extends Label

var kill_count := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	TestDebugMenu.challenge_enabled.connect(_on_challenge_on)
	TestDebugMenu.challenge_disabled.connect(_on_challenge_off)
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_enemy_death():
	kill_count += 1
	text = str(kill_count)

func _on_challenge_on():
	GameManager.enemy_killed.connect(_on_enemy_death)
	kill_count = 0
	text = str(0)
	visible = true
	
func _on_challenge_off():
	GameManager.enemy_killed.disconnect(_on_enemy_death)
	visible = false
