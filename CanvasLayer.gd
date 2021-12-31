extends CanvasLayer

func _ready():
	set_visible(false)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if !get_tree().get_current_scene().get_name().ends_with("Menu"):
			set_visible(!get_tree().paused)
			get_tree().paused = !get_tree().paused
	elif event.is_action_pressed("command"):
		get_tree().change_scene("res://UI/CommandLine.tscn")


func _on_ContinueButton_pressed():
	get_tree().paused = false
	set_visible(false)

func _on_OptionsButton_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/OptionsMenu.tscn")
	set_visible(false)

func _on_MenuButton_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/StartMenu.tscn")
	set_visible(false)

func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible

