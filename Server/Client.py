import struct,threading,socket,User

from NetworkConstants import receive_codes, send_codes, handshake_codes
from Network import *
import Network
import time


class Client(threading.Thread):
    def __init__(self, connection, address, server,pid):
        threading.Thread.__init__(self)

        self.connection = connection                        # Connection Information
        self.address = address                              # Client Address Properties
        self.server = server                                # Reference to main server
        self.connected = True                               # Connection status
        self.handshake = handshake_codes['UNKNOWN']         # Handshake status defaulted to unknown
        self.user = None                                    # Clients each have a user for the game
        self.pid = pid
        self.username=""
        self.buffer=Network.Buff()

    def sendmessage(self,buff=None,debug=False):
        if buff==None:
            buff=self.buffer
        types = ''.join(buff.BufferWriteT)
        length=struct.calcsize(types)
        self.connection.send(struct.pack("="+types,*buff.BufferWrite))
        if debug==True:
            print(*buff.BufferWrite,''.join(buff.BufferWriteT),struct.pack("="+types,*buff.BufferWrite))
    def sendmessage_other(self):
        for c in self.server.clients:
            if id(c)!=id(self) and c.user!=None:
                c.sendmessage(self.buffer)
    def sendmessage_all(self):
        for c in self.server.clients:
            if c.user!=None:
                c.sendmessage(self.buffer)

    def run(self):

        # Wait for handshake to complete before reading any data
        self.wait_for_handshake()
        # Handshake complete so execute main data read loop
        while self.connected:
            try:
                # Receive data from clients
                self.buffer.Buffer = self.connection.recv(1024)
                self.buffer.BufferO=self.buffer.Buffer
                event_id=self.readbyte()

                if event_id == receive_codes['PING']:
                    self.case_message_ping()
                elif event_id == receive_codes['DISCONNECT']:
                    self.case_message_player_leave()
                elif event_id == receive_codes["REGISTER"]:
                    self.case_message_player_register()
                elif event_id == receive_codes["LOGIN"]:
                    self.case_messasge_player_login()
                elif event_id == receive_codes["MOVE"]:
                    self.case_message_player_move()
                elif event_id == receive_codes["CHAT"]:
                    self.case_message_player_chat()

            except ConnectionResetError:
                self.disconnect_user()



    def case_message_player_chat(self):
        chat=self.readstring()
        #send to everyone
        self.clearbuffer()
        self.writebyte(send_codes["CHAT"])
        self.writebyte(self.pid)
        self.writestring(chat)
        self.sendmessage_all()
    def case_message_ping(self):
        time=self.readint()
        self.clearbuffer()
        self.writebyte(send_codes["PING"])
        self.writeint(time)
        self.sendmessage()
    def case_messasge_player_login(self):
        username=self.readstring()
        password=self.readstring()

        login=True
        login_msg=""
        #check if correct username+password
        self.server.dbc.execute("SELECT * FROM users WHERE username=%s AND password=%s;",(username,password))
        result = self.server.dbc.fetchall()
        if len(result)==0:
            login=False
            login_msg="Invalid username or password"
        #Check if they are already logged in
        for c in self.server.clients:
            if c.user!=None and c.user.username==username:
                login=False
                login_msg="You are already logged in!"

        self.clearbuffer()
        self.writebyte(send_codes["LOGIN"])
        self.writebit(login)
        if login==True:
            self.writestring(username)
            self.writebyte(self.pid)
            print("{0} logged in from {1}:{2}".format(username, self.address[0], self.address[1]))
            self.username=username
        else:
            self.writestring(login_msg)
        self.sendmessage()

        if login==1:
            self.user=User.User(0,0,username,self)
            self.user.start()

            #tell everyone you are here
            self.clearbuffer()
            self.writebyte(send_codes["JOIN"])
            self.writebyte(self.pid)
            self.writestring(self.username)
            self.writedouble(0)
            self.writedouble(0)
            self.writebit(True)
            self.sendmessage_other()
            #time.sleep(1)
            #Make everyone else tell you
            for c in self.server.clients:
                if id(c)!=id(self) and c.user!=None:
                    self.clearbuffer()
                    self.writebyte(send_codes["JOIN"])
                    self.writebyte(c.pid)
                    self.writestring(c.username)
                    self.writedouble(c.user.x)
                    self.writedouble(c.user.y)
                    self.writebit(False)
                    self.sendmessage(buff=self.buffer)
    def case_message_register(self):
        username=self.readstring()
        password=self.readstring()
        self.server.dbc.execute("SELECT * FROM users WHERE username=%s;",(username,))
        if len(self.server.dbc.fetchall())==0:
            self.server.dbc.execute("INSERT INTO users(username,password) VALUES(%s,%s)",(username,password))
            self.clearbuffer()
            self.writebyte(send_codes["REGISTER"])
            self.writebit(True)
            self.writestring(username)
            self.sendmessage()
            print("{0} registered from {1}:{2}".format(username, self.address[0], self.address[1]))

        else:
            clearbuffer()
            writebyte(send_codes["REGISTER"])
            writebit(False)
            writestring("There is already an account by that name")
            self.sendmessage()
    def case_message_player_move(self):
        self.user.inputs=[self.readbit(),self.readbit(),self.readbit(),self.readbit()]
        self.user.x=self.readdouble()
        self.user.y=self.readdouble()
        #forward to other clients
        self.clearbuffer()
        self.writebyte(send_codes["MOVE"])
        self.writebyte(self.pid)
        self.writebit(self.user.inputs[0])
        self.writebit(self.user.inputs[1])
        self.writebit(self.user.inputs[2])
        self.writebit(self.user.inputs[3])
        self.writedouble(self.user.x)
        self.writedouble(self.user.y)
        self.sendmessage_other()
    def case_message_player_leave(self):
        self.disconnect_user()

    def wait_for_handshake(self):
        """
            Wait for the handshake to complete before reading any other information
            TODO: Add better implementation for handshake
        """

        while self.connected and self.handshake != handshake_codes["COMPLETED"]:

            if self.handshake == handshake_codes['UNKNOWN']:
                # First send message to client letting them know we are engaging in a handshake
                handshake = struct.pack('B', receive_codes['HANDSHAKE'])
                self.connection.send(handshake)
                self.handshake = handshake_codes['WAITING_ACK']

            else:
                # Wait for handshake ack
                data = self.connection.recv(1024)
                event_id = struct.unpack('B', data[:1])[0]

                if event_id == receive_codes['HANDSHAKE']:
                    # Received handshake successfully from client
                    self.handshake = handshake_codes['COMPLETED']
                    print("Handshake with {0} complete...".format(self.address[0]))
    def disconnect_user(self):
        """
            Removes the user from the server after disconnection
            TODO: Pass actual server as reference so we can modify it
        """
        print("Disconnected from {0}:{1}".format(self.address[0], self.address[1]))
        self.connected = False

        if self in self.server.clients:
            self.server.clients.remove(self)
            if self.user!=None:
                self.user.Running=False
                #forward to other clients
                self.clearbuffer()
                self.writebyte(send_codes["LEAVE"])
                self.writebyte(self.pid)
                self.sendmessage_other()

    def kick_user(self):
        self.clearbuffer()
        self.writebyte(send_codes["CLOSE"])
        self.writestring("You have been kicked")
        self.sendmessage()
        self.disconnect_user()


    def clearbuffer(self):
        self.buffer.clearbuffer()
    def writebit(self,b):
        self.buffer.writebit(b)
    def writebyte(self,b):
        self.buffer.writebyte(b)
    def writestring(self,b):
        self.buffer.writestring(b)
    def writeint(self,b):
        self.buffer.writeint(b)
    def writedouble(self,b):
        self.buffer.writedouble(b)
    def writefloat(self,b):
        self.buffer.writefloat(b)
    def readstring(self):
        return self.buffer.readstring()
    def readbyte(self):
        return self.buffer.readbyte()
    def readbit(self):
        return self.buffer.readbit()
    def readint(self):
        return self.buffer.readint()
    def readdouble(self):
        return self.buffer.readdouble()
    def readfloat(self):
        return self.buffer.readfloat()
