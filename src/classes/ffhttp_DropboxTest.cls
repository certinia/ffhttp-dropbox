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
 * ffhttp_DropboxTest
 *
 * This class contains the test methods for Dropbox.
 */
 @istest
private class ffhttp_DropboxTest 
{
	static testMethod void ffhttp_DropboxAccounts()
	{
		ffhttp_DropboxAccounts accounts = createAccounts();
		
		ffhttp_DropboxAccounts.InfoRequest infoRequest = accounts.infoRequest();
		assertRequestEndpointAndMethod(infoRequest, 'https://api.dropbox.com/1/account/info', 'GET');
		
		System.assertEquals(infoRequest.getLocale(), null);
		
		infoRequest.setLocale('Test');
					   
		System.assertEquals(infoRequest.getLocale(), 'Test');
	}
	
	static testMethod void ffhttp_DropboxFilesFilesRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		
		ffhttp_DropboxFiles.FilesRequest filesRequest = files.filesRequest('TestPath');
		assertRequestEndpointAndMethod(filesRequest, 'https://api-content.dropbox.com/1/files/auto/TestPath', 'GET');
		
		System.assertEquals(filesRequest.getRev(), null);
		
		filesRequest.setRev('Test');
					   
		System.assertEquals(filesRequest.getRev(), 'Test');
	}
	
	static testMethod void ffhttp_DropboxFilesFilesPutRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		
		ffhttp_DropboxFiles.FilesPutRequest filesPutRequest = files.filesPutRequest('TestPath', Blob.valueOf('Test data') , 'text/plain');
		assertRequestEndpointAndMethod(filesPutRequest, 'https://api-content.dropbox.com/1/files_put/auto/TestPath', 'PUT');
		
		System.assertEquals(filesPutRequest.getLocale(), null);
		System.assertEquals(filesPutRequest.getOverwrite(), true);
		System.assertEquals(filesPutRequest.getParentRev(), null);
		System.assertEquals(filesPutRequest.getAutoRename(), true);
		
		filesPutRequest.setLocale('en-US').setOverwrite(false).setParentRev('ParentRev').setAutoRename(false);

		System.assertEquals(filesPutRequest.getLocale(), 'en-US');
		System.assertEquals(filesPutRequest.getOverwrite(), false);
		System.assertEquals(filesPutRequest.getParentRev(), 'ParentRev');
		System.assertEquals(filesPutRequest.getAutoRename(), false);
	}
	
	static testMethod void ffhttp_DropboxFilesMetaDataRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		
		ffhttp_DropboxFiles.MetaDataRequest metaDataRequest = files.metaDataRequest('TestPath');
		assertRequestEndpointAndMethod(metaDataRequest, 'https://api.dropbox.com/1/metadata/auto/TestPath', 'GET');
		
		System.assertEquals(metaDataRequest.getFileLimit(), 10000);
		System.assertEquals(metaDataRequest.getHash(), null);
		System.assertEquals(metaDataRequest.getList(), true);
		System.assertEquals(metaDataRequest.getIncludeDeleted(), false);
		System.assertEquals(metaDataRequest.getRev(), null);
		System.assertEquals(metaDataRequest.getLocale(), null);
		System.assertEquals(metaDataRequest.getIncludeMediaInfo(), true);
		
		metaDataRequest.setFileLimit(100).setHash('Hash').setList(false).setIncludeDeleted(true).setRev('Test')
					   .setLocale('en-US').setIncludeMediaInfo(false);
					   
		System.assertEquals(metaDataRequest.getFileLimit(), 100);
		System.assertEquals(metaDataRequest.getHash(), 'Hash');
		System.assertEquals(metaDataRequest.getList(), false);
		System.assertEquals(metaDataRequest.getIncludeDeleted(), true);
		System.assertEquals(metaDataRequest.getRev(), 'Test');
		System.assertEquals(metaDataRequest.getLocale(), 'en-US');
		System.assertEquals(metaDataRequest.getIncludeMediaInfo(), false);
	}
	
	static testMethod void ffhttp_DropboxFilesDeltaRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		
		ffhttp_DropboxFiles.DeltaRequest deltaRequest = files.deltaRequest();
		assertRequestEndpointAndMethod(deltaRequest, 'https://api.dropbox.com/1/delta', 'POST');
	
		deltaRequest.setCursor('AAFjPOaxfmu-9KjZknU79_HOxtyjVJ6rCVtbG3-6vS0BbQibskA83XpJ1H7tl33VO_OVFhOtuyt0r9xFmpbpkMrb_l3CnvkjHUsxcFdkz85TUFsvBK5ZET-rvpMK-Dh0psg')
					.setLocale('en-US')
					.setPathPrefix('/Photos')
					.setIncludeMediaInfo(false);
					
		System.assertEquals(deltaRequest.getCursor(), 'AAFjPOaxfmu-9KjZknU79_HOxtyjVJ6rCVtbG3-6vS0BbQibskA83XpJ1H7tl33VO_OVFhOtuyt0r9xFmpbpkMrb_l3CnvkjHUsxcFdkz85TUFsvBK5ZET-rvpMK-Dh0psg'); 
		System.assertEquals(deltaRequest.getLocale(), 'en-US');
		System.assertEquals(deltaRequest.getPathPrefix(), '/Photos');
		System.assertEquals(deltaRequest.getIncludeMediaInfo(), false);
	}
	
	static testMethod void ffhttp_DropboxFilesDeltaLatestCursorRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		
		ffhttp_DropboxFiles.DeltaLatestCursorRequest deltaLatestCursorRequest = files.deltaLatestCursorRequest();
		assertRequestEndpointAndMethod(deltaLatestCursorRequest, 'https://api.dropbox.com/1/delta/latest_cursor', 'POST');
		
		deltaLatestCursorRequest.setPathPrefix('/Photos/Vacation')
								.setIncludeMediaInfo(true);
					
		System.assertEquals(deltaLatestCursorRequest.getPathPrefix(), '/Photos/Vacation');
		System.assertEquals(deltaLatestCursorRequest.getIncludeMediaInfo(), true);
	}
	
	static testMethod void ffhttp_DropboxFilesLongpollDeltaRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		
		ffhttp_DropboxFiles.LongpollDeltaRequest longpollDeltaRequest = files.longpollDeltaRequest();
		assertRequestEndpointAndMethod(longpollDeltaRequest, 'https://api-notify.dropbox.com/1/longpoll_delta', 'GET');
		
		System.assertEquals(longpollDeltaRequest.getCursor(), null);
		System.assertEquals(longpollDeltaRequest.getTimeout(), 30);
		
		longpollDeltaRequest.setCursor('AAFjPOaxfmu-9KjZknU79_HOxtyjVJ6rCVtbG3-6vS0BbQibskA83XpJ1H7tl33VO_OVFhOtuyt0r9xFmpbpkMrb_l3CnvkjHUsxcFdkz85TUFsvBK5ZET-rvpMK-Dh0psg')
							.setTimeout(60);
		
		System.assertEquals(longpollDeltaRequest.getCursor(), 'AAFjPOaxfmu-9KjZknU79_HOxtyjVJ6rCVtbG3-6vS0BbQibskA83XpJ1H7tl33VO_OVFhOtuyt0r9xFmpbpkMrb_l3CnvkjHUsxcFdkz85TUFsvBK5ZET-rvpMK-Dh0psg');
		System.assertEquals(longpollDeltaRequest.getTimeout(), 60);
	}
	
	static testMethod void ffhttp_DropboxFilesSearchRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		
		ffhttp_DropboxFiles.SearchRequest searchRequest = files.searchRequest('TestPath');
		assertRequestEndpointAndMethod(searchRequest, 'https://api.dropbox.com/1/search/auto/TestPath', 'GET');
		
		System.assertEquals(searchRequest.getQuery(), null);
		System.assertEquals(searchRequest.getFileLimit(), 1000);
		System.assertEquals(searchRequest.getIncludeDeleted(), false);
		System.assertEquals(searchRequest.getLocale(), null);
		
		searchRequest.setQuery('Test Search').setFileLimit(100).setIncludeDeleted(true).setLocale('en-US');
					  
		System.assertEquals(searchRequest.getQuery(), 'Test Search'); 
		System.assertEquals(searchRequest.getFileLimit(), 100);
		System.assertEquals(searchRequest.getIncludeDeleted(), true);
		System.assertEquals(searchRequest.getLocale(), 'en-US');
	}
	
	static testMethod void ffhttp_DropboxFilesRevisionsRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		
		ffhttp_DropboxFiles.RevisionsRequest revisionsRequest = files.revisionsRequest('TestPath');
		assertRequestEndpointAndMethod(revisionsRequest, 'https://api.dropbox.com/1/revisions/auto/TestPath', 'GET');
		
		System.assertEquals(revisionsRequest.getRevLimit(), 10);
		System.assertEquals(revisionsRequest.getLocale(), null);
		
		revisionsRequest.setRevLimit(100).setLocale('en-US');
					  
		System.assertEquals(revisionsRequest.getRevLimit(), 100);
		System.assertEquals(revisionsRequest.getLocale(), 'en-US');
	}
	
	static testMethod void ffhttp_DropboxFilesRestoreRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		
		ffhttp_DropboxFiles.RestoreRequest restoreRequest = files.restoreRequest('TestPath');
		assertRequestEndpointAndMethod(restoreRequest, 'https://api.dropbox.com/1/restore/auto/TestPath', 'GET');
		
		System.assertEquals(restoreRequest.getRev(), null);
		System.assertEquals(restoreRequest.getLocale(), null);
		
		restoreRequest.setRev('40000000d').setLocale('en-US');
					  
		System.assertEquals(restoreRequest.getRev(), '40000000d');
		System.assertEquals(restoreRequest.getLocale(), 'en-US');
	}
	
	static testMethod void ffhttp_DropboxFilesSharesRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		
		ffhttp_DropboxFiles.SharesRequest sharesRequest = files.sharesRequest('TestPath');
		assertRequestEndpointAndMethod(sharesRequest, 'https://api.dropbox.com/1/shares/auto/TestPath', 'POST');
		
		System.assertEquals(sharesRequest.getLocale(), null);
		System.assertEquals(sharesRequest.getShortUrl(), true);
		
		sharesRequest.setLocale('en-US').setShortUrl(false);

		System.assertEquals(sharesRequest.getLocale(), 'en-US');
		System.assertEquals(sharesRequest.getShortUrl(), false);
	}
	
	static testMethod void ffhttp_DropboxFilesMediaRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		
		ffhttp_DropboxFiles.MediaRequest mediaRequest = files.mediaRequest('TestPath');
		assertRequestEndpointAndMethod(mediaRequest, 'https://api.dropbox.com/1/media/auto/TestPath', 'POST');
		
		System.assertEquals(mediaRequest.getLocale(), null);

		mediaRequest.setLocale('en-US');

		System.assertEquals(mediaRequest.getLocale(), 'en-US');
	}
	
	static testMethod void ffhttp_DropboxFilesCopyRefRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		ffhttp_DropboxFiles.CopyRefRequest copyRefRequest = files.copyRefRequest('TestPath');
		assertRequestEndpointAndMethod(copyRefRequest, 'https://api.dropbox.com/1/copy_ref/auto/TestPath', 'GET');
	}
	
	static testMethod void ffhttp_DropboxFilesThumbnailsRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		ffhttp_DropboxFiles.ThumbnailsRequest thumbnailsRequest = files.thumbnailsRequest('TestPath');
		assertRequestEndpointAndMethod(thumbnailsRequest, 'https://api-content.dropbox.com/1/thumbnails/auto/TestPath', 'GET');
	
		System.assertEquals(thumbnailsRequest.getFormat(), 'jpeg');
		System.assertEquals(thumbnailsRequest.getSize(), 's');
			
		thumbnailsRequest.setFormat('png').setSize('xl');
		
		System.assertEquals(thumbnailsRequest.getFormat(), 'png');
		System.assertEquals(thumbnailsRequest.getSize(), 'xl');
	}
	
	static testMethod void ffhttp_DropboxFilesPreviewsRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		ffhttp_DropboxFiles.PreviewsRequest previewsRequest = files.previewsRequest('TestPath');
		assertRequestEndpointAndMethod(previewsRequest, 'https://api-content.dropbox.com/1/previews/auto/TestPath', 'GET');
		
		previewsRequest.setRev('Test');
		
		System.assertEquals(previewsRequest.getRev(), 'Test');
	}
	
	static testMethod void ffhttp_DropboxFilesChunkedUploadRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		
		ffhttp_DropboxFiles.ChunkedUploadRequest chunkedUploadRequest = files.chunkedUploadRequest(Blob.valueOf('Test data') , 'text/plain');	
		assertRequestEndpointAndMethod(chunkedUploadRequest, 'https://api-content.dropbox.com/1/chunked_upload', 'PUT');
		
		System.assertEquals(chunkedUploadRequest.getUploadId(), null);
		System.assertEquals(chunkedUploadRequest.getOffset(), null);
		
		chunkedUploadRequest.setUploadId('TestUploadId').setOffset(1627856);

		System.assertEquals(chunkedUploadRequest.getUploadId(), 'TestUploadId');
		System.assertEquals(chunkedUploadRequest.getOffset(), 1627856);
	}

	static testMethod void ffhttp_DropboxFilesCommitChunkedUploadRequest()
	{
		ffhttp_DropboxFiles files = createFiles();
		
		ffhttp_DropboxFiles.CommitChunkedUploadRequest commitChunkedUploadRequest = files.commitChunkedUploadRequest('TestPath');
		assertRequestEndpointAndMethod(commitChunkedUploadRequest, 'https://api-content.dropbox.com/1/commit_chunked_upload/auto/TestPath', 'POST');
		
		System.assertEquals(commitChunkedUploadRequest.getLocale(), null);
		System.assertEquals(commitChunkedUploadRequest.getOverwrite(), true);
		System.assertEquals(commitChunkedUploadRequest.getParentRev(), null);
		System.assertEquals(commitChunkedUploadRequest.getAutoRename(), true);
		System.assertEquals(commitChunkedUploadRequest.getUploadId(), null);
		
		commitChunkedUploadRequest.setLocale('en-US').setOverwrite(false).setParentRev('ParentRev').setAutoRename(false)
								  .setUploadId('TestUploadId');

		System.assertEquals(commitChunkedUploadRequest.getLocale(), 'en-US');
		System.assertEquals(commitChunkedUploadRequest.getOverwrite(), false);
		System.assertEquals(commitChunkedUploadRequest.getParentRev(), 'ParentRev');
		System.assertEquals(commitChunkedUploadRequest.getAutoRename(), false);
		System.assertEquals(commitChunkedUploadRequest.getUploadId(), 'TestUploadId');
	}
	
	static testMethod void ffhttp_DropboxFileOperationsCopyRequest()
	{
		ffhttp_DropboxFileOperations fileOperations = createFileOperations();
		
		ffhttp_DropboxFileOperations.CopyRequest copyRequest = fileOperations.copyRequest();
		assertRequestEndpointAndMethod(copyRequest, 'https://api.dropbox.com/1/fileops/copy', 'POST');
		
		System.assertEquals(copyRequest.getLocale(), null);
		System.assertEquals(copyRequest.getRoot(), null);
		System.assertEquals(copyRequest.getFromPath(), null);
		System.assertEquals(copyRequest.getToPath(), null);
		System.assertEquals(copyRequest.getFromCopyRef(), null);
		
		copyRequest.setFromCopyRef('z1X6ATl6aWtzOGq0c3g5Ng').setFromPath('test').setToPath('test2').setLocale('en-US').setRoot('auto');

		System.assertEquals(copyRequest.getLocale(), 'en-US');
		System.assertEquals(copyRequest.getRoot(), 'auto');
		System.assertEquals(copyRequest.getFromPath(), 'test');
		System.assertEquals(copyRequest.getToPath(), 'test2');
		System.assertEquals(copyRequest.getFromCopyRef(), 'z1X6ATl6aWtzOGq0c3g5Ng');
	}
	
	static testMethod void ffhttp_DropboxFileOperationsCreateFolderRequest()
	{
		ffhttp_DropboxFileOperations fileOperations = createFileOperations();
		
		ffhttp_DropboxFileOperations.CreateFolderRequest createFolderRequest = fileOperations.createFolderRequest();
		assertRequestEndpointAndMethod(createFolderRequest, 'https://api.dropbox.com/1/fileops/create_folder', 'POST');
		
		System.assertEquals(createFolderRequest.getLocale(), null);
		System.assertEquals(createFolderRequest.getRoot(), null);
		System.assertEquals(createFolderRequest.getPath(), null);
		
		createFolderRequest.setPath('test').setLocale('en-US').setRoot('auto');

		System.assertEquals(createFolderRequest.getLocale(), 'en-US');
		System.assertEquals(createFolderRequest.getRoot(), 'auto');
		System.assertEquals(createFolderRequest.getPath(), 'test');
	}
	
	static testMethod void ffhttp_DropboxFileOperationsDeleteRequest()
	{
		ffhttp_DropboxFileOperations fileOperations = createFileOperations();
		
		ffhttp_DropboxFileOperations.DeleteRequest deleteRequest = fileOperations.deleteRequest();
		assertRequestEndpointAndMethod(deleteRequest, 'https://api.dropbox.com/1/fileops/delete', 'POST');
		
		System.assertEquals(deleteRequest.getLocale(), null);
		System.assertEquals(deleteRequest.getRoot(), null);
		System.assertEquals(deleteRequest.getPath(), null);
		
		deleteRequest.setPath('test').setLocale('en-US').setRoot('auto');

		System.assertEquals(deleteRequest.getLocale(), 'en-US');
		System.assertEquals(deleteRequest.getRoot(), 'auto');
		System.assertEquals(deleteRequest.getPath(), 'test');
	}
	
	static testMethod void ffhttp_DropboxFileOperationsMoveRequest()
	{
		ffhttp_DropboxFileOperations fileOperations = createFileOperations();
		
		ffhttp_DropboxFileOperations.MoveRequest moveRequest = fileOperations.moveRequest();
		assertRequestEndpointAndMethod(moveRequest, 'https://api.dropbox.com/1/fileops/move', 'POST');
		
		System.assertEquals(moveRequest.getLocale(), null);
		System.assertEquals(moveRequest.getRoot(), null);
		System.assertEquals(moveRequest.getFromPath(), null);
		System.assertEquals(moveRequest.getToPath(), null);
		
		moveRequest.setFromPath('test').setToPath('test2').setLocale('en-US').setRoot('auto');

		System.assertEquals(moveRequest.getLocale(), 'en-US');
		System.assertEquals(moveRequest.getRoot(), 'auto');
		System.assertEquals(moveRequest.getFromPath(), 'test');
		System.assertEquals(moveRequest.getToPath(), 'test2');
	}
	
	private static ffhttp_Dropbox createClient()
	{
		return new ffhttp_Dropbox(new ffhttp_Client.Credentials('Bearer', 'Test Token'));
	}
	
	private static ffhttp_DropboxAccounts createAccounts()
	{
		ffhttp_Dropbox client = createClient();
		
		ffhttp_DropboxAccounts accounts = new ffhttp_DropboxAccounts(client);
		System.assertEquals(accounts.getService(), client);
		
		return client.accounts();
	}
	
	private static ffhttp_DropboxFiles createFiles()
	{
		ffhttp_Dropbox client = createClient();
		
		ffhttp_DropboxFiles files = new ffhttp_DropboxFiles(client);
		System.assertEquals(files.getService(), client);
		
		return client.files();
	}
	
	private static ffhttp_DropboxFileOperations createFileOperations()
	{
		ffhttp_Dropbox client = createClient();
		
		ffhttp_DropboxFileOperations fileOperations = new ffhttp_DropboxFileOperations(client);
		System.assertEquals(fileOperations.getService(), client);
		
		fileOperations.setService(null);
		System.assertEquals(fileOperations.getService(), null);
		
		return client.fileOperations();
	}
	
	private static void assertRequestEndpointAndMethod(ffhttp_Client.AbstractClientRequest request, 
													   String endpoint, String method)
	{
		System.HttpRequest httpRequest = request.buildHttpRequest();
		System.assertEquals(httpRequest.getEndpoint(), endpoint);
		System.assertEquals(httpRequest.getMethod(), method);
	}
}
