class_name GunStats extends Resource

@export_group("Multipliers")
@export var shot_speed := 1.0 #The physical speed of the bullets fired from this gun.
@export var damage := 2.0 #The Damage of the bullets fired from this gun

@export_group("Fire Rate")
@export var rate_limited := true #Does the gun have a rate limit? False for enemies whose fire rate is behaviour controlled
@export var fire_rate := 2.5 #How many Bullets a second to fire

@export var effects:Dictionary[String, bool] = {} #{Name, True/False} Name will be replaced with an effect resource once I have those.
