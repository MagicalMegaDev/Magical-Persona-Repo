#RandomMovementAI.gd
#Basic Enemy Pathing that randomly changes direction after a delay.
class_name RandomMovementAI 
extends EnemyMovementAI

# Current movement direction for the enemy.
var direction := Vector2.ZERO

# Timer controlling how often the enemy picks a new direction
var direction_change_timer:Timer

# Minimum and maximum seconds between direction changes.
@export var direction_change_frequency_min:float = 0.5
@export var direction_change_frequency_max:float = 1.5

#Initialize the timer used for andom movement.
func _ready():
	direction_change_timer = Timer.new()
	direction_change_timer.wait_time = randf_range(direction_change_frequency_min, direction_change_frequency_max)
	direction_change_timer.one_shot = true
	direction_change_timer.timeout.connect(set_direction)
	add_child(direction_change_timer)

# Reset state while this AI is inactive.
func pause():
	direction = Vector2.ZERO
	direction_change_timer.stop()
	direction_change_timer.wait_time = randf_range(direction_change_frequency_min, direction_change_frequency_max)

# Resumes movement when the state is reactivated
func resume():
	set_direction()
	direction_change_timer.start()
	

# Generate a random movement direction for the enemy
func set_direction():
	direction = Vector2.from_angle(randf() * 2.0 * PI)
	direction_change_timer.wait_time = randf_range(direction_change_frequency_min, direction_change_frequency_max)

# Returns the current movement direction, recalculating if stuck
func get_direction() -> Vector2:
	if(!my_character):
		push_warning("RandomMovementAI: my_character is null")
		return Vector2.ZERO

	if(my_character.is_on_ceiling() or my_character.is_on_wall() or my_character.is_on_floor()):
		set_direction()
		direction_change_timer.stop()
		
	if(direction_change_timer.is_stopped()):
		direction_change_timer.start()
	return direction

	

# Reverses the current direction
func reverse_direction():
	direction = -direction
	direction_change_timer.start()

# Called when another enemy enters the detection area.
func _on_enemy_nearby(area):
	reverse_direction()
