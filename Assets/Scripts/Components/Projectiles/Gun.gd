#TODO: ADD GUN STATS RESOURCE

class_name Gun extends Node2D

@export var my_bullet:PackedScene
@export var hit_groups:Array[String] = []
var shot_timer:Timer

#region stats
#All default values are placeholders
@export var shot_speed:float = 1 #How fast the bullets out of this gun move
@export var damage:float = 2 #How much damage this gun does
@export_group("Fire Rrate")
@export var rate_limited:bool = true #Does the gun have a rate limit? False for enemies whose fire rate is behaviour controlled
@export var fire_rate:float = 2.5 #How many bullets a second to fire
#endregion

#region effects
@export_group("Effects")
var _spectral:bool = false
@export var spectral:bool :
	get:
		return _spectral
	set(value):
		_spectral = value
		if(spectral):
			remove_hit_group("Environment")
		else:
			add_hit_group("Environment")
#endregion

func _ready():
	_debug()
	shot_timer = $shot_cooldown
	shot_timer.wait_time = 1/fire_rate
	if(spectral):
		remove_hit_group("Environment")
	else:
		add_hit_group("Environment")

func _on_shoot(direction):
	if(direction == Vector2.ZERO):
		return
	if(shot_timer.is_stopped()):
		var new_bullet := my_bullet.instantiate() as BaseBullet
		assert(new_bullet, "%s 's gun is trying to spawn non-bullets!" % get_parent().name)
		new_bullet.speed_mods["Gun Shot Speed"] = shot_speed
		new_bullet.damage_mods["Gun Damage"] = damage
		new_bullet.direction = direction
		new_bullet.hit_groups = hit_groups
		get_tree().current_scene.add_child(new_bullet)
		new_bullet.global_position = global_position
		shot_timer.start()

func add_hit_group(group:String):
	if !(hit_groups.has(group)):
		hit_groups.append(group)
	
func remove_hit_group(group:String):
	if(hit_groups.has(group)):
		hit_groups.erase(group)

func _debug():
	TestDebugMenu._add_inspector(self, "Player")
	var bullet = my_bullet.instantiate() as BaseBullet
	TestDebugMenu._add_inspector(bullet.base_stats, "Player")
	bullet.queue_free()
	#SEND GUN STATS HERE ONCE MADE.
