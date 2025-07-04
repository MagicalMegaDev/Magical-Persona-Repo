#This script is a signal bus for all player input.
class_name PlayerInputController extends Node

@export var myCharacter:BaseCharacter

var shooting_queue = []
var last_input_device:String = "keyboard"

signal direction_calculated(direction:Vector2)
signal shoot(direction:Vector2)

func _ready():
	if(myCharacter.movement_handler):
		direction_calculated.connect(myCharacter.movement_handler._on_direction_calculated)
	if(myCharacter.gun):
		shoot.connect(myCharacter.gun._on_shoot)

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
	if(Input.is_action_just_pressed("speed")):
		if(myCharacter.movement_handler.max_speed_mods.has("Debug")):
			myCharacter.movement_handler.max_speed_mods.erase("Debug")
		else:
			myCharacter.movement_handler.max_speed_mods["Debug"] = 2

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	direction.x = direction.x if abs(direction.x) >= 0.2 else 0
	direction.y = direction.y if abs(direction.y) >= 0.2 else 0
	direction_calculated.emit(direction)

func check_kb_shoot_input():
	if(Input.is_action_just_pressed("shoot_up")):
		shooting_queue.erase("shoot_up")
		shooting_queue.push_front("shoot_up")
	if(Input.is_action_just_pressed("shoot_down")):
		shooting_queue.erase("shoot_down")
		shooting_queue.push_front("shoot_down")
	if(Input.is_action_just_pressed("shoot_left")):
		shooting_queue.erase("shoot_left")
		shooting_queue.push_front("shoot_left")
	if(Input.is_action_just_pressed("shoot_right")):
		shooting_queue.erase("shoot_right")
		shooting_queue.push_front("shoot_right")
	
	if(!Input.is_action_pressed("shoot_up")):
		shooting_queue.erase("shoot_up")
	if(!Input.is_action_pressed("shoot_down")):
		shooting_queue.erase("shoot_down")
	if(!Input.is_action_pressed("shoot_left")):
		shooting_queue.erase("shoot_left")
	if(!Input.is_action_pressed("shoot_right")):
		shooting_queue.erase("shoot_right")

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

func check_shoot():
	if shooting_queue.is_empty():
		pass
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
