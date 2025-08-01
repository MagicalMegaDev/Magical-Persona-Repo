class_name HeartContainer extends TextureRect

const HEART_MIN = 0 #The minimum value a heart container can be
const HEART_MAX = 2 #The Maximum value of a heart. By default a heart goes empty, half, full, but I may want to implement quarter hearts in the future.

@onready var sprite:AnimatedSprite2D = $HeartContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_state(state: int):
	sprite.frame = clamp(state,HEART_MIN,HEART_MAX)
