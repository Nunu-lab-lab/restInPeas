extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$startBtn.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/login.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
