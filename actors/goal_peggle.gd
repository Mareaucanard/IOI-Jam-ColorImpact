extends Goal

@onready var path = $".."
@export var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path.progress += speed * delta

func reset():
	super()
