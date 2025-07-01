class_name PlayerController extends BaseCharacter

#This script will store any non-component based info or signals shared across all playable characters.
#Nothing is here yet.

func _ready():
	super()
	self.add_to_group("Players")
