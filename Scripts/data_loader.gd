extends Node

var weapons: Dictionary = {}
var enemies: Dictionary = {}

var spawn_list: Array = []

# Called when the node enters the scene tree for the first time.
func load_weapons_csv(path: String) -> void:
	if not FileAccess.file_exists(path):
		print("Error: Could not find file at: ", path)
		return
		
	var file := FileAccess.open(path, FileAccess.READ)
	
	var _headers = file.get_csv_line()
	
	while not file.eof_reached():
		var row := file.get_csv_line()
		
		# Check for all 5 columns (id, name, dmg, fire_rate, dps)
		if row.size() < 4 or row[0].strip_edges() == "":
			continue
		
		var weapon_id := row[0].strip_edges()
		weapons[weapon_id] = {
			"name": row[1].strip_edges(),
			"damage": float(row[2]),
			"fire_rate": float(row[3]),
			"dps": float(row[4])
		}

func load_enemies_csv(path: String) -> void:
	if not FileAccess.file_exists(path):
		print("Error: Could not find file at: ", path)
		return
		
	var file := FileAccess.open(path, FileAccess.READ)
	
	var _headers = file.get_csv_line()
	
	while not file.eof_reached():
		var row := file.get_csv_line()
		
		# Check for all 6 columns
		if row.size() < 6 or row[0].strip_edges() == "":
			continue
		
		var enemy_id := row[0].strip_edges()
		enemies[enemy_id] = {
			"name": row[1].strip_edges(),
			"hp": float(row[2]),
			"speed": float(row[3])
		}

func load_spawns_csv(path: String) -> void:
	if not FileAccess.file_exists(path):
		print("Error: Could not find file at: ", path)
		return
	var file := FileAccess.open(path, FileAccess.READ)
	var _headers = file.get_csv_line()
	spawn_list.clear()
	while not file.eof_reached():
		var row := file.get_csv_line()
		if row.size() < 3 or row[0].strip_edges() == "":
			continue
		spawn_list.append({
			"enemy_id": row[0].strip_edges(),
			"wait": float(row[1]),
			"y": float(row[2])
		})

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	load_weapons_csv("res://Data/weapons.csv")
	load_enemies_csv("res://Data/enemies.csv")
	load_spawns_csv("res://Data/spawns.csv")
	
	#print("---Weapons Loaded Successfully ---")
	#print("---Enemies Loaded Successfully ---")
	
	#print(weapons)
	#print(enemies)
	#print("Pulse Laser Damage: ", weapons["wpn_laser"]["damage"])
