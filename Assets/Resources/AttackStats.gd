# AttackStats.gd
# Describes base data shared by any attack

class_name AttackStats 
extends Resource

@export var damage := 1 #Amount of health removed when the attack hits.
@export var knockback_enabled := true #Whether this attack applies knockback
@export var knockback_force := 50 #Knockback Strength applied to the target
@export var effects:Dictionary[String, bool] = {} #{Name, True/False} Name will be replaced with an effect resource once I have those.
