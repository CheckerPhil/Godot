extends Area2D

export var damage = 1
var knockback_vector = Vector2.ZERO
export(int) var speed = 100

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta

func destroy():
	queue_free()

func _on_Player_Dagger_area_entered(area):
	destroy()


func _on_Player_Dagger_body_entered(body):
	destroy()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
