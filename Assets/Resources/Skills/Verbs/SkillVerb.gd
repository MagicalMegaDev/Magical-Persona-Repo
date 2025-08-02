class_name SkillVerb
extends Resource

func execute(source: Node, targets: Array[Node], context: Dictionary = {}) -> void:
	push_warning("Verb.execute() not implemented in " + self.name)
	
func can_execute(source: Node, targets: Array[Node], context: Dictionary = {}) -> bool:
	return true
