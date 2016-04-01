import socket
import os


host = 'localhost'
port = 6100


def getCmd(path):
    tmpScriptPath = os.path.join(path, "tmpScript.py")
    with open(tmpScriptPath) as tmpFile:
        cmd = tmpFile.read()

    return cmd


def send(cmd):

    try:
        connection = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        connection.connect((host, port))
        connection.send(cmd)
        connection.send("\x04")
    except:
        print "Connection failed."
    finally:
        connection.close()
