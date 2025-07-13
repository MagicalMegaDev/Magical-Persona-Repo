class_name HealthBar extends GridContainer

const HEART_VALUE := 2 #The amount a single heart is worth. Hearts have two states: Full and Half, so they are worth two hitpoints.
var max_containers = 10 #The max number of heart containers the player can have. Each Container is representitive of two health.

var hearts: Array[Node] = []

func _ready():
	print("HealthBar.gd: ready")
	hearts = get_children()
	SignalBus.player_health_changed.connect(_on_player_health_changed)

#_on_player_health_changed
#signal reciever for when the player's health has been changed in any way.
#Value: The current value of the players health.
#max_health: The players max_health, to tell how many heart containers to draw.
func _on_player_health_changed(value:int, max_health:int):
	#First, get the amount of containers to be drawn, and draw them all in an empty state
	var container_count := int(ceil(max_health/HEART_VALUE))
	
	for i in range(hearts.size()):
		var heart = hearts[i]
		heart.visible = i < container_count
	
	#Second, iterate through the visible hearts, and subtract from the value to fill them until value == 0
	var remaining := value
	for i in range(container_count):
		var heart = hearts[i]
		var state := 0
		if remaining >= 2: #If there is at least one full heart remaining, set the container to full
			state = 2
			remaining -= 2
		elif remaining == 1:
			state = 1
			remaining -= 1
		assert(heart is HeartContainer, "Player Health Bar trying to set a node that isn't a heart container! Check HealthBar.gd")
		heart.set_state(state)
