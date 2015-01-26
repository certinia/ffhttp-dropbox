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
 * ffhttp_DropboxResource
 *
 * Abstract class to provide the base functionality for all Dropbox calls.
 */
public with sharing abstract class ffhttp_DropboxResource 
{
	//Statics
	
	//URLs
	//Dropbox URLs
	public static final String DROPBOX_URL = 'https://www.dropbox.com/';
	public static final String DROPBOX_API_URL = 'https://api.dropbox.com/';
	public static final String DROPBOX_API_CONTENT_URL = 'https://api-content.dropbox.com/';
	public static final String DROPBOX_API_NOTIFY_URL = 'https://api-notify.dropbox.com/';
	public static final String DROPBOX_FILE_OPERATION_URL = 'https://api.dropbox.com/1/fileops/';
	
	//Directories
	public static final String ROOT_AUTO = 'auto';
	public static final String ROOT_SANDBOX = 'sandbox';
	public static final String ROOT_DROPBOX = 'dropbox';
	
	//Thumbnail Sizes
	public static final String THUMBNAIL_SIZE_EXTRA_SMALL = 'xs';	//32x32
	public static final String THUMBNAIL_SIZE_SMALL = 's';			//64x64
	public static final String THUMBNAIL_SIZE_MEDIUM = 'm';			//128x128
	public static final String THUMBNAIL_SIZE_LARGE = 'l';			//640x480
	public static final String THUMBNAIL_SIZE_EXTRA_LARGE = 'xl';	//1024x768

	//Instance variables
	private ffhttp_Dropbox m_service;
	
	/**
	 * Constructor
	 */
	public ffhttp_DropboxResource(ffhttp_Dropbox service)
	{
		m_service = service;
	}
	
	/**
	 * Gets/Sets
	 */
	public ffhttp_Dropbox getService()
	{
		return m_service;
	}
	public ffhttp_DropboxResource setService(ffhttp_Dropbox service)
	{
		m_service = service;
		return this;
	}

	/**
	 * DropboxRequest
	 * 
	 * Abtract class created for all Dropbox requests
	 */
	public abstract class DropboxRequest extends ffhttp_Client.AbstractClientRequest
	{ 
	 	protected DropboxRequest(ffhttp_DropboxResource resource, String endpoint, String method, 
	 								 ffhttp_IHttpContent content, ffhttp_IDeserialize responseDeserializer) 
	 	{
			super(resource.getService(),  endpoint, method, content, responseDeserializer);
		}
	}	
}
