class_name KnockbackController extends Node2D

var weight := 50
var can_knockback := true #Bool to turn off knockback

signal apply_knockback(knockback : Vector2)

func _receive_stats(stats:CharacterStats):
	weight = stats.weight 
	
func calculate_knockback(stats:AttackStats, attacker_posistion:Vector2):
	var ratio = stats.force/weight
	var delta = get_physics_process_delta_time()
	var direction = (global_position - attacker_posistion).normalized()
	var knockback = direction * GameManager.BASE_KNOCKBACK_STRENGTH * ratio
	apply_knockback.emit(knockback)
	
func _on_knockback_enabled():
	can_knockback = true

func _on_knockback_disabled():
	can_knockback = false
