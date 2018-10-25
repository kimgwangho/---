import bluetooth
import socket

def file_read():
    
    line = ''
    result = ''
    
    f = open("./obd_data.txt", 'r')
    while True:
        line = f.readline()
        if not line: break
        print(line)
        result += line
    f.close()
    return result


server_socket=bluetooth.BluetoothSocket( bluetooth.RFCOMM )
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

port = 1
server_socket.bind(("",port))
server_socket.listen(1)

client_socket,address = server_socket.accept()
print ("Accepted connection from " + address[0])
while 1:

    try : 
        data = client_socket.recv(1024)
     
        data = data.decode("utf8").strip()
     
        print ("Received: " + data)

      
        if (data == "1"):    

            obd_data = file_read()
            client_socket.send( obd_data + '\n')
      
      
        if (data == "q"):
            print ("Quit")
            break
        
    except Exception as ex:
         #client_socket.close()
        server_socket.close()
        print("socket close")

        server_socket=bluetooth.BluetoothSocket( bluetooth.RFCOMM )
        server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

        port = 1
        server_socket.bind(("",port))
        server_socket.listen(1)

        client_socket,address = server_socket.accept()

        
server_socket.close()
