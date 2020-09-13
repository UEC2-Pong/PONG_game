import serial
from time import sleep
from pynput import keyboard

ser = serial.Serial(
    port='COM11', 
    baudrate=9600,
    bytesize=serial.EIGHTBITS,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_ONE
)

def press_callback(key):
    if hasattr(key, 'char'):
        if key.char == "w":
            ser.write(b'w')
        elif key.char == "s":
            ser.write(b's')
        elif key.char == "i":
            ser.write(b'i')
        elif key.char == "k":
            ser.write(b'k')
    elif key == keyboard.Key.enter:
        ser.write(chr(13).encode())
    elif key == keyboard.Key.esc:
        ser.write(chr(27).encode())
    elif key == keyboard.Key.delete:
        return False
    print('{} was pressed'.format(key))

def release_callback(key):
    if hasattr(key, 'char'):
        if key.char == "w":
            ser.write(chr(1).encode())
        elif key.char == "s":
            ser.write(chr(2).encode())
        elif key.char == "i":
            ser.write(chr(3).encode())
        elif key.char == "k":
            ser.write(chr(4).encode())
    print('{} was released'.format(key))

l = keyboard.Listener(on_press=press_callback, on_release=release_callback)
l.start()
l.join()
