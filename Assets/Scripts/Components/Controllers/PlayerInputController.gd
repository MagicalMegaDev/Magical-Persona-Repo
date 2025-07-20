#This script is a signal bus for all player input.
class_name PlayerInputController 
extends Node

@export var my_character:BaseCharacter

#region DEBUG
const DEBUG_SPEED := 2
const SHOOT_ACTIONS := ["shoot_up", "shoot_down", "shoot_left", "shoot_right"] #Directions used for shooting input
#endregion

var shooting_queue = []
var last_input_device:String = "keyboard"

# Emitted every physics frame with the player's movement direction.
signal direction_calculated(direction:Vector2)

# Emitted when the player fires. Parameter is shot direction
signal shoot(direction:Vector2)

func _ready():
	assert(my_character, "PlayerInputController has no character assigned!")

# Detects which input device is currently being used.
func _input(event):
	if event is InputEventKey:
		last_input_device = "keyboard"
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		last_input_device = "joystick"

func _process(delta):
	if(last_input_device == "keyboard"):
		check_kb_shoot_input()
	elif(last_input_device == "joystick"):
		check_js_shoot_input()
	check_shoot()
	#DEBUG
	#Pressing the speed action adds or removes a movement speed modifier, representing the player when speed capped
	if(Input.is_action_just_pressed("speed") and my_character.movement_handler):
		if(my_character.movement_handler.max_speed_mods.has("Debug")):
			my_character.movement_handler.max_speed_mods.erase("Debug")
		else:
			my_character.movement_handler.max_speed_mods["Debug"] = DEBUG_SPEED
	#ENDDEBUG

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	direction.x = direction.x if abs(direction.x) >= Constants.CONTROLLER_DEADZONE else 0
	direction.y = direction.y if abs(direction.y) >= Constants.CONTROLLER_DEADZONE else 0
	direction_calculated.emit(direction)

#Updates the shooting queue based on keyboard inputs
func check_kb_shoot_input():
	for action in SHOOT_ACTIONS:
		if(Input.is_action_just_pressed(action)):
			shooting_queue.erase(action)
			shooting_queue.push_front(action)
		elif !Input.is_action_pressed(action):
			shooting_queue.erase(action)

#Updates the shooting queue based on joystick input
func check_js_shoot_input():
	shooting_queue.clear()
	var vector = Input.get_vector("shoot_left", "shoot_right","shoot_up","shoot_down")
	if abs(vector.x) > abs(vector.y):
		if vector.x >0:
			shooting_queue.push_front("shoot_right")
		else: 
			shooting_queue.push_front("shoot_left")
	elif abs(vector.y) > abs(vector.x):
		if vector.y > 0:
			shooting_queue.push_front("shoot_down") 
		else: shooting_queue.push_front("shoot_up")

#Emits the shoot signal using the queued direction.
func check_shoot():
	if shooting_queue.is_empty():
		shoot.emit(Vector2.ZERO)
	else:
		var shot_direction
		match shooting_queue[0]:
			"shoot_up":
				shot_direction = Vector2.UP
			"shoot_down":
				shot_direction = Vector2.DOWN
			"shoot_left":
				shot_direction = Vector2.LEFT
			"shoot_right":
				shot_direction = Vector2.RIGHT
			_:
				push_error("SOMETHING WEIRD IN PLAYER SHOOTING_QUEUE[0]! " + str(shooting_queue[0]) + " found!")
		shoot.emit(shot_direction)
