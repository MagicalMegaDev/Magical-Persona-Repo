class_name EnemyAIStateMachine extends StateMachine

var movement_states := {}
var attack_states := {}
var active_movement_state:EnemyMovementState
var active_attack_state:EnemyAttackState
@export var starting_movement_state:EnemyMovementState
@export var starting_attack_state:EnemyAttackState

func _ready():
	my_owner = get_parent()
	assert(my_owner is BaseEnemy, "%s is not at root, parent is: %s" % [name, get_parent().name])
	for child in get_children():
		if child is EnemyMovementState:
			movement_states[child.name] = child
			child.state_machine = self
			child.movement_ai.my_character = my_owner
		elif child is EnemyAttackState:
			attack_states[child.name] = child
			child.state_machine = self
		if(starting_movement_state):
			assert(movement_states.has(starting_movement_state.name), "%s StateMachine somehow has a starting movement state not in it's library!" % get_parent().name)
			set_movement_state(starting_movement_state.name)
		if(starting_attack_state):
			assert(attack_states.has(starting_attack_state.name), "%s StateMachine somehow has a starting attack state not in it's library!" % get_parent().name)
			set_attack_state(starting_attack_state.name)

func set_movement_state(name:String):
	if(active_movement_state):
		active_movement_state.exit()
	active_movement_state = movement_states.get(name)
	if(active_movement_state):
		active_movement_state.enter()
	else:
		print("%s movement state doesn't exist at %s !" % [name, my_owner.name])
		
func set_attack_state(name:String):
	if(active_attack_state):
		active_attack_state.exit()
	active_attack_state = attack_states.get(name)
	if(active_attack_state):
		active_attack_state.enter()
	else:
		print("%s attack state doesn't exist at %s !" % [name, my_owner.name])
		
func _process(delta):
	if active_movement_state:
		active_movement_state.update(delta)
	if active_attack_state:
		active_attack_state.update(delta)
		
func _physics_process(delta):
	if active_movement_state:
		active_movement_state.physics_update(delta)
	if active_attack_state:
		active_attack_state.physics_update(delta)
