<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Combined Feed</title>
    <script type="text/javascript">
        var video = document.getElementById('video');  // Assuming you have a video element with id 'video'
        var detectionText = document.getElementById('detectionText');  // Assuming you have an element for displaying detection results
        var eventSource = new EventSource('http://127.0.0.1:5000/combined_feed');  // Connect to the combined_feed endpoint

        eventSource.onmessage = function (event) {
            if (event.data.startsWith("data:")) {
                // Handle detection result
                var detectionResult = event.data.substring(5);
                console.log("Detection Result: " + detectionResult);
                // Update the DOM element to display the detection result
                detectionText.innerText = detectionResult;
            } else {
                // Handle video stream
                video.src = "data:image/jpeg;base64," + event.data;
            }
        };
    </script>
</head>
<body>
    <video id="video" width="640" height="480" autoplay></video>
    <div id="detectionText"></div>
</body>
</html>
