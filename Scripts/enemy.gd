extends RigidBody2D

var player: Node2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	
	var xAxisForce = randf_range(-25, 25)
	var yAxisForce = randf_range(-25, 25)
	
	var enemyVector:= Vector2(xAxisForce, yAxisForce)
	
	var force = 10
	apply_impulse(enemyVector * force)

func _physics_process(delta: float) -> void:
	if player == null:
		return
	var xAxisForce = randf_range(-10, 10)
	var yAxisForce = randf_range(-10, 10)
		
		
