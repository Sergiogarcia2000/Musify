/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import db.DatabaseManager;
import db.Song;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.filechooser.FileSystemView;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


/**
 *
 * @author Sergio
 */
@WebServlet(name = "FileManagement", urlPatterns = {"/FileManagement"})
public class FileManagement extends HttpServlet {

    private final String UPLOAD_DIRECTORY = "./";
    
    private static String documentsDirectory = FileSystemView.getFileSystemView().getDefaultDirectory().getPath();
    
    private static String path = documentsDirectory + "\\NetBeansProjects\\Musify\\web\\songs";
    
    
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
        response.setContentType("text/html;charset=UTF-8");
       
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
       
       String songName = null;
       String artistName = null;
        System.out.println("Hola caracola");
        
        //process only if its multipart content
        if(ServletFileUpload.isMultipartContent(request)){
            try {
                List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                File song = null;
                for(FileItem item : multiparts){
                    
                    
                    if (item.getFieldName().equalsIgnoreCase("song_name")){
                        songName = item.getString("ISO-8859-1");
                    }
                    
                    if (item.getFieldName().equalsIgnoreCase("artist_name")){
                        artistName = item.getString("ISO-8859-1");
                        System.out.println(item.getFieldName() + " " + item.getString("ISO-8859-1"));
                    }
                    
                    if(!item.isFormField()){
                        song = new File(item.getName());
                        String name = song.getName();
                        boolean isFound = name.indexOf(".mp3") !=-1? true: false;
                        if (!isFound){
                            throw new Exception("File is not mp3");
                        }
                        
                        if (DatabaseManager.getInstance().addSong(new Song(songName, artistName, "./songs/" + songName + ".mp3"))) {
                            item.write(new File(path + File.separator + songName + ".mp3"));
                        } else {
                            throw new Exception("Error saving song");
                        }
                    }
                }
               //File uploaded successfully
                System.out.println("File Uploaded Successfully");
               request.setAttribute("message", "File Uploaded Successfully");
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
               request.setAttribute("message", "File Upload Failed due to " + ex);
            }          
          
        }else{
            System.out.println("Sorry this Servlet only handles file upload request");
            request.setAttribute("message",
                                 "Sorry this Servlet only handles file upload request");
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
