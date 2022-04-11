extends Control

func _ready():
	$VBoxContainer/ControlsButton.grab_focus()

func _on_ControlsButton_pressed():
	get_tree().change_scene("res://UI/Menu/ControlsMenu.tscn")

func _on_GraphicsButton_pressed():
	get_tree().change_scene("res://UI/Menu/GraphicsMenu.tscn")

func _on_ExitButton_pressed():
	get_tree().change_scene("res://UI/Menu/StartMenu.tscn")
