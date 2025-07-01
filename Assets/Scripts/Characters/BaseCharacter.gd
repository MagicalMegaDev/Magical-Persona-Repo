class_name BaseCharacter extends CharacterBody2D 

#Collection of Potential Handlers Goes here
var movementHandler:MovementHandler

func _enter_tree():
	#Gather up Handlers and assign them
	movementHandler = ApplyHandler("MovementHandler")

func ApplyHandler(className:String) -> Object:
	var found:Object = null
	for child in GameManager.get_all_children(self):
		if child.is_class(className):
			if(found):
				print("Multiple" + className +" found at: " + self.name)
			else:
				found = child
	return found

func _ready():
	if(movementHandler):
		print(movementHandler.name)
	else:
		print("Nope")
#_on_velocity_calculated(momentum)
#momentum:Vector2 = The players current speed in x and y, to be assigned to velocity
#This is simply a generic signal reciever to make the character move, agnostic of whether it is through input, AI, or otherwise.
func _on_velocity_calculated(momentum):
	velocity = momentum
	move_and_slide()
