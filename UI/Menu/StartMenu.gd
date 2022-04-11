extends Control


func _ready():
	$VBoxContainer/SingleplayerButton.grab_focus()

func _on_StartButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://World.tscn")


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://UI/Menu/OptionsMenu.tscn")


func _on_QuitButton_pressed():
	print("Quiting using Main Menu (ExitCode: 0)")
	get_tree().quit()


func _on_TextureButton_pressed():
	OS.shell_open("https://discord.gg/fjX2d4dPVE")


func _on_MultiplayerButton_pressed():
	get_tree().change_scene("res://UI/Menu/MultiplayerMenu.tscn")
