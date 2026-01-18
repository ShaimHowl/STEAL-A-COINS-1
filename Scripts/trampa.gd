extends CharacterBody2D

var SPEED = 180
const RAY_FLOOR_POSITION_X = 30
const RAY_WALL_TARGET_POSITION_X = 29
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var empieza_a_la_derecha: bool = true

var jugador_en_contacto: Node2D = null
var tiempo_entre_daño := 0.4
var temporizador_daño := 0.0

func _ready():
	if empieza_a_la_derecha:
		velocity.x = SPEED
		$detection_floor.position.x = RAY_FLOOR_POSITION_X
		$detection_wall.target_position.x = RAY_WALL_TARGET_POSITION_X
	else:
		velocity.x = -SPEED
		$detection_floor.position.x = -RAY_FLOOR_POSITION_X
		$detection_wall.target_position.x = -RAY_WALL_TARGET_POSITION_X

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if not $detection_floor.is_colliding() or $detection_wall.is_colliding():
		velocity.x *= -1
		$detection_floor.position.x *= -1
		$detection_wall.target_position.x *= -1

	if jugador_en_contacto != null:
		temporizador_daño -= delta
		if temporizador_daño <= 0.0:
			if jugador_en_contacto.has_method("recibir_daño"):
				jugador_en_contacto.recibir_daño(15)
				$AudioStreamPlayer.play()
			temporizador_daño = tiempo_entre_daño

	move_and_slide()

func _on_damage_body_entered(body: Node2D) -> void:
	if body.name == "jugador":
		jugador_en_contacto = body
		temporizador_daño = 0.0

func _on_damage_body_exited(body: Node2D) -> void:
	if body == jugador_en_contacto:
		jugador_en_contacto = null
