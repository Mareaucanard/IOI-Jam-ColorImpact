extends RigidBody2D
class_name Goal

@export var required_factor: float = 0.5
@export var max_expected_speed: float = 1000
@export var min_speed_color: Color = Color(0,0,1)
@export var max_speed_color: Color = Color(1,0,0)
@export var impact_magnitude = 100

var step_count: float = 100
var target_color: Color = Color(1, 1, 1)
var old_color: Color = Color(1,1,1)
var impact_direction: Vector2 = Vector2()
var impact_force: float
var centered_text_position: Vector2
var ball

signal enter_slowmo
signal exit_slowmo
signal win(factor: float)
signal loss(factor: float, linear_velocity: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	centered_text_position = $Label.position
	reset()

func reset():
	$Sprites.modulate = get_color_from_factor(required_factor)
	$Label.text = "%2.f%%" % (required_factor * 100)

func get_factor_from_speed(velocity) -> float:
	var speed = velocity.distance_to(Vector2())
	return min(1, speed / max_expected_speed)

func get_color_from_factor(factor: float) -> Color:
	return lerp(min_speed_color, max_speed_color, factor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if step_count < 2:
		step_count += delta
		var progress = lerp(0.0, 1/2.0, step_count)
		$Sprites.modulate = lerp(old_color, target_color, progress)
		var p = 2 * PI * 2 * 5 * min(0.5, step_count)
		var transform_factor = sin(p)/p
		$Sprites.position = impact_direction * impact_magnitude * transform_factor * impact_force
		$Label.position = $Sprites.position + centered_text_position

func apply_impact(factor: float, velocity: Vector2):
	old_color = $Sprites.modulate
	target_color = lerp(min_speed_color, max_speed_color, factor)
	step_count = 0
	impact_force = factor
	impact_direction = velocity.normalized()
	$Label.text = "%2.f%%" % (factor * 100)
