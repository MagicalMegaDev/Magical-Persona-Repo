class_name Muzzle
extends RayCast2D

@export var default_behavior:BulletMovementBehavior
var ray_length: float
var direction: Vector2
var base_direction:Vector2

func _ready():
	ray_length = target_position.length()
	base_direction = target_position.normalized()
	direction = base_direction

func get_direction() -> Vector2:
	return (to_global(target_position) - global_position).normalized()
	

func _on_controlled_shooting_direction_set(direction):
	pass # Replace with function body.
