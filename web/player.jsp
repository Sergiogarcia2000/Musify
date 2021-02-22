<%@page import="db.Song"%>
<%@page import="java.util.Set"%>
<%@page import="db.Playlist"%>
<%@page import="db.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/styles.css">
    <link rel="icon" href="./img/icon.png">
    <script src="https://kit.fontawesome.com/2d3dba4dd0.js" crossorigin="anonymous"></script>
    <title>Musify</title>
</head>
<body class="bg" onload="load()">
    
    <%
        User user = (User) request.getSession().getAttribute("user");

        if (user == null){
    %>
            <section class="container-fluid transparent">
                <section class="row justify-content-center text-center">
                    <h1 class="col-12 color-white">¡Tienes que iniciar sesion!</h1>
                    <a class="col-2 text-center btn btn-danger" href="./index.jsp">Iniciar sesión</a>
                </section>
            </section>
    <%
        }else{

            Set<Playlist> playLists = user.getPlaylists();
    %>
    
    <section class="container-fluid transparent h-100">
        <section class="row d-flex justify-content-center h-100">

            <section class="col-8 h-100 border">

                <div class="col-12">
                    <div class="row">
                        <img src="./img/logo.png" class="center logo-img">
                    </div>

                    <div class="row div-block d-flex justify-content-center">
                        <div class="col center text-center center">
                            <video id="videoPlayer" loop="true" src="./Music.mp4" autostart="false" class="video mt-2 rounded"></video>
                            <h1 id="songName" class="song-title"></h1>
                            <h2 id="artistName" class="song-author"></h2>
                        </div>
                    </div>

                    <div class="row delete-paddings">
                    
                        <div class="col-12 d-flex justify-content-center">
                            <button class="col-1 btn btn-dark m-1" onclick="shufflePlaylist()"><i class="fas fa-random"></i></button>
                            <button class="col-1 btn btn-dark m-1" onclick="restartSong()"><i class="fa fa-stop-circle" aria-hidden="true"></i></button>
                            <button class="col-1 btn btn-dark m-1" onclick="previousSong()"><i class="fas fa-backward"></i></button>
                            <button class="col-1 btn btn-dark m-1" onclick="togglePlay()"><i id="playButton" class="fas fa-play"></i></button>
                            <button class="col-1 btn btn-dark m-1" onclick="nextSong()"><i class="fas fa-forward"></i></button>
                            <button class="col-1 btn btn-dark m-1" onclick="toggleLoop()"><i id="replayButton" class="fas fa-redo-alt"></i></button>
                            <input  class="col-1 form-control-range delete-paddings" type="range" name="" id="volumeRange" min="0" max="100" value="100">
                        </div>

                        <div class="col-12 d-flex justify-content-center text-center">
                            <p id="songActual" class="col-3 text-white text-right">0:00</p>
                            <input id="songRange" type="range" class="col-7 form-control-range delete-paddings" min="0" max="100" value="0">
                            <p id="songDuration" class="col-3 text-white text-left">0:00</p>
                        </div>
                        <div class="col-12 d-flex justify-content-center text-center"> 
                            <h2 class="color-white"><%=user.getUsername()%></h2>
                        </div>
                        <div class="col-12 d-flex justify-content-center text-center"> 
                            <a class="col-4 btn btn-danger" href="PlaylistManager?action=logout">Cerrar sesión</a>
                        </div>
                    </div>
                </div>

            </section>
            <section class="col-4 h-100 border scroll">
                <div class="col-12">
                    <div class="row d-flex justify-content-center m-3">
                        <button class="col-1 btn btn-dark" data-toggle="modal" data-target="#uploadSongModal" data-whatever="@mdo"> <i class="color-white fas fa-music"></i> </button>
                        <select id="playListSelect" onchange="changePlaylist(this.options[this.selectedIndex].value)" class="col-10 custom-select"></select>
                        <button class="col-1 btn btn-dark" data-toggle="modal" data-target="#createPlaylistModal"> <i class="color-white fas fa-plus"></i> </button>
                    </div>
                    <div class="row " id="songsList">
                    </div>
                </div>
            </section>
        </section>
    </section>

    <div class="modal fade" id="uploadSongModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Subir canción</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action = "${pageContext.request.contextPath}/FileManagement" method = "post" enctype = "multipart/form-data">
                        <div class="form-group">
                            <label for="song_name" class="col-form-label">Nombre:</label>
                            <input type="text" class="form-control" name="song_name" id="song_name" required>
                        </div>
                        <div class="form-group">
                            <label for="artist_name" class="col-form-label">Artista:</label>
                            <input type="text" class="form-control" name="artist_name" id="artist_name" required>
                        </div>
                        <div class="form-group">
                            <label for="file" class="col-form-label" >Archivo:</label>
                            <input type = "file" name = "file" size = "50" required>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                            <input type="submit" class="btn btn-primary" value="Subir">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="createPlaylistModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Crear playlist</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action = "${pageContext.request.contextPath}/PlaylistManager" method = "post">
                        <div class="form-group">
                            <input name="finality" type="hidden" value="createPlaylist">
                            <label for="playlist_name" class="col-form-label">Nombre:</label>
                            <input type="text" class="form-control" name="playlist_name" id="playlist_name" required>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                            <input type="submit" class="btn btn-primary" value="Crear">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="addToPlaylistModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addToPlaylistModalHeader">Añadir cancion a playlist</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                 <form method="post" action="${pageContext.request.contextPath}/PlaylistManager">
                        <div class="form-group">
                            <input name="finality" type="hidden" value="addSongToPlaylist">
                            <label for="modal_song_name" class="col-form-label">Nombre de la canción:</label>
                            <input type="text" class="form-control" name="modal_song_name" id="modal_song_name" readonly>
                        </div>
                        <div class="form-group">
                            <select class="custom-select" name="modal_playlist_select" id="modal_playlist_select"></select>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                            <input type="submit" class="btn btn-primary" value="Aceptar">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addToPlaylistModalHeader">Elminar canción</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                 <form method="post" action="${pageContext.request.contextPath}/PlaylistManager">
                        <div class="form-group">
                            <input name="finality" type="hidden" value="deleteSong">
                            <input name="modal_song_id" id="modal_song_id" type="hidden">
                            <input name="modal_playlist_id" id="modal_playlist_id" type="hidden">
                            <input name="finality" type="hidden" value="deleteSong">
                            <label for="modal_delete_song_name" class="col-form-label">Nombre de la canción:</label>
                            <input type="text" class="form-control" name="modal_delete_song_name" id="modal_delete_song_name" readonly>
                            <label for="modal_delete_playlist_name" class="col-form-label">Nombre de la Playlist:</label>
                            <input type="text" class="form-control" name="modal_delete_playlist_name" id="modal_delete_playlist_name" readonly>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                            <input type="submit" id="delete_btn" class="btn btn-primary" value="Aceptar">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script>
        var videoPlayer = document.getElementById("videoPlayer");
        var playButton = document.getElementById("playButton");
        var songDuration = document.getElementById("songDuration");
        var songActual = document.getElementById("songActual");
        var songRange = document.getElementById("songRange"); 
        var volumeRange = document.getElementById("volumeRange");
        var replayButton = document.getElementById("replayButton");
        var songName = document.getElementById("songName");
        var artistName = document.getElementById("artistName");
        var playListSelect = document.getElementById("playListSelect");
        var songsList = document.getElementById("songsList");

        var audio;
        var activeList = 0;
        var activeSong = 0;
        var playLists = [];

        class Playlist {
            constructor(id, name, songs){
                this.id = id;
                this.name = name;
                this.songs = songs;
            }
        }

        class Song {
            constructor(id, title, artist, source){
                this.id = id;
                this.title = title;
                this.artist = artist;
                this.source = source;
            }
        }
        
        
        setInterval(resfresh, 1000);


        songRange.addEventListener('change', function() {
            console.log(this.value);
            audio.currentTime =  (audio.duration * this.value) / 100;
        });

        volumeRange.addEventListener('change', function() {
            console.log(this.value);
            audio.volume = this.value / 100;
        });

        function configurePlaylistModal(value){
            let songName = document.getElementById("modal_song_name");
            let playlistsSelect = document.getElementById("modal_playlist_select");

            songName.value = playLists[activeList].songs[value].title;
            
            var counter = 0;
            playLists.forEach( element => {
                if (element.name != playLists[activeList].name){
                    var option = document.createElement("option");
                    option.setAttribute("value", element.id);
                    option.innerHTML = element.name;
                    playlistsSelect.appendChild(option);
                }
                counter++;
            });
        }

        function changePlaylist(value){
            var counter = 0;
            activeList = value;
            songsList.innerHTML = "";
            playLists[value].songs.forEach(element => {
                let songHTML = `<div class="col-1 dropdown">
                                    <button class="btn btn-dark mt-1 dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <button class="dropdown-item" value="`+ counter +`" onclick="queueUp(this.value)"><i class="fas fa-angle-double-up mr-1 "></i>Siguiente</button>
                                        <button class="dropdown-item" value="`+ counter +`" onclick="configurePlaylistModal(this.value)" data-toggle="modal" data-target="#addToPlaylistModal"><i class="fas fa-plus mr-1"></i>Añadir a playlist</button>
                                        <button class="dropdown-item" value="`+ counter +`" onclick="deleteSong(this.value)" data-toggle="modal" data-target="#deleteModal"><i class="fas fa-trash mr-1"></i>Eliminar</button>
                                    </div>
                                </div>
                                <button class="col-11 btn btn-dark text-center mt-1 color-white" value="`+ counter +`" onclick="playSong(this.value)" id="song` + counter + `">` + element.title +`</button>`;
                songsList.innerHTML += songHTML;
                counter++;
            });
        }

        function deleteSong(song){
            let songName = document.getElementById("modal_delete_song_name");
            let playlistName = document.getElementById("modal_delete_playlist_name");
            let songId = document.getElementById("modal_song_id");
            let playlistId = document.getElementById("modal_playlist_id");
            let deleteBtn = document.getElementById("delete_btn");
            if (playLists[activeList].name != "Todas"){
                songName.value = playLists[activeList].songs[parseInt(song,10)].title;
                playlistName.value = playLists[activeList].name;
                playlistId.value =  playLists[activeList].id;
                songId.value =  playLists[activeList].songs[parseInt(song,10)].id;
            }else{
                songName.value = "No se puede eliminar esta canción";
                playlistName.value = "No se puede eliminar de esta playlist";
                deleteBtn.setAttribute("disabled", "true");
            }
        }

        function load(){
        
            <% for (Playlist p : playLists){ %>
                var songs = [];
                <% for (Song s : p.getSongs()){ %>
                    var song = new Song("<%= s.getSongId() %>", "<%= s.getTitle() %>", "<%= s.getArtist()%>", "<%= s.getSource()%>");
                    songs.push(song);
                <% }%>
                 songs.sort(function(a, b) {
                    return a.id - b.id;
                });

                var playList = new Playlist("<%= p.getPlaylistId()%>", "<%= p.getPlaylistName()%>", songs);
                playLists.push(playList);
            <% } %>

            playLists.sort(function(a, b) {
                    return a.id - b.id;
                });

            var counter = 0;
            playLists.forEach( element => {
                var option = document.createElement("option");
                option.setAttribute("value", counter);
                option.innerHTML = element.name;
                playListSelect.appendChild(option);
                counter++;
            });

            changePlaylist(0);
            audio = new Audio(playLists[activeList].songs[activeSong].source);
            playSong(activeSong);
        }

        function shufflePlaylist(){
            playLists[activeList].songs.sort(() => Math.random() - 0.5);
            playSong(0);
            changePlaylist(activeList);
            
        }

        function queueUp(song){

            if (song != activeSong && song != activeSong+1){

                    if (activeSong == playLists[activeList].songs.length - 1){

                       playLists[activeList].songs[0].id = song
                       playLists[activeList].songs[song].id = 0;

                    }else{
                        let second = (parseInt(activeSong, 10) + 1);
                        console.log("a" +second);
                        console.log("b" + song);
                        playLists[activeList].songs[second].id = (parseInt(song,10) + 1).toString();
                        playLists[activeList].songs[song].id = (parseInt(activeSong,10) + 2).toString();
                    }

                    playLists[activeList].songs.sort(function(a, b) {
                    return a.id - b.id;
                    });
                    console.log("new array");
                    console.log(playLists[activeList].songs);
                    changePlaylist(activeList);
                    changeSongStatus();
            }else{
                console.log("no se puede mover hacia arriba");
            }
        }

        function playSong(song){
            audio.pause();
            console.log("cancion: " + song);

            let songInList = document.getElementById("song" + (activeSong));
            songInList.className = "col-11 btn btn-dark text-center mt-1 color-white";

            activeSong = song;

            let newSongInList = document.getElementById("song" + song);
            newSongInList.className = "col-11 btn btn-dark text-center mt-1 color-green";

            songName.innerHTML = playLists[activeList].songs[activeSong].title;
            artistName.innerHTML = playLists[activeList].songs[activeSong].artist;
            audio = new Audio(playLists[activeList].songs[activeSong].source);
            audio.volume = volumeRange.value / 100;
            togglePlay();
        }

        function changeSongStatus(song){
            let newSongInList = document.getElementById("song" + activeSong);
            newSongInList.className = "col-11 btn btn-dark text-center mt-1 color-green";
        }

        function nextSong(){
            audio.pause();

            if (activeSong >= playLists[activeList].songs.length - 1){
                playSong(0);
            }else{
                playSong(parseInt(activeSong,10) + 1);
            }
        }

        function previousSong(){
            audio.pause();

            if (activeSong <= 0){
                playSong(playLists[activeList].songs.length - 1);
            }else{
                playSong(parseInt(activeSong,10)-1);
            }
        }

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
            songDuration.innerHTML = convertTime(audio.duration);

            var millisecondsToWait = 1000;
            setTimeout(function() {
                if (audio.currentTime >= audio.duration){
                    nextSong();
                }
            }, millisecondsToWait);
        }

        function togglePlay(){

            
            window.document.title = "MUSIFY - " +  playLists[activeList].songs[activeSong].title;

            if (audio.paused){
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
    </script>
    <% } %>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>