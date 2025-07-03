class_name ZigZagShot extends BulletMovementBehavior

## Time (in seconds) before switching diagonal direction
@export var interval: float = 0.25
## Distance to move from one side of the line of fire to the other
@export var perpendicular_distance: float = 40.0

var elapsed_time: float = 0.0
var direction_sign: int = 1
var target_offset: float = 0.0
var current_offset: float = 0.0
var offset_speed: float = 0.0

func move(delta: float) -> void:
		if offset_speed == 0.0:
				offset_speed = perpendicular_distance / interval
				target_offset = perpendicular_distance

		elapsed_time += delta
		if elapsed_time >= interval:
				elapsed_time -= interval
				direction_sign *= -1
				target_offset = perpendicular_distance * direction_sign
				offset_speed = 2.0 * perpendicular_distance / interval

		var prev_offset := current_offset
		current_offset = move_toward(current_offset, target_offset, offset_speed * delta)

		var perp := Vector2(-my_bullet.direction.y, my_bullet.direction.x)
		my_bullet.position += my_bullet.direction * my_bullet.speed * delta
		my_bullet.position += perp * (current_offset - prev_offset)
