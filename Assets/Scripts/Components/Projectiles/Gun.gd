#TODO: ADD GUN STATS RESOURCE

#Class for anything that fires projectiles
class_name Gun 
extends Node2D

@export var my_bullet:PackedScene
@export var hit_groups:Array[String] = []
@export var default_behavior:BulletMovementBehavior
var shot_timer:Timer

#region stats
#All default values are placeholders
@export var stats:GunStats
var shot_speed:float: #Speed multiplier for bullets coming out of this gun
	get():
		return stats.shot_speed
	set(value):
		stats.shot_speed = value
var damage:float: #Damage multiplier for bullets coming out of this gun
	get():
		return stats.damage
	set(value):
		stats.damage = value

var rate_limited:bool: #If true, this gun's fire rate is capped by the fire_rate stat. ONLY Set false if shot frequency is AI behavior controlled
	get():
		return stats.rate_limited
	set(value):
		stats.rate_limited = value

var fire_rate:float: #Number of bullets this gun can fire a second.
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
	assert(stats, "%s Gun has no stats resource!" % get_parent().name)
	assert(my_bullet, "%s Gun has no bullet PackedScene assigned!" % get_parent().name)
	assert(default_behavior, "%s Gun has no default behavior!" % get_parent().name)
	assert (has_node("shot_cooldown"), "%s has no shot_cooldown Timer!" % get_parent().name)
	stats = stats.duplicate()
	_debug()
	shot_timer = $shot_cooldown
	shot_timer.wait_time = 1/fire_rate
#	if(spectral):
#		remove_hit_group("Environment")
#	else:
#		add_hit_group("Environment")

# Fires a bullet in the provided direction if able.
func _on_shoot(direction: Vector2):
	if(direction == Vector2.ZERO):
		return
	if(shot_timer.is_stopped() || !rate_limited):
		var new_bullet := my_bullet.instantiate() as BaseBullet
		assert(new_bullet, "%s 's gun is trying to spawn non-bullets!" % get_parent().name)
		new_bullet.speed_mods["Gun Shot Speed"] = shot_speed
		new_bullet.damage_mods["Gun Damage"] = damage
		new_bullet.direction = direction
		new_bullet.hit_groups = hit_groups
		if(new_bullet.movement_behavior == null):
			new_bullet.movement_behavior = default_behavior
		get_tree().current_scene.add_child(new_bullet)
		new_bullet.global_position = global_position
		shot_timer.wait_time = 1/stats.fire_rate
		shot_timer.start()

# Adds a new collision group this gun's bullets can hit.
func add_hit_group(group:String):
	if !(hit_groups.has(group)):
		hit_groups.append(group)
	
# Removes a collision group from the gun if present.
func remove_hit_group(group:String):
	if(hit_groups.has(group)):
		hit_groups.erase(group)

func _debug():
	TestDebugMenu._add_inspector(stats, "Player")
	var bullet = my_bullet.instantiate() as BaseBullet
	TestDebugMenu._add_inspector(bullet.base_stats, "Player")
	bullet.queue_free()
	#SEND GUN STATS HERE ONCE MADE.
