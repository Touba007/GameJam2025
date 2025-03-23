extends Control

func _ready():
	$VBoxContainer/CommencerButton.pressed.connect(_on_commencer_pressed)
	$VBoxContainer/QuitterButton.pressed.connect(_on_quitter_pressed)

func _on_commencer_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_quitter_pressed():
	get_tree().quit()
