extends Label

func _ready():
	self.text = "Berry collected: "+str(Global.score) + "/10"
