extends AStar2D

class_name Pathfinder

var debug_layer

var _tilemap
var _root_node
var walkable_points = []

func _draw_debug_node(position, color, filled):
	var circle = Square.new(
		Rect2(
			Vector2( position.x * 4.0 * _tilemap.tile_size.x, position.y * 4.0 * _tilemap.tile_size.y), 
			Vector2(4.0 * _tilemap.tile_size.x, 4.0 * _tilemap.tile_size.y)
		),
		color, filled)
	_root_node.call_deferred("add_child", circle)
	circle.add_to_group("debug_nodes")
	
func _clear_debug_nodes():
	var debug_nodes = _root_node.get_tree().get_nodes_in_group("debug_nodes")
	for node in debug_nodes:
		node.queue_free()

func _init(tilemap, root_node):
	_tilemap = tilemap
	_root_node = root_node
	setup()

func get_point_id(point):
	return point.x + point.y * _tilemap.map_size.y

func setup():
	
	# alle begaanbare punten vinden
	for x in range(_tilemap.map_size.x):
		for y in range(_tilemap.map_size.y):
			var cell = _tilemap.get_cell(x, y)
			if cell != -1:
				_draw_debug_node(Vector2(x, y), Color(1.0, 0.0, 0.0, 0.2), true)
			else:
				self.add_point(get_point_id(Vector2(x, y)), Vector2(x, y))
				
	# punten verbinden
	for point_id in self.get_points():
		var point = self.get_point_position(point_id)
		_draw_debug_node(point, Color(0.0, 0.0, 1.0, 0.2), false)
		
		var neighbors = Array([
			Vector2(point.x + 1, point.y),
			Vector2(point.x - 1, point.y),	
			Vector2(point.x, point.y + 1),		
			Vector2(point.x, point.y - 1)	
		])
		
		for neighbor in neighbors:
			var neighbor_id = get_point_id(neighbor)
			if self.has_point(neighbor_id):
				var a = 10
				self.connect_points(point_id, neighbor_id)

func get_path(start, end):
	
	_clear_debug_nodes()
		
	var start_point_id = get_point_id(start)
	var end_point_id = get_point_id(end)
	
	if !self.has_point(start_point_id) or !self.has_point(end_point_id):
		return
		
	var path = get_point_path(start_point_id, end_point_id)
	
	for point in path:
		_draw_debug_node(point, Color(0.0, 1.0, 0.0, 0.2), true)
	
	return path
