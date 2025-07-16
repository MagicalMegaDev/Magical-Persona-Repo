extends HBoxContainer

@onready var variable_name := $"Variable Name"
@export var my_name:String
@onready var variable_value := $"Variable Value"
@export var my_value:String

func _ready():
	variable_name.name = my_name
	variable_value.text = my_value
