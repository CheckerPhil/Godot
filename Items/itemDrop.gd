extends KinematicBody2D

const ACCELERATION = 460
const MAX_SPEED = 225
var velocity = Vector2.ZERO
export(String) var item_name

var player = null
var being_picked_up = false

func _physics_process(delta):
	if Engine.get_frames_per_second() <= 7:
		queue_free()
	
	if being_picked_up == true:
		if player != null:
			var direction = global_position.direction_to(player.global_position)
			velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			var distance = global_position.distance_to(player.global_position)
			if distance < 4:
				Inventory.add_item(item_name, 1)
				queue_free()
	velocity = move_and_slide(velocity, Vector2.UP)

func pick_up_item(body):
	player = body
	being_picked_up = true


func _on_VisibilityNotifier2D_screen_exited():
	if Engine.get_frames_per_second() <= 20:
		queue_free()
