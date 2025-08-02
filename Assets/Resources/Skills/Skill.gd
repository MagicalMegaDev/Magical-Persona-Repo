class_name Skill
extends Resource

@export var verbs: Array[SkillVerb] = [] #List of verbs for the Skill to execute on use.
@export var cooldown_time :float = 0.0 #how long between skill uses.
@export var requires_target: bool = false #Does this require a target
@export var target_groups:Array[String] = [] #Which groups can this hit?

func execute(source: Node, targets: Array[Node], context: Dictionary = {}) -> void:
	for verb in verbs:
		if verb and verb.can_execute(source, targets, context):
			verb.execute(source, targets, context)
