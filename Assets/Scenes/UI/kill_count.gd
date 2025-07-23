extends Label

var kill_count := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	TestDebugMenu.challenge_enabled.connect(_on_challenge_on)
	TestDebugMenu.challenge_disabled.connect(_on_challenge_off)
	visible = false

func _on_enemy_death():
	kill_count += 1
	text = str(kill_count)

# Start tracking kills and show the counter when challenge mode is on
func _on_challenge_on():
	GameManager.enemy_killed.connect(_on_enemy_death)
	kill_count = 0
	text = str(0)
	visible = true
	
# Stop tracking kills and show the counter when challenge mode is off
func _on_challenge_off():
	GameManager.enemy_killed.disconnect(_on_enemy_death)
	visible = false
