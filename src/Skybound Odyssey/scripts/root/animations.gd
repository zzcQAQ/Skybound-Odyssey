extends Node

var titleStandardPos = Vector2(200, 200)
var titleHidePos = Vector2(-900, 200)

var buttonStandardPos = Vector2(1500, 300)
var buttonHidePos = Vector2(2000, 300)

func UImove(node: Node2D, start_pos: Vector2, end_pos: Vector2, duration: float):
	
	var tween = create_tween()
	node.position = start_pos
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(node, "position", end_pos, duration)

func UIchange(from: Node2D, to: Node2D):
	
	var title0 = from.get_node("title")
	var buttons0 = from.get_node("buttons")
	
	var title1 = to.get_node("title")
	var buttons1 = to.get_node("buttons")
	
	UImove(buttons0, buttonStandardPos, buttonHidePos, 0.3)
	UImove(title0, titleStandardPos, titleHidePos, 0.3)
	
	await get_tree().create_timer(0.3).timeout
	
	UImove(buttons1, buttonHidePos, buttonStandardPos, 0.3)
	UImove(title1, titleHidePos, titleStandardPos, 0.3)

	
	
