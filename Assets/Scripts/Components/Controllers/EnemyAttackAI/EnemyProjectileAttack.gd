class_name EnemyProjectileAttack
extends EnemyAttackAI

var shot_direction := Vector2.ZERO

signal shot_fired(direction:Vector2)

#Called when the enemy should attack
func attack():
	get_shot_direction()
	shot_fired.emit(shot_direction)

func get_shot_direction():
	pass
	
func pause():
	pass
	
func resume():
	pass
