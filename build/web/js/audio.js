var audio = new Audio('./songs/save.mp3');
var videoPlayer = document.getElementById("videoPlayer");
var playButton = document.getElementById("playButton");
var songDuration = document.getElementById("songDuration");
var songActual = document.getElementById("songActual");
var songRange = document.getElementById("songRange"); 
var volumeRange = document.getElementById("volumeRange");
var replayButton = document.getElementById("replayButton");
setInterval(resfresh, 1000);


songRange.addEventListener('mouseup', function() {
    audio.currentTime =  (audio.duration * this.value) / 100;
});

volumeRange.addEventListener('mouseup', function() {
    audio.volume = this.value / 100;
});

function toggleLoop(){
    if (audio.loop){
        audio.loop = false;
        replayButton.className = "fas fa-redo-alt";
    }else{
        audio.loop = true;
        replayButton.className = "fas fa-redo-alt color-green";
    }
}

function resfresh(){
    songActual.innerHTML = convertTime(audio.currentTime);
    songRange.value = getRangeTime();
    
}

function togglePlay(){

    songDuration.innerHTML = convertTime(audio.duration);
    window.document.title = "MUSIFY - " + "Save your tears" 

    if (videoPlayer.paused){
        videoPlayer.play();
        audio.play();
        playButton.className = "fas fa-pause";
    }else{
        videoPlayer.pause();
        audio.pause();
        playButton.className = "fas fa-play";
    }
}

function restartSong(){
    audio.pause();
    videoPlayer.pause();   
    audio.currentTime = 0;
    playButton.className = "fas fa-play";
}

function getRangeTime(){
    return (audio.currentTime * 100) / audio.duration;
}

var convertTime = function(time){    
    var mins = Math.floor(time / 60);
    if (mins < 10) {
      mins = '0' + String(mins);
    }
    var secs = Math.floor(time % 60);
    if (secs < 10) {
      secs = '0' + String(secs);
    }

    return mins + ':' + secs;
}