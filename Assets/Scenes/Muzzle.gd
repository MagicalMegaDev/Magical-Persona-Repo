class_name Muzzle
extends RayCast2D

#constant to make new muzzles point up by default
const DEFAULT_MUZZLE_TARGET = -25.0

@export var default_behavior:BulletMovementBehavior
var offset_angle: float = 0.0
var offset_from_gun: Vector2 = Vector2.ZERO

var gun: Gun

func _ready():
	gun = get_parent() as Gun
	assert(gun, "Muzzle %s could not find parent Gun!" % name)
	if not default_behavior:
		print("Muzzle.gd: %s muzzle missing default behavior! Defaulting to straight shot!" % gun.get_parent().name)
	target_position = Vector2.from_angle(deg_to_rad(offset_angle))

func get_direction() -> Vector2:
	return (to_global(target_position) - global_position).normalized()
	

func _on_controlled_shooting_direction_set(direction):
	pass # Replace with function body.

static func create_muzzle(parent_gun: Gun, angle_degrees: float = 0.0, pos_offset: Vector2 = Vector2.ZERO, behavior: BulletMovementBehavior = null) -> Muzzle:
	var muzzle = Muzzle.new()
	
	muzzle.name = "Muzzle_" + str(angle_degrees)
	muzzle.angle_offset = angle_degrees
	muzzle.offset_from_gun = pos_offset
	
	muzzle.target_position = Vector2(0, DEFAULT_MUZZLE_TARGET)
	muzzle.enabled = false
	
	if behavior:
		muzzle.default_behavior = behavior
	else:
		print("%s muzzle has no behavior, defaulting to straight shot!" % parent_gun.get_parent().name)
		muzzle.default_behavior = preload("res://Assets/Resources/ProjectileBehaviors/StraightShot.tres")
		
	parent_gun.add_child(muzzle)
	return muzzle

func update_transform():
	if gun:
		position = offset_from_gun
		rotation = deg_to_rad(offset_angle)
