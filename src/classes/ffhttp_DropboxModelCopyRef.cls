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
 * ffhttp_DropboxModelCopyRef
 *
 * An object that represents a copy_ref to the specified file. 
 *
 * Example response:
 *
 * {
 *    "copy_ref": "z1X6ATl6aWtzOGq0c3g5Ng",
 *    "expires": "Fri, 31 Jan 2042 21:01:05 +0000"
 * }
 */
public with sharing class ffhttp_DropboxModelCopyRef extends ffhttp_AbstractJsonSerializable
{
	//Instance variables
	private String copy_ref; 	//The reference to the file to copy
	private String expires;		//The expiry date for the reference
	
	/**
	 * Get/Sets
	 */
	public String getCopyRef() 
	{
		return copy_ref;
	}
	public ffhttp_DropboxModelCopyRef setCopyRef(String copy_ref) 
	{
		this.copy_ref = copy_ref;
		return this;
	}
	public String getExpires() 
	{
		return expires;
	}
	public ffhttp_DropboxModelCopyRef setExpires(String expires) 
	{
		this.expires = expires;
		return this;
	}
}
