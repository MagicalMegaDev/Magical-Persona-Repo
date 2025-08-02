class_name Skill
extends Resource

@export var verbs: Array[SkillVerb] = [] #List of verbs for the Skill to execute on use.
@export var cooldown_time :float = 0.0 #how long between skill uses.
@export var requires_target: bool = false #Does this require a target
@export var target_groups:Array[String] = [] #Which groups can this hit?

var cooldown_timer:Timer

func init(parent: Node):
	if cooldown_time != 0.0:
		cooldown_timer = Timer.new()
		cooldown_timer.wait_time = cooldown_time
		cooldown_timer.timeout.connect(_on_cooldown_timeout)
		cooldown_timer.one_shot = true


func execute(source: Node, targets: Array[Node], context: Dictionary = {}) -> void:
	if(cooldown_timer and !cooldown_timer.is_stopped()):
		return
	for verb in verbs:
		if verb and verb.can_execute(source, targets, context):
			verb.execute(source, targets, context)
	if cooldown_timer:
		cooldown_timer.start()

func _on_cooldown_timeout():
	pass
