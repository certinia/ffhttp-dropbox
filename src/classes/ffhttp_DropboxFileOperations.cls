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
 * ffhttp_DropboxFileOperations
 *
 * This class contains the methods to access each of the Dropbox File Operation API calls.
 */
public with sharing class ffhttp_DropboxFileOperations extends ffhttp_DropboxResource
{
	/**
	 * Constructor
	 *
	 * @param service The ffhttp_DropboxFileOperations service.
	 * @return Access to the File Operations API calls.
	 */
	public ffhttp_DropboxFileOperations(ffhttp_Dropbox service) 
	{
		super(service);
	}
	
	/*********************************************************************************************************
	 * Requests
	 *********************************************************************************************************/

	public CopyRequest copyRequest()
	{
		return new CopyRequest(this);
	}
	
	public CreateFolderRequest createFolderRequest()
	{
		return new CreateFolderRequest(this);
	}
	
	public DeleteRequest deleteRequest()
	{
		return new DeleteRequest(this);
	}
	
	public MoveRequest moveRequest()
	{
		return new MoveRequest(this);
	}
	
	/*********************************************************************************************
	 * API Calls
	 *********************************************************************************************/
	
	/**
	 * /fileops/copy
	 *
	 * Copies a file or folder to a new location.
	 */
	public class CopyRequest extends TransferFileOperationRequest
	{
		CopyRequest(ffhttp_DropboxFileOperations fileOperations)
		{
			super(fileOperations, 'copy');
		}
		
		/**
		 * Request parameters
		 */
		public String getFromCopyRef()
		{
			return getParam('from_copy_ref');
		}
		public CopyRequest setFromCopyRef(String fromCopyRef)
		{
			addParam('from_copy_ref', fromCopyRef);
			return this;
		}
	}
	 
	/**
	 * /fileops/create_folder
	 *
	 * Creates a folder.
	 */
	public class CreateFolderRequest extends PathOperationRequest
	{
	 	CreateFolderRequest(ffhttp_DropboxFileOperations fileOperations) 
		{
			super(fileOperations, 'create_folder');
		}
	}
	
	/**
	 * /fileops/delete
	 *
	 * Deletes a file or folder.
	 */
	public class DeleteRequest extends PathOperationRequest
	{
		DeleteRequest(ffhttp_DropboxFileOperations fileOperations)
		{
			super(fileOperations, 'delete');
		}
	}
	
	/**
	 * /fileops/move
	 *
	 * Moves a file or folder to a new location.
	 */
	 public class MoveRequest extends TransferFileOperationRequest
	 {
	 	public MoveRequest(ffhttp_DropboxFileOperations fileOperations)
	 	{
	 		super(fileOperations, 'move');
	 	}
	 }
	 
	 /*********************************************************************************************
	 * Abstract classes
	 *********************************************************************************************/

	/**
	 * PathOperationRequest 
	 */
	public abstract class PathOperationRequest extends FileOperationRequest
	{
		public PathOperationRequest(ffhttp_DropboxFileOperations fileOperations, String fileOperation)
		{
			super(fileOperations, fileOperation);
		}
		
		/**
		 * Request parameters
		 */
		public String getPath()
		{
			return getParam('path');
		}
		public PathOperationRequest setPath(String path)
		{
			addParam('path', path);
			return this;
		}
	}

	/**
	 * TransferFileOperationRequest
	 *
	 * Contains the information generic to transfer file calls.
	 */ 
	public abstract class TransferFileOperationRequest extends FileOperationRequest
	{
		public TransferFileOperationRequest(ffhttp_DropboxFileOperations fileOperations, String fileOperation)
		{
			super(fileOperations, fileOperation);
		}
		
	 	/**
		 * Request parameters
		 */
	 	public String getFromPath()
		{
			return getParam('from_path');
		}
		public TransferFileOperationRequest setFromPath(String fromPath)
		{
			addParam('from_path', fromPath);
			return this;
		}
		public String getToPath()
		{
			return getParam('to_path');
		}
		public TransferFileOperationRequest setToPath(String toPath)
		{
			addParam('to_path', toPath);
			return this;
		}
	 }
	
	/**
	 * FileOperationRequest
	 * Contains the information generic to all file operation calls.
	 */
	public abstract class FileOperationRequest extends DropboxRequest 
	{
	 	FileOperationRequest(ffhttp_DropboxFileOperations fileOperations, String fileOperation) 
		{
			super(fileOperations, DROPBOX_FILE_OPERATION_URL + fileOperation, REQUEST_METHOD_POST, 
				  null, new ffhttp_JsonDeserializer(ffhttp_DropboxModelFile.class));
		}
		
		/**
		 * Request parameters
		 */
		public String getRoot()
		{
			return getParam('root');
		}
		public FileOperationRequest setRoot(String root)
		{
			addParam('root', root);
			return this;
		}
		public String getLocale()
		{
			return getParam('locale');
		}
		public FileOperationRequest setLocale(String locale)
		{
			addParam('locale', locale);
			return this;
		}
	}
}
