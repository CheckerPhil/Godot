extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var ROLL_SPEED= 200
export var FRICTION = 500
export var sprintboost = 1

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats
var is_master = false

onready var walkPlayer = $Animations/WalkPlayer
onready var rollPlayer = $Animations/DashPlayer
#onready var animationTree = $AnimationTree
#onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

export(PackedScene) var DAGGER: PackedScene = preload("res://Effects/Projectiles/Player Dagger.tscn")
onready var shoot_attack_timer = $ShootAttackTimer

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")
	#animationTree.active = true
	swordHitbox.knockback_vector = roll_vector

func _physics_process(delta):
	if is_master && Settings.multiplayer_start == true:
		match state:
			MOVE:
				move_state(delta)
			
			ROLL:
				roll_state(delta)
			
			ATTACK:
				attack_state(delta)
		
		if Input.is_action_just_pressed("shoot") and shoot_attack_timer.is_stopped():
			var dagger_direction = self.global_position.direction_to(get_global_mouse_position())
			throw_dagger(dagger_direction)
	else:
		match state:
			MOVE:
				move_state(delta)
			
			ROLL:
				roll_state(delta)
			
			ATTACK:
				attack_state(delta)
		
		if Input.is_action_just_pressed("shoot") and shoot_attack_timer.is_stopped():
			var dagger_direction = self.global_position.direction_to(get_global_mouse_position())
			throw_dagger(dagger_direction)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	#Sprinting
	if Input.is_action_just_pressed("sprint"):
		sprintboost = 1.7
	if Input.is_action_just_released("sprint"):
		sprintboost = 1

	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		#animationTree.set("parameters/Idle/blend_position", input_vector)
		#animationTree.set("parameters/Run/blend_position", input_vector)
		#animationTree.set("parameters/Attack/blend_position", input_vector)
		#animationTree.set("parameters/Roll/blend_position", input_vector)
		#animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED * sprintboost, ACCELERATION * delta)
	else:
		walkPlayer.play("Idle")
		#animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	
	if Input.is_action_just_pressed("roll"):
		state = ROLL
	
	#if Input.is_action_just_pressed("attack"):
		#state = ATTACK

func roll_state(_delta):
	velocity = roll_vector * ROLL_SPEED
	rollPlayer.play("Dash")
	#animationState.travel("Roll")
	hurtbox.start_invincibility(0.5)
	move()

func attack_state(_delta):
	velocity = Vector2.ZERO
	#animationState.travel("Attack")

func move():
	velocity = move_and_slide(velocity)
	walkPlayer.play("Walk")
	if Settings.multiplayer_start == true:
		rpc_unreliable("set_pos", position)

func _on_DashPlayer_animation_finished(anim_name):
	velocity = velocity * 0.8
	state = MOVE

func attack_animation_finished():
	state = MOVE

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()


func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")

func throw_dagger(dagger_direction: Vector2):
	if DAGGER:
		var dagger = DAGGER.instance()
		get_tree().current_scene.add_child(dagger)
		dagger.global_position = self.global_position
		
		var dagger_rotation = dagger_direction.angle()
		dagger.rotation = dagger_rotation
		
		shoot_attack_timer.start()

#Local Multiplayer
func initialize(id):
	is_master = id == Autoload.net_id

remote func set_pos(pos):
	position = pos

#Save
func get_save_stats():
	return {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'x_Pos' : global_transform.origin.x,
		'y_Pos' : global_transform.origin.y,
	}
