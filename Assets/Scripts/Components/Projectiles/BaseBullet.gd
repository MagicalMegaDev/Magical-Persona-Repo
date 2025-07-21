class_name BaseBullet extends Area2D

var direction = Vector2.ZERO
#region stats
#All default values are placeholders
@export var base_stats:ProjectileAttackStats
var updated_stats:ProjectileAttackStats
var speed := 0.0:
	get():
		return updated_stats.speed
	set(value):
		updated_stats.speed = value
var damage := 0.0:
	get():
		return updated_stats.damage
	set(value):
		updated_stats.damage = value
#endregion

#region Multipliers
var speed_mods := {}
var damage_mods := {}
#endregion

#region effects
#endregion

@export var movement_behavior:BulletMovementBehavior

#groups this projectile can collide with and apply damage to.
var hit_groups: Array[String] = []
var status_effects = {} #Dictionary of potential status effects to inflict

func _ready():
	assert(base_stats, "%s has no stats attached!" % name)
	assert(movement_behavior, "%s has no movement behavior attached!" % name)
	updated_stats = base_stats.duplicate()
	damage = GameManager.apply_modifiers(base_stats.damage, damage_mods, name)
	speed = GameManager.apply_modifiers(base_stats.speed, speed_mods, name)
	movement_behavior = movement_behavior.duplicate()
	movement_behavior.my_bullet = self

func on_hit():
	pass

func on_despawn():
	pass

func _on_body_entered(body):
	for group in hit_groups:
		if(body.is_in_group(group)):
			if(group != "Environment" and body.has_method("_on_take_damage")):
				body._on_take_damage(updated_stats)
			queue_free()
			return


func _on_area_entered(area):
	for group in hit_groups:
		if(area.is_in_group(group)):
			if(group != "Environment"):
				if(area.has_method("_on_take_damage")):
					area._on_take_damage(updated_stats)
				elif(area.has_method("_on_hit")):
					area._on_hit(updated_stats, global_position)
			queue_free()
			return
