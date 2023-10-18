import tkinter as tk
from tkinter import filedialog
from PIL import ImageTk, Image
import cv2
from ultralytics import YOLO

# Load the YOLO model
model = YOLO(r"/best(2).pt")

# Initialize the Tkinter GUI
root = tk.Tk()
root.title("YOLOv8 Inference")

# Create two frames for displaying videos
left_frame = tk.Frame(root)
left_frame.pack(side="left", expand=True, fill="y")
left_frame.configure(height=400)  # 设置左侧框架的高度为600像素

right_frame = tk.Frame(root)
right_frame.pack(side="right", expand=True, fill="y")
right_frame.configure(height=400)  # 设置右侧框架的高度为600像素

# Create two labels for displaying video frames
left_label = tk.Label(left_frame)
left_label.pack()
right_label = tk.Label(right_frame)
right_label.pack()
show_TextField = tk.Text(root, state=tk.NORMAL)
show_TextField.pack(side="bottom", fill="both", expand=True)  # 将文本框放置在底部并充满整个空间
# Function to update the video frames
def detect_objects(frame):
    results = model(frame)
    return results[0].boxes
# ... (之前的代码)

# Function to update the video frames

video_file_path = r"C:\Users\20362\Desktop\CarViedo.mp4"
cap = cv2.VideoCapture(video_file_path)

def update_frames():
    global cap
    # Read a frame from the video
    success, frame = cap.read()


    if success:
        # Check if recognition button is clicked
        if recognition_clicked:
            # Run YOLOv8 inference on the frame with the selected confidence threshold
            results = model(frame, conf=confidence_threshold.get())
            results2 = detect_objects(frame)

            for bbox in results2.cpu().numpy():
                conf = bbox.conf  # Use conf attribute to get confidence
                cls = int(bbox.cls)  # Use cls attribute to get class

                # Get the class label corresponding to the class index
                class_label = model.names[cls]


                show_TextField.delete("1.0", tk.END)
                show_TextField.insert(tk.END, f"Detected object: {class_label}")
                show_TextField.pack()

            # Visualize the results on the frame
            annotated_frame = results[0].plot()

            # Convert the frames to Tkinter-compatible images
            original_image = ImageTk.PhotoImage(Image.fromarray(cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)))
            annotated_image = ImageTk.PhotoImage(Image.fromarray(cv2.cvtColor(annotated_frame, cv2.COLOR_BGR2RGB)))

            # Update the labels with the new images
            left_label.config(image=original_image)
            left_label.image = original_image
            right_label.config(image=annotated_image)
            right_label.image = annotated_image

        else:
            # Convert the frame to Tkinter-compatible image
            original_image = ImageTk.PhotoImage(Image.fromarray(cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)))

            # Update the label with the new image
            left_label.config(image=original_image)
            left_label.image = original_image

    # Schedule the next frame update
    root.after(1, update_frames)

# ... (之后的代码)


# Function to handle recognition button click
def recognize():
    global recognition_clicked
    recognition_clicked = True
    recognition_button.config(state=tk.DISABLED)  # Disable the button after click

# Function to handle save button click
def save_image():
    # Get the current frame
    _, frame = cap.read()

    # Open a file dialog to select the save path
    file_path = filedialog.asksaveasfilename(defaultextension=".jpg", filetypes=[("JPEG files", "*.jpg")])

    # Check if a file path is selected
    if file_path:
        # Save the frame as an image file
        cv2.imwrite(file_path, frame)

# Open the video capture
cap = cv2.VideoCapture("http://192.168.8.1:8083/?action=stream")

# Start updating the video frames
recognition_clicked = False
update_frames()

# Create the recognition button
recognition_button = tk.Button(root, text="Recognize", command=recognize)
recognition_button.pack()

# Create the save button
save_button = tk.Button(root, text="Save Image", command=save_image)
save_button.pack()

# Create the confidence threshold slider
confidence_threshold = tk.DoubleVar()
confidence_threshold.set(0.5)  # 设置初始的置信度阈值
threshold_slider = tk.Scale(root, from_=0, to=1, resolution=0.01, orient=tk.HORIZONTAL, length=200, label="Confidence Threshold", variable=confidence_threshold)
threshold_slider.pack()





# Start the Tkinter event loop
root.mainloop()

# Release the video capture object
cap.release()