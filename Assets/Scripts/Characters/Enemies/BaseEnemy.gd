class_name BaseEnemy extends BaseCharacter

#This script will store any non-component based info or signals shared across all enemies.

@export var movement_ai:EnemyMovementAI

func _enter_tree():
	super()
	if(movement_ai):
		movement_ai.my_character = self

func _ready():
	self.add_to_group("Enemies")
