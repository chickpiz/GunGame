extends Node2D

var bullet_spr1 = preload("res://pictures/Bullet1.png")
var bullet_spr2 = preload("res://pictures/Bullet2.png")
var pl1score = 0
var pl2score = 0

func _ready():
    update_score()

func _process(delta):
    if get_node("Player1").hp >= 0:
        get_node("Player1/Bar").value = get_node("Player1").hp
    else:
        get_node("Player1/Bar").value = 0
    if get_node("Player2").hp >= 0:
        get_node("Player2/Bar").value = get_node("Player2").hp
    else:
        get_node("Player2/Bar").value = 0
    
func update_score():
    get_node("Score").text = str(pl1score) + " : " + str(pl2score)
    
func _on_Player1_shoot(Bullet, direction, spd):
    var bullet = Bullet.instance()
    add_child(bullet)
    bullet.direction = direction.normalized()
    bullet.speed = spd
    bullet.set_color(1)
    bullet.position = get_node("Player1").position + direction.normalized() * 16

func _on_Player2_shoot(Bullet, direction, spd):
    var bullet = Bullet.instance()
    add_child(bullet)
    bullet.direction = direction.normalized()
    bullet.speed = spd
    bullet.set_color(2)
    bullet.position = get_node("Player2").position + direction.normalized() * 16
    
func _on_Game_gameover(playernum):
    if playernum == 1:
        pl2score += 1
        get_node("Player1").position = Vector2(32, 288)
        get_node("Player1").hp = 100
    else:
        pl1score += 1
        get_node("Player2").position = Vector2(992, 288)
        get_node("Player2").hp = 100        
    update_score()