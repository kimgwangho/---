import random
import time
import datetime

prevSpd = 0
msgCnt = 1
remainOil = 50
consumeOil = 0

while(True) :
    
    #ts = time.time()
    ts = datetime.datetime.now()
    rpm = random.randrange(1000, 4000)
    spdAccel = random.randrange(-3, 6)
    prevSpd += spdAccel
    
    if(prevSpd < 0) :
        prevSpd = 0
    elif(prevSpd > 160) :
        prevSpd = 160
        
    coolTmp = random.randrange((int)(prevSpd/4) + 20 , (int)(prevSpd/4 + 25))
    egOilTmp = random.randrange((int)(prevSpd/4) + 40, (int)(prevSpd/4) + 45)
    
    remainOil = remainOil - prevSpd / 3600
    consumeOil = 50 - remainOil
    
    result = str(ts) + "," + str(msgCnt) + "," + str(coolTmp) + "," + str(rpm) + "," + "0" + "," + str(prevSpd)    + "," + str(egOilTmp)  + "," + str(remainOil) + "," + str(consumeOil)
    
    print(result)


    f = open('obd_data.txt', 'w')
    f.write(result + '\n')
    f.close()
    
    
    
    
    time.sleep(1)
    

    msgCnt = msgCnt + 1