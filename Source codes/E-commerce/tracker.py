import asyncio
from bleak import BleakClient, BleakScanner
from bleak.backends.characteristic import BleakGATTCharacteristic
from array import array
import numpy as np
import json
file_count = 0

#设备的Characteristic UUID
# par_notification_characteristic="0000ae02-0000-1000-8000-00805f9b34fb"
par_notification_characteristic=0x0007
#设备的Characteristic UUID（具备写属性Write）
# par_write_characteristic="0000ae01-0000-1000-8000-00805f9b34fb"
par_write_characteristic=0x0005

par_device_addr="ce:9f:3e:88:4d:1b" #设备的MAC地址 此处需要填入设备的mac地址

#准备发送的消息，为“hi world\n”的HEX形式（包括回车符0x0A 0x0D）
# send_str=bytearray([0x68,0x69,0x20,0x77,0x6F,0x72,0x6C,0x64,0x0A,0x0D])

#监听回调函数，此处为打印消息
def notification_handler(characteristic: BleakGATTCharacteristic, data: bytearray):
    #print("rev data:",data)
    parse_imu(data)

def parse_imu(buf):
    scaleAccel       = 0.00478515625      # 加速度 [-16g~+16g]    9.8*16/32768
    scaleQuat        = 0.000030517578125  # 四元数 [-1~+1]         1/32768
    scaleAngle       = 0.0054931640625    # 角度   [-180~+180]     180/32768
    scaleAngleSpeed  = 0.06103515625      # 角速度 [-2000~+2000]    2000/32768
    scaleMag         = 0.15106201171875   # 磁场 [-4950~+4950]   4950/32768
    scaleTemperature = 0.01               # 温度
    scaleAirPressure = 0.0002384185791    # 气压 [-2000~+2000]    2000/8388608
    scaleHeight      = 0.0010728836       # 高度 [-9000~+9000]    9000/8388608

    imu_dat = array('f',[0.0 for i in range(0,34)])

    if buf[0] == 0x11:
        ctl = (buf[2] << 8) | buf[1]
        #print("\n subscribe tag: 0x%04x"%ctl)
        #print(" ms: ", ((buf[6]<<24) | (buf[5]<<16) | (buf[4]<<8) | (buf[3]<<0)))

        L =7 # 从第7字节开始根据 订阅标识tag来解析剩下的数据
        if ((ctl & 0x0001) != 0):
            tmpX = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAccel; L += 2 
            #print("\taX: %.3f"%tmpX); # x加速度aX
            tmpY = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAccel; L += 2 
            #print("\taY: %.3f"%tmpY); # y加速度aY
            tmpZ = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAccel; L += 2
            #print("\taZ: %.3f"%tmpZ); # z加速度aZ

            imu_dat[0] = float(tmpX)
            imu_dat[1] = float(tmpY)
            imu_dat[2] = float(tmpZ)
        
        if ((ctl & 0x0002) != 0):
            tmpX = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAccel; L += 2
            #print("\tAX: %.3f"%tmpX) # x加速度AX
            tmpY = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAccel; L += 2
            #print("\tAY: %.3f"%tmpY) # y加速度AY
            tmpZ = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAccel; L += 2
            #print("\tAZ: %.3f"%tmpZ) # z加速度AZ

            imu_dat[3] = float(tmpX)
            imu_dat[4] = float(tmpY)
            imu_dat[5] = float(tmpZ)

        if ((ctl & 0x0004) != 0):
            tmpX = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAngleSpeed; L += 2 
            #print("\tGX: %.3f"%tmpX) # x角速度GX
            tmpY = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAngleSpeed; L += 2 
            #print("\tGY: %.3f"%tmpY) # y角速度GY
            tmpZ = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAngleSpeed; L += 2
            #print("\tGZ: %.3f"%tmpZ) # z角速度GZ

            imu_dat[6] = float(tmpX)
            imu_dat[7] = float(tmpY)
            imu_dat[8] = float(tmpZ)
        
        if ((ctl & 0x0008) != 0):
            tmpX = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleMag; L += 2
            print("\tCX: %.3f"%tmpX); # x磁场CX
            tmpY = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleMag; L += 2
            print("\tCY: %.3f"%tmpY); # y磁场CY
            tmpZ = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleMag; L += 2
            print("\tCZ: %.3f"%tmpZ); # z磁场CZ

            # 保存为JSON文件的部分

            global file_count
            file_count += 1
            # data_to_save = {[tmpX, tmpY]}
            with open(f"D://mini_proj//testWeb//src//main//webapp//tmp_points//{file_count}.txt", "w") as file:
                file.write(f"{tmpX} {tmpY}")
            print(f"Data saved to {file_count}.json")

            imu_dat[9] = float(tmpX)
            imu_dat[10] = float(tmpY)
            imu_dat[11] = float(tmpZ)
        
        if ((ctl & 0x0010) != 0):
            tmpX = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleTemperature; L += 2
            #print("\ttemperature: %.2f"%tmpX) # 温度

            tmpU32 = np.uint32(((np.uint32(buf[L+2]) << 16) | (np.uint32(buf[L+1]) << 8) | np.uint32(buf[L])))
            if ((tmpU32 & 0x800000) == 0x800000): # 若24位数的最高位为1则该数值为负数，需转为32位负数，直接补上ff即可
                tmpU32 = (tmpU32 | 0xff000000)      
            tmpY = np.int32(tmpU32) * scaleAirPressure; L += 3
            #print("\tairPressure: %.3f"%tmpY); # 气压

            tmpU32 = np.uint32((np.uint32(buf[L+2]) << 16) | (np.uint32(buf[L+1]) << 8) | np.uint32(buf[L]))
            if ((tmpU32 & 0x800000) == 0x800000): # 若24位数的最高位为1则该数值为负数，需转为32位负数，直接补上ff即可
                tmpU32 = (tmpU32 | 0xff000000)
            tmpZ = np.int32(tmpU32) * scaleHeight; L += 3 
            #print("\theight: %.3f"%tmpZ); # 高度

            imu_dat[12] = float(tmpX)
            imu_dat[13] = float(tmpY)
            imu_dat[14] = float(tmpZ)

        if ((ctl & 0x0020) != 0):
            tmpAbs = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleQuat; L += 2
            #print("\tw: %.3f"%tmpAbs); # w
            tmpX =   np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleQuat; L += 2
            #print("\tx: %.3f"%tmpX); # x
            tmpY =   np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleQuat; L += 2
            #print("\ty: %.3f"%tmpY); # y
            tmpZ =   np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleQuat; L += 2
            #print("\tz: %.3f"%tmpZ); # z

            imu_dat[15] = float(tmpAbs)
            imu_dat[16] = float(tmpX)
            imu_dat[17] = float(tmpY)
            imu_dat[18] = float(tmpZ)

        if ((ctl & 0x0040) != 0):
            tmpX = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAngle; L += 2
            #print("\tangleX: %.3f"%tmpX); # x角度
            tmpY = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAngle; L += 2
            #print("\tangleY: %.3f"%tmpY); # y角度
            tmpZ = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAngle; L += 2
            #print("\tangleZ: %.3f"%tmpZ); # z角度

            imu_dat[19] = float(tmpX)
            imu_dat[20] = float(tmpY)
            imu_dat[21] = float(tmpZ)

        if ((ctl & 0x0080) != 0):
            tmpX = np.short((np.short(buf[L+1])<<8) | buf[L]) / 1000.0; L += 2
            #print("\toffsetX: %.3f"%tmpX); # x坐标
            tmpY = np.short((np.short(buf[L+1])<<8) | buf[L]) / 1000.0; L += 2
            #print("\toffsetY: %.3f"%tmpY); # y坐标
            tmpZ = np.short((np.short(buf[L+1])<<8) | buf[L]) / 1000.0; L += 2
            #print("\toffsetZ: %.3f"%tmpZ); # z坐标

            imu_dat[22] = float(tmpX)
            imu_dat[23] = float(tmpY)
            imu_dat[24] = float(tmpZ)

        if ((ctl & 0x0100) != 0):
            tmpU32 = ((buf[L+3]<<24) | (buf[L+2]<<16) | (buf[L+1]<<8) | (buf[L]<<0)); L += 4
            #print("\tsteps: %u"%tmpU32); # 计步数
            tmpU8 = buf[L]; L += 1
            if (tmpU8 & 0x01):# 是否在走路
                #print("\t walking yes")
                imu_dat[25] = 100
            else:
                #print("\t walking no")
                imu_dat[25] = 0
            if (tmpU8 & 0x02):# 是否在跑步
                #print("\t running yes")
                imu_dat[26] = 100
            else:
                #print("\t running no")
                imu_dat[26] = 0
            if (tmpU8 & 0x04):# 是否在骑车
                #print("\t biking yes")
                imu_dat[27] = 100
            else:
                #print("\t biking no")
                imu_dat[27] = 0
            if (tmpU8 & 0x08):# 是否在开车
                #print("\t driving yes")
                imu_dat[28] = 100
            else:
                #print("\t driving no")
                imu_dat[28] = 0

        if ((ctl & 0x0200) != 0):
            tmpX = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAccel; L += 2
            #print("\tasX: %.3f"%tmpX); # x加速度asX
            tmpY = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAccel; L += 2
            #print("\tasY: %.3f"%tmpY); # y加速度asY
            tmpZ = np.short((np.short(buf[L+1])<<8) | buf[L]) * scaleAccel; L += 2
            #print("\tasZ: %.3f"%tmpZ); # z加速度asZ
        
            imu_dat[29] = float(tmpX)
            imu_dat[30] = float(tmpY)
            imu_dat[31] = float(tmpZ)
            
        if ((ctl & 0x0400) != 0):
            tmpU16 = ((buf[L+1]<<8) | (buf[L]<<0)); L += 2
            #print("\tadc: %u"%tmpU16); # adc测量到的电压值，单位为mv
            imu_dat[32] = float(tmpU16)

        if ((ctl & 0x0800) != 0):
            tmpU8 = buf[L]; L += 1
            #print("\t GPIO1  M:%X, N:%X"%((tmpU8>>4)&0x0f, (tmpU8)&0x0f))
            imu_dat[33] = float(tmpU8)

    else:
        print("[error] data head not define")

