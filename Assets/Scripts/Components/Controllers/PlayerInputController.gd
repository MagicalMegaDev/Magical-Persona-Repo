#This script is a signal bus for all player input.
class_name PlayerInputController extends Node

@export var myCharacter:BaseCharacter

var shooting_queue = []

signal direction_calculated(hDir:float, vDir:float)
signal shoot(direction:Vector2)

func _ready():
	if(myCharacter.movement_handler):
		direction_calculated.connect(myCharacter.movement_handler._on_direction_calculated)
	if(myCharacter.gun):
		shoot.connect(myCharacter.gun._on_shoot)
		
func _process(delta):
	if(Input.is_action_pressed("shoot_down")):
		shoot.emit(Vector2.DOWN)

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	direction.x = direction.x if abs(direction.x) >= 0.2 else 0
	direction.y = direction.y if abs(direction.y) >= 0.2 else 0
	direction_calculated.emit(direction)
