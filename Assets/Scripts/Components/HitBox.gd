#Component for Hitboxes
#Emits 'collections_in_area' every frame while any body or area overlaps

class_name HitBox 
extends Area2D

#Submits the collection of bodies and the collection of areas
signal collections_in_area(bodies:Array, areas:Array, position:Vector2)

func _process(delta):
	#emit all overlapping bodies or areas
	var bodies := get_overlapping_bodies()
	var areas := get_overlapping_areas()
	if(bodies or areas):
		collections_in_area.emit(bodies, areas, global_position)
