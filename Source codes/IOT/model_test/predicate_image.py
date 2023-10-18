from ultralytics import YOLO
import cv2

# Load a pretrained YOLO model
model = YOLO("C:\\Python\\miniCourse\\yolov8\\runs\\detect\\train8\\weights\\best.pt")

# Path to the image for detection
img_path = "C:\\Users\\20362\\Desktop\\test"

# Perform object detection on the image and save the results
results = model.predict(img_path, save=True, save_txt=True, conf=0.4)
