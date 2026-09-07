
extends RigidBody2D

@export var enemy_id: String = "enm_alien"

var player: Node2D
var speed: float = 100.0


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

	load_enemy_data()

	# Initial random movement
	var x_axis_force = randf_range(-speed, speed)
	var y_axis_force = randf_range(-speed, speed)

	var enemy_vector := Vector2(x_axis_force, y_axis_force)

	apply_impulse(enemy_vector * 10)


func load_enemy_data() -> void:
	var file = FileAccess.open("res://Data/enemies.csv", FileAccess.READ)

	if file == null:
		print("Could not open enemies.csv")
		return

	# Read and discard header
	file.get_line()

	while not file.eof_reached():
		var line = file.get_line().strip_edges()

		if line == "":
			continue

		var data = line.split(",")

		if data.size() < 4:
			continue

		var id = data[0]

		if id == enemy_id:
			speed = float(data[3])
			print(enemy_id, " speed = ", speed)
			break


func _physics_process(delta: float) -> void:
	if player == null:
		return

	var constant_speed = speed * 0.1

	var x_axis_force = randf_range(-constant_speed, constant_speed)
	var y_axis_force = randf_range(-constant_speed, constant_speed)

	var enemy_vector := Vector2(x_axis_force, y_axis_force)
