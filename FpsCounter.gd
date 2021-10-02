extends RichTextLabel

func _process(delta):
	text = "FPS: " + String(Engine.get_frames_per_second())
