extends CharacterBody2D

var velocidad: int = 50

func _ready():
	$AnimatedSprite2F.play("andar")
	velocity.x = -velocidad

func _physics_process(delta):
	if is_on_wall():
		if !$AnimatedSprite2F.flip_h: #ESTA MIRANDO A LA IZQUIERDA
			velocity.x = velocidad
		else: #"esta mirando a la derecha"
			velocity.x = -velocidad
	move_and_slide()
	
	if velocity.x <0:
		$AnimatedSprite2F.flip_h = false
	elif velocity.x > 0:
		$AnimatedSprite2F.flip_h = true
	
 
 
