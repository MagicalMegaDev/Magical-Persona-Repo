#Component for Hitboxes
#Emits 'collections_in_area' every frame while any body or area overlaps

class_name HitBox 
extends Area2D

signal collections_in_area(bodies:Array, areas:Array, position:Vector2)

func _process(delta):
	#emit all overlapping bodies or areas
	if(get_overlapping_bodies() or get_overlapping_areas()):
		collections_in_area.emit(get_overlapping_bodies(), get_overlapping_areas(), global_position)
