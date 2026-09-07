extends Node

var weapon_inventory: Dictionary = {
	"wpn_laser": {
		"name": "Pulse Laser",
		"damage": 10.0,
		"fire_rate": 0.2,
		"dps": 50.0
	}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	#print("---Starting Logic Playground---")
	test_if_statements()
	test_while_loops()
	test_Arrays()
	
func test_Dictionary() -> void:
	#print("\n---Test Dictionary ---")
	for weapon_id in weapon_inventory:
		var stats: Dictionary = weapon_inventory[weapon_id]
		#print("ID: ", weapon_id, " -> Name: ",
		#stats["name"], " (DPS: ", stats["dps"], ")")
	
	
func test_Arrays() -> void:
	#print("\n --- Test Array Function ---")
	var index: int = 0
	#create an arry of enemies
	var enemies: Array[String] = ["Scout Drone",
	"Asteroid", 
	"Cruiser", 
	"Boss Mothership"]
	
	while index < 4:
		#index = index + 1
		#print("Current index is:" + str(index))
		#print(enemies[index])
		index += 1;
	

func test_if_statements() -> void:
	#print("--- Hello from if function ---")
	var player_health: int = 15
	#print("Player Health = " + str(player_health))
	
	if player_health <= 0:
		pass
		#print("Status: Player Defeated")
	elif player_health < 25:
		pass
		#print("Status: Critical Health Warning")
	else:
		pass
		#print("Status: Healthy")
		
func test_while_loops() -> void:
	#print("\n --- 2. Testing While Loops ---")
	var current_shield: int = 0
	var max_shield: int = 3
	#print("\n --- Recharging shield ---")
	
	#loop repeats until current shield is charged
	
	while current_shield < max_shield:
		#current_shield += 1
		current_shield = current_shield + 1
		#print("Shield charging... Level: ", str(current_shield))
		
	#print("Shield fully Charged!")
