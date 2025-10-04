extends Control



func _ready() -> void:
	$MarginContainer/VBoxContainer/loginBtn.pressed.connect(_on_login_button_pressed)

func _on_login_button_pressed():
	var userName = $MarginContainer/VBoxContainer/nameInput.text
	var userAgeText = $MarginContainer/VBoxContainer/ageInput.text
	
	if userName.strip_edges() == "":
		$ErrorLabel.text = "Name cannot be empty"
		$ErrorLabel.visible = true
		return
	elif userName.is_valid_int():
		$ErrorLabel.text = "Name must contain letters"
		$ErrorLabel.visible = true
		return
	if userAgeText.strip_edges() == "":
		$ErrorLabel.text = "Age cannot be empty"
		$ErrorLabel.visible = true
		return
	elif !userAgeText.is_valid_int():
		$ErrorLabel.text = "Age must be a number"
		$ErrorLabel.visible = true
		return
	
	var age = int(userAgeText)
	$ErrorLabel.text = ""
	$ErrorLabel.visible = false
	print("Login successful: Name =", userName, ", Age =", age)
	
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _process(delta: float) -> void:
	pass
