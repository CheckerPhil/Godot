extends Node

const enemyscene = preload("res://Enemies/Zombie.tscn")
var enemypool = []
var index = 0

func _ready():
	var rand = RandomNumberGenerator.new()

	var scree_size = get_viewport().get_visible_rect().size
	
	for i in range(0,Settings.difficulty * 10):
		var enemy = enemyscene.instance();
		rand.randomize()
		var x = rand.randf_range(0, scree_size.x)
		rand.randomize()
		var y = rand.randf_range(0, scree_size.y)
		enemy.position.x = x
		enemy.position.y = y
		enemypool.append(enemy)

func spawn():
	for i in range(0,Settings.difficulty * 10):
		var enemy = enemypool[index]
		index = wrapi(index + 1, 0, (Settings.difficulty * 10) -1)
		add_child(enemy)
