#Base State for enemy AI, exists only to provide a common type
#Stubbed in case of future functionality
class_name EnemyAIState extends State

var my_character:BaseEnemy

func _ready():
	my_character = state_machine.my_owner
	assert(my_character is BaseEnemy, "%s my_character is not hooked up right!" % name)
	
func exit():
	super()


func handle_input(event):
	super(event)

func update(delta):
	super(delta)

func physics_update(delta):
	super(delta)
