/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

/**
 *
 * @author Sergio
 */
@Entity
@Table(name = "PLAYLISTS")
public class Playlist implements Serializable{
    
    @Id
    @Column(name = "PLAYLIST_ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int playlistId;
    
    @Column(name = "PLAYLISTNAME")
    private String playlistName;
    

    @ManyToMany(cascade = {CascadeType.PERSIST,CascadeType.MERGE,CascadeType.DETACH})
    @JoinTable(
            name="PLAYLIST_SONG", 
            joinColumns = {@JoinColumn(name="PLAYLIST_FK")}, 
            inverseJoinColumns = {@JoinColumn(name = "SONG_FK")})
    private Set<Song> songs = new HashSet();
    
    @ManyToOne
    @JoinColumn(name = "USER_FK")
    private User user;
    
    /*
    
    
    @ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(name="USERS_SONGS_PLAYLIST", joinColumns = {@JoinColumn(name="playlistId")}, inverseJoinColumns = {@JoinColumn(name = "userId")})
    private Set<User> users = new HashSet();
    */
    
    public Playlist(){
        
    }
    
    public Playlist(String playlistName, User user) {
        this.playlistName = playlistName;
        this.user = user;
    }

    public int getPlaylistId() {
        return playlistId;
    }

    public void setPlaylistId(int playlistId) {
        this.playlistId = playlistId;
    }

    public String getPlaylistName() {
        return playlistName;
    }

    public void setPlaylistName(String playlistName) {
        this.playlistName = playlistName;
    }

    public Set<Song> getSongs() {
        return songs;
    }

    public void setSongs(Set<Song> songs) {
        this.songs = songs;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
