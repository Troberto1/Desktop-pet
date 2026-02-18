extends Node2D

@onready var window : Window = $Window
@onready var audio : AudioStreamPlayer = $Window/Audio
@onready var animat : AnimationPlayer = $Animation
@onready var tick : Timer = $Window/Timer

const SPEED	 = 10
var State : String = "idle"
var Audio_Files : Array = [
	"res://Pets/test01/audio/1.mp3",
	"res://Pets/test01/audio/2.mp3",
	"res://Pets/test01/audio/3.mp3",
	"res://Pets/test01/audio/4.mp3",
	"res://Pets/test01/audio/5.mp3",
	"res://Pets/test01/audio/6.mp3",
	"res://Pets/test01/audio/7.mp3",
]

func _init() -> void:
	print("Hello World!")
	#NOTE: Has to be like this, because onready runs after this (i guess)
	$Window/Timer.connect("timeout",process2)
	$Window/Input_Button.connect("pressed",click)
	$Window/Label.modulate = Color.hex(0xffffff00)
	

func process2():
	print(State)
	match State:
		"normal":
			State = "chase"
			
		"chase":
			move_to(get_global_mouse_position())
			
		"sound":
			audio.stop()
			animat.stop()
			var rannum : int = randi_range(1,7)
			match rannum:
				6:
					animat.play("text1") 
				7:
					animat.play("text2") 
			audio.stream = load(Audio_Files[rannum-1])
			audio.play()
			await get_tree().create_timer(0.3).timeout
			State = "idle"
			
		"idle":
			State = ["normal","chase", "idle"].pick_random()

func move_to(to) -> void:
	window.position += Vector2i(global_position.direction_to(get_global_mouse_position()))
	global_position = window.position 

func click():
	State = "sound"
