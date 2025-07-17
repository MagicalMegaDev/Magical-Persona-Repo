class_name BaseEnemy extends BaseCharacter

#This script will store any non-component based info or signals shared across all enemies.

signal died(BaseEnemy)

func _ready():
	super()
	self.add_to_group("Enemies")
	died.connect(GameManager._on_any_enemy_death)

func _on_death():
	died.emit(self)
