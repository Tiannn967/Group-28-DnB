from flask import Flask, Response
import cv2
from ultralytics import YOLO

app = Flask(__name__)
# Load the YOLO model
model = YOLO(r"C:\\Python\\miniCourse\\yolov8\\runs\\detect\\train8\\weights\\best.pt")

def detect_objects(frame):
    # Detect objects in the frame using the YOLO model
    results = model(frame)
    return results[0].boxes

def generate_frames():
    cap = cv2.VideoCapture(0) # Open the video capture device (camera)
    lastcls = -1
    i = 0
    count = 0

    while cap.isOpened():
        success, frame = cap.read() # Read a frame from the video capture

        if not success:
            break
        else:
            results = detect_objects(frame) # Detect objects in the current frame

            for bbox in results.cpu().numpy():
                xyxy = bbox.xyxy
                x1, y1, x2, y2 = int(xyxy[0][0]), int(xyxy[0][1]), int(xyxy[0][2]), int(xyxy[0][3])

                conf = bbox.conf  # Confidence score for the detection
                cls = int(bbox.cls)  # Class index of the detected object

                if cls == lastcls:
                    i += 1
                    if i == 10:
                        # Save the captured frame with a unique filename
                        filename = f"captured_frame_{count}.jpg"
                        cv2.imwrite(filename, frame)
                else:
                    i = 0

                print(model.names[cls])  # Print the class name of the detected object

                # Draw a rectangle around the detected object
                cv2.rectangle(frame, color=(0, 255, 0), pt1=(x1, y1), pt2=(x2, y2))

                # Display the class name of the detected object
                cv2.putText(frame, f"{model.names[cls]}",
                            (x1, y1 - 10),
                            cv2.FONT_HERSHEY_SIMPLEX,
                            0.5,
                            (0, 255, 0),
                            2)
                lastcls = cls

            # Encode the frame as JPEG
            _, buffer = cv2.imencode('.jpg', frame)
            frame = buffer.tobytes()
            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')
        count += 1

@app.route('/video_feed')
def video_feed():
    # Return a multipart response for video streaming
    return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == '__main__':
    # Run the Flask application
    app.run(debug=False)
