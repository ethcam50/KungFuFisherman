extends KinematicBody

var speed = 10
var acceleration = 5
var mouse_sensitivity = 0.1

var direction = Vector3()
var velocity = Vector3()

func _ready():
	pass 

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		

func _process(delta):
	
	direction = Vector3()
	
	if Input.is_action_pressed("move_foward"):
		
		direction -= transform.basis.z
		
	elif Input.is_action_pressed("move_backward"):
		
		direction += transform.basis.z
		
	if Input.is_action_pressed("move_left"):
		
		direction -= transform.basis.x
		
	elif Input.is_action_pressed("move_right"):
		
		direction += transform.basis.x
		
	direction = direction.normalized()
	velocity = direction * speed
	velocity.linear_interpolate(velocity, acceleration * delta)
	move_and_slide(velocity, Vector3.UP)
	
