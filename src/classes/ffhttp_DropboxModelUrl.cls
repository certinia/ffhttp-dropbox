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
 * ffhttp_DropboxModelUrl
 *
 * An object that represents the a URL response from Dropbox.
 *
 * Example response:
 *
 * {
 *     "url": "https://db.tt/c0mFuu1Y",
 *	   "expires": "Tue, 01 Jan 2030 00:00:00 +0000"
 * }
 */
public with sharing class ffhttp_DropboxModelUrl extends ffhttp_AbstractJsonSerializable
{
	//Instance variables
	private String url;		//The URL for the particular Dropbox File
	private String expires;	//The expiry date for the URL
	
	/**
	 * Get/Sets
	 */
	public String getUrl() 
	{
		return url;
	}
	public ffhttp_DropboxModelUrl setUrl(String url) 
	{
		this.url = url;
		return this;
	}
	public String getExpires() 
	{
		return expires;
	}
	public ffhttp_DropboxModelUrl setExpires(String expires) 
	{
		this.expires = expires;
		return this;
	}
}
