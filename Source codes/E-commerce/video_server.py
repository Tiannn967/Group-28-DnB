from flask import Flask, Response
import cv2
from ultralytics import YOLO

url = "http://192.168.8.1:8083/?action=stream"
app = Flask(__name__)
model = YOLO(r"D://mini_proj//best.pt")

def detect_objects(frame):
     results = model(frame)
     return results[0].boxes
 # Extract detection results
def generate_frames():
    cap = cv2.VideoCapture(url) #
    lastcls=-1
    i=0
    count=0
    while cap.isOpened():
        success, frame = cap.read()
        if not success:
            break
        else:
            results = detect_objects(frame)


            for bbox in results.cpu().numpy():
                xyxy = bbox.xyxy
                x1, y1, x2, y2 = int (xyxy[0][0]), int(xyxy[0][1]), int(xyxy[0][2]), int(xyxy[0][3])


                conf = bbox.conf  # Use conf attribute to get confidence
                cls = int(bbox.cls)  # Use cls attribute to get class
                if cls==lastcls:
                    i+=1
                    if i==3:
                        filename = f"D://mini_proj//testWeb//src//main//webapp//tmp_pictures//{model.names[cls]}_{count}.jpg"
                        cv2.imwrite(filename,frame)
                else:
                    i=0


                print(model.names[cls])


                cv2.rectangle(frame,color=(0, 255, 0),pt1=(x1,y1),pt2=(x2,y2))


                cv2.putText(frame, f"{model.names[cls]}",
                            (x1, y1 - 10),
                            cv2.FONT_HERSHEY_SIMPLEX,
                            0.5,
                            (0, 255, 0),
                            2)
                lastcls=cls

            # Encode the frame as JPEG
            _, buffer = cv2.imencode('.jpg', frame)
            frame = buffer.tobytes()
            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')
        count+=1


@app.route('/video_feed')
def video_feed():
    return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == '__main__':
    app.run(debug=False)
