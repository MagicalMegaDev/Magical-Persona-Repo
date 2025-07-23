#Generic container for all pickups
class_name Pickup
extends HitBox

signal try_pickup(me:Pickup)

func _ready():
	collections_in_area.connect(_on_overlap)
	try_pickup.connect(SignalBus._on_item_pickup)

func _on_overlap(bodies:Array, areas: Array, pos:Vector2):
	try_pickup.emit(self)

func _on_pickup_attemped(picked_up:bool):
	if picked_up:
		queue_free()
