class_name MovementHandler extends Node

#region constants
const CONTROLLER_DEADZONE = 0.3
#endregion

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
#All Default Values are placeholders
@export var base_max_speed := 200.0
@export var base_acceleration := 50.0
@export var base_friction := 50.0

var momentum = Vector2(0.0,0.0)

#mods
var max_speed_mods = {}
var acceleration_mods = {}
var friction_mods = {}

#scales
var base_speed_scale = 1.0
var base_acceleration_scale = 1.0
var base_friction_scale = 1.0

var raw_direction := Vector2.ZERO
var direction := Vector2.ZERO
var last_input_direction := Vector2.ZERO
var speed = 0.0
var knockback_velocity := Vector2.ZERO
var can_move:bool = true

var myCharacter:BaseCharacter

signal velocity_calculated(sentVelocity:Vector2) #Signal to be attached to the character controller _on_velocity_calculated for Move_and_Slide()

func _receive_stats(stats:CharacterStats):
	base_max_speed = stats.base_max_speed
	base_acceleration = stats.base_acceleration
	base_friction = stats.base_friction

func _ready():
	velocity_calculated.connect(myCharacter._on_velocity_calculated)

func _process(delta):
	pass

func _physics_process(delta):
	# Use a slightly higher threshold than Godot's deadzone to prevent drift
	if(raw_direction.length() > CONTROLLER_DEADZONE):
		direction = raw_direction.normalized()
		last_input_direction = direction
	else:
		direction = Vector2.ZERO
	if(direction != Vector2.ZERO):
		last_input_direction = direction
	momentum = calculate_speed(delta)
	momentum += knockback_velocity
	if(knockback_velocity.length() > 0):
		var friction = GameManager.add_mods(base_friction, friction_mods)
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, friction * delta)
	if(can_move):
		velocity_calculated.emit(momentum)

#_on_direction_calculated(hDir,vDir)
#hDir = Horizontal Direction passed in
#vDir = Vertical Direction passed in
#This is a signal reciever to take in input from any controller to assign direction, however that controller wants to handle it.
func _on_direction_calculated(new_direction:Vector2):
	raw_direction = new_direction

#calculate_speed(delta)
#Applies all mods to all speed related variables, and then either accelerates or deaccelerates the character in the chosen direction based on input recieved.
func calculate_speed(delta):
	var max_speed = GameManager.add_mods(base_max_speed, max_speed_mods)
	var acceleration = GameManager.add_mods(base_acceleration, acceleration_mods)
	var friction = GameManager.add_mods(base_friction, friction_mods)
	
	if(direction != Vector2.ZERO):
		speed = move_toward(speed, max_speed, acceleration * delta)
		return speed * direction
	else: 
		if(speed > 0):
			speed = move_toward(speed, 0, friction * delta)
			return speed * last_input_direction
		else:
			return Vector2.ZERO

func _on_knockback(impulse:Vector2):
	knockback_velocity += impulse
