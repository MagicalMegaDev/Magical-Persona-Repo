class_name PickupDropHandler
extends Node

@export var drop_chance:float = 0.25
@export var drop_table:Dictionary = {}

@export var slide_time:float = 0.25
@export var slide_factor:float = 1.0

var my_character:BaseCharacter

func _ready():
    my_character = get_parent() as BaseCharacter
    if my_character and my_character.health_handler:
        my_character.health_handler.died.connect(_on_owner_died)

func _on_owner_died():
    if randf() <= drop_chance:
        var scene:PackedScene = _select_drop()
        if scene:
            var pickup = scene.instantiate()
            get_tree().current_scene.add_child(pickup)
            pickup.global_position = my_character.global_position
            _apply_momentum(pickup)

func _select_drop() -> PackedScene:
    var total := 0.0
    for chance in drop_table.values():
        total += float(chance)
    if total <= 0:
        return null
    var roll := randf() * total
    var accum := 0.0
    for scene in drop_table.keys():
        accum += float(drop_table[scene])
        if roll <= accum:
            return scene
    return null

func _apply_momentum(pickup:Node):
    if my_character.movement_handler:
        var vel:Vector2 = my_character.movement_handler.momentum * slide_factor
        if vel != Vector2.ZERO:
            var tween = pickup.create_tween()
            tween.tween_property(pickup, "global_position", pickup.global_position + vel * slide_time, slide_time)