async def main():
    print("starting scan...")

    #基于MAC地址查找设备
    device = await BleakScanner.find_device_by_address(
        par_device_addr, cb=dict(use_bdaddr=False)  #use_bdaddr判断是否是MOC系统
    )
    if device is None:
        print("could not find device with address '%s'", par_device_addr)
        return

    #事件定义
    disconnected_event = asyncio.Event()

    #断开连接事件回调
    def disconnected_callback(client):
        print("Disconnected callback called!")
        disconnected_event.set()

    print("connecting to device...")
    async with BleakClient(device,disconnected_callback=disconnected_callback) as client:
        print("Connected")
        await client.start_notify(par_notification_characteristic, notification_handler)
   
        # 保持连接 0x29
        wakestr=bytes([0x29])
        await client.write_gatt_char(par_write_characteristic, wakestr)
        await asyncio.sleep(0.2)
        print("------------------------------------------------")
        # 尝试采用蓝牙高速通信特性 0x46
        fast=bytes([0x46])
        await client.write_gatt_char(par_write_characteristic, fast)
        await asyncio.sleep(0.2)

        # GPIO 上拉
        #upstr=bytes([0x27,0x10])
        #await client.write_gatt_char(par_write_characteristic, upstr)
        #await asyncio.sleep(0.2)

        # 参数设置
        isCompassOn = 0 #使用磁场融合姿态
        barometerFilter = 2
        Cmd_ReportTag = 0x0FFF # 功能订阅标识
        params = bytearray([0x00 for i in range(0,11)])
        params[0] = 0x12
        params[1] = 5       #静止状态加速度阀值
        params[2] = 255     #静止归零速度(单位cm/s) 0:不归零 255:立即归零
        params[3] = 0       #动态归零速度(单位cm/s) 0:不归零
        params[4] = ((barometerFilter&3)<<1) | (isCompassOn&1);   
        params[5] = 60      #数据主动上报的传输帧率[取值0-250HZ], 0表示0.5HZ
        params[6] = 1       #陀螺仪滤波系数[取值0-2],数值越大越平稳但实时性越差
        params[7] = 3       #加速计滤波系数[取值0-4],数值越大越平稳但实时性越差
        params[8] = 5       #磁力计滤波系数[取值0-9],数值越大越平稳但实时性越差
        params[9] = Cmd_ReportTag&0xff
        params[10] = (Cmd_ReportTag>>8)&0xff
        await client.write_gatt_char(par_write_characteristic, params)
        await asyncio.sleep(0.2)

        notes=bytes([0x19])
        await client.write_gatt_char(par_write_characteristic, notes)
        
        # 添加一个循环，使程序在接收数据时不会退出
        while not disconnected_event.is_set():
            await asyncio.sleep(1.0)
            
        #await disconnected_event.wait() #休眠直到设备断开连接，有延迟。此处为监听设备直到断开为止
        #await client.stop_notify(par_notification_characteristic)

asyncio.run(main())