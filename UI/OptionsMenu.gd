extends Control

func _ready():
	$VBoxContainer/ControlsButton.grab_focus()

func _on_ControlsButton_pressed():
	get_tree().change_scene("res://UI/ControlsMenu.tscn")

func _on_GraphicsButton_pressed():
	get_tree().change_scene("res://UI/GraphicsMenu.tscn")

func _on_ExitButton_pressed():
	get_tree().change_scene("res://UI/StartMenu.tscn")
