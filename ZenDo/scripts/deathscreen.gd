extends Control


func _on_rejouer_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_quitter_pressed():
	get_tree().quit()


func _on_menu_principal_pressed():
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn")
