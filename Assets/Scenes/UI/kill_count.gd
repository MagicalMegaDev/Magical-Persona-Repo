extends Label

var kill_count := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.enemy_killed.connect(_on_enemy_death)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_enemy_death():
	print("Death!")
	kill_count += 1
	text = str(kill_count)
