import random
import time

prevSpd = 0
msgCnt = 1

while(True) :
    
    ts = time.time()
    coolTmp = random.randrange(35,60)
    rpm = random.randrange(1000, 4000)
    spdAccel = random.randrange(-3, 6)
    prevSpd += spdAccel
    
    if(prevSpd < 0) :
        prevSpd = 0
    elif(prevSpd > 160) :
        prevSpd = 160
        
    egOilTmp = random.randrange(40,60)
    
    result = str(ts) + "," + str(msgCnt) + "," + str(coolTmp) + "," + str(rpm) + "," + "0" + "," + str(prevSpd)    + "," + str(egOilTmp) 
    
    print(result)
    
    f = open('obd_data.txt', 'w')
    f.write(result + '\n')
    f.close()
    
    
    
    
    time.sleep(1)
    
    
    msgCnt = msgCnt + 1