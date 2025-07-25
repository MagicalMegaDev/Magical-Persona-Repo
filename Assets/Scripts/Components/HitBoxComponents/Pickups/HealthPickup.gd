class_name HealthPickup
extends Pickup

const FULL_HEART_FRAME := 0
const HALF_HEART_FRAME := 12

enum HeartValue {HALF_HEART = 1, FULL_HEART = 2}
@export var heal_value: HeartValue = HeartValue.HALF_HEART #Amount of health this pickup heals

func _ready():
	super()
	#Set the frame based on the pickups value
	match heal_value:
		1:
			my_sprite.frame = HALF_HEART_FRAME
		2:
			my_sprite.frame = FULL_HEART_FRAME
