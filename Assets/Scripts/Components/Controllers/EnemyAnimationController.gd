#DEBUG CLASS TO GIVE BASIC DAMAGE ANIMATION FOR PROTOTYPE FEEDBACK
class_name EnemyAnimationController extends AnimationPlayer

const DAMAGE_ANIM := "hurt" #Name of damage animation

func _on_take_damage():
	print("Ouchie")
	if(has_animation(DAMAGE_ANIM)):
		play(DAMAGE_ANIM)
