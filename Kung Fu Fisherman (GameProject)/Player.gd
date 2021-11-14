extends KinematicBody

#Player movement variables
export var speed : float = 10
export var acceleration : float = 7
export var air_acceleration : float = 5
export var gravity : float = 0.8
export var max_terminal_velocity : float = 54
export var jump_power : float = 15

#Camera variables
export(float, 0.1, 1) var mouse_sensitivity : float = 0.3
export(float, -90, 0) var min_pitch : float = -90
export(float, 0, 90) var max_pitch : float = 90

#Velocity/movement calculation variables
var velocity : Vector3
var y_velocity : float

#Camera variables
onready var camera_pivot = $CameraPivot
onready var camera = $CameraPivot/CameraBoom/Camera


#Function that locks the mouse
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


#Allows the player to unlock the mouse with the 'Esc' button
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


#Sets the camera movement in relation to the movement of the mouse
func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		camera_pivot.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, min_pitch, max_pitch)


#Creates a function for the movement
func _physics_process(delta):
	handle_movement(delta)
	
	
#Movement function
func handle_movement(delta):
	var direction = Vector3()
	
	#Input controls
	if Input.is_action_pressed("move_foward"):
		direction -= transform.basis.z
		
		
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
		
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
		
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
		
	direction = direction.normalized()
	
	#acceleration in the air and on the ground
	var accel = acceleration if is_on_floor() else air_acceleration
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	
	#Velocity calculations
	if is_on_floor():
		y_velocity = -0.01
	else:
		y_velocity = clamp(y_velocity - gravity, -max_terminal_velocity, max_terminal_velocity)
		
	#Jump input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		y_velocity = jump_power
	
	#Other velocity calculations
	velocity.y = y_velocity
	velocity = move_and_slide(velocity, Vector3.UP)
