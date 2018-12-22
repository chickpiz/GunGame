extends KinematicBody2D

var pl1tex = preload("res://pictures/Bullet1.png")
var pl2tex = preload("res://pictures/Bullet2.png")

var direction = Vector2()
var speed = 0
var mynum

func set_color(plrnum):
    mynum = plrnum
    if plrnum == 1:
        get_node("Sprite").texture = pl1tex
    else:
        get_node("Sprite").texture = pl2tex

func _physics_process(delta):
    look_at(self.position + direction)
    var collision = move_and_collide(direction * speed * delta)
    if collision:
        if "plrnum" in collision.collider:
            if mynum != collision.collider.plrnum:
                collision.collider.damage(10)  
        get_parent().remove_child(self)
    if self.is_on_ceiling() or self.is_on_wall() or self.is_on_floor():
        get_parent().remove_child(self)
