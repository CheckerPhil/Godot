extends Control

onready var vsyncButton = $VsyncCheckbox
onready var fullscreenButton = $FullscreenCheckbox

func _ready():
	$ExitButton.grab_focus()

func _on_ExitButton_pressed():
	get_tree().change_scene("res://UI/OptionsMenu.tscn")

func _on_FullscreenCheckbox_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	fullscreenButton.set_pressed(!vsyncButton.is_pressed())

func _on_VsyncCheckbox_pressed():
	OS.vsync_enabled = !OS.vsync_enabled
	vsyncButton.pressed = !vsyncButton.pressed


