class_name ContactDamageHandler extends Node2D

@export var attack_stats:AttackStats
@export var hit_box:HitBox 
@export var hit_groups:Array[String] = ["Players"]
var _friendly_fire:bool = false
@export var friendly_fire:bool = false: #Variable to enable and disable contact damage to other enemies
	get: return _friendly_fire
	set(value):
		_friendly_fire = value
		_on_friendly_fire_toggle(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(attack_stats, "%s has no AttackStats attached to it's ContactDamageHandler!" % get_parent().name)
	assert(hit_box, "%s has no HitBox attached to it's ContactDamageHandler!" % get_parent().name) #make sure the hurt box has been hooked up

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_check_hit(bodies, areas, position):
	for area in areas:
		if area is HurtBox:
			for group in hit_groups:
				if(area.is_in_group(group)):
					area._on_hit(attack_stats, position)
	
#_on_friendly_fire_toggle
#Simple function to add and remove Enemies from the hit group, saves retyping code in _ready()
func _on_friendly_fire_toggle(value:bool):
	if(friendly_fire == true and !hit_groups.has("Enemies")):
		hit_groups.append("Enemies")
	elif(friendly_fire == false and hit_groups.has("Enemies")):
		hit_groups.erase("Enemies")
