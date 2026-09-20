extends Area2D


@export var speed: float = 1000.0
var damage: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DamageLabel.text = str(damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x += speed * delta
	if position.x > 1000.0:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free()
