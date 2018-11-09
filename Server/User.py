import time,threading


class User(threading.Thread):

	def __init__(self, x, y, username,client):
		threading.Thread.__init__(self)
		self.client=client
		self.x = x
		self.y = y
		self.username = username
		self.step=0
		self.Running=True
		self.inputs=[0,0,0,0] #left,right,up,down

	def run(self):
		while self.Running:
			start_time = time.time()
			self.move()

			self.step+=1
			end_time = time.time()

			time.sleep(max(.01666-(end_time-start_time),0))#Go at 60 steps/second

	def move(self):
		if self.inputs[0]==1:
			self.x-=5
		if self.inputs[1]==1:
			self.x+=5
		if self.inputs[2]==1:
			self.y-=5
		if self.inputs[3]==1:
			self.y+=5
			



