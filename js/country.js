$(document).ready(function(){
    const countrymodal=$("#countrydetailsmodal"),
        addnewcountrybutton=$("#addnewcountry"),
        countyidfield=$("#countryid"),
        countrynamefield=$("#countryname"),
        savecountrybutton=$("#savecountry"),
        notifications=$("#notifications"),
        countiestable=$("#countriestable"),
        countrynotfications=$("#countrynotifications")
    // Load existing countries
    getcountiesastable()

    addnewcountrybutton.on("click",function(){
        countrymodal.modal("show")
    }) 

    savecountrybutton.on("click",function(){
        const countryname=countrynamefield.val(),
            countryid=countyidfield.val()
        if(countryname==""){
            notifications.html("<div class='alert alert-primary'>Please enter country name</div>")
            countrynamefield.focus()
        }else{
            $.post(
                "controllers/countryoperations.php",
                {
                    savecountry:true,
                    countryid:countryid,
                    countryname:countryname
                },
                function(data){
                    if(isJSON(data)){
                        data=JSON.parse(data)
                        if(data.status=="success"){
                            notifications.html("<div class='alert alert-success'>Country has been saved successfully</div>")
                            countrynamefield.val("")
                            countrynamefield.focus()
                            // Refresh sountries list
                            getcountiesastable()
                        }else if(data.status=="exists"){
                            notifications.html("<div class='alert alert-info'>Country already exists in the system</div>")
                            countrynamefield.focus()
                        }
                    }else{
                        notifications.html(`<div class='alert alert-danger'>Sorry an error occured ${data}</div>`)
                    }
                }
            )
        }
    })

    countrynamefield.on("input",function(){
        notifications.html("")
    })

    function isJSON(str) {
        try {
            return (JSON.parse(str) && !!str);
        } catch (e) {
            return false;
        }
    }

    function getcountiesastable(){
        $.getJSON(
            "controllers/countryoperations.php",
            {
                getcountries:true
            }
        ).done(function(data){
            let results=""
            data.forEach(function(country,i){
                   results+=`<tr><td>${i+1}</td>`   
                   results+=`<td>${country.countryname}</td>`       
                   results+=`<td>${country.cities}</td>`
                   results+=`<td>${country.airports}</td>`  
                   results+=`<td>${country.airlines}</td>` 
                   results+=`<td><a href='#'><i class='fas fa-edit fa-lg'></i></a></td></tr>` 
            })
            // done with looping through the data that is returned
            countiestable.find("tbody").html(results)
        }).fail(function(response, status, error){
            countrynotfications.html(`<div class='alert alert-danger'>${response.responseText}</div>`)
            // console.log(`Sorry an error occured ${response.responseText}`)
        })
    }
})