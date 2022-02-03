extends Node2D

onready var player = preload("res://Player/Player.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50

enum {
	IDLE,
	FOLLOW,
}

var state = IDLE
var velocity = Vector2.ZERO

func _physics_process(delta):
	if state == IDLE:
		velocity = Vector2.ZERO
	elif state == FOLLOW:
		print("Test")
		transform.origin.move_toward(player.global_position, MAX_SPEED * delta)
	pass


func _on_Area2D_area_entered(area):
	state = FOLLOW

func _on_Area2D_area_exited(area):
	state = IDLE
