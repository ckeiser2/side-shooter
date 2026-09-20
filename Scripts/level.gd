extends Node2D

var score: int = 0
var lives: int = 3

var wave_done: bool = false
var enemies_alive: int = 0
var game_ended: bool = false


@onready var score_label: Label = $HUD/ScoreLabel
@onready var lives_label: Label = $HUD/LivesLabel
@onready var game_over_label: Label = $HUD/GameOverLabel

@onready var you_win_label: Label = $HUD/YouWinLabel
@onready var restart_button: Button = $HUD/RestartButton

func add_score(amount: int) -> void:
	score += amount
	score_label.text = "Score: " + str(score)
	print("Score is now ", score)

func lose_life(amount: int) -> void:
	if lives <= 0:
		return
	lives -= amount
	lives_label.text = "Lives: " + str(lives)
	print("Lives left: ", lives)
	if lives <= 0:
		game_over()

func game_over() -> void:
	if game_ended:
		return
	game_ended = true
	print("GAME OVER")
	game_over_label.visible = true
	restart_button.visible = true
	$EnemySpawner/SpawnTimer.stop()
	if $PlayerShip.has_method("disable_ship"):
		$PlayerShip.disable_ship()
		
func on_enemy_spawned() -> void:
	enemies_alive += 1
	check_win()

func on_enemy_gone() -> void:
	enemies_alive -= 1
	check_win()

func check_win() -> void:
	if game_ended:
		return
	if lives <= 0:
		return
	if wave_done and enemies_alive <= 0:
		you_win()
		
func you_win() -> void:
	game_ended = true
	print("YOU WIN")
	you_win_label.visible = true
	restart_button.visible = true
	$EnemySpawner/SpawnTimer.stop()
	if $PlayerShip.has_method("freeze_ship"):
		$PlayerShip.freeze_ship()

func on_wave_finished() -> void:
	wave_done = true
	print("Wave list is done. Enemies still alive: ", enemies_alive)
	check_win()
	
func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
