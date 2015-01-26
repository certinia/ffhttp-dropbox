Apex Dropbox API Framework
==========================

<a href="https://githubsfdeploy.herokuapp.com?owner=financialforcedev&repo=ffhttp-dropbox">
    <img alt="Deploy to Salesforce"
        src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

Overview
--------

An Apex framework has been created to provide functionality for Dropbox API callouts. 

This library extends the [Core](https://github.com/financialforcedev/ffhttp-core) library to provide access to Dropbox API calls found at https://www.dropbox.com/developers/core/docs.

Key Features
------------

+ APEX Dropbox API.

Sample Code
-----------

Using the Dropbox library is straightforward once the connector between Salesforce and Dropbox has been set up.

To transfer a file between Salesforce and Dropbox the following example code can be used. In this example, a file is created in Dropbox with the name 'Test File' and the contents 'Test document contents'.

    //Create the credentials and Dropbox client
    ffhttp_Client.Credentials credentials = new ffhttp_Client.Credentials('Bearer', 'Sample_Token');
    ffhttp_Dropbox client = new ffhttp_Dropbox(credentials);

    //Create the test file data
    String path = 'Test File.txt';
    Blob fileContents = Blob.valueOf('Test document contents');
    String contentType = 'text/plain';

    //Create an insert request and execute
    ffhttp_DropboxFiles files = client.files();
    ffhttp_DropboxFiles.FilesPutRequest filesPutRequest = files.filesPutRequest(path, fileContents, contentType);
    filesPutRequest.execute();

    //This will insert a new file into Dropbox called 'Test File.txt' with the contents 'Test document contents'.

Configuration
-------------
This creates a connection between Salesforce and Dropbox using the packages described above.

Make sure that the [Core](https://githubsfdeploy.herokuapp.com?owner=financialforcedev&repo=ffhttp-core) and [Dropbox](https://githubsfdeploy.herokuapp.com?owner=financialforcedev&repo=ffhttp-dropbox) packages have been deployed to your Saleforce organisation.

###Create an app in Dropbox

1. Log in to your Dropbox account.
2. Go to https://www.dropbox.com/developers/apps and select **Create App**.
3. Select **Dropbox API app** for **What type of data does your app need to store on Dropbox?**.
4. Select **Files and datastores** for **Can your app be limited to its own folder?**.
5. Select **No** as **Can your app be limited to its own folder?**.
6. Select **All file types** for **What type of files does your app need access to?**.
7. Enter an **App name** and select **Create App**.
8. Set the **Redirect URIs** to the URL of the Salesforce organisation e.g. https://eu3.salesforce.com/apex/conector.
9. Make sure you know the **App Key** and **App Secret** as they will be needed later.

###Create a Connector in Salesforce
1. Log in to your Salesforce organisation.
2. Select the **OAuth** app.
3. Select **Connector Types** then **New**.
4. Enter a **Connector Type Name** e.g. Dropbox.
5. Set the **Authorization Endpoint** to https://www.dropbox.com/1/oauth2/authorize. 
6. Set the **Token Endpoint** to https://api.dropbox.com/1/oauth2/token.
7. Set the **Client ID** to the App Key obtained earlier.
8. Set the **Client Secret** to the App Secret obtained earlier.
9. Set the **Redirect URI** to the same URL as you set in step 8 in the Create an app in Dropbox section.
10. Make sure that **Scope Required** is unchecked.
11. **Save** the Connector Type.
12. Select **New Connector**.
13. Set the **Connector Name** and save. 
14. Select the Connector and then **Activate**. You will be directed to another Salesforce page that activates your connector.
15. Select **Authorize**. This will prompt you to log in to your Google account (if you are not already logged in) and then authenticate the scope provided earlier. Select **Accept** to authorize. 
16. Select **Save**. The connector is now ready for use.

Reporting Issues & Enhancements
-------------------------------

Please report any issues using the github [issues](https://github.com/financialforcedev/ffhttp-dropbox/issues) feature. Suggestions / bug reports are welcome as are extensions containing additional functionality.
