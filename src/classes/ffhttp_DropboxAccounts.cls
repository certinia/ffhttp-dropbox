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
public with sharing class ffhttp_DropboxAccounts extends ffhttp_DropboxResource
{
	/**
	 * Constructor
	 *
	 * @param service The ffhttp_Dropbox service.
	 * @return Access to the Accounts API calls.
	 */
	public ffhttp_DropboxAccounts(ffhttp_Dropbox service) 
	{
		super(service);
	}
	
	/*********************************************************************************************************
	 * Requests
	 *********************************************************************************************************/

	public InfoRequest infoRequest()
	{
		return new InfoRequest(this);
	}
	
	/*********************************************************************************************
	 * API Calls
	 *********************************************************************************************/
	
	/**
	 * /account/info
	 *
	 * Retrieves information about the user's account.
	 */
	public class InfoRequest extends DropboxRequest
	{
		InfoRequest(ffhttp_DropboxAccounts accounts)
		{
			super(accounts, DROPBOX_API_URL + '1/account/info', REQUEST_METHOD_GET, 
				  null, new ffhttp_JsonDeserializer(ffhttp_DropboxModelAccountInfo.class));
		}
		
		/**
		 * Request parameters
		 */
		public String getLocale()
		{
			return getParam('locale');
		}
		public InfoRequest setLocale(String locale)
		{
			addParam('locale', locale);
			return this;
		}
	}	
}
