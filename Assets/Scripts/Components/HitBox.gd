class_name HitBox extends Area2D

var bodies_inside:Array = []
var areas_inside:Array = []

signal collections_in_area(bodies:Array, areas:Array)

func _process(delta):
	if(!bodies_inside.is_empty() or !areas_inside.is_empty()):
		collections_in_area.emit(bodies_inside, areas_inside)
		
func _on_body_enter(body):
	bodies_inside.append(body)

func _on_area_enter(area):
	areas_inside.append(area)

func _on_body_exit(body):
	if(bodies_inside.has(body)):
		bodies_inside.erase(body)
		
func _on_area_exit(area):
	if(areas_inside.has(area)):
		areas_inside.erase(area)
