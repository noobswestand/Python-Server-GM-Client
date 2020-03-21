import struct

#https://docs.python.org/2/library/struct.html#format-characters

class Buff():
	def __init__(self):
		self.Buffer=-1
		self.BufferO=-1
		self.BufferWrite=[]
		self.BufferWriteT=[]
		self.BufferHeader="H"
		self.BufferHeaderSize=struct.calcsize(self.BufferHeader)
	def clearbuffer(self):
		self.BufferWrite.clear()
		self.BufferWriteT.clear()

		#Header- length of data in the packet
		self.BufferWrite.append(0)
		self.BufferWriteT.append(self.BufferHeader)
		
	def writebit(self,b):
		self.BufferWrite.append(b)
		self.BufferWriteT.append("?")
	def writebyte(self,b):
		self.BufferWrite.append(b)
		self.BufferWriteT.append("B")
	def writestring(self,s):
		self.BufferWriteT.append("{}s".format(len(s)+1))
		self.BufferWrite.append(s.encode("utf-8")+b'\x00')
	def writeint(self,b):
		self.BufferWrite.append(b)
		self.BufferWriteT.append("i")
	def writedouble(self,b):
		self.BufferWrite.append(float(b))
		self.BufferWriteT.append("d")
	def writefloat(self,b):
		self.BufferWrite.append(b)
		self.BufferWriteT.append("f")
	def writeshort(self,b):
		self.BufferWrite.append(b)
		self.BufferWriteT.append("h")
	def writeushort(self,b):
		self.BufferWrite.append(b)
		self.BufferWriteT.append("H")
	def readstring(self):
		s=""
		p=""
		while(p!="\x00"):
			p=struct.unpack('s', self.Buffer[:1])[0].decode("utf-8")
			self.Buffer=self.Buffer[1:]
			s+=p
		return s[:-1]
	def readbyte(self):
		Buffer2=self.Buffer
		self.Buffer=self.Buffer[1:]
		return struct.unpack('B', Buffer2[:1])[0]
	def readbit(self):
		Buffer2=self.Buffer
		self.Buffer=self.Buffer[1:]
		return struct.unpack('?', Buffer2[:1])[0]
	def readshort(self):
		Buffer2=self.Buffer
		self.Buffer=self.Buffer[2:]
		return struct.unpack('h', Buffer2[:2])[0]
	def readushort(self):
		Buffer2=self.Buffer
		self.Buffer=self.Buffer[2:]
		return struct.unpack('H', Buffer2[:2])[0]
	def readint(self):
		Buffer2=self.Buffer
		self.Buffer=self.Buffer[4:]
		return struct.unpack('i', Buffer2[:4])[0]
	def readdouble(self):
		Buffer2=self.Buffer
		self.Buffer=self.Buffer[8:]
		return struct.unpack('d', Buffer2[:8])[0]
	def readfloat(self):
		Buffer2=self.Buffer
		self.Buffer=self.Buffer[4:]
		return struct.unpack('f', Buffer2[:4])[0]
	def readheader(self):
		Buffer2=self.Buffer
		self.Buffer=self.Buffer[self.BufferHeaderSize:]
		return struct.unpack(self.BufferHeader, Buffer2[:self.BufferHeaderSize])[0]