import os
import time  # Import sleep directly from the time module
from datetime import datetime

import cv2
import numpy as np
from flask import Response, Flask
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # 添加CORS处理

# 画布尺寸
canvas_size = (800, 600)
# 创建空白画布
canvas = np.zeros((canvas_size[1], canvas_size[0], 3), dtype=np.uint8)

data_directory = r'D:\mini_proj\testWeb\src\main\webapp\tmp_points'  # 修改为你的数据目录
def generate_path_frames():
    i=1

    while True:
        print(len(os.listdir(data_directory)))
        if i >= len(os.listdir(data_directory)):
            continue

        print(i)
        i = i+1
        file_path = os.path.join(data_directory, f'{i}.txt')

        with open(file_path, 'r') as file:
            # 从TXT文件读取坐标数据，修改分隔符为空格
            coordinates = [tuple(map(float, line.strip().split())) for line in file]

        # 处理坐标数据，替换为你的实际处理逻辑
        path_data = generate_path_data(coordinates)

        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + path_data + b'\r\n\r\n')


def generate_path_data(coordinates):
    for x, y in coordinates:
        # 将坐标映射到画布上
        mapped_x = int(np.interp(x, [-180, 180], [0, canvas_size[0]]))
        mapped_y = int(np.interp(y, [-180, 180], [0, canvas_size[1]]))

        # 在画布上绘制圆点
        cv2.circle(canvas, (mapped_x, mapped_y), 3, (255, 255, 255), -1)

    # 返回图像数据
    _, buffer = cv2.imencode('.jpg', canvas)
    return buffer.tobytes()

# 剩下的部分保持不变



@app.route('/path_feed')
def path_feed():
    return Response(generate_path_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == '__main__':
    app.run(debug=True,port=5001)

