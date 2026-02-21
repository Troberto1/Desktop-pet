extends Node2D

@onready var window : Window = $Window
@onready var audio : AudioStreamPlayer = $Window/Audio
@onready var animat : AnimationPlayer = $Animation
@onready var tick : Timer = $Window/Timer

const SPEED	 = 10
var State : String = "wander"
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
	#NOTE: Has to be like this, because @onready runs after/before this (i guess) and doesnt activates
	$Window/Timer.connect("timeout",process2)
	$Window/Input_Button.connect("pressed",click)
	$Window/Label.modulate = Color.hex(0xffffff00)
	

var Wander_Pos : Vector2 
var Prev_State : String

func process2():
	if State != Prev_State:
		Prev_State = State
		print(State)
	match State:
		"wander":
			if Wander_Pos != Vector2(0,0):
				move_to(Wander_Pos) #FIX!
			else:
				Wander_Pos = Vector2(randi_range(0,get_window().size.x),randi_range(0,get_window().size.y))
		"chase":
			move_to(get_global_mouse_position() + Vector2(10,10))
			
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
			#TODO: make it wander automaticly switch between idle -- wander, and for temp the state is randomm
		"idle":
			State = "stop"
			print("continue")
			State = ["wander", "chase","follow"].pick_random()#NOTE make these chosables by charater  
			
		"follow":
			move_to(get_global_mouse_position())
		"stop":
			pass

func move_to(to) -> void:
	window.position += Vector2i((global_position.direction_to(to)*SPEED))
	global_position = window.position 

func click():
	State = "sound"
