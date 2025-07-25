#Generic container for all pickups
class_name Pickup
extends HitBox

@onready var my_sprite :Sprite2D = $Sprite2D
@export var base_pickup_effects:Array[PickupEffect] #Add resources in inspector
var pickup_effects:Array[PickupEffect]

signal try_pickup(me:Pickup)

func _ready():
	collision_layer = 0
	set_collision_layer_value(12, true)
	collision_mask = 0
	set_collision_mask_value(4, true)
	body_entered.connect(_on_body_entered)
	try_pickup.connect(SignalBus._on_item_pickup)
	for effect in base_pickup_effects:
		pickup_effects.append(effect.duplicate)
	for effect in pickup_effects:
		for property in effect.get_property_list():
			if property.name == "my_sprite":
				effect.my_sprite = my_sprite
				break
		effect._setup()

func _on_body_entered(body:Node):
	if(body.is_in_group("Players")):
		try_pickup.emit(self)
		
func _on_pickup_attemped(picked_up:bool):
	if picked_up:
		queue_free()
