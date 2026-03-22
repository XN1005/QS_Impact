extends Node2D

@onready var player = $CharacterBody2D
@onready var death_menu = $CanvasLayer/DeathMenu
@onready var pause_menu = $CanvasLayer/PauseMenu

func _ready():
	player.died.connect(_on_player_died)

func _on_player_died():
	death_menu.show_death()

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") and not death_menu.visible:
		if get_tree().paused:
			pause_menu.close()
		else:
			pause_menu.open()
