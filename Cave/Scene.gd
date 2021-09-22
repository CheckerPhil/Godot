extends Node2D

onready var stone = $TileMap

# warning-ignore:unused_argument
func _physics_process(delta):
	#Set Path
	if Input.is_mouse_button_pressed(1):
		var clicked_map_pos = stone.world_to_map(get_global_mouse_position() / scale)
		stone.set_cell(clicked_map_pos.x,clicked_map_pos.y, 0, false, false, false, stone.get_cell_autotile_coord(clicked_map_pos.x, clicked_map_pos.y))
		stone.update_bitmask_area(Vector2(clicked_map_pos.x, clicked_map_pos.y))
