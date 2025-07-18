#TODO: ADD GUN STATS RESOURCE

class_name Gun extends Node2D

@export var my_bullet:PackedScene
@export var hit_groups:Array[String] = []
var shot_timer:Timer

#region stats
#All default values are placeholders
@export var stats:GunStats
var shot_speed:float: #How fast the bullets out of this gun move
	get():
		return stats.shot_speed
	set(value):
		stats.shot_speed = value
var damage:float: #How much damage this gun does
	get():
		return stats.damage
	set(value):
		stats.damage = value

var rate_limited:bool: #Does the gun have a rate limit? False for enemies whose fire rate is behaviour controlled
	get():
		return stats.rate_limited
	set(value):
		stats.rate_limited = value

var fire_rate:float: #How many bullets a second to fire
	get():
		return stats.fire_rate
	set(value):
		stats.fire_rate = value
		shot_timer.wait_time = 1/stats.fire_rate
#endregion

#region effects
#@export_group("Effects")
#var _spectral:bool = false
#@export var spectral:bool :
#	get:
#		return _spectral
#	set(value):
#		_spectral = value
#		if(spectral):
#			remove_hit_group("Environment")
#		else:
#			add_hit_group("Environment")
#endregion

func _ready():
	stats = stats.duplicate()
	_debug()
	shot_timer = $shot_cooldown
	shot_timer.wait_time = 1/fire_rate
#	if(spectral):
#		remove_hit_group("Environment")
#	else:
#		add_hit_group("Environment")

func _on_shoot(direction):
	if(direction == Vector2.ZERO):
		return
	if(shot_timer.is_stopped() || !rate_limited):
		var new_bullet := my_bullet.instantiate() as BaseBullet
		assert(new_bullet, "%s 's gun is trying to spawn non-bullets!" % get_parent().name)
		new_bullet.speed_mods["Gun Shot Speed"] = shot_speed
		new_bullet.damage_mods["Gun Damage"] = damage
		new_bullet.direction = direction
		new_bullet.hit_groups = hit_groups
		get_tree().current_scene.add_child(new_bullet)
		new_bullet.global_position = global_position
		shot_timer.wait_time = 1/stats.fire_rate
		shot_timer.start()

func add_hit_group(group:String):
	if !(hit_groups.has(group)):
		hit_groups.append(group)
	
func remove_hit_group(group:String):
	if(hit_groups.has(group)):
		hit_groups.erase(group)

func _debug():
	TestDebugMenu._add_inspector(stats, "Player")
	var bullet = my_bullet.instantiate() as BaseBullet
	TestDebugMenu._add_inspector(bullet.base_stats, "Player")
	bullet.queue_free()
	#SEND GUN STATS HERE ONCE MADE.
