extends Node2D
class_name Canon

@export var goal: Goal
@export var power: int = 1000
@export var min_angle: int = 0
@export var max_angle: int = 90
@export var ball_bounce: float =  1.2
var turn_speed: float = 45
var ball_scene = preload("res://actors/ball.tscn")
var ball

var working = true

signal fired(ball)
signal got_reset()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func reset():
	working = true
	got_reset.emit()
	if ball != null:
		ball.queue_free()

func stop():
	working = false

func turn_right(delta: float):
	global_rotation_degrees = max(min_angle, global_rotation_degrees - turn_speed * delta)
	
func turn_left(delta: float):
	global_rotation_degrees = min(max_angle, global_rotation_degrees + turn_speed * delta)

func fire():
	var pos = $Endpoint.global_position
	var velocity = ($Endpoint.global_position - global_position).normalized() * power
	ball = ball_scene.instantiate()
	ball.goal = goal
	ball.position = pos
	ball.linear_velocity = velocity
	ball.bounce = ball_bounce
	get_parent().add_child(ball)
	fired.emit(ball)
	stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if working:
		if Input.is_action_pressed("turn_cannon_right") and not Input.is_action_pressed("turn_cannon_left"):
			turn_right(delta)
		elif not Input.is_action_pressed("turn_cannon_right") and Input.is_action_pressed("turn_cannon_left"):
			turn_left(delta)
		if Input.is_action_just_pressed("fire"):
			fire()
