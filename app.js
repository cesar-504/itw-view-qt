.pragma library
/*
 *implementacion de ajax en javascript
 */
function func() {
    return "Hola"
}

function ajax(config){
    var type= config.type || 'get'
    var url=config.url || './'
    var success = config.success || function(){console.log('success: '+url)};
    var error = config.error || function(){console.log('error: '+url)};
    var data = config.data

    var request = new XMLHttpRequest();
    request.onreadystatechange = function() {
      if (request.readyState == XMLHttpRequest.DONE) {
        if (request.status >= 200 && request.status < 400) {
            success(request.responseText);
        } else {
          error(request.responseText);
        }
      }
    };

    request.open(type, url, true);
    request.send(data);
}


function json(config){
    config.success =function(data){return JSON.parse(data);};
    ajax(config);
}




