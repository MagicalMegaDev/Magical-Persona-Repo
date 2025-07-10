class_name BaseEnemy extends BaseCharacter

#This script will store any non-component based info or signals shared across all enemies.

signal died(BaseEnemy)

func _ready():
	self.add_to_group("Enemies")

func _on_death():
	died.emit(self)
