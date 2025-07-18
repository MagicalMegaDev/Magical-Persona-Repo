class_name MovementHandler extends Node

#region constants
#endregion

#current velocity vector
var momentum := Vector2(0.0,0.0)

#modifiers
var max_speed_mods := {}
var acceleration_mods := {}
var friction_mods := {}

#scales, used for room and global effects that are meant to apply to everything it can.
var base_speed_scale := 1.0
var base_acceleration_scale := 1.0
var base_friction_scale := 1.0

var raw_direction := Vector2.ZERO #Input Direction before deadzone filtering
var direction := Vector2.ZERO #normalized direction for movement with deadzone applied
var last_input_direction := Vector2.ZERO #Last non-zero input direction
var speed := 0.0 #Current speed magnitude
var knockback_velocity := Vector2.ZERO
var knockback_friction:float
var can_move := true #Determines if movement is allowed

var my_character:BaseCharacter #Owning Character
var my_stats:CharacterStats #Character's stats component

#Emitted every physics frame with the calculated movement velocity
signal velocity_calculated(sentVelocity:Vector2)
#Emitted when Knockback Velocity has decayed to nearly zero
signal knockback_finished

func _ready():
	assert(my_character, "%s MovementHandler lacks a Character Reference!" % get_parent().name)
	assert(my_stats, "%s MovementHandler lacks a stats reference!" % get_parent().name)
	velocity_calculated.connect(my_character._on_velocity_calculated)

func _physics_process(delta):
	# Use a slightly higher threshold than Godot's deadzone to prevent drift
	if(raw_direction.length() > Constants.CONTROLLER_DEADZONE):
		direction = raw_direction.normalized()
		last_input_direction = direction
	else:
		direction = Vector2.ZERO
	if(direction != Vector2.ZERO):
		last_input_direction = direction
	momentum = calculate_speed(delta)
	momentum += knockback_velocity
	if(knockback_velocity.length() > 0):
		knockback_friction = my_stats.base_friction/2
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_friction * delta)
		if(knockback_velocity.length() < 0.5):
			knockback_finished.emit()
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
func calculate_speed(delta:float):
	var max_speed = GameManager.apply_modifiers(my_stats.base_max_speed, max_speed_mods, name)
	var acceleration = GameManager.apply_modifiers(my_stats.base_acceleration, acceleration_mods, name)
	var friction = GameManager.apply_modifiers(my_stats.base_friction, friction_mods, name)
	
	if(!can_move):
		if(speed > 0):
			speed = move_toward(speed, 0, friction * delta)
			return speed * last_input_direction
		else:
			return Vector2.ZERO
			
	if(direction != Vector2.ZERO):
		speed = move_toward(speed, max_speed, acceleration * delta)
		return speed * direction
	else: 
		if(speed > 0):
			speed = move_toward(speed, 0, friction * delta)
			return speed * last_input_direction
		else:
			return Vector2.ZERO

#Signal reciever, adds an impulse to the knockback velocity.
func _on_knockback(impulse:Vector2):
	knockback_velocity += impulse
