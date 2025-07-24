#Generic container for all pickups
class_name Pickup
extends HitBox

signal try_pickup(me:Pickup)

func _ready():
	body_entered.connect(_on_body_entered)
	try_pickup.connect(SignalBus._on_item_pickup)

func _on_body_entered(body:Node):
	if(body.is_in_group("Players")):
		try_pickup.emit(self)
		
func _on_pickup_attemped(picked_up:bool):
	if picked_up:
		queue_free()
