class_name HurtBox extends Area2D

signal contacted(stats:AttackStats, position:Vector2)

func _on_hit(stats:AttackStats, position):
	contacted.emit(stats, position)
