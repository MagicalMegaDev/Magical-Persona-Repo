class_name HealVerb
extends SkillVerb

@export var heal_value:int = 1

func execute(source: Node, targets: Array[Node], context: Dictionary = {}) -> void:
	for target in targets:
		if target is HealthHandler:
			target.heal_damage(heal_value)
	
func can_execute(source: Node, targets: Array[Node], context: Dictionary = {}) -> bool:
	return true
