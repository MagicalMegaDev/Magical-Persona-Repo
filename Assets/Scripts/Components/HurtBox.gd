class_name HurtBox extends Area2D

signal contacted(damage:int, position:Vector2)

func _on_hit(damage, position):
	contacted.emit(damage, position)
