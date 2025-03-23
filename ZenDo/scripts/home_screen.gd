extends Control


func _on_quitter_pressed():
	get_tree().quit()


func _on_commencer_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
