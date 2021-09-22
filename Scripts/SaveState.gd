extends Node

var save_filename = "user://save_game.save"

func save_game():
	var save_file = File.new()
	save_file.open(save_filename, File.WRITE)
	
	var saved_nodes = get_tree().get_nodes_in_group("Saved")
	
	for node in saved_nodes:
		if node.filename.empty():
			break
			
		var node_details = node.get_saved_stats()
		save_file.store_line(to_json(node_details))
		
	save_file.close()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST or MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		save_game()
