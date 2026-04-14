<?php
sessionn_start();
session_destroy();
header('Location: admin_login.php');