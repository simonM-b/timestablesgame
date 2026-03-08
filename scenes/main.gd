extends Control

var correctNumber = 0
var curentNumber

var right = 0
var wrong = 0

var topNumb = 0
var bottomNumb = 0

var old_text := ""

func _ready() -> void:
	$"color bg".show()
	randomize()
	restart()
	

func _process(delta: float) -> void:
	$Panel/CenterContainer/HBoxContainer/correct.text = "correct: " + str(right)
	$Panel/CenterContainer/HBoxContainer/wrong.text = "wrong: " + str(wrong)
	if Input.is_action_just_pressed("enter"):
		if correctNumber == curentNumber: #right is under here
			$"color bg".color = Color.GREEN
			fadeOutColor()
			restart()
			right += 1
		else: #wrong is under here
			$"color bg".color = Color.RED
			fadeOutColor()
			$correction/Label.text = "correct answer for " + str(topNumb) + " * " + str(bottomNumb) + " was: " + str(correctNumber)
			restart()
			$correction.show()
			wrong += 1

func fadeOutColor():
	var fadeTime = 0.6 #seconds
	$"color bg".modulate.a = 0.6
	var tween = get_tree().create_tween()
	tween.tween_property($"color bg", "modulate:a", 0, fadeTime)
	tween.play()
	await tween.finished
	tween.kill()
		

func restart():
	$correction.hide()
	$VBoxContainer/LineEdit.text = ""
	topNumb = randi_range(1,12)
	bottomNumb = randi_range(1,12)
	$VBoxContainer/CenterContainer/VBoxContainer/top.text = str(topNumb)
	$VBoxContainer/CenterContainer/VBoxContainer/botttom.text = str(bottomNumb)
	correctNumber = topNumb*bottomNumb
	
	


func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.is_empty() or new_text.is_valid_int():
		old_text = new_text
		curentNumber = int(old_text)
	else:
		$VBoxContainer/LineEdit.text = old_text
