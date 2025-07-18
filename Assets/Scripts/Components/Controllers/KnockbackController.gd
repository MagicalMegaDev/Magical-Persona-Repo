class_name KnockbackController extends Node2D

var weight := 50
var queue_knockback := false #Knockback is queued
var can_knockback := true #Bool to turn off knockback
var i_frames := false #Are i-frames going?

var knockback_timer:Timer #Timer for minimum knockback
var knockback_wait_time := 0.1 #Timer length

signal apply_knockback(knockback : Vector2)

func _ready():
	knockback_timer = Timer.new()
	knockback_timer.one_shot = true
	knockback_timer.autostart = false
	knockback_timer.wait_time = knockback_wait_time
	knockback_timer.timeout.connect(_on_knockback_disabled)
	add_child(knockback_timer)
	
func _process(delta):
	if(queue_knockback and !i_frames):
		can_knockback = true
		queue_knockback = false

func _receive_stats(stats:CharacterStats):
	weight = stats.weight 
	
func calculate_knockback(stats:AttackStats, attacker_position:Vector2):
	if(can_knockback and stats.knockback_enabled):
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
		can_knockback = true
	else:
		queue_knockback = true

func _on_knockback_disabled():
	can_knockback = false
