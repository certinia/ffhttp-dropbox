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
 * ffhttp_DropboxModelAccountInfo
 *
 * An object that represents the meta data for a user account in Dropbox.
 * https://www.dropbox.com/developers/core/docs#account-info
 *
 * Example response:
 *
 * {
 *    "referral_link": "https://www.dropbox.com/referrals/r1a2n3d4m5s6t7",
 *    "display_name": "John P. User",
 *    "uid": 12345678,
 *    "team": {
 *        "name": "Acme Inc."
 *     },
 *     "country": "US",
 *     "quota_info": {
 *         "shared": 253738410565,
 *         "quota": 107374182400000,
 *         "normal": 680031877871
 *     }
 * }
 */
public with sharing class ffhttp_DropboxModelAccountInfo extends ffhttp_AbstractJsonSerializable
{
	//Instance variables
	private String referral_link;	//The user's referral link.
	private String display_name;	//The user's display name.
	private String uid;				//The user's unique Dropbox ID.
	private String country;			//The user's two-letter country code, if available.
	private Team team;				//If the user belongs to a team, contains team information. 
									//Otherwise, null.
	private QuotaInfo quotaInfo;	//The user's used quota.
				
	/**
	 * Get/Sets
	 */
	public String getReferralLink() 
	{
		return referral_link;
	}
	public ffhttp_DropboxModelAccountInfo setReferralLink(String referral_link) 
	{
		this.referral_link = referral_link;
		return this;
	}
	public String getDisplayName() 
	{
		return display_name;
	}
	public ffhttp_DropboxModelAccountInfo setDisplayName(String display_name) 
	{
		this.display_name = display_name;
		return this;
	}
	public String getUid() 
	{
		return uid;
	}
	public ffhttp_DropboxModelAccountInfo setUid(String uid) 
	{
		this.uid = uid;
		return this;
	}
	public String getCountry() 
	{
		return country;
	}
	public ffhttp_DropboxModelAccountInfo setCountry(String country) 
	{
		this.country = country;
		return this;
	}
	public Team getTeam() 
	{
		return team;
	}
	public ffhttp_DropboxModelAccountInfo setTeam(Team team) 
	{
		this.team = team;
		return this;
	}
	public QuotaInfo getQuotaInfo() 
	{
		return quotaInfo;
	}
	public ffhttp_DropboxModelAccountInfo setQuotaInfo(QuotaInfo quotaInfo) 
	{
		this.quotaInfo = quotaInfo;
		return this;
	}
	 
	/**					
	 * Inner classes
	 */
	public class Team extends ffhttp_AbstractJsonSerializable
	{
		//Instance variables
		private String name; 	//The name of the team the user belongs to.	
		
		/**	
		 * Get/Sets
		 */
		public String getName()
		{
			return name;
		}
		public Team setName(String name)
		{
			this.name = name;
			return this;
		}
	}
	
	public class QuotaInfo extends ffhttp_AbstractJsonSerializable
	{
		//Instance variables
		private Long normal;	//The user's used quota outside of shared folders (bytes).
		private Long shared;	//The user's used quota in shared folders (bytes).
		private Long quota;		//The user's total quota allocation (bytes).
		
		/**
		 * Get/Sets
		 */
		public Long getNormal() 
		{
			return normal;
		}
		public QuotaInfo setNormal(Long normal) 
		{
			this.normal = normal;
			return this;
		}
		public Long getShared() 
		{
			return shared;
		}
		public QuotaInfo setShared(Long shared) 
		{
			this.shared = shared;
			return this;
		}
		public Long getQuota() 
		{
			return quota;
		}
		public QuotaInfo setQuota(Long quota) 
		{
			this.quota = quota;
			return this;
		}
	}
}
