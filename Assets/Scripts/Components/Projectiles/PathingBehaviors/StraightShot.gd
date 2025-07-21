#Moves the bullet in a straight line towards it's direction
class_name StraightShot 
extends BulletMovementBehavior

func move(delta):
	assert(my_bullet != null, "%s: my_bullet is null" % get_script().resource_path)
	my_bullet.position += my_bullet.direction * my_bullet.updated_stats.speed * delta
