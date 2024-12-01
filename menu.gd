extends Control

var help_state = false
var delta_sum = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_exit_help_text_pressed()

func _process(delta: float) -> void:
	delta_sum += delta
	var c = color(delta_sum)
	$Title/Sprite2D.modulate = c
	$Title/Line2D.feed_color(c)

func f(x: float) -> float:
	return (sin(x/2) + 1) / 2

func color(x: float) -> Color:
	return lerp(Color(1,0.2,0.2), Color(0.2,0.2,1), f(x))

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/highway.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/peggle/peggle.tscn")
	


func _on_help_pressed() -> void:
	help_state = true
	$Level1.visible = false
	$Level2.visible = false
	$Help.visible = false
	$Exit.visible = false
	$Title.visible = false
	$"Help text".visible = true
	$"Exit help text".visible = true


func _on_exit_help_text_pressed() -> void:
	help_state = false
	$Level1.visible = true
	$Level2.visible = true
	$Title.visible = true
	$Help.visible = true
	$Exit.visible = true
	$"Help text".visible = false
	$"Exit help text".visible = false


func _on_exit_pressed() -> void:
	get_tree().quit()
