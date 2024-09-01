extends Node2D

var buttons = []
var titles = ["PLAY", "OPTIONS", "EXTRAS", "QUIT"]

var selected = self

func _ready() -> void:
	for i in range(titles.size()):
		var inst = $button.duplicate()
		buttons.append(inst)
		inst.get_node("bg/text").text = titles[i]
		add_child(inst)
	$button.queue_free()

func _physics_process(delta: float) -> void:
	if get_parent().current_state == get_parent().states.MAIN_MENU:
		$bg.rotation_degrees /= 1.3
		position /= 1.1
		modulate = modulate.linear_interpolate(Color.white,delta * 10)
		
		if Input.is_action_just_pressed("ALT_CLICK"):
			get_parent().current_state = get_parent().states.LOGO
			for i in range(get_parent().get_node("bg").count.size()):
				get_parent().get_node("bg").count[i] = 0
		
		for i in range(buttons.size()):
			var p = buttons[i]
			p.get_node("bg/hover").modulate = Color.black
			p.get_node("bg/text").modulate = Color.white
			
			p.position = p.position.linear_interpolate($anchor.position + Vector2(i * -10, i * 40),delta * 10)
			if p.get_node("mouse_detect").is_hovered():
				p.get_node("bg/hover").modulate = Color.white
				p.get_node("bg/text").modulate = Color.black
				p.position += Vector2(2,0.6)
				selected = p
				
		if Input.is_action_just_pressed("CLICK"):
			if selected == buttons[1]:
				get_parent().current_state = get_parent().states.SETTINGS

	
	else:
		position /= 1.1
		
#		$bg.rotation_degrees += (65 - $bg.rotation_degrees) * 0.1
		for i in buttons:
			i.position = i.position.linear_interpolate($bg.position + Vector2(15,10),delta * 20)
			
		modulate = modulate.linear_interpolate(Color.transparent,delta * 30)
#		position.y += (1100 - position.y) * 0.2
