extends CharacterBody2D

@onready var player = get_parent().find_child("player")
@onready var animation = $AnimatedSprite2D

func _ready():
	set_physics_process(false)
	await animation.animation_finished
	set_physics_process(true)
	animation.play("Idle")

func _physics_process(_delta):
	var direction = player.position - position
	velocity = direction.normalized() * 80

	move_and_slide()
