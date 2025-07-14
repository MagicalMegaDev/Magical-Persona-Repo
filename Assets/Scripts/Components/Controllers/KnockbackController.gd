class_name KnockbackController extends Node2D

var weight := 50


signal apply_knockback(knockback : Vector2)

func _receive_stats(stats:CharacterStats):
	weight = stats.weight 
	
func calculate_knockback(stats:AttackStats, direction:Vector2):
	var ratio = stats.force/weight
	var delta = get_physics_process_delta_time()
	var knockback = direction * stats.force * delta
	apply_knockback.emit(knockback)
	
	
