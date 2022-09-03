


  
  
window.addEventListener("message", function (event) {
    var item = event.data;
    switch (item.type) {
      case "OPEN_MENU":
         $('#app').css('display','block');
         $('.menu-wrapper').removeClass('animate__backOutRight')
         $('.menu-wrapper').addClass('animate__backInRight')
          app.playerdata(item.playertable,item.maxplayer,item.playeridentifier,item.service,item.servername)
         
          app.playerurl(item.playertable)
      break;
      case "UPDATE_JOBS":
       app.job(item.jobtable)
    
     break;
   
    }
});
  
  
  
  
  
  const app = new Vue({
    el: "#app",
  
    data: {

      playertable :'',
      maxplayer : '',
      playeridentifier : '',
      playerimage  : '',
     
      search :'',
      service :'',
      jobtable : '',
      servername : '',
    
    },
    methods : {
    
      playerdata(val,maxply,plyidentifier,clientservice,server){
        this.playertable = val;
        this.maxplayer = maxply;
        this.playeridentifier = plyidentifier
        this.service = clientservice
        this.servername = server
      },

      job(val){
        this.jobtable = val
      },
  
      playerurl(val){
       
        if(this.service == 'steam'){
          val.forEach(element => {
      
            var xhr = new XMLHttpRequest();
            xhr.responseType = "text";
            xhr.open('GET', element.playersteamid, true);
            xhr.send();
            const processRequest = () => {
              if (xhr.readyState == 4 && xhr.status == 200) {
               var string = xhr.responseText.toString();
               var array = string.split("avatarfull");
               var array2 = array[1].toString().split('"');
                element.playerimage = array2[2].toString()
            
              }
              }
            xhr.onreadystatechange = processRequest;
  
          });   
        }
       
       
      
      }
    },

    
    computed: {
      filterByTerm() {
        if(this.search.length > 0 ){
          return this.playertable.filter((playername) => { return playername.playername.toLowerCase().includes(this.search.toLowerCase())})
        }else{
          return this.playertable
        }
      },
    

    },

  
  })

  
  
  
  $(document).keydown(function (e) {
    if (e.keyCode == 27) {
      $.post("https://codem-scoreboard/close");
    //   $('#app').css('display','none');
    $('.menu-wrapper').removeClass('animate__backInRight')
      $('.menu-wrapper').addClass('animate__backOutRight')
      $('#app').css('display','block');
     
    }
  });