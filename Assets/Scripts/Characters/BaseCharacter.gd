class_name BaseCharacter extends CharacterBody2D 

#Collection of Potential Handlers Goes here
#var xHandler:XHandler

func _enter_tree():
	pass
	#Gather up Handlers and assign them
	#ApplyHandler(xHandler, XHandler)

#func ApplyHandler(handlerVariable, Type):
#Figure out how to make a Type a variable and then
#for child in game_manager.get_all_children(self):
		#if child is Type:
			#if(handlerVariable):
				#print("Multiple" + howeveryoudoTypeName +" found at: " + self.name)
			#else:
				#handlerVariable = child

#_on_velocity_calculated(momentum)
#momentum:Vector2 = The players current speed in x and y, to be assigned to velocity
#This is simply a generic signal reciever to make the character move, agnostic of whether it is through input, AI, or otherwise.
func _on_velocity_calculated(momentum):
	velocity = momentum
	move_and_slide()
