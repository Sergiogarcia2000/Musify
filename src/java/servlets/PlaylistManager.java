/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import db.DatabaseManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Sergio
 */
@WebServlet(name = "PlaylistManager", urlPatterns = {"/PlaylistManager"})
public class PlaylistManager extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String finality = request.getParameter("finality");
        if (finality.equals("createPlaylist")){
            String playlistName = request.getParameter("playlist_name");
        
            DatabaseManager.getInstance().addPlaylist(playlistName);
            System.out.println("Playlist creada!");
        }else if (finality.equals("deleteSong")){
            String songName = request.getParameter("modal_delete_song_name");
            String playlistId = request.getParameter("modal_playlist_id");
            System.out.println("asd: " + playlistId);
            DatabaseManager.getInstance().deleteSongFromPlaylist(Integer.parseInt(playlistId), songName);
        }else{
            String songName = request.getParameter("modal_song_name");
            String playlist = request.getParameter("modal_playlist_select");
            System.out.println("Cancion '" + songName + "' añadida to playlist ' " + playlist);
            DatabaseManager.getInstance().addSongToPlaylist(Integer.parseInt(playlist), songName);
        }
        response.sendRedirect("player.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
