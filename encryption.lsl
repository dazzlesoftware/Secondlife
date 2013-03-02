//************************************************// 
//* Masa's XTEA encryption/decryption v3         *// 
//* Modified by SleightOf Hand for Stability and *// 
//* intercommunication with PHP version          *// 
//************************************************// 
// NOTE: This version only encodes 60 bits per 64-bit block! 
// This code is public domain. 
// Sleight was here 20070522 
// masa was here 20070315 
// so was strife 20070315 
// so was adz 20070812
//
// This was Modified by SleightOf Hand to allow
// Strong encryption between LSL and PHP. 
//************************************************// 
//* XTEA IMPLEMENTATION                          *// 
//************************************************// 
 
integer XTEA_DELTA      = 0x9E3779B9; // (sqrt(5) - 1) * 2^31 
integer xtea_num_rounds = 6; 
list    xtea_key        = [0, 0, 0, 0]; 
 
 
// Converts any string to a 32 char MD5 string and then to a list of
// 4 * 32 bit integers = 128 bit Key. MD5 ensures always a specific
// 128 bit key is generated for any string passed.
list xtea_key_from_string( string str )
{ 
    str = llMD5String(str,0); // Use Nonce = 0
    return [    hexdec(llGetSubString(  str,  0,  7)), 
                hexdec(llGetSubString(  str,  8,  15)), 
                hexdec(llGetSubString(  str,  16,  23)), 
                hexdec(llGetSubString(  str,  24,  31))]; 
} 
 
// Encipher two integers and return the result as a 12-byte string 
// containing two base64-encoded integers. 
string xtea_encipher( integer v0, integer v1 )
{ 
    integer num_rounds = xtea_num_rounds; 
    integer sum = 0; 
    do { 
        // LSL does not have unsigned integers, so when shifting right we 
        // have to mask out sign-extension bits. 
        v0  += (((v1 << 4) ^ ((v1 >> 5) & 0x07FFFFFF)) + v1) ^ (sum + llList2Integer(xtea_key, sum & 3));
        sum +=  XTEA_DELTA;
        v1  += (((v0 << 4) ^ ((v0 >> 5) & 0x07FFFFFF)) + v0) ^ (sum + llList2Integer(xtea_key, (sum >> 11) & 3)); 
 
    } while( --num_rounds ); 
    //return only first 6 chars to remove "=="'s and compact encrypted text.
    return llGetSubString(llIntegerToBase64(v0),0,5) +
           llGetSubString(llIntegerToBase64(v1),0,5); 
} 
 
// Decipher two base64-encoded integers and return the FIRST 30 BITS of 
// each as one 10-byte base64-encoded string. 
string xtea_decipher( integer v0, integer v1 )
{ 
    integer num_rounds = xtea_num_rounds; 
    integer sum = XTEA_DELTA*xtea_num_rounds; 
    do { 
        // LSL does not have unsigned integers, so when shifting right we 
        // have to mask out sign-extension bits. 
        v1  -= (((v0 << 4) ^ ((v0 >> 5) & 0x07FFFFFF)) + v0) ^ (sum + llList2Integer(xtea_key, (sum>>11) & 3)); 
        sum -= XTEA_DELTA;
        v0  -= (((v1 << 4) ^ ((v1 >> 5) & 0x07FFFFFF)) + v1) ^ (sum + llList2Integer(xtea_key, sum  & 3)); 
    } while ( --num_rounds ); 
 
    return llGetSubString(llIntegerToBase64(v0), 0, 4) + 
           llGetSubString(llIntegerToBase64(v1), 0, 4); 
} 
 
// Encrypt a full string using XTEA. 
string xtea_encrypt_string( string str )
{ 
    // encode string 
    str = llStringToBase64(str); 
    // remove trailing =s so we can do our own 0 padding 
    integer i = llSubStringIndex( str, "=" ); 
    if ( i != -1 ) 
        str = llDeleteSubString( str, i, -1 ); 
 
    // we don't want to process padding, so get length before adding it 
    integer len = llStringLength(str); 
 
    // zero pad 
    str += "AAAAAAAAAA="; 
 
    string result; 
    i = 0; 
 
    do { 
        // encipher 30 (5*6) bits at a time. 
        result += xtea_encipher( 
            llBase64ToInteger(llGetSubString(str,   i, i += 4) + "A="), 
            llBase64ToInteger(llGetSubString(str, ++i, i += 4) + "A=") 
        ); 
    } while ( ++i < len ); 
 
    return result; 
} 
 
// Decrypt a full string using XTEA 
string xtea_decrypt_string( string str ) { 
    integer len = llStringLength(str); 
    integer i; 
    string result; 
    do { 
        result += xtea_decipher( 
            llBase64ToInteger(llGetSubString(str,   i, i += 5) + "=="), 
            llBase64ToInteger(llGetSubString(str, ++i, i += 5) + "==") 
        ); 
    } while ( ++i < len ); 
 
    // Replace multiple trailing zeroes with a single one 
    i = llStringLength(result) - 1; 
    while ( llGetSubString(result, --i, i+1) == "AA" ) 
        result = llDeleteSubString(result, i+1, i+1); 
    return llBase64ToString( result + "====" ); 
} 
 
key requestid; // just to check if we're getting the result we've asked for; all scripts in the same object get the same replies
string base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + 
 
                          "abcdefghijklmnopqrstuvwxyz" + 
 
                          "0123456789+/";
string url = "http://<enter your URL here>/test-script.php";
 
 
 
default
{
    touch_start(integer number)
    {
        string tosend = "this is a message to send";
        llWhisper(0, "Message to Send = " + tosend);
        xtea_key = xtea_key_from_string("this is a test key");
        string message = xtea_encrypt_string(tosend);
        llWhisper(0, "Message to Server = " + message);
        requestid = llHTTPRequest(url, 
            [HTTP_METHOD, "POST",
             HTTP_MIMETYPE, "application/x-www-form-urlencoded"],
            "parameter1=" + llEscapeURL(message));
    }
 
    http_response(key request_id, integer status, list metadata, string body)
    {
        if (request_id == requestid) { 
            llWhisper(0, "Web server sent: " + body);
            integer clean = 0;
            string cleanbody = "";
            while(~llSubStringIndex(base64,llGetSubString(body,clean,clean))){
                cleanbody += llGetSubString(body,clean,clean++);
            }
            llWhisper(0, "Cleaned : " + cleanbody);
            llWhisper(0, "Web server said: " + xtea_decrypt_string( cleanbody ));
        }
    }
}