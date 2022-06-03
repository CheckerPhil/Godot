extends CanvasLayer

var last_added_node = 0

func _input(event):
	if event.is_action_pressed("inventory"):
		$Inventory.visible = !$Inventory.visible
		#$Inventory.show_inventory()
		for i in Inventory.inventory:
			for a in get_node("Inventory/GridContainer").get_children():
				if(last_added_node < Inventory.inventory.size()):
					a.AddItem(Inventory.inventory[last_added_node].name, Inventory.inventory[last_added_node].amount)
					last_added_node = last_added_node + 1
