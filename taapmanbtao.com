
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Taapmaan Btao</title>
    <style>
         
        body {
            background-image: url('https://media.istockphoto.com/id/509139773/photo/cloudy-blue-sky-with-sun-beam.jpg?s=612x612&w=0&k=20&c=fr3rjZ5gdtd4N7H223nroyMZ0Ngm3w5VN2oZk7cahyk='); /* Path to your image */
            background-size: cover;  /* Ensures the image covers the entire screen */
            background-position: center; /* Centers the image */
            background-attachment: fixed; /* Makes the image stay fixed when scrolling */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh; /* Full viewport height */
            
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .weather-container {
            text-align: center;
            padding: 20px;
            border: 2px solid #ccc;
            border-radius: 8px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
        }

        .input-container {
            margin-bottom: 20px;
        }

        input {
            padding: 10px;
            font-size: 14px;
            border-radius: 5px;
            border: 1px solid #ccc;
            width: 60%;
            margin-right: 10px;
        }

        button {
            padding: 10px 20px;
            font-size: 14px;
            cursor: pointer;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: #4CAF50;
            color: white;
        }

        button:hover {
            background-color: #45a049;
        }

        #weather-result {
            margin-top: 20px;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 5px;
        }

        #weather-result.hidden {
            display: none;
        }
    </style>
</head>
<body>
    <div class="weather-container">
        <h1>Taapmaan Btao</h1>
        <h4>Umid hai mausam acha hoga</h4>
        <a href="https://www.instagram.com/backbencher_boys07/" target="_blank" class="instagram-link">
            Follow me on Instagram 📸
        </a>
        
        <div class="input-container">
            <input type="text" id="location" placeholder="Enter city name">
            <button onclick="getWeather()">Get Weather</button>
        </div>
        
        <div id="weather-result" class="hidden">
            <h2>Weather in <span id="city-name"></span></h2>
            <p><strong>Temperature:</strong> <span id="temperature"></span> °C</p>
            <p><strong>Condition:</strong> <span id="condition"></span></p>
            <p><strong>Air Quality Index (AQI):</strong> <span id="aqi"></span></p>
            <p><strong> jao enjoy kro ⛅️<strong></span></p>
        </div>
    </div>

    <script>
        async function getWeather() {
            const location = document.getElementById("location").value;
            const apiKey = "a8cab0c527704144ab3173035253001";
            const url = `http://api.weatherapi.com/v1/current.json?key=${apiKey}&q=${location}&aqi=yes`;

            try {
                const response = await fetch(url);
                const data = await response.json();

                if (data.error) {
                    alert("Error: " + data.error.message);
                    return;
                }

                // Extract weather data
                const city = data.location.name;
                const temperature = data.current.temp_c;
                const condition = data.current.condition.text;
                const aqi = data.current.air_quality.pm2_5;

                // Update the UI
                document.getElementById("city-name").textContent = city;
                document.getElementById("temperature").textContent = temperature;
                document.getElementById("condition").textContent = condition;
                document.getElementById("aqi").textContent = aqi.toFixed(2);

                // Show the result
                document.getElementById("weather-result").classList.remove("hidden");
            } catch (error) {
                console.error("Error fetching weather data:", error);
                alert("Something went wrong. Please try again later.");
            }
        }
        
    </script>
</body>
</html>
