class_name Muzzle
extends RayCast2D

@export var default_behavior:BulletMovementBehavior
var ray_length: float
var direction: Vector2

func _ready():
	ray_length = target_position.length()
	direction = target_position.normalized()
	
func set_direction(new_dir:Vector2) -> void:
	direction = new_dir.normalized()
	target_position = direction * ray_length


func _on_controlled_shooting_direction_set(direction):
	pass # Replace with function body.
