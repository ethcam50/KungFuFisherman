extends KinematicBody

var gravity = 20
var jump = 8
var player = Vector3()

var speed = 8
var acceleration = 100
var mouse_sensitivity = 0.3

var direction = Vector3()
var velocity = Vector3()

onready var pivot = $Pivot

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		pivot.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		pivot.rotation.x = clamp(pivot.rotation.x, deg2rad(-90), deg2rad(90))

func _physics_process(delta):
	direction = Vector3()
	
	if Input.is_action_pressed("move_foward"):
		direction -= transform.basis.z
		
	elif Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
		
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
		
	elif Input.is_action_pressed("move_right"):
		direction += transform.basis.x
		
	if not is_on_floor():
		player.y -= gravity * delta
		
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		player.y = jump 
		 
		
		
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y = player.y
	move_and_slide(velocity, Vector3.UP)
	

	
	

	
