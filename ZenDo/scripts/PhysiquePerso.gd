extends CharacterBody2D

@onready var sprite = $SpritePerso
@export var speed = 200.0

@export var front_texture: Texture
@export var back_texture: Texture
@export var left_texture: Texture
@export var right_texture: Texture

func _physics_process(delta):
	var dir = Vector2.ZERO
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if dir != Vector2.ZERO:
		dir = dir.normalized()
		velocity = dir * speed
		move_and_slide()

		if abs(dir.x) > abs(dir.y):
			if dir.x > 0:
				sprite.texture = right_texture
			else:
				sprite.texture = left_texture
		else:
			if dir.y > 0:
				sprite.texture = front_texture
			else:
				sprite.texture = back_texture
	else:
		velocity = Vector2.ZERO
