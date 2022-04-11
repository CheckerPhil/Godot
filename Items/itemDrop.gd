extends KinematicBody2D

const ACCELERATION = 460
const MAX_SPEED = 225
var velocity = Vector2.ZERO
var item_name

var player = null
var being_picked_up = false

func _ready():
	var path_split = $Sprite.texture.resource_path.split("/")[3].split(".")
	item_name = path_split[0]

func _physics_process(delta):
	if being_picked_up == true:
		if player != null:
			var direction = global_position.direction_to(player.global_position)
			velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			var distance = global_position.distance_to(player.global_position)
			if distance < 4:
				PlayerInventory.add_item(item_name, 1)
				queue_free()
	velocity = move_and_slide(velocity, Vector2.UP)

func pick_up_item(body):
	player = body
	being_picked_up = true