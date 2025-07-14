class_name BaseBullet extends Area2D

var direction = Vector2.ZERO
#region stats
#All default values are placeholders
@export var base_stats:ProjectileAttackStats
var updated_stats:ProjectileAttackStats
var base_speed := 0
var base_damage := 0.0
var speed:int = 0
var damage:float = 0
#endregion

#region Multipliers
var speed_mods = {}
var damage_mods = {}
#endregion

#region effects
#endregion

@export var movement_behavior:BulletMovementBehavior
var hit_groups: Array[String] = []
var status_effects = {} #Dictionary of potential status effects to inflict

func _ready():
	updated_stats = base_stats.duplicate()
	assert(base_stats, "%s has no stats attached!" % name)
	assert(movement_behavior, "%s has no movement behavior attached!" % name)
	updated_stats = base_stats
	updated_stats.damage = GameManager.add_mods(base_stats.damage, damage_mods)
	updated_stats.speed = GameManager.add_mods(base_stats.speed, speed_mods)
	movement_behavior = movement_behavior.duplicate()
	movement_behavior.my_bullet = self

func _process(delta):
	pass

func on_hit():
	pass

func on_despawn():
	pass


func _on_body_entered(body):
	for group in hit_groups:
		if(body.is_in_group(group)):
			if(group != "Environment"):
				body._on_take_damage(damage)
			queue_free()
			return


func _on_area_entered(area):
	for group in hit_groups:
		if(area.is_in_group(group)):
			if(group != "Environment"):
				if(area.has_method("_on_take_damage")):
					area._on_take_damage(damage)
				elif(area.has_method("_on_hit")):
					area._on_hit(updated_stats, global_position)
			queue_free()
			return
