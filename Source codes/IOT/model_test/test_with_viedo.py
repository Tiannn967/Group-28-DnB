from ultralytics import YOLO
# from ultralytics.yolo.utils.benchmarks import benchmark
import cv2

# Load a model
# model = YOLO("yolov8n.yaml")  # build a new model from scratch
model = YOLO("")  # 改为我们的模型

# Use the model
# model.train(data="coco128.yaml", epochs=3,workers=0)  # train the model,workers=0 if windows
# metrics = model.val()  # evaluate model performance on the validation set
'''
results = model("bus.jpg")  # predict on an image
print(results)
# '''
img_path = "./image/"
# results = model.predict(img_path, save=True,conf=0.5) # device=0 by default, conf:置信度阈值
# results = model.predict(img_path,save=True,classes=[0,2],conf=0.5) # i.e. classes=0,classes=[0,3,4]

# save detection results *
# results = model.predict(img_path,save=True,save_txt=True,classes=0,conf=0.4)



# predict video
video_path = "./video/1.mp4"#视频流
cap = cv2.VideoCapture(0)

# Loop through the video frames
while cap.isOpened():
    # Read a frame from the video
    success, frame = cap.read()

    if success:
        # Run YOLOv8 inference on the frame
        results = model(frame)

        # Visualize the results on the frame
        annotated_frame = results[0].plot()

        # Display the annotated frame
        cv2.imshow("YOLOv8 Inference", annotated_frame)

        # Break the loop if 'q' is pressed
        if cv2.waitKey(1) & 0xFF == ord("q"):
            break
    else:
        # Break the loop if the end of the video is reached
        break

# Release the video capture object and close the display window
cap.release()
cv2.destroyAllWindows()
