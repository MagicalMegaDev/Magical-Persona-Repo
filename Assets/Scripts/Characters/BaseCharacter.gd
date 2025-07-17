class_name BaseCharacter extends CharacterBody2D 

#Collection of Potential Handlers Goes here
var movement_handler:MovementHandler
var health_handler:HealthHandler
var contact_damage_handler:ContactDamageHandler
var knockback_controller:KnockbackController
var gun:Gun

@export var stats:CharacterStats

signal stats_ready(stats : CharacterStats)

func _enter_tree():
	#Gather up Handlers and assign them
	movement_handler = apply_handler(MovementHandler)
	health_handler = apply_handler(HealthHandler)
	contact_damage_handler = apply_handler(ContactDamageHandler)
	knockback_controller = apply_handler(KnockbackController) 
	gun = apply_handler(Gun)
	assert(stats, "%s has no stats attached!" % name)
	if(movement_handler):
		movement_handler.my_character = self
		movement_handler.my_stats = stats
	if(health_handler):
		health_handler.died.connect(_on_death)
		stats_ready.connect(health_handler._receive_stats)
	if(knockback_controller):
		stats_ready.connect(knockback_controller._receive_stats)
		assert(movement_handler, "%s has a knockback handler but no movement handler!" % name)
		knockback_controller.apply_knockback.connect(movement_handler._on_knockback)
		movement_handler.knockback_finished.connect(knockback_controller._on_knockback_enabled)
	stats_ready.emit(stats)

func _ready():
	#DEBUG
	_debug()

func apply_handler(handler_type) -> Object:
	var found: Object = null
	for child in GameManager.get_all_children(self):
		if is_instance_of(child, handler_type):
			if found:
				print("Multiple " + str(handler_type) + " found at: " + self.name)
			else:
				found = child
	
	return found

#_on_velocity_calculated(momentum)
#momentum:Vector2 = The players current speed in x and y, to be assigned to velocity
#This is simply a generic signal reciever to make the character move, agnostic of whether it is through input, AI, or otherwise.
func _on_velocity_calculated(momentum):
	velocity = momentum
	move_and_slide()

#_on_take_damage(stats: AttackStats)
#amount: The amount of incoming damage
#Generic signal reciever to handle behavior upon being hit.
func _on_take_damage(stats: AttackStats):
	pass
	
#_on_death
#A signal recieved for died, holds all logic and behavior for character death.
func _on_death():
	queue_free()
	
func _debug():
	TestDebugMenu._add_inspector(stats, name)
