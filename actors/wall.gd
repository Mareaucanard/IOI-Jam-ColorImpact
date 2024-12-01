extends RigidBody2D
class_name Wall

var already_hit: bool = false
var step_count: float = 100
var target_color: Color = Color(1, 1, 1)
var old_color: Color = Color(1,1,1)
var impact_direction: Vector2 = Vector2()
var impact_force: float
var centered_text_position: Vector2
@export var impact_magnitude = 50

@export var min_speed_color: Color = Color(1,1,1)
@export var max_speed_color: Color = Color(1,1,1)
@export var color_override: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.self_modulate = old_color
	centered_text_position = $Label.position
	

func reset() -> void:
	target_color = Color(1, 1, 1)
	old_color = Color(1,1,1)
	$Label.text = ""
	$Sprite2D.self_modulate = target_color
	already_hit = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if step_count < 0.5:
		step_count += delta
		var progress = lerp(0.0, 1/0.5, step_count)
		$Sprite2D.self_modulate = lerp(old_color, target_color, progress)
		var p = 2 * PI * 2 * 5 * min(0.5, step_count)
		var transform_factor = sin(p)/p
		$Sprite2D.position = impact_direction * impact_magnitude * transform_factor * impact_force
		$Label.position = $Sprite2D.position + centered_text_position

func update_from_impact(factor: float, color: Color, velocity: Vector2) -> void:
	old_color = $Sprite2D.self_modulate
	if color_override:
		target_color = lerp(min_speed_color, max_speed_color, factor)
	else:
		target_color = color
	step_count = 0
	impact_force = factor
	impact_direction = velocity.normalized()
	$Label.text = "%2.f%%" % (factor * 100)
