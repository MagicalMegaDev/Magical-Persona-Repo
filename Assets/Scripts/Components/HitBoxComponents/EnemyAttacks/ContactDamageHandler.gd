#Handles Damage delaing when an enemy HitBox overlaps a valid HurtBox
class_name ContactDamageHandler 
extends Node2D

@export var attack_stats:AttackStats #The incoming attack's stats
@onready var hit_box:HitBox = get_parent()
@export var hit_groups:Array[String] = ["Players"] #Groups this handler can damage
var _friendly_fire:bool = false
@export var friendly_fire:bool = false: #Variable to enable and disable contact damage to other enemies
	get: return _friendly_fire
	set(value):
		_friendly_fire = value
		_on_friendly_fire_toggle(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(attack_stats, "%s has no AttackStats attached to it's ContactDamageHandler!" % get_parent().name)
	if not hit_box.collections_in_area.is_connected(_on_check_hit):
		hit_box.collections_in_area.connect(_on_check_hit)
		
#Check all colliders inside the hitbox for any in hit_groups
func _on_check_hit(bodies:Array, areas:Array, position:Vector2):
	for area in areas:
		if area is HurtBox:
			for group in hit_groups:
				if(area.is_in_group(group)):
					area._on_hit(attack_stats, position)
					break

#Simple function to add and remove Enemies from the hit group, saves retyping code in _ready()
func _on_friendly_fire_toggle(value:bool):
	if(value and !hit_groups.has("Enemies")):
		hit_groups.append("Enemies")
	elif(!value and hit_groups.has("Enemies")):
		hit_groups.erase("Enemies")
