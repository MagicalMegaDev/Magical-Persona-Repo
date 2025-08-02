# CharacterStats.gd
# Defines base statistics shared by any character in the game.  These
# values are duplicated for each character instance so they can be
# modified at runtime without affecting the original resource.

extends Resource
class_name CharacterStats

@export_group("Health")
@export var max_health := 5 #Maximum Health Points. For player, 2 = one Heart

@export_group("Movement")
@export var base_max_speed := 200.0 #Maximum Speed
@export var base_acceleration := 50.0 #Acceleration Rate
@export var base_friction := 50.0 #Deacceleration Rate when Idle

@export_group("Physical")
@export var weight := 50.0 #Weight of the Object, used to scale knockback force
