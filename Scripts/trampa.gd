extends CharacterBody2D

var SPEED = 200
const RAY_FLOOR_POSITION_X = 30
const RAY_WALL_TARGET_POSITION_X = 29
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	velocity.x = SPEED
	$detection_floor.position.x = RAY_FLOOR_POSITION_X
	$detection_wall.target_position.x = RAY_WALL_TARGET_POSITION_X
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	if not $detection_floor.is_colliding() || $detection_wall.is_colliding():
		velocity.x *=  -1
		$detection_floor.position.x *= -1
		$detection_wall.target_position.x *= -1
	move_and_slide()
