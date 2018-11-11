import socket,sys,mysql.connector
from enum import Enum
from time import sleep
from threading import Thread
from Client import Client
from NetworkConstants import receive_codes, send_codes




class Server:
    def __init__(self, max_clients, port):

        self.max_clients = max_clients
        self.clients = []
        self.clientpid = 1 #0=server
        self.verified_clients = {}
        self.port = port
        self.socket = None
        self.running = False
        self.db = mysql.connector.connect(
          host="localhost",
          user="root",
          passwd="",
          database="gm"
        )
        self.dbc = self.db.cursor()
        self.input_thread=-1

    def inputs(self):
        while self.running:
            x=input("Server>")
            if "/help" in x:
                print("/help\n\tShows this help menu\n\
/kick <player>\n\tkicks a player of a given username\n\
/say <text>\n\tsends a chat message to everyone")
            if "/kick " in x:
                player=x.replace("/kick ","")
                found=False
                for players in self.clients:
                    if players.username==player:
                        players.kick_user()
                        found=True
                        break
                if found==False:
                    print("Player not found")
                else:
                    print("Kicked player",player)
            if "/say " in x:
                text=x.replace("/say ","")
                for players in self.clients:
                    players.clearbuffer()
                    players.writebyte(send_codes["CHAT"])
                    players.writebyte(0)
                    players.writestring(text)
                    players.sendmessage()




    def start(self):

        # Create a new socket
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        # self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, 1024)

        try:
            # Attempt to bind socket to port
            self.socket.bind(("", self.port))
            self.running = True
        except socket.error as err:
            print("Failed to bind socket: [{0}] {1}".format(err[0], err[1]))
            sys.exit()

        # Main server loop
        self.input_thread = Thread(target = self.inputs)
        self.input_thread.setDaemon(True)
        self.input_thread.start()
        while self.running:
            sleep(1 / 1000)

            # Listen for incoming connections
            self.socket.listen(self.max_clients)

            # Accept incoming connections
            connection, address = self.socket.accept()

            # Add user to user list and start the user thread
            print("Connected to {0}:{1}".format(address[0], address[1]))
            client = Client(connection, address, self, self.clientpid)
            client.start()
            self.clients.append(client)
            self.clientpid+=1
