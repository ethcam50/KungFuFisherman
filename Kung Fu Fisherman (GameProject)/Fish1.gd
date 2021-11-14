extends KinematicBody

#Sets the variables
var player
var player_follow = false
var move_speed = 300
var gravity = 20
var fall = Vector3()
var velocity = Vector3()



func _ready():
	pass 


#Gets the enemy to follow the player 
func _physics_process(delta):
	if player_follow == true:
		var pos = player.global_transform.origin
		var facing = -global_transform.basis.z
		look_at(pos, Vector3.UP)
		rotation.x = 0
		rotation.z = 0
		move_and_slide(facing * move_speed * delta, Vector3.UP)
		
	
		
		
#Returns when the player enters the body 
func _on_Area_body_entered(body):
	if body.name == "Player":
		$RayCast.set_enabled(true)
		player_follow = true
		player = body 
		
		
#Returns when the player leaves the area
func _on_Area_body_exited(body):
	if body.name == "Player":
		$RayCast.set_enabled(false)
		player_follow = false
		

