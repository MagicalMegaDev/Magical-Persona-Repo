# GunStats.gd
# Shared gun data describing projectile behaviour and rate of fire.

class_name GunStats
extends Resource

@export_group("Multipliers")
@export var shot_speed := 1.0 #Base Speed modifier for bullets fired
@export var damage := 2.0 #Base Modifier for Damage inflicted by a bullet

@export_group("Fire Rate")
#If True the gun must wait between shots. Should ONLY be false for enemies whose shot frequency is behavior controlled.
@export var rate_limited := true
@export var fire_rate := 2.5 #Bullets fired per second when rate limited

@export var effects:Dictionary[String, bool] = {} #{Name, True/False} Name will be replaced with an effect resource once I have those.
