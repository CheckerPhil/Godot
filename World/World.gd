extends Node2D

onready var path = $DirtPathTileMap
onready var singleplayer = $Player
onready var stone_item = preload("res://Items/StoneItem.tscn")

const CHUNK_WIDTH = 64
const CHUNK_HEIGHT = 64
const TILES = {
	'grass': 1,
	'rock': 0,
	'sand': 1,
}

var player = preload("res://Player/Player.tscn")
var open_simplex_noise

export(String) var world_seed = "Hello Godot!"

func _ready():
	if Settings.multiplayer_start == true:
		singleplayer.queue_free()
		Autoload.net_id = get_tree().get_network_unique_id()
		for i in Autoload.player_ids:
			create_player(i)
		create_player(get_tree().get_network_unique_id())
	
	#World Generation
	randomize()
	open_simplex_noise = OpenSimplexNoise.new()
	open_simplex_noise.seed = world_seed.hash()
	
	open_simplex_noise.octaves = 4
	open_simplex_noise.period = 15
	open_simplex_noise.lacunarity = 1.5
	open_simplex_noise.persistence = 0.75
	
	_generate_world()

# warning-ignore:unused_argument
func _physics_process(delta):
	#Set Path
	#if Input.is_mouse_button_pressed(2):
		#var clicked_map_pos = path.world_to_map(get_global_mouse_position() / scale)
		#path.set_cell(clicked_map_pos.x,clicked_map_pos.y, path.tile_set.get_tiles_ids()[0], false, false, false, path.get_cell_autotile_coord(clicked_map_pos.x, clicked_map_pos.y))
		#path.update_bitmask_area(Vector2(clicked_map_pos.x, clicked_map_pos.y))
	
	if Input.is_mouse_button_pressed(1):
		var clicked_map_pos = $TileMap.world_to_map(get_global_mouse_position() / scale)
		$TileMap.set_cell(clicked_map_pos.x,clicked_map_pos.y, TILES.grass, false, false, false, $TileMap.get_cell_autotile_coord(clicked_map_pos.x, clicked_map_pos.y))
		$TileMap.update_bitmask_area(Vector2(clicked_map_pos.x, clicked_map_pos.y))
		var scene = load("res://Items/StoneItem.tscn")
		var item = scene.instance()
		add_child(item)


func create_player(id):
	var a = player.instance()
	a.name = str(id)
	a.position = Vector2(randi()%400, randi()%200)
	a.initialize(id)
	add_child(a)

#World Generation
func _generate_world():
	for x in CHUNK_WIDTH:
		for y in CHUNK_HEIGHT:
			$TileMap.set_cellv(Vector2(x - CHUNK_WIDTH / 2, y - CHUNK_HEIGHT / 2), _get_tile_index(open_simplex_noise.get_noise_2d(float(x), float(y))))
	$TileMap.update_bitmask_region()

func _get_tile_index(noise_sample):
	if noise_sample < -0.1:
		return TILES.sand
	if noise_sample < 0.4:
		return TILES.rock
	return TILES.grass
