#Generic container for all pickups
class_name Pickup
extends Node

@onready var hit_box:HitBox = get_parent()
@onready var my_sprite :Sprite2D = get_parent().get_node("Sprite2D")

signal try_pickup(me:Pickup)

func _ready():
	hit_box.collision_layer = 0
	hit_box.set_collision_layer_value(12, true)
	hit_box.collision_mask = 0
	hit_box.set_collision_mask_value(4, true)
	hit_box.body_entered.connect(_on_body_entered)
	try_pickup.connect(SignalBus._on_item_pickup)

func _on_body_entered(body:Node):
	if(body.is_in_group("Players")):
		try_pickup.emit(self)
		
func _on_pickup_attemped(picked_up:bool):
	if picked_up:
		queue_free()
