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
 * ffhttp_DropboxFiles
 *
 * This class contains the methods to access each of the Dropbox File API calls.
 */
public with sharing class ffhttp_DropboxFiles extends ffhttp_DropboxResource
{	
	/**
	 * Constructor
	 *
	 * @param service The ffhttp_Dropbox service.
	 * @return Access to the Files API calls.
	 */
	public ffhttp_DropboxFiles(ffhttp_Dropbox service) 
	{
		super(service);
	}

	/*********************************************************************************************************
	 * Requests
	 *********************************************************************************************************/
	 
	/**
	 * /files (GET)
	 *
	 * Downloads a file. Note that this call goes to api-content.dropbox.com instead of api.dropbox.com.
	 */
	public FilesRequest filesRequest(String path)
	{
		if (path == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullPath);
		
		return new FilesRequest(this, path);
	}
	
	/**
	 * /files_put
	 *
	 * Uploads a file using PUT semantics. 
	 *
	 * Note that this call goes to api-content.dropbox.com instead of api.dropbox.com.
	 */
	public FilesPutRequest filesPutRequest(String path, Blob attachmentContent, String attachmentContentType) 
	{ 
		if (path == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullPath);
		if (attachmentContent == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullAttachmentContent);
		if (attachmentContentType == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullAttachmentContentType);
		
		ffhttp_BlobContent content = new ffhttp_BlobContent(attachmentContent, attachmentContentType);
		return new FilesPutRequest(this, path, content);
	}
	
	/**
	 * /metadata
	 *
	 * Retrieves file and folder metadata.
	 */
	public MetaDataRequest metaDataRequest(String path)
	{
		if (path == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullPath);
		
		return new MetaDataRequest(this, path);
	}
	
	/**
	 * /delta
	 *
	 * A way of letting you keep up with changes to files and folders in a user's Dropbox. 
	 * You can periodically call /delta to get a list of "delta entries", which are instructions on how to 
	 * update your local state to match the server's state.
	 */
	public DeltaRequest deltaRequest()
	{
		return new DeltaRequest(this);
	}
	 
	/**
	 * /delta/latest_cursor
	 *
	 * A way to quickly get a cursor for the server's state, for use with /delta. 
	 * Unlike /delta, /delta/latest_cursor does not return any entries, so your app will not know about any 
	 * existing files or folders in the Dropbox account. For example, if your app processes future delta entries 
	 * and sees that a folder was deleted, your app won't know what files were in that folder. Use this endpoint 
	 * if your app only needs to know about new files and modifications and doesn't need to know about files that 
	 * already exist in Dropbox.
	 *
	 * If you need to build local state to match the server state in Dropbox, you should instead use /delta.
	 */
	public DeltaLatestCursorRequest deltaLatestCursorRequest()
	{
		return new DeltaLatestCursorRequest(this);
	}
	
	/**
	 * /longpoll_delta
	 *
	 * A long-poll endpoint to wait for changes on an account. In conjunction with /delta, this call gives you a 
	 * low-latency way to monitor an account for file changes.
	 * 
	 * Note that this call goes to api-notify.dropbox.com instead of api.dropbox.com.
	 * 
	 * Unlike most other API endpoints, this call does not require OAuth authentication. 
	 * The passed in cursor can only be acquired via an authenticated call to /delta.
	 */
	public LongpollDeltaRequest longpollDeltaRequest()
	{
		return new LongpollDeltaRequest(this);
	}
	
	/**
	 * /revisions
	 * 
	 * Obtains metadata for the previous revisions of a file.
	 * 
	 * Only revisions up to thirty days old are available (or more if the Dropbox user has Packrat). 
	 * You can use the revision number in conjunction with the /restore call to revert the file to its previous state.
	 */
	public RevisionsRequest revisionsRequest(String path)
	{
		if (path == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullPath);
		
		return new RevisionsRequest(this, path);
	}
	 
	/**
	 * /restore
	 * 
	 * Restores a file path to a previous revision.
	 *
	 * Unlike downloading a file at a given revision and then re-uploading it, this call is atomic. 
	 * It also saves a bunch of bandwidth.
	 */
	public RestoreRequest restoreRequest(String path)
	{
		if (path == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullPath);
		
		return new RestoreRequest(this, path);
	}
	
	/**
	 * /search
	 *
	 * Returns metadata for all files and folders whose filename contains the given search string as a substring.
	 * 
	 * Searches are limited to the folder path and its sub-folder hierarchy provided in the call.
	 */
	public SearchRequest searchRequest(String path)
	{
		if (path == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullPath);
		
		return new SearchRequest(this, path);
	}
	 
	/**
	 * /shares
	 * 
	 * Creates and returns a Dropbox link to files or folders users can use to view a preview of the file in a web browser.
	 */
	public SharesRequest sharesRequest(String path)
	{
		if (path == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullPath);
		
		return new SharesRequest(this, path);
	}
	
	/**
	 * /media
	 * 
	 * Returns a link directly to a file.
	 *
	 * Similar to /shares. The difference is that this bypasses the Dropbox webserver, used to provide a preview of the 
	 * file, so that you can effectively stream the contents of your media. This URL should not be used to display 
	 * content directly in the browser.
	 */
	public MediaRequest mediaRequest(String path)
	{
		if (path == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullPath);
		
		return new MediaRequest(this, path);
	}
	
	/**
	 * /copy_ref
	 * 
	 * Creates and returns a copy_ref to a file. 
	 * This reference string can be used to copy that file to another user's Dropbox by passing it in as the 
	 * from_copy_ref parameter on /fileops/copy.
	 */
	public CopyRefRequest copyRefRequest(String path)
	{
		if (path == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullPath);
		
		return new CopyRefRequest(this, path);
	}
	
	/**
	 * /thumbnails
	 *
	 * Gets a thumbnail for an image. 
	 * 
	 * Note that this call goes to api-content.dropbox.com instead of api.dropbox.com.
	 */
	public ThumbnailsRequest thumbnailsRequest(String path)
	{
		if (path == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullPath);
		
		return new ThumbnailsRequest(this, path);
	}
	
	/**
	 * /previews
	 *
	 * Gets a preview for a file. 
	 *
	 * Note that this call goes to api-content.dropbox.com instead of api.dropbox.com.
	 */
	public PreviewsRequest previewsRequest(String path)
	{
		if (path == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullPath);
		
		return new PreviewsRequest(this, path);
	}
	 
	/**
	 * /chunked_upload
	 * 
	 * Uploads large files to Dropbox in multiple chunks. Also has the ability to resume if the upload is interrupted. 
	 * This allows for uploads larger than the /files and /files_put maximum of 150 MB.
	 *
	 * Typical usage:
	 *
	 * Send a PUT request to /chunked_upload with the first chunk of the file without setting upload_id, and receive an 
	 * upload_id in return.
	 *
	 * Repeatedly PUT subsequent chunks using the upload_id to identify the upload in progress and an offset representing 
	 * the number of bytes transferred so far.
	 *
	 * After each chunk has been uploaded, the server returns a new offset representing the total amount transferred.
	 *
	 * After the last chunk, POST to /commit_chunked_upload to complete the upload.
	 *
	 * If the offset you submit does not match the expected offset on the server, the server will ignore the request and respond 
	 * with a 400 error that includes the current offset. To resume upload, seek to the correct offset (in bytes) within the file 
	 * and then resume uploading from that point.
	 *
	 * A chunked upload can take a maximum of 24 hours before expiring.
	 */
	public ChunkedUploadRequest chunkedUploadRequest(Blob attachmentContent, String attachmentContentType)
	{
		if (attachmentContent == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullAttachmentContent);
		if (attachmentContentType == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullAttachmentContentType);
		
		ffhttp_BlobContent content = new ffhttp_BlobContent(attachmentContent, attachmentContentType);
		return new ChunkedUploadRequest(this, content);
	}
	
	/**
	 * /commit_chunked_upload
	 * 
	 * Completes an upload initiated by the /chunked_upload method. Saves a file uploaded via /chunked_upload to a user's Dropbox.
	 *
	 * /commit_chunked_upload is similar to /files_put. The main difference is that while /files_put takes the file contents in 
	 * the request body, /commit_chunked_upload takes a parameter upload_id, which is obtained when the file contents are uploaded 
	 * via /chunked_upload.
	 *
	 * Note that this call goes to api-content.dropbox.com instead of api.dropbox.com.
	 */
	public CommitChunkedUploadRequest commitChunkedUploadRequest(String path)
	{
		if (path == null) throw new ffhttp_SystemException(System.Label.ffhttp_dropbox_NullPath);
		
		return new CommitChunkedUploadRequest(this, path);
	}
	
	/*********************************************************************************************************
	 * API Callout Inner Classes
	 *********************************************************************************************************/
	
	public class FilesRequest extends DropboxRequest
	{
	 	FilesRequest(ffhttp_DropboxFiles files, String path) 
		{
			super(files, DROPBOX_API_CONTENT_URL + '1/files/auto/' + path, REQUEST_METHOD_GET, null, null);
		}
		
		/**
		 * Request Parameters
		 */
		public String getRev()
		{
			return getParam('rev');
		}
		public FilesRequest setRev(String rev)
		{
			addParam('rev', rev);
			return this;
		}
	}
	
	public class FilesPutRequest extends DropboxRequest
	{
	 	FilesPutRequest(ffhttp_DropboxFiles files, String path, ffhttp_IHttpContent content) 
		{
			super(files, DROPBOX_API_CONTENT_URL + '1/files_put/auto/' + path, REQUEST_METHOD_PUT, 
				  content, new ffhttp_JsonDeserializer(ffhttp_DropboxModelFile.class));
		}
		
		/**
		 * Request Parameters
		 */
		public String getLocale()
		{
			return getParam('locale');
		}
		public FilesPutRequest setLocale(String locale)
		{
			addParam('locale', locale);
			return this;
		}
		public Boolean getOverwrite()
		{
			return getParam('overwrite', true);
		}
		public FilesPutRequest setOverwrite(Boolean overwrite)
		{
			addParam('overwrite', overwrite);
			return this;
		}
		public String getParentRev()
		{
			return getParam('parent_rev');
		}
		public FilesPutRequest setParentRev(String parentRev)
		{
			addParam('parent_rev', parentRev);
			return this;
		}
		public Boolean getAutoRename()
		{
			return getParam('autorename', true);
		}
		public FilesPutRequest setAutoRename(Boolean autorename)
		{
			addParam('autorename', autorename);
			return this;
		}
	}
	
	public class MetaDataRequest extends DropboxRequest
	{
		MetaDataRequest(ffhttp_DropboxFiles files, String path) 
		{
			super(files, DROPBOX_API_URL + '1/metadata/auto/' + path, REQUEST_METHOD_GET, 
				  null, new ffhttp_JsonDeserializer(ffhttp_DropboxModelFile.class));
		}
		
		/**
		 * Request Parameters
		 */
		public Integer getFileLimit()
		{
			return getParam('file_limit', 10000);
		}
		public MetaDataRequest setFileLimit(Integer fileLimit)
		{
			addParam('file_limit', fileLimit);
			return this;
		}
		public String getHash()
		{
			return getParam('hash');
		}
		public MetaDataRequest setHash(String hash)
		{
			addParam('hash', hash);
			return this;
		}
		public Boolean getList()
		{
			return getParam('list', true);
		}
		public MetaDataRequest setList(Boolean listB)
		{
			addParam('list', listB);
			return this;
		}
		public Boolean getIncludeDeleted()
		{
			return getParam('include_deleted', false);
		}
		public MetaDataRequest setIncludeDeleted(Boolean includeDeleted)
		{
			addParam('include_deleted', includeDeleted);
			return this;
		}
		public String getRev()
		{
			return getParam('rev');
		}
		public MetaDataRequest setRev(String rev)
		{
			addParam('rev', rev);
			return this;
		}
		public String getLocale()
		{
			return getParam('locale');
		}
		public MetaDataRequest setLocale(String locale)
		{
			addParam('locale', locale);
			return this;
		}
		public Boolean getIncludeMediaInfo()
		{
			return getParam('include_media_info', true);
		}
		public MetaDataRequest setIncludeMediaInfo(Boolean includeMediaInfo)
		{
			addParam('include_media_info', includeMediaInfo);
			return this;
		}
	}
	
	public class DeltaRequest extends DropboxRequest
	{
		DeltaRequest(ffhttp_DropboxFiles files)
		{
			super(files, DROPBOX_API_URL + '1/delta', REQUEST_METHOD_POST, 
				  null, new ffhttp_DropboxModelDelta());
		}
		
		/**
		 * Request Parameters
		 */
		public String getCursor()
		{
			return getParam('cursor');
		}
		public DeltaRequest setCursor(String cursor)
		{
			addParam('cursor', cursor);
			return this;
		}
		public String getLocale()
		{
			return getParam('locale');
		}
		public DeltaRequest setLocale(String locale)
		{
			addParam('locale', locale);
			return this;
		}
		public String getPathPrefix()
		{
			return getParam('path_prefix');
		}
		public DeltaRequest setPathPrefix(String pathPrefix)
		{
			addParam('path_prefix', pathPrefix);
			return this;
		}
		public Boolean getIncludeMediaInfo()
		{
			return getParam('include_media_info', true);
		}
		public DeltaRequest setIncludeMediaInfo(Boolean includeMediaInfo)
		{
			addParam('include_media_info', includeMediaInfo);
			return this;
		}	
	}
	
	public class DeltaLatestCursorRequest extends DropboxRequest
	{
		DeltaLatestCursorRequest(ffhttp_DropboxFiles files)
		{
			super(files, DROPBOX_API_URL + '1/delta/latest_cursor', REQUEST_METHOD_POST, 
				  null, new ffhttp_DropboxModelDelta());
		}
		
		/**
		 * Request Parameters
		 */
		public String getPathPrefix()
		{
			return getParam('path_prefix');
		}
		public DeltaLatestCursorRequest setPathPrefix(String pathPrefix)
		{
			addParam('path_prefix', pathPrefix);
			return this;
		}
		public Boolean getIncludeMediaInfo()
		{
			return getParam('include_media_info', true);
		}
		public DeltaLatestCursorRequest setIncludeMediaInfo(Boolean includeMediaInfo)
		{
			addParam('include_media_info', includeMediaInfo);
			return this;
		}	
	}
	
	public class LongpollDeltaRequest extends DropboxRequest
	{
		LongpollDeltaRequest(ffhttp_DropboxFiles files)
		{
			super(files, DROPBOX_API_NOTIFY_URL + '1/longpoll_delta', REQUEST_METHOD_GET, 
				  null, new ffhttp_JsonDeserializer(ffhttp_DropboxModelLongpollDelta.class));
		}
		
		/**
		 * Request Parameters
		 */
		public String getCursor()
		{
			return getParam('cursor');
		}
		public LongpollDeltaRequest setCursor(String cursor)
		{
			addParam('cursor', cursor);
			return this;
		}
		public Integer getTimeout()
		{
			return getParam('timeout', 30);
		}
		public LongpollDeltaRequest setTimeout(Integer timeout)
		{
			addParam('timeout', timeout);
			return this;
		}
	}
		
	public class SearchRequest extends DropboxRequest
	{
		SearchRequest(ffhttp_DropboxFiles files, String path)
		{
			super(files, DROPBOX_API_URL + '1/search/auto/' + path, REQUEST_METHOD_GET, 
				  null, new ffhttp_JsonDeserializer(ffhttp_DropboxModelFile[].class));
		}
		
		/**
		 * Request Parameters
		 */
		public String getQuery()
		{
			return getParam('query');
		}
		public SearchRequest setQuery(String query)
		{
			addParam('query', query);
			return this;
		}
		public Integer getFileLimit()
		{
			return getParam('file_limit', 1000);
		}
		public SearchRequest setFileLimit(Integer fileLimit)
		{
			addParam('file_limit', fileLimit);
			return this;
		}
		public Boolean getIncludeDeleted()
		{
			return getParam('include_deleted', false);
		}
		public SearchRequest setIncludeDeleted(Boolean includeDeleted)
		{
			addParam('include_deleted', includeDeleted);
			return this;
		}
		public String getLocale()
		{
			return getParam('locale');
		}
		public SearchRequest setLocale(String locale)
		{
			addParam('locale', locale);
			return this;
		}
	}
	
	public class RevisionsRequest extends DropboxRequest
	{
		RevisionsRequest(ffhttp_DropboxFiles files, String path)
		{
			super(files, DROPBOX_API_URL + '1/revisions/auto/' + path, REQUEST_METHOD_GET, 
				  null, new ffhttp_JsonDeserializer(ffhttp_DropboxModelFile[].class));
		}
		
		/**
		 * Request Parameters
		 */
		public Integer getRevLimit()
		{
			return getParam('rev_limit', 10);
		}
		public RevisionsRequest setRevLimit(Integer rev_limit)
		{
			addParam('rev_limit', rev_limit);
			return this;
		}
		public String getLocale()
		{
			return getParam('locale');
		}
		public RevisionsRequest setLocale(String locale)
		{
			addParam('locale', locale);
			return this;
		}
	}
	
	public class RestoreRequest extends DropboxRequest
	{
		RestoreRequest(ffhttp_DropboxFiles files, String path)
		{
			super(files, DROPBOX_API_URL + '1/restore/auto/' + path, REQUEST_METHOD_GET, 
				  null, new ffhttp_JsonDeserializer(ffhttp_DropboxModelFile.class));
		}
		
		/**
		 * Request Parameters
		 */
		public String getRev()
		{
			return getParam('rev');
		}
		public RestoreRequest setRev(String rev)
		{
			addParam('rev', rev);
			return this;
		}
		public String getLocale()
		{
			return getParam('locale');
		}
		public RestoreRequest setLocale(String locale)
		{
			addParam('locale', locale);
			return this;
		}
	}
	
	public class SharesRequest extends DropboxRequest
	{
		SharesRequest(ffhttp_DropboxFiles files, String path)
		{
			super(files, DROPBOX_API_URL + '1/shares/auto/' + path, REQUEST_METHOD_POST, 
				  null, new ffhttp_JsonDeserializer(ffhttp_DropboxModelUrl.class));
		}
		
		/**
		 * Request Parameters
		 */
		public String getLocale()
		{
			return getParam('locale');
		}
		public SharesRequest setLocale(String locale)
		{
			addParam('locale', locale);
			return this;
		}
		public Boolean getShortUrl()
		{
			return getParam('short_url', true);
		}
		public SharesRequest setShortUrl(Boolean shortUrl)
		{
			addParam('short_url', shortUrl);
			return this;
		}
	}

	public class MediaRequest extends DropboxRequest
	{
		MediaRequest(ffhttp_DropboxFiles files, String path)
		{
			super(files, DROPBOX_API_URL + '1/media/auto/' + path, REQUEST_METHOD_POST, 
				  null, new ffhttp_JsonDeserializer(ffhttp_DropboxModelUrl.class));
		}
		
		/**
		 * Request Parameters
		 */
		public String getLocale()
		{
			return getParam('locale');
		}
		public MediaRequest setLocale(String locale)
		{
			addParam('locale', locale);
			return this;
		}
	}
	
	public class CopyRefRequest extends DropboxRequest
	{
		CopyRefRequest(ffhttp_DropboxFiles files, String path)
		{
			super(files, DROPBOX_API_URL + '1/copy_ref/auto/' + path, REQUEST_METHOD_GET, 
				  null, new ffhttp_JsonDeserializer(ffhttp_DropboxModelCopyRef.class));
		}
	}
	
	public class ThumbnailsRequest extends DropboxRequest
	{
		ThumbnailsRequest(ffhttp_DropboxFiles files, String path)
		{
			super(files, DROPBOX_API_CONTENT_URL + '1/thumbnails/auto/' + path, REQUEST_METHOD_GET, null, null);
		}
		
		/**
		 * Request Parameters
		 */
		public String getFormat()
		{
			return getParam('format', 'jpeg');
		}
		public ThumbnailsRequest setFormat(String format)
		{
			addParam('format', format);
			return this;
		}
		public String getSize()
		{
			return getParam('size', THUMBNAIL_SIZE_SMALL);
		}
		public ThumbnailsRequest setSize(String size)
		{
			addParam('size', size);
			return this;
		}
	}
	
	public class PreviewsRequest extends DropboxRequest
	{
		PreviewsRequest(ffhttp_DropboxFiles files, String path)
		{
			super(files, DROPBOX_API_CONTENT_URL + '1/previews/auto/' + path, REQUEST_METHOD_GET, null, null);
		}
		
		/**
		 * Request Parameters
		 */
		public String getRev()
		{
			return getParam('rev');
		}
		public PreviewsRequest setRev(String rev)
		{
			addParam('rev', rev);
			return this;
		}
	}
	
	public class ChunkedUploadRequest extends DropboxRequest
	{
		ChunkedUploadRequest(ffhttp_DropboxFiles files, ffhttp_BlobContent content)
		{
			super(files, DROPBOX_API_CONTENT_URL + '1/chunked_upload', REQUEST_METHOD_PUT, 
				  content, new ffhttp_JsonDeserializer(ffhttp_DropboxModelUploadChunk.class));
		}
		
		/**
		 * Request Parameters
		 */
		public String getUploadId()
		{
			return getParam('upload_id');
		}
		public ChunkedUploadRequest setUploadId(String upload_id)
		{
			addParam('upload_id', upload_id);
			return this;
		}
		public Integer getOffset()
		{
			return getParam('offset', (Integer)null);
		}
		public ChunkedUploadRequest setOffset(Integer offset)
		{
			addParam('offset', offset);
			return this;
		}
	}

	public class CommitChunkedUploadRequest extends DropboxRequest
	{
		CommitChunkedUploadRequest(ffhttp_DropboxFiles files, String path)
		{
			super(files, DROPBOX_API_CONTENT_URL + '1/commit_chunked_upload/auto/' + path, REQUEST_METHOD_POST, 
				  null, new ffhttp_JsonDeserializer(ffhttp_DropboxModelFile.class));
		}
		
		/**
		 * Request Parameters
		 */
		public String getLocale()
		{
			return getParam('locale');
		}
		public CommitChunkedUploadRequest setLocale(String locale)
		{
			addParam('locale', locale);
			return this;
		}
		public Boolean getOverwrite()
		{
			return getParam('overwrite', true);
		}
		public CommitChunkedUploadRequest setOverwrite(Boolean overwrite)
		{
			addParam('overwrite', overwrite);
			return this;
		}
		public String getParentRev()
		{
			return getParam('parent_rev');
		}
		public CommitChunkedUploadRequest setParentRev(String parentRev)
		{
			addParam('parent_rev', parentRev);
			return this;
		}	
		public Boolean getAutoRename()
		{
			return getParam('autorename', true);
		}
		public CommitChunkedUploadRequest setAutoRename(Boolean autorename)
		{
			addParam('autorename', autorename);
			return this;
		}
		public String getUploadId()
		{
			return getParam('upload_id');
		}
		public CommitChunkedUploadRequest setUploadId(String upload_id)
		{
			addParam('upload_id', upload_id);
			return this;
		}
	}
}
