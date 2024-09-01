extends Line2D

var spacing = 32
var length = 1000
var p_vel = []

var outline_self = Line2D

func _ready() -> void:
	for i in range(length / spacing):
		add_point(Vector2(i * spacing,0))
		p_vel.append(Vector2.ZERO)
	position.y = width * 1.8
	
	var outline_inst = outline_self.new()
	outline_inst.default_color = Color8(255,255,255,50)
	outline_inst.position.y = -width / 2
	outline_inst.joint_mode = joint_mode
#	outline_inst.width = 32
	outline_inst.begin_cap_mode = begin_cap_mode
	outline_inst.end_cap_mode = end_cap_mode
	for i in range(length / spacing):
		outline_inst.add_point(Vector2(i * spacing, 0))
	add_child(outline_inst)
	outline_self = outline_inst
	
	
func _physics_process(delta: float) -> void:
	outline_self.hide()
	for i in range(points.size() - 1):
		
		points[i + 1] += p_vel[i + 1] * (delta * 1)
		p_vel[i + 1] /= 1.05
		p_vel[i + 1] += (points[i] - points[i + 1]) * 6
		p_vel[i + 1] += (Vector2((i + 1) * spacing, 0) - points[i + 1])  * 2
		p_vel[i] += (points[i + 1] - points[i])  * 6
		outline_self.points[i] = points[i]
	
	if Input.is_action_pressed("CLICK"):
		for i in range(points.size()):
			if points[i].distance_squared_to(get_local_mouse_position()) < 11500:
				var result = (get_local_mouse_position() - points[i]).normalized() * 200
				p_vel[i].y -= result.y
				
