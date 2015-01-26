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
 * ffhttp_DropboxModelDelta
 *
 * An object that represents the changes that have occured in Dropbox since the given cursor.
 * https://www.dropbox.com/developers/core/docs#delta
 *
 * Example response:
 *
 * {
 *   "has_more": false,
 *   "cursor": "AAHjWQYRF2qFqZzEZu0zmowJElUpsOaYrCbOzLG9bAKR686zvGts5BaNlk09VglMxL0rAUaOZK40Z_hChoraoj0LU3nQai39_LFcziJTKVB7knwqjmM0TpzR9lmUj-Ii9gk",
 *   "entries": [
 *     [
 *       "/test.txt",
 *       {
 *         "rev": "88429f0770c",
 *         "thumb_exists": false,
 *         "path": "/Test.txt",
 *         "is_dir": false,
 *         "client_mtime": "Thu, 15 Jan 2015 14:41:03 +0000",
 *         "icon": "page_white_text",
 *         "read_only": false,
 *         "modifier": null,
 *         "bytes": 4,
 *         "modified": "Thu, 15 Jan 2015 14:41:03 +0000",
 *         "size": "4 bytes",
 *         "root": "dropbox",
 *         "mime_type": "text/plain",
 *         "revision": 2180
 *       }
 *     ]
 *   ],
 *   "reset": true
 * }
 */
public with sharing class ffhttp_DropboxModelDelta extends ffhttp_AbstractJsonSerializable
												   implements ffhttp_IDeserialize
{
	private List<DeltaEntry> entries;	//A list of "delta entries".
	private Boolean reset;				//If true, clear your local state before processing the delta entries. 
										//Reset is always true on the initial call to /delta (i.e. when no cursor is passed in). 
										//Otherwise, it is true in rare situations, such as after server or account maintenance,
										//or if a user deletes their app folder.
	private String cursor;				//A string that encodes the latest information that has been returned. 
										//On the next call to /delta, pass in this value.
	private Boolean has_more; 			//If true, then there are more entries available; you can call /delta again immediately 
										//to retrieve those entries. If 'false', then wait for at least five minutes (preferably 
										//longer) before checking again.
	
	/**									
	 * Constructor
	 */
	public ffhttp_DropboxModelDelta() 
	{
	}
	
	/**
	 * ffhttp_IDeserialize implementation
	 *
	 * Due to the way that delta entries are serialized we need to implement a bespoke deserialization strategy.
	 */
	public Object deserialize(String jsonString) 
	{
		//Deserialize into a String -> Object map and get the cursor, has_more and reset variables
		Map<String, Object> hm = (Map<String, Object>) JSON.deserializeUntyped(jsonString);
		cursor = (String)hm.get('cursor');
		has_more = (Boolean)hm.get('has_more');
		reset = (Boolean)hm.get('reset');
		
		//Now get the entries. The entries consist of a String, File array (rather than map hence why we are having to do this).
		List<Object> entriesList = (List<Object>)hm.get('entries');	
		if (entriesList != null)
		{
			//Create a file deserializer.
			ffhttp_JsonDeserializer fileDeserializer = new ffhttp_JsonDeserializer(ffhttp_DropboxModelFile.class);
		
			//Now go through the entries.
			for (Object entry : entriesList) 
			{
				List<Object> listEntry = (List<Object>)entry;
				String path = String.valueOf(listEntry[0]);
				
				//Reserialize the file object so that we can deserialize it into a file rather than a map.
				ffhttp_DropboxModelFile file = null;
				Object fileEntry = listEntry[1];
				if (fileEntry != null)
				{
					String serializedFileMetaData = JSON.serialize(fileEntry);
					file = (ffhttp_DropboxModelFile)fileDeserializer.deserialize(serializedFileMetaData);
				}
				
				//Create the DeltaEntry and add it to the list of entries.
				DeltaEntry de = new DeltaEntry(path, file);
				if (entries == null)
				{
					entries = new List<DeltaEntry>();
				}
				entries.add(de);
			}
		}
	
		return this;
	}

	/**
	 * Get/Sets
	 */
	public DeltaEntry[] getEntries() 
	{
		return entries;
	}
	public ffhttp_DropboxModelDelta setEntries(DeltaEntry[] entries) 
	{
		this.entries = entries;
		return this;
	}
	public Boolean getReset() 
	{
		return reset;
	}
	public ffhttp_DropboxModelDelta setReset(Boolean reset) 
	{
		this.reset = reset;
		return this;
	}
	public String getCursor() 
	{
		return cursor;
	}
	public ffhttp_DropboxModelDelta setCursor(String cursor) 
	{
		this.cursor = cursor;
		return this;
	}
	public Boolean getHasMore() 
	{
		return has_more;
	}
	public ffhttp_DropboxModelDelta setHasMore(Boolean has_more) 
	{
		this.has_more = has_more;
		return this;
	}
	
	/**
	 * DeltaEntry
	 *
	 * Each delta entry is a 2-item list of one of the following forms:
	 * 
	 * [<path>, <metadata>] - Indicates that there is a file/folder at the given path. 
	 * 
	 * You should add the entry to your local state. 
	 * The metadata value is the same as what would be returned by the /metadata call, except folder metadata doesn't 
	 * have hash or contents fields.
	 *						  
	 * To correctly process delta entries:
	 * If the new entry includes parent folders that don't yet exist in your local state, create those parent folders 
	 * in your local state.
	 * If the new entry is a file, replace whatever your local state has at path with the new entry.
	 * If the new entry is a folder, check what your local state has at <path>. 
	 * If it's a file, replace it with the new entry. If it's a folder, apply the new <metadata> to the folder, 
	 * but don't modify the folder's children. If your local state doesn't yet include this path, create it as a folder.
	 * If the new entry is a folder with the read-only field set to true, apply the read-only permission recursively to 
	 * all files within the shared folder.
	 * 
	 * [<path>, null] - Indicates that there is no file/folder at the given path. 
	 * 
	 * To update your local state to match, anything at path and all its children should be deleted. 
	 * Deleting a folder in your Dropbox will sometimes send down a single deleted entry for that folder, 
	 * and sometimes separate entries for the folder and all child paths. 
	 * If your local state doesn't have anything at path, ignore this entry.
	 * Note: Dropbox treats file names in a case-insensitive but case-preserving way. 
	 * To facilitate this, the <path> values above are lower-cased versions of the actual path. 
	 * The last path component of the <metadata> value will be case-preserved.	
	 */
	public class DeltaEntry extends ffhttp_AbstractJsonSerializable
	{
		private String path;
		private ffhttp_DropboxModelFile metaData;
		
		public DeltaEntry(String path, ffhttp_DropboxModelFile metaData)
		{
			this.path = path;
			this.metaData = metaData;	
		}
		
		/**
		 * Get/Sets
		 */
		public String getPath() 
		{
			return path;
		}
		public DeltaEntry setPath(String path) 
		{
			this.path = path;
			return this;
		}
		public ffhttp_DropboxModelFile getMetaData() 
		{
			return metadata;
		}
		public DeltaEntry setMetaData(ffhttp_DropboxModelFile metadata) 
		{
			this.metadata = metadata;
			return this;
		}
	}
}
