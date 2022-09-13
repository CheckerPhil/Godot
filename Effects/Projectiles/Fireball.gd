extends Area2D

export var damage = 1
var knockback_vector = Vector2.ZERO
export(int) var speed = 200

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta


func _on_Timer_timeout():
	$CollisionShape2D.disabled = false

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
