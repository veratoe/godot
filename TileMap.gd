extends TileMap

export var map_size = Vector2(16, 16)
var tile_size = Vector2(16, 16)

var _tileset
var pathfinder

# Called when the node enters the scene tree for the first time.
func _ready():
	_tileset = get_tileset()
	populate_world()
	pathfinder = Pathfinder.new(self, get_parent())

func populate_world():
	for i in range(map_size.x):
		for j in range(map_size.y):
			if (randi() % 4 ==  3):
				set_cellv(Vector2(i, j), _tileset.find_tile_by_name("water_well"))



	
