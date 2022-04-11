extends Node2D

const SlotClass = preload("res://UI/Inventory/Slot.gd")
onready var inventory_slots = $TextureRect/GridContainer
var holding_item = null

func _ready():
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", self, "slot_gui_input", [inv_slot])
	initialize_inventory()

func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.item:
					slot.putIntoSlot(holding_item)
					holding_item = null
				else:
					if holding_item.ItemType != slot.item.ItemType:
						var temp_item = slot.item
						slot.pickFromSlot()
						temp_item.global_position = event.global_position
						slot.putIntoSlot(holding_item)
						holding_item = temp_item
					#Stacking
					else:
						var able_to_add = slot.item.max_StackSize - slot.item.StackSize
						if able_to_add >= holding_item.StackSize:
							slot.item.AddItems(holding_item.StackSize)
							holding_item.queue_free()
							holding_item = null
						else:
							slot.item.AddItems(able_to_add)
							holding_item.RemoveItems(able_to_add)
			elif slot.item:
				holding_item = slot.item
				slot.pickFromSlot()
				holding_item.global_position = get_global_mouse_position()

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
