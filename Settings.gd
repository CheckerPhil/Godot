extends Node

var cpuParticles = false
var ai = true
var multiplayer_start = false
var AttackDash = false

var difficulty = 1

func _ready():
	#START PROGRESS
	#Set Title
	if OS.is_debug_build():
		OS.set_window_title("Village Magic (DEBUG MODE)")
		print("Started in Debug Mode...")
	else:
		OS.set_window_title("Village Magic")
		print("Started in Standalone Mode...")
	
	#Debug
	print("Modelname: " + OS.get_model_name())
	print("GPU: " + VisualServer.get_video_adapter_name())
	print("----------------------")

func _notification(what):
	if what == MainLoop.NOTIFICATION_CRASH:
		get_tree().change_scene("res://UI/Menu/StartMenu.tscn")
		print("Game Chrashed. Please send this log file to a developer.")
	elif what == MainLoop.NOTIFICATION_OS_MEMORY_WARNING:
		print("Memory high! OS Memory warning send.")
