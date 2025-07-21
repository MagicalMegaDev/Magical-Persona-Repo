# Base movement behavior used by bullets.
# This resource is meant to be extended for custom pathing logic
class_name BulletMovementBehavior 
extends Resource

#Reference to the bullet that owns this behavior
var my_bullet:BaseBullet

func move(delta):
	#Should be overridden by subclasses to move the bullet.
	pass
