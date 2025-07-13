class_name BaseCharacter extends CharacterBody2D 

#Collection of Potential Handlers Goes here
var movement_handler:MovementHandler
var health_handler:HealthHandler
var gun:Gun

func _enter_tree():
	#Gather up Handlers and assign them
	movement_handler = apply_handler(MovementHandler)
	health_handler = apply_handler(HealthHandler)
	gun = apply_handler(Gun)
	if(movement_handler):
		movement_handler.myCharacter = self
	if(health_handler):
		health_handler.died.connect(_on_death)


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

#_on_take_damage(amount)
#amount: The amount of incoming damage
#Generic signal reciever to handle behavior upon being hit.
func _on_take_damage(amount):
	pass
	
#_on_death
#A signal recieved for died, holds all logic and behavior for character death.
func _on_death():
	queue_free()
