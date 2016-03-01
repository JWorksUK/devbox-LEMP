<html>
    <head>
        <title>Welcome to Test.com!</title>
    </head>
    <body>
        <h1>Success!  The test.com server block is working!</h1>

        <?php
            $servername = "localhost";
            $username = "root";
            $password = "secret";

            // Create connection
            $conn = new mysqli($servername, $username, $password);

            // Check connection
            if ($conn->connect_error) {
                die("Connection failed: " . $conn->connect_error);
            } 
            echo "<p>Connected successfully</p>";
        ?>
    </body>
</html>


