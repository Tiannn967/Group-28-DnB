# YOLOv8 Inference with GUI and Video Streaming

This project demonstrates real-time object detection using YOLOv8 (You Only Look Once version 8) integrated with a graphical user interface (GUI). The GUI allows users to stream a video and perform object detection with YOLOv8 in real-time. Additionally, it provides options to recognize objects, save images, and set confidence thresholds for detection.

## Table of Contents

- [Features](#features)
- [Usage](#usage)
- [Installation](#installation)
- [Dependencies](#dependencies)


## Features

- Real-time object detection using YOLOv8.
- Graphical user interface for video streaming and object recognition.
- Option to recognize objects in the video stream.
- Ability to save frames as images.
- Adjustable confidence threshold for object detection.

## Usage

1. **Prerequisites**:
   - Ensure you have the necessary dependencies installed (see [Dependencies](#dependencies)).

2. **Run the GUI**:
   - Execute the Python script `gui.py` to launch the GUI for video streaming and object detection.

3. **Interact with the GUI**:
   - Stream a video and adjust the confidence threshold for object detection.
   - Click the "Recognize" button to initiate object recognition and view detected objects.
   - Use the "Save Image" button to save frames as image files.

## Installation

1. **Clone the Repository**:
git clone https://github.com/Tiannn967/Group-28-DnB.git
cd Source codes/IOT
2. **Install Dependencies**:
pip install -r requirements.txt

## Dependencies

- tkinter
- PIL (Pillow)
- cv2 (OpenCV)
- ultralytics (YOLO)





