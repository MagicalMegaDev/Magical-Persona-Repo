class_name PlayerController extends BaseCharacter

#This script will store any non-component based info or signals shared across all playable characters.

signal health_picked_up(heal_value:int) #Signal emitted when health is picked up

@export var secondary_skill:Skill

func _ready():
	super()
	self.add_to_group("Players")
	connect_signals()
	initialize_skills()

#helper function to initialize all skills(Mostly to set up cooldown timers
func initialize_skills():
	for prop in get_property_list():
		var skill = get(prop.name)
		if skill is Skill:
			skill.init(self)
			if(skill.cooldown_timer):
				add_child(skill.cooldown_timer)
	
	
#helper function to connect needed signals and keep _ready clean
func connect_signals():
	# Set up Recievers
	SignalBus.player_picked_up_item.connect(_on_item_pickup) 
	
	# Set up Connectors
	assert(health_handler, "PlayerController: Player has no health handler attached!")
	health_picked_up.connect(health_handler.heal_damage)
	
func _on_item_pickup(pickup:Pickup):
	var picked_up := false #Was the Pickup picked up?
	for effect in pickup.pickup_effects:
		if(effect.qualifier.call(health_handler)):
			effect.action.call(health_handler)
			picked_up = true
	pickup._on_pickup_attemped(picked_up)
