import sys
import socket


# specify Host and Port
HOST = '172.24.132.148'
PORT = 8001
   
soc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen()
    conn, addr = s.accept()
    with conn:
        print(f"Connected by {addr}")
        print(conn)
        do_ack = False
        while True:
            try:
                data = conn.recv(1024)
                if not data:
                    break
                print("Received: ", data)

                #if not do_ack:
                #    do_ack = True
                #    conn.sendall(data)
            except KeyboardInterrupt:
                conn.close(); s.close();break;