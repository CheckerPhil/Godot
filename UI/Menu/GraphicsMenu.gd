extends Control

onready var vsyncButton = $VsyncCheckbox
onready var fullscreenButton = $FullscreenCheckbox

func _ready():
	$ExitButton.grab_focus()
	
	$MSSADropdown.add_item("MSSA 16x")
	$MSSADropdown.add_item("MSSA 2x")
	$MSSADropdown.add_item("MSSA 4x")
	$MSSADropdown.add_item("MSSA 8x")
	$MSSADropdown.add_item("MSSA Disabled")
	
	if get_viewport().msaa == Viewport.MSAA_16X:
		$MSSADropdown.select(0)
	if get_viewport().msaa == Viewport.MSAA_2X:
		$MSSADropdown.select(1)
	if get_viewport().msaa == Viewport.MSAA_4X:
		$MSSADropdown.select(2)
	if get_viewport().msaa == Viewport.MSAA_8X:
		$MSSADropdown.select(3)
	if get_viewport().msaa == Viewport.MSAA_DISABLED:
		$MSSADropdown.select(4)
		
func _on_ExitButton_pressed():
	get_tree().change_scene("res://UI/Menu/OptionsMenu.tscn")

func _on_FullscreenCheckbox_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	fullscreenButton.set_pressed(!vsyncButton.is_pressed())

func _on_VsyncCheckbox_pressed():
	OS.vsync_enabled = !OS.vsync_enabled
	vsyncButton.pressed = !vsyncButton.pressed

func _on_MSSADropdown_item_selected(index):
	match index:
		0:
			get_viewport().msaa = Viewport.MSAA_16X
		1:
			get_viewport().msaa = Viewport.MSAA_2X
		2:
			get_viewport().msaa = Viewport.MSAA_4X
		3:
			get_viewport().msaa = Viewport.MSAA_8X
		4:
			get_viewport().msaa = Viewport.MSAA_DISABLED
	

func _on_FXAACheckbox_pressed():
	get_viewport().fxaa = !get_viewport().fxaa
	$FXAACheckbox.pressed = !$FXAACheckbox.pressed
