extends KinematicBody2D

var speed = ProjectSettings.get("Game/Player Speed")

var bullet_speed = 500

var hp = 100
var plrnum = 2

var velocity = Vector2()
var rot
var direction = Vector2()

var Bullet = preload("res://Bullet.tscn")

signal shoot(Bullet, direction, spd)
signal gameover(num)

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed("player2_up"):
        velocity.y -= 1
    if Input.is_action_pressed("player2_down"):
        velocity.y += 1
    if Input.is_action_pressed("player2_left"):
        velocity.x -= 1
    if Input.is_action_pressed("player2_right"):
        velocity.x += 1
    velocity = velocity.normalized() * speed
    
func damage(point):
    hp -= point
    if hp <= 0:
        emit_signal("gameover", 2)
        
func _input(event):
    if event is InputEventKey:
        if event.is_action_pressed("player2_attack"):
            emit_signal("shoot", Bullet, direction.normalized(), bullet_speed)
            
func _physics_process(delta):
    rot = self.rotation
    direction = Vector2(cos(rotation), sin(rotation))
    get_input()
    look_at(self.position + velocity.normalized())
    move_and_slide(velocity)