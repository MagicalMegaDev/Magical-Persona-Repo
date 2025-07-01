class_name MovementHandler extends Node

#region enums
#Direction Enums
enum HorizontalDirection{
	LEFT = -1,
	STILL = 0,
	RIGHT = 1
}

enum VerticalDirection{
	UP = -1,
	STILL = 0,
	DOWN = 1
}
#endregion

#Baselines
@export_group("Movement Variables")
@export var base_max_speed = 200.0
@export var base_acceleration = 50.0
@export var base_friction = 50.0

var momentum = Vector2(0.0,0.0)

#mods
var max_speed_mods = {}
var acceleration_mods = {}
var friction_mods = {}

#scales
var base_speed_scale = 1.0
var base_acceleration_scale = 1.0
var base_friction_scale = 1.0

var horizontal_direction = HorizontalDirection.STILL
var vertical_direction = VerticalDirection.STILL
var direction = Vector2.ZERO
var last_input_direction = Vector2.ZERO
var speed = 0.0
var can_move:bool = true

signal velocity_calculated(sentVelocity:Vector2) #Signal to be attached to the character controller _on_velocity_calculated for Move_and_Slide()

func _physics_process(delta):
	direction = Vector2(horizontal_direction, vertical_direction).normalized()
	if(direction != Vector2.ZERO):
		last_input_direction = direction
	momentum = calculateSpeed(delta)
	if(can_move):
		velocity_calculated.emit(momentum)

#_on_direction_calculated(hDir,vDir)
#hDir = Horizontal Direction passed in
#vDir = Vertical Direction passed in
#This is a signal reciever to take in input from any controller to assign direction, however that controller wants to handle it.
func _on_direction_calculated(hDir,vDir):
	horizontal_direction = hDir
	vertical_direction = vDir

#calculateSpeed(delta)
#Applies all mods to all speed related variables, and then either accelerates or deaccelerates the character in the chosen direction based on input recieved.
func calculateSpeed(delta):
	var max_speed = GameManager.add_mods(base_max_speed, max_speed_mods)
	var acceleration = GameManager.add_mods(base_acceleration, acceleration_mods)
	var friction = GameManager.add_mods(base_friction, friction_mods)
	
	if(direction != Vector2.ZERO):
		speed = move_toward(speed, max_speed, acceleration * delta)
		return speed * direction
	else: 
		if(abs(speed) > 0):
			speed = move_toward(speed, 0, friction * delta)
			return speed * last_input_direction
		else:
			return Vector2.ZERO
