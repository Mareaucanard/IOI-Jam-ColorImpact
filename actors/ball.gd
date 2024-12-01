extends RigidBody2D
class_name Ball

var goal: Goal
var trail: Trail
var bounce = 1.2

func _ready() -> void:
	activate_trail()

func _process(_delta: float) -> void:
	var factor = goal.get_factor_from_speed(linear_velocity)
	var color = goal.get_color_from_factor(factor)
	$Sprite2D.self_modulate = color
	trail.feed_color(color)

func activate_trail():
	trail = Trail.create()
	trail.visible = true
	add_child(trail)

func _on_bounce(body: Node) -> void:
	if body is Wall:
		var factor = goal.get_factor_from_speed(linear_velocity)
		var color = goal.get_color_from_factor(factor)
		body.update_from_impact(factor, color, linear_velocity)
		if body.already_hit == false:
			linear_velocity *= bounce
			body.already_hit = true
	elif body is Goal:
		var factor = goal.get_factor_from_speed(linear_velocity)
		goal.apply_impact(factor, linear_velocity)
		if factor >= body.required_factor:
			goal.win.emit(factor)
		else:
			goal.loss.emit(factor, linear_velocity)
		queue_free()
