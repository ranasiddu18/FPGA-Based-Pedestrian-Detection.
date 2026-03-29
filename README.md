

## FPGA Based Real-Time Pedestrian Detection Using HOG + SVM

## 1. Introduction

This project implements a **real-time pedestrian detection system on an FPGA** using a CMOS camera.
The system captures live video from an **OV7670 camera**, processes each frame through a hardware image processing pipeline, extracts **Histogram of Oriented Gradients (HOG) features**, and classifies the features using a **Support Vector Machine (SVM)** to detect pedestrians.

If a pedestrian is detected in the camera frame, an **LED on the FPGA board turns ON**.

The entire processing pipeline is implemented in **Verilog HDL** and synthesized on an **Artix-7 FPGA (xc7a35tff256-1)**.

This project demonstrates:

* Real-time image processing on FPGA
* Hardware implementation of HOG feature extraction
* Hardware classification using SVM
* Streaming image processing pipeline

---

# 2. Hardware Used

### FPGA Board

EDGE Artix-7 Development Board

FPGA device:

```
xc7a35tff256-1
```

### Camera Module

```
OV7670 CMOS Camera
```

Resolution:

```
640 × 480 (default)
```

Camera outputs:

* Pixel clock (PCLK)
* VSYNC
* HREF
* 8-bit pixel data

---

# 3. Software Tools

Tool used:

```
Xilinx Vivado
```

Design language:

```
Verilog HDL
```

Design flow:

```
RTL Design
→ Simulation
→ Synthesis
→ Implementation
→ Bitstream Generation
→ FPGA Programming
```

---

# 4. Project Goal

The goal of the project is to detect pedestrians using a hardware pipeline that performs the following operations:

1. Capture image from camera
2. Convert RGB image to grayscale
3. Detect edges using Sobel filter
4. Calculate gradient orientation
5. Build HOG feature histogram
6. Classify using SVM
7. Output detection signal

If a pedestrian is detected in a frame, the FPGA **activates an LED**.

---

# 5. System Architecture

The pedestrian detection pipeline is implemented as a **streaming hardware architecture**.

Pipeline:

```
Camera
   ↓
Camera Capture
   ↓
RGB to Grayscale
   ↓
Line Buffer
   ↓
Sobel Edge Detection
   ↓
Gradient Orientation
   ↓
HOG Histogram
   ↓
Cell Controller
   ↓
SVM Classifier
   ↓
Detection Filter
   ↓
Frame Detector
   ↓
LED Output
```

Each module processes pixels sequentially in a pipeline.

---

# 6. Image Processing Pipeline

The FPGA processes pixels **as a stream**, meaning each pixel flows through the pipeline one after another.

This allows **real-time processing without storing entire frames**.

---

# 7. Module Descriptions

## 7.1 Camera Clock Generator

The OV7670 camera requires a clock signal.

The FPGA generates a clock for the camera:

```
Input clock → Camera clock (XCLK)
```

Module:

```
camera_clock
```

Output:

```
ov7670_xclk
```

---

# 7.2 OV7670 Configuration

The camera must be configured through the **SCCB interface (similar to I2C)**.

Configuration includes:

* Resolution
* Color format
* Frame settings

Module:

```
ov7670_config
```

Signals used:

```
sioc
siod
```

---

# 7.3 Camera Capture Module

This module captures pixel data from the camera.

Inputs:

```
pclk
vsync
href
cam_data[7:0]
```

Output:

```
pixel[15:0] (RGB565 format)
pixel_valid
```

The module reconstructs pixels from the camera data stream.

Module:

```
camera_capture
```

---

# 7.4 RGB to Grayscale Conversion

The camera outputs color pixels in **RGB565 format**.

These are converted to grayscale to simplify processing.

Formula used:

```
Gray = weighted combination of R, G, B
```

Module:

```
rgb_to_gray
```

Outputs:

```
gray_pixel
gray_valid
```

---

# 7.5 Line Buffer

Edge detection requires a **3×3 pixel window**.

The line buffer stores previous rows of pixels to generate this window.

Output pixels:

```
p1 p2 p3
p4 p5 p6
p7 p8 p9
```

Module:

```
line_buffer
```

