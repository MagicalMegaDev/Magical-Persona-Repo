# ProjectileAttackStats.gd
# Data definition for projectile-based attacks. Extends AttackStats to include 
# additional projectile-specific properties.

class_name ProjectileAttackStats
extends AttackStats

@export var speed := 200 #Movement Speed of the projectile.
