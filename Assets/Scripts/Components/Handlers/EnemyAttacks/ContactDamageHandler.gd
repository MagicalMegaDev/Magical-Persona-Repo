class_name ContactDamageHandler extends Node

@export var damage:int = 1 #Placeholder Value but most enemies will be 1.
@export var HurtBox:Area2D 
@export var hit_groups:Array[String] = ["Players"]
var _friendly_fire:bool = false
@export var friendly_fire:bool = false: #Variable to enable and disable contact damage to other enemies
	get: return _friendly_fire
	set(value):
		_friendly_fire = value
		_on_friendly_fire_toggle(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(HurtBox, "%s has no HurtBox attached to it's ContactDamageHandler!" % get_parent().name) #make sure the hurt box has been hooked up
	HurtBox.body_entered.connect(_on_body_entered)
	print("ContactDamageHandler: %s Connected to HurtBox" % get_parent().name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	print("ContactDamageHandler: %s Made Contact" % get_parent().name)
	for group in hit_groups:
		if(body.is_in_group(group)):
			if(body is BaseCharacter):
				print("With Player")
				body._on_take_damage(damage)

#_on_friendly_fire_toggle
#Simple function to add and remove Enemies from the hit group, saves retyping code in _ready()
func _on_friendly_fire_toggle(value:bool):
	if(friendly_fire == true and !hit_groups.has("Enemies")):
		hit_groups.append("Enemies")
	elif(friendly_fire == false and hit_groups.has("Enemies")):
		hit_groups.erase("Enemies")
