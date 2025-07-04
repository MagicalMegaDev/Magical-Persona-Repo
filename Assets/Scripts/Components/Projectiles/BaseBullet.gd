class_name BaseBullet extends Area2D

var direction = Vector2.ZERO
#region stats
@export var base_speed:int = 700
var speed:int = 0
@export var base_damage:float = 1
var damage:float = 0
#endregion

#region Multipliers
var speed_mods = {}
var damage_mods = {}
#endregion

#region effects
#endregion

@export var movement_behavior:BulletMovementBehavior

var status_effects = {} #Dictionary of potential status effects to inflict

func _ready():
	movement_behavior = movement_behavior.duplicate()
	movement_behavior.my_bullet = self
	speed = GameManager.add_mods(base_speed, speed_mods)
	damage = GameManager.add_mods(base_damage, damage_mods)

func _process(delta):
	pass

func on_hit():
	pass

func on_despawn():
	pass


func _on_body_entered(body):
	if(body is BaseCharacter):
		body._on_take_damage(damage)
	queue_free()
