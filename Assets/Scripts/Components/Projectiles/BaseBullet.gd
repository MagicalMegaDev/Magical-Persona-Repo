class_name BaseBullet extends Area2D

var direction = Vector2.ZERO
#region stats
@export var base_speed:int = 700
var speed:int = 0
#endregion

#region Multipliers
var speed_mods = {}
#endregion

#region effects
#endregion

@export var movement_behavior:BulletMovementBehavior

var status_effects = {} #Dictionary of potential status effects to inflict

func _ready():
	movement_behavior = movement_behavior.duplicate()
	movement_behavior.my_bullet = self

func _process(delta):
	speed = GameManager.add_mods(base_speed, speed_mods)
	
func on_hit():
	pass

func on_despawn():
	pass


func _on_body_entered(body):
	queue_free()
