class_name BaseBullet extends Area2D

var direction = Vector2.ZERO
#region stats
@export var base_speed:int = 100
var speed:int = 0
#endregion

#region Multipliers
var speed_mods = {}
#endregion

#region effects
#endregion

#movement behavior goes here.


var status_effects = {} #Dictionary of potential status effects to inflict

func _process(delta):
	speed = GameManager.add_mods(base_speed, speed_mods)
	
func on_hit():
	pass

func on_despawn():
	pass
