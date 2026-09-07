extends CharacterBody2D

@export var weapon_id: String = "wpn_laser"
@export var speed: float = 300.0
var weapon_name: String = ""
var damage: float = 0.0
var fire_rate: float = 1.0
@onready var fire_timer: Timer = $FireTimer
@onready var weapon_label: Label = $WeaponLabel


func _ready() -> void:
	apply_weapon_from_data()


func apply_weapon_from_data() -> void:
	var loader: Node = get_node("/root/DataLoader")
	if not loader.weapons.has(weapon_id):
		print("Unknown weapon id: ", weapon_id)
		weapon_label.text = "Unknown weapon"
		return
	var stats: Dictionary = DataLoader.weapons[weapon_id]
	weapon_name = stats["name"]
	damage = stats["damage"]
	fire_rate = stats["fire_rate"]
	fire_timer.wait_time = fire_rate
	fire_timer.start()
	weapon_label.text = weapon_name
	print("Equipped: ", weapon_name)
	print("Damage: ", damage, " Fire rate: ", fire_rate)
	
func _physics_process(_delta: float) -> void:
	var direction := Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
func _on_fire_timer_timeout() -> void:
	pass
	#print("PEW! ", weapon_name, " deals ", damage, " damage")
