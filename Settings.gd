extends Node

var cpuParticles = false
var ai = true
var multiplayer_start = false

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

