class_name ContactDamageHandler extends Node2D

@export var damage:int = 1 #Placeholder Value but most enemies will be 1.
@export var HitBox:Area2D 
@export var hit_groups:Array[String] = ["Players"]
var _friendly_fire:bool = false
@export var friendly_fire:bool = false: #Variable to enable and disable contact damage to other enemies
	get: return _friendly_fire
	set(value):
		_friendly_fire = value
		_on_friendly_fire_toggle(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(HitBox, "%s has no HitBox attached to it's ContactDamageHandler!" % get_parent().name) #make sure the hurt box has been hooked up
	HitBox.area_entered.connect(_on_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	if(area is HurtBox):
		for group in hit_groups:
			if(area.is_in_group(group)):
				area._on_hit(damage)
	
#_on_friendly_fire_toggle
#Simple function to add and remove Enemies from the hit group, saves retyping code in _ready()
func _on_friendly_fire_toggle(value:bool):
	if(friendly_fire == true and !hit_groups.has("Enemies")):
		hit_groups.append("Enemies")
	elif(friendly_fire == false and hit_groups.has("Enemies")):
		hit_groups.erase("Enemies")
