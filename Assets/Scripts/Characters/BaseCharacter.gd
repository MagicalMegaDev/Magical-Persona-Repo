class_name BaseCharacter extends CharacterBody2D 

#Collection of Potential Handlers Goes here
var movement_handler:MovementHandler

func _enter_tree():
	#Gather up Handlers and assign them
	movement_handler = ApplyHandler(MovementHandler)
	movement_handler.myCharacter = self


func ApplyHandler(handler_type) -> Object:
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
