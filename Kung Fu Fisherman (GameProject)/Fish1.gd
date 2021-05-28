extends KinematicBody

var player
var player_follow = false
var move_speed = 100

func _ready():
	pass 

func _physics_process(delta):
	if player_follow == true:
		pass

func _on_Area_body_entered(body):
	if body.name == "Player":
		$RayCast.set_enabled(true)
		player_follow = true
		player = body 


func _on_Area_body_exited(body):
	if body.name == "Player":
		$RayCast.set_enabled(false)
		player_follow = false
	pass 
