extends Control

var inventory = []
var itemnames = []

var ItemClass = preload("res://Items/Item.tscn")

var holding_item = null

#func _ready():
	#for inv_slot in $GridContainer.get_children():
		#inv_slot.connect("gui_input", self, "slot_gui_input")

func add_item(var item_name, var amount):
	if(inventory.size() > 0):
		var loops =0
		for i in inventory:
			if(i.name == item_name):
				#An Zukunfts-Ich: Nicht in obere if-Abrage mit && einbauen
				#Kein Plan warum aber breakt Code
				#if(i.name == item_name):
				i.amount += amount
				break
			else:
				loops = loops + 1
		if(loops >= inventory.size()):
				item_add(item_name, amount)
				#break
			
	else:
		item_add(item_name, amount)
		#itemnames.insert(itemnames.size(), item_name)
	#show_inventory()

func remove_item(var item_name, var amount):
	for i in inventory:
			itemnames.insert(itemnames.size(), i.name)
			if(itemnames.has(item_name)):
				#An Zukunfts-Ich: Nicht in obere if-Abrage mit && einbauen
				#Kein Plan warum aber breakt Code
				if(i.name == item_name):
					i.amount -= amount
					if(i.amount <= 0):
						inventory.erase(i)

func show_inventory():
	for i in inventory:
		print(i.name + " | " + str(i.amount))
	print("----")

func item_add(var item_name, var amount):
	var item = Item.new()
	item.name = item_name
	item.amount = amount
	inventory.insert(inventory.size(),item)

func slot_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_item == null:
				pass
