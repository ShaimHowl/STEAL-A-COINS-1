extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().has_node("jugador"):
		$health_ProgressBar.value = get_parent().get_node("jugador").health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$health_ProgressBar.value = get_parent().get_node("jugador").health
