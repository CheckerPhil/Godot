extends Node2D

onready var path = $DirtPathTileMap
onready var singleplayer = $Player

var player = preload("res://Player/Player.tscn")

func _ready():
	if Settings.multiplayer_start == true:
		singleplayer.queue_free()
		Autoload.net_id = get_tree().get_network_unique_id()
		for i in Autoload.player_ids:
			create_player(i)
		create_player(get_tree().get_network_unique_id())
	

# warning-ignore:unused_argument
#func _physics_process(delta):
	#Set Path
	#if Input.is_mouse_button_pressed(2):
		#var clicked_map_pos = path.world_to_map(get_global_mouse_position() / scale)
		#path.set_cell(clicked_map_pos.x,clicked_map_pos.y, path.tile_set.get_tiles_ids()[0], false, false, false, path.get_cell_autotile_coord(clicked_map_pos.x, clicked_map_pos.y))
		#path.update_bitmask_area(Vector2(clicked_map_pos.x, clicked_map_pos.y))

func create_player(id):
	var a = player.instance()
	a.name = str(id)
	a.position = Vector2(randi()%400, randi()%200)
	a.initialize(id)
	add_child(a)
