extends Node2D

onready var rect = get_children()
var rect_pos = []

var count = []

var selected = null

func _ready() -> void:
	for i in range(rect.size()):
		rect_pos.append(rect[i].rect_position)
		count.append(0.02 * i)
		rect[i].rect_position += Vector2(rand_range(-255,55),rand_range(-55,55))
		rect[i].hide()
#		rect[i].rect_position.x -= 1100 * i * rand_range(-5,5)
#		rect[i].rect_position.y -= 28 * i
		rect[i].rect_scale = Vector2(0,-2)
		
func _physics_process(delta: float) -> void:
	if get_parent().current_state == get_parent().states.LOGO or get_parent().current_state == get_parent().states.MAIN_MENU:
		for i in range(rect.size()):
			var p = rect[i]
			if count[i] < 0:
				p.show()
				p.rect_scale = p.rect_scale.linear_interpolate(Vector2.ONE, delta * 5)
				p.rect_position = p.rect_position.linear_interpolate(rect_pos[i],delta * 10)
			else:
				count[i] -= delta
				
				
		if Input.is_action_just_pressed("CLICK"):
			get_parent().current_state = get_parent().states.MAIN_MENU
			for i in range(count.size()):
				count[i] = 0
				
		if Input.is_action_just_pressed("ui_cancel"):
			get_tree().reload_current_scene()
	else:
		rect[0].rect_position.y = 1555
		
		for i in range(rect.size()):
			rect[i].rect_global_position.x += ( (rect_pos[i].x + (sin(i) * 100)) - rect[i].rect_global_position.x ) * 0.1
			
			if count[i] > 0.01 * i:
				rect[i].rect_scale /= 1.4
				if rect[i].rect_scale.length() < 0.001:
					rect[i].hide()
			else:
				count[i] += delta * 3
				
	if get_parent().current_state != get_parent().states.LOGO:
		$Label2.rect_position -= Vector2(55,13)
		
#			rect[i].rect_global_position.x += (rect[i - 1].rect_global_position.x - rect[i].rect_global_position.x) * 0.1
#			rect[i].rect_global_position.y += (1555 - rect[i].rect_global_position.y) * 0.004
		

	
