extends Line2D

var GRADIENT_PRECISION = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gradient.offsets = []
	gradient.colors = []
	for i in range(GRADIENT_PRECISION):
		var j = float(i) / GRADIENT_PRECISION
		gradient.add_point(j, $"../..".color(1 - j))

func feed_color(color: Color) -> void:
	for i in range(GRADIENT_PRECISION - 1):
		gradient.colors[i] = gradient.colors[i + 1]
	gradient.colors[GRADIENT_PRECISION - 1] = color
