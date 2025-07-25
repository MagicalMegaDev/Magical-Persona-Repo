class_name HealthPickup
extends PickupEffect

const FULL_HEART_FRAME := 0
const HALF_HEART_FRAME := 12

enum HeartValue {HALF_HEART = 1, FULL_HEART = 2}
@export var heal_value: HeartValue = HeartValue.HALF_HEART #Amount of health this pickup heals
var my_sprite:Sprite2D

func _setup():
	#Set the frame based on the pickups value
	match heal_value:
		1:
			my_sprite.frame = HALF_HEART_FRAME
		2:
			my_sprite.frame = FULL_HEART_FRAME
	qualifier = func(obj): return obj.current_health < obj.max_health
	action = func(obj): obj.heal_damage(heal_value)
