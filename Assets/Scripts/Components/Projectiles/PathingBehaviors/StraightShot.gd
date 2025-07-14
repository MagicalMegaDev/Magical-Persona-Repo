class_name StraightShot extends BulletMovementBehavior

func move(delta):
	my_bullet.position += my_bullet.direction * my_bullet.updated_stats.speed * delta
