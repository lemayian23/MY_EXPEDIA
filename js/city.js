$(document).ready(function(){
    const addnewbutton=$("#addnewcity"),
        citydetailsmodal=$("#citydetailsmodal"),
        filtercountylist=$("#filtercountry"),
        citycountrylist=$("#citydetailscountry"),
        filtercitynotifications=$("#filtercitynotifications"),
        citynamefield=$("#citydetailscityname"),
        savecitybutton=$("#savecity"),
        citydetailnotifications=$("#citydetailsnotifications"),
        cityidfield=$("#cityid"),

        //global variable
        inputfield=$("input"),
        selectfield=$("select")

    // load counties from the database
    getcountries(filtercountylist,'all')
    getcountries(citycountrylist)

    inputfield.on("input",function(){
        citydetailnotifications.html("")
    })

    selectfield.on("change",function(){
        inputfield.trigger("input")
    })

    // listen to city click button and show modal
    addnewbutton.on("click",function(){
        citydetailsmodal.modal("show")
    })

    function getcountries(obj,option='choose'){
        $.getJSON(
            "controllers/countryoperations.php",
            {
                getcountries:true
            }
        ).done(function(data){
            let results=option=='choose'?
            `<option value=''>&lt;Choose&gt;</option>`:
            `<option value='0'>&lt;All&gt;</option>`
            data.forEach(function(country){
                results+=`<option value='${country.countryid}'>${country.countryname}</option>`
            })
            obj.html(results) 
        }).fail(function(response,status,error){
            filtercitynotifications.html(`<div class='alert alert-danger'>${response.responseText}</div>`)
        })
    }

    // save city
    savecitybutton.on("click",function(){
        const cityid=cityidfield.val(),
            countryid=citycountrylist.val(),
            cityname=citynamefield.val()
        // check for blank fields
        if(countryid==""){
            citydetailnotifications.html(`<alert class='alert alert-info'>Please select city first</div>`)
            citycountrylist.focus()
        }else if(cityname==""){
            citydetailnotifications.html(`<alert class='alert alert-info'>Please provide city name first</div>`)
            citynamefield.focus()
        }else{
            $.post(
                "controllers/cityoperations.php",
                {
                    savecity:true,
                    cityid:cityid,
                    cityname:cityname,
                    countryid:countryid
                },
                function(data){
                    if(isJSON(data)){
                        data=JSON.parse(data)
                        if(data.status=="success"){
                            citydetailnotifications.html(`<alert class='alert alert-success'>The city was saved succesfully</div>`)
                            citynamefield.val("").focus()
                        }else if(data.status=="exists"){
                            citydetailnotifications.html(`<alert class='alert alert-info'>The city name already exists</div>`)
                            citynamefield.focus()
                        }
                    }else{
                        citydetailnotifications.html(`<alert class='alert alert-danger'>Sorry an error occured ${data}</div>`)
                    }
                }
            )
        }
    })

    function isJSON(str) {
        try {
            return (JSON.parse(str) && !!str);
        } catch (e) {
            return false;
        }
    }
})