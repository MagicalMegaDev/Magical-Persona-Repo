class_name ProjectileMovementHandler extends Node

var my_bullet:BaseBullet

func _ready():
	assert(get_parent() is BaseBullet, "%s is not a Bullet!" % [get_parent().name])
	my_bullet = get_parent()

func _physics_process(delta):
	my_bullet.position += my_bullet.direction * my_bullet.speed * delta
