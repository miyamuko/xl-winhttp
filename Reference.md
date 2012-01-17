# xl-winhttp API Reference

  * [PACKAGES](#packages)
    * [xl-winhttp.api](#xl-winhttp.api)
  * [CONDITIONS](#conditions)
    * [winhttp-condition](#winhttp-condition)
  * [STRUCTS](#structs)
    * [connection](#connection)
    * [hinternet](#hinternet)
    * [request](#request)
    * [session](#session)
  * [MACROS](#macros)
    * [with-connect](#with-connect)
    * [with-open](#with-open)
    * [with-open-request](#with-open-request)
  * [FUNCTIONS](#functions)
    * [add-request-headers](#add-request-headers)
    * [check-platform](#check-platform)
    * [close-handle](#close-handle)
    * [connect](#connect)
    * [crack-url](#crack-url)
    * [create-proxy-resolver](#create-proxy-resolver)
    * [create-url](#create-url)
    * [detect-auto-proxy-config-url](#detect-auto-proxy-config-url)
    * [get-default-proxy-configuration](#get-default-proxy-configuration)
    * [get-ieproxy-config-for-current-user](#get-ieproxy-config-for-current-user)
    * [get-proxy-for-url](#get-proxy-for-url)
    * [get-proxy-for-url-ex](#get-proxy-for-url-ex)
    * [open](#open)
    * [open-request](#open-request)
    * [query-auth-schemes](#query-auth-schemes)
    * [query-data-available](#query-data-available)
    * [query-option](#query-option)
    * [query-request-header](#query-request-header)
    * [query-request-headers](#query-request-headers)
    * [query-response-header](#query-response-header)
    * [query-response-headers](#query-response-headers)
    * [read-data](#read-data)
    * [receive-response](#receive-response)
    * [reset-auto-proxy](#reset-auto-proxy)
    * [send-request](#send-request)
    * [set-credentials](#set-credentials)
    * [set-default-proxy-configuration](#set-default-proxy-configuration)
    * [set-option](#set-option)
    * [set-status-callback](#set-status-callback)
    * [set-timeouts](#set-timeouts)
    * [time-from-system-time](#time-from-system-time)
    * [time-from-universal-time](#time-from-universal-time)
    * [time-to-system-time](#time-to-system-time)
    * [time-to-universal-time](#time-to-universal-time)
    * [write-data](#write-data)
    * [xl-winhttp-version](#xl-winhttp-version)
  * [ACCESSORS](#accessors)
    * [connection-async-p](#connection-async-p)
    * [connection-callback](#connection-callback)
    * [connection-closed-p](#connection-closed-p)
    * [connection-context](#connection-context)
    * [connection-created-on](#connection-created-on)
    * [connection-description](#connection-description)
    * [connection-handle](#connection-handle)
    * [connection-p](#connection-p)
    * [connection-parent](#connection-parent)
    * [hinternet-async-p](#hinternet-async-p)
    * [hinternet-callback](#hinternet-callback)
    * [hinternet-closed-p](#hinternet-closed-p)
    * [hinternet-context](#hinternet-context)
    * [hinternet-created-on](#hinternet-created-on)
    * [hinternet-description](#hinternet-description)
    * [hinternet-handle](#hinternet-handle)
    * [hinternet-p](#hinternet-p)
    * [hinternet-parent](#hinternet-parent)
    * [request-async-p](#request-async-p)
    * [request-callback](#request-callback)
    * [request-closed-p](#request-closed-p)
    * [request-context](#request-context)
    * [request-created-on](#request-created-on)
    * [request-description](#request-description)
    * [request-handle](#request-handle)
    * [request-p](#request-p)
    * [request-parent](#request-parent)
    * [request-read-buffer](#request-read-buffer)
    * [request-secure-p](#request-secure-p)
    * [request-send-buffer](#request-send-buffer)
    * [session-async-p](#session-async-p)
    * [session-callback](#session-callback)
    * [session-closed-p](#session-closed-p)
    * [session-context](#session-context)
    * [session-created-on](#session-created-on)
    * [session-description](#session-description)
    * [session-handle](#session-handle)
    * [session-p](#session-p)
    * [session-parent](#session-parent)
    * [winhttp-condition-api](#winhttp-condition-api)
    * [winhttp-condition-error-code](#winhttp-condition-error-code)
    * [winhttp-condition-error-keyword](#winhttp-condition-error-keyword)
    * [winhttp-condition-error-name](#winhttp-condition-error-name)

----

## <a name="packages">PACKAGES</a>

### Package: <a name="xl-winhttp.api"><em>xl-winhttp.api</em></a>

TODO

ニックネームは以下のとおりです。

  * `winhttp.api`
  * `xl-winhttp`
  * `winhttp`


----

## <a name="conditions">CONDITIONS</a>

### Condition: <a name="winhttp-condition"><em>winhttp-condition</em></a>

TODO

__See Also:__

  * [winhttp-condition-api](#winhttp-condition-api)
  * [winhttp-condition-error-code](#winhttp-condition-error-code)
  * [winhttp-condition-error-keyword](#winhttp-condition-error-keyword)
  * [winhttp-condition-error-name](#winhttp-condition-error-name)


----

## <a name="structs">STRUCTS</a>

### Struct: <a name="connection"><em>connection</em></a>

TODO

__See Also:__

  * [connection-async-p](#connection-async-p)
  * [connection-callback](#connection-callback)
  * [connection-closed-p](#connection-closed-p)
  * [connection-context](#connection-context)
  * [connection-created-on](#connection-created-on)
  * [connection-description](#connection-description)
  * [connection-handle](#connection-handle)
  * [connection-p](#connection-p)
  * [connection-parent](#connection-parent)

### Struct: <a name="hinternet"><em>hinternet</em></a>

TODO

__See Also:__

  * [hinternet-async-p](#hinternet-async-p)
  * [hinternet-callback](#hinternet-callback)
  * [hinternet-closed-p](#hinternet-closed-p)
  * [hinternet-context](#hinternet-context)
  * [hinternet-created-on](#hinternet-created-on)
  * [hinternet-description](#hinternet-description)
  * [hinternet-handle](#hinternet-handle)
  * [hinternet-p](#hinternet-p)
  * [hinternet-parent](#hinternet-parent)

### Struct: <a name="request"><em>request</em></a>

TODO

__See Also:__

  * [request-async-p](#request-async-p)
  * [request-callback](#request-callback)
  * [request-closed-p](#request-closed-p)
  * [request-context](#request-context)
  * [request-created-on](#request-created-on)
  * [request-description](#request-description)
  * [request-handle](#request-handle)
  * [request-p](#request-p)
  * [request-parent](#request-parent)
  * [request-read-buffer](#request-read-buffer)
  * [request-secure-p](#request-secure-p)
  * [request-send-buffer](#request-send-buffer)

### Struct: <a name="session"><em>session</em></a>

TODO

__See Also:__

  * [session-async-p](#session-async-p)
  * [session-callback](#session-callback)
  * [session-closed-p](#session-closed-p)
  * [session-context](#session-context)
  * [session-created-on](#session-created-on)
  * [session-description](#session-description)
  * [session-handle](#session-handle)
  * [session-p](#session-p)
  * [session-parent](#session-parent)


----

## <a name="macros">MACROS</a>

### Macro: <a name="with-connect"><em>with-connect</em></a> <i>(`VAR` &rest `ARGS`) `&BODY` `BODY`</i>

TODO

__See Also:__

  * TODO

### Macro: <a name="with-open"><em>with-open</em></a> <i>(`VAR` &rest `ARGS`) `&BODY` `BODY`</i>

TODO

__See Also:__

  * TODO

### Macro: <a name="with-open-request"><em>with-open-request</em></a> <i>(`VAR` &rest `ARGS`) `&BODY` `BODY`</i>

TODO

__See Also:__

  * TODO


----

## <a name="functions">FUNCTIONS</a>

### Function: <a name="add-request-headers"><em>add-request-headers</em></a> <i>`REQUEST` `HEADERS` &optional (`MODIFIERS` :add)</i>

```
WinHttpAddRequestHeaders function

The WinHttpAddRequestHeaders function adds one or more HTTP request headers to the HTTP request handle.

Syntax

BOOL WINAPI WinHttpAddRequestHeaders(
  __in  HINTERNET hRequest,
  __in  LPCWSTR pwszHeaders,
  __in  DWORD dwHeadersLength,
  __in  DWORD dwModifiers
);

Parameters

hRequest [in]

    A HINTERNET handle returned by a call to the WinHttpOpenRequest function.

pwszHeaders [in]

    A pointer to a string variable that contains the headers to append to the request. Each header except the last must
    be terminated by a carriage return/line feed (CR/LF).

dwHeadersLength [in]

    An unsigned long integer value that contains the length, in characters, of pwszHeaders. If this parameter is -1L,
    the function assumes that pwszHeaders is zero-terminated (ASCIIZ), and the length is computed.

dwModifiers [in]

    An unsigned long integer value that contains the flags used to modify the semantics of this function. Can be one or
    more of the following flags.

                         Value                                                    Meaning
    WINHTTP_ADDREQ_FLAG_ADD                         Adds the header if it does not exist. Used with
                                                    WINHTTP_ADDREQ_FLAG_REPLACE.

    WINHTTP_ADDREQ_FLAG_ADD_IF_NEW                  Adds the header only if it does not already exist; otherwise, an
                                                    error is returned.

    WINHTTP_ADDREQ_FLAG_COALESCE                    Merges headers of the same name.

                                                    Merges headers of the same name using a comma. For example, adding
                                                    "Accept: text/*" followed by "Accept: audio/*" with this flag
    WINHTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA         results in a single header "Accept: text/*, audio/*". This causes
                                                    the first header found to be merged. The calling application must
                                                    to ensure a cohesive scheme with respect to merged and separate
                                                    headers.

    WINHTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON     Merges headers of the same name using a semicolon.

                                                    Replaces or removes a header. If the header value is empty and the
    WINHTTP_ADDREQ_FLAG_REPLACE                     header is found, it is removed. If the value is not empty, it is
                                                    replaced.



Return value

Returns TRUE if successful, or FALSE otherwise. For extended error information, call GetLastError. Among the error
codes returned are the following.

               Error Code                                                 Description
ERROR_WINHTTP_INCORRECT_HANDLE_STATE     The requested operation cannot be performed because the handle supplied is not
                                         in the correct state.

ERROR_WINHTTP_INCORRECT_HANDLE_TYPE      The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR             An internal error has occurred.

ERROR_NOT_ENOUGH_MEMORY                  Not enough memory was available to complete the requested operation.



Remarks

Headers are transferred across redirects. This can be a security issue. To avoid having headers transferred when a
redirect occurs, use the WINHTTP_STATUS_CALLBACK callback to correct the specific headers when a redirect occurs.

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

The WinHttpAddRequestHeaders function appends additional free-format headers to the HTTP request handle and is intended
for use by sophisticated clients that require detailed control over the exact request sent to the HTTP server.

The name and value of request headers added with this function are validated. Headers must be well formed. For more
information about valid HTTP headers, see RFC 2616. If an invalid header is used, this function fails and GetLastError
returns ERROR_INVALID_PARAMETER. The invalid header is not added.

If you are sending a Date: request header, you can use the WinHttpTimeFromSystemTime function to create structure for
the header.

For basic WinHttpAddRequestHeaders, the application can pass in multiple headers in a single buffer.

An application can also use WinHttpSendRequest to add additional headers to the HTTP request handle before sending a
request.

Note  For more information, see Run-Time Requirements.

Examples

The following code example includes an If-Modified-Since header in a request. The response header is interpreted to
determine whether the target document has been updated.



  DWORD dwSize = sizeof(DWORD);
  DWORD dwStatusCode = 0;
  BOOL  bResults = FALSE;
  HINTERNET hSession = NULL,
        hConnect = NULL,
        hRequest = NULL;

  // Use WinHttpOpen to obtain a session handle.
  hSession = WinHttpOpen( L"A WinHTTP Example Program/1.0",
                          WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                          WINHTTP_NO_PROXY_NAME,
                          WINHTTP_NO_PROXY_BYPASS,
                          0 );

  // Specify an HTTP server.
  if( hSession )
    hConnect = WinHttpConnect( hSession,
                               L"www.microsoft.com",
                               INTERNET_DEFAULT_HTTP_PORT,
                               0 );

  // Create an HTTP Request handle.
  if( hConnect )
    hRequest = WinHttpOpenRequest( hConnect,
                                   L"GET",
                                   NULL,
                                   NULL,
                                   WINHTTP_NO_REFERER,
                                   WINHTTP_DEFAULT_ACCEPT_TYPES,
                                   0 );

  // Add a request header.
  if( hRequest )
    bResults = WinHttpAddRequestHeaders( hRequest,
                 L"If-Modified-Since: Mon, 20 Nov 2000 20:00:00 GMT",
                                         (ULONG)-1L,
                                         WINHTTP_ADDREQ_FLAG_ADD );

  // Send a Request.
  if( bResults )
    bResults = WinHttpSendRequest( hRequest,
                                   WINHTTP_NO_ADDITIONAL_HEADERS,
                                   0,
                                   WINHTTP_NO_REQUEST_DATA,
                                   0,
                                   0,
                                   0 );

  // End the request.
  if( bResults )
    bResults = WinHttpReceiveResponse( hRequest, NULL);

  // Use WinHttpQueryHeaders to obtain the header buffer.
  if( bResults )
    bResults = WinHttpQueryHeaders( hRequest,
                WINHTTP_QUERY_STATUS_CODE | WINHTTP_QUERY_FLAG_NUMBER,
                                    NULL,
                                    &dwStatusCode,
                                    &dwSize,
                                    WINHTTP_NO_HEADER_INDEX );

  // Based on the status code, determine whether
  // the document was recently updated.
  if( bResults )
  {
    if( dwStatusCode == 304 )
      printf( "Document has not been updated.\n" );
    else if( dwStatusCode == 200 )
      printf( "Document has been updated.\n" );
    else
      printf( "Status code = %u.\n",dwStatusCode );
  }

  // Report any errors.
  if( !bResults )
    printf( "Error %d has occurred.\n", GetLastError( ) );

  // Close open handles.
  if( hRequest ) WinHttpCloseHandle( hRequest );
  if( hConnect ) WinHttpCloseHandle( hConnect );
  if( hSession ) WinHttpCloseHandle( hSession );



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [open-request](#open-request)
  * [send-request](#send-request)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpAddRequestHeaders](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384087.aspx)

### Function: <a name="check-platform"><em>check-platform</em></a>

```
WinHttpCheckPlatform function

The WinHttpCheckPlatform function determines whether the current platform is supported by this version of Microsoft
Windows HTTP Services (WinHTTP).

Syntax

BOOL WinHttpCheckPlatform(void);

Parameters

This function has no parameters.

Return value

The return value is TRUE if the platform is supported by Microsoft Windows HTTP Services (WinHTTP), or FALSE otherwise.

Remarks

This function is useful if your application uses Microsoft Windows HTTP Services (WinHTTP), but also supports platforms
that WinHTTP does not.

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

WinHTTP version 5.1 is an operating-system component of Windows 2000 with Service Pack 3 (SP3) and later (except
Datacenter Server), Windows XP with Service Pack 1 (SP1) and later, and Windows Server 2003. In Windows Server 2003,
WinHTTP is a system side-by-side assembly.

For more information, see Run-Time Requirements.

Examples

The following example shows how to determine whether the current platform is supported.


    if (WinHttpCheckPlatform( ))
        printf("This platform is supported by WinHTTP.\n");
    else
        printf("This platform is NOT supported by WinHTTP.\n");



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpCheckPlatform](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384089.aspx)

### Function: <a name="close-handle"><em>close-handle</em></a> <i>`HINTERNET`</i>

```
WinHttpCloseHandle function

The WinHttpCloseHandle function closes a single HINTERNET handle.

Syntax

BOOL WINAPI WinHttpCloseHandle(
  __in  HINTERNET hInternet
);

Parameters

hInternet [in]

    Valid HINTERNET handle to be closed.

Return value

Returns TRUE if the handle is successfully closed, or FALSE otherwise. To get extended error information, call
GetLastError. Among the error codes returned are the following.

          Error Codes                                                 Description
ERROR_WINHTTP_SHUTDOWN           The WinHTTP function support is being shut down or unloaded.

ERROR_WINHTTP_INTERNAL_ERROR     An internal error has occurred.

ERROR_NOT_ENOUGH_MEMORY          Not enough memory was available to complete the requested operation. (Windows error
                                 code)



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

If there is a status callback registered for the handle being closed and the handle was created with a non-NULL context
value, a WINHTTP_CALLBACK_STATUS_HANDLE_CLOSING callback is made. This is the last callback made from the handle and
indicates that the handle is being destroyed.

An application can terminate an in-progress synchronous or asynchronous request by closing the HINTERNET request handle
using WinHttpCloseHandle. For asynchronous requests, keep the following points in mind:

 ｡ｦ After an application calls WinHttpCloseHandle on a WinHTTP handle, it cannot call any other WinHTTP API functions
    using that handle from any thread.

 ｡ｦ Even after a call to WinHttpCloseHandle returns, the application must still be prepared to receive callbacks for
    the closed handle, because WinHTTP can tear down the handle asynchronously. If the asynchronous request was not
    able to complete successfully, the callback receives a WINHTTP_CALLBACK_STATUS_REQUEST_ERROR notification.

 ｡ｦ If an application associates a context data structure or object with the handle, it should maintain that binding
    until the callback function receives a WINHTTP_CALLBACK_STATUS_HANDLE_CLOSING notification. This is the last
    callback notification WinHTTP sends prior to deleting a handle object from memory. In order to receive the
    WINHTTP_CALLBACK_STATUS_HANDLE_CLOSING callback notification, the application must enable the
    WINHTTP_CALLBACK_FLAG_HANDLES flag in the WinHttpSetStatusCallback call.

 ｡ｦ Before calling WinHttpCloseHandle, an application can call WinHttpSetStatusCallback to indicate that no more
    callbacks should be made:

    WinHttpSetStatusCallback( hRequest, NULL, 0, 0 );

    It might seem that the context data structure could then be freed immediately rather than having to wait for a
    WINHTTP_CALLBACK_STATUS_HANDLE_CLOSING notification, but this is not the case: WinHTTP does not synchronize
    WinHttpSetStatusCallback with callbacks originating in worker threads. As a result, a callback could already be in
    progress from another thread, and the application could receive a callback notification even after having NULL
    ed-out the callback function pointer and deleted the handle's context data structure. Because of this potential
    race condition, be conservative in freeing the context structure until after having received the
    WINHTTP_CALLBACK_STATUS_HANDLE_CLOSING notification.

An application should never WinHttpCloseHandle call on a synchronous request. This can create a race condition. See
HINTERNET Handles in WinHTTP for more information.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHttp start page.

Examples

The following example shows you how to retrieve the connection time-out value:


    DWORD data;
    DWORD dwSize = sizeof(DWORD);

    // Use WinHttpOpen to obtain an HINTERNET handle.
    HINTERNET hSession = WinHttpOpen(L"A WinHTTP Example Program/1.0",
                                    WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                                    WINHTTP_NO_PROXY_NAME,
                                    WINHTTP_NO_PROXY_BYPASS, 0);
    if (hSession)
    {


        // Use WinHttpQueryOption to retrieve internet options.
        if (WinHttpQueryOption( hSession,
                                WINHTTP_OPTION_CONNECT_TIMEOUT,
                                &data, &dwSize))
        {
            printf("Connection timeout: %u ms\n\n",data);
        }
        else
        {
            printf("Error %u in WinHttpQueryOption.\n",
                   GetLastError());
        }

        // When finished, release the HINTERNET handle.
        WinHttpCloseHandle(hSession);
    }
    else
    {
        printf("Error %u in WinHttpOpen.\n", GetLastError());
    }



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [open](#open)
  * [open-request](#open-request)
  * [connect](#connect)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpCloseHandle](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384090.aspx)

### Function: <a name="connect"><em>connect</em></a> <i>`SESSION` `SERVER` &optional (`PORT` INTERNET_DEFAULT_PORT)</i>

```
WinHttpConnect function

The WinHttpConnect function specifies the initial target server of an HTTP request and returns an HINTERNET connection
handle to an HTTP session for that initial target.

Syntax

HINTERNET WINAPI WinHttpConnect(
  __in        HINTERNET hSession,
  __in        LPCWSTR pswzServerName,
  __in        INTERNET_PORT nServerPort,
  __reserved  DWORD dwReserved
);

Parameters

hSession [in]

    Valid HINTERNET WinHTTP session handle returned by a previous call to WinHttpOpen.

pswzServerName [in]

    Pointer to a null-terminated string that contains the host name of an HTTP server. Alternately, the string can
    contain the IP address of the site in ASCII, for example, 10.0.1.45. Note that WinHttp does not accept
    international host names without converting them first to Punycode. For more information, see Handling
    Internationalized Domain Names (IDNs).

nServerPort [in]

    Unsigned integer that specifies the TCP/IP port on the server to which a connection is made. This parameter can be
    any valid TCP/IP port number, or one of the following values.

                 Value                                                    Meaning
    INTERNET_DEFAULT_HTTP_PORT      Uses the default port for HTTP servers (port 80).

                                    Uses the default port for HTTPS servers (port 443). Selecting this port does not
    INTERNET_DEFAULT_HTTPS_PORT     automatically establish a secure connection. You must still specify the use of
                                    secure transaction semantics by using the WINHTTP_FLAG_SECURE flag with
                                    WinHttpOpenRequest.

    INTERNET_DEFAULT_PORT           Uses port 80 for HTTP and port 443 for Secure Hypertext Transfer Protocol (HTTPS).



dwReserved [in]

    This parameter is reserved and must be 0.

Return value

Returns a valid connection handle to the HTTP session if the connection is successful, or NULL otherwise. To retrieve
extended error information, call GetLastError. Among the error codes returned are the following.

              Error Codes                                                 Description
ERROR_WINHTTP_INCORRECT_HANDLE_TYPE     The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR            An internal error has occurred.

ERROR_WINHTTP_INVALID_URL               The URL is invalid.

ERROR_WINHTTP_OPERATION_CANCELLED       The operation was canceled, usually because the handle on which the request was
                                        operating was closed before the operation completed.

ERROR_WINHTTP_UNRECOGNIZED_SCHEME       The URL scheme could not be recognized, or is not supported.

ERROR_WINHTTP_SHUTDOWN                  The WinHTTP function support is being shut down or unloaded.

ERROR_NOT_ENOUGH_MEMORY                 Not enough memory was available to complete the requested operation. (Windows
                                        error code)



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

After the calling application has finished using the HINTERNET handle returned by WinHttpConnect, it must be closed
using the WinHttpCloseHandle function.

WinHttpConnect specifies the target HTTP server, however a response can come from another server if the request was
redirected. You can determine the URL of the server sending the response by calling WinHttpQueryOption with the
WINHTTP_OPTION_URL flag.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHttp start page.

Examples

The following example shows how to use secure transaction semantics to download a resource from an HTTPS server. The
sample code initializes the Microsoft Windows HTTP Services (WinHTTP) application programming interface (API), selects
a target HTTPS server, then opens and sends a request for this secure resource. WinHttpQueryDataAvailable is used with
the request handle to determine how much data is available for download, then WinHttpReadData is used to read that
data. This process repeats until the entire document has been retrieved and displayed.



    DWORD dwSize = 0;
    DWORD dwDownloaded = 0;
    LPSTR pszOutBuffer;
    BOOL  bResults = FALSE;
    HINTERNET  hSession = NULL,
               hConnect = NULL,
               hRequest = NULL;

    // Use WinHttpOpen to obtain a session handle.
    hSession = WinHttpOpen( L"WinHTTP Example/1.0",
                            WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                            WINHTTP_NO_PROXY_NAME,
                            WINHTTP_NO_PROXY_BYPASS, 0);

    // Specify an HTTP server.
    if (hSession)
        hConnect = WinHttpConnect( hSession, L"www.microsoft.com",
                                   INTERNET_DEFAULT_HTTPS_PORT, 0);

    // Create an HTTP request handle.
    if (hConnect)
        hRequest = WinHttpOpenRequest( hConnect, L"GET", NULL,
                                       NULL, WINHTTP_NO_REFERER,
                                       WINHTTP_DEFAULT_ACCEPT_TYPES,
                                       WINHTTP_FLAG_SECURE);

    // Send a request.
    if (hRequest)
        bResults = WinHttpSendRequest( hRequest,
                                       WINHTTP_NO_ADDITIONAL_HEADERS,
                                       0, WINHTTP_NO_REQUEST_DATA, 0,
                                       0, 0);


    // End the request.
    if (bResults)
        bResults = WinHttpReceiveResponse( hRequest, NULL);

    // Keep checking for data until there is nothing left.
    if (bResults)
        do
        {
            // Check for available data.
            dwSize = 0;
            if (!WinHttpQueryDataAvailable( hRequest, &dwSize))
                printf("Error %u in WinHttpQueryDataAvailable.\n", GetLastError());

            // Allocate space for the buffer.
            pszOutBuffer = new char[dwSize+1];
            if (!pszOutBuffer)
            {
                printf("Out of memory\n");
                dwSize=0;
            }
            else
            {
                // Read the Data.
                ZeroMemory(pszOutBuffer, dwSize+1);

                if (!WinHttpReadData( hRequest, (LPVOID)pszOutBuffer,
                                      dwSize, &dwDownloaded))
                    printf( "Error %u in WinHttpReadData.\n", GetLastError());
                else
                    printf( "%s\n", pszOutBuffer);

                // Free the memory allocated to the buffer.
                delete [] pszOutBuffer;
            }

        } while (dwSize > 0);


    // Report any errors.
    if (!bResults)
        printf("Error %d has occurred.\n", GetLastError());

    // Close any open handles.
    if (hRequest) WinHttpCloseHandle(hRequest);
    if (hConnect) WinHttpCloseHandle(hConnect);
    if (hSession) WinHttpCloseHandle(hSession);



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [open](#open)
  * [open-request](#open-request)
  * [close-handle](#close-handle)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpConnect](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384091.aspx)

### Function: <a name="crack-url"><em>crack-url</em></a> <i>`URL` &key `:decode` `:escape` `:reject-userpwd`</i>

```
WinHttpCrackUrl function

The WinHttpCrackUrl function separates a URL into its component parts such as host name and path.

Syntax

BOOL WINAPI WinHttpCrackUrl(
  __in     LPCWSTR pwszUrl,
  __in     DWORD dwUrlLength,
  __in     DWORD dwFlags,
  __inout  LPURL_COMPONENTS lpUrlComponents
);

Parameters

pwszUrl [in]

    Pointer to a string that contains the canonical URL to separate. WinHttpCrackUrl does not check this URL for
    validity or correct format before attempting to crack it.

dwUrlLength [in]

    The length of the pwszUrl string, in characters. If dwUrlLength is set to zero, WinHttpCrackUrl assumes that the
    pwszUrl string is null terminated and determines the length of the pwszUrl string based on that assumption.

dwFlags [in]

    The flags that control the operation. This parameter can be one of the following values.

            Value                                                    Meaning
                           Converts characters that are "escape encoded" (%xx) to their non-escaped form. This does not
    ICU_DECODE             decode other encodings, such as UTF-8. This feature can be used only if the user provides
                           buffers in the URL_COMPONENTS structure to copy the components into.

                           Escapes certain characters to their escape sequences (%xx). Characters to be escaped are
    ICU_ESCAPE             non-ASCII characters or those ASCII characters that must be escaped to be represented in an
                           HTTP request. This feature can be used only if the user provides buffers in the
                           URL_COMPONENTS structure to copy the components into.

                           Rejects URLs as input that contains either a username, or a password, or both. If the
    ICU_REJECT_USERPWD     function fails because of an invalid URL, subsequent calls to GetLastError will return
                           ERROR_WINHTTP_INVALID_URL.



lpUrlComponents [in, out]

    Pointer to a URL_COMPONENTS structure that receives the URL components.

Return value

Returns TRUE if the function succeeds, or FALSE otherwise. To get extended error information, call GetLastError. Among
the error codes returned are the following.

             Error Codes                                                 Description
ERROR_WINHTTP_INTERNAL_ERROR          An internal error has occurred.

ERROR_WINHTTP_INVALID_URL             The URL is invalid.

ERROR_WINHTTP_UNRECOGNIZED_SCHEME     The URL scheme could not be recognized, or is not supported.

ERROR_NOT_ENOUGH_MEMORY               Not enough memory was available to complete the requested operation. (Windows
                                      error code)



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

The required components are indicated by members of the URL_COMPONENTS structure. Each component has a pointer to the
value and has a member that stores the length of the stored value. If both the value and the length for a component are
equal to zero, that component is not returned. If the pointer to the value of the component is not NULL and the value
of its corresponding length member is nonzero, the address of the first character of the corresponding component in the
pwszUrl string is stored in the pointer, and the length of the component is stored in the length member.

If the pointer contains the address of the user-supplied buffer, the length member must contain the size of the buffer.
The WinHttpCrackUrl function copies the component into the buffer, and the length member is set to the length of the
copied component, minus 1 for the trailing string terminator. If a user-supplied buffer is not large enough,
WinHttpCrackUrl returns FALSE, and GetLastError returns ERROR_INSUFFICIENT_BUFFER.

For WinHttpCrackUrl to work properly, the size of the URL_COMPONENTS structure must be stored in the dwStructSize
member of that structure.

If the Internet protocol of the URL passed in for pwszUrl is not HTTP or HTTPS, then WinHttpCrackUrl returns FALSE and
GetLastError indicates ERROR_WINHTTP_UNRECOGNIZED_SCHEME.

WinHttpCrackUrl does not check the validity or format of a URL before attempting to crack it. As a result, if a string
such as ""http://server?Bad=URL"" is passed in, the function returns incorrect results.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHttp start page.

Examples

This example shows how to break a URL into its components, update a component, then reconstruct the URL.


    URL_COMPONENTS urlComp;
    LPCWSTR pwszUrl1 =
      L"http://search.msn.com/results.asp?RS=CHECKED&FORM=MSNH&v=1&q=wininet";
    DWORD dwUrlLen = 0;

    // Initialize the URL_COMPONENTS structure.
    ZeroMemory(&urlComp, sizeof(urlComp));
    urlComp.dwStructSize = sizeof(urlComp);

    // Set required component lengths to non-zero
    // so that they are cracked.
    urlComp.dwSchemeLength    = (DWORD)-1;
    urlComp.dwHostNameLength  = (DWORD)-1;
    urlComp.dwUrlPathLength   = (DWORD)-1;
    urlComp.dwExtraInfoLength = (DWORD)-1;

    // Crack the URL.
    if (!WinHttpCrackUrl( pwszUrl1, (DWORD)wcslen(pwszUrl1), 0, &urlComp))
    {
        printf("Error %u in WinHttpCrackUrl.\n", GetLastError());
    }
    else
    {
        // Change the search information.
        // New info is the same length.
        urlComp.lpszExtraInfo = L"?RS=CHECKED&FORM=MSNH&v=1&q=winhttp";

        // Obtain the size of the new URL and allocate memory.
        WinHttpCreateUrl( &urlComp, 0, NULL, &dwUrlLen);
        LPWSTR pwszUrl2 = new WCHAR[dwUrlLen];

        // Create a new URL.
        if(!WinHttpCreateUrl( &urlComp, 0, pwszUrl2, &dwUrlLen))
        {
            printf("Error %u in WinHttpCreateUrl.\n", GetLastError());
        }
        else
        {
            // Show both URLs.
            printf("Old URL:  %S\nNew URL:  %S\n", pwszUrl1, pwszUrl2);
        }

        // Free allocated memory.
        delete [] pwszUrl2;
    }



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
Handling Uniform Resource Locators
  * [create-url](#create-url)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpCrackUrl](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384092.aspx)

### Function: <a name="create-proxy-resolver"><em>create-proxy-resolver</em></a> <i>`SESSION`</i>

```
WinHttpCreateProxyResolver function

[This documentation is preliminary and is subject to change.]

The WinHttpCreateProxyResolver function creates a handle for use by WinHttpGetProxyForUrlEx.

Syntax

DWORD WinHttpCreateProxyResolver(
  _In_   HINTERNET hSession,
  _Out_  HINTERNET *phResolver
);

Parameters

hSession [in]

    Valid HINTERNET WinHTTP session handle returned by a previous call to WinHttpOpen.

phResolver [out]

    A pointer to a new handle for use by WinHttpGetProxyForUrlEx. When finished or cancelling an outstanding operation,
    close this handle with WinHttpCloseHandle.

Return value

A status code indicating the result of the operation.

 The following codes may be returned.                                     Description
ERROR_SUCCESS                           The operation succeeded.

ERROR_INVALID_HANDLE                    hSession is NULL.

ERROR_WINHTTP_INCORRECT_HANDLE_TYPE     hSession is not the result of a call to WinHttpOpen or hSession is not marked
                                        as asynchronous using WINHTTP_FLAG_ASYNC.




Requirements

Minimum supported client Windows Developer Preview

Minimum supported server Windows Server Developer Preview

         Header          Winhttp.h
```
  * [WinHttpCreateProxyResolver](http://msdn.microsoft.com/en-us/library/windows/desktop/hh405355.aspx)

### Function: <a name="create-url"><em>create-url</em></a> <i>`SCHEME` `USERNAME` `PASSWORD` `HOSTNAME` `PORT` `URL-PATH` `EXTRA-INFO` &key `:escape` `:reject-userpwd`</i>

```
WinHttpCreateUrl function

The WinHttpCreateUrl function creates a URL from component parts such as the host name and path.

Syntax

BOOL WINAPI WinHttpCreateUrl(
  __in     LPURL_COMPONENTS lpUrlComponents,
  __in     DWORD dwFlags,
  __out    LPWSTR pwszUrl,
  __inout  LPDWORD lpdwUrlLength
);

Parameters

lpUrlComponents [in]

    Pointer to a URL_COMPONENTS structure that contains the components from which to create the URL.

dwFlags [in]

    Flags that control the operation of this function. This parameter can be one of the following values.

            Value                                                    Meaning
                           Converts all unsafe characters to their corresponding escape sequences in the path string
    ICU_ESCAPE             pointed to by the lpszUrlPath member and in lpszExtraInfo the extra-information string
                           pointed to by the member of the URL_COMPONENTS structure pointed to by the lpUrlComponents
                           parameter.

                           Rejects URLs as input that contains either a username, or a password, or both. If the
    ICU_REJECT_USERPWD     function fails because of an invalid URL, subsequent calls to GetLastError will return
                           ERROR_WINHTTP_INVALID_URL.



pwszUrl [out]

    Pointer to a character buffer that receives the URL as a wide character (Unicode) string.

lpdwUrlLength [in, out]

    Pointer to a variable of type unsigned long integer that receives the length of the pwszUrl buffer in wide
    (Unicode) characters. When the function returns, this parameter receives the length of the URL string wide in
    characters, minus 1 for the terminating character. If GetLastError returns ERROR_INSUFFICIENT_BUFFER, this
    parameter receives the number of wide characters required to hold the created URL.

Return value

Returns TRUE if the function succeeds, or FALSE otherwise. To get extended error data, call GetLastError. Among the
error codes returned are the following.

           Error Code                                                Description
ERROR_WINHTTP_INTERNAL_ERROR     An internal error occurred.

ERROR_NOT_ENOUGH_MEMORY          Insufficient memory available to complete the requested operation. (Windows error
                                 code)



Remarks

Even when WinHTTP is used in asynchronous mode, that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen, this
function operates synchronously. The return value indicates success or failure. To get extended error data, call
GetLastError.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHttp start page.

Examples

The following example shows how to decompile, or crack, a URL into its subcomponents, update a component, then
reconstruct the URL.



    URL_COMPONENTS urlComp;
    LPCWSTR pwszUrl1 =
       L"http://search.msn.com/results.asp?RS=CHECKED&FORM=MSNH&v=1&q=wininet";
    DWORD dwUrlLen = 0;

    // Initialize the URL_COMPONENTS structure.
    ZeroMemory(&urlComp, sizeof(urlComp));
    urlComp.dwStructSize = sizeof(urlComp);

    // Set required component lengths to non-zero,
    // so that they are cracked.
    urlComp.dwSchemeLength    = (DWORD)-1;
    urlComp.dwHostNameLength  = (DWORD)-1;
    urlComp.dwUrlPathLength   = (DWORD)-1;
    urlComp.dwExtraInfoLength = (DWORD)-1;

    // Crack the URL.
    if (!WinHttpCrackUrl( pwszUrl1, (DWORD)wcslen(pwszUrl1), 0, &urlComp))
    {
        printf("Error %u in WinHttpCrackUrl.\n", GetLastError());
    }
    else
    {
        // Change the search data. New data is the same length.
        urlComp.lpszExtraInfo = L"?RS=CHECKED&FORM=MSNH&v=1&q=winhttp";

        // Obtain the size of the new URL and allocate memory.
        WinHttpCreateUrl( &urlComp, 0, NULL, &dwUrlLen);
        LPWSTR pwszUrl2 = new WCHAR[dwUrlLen];

        // Create a new URL.
        if(!WinHttpCreateUrl( &urlComp, 0, pwszUrl2, &dwUrlLen))
        {
            printf( "Error %u in WinHttpCreateUrl.\n", GetLastError());
        }
        else
        {
            // Show both URLs.
            printf( "Old URL:  %S\nNew URL:  %S\n", pwszUrl1, pwszUrl2);
        }

        // Free allocated memory.
        delete [] pwszUrl2;
    }



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
Handling Uniform Resource Locators
  * [crack-url](#crack-url)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpCreateUrl](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384093.aspx)

### Function: <a name="detect-auto-proxy-config-url"><em>detect-auto-proxy-config-url</em></a> <i>&key `:dhcp` `:dns_a`</i>

```
WinHttpDetectAutoProxyConfigUrl function

The WinHttpDetectAutoProxyConfigUrl function finds the URL for the Proxy Auto-Configuration (PAC) file. This function
reports the URL of the PAC file, but it does not download the file.

Syntax

BOOL WINAPI WinHttpDetectAutoProxyConfigUrl(
  __in   DWORD dwAutoDetectFlags,
  __out  LPWSTR *ppwszAutoConfigUrl
);

Parameters

dwAutoDetectFlags [in]

    A data type that specifies what protocols to use to locate the PAC file. If both the DHCP and DNS auto detect flags
    are set, DHCP is used first; if no PAC URL is discovered using DHCP, then DNS is used.

                  Value                                                    Meaning
    WINHTTP_AUTO_DETECT_TYPE_DHCP      Use DHCP to locate the proxy auto-configuration file.

    WINHTTP_AUTO_DETECT_TYPE_DNS_A     Use DNS to attempt to locate the proxy auto-configuration file at a well-known
                                       location on the domain of the local computer.



ppwszAutoConfigUrl [out]

    A data type that returns a pointer to a null-terminated Unicode string that contains the configuration URL that
    receives the proxy data. You must free the string pointed to by ppwszAutoConfigUrl using the GlobalFree function.

Return value

Returns TRUE if successful, or FALSE otherwise. For extended error information, call GetLastError. Among the error
codes returned are the following.

              Error Code                                                 Description
ERROR_WINHTTP_AUTODETECTION_FAILED     Returned if WinHTTP was unable to discover the URL of the Proxy
                                       Auto-Configuration (PAC) file.

ERROR_WINHTTP_INTERNAL_ERROR           An internal error has occurred.

ERROR_NOT_ENOUGH_MEMORY                Not enough memory was available to complete the requested operation. (Windows
                                       error code)



Remarks

WinHTTP implements the Web Proxy Auto-Discovery (WPAD) protocol, often referred to as autoproxy. For more information
about well-known locations, see the Discovery Process section of the WPAD protocol document.

Note that because the WinHttpDetectAutoProxyConfigUrl function takes time to complete its operation, it should not be
called from a UI thread.

Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpDetectAutoProxyConfigUrl](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384094.aspx)

### Function: <a name="get-default-proxy-configuration"><em>get-default-proxy-configuration</em></a>

```
WinHttpGetDefaultProxyConfiguration function

The WinHttpGetDefaultProxyConfiguration function retrieves the default WinHTTP proxy configuration from the registry.

Syntax

BOOL WINAPI WinHttpGetDefaultProxyConfiguration(
  __inout  WINHTTP_PROXY_INFO *pProxyInfo
);

Parameters

pProxyInfo [in, out]

    A pointer to a variable of type WINHTTP_PROXY_INFO that receives the default proxy configuration.

Return value

Returns TRUE if successful or FALSE otherwise. To retrieve a specific error message, call GetLastError. Error codes
returned include the following.

           Error Code                                                 Description
ERROR_WINHTTP_INTERNAL_ERROR     An internal error has occurred.

ERROR_NOT_ENOUGH_MEMORY          Not enough memory was available to complete the requested operation. (Windows error
                                 code)



Remarks

WinHttpGetDefaultProxyConfiguration retrieves the proxy configuration set by WinHttpSetDefaultProxyConfiguration or
ProxyCfg.exe.

The default proxy configuration can be overridden for a WinHTTP session by calling WinHttpSetOption and specifying the
WINHTTP_OPTION_PROXY flag. WinHttpGetDefaultProxyConfiguration does not retrieve the configuration for the current
session. It retrieves the configuration specified in the registry.

If the registry contains a list of proxy servers, the dwAccessType member of pProxyInfo is set to
WINHTTP_ACCESS_TYPE_NAMED_PROXY. Otherwise, it is set to WINHTTP_ACCESS_TYPE_NO_PROXY.

WinHttpGetDefaultProxyConfiguration allocates memory for the string members of pProxyInfo. To free this memory, call
GlobalFree.

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHTTP Start Page.

Examples

The following code example shows how to retrieve the default proxy configuration from the registry.


    WINHTTP_PROXY_INFO proxyInfo;

    // Retrieve the default proxy configuration.
    WinHttpGetDefaultProxyConfiguration( &proxyInfo );

    // Display the proxy servers and free memory
    // allocated to this string.
    if (proxyInfo.lpszProxy != NULL)
    {
        printf("Proxy server list: %S\n", proxyInfo.lpszProxy);
        GlobalFree( proxyInfo.lpszProxy );
    }

    // Display the bypass list and free memory
    // allocated to this string.
    if (proxyInfo.lpszProxyBypass != NULL)
    {
        printf("Proxy bypass list: %S\n", proxyInfo.lpszProxyBypass);
        GlobalFree( proxyInfo.lpszProxyBypass );
    }



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

ProxyCfg.exe, a Proxy Configuration Tool
  * [set-default-proxy-configuration](#set-default-proxy-configuration)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpGetDefaultProxyConfiguration](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384095.aspx)

### Function: <a name="get-ieproxy-config-for-current-user"><em>get-ieproxy-config-for-current-user</em></a>

```
WinHttpGetIEProxyConfigForCurrentUser function

The WinHttpGetIEProxyConfigForCurrentUser function retrieves the Internet Explorer proxy configuration for the current
user.

Syntax

BOOL WINAPI WinHttpGetIEProxyConfigForCurrentUser(
  __inout  WINHTTP_CURRENT_USER_IE_PROXY_CONFIG *pProxyConfig
);

Parameters

pProxyConfig [in, out]

    A pointer, on input, to a WINHTTP_CURRENT_USER_IE_PROXY_CONFIG structure. On output, the structure contains the
    Internet Explorer proxy settings for the current active network connection (for example, LAN, dial-up, or VPN
    connection).

Return value

Returns TRUE if successful, or FALSE otherwise. For extended error information, call GetLastError. Among the error
codes returned are the following.

           Error Code                                                 Description
ERROR_FILE_NOT_FOUND             No Internet Explorer proxy settings can be found.

ERROR_WINHTTP_INTERNAL_ERROR     An internal error has occurred.

ERROR_NOT_ENOUGH_MEMORY          Not enough memory was available to complete the requested operation. (Windows error
                                 code)



Remarks

In Internet Explorer, the proxy settings are found on the Connections tab of the Tools / Internet Options menu option.
Proxy settings are configured on a per-connection basis; that is, the proxy settings for a LAN connection are separate
from those for a dial-up or VPN connection. WinHttpGetIEProxyConfigForCurrentUser returns the proxy settings for the
current active connection.

This function is useful in client applications running in network environments in which the Web Proxy Auto-Discovery
(WPAD) protocol is not implemented (meaning that no Proxy Auto-Configuration file is available). If a PAC file is not
available, then the WinHttpGetProxyForUrl function fails. The WinHttpGetIEProxyConfigForCurrentUser function can be
used as a fall-back mechanism to discover a workable proxy configuration by retrieving the user's proxy configuration
in Internet Explorer.

This function should not be used in a service process that does not impersonate a logged-on user.If the caller does not
impersonate a logged on user, WinHTTP attempts to retrieve the Internet Explorer settings for the current service
process: for example, the local service or the network service. If the Internet Explorer settings are not configured
for these system accounts, the call to WinHttpGetIEProxyConfigForCurrentUser will fail.

The caller must free the lpszProxy, lpszProxyBypass and lpszAutoConfigUrl strings in the
WINHTTP_CURRENT_USER_IE_PROXY_CONFIG structure if they are non-NULL. Use GlobalFree to free the strings.

Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpGetIEProxyConfigForCurrentUser](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384096.aspx)

### Function: <a name="get-proxy-for-url"><em>get-proxy-for-url</em></a> <i>`SESSION` `URL` &key `:auto-config-url` `:auto-logon-if-challenged` `:auto-detect` `:config-url` `:run-inprocess` `:run-outprocess-only` `:dhcp` `:dns_a`</i>

```
WinHttpGetProxyForUrl function

The WinHttpGetProxyForUrl function retrieves the proxy data for the specified URL.

Syntax

BOOL WINAPI WinHttpGetProxyForUrl(
  __in   HINTERNET hSession,
  __in   LPCWSTR lpcwszUrl,
  __in   WINHTTP_AUTOPROXY_OPTIONS *pAutoProxyOptions,
  __out  WINHTTP_PROXY_INFO *pProxyInfo
);

Parameters

hSession [in]

    The WinHTTP session handle returned by the WinHttpOpen function.

lpcwszUrl [in]

    A pointer to a null-terminated Unicode string that contains the URL of the HTTP request that the application is
    preparing to send.

pAutoProxyOptions [in]

    A pointer to a WINHTTP_AUTOPROXY_OPTIONS structure that specifies the auto-proxy options to use.

pProxyInfo [out]

    A pointer to a WINHTTP_PROXY_INFO structure that receives the proxy setting. This structure is then applied to the
    request handle using the WINHTTP_OPTION_PROXY option. Free the lpszProxy and lpszProxyBypass strings contained in
    this structure (if they are non-NULL) using the GlobalFree function.

Return value

If the function succeeds, the function returns TRUE.

If the function fails, it returns FALSE. For extended error data, call GetLastError.

Possible error codes include the folllowing.

                Error Code                                                  Description
ERROR_WINHTTP_AUTO_PROXY_SERVICE_ERROR      Returned by WinHttpGetProxyForUrl when a proxy for the specified URL cannot
                                            be located.

ERROR_WINHTTP_BAD_AUTO_PROXY_SCRIPT         An error occurred executing the script code in the Proxy Auto-Configuration
                                            (PAC) file.

ERROR_WINHTTP_INCORRECT_HANDLE_TYPE         The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR                An internal error has occurred.

ERROR_WINHTTP_INVALID_URL                   The URL is invalid.

                                            The login attempt failed. When this error is encountered, close the request
ERROR_WINHTTP_LOGIN_FAILURE                 handle with WinHttpCloseHandle. A new request handle must be created before
                                            retrying the function that originally produced this error.

ERROR_WINHTTP_OPERATION_CANCELLED           The operation was canceled, usually because the handle on which the request
                                            was operating was closed before the operation completed.

                                            The PAC file could not be downloaded. For example, the server referenced by
ERROR_WINHTTP_UNABLE_TO_DOWNLOAD_SCRIPT     the PAC URL may not have been reachable, or the server returned a 404 NOT
                                            FOUND response.

ERROR_WINHTTP_UNRECOGNIZED_SCHEME           The URL of the PAC file specified a scheme other than "http:" or "https:".

ERROR_NOT_ENOUGH_MEMORY                     Not enough memory was available to complete the requested operation.
                                            (Windows error code)



Remarks

This function implements the Web Proxy Auto-Discovery (WPAD) protocol for automatically configuring the proxy settings
for an HTTP request. The WPAD protocol downloads a Proxy Auto-Configuration (PAC) file, which is a script that
identifies the proxy server to use for a given target URL. PAC files are typically deployed by the IT department within
a corporate network environment. The URL of the PAC file can either be specified explicitly or WinHttpGetProxyForUrl
can be instructed to automatically discover the location of the PAC file on the local network.

WinHttpGetProxyForUrl supports only ECMAScript-based PAC files.

WinHttpGetProxyForUrl must be called on a per-URL basis, because the PAC file can return a different proxy server for
different URLs. This is useful because the PAC file enables an IT department to implement proxy server load balancing
by mapping (hashing) the target URL (specified by the lpcwszUrl parameter) to a certain proxy in a proxy server array.

WinHttpGetProxyForUrl caches the autoproxy URL and the autoproxy script when auto-discovery is specified in the dwFlags
member of the pAutoProxyOptions structure. For more information, see Autoproxy Cache.

Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpGetProxyForUrl](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384097.aspx)

### Function: <a name="get-proxy-for-url-ex"><em>get-proxy-for-url-ex</em></a> <i>`RESOLVER` `URL`</i>

```
WinHttpGetProxyForUrlEx function

[This documentation is preliminary and is subject to change.]

The WinHttpGetProxyForUrlEx function retrieves the proxy data for the specified URL.

Syntax

DWORD WINHTTPAPI WinHttpGetProxyForUrlEx(
  _In_      HINTERNET hResolver,
  _In_      PCWSTR pcwszUrl,
  _In_opt_  PCWSTR pcwszHost,
  _In_opt_  PCWSTR pcwszPath,
  _In_opt_  INTERNET_SCHEME isScheme,
  _In_opt_  INTERNET_PORT ipPort,
  _In_      WINHTTP_AUTOPROXY_OPTIONS *pAutoProxyOptions,
  _In_      DWORD_PTR pContext
);

Parameters

hResolver [in]

    The WinHTTP session handle returned by the WinHttpCreateProxyResolver function.

pcwszUrl [in]

    A pointer to a null-terminated Unicode string that contains the URL of the HTTP request that the application is
    preparing to send.

pcwszHost [in, optional]

    reserved

pcwszPath [in, optional]

    reserved

isScheme [in, optional]

    reserved

ipPort [in, optional]

    reserved

pAutoProxyOptions [in]

    A pointer to a WINHTTP_AUTOPROXY_OPTIONS structure that specifies the auto-proxy options to use.

pContext [in]

    Context data that will be passed to the completion callback function.

Return value

A status code indicating the result of the operation.

   The following codes may be returned.                                     Description
ERROR_IO_PENDING                            Success.

ERROR_WINHTTP_AUTO_PROXY_SERVICE_ERROR      Returned by WinHttpGetProxyForUrlEx when a proxy for the specified URL
                                            cannot be located.

ERROR_WINHTTP_BAD_AUTO_PROXY_SCRIPT         An error occurred executing the script code in the Proxy Auto-Configuration
                                            (PAC) file.

ERROR_WINHTTP_INCORRECT_HANDLE_TYPE         The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR                An internal error has occurred.

ERROR_WINHTTP_INVALID_URL                   The URL is invalid.

                                            The login attempt failed. When this error is encountered, close the request
ERROR_WINHTTP_LOGIN_FAILURE                 handle with WinHttpCloseHandle. A new request handle must be created before
                                            retrying the function that originally produced this error.

ERROR_WINHTTP_OPERATION_CANCELLED           The operation was canceled, usually because the handle on which the request
                                            was operating was closed before the operation completed.

                                            The PAC file could not be downloaded. For example, the server referenced by
ERROR_WINHTTP_UNABLE_TO_DOWNLOAD_SCRIPT     the PAC URL may not have been reachable, or the server returned a 404 NOT
                                            FOUND response.

ERROR_WINHTTP_UNRECOGNIZED_SCHEME           The URL of the PAC file specified a scheme other than "http:" or "https:".

ERROR_NOT_ENOUGH_MEMORY                     Not enough memory was available to complete the requested operation.
                                            (Windows error code)



Remarks

This function implements the Web Proxy Auto-Discovery (WPAD) protocol for automatically configuring the proxy settings
for an HTTP request. The WPAD protocol downloads a Proxy Auto-Configuration (PAC) file, which is a script that
identifies the proxy server to use for a given target URL. PAC files are typically deployed by the IT department within
a corporate network environment. The URL of the PAC file can either be specified explicitly or WinHttpGetProxyForUrlEx
can be instructed to automatically discover the location of the PAC file on the local network.

WinHttpGetProxyForUrlEx supports only ECMAScript-based PAC files.

WinHttpGetProxyForUrlEx must be called on a per-URL basis, because the PAC file can return a different proxy server for
different URLs. This is useful because the PAC file enables an IT department to implement proxy server load balancing
by mapping (hashing) the target URL (specified by the lpcwszUrl parameter) to a certain proxy in a proxy server array.

WinHttpGetProxyForUrlEx caches the autoproxy URL and the autoproxy script when auto-discovery is specified in the
dwFlags member of the pAutoProxyOptions structure. For more information, see Autoproxy Cache.

WinHttpGetProxyForUrlEx provides a fully Asynchronous and cancellable API that WinHttpGetProxyForUrl does not.
WinHttpGetProxyForUrlEx also provides the application with the full proxy list that was returned by the PAC script
allowing the application to better handle failover to "DIRECT" and to understand SOCKS if desired.

WinHttpGetProxyForUrlEx always executes asynchronously and returns immediately with ERROR_IO_PENDING on success. The
callback is set by calling WinHttpSetStatusCallback on the hSession provided by WinHttpOpen. Alternately call
WinHttpSetStatusCallback on the hResolver provided by WinHttpCreateProxyResolver to have a specific callback for each
call.

You must call WinHttpSetStatusCallback before WinHttpCreateProxyResolver. When calling WinHttpSetStatusCallback, use
WINHTTP_CALLBACK_FLAG_REQUEST_ERROR | WINHTTP_CALLBACK_FLAG_GETPROXYFORURL_COMPLETE. See WINHTTP_STATUS_CALLBACK for
information on the use of the callback.

This function always executes out-of-process.

Requirements

Minimum supported client Windows Developer Preview

Minimum supported server Windows Server Developer Preview

         Header          Winhttp.h
```
  * [WinHttpGetProxyForUrlEx](http://msdn.microsoft.com/en-us/library/windows/desktop/hh405356.aspx)

### Function: <a name="open"><em>open</em></a> <i>&key `:user-agent` `:proxy-name` `:proxy-bypass` (`:access-type` :default-proxy) `:async`</i>

```
WinHttpOpen function

The WinHttpOpen function initializes, for an application, the use of WinHTTP functions and returns a WinHTTP-session
handle.

Syntax

HINTERNET WINAPI WinHttpOpen(
  __in_opt  LPCWSTR pwszUserAgent,
  __in      DWORD dwAccessType,
  __in      LPCWSTR pwszProxyName,
  __in      LPCWSTR pwszProxyBypass,
  __in      DWORD dwFlags
);

Parameters

pwszUserAgent [in, optional]

    A pointer to a string variable that contains the name of the application or entity calling the WinHTTP functions.
    This name is used as the user agent in the HTTP protocol.

dwAccessType [in]

    Type of access required. This can be one of the following values.

                    Value                                                    Meaning
    WINHTTP_ACCESS_TYPE_NO_PROXY          Resolves all host names directly without a proxy.

                                          Retrieves the static proxy or direct configuration from the registry.
                                          WINHTTP_ACCESS_TYPE_DEFAULT_PROXY does not inherit browser proxy settings.
                                          WinHTTP does not share any proxy settings with Internet Explorer.

    WINHTTP_ACCESS_TYPE_DEFAULT_PROXY     The WinHTTP proxy configuration is set by one of these mechanisms.

                                           ｡ｦ The proxycfg.exe utility on Windows XP and Windows Server 2003 or
                                              earlier.
                                           ｡ｦ The netsh.exe utility on Windows Vista and Windows Server 2008 or later.
                                           ｡ｦ WinHttpSetDefaultProxyConfiguration on all platforms.

                                          Passes requests to the proxy unless a proxy bypass list is supplied and the
    WINHTTP_ACCESS_TYPE_NAMED_PROXY       name to be resolved bypasses the proxy. In this case, this function uses
                                          WINHTTP_ACCESS_TYPE_NAMED_PROXY.



pwszProxyName [in]

    A pointer to a string variable that contains the name of the proxy server to use when proxy access is specified by
    setting dwAccessType to WINHTTP_ACCESS_TYPE_NAMED_PROXY. The WinHTTP functions recognize only CERN type proxies for
    HTTP. If dwAccessType is not set to WINHTTP_ACCESS_TYPE_NAMED_PROXY, this parameter must be set to
    WINHTTP_NO_PROXY_NAME.

pwszProxyBypass [in]

    A pointer to a string variable that contains an optional semicolon delimited list of host names or IP addresses, or
    both, that should not be routed through the proxy when dwAccessType is set to WINHTTP_ACCESS_TYPE_NAMED_PROXY. The
    list can contain wildcard characters. Do not use an empty string, because the WinHttpOpen function uses it as the
    proxy bypass list. If this parameter specifies the "<local>" macro in the list as the only entry, this function
    bypasses any host name that does not contain a period. If dwAccessType is not set to
    WINHTTP_ACCESS_TYPE_NAMED_PROXY, this parameter must be set to WINHTTP_NO_PROXY_BYPASS.

dwFlags [in]

    Unsigned long integer value that contains the flags that indicate various options affecting the behavior of this
    function. This parameter can have the following value.

            Value                                                    Meaning
                           Use the WinHTTP functions asynchronously. By default, all WinHTTP functions that use the
    WINHTTP_FLAG_ASYNC     returned HINTERNET handle are performed synchronously. When this flag is set, the caller
                           needs to specify a callback function through WinHttpSetStatusCallback.



Return value

Returns a valid session handle if successful, or NULL otherwise. To retrieve extended error information, call
GetLastError. Among the error codes returned are the following.

           Error Code                                                 Description
ERROR_WINHTTP_INTERNAL_ERROR     An internal error has occurred.

ERROR_NOT_ENOUGH_MEMORY          Not enough memory was available to complete the requested operation. (Windows error
                                 code)



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To retrieve extended error information,
call GetLastError.

The WinHttpOpen function is the first of the WinHTTP functions called by an application. It initializes internal
WinHTTP data structures and prepares for future calls from the application. When the application finishes using the
WinHTTP functions, it must call WinHttpCloseHandle to free the session handle and any associated resources.

The application can make any number of calls to WinHttpOpen, though a single call is normally sufficient. Each call to
WinHttpOpen opens a new session context. Because user data is not shared between multiple session contexts, an
application that makes requests on behalf of multiple users should create a separate session for each user, so as not
to share user-specific cookies and authentication state. The application should define separate behaviors for each
WinHttpOpen instance, such as different proxy servers configured for each.

After the calling application has finished using the HINTERNET handle returned by WinHttpOpen, it must be closed using
the WinHttpCloseHandle function.

Note  For Windows XP and Windows 2000, see Run-Time Requirements.

Examples

The following example code shows how to retrieve the default connection time-out value.



    DWORD data;
    DWORD dwSize = sizeof(DWORD);

    // Use WinHttpOpen to obtain an HINTERNET handle.
    HINTERNET hSession = WinHttpOpen(L"A WinHTTP Example Program/1.0",
                                    WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                                    WINHTTP_NO_PROXY_NAME,
                                    WINHTTP_NO_PROXY_BYPASS, 0);
    if (hSession)
    {


        // Use WinHttpQueryOption to retrieve internet options.
        if (WinHttpQueryOption( hSession,
                                WINHTTP_OPTION_CONNECT_TIMEOUT,
                                &data, &dwSize))
        {
            printf("Connection timeout: %u ms\n\n",data);
        }
        else
        {
            printf( "Error %u in WinHttpQueryOption.\n",
                    GetLastError());
        }

        // When finished, release the HINTERNET handle.
        WinHttpCloseHandle(hSession);
    }
    else
    {
        printf("Error %u in WinHttpOpen.\n", GetLastError());
    }



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [close-handle](#close-handle)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpOpen](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384098.aspx)

### Function: <a name="open-request"><em>open-request</em></a> <i>`CONNECTION` `VERB` `OBJECT-NAME` &key `:version` `:referrer` `:accept` `:bypass-proxy-cache` `:escape-disable` `:escape-disable-query` `:escape-percent` `:null-codepage` `:refresh` `:secure`</i>

```
WinHttpOpenRequest function

The WinHttpOpenRequest function creates an HTTP request handle.

Syntax

HINTERNET WINAPI WinHttpOpenRequest(
  __in  HINTERNET hConnect,
  __in  LPCWSTR pwszVerb,
  __in  LPCWSTR pwszObjectName,
  __in  LPCWSTR pwszVersion,
  __in  LPCWSTR pwszReferrer,
  __in  LPCWSTR *ppwszAcceptTypes,
  __in  DWORD dwFlags
);

Parameters

hConnect [in]

    HINTERNET connection handle to an HTTP session returned by WinHttpConnect.

pwszVerb [in]

    Pointer to a string that contains the HTTP verb to use in the request. If this parameter is NULL, the function uses
    GET as the HTTP verb.

        Note  This string should be all uppercase. Many servers treat HTTP verbs as case-sensitive, and the Internet
        Engineering Task Force (IETF) Requests for Comments (RFCs) spell these verbs using uppercase characters only.

pwszObjectName [in]

    Pointer to a string that contains the name of the target resource of the specified HTTP verb. This is generally a
    file name, an executable module, or a search specifier.

pwszVersion [in]

    Pointer to a string that contains the HTTP version. If this parameter is NULL, the function uses HTTP/1.1.

pwszReferrer [in]

    Pointer to a string that specifies the URL of the document from which the URL in the request pwszObjectName was
    obtained. If this parameter is set to WINHTTP_NO_REFERER, no referring document is specified.

ppwszAcceptTypes [in]

    Pointer to a null-terminated array of string pointers that specifies media types accepted by the client. If this
    parameter is set to WINHTTP_DEFAULT_ACCEPT_TYPES, no types are accepted by the client. Typically, servers handle a
    lack of accepted types as indication that the client accepts only documents of type "text/*"; that is, only text
    documents?no pictures or other binary files. For a list of valid media types, see Media Types defined by IANA at
    http://www.iana.org/assignments/media-types/.

dwFlags [in]

    Unsigned long integer value that contains the Internet flag values. This can be one or more of the following
    values:

                    Value                                                    Meaning
    WINHTTP_FLAG_BYPASS_PROXY_CACHE       This flag provides the same behavior as WINHTTP_FLAG_REFRESH.

    WINHTTP_FLAG_ESCAPE_DISABLE           Unsafe characters in the URL passed in for pwszObjectName are not converted
                                          to escape sequences.

    WINHTTP_FLAG_ESCAPE_DISABLE_QUERY     Unsafe characters in the query component of the URL passed in for
                                          pwszObjectName are not converted to escape sequences.

                                          The string passed in for pwszObjectName is converted from an LPCWSTR to an
    WINHTTP_FLAG_ESCAPE_PERCENT           LPSTR. All unsafe characters are converted to an escape sequence including
                                          the percent symbol. By default, all unsafe characters except the percent
                                          symbol are converted to an escape sequence.

                                          The string passed in for pwszObjectName is assumed to consist of valid ANSI
    WINHTTP_FLAG_NULL_CODEPAGE            characters represented by WCHAR. No check are done for unsafe characters.

                                              Windows 7:  This option is obsolete.

                                          Indicates that the request should be forwarded to the originating server
                                          rather than sending a cached version of a resource from a proxy server. When
    WINHTTP_FLAG_REFRESH                  this flag is used, a "Pragma: no-cache" header is added to the request
                                          handle. When creating an HTTP/1.1 request header, a "Cache-Control: no-cache"
                                          is also added.

    WINHTTP_FLAG_SECURE                   Uses secure transaction semantics. This translates to using Secure Sockets
                                          Layer (SSL)/Transport Layer Security (TLS).



Return value

Returns a valid HTTP request handle if successful, or NULL if not. For extended error information, call GetLastError.
Among the error codes returned are the following.

              Error Code                                                  Description
ERROR_WINHTTP_INCORRECT_HANDLE_TYPE     The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR            An internal error has occurred.

ERROR_WINHTTP_INVALID_URL               The URL is invalid.

ERROR_WINHTTP_OPERATION_CANCELLED       The operation was canceled, usually because the handle on which the request was
                                        operating was closed before the operation completed.

ERROR_WINHTTP_UNRECOGNIZED_SCHEME       The URL specified a scheme other than "http:" or "https:".

ERROR_NOT_ENOUGH_MEMORY                 Not enough memory was available to complete the requested operation. (Windows
                                        error code)



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

The WinHttpOpenRequest function creates a new HTTP request handle and stores the specified parameters in that handle.
An HTTP request handle holds a request to send to an HTTP server and contains all RFC822/MIME/HTTP headers to be sent
as part of the request.

If pwszVerb is set to "HEAD", the Content-Length header is ignored.

If a status callback function has been installed with WinHttpSetStatusCallback, then a
WINHTTP_CALLBACK_STATUS_HANDLE_CREATED notification indicates that WinHttpOpenRequest has created a request handle.

After the calling application finishes using the HINTERNET handle returned by WinHttpOpenRequest, it must be closed
using the WinHttpCloseHandle function.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHttp start page.

Examples

This example shows how to obtain an HINTERNET handle, open an HTTP session, create a request header, and send that
header to the server.



    BOOL  bResults = FALSE;
    HINTERNET hSession = NULL,
              hConnect = NULL,
              hRequest = NULL;

    // Use WinHttpOpen to obtain a session handle.
    hSession = WinHttpOpen(  L"A WinHTTP Example Program/1.0",
                             WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                             WINHTTP_NO_PROXY_NAME,
                             WINHTTP_NO_PROXY_BYPASS, 0);

    // Specify an HTTP server.
    if (hSession)
        hConnect = WinHttpConnect( hSession, L"www.wingtiptoys.com",
                                   INTERNET_DEFAULT_HTTP_PORT, 0);

    // Create an HTTP Request handle.
    if (hConnect)
        hRequest = WinHttpOpenRequest( hConnect, L"PUT",
                                       L"/writetst.txt",
                                       NULL, WINHTTP_NO_REFERER,
                                       WINHTTP_DEFAULT_ACCEPT_TYPES,
                                       0);

    // Send a Request.
    if (hRequest)
        bResults = WinHttpSendRequest( hRequest,
                                       WINHTTP_NO_ADDITIONAL_HEADERS,
                                       0, WINHTTP_NO_REQUEST_DATA, 0,
                                       0, 0);

    // PLACE ADDITIONAL CODE HERE.

    // Report any errors.
    if (!bResults)
        printf( "Error %d has occurred.\n", GetLastError());

    // Close any open handles.
    if (hRequest) WinHttpCloseHandle(hRequest);
    if (hConnect) WinHttpCloseHandle(hConnect);
    if (hSession) WinHttpCloseHandle(hSession);



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [open](#open)
  * [connect](#connect)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpOpenRequest](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384099.aspx)

### Function: <a name="query-auth-schemes"><em>query-auth-schemes</em></a> <i>`REQUEST`</i>

```
WinHttpQueryAuthSchemes function

The WinHttpQueryAuthSchemes function returns the authorization schemes that are supported by the server.

Syntax

BOOL WINAPI WinHttpQueryAuthSchemes(
  __in   HINTERNET hRequest,
  __out  LPDWORD lpdwSupportedSchemes,
  __out  LPDWORD lpdwFirstScheme,
  __out  LPDWORD pdwAuthTarget
);

Parameters

hRequest [in]

    Valid HINTERNET handle returned by WinHttpOpenRequest

lpdwSupportedSchemes [out]

    An unsigned integer that specifies a flag that contains the supported authentication schemes. This parameter can
    return one or more flags that are identified in the following table.

                  Value                                  Meaning
    WINHTTP_AUTH_SCHEME_BASIC         Indicates basic authentication is available.

    WINHTTP_AUTH_SCHEME_NTLM          Indicates NTLM authentication is available.

    WINHTTP_AUTH_SCHEME_PASSPORT      Indicates passport authentication is
                                      available.

    WINHTTP_AUTH_SCHEME_DIGEST        Indicates digest authentication is available.

    WINHTTP_AUTH_SCHEME_NEGOTIATE     Selects between NTLM and Kerberos
                                      authentication.



lpdwFirstScheme [out]

    An unsigned integer that specifies a flag that contains the first authentication scheme listed by the server. This
    parameter can return one or more flags that are identified in the following table.

                  Value                                  Meaning
    WINHTTP_AUTH_SCHEME_BASIC         Indicates basic authentication is first.

    WINHTTP_AUTH_SCHEME_NTLM          Indicates NTLM authentication is first.

    WINHTTP_AUTH_SCHEME_PASSPORT      Indicates passport authentication is first.

    WINHTTP_AUTH_SCHEME_DIGEST        Indicates digest authentication is first.

    WINHTTP_AUTH_SCHEME_NEGOTIATE     Selects between NTLM and Kerberos
                                      authentication.



pdwAuthTarget [out]

    An unsigned integer that specifies a flag that contains the authentication target. This parameter can return one or
    more flags that are identified in the following table.

                Value                                                   Meaning
    WINHTTP_AUTH_TARGET_SERVER     Authentication target is a server. Indicates that a 401 status code has been
                                   received.

    WINHTTP_AUTH_TARGET_PROXY      Authentication target is a proxy. Indicates that a 407 status code has been
                                   received.



Return value

Returns TRUE if successful, or FALSE if unsuccessful. To get extended error information, call GetLastError. The
following table identifies the error codes that are returned.

              Error Code                                                  Description
ERROR_WINHTTP_INCORRECT_HANDLE_TYPE     The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR            An internal error has occurred.

ERROR_NOT_ENOUGH_MEMORY                 Not enough memory was available to complete the requested operation. (Windows
                                        error code)



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC is set in WinHttpOpen), this function
operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

WinHttpQueryAuthSchemes cannot be used before calling WinHttpQueryHeaders.

Note  For Windows XP and Windows 2000 see the Run-Time Requirements section of the WinHttp start page.

Examples

The following example shows how to retrieve a specified document from an HTTP server when authentication is required.
The status code is retrieved from the response to determine if the server or proxy is requesting authentication. If a
200 status code is found, the document is available. If a status code of 401 or 407 is found, authentication is
required before the document can be retrieved. For any other status code an error message is displayed.


#include <windows.h>
#include <winhttp.h>
#include <stdio.h>

#pragma comment(lib, "winhttp.lib")

DWORD ChooseAuthScheme( DWORD dwSupportedSchemes )
{
  //  It is the server's responsibility only to accept
  //  authentication schemes that provide a sufficient level
  //  of security to protect the server's resources.
  //
  //  The client is also obligated only to use an authentication
  //  scheme that adequately protects its username and password.
  //
  //  Thus, this sample code does not use Basic authentication
  //  because Basic authentication exposes the client's username
  //  and password to anyone monitoring the connection.

  if( dwSupportedSchemes & WINHTTP_AUTH_SCHEME_NEGOTIATE )
    return WINHTTP_AUTH_SCHEME_NEGOTIATE;
  else if( dwSupportedSchemes & WINHTTP_AUTH_SCHEME_NTLM )
    return WINHTTP_AUTH_SCHEME_NTLM;
  else if( dwSupportedSchemes & WINHTTP_AUTH_SCHEME_PASSPORT )
    return WINHTTP_AUTH_SCHEME_PASSPORT;
  else if( dwSupportedSchemes & WINHTTP_AUTH_SCHEME_DIGEST )
    return WINHTTP_AUTH_SCHEME_DIGEST;
  else
    return 0;
}

struct SWinHttpSampleGet
{
  LPCWSTR szServer;
  LPCWSTR szPath;
  BOOL fUseSSL;
  LPCWSTR szServerUsername;
  LPCWSTR szServerPassword;
  LPCWSTR szProxyUsername;
  LPCWSTR szProxyPassword;
};

void WinHttpAuthSample( IN SWinHttpSampleGet *pGetRequest )
{
  DWORD dwStatusCode = 0;
  DWORD dwSupportedSchemes;
  DWORD dwFirstScheme;
  DWORD dwSelectedScheme;
  DWORD dwTarget;
  DWORD dwLastStatus = 0;
  DWORD dwSize = sizeof(DWORD);
  BOOL  bResults = FALSE;
  BOOL  bDone = FALSE;

  DWORD dwProxyAuthScheme = 0;
  HINTERNET  hSession = NULL,
             hConnect = NULL,
             hRequest = NULL;

  // Use WinHttpOpen to obtain a session handle.
  hSession = WinHttpOpen( L"WinHTTP Example/1.0",
                          WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                          WINHTTP_NO_PROXY_NAME,
                          WINHTTP_NO_PROXY_BYPASS, 0 );

  INTERNET_PORT nPort = ( pGetRequest->fUseSSL ) ?
                        INTERNET_DEFAULT_HTTPS_PORT  :
                        INTERNET_DEFAULT_HTTP_PORT;

  // Specify an HTTP server.
  if( hSession )
    hConnect = WinHttpConnect( hSession,
                               pGetRequest->szServer,
                               nPort, 0 );

  // Create an HTTP request handle.
  if( hConnect )
    hRequest = WinHttpOpenRequest( hConnect,
                                   L"GET",
                                   pGetRequest->szPath,
                                   NULL,
                                   WINHTTP_NO_REFERER,
                                   WINHTTP_DEFAULT_ACCEPT_TYPES,
                                   ( pGetRequest->fUseSSL ) ?
                                       WINHTTP_FLAG_SECURE : 0 );

  // Continue to send a request until status code is not 401 or 407.
  if( hRequest == NULL )
    bDone = TRUE;

  while( !bDone )
  {
    //  If a proxy authentication challenge was responded to, reset
    //  those credentials before each SendRequest, because the proxy
    //  may require re-authentication after responding to a 401 or to
    //  a redirect. If you don't, you can get into a 407-401-407-401
    //  loop.
    if( dwProxyAuthScheme != 0 )
      bResults = WinHttpSetCredentials( hRequest,
                                        WINHTTP_AUTH_TARGET_PROXY,
                                        dwProxyAuthScheme,
                                        pGetRequest->szProxyUsername,
                                        pGetRequest->szProxyPassword,
                                        NULL );
    // Send a request.
    bResults = WinHttpSendRequest( hRequest,
                                   WINHTTP_NO_ADDITIONAL_HEADERS,
                                   0,
                                   WINHTTP_NO_REQUEST_DATA,
                                   0,
                                   0,
                                   0 );

    // End the request.
    if( bResults )
      bResults = WinHttpReceiveResponse( hRequest, NULL );

    // Resend the request in case of
    // ERROR_WINHTTP_RESEND_REQUEST error.
    if( !bResults && GetLastError( ) == ERROR_WINHTTP_RESEND_REQUEST)
        continue;

    // Check the status code.
    if( bResults )
      bResults = WinHttpQueryHeaders( hRequest,
                                      WINHTTP_QUERY_STATUS_CODE |
                                          WINHTTP_QUERY_FLAG_NUMBER,
                                      NULL,
                                      &dwStatusCode,
                                      &dwSize,
                                      NULL );

    if( bResults )
    {
      switch( dwStatusCode )
      {
        case 200:
          // The resource was successfully retrieved.
          // You can use WinHttpReadData to read the contents
          // of the server's response.
          printf( "The resource was successfully retrieved.\n" );
          bDone = TRUE;
          break;

        case 401:
          // The server requires authentication.
          printf(
           "The server requires authentication. Sending credentials\n");

          // Obtain the supported and preferred schemes.
          bResults = WinHttpQueryAuthSchemes( hRequest,
                                              &dwSupportedSchemes,
                                              &dwFirstScheme,
                                              &dwTarget );

          // Set the credentials before re-sending the request.
          if( bResults )
          {
            dwSelectedScheme = ChooseAuthScheme( dwSupportedSchemes );

            if( dwSelectedScheme == 0 )
              bDone = TRUE;
            else
              bResults = WinHttpSetCredentials(
                                        hRequest, dwTarget,
                                        dwSelectedScheme,
                                        pGetRequest->szServerUsername,
                                        pGetRequest->szServerPassword,
                                        NULL );
          }

          // If the same credentials are requested twice, abort the
          // request.  For simplicity, this sample does not check for
          // a repeated sequence of status codes.
          if( dwLastStatus == 401 )
            bDone = TRUE;

          break;

        case 407:
          // The proxy requires authentication.
          printf(
           "The proxy requires authentication. Sending credentials\n");

          // Obtain the supported and preferred schemes.
          bResults = WinHttpQueryAuthSchemes( hRequest,
                                              &dwSupportedSchemes,
                                              &dwFirstScheme,
                                              &dwTarget );

          // Set the credentials before re-sending the request.
          if( bResults )
            dwProxyAuthScheme = ChooseAuthScheme(dwSupportedSchemes);

          // If the same credentials are requested twice, abort the
          // request.  For simplicity, this sample does not check for
          // a repeated sequence of status codes.
          if( dwLastStatus == 407 )
            bDone = TRUE;
          break;

        default:
          // The status code does not indicate success.
          printf( "Error. Status code %d returned.\n", dwStatusCode );
          bDone = TRUE;
      }
    }

    // Keep track of the last status code.
    dwLastStatus = dwStatusCode;

    // If there are any errors, break out of the loop.
    if( !bResults )
        bDone = TRUE;
  }

  // Report any errors.
  if( !bResults )
  {
    DWORD dwLastError = GetLastError( );
    printf( "Error %d has occurred.\n", dwLastError );
  }

  // Close any open handles.
  if( hRequest ) WinHttpCloseHandle( hRequest );
  if( hConnect ) WinHttpCloseHandle( hConnect );
  if( hSession ) WinHttpCloseHandle( hSession );
}




Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [set-credentials](#set-credentials)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpQueryAuthSchemes](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384100.aspx)

### Function: <a name="query-data-available"><em>query-data-available</em></a> <i>`REQUEST`</i>

```
WinHttpQueryDataAvailable function

The WinHttpQueryDataAvailable function returns the amount of data, in bytes, available to be read with WinHttpReadData.

Syntax

BOOL WINAPI WinHttpQueryDataAvailable(
  __in   HINTERNET hRequest,
  __out  LPDWORD lpdwNumberOfBytesAvailable
);

Parameters

hRequest [in]

    A valid HINTERNET handle returned by WinHttpOpenRequest. WinHttpReceiveResponse must have been called for this
    handle and have completed before WinHttpQueryDataAvailable is called.

lpdwNumberOfBytesAvailable [out]

    A pointer to an unsigned long integer variable that receives the number of available bytes. When WinHTTP is used in
    asynchronous mode, always set this parameter to NULL and retrieve data in the callback function; not doing so can
    cause a memory fault.

Return value

Returns TRUE if the function succeeds, or FALSE otherwise. To get extended error data, call GetLastError. Among the
error codes returned are the following.

               Error Code                                                 Description
                                         The connection with the server has been reset or terminated, or an
ERROR_WINHTTP_CONNECTION_ERROR           incompatible SSL protocol was encountered. For example, WinHTTP version 5.1
                                         does not support SSL2 unless the client specifically enables it.

ERROR_WINHTTP_INCORRECT_HANDLE_STATE     The requested operation cannot complete because the handle supplied is not in
                                         the correct state.

ERROR_WINHTTP_INCORRECT_HANDLE_TYPE      The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR             An internal error has occurred.

ERROR_WINHTTP_OPERATION_CANCELLED        The operation was canceled, usually because the handle on which the request
                                         was operating was closed before the operation completed.

ERROR_WINHTTP_TIMEOUT                    The request has timed out.

ERROR_NOT_ENOUGH_MEMORY                  Not enough memory was available to complete the requested operation. (Windows
                                         error code)



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function can operate either synchronously or asynchronously. If it returns FALSE, it failed and you can call
GetLastError to get extended error information. If it returns TRUE, use the WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE
completion to determine whether this function was successful and the value of the parameters. The
WINHTTP_CALLBACK_STATUS_REQUEST_ERROR completion indicates that the operation completed asynchronously, but failed.

Warning  When WinHTTP is used in asynchronous mode, always set the lpdwNumberOfBytesAvailable parameter to NULL and
retrieve the bytes available in the callback function; otherwise, a memory fault can occur.

This function returns the number of bytes of data that are available to read immediately by a subsequent call to
WinHttpReadData. If no data is available and the end of the file has not been reached, one of two things happens. If
the session is synchronous, the request waits until data becomes available. If the session is asynchronous, the
function returns TRUE, and when data becomes available, calls the callback function with
WINHTTP_STATUS_CALLBACK_DATA_AVAILABLE and indicates the number of bytes immediately available to read by calling
WinHttpReadData.

The amount of data that remains is not recalculated until all available data indicated by the call to
WinHttpQueryDataAvailable is read.

Use the return value of WinHttpReadData to determine when a response has been completely read.

Important  Do not use the return value of WinHttpQueryDataAvailable to determine whether the end of a response has been
reached, because not all servers terminate responses properly, and an improperly terminated response causes
WinHttpQueryDataAvailable to anticipate more data.

For HINTERNET handles created by the WinHttpOpenRequest function and sent by WinHttpSendRequest, a call to
WinHttpReceiveResponse must be made on the handle before WinHttpQueryDataAvailable can be used.

If a status callback function has been installed with WinHttpSetStatusCallback, then those of the following
notifications that have been set in the dwNotificationFlags parameter of WinHttpSetStatusCallback indicate progress in
checking for available data:

 ｡ｦ WINHTTP_CALLBACK_STATUS_RECEIVING_RESPONSE
 ｡ｦ WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED
 ｡ｦ WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE

Note  For more information about Windows XP and Windows 2000, see Run-Time Requirements.

Examples

The following example shows how to use secure transaction semantics to download a resource from an HTTPS server. The
sample code initializes the WinHTTP API, selects a target HTTPS server, and then opens and sends a request for this
secure resource. WinHttpQueryDataAvailable is used with the request handle to determine how much data is available for
download, then WinHttpReadData is used to read that data. This process repeats until the entire document has been
retrieved and displayed.



    DWORD dwSize = 0;
    DWORD dwDownloaded = 0;
    LPSTR pszOutBuffer;
    BOOL  bResults = FALSE;
    HINTERNET  hSession = NULL,
               hConnect = NULL,
               hRequest = NULL;

    // Use WinHttpOpen to obtain a session handle.
    hSession = WinHttpOpen( L"WinHTTP Example/1.0",
                            WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                            WINHTTP_NO_PROXY_NAME,
                            WINHTTP_NO_PROXY_BYPASS, 0);

    // Specify an HTTP server.
    if (hSession)
        hConnect = WinHttpConnect( hSession, L"www.microsoft.com",
                                   INTERNET_DEFAULT_HTTPS_PORT, 0);

    // Create an HTTP request handle.
    if (hConnect)
        hRequest = WinHttpOpenRequest( hConnect, L"GET", NULL,
                                       NULL, WINHTTP_NO_REFERER,
                                       WINHTTP_DEFAULT_ACCEPT_TYPES,
                                       WINHTTP_FLAG_SECURE);

    // Send a request.
    if (hRequest)
        bResults = WinHttpSendRequest( hRequest,
                                       WINHTTP_NO_ADDITIONAL_HEADERS,
                                       0, WINHTTP_NO_REQUEST_DATA, 0,
                                       0, 0);


    // End the request.
    if (bResults)
        bResults = WinHttpReceiveResponse( hRequest, NULL);

    // Continue to verify data until there is nothing left.
    if (bResults)
        do
        {

            // Verify available data.
            dwSize = 0;
            if (!WinHttpQueryDataAvailable( hRequest, &dwSize))
                printf( "Error %u in WinHttpQueryDataAvailable.\n",
                        GetLastError());

            // Allocate space for the buffer.
            pszOutBuffer = new char[dwSize+1];
            if (!pszOutBuffer)
            {
                printf("Out of memory\n");
                dwSize=0;
            }
            else
            {
                // Read the Data.
                ZeroMemory(pszOutBuffer, dwSize+1);

                if (!WinHttpReadData( hRequest, (LPVOID)pszOutBuffer,
                                      dwSize, &dwDownloaded))
                    printf( "Error %u in WinHttpReadData.\n", GetLastError());
                else
                    printf( "%s\n", pszOutBuffer);

                // Free the memory allocated to the buffer.
                delete [] pszOutBuffer;
            }

        } while (dwSize > 0);


    // Report any errors.
    if (!bResults)
        printf( "Error %d has occurred.\n", GetLastError());

    // Close open handles.
    if (hRequest) WinHttpCloseHandle(hRequest);
    if (hConnect) WinHttpCloseHandle(hConnect);
    if (hSession) WinHttpCloseHandle(hSession);



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [open](#open)
  * [open-request](#open-request)
  * [send-request](#send-request)
  * [connect](#connect)
  * [read-data](#read-data)
  * [close-handle](#close-handle)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpQueryDataAvailable](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384101.aspx)

### Function: <a name="query-option"><em>query-option</em></a> <i>`HINTERNET` `OPTION`</i>

```
WinHttpQueryOption function

The WinHttpQueryOption function queries an Internet option on the specified handle.

Syntax

BOOL WINAPI WinHttpQueryOption(
  __in     HINTERNET hInternet,
  __in     DWORD dwOption,
  __out    LPVOID lpBuffer,
  __inout  LPDWORD lpdwBufferLength
);

Parameters

hInternet [in]

    HINTERNET handle on which to query information. Note that this can be either a Session handle or a Request handle,
    depending on what option is being queried; see the Option Flags topic to determine which handle is appropriate to
    use in querying a particular option.

dwOption [in]

    Unsigned long integer value that contains the Internet option to query. This can be one of the Option Flags values.

lpBuffer [out]

    Pointer to a buffer that receives the option setting. Strings returned by the WinHttpQueryOption function are
    globally allocated, so the calling application must globally free the string when it finishes using it. Setting
    this parameter to NULL causes this function to return FALSE. Calling GetLastError then returns
    ERROR_INSUFFICIENT_BUFFER and lpdwBufferLength contains the number of bytes required to hold the requested
    information.

lpdwBufferLength [in, out]

    Pointer to an unsigned long integer variable that contains the length of lpBuffer, in bytes. When the function
    returns, the variable receives the length of the data placed into lpBuffer. If GetLastError returns
    ERROR_INSUFFICIENT_BUFFER, this parameter receives the number of bytes required to hold the requested information.

Return value

Returns TRUE if successful, or FALSE otherwise. To get a specific error message, call GetLastError. Among the error
codes returned are the following.

               Error Code                                                 Description
ERROR_WINHTTP_INCORRECT_HANDLE_STATE     The requested operation cannot be carried out because the handle supplied is
                                         not in the correct state.

ERROR_WINHTTP_INCORRECT_HANDLE_TYPE      The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR             An internal error has occurred.

ERROR_WINHTTP_INVALID_OPTION             An invalid option value was specified.

ERROR_NOT_ENOUGH_MEMORY                  Not enough memory was available to complete the requested operation. (Windows
                                         error code)



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

GetLastError returns the ERROR_INVALID_PARAMETER if an option flag that is invalid for the specified handle type is
passed to the dwOption parameter.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHttp start page.

Examples

This example demonstrates retrieving the connection time-out value:


    DWORD data;
    DWORD dwSize = sizeof(DWORD);

    // Use WinHttpOpen to obtain an HINTERNET handle.
    HINTERNET hSession = WinHttpOpen(L"A WinHTTP Example Program/1.0",
                                    WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                                    WINHTTP_NO_PROXY_NAME,
                                    WINHTTP_NO_PROXY_BYPASS, 0);
    if (hSession)
    {


        // Use WinHttpQueryOption to retrieve internet options.
        if (WinHttpQueryOption( hSession,
                                WINHTTP_OPTION_CONNECT_TIMEOUT,
                                &data, &dwSize))
        {
            printf("Connection timeout: %u ms\n\n",data);
        }
        else
        {
            printf( "Error %u in WinHttpQueryOption.\n", GetLastError());
        }

        // When finished, release the HINTERNET handle.
        WinHttpCloseHandle(hSession);
    }
    else
    {
        printf("Error %u in WinHttpOpen.\n", GetLastError());
    }



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
Retrieving Internet Options With WinHTTP
  * [open](#open)
  * [open-request](#open-request)
  * [connect](#connect)
  * [close-handle](#close-handle)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpQueryOption](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384103.aspx)

### Function: <a name="query-request-header"><em>query-request-header</em></a> <i>`REQUEST` `HEADER` &key (`:type` :string) (`:index` 0)</i>

TODO

__See Also:__

  * TODO

### Function: <a name="query-request-headers"><em>query-request-headers</em></a> <i>`REQUEST` `HEADER` &key (`:type` :string)</i>

TODO

__See Also:__

  * TODO

### Function: <a name="query-response-header"><em>query-response-header</em></a> <i>`REQUEST` `HEADER` &key (`:type` :string) (`:index` 0)</i>

TODO

__See Also:__

  * TODO

### Function: <a name="query-response-headers"><em>query-response-headers</em></a> <i>`REQUEST` `HEADER` &key (`:type` :string)</i>

TODO

__See Also:__

  * TODO

### Function: <a name="read-data"><em>read-data</em></a> <i>`REQUEST` `NUM-OF-BYTES-TO-READ`</i>

```
WinHttpReadData function

The WinHttpReadData function reads data from a handle opened by the WinHttpOpenRequest function.

Syntax

BOOL WINAPI WinHttpReadData(
  __in   HINTERNET hRequest,
  __out  LPVOID lpBuffer,
  __in   DWORD dwNumberOfBytesToRead,
  __out  LPDWORD lpdwNumberOfBytesRead
);

Parameters

hRequest [in]

    Valid HINTERNET handle returned from a previous call to WinHttpOpenRequest. WinHttpReceiveResponse or
    WinHttpQueryDataAvailable must have been called for this handle and must have completed before WinHttpReadData is
    called. Although calling WinHttpReadData immediately after completion of WinHttpReceiveResponse avoids the expense
    of a buffer copy, doing so requires that the application use a fixed-length buffer for reading.

lpBuffer [out]

    Pointer to a buffer that receives the data read. Make sure that this buffer remains valid until WinHttpReadData has
    completed.

dwNumberOfBytesToRead [in]

    Unsigned long integer value that contains the number of bytes to read.

lpdwNumberOfBytesRead [out]

    Pointer to an unsigned long integer variable that receives the number of bytes read. WinHttpReadData sets this
    value to zero before doing any work or error checking. When using WinHTTP asynchronously, always set this parameter
    to NULL and retrieve the information in the callback function; not doing so can cause a memory fault.

Return value

Returns TRUE if successful, or FALSE otherwise. For extended error information, call GetLastError. The following table
identifies the error codes that are returned.

               Error Code                                                  Description
                                          The connection with the server has been reset or terminated, or an
ERROR_WINHTTP_CONNECTION_ERROR            incompatible SSL protocol was encountered. For example, WinHTTP 5.1 does not
                                          support SSL2 unless the client specifically enables it.

ERROR_WINHTTP_INCORRECT_HANDLE_STATE      The requested operation cannot be carried out because the handle supplied is
                                          not in the correct state.

ERROR_WINHTTP_INCORRECT_HANDLE_TYPE       The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR              An internal error has occurred.

ERROR_WINHTTP_OPERATION_CANCELLED         The operation was canceled, usually because the handle on which the request
                                          was operating was closed before the operation completed.

ERROR_WINHTTP_RESPONSE_DRAIN_OVERFLOW     Returned when an incoming response exceeds an internal WinHTTP size limit.

ERROR_WINHTTP_TIMEOUT                     The request has timed out.

ERROR_NOT_ENOUGH_MEMORY                   Not enough memory was available to complete the requested operation. (Windows
                                          error code)



Remarks

Starting in Windows Vista and Windows Server 2008, WinHttp enables applications to perform chunked transfer encoding on
data sent to the server. When the Transfer-Encoding header is present on the WinHttp response, WinHttpReadData strips
the chunking information before giving the data to the application.

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function can operate either synchronously or asynchronously. If this function returns FALSE, this function failed and
you can call GetLastError to get extended error information. If this function returns TRUE, use the
WINHTTP_CALLBACK_STATUS_READ_COMPLETE completion to determine whether this function was successful and the value of the
parameters. The WINHTTP_CALLBACK_STATUS_REQUEST_ERROR completion indicates that the operation completed asynchronously,
but failed.

Warning  When WinHTTP is used in asynchronous mode, always set the lpdwNumberOfBytesRead parameter to NULL and retrieve
the bytes read in the callback function; otherwise, a memory fault can occur.

When the read buffer is very small, WinHttpReadData might complete synchronously. If the
WINHTTP_CALLBACK_STATUS_READ_COMPLETE completion triggers another call to WinHttpReadData, the situation can result in
a stack overflow. In general, it is best to use a read buffer that is comparable in size, or larger than the internal
read buffer used by WinHTTP, which is 8 KB.

If you are using WinHttpReadData synchronously, and the return value is TRUE and the number of bytes read is zero, the
transfer has been completed and there are no more bytes to read on the handle. This is analogous to reaching
end-of-file in a local file. If you are using the function asynchronously, the WINHTTP_CALLBACK_STATUS_READ_COMPLETE
callback is called with the dwStatusInformationLength parameter set to zero when the end of a response is found.

WinHttpReadData tries to fill the buffer pointed to by lpBuffer until there is no more data available from the
response. If sufficient data has not arrived from the server, the buffer is not filled.

For HINTERNET handles created by the WinHttpOpenRequest function and sent by WinHttpSendRequest, a call to
WinHttpReceiveResponse must be made on the handle before WinHttpReadData can be used.

Single byte characters retrieved with WinHttpReadData are not converted to multi-byte characters.

When the read buffer is very small, WinHttpReadData may complete synchronously, and if the
WINHTTP_CALLBACK_STATUS_READ_COMPLETE completion then triggers another call to WinHttpReadData, a stack overflow can
result. It is best to use a read buffer that is 8 Kilobytes or larger in size.

If sufficient data has not arrived from the server, WinHttpReadData does not entirely fill the buffer pointed to by
lpBuffer. The buffer must be large enough at least to hold the HTTP headers on the first read, and when reading HTML
encoded directory entries, it must be large enough to hold at least one complete entry.

If a status callback function has been installed by using WinHttpSetStatusCallback, then those of the following
notifications that have been set in the dwNotificationFlags parameter of WinHttpSetStatusCallback indicate progress in
checking for available data:

 ｡ｦ WINHTTP_CALLBACK_STATUS_RECEIVING_RESPONSE
 ｡ｦ WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED
 ｡ｦ WINHTTP_CALLBACK_STATUS_CONNECTION_CLOSED
 ｡ｦ WINHTTP_CALLBACK_STATUS_READ_COMPLETE

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHttp start page.

Examples

The following example shows how to use secure transaction semantics to download a resource from an Secure Hypertext
Transfer Protocol (HTTPS) server. The sample code initializes the WinHTTP application programming interface (API),
selects a target HTTPS server, then opens and sends a request for this secure resource. WinHttpQueryDataAvailable is
used with the request handle to determine how much data is available for download, then WinHttpReadData is used to read
that data. This process repeats until the entire document has been retrieved and displayed.


    DWORD dwSize = 0;
    DWORD dwDownloaded = 0;
    LPSTR pszOutBuffer;
    BOOL  bResults = FALSE;
    HINTERNET  hSession = NULL,
               hConnect = NULL,
               hRequest = NULL;

    // Use WinHttpOpen to obtain a session handle.
    hSession = WinHttpOpen( L"WinHTTP Example/1.0",
                            WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                            WINHTTP_NO_PROXY_NAME,
                            WINHTTP_NO_PROXY_BYPASS, 0);

    // Specify an HTTP server.
    if (hSession)
        hConnect = WinHttpConnect( hSession, L"www.microsoft.com",
                                   INTERNET_DEFAULT_HTTPS_PORT, 0);

    // Create an HTTP request handle.
    if (hConnect)
        hRequest = WinHttpOpenRequest( hConnect, L"GET", NULL,
                                       NULL, WINHTTP_NO_REFERER,
                                       WINHTTP_DEFAULT_ACCEPT_TYPES,
                                       WINHTTP_FLAG_SECURE);

    // Send a request.
    if (hRequest)
        bResults = WinHttpSendRequest( hRequest,
                                       WINHTTP_NO_ADDITIONAL_HEADERS,
                                       0, WINHTTP_NO_REQUEST_DATA, 0,
                                       0, 0);


    // End the request.
    if (bResults)
        bResults = WinHttpReceiveResponse( hRequest, NULL);

    // Keep checking for data until there is nothing left.
    if (bResults)
    {
        do
        {
            // Check for available data.
            dwSize = 0;
            if (!WinHttpQueryDataAvailable( hRequest, &dwSize))
            {
                printf( "Error %u in WinHttpQueryDataAvailable.\n",
                        GetLastError());
                break;
            }

            // No more available data.
            if (!dwSize)
                break;

            // Allocate space for the buffer.
            pszOutBuffer = new char[dwSize+1];
            if (!pszOutBuffer)
            {
                printf("Out of memory\n");
                break;
            }

            // Read the Data.
            ZeroMemory(pszOutBuffer, dwSize+1);

            if (!WinHttpReadData( hRequest, (LPVOID)pszOutBuffer,
                                  dwSize, &dwDownloaded))
            {
                printf( "Error %u in WinHttpReadData.\n", GetLastError());
            }
            else
            {
                printf("%s", pszOutBuffer);
            }

            // Free the memory allocated to the buffer.
            delete [] pszOutBuffer;

            // This condition should never be reached since WinHttpQueryDataAvailable
            // reported that there are bits to read.
            if (!dwDownloaded)
                break;

        } while (dwSize > 0);
    }
    else
    {
        // Report any errors.
        printf( "Error %d has occurred.\n", GetLastError() );
    }

    // Close any open handles.
    if (hRequest) WinHttpCloseHandle(hRequest);
    if (hConnect) WinHttpCloseHandle(hConnect);
    if (hSession) WinHttpCloseHandle(hSession);



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [open](#open)
  * [open-request](#open-request)
  * [send-request](#send-request)
  * [connect](#connect)
  * [query-data-available](#query-data-available)
  * [close-handle](#close-handle)
  * [write-data](#write-data)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpReadData](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384104.aspx)

### Function: <a name="receive-response"><em>receive-response</em></a> <i>`REQUEST`</i>

```
WinHttpReceiveResponse function

The WinHttpReceiveResponse function waits to receive the response to an HTTP request initiated by WinHttpSendRequest.
When WinHttpReceiveResponse completes successfully, the status code and response headers have been received and are
available for the application to inspect using WinHttpQueryHeaders. An application must call WinHttpReceiveResponse
before it can use WinHttpQueryDataAvailable and WinHttpReadData to access the response entity body (if any).

Syntax

BOOL WINAPI WinHttpReceiveResponse(
  __in        HINTERNET hRequest,
  __reserved  LPVOID lpReserved
);

Parameters

hRequest [in]

    HINTERNET handle returned by WinHttpOpenRequest and sent by WinHttpSendRequest. Wait until WinHttpSendRequest has
    completed for this handle before calling WinHttpReceiveResponse.

lpReserved [in]

    This parameter is reserved and must be NULL.

Return value

Returns TRUE if successful, or FALSE otherwise. For extended error information, call GetLastError. Among the error
codes returned are the following.

                      Error Code                                                  Description
ERROR_WINHTTP_CANNOT_CONNECT                            Returned if connection to the server failed.

ERROR_WINHTTP_CHUNKED_ENCODING_HEADER_SIZE_OVERFLOW     Returned when an overflow condition is encountered in the
                                                        course of parsing chunked encoding.

ERROR_WINHTTP_CLIENT_AUTH_CERT_NEEDED                   Returned when the server requests client authentication.

                                                        The connection with the server has been reset or terminated, or
ERROR_WINHTTP_CONNECTION_ERROR                          an incompatible SSL protocol was encountered. For example,
                                                        WinHTTP version 5.1 does not support SSL2 unless the client
                                                        specifically enables it.

ERROR_WINHTTP_HEADER_COUNT_EXCEEDED                     Returned when a larger number of headers were present in a
                                                        response than WinHTTP could receive.

ERROR_WINHTTP_HEADER_SIZE_OVERFLOW                      Returned by WinHttpReceiveResponse when the size of headers
                                                        received exceeds the limit for the request handle.

ERROR_WINHTTP_INCORRECT_HANDLE_STATE                    The requested operation cannot be carried out because the
                                                        handle supplied is not in the correct state.

ERROR_WINHTTP_INCORRECT_HANDLE_TYPE                     The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR                            An internal error has occurred.

ERROR_WINHTTP_INVALID_SERVER_RESPONSE                   The server response could not be parsed.

ERROR_WINHTTP_INVALID_URL                               The URL is invalid.

                                                        The login attempt failed. When this error is encountered, the
ERROR_WINHTTP_LOGIN_FAILURE                             request handle should be closed with WinHttpCloseHandle. A new
                                                        request handle must be created before retrying the function
                                                        that originally produced this error.

ERROR_WINHTTP_NAME_NOT_RESOLVED                         The server name could not be resolved.

                                                        The operation was canceled, usually because the handle on which
ERROR_WINHTTP_OPERATION_CANCELLED                       the request was operating was closed before the operation
                                                        completed.

ERROR_WINHTTP_REDIRECT_FAILED                           The redirection failed because either the scheme changed or all
                                                        attempts made to redirect failed (default is five attempts).

ERROR_WINHTTP_RESEND_REQUEST                            The WinHTTP function failed. The desired function can be
                                                        retried on the same request handle.

ERROR_WINHTTP_RESPONSE_DRAIN_OVERFLOW                   Returned when an incoming response exceeds an internal WinHTTP
                                                        size limit.

                                                        One or more errors were found in the Secure Sockets Layer (SSL)
                                                        certificate sent by the server. To determine what type of error
ERROR_WINHTTP_SECURE_FAILURE                            was encountered, check for a
                                                        WINHTTP_CALLBACK_STATUS_SECURE_FAILURE notification in a status
                                                        callback function. For more information, see
                                                        WINHTTP_STATUS_CALLBACK.

ERROR_WINHTTP_TIMEOUT                                   The request has timed out.

ERROR_WINHTTP_UNRECOGNIZED_SCHEME                       The URL specified a scheme other than "http:" or "https:".

ERROR_NOT_ENOUGH_MEMORY                                 Not enough memory was available to complete the requested
                                                        operation. (Windows error code)



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function can operate either synchronously or asynchronously. If this function returns FALSE, this function failed and
you can call GetLastError to get extended error information. If this function returns TRUE, the application should
expect either the WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE completion callback, indicating success, or the
WINHTTP_CALLBACK_STATUS_REQUEST_ERROR completion callback, indicating that the operation completed asynchronously, but
failed.

If a status callback function has been installed with WinHttpSetStatusCallback, then those of the following
notifications that have been set in the dwNotificationFlags parameter of WinHttpSetStatusCallback indicate progress in
receiving the response:

 ｡ｦ WINHTTP_CALLBACK_STATUS_RECEIVING_RESPONSE
 ｡ｦ WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED
 ｡ｦ WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE
 ｡ｦ WINHTTP_CALLBACK_STATUS_INTERMEDIATE_RESPONSE
 ｡ｦ WINHTTP_CALLBACK_STATUS_REDIRECT

If the server closes the connection, the following notifications will also be reported, provided that they have been
set in the dwNotificationFlags parameter of WinHttpSetStatusCallback:

 ｡ｦ WINHTTP_CALLBACK_STATUS_CLOSING_CONNECTION
 ｡ｦ WINHTTP_CALLBACK_STATUS_CONNECTION_CLOSED

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHttp start page.

Examples

This example shows code that writes data to an HTTP server. The server name supplied in the example,
www.wingtiptoys.com, is fictitious and must be replaced with the name of a server for which you have write access.


    LPSTR pszData = "WinHttpWriteData Example";
    DWORD dwBytesWritten = 0;
    BOOL  bResults = FALSE;
    HINTERNET hSession = NULL,
              hConnect = NULL,
              hRequest = NULL;

    // Use WinHttpOpen to obtain a session handle.
    hSession = WinHttpOpen(  L"A WinHTTP Example Program/1.0",
                             WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                             WINHTTP_NO_PROXY_NAME,
                             WINHTTP_NO_PROXY_BYPASS, 0);

    // Specify an HTTP server.
    if (hSession)
        hConnect = WinHttpConnect( hSession, L"www.wingtiptoys.com",
                                   INTERNET_DEFAULT_HTTP_PORT, 0);

    // Create an HTTP Request handle.
    if (hConnect)
        hRequest = WinHttpOpenRequest( hConnect, L"PUT",
                                       L"/writetst.txt",
                                       NULL, WINHTTP_NO_REFERER,
                                       WINHTTP_DEFAULT_ACCEPT_TYPES,
                                       0);

    // Send a Request.
    if (hRequest)
        bResults = WinHttpSendRequest( hRequest,
                                       WINHTTP_NO_ADDITIONAL_HEADERS,
                                       0, WINHTTP_NO_REQUEST_DATA, 0,
                                       (DWORD)strlen(pszData), 0);

    // Write data to the server.
    if (bResults)
        bResults = WinHttpWriteData( hRequest, pszData,
                                     (DWORD)strlen(pszData),
                                     &dwBytesWritten);

    // End the request.
    if (bResults)
        bResults = WinHttpReceiveResponse( hRequest, NULL);

    // Report any errors.
    if (!bResults)
        printf("Error %d has occurred.\n",GetLastError());


    // Close any open handles.
    if (hRequest) WinHttpCloseHandle(hRequest);
    if (hConnect) WinHttpCloseHandle(hConnect);
    if (hSession) WinHttpCloseHandle(hSession);



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [open](#open)
  * [open-request](#open-request)
  * [send-request](#send-request)
  * [close-handle](#close-handle)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpReceiveResponse](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384105.aspx)

### Function: <a name="reset-auto-proxy"><em>reset-auto-proxy</em></a> <i>`SESSION` &key `:flags`</i>

```
WinHttpResetAutoProxy function

[This documentation is preliminary and is subject to change.]

The WinHttpResetAutoProxy function resets the auto-proxy.

Syntax

DWORD WinHttpResetAutoProxy(
  _In_  HINTERNET hSession,
  _In_  DWORD dwFlags
);

Parameters

hSession [in]

    Valid HINTERNET WinHTTP session handle returned by a previous call to WinHttpOpen.

dwFlags [in]

    A set of flags that affects the reset operation.

    The following flags are supported.

                 Value                                                    Meaning
    WINHTTP_RESET_SCRIPT_CACHE      Flushes persistent HTTP cache of proxy scripts.

    WINHTTP_WRAPPER_RESET_STATE     Forces a flush and retry of non-persistent proxy information on the current
                                    network.

                                    Act on the autoproxy service instead of the current process.

    NHTTP_RESET_OUT_OF_PROC         Note  This flag is required.

                                    Applications using WinHttpGetProxyForUrl that need to purge in-process caching
                                    should close the hInternet handle and open a new handle for future calls.



Return value

A code indicating the success or failure of the operation.

            Return code                                  Description
ERROR_SUCCESS                       The operation was successful.

ERROR_INVALID_HANDLE                hSession is not a valid handle.

ERROR_WINHTTP_INCORRECT_HANDLE TYPE hSession is not the product of a call to WinHttpOpen.



Requirements

Minimum supported client Windows Developer Preview

Minimum supported server Windows Server Developer Preview

         Header          Winhttp.h
```
  * [WinHttpResetAutoProxy](http://msdn.microsoft.com/en-us/library/windows/desktop/hh405357.aspx)

### Function: <a name="send-request"><em>send-request</em></a> <i>`REQUEST` &key `:data` `:headers` `:total-length`</i>

```
WinHttpSendRequest function

The WinHttpSendRequest function sends the specified request to the HTTP server.

Syntax

BOOL WINAPI WinHttpSendRequest(
  __in      HINTERNET hRequest,
  __in_opt  LPCWSTR pwszHeaders,
  __in      DWORD dwHeadersLength,
  __in_opt  LPVOID lpOptional,
  __in      DWORD dwOptionalLength,
  __in      DWORD dwTotalLength,
  __in      DWORD_PTR dwContext
);

Parameters

hRequest [in]

    An HINTERNET handle returned by WinHttpOpenRequest.

pwszHeaders [in, optional]

    A pointer to a string that contains the additional headers to append to the request. This parameter can be
    WINHTTP_NO_ADDITIONAL_HEADERS if there are no additional headers to append.

dwHeadersLength [in]

    An unsigned long integer value that contains the length, in characters, of the additional headers. If this
    parameter is -1L and pwszHeaders is not NULL, this function assumes that pwszHeaders is null-terminated, and the
    length is calculated.

lpOptional [in, optional]

    A pointer to a buffer that contains any optional data to send immediately after the request headers. This parameter
    is generally used for POST and PUT operations. The optional data can be the resource or data posted to the server.
    This parameter can be WINHTTP_NO_REQUEST_DATA if there is no optional data to send.

    If the dwOptionalLength parameter is 0, this parameter is ignored and set to NULL.

    This buffer must remain available until the request handle is closed or the call to WinHttpReceiveResponse has
    completed.

dwOptionalLength [in]

    An unsigned long integer value that contains the length, in bytes, of the optional data. This parameter can be zero
    if there is no optional data to send.

    This parameter must contain a valid length when the lpOptional parameter is not NULL. Otherwise, lpOptional is
    ignored and set to NULL.

dwTotalLength [in]

    An unsigned long integer value that contains the length, in bytes, of the total data sent. This parameter specifies
    the Content-Length header of the request. If the value of this parameter is greater than the length specified by
    dwOptionalLength, then WinHttpWriteData can be used to send additional data.

    dwTotalLength must not change between calls to WinHttpSendRequest for the same request. If dwTotalLength needs to
    be changed, the caller should create a new request.

dwContext [in]

    A pointer to a pointer-sized variable that contains an application-defined value that is passed, with the request
    handle, to any callback functions.

Return value

Returns TRUE if successful, or FALSE otherwise. For extended error information, call GetLastError. Error codes are
listed in the following table.

               Error Code                                                  Description
ERROR_WINHTTP_CANNOT_CONNECT              Returned if connection to the server failed.

                                          The secure HTTP server requires a client certificate. The application
                                          retrieves the list of certificate issuers by calling WinHttpQueryOption with
                                          the WINHTTP_OPTION_CLIENT_CERT_ISSUER_LIST option.

                                          If the server requests the client certificate, but does not require it, the
                                          application can alternately call WinHttpSetOption with the
ERROR_WINHTTP_CLIENT_AUTH_CERT_NEEDED     WINHTTP_OPTION_CLIENT_CERT_CONTEXT option. In this case, the application
                                          specifies the WINHTTP_NO_CLIENT_CERT_CONTEXT macro in the lpBuffer parameter
                                          of WinHttpSetOption. For more information, see the
                                          WINHTTP_OPTION_CLIENT_CERT_CONTEXT option.

                                              Windows Server 2003 with SP1, Windows XP with SP2, and Windows 2000:
                                              This error is not supported.

                                          The connection with the server has been reset or terminated, or an
ERROR_WINHTTP_CONNECTION_ERROR            incompatible SSL protocol was encountered. For example, WinHTTP version 5.1
                                          does not support SSL2 unless the client specifically enables it.

ERROR_WINHTTP_INCORRECT_HANDLE_STATE      The requested operation cannot be carried out because the handle supplied is
                                          not in the correct state.

ERROR_WINHTTP_INCORRECT_HANDLE_TYPE       The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR              An internal error has occurred.

ERROR_WINHTTP_INVALID_URL                 The URL is invalid.

                                          The login attempt failed. When this error is encountered, the request handle
ERROR_WINHTTP_LOGIN_FAILURE               should be closed with WinHttpCloseHandle. A new request handle must be
                                          created before retrying the function that originally produced this error.

ERROR_WINHTTP_NAME_NOT_RESOLVED           The server name cannot be resolved.

ERROR_WINHTTP_OPERATION_CANCELLED         The operation was canceled, usually because the handle on which the request
                                          was operating was closed before the operation completed.

ERROR_WINHTTP_RESPONSE_DRAIN_OVERFLOW     Returned when an incoming response exceeds an internal WinHTTP size limit.

                                          One or more errors were found in the Secure Sockets Layer (SSL) certificate
ERROR_WINHTTP_SECURE_FAILURE              sent by the server. To determine what type of error was encountered, verify
                                          through a WINHTTP_CALLBACK_STATUS_SECURE_FAILURE notification in a status
                                          callback function. For more information, see WINHTTP_STATUS_CALLBACK.

ERROR_WINHTTP_SHUTDOWN                    The WinHTTP function support is shut down or unloaded.

ERROR_WINHTTP_TIMEOUT                     The request timed out.

ERROR_WINHTTP_UNRECOGNIZED_SCHEME         The URL specified a scheme other than "http:" or "https:".

                                          Not enough memory was available to complete the requested operation. (Windows
                                          error code)
ERROR_NOT_ENOUGH_MEMORY
                                              Windows Server 2003, Windows XP, and Windows 2000:  The TCP reservation
                                              range set with the WINHTTP_OPTION_PORT_RESERVATION option is not large
                                              enough to send this request.

                                          The content length specified in the dwTotalLength parameter does not match
                                          the length specified in the Content-Length header. (Windows error code)

                                          The content length specified in the dwTotalLength parameter does not match
                                          the length specified in the Content-Length header.
ERROR_INVALID_PARAMETER
                                          The lpOptional parameter must be NULL and the dwOptionalLength parameter must
                                          be zero when the Transfer-Encoding header is present.

                                          The Content-Length header cannot be present when the Transfer-Encoding header
                                          is present.

                                          The application must call WinHttpSendRequest again due to a redirect or
                                          authentication challenge.
ERROR_WINHTTP_RESEND_REQUEST
                                              Windows Server 2003 with SP1, Windows XP with SP2, and Windows 2000:
                                              This error is not supported.



Remarks

Even when WinHTTP is used in asynchronous mode, that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen, this
function can operate either synchronously or asynchronously. In either case, if the request is sent successfully, the
application is called back with the completion status set to WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE. The
WINHTTP_CALLBACK_STATUS_REQUEST_ERROR completion indicates that the operation completed asynchronously, but failed.
Upon receiving the WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE status callback, the application can start to receive a
response from the server with WinHttpReceiveResponse. Before then, no other asynchronous functions can be called,
otherwise, ERROR_WINHTTP_INCORRECT_HANDLE_STATE is returned.

An application must not delete or alter the buffer pointed to by lpOptional until the request handle is closed or the
call to WinHttpReceiveResponse has completed, because an authentication challenge or redirect that required the
optional data could be encountered in the course of receiving the response. If the operation must be aborted with
WinHttpCloseHandle, the application must keep the buffer valid until it receives the callback
WINHTTP_CALLBACK_STATUS_REQUEST_ERROR with an ERROR_WINHTTP_OPERATION_CANCELLED error code.

If WinHTTP is used synchronously, that is, when WINHTP_FLAG_ASYNC was not set in WinHttpOpen, an application is not
called with a completion status even if a callback function is registered. While in this mode, the application can call
WinHttpReceiveResponse when WinHttpSendRequest returns.

The WinHttpSendRequest function sends the specified request to the HTTP server and allows the client to specify
additional headers to send along with the request.

This function also lets the client specify optional data to send to the HTTP server immediately following the request
headers. This feature is generally used for write operations such as PUT and POST.

An application can use the same HTTP request handle in multiple calls to WinHttpSendRequest to re-send the same
request, but the application must read all data returned from the previous call before calling this function again.

The name and value of request headers added with this function are validated. Headers must be well formed. For more
information about valid HTTP headers, see RFC 2616. If an invalid header is used, this function fails and GetLastError
returns ERROR_INVALID_PARAMETER. The invalid header is not added.

If a status callback function has been installed with WinHttpSetStatusCallback, then those of the following
notifications that have been set in the dwNotificationFlags parameter of WinHttpSetStatusCallback indicate the progress
in sending the request:

 ｡ｦ WINHTTP_CALLBACK_STATUS_RESOLVING_NAME (deprecated),
 ｡ｦ WINHTTP_CALLBACK_STATUS_NAME_RESOLVED (deprecated),
 ｡ｦ WINHTTP_CALLBACK_STATUS_DETECTING_PROXY (not implemented),
 ｡ｦ WINHTTP_CALLBACK_STATUS_CONNECTING_TO_SERVER (deprecated),
 ｡ｦ WINHTTP_CALLBACK_STATUS_CONNECTED_TO_SERVER (deprecated),
 ｡ｦ WINHTTP_CALLBACK_STATUS_SENDING_REQUEST (deprecated),
 ｡ｦ WINHTTP_CALLBACK_STATUS_REQUEST_SENT (deprecated),
 ｡ｦ WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE (only in asynchronous mode),
 ｡ｦ WINHTTP_CALLBACK_STATUS_REDIRECT,
 ｡ｦ WINHTTP_CALLBACK_STATUS_SECURE_FAILURE,
 ｡ｦ WINHTTP_CALLBACK_STATUS_RECEIVING_RESPONSE (deprecated),
 ｡ｦ WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED (deprecated), and
 ｡ｦ WINHTTP_CALLBACK_STATUS_INTERMEDIATE_RESPONSE.

If the server closes the connection, the following notifications are also sent, provided that they have been set in the
dwNotificationFlags parameter of WinHttpSetStatusCallback:

 ｡ｦ WINHTTP_CALLBACK_STATUS_CLOSING_CONNECTION (deprecated), and
 ｡ｦ WINHTTP_CALLBACK_STATUS_CONNECTION_CLOSED (deprecated).

    Windows 2000:  When sending requests from multiple threads, there may be a significant decrease in network and CPU
    performance. For more information, see Q282865 - Winsock Shutdown Can Increase CPU Usage to 100 Percent.

    Windows XP and Windows 2000:  See Run-Time Requirements.

Support for Greater Than 4-GB Upload

Starting in Windows Vista and Windows Server 2008, WinHttp supports uploading files up to the size of a LARGE_INTEGER
(2^64 bytes) using the Content-Length header. Payload lengths specified in the call to WinHttpSendRequest are limited
to the size of a DWORD (2^32 bytes). To upload data to a URL larger than a DWORD, the application must provide the
length in the Content-Length header of the request. In this case, the WinHttp client application calls
WinHttpSendRequest with the dwTotalLength parameter set to WINHTTP_IGNORE_TOTAL_LENGTH.

If the Content-Length header specifies a length less than a 2^32, the application must also specify the content length
in the call to WinHttpSendRequest. If the dwTotalLength parameter does not match the length specified in the
Content-Length header, the call fails and returns ERROR_INVALID_PARAMETER.

The Content-Length header can be added in the call to WinHttpAddRequestHeaders, or it can be specified in the
lpszHeader parameter of WinHttpSendRequest as shown in the following code example.

BOOL fRet = WinHttpSendRequest(
                        hReq,
                        L"Content-Length: 68719476735\r\n",
                        -1L,
                        WINHTTP_NO_REQUEST_DATA,
                        0,
                        WINHTTP_IGNORE_REQUEST_TOTAL_LENGTH,
                        pMyContent);

Transfer-Encoding Header

Starting in Windows Vista and Windows Server 2008, WinHttp enables applications to perform chunked transfer encoding on
data sent to the server. When the Transfer-Encoding header is present on the WinHttp request, the dwTotalLength
parameter in the call to WinHttpSendRequest is set to WINHTTP_IGNORE_REQUEST_TOTAL_LENGTH and the application sends the
entity body in one or more calls to WinHttpWriteData. The lpOptional parameter of WinHttpSendRequest must be NULL and
the dwOptionLength parameter must be zero, otherwise an ERROR_WINHTTP_INVALID_PARAMETER error is returned. To terminate
the chunked data transfer, the application generates a zero length chunk and sends it in the last call to
WinHttpWriteData.

Examples

The following code example shows how to obtain an HINTERNET handle, open an HTTP session, create a request header, and
send that header to the server.


    BOOL  bResults = FALSE;
    HINTERNET hSession = NULL,
              hConnect = NULL,
              hRequest = NULL;

    // Use WinHttpOpen to obtain a session handle.
    hSession = WinHttpOpen(  L"A WinHTTP Example Program/1.0",
                             WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                             WINHTTP_NO_PROXY_NAME,
                             WINHTTP_NO_PROXY_BYPASS, 0);

    // Specify an HTTP server.
    if (hSession)
        hConnect = WinHttpConnect( hSession, L"www.wingtiptoys.com",
                                   INTERNET_DEFAULT_HTTP_PORT, 0);

    // Create an HTTP Request handle.
    if (hConnect)
        hRequest = WinHttpOpenRequest( hConnect, L"PUT",
                                       L"/writetst.txt",
                                       NULL, WINHTTP_NO_REFERER,
                                       WINHTTP_DEFAULT_ACCEPT_TYPES,
                                       0);

    // Send a Request.
    if (hRequest)
        bResults = WinHttpSendRequest( hRequest,
                                       WINHTTP_NO_ADDITIONAL_HEADERS,
                                       0, WINHTTP_NO_REQUEST_DATA, 0,
                                       0, 0);

    // Place additional code here.


    // Report errors.
    if (!bResults)
        printf("Error %d has occurred.\n",GetLastError());

    // Close open handles.
    if (hRequest) WinHttpCloseHandle(hRequest);
    if (hConnect) WinHttpCloseHandle(hConnect);
    if (hSession) WinHttpCloseHandle(hSession);



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
WINHTTP_STATUS_CALLBACK
  * [close-handle](#close-handle)
  * [connect](#connect)
  * [open](#open)
  * [open-request](#open-request)
  * [receive-response](#receive-response)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpSendRequest](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384110.aspx)

### Function: <a name="set-credentials"><em>set-credentials</em></a> <i>`REQUEST` `AUTH-TARGETS` `AUTH-SCHEME` `USERNAME` `PASSWORD`</i>

```
WinHttpSetCredentials function

The WinHttpSetCredentials function passes the required authorization credentials to the server.

Syntax

BOOL WINAPI WinHttpSetCredentials(
  __in        HINTERNET hRequest,
  __in        DWORD AuthTargets,
  __in        DWORD AuthScheme,
  __in        LPCWSTR pwszUserName,
  __in        LPCWSTR pwszPassword,
  __reserved  LPVOID pAuthParams
);

Parameters

hRequest [in]

    Valid HINTERNET handle returned by WinHttpOpenRequest.

AuthTargets [in]

    An unsigned integer that specifies a flag that contains the authentication target. Can be one of the values in the
    following table.

                Value                          Meaning
    WINHTTP_AUTH_TARGET_SERVER     Credentials are passed to a
                                   server.

    WINHTTP_AUTH_TARGET_PROXY      Credentials are passed to a
                                   proxy.



AuthScheme [in]

    An unsigned integer that specifies a flag that contains the authentication scheme. Must be one of the supported
    authentication schemes returned from WinHttpQueryAuthSchemes. The following table identifies the possible values.

                  Value                                  Meaning
    WINHTTP_AUTH_SCHEME_BASIC         Use basic authentication.

    WINHTTP_AUTH_SCHEME_NTLM          Use NTLM authentication.

    WINHTTP_AUTH_SCHEME_PASSPORT      Use passport authentication.

    WINHTTP_AUTH_SCHEME_DIGEST        Use digest authentication.

    WINHTTP_AUTH_SCHEME_NEGOTIATE     Selects between NTLM and Kerberos
                                      authentication.



pwszUserName [in]

    Pointer to a string that contains a valid user name.

pwszPassword [in]

    Pointer to a string that contains a valid password. The password can be blank.

pAuthParams [in]

    This parameter is reserved and must be NULL.

Return value

Returns TRUE if successful, or FALSE otherwise. For extended error information, call GetLastError. The following table
identifies the error codes returned.

               Error Code                                                 Description
ERROR_WINHTTP_INCORRECT_HANDLE_STATE     The requested operation cannot be carried out because the handle supplied is
                                         not in the correct state.

ERROR_WINHTTP_INCORRECT_HANDLE_TYPE      The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR             An internal error has occurred.

ERROR_NOT_ENOUGH_MEMORY                  Not enough memory was available to complete the requested operation (Windows
                                         error code).



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

The credentials set by WinHttpSetCredentials are only used for a single request; WinHTTP does not cache these
credentials for use in subsequent requests. As a result, applications must be written so that they can respond to
multiple challenges. If an authenticated connection is re-used, subsequent requests cannot be challenged, but your code
should be able to respond to a challenge at any point.

For sample code that illustrates the use of WinHttpSetCredentials, see Authentication in WinHTTP.

Note  When using Passport authentication and responding to a 407 status code, a WinHTTP application must use
WinHttpSetOption to provide proxy credentials rather than WinHttpSetCredentials. This is only true when using Passport
authentication; in all other circumstances, use WinHttpSetCredentials, because WinHttpSetOption is less secure.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHttp start page.

Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
Authentication in WinHTTP
  * [open](#open)
  * [open-request](#open-request)
  * [connect](#connect)
  * [query-auth-schemes](#query-auth-schemes)
  * [close-handle](#close-handle)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpSetCredentials](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384112.aspx)

### Function: <a name="set-default-proxy-configuration"><em>set-default-proxy-configuration</em></a> <i>&key `:proxy-name` `:proxy-bypass` (`:access-type` :default-proxy)</i>

```
WinHttpSetDefaultProxyConfiguration function

The WinHttpSetDefaultProxyConfiguration function sets the default WinHTTP proxy configuration in the registry.

Syntax

BOOL WINAPI WinHttpSetDefaultProxyConfiguration(
  __in  WINHTTP_PROXY_INFO *pProxyInfo
);

Parameters

pProxyInfo [in]

    A pointer to a variable of type WINHTTP_PROXY_INFO that specifies the default proxy configuration.

Return value

Returns TRUE if successful, or FALSE otherwise. For extended error information, call GetLastError. Among the error
codes returned are the following.

           Error Code                                                 Description
ERROR_WINHTTP_INTERNAL_ERROR     An internal error has occurred.

ERROR_NOT_ENOUGH_MEMORY          Not enough memory was available to complete the requested operation. (Windows error
                                 code)



Remarks

WinHttpSetDefaultProxyConfiguration changes the proxy configuration set by ProxyCfg.exe.

The default proxy configuration set by this function can be overridden for an existing WinHTTP session by calling
WinHttpSetOption and specifying the WINHTTP_OPTION_PROXY flag. The default proxy configuration can be overridden for a
new session by specifying the configuration with the WinHttpOpen function.

The dwAccessType member of the WINHTTP_PROXY_INFO structure pointed to by pProxyInfo should be set to
WINHTTP_ACCESS_TYPE_NAMED_PROXY if a proxy is specified. Otherwise, it should be set to
WINHTTP_ACCESS_TYPE_DEFAULT_PROXY.

Any new sessions created after calling this function use the new default proxy configuration.

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHTTP start page.

Examples

The following code example shows how to set the default proxy configuration in the registry.


    WINHTTP_PROXY_INFO proxyInfo;

    // Allocate memory for string members.
    proxyInfo.lpszProxy = new WCHAR[25];
    proxyInfo.lpszProxyBypass = new WCHAR[25];

    // Set the members of the proxy info structure.
    proxyInfo.dwAccessType = WINHTTP_ACCESS_TYPE_NAMED_PROXY;
    swprintf_s(proxyInfo.lpszProxy, 25, L"proxy_server");
    swprintf_s(proxyInfo.lpszProxyBypass, 25, L"<local>");

    // Set the default proxy configuration.
    if (WinHttpSetDefaultProxyConfiguration( &proxyInfo ))
        printf("Proxy Configuration Set.\n");

    // Free memory allocated to the strings.
    delete [] proxyInfo.lpszProxy;
    delete [] proxyInfo.lpszProxyBypass;



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

ProxyCfg.exe, a Proxy Configuration Tool
  * [get-default-proxy-configuration](#get-default-proxy-configuration)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpSetDefaultProxyConfiguration](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384113.aspx)

### Function: <a name="set-option"><em>set-option</em></a> <i>`HINTERNET` `OPTION` `VALUE`</i>

```
WinHttpSetOption function

The WinHttpSetOption function sets an Internet option.

Syntax

BOOL WINAPI WinHttpSetOption(
  __in  HINTERNET hInternet,
  __in  DWORD dwOption,
  __in  LPVOID lpBuffer,
  __in  DWORD dwBufferLength
);

Parameters

hInternet [in]

    The HINTERNET handle on which to set data. Be aware that this can be either a Session handle or a Request handle,
    depending on what option is being set. For more information about how to determine which handle is appropriate to
    use in setting a particular option, see the Option Flags.

dwOption [in]

    An unsigned long integer value that contains the Internet option to set. This can be one of the Option Flags
    values.

lpBuffer [in]

    A pointer to a buffer that contains the option setting.

dwBufferLength [in]

    Unsigned long integer value that contains the length of the lpBuffer buffer. The length of the buffer is specified
    in characters for the following options; for all other options, the length is specified in bytes.

Return value

Returns TRUE if successful, or FALSE otherwise. For extended error information, call GetLastError. Among the error
codes returned are the following

               Error Code                                                 Description
ERROR_WINHTTP_INCORRECT_HANDLE_STATE     The requested operation cannot be carried out because the handle supplied is
                                         not in the correct state.

ERROR_WINHTTP_INCORRECT_HANDLE_TYPE      The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR             An internal error has occurred.

ERROR_WINHTTP_INVALID_OPTION             A request to WinHttpQueryOption or WinHttpSetOption specified an invalid
                                         option value.

ERROR_WINHTTP_OPTION_NOT_SETTABLE        The requested option cannot be set, only queried.

ERROR_NOT_ENOUGH_MEMORY                  Not enough memory was available to complete the requested operation. (Windows
                                         error code)



Remarks

Credentials passed to WinHttpSetOption could be unexpectedly sent in plaintext. It is strongly recommended that you use
WinHttpQueryAuthSchemes and WinHttpSetCredentials instead of WinHttpSetOption for setting credentials.

Note  When using Passport authentication, however, a WinHTTP application responding to a 407 status code must use
WinHttpSetOption to provide proxy credentials rather than WinHttpSetCredentials. This is only true when using Passport
authentication; in all other circumstances, use WinHttpSetCredentials.

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

GetLastError returns the error ERROR_INVALID_PARAMETER if an option flag is specified that cannot be set.

For more information and code examples that show the use of WinHttpSetOption, see Authentication in WinHTTP.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHttp start page.

Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
Setting Internet Options With WinHTTP
  * [open](#open)
  * [query-option](#query-option)
  * [close-handle](#close-handle)
Authentication in WinHTTP
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpSetOption](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384114.aspx)

### Function: <a name="set-status-callback"><em>set-status-callback</em></a> <i>`HINTERNET` `CALLBACK` &key `:all-completions` `:all-notifications` `:resolve-name` `:connect-to-server` `:detecting-proxy` `:data-available` `:headers-available` `:read-complete` `:request-error` `:send-request` `:send-request-complete` `:write-complete` `:receive-response` `:close-connection` `:handles` `:redirect` `:intermediate-response` `:secure-failure`</i>

```
WinHttpSetStatusCallback function

The WinHttpSetStatusCallback function sets up a callback function that WinHTTP can call as progress is made during an
operation.

Syntax

WINHTTP_STATUS_CALLBACK WINAPI WinHttpSetStatusCallback(
  __in        HINTERNET hInternet,
  __in        WINHTTP_STATUS_CALLBACK lpfnInternetCallback,
  __in        DWORD dwNotificationFlags,
  __reserved  DWORD_PTR dwReserved
);

Parameters

hInternet [in]

    HINTERNET handle for which the callback is to be set.

lpfnInternetCallback [in]

    Pointer to the callback function to call when progress is made. Set this to NULL to remove the existing callback
    function. For more information about the callback function, see WINHTTP_STATUS_CALLBACK.

dwNotificationFlags [in]

    Unsigned long integer value that specifies flags to indicate which events activate the callback function.

    The possible values are as follows.

                         Value                                                    Meaning
                                                    Activates upon any completion notification. This flag specifies
    WINHTTP_CALLBACK_FLAG_ALL_COMPLETIONS           that all notifications required for read or write operations are
                                                    used. See WINHTTP_STATUS_CALLBACK for a list of completions.

                                                    Activates upon any status change notification including
    WINHTTP_CALLBACK_FLAG_ALL_NOTIFICATIONS         completions. See WINHTTP_STATUS_CALLBACK for a list of
                                                    notifications.

    WINHTTP_CALLBACK_FLAG_RESOLVE_NAME              Activates upon beginning and completing name resolution.

    WINHTTP_CALLBACK_FLAG_CONNECT_TO_SERVER         Activates upon beginning and completing connection to the server.

    WINHTTP_CALLBACK_FLAG_DETECTING_PROXY           Activates when detecting the proxy server.

    WINHTTP_CALLBACK_FLAG_DATA_AVAILABLE            Activates when completing a query for data.

    WINHTTP_CALLBACK_FLAG_HEADERS_AVAILABLE         Activates when the response headers are available for retrieval.

    WINHTTP_CALLBACK_FLAG_READ_COMPLETE             Activates upon completion of a data-read operation.

    WINHTTP_CALLBACK_FLAG_REQUEST_ERROR             Activates when an asynchronous error occurs.

    WINHTTP_CALLBACK_FLAG_SEND_REQUEST              Activates upon beginning and completing the sending of a request
                                                    header with WinHttpSendRequest.

    WINHTTP_CALLBACK_FLAG_SENDREQUEST_COMPLETE      Activates when a request header has been sent with
                                                    WinHttpSendRequest.

    WINHTTP_CALLBACK_FLAG_WRITE_COMPLETE            Activates upon completion of a data-post operation.

    WINHTTP_CALLBACK_FLAG_RECEIVE_RESPONSE          Activates upon beginning and completing the receipt of a resource
                                                    from the HTTP server.

    WINHTTP_CALLBACK_FLAG_CLOSE_CONNECTION          Activates when beginning and completing the closing of an HTTP
                                                    connection.

    WINHTTP_CALLBACK_FLAG_HANDLES                   Activates when an HINTERNET handle is created or closed.

    WINHTTP_CALLBACK_FLAG_REDIRECT                  Activates when the request is redirected.

    WINHTTP_CALLBACK_FLAG_INTERMEDIATE_RESPONSE     Activates when receiving an intermediate (100 level) status code
                                                    message from the server.

    WINHTTP_CALLBACK_FLAG_SECURE_FAILURE            Activates upon a secure connection failure.



dwReserved [in]

    This parameter is reserved and must be NULL.

Return value

If successful, returns a pointer to the previously defined status callback function or NULL if there was no previously
defined status callback function. Returns WINHTTP_INVALID_STATUS_CALLBACK if the callback function could not be
installed. For extended error information, call GetLastError. Among the error codes returned are the following.

              Error Code                                                  Description
ERROR_WINHTTP_INCORRECT_HANDLE_TYPE     The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR            An internal error has occurred.

ERROR_NOT_ENOUGH_MEMORY                 Not enough memory was available to complete the requested operation. (Windows
                                        error code)



Remarks

If you set the callback on the session handle before creating the request handle, the request handle inherits the
callback function pointer from its parent session.

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

Both synchronous and asynchronous functions use the callback function to indicate the progress of the request, such as
resolving a name, connecting to a server, and so on. The callback function is required for an asynchronous operation.

A callback function can be set on any handle and is inherited by derived handles. A callback function can be changed
using WinHttpSetStatusCallback, provided there are no pending requests that need to use the previous callback value.
However, changing the callback function on a handle does not change the callbacks on derived handles, such as that
returned by WinHttpConnect. You must change the callback function at each level.

Many WinHTTP functions perform several operations on the network. Each operation can take time to complete and each can
fail.

After initiating the WinHttpSetStatusCallback function, the callback function can be accessed from within WinHTTP for
monitoring time-intensive network operations.

At the end of asynchronous processing, the application may set the callback function to NULL. This prevents the client
application from receiving additional notifications.

The following code snippet shows the recommended method for setting the callback function to NULL.

WinHttpSetStatusCallback( hOpen,
                          NULL,
                          WINHTTP_CALLBACK_FLAG_ALL_NOTIFICATIONS,
                          NULL );


Note, however, that WinHTTP does not synchronize WinHttpSetStatusCallback with worker threads. If a callback
originating in another thread is in progress when an application calls WinHttpSetStatusCallback, the application still
receives a callback notification even after WinHttpSetStatusCallback successfully sets the callback function to NULL
and returns.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHttp start page.

Examples

The following example shows how to install a callback function for asynchronous WinHTTP functions. The example assumes
that a WINHTTP_STATUS_CALLBACK function named "AsyncCallback( )" has been previously implemented:


    // Use WinHttpOpen to obtain an HINTERNET handle.
    HINTERNET hSession = WinHttpOpen(L"A WinHTTP Example Program/1.0",
                                    WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                                    WINHTTP_NO_PROXY_NAME,
                                    WINHTTP_NO_PROXY_BYPASS, 0);
    if (hSession)
    {
        // Install the status callback function.
        WINHTTP_STATUS_CALLBACK isCallback = WinHttpSetStatusCallback( hSession,
                                               (WINHTTP_STATUS_CALLBACK)AsyncCallback,
                                               WINHTTP_CALLBACK_FLAG_ALL_NOTIFICATIONS,
                                               NULL);

        // Place additional code here.

        // When finished, release the HINTERNET handle.
        WinHttpCloseHandle(hSession);
    }
    else
    {
        printf("Error %u in WinHttpOpen.\n", GetLastError());
    }



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [open](#open)
  * [connect](#connect)
WINHTTP_STATUS_CALLBACK
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpSetStatusCallback](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384115.aspx)

### Function: <a name="set-timeouts"><em>set-timeouts</em></a> <i>`HINTERNET` &key (`:resolve` 0) (`:connect` 60000) (`:send` 30000) (`:receive` 30000)</i>

```
WinHttpSetTimeouts function

The WinHttpSetTimeouts function sets time-outs involved with HTTP transactions.

Syntax

BOOL WINAPI WinHttpSetTimeouts(
  __in  HINTERNET hInternet,
  __in  int dwResolveTimeout,
  __in  int dwConnectTimeout,
  __in  int dwSendTimeout,
  __in  int dwReceiveTimeout
);

Parameters

hInternet [in]

    The HINTERNET handle returned by WinHttpOpen or WinHttpOpenRequest.

dwResolveTimeout [in]

    A value of type integer that specifies the time-out value, in milliseconds, to use for name resolution. If
    resolution takes longer than this time-out value, the action is canceled. The initial value is zero, meaning no
    time-out (infinite).

        Windows Vista and Windows XP:  If DNS timeout is specified using NAME_RESOLUTION_TIMEOUT, there is an overhead
        of one thread per request.

dwConnectTimeout [in]

    A value of type integer that specifies the time-out value, in milliseconds, to use for server connection requests.
    If a connection request takes longer than this time-out value, the request is canceled. The initial value is 60,000
    (60 seconds).

dwSendTimeout [in]

    A value of type integer that specifies the time-out value, in milliseconds, to use for sending requests. If sending
    a request takes longer than this time-out value, the send is canceled. The initial value is 30,000 (30 seconds).

dwReceiveTimeout [in]

    A value of type integer that specifies the time-out value, in milliseconds, to receive a response to a request. If
    a response takes longer than this time-out value, the request is canceled. The initial value is 30,000 (30
    seconds).

Return value

Returns TRUE if successful, or FALSE otherwise. For extended error information, call GetLastError. Among the error
codes returned are the following.

               Error Code                                                 Description
ERROR_WINHTTP_INCORRECT_HANDLE_STATE     The requested operation cannot be carried out because the handle supplied is
                                         not in the correct state.

ERROR_WINHTTP_INCORRECT_HANDLE_TYPE      The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR             An internal error has occurred.

ERROR_NOT_ENOUGH_MEMORY                  Not enough memory was available to complete the requested operation. (Windows
                                         error code)

ERROR_INVALID_PARAMETER                  One or more of the timeout parameters has a negative value other than -1.



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

A value of 0 or -1 sets a time-out to wait infinitely. A value greater than 0 sets the time-out value in milliseconds.
For example, 30,000 would set the time-out to 30 seconds. All negative values other than -1 cause the function to fail
with ERROR_INVALID_PARAMETER.

Important  If a small timeout is set using WinHttpSetOption and WINHTTP_OPTION_RECEIVE_TIMEOUT, it can override the
value set with the dwReceiveTimeout parameter, causing a response to terminate earlier than expected. To avoid this, do
not set a timeout with the WINHTTP_OPTION_RECEIVE_TIMEOUT option that is smaller than the value set using
dwReceiveTimeout.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHTTP start page.

Examples

This example shows how to set new time-out values using WinHttpSetTimeouts.


    // Use WinHttpOpen to obtain an HINTERNET handle.
    HINTERNET hSession = WinHttpOpen(L"A WinHTTP Example Program/1.0",
                                    WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                                    WINHTTP_NO_PROXY_NAME,
                                    WINHTTP_NO_PROXY_BYPASS, 0);
    if (hSession)
    {
        // Use WinHttpSetTimeouts to set a new time-out values.
        if (!WinHttpSetTimeouts( hSession, 10000, 10000, 10000, 10000))
            printf( "Error %u in WinHttpSetTimeouts.\n", GetLastError());

        // PLACE ADDITIONAL CODE HERE.

        // When finished, release the HINTERNET handle.
        WinHttpCloseHandle(hSession);
    }
    else
    {
        printf("Error %u in WinHttpOpen.\n", GetLastError());
    }



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [open](#open)
  * [open-request](#open-request)
  * [connect](#connect)
  * [close-handle](#close-handle)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpSetTimeouts](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384116.aspx)

### Function: <a name="time-from-system-time"><em>time-from-system-time</em></a> <i>`SECOND` `MINUTE` `HOUR` `DAY` `MONTH` `YEAR` &optional `TIME-ZONE`</i>

```
WinHttpTimeFromSystemTime function

The WinHttpTimeFromSystemTime function formats a date and time according to the HTTP version 1.0 specification.

Syntax

BOOL WINAPI WinHttpTimeFromSystemTime(
  __in   const SYSTEMTIME *pst,
  __out  LPWSTR pwszTime
);

Parameters

pst [in]

    A pointer to a SYSTEMTIME structure that contains the date and time to format.

pwszTime [out]

    A pointer to a string buffer that receives the formatted date and time. The buffer should equal to the size, in
    bytes, of WINHTTP_TIME_FORMAT_BUFSIZE.

Return value

Returns TRUE if successful, or FALSE otherwise. To get extended error information, call GetLastError. Error codes
include the following.

           Error Code                    Description
ERROR_WINHTTP_INTERNAL_ERROR     An internal error has
                                 occurred.



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHTTP Start Page.

Examples

The following code example code shows how to convert a SYSTEMTIME structure to a string that contains the time in HTTP
format.


    SYSTEMTIME  sTime;
    LPWSTR      pwszTimeStr;

    // Get the current time.
    GetSystemTime(&sTime);

    // Allocate memory for the string.
    // Note: WINHTTP_TIME_FORMAT_BUFSIZE is a byte count.
    //       Therefore, you must divide the array by
    //       sizeof WCHAR to get the proper string length.
    pwszTimeStr = new WCHAR[WINHTTP_TIME_FORMAT_BUFSIZE/sizeof(WCHAR)];

    // Convert the current time to HTTP format.
    if(!WinHttpTimeFromSystemTime( &sTime, pwszTimeStr))
    {
        printf( "Error %u in WinHttpTimeFromSystemTime.\n", GetLastError());
    }
    else
    {
        // Print the time.
        printf("Current time is (%S)\n", pwszTimeStr);
    }

    // Free the memory.
    delete [] pwszTimeStr;



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [time-to-system-time](#time-to-system-time)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpTimeFromSystemTime](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384117.aspx)

### Function: <a name="time-from-universal-time"><em>time-from-universal-time</em></a> <i>`UNIVERSAL-TIME`</i>

TODO

__See Also:__

  * TODO

### Function: <a name="time-to-system-time"><em>time-to-system-time</em></a> <i>`TIME` &optional `TIME-ZONE`</i>

```
WinHttpTimeToSystemTime function

The WinHttpTimeToSystemTime function takes an HTTP time/date string and converts it to a SYSTEMTIME structure.

Syntax

BOOL WINAPI WinHttpTimeToSystemTime(
  __in   LPCWSTR pwszTime,
  __out  SYSTEMTIME *pst
);

Parameters

pwszTime [in]

    Pointer to a null-terminated date/time string to convert. This value must use the format defined in section 3.3 of
    the RFC2616.

pst [out]

    Pointer to the SYSTEMTIME structure that receives the converted time.

Return value

Returns TRUE if successful, or FALSE otherwise. For extended error information, call GetLastError. Among the error
codes returned is:

           Error Code                    Description
ERROR_WINHTTP_INTERNAL_ERROR     An internal error has
                                 occurred.



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function operates synchronously. The return value indicates success or failure. To get extended error information, call
GetLastError.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHttp start page.

Examples

This example shows how to convert an HTTP formatted date to a SYSTEMTIME structure.


    SYSTEMTIME  sTime;
    LPCWSTR     pwszTimeStr = L"Tue, 21 Nov 2000 01:06:53 GMT";

    // Convert the HTTP string to a SYSTEMTIME structure.
    if (!WinHttpTimeToSystemTime( pwszTimeStr, &sTime))
    {
        printf( "Error %u in WinHttpTimeToSystemTime.\n", GetLastError());
    }
    else
    {
        // Print the date.
        printf( "The U.S. formatted date is (%u/%u/%u)\n",
                sTime.wMonth, sTime.wDay, sTime.wYear);
    }



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [time-from-system-time](#time-from-system-time)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpTimeToSystemTime](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384118.aspx)

### Function: <a name="time-to-universal-time"><em>time-to-universal-time</em></a> <i>`TIME`</i>

TODO

__See Also:__

  * TODO

### Function: <a name="write-data"><em>write-data</em></a> <i>`REQUEST` `DATA`</i>

```
WinHttpWriteData function

The WinHttpWriteData function writes request data to an HTTP server.

Syntax

BOOL WINAPI WinHttpWriteData(
  __in   HINTERNET hRequest,
  __in   LPCVOID lpBuffer,
  __in   DWORD dwNumberOfBytesToWrite,
  __out  LPDWORD lpdwNumberOfBytesWritten
);

Parameters

hRequest [in]

    Valid HINTERNET handle returned by WinHttpSendRequest. Wait until WinHttpSendRequest has completed for this handle
    before calling WinHttpWriteData.

lpBuffer [in]

    Pointer to a buffer that contains the data to send to the server. Be sure that this buffer remains valid until
    WinHttpWriteData completes.

dwNumberOfBytesToWrite [in]

    Unsigned long integer value that contains the number of bytes to write to the file.

lpdwNumberOfBytesWritten [out]

    Pointer to an unsigned long integer variable that receives the number of bytes written to the buffer. The
    WinHttpWriteData function sets this value to zero before doing any work or error checking. When using WinHTTP
    asynchronously, always set this parameter to NULL and retrieve the information in the callback function; not doing
    so can cause a memory fault.

Return value

Returns TRUE if successful, or FALSE otherwise. For extended error information, call GetLastError. Among the error
codes returned are:

               Error Code                                                 Description
                                         The connection with the server has been reset or terminated, or an
ERROR_WINHTTP_CONNECTION_ERROR           incompatible SSL protocol was encountered. For example, WinHTTP version 5.1
                                         does not support SSL2 unless the client specifically enables it.

ERROR_WINHTTP_INCORRECT_HANDLE_STATE     The requested operation cannot be carried out because the handle supplied is
                                         not in the correct state.

ERROR_WINHTTP_INCORRECT_HANDLE_TYPE      The type of handle supplied is incorrect for this operation.

ERROR_WINHTTP_INTERNAL_ERROR             An internal error has occurred.

ERROR_WINHTTP_OPERATION_CANCELLED        The operation was canceled, usually because the handle on which the request
                                         was operating was closed before the operation completed.

ERROR_WINHTTP_TIMEOUT                    The request has timed out.

ERROR_NOT_ENOUGH_MEMORY                  Not enough memory was available to complete the requested operation. (Windows
                                         error code)



Remarks

Even when WinHTTP is used in asynchronous mode (that is, when WINHTTP_FLAG_ASYNC has been set in WinHttpOpen), this
function can operate either synchronously or asynchronously. If this function returns FALSE, this function failed and
you can call GetLastError to get extended error information. If this function returns TRUE, use the
WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE completion to determine whether this function was successful and the value of
the parameters. The WINHTTP_CALLBACK_STATUS_REQUEST_ERROR completion indicates that the operation completed
asynchronously, but failed.

Warning  When using WinHTTP asynchronously, always set the lpdwNumberOfBytesWritten parameter to NULL and retrieve the
bytes written in the callback function; otherwise, a memory fault can occur.

When the application is sending data, it can call WinHttpReceiveResponse to end the data transfer. If
WinHttpCloseHandle is called, then the data transfer is aborted.

If a status callback function has been installed with WinHttpSetStatusCallback, then those of the following
notifications that have been set in the dwNotificationFlags parameter of WinHttpSetStatusCallback indicate progress in
sending data to the server:

 ｡ｦ WINHTTP_CALLBACK_STATUS_RECEIVING_RESPONSE
 ｡ｦ WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED
 ｡ｦ WINHTTP_CALLBACK_STATUS_DATA_WRITTEN
 ｡ｦ WINHTTP_CALLBACK_STATUS_SENDING_REQUEST
 ｡ｦ WINHTTP_CALLBACK_STATUS_REQUEST_SENT
 ｡ｦ WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE

Two issues can arise when attempting to POST (or PUT) data to proxies or servers that challenge using NTLM or Negotiate
authentication. First, these proxies or servers may send 401/407 challenges and close the connection before all the
data can be POST'ed, in which case not only does WinHttpWriteData fail, but also WinHTTP cannot handle the
authentication challenges. NTLM and Negotiate require that all authentication handshakes be exchanged on the same
socket connection, so authentication fails if the connection is broken prematurely.

Secondly, NTLM and Negotiate may require multiple handshakes to complete authentication, which requires data to be
re-POST'ed for each of these authentication "legs". This can be very inefficient for large data uploads.

To work around these two issues, one solution is to send an Idempotent "warm-up" request such as HEAD to the
authenticating v-dir first, handle the authentication challenges associated with this request, and only then POST data.
As long as the same socket is re-used to handle the POST'ing, no further authentication challenges should be
encountered and all data can be uploaded at once. Since an authenticated socket can only be re-used for subsequent
requests within the same session, the POST should go out in the same socket as long as the socket is not pooled with
concurrent requests competing for it.

Note  For Windows XP and Windows 2000, see the Run-Time Requirements section of the WinHttp start page.

Examples

This example shows code that writes data to an HTTP server. The server name supplied in the example,
www.wingtiptoys.com, is fictitious and must be replaced with the name of a server for which you have write access.


    LPSTR pszData = "WinHttpWriteData Example";
    DWORD dwBytesWritten = 0;
    BOOL  bResults = FALSE;
    HINTERNET hSession = NULL,
              hConnect = NULL,
              hRequest = NULL;

    // Use WinHttpOpen to obtain a session handle.
    hSession = WinHttpOpen(  L"A WinHTTP Example Program/1.0",
                             WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                             WINHTTP_NO_PROXY_NAME,
                             WINHTTP_NO_PROXY_BYPASS, 0);

    // Specify an HTTP server.
    if (hSession)
        hConnect = WinHttpConnect( hSession, L"www.wingtiptoys.com",
                                   INTERNET_DEFAULT_HTTP_PORT, 0);

    // Create an HTTP Request handle.
    if (hConnect)
        hRequest = WinHttpOpenRequest( hConnect, L"PUT",
                                       L"/writetst.txt",
                                       NULL, WINHTTP_NO_REFERER,
                                       WINHTTP_DEFAULT_ACCEPT_TYPES,
                                       0);

    // Send a Request.
    if (hRequest)
        bResults = WinHttpSendRequest( hRequest,
                                       WINHTTP_NO_ADDITIONAL_HEADERS,
                                       0, WINHTTP_NO_REQUEST_DATA, 0,
                                       (DWORD)strlen(pszData), 0);

    // Write data to the server.
    if (bResults)
        bResults = WinHttpWriteData( hRequest, pszData,
                                     (DWORD)strlen(pszData),
                                     &dwBytesWritten);

    // End the request.
    if (bResults)
        bResults = WinHttpReceiveResponse( hRequest, NULL);

    // Report any errors.
    if (!bResults)
        printf("Error %d has occurred.\n",GetLastError());


    // Close any open handles.
    if (hRequest) WinHttpCloseHandle(hRequest);
    if (hConnect) WinHttpCloseHandle(hConnect);
    if (hSession) WinHttpCloseHandle(hSession);



Requirements

Minimum supported client Windows XP, Windows 2000 Professional with SP3

Minimum supported server Windows Server 2003, Windows 2000 Server with SP3

    Redistributable      WinHTTP 5.0 and Internet Explorer 5.01 or later on Windows XP and Windows 2000.

         Header          Winhttp.h

        Library          Winhttp.lib

          DLL            Winhttp.dll

```

__See Also:__

  * [About Microsoft Windows HTTP Services (WinHTTP)](http://msdn.microsoft.com/en-us/library/windows/desktop/aa382925.aspx)
  * [open](#open)
  * [open-request](#open-request)
  * [connect](#connect)
  * [WinHTTP Versions](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384276.aspx)
  * [WinHttpWriteData](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384120.aspx)

### Function: <a name="xl-winhttp-version"><em>xl-winhttp-version</em></a>

TODO

__See Also:__

  * TODO


----

## <a name="accessors">ACCESSORS</a>

### Accessor: <a name="connection-async-p"><em>connection-async-p</em></a> <i>`X`</i>

[connection](#connection) 構造体の `async-p` スロットを取得します。

__See Also:__

  * [connection](#connection)

### Accessor: <a name="connection-callback"><em>connection-callback</em></a> <i>`X`</i>

[connection](#connection) 構造体の `callback` スロットを取得・設定します。

__See Also:__

  * [connection](#connection)

### Accessor: <a name="connection-closed-p"><em>connection-closed-p</em></a> <i>`X`</i>

[connection](#connection) 構造体の `closed-p` スロットを取得・設定します。

__See Also:__

  * [connection](#connection)

### Accessor: <a name="connection-context"><em>connection-context</em></a> <i>`X`</i>

[connection](#connection) 構造体の `context` スロットを取得・設定します。

__See Also:__

  * [connection](#connection)

### Accessor: <a name="connection-created-on"><em>connection-created-on</em></a> <i>`X`</i>

[connection](#connection) 構造体の `created-on` スロットを取得します。

__See Also:__

  * [connection](#connection)

### Accessor: <a name="connection-description"><em>connection-description</em></a> <i>`X`</i>

[connection](#connection) 構造体の `description` スロットを取得します。

__See Also:__

  * [connection](#connection)

### Accessor: <a name="connection-handle"><em>connection-handle</em></a> <i>`X`</i>

[connection](#connection) 構造体の `handle` スロットを取得します。

__See Also:__

  * [connection](#connection)

### Accessor: <a name="connection-p"><em>connection-p</em></a> <i>`X`</i>

`X` が [connection](#connection) 構造体のインスタンスなら t を返します。

__See Also:__

  * [connection](#connection)

### Accessor: <a name="connection-parent"><em>connection-parent</em></a> <i>`X`</i>

[connection](#connection) 構造体の `parent` スロットを取得します。

__See Also:__

  * [connection](#connection)

### Accessor: <a name="hinternet-async-p"><em>hinternet-async-p</em></a> <i>`X`</i>

[hinternet](#hinternet) 構造体の `async-p` スロットを取得します。

__See Also:__

  * [hinternet](#hinternet)

### Accessor: <a name="hinternet-callback"><em>hinternet-callback</em></a> <i>`X`</i>

[hinternet](#hinternet) 構造体の `callback` スロットを取得・設定します。

__See Also:__

  * [hinternet](#hinternet)

### Accessor: <a name="hinternet-closed-p"><em>hinternet-closed-p</em></a> <i>`X`</i>

[hinternet](#hinternet) 構造体の `closed-p` スロットを取得・設定します。

__See Also:__

  * [hinternet](#hinternet)

### Accessor: <a name="hinternet-context"><em>hinternet-context</em></a> <i>`X`</i>

[hinternet](#hinternet) 構造体の `context` スロットを取得・設定します。

__See Also:__

  * [hinternet](#hinternet)

### Accessor: <a name="hinternet-created-on"><em>hinternet-created-on</em></a> <i>`X`</i>

[hinternet](#hinternet) 構造体の `created-on` スロットを取得します。

__See Also:__

  * [hinternet](#hinternet)

### Accessor: <a name="hinternet-description"><em>hinternet-description</em></a> <i>`X`</i>

[hinternet](#hinternet) 構造体の `description` スロットを取得します。

__See Also:__

  * [hinternet](#hinternet)

### Accessor: <a name="hinternet-handle"><em>hinternet-handle</em></a> <i>`X`</i>

[hinternet](#hinternet) 構造体の `handle` スロットを取得します。

__See Also:__

  * [hinternet](#hinternet)

### Accessor: <a name="hinternet-p"><em>hinternet-p</em></a> <i>`X`</i>

`X` が [hinternet](#hinternet) 構造体のインスタンスなら t を返します。

__See Also:__

  * [hinternet](#hinternet)

### Accessor: <a name="hinternet-parent"><em>hinternet-parent</em></a> <i>`X`</i>

[hinternet](#hinternet) 構造体の `parent` スロットを取得します。

__See Also:__

  * [hinternet](#hinternet)

### Accessor: <a name="request-async-p"><em>request-async-p</em></a> <i>`X`</i>

[request](#request) 構造体の `async-p` スロットを取得します。

__See Also:__

  * [request](#request)

### Accessor: <a name="request-callback"><em>request-callback</em></a> <i>`X`</i>

[request](#request) 構造体の `callback` スロットを取得・設定します。

__See Also:__

  * [request](#request)

### Accessor: <a name="request-closed-p"><em>request-closed-p</em></a> <i>`X`</i>

[request](#request) 構造体の `closed-p` スロットを取得・設定します。

__See Also:__

  * [request](#request)

### Accessor: <a name="request-context"><em>request-context</em></a> <i>`X`</i>

[request](#request) 構造体の `context` スロットを取得・設定します。

__See Also:__

  * [request](#request)

### Accessor: <a name="request-created-on"><em>request-created-on</em></a> <i>`X`</i>

[request](#request) 構造体の `created-on` スロットを取得します。

__See Also:__

  * [request](#request)

### Accessor: <a name="request-description"><em>request-description</em></a> <i>`X`</i>

[request](#request) 構造体の `description` スロットを取得します。

__See Also:__

  * [request](#request)

### Accessor: <a name="request-handle"><em>request-handle</em></a> <i>`X`</i>

[request](#request) 構造体の `handle` スロットを取得します。

__See Also:__

  * [request](#request)

### Accessor: <a name="request-p"><em>request-p</em></a> <i>`X`</i>

`X` が [request](#request) 構造体のインスタンスなら t を返します。

__See Also:__

  * [request](#request)

### Accessor: <a name="request-parent"><em>request-parent</em></a> <i>`X`</i>

[request](#request) 構造体の `parent` スロットを取得します。

__See Also:__

  * [request](#request)

### Accessor: <a name="request-read-buffer"><em>request-read-buffer</em></a> <i>`X`</i>

[request](#request) 構造体の `read-buffer` スロットを取得・設定します。

__See Also:__

  * [request](#request)

### Accessor: <a name="request-secure-p"><em>request-secure-p</em></a> <i>`X`</i>

[request](#request) 構造体の `secure-p` スロットを取得します。

__See Also:__

  * [request](#request)

### Accessor: <a name="request-send-buffer"><em>request-send-buffer</em></a> <i>`X`</i>

[request](#request) 構造体の `send-buffer` スロットを取得・設定します。

__See Also:__

  * [request](#request)

### Accessor: <a name="session-async-p"><em>session-async-p</em></a> <i>`X`</i>

[session](#session) 構造体の `async-p` スロットを取得します。

__See Also:__

  * [session](#session)

### Accessor: <a name="session-callback"><em>session-callback</em></a> <i>`X`</i>

[session](#session) 構造体の `callback` スロットを取得・設定します。

__See Also:__

  * [session](#session)

### Accessor: <a name="session-closed-p"><em>session-closed-p</em></a> <i>`X`</i>

[session](#session) 構造体の `closed-p` スロットを取得・設定します。

__See Also:__

  * [session](#session)

### Accessor: <a name="session-context"><em>session-context</em></a> <i>`X`</i>

[session](#session) 構造体の `context` スロットを取得・設定します。

__See Also:__

  * [session](#session)

### Accessor: <a name="session-created-on"><em>session-created-on</em></a> <i>`X`</i>

[session](#session) 構造体の `created-on` スロットを取得します。

__See Also:__

  * [session](#session)

### Accessor: <a name="session-description"><em>session-description</em></a> <i>`X`</i>

[session](#session) 構造体の `description` スロットを取得します。

__See Also:__

  * [session](#session)

### Accessor: <a name="session-handle"><em>session-handle</em></a> <i>`X`</i>

[session](#session) 構造体の `handle` スロットを取得します。

__See Also:__

  * [session](#session)

### Accessor: <a name="session-p"><em>session-p</em></a> <i>`X`</i>

`X` が [session](#session) 構造体のインスタンスなら t を返します。

__See Also:__

  * [session](#session)

### Accessor: <a name="session-parent"><em>session-parent</em></a> <i>`X`</i>

[session](#session) 構造体の `parent` スロットを取得します。

__See Also:__

  * [session](#session)

### Accessor: <a name="winhttp-condition-api"><em>winhttp-condition-api</em></a> <i>`X`</i>

[winhttp-condition](#winhttp-condition) 構造体の `api` スロットを取得・設定します。

__See Also:__

  * [winhttp-condition](#winhttp-condition)

### Accessor: <a name="winhttp-condition-error-code"><em>winhttp-condition-error-code</em></a> <i>`X`</i>

[winhttp-condition](#winhttp-condition) 構造体の `error-code` スロットを取得・設定します。

__See Also:__

  * [winhttp-condition](#winhttp-condition)

### Accessor: <a name="winhttp-condition-error-keyword"><em>winhttp-condition-error-keyword</em></a> <i>`X`</i>

[winhttp-condition](#winhttp-condition) 構造体の `error-keyword` スロットを取得・設定します。

__See Also:__

  * [winhttp-condition](#winhttp-condition)

### Accessor: <a name="winhttp-condition-error-name"><em>winhttp-condition-error-name</em></a> <i>`X`</i>

[winhttp-condition](#winhttp-condition) 構造体の `error-name` スロットを取得・設定します。

__See Also:__

  * [winhttp-condition](#winhttp-condition)

