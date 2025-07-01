class_name EnemyController extends BaseCharacter

#This script will store any non-component based info or signals shared across all enemies.
#Nothing is here yet.

func _ready():
	self.add_to_group("Enemies")
