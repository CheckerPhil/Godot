extends Node

func spawn():
	var rand = RandomNumberGenerator.new()
	var enemyscene = load("res://Enemies/Zombie.tscn")
	
	var scree_size = get_viewport().get_visible_rect().size
	
	for i in range(0,Settings.difficulty * 10):
		var enemy = enemyscene.instance();
		rand.randomize()
		var x = rand.randf_range(0, scree_size.x)
		rand.randomize()
		var y = rand.randf_range(0, scree_size.y)
		enemy.position.x = x
		enemy.position.y = y
		add_child(enemy)
