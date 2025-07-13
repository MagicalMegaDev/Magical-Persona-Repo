class_name HurtBox extends Area2D

signal contacted(damage:int)

func _on_hit(damage):
	contacted.emit(damage)
