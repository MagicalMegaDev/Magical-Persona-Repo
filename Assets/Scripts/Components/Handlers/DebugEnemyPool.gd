class_name DebugEnemyPool extends Node

var alive_enemies = {}
var dead_enemies = {}

func _ready():
	
	for child in get_tree().get_nodes_in_group("Enemies"):
		alive_enemies[child] = child.global_position
		child.died.connect(_store)

func _store(enemy:BaseEnemy):
	enemy.get_node("AnimationTree/AnimationPlayer").stop()
	enemy.process_mode = Node.PROCESS_MODE_DISABLED
	enemy.visible = false
	if enemy in alive_enemies:
		dead_enemies[enemy] = alive_enemies[enemy]
		alive_enemies.erase(enemy)
	if alive_enemies.is_empty():
		_respawn()
		
func _respawn():
	for e in alive_enemies:
		assert(e is BaseEnemy, "Pool is trying to store %s, not an enemy!" % e.name)
		_store(e)

	for e in dead_enemies:
		e.global_position = dead_enemies[e]
		e.health_handler.heal_damage(e.health_handler.max_health)
		e.process_mode = Node.PROCESS_MODE_INHERIT
		e.visible = true
		alive_enemies[e] = dead_enemies[e]
	dead_enemies.clear()
