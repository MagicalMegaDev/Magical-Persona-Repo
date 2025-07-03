class_name Gun extends Node2D

@export var my_bullet:PackedScene
var shot_timer:Timer

#region stats
@export var shot_speed:float = 1 #How fast the bullets out of this gun move
@export_group("Fire Rrate")
@export var rate_limited:bool = true #Does the gun have a rate limit? False for enemies whose fire rate is behaviour controlled
@export var fire_rate:float = 2.5 #How many bullets a second to fire
#endregion

func _ready():
	shot_timer = $shot_cooldown
	shot_timer.wait_time = 1/fire_rate

func _on_shoot(direction):
	if(shot_timer.is_stopped()):
		var new_bullet := my_bullet.instantiate() as BaseBullet
		assert(new_bullet, "%s 's gun is trying to spawn non-bullets!" % get_parent().name)
		new_bullet.speed_mods["Gun Shot Speed"] = shot_speed
		new_bullet.direction = direction
		add_child(new_bullet)
		new_bullet.global_position = global_position
		shot_timer.start()
