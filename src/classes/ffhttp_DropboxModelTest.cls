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
 * ffhttp_DropboxModelTest
 *
 * Tests each of the model classes.
 */
@isTest
public with sharing class ffhttp_DropboxModelTest 
{
	static testMethod void ffhttp_DropboxModelAccountInfo()
	{
		ffhttp_DropboxModelAccountInfo.QuotaInfo quotaInfo = new ffhttp_DropboxModelAccountInfo.QuotaInfo();
		quotaInfo.setShared(253738410565L)
				 .setQuota(107374182400000L)
				 .setNormal(680031877871L);
				 
		ffhttp_DropboxModelAccountInfo.Team team = new ffhttp_DropboxModelAccountInfo.Team();
		team.setName('Acme Inc.'); 
		
		ffhttp_DropboxModelAccountInfo accountInfo = new ffhttp_DropboxModelAccountInfo();
		accountInfo.setReferralLink('https://www.dropbox.com/referrals/r1a2n3d4m5s6t7')
				   .setDisplayName('John P. User')
				   .setUid('12345678')
				   .setTeam(team)
				   .setCountry('US')
				   .setQuotaInfo(quotaInfo);
				   
		System.assertEquals(accountInfo.getReferralLink(), 'https://www.dropbox.com/referrals/r1a2n3d4m5s6t7');
		System.assertEquals(accountInfo.getDisplayName(), 'John P. User');
		System.assertEquals(accountInfo.getUid(), '12345678');
		System.assertEquals(accountInfo.getTeam().getName(), 'Acme Inc.');
		System.assertEquals(accountInfo.getCountry(), 'US');
		System.assertEquals(accountInfo.getQuotaInfo().getShared(), 253738410565L);
		System.assertEquals(accountInfo.getQuotaInfo().getQuota(), 107374182400000L);
		System.assertEquals(accountInfo.getQuotaInfo().getNormal(), 680031877871L);
	}
	
	static testMethod void ffhttp_DropboxModelCopyRef()
	{
		ffhttp_DropboxModelCopyRef copyRef = new ffhttp_DropboxModelCopyRef();
		copyRef.setCopyRef('z1X6ATl6aWtzOGq0c3g5Ng')
		   	   .setExpires('Tue, 01 Jan 2030 00:00:00 +0000');
		   
		System.assertEquals(copyRef.getCopyRef(), 'z1X6ATl6aWtzOGq0c3g5Ng');
		System.assertEquals(copyRef.getExpires(), 'Tue, 01 Jan 2030 00:00:00 +0000');
 	}
 	
 	static testMethod void ffhttp_DropboxModelDelta()
 	{
 		String jsonStr = '{"has_more": false, "cursor": "AAHzPcmB0ZWBcS8cZHSl_5PR61tKzjcnmKFnzt--dzhS7CPPDTkFeGFQKNcz_7Y7J4U2Z0uIfHC4k1sFjGG4E19DtXHgYOG-DG24TdKh4M6a9BnmfaELWvqM_5OMWc7VuVs", "entries": [["/dscn3227.jpg", {"rev": "84c29f0770c", "thumb_exists": true, "path": "/DSCN3227.JPG", "is_dir": false, "client_mtime": "Tue, 26 Aug 2014 12:59:36 +0000", "icon": "page_white_picture", "bytes": 3337716, "modified": "Tue, 04 Nov 2014 20:58:29 +0000", "size": "3.2 MB", "root": "dropbox", "mime_type": "image/jpeg", "revision": 2124}], ["/dscn0800.jpg", {"rev": "84e29f0770c", "thumb_exists": true, "path": "/DSCN0800.JPG", "is_dir": false, "client_mtime": "Mon, 05 Aug 2013 08:47:36 +0000", "icon": "page_white_picture", "bytes": 456437, "modified": "Tue, 04 Nov 2014 20:58:37 +0000", "size": "445.7 KB", "root": "dropbox", "mime_type": "image/jpeg", "revision": 2126}]], "reset": false}';
	
		ffhttp_DropboxModelDelta delta = new ffhttp_DropboxModelDelta();
		delta.deserialize(jsonStr);
		
		System.assertEquals(delta.getReset(), false);
		System.assertEquals(delta.getHasMore(), false);
		System.assertEquals(delta.getCursor(), 'AAHzPcmB0ZWBcS8cZHSl_5PR61tKzjcnmKFnzt--dzhS7CPPDTkFeGFQKNcz_7Y7J4U2Z0uIfHC4k1sFjGG4E19DtXHgYOG-DG24TdKh4M6a9BnmfaELWvqM_5OMWc7VuVs');
		System.assertEquals(delta.getEntries().size(), 2);
		System.assertEquals(delta.getEntries()[0].getPath(), '/dscn3227.jpg');
		System.assertEquals(delta.getEntries()[0].getMetaData().getRev(), '84c29f0770c');

		delta.getEntries()[0].setPath(null);
		delta.getEntries()[0].setMetaData(null);
		
		System.assertEquals(delta.getEntries()[0].getPath(), null);
		System.assertEquals(delta.getEntries()[0].getMetaData(), null);
		
		delta.setEntries(null).setReset(true).setHasMore(true).setCursor('TestCursor');
		
		System.assertEquals(delta.getReset(), true);
		System.assertEquals(delta.getHasMore(), true);
		System.assertEquals(delta.getCursor(), 'TestCursor');
		System.assertEquals(delta.getEntries(), null);
 	}
 	
 	static testMethod void ffhttp_DropboxModelDelta_LatestCursor()
 	{
 		String jsonStr = '{"cursor": "AAFjPOaxfmu-9KjZknU79_HOxtyjVJ6rCVtbG3-6vS0BbQibskA83XpJ1H7tl33VO_OVFhOtuyt0r9xFmpbpkMrb_l3CnvkjHUsxcFdkz85TUFsvBK5ZET-rvpMK-Dh0psg"}';
 		
 		ffhttp_DropboxModelDelta delta = new ffhttp_DropboxModelDelta();
		delta.deserialize(jsonStr);
		
		System.assertEquals(delta.getReset(), null);
		System.assertEquals(delta.getHasMore(), null);
		System.assertEquals(delta.getCursor(), 'AAFjPOaxfmu-9KjZknU79_HOxtyjVJ6rCVtbG3-6vS0BbQibskA83XpJ1H7tl33VO_OVFhOtuyt0r9xFmpbpkMrb_l3CnvkjHUsxcFdkz85TUFsvBK5ZET-rvpMK-Dh0psg');
		System.assertEquals(delta.getEntries(), null);
 	} 	
	
	static testMethod void ffhttp_DropboxModelFile()
	{	
		ffhttp_DropboxModelFile.PhotoInfo photoInfo = new ffhttp_DropboxModelFile.PhotoInfo();
		photoInfo.setLatLong(new Double[]{ 37.77256666666666D, -122.45934166666667D})
				 .setTimeTaken('Wed, 28 Aug 2013 18:22:02 +0000');
				 		
		System.assertEquals(photoInfo.getLatLong(), new Double[]{ 37.77256666666666D, -122.45934166666667D});
		System.assertEquals(photoInfo.getTimeTaken(), 'Wed, 28 Aug 2013 18:22:02 +0000');
		
		ffhttp_DropboxModelFile.VideoInfo videoInfo = new ffhttp_DropboxModelFile.VideoInfo();
		videoInfo.setLatLong(new Double[]{ 37.77256666666666D, -122.45934166666667D})
				 .setTimeTaken('Wed, 28 Aug 2013 18:12:02 +0000')
				 .setDuration(30000);
				 		
		System.assertEquals(videoInfo.getLatLong(), new Double[]{ 37.77256666666666D, -122.45934166666667D});
		System.assertEquals(videoInfo.getTimeTaken(), 'Wed, 28 Aug 2013 18:12:02 +0000');
		System.assertEquals(videoInfo.getDuration(), 30000);
		
	 	ffhttp_DropboxModelFile file = new ffhttp_DropboxModelFile();
	 	file.setSize('2.3 MB')
	 		.setBytes(2453963)
	 		.setPath('/Photos/flower.jpg')
	 		.setDir(false)
	 		.setDeleted(false)
	 		.setRev('714f029684fe')
	 		.setHash('37eb1ba1849d4b0fb0b28caf7ef3af52')
	 		.setThumbExists(false)
	 		.setPhotoInfo(photoInfo)
	 		.setVideoInfo(videoInfo)
	 		.setIcon('page_white_acrobat')
	 		.setModified('Mon, 07 Apr 2014 23:13:16 +0000')
	 		.setClientMtime('Mon, 18 Jul 2011 18:04:35 +0000')
	 		.setRoot('app_folder');
	 	
	 	System.assertEquals(file.getSize(), '2.3 MB');
	 	System.assertEquals(file.getBytes(), 2453963);
	 	System.assertEquals(file.getPath(), '/Photos/flower.jpg');
	 	System.assertEquals(file.getDir(), false);
	 	System.assertEquals(file.getDeleted(), false);
	 	System.assertEquals(file.getRev(), '714f029684fe');
	 	System.assertEquals(file.getHash(), '37eb1ba1849d4b0fb0b28caf7ef3af52');
	 	System.assertEquals(file.getThumbExists(), false);
	 	System.assertEquals(file.getPhotoInfo().getLatLong(), new Double[]{ 37.77256666666666D, -122.45934166666667D});
		System.assertEquals(file.getPhotoInfo().getTimeTaken(), 'Wed, 28 Aug 2013 18:22:02 +0000');
	 	System.assertEquals(file.getVideoInfo().getLatLong(), new Double[]{ 37.77256666666666D, -122.45934166666667D});
		System.assertEquals(file.getVideoInfo().getTimeTaken(), 'Wed, 28 Aug 2013 18:12:02 +0000');
		System.assertEquals(file.getVideoInfo().getDuration(), 30000);
		System.assertEquals(file.getIcon(), 'page_white_acrobat');
		System.assertEquals(file.getModified(), 'Mon, 07 Apr 2014 23:13:16 +0000');
		System.assertEquals(file.getClientMtime(), 'Mon, 18 Jul 2011 18:04:35 +0000');
		System.assertEquals(file.getRoot(), 'app_folder');
		
	 	file.setDir(false);
	 	System.assertEquals(file.isFile(), true);
	 	System.assertEquals(file.isDirectory(), false);
	 	
	 	file.setDir(true);
	 	System.assertEquals(file.isFile(), false);
	 	System.assertEquals(file.isDirectory(), true);
	 
	 	file.setPath('/');
	 	System.assertEquals(file.getName(), 'Dropbox Root Directory');
	 	
	 	file.setPath('test/Getting_Started.pdf');
	 	System.assertEquals(file.getName(), 'Getting_Started.pdf');
	 	
	 	List<ffhttp_DropboxModelFile> files = file.getAllFiles();
	 	System.assertEquals(files.size(), 1);
	}
	
	static testMethod void ffhttp_DropboxModelFile_Serialized()
	{
		String jsonStr = '{"size":"0 bytes","hash":"37eb1ba1849d4b0fb0b28caf7ef3af52","bytes":0,"thumb_exists":false,"rev":"714f029684fe","modified":"Wed, 27 Apr 2011 22:18:51 +0000","path":"/Photos","is_dir":true,"icon":"folder","root":"dropbox","contents":[{"size":"2.3 MB","rev":"38af1b183490","thumb_exists":true,"bytes":2453963,"modified":"Mon, 07 Apr 2014 23:13:16 +0000","client_mtime":"Thu, 29 Aug 2013 01:12:02 +0000","path":"/Photos/flower.jpg","photo_info":{"lat_long":[37.77256666666666,-122.45934166666667],"time_taken":"Wed, 28 Aug 2013 18:12:02 +0000"},"is_dir":false,"icon":"page_white_picture","root":"dropbox","mime_type":"image/jpeg","revision":14511}],"revision":29007}';
	
		ffhttp_JsonDeserializer deserializer = new ffhttp_JsonDeserializer(ffhttp_DropboxModelFile.class);
		ffhttp_DropboxModelFile file = (ffhttp_DropboxModelFile)deserializer.deserialize(jsonStr);
		
		System.assertEquals(file.getSize(), '0 bytes');
	 	System.assertEquals(file.getBytes(), 0);
	 	System.assertEquals(file.getPath(), '/Photos');
	 	System.assertEquals(file.getDir(), true);
	 	System.assertEquals(file.getDeleted(), null);
	 	System.assertEquals(file.getRev(), '714f029684fe');
	 	System.assertEquals(file.getHash(), '37eb1ba1849d4b0fb0b28caf7ef3af52');
	 	System.assertEquals(file.getThumbExists(), false);
	 	System.assertEquals(file.getPhotoInfo(), null);
	 	System.assertEquals(file.getVideoInfo(), null);
		System.assertEquals(file.getIcon(), 'folder');
		System.assertEquals(file.getModified(), 'Wed, 27 Apr 2011 22:18:51 +0000');
		System.assertEquals(file.getClientMtime(), null);
		System.assertEquals(file.getRoot(), 'dropbox');
		
		List<ffhttp_DropboxModelFile> files = file.getAllFiles();
	 	System.assertEquals(files.size(), 2);
	}
	
	static testMethod void ffhttp_DropboxModelLongpollDelta()
	{
		ffhttp_DropboxModelLongpollDelta longpollDelta = new ffhttp_DropboxModelLongpollDelta();
		longpollDelta.setChanges(true).setBackoff(60);
		
		System.assertEquals(longpollDelta.getChanges(), true);
		System.assertEquals(longpollDelta.getBackoff(), 60);
	}
	
	static testMethod void ffhttp_DropboxModelUploadChunk()
	{
		ffhttp_DropboxModelUploadChunk uploadChunk = new ffhttp_DropboxModelUploadChunk();
		uploadChunk.setUploadId('v0k84B0AT9fYkfMUp0sBTA')
				   .setOffset(31337)
				   .setExpires('Tue, 19 Jul 2011 21:55:38 +0000');
				   
		System.assertEquals(uploadChunk.getUploadId(), 'v0k84B0AT9fYkfMUp0sBTA');
		System.assertEquals(uploadChunk.getOffset(), 31337);
		System.assertEquals(uploadChunk.getExpires(), 'Tue, 19 Jul 2011 21:55:38 +0000');
	}
	
	static testMethod void ffhttp_DropboxModelUrl()
	{
		ffhttp_DropboxModelUrl url = new ffhttp_DropboxModelUrl();
		url.setUrl('https://db.tt/c0mFuu1Y')
		   .setExpires('Tue, 01 Jan 2030 00:00:00 +0000');
		   
		System.assertEquals(url.getUrl(), 'https://db.tt/c0mFuu1Y');
		System.assertEquals(url.getExpires(), 'Tue, 01 Jan 2030 00:00:00 +0000');
 	}
}
