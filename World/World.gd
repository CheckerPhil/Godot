extends Node2D

onready var path = $DirtPathTileMap

# warning-ignore:unused_argument
#func _physics_process(delta):
	#Set Path
	#if Input.is_mouse_button_pressed(2):
		#var clicked_map_pos = path.world_to_map(get_global_mouse_position() / scale)
		#path.set_cell(clicked_map_pos.x,clicked_map_pos.y, path.tile_set.get_tiles_ids()[0], false, false, false, path.get_cell_autotile_coord(clicked_map_pos.x, clicked_map_pos.y))
		#path.update_bitmask_area(Vector2(clicked_map_pos.x, clicked_map_pos.y))
