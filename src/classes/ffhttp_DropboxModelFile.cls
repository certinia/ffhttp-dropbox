/**
 * Copyright (c) 2014, FinancialForce.com, inc
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *      this list of conditions and the following disclaimer in the documentation 
 *      and/or other materials provided with the distribution.
 * - Neither the name of the FinancialForce.com, inc nor the names of its contributors 
 *      may be used to endorse or promote products derived from this software without 
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

/**
 * ffhttp_DropboxModelFile
 *
 * An object that represents the meta data for a file in Dropbox.
 * https://www.dropbox.com/developers/core/docs#metadata
 *
 * Example response:
 *
 * {
 *    "size": "225.4KB",
 *    "rev": "35e97029684fe",
 *    "thumb_exists": false,
 *    "bytes": 230783,
 *    "modified": "Tue, 19 Jul 2011 21:55:38 +0000",
 *    "client_mtime": "Mon, 18 Jul 2011 18:04:35 +0000",
 *    "path": "/Getting_Started.pdf",
 *    "is_dir": false,
 *    "icon": "page_white_acrobat",
 *    "root": "dropbox",
 *    "mime_type": "application/pdf",
 *    "revision": 220823
 * }
 */
public with sharing class ffhttp_DropboxModelFile extends ffhttp_AbstractJsonSerializable
{
	private String size;			//A human-readable description of the file size (translated by locale).
	private Integer bytes;			//The file size in bytes.
	private String path;		 	//Returns the canonical path to the file or directory.
	private Boolean is_dir;			//Whether the given entry is a folder or not.
	private Boolean is_deleted;		//Whether the given entry is deleted (only included if deleted files are being returned).
	private String rev;				//A unique identifier for the current revision of a file. 
									//This field is the same rev as elsewhere in the API and can be used to 
									//detect changes and avoid conflicts.
	private String hash; 			//A folder's hash is useful for indicating changes to the folder's contents in later 
									//calls to /metadata. This is roughly the folder equivalent to a file's rev.
	private Boolean thumb_exists;	//True if the file is an image that can be converted to a thumbnail via the /thumbnails call.				
	private PhotoInfo photo_info;	//Only returned when the include_media_info parameter is true and the file is an image. 
									//A dictionary that includes the creation time (time_taken) and the GPS coordinates 
									//(lat_long).				
	private VideoInfo video_info;	//Only returned when the include_media_info parameter is true and the file is a video. 
									//A dictionary that includes the creation time (time_taken), the GPS coordinates 
									//(lat_long), and the length of the video in milliseconds (duration).
	private String icon;			//The name of the icon used to illustrate the file type in Dropbox's icon library.
   	private String modified;		//The last time the file was modified on Dropbox, in the standard date format 
   									//(not included for the root folder).
    private String client_mtime;	//For files, this is the modification time set by the desktop client when the file 
    								//was added to Dropbox, in the standard date format. Since this time is not verified 
    								//(the Dropbox server stores whatever the desktop client sends up), this should only 
   									//be used for display purposes (such as sorting) and not, for example, to determine 
 									//if a file has changed or not.
    private String root;			//The root or top-level folder depending on your access level. 
     								//All paths returned are relative to this root level. 
     								//Permitted values are either dropbox or app_folder.
     											   
    /**
     * Non-meta data fields.
     */	     
    private List<ffhttp_DropboxModelFile> contents;	//If the DropboxFile is a folder then the response also contains the files within that 
    												//folder. Store them as a list of DropboxFiles.
    
    /**
     * Helper methods
     */
     
    /**
     * Return the name of the file rather than the canonical path to the file or directory.
     * Returns everything after the last /.
     */
	public String getName()
	{
		String retval = 'Dropbox Root Directory';
		
		List<String> pathParts = path.split('/');
		Integer size = pathParts.size();
		if (size > 0)
		{
			retval = pathParts.get(size - 1);
		}
		return retval;
	}

	/**
	 * Returns true if this DropboxFile is a directory.
	 */
	public Boolean isDirectory()
	{
		return is_Dir;
	}
	
	/**
	 * Returns true if this DropboxFile is a file.
	 */
	public Boolean isFile()
	{
		return !is_Dir;
	}

    /**
     * Returns this file and all the contents in one list.
     */
    public List<ffhttp_DropboxModelFile> getAllFiles()
    {
    	List<ffhttp_DropboxModelFile> allFiles = new List<ffhttp_DropboxModelFile>();
    	allFiles.add(this);
    	
    	if (contents != null 
    	  && contents.size() > 0)
    	{
    		allFiles.addAll(contents);
    	}
    	
    	return allFiles;
    }
    
    /**
     * Get/Sets
     */
	public String getSize() 
	{
		return size;
	}
	public ffhttp_DropboxModelFile setSize(String size)
	{
		this.size = size;
		return this;
	}
	public Integer getBytes() 
	{
		return bytes;
	}
	public ffhttp_DropboxModelFile setBytes(Integer bytes) 
	{
		this.bytes = bytes;
		return this;
	}
	public String getPath() 
	{
		return path;
	}
	public ffhttp_DropboxModelFile setPath(String path) 
	{
		this.path = path;
		return this;
	}
	public Boolean getDir() 
	{
		return is_dir;
	}
	public ffhttp_DropboxModelFile setDir(Boolean is_dir) 
	{
		this.is_dir = is_dir;
		return this;
	}
	public Boolean getDeleted() 
	{
		return is_deleted;
	}
	public ffhttp_DropboxModelFile setDeleted(Boolean is_deleted) 
	{
		this.is_deleted = is_deleted;
		return this;
	}
	public String getRev() 
	{
		return rev;
	}
	public ffhttp_DropboxModelFile setRev(String rev) 
	{
		this.rev = rev;
		return this;
	}
	public String getHash() 
	{
		return hash;
	}
	public ffhttp_DropboxModelFile setHash(String hash) 
	{
		this.hash = hash;
		return this;
	}
	public Boolean getThumbExists() 
	{
		return thumb_exists;
	}
	public ffhttp_DropboxModelFile setThumbExists(Boolean thumb_exists) 
	{
		this.thumb_exists = thumb_exists;
		return this;
	}
	public PhotoInfo getPhotoInfo() 
	{
		return photo_info;
	}
	public ffhttp_DropboxModelFile setPhotoInfo(PhotoInfo photo_info) 
	{
		this.photo_info = photo_info;
		return this;
	}
	public VideoInfo getVideoInfo() 
	{
		return video_info;
	}
	public ffhttp_DropboxModelFile setVideoInfo(VideoInfo video_info) 
	{
		this.video_info = video_info;
		return this;
	}
	public String getIcon() 
	{
		return icon;
	}
	public ffhttp_DropboxModelFile setIcon(String icon) 
	{
		this.icon = icon;
		return this;
	}
	public String getModified() 
	{
		return modified;
	}
	public ffhttp_DropboxModelFile setModified(String modified) 
	{
		this.modified = modified;
		return this;
	}
	public String getClientMtime() 
	{
		return client_mtime;
	}
	public ffhttp_DropboxModelFile setClientMtime(String client_mtime) 
	{
		this.client_mtime = client_mtime;
		return this;
	}
	public String getRoot() 
	{
		return root;
	}
	public ffhttp_DropboxModelFile setRoot(String root) 
	{
		this.root = root;
		return this;
	}
    
    /**
     * Inner classes
     */
    public class PhotoInfo extends ffhttp_AbstractJsonSerializable
	{
		//Instance variables
		private String time_taken;		//The creation date of the image;
		private Double[] lat_long;		//The latitude and longitude stored in the image.	
		
		/**
		 * Get/Sets
		 */
		public String getTimeTaken() 
		{
			return time_taken;
		}
		public PhotoInfo setTimeTaken(String time_taken) 
		{
			this.time_taken = time_taken;
			return this;
		}
		public Double[] getLatLong() 
		{
			return lat_long;
		}
		public PhotoInfo setLatlong(Double[] lat_long) 
		{
			this.lat_long = lat_long;
			return this;
		}
	}

 	public class VideoInfo extends ffhttp_AbstractJsonSerializable
	{
		//Instance variables
		private String time_taken;	//The creation date of the video;
		private Double[] lat_long;		//The latitude and longitude stored in the video.	
		private Long duration;			//The length of the video.
		
		/**
		 * Get/Sets
		 */
		public String getTimeTaken() 
		{
			return time_taken;
		}
		public VideoInfo setTimeTaken(String time_taken) 
		{
			this.time_taken = time_taken;
			return this;
		}
		public Double[] getLatLong() 
		{
			return lat_long;
		}
		public VideoInfo setLatlong(Double[] lat_long) 
		{
			this.lat_long = lat_long;
			return this;
		}
		public Long getDuration() 
		{
			return duration;
		}
		public VideoInfo setDuration(Long duration) 
		{
			this.duration = duration;
			return this;
		}
	}
}
