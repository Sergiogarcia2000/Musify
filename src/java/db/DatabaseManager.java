/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

/**
 *
 * @author Sergio
 */
public class DatabaseManager {
    
    private static DatabaseManager dbManager = null;

    SessionFactory sessionFactory;
    Configuration configuration;
    ServiceRegistry serviceRegistry;
    Session session;
    
    User activeUser = null;

    
    public DatabaseManager() {
        configuration = new Configuration();
        configuration.configure();
        serviceRegistry = new ServiceRegistryBuilder().applySettings(configuration.getProperties()).buildServiceRegistry();
        sessionFactory = configuration.buildSessionFactory(serviceRegistry);
        session = sessionFactory.openSession();
    }
    
    public static DatabaseManager getInstance(){
        if (dbManager == null){
            dbManager = new DatabaseManager();
        }
        return dbManager;
    }
    
    
    public boolean checkUser(String email, String password){
        
        List<User> users = getUsers();
        
        for (User user : users){
            System.out.println(user.getEmail() + " | " + user.getPassword());
            if (user.getEmail().equalsIgnoreCase(email)){
                if (user.getPassword().equals(password)){
                    return true;
                }
            }
        }
        return false;
    }
    
    public User getUser(String email, String password){
        List<User> users = getUsers();

        for (User user : users){
            System.out.println(user.getEmail() + " | " + user.getPassword());
            if (user.getEmail().equalsIgnoreCase(email)){
                if (user.getPassword().equals(password)){
                    this.activeUser = user;
                    return user;
                }
            }
        }

        return null;
    }
    
    private List<User> getUsers(){
        Query query = session.createQuery("SELECT u FROM User u");
        return query.list();
    }
    
    private List<Song> getSongs(){
        Query query = session.createQuery("Select s FROM Song s");
        return query.list();
    }
    
    public boolean addSong(Song song){
        Transaction transaction = null;
        
        try{
            transaction = session.beginTransaction();
        
            for (User u : this.getUsers()){
                for (Playlist p : u.getPlaylists()){
                    if (p.getPlaylistName().equalsIgnoreCase("Todas")){
                        p.getSongs().add(song); 
                    }
                }
                session.update(u);
            }

            transaction.commit();
        }catch (RuntimeException e){
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
        return true;
    }
    
    public boolean addUser(String name, String email, String password){
        Transaction transaction = null;
        
        try{
            transaction = session.beginTransaction();
        
            for (User u : getUsers()){
                if (u.getEmail().equalsIgnoreCase(email)){
                    transaction.commit();
                    return false;
                }
            }
        
            User user = new User(name, email, password);
        
            Playlist playlist = new Playlist("Todas", user);
        
            for (Song s : getSongs()){
                playlist.getSongs().add(s);
            }
        
            user.getPlaylists().add(playlist);
            session.save(user);
            transaction.commit();
        }catch (RuntimeException e){
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
        return true;
    }
    
    public boolean addPlaylist(String name){
        Transaction transaction = null;
        try{
            transaction = session.beginTransaction();
        
            Playlist playlist = new Playlist(name, activeUser);

            activeUser.getPlaylists().add(playlist);

            session.update(activeUser);

            transaction.commit();
        }catch (RuntimeException e){
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
        return true;
    }
    
    public boolean addSongToPlaylist(int playListId, String songName){
        
        Transaction transaction = null;
        try{
            transaction = session.beginTransaction();
            
            Playlist playlist = (Playlist) session.get(Playlist.class, playListId);
            
            for (Song s : getSongs()){
                if (s.getTitle().equalsIgnoreCase(songName)){
                    playlist.getSongs().add(s);
                    for (Playlist p : s.getPlaylists()){
                        if (p.getPlaylistId() == playListId){
                            p.getSongs().add(s);
                        }
                    }
                }
            }
            
            session.save(playlist);
            transaction.commit();
        }catch (RuntimeException e){
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
        return true;
        
    }
    
    /**
     * I take every song of the playlist and check if its the correct one, if it is I remove the song from the playlist and the playlist from that song
     * If it was the last song of that playlist, that is deleted.
     * Basically in here 
     * 
     * @param playListId
     * @param songName
     * @return 
     */
    public boolean deleteSongFromPlaylist(int playListId, int songId){
        Transaction transaction = null;
        try{
            transaction = session.beginTransaction();
            Playlist playlist = (Playlist) session.get(Playlist.class, playListId);
            Song song = (Song) session.get(Song.class, songId);
            
            playlist.getSongs().remove(song);
            song.getPlaylists().remove(playlist);
           
            if (playlist.getSongs().isEmpty()){
                activeUser.getPlaylists().remove(playlist);
                session.delete(playlist);
            }else{
                session.update(playlist);
            }
            transaction.commit();
        }catch (RuntimeException e){
            transaction.rollback();
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
