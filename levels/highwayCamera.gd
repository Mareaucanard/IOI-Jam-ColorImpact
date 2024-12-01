extends Camera2D

var tracked_ball
var track_cannon = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = $"../Cannon/Endpoint".position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if track_cannon:
		position.x = $"../Cannon/Endpoint".global_position.x
	elif tracked_ball != null  :
		position.x = tracked_ball.position.x
		


func _on_cannon_fired(ball: Variant) -> void:
	tracked_ball = ball
	track_cannon = false


func _on_cannon_got_reset() -> void:
	track_cannon = true
