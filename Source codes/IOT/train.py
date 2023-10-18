from ultralytics import YOLO

if __name__=='__main__':
  model = YOLO('yolov8n.pt')
  model.train(
  data = 'C:/Users/ASUS/Desktop/yolov8-minimal-train-demo/yolov8/datasets/demo/data.yaml',
  epochs = 80,
  batch = 16,
  lr0 = 0.001,
  dropout = 0.1,
  label_smoothing = 0.15
)
