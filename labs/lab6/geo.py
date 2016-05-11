import telnetlib as tn
import random
import time

t = tn.Telnet("127.0.0.1", 5554)

while True:
    random_long = random.random()*20
    random_lat = random.random()*20
    t.write("geo fix "+str(random_long)+" "+str(random_lat)+"\n")
    time.sleep(1)
