extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 1.6
var bLeftKeyPressed = false
var bRightKeyPressed = false
var bForwardKeyPressed = false
var bDownKeyPressed = false
var bBackKeyPressed = false
var bMousePressed = false
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
		var flag = false
		if event.pressed:
			flag = true
		if event.scancode == KEY_A:
			bLeftKeyPressed = flag
		if event.scancode == KEY_D:
			bRightKeyPressed = flag
		if event.scancode == KEY_W:
			bForwardKeyPressed = flag
		if event.scancode == KEY_S:
			bBackKeyPressed = flag
		if event.scancode == KEY_Q:
			bDownKeyPressed = flag
		if event.scancode == KEY_E:
			bUpKeyPressed = flag
	if event is InputEventMouseButton:
		bMousePressed = event.pressed;
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
		
	if bMousePressed:
		var list = [];
		var space_state = get_world().direct_space_state;
		var cam = get_node("Camera");
		var from = cam.project_ray_origin(mousePos);
		var to = from + cam.project_ray_normal(mousePos) * rayLength;
		var res = space_state.intersect_ray(to, from);
		
		while res.has("position"):
			list.append(res.collider);
			res = space_state.intersect_ray(to, from, list);
		
		
		# get_node("../target").transform.origin = res.position + Vector3(0, 0.25, 0);
	# var result = space_state.intersect_ray()
	
