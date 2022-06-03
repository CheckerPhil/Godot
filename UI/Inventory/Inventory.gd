extends Control

var inventory = []
var itemnames = []

var ItemClass = preload("res://Items/Item.tscn")

func add_item(var item_name, var amount):
	if(inventory.size() > 0):
		for i in inventory:

			if(itemnames.has(item_name)):
				#An Zukunfts-Ich: Nicht in obere if-Abrage mit && einbauen
				#Kein Plan warum aber breakt Code
				if(i.name == item_name):
					i.amount += amount
			else:
				var item = Item.new()
				item.name = item_name
				item.amount = amount
				inventory.insert(inventory.size(),item)
				#itemnames.insert(itemnames.size(), i.name)
	else:
		var item = Item.new()
		item.name = item_name
		item.amount = amount
		inventory.insert(inventory.size(),item)
		#itemnames.insert(itemnames.size(), item_name)
	show_inventory()

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