---

# 7.6 Sobel Edge Detection

The Sobel operator calculates **horizontal and vertical gradients**.

Formulas:

```
Gx = horizontal gradient
Gy = vertical gradient
```

Edge magnitude:

```
|G| = |Gx| + |Gy|
```

Module:

```
sobel_filter
```

Outputs:

```
gx
gy
edge magnitude
```

---

# 7.7 Gradient Orientation

The gradient direction determines the **edge orientation**.

Orientation is mapped into bins.

Example bins:

```
0°
22°
45°
67°
90°
112°
135°
157°
```

Module:

```
orientation_bin
```

Output:

```
bin number (0–7)
```

---

# 7.8 HOG Histogram

HOG stands for:

```
Histogram of Oriented Gradients
```

For each cell (8×8 pixels), a histogram of gradient directions is calculated.

Example:

```
h0
h1
h2
...
h15
```

These represent gradient strength for each orientation bin.

Module:

```
hog_histogram
```

---

# 7.9 Cell Controller

Controls the histogram reset and cell completion.

It tracks how many pixels belong to each HOG cell.

Module:

```
hog_cell_controller
```

Outputs:

```
cell_done
reset_hist
```

---

# 7.10 SVM Classifier

The SVM classifier decides whether the extracted HOG features correspond to a pedestrian.

Input:

```
16 HOG features
```

The classifier performs a weighted sum:

```
score = w1*h1 + w2*h2 + ... + w16*h16
```

If the score exceeds a threshold:

```
Pedestrian detected
```

Module:

```
svm_classifier
```

Output:

```
detect_pixel
```

---

# 7.11 Detection Filter

Raw detection can be noisy.

This module filters out short false detections.

Module:

```
detection_filter
```

---

# 7.12 Frame Counter

Detects when a new frame begins.

Uses the VSYNC signal.

Module:

```
frame_counter
```

---

# 7.13 Frame Detector

If any detection occurs within a frame, the output is activated once.

Output:

```
detect_frame
```

Module:

```
frame_detector
```

---

# 8. Final Output

The final detection signal drives an LED.

```
If pedestrian detected → LED ON
Otherwise → LED OFF
```

---

# 9. FPGA Implementation Flow

The design flow used:

```
Write Verilog modules
       ↓
Simulate pipeline
       ↓
Run synthesis
       ↓
Fix synthesis errors
       ↓
Run implementation
       ↓
Resolve clock routing constraints
       ↓
Generate bitstream
       ↓
Program FPGA
```

---

# 10. Constraint File (XDC)

The XDC file defines FPGA pin connections.

Main signals mapped:

```
System Clock
Camera Signals
Detection LED
```

Camera pins include:

```
pclk
vsync
href
data[7:0]
sioc
siod
xclk
reset
pwdn
```

---

# 11. Expected System Behavior

When the camera is connected:

1. Camera starts streaming frames
2. FPGA processes each pixel
3. HOG features are extracted
4. SVM classifier evaluates features
5. If pedestrian detected → LED turns ON

Detection occurs **in real time**.

---

# 12. Applications

This system can be used in:

* Autonomous vehicles
* Driver assistance systems
* Smart surveillance
* Robotics
* Intelligent transportation

---

# 13. Key Learning Outcomes

This project demonstrates:

* FPGA based image processing
* Real time hardware pipelines
* HOG feature extraction
* Machine learning implementation in hardware
* Camera interface design
* Verilog hardware architecture

---

# 14. Conclusion

A complete real-time pedestrian detection system was implemented on an FPGA using an OV7670 camera. The design processes image data in a streaming pipeline and uses HOG feature extraction with an SVM classifier to detect pedestrians.

The system demonstrates how computer vision algorithms can be efficiently implemented in hardware for real-time applications.

---


## Elaborated Board Design
<img width="1570" height="994" alt="image" src="https://github.com/user-attachments/assets/b302d45d-5d39-4e65-9c0f-5c1d432cd13f" />


---

## Simulation 
<img width="1573" height="921" alt="Screenshot 2026-03-11 011341" src="https://github.com/user-attachments/assets/949ea4b8-f492-4261-9db9-bc52f9a3f2f5" />


---
