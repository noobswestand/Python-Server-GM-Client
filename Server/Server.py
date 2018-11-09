import socket,sys,mysql.connector
from enum import Enum
from time import sleep

from Client import Client





class Server:
    def __init__(self, max_clients, port):

        self.max_clients = max_clients
        self.clients = []
        self.clientpid = 0
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
