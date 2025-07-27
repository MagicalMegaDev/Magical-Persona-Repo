extends Node

func set_multiple_collision_layers(collider:CollisionObject2D, layers:Array[int], toggle:bool = true, reset:bool = false):
	if(reset):
		collider.collision_layer = 0
	for i in layers:
		collider.set_collision_layer_value(i, toggle)

func set_multiple_collision_masks(collider:CollisionObject2D, masks:Array[int], toggle:bool = true, reset:bool = false):
	if(reset):
		collider.collision_mask = 0
	for i in masks:
		collider.set_collision_mask_value(i, toggle)
