#Controller to calculate and distribute knockback to Nodes
class_name KnockbackController 
extends Node2D

var weight := 50 #Weight of the owning character. Equates to knockback resistance
var pending_knockback := false #True when knockback should be applied once i-frames end.
var knockback_allowed := true #Controls whether the character is currently allowed to be knocked back
var i_frames := false #True if the character currently has i-frames

var knockback_timer:Timer #Timer to enforce a minimum delay between knockbacks
var knockback_wait_time := 0.1 #Timer length in seconds

signal apply_knockback(knockback : Vector2)

func _ready():
	knockback_timer = Timer.new()
	knockback_timer.one_shot = true
	knockback_timer.autostart = false
	knockback_timer.wait_time = knockback_wait_time
	knockback_timer.timeout.connect(_on_knockback_disabled)
	add_child(knockback_timer)
	
func _process(delta):
	#if a knockback is pending, apply it.
	if(pending_knockback and !i_frames):
		knockback_allowed = true
		pending_knockback = false

func _receive_stats(stats:CharacterStats):
	assert(stats.weight > 0, "Knockback Controller: %s weight must be positive" % get_parent().name)
	weight = stats.weight 
	
func calculate_knockback(stats:AttackStats, attacker_position:Vector2):
	#Apply knockback if permitted and the incoming attack supports it.
	if(knockback_allowed and stats.knockback_enabled):
		var ratio = stats.knockback_force/weight
		var delta = get_physics_process_delta_time()
		var direction = (global_position - attacker_position).normalized()
		var knockback = direction * Constants.BASE_KNOCKBACK_STRENGTH * ratio
		apply_knockback.emit(knockback)
		if(knockback_timer.is_stopped()):
			knockback_timer.start()

func _i_frame_toggle(value:bool):
	i_frames = value

func _on_knockback_enabled():
	if(!i_frames):
		knockback_timer.stop()
		knockback_allowed = true
	else:
		pending_knockback = true

func _on_knockback_disabled():
	knockback_allowed = false
