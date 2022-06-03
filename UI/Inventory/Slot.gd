extends Panel

var ItemClass = preload("res://Items/Item.tscn")
#ar item = null

#func _ready():
	#item = ItemClass.instance()
	#item.set_texture("Stone")
	#add_child(item)

func AddItem(var item_name, var item_amount):
	var item = ItemClass.instance()
	item.set_texture(item_name)
	item.set_amount(item_amount)
	add_child(item)


#func _physics_process(delta):
	#for i in Inventory.inventory:
		#for a in get_children():
			#if(i.name == a.itemname):
				#print(i.name)
				#print(i.amount)
				#a.set_amount(i.amount)
