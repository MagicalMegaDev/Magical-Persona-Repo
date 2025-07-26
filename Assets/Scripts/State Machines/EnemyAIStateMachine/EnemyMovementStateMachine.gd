class_name EnemyMovementStateMachine
extends StateMachine


# Called when the node enters the scene tree for the first time.
func _enter_tree():
	super()
	for child in states.values():
		if(child is EnemyMovementState):
			child.state_machine = self
			child.movement_ai.my_character = my_owner
		else: print ("%s in %s is not an EnemyMovementState!" % [child.name, get_parent().name])
