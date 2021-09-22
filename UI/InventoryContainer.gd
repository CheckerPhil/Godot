extends ColorRect

var inventory = preload("res://Inventory.tres")

func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")

func drop_data(_position, data):
	inventory.set_item(data.item_index, data.item)

func _physics_process(_delta):
	if Input.is_action_just_released("inventory"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://World.tscn")
