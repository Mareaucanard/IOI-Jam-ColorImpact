extends CanvasLayer

@export var goal: Goal
@export var cannon: Canon


func _ready() -> void:
	reset()
	goal.win.connect(victory)
	goal.loss.connect(defeat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		reset()
		cannon.reset()
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://menu.tscn")
	$Vicotry.position = $"../Camera2D".get_screen_center_position() - $"../Camera2D".get_viewport_rect().size / 2  
	$Defeat.position = $"../Camera2D".get_screen_center_position() - $"../Camera2D".get_viewport_rect().size / 2  

func reset() -> void:
	$Vicotry.visible = false
	$Defeat.visible = false
	get_tree().call_group("Walls", "reset")

func victory(factor: float) -> void:
	$Vicotry.visible = true
	if factor >= 1.0:
		$Vicotry/Info.text = "Congrats, you surpassed expectations and hit the goal with full power!"
	else:
		$Vicotry/Info.text = "You hit the goal with %2.f%% power!\nPress r to rety\nPress escape to return to the main menu" % (factor * 100)

func defeat(factor: float, velocity: Vector2) -> void:
	$Defeat.visible = true
	$Defeat/Info.text = "You've hit the goal with %2.f%% power.\nYou need %2.f%% power to win\nPress r to retry\nPress escape to return to the main menu" % [(factor * 100), (goal.required_factor * 100)]
	
	
