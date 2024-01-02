extends Label

func _ready():
	self.text = "Barry collected: "+str(Global.score)
