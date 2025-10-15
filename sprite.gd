extends Sprite2D
var speed = 500

func _process(delta):
	var direction = Vector2.ZERO
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	position += direction * speed * delta
