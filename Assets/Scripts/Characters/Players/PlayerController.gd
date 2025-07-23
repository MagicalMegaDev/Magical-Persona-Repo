class_name PlayerController extends BaseCharacter

#This script will store any non-component based info or signals shared across all playable characters.

signal health_picked_up(heal_value:int) #Signal emitted when health is picked up

func _ready():
	super()
	self.add_to_group("Players")
	connect_signals()


#helper function to connect needed signals and keep _ready clean
func connect_signals():
	# Set up Recievers
	SignalBus.player_picked_up_item.connect(_on_item_pickup) 
	
	# Set up Connectors
	assert(health_handler, "PlayerController: Player has no health handler attached!")
	health_picked_up.connect(health_handler.heal_damage)
	
func _on_item_pickup(pickup:Pickup):
	var picked_up := false #Was the Pickup picked up?
	match pickup:
		HealthPickup:
			if(health_handler.current_health < health_handler.max_health):
				health_picked_up.emit(pickup.heal_value)
				picked_up = true
		_:
			push_error("Player picked up Pickup of unknown type!")
	pickup._on_pickup_attemped(picked_up)
