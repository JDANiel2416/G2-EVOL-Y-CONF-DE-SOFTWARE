<?php
session_start();
if (isset($_SESSION['chat_history'])) {
    unset($_SESSION['chat_history']);
}

http_response_code(200);
?>