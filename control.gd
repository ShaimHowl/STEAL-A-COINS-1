extends Control

@onready var label = $Label
@onready var animation_player = $AnimationPlayer

@export var autostart : bool = true
@export var counter_values : Array = [
	{
		"border_color" : Color('6a4696'),
		"value" : "3"
	},
	{
		"border_color" : Color('2da5ff'),
		"value" : "2"
	},
	{
		"border_color" : Color('ff7564'),
		"value" : "1"
	},
	{
		"border_color" : Color('0da4b6'),
		"value" : "GO!"
	}
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
