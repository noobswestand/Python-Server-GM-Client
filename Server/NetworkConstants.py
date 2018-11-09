from enum import Enum


receive_codes = {
    "PING": 0,
    "HANDSHAKE": 1,
    "DISCONNECT": 2,
    "REGISTER":3,
    "LOGIN":4,
    "MOVE":5,
    "CHAT":6,
}

send_codes = {
	"PING":0,
    "REGISTER":3,
	"LOGIN":4,
	"MOVE":5,
	"JOIN":6,
	"LEAVE":7,
	"CHAT":8,
}


handshake_codes = {
    "UNKNOWN": 0,
    "WAITING_ACK": 1,
    "COMPLETED": 2
}

