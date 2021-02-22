/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.io.Serializable;
import java.sql.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

/**
 *
 * @author Sergio
 */
@Entity
@Table(name = "Songs")
public class Song implements Serializable{
    @Id
    @Column(name = "SONG_ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int songId;
    
    @Column(name = "TITLE")
    private String title;

    @Column(name = "ARTIST")
    private String artist;
    
    @Column(name = "SOURCE")
    private String source;
    
    @ManyToMany(mappedBy = "songs",
            cascade = {CascadeType.ALL})
    private Set<Playlist> playlists = new HashSet();

    public Song(){
        
    }

    public Song(String title, String artist, String source) {
        this.title = title;
        this.artist = artist;
        this.source = source;
    }

    public int getSongId() {
        return songId;
    }

    public void setSongId(int songId) {
        this.songId = songId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getArtist() {
        return artist;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public Set<Playlist> getPlaylists() {
        return playlists;
    }

    public void setPlaylists(Set<Playlist> playlists) {
        this.playlists = playlists;
    }
}
