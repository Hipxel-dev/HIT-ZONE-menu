extends Node2D

var buttons = []
onready var visual = $bg.get_children()
var visual_pos = []

func _ready() -> void:
	for i in visual:
		visual_pos.append(i.rect_position)
		i.rect_position.x -= (320 - i.rect_position.x) * 5
func _physics_process(delta: float) -> void:
	if get_parent().current_state == get_parent().states.SETTINGS:
		show()
		
		for i in range(visual.size()):
			visual[i].rect_position = visual[i].rect_position.linear_interpolate(visual_pos[i],delta * 10)
		
		if Input.is_action_just_pressed("ALT_CLICK"):
			get_parent().current_state = get_parent().states.MAIN_MENU
			for i in visual:
				i.rect_position.x -= (320 - i.rect_position.x) * 5
	else:
		hide()
		
