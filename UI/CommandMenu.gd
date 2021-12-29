extends Control

onready var input_box = get_node("Input")
onready var output_box = get_node("Output")
export(String) onready var prefix = "/"

func _ready():
	input_box.grab_focus()

func output_text(text):
	output_box.text = str(output_box.text + "\n" + text)
	print("CONSOLE: " + "[OUTPUT] " + text)

func _on_Input_text_entered(new_text):
	print("CONSOLE: " + "[Input] " + new_text)
	if new_text == prefix + "cave":
		get_tree().change_scene("res://Cave/Scene.tscn")
	elif new_text == prefix + "fps":
		var text = "FPS: " + String(Engine.get_frames_per_second())
		output_text(text)
	elif new_text == prefix + "quit":
		get_tree().quit(99)
	elif new_text == "Soos ist ein geiler Minecraft Server":
		OS.shell_open("https://soos-network.github.io/Soos-Website/")
	input_box.clear()
