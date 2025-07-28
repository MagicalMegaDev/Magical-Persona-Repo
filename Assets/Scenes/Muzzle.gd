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
	
func set_direction(new_dir:Vector2) -> void:
	var ang = Vector2.UP.angle_to(new_dir.normalized())
	direction = base_direction.rotated(ang)
	target_position = direction * ray_length


func _on_controlled_shooting_direction_set(direction):
	pass # Replace with function body.
