class_name RandomMovementAI extends EnemyMovementAI

var direction_change_timer:Timer
@export var direction_change_frequency:float = 1.5

func _ready():
	super()
	direction_change_timer = Timer.new()
	direction_change_timer.wait_time = direction_change_frequency
	direction_change_timer.one_shot = false
	direction_change_timer.timeout.connect(get_direction)
	add_child(direction_change_timer)
	await get_direction()
	direction_change_timer.start()

func _process(delta):
	if(my_character.is_on_floor() or my_character.is_on_ceiling() or my_character.is_on_wall()):
		get_direction()

func get_direction():
	direction_calculated.emit(Vector2.from_angle(randf() * 2.0 * PI))
