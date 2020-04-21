extends Spatial


var speed = 1.6
var bLeftKeyPressed = false
var bRightKeyPressed = false
var bForwardKeyPressed = false
var bDownKeyPressed = false
var bBackKeyPressed = false
var bLeftMousePressed = false
var bRightMousePressed = false
var bUpKeyPressed = false
var mousePos = Vector2()
var rayLength = 100
var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node("../target")
	pass # Replace with function body.


func _unhandled_input(event):
	if event is InputEventKey:
		if event.scancode == KEY_A:
			bLeftKeyPressed = event.pressed
		if event.scancode == KEY_D:
			bRightKeyPressed = event.pressed
		if event.scancode == KEY_W:
			bForwardKeyPressed = event.pressed
		if event.scancode == KEY_S:
			bBackKeyPressed = event.pressed
		if event.scancode == KEY_Q:
			bDownKeyPressed = event.pressed
		if event.scancode == KEY_E:
			bUpKeyPressed = event.pressed
	if event is InputEventMouseButton:
		if (event.button_index == 1):
			bLeftMousePressed = event.pressed
		elif event.button_index == 2:
			bRightMousePressed = event.pressed
	if event is InputEventMouseMotion:
		mousePos = event.position;


func _physics_process(delta):
	if bLeftKeyPressed:
		translate_object_local(transform.basis.x * speed * delta)
	if bRightKeyPressed:
		translate_object_local(-transform.basis.x * speed * delta)
	if bForwardKeyPressed:
		translate_object_local(transform.basis.z * speed * delta)
	if bBackKeyPressed:
		translate_object_local(-transform.basis.z * speed * delta)
	if bDownKeyPressed:
		translate_object_local(-transform.basis.y * speed * delta)
	if bUpKeyPressed:
		translate_object_local(transform.basis.y * speed * delta)
		
	if bRightMousePressed:
		var list = []; var obj = [];
		var space_state = get_world().direct_space_state;
		var cam = get_node("Camera");
		var from = cam.project_ray_origin(mousePos);
		var to = from + cam.project_ray_normal(mousePos) * rayLength;
		var res = space_state.intersect_ray(to, from);
		
		var pos = to
		
		while res.has("position"):
			list.append(res.collider);
			if (pos - from).length() > (res.position - from).length():
				pos = res.position
			res = space_state.intersect_ray(from, to, list);

		if list.size() > 0:
			target.transform.origin = pos;
