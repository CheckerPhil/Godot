extends Panel

var ItemClass = preload("res://UI/Inventory/Item.tscn")
var item = null

func _ready():
	#if randi() % 2 == 0:
		#item = ItemClass.instance()
		#add_child(item)
		pass

func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null

func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)

func initialize_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instance()
		add_child(item)
		item.setItem(item_name, item_quantity)
	else:
		item.setItem(item_name, item_quantity)
