extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE= 4

enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var shake_amount = 1.0

var state = CHASE

onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var wandercontroller = $WanderController
onready var animationPlayer = $AnimationPlayer
onready var walkPlayer = $Animations/WalkPlayer

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	if Settings.ai == true:
		match state:
			IDLE:
				velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
				seek_player()
				walkPlayer.play("Idle")
				
				if wandercontroller.get_time_left() == 0:
					update_wander()
			WANDER:
				seek_player()
				walkPlayer.play("Walk")
				if wandercontroller.get_time_left() == 0:
					update_wander()
				
				accelerate_towards_point(wandercontroller.target_position, delta)
				
				if global_position.distance_to(wandercontroller.target_position) <= WANDER_TARGET_RANGE:
					update_wander()
			CHASE:
				var player = playerDetectionZone.player
				walkPlayer.play("Walk")
				if player != null:
					accelerate_towards_point(player.global_position, delta)
				else:
					state = IDLE

	if softCollision.is_colliding():
		velocity = softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	#sprite.flip_h = velocity.x < 0

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wandercontroller.start_wander_timer(rand_range(1, 3))

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 200
	var camera = get_node("/root/World/YSort/Player/Camera2D")
	camera.set_offset(Vector2( \
		rand_range(-1.0, 1.0) * shake_amount, \
		rand_range(-1.0, 1.0) * shake_amount \
	))
	hurtbox.create_hit_effect()
	$Animations/HitPlayer.play("Hit")
	hurtbox.start_invincibility(0.4)

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	Settings.difficulty =+ 1


func _on_Hurtbox_invincibility_started():
	animationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended():
	animationPlayer.play("Stop")
