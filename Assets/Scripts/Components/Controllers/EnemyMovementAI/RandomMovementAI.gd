class_name RandomMovementAI extends EnemyMovementAI

var direction := Vector2.ZERO
var direction_change_timer:Timer
@export var direction_change_frequency_min:float = 0.5
@export var direction_change_frequency_max:float = 1.5

func _ready():
	super()
	direction_change_timer = Timer.new()
	direction_change_timer.wait_time = randf_range(direction_change_frequency_min, direction_change_frequency_max)
	direction_change_timer.one_shot = false
	direction_change_timer.timeout.connect(get_direction)
	add_child(direction_change_timer)
	get_direction()
	direction_change_timer.start()

func _process(delta):
	if(my_character.is_on_floor() or my_character.is_on_ceiling() or my_character.is_on_wall()):
		reverse_direction()

#get_direction()
#Generate a random direction and emit it to be moved
func get_direction():
	direction = Vector2.from_angle(randf() * 2.0 * PI)
	direction_calculated.emit(direction)
	direction_change_timer.wait_time = randf_range(direction_change_frequency_min, direction_change_frequency_max)

#reverse_direction()
#Move in the opposite of the current direction
func reverse_direction():
	direction = -direction
	direction_calculated.emit(direction)
	direction_change_timer.start()

func _on_enemy_nearby(area):
	reverse_direction()
