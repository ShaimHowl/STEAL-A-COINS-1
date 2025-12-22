extends CharacterBody2D

@export var speed = 300
@export var jump = -430
var health = 100
var gravity = 980
@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta):

	# Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Salto
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump

	# Movimiento horizontal
	var direction = Input.get_axis("move_left", "move_right")

	if direction < 0:
		animated_sprite_2d.flip_h = true
	elif direction > 0:
		animated_sprite_2d.flip_h = false

	# Animaciones
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("Idle")
		else:
			animated_sprite_2d.play("run")
	else:
		if velocity.y < 0:
			animated_sprite_2d.play("jump")
		else:
			animated_sprite_2d.play("fall")

	# Aplicar movimiento
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func _on_damgedetection_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	health -= 25
	print(health)
