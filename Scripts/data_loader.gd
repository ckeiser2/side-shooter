extends Node

var weapons: Dictionary = {}
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	load_weapons_csv("res://Data/weapons.csv")
	
	print("---Weapons Loaded Successfully ---")
	print(weapons)
	print("Pulse Laser Damage: ", weapons["wpn_laser"]["damage"])
