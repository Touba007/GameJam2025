extends CanvasLayer

# Fonction pour le bouton "Recommencer"
func _on_RetryButton_pressed():
	# Recharge la scène actuelle
	get_tree().reload_current_scene()

# Fonction pour le bouton "Quitter"
func _on_QuitButton_pressed():
	# Quitte le jeu
	get_tree().quit()
