extends Node2D

var itemname
var itemamount

func set_texture(var item_name):
	itemname = item_name
	$TextureRect.texture = load("res://Items/" + item_name +".png")

func set_amount(var item_amount):
	item_amount = item_amount
	#print(item_amount)
	$RichTextLabel.text = str(item_amount)

func _physics_process(delta):
	for i in Inventory.inventory:
		if(i.name == itemname):
			#print(i.name)
			set_amount(i.amount)
