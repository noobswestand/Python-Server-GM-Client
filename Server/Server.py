import socket,sys,sqlite3
from enum import Enum
from time import sleep
from threading import Thread,Lock
from Client import Client
from NetworkConstants import receive_codes, send_codes

def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d


class Server:
    def __init__(self, max_clients, port):

        self.max_clients = max_clients
        self.clients = []
        self.clientpid = 1 #0=server
        self.verified_clients = {}
        self.port = port
        self.socket = None
        self.running = False
        
        self.db = sqlite3.connect('database.db',check_same_thread=False)
        self.db.row_factory = dict_factory
        self.dbc= self.db.cursor()
        self.lock = Lock()

        with open('help.txt', 'r') as myfile:
            self.input_help=myfile.read()

        self.input_thread=-1
    def __del__(self):
        self.db.commit()
        self.db.close()

    def sql(self,sql,args=()):
        try:
            self.lock.acquire(True)

            if sql=="COMMIT":
                self.db.commit()
            else:
                res = self.dbc.execute(sql,args)
                if "SELECT" in sql:
                    result=res.fetchall()
                    if len(result)==1:
                        return result[0]
                    elif len(result)==0:
                        return None
                    else:
                        return result
                elif "INSERT INTO" in sql:
                    self.db.commit()
        finally:
            self.lock.release()

    def inputs(self):
        while self.running:
            x=input("Server>")
            if "/help" in x:
                print(self.input_help)
            if "/kick " in x:
                name=x.replace("/kick ","")
                player=self.playerFind(name)
                if player==None:
                    print("Player not found")
                else:
                    player.kick_user()
                    print("Kicked player",name)
            if "/say " in x:
                text=x.replace("/say ","")
                for players in self.clients:
                    players.clearbuffer()
                    players.writebyte(send_codes["CHAT"])
                    players.writebyte(0)
                    players.writestring(text)
                    players.sendmessage()

    def playerFind(self,name):
        for player in self.clients:
            if player.username==name:
                return player
        return None



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
