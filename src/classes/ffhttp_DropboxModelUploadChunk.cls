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
 * ffhttp_DropboxModelUploadChunk
 *
 * An object that represents the upload chunk response from Dropbox.
 * 
 * This is used for the /chunked_upload API call.
 *
 * Example response:
 *
 * {
 *    "upload_id": "v0k84B0AT9fYkfMUp0sBTA",
 *    "offset": 31337,
 *    "expires": "Tue, 19 Jul 2011 21:55:38 +0000" 
 * }
 */
public with sharing class ffhttp_DropboxModelUploadChunk extends ffhttp_AbstractJsonSerializable
{
	//Instance variables
	private String upload_id; 	//The unique ID of the in-progress upload on the server. 
								//If left blank, the server will create a new upload session.
	private Integer offset;		//The byte offset of this chunk, relative to the beginning of the full file. 
								//The server will verify that this matches the offset it expects. 
								//If it does not, the server will return an error with the expected offset.
	private String expires;		//The expiry date for the upload
	
	/**
	 * Get/Sets
	 */
	public String getUploadId() 
	{
		return upload_id;
	}
	public ffhttp_DropboxModelUploadChunk setUploadId(String upload_id) 
	{
		this.upload_id = upload_id;
		return this;
	}
	public Integer getOffset() 
	{
		return offset;
	}
	public ffhttp_DropboxModelUploadChunk setOffset(Integer offset) 
	{
		this.offset = offset;
		return this;
	}
	public String getExpires() 
	{
		return expires;
	}
	public ffhttp_DropboxModelUploadChunk setExpires(String expires) 
	{
		this.expires = expires;
		return this;
	}
}
