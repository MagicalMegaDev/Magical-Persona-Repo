class_name RandomMovementAI extends EnemyMovementAI

var direction := Vector2.ZERO
var direction_change_timer:Timer
@export var direction_change_frequency_min:float = 0.5
@export var direction_change_frequency_max:float = 1.5

func _ready():
	direction_change_timer = Timer.new()
	direction_change_timer.wait_time = randf_range(direction_change_frequency_min, direction_change_frequency_max)
	direction_change_timer.one_shot = true
	direction_change_timer.timeout.connect(set_direction)
	add_child(direction_change_timer)

func pause():
	print("Pause")
	direction = Vector2.ZERO
	direction_change_timer.stop()
	direction_change_timer.wait_time = randf_range(direction_change_frequency_min, direction_change_frequency_max)

func resume():
	print("Resume")
	set_direction()
	direction_change_timer.start()
	
#set_direction()
#Generate a random direction and emit it to be moved
func set_direction():
	print("Setting")
	direction = Vector2.from_angle(randf() * 2.0 * PI)
	direction_change_timer.wait_time = randf_range(direction_change_frequency_min, direction_change_frequency_max)

func get_direction() -> Vector2:
	return direction
	if(direction_change_timer.is_stopped()):
		print("Starting Timer")
		direction_change_timer.start()
	
#reverse_direction()
#Move in the opposite of the current direction
func reverse_direction():
	direction = -direction
	direction_calculated.emit(direction)
	direction_change_timer.start()

func _on_enemy_nearby(area):
	reverse_direction()
