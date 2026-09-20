extends Node2D


const ENEMY_SCENE: PackedScene = preload("res://Scenes/enemy.tscn")

var spawn_index: int = 0 
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var spawn_timer: Timer = $SpawnTimer

func _ready():
	spawn_timer.wait_time = 0.4
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	var loader: Node = get_node("/root/DataLoader")
	if spawn_index >= loader.spawn_list.size():
		spawn_timer.stop()
		print("Wave finished")
		
		if get_parent().has_method("on_wave_finished"):
			get_parent().on_wave_finished()
		
		return

	var row: Dictionary = loader.spawn_list[spawn_index]
	spawn_enemy(row["enemy_id"], row["y"])
	spawn_timer.wait_time = row["wait"]
	spawn_index += 1
	

	
func spawn_enemy(id: String, y: float) -> void:
	var enemy = ENEMY_SCENE.instantiate()
	enemy.enemy_id = id
	enemy.global_position = Vector2(spawn_point.global_position.x, y)
	get_parent().add_child(enemy)
	
	if get_parent().has_method("on_enemy_spawned"):
		get_parent().on_enemy_spawned()
	
	print("Spawning ", id, " at y = ", y)


func _process(delta):
	pass
