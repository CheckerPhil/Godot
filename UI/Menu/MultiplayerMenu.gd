extends Control

export var max_player = 10

func _ready():
	get_tree().connect("network_peer_connected", self, "Success")

func _on_HostButton_pressed():
	var net = NetworkedMultiplayerENet.new()
	net.create_server(9696,max_player)
	get_tree().network_peer = net
	print("Server created")

func _on_JoinButton_pressed():
	var net = NetworkedMultiplayerENet.new()
	net.create_client("127.0.0.1", 9696)
	get_tree().network_peer = net
	print("Client created")

func Success(id):
	Autoload.player_ids.append(id)
	if Autoload.player_ids.size() > 1:
		var a = preload("res://World.tscn").instance()
		get_tree().root.add_child(a)
		Settings.multiplayer_start = true
		queue_free()
