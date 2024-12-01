extends Line2D
class_name Trail

const MAX_POINTS: int = 100
const GRADIENT_PRECISION: int = 50
var delta_sum: float = 0
@onready var curve := Curve2D.new()

func _ready() -> void:
	gradient.offsets = []
	gradient.colors = []
	for i in range(GRADIENT_PRECISION):
		gradient.add_point(float(i) / GRADIENT_PRECISION, Color(1,1,1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta_sum += delta
	while delta_sum >= 1.0/60:
		add_point_to_curve()
		delta_sum -= 1.0/60

func add_point_to_curve() -> void:
	curve.add_point(get_parent().position)
	if curve.get_baked_points().size() > MAX_POINTS:
		curve.remove_point(0)
	points = curve.get_baked_points()

func feed_color(color: Color) -> void:
	for i in range(GRADIENT_PRECISION - 1):
		gradient.colors[i] = gradient.colors[i + 1]
	gradient.colors[GRADIENT_PRECISION - 1] = color

func stop() -> void:
	#set_process(false)
	#var tw := get_tree().create_tween()
	#tw.tween_property(self, "modulate:a", 0.0, 3.0)
	#await tw.finished
	queue_free()

static func create() -> Trail:
	var scn = preload("res://actors/trail.tscn")
	return scn.instantiate()
