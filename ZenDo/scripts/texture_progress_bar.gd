extends Control

# Variables pour gérer le niveau de stress
export var max_stress : float = 100.0
export var current_stress : float = 0.0

onready var stress_bar = $TextureProgress
onready var stress_label = $Label

func _ready():
	update_stress_bar()

func update_stress_bar():
	# Mettre à jour la barre de stress
	stress_bar.value = current_stress / max_stress
	# Mettre à jour le label (si utilisé)
	if stress_label:
		stress_label.text = str(int(current_stress)) + " / " + str(int(max_stress))

func add_stress(amount: float):
	current_stress += amount
	if current_stress > max_stress:
		current_stress = max_stress
	update_stress_bar()

func reduce_stress(amount: float):
	current_stress -= amount
	if current_stress < 0:
		current_stress = 0
	update_stress_bar()
