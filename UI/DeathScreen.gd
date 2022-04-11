extends Control

func _on_RespawnButton_pressed():
	get_tree().change_scene("res://World.tscn")


func _on_MenuButton_pressed():
	get_tree().change_scene("res://UI/Menu/StartMenu.tscn")
