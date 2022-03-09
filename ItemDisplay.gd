extends Node2D

export(String) var ItemCatogory = null;
export(String) var ItemType = null;
export(String) var ItemName = null;
export(int) var max_StackSize = 64
export(String) var Description = "No Description"

var StackSize = 63

func _ready():
	if randi() % 2 == 0:
		ItemType = "Sword"
	else:
		ItemType = "HeartUIFull"

	$TextureRect.texture =  load("res://Items/" + ItemType + ".png")
	
	if StackSize == 1:
		$StackCounter.visible = false;
	else:
		$StackCounter.visible = true;
		$StackCounter.text = String(StackSize)

func AddItems(var to_add_stacksize):
	StackSize += to_add_stacksize
	$StackCounter.visible = true;
	$StackCounter.text = String(StackSize)
func RemoveItems(var to_add_stacksize):
	StackSize -= to_add_stacksize
	$StackCounter.visible = true;
	$StackCounter.text = String(StackSize)
