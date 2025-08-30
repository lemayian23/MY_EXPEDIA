<?php
    require_once("../models/airline.php");

    $airline=new airline();

    if(isset($_POST['saveairline'])){
        $airlineid=$_POST['airlineid'];
        $airlinename=$_POST['airlinename'];
        $homecountryid=$_POST['homecountryid'];
        $logo=$_POST['logo'];

        $response=$airline->saveairline($airlineid,$airlinename,$homecountryid,$logo);
        echo json_encode($response);

    }

    if(isset($_GET['filterairlines'])){
        $airlinename=isset($_GET['airlinename'])?$_GET['airlinename']:"";
        // $countryname=isset($_GET['countryname'])?$_GET['countryname']:"";
        if(isset($_GET['countryname'])){
            $countryname=$_GET['countryname'];
        }else{
            $countryname="";
        }
        echo $airline->filterairlines($airlinename,$countryname);
    }

    if(isset($_GET['getairlinedetails'])){
        $airlineid=$_GET['airlineid'];
        echo $airline->getairlinedetails($airlineid);
    }

    if(isset($_POST['deleteairline'])){
        $airlineid=$_POST['airlineid'];
        $response=$airline->deleteairline($airlineid);
        echo json_encode($response);
    }

?>