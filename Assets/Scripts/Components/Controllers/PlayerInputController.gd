#This script is a signal bus for all player input.
class_name PlayerInputController extends Node

@export var myCharacter:BaseCharacter
var horizontal_direction:float
var vertical_direction:float

signal direction_calculated(hDir:float, vDir:float)

func _ready():
	if(myCharacter.movement_handler):
		direction_calculated.connect(myCharacter.movement_handler._on_direction_calculated)
	else:
		pass

func _physics_process(delta):
	horizontal_direction = Input.get_axis("move_left","move_right")
	vertical_direction = Input.get_axis("move_up","move_down")
	direction_calculated.emit(horizontal_direction,vertical_direction)
