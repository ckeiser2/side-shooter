
extends Area2D

@export var enemy_id: String = "enm_alien"

var player: Node2D
var max_hp: float = 0.0
var current_hp: float = 0.0
var move_speed: float = 100.0
@onready var hp_label: Label = $HpLabel
@onready var sprite: Sprite2D = $Sprite2D
@onready var death_particles: GPUParticles2D = $DeathParticles

func _ready() -> void:
	setup_enemy(enemy_id)

func setup_enemy(id: String) -> void:
	var loader: Node = get_node("/root/DataLoader")
	if not loader.enemies.has(id):
		print("Unknown enemy id: ", id)
		hp_label.text = "Unknown"
		return
	
	var data: Dictionary = loader.enemies[id]

	print("Enemy ID: ", id)
	print("Enemy data: ", data)
	print("Enemy keys: ", data.keys())

	max_hp = data["hp"]
	current_hp = max_hp
	move_speed = data["speed"]
	hp_label.text = str(current_hp)
	load_enemy_visual(id)
	print("Spawned ",
	data["name"],
	" HP: ",
	current_hp,
	" Speed: ",
	move_speed)
	
func load_enemy_visual(id: String) -> void:
	match id:
		"enm_alien":
			sprite.texture = preload("res://Assets/alien.png")

		"enm_scout":
			sprite.texture = preload("res://Assets/scout.png")

		"enm_cruiser":
			sprite.texture = preload("res://Assets/cruiser.png")



func _physics_process(delta: float) -> void:
	position.x -= move_speed * delta
	if position.x < -100.0:
		leak()

func take_damage(amount: float) -> void:
	current_hp -= amount
	hp_label.text = str(current_hp)
	print(enemy_id, " took ",
	amount,
	" damage. HP left: ",
	current_hp)
	
	if current_hp <= 0.0:
		die()
		
func notify_gone() -> void:
	if get_parent().has_method("on_enemy_gone"):
		get_parent().on_enemy_gone()

func die() -> void:
	print(enemy_id, " destroyed!")

	if get_parent().has_method("add_score"):
		get_parent().add_score(10)

	notify_gone()

	# Disable enemy
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.hide()
	$HpLabel.hide()

	# Play particles
	death_particles.emitting = true

	# Wait for death animation to finish then free queue
	await death_particles.finished

	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_hit"):
		body.take_hit(1)
		notify_gone()
		queue_free()

func leak() -> void:
	if get_parent().has_method("lose_life"):
		get_parent().lose_life(1)
	notify_gone()
	queue_free()
