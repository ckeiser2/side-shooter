extends CharacterBody2D

@export var weapon_id: String = "wpn_laser"
@export var speed: float = 300.0
var weapon_name: String = ""
var damage: float = 0.0
var fire_rate: float = 1.0
@onready var fire_timer: Timer = $FireTimer
@onready var weapon_label: Label = $WeaponLabel
@onready var muzzle: Marker2D = $Muzzle

const BULLET_SCENE: PackedScene = preload("res://Scenes/bullet.tscn")

var is_alive: bool = true

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
	#print("Equipped: ", weapon_name)
	print("Damage: ", damage, " Fire rate: ", fire_rate)
	
func _physics_process(_delta: float) -> void:
	var direction := Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
func _on_fire_timer_timeout() -> void:
	var bullet = BULLET_SCENE.instantiate()
	bullet.damage = damage
	bullet.global_position = muzzle.global_position
	get_parent().add_child(bullet)
	if not is_alive:
		return
	#print(
	#	"Fired ",
	#	weapon_name,
	#	"for ",
	#	damage, " damage")

func take_hit(_amount: int) -> void:
	if not is_alive:
		return
	if get_parent().has_method("lose_life"):
		get_parent().lose_life(1)
		
func disable_ship() -> void:
	is_alive = false
	fire_timer.stop()
	visible = false
	collision_layer = 0
	set_physics_process(false)
	
func freeze_ship() -> void:
	is_alive = false
	fire_timer.stop()
	set_physics_process(false)
	
