extends AnimatedSprite

class_name Player


var _map_position 
var _tilemap
var _direction
var _destination # uiteindelijke bestemming
var _target # eerstvolgende waypoint

func initialize(tilemap):
	_tilemap = tilemap
	_target = _tilemap.world_to_map(get_position())

func _setDestination(destination):
	_destination = destination

func _update_direction():
	if _target == null:
		return Vector2(0, 0)
		
	if _target.x > _map_position.x:
		_direction = Vector2(1, 0)
	if _target.x < _map_position.x:
		_direction = Vector2(-1, 0)
	if _target.y > _map_position.y:
		_direction = Vector2(0, 1)
	if _target.y < _map_position.y:
		_direction = Vector2(0, -1)
		
	#

func _move():
	if _target == null or _target == _map_position:
		print(_map_position, _destination)
		var path = _tilemap.pathfinder.get_path(_map_position, _destination)
		if path != null:
			_target = path[1]
	_update_direction()
	translate(_direction)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_map_position = _tilemap.world_to_map(get_position() / 4)
	if _destination != null and _map_position != _destination:
		_move()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			var mouse_position = to_local(get_global_mouse_position())
			_target = null
			_destination = _tilemap.world_to_map(mouse_position)
