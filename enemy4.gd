extends CharacterBody2D

@export var max_health = 50
var health = 0
var muerto = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var health_bar = $Vida/health_ProgressBar   # ← NUEVO

func _ready():
	health = max_health
	health_bar.max_value = max_health
	health_bar.value = health

	hitbox.connect("body_entered", Callable(self, "_on_hitbox_body_entered"))

func _on_hitbox_body_entered(body):
	if muerto:
		return

	if body.is_in_group("jugador") and body.atacando:
		recibir_daño(20)

func recibir_daño(cantidad):
	if muerto:
		return

	health -= cantidad
	health_bar.value = health   # ← ACTUALIZA LA BARRA

	print("enemy4 vida:", health)

	if health <= 0:
		morir()

func morir():
	muerto = true
	print("enemy4 muerto")

	if animated_sprite.has_animation("death"):
		animated_sprite.play("death")
		await animated_sprite.animation_finished

	queue_free()
