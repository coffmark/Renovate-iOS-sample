//
// Copyright 2010-2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSS3Resources.h"
#import <AWSCore/AWSCocoaLumberjack.h>

@interface AWSS3Resources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSS3Resources

+ (instancetype)sharedInstance {
    static AWSS3Resources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSS3Resources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSDDLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2006-03-01\",\
    \"checksumFormat\":\"md5\",\
    \"endpointPrefix\":\"s3\",\
    \"globalEndpoint\":\"s3.amazonaws.com\",\
    \"protocol\":\"rest-xml\",\
    \"serviceAbbreviation\":\"Amazon S3\",\
    \"serviceFullName\":\"Amazon Simple Storage Service\",\
    \"serviceId\":\"S3\",\
    \"signatureVersion\":\"s3\",\
    \"uid\":\"s3-2006-03-01\"\
  },\
  \"operations\":{\
    \"AbortMultipartUpload\":{\
      \"name\":\"AbortMultipartUpload\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}/{Key+}\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"AbortMultipartUploadRequest\"},\
      \"output\":{\"shape\":\"AbortMultipartUploadOutput\"},\
      \"errors\":[\
        {\"shape\":\"NoSuchUpload\"}\
      ],\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadAbort.html\",\
      \"documentation\":\"<p>This operation aborts a multipart upload. After a multipart upload is aborted, no additional parts can be uploaded using that upload ID. The storage consumed by any previously uploaded parts will be freed. However, if any part uploads are currently in progress, those part uploads might or might not succeed. As a result, it might be necessary to abort a given multipart upload multiple times in order to completely free all storage consumed by all parts. </p> <p>To verify that all parts have been removed, so you don't get charged for the part storage, you should call the <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListParts.html\\\">ListParts</a> operation and ensure that the parts list is empty.</p> <p>For information about permissions required to use the multipart upload API, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html\\\">Multipart Upload API and Permissions</a>.</p> <p>The following operations are related to <code>AbortMultipartUpload</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html\\\">CreateMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html\\\">UploadPart</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CompleteMultipartUpload.html\\\">CompleteMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListParts.html\\\">ListParts</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListMultipartUploads.html\\\">ListMultipartUploads</a> </p> </li> </ul>\"\
    },\
    \"CompleteMultipartUpload\":{\
      \"name\":\"CompleteMultipartUpload\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/{Bucket}/{Key+}\"\
      },\
      \"input\":{\"shape\":\"CompleteMultipartUploadRequest\"},\
      \"output\":{\"shape\":\"CompleteMultipartUploadOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadComplete.html\",\
      \"documentation\":\"<p>Completes a multipart upload by assembling previously uploaded parts.</p> <p>You first initiate the multipart upload and then upload all parts using the <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html\\\">UploadPart</a> operation. After successfully uploading all relevant parts of an upload, you call this operation to complete the upload. Upon receiving this request, Amazon S3 concatenates all the parts in ascending order by part number to create a new object. In the Complete Multipart Upload request, you must provide the parts list. You must ensure that the parts list is complete. This operation concatenates the parts that you provide in the list. For each part in the list, you must provide the part number and the <code>ETag</code> value, returned after that part was uploaded.</p> <p>Processing of a Complete Multipart Upload request could take several minutes to complete. After Amazon S3 begins processing the request, it sends an HTTP response header that specifies a 200 OK response. While processing is in progress, Amazon S3 periodically sends white space characters to keep the connection from timing out. Because a request could fail after the initial 200 OK response has been sent, it is important that you check the response body to determine whether the request succeeded.</p> <p>Note that if <code>CompleteMultipartUpload</code> fails, applications should be prepared to retry the failed requests. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ErrorBestPractices.html\\\">Amazon S3 Error Best Practices</a>.</p> <p>For more information about multipart uploads, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/uploadobjusingmpu.html\\\">Uploading Objects Using Multipart Upload</a>.</p> <p>For information about permissions required to use the multipart upload API, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html\\\">Multipart Upload API and Permissions</a>.</p> <p> <code>CompleteMultipartUpload</code> has the following special errors:</p> <ul> <li> <p>Error code: <code>EntityTooSmall</code> </p> <ul> <li> <p>Description: Your proposed upload is smaller than the minimum allowed object size. Each part must be at least 5 MB in size, except the last part.</p> </li> <li> <p>400 Bad Request</p> </li> </ul> </li> <li> <p>Error code: <code>InvalidPart</code> </p> <ul> <li> <p>Description: One or more of the specified parts could not be found. The part might not have been uploaded, or the specified entity tag might not have matched the part's entity tag.</p> </li> <li> <p>400 Bad Request</p> </li> </ul> </li> <li> <p>Error code: <code>InvalidPartOrder</code> </p> <ul> <li> <p>Description: The list of parts was not in ascending order. The parts list must be specified in order by part number.</p> </li> <li> <p>400 Bad Request</p> </li> </ul> </li> <li> <p>Error code: <code>NoSuchUpload</code> </p> <ul> <li> <p>Description: The specified multipart upload does not exist. The upload ID might be invalid, or the multipart upload might have been aborted or completed.</p> </li> <li> <p>404 Not Found</p> </li> </ul> </li> </ul> <p>The following operations are related to <code>CompleteMultipartUpload</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html\\\">CreateMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html\\\">UploadPart</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_AbortMultipartUpload.html\\\">AbortMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListParts.html\\\">ListParts</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListMultipartUploads.html\\\">ListMultipartUploads</a> </p> </li> </ul>\"\
    },\
    \"CopyObject\":{\
      \"name\":\"CopyObject\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}/{Key+}\"\
      },\
      \"input\":{\"shape\":\"CopyObjectRequest\"},\
      \"output\":{\"shape\":\"CopyObjectOutput\"},\
      \"errors\":[\
        {\"shape\":\"ObjectNotInActiveTierError\"}\
      ],\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectCOPY.html\",\
      \"documentation\":\"<p>Creates a copy of an object that is already stored in Amazon S3.</p> <note> <p>You can store individual objects of up to 5 TB in Amazon S3. You create a copy of your object up to 5 GB in size in a single atomic operation using this API. However, to copy an object greater than 5 GB, you must use the multipart upload Upload Part - Copy API. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/CopyingObjctsUsingRESTMPUapi.html\\\">Copy Object Using the REST Multipart Upload API</a>.</p> </note> <p>All copy requests must be authenticated. Additionally, you must have <i>read</i> access to the source object and <i>write</i> access to the destination bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html\\\">REST Authentication</a>. Both the Region that you want to copy the object from and the Region that you want to copy the object to must be enabled for your account.</p> <p>A copy request might return an error when Amazon S3 receives the copy request or while Amazon S3 is copying the files. If the error occurs before the copy operation starts, you receive a standard Amazon S3 error. If the error occurs during the copy operation, the error response is embedded in the <code>200 OK</code> response. This means that a <code>200 OK</code> response can contain either a success or an error. Design your application to parse the contents of the response and handle it appropriately.</p> <p>If the copy is successful, you receive a response with information about the copied object.</p> <note> <p>If the request is an HTTP 1.1 request, the response is chunk encoded. If it were not, it would not contain the content-length, and you would need to read the entire body.</p> </note> <p>The copy request charge is based on the storage class and Region that you specify for the destination object. For pricing information, see <a href=\\\"https://aws.amazon.com/s3/pricing/\\\">Amazon S3 pricing</a>.</p> <important> <p>Amazon S3 transfer acceleration does not support cross-Region copies. If you request a cross-Region copy using a transfer acceleration endpoint, you get a 400 <code>Bad Request</code> error. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html\\\">Transfer Acceleration</a>.</p> </important> <p> <b>Metadata</b> </p> <p>When copying an object, you can preserve all metadata (default) or specify new metadata. However, the ACL is not preserved and is set to private for the user making the request. To override the default ACL setting, specify a new ACL when generating a copy request. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html\\\">Using ACLs</a>. </p> <p>To specify whether you want the object metadata copied from the source object or replaced with metadata provided in the request, you can optionally add the <code>x-amz-metadata-directive</code> header. When you grant permissions, you can use the <code>s3:x-amz-metadata-directive</code> condition key to enforce certain metadata behavior when objects are uploaded. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/amazon-s3-policy-keys.html\\\">Specifying Conditions in a Policy</a> in the <i>Amazon S3 Developer Guide</i>. For a complete list of Amazon S3-specific condition keys, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/list_amazons3.html\\\">Actions, Resources, and Condition Keys for Amazon S3</a>.</p> <p> <b> <code>x-amz-copy-source-if</code> Headers</b> </p> <p>To only copy an object under certain conditions, such as whether the <code>Etag</code> matches or whether the object was modified before or after a specified date, use the following request parameters:</p> <ul> <li> <p> <code>x-amz-copy-source-if-match</code> </p> </li> <li> <p> <code>x-amz-copy-source-if-none-match</code> </p> </li> <li> <p> <code>x-amz-copy-source-if-unmodified-since</code> </p> </li> <li> <p> <code>x-amz-copy-source-if-modified-since</code> </p> </li> </ul> <p> If both the <code>x-amz-copy-source-if-match</code> and <code>x-amz-copy-source-if-unmodified-since</code> headers are present in the request and evaluate as follows, Amazon S3 returns <code>200 OK</code> and copies the data:</p> <ul> <li> <p> <code>x-amz-copy-source-if-match</code> condition evaluates to true</p> </li> <li> <p> <code>x-amz-copy-source-if-unmodified-since</code> condition evaluates to false</p> </li> </ul> <p>If both the <code>x-amz-copy-source-if-none-match</code> and <code>x-amz-copy-source-if-modified-since</code> headers are present in the request and evaluate as follows, Amazon S3 returns the <code>412 Precondition Failed</code> response code:</p> <ul> <li> <p> <code>x-amz-copy-source-if-none-match</code> condition evaluates to false</p> </li> <li> <p> <code>x-amz-copy-source-if-modified-since</code> condition evaluates to true</p> </li> </ul> <note> <p>All headers with the <code>x-amz-</code> prefix, including <code>x-amz-copy-source</code>, must be signed.</p> </note> <p> <b>Encryption</b> </p> <p>The source object that you are copying can be encrypted or unencrypted. The source object can be encrypted with server-side encryption using AWS managed encryption keys (SSE-S3 or SSE-KMS) or by using a customer-provided encryption key. With server-side encryption, Amazon S3 encrypts your data as it writes it to disks in its data centers and decrypts the data when you access it. </p> <p>You can optionally use the appropriate encryption-related headers to request server-side encryption for the target object. You have the option to provide your own encryption key or use SSE-S3 or SSE-KMS, regardless of the form of server-side encryption that was used to encrypt the source object. You can even request encryption if the source object was not encrypted. For more information about server-side encryption, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html\\\">Using Server-Side Encryption</a>.</p> <p> <b>Access Control List (ACL)-Specific Request Headers</b> </p> <p>When copying an object, you can optionally use headers to grant ACL-based permissions. By default, all objects are private. Only the owner has full access control. When adding a new object, you can grant permissions to individual AWS accounts or to predefined groups defined by Amazon S3. These permissions are then added to the ACL on the object. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\\\">Access Control List (ACL) Overview</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-using-rest-api.html\\\">Managing ACLs Using the REST API</a>. </p> <p> <b>Storage Class Options</b> </p> <p>You can use the <code>CopyObject</code> operation to change the storage class of an object that is already stored in Amazon S3 using the <code>StorageClass</code> parameter. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html\\\">Storage Classes</a> in the <i>Amazon S3 Service Developer Guide</i>.</p> <p> <b>Versioning</b> </p> <p>By default, <code>x-amz-copy-source</code> identifies the current version of an object to copy. If the current version is a delete marker, Amazon S3 behaves as if the object was deleted. To copy a different version, use the <code>versionId</code> subresource.</p> <p>If you enable versioning on the target bucket, Amazon S3 generates a unique version ID for the object being copied. This version ID is different from the version ID of the source object. Amazon S3 returns the version ID of the copied object in the <code>x-amz-version-id</code> response header in the response.</p> <p>If you do not enable versioning or suspend it on the target bucket, the version ID that Amazon S3 generates is always null.</p> <p>If the source object's storage class is GLACIER, you must restore a copy of this object before you can use it as a source object for the copy operation. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_RestoreObject.html\\\">RestoreObject</a>.</p> <p>The following operations are related to <code>CopyObject</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html\\\">PutObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a> </p> </li> </ul> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/CopyingObjectsExamples.html\\\">Copying Objects</a>.</p>\",\
      \"alias\":\"PutObjectCopy\"\
    },\
    \"CreateBucket\":{\
      \"name\":\"CreateBucket\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}\"\
      },\
      \"input\":{\"shape\":\"CreateBucketRequest\"},\
      \"output\":{\"shape\":\"CreateBucketOutput\"},\
      \"errors\":[\
        {\"shape\":\"BucketAlreadyExists\"},\
        {\"shape\":\"BucketAlreadyOwnedByYou\"}\
      ],\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUT.html\",\
      \"documentation\":\"<p>Creates a new S3 bucket. To create a bucket, you must register with Amazon S3 and have a valid AWS Access Key ID to authenticate requests. Anonymous requests are never allowed to create buckets. By creating the bucket, you become the bucket owner.</p> <p>Not every string is an acceptable bucket name. For information about bucket naming restrictions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html\\\">Working with Amazon S3 buckets</a>. </p> <p>If you want to create an Amazon S3 on Outposts bucket, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateBucket.html\\\">Create Bucket</a>. </p> <p>By default, the bucket is created in the US East (N. Virginia) Region. You can optionally specify a Region in the request body. You might choose a Region to optimize latency, minimize costs, or address regulatory requirements. For example, if you reside in Europe, you will probably find it advantageous to create buckets in the Europe (Ireland) Region. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html#access-bucket-intro\\\">Accessing a bucket</a>.</p> <note> <p>If you send your create bucket request to the <code>s3.amazonaws.com</code> endpoint, the request goes to the us-east-1 Region. Accordingly, the signature calculations in Signature Version 4 must use us-east-1 as the Region, even if the location constraint in the request specifies another Region where the bucket is to be created. If you create a bucket in a Region other than US East (N. Virginia), your application must be able to handle 307 redirect. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/VirtualHosting.html\\\">Virtual hosting of buckets</a>.</p> </note> <p>When creating a bucket using this operation, you can optionally specify the accounts or groups that should be granted specific permissions on the bucket. There are two ways to grant the appropriate permissions using the request headers.</p> <ul> <li> <p>Specify a canned ACL using the <code>x-amz-acl</code> request header. Amazon S3 supports a set of predefined ACLs, known as <i>canned ACLs</i>. Each canned ACL has a predefined set of grantees and permissions. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\\\">Canned ACL</a>.</p> </li> <li> <p>Specify access permissions explicitly using the <code>x-amz-grant-read</code>, <code>x-amz-grant-write</code>, <code>x-amz-grant-read-acp</code>, <code>x-amz-grant-write-acp</code>, and <code>x-amz-grant-full-control</code> headers. These headers map to the set of permissions Amazon S3 supports in an ACL. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\\\">Access control list (ACL) overview</a>.</p> <p>You specify each grantee as a type=value pair, where the type is one of the following:</p> <ul> <li> <p> <code>id</code> â if the value specified is the canonical user ID of an AWS account</p> </li> <li> <p> <code>uri</code> â if you are granting permissions to a predefined group</p> </li> <li> <p> <code>emailAddress</code> â if the value specified is the email address of an AWS account</p> <note> <p>Using email addresses to specify a grantee is only supported in the following AWS Regions: </p> <ul> <li> <p>US East (N. Virginia)</p> </li> <li> <p>US West (N. California)</p> </li> <li> <p> US West (Oregon)</p> </li> <li> <p> Asia Pacific (Singapore)</p> </li> <li> <p>Asia Pacific (Sydney)</p> </li> <li> <p>Asia Pacific (Tokyo)</p> </li> <li> <p>Europe (Ireland)</p> </li> <li> <p>South America (SÃ£o Paulo)</p> </li> </ul> <p>For a list of all the Amazon S3 supported Regions and endpoints, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region\\\">Regions and Endpoints</a> in the AWS General Reference.</p> </note> </li> </ul> <p>For example, the following <code>x-amz-grant-read</code> header grants the AWS accounts identified by account IDs permissions to read object data and its metadata:</p> <p> <code>x-amz-grant-read: id=\\\"11112222333\\\", id=\\\"444455556666\\\" </code> </p> </li> </ul> <note> <p>You can use either a canned ACL or specify access permissions explicitly. You cannot do both.</p> </note> <p>The following operations are related to <code>CreateBucket</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html\\\">PutObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucket.html\\\">DeleteBucket</a> </p> </li> </ul>\",\
      \"alias\":\"PutBucket\"\
    },\
    \"CreateMultipartUpload\":{\
      \"name\":\"CreateMultipartUpload\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/{Bucket}/{Key+}?uploads\"\
      },\
      \"input\":{\"shape\":\"CreateMultipartUploadRequest\"},\
      \"output\":{\"shape\":\"CreateMultipartUploadOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadInitiate.html\",\
      \"documentation\":\"<p>This operation initiates a multipart upload and returns an upload ID. This upload ID is used to associate all of the parts in the specific multipart upload. You specify this upload ID in each of your subsequent upload part requests (see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html\\\">UploadPart</a>). You also include this upload ID in the final request to either complete or abort the multipart upload request.</p> <p>For more information about multipart uploads, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html\\\">Multipart Upload Overview</a>.</p> <p>If you have configured a lifecycle rule to abort incomplete multipart uploads, the upload must complete within the number of days specified in the bucket lifecycle configuration. Otherwise, the incomplete multipart upload becomes eligible for an abort operation and Amazon S3 aborts the multipart upload. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config\\\">Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy</a>.</p> <p>For information about the permissions required to use the multipart upload API, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html\\\">Multipart Upload API and Permissions</a>.</p> <p>For request signing, multipart upload is just a series of regular requests. You initiate a multipart upload, send one or more requests to upload parts, and then complete the multipart upload process. You sign each request individually. There is nothing special about signing multipart upload requests. For more information about signing, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html\\\">Authenticating Requests (AWS Signature Version 4)</a>.</p> <note> <p> After you initiate a multipart upload and upload one or more parts, to stop being charged for storing the uploaded parts, you must either complete or abort the multipart upload. Amazon S3 frees up the space used to store the parts and stop charging you for storing them only after you either complete or abort a multipart upload. </p> </note> <p>You can optionally request server-side encryption. For server-side encryption, Amazon S3 encrypts your data as it writes it to disks in its data centers and decrypts it when you access it. You can provide your own encryption key, or use AWS Key Management Service (AWS KMS) customer master keys (CMKs) or Amazon S3-managed encryption keys. If you choose to provide your own encryption key, the request headers you provide in <a href=\\\"AmazonS3/latest/API/API_UploadPart.html\\\">UploadPart</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html\\\">UploadPartCopy</a> requests must match the headers you used in the request to initiate the upload by using <code>CreateMultipartUpload</code>. </p> <p>To perform a multipart upload with encryption using an AWS KMS CMK, the requester must have permission to the <code>kms:Encrypt</code>, <code>kms:Decrypt</code>, <code>kms:ReEncrypt*</code>, <code>kms:GenerateDataKey*</code>, and <code>kms:DescribeKey</code> actions on the key. These permissions are required because Amazon S3 must decrypt and read data from the encrypted file parts before it completes the multipart upload.</p> <p>If your AWS Identity and Access Management (IAM) user or role is in the same AWS account as the AWS KMS CMK, then you must have these permissions on the key policy. If your IAM user or role belongs to a different account than the key, then you must have the permissions on both the key policy and your IAM user or role.</p> <p> For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html\\\">Protecting Data Using Server-Side Encryption</a>.</p> <dl> <dt>Access Permissions</dt> <dd> <p>When copying an object, you can optionally specify the accounts or groups that should be granted specific permissions on the new object. There are two ways to grant the permissions using the request headers:</p> <ul> <li> <p>Specify a canned ACL with the <code>x-amz-acl</code> request header. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\\\">Canned ACL</a>.</p> </li> <li> <p>Specify access permissions explicitly with the <code>x-amz-grant-read</code>, <code>x-amz-grant-read-acp</code>, <code>x-amz-grant-write-acp</code>, and <code>x-amz-grant-full-control</code> headers. These parameters map to the set of permissions that Amazon S3 supports in an ACL. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\\\">Access Control List (ACL) Overview</a>.</p> </li> </ul> <p>You can use either a canned ACL or specify access permissions explicitly. You cannot do both.</p> </dd> <dt>Server-Side- Encryption-Specific Request Headers</dt> <dd> <p>You can optionally tell Amazon S3 to encrypt data at rest using server-side encryption. Server-side encryption is for data encryption at rest. Amazon S3 encrypts your data as it writes it to disks in its data centers and decrypts it when you access it. The option you use depends on whether you want to use AWS managed encryption keys or provide your own encryption key. </p> <ul> <li> <p>Use encryption keys managed by Amazon S3 or customer master keys (CMKs) stored in AWS Key Management Service (AWS KMS) â If you want AWS to manage the keys used to encrypt data, specify the following headers in the request.</p> <ul> <li> <p>x-amz-server-side-encryption</p> </li> <li> <p>x-amz-server-side-encryption-aws-kms-key-id</p> </li> <li> <p>x-amz-server-side-encryption-context</p> </li> </ul> <note> <p>If you specify <code>x-amz-server-side-encryption:aws:kms</code>, but don't provide <code>x-amz-server-side-encryption-aws-kms-key-id</code>, Amazon S3 uses the AWS managed CMK in AWS KMS to protect the data.</p> </note> <important> <p>All GET and PUT requests for an object protected by AWS KMS fail if you don't make them with SSL or by using SigV4.</p> </important> <p>For more information about server-side encryption with CMKs stored in AWS KMS (SSE-KMS), see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html\\\">Protecting Data Using Server-Side Encryption with CMKs stored in AWS KMS</a>.</p> </li> <li> <p>Use customer-provided encryption keys â If you want to manage your own encryption keys, provide all the following headers in the request.</p> <ul> <li> <p>x-amz-server-side-encryption-customer-algorithm</p> </li> <li> <p>x-amz-server-side-encryption-customer-key</p> </li> <li> <p>x-amz-server-side-encryption-customer-key-MD5</p> </li> </ul> <p>For more information about server-side encryption with CMKs stored in AWS KMS (SSE-KMS), see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html\\\">Protecting Data Using Server-Side Encryption with CMKs stored in AWS KMS</a>.</p> </li> </ul> </dd> <dt>Access-Control-List (ACL)-Specific Request Headers</dt> <dd> <p>You also can use the following access controlârelated headers with this operation. By default, all objects are private. Only the owner has full access control. When adding a new object, you can grant permissions to individual AWS accounts or to predefined groups defined by Amazon S3. These permissions are then added to the access control list (ACL) on the object. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html\\\">Using ACLs</a>. With this operation, you can grant access permissions using one of the following two methods:</p> <ul> <li> <p>Specify a canned ACL (<code>x-amz-acl</code>) â Amazon S3 supports a set of predefined ACLs, known as <i>canned ACLs</i>. Each canned ACL has a predefined set of grantees and permissions. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\\\">Canned ACL</a>.</p> </li> <li> <p>Specify access permissions explicitly â To explicitly grant access permissions to specific AWS accounts or groups, use the following headers. Each header maps to specific permissions that Amazon S3 supports in an ACL. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\\\">Access Control List (ACL) Overview</a>. In the header, you specify a list of grantees who get the specific permission. To grant permissions explicitly, use:</p> <ul> <li> <p>x-amz-grant-read</p> </li> <li> <p>x-amz-grant-write</p> </li> <li> <p>x-amz-grant-read-acp</p> </li> <li> <p>x-amz-grant-write-acp</p> </li> <li> <p>x-amz-grant-full-control</p> </li> </ul> <p>You specify each grantee as a type=value pair, where the type is one of the following:</p> <ul> <li> <p> <code>id</code> â if the value specified is the canonical user ID of an AWS account</p> </li> <li> <p> <code>uri</code> â if you are granting permissions to a predefined group</p> </li> <li> <p> <code>emailAddress</code> â if the value specified is the email address of an AWS account</p> <note> <p>Using email addresses to specify a grantee is only supported in the following AWS Regions: </p> <ul> <li> <p>US East (N. Virginia)</p> </li> <li> <p>US West (N. California)</p> </li> <li> <p> US West (Oregon)</p> </li> <li> <p> Asia Pacific (Singapore)</p> </li> <li> <p>Asia Pacific (Sydney)</p> </li> <li> <p>Asia Pacific (Tokyo)</p> </li> <li> <p>Europe (Ireland)</p> </li> <li> <p>South America (SÃ£o Paulo)</p> </li> </ul> <p>For a list of all the Amazon S3 supported Regions and endpoints, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region\\\">Regions and Endpoints</a> in the AWS General Reference.</p> </note> </li> </ul> <p>For example, the following <code>x-amz-grant-read</code> header grants the AWS accounts identified by account IDs permissions to read object data and its metadata:</p> <p> <code>x-amz-grant-read: id=\\\"11112222333\\\", id=\\\"444455556666\\\" </code> </p> </li> </ul> </dd> </dl> <p>The following operations are related to <code>CreateMultipartUpload</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html\\\">UploadPart</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CompleteMultipartUpload.html\\\">CompleteMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_AbortMultipartUpload.html\\\">AbortMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListParts.html\\\">ListParts</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListMultipartUploads.html\\\">ListMultipartUploads</a> </p> </li> </ul>\",\
      \"alias\":\"InitiateMultipartUpload\"\
    },\
    \"DeleteBucket\":{\
      \"name\":\"DeleteBucket\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteBucketRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketDELETE.html\",\
      \"documentation\":\"<p>Deletes the S3 bucket. All objects (including all object versions and delete markers) in the bucket must be deleted before the bucket itself can be deleted.</p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObject.html\\\">DeleteObject</a> </p> </li> </ul>\"\
    },\
    \"DeleteBucketAnalyticsConfiguration\":{\
      \"name\":\"DeleteBucketAnalyticsConfiguration\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}?analytics\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteBucketAnalyticsConfigurationRequest\"},\
      \"documentation\":\"<p>Deletes an analytics configuration for the bucket (specified by the analytics configuration ID).</p> <p>To use this operation, you must have permissions to perform the <code>s3:PutAnalyticsConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>For information about the Amazon S3 analytics feature, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/analytics-storage-class.html\\\">Amazon S3 Analytics â Storage Class Analysis</a>. </p> <p>The following operations are related to <code>DeleteBucketAnalyticsConfiguration</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketAnalyticsConfiguration.html\\\">GetBucketAnalyticsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBucketAnalyticsConfigurations.html\\\">ListBucketAnalyticsConfigurations</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketAnalyticsConfiguration.html\\\">PutBucketAnalyticsConfiguration</a> </p> </li> </ul>\"\
    },\
    \"DeleteBucketCors\":{\
      \"name\":\"DeleteBucketCors\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}?cors\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteBucketCorsRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketDELETEcors.html\",\
      \"documentation\":\"<p>Deletes the <code>cors</code> configuration information set for the bucket.</p> <p>To use this operation, you must have permission to perform the <code>s3:PutBucketCORS</code> action. The bucket owner has this permission by default and can grant this permission to others. </p> <p>For information about <code>cors</code>, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html\\\">Enabling Cross-Origin Resource Sharing</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p class=\\\"title\\\"> <b>Related Resources:</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketCors.html\\\">PutBucketCors</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTOPTIONSobject.html\\\">RESTOPTIONSobject</a> </p> </li> </ul>\"\
    },\
    \"DeleteBucketEncryption\":{\
      \"name\":\"DeleteBucketEncryption\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}?encryption\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteBucketEncryptionRequest\"},\
      \"documentation\":\"<p>This implementation of the DELETE operation removes default encryption from the bucket. For information about the Amazon S3 default encryption feature, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html\\\">Amazon S3 Default Bucket Encryption</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>To use this operation, you must have permissions to perform the <code>s3:PutEncryptionConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to your Amazon S3 Resources</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketEncryption.html\\\">PutBucketEncryption</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketEncryption.html\\\">GetBucketEncryption</a> </p> </li> </ul>\"\
    },\
    \"DeleteBucketInventoryConfiguration\":{\
      \"name\":\"DeleteBucketInventoryConfiguration\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}?inventory\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteBucketInventoryConfigurationRequest\"},\
      \"documentation\":\"<p>Deletes an inventory configuration (identified by the inventory ID) from the bucket.</p> <p>To use this operation, you must have permissions to perform the <code>s3:PutInventoryConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>For information about the Amazon S3 inventory feature, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-inventory.html\\\">Amazon S3 Inventory</a>.</p> <p>Operations related to <code>DeleteBucketInventoryConfiguration</code> include: </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketInventoryConfiguration.html\\\">GetBucketInventoryConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketInventoryConfiguration.html\\\">PutBucketInventoryConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBucketInventoryConfigurations.html\\\">ListBucketInventoryConfigurations</a> </p> </li> </ul>\"\
    },\
    \"DeleteBucketLifecycle\":{\
      \"name\":\"DeleteBucketLifecycle\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}?lifecycle\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteBucketLifecycleRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketDELETElifecycle.html\",\
      \"documentation\":\"<p>Deletes the lifecycle configuration from the specified bucket. Amazon S3 removes all the lifecycle configuration rules in the lifecycle subresource associated with the bucket. Your objects never expire, and Amazon S3 no longer automatically deletes any objects on the basis of rules contained in the deleted lifecycle configuration.</p> <p>To use this operation, you must have permission to perform the <code>s3:PutLifecycleConfiguration</code> action. By default, the bucket owner has this permission and the bucket owner can grant this permission to others.</p> <p>There is usually some time lag before lifecycle configuration deletion is fully propagated to all the Amazon S3 systems.</p> <p>For more information about the object expiration, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#intro-lifecycle-rules-actions\\\">Elements to Describe Lifecycle Actions</a>.</p> <p>Related actions include:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html\\\">PutBucketLifecycleConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycleConfiguration.html\\\">GetBucketLifecycleConfiguration</a> </p> </li> </ul>\"\
    },\
    \"DeleteBucketMetricsConfiguration\":{\
      \"name\":\"DeleteBucketMetricsConfiguration\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}?metrics\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteBucketMetricsConfigurationRequest\"},\
      \"documentation\":\"<p>Deletes a metrics configuration for the Amazon CloudWatch request metrics (specified by the metrics configuration ID) from the bucket. Note that this doesn't include the daily storage metrics.</p> <p> To use this operation, you must have permissions to perform the <code>s3:PutMetricsConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>For information about CloudWatch request metrics for Amazon S3, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cloudwatch-monitoring.html\\\">Monitoring Metrics with Amazon CloudWatch</a>. </p> <p>The following operations are related to <code>DeleteBucketMetricsConfiguration</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketMetricsConfiguration.html\\\">GetBucketMetricsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketMetricsConfiguration.html\\\">PutBucketMetricsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBucketMetricsConfigurations.html\\\">ListBucketMetricsConfigurations</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cloudwatch-monitoring.html\\\">Monitoring Metrics with Amazon CloudWatch</a> </p> </li> </ul>\"\
    },\
    \"DeleteBucketOwnershipControls\":{\
      \"name\":\"DeleteBucketOwnershipControls\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}?ownershipControls\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteBucketOwnershipControlsRequest\"},\
      \"documentation\":\"<p>Removes <code>OwnershipControls</code> for an Amazon S3 bucket. To use this operation, you must have the <code>s3:PutBucketOwnershipControls</code> permission. For more information about Amazon S3 permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\\\">Specifying Permissions in a Policy</a>.</p> <p>For information about Amazon S3 Object Ownership, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/about-object-ownership.html\\\">Using Object Ownership</a>. </p> <p>The following operations are related to <code>DeleteBucketOwnershipControls</code>:</p> <ul> <li> <p> <a>GetBucketOwnershipControls</a> </p> </li> <li> <p> <a>PutBucketOwnershipControls</a> </p> </li> </ul>\"\
    },\
    \"DeleteBucketPolicy\":{\
      \"name\":\"DeleteBucketPolicy\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}?policy\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteBucketPolicyRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketDELETEpolicy.html\",\
      \"documentation\":\"<p>This implementation of the DELETE operation uses the policy subresource to delete the policy of a specified bucket. If you are using an identity other than the root user of the AWS account that owns the bucket, the calling identity must have the <code>DeleteBucketPolicy</code> permissions on the specified bucket and belong to the bucket owner's account to use this operation. </p> <p>If you don't have <code>DeleteBucketPolicy</code> permissions, Amazon S3 returns a <code>403 Access Denied</code> error. If you have the correct permissions, but you're not using an identity that belongs to the bucket owner's account, Amazon S3 returns a <code>405 Method Not Allowed</code> error. </p> <important> <p>As a security precaution, the root user of the AWS account that owns a bucket can always use this operation, even if the policy explicitly denies the root user the ability to perform this action.</p> </important> <p>For more information about bucket policies, see <a href=\\\" https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html\\\">Using Bucket Policies and UserPolicies</a>. </p> <p>The following operations are related to <code>DeleteBucketPolicy</code> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObject.html\\\">DeleteObject</a> </p> </li> </ul>\"\
    },\
    \"DeleteBucketReplication\":{\
      \"name\":\"DeleteBucketReplication\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}?replication\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteBucketReplicationRequest\"},\
      \"documentation\":\"<p> Deletes the replication configuration from the bucket.</p> <p>To use this operation, you must have permissions to perform the <code>s3:PutReplicationConfiguration</code> action. The bucket owner has these permissions by default and can grant it to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>. </p> <note> <p>It can take a while for the deletion of a replication configuration to fully propagate.</p> </note> <p> For information about replication configuration, see <a href=\\\" https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html\\\">Replication</a> in the <i>Amazon S3 Developer Guide</i>. </p> <p>The following operations are related to <code>DeleteBucketReplication</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketReplication.html\\\">PutBucketReplication</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketReplication.html\\\">GetBucketReplication</a> </p> </li> </ul>\"\
    },\
    \"DeleteBucketTagging\":{\
      \"name\":\"DeleteBucketTagging\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}?tagging\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteBucketTaggingRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketDELETEtagging.html\",\
      \"documentation\":\"<p>Deletes the tags from the bucket.</p> <p>To use this operation, you must have permission to perform the <code>s3:PutBucketTagging</code> action. By default, the bucket owner has this permission and can grant this permission to others. </p> <p>The following operations are related to <code>DeleteBucketTagging</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketTagging.html\\\">GetBucketTagging</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketTagging.html\\\">PutBucketTagging</a> </p> </li> </ul>\"\
    },\
    \"DeleteBucketWebsite\":{\
      \"name\":\"DeleteBucketWebsite\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}?website\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteBucketWebsiteRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketDELETEwebsite.html\",\
      \"documentation\":\"<p>This operation removes the website configuration for a bucket. Amazon S3 returns a <code>200 OK</code> response upon successfully deleting a website configuration on the specified bucket. You will get a <code>200 OK</code> response if the website configuration you are trying to delete does not exist on the bucket. Amazon S3 returns a <code>404</code> response if the bucket specified in the request does not exist.</p> <p>This DELETE operation requires the <code>S3:DeleteBucketWebsite</code> permission. By default, only the bucket owner can delete the website configuration attached to a bucket. However, bucket owners can grant other users permission to delete the website configuration by writing a bucket policy granting them the <code>S3:DeleteBucketWebsite</code> permission. </p> <p>For more information about hosting websites, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html\\\">Hosting Websites on Amazon S3</a>. </p> <p>The following operations are related to <code>DeleteBucketWebsite</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketWebsite.html\\\">GetBucketWebsite</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketWebsite.html\\\">PutBucketWebsite</a> </p> </li> </ul>\"\
    },\
    \"DeleteObject\":{\
      \"name\":\"DeleteObject\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}/{Key+}\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteObjectRequest\"},\
      \"output\":{\"shape\":\"DeleteObjectOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectDELETE.html\",\
      \"documentation\":\"<p>Removes the null version (if there is one) of an object and inserts a delete marker, which becomes the latest version of the object. If there isn't a null version, Amazon S3 does not remove any objects.</p> <p>To remove a specific version, you must be the bucket owner and you must use the version Id subresource. Using this subresource permanently deletes the version. If the object deleted is a delete marker, Amazon S3 sets the response header, <code>x-amz-delete-marker</code>, to true. </p> <p>If the object you want to delete is in a bucket where the bucket versioning configuration is MFA Delete enabled, you must include the <code>x-amz-mfa</code> request header in the DELETE <code>versionId</code> request. Requests that include <code>x-amz-mfa</code> must use HTTPS. </p> <p> For more information about MFA Delete, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingMFADelete.html\\\">Using MFA Delete</a>. To see sample requests that use versioning, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectDELETE.html#ExampleVersionObjectDelete\\\">Sample Request</a>. </p> <p>You can delete objects by explicitly calling the DELETE Object API or configure its lifecycle (<a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycle.html\\\">PutBucketLifecycle</a>) to enable Amazon S3 to remove them for you. If you want to block users or accounts from removing or deleting objects from your bucket, you must deny them the <code>s3:DeleteObject</code>, <code>s3:DeleteObjectVersion</code>, and <code>s3:PutLifeCycleConfiguration</code> actions. </p> <p>The following operation is related to <code>DeleteObject</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html\\\">PutObject</a> </p> </li> </ul>\"\
    },\
    \"DeleteObjectTagging\":{\
      \"name\":\"DeleteObjectTagging\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}/{Key+}?tagging\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeleteObjectTaggingRequest\"},\
      \"output\":{\"shape\":\"DeleteObjectTaggingOutput\"},\
      \"documentation\":\"<p>Removes the entire tag set from the specified object. For more information about managing object tags, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-tagging.html\\\"> Object Tagging</a>.</p> <p>To use this operation, you must have permission to perform the <code>s3:DeleteObjectTagging</code> action.</p> <p>To delete tags of a specific object version, add the <code>versionId</code> query parameter in the request. You will need permission for the <code>s3:DeleteObjectVersionTagging</code> action.</p> <p>The following operations are related to <code>DeleteBucketMetricsConfiguration</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObjectTagging.html\\\">PutObjectTagging</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectTagging.html\\\">GetObjectTagging</a> </p> </li> </ul>\"\
    },\
    \"DeleteObjects\":{\
      \"name\":\"DeleteObjects\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/{Bucket}?delete\"\
      },\
      \"input\":{\"shape\":\"DeleteObjectsRequest\"},\
      \"output\":{\"shape\":\"DeleteObjectsOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/multiobjectdeleteapi.html\",\
      \"documentation\":\"<p>This operation enables you to delete multiple objects from a bucket using a single HTTP request. If you know the object keys that you want to delete, then this operation provides a suitable alternative to sending individual delete requests, reducing per-request overhead.</p> <p>The request contains a list of up to 1000 keys that you want to delete. In the XML, you provide the object key names, and optionally, version IDs if you want to delete a specific version of the object from a versioning-enabled bucket. For each key, Amazon S3 performs a delete operation and returns the result of that delete, success, or failure, in the response. Note that if the object specified in the request is not found, Amazon S3 returns the result as deleted.</p> <p> The operation supports two modes for the response: verbose and quiet. By default, the operation uses verbose mode in which the response includes the result of deletion of each key in your request. In quiet mode the response includes only keys where the delete operation encountered an error. For a successful deletion, the operation does not return any information about the delete in the response body.</p> <p>When performing this operation on an MFA Delete enabled bucket, that attempts to delete any versioned objects, you must include an MFA token. If you do not provide one, the entire request will fail, even if there are non-versioned objects you are trying to delete. If you provide an invalid token, whether there are versioned keys in the request or not, the entire Multi-Object Delete request will fail. For information about MFA Delete, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/Versioning.html#MultiFactorAuthenticationDelete\\\"> MFA Delete</a>.</p> <p>Finally, the Content-MD5 header is required for all Multi-Object Delete requests. Amazon S3 uses the header value to ensure that your request body has not been altered in transit.</p> <p>The following operations are related to <code>DeleteObjects</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html\\\">CreateMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html\\\">UploadPart</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CompleteMultipartUpload.html\\\">CompleteMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListParts.html\\\">ListParts</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_AbortMultipartUpload.html\\\">AbortMultipartUpload</a> </p> </li> </ul>\",\
      \"alias\":\"DeleteMultipleObjects\",\
      \"httpChecksumRequired\":true\
    },\
    \"DeletePublicAccessBlock\":{\
      \"name\":\"DeletePublicAccessBlock\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/{Bucket}?publicAccessBlock\",\
        \"responseCode\":204\
      },\
      \"input\":{\"shape\":\"DeletePublicAccessBlockRequest\"},\
      \"documentation\":\"<p>Removes the <code>PublicAccessBlock</code> configuration for an Amazon S3 bucket. To use this operation, you must have the <code>s3:PutBucketPublicAccessBlock</code> permission. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>The following operations are related to <code>DeletePublicAccessBlock</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html\\\">Using Amazon S3 Block Public Access</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetPublicAccessBlock.html\\\">GetPublicAccessBlock</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutPublicAccessBlock.html\\\">PutPublicAccessBlock</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketPolicyStatus.html\\\">GetBucketPolicyStatus</a> </p> </li> </ul>\"\
    },\
    \"GetBucketAccelerateConfiguration\":{\
      \"name\":\"GetBucketAccelerateConfiguration\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?accelerate\"\
      },\
      \"input\":{\"shape\":\"GetBucketAccelerateConfigurationRequest\"},\
      \"output\":{\"shape\":\"GetBucketAccelerateConfigurationOutput\"},\
      \"documentation\":\"<p>This implementation of the GET operation uses the <code>accelerate</code> subresource to return the Transfer Acceleration state of a bucket, which is either <code>Enabled</code> or <code>Suspended</code>. Amazon S3 Transfer Acceleration is a bucket-level feature that enables you to perform faster data transfers to and from Amazon S3.</p> <p>To use this operation, you must have permission to perform the <code>s3:GetAccelerateConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to your Amazon S3 Resources</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>You set the Transfer Acceleration state of an existing bucket to <code>Enabled</code> or <code>Suspended</code> by using the <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketAccelerateConfiguration.html\\\">PutBucketAccelerateConfiguration</a> operation. </p> <p>A GET <code>accelerate</code> request does not return a state value for a bucket that has no transfer acceleration state. A bucket has no Transfer Acceleration state if a state has never been set on the bucket. </p> <p>For more information about transfer acceleration, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html\\\">Transfer Acceleration</a> in the Amazon Simple Storage Service Developer Guide.</p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketAccelerateConfiguration.html\\\">PutBucketAccelerateConfiguration</a> </p> </li> </ul>\"\
    },\
    \"GetBucketAcl\":{\
      \"name\":\"GetBucketAcl\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?acl\"\
      },\
      \"input\":{\"shape\":\"GetBucketAclRequest\"},\
      \"output\":{\"shape\":\"GetBucketAclOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETacl.html\",\
      \"documentation\":\"<p>This implementation of the <code>GET</code> operation uses the <code>acl</code> subresource to return the access control list (ACL) of a bucket. To use <code>GET</code> to return the ACL of the bucket, you must have <code>READ_ACP</code> access to the bucket. If <code>READ_ACP</code> permission is granted to the anonymous user, you can return the ACL of the bucket without using an authorization header.</p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjects.html\\\">ListObjects</a> </p> </li> </ul>\"\
    },\
    \"GetBucketAnalyticsConfiguration\":{\
      \"name\":\"GetBucketAnalyticsConfiguration\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?analytics\"\
      },\
      \"input\":{\"shape\":\"GetBucketAnalyticsConfigurationRequest\"},\
      \"output\":{\"shape\":\"GetBucketAnalyticsConfigurationOutput\"},\
      \"documentation\":\"<p>This implementation of the GET operation returns an analytics configuration (identified by the analytics configuration ID) from the bucket.</p> <p>To use this operation, you must have permissions to perform the <code>s3:GetAnalyticsConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\"> Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a> in the <i>Amazon Simple Storage Service Developer Guide</i>. </p> <p>For information about Amazon S3 analytics feature, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/analytics-storage-class.html\\\">Amazon S3 Analytics â Storage Class Analysis</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketAnalyticsConfiguration.html\\\">DeleteBucketAnalyticsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBucketAnalyticsConfigurations.html\\\">ListBucketAnalyticsConfigurations</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketAnalyticsConfiguration.html\\\">PutBucketAnalyticsConfiguration</a> </p> </li> </ul>\"\
    },\
    \"GetBucketCors\":{\
      \"name\":\"GetBucketCors\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?cors\"\
      },\
      \"input\":{\"shape\":\"GetBucketCorsRequest\"},\
      \"output\":{\"shape\":\"GetBucketCorsOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETcors.html\",\
      \"documentation\":\"<p>Returns the cors configuration information set for the bucket.</p> <p> To use this operation, you must have permission to perform the s3:GetBucketCORS action. By default, the bucket owner has this permission and can grant it to others.</p> <p> For more information about cors, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html\\\"> Enabling Cross-Origin Resource Sharing</a>.</p> <p>The following operations are related to <code>GetBucketCors</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketCors.html\\\">PutBucketCors</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketCors.html\\\">DeleteBucketCors</a> </p> </li> </ul>\"\
    },\
    \"GetBucketEncryption\":{\
      \"name\":\"GetBucketEncryption\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?encryption\"\
      },\
      \"input\":{\"shape\":\"GetBucketEncryptionRequest\"},\
      \"output\":{\"shape\":\"GetBucketEncryptionOutput\"},\
      \"documentation\":\"<p>Returns the default encryption configuration for an Amazon S3 bucket. For information about the Amazon S3 default encryption feature, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html\\\">Amazon S3 Default Bucket Encryption</a>.</p> <p> To use this operation, you must have permission to perform the <code>s3:GetEncryptionConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>The following operations are related to <code>GetBucketEncryption</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketEncryption.html\\\">PutBucketEncryption</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketEncryption.html\\\">DeleteBucketEncryption</a> </p> </li> </ul>\"\
    },\
    \"GetBucketInventoryConfiguration\":{\
      \"name\":\"GetBucketInventoryConfiguration\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?inventory\"\
      },\
      \"input\":{\"shape\":\"GetBucketInventoryConfigurationRequest\"},\
      \"output\":{\"shape\":\"GetBucketInventoryConfigurationOutput\"},\
      \"documentation\":\"<p>Returns an inventory configuration (identified by the inventory configuration ID) from the bucket.</p> <p>To use this operation, you must have permissions to perform the <code>s3:GetInventoryConfiguration</code> action. The bucket owner has this permission by default and can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>For information about the Amazon S3 inventory feature, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-inventory.html\\\">Amazon S3 Inventory</a>.</p> <p>The following operations are related to <code>GetBucketInventoryConfiguration</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketInventoryConfiguration.html\\\">DeleteBucketInventoryConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBucketInventoryConfigurations.html\\\">ListBucketInventoryConfigurations</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketInventoryConfiguration.html\\\">PutBucketInventoryConfiguration</a> </p> </li> </ul>\"\
    },\
    \"GetBucketLifecycle\":{\
      \"name\":\"GetBucketLifecycle\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?lifecycle\"\
      },\
      \"input\":{\"shape\":\"GetBucketLifecycleRequest\"},\
      \"output\":{\"shape\":\"GetBucketLifecycleOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETlifecycle.html\",\
      \"documentation\":\"<important> <p>For an updated version of this API, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycleConfiguration.html\\\">GetBucketLifecycleConfiguration</a>. If you configured a bucket lifecycle using the <code>filter</code> element, you should see the updated version of this topic. This topic is provided for backward compatibility.</p> </important> <p>Returns the lifecycle configuration information set on the bucket. For information about lifecycle configuration, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html\\\">Object Lifecycle Management</a>.</p> <p> To use this operation, you must have permission to perform the <code>s3:GetLifecycleConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p> <code>GetBucketLifecycle</code> has the following special error:</p> <ul> <li> <p>Error code: <code>NoSuchLifecycleConfiguration</code> </p> <ul> <li> <p>Description: The lifecycle configuration does not exist.</p> </li> <li> <p>HTTP Status Code: 404 Not Found</p> </li> <li> <p>SOAP Fault Code Prefix: Client</p> </li> </ul> </li> </ul> <p>The following operations are related to <code>GetBucketLifecycle</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycleConfiguration.html\\\">GetBucketLifecycleConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycle.html\\\">PutBucketLifecycle</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketLifecycle.html\\\">DeleteBucketLifecycle</a> </p> </li> </ul>\",\
      \"deprecated\":true\
    },\
    \"GetBucketLifecycleConfiguration\":{\
      \"name\":\"GetBucketLifecycleConfiguration\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?lifecycle\"\
      },\
      \"input\":{\"shape\":\"GetBucketLifecycleConfigurationRequest\"},\
      \"output\":{\"shape\":\"GetBucketLifecycleConfigurationOutput\"},\
      \"documentation\":\"<note> <p>Bucket lifecycle configuration now supports specifying a lifecycle rule using an object key name prefix, one or more object tags, or a combination of both. Accordingly, this section describes the latest API. The response describes the new filter element that you can use to specify a filter to select a subset of objects to which the rule applies. If you are using a previous version of the lifecycle configuration, it still works. For the earlier API description, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycle.html\\\">GetBucketLifecycle</a>.</p> </note> <p>Returns the lifecycle configuration information set on the bucket. For information about lifecycle configuration, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html\\\">Object Lifecycle Management</a>.</p> <p>To use this operation, you must have permission to perform the <code>s3:GetLifecycleConfiguration</code> action. The bucket owner has this permission, by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p> <code>GetBucketLifecycleConfiguration</code> has the following special error:</p> <ul> <li> <p>Error code: <code>NoSuchLifecycleConfiguration</code> </p> <ul> <li> <p>Description: The lifecycle configuration does not exist.</p> </li> <li> <p>HTTP Status Code: 404 Not Found</p> </li> <li> <p>SOAP Fault Code Prefix: Client</p> </li> </ul> </li> </ul> <p>The following operations are related to <code>GetBucketLifecycleConfiguration</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycle.html\\\">GetBucketLifecycle</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycle.html\\\">PutBucketLifecycle</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketLifecycle.html\\\">DeleteBucketLifecycle</a> </p> </li> </ul>\"\
    },\
    \"GetBucketLocation\":{\
      \"name\":\"GetBucketLocation\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?location\"\
      },\
      \"input\":{\"shape\":\"GetBucketLocationRequest\"},\
      \"output\":{\"shape\":\"GetBucketLocationOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETlocation.html\",\
      \"documentation\":\"<p>Returns the Region the bucket resides in. You set the bucket's Region using the <code>LocationConstraint</code> request parameter in a <code>CreateBucket</code> request. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a>.</p> <p> To use this implementation of the operation, you must be the bucket owner.</p> <p>The following operations are related to <code>GetBucketLocation</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a> </p> </li> </ul>\"\
    },\
    \"GetBucketLogging\":{\
      \"name\":\"GetBucketLogging\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?logging\"\
      },\
      \"input\":{\"shape\":\"GetBucketLoggingRequest\"},\
      \"output\":{\"shape\":\"GetBucketLoggingOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETlogging.html\",\
      \"documentation\":\"<p>Returns the logging status of a bucket and the permissions users have to view and modify that status. To use GET, you must be the bucket owner.</p> <p>The following operations are related to <code>GetBucketLogging</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLogging.html\\\">PutBucketLogging</a> </p> </li> </ul>\"\
    },\
    \"GetBucketMetricsConfiguration\":{\
      \"name\":\"GetBucketMetricsConfiguration\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?metrics\"\
      },\
      \"input\":{\"shape\":\"GetBucketMetricsConfigurationRequest\"},\
      \"output\":{\"shape\":\"GetBucketMetricsConfigurationOutput\"},\
      \"documentation\":\"<p>Gets a metrics configuration (specified by the metrics configuration ID) from the bucket. Note that this doesn't include the daily storage metrics.</p> <p> To use this operation, you must have permissions to perform the <code>s3:GetMetricsConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p> For information about CloudWatch request metrics for Amazon S3, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cloudwatch-monitoring.html\\\">Monitoring Metrics with Amazon CloudWatch</a>.</p> <p>The following operations are related to <code>GetBucketMetricsConfiguration</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketMetricsConfiguration.html\\\">PutBucketMetricsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketMetricsConfiguration.html\\\">DeleteBucketMetricsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBucketMetricsConfigurations.html\\\">ListBucketMetricsConfigurations</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cloudwatch-monitoring.html\\\">Monitoring Metrics with Amazon CloudWatch</a> </p> </li> </ul>\"\
    },\
    \"GetBucketNotification\":{\
      \"name\":\"GetBucketNotification\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?notification\"\
      },\
      \"input\":{\"shape\":\"GetBucketNotificationConfigurationRequest\"},\
      \"output\":{\"shape\":\"NotificationConfigurationDeprecated\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETnotification.html\",\
      \"documentation\":\"<p> No longer used, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketNotificationConfiguration.html\\\">GetBucketNotificationConfiguration</a>.</p>\",\
      \"deprecated\":true\
    },\
    \"GetBucketNotificationConfiguration\":{\
      \"name\":\"GetBucketNotificationConfiguration\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?notification\"\
      },\
      \"input\":{\"shape\":\"GetBucketNotificationConfigurationRequest\"},\
      \"output\":{\"shape\":\"NotificationConfiguration\"},\
      \"documentation\":\"<p>Returns the notification configuration of a bucket.</p> <p>If notifications are not enabled on the bucket, the operation returns an empty <code>NotificationConfiguration</code> element.</p> <p>By default, you must be the bucket owner to read the notification configuration of a bucket. However, the bucket owner can use a bucket policy to grant permission to other users to read this configuration with the <code>s3:GetBucketNotification</code> permission.</p> <p>For more information about setting and reading the notification configuration on a bucket, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\\\">Setting Up Notification of Bucket Events</a>. For more information about bucket policies, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html\\\">Using Bucket Policies</a>.</p> <p>The following operation is related to <code>GetBucketNotification</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketNotification.html\\\">PutBucketNotification</a> </p> </li> </ul>\"\
    },\
    \"GetBucketOwnershipControls\":{\
      \"name\":\"GetBucketOwnershipControls\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?ownershipControls\"\
      },\
      \"input\":{\"shape\":\"GetBucketOwnershipControlsRequest\"},\
      \"output\":{\"shape\":\"GetBucketOwnershipControlsOutput\"},\
      \"documentation\":\"<p>Retrieves <code>OwnershipControls</code> for an Amazon S3 bucket. To use this operation, you must have the <code>s3:GetBucketOwnershipControls</code> permission. For more information about Amazon S3 permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\\\">Specifying Permissions in a Policy</a>. </p> <p>For information about Amazon S3 Object Ownership, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/about-object-ownership.html\\\">Using Object Ownership</a>. </p> <p>The following operations are related to <code>GetBucketOwnershipControls</code>:</p> <ul> <li> <p> <a>PutBucketOwnershipControls</a> </p> </li> <li> <p> <a>DeleteBucketOwnershipControls</a> </p> </li> </ul>\"\
    },\
    \"GetBucketPolicy\":{\
      \"name\":\"GetBucketPolicy\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?policy\"\
      },\
      \"input\":{\"shape\":\"GetBucketPolicyRequest\"},\
      \"output\":{\"shape\":\"GetBucketPolicyOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETpolicy.html\",\
      \"documentation\":\"<p>Returns the policy of a specified bucket. If you are using an identity other than the root user of the AWS account that owns the bucket, the calling identity must have the <code>GetBucketPolicy</code> permissions on the specified bucket and belong to the bucket owner's account in order to use this operation.</p> <p>If you don't have <code>GetBucketPolicy</code> permissions, Amazon S3 returns a <code>403 Access Denied</code> error. If you have the correct permissions, but you're not using an identity that belongs to the bucket owner's account, Amazon S3 returns a <code>405 Method Not Allowed</code> error.</p> <important> <p>As a security precaution, the root user of the AWS account that owns a bucket can always use this operation, even if the policy explicitly denies the root user the ability to perform this action.</p> </important> <p>For more information about bucket policies, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html\\\">Using Bucket Policies and User Policies</a>.</p> <p>The following operation is related to <code>GetBucketPolicy</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a> </p> </li> </ul>\"\
    },\
    \"GetBucketPolicyStatus\":{\
      \"name\":\"GetBucketPolicyStatus\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?policyStatus\"\
      },\
      \"input\":{\"shape\":\"GetBucketPolicyStatusRequest\"},\
      \"output\":{\"shape\":\"GetBucketPolicyStatusOutput\"},\
      \"documentation\":\"<p>Retrieves the policy status for an Amazon S3 bucket, indicating whether the bucket is public. In order to use this operation, you must have the <code>s3:GetBucketPolicyStatus</code> permission. For more information about Amazon S3 permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\\\">Specifying Permissions in a Policy</a>.</p> <p> For more information about when Amazon S3 considers a bucket public, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html#access-control-block-public-access-policy-status\\\">The Meaning of \\\"Public\\\"</a>. </p> <p>The following operations are related to <code>GetBucketPolicyStatus</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html\\\">Using Amazon S3 Block Public Access</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetPublicAccessBlock.html\\\">GetPublicAccessBlock</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutPublicAccessBlock.html\\\">PutPublicAccessBlock</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeletePublicAccessBlock.html\\\">DeletePublicAccessBlock</a> </p> </li> </ul>\"\
    },\
    \"GetBucketReplication\":{\
      \"name\":\"GetBucketReplication\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?replication\"\
      },\
      \"input\":{\"shape\":\"GetBucketReplicationRequest\"},\
      \"output\":{\"shape\":\"GetBucketReplicationOutput\"},\
      \"documentation\":\"<p>Returns the replication configuration of a bucket.</p> <note> <p> It can take a while to propagate the put or delete a replication configuration to all Amazon S3 systems. Therefore, a get request soon after put or delete can return a wrong result. </p> </note> <p> For information about replication configuration, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html\\\">Replication</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>This operation requires permissions for the <code>s3:GetReplicationConfiguration</code> action. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html\\\">Using Bucket Policies and User Policies</a>.</p> <p>If you include the <code>Filter</code> element in a replication configuration, you must also include the <code>DeleteMarkerReplication</code> and <code>Priority</code> elements. The response also returns those elements.</p> <p>For information about <code>GetBucketReplication</code> errors, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#ReplicationErrorCodeList\\\">List of replication-related error codes</a> </p> <p>The following operations are related to <code>GetBucketReplication</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketReplication.html\\\">PutBucketReplication</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketReplication.html\\\">DeleteBucketReplication</a> </p> </li> </ul>\"\
    },\
    \"GetBucketRequestPayment\":{\
      \"name\":\"GetBucketRequestPayment\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?requestPayment\"\
      },\
      \"input\":{\"shape\":\"GetBucketRequestPaymentRequest\"},\
      \"output\":{\"shape\":\"GetBucketRequestPaymentOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTrequestPaymentGET.html\",\
      \"documentation\":\"<p>Returns the request payment configuration of a bucket. To use this version of the operation, you must be the bucket owner. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/RequesterPaysBuckets.html\\\">Requester Pays Buckets</a>.</p> <p>The following operations are related to <code>GetBucketRequestPayment</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjects.html\\\">ListObjects</a> </p> </li> </ul>\"\
    },\
    \"GetBucketTagging\":{\
      \"name\":\"GetBucketTagging\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?tagging\"\
      },\
      \"input\":{\"shape\":\"GetBucketTaggingRequest\"},\
      \"output\":{\"shape\":\"GetBucketTaggingOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETtagging.html\",\
      \"documentation\":\"<p>Returns the tag set associated with the bucket.</p> <p>To use this operation, you must have permission to perform the <code>s3:GetBucketTagging</code> action. By default, the bucket owner has this permission and can grant this permission to others.</p> <p> <code>GetBucketTagging</code> has the following special error:</p> <ul> <li> <p>Error code: <code>NoSuchTagSetError</code> </p> <ul> <li> <p>Description: There is no tag set associated with the bucket.</p> </li> </ul> </li> </ul> <p>The following operations are related to <code>GetBucketTagging</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketTagging.html\\\">PutBucketTagging</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketTagging.html\\\">DeleteBucketTagging</a> </p> </li> </ul>\"\
    },\
    \"GetBucketVersioning\":{\
      \"name\":\"GetBucketVersioning\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?versioning\"\
      },\
      \"input\":{\"shape\":\"GetBucketVersioningRequest\"},\
      \"output\":{\"shape\":\"GetBucketVersioningOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETversioningStatus.html\",\
      \"documentation\":\"<p>Returns the versioning state of a bucket.</p> <p>To retrieve the versioning state of a bucket, you must be the bucket owner.</p> <p>This implementation also returns the MFA Delete status of the versioning state. If the MFA Delete status is <code>enabled</code>, the bucket owner must use an authentication device to change the versioning state of the bucket.</p> <p>The following operations are related to <code>GetBucketVersioning</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html\\\">PutObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObject.html\\\">DeleteObject</a> </p> </li> </ul>\"\
    },\
    \"GetBucketWebsite\":{\
      \"name\":\"GetBucketWebsite\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?website\"\
      },\
      \"input\":{\"shape\":\"GetBucketWebsiteRequest\"},\
      \"output\":{\"shape\":\"GetBucketWebsiteOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETwebsite.html\",\
      \"documentation\":\"<p>Returns the website configuration for a bucket. To host website on Amazon S3, you can configure a bucket as website by adding a website configuration. For more information about hosting websites, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html\\\">Hosting Websites on Amazon S3</a>. </p> <p>This GET operation requires the <code>S3:GetBucketWebsite</code> permission. By default, only the bucket owner can read the bucket website configuration. However, bucket owners can allow other users to read the website configuration by writing a bucket policy granting them the <code>S3:GetBucketWebsite</code> permission.</p> <p>The following operations are related to <code>DeleteBucketWebsite</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketWebsite.html\\\">DeleteBucketWebsite</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketWebsite.html\\\">PutBucketWebsite</a> </p> </li> </ul>\"\
    },\
    \"GetObject\":{\
      \"name\":\"GetObject\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}/{Key+}\"\
      },\
      \"input\":{\"shape\":\"GetObjectRequest\"},\
      \"output\":{\"shape\":\"GetObjectOutput\"},\
      \"errors\":[\
        {\"shape\":\"NoSuchKey\"}\
      ],\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectGET.html\",\
      \"documentation\":\"<p>Retrieves objects from Amazon S3. To use <code>GET</code>, you must have <code>READ</code> access to the object. If you grant <code>READ</code> access to the anonymous user, you can return the object without using an authorization header.</p> <p>An Amazon S3 bucket has no directory hierarchy such as you would find in a typical computer file system. You can, however, create a logical hierarchy by using object key names that imply a folder structure. For example, instead of naming an object <code>sample.jpg</code>, you can name it <code>photos/2006/February/sample.jpg</code>.</p> <p>To get an object from such a logical hierarchy, specify the full key name for the object in the <code>GET</code> operation. For a virtual hosted-style request example, if you have the object <code>photos/2006/February/sample.jpg</code>, specify the resource as <code>/photos/2006/February/sample.jpg</code>. For a path-style request example, if you have the object <code>photos/2006/February/sample.jpg</code> in the bucket named <code>examplebucket</code>, specify the resource as <code>/examplebucket/photos/2006/February/sample.jpg</code>. For more information about request types, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/VirtualHosting.html#VirtualHostingSpecifyBucket\\\">HTTP Host Header Bucket Specification</a>.</p> <p>To distribute large files to many people, you can save bandwidth costs by using BitTorrent. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3Torrent.html\\\">Amazon S3 Torrent</a>. For more information about returning the ACL of an object, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectAcl.html\\\">GetObjectAcl</a>.</p> <p>If the object you are retrieving is stored in the GLACIER or DEEP_ARCHIVE storage classes, before you can retrieve the object you must first restore a copy using <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_RestoreObject.html\\\">RestoreObject</a>. Otherwise, this operation returns an <code>InvalidObjectStateError</code> error. For information about restoring archived objects, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/restoring-objects.html\\\">Restoring Archived Objects</a>.</p> <p>Encryption request headers, like <code>x-amz-server-side-encryption</code>, should not be sent for GET requests if your object uses server-side encryption with CMKs stored in AWS KMS (SSE-KMS) or server-side encryption with Amazon S3âmanaged encryption keys (SSE-S3). If your object does use these types of keys, youâll get an HTTP 400 BadRequest error.</p> <p>If you encrypt an object by using server-side encryption with customer-provided encryption keys (SSE-C) when you store the object in Amazon S3, then when you GET the object, you must use the following headers:</p> <ul> <li> <p>x-amz-server-side-encryption-customer-algorithm</p> </li> <li> <p>x-amz-server-side-encryption-customer-key</p> </li> <li> <p>x-amz-server-side-encryption-customer-key-MD5</p> </li> </ul> <p>For more information about SSE-C, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html\\\">Server-Side Encryption (Using Customer-Provided Encryption Keys)</a>.</p> <p>Assuming you have permission to read object tags (permission for the <code>s3:GetObjectVersionTagging</code> action), the response also returns the <code>x-amz-tagging-count</code> header that provides the count of number of tags associated with the object. You can use <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectTagging.html\\\">GetObjectTagging</a> to retrieve the tag set associated with an object.</p> <p> <b>Permissions</b> </p> <p>You need the <code>s3:GetObject</code> permission for this operation. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\\\">Specifying Permissions in a Policy</a>. If the object you request does not exist, the error Amazon S3 returns depends on whether you also have the <code>s3:ListBucket</code> permission.</p> <ul> <li> <p>If you have the <code>s3:ListBucket</code> permission on the bucket, Amazon S3 will return an HTTP status code 404 (\\\"no such key\\\") error.</p> </li> <li> <p>If you donât have the <code>s3:ListBucket</code> permission, Amazon S3 will return an HTTP status code 403 (\\\"access denied\\\") error.</p> </li> </ul> <p> <b>Versioning</b> </p> <p>By default, the GET operation returns the current version of an object. To return a different version, use the <code>versionId</code> subresource.</p> <note> <p>If the current version of the object is a delete marker, Amazon S3 behaves as if the object was deleted and includes <code>x-amz-delete-marker: true</code> in the response.</p> </note> <p>For more information about versioning, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketVersioning.html\\\">PutBucketVersioning</a>. </p> <p> <b>Overriding Response Header Values</b> </p> <p>There are times when you want to override certain response header values in a GET response. For example, you might override the Content-Disposition response header value in your GET request.</p> <p>You can override values for a set of response headers using the following query parameters. These response header values are sent only on a successful request, that is, when status code 200 OK is returned. The set of headers you can override using these parameters is a subset of the headers that Amazon S3 accepts when you create an object. The response headers that you can override for the GET response are <code>Content-Type</code>, <code>Content-Language</code>, <code>Expires</code>, <code>Cache-Control</code>, <code>Content-Disposition</code>, and <code>Content-Encoding</code>. To override these header values in the GET response, you use the following request parameters.</p> <note> <p>You must sign the request, either using an Authorization header or a presigned URL, when using these parameters. They cannot be used with an unsigned (anonymous) request.</p> </note> <ul> <li> <p> <code>response-content-type</code> </p> </li> <li> <p> <code>response-content-language</code> </p> </li> <li> <p> <code>response-expires</code> </p> </li> <li> <p> <code>response-cache-control</code> </p> </li> <li> <p> <code>response-content-disposition</code> </p> </li> <li> <p> <code>response-content-encoding</code> </p> </li> </ul> <p> <b>Additional Considerations about Request Headers</b> </p> <p>If both of the <code>If-Match</code> and <code>If-Unmodified-Since</code> headers are present in the request as follows: <code>If-Match</code> condition evaluates to <code>true</code>, and; <code>If-Unmodified-Since</code> condition evaluates to <code>false</code>; then, S3 returns 200 OK and the data requested. </p> <p>If both of the <code>If-None-Match</code> and <code>If-Modified-Since</code> headers are present in the request as follows:<code> If-None-Match</code> condition evaluates to <code>false</code>, and; <code>If-Modified-Since</code> condition evaluates to <code>true</code>; then, S3 returns 304 Not Modified response code.</p> <p>For more information about conditional requests, see <a href=\\\"https://tools.ietf.org/html/rfc7232\\\">RFC 7232</a>.</p> <p>The following operations are related to <code>GetObject</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBuckets.html\\\">ListBuckets</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectAcl.html\\\">GetObjectAcl</a> </p> </li> </ul>\"\
    },\
    \"GetObjectAcl\":{\
      \"name\":\"GetObjectAcl\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}/{Key+}?acl\"\
      },\
      \"input\":{\"shape\":\"GetObjectAclRequest\"},\
      \"output\":{\"shape\":\"GetObjectAclOutput\"},\
      \"errors\":[\
        {\"shape\":\"NoSuchKey\"}\
      ],\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectGETacl.html\",\
      \"documentation\":\"<p>Returns the access control list (ACL) of an object. To use this operation, you must have <code>READ_ACP</code> access to the object.</p> <p>This action is not supported by Amazon S3 on Outposts.</p> <p> <b>Versioning</b> </p> <p>By default, GET returns ACL information about the current version of an object. To return ACL information about a different version, use the versionId subresource.</p> <p>The following operations are related to <code>GetObjectAcl</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObject.html\\\">DeleteObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html\\\">PutObject</a> </p> </li> </ul>\"\
    },\
    \"GetObjectLegalHold\":{\
      \"name\":\"GetObjectLegalHold\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}/{Key+}?legal-hold\"\
      },\
      \"input\":{\"shape\":\"GetObjectLegalHoldRequest\"},\
      \"output\":{\"shape\":\"GetObjectLegalHoldOutput\"},\
      \"documentation\":\"<p>Gets an object's current Legal Hold status. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\\\">Locking Objects</a>.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\"\
    },\
    \"GetObjectLockConfiguration\":{\
      \"name\":\"GetObjectLockConfiguration\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?object-lock\"\
      },\
      \"input\":{\"shape\":\"GetObjectLockConfigurationRequest\"},\
      \"output\":{\"shape\":\"GetObjectLockConfigurationOutput\"},\
      \"documentation\":\"<p>Gets the Object Lock configuration for a bucket. The rule specified in the Object Lock configuration will be applied by default to every new object placed in the specified bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\\\">Locking Objects</a>.</p>\"\
    },\
    \"GetObjectRetention\":{\
      \"name\":\"GetObjectRetention\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}/{Key+}?retention\"\
      },\
      \"input\":{\"shape\":\"GetObjectRetentionRequest\"},\
      \"output\":{\"shape\":\"GetObjectRetentionOutput\"},\
      \"documentation\":\"<p>Retrieves an object's retention settings. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\\\">Locking Objects</a>.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\"\
    },\
    \"GetObjectTagging\":{\
      \"name\":\"GetObjectTagging\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}/{Key+}?tagging\"\
      },\
      \"input\":{\"shape\":\"GetObjectTaggingRequest\"},\
      \"output\":{\"shape\":\"GetObjectTaggingOutput\"},\
      \"documentation\":\"<p>Returns the tag-set of an object. You send the GET request against the tagging subresource associated with the object.</p> <p>To use this operation, you must have permission to perform the <code>s3:GetObjectTagging</code> action. By default, the GET operation returns information about current version of an object. For a versioned bucket, you can have multiple versions of an object in your bucket. To retrieve tags of any other version, use the versionId query parameter. You also need permission for the <code>s3:GetObjectVersionTagging</code> action.</p> <p> By default, the bucket owner has this permission and can grant this permission to others.</p> <p> For information about the Amazon S3 object tagging feature, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-tagging.html\\\">Object Tagging</a>.</p> <p>The following operation is related to <code>GetObjectTagging</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObjectTagging.html\\\">PutObjectTagging</a> </p> </li> </ul>\"\
    },\
    \"GetObjectTorrent\":{\
      \"name\":\"GetObjectTorrent\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}/{Key+}?torrent\"\
      },\
      \"input\":{\"shape\":\"GetObjectTorrentRequest\"},\
      \"output\":{\"shape\":\"GetObjectTorrentOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectGETtorrent.html\",\
      \"documentation\":\"<p>Returns torrent files from a bucket. BitTorrent can save you bandwidth when you're distributing large files. For more information about BitTorrent, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3Torrent.html\\\">Using BitTorrent with Amazon S3</a>.</p> <note> <p>You can get torrent only for objects that are less than 5 GB in size, and that are not encrypted using server-side encryption with a customer-provided encryption key.</p> </note> <p>To use GET, you must have READ access to the object.</p> <p>This action is not supported by Amazon S3 on Outposts.</p> <p>The following operation is related to <code>GetObjectTorrent</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a> </p> </li> </ul>\"\
    },\
    \"GetPublicAccessBlock\":{\
      \"name\":\"GetPublicAccessBlock\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?publicAccessBlock\"\
      },\
      \"input\":{\"shape\":\"GetPublicAccessBlockRequest\"},\
      \"output\":{\"shape\":\"GetPublicAccessBlockOutput\"},\
      \"documentation\":\"<p>Retrieves the <code>PublicAccessBlock</code> configuration for an Amazon S3 bucket. To use this operation, you must have the <code>s3:GetBucketPublicAccessBlock</code> permission. For more information about Amazon S3 permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\\\">Specifying Permissions in a Policy</a>.</p> <important> <p>When Amazon S3 evaluates the <code>PublicAccessBlock</code> configuration for a bucket or an object, it checks the <code>PublicAccessBlock</code> configuration for both the bucket (or the bucket that contains the object) and the bucket owner's account. If the <code>PublicAccessBlock</code> settings are different between the bucket and the account, Amazon S3 uses the most restrictive combination of the bucket-level and account-level settings.</p> </important> <p>For more information about when Amazon S3 considers a bucket or an object public, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html#access-control-block-public-access-policy-status\\\">The Meaning of \\\"Public\\\"</a>.</p> <p>The following operations are related to <code>GetPublicAccessBlock</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html\\\">Using Amazon S3 Block Public Access</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutPublicAccessBlock.html\\\">PutPublicAccessBlock</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetPublicAccessBlock.html\\\">GetPublicAccessBlock</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeletePublicAccessBlock.html\\\">DeletePublicAccessBlock</a> </p> </li> </ul>\"\
    },\
    \"HeadBucket\":{\
      \"name\":\"HeadBucket\",\
      \"http\":{\
        \"method\":\"HEAD\",\
        \"requestUri\":\"/{Bucket}\"\
      },\
      \"input\":{\"shape\":\"HeadBucketRequest\"},\
      \"errors\":[\
        {\"shape\":\"NoSuchBucket\"}\
      ],\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketHEAD.html\",\
      \"documentation\":\"<p>This operation is useful to determine if a bucket exists and you have permission to access it. The operation returns a <code>200 OK</code> if the bucket exists and you have permission to access it. Otherwise, the operation might return responses such as <code>404 Not Found</code> and <code>403 Forbidden</code>. </p> <p>To use this operation, you must have permissions to perform the <code>s3:ListBucket</code> action. The bucket owner has this permission by default and can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p>\"\
    },\
    \"HeadObject\":{\
      \"name\":\"HeadObject\",\
      \"http\":{\
        \"method\":\"HEAD\",\
        \"requestUri\":\"/{Bucket}/{Key+}\"\
      },\
      \"input\":{\"shape\":\"HeadObjectRequest\"},\
      \"output\":{\"shape\":\"HeadObjectOutput\"},\
      \"errors\":[\
        {\"shape\":\"NoSuchKey\"}\
      ],\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectHEAD.html\",\
      \"documentation\":\"<p>The HEAD operation retrieves metadata from an object without returning the object itself. This operation is useful if you're only interested in an object's metadata. To use HEAD, you must have READ access to the object.</p> <p>A <code>HEAD</code> request has the same options as a <code>GET</code> operation on an object. The response is identical to the <code>GET</code> response except that there is no response body.</p> <p>If you encrypt an object by using server-side encryption with customer-provided encryption keys (SSE-C) when you store the object in Amazon S3, then when you retrieve the metadata from the object, you must use the following headers:</p> <ul> <li> <p>x-amz-server-side-encryption-customer-algorithm</p> </li> <li> <p>x-amz-server-side-encryption-customer-key</p> </li> <li> <p>x-amz-server-side-encryption-customer-key-MD5</p> </li> </ul> <p>For more information about SSE-C, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html\\\">Server-Side Encryption (Using Customer-Provided Encryption Keys)</a>.</p> <note> <p>Encryption request headers, like <code>x-amz-server-side-encryption</code>, should not be sent for GET requests if your object uses server-side encryption with CMKs stored in AWS KMS (SSE-KMS) or server-side encryption with Amazon S3âmanaged encryption keys (SSE-S3). If your object does use these types of keys, youâll get an HTTP 400 BadRequest error.</p> </note> <p>Request headers are limited to 8 KB in size. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTCommonRequestHeaders.html\\\">Common Request Headers</a>.</p> <p>Consider the following when using request headers:</p> <ul> <li> <p> Consideration 1 â If both of the <code>If-Match</code> and <code>If-Unmodified-Since</code> headers are present in the request as follows:</p> <ul> <li> <p> <code>If-Match</code> condition evaluates to <code>true</code>, and;</p> </li> <li> <p> <code>If-Unmodified-Since</code> condition evaluates to <code>false</code>;</p> </li> </ul> <p>Then Amazon S3 returns <code>200 OK</code> and the data requested.</p> </li> <li> <p> Consideration 2 â If both of the <code>If-None-Match</code> and <code>If-Modified-Since</code> headers are present in the request as follows:</p> <ul> <li> <p> <code>If-None-Match</code> condition evaluates to <code>false</code>, and;</p> </li> <li> <p> <code>If-Modified-Since</code> condition evaluates to <code>true</code>;</p> </li> </ul> <p>Then Amazon S3 returns the <code>304 Not Modified</code> response code.</p> </li> </ul> <p>For more information about conditional requests, see <a href=\\\"https://tools.ietf.org/html/rfc7232\\\">RFC 7232</a>.</p> <p> <b>Permissions</b> </p> <p>You need the <code>s3:GetObject</code> permission for this operation. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\\\">Specifying Permissions in a Policy</a>. If the object you request does not exist, the error Amazon S3 returns depends on whether you also have the s3:ListBucket permission.</p> <ul> <li> <p>If you have the <code>s3:ListBucket</code> permission on the bucket, Amazon S3 returns an HTTP status code 404 (\\\"no such key\\\") error.</p> </li> <li> <p>If you donât have the <code>s3:ListBucket</code> permission, Amazon S3 returns an HTTP status code 403 (\\\"access denied\\\") error.</p> </li> </ul> <p>The following operation is related to <code>HeadObject</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a> </p> </li> </ul>\"\
    },\
    \"ListBucketAnalyticsConfigurations\":{\
      \"name\":\"ListBucketAnalyticsConfigurations\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?analytics\"\
      },\
      \"input\":{\"shape\":\"ListBucketAnalyticsConfigurationsRequest\"},\
      \"output\":{\"shape\":\"ListBucketAnalyticsConfigurationsOutput\"},\
      \"documentation\":\"<p>Lists the analytics configurations for the bucket. You can have up to 1,000 analytics configurations per bucket.</p> <p>This operation supports list pagination and does not return more than 100 configurations at a time. You should always check the <code>IsTruncated</code> element in the response. If there are no more configurations to list, <code>IsTruncated</code> is set to false. If there are more configurations to list, <code>IsTruncated</code> is set to true, and there will be a value in <code>NextContinuationToken</code>. You use the <code>NextContinuationToken</code> value to continue the pagination of the list by passing the value in continuation-token in the request to <code>GET</code> the next page.</p> <p>To use this operation, you must have permissions to perform the <code>s3:GetAnalyticsConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>For information about Amazon S3 analytics feature, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/analytics-storage-class.html\\\">Amazon S3 Analytics â Storage Class Analysis</a>. </p> <p>The following operations are related to <code>ListBucketAnalyticsConfigurations</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketAnalyticsConfiguration.html\\\">GetBucketAnalyticsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketAnalyticsConfiguration.html\\\">DeleteBucketAnalyticsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketAnalyticsConfiguration.html\\\">PutBucketAnalyticsConfiguration</a> </p> </li> </ul>\"\
    },\
    \"ListBucketInventoryConfigurations\":{\
      \"name\":\"ListBucketInventoryConfigurations\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?inventory\"\
      },\
      \"input\":{\"shape\":\"ListBucketInventoryConfigurationsRequest\"},\
      \"output\":{\"shape\":\"ListBucketInventoryConfigurationsOutput\"},\
      \"documentation\":\"<p>Returns a list of inventory configurations for the bucket. You can have up to 1,000 analytics configurations per bucket.</p> <p>This operation supports list pagination and does not return more than 100 configurations at a time. Always check the <code>IsTruncated</code> element in the response. If there are no more configurations to list, <code>IsTruncated</code> is set to false. If there are more configurations to list, <code>IsTruncated</code> is set to true, and there is a value in <code>NextContinuationToken</code>. You use the <code>NextContinuationToken</code> value to continue the pagination of the list by passing the value in continuation-token in the request to <code>GET</code> the next page.</p> <p> To use this operation, you must have permissions to perform the <code>s3:GetInventoryConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>For information about the Amazon S3 inventory feature, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-inventory.html\\\">Amazon S3 Inventory</a> </p> <p>The following operations are related to <code>ListBucketInventoryConfigurations</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketInventoryConfiguration.html\\\">GetBucketInventoryConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketInventoryConfiguration.html\\\">DeleteBucketInventoryConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketInventoryConfiguration.html\\\">PutBucketInventoryConfiguration</a> </p> </li> </ul>\"\
    },\
    \"ListBucketMetricsConfigurations\":{\
      \"name\":\"ListBucketMetricsConfigurations\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?metrics\"\
      },\
      \"input\":{\"shape\":\"ListBucketMetricsConfigurationsRequest\"},\
      \"output\":{\"shape\":\"ListBucketMetricsConfigurationsOutput\"},\
      \"documentation\":\"<p>Lists the metrics configurations for the bucket. The metrics configurations are only for the request metrics of the bucket and do not provide information on daily storage metrics. You can have up to 1,000 configurations per bucket.</p> <p>This operation supports list pagination and does not return more than 100 configurations at a time. Always check the <code>IsTruncated</code> element in the response. If there are no more configurations to list, <code>IsTruncated</code> is set to false. If there are more configurations to list, <code>IsTruncated</code> is set to true, and there is a value in <code>NextContinuationToken</code>. You use the <code>NextContinuationToken</code> value to continue the pagination of the list by passing the value in <code>continuation-token</code> in the request to <code>GET</code> the next page.</p> <p>To use this operation, you must have permissions to perform the <code>s3:GetMetricsConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>For more information about metrics configurations and CloudWatch request metrics, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cloudwatch-monitoring.html\\\">Monitoring Metrics with Amazon CloudWatch</a>.</p> <p>The following operations are related to <code>ListBucketMetricsConfigurations</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketMetricsConfiguration.html\\\">PutBucketMetricsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketMetricsConfiguration.html\\\">GetBucketMetricsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketMetricsConfiguration.html\\\">DeleteBucketMetricsConfiguration</a> </p> </li> </ul>\"\
    },\
    \"ListBuckets\":{\
      \"name\":\"ListBuckets\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/\"\
      },\
      \"output\":{\"shape\":\"ListBucketsOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTServiceGET.html\",\
      \"documentation\":\"<p>Returns a list of all buckets owned by the authenticated sender of the request.</p>\",\
      \"alias\":\"GetService\"\
    },\
    \"ListMultipartUploads\":{\
      \"name\":\"ListMultipartUploads\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?uploads\"\
      },\
      \"input\":{\"shape\":\"ListMultipartUploadsRequest\"},\
      \"output\":{\"shape\":\"ListMultipartUploadsOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadListMPUpload.html\",\
      \"documentation\":\"<p>This operation lists in-progress multipart uploads. An in-progress multipart upload is a multipart upload that has been initiated using the Initiate Multipart Upload request, but has not yet been completed or aborted.</p> <p>This operation returns at most 1,000 multipart uploads in the response. 1,000 multipart uploads is the maximum number of uploads a response can include, which is also the default value. You can further limit the number of uploads in a response by specifying the <code>max-uploads</code> parameter in the response. If additional multipart uploads satisfy the list criteria, the response will contain an <code>IsTruncated</code> element with the value true. To list the additional multipart uploads, use the <code>key-marker</code> and <code>upload-id-marker</code> request parameters.</p> <p>In the response, the uploads are sorted by key. If your application has initiated more than one multipart upload using the same object key, then uploads in the response are first sorted by key. Additionally, uploads are sorted in ascending order within each key by the upload initiation time.</p> <p>For more information on multipart uploads, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/uploadobjusingmpu.html\\\">Uploading Objects Using Multipart Upload</a>.</p> <p>For information on permissions required to use the multipart upload API, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html\\\">Multipart Upload API and Permissions</a>.</p> <p>The following operations are related to <code>ListMultipartUploads</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html\\\">CreateMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html\\\">UploadPart</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CompleteMultipartUpload.html\\\">CompleteMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListParts.html\\\">ListParts</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_AbortMultipartUpload.html\\\">AbortMultipartUpload</a> </p> </li> </ul>\"\
    },\
    \"ListObjectVersions\":{\
      \"name\":\"ListObjectVersions\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?versions\"\
      },\
      \"input\":{\"shape\":\"ListObjectVersionsRequest\"},\
      \"output\":{\"shape\":\"ListObjectVersionsOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETVersion.html\",\
      \"documentation\":\"<p>Returns metadata about all versions of the objects in a bucket. You can also use request parameters as selection criteria to return metadata about a subset of all the object versions. </p> <note> <p> A 200 OK response can contain valid or invalid XML. Make sure to design your application to parse the contents of the response and handle it appropriately.</p> </note> <p>To use this operation, you must have READ access to the bucket.</p> <p>This action is not supported by Amazon S3 on Outposts.</p> <p>The following operations are related to <code>ListObjectVersions</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjectsV2.html\\\">ListObjectsV2</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html\\\">PutObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObject.html\\\">DeleteObject</a> </p> </li> </ul>\",\
      \"alias\":\"GetBucketObjectVersions\"\
    },\
    \"ListObjects\":{\
      \"name\":\"ListObjects\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}\"\
      },\
      \"input\":{\"shape\":\"ListObjectsRequest\"},\
      \"output\":{\"shape\":\"ListObjectsOutput\"},\
      \"errors\":[\
        {\"shape\":\"NoSuchBucket\"}\
      ],\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGET.html\",\
      \"documentation\":\"<p>Returns some or all (up to 1,000) of the objects in a bucket. You can use the request parameters as selection criteria to return a subset of the objects in a bucket. A 200 OK response can contain valid or invalid XML. Be sure to design your application to parse the contents of the response and handle it appropriately.</p> <important> <p>This API has been revised. We recommend that you use the newer version, <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjectsV2.html\\\">ListObjectsV2</a>, when developing applications. For backward compatibility, Amazon S3 continues to support <code>ListObjects</code>.</p> </important> <p>The following operations are related to <code>ListObjects</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjectsV2.html\\\">ListObjectsV2</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html\\\">PutObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBuckets.html\\\">ListBuckets</a> </p> </li> </ul>\",\
      \"alias\":\"GetBucket\"\
    },\
    \"ListObjectsV2\":{\
      \"name\":\"ListObjectsV2\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}?list-type=2\"\
      },\
      \"input\":{\"shape\":\"ListObjectsV2Request\"},\
      \"output\":{\"shape\":\"ListObjectsV2Output\"},\
      \"errors\":[\
        {\"shape\":\"NoSuchBucket\"}\
      ],\
      \"documentation\":\"<p>Returns some or all (up to 1,000) of the objects in a bucket. You can use the request parameters as selection criteria to return a subset of the objects in a bucket. A <code>200 OK</code> response can contain valid or invalid XML. Make sure to design your application to parse the contents of the response and handle it appropriately.</p> <p>To use this operation, you must have READ access to the bucket.</p> <p>To use this operation in an AWS Identity and Access Management (IAM) policy, you must have permissions to perform the <code>s3:ListBucket</code> action. The bucket owner has this permission by default and can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <important> <p>This section describes the latest revision of the API. We recommend that you use this revised API for application development. For backward compatibility, Amazon S3 continues to support the prior version of this API, <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjects.html\\\">ListObjects</a>.</p> </important> <p>To get a list of your buckets, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBuckets.html\\\">ListBuckets</a>.</p> <p>The following operations are related to <code>ListObjectsV2</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html\\\">PutObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a> </p> </li> </ul>\"\
    },\
    \"ListParts\":{\
      \"name\":\"ListParts\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/{Bucket}/{Key+}\"\
      },\
      \"input\":{\"shape\":\"ListPartsRequest\"},\
      \"output\":{\"shape\":\"ListPartsOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadListParts.html\",\
      \"documentation\":\"<p>Lists the parts that have been uploaded for a specific multipart upload. This operation must include the upload ID, which you obtain by sending the initiate multipart upload request (see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html\\\">CreateMultipartUpload</a>). This request returns a maximum of 1,000 uploaded parts. The default number of parts returned is 1,000 parts. You can restrict the number of parts returned by specifying the <code>max-parts</code> request parameter. If your multipart upload consists of more than 1,000 parts, the response returns an <code>IsTruncated</code> field with the value of true, and a <code>NextPartNumberMarker</code> element. In subsequent <code>ListParts</code> requests you can include the part-number-marker query string parameter and set its value to the <code>NextPartNumberMarker</code> field value from the previous response.</p> <p>For more information on multipart uploads, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/uploadobjusingmpu.html\\\">Uploading Objects Using Multipart Upload</a>.</p> <p>For information on permissions required to use the multipart upload API, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html\\\">Multipart Upload API and Permissions</a>.</p> <p>The following operations are related to <code>ListParts</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html\\\">CreateMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html\\\">UploadPart</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CompleteMultipartUpload.html\\\">CompleteMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_AbortMultipartUpload.html\\\">AbortMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListMultipartUploads.html\\\">ListMultipartUploads</a> </p> </li> </ul>\"\
    },\
    \"PutBucketAccelerateConfiguration\":{\
      \"name\":\"PutBucketAccelerateConfiguration\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?accelerate\"\
      },\
      \"input\":{\"shape\":\"PutBucketAccelerateConfigurationRequest\"},\
      \"documentation\":\"<p>Sets the accelerate configuration of an existing bucket. Amazon S3 Transfer Acceleration is a bucket-level feature that enables you to perform faster data transfers to Amazon S3.</p> <p> To use this operation, you must have permission to perform the s3:PutAccelerateConfiguration action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p> The Transfer Acceleration state of a bucket can be set to one of the following two values:</p> <ul> <li> <p> Enabled â Enables accelerated data transfers to the bucket.</p> </li> <li> <p> Suspended â Disables accelerated data transfers to the bucket.</p> </li> </ul> <p>The <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketAccelerateConfiguration.html\\\">GetBucketAccelerateConfiguration</a> operation returns the transfer acceleration state of a bucket.</p> <p>After setting the Transfer Acceleration state of a bucket to Enabled, it might take up to thirty minutes before the data transfer rates to the bucket increase.</p> <p> The name of the bucket used for Transfer Acceleration must be DNS-compliant and must not contain periods (\\\".\\\").</p> <p> For more information about transfer acceleration, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html\\\">Transfer Acceleration</a>.</p> <p>The following operations are related to <code>PutBucketAccelerateConfiguration</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketAccelerateConfiguration.html\\\">GetBucketAccelerateConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a> </p> </li> </ul>\"\
    },\
    \"PutBucketAcl\":{\
      \"name\":\"PutBucketAcl\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?acl\"\
      },\
      \"input\":{\"shape\":\"PutBucketAclRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTacl.html\",\
      \"documentation\":\"<p>Sets the permissions on an existing bucket using access control lists (ACL). For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html\\\">Using ACLs</a>. To set the ACL of a bucket, you must have <code>WRITE_ACP</code> permission.</p> <p>You can use one of the following two ways to set a bucket's permissions:</p> <ul> <li> <p>Specify the ACL in the request body</p> </li> <li> <p>Specify permissions using request headers</p> </li> </ul> <note> <p>You cannot specify access permission using both the body and the request headers.</p> </note> <p>Depending on your application needs, you may choose to set the ACL on a bucket using either the request body or the headers. For example, if you have an existing application that updates a bucket ACL using the request body, then you can continue to use that approach.</p> <p> <b>Access Permissions</b> </p> <p>You can set access permissions using one of the following methods:</p> <ul> <li> <p>Specify a canned ACL with the <code>x-amz-acl</code> request header. Amazon S3 supports a set of predefined ACLs, known as <i>canned ACLs</i>. Each canned ACL has a predefined set of grantees and permissions. Specify the canned ACL name as the value of <code>x-amz-acl</code>. If you use this header, you cannot use other access control-specific headers in your request. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\\\">Canned ACL</a>.</p> </li> <li> <p>Specify access permissions explicitly with the <code>x-amz-grant-read</code>, <code>x-amz-grant-read-acp</code>, <code>x-amz-grant-write-acp</code>, and <code>x-amz-grant-full-control</code> headers. When using these headers, you specify explicit access permissions and grantees (AWS accounts or Amazon S3 groups) who will receive the permission. If you use these ACL-specific headers, you cannot use the <code>x-amz-acl</code> header to set a canned ACL. These parameters map to the set of permissions that Amazon S3 supports in an ACL. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\\\">Access Control List (ACL) Overview</a>.</p> <p>You specify each grantee as a type=value pair, where the type is one of the following:</p> <ul> <li> <p> <code>id</code> â if the value specified is the canonical user ID of an AWS account</p> </li> <li> <p> <code>uri</code> â if you are granting permissions to a predefined group</p> </li> <li> <p> <code>emailAddress</code> â if the value specified is the email address of an AWS account</p> <note> <p>Using email addresses to specify a grantee is only supported in the following AWS Regions: </p> <ul> <li> <p>US East (N. Virginia)</p> </li> <li> <p>US West (N. California)</p> </li> <li> <p> US West (Oregon)</p> </li> <li> <p> Asia Pacific (Singapore)</p> </li> <li> <p>Asia Pacific (Sydney)</p> </li> <li> <p>Asia Pacific (Tokyo)</p> </li> <li> <p>Europe (Ireland)</p> </li> <li> <p>South America (SÃ£o Paulo)</p> </li> </ul> <p>For a list of all the Amazon S3 supported Regions and endpoints, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region\\\">Regions and Endpoints</a> in the AWS General Reference.</p> </note> </li> </ul> <p>For example, the following <code>x-amz-grant-write</code> header grants create, overwrite, and delete objects permission to LogDelivery group predefined by Amazon S3 and two AWS accounts identified by their email addresses.</p> <p> <code>x-amz-grant-write: uri=\\\"http://acs.amazonaws.com/groups/s3/LogDelivery\\\", id=\\\"111122223333\\\", id=\\\"555566667777\\\" </code> </p> </li> </ul> <p>You can use either a canned ACL or specify access permissions explicitly. You cannot do both.</p> <p> <b>Grantee Values</b> </p> <p>You can specify the person (grantee) to whom you're assigning access rights (using request elements) in the following ways:</p> <ul> <li> <p>By the person's ID:</p> <p> <code>&lt;Grantee xmlns:xsi=\\\"http://www.w3.org/2001/XMLSchema-instance\\\" xsi:type=\\\"CanonicalUser\\\"&gt;&lt;ID&gt;&lt;&gt;ID&lt;&gt;&lt;/ID&gt;&lt;DisplayName&gt;&lt;&gt;GranteesEmail&lt;&gt;&lt;/DisplayName&gt; &lt;/Grantee&gt;</code> </p> <p>DisplayName is optional and ignored in the request</p> </li> <li> <p>By URI:</p> <p> <code>&lt;Grantee xmlns:xsi=\\\"http://www.w3.org/2001/XMLSchema-instance\\\" xsi:type=\\\"Group\\\"&gt;&lt;URI&gt;&lt;&gt;http://acs.amazonaws.com/groups/global/AuthenticatedUsers&lt;&gt;&lt;/URI&gt;&lt;/Grantee&gt;</code> </p> </li> <li> <p>By Email address:</p> <p> <code>&lt;Grantee xmlns:xsi=\\\"http://www.w3.org/2001/XMLSchema-instance\\\" xsi:type=\\\"AmazonCustomerByEmail\\\"&gt;&lt;EmailAddress&gt;&lt;&gt;Grantees@email.com&lt;&gt;&lt;/EmailAddress&gt;lt;/Grantee&gt;</code> </p> <p>The grantee is resolved to the CanonicalUser and, in a response to a GET Object acl request, appears as the CanonicalUser. </p> <note> <p>Using email addresses to specify a grantee is only supported in the following AWS Regions: </p> <ul> <li> <p>US East (N. Virginia)</p> </li> <li> <p>US West (N. California)</p> </li> <li> <p> US West (Oregon)</p> </li> <li> <p> Asia Pacific (Singapore)</p> </li> <li> <p>Asia Pacific (Sydney)</p> </li> <li> <p>Asia Pacific (Tokyo)</p> </li> <li> <p>Europe (Ireland)</p> </li> <li> <p>South America (SÃ£o Paulo)</p> </li> </ul> <p>For a list of all the Amazon S3 supported Regions and endpoints, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region\\\">Regions and Endpoints</a> in the AWS General Reference.</p> </note> </li> </ul> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucket.html\\\">DeleteBucket</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectAcl.html\\\">GetObjectAcl</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutBucketAnalyticsConfiguration\":{\
      \"name\":\"PutBucketAnalyticsConfiguration\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?analytics\"\
      },\
      \"input\":{\"shape\":\"PutBucketAnalyticsConfigurationRequest\"},\
      \"documentation\":\"<p>Sets an analytics configuration for the bucket (specified by the analytics configuration ID). You can have up to 1,000 analytics configurations per bucket.</p> <p>You can choose to have storage class analysis export analysis reports sent to a comma-separated values (CSV) flat file. See the <code>DataExport</code> request element. Reports are updated daily and are based on the object filters that you configure. When selecting data export, you specify a destination bucket and an optional destination prefix where the file is written. You can export the data to a destination bucket in a different account. However, the destination bucket must be in the same Region as the bucket that you are making the PUT analytics configuration to. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/analytics-storage-class.html\\\">Amazon S3 Analytics â Storage Class Analysis</a>. </p> <important> <p>You must create a bucket policy on the destination bucket where the exported file is written to grant permissions to Amazon S3 to write objects to the bucket. For an example policy, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/example-bucket-policies.html#example-bucket-policies-use-case-9\\\">Granting Permissions for Amazon S3 Inventory and Storage Class Analysis</a>.</p> </important> <p>To use this operation, you must have permissions to perform the <code>s3:PutAnalyticsConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p class=\\\"title\\\"> <b>Special Errors</b> </p> <ul> <li> <ul> <li> <p> <i>HTTP Error: HTTP 400 Bad Request</i> </p> </li> <li> <p> <i>Code: InvalidArgument</i> </p> </li> <li> <p> <i>Cause: Invalid argument.</i> </p> </li> </ul> </li> <li> <ul> <li> <p> <i>HTTP Error: HTTP 400 Bad Request</i> </p> </li> <li> <p> <i>Code: TooManyConfigurations</i> </p> </li> <li> <p> <i>Cause: You are attempting to create a new configuration but have already reached the 1,000-configuration limit.</i> </p> </li> </ul> </li> <li> <ul> <li> <p> <i>HTTP Error: HTTP 403 Forbidden</i> </p> </li> <li> <p> <i>Code: AccessDenied</i> </p> </li> <li> <p> <i>Cause: You are not the owner of the specified bucket, or you do not have the s3:PutAnalyticsConfiguration bucket permission to set the configuration on the bucket.</i> </p> </li> </ul> </li> </ul> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketAnalyticsConfiguration.html\\\">GetBucketAnalyticsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketAnalyticsConfiguration.html\\\">DeleteBucketAnalyticsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBucketAnalyticsConfigurations.html\\\">ListBucketAnalyticsConfigurations</a> </p> </li> </ul>\"\
    },\
    \"PutBucketCors\":{\
      \"name\":\"PutBucketCors\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?cors\"\
      },\
      \"input\":{\"shape\":\"PutBucketCorsRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTcors.html\",\
      \"documentation\":\"<p>Sets the <code>cors</code> configuration for your bucket. If the configuration exists, Amazon S3 replaces it.</p> <p>To use this operation, you must be allowed to perform the <code>s3:PutBucketCORS</code> action. By default, the bucket owner has this permission and can grant it to others.</p> <p>You set this configuration on a bucket so that the bucket can service cross-origin requests. For example, you might want to enable a request whose origin is <code>http://www.example.com</code> to access your Amazon S3 bucket at <code>my.example.bucket.com</code> by using the browser's <code>XMLHttpRequest</code> capability.</p> <p>To enable cross-origin resource sharing (CORS) on a bucket, you add the <code>cors</code> subresource to the bucket. The <code>cors</code> subresource is an XML document in which you configure rules that identify origins and the HTTP methods that can be executed on your bucket. The document is limited to 64 KB in size. </p> <p>When Amazon S3 receives a cross-origin request (or a pre-flight OPTIONS request) against a bucket, it evaluates the <code>cors</code> configuration on the bucket and uses the first <code>CORSRule</code> rule that matches the incoming browser request to enable a cross-origin request. For a rule to match, the following conditions must be met:</p> <ul> <li> <p>The request's <code>Origin</code> header must match <code>AllowedOrigin</code> elements.</p> </li> <li> <p>The request method (for example, GET, PUT, HEAD, and so on) or the <code>Access-Control-Request-Method</code> header in case of a pre-flight <code>OPTIONS</code> request must be one of the <code>AllowedMethod</code> elements. </p> </li> <li> <p>Every header specified in the <code>Access-Control-Request-Headers</code> request header of a pre-flight request must match an <code>AllowedHeader</code> element. </p> </li> </ul> <p> For more information about CORS, go to <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html\\\">Enabling Cross-Origin Resource Sharing</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketCors.html\\\">GetBucketCors</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketCors.html\\\">DeleteBucketCors</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTOPTIONSobject.html\\\">RESTOPTIONSobject</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutBucketEncryption\":{\
      \"name\":\"PutBucketEncryption\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?encryption\"\
      },\
      \"input\":{\"shape\":\"PutBucketEncryptionRequest\"},\
      \"documentation\":\"<p>This implementation of the <code>PUT</code> operation uses the <code>encryption</code> subresource to set the default encryption state of an existing bucket.</p> <p>This implementation of the <code>PUT</code> operation sets default encryption for a bucket using server-side encryption with Amazon S3-managed keys SSE-S3 or AWS KMS customer master keys (CMKs) (SSE-KMS). For information about the Amazon S3 default encryption feature, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html\\\">Amazon S3 Default Bucket Encryption</a>.</p> <important> <p>This operation requires AWS Signature Version 4. For more information, see <a href=\\\"sig-v4-authenticating-requests.html\\\"> Authenticating Requests (AWS Signature Version 4)</a>. </p> </important> <p>To use this operation, you must have permissions to perform the <code>s3:PutEncryptionConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a> in the Amazon Simple Storage Service Developer Guide. </p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketEncryption.html\\\">GetBucketEncryption</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketEncryption.html\\\">DeleteBucketEncryption</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutBucketInventoryConfiguration\":{\
      \"name\":\"PutBucketInventoryConfiguration\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?inventory\"\
      },\
      \"input\":{\"shape\":\"PutBucketInventoryConfigurationRequest\"},\
      \"documentation\":\"<p>This implementation of the <code>PUT</code> operation adds an inventory configuration (identified by the inventory ID) to the bucket. You can have up to 1,000 inventory configurations per bucket. </p> <p>Amazon S3 inventory generates inventories of the objects in the bucket on a daily or weekly basis, and the results are published to a flat file. The bucket that is inventoried is called the <i>source</i> bucket, and the bucket where the inventory flat file is stored is called the <i>destination</i> bucket. The <i>destination</i> bucket must be in the same AWS Region as the <i>source</i> bucket. </p> <p>When you configure an inventory for a <i>source</i> bucket, you specify the <i>destination</i> bucket where you want the inventory to be stored, and whether to generate the inventory daily or weekly. You can also configure what object metadata to include and whether to inventory all object versions or only current versions. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-inventory.html\\\">Amazon S3 Inventory</a> in the Amazon Simple Storage Service Developer Guide.</p> <important> <p>You must create a bucket policy on the <i>destination</i> bucket to grant permissions to Amazon S3 to write objects to the bucket in the defined location. For an example policy, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/example-bucket-policies.html#example-bucket-policies-use-case-9\\\"> Granting Permissions for Amazon S3 Inventory and Storage Class Analysis</a>.</p> </important> <p>To use this operation, you must have permissions to perform the <code>s3:PutInventoryConfiguration</code> action. The bucket owner has this permission by default and can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a> in the Amazon Simple Storage Service Developer Guide.</p> <p class=\\\"title\\\"> <b>Special Errors</b> </p> <ul> <li> <p class=\\\"title\\\"> <b>HTTP 400 Bad Request Error</b> </p> <ul> <li> <p> <i>Code:</i> InvalidArgument</p> </li> <li> <p> <i>Cause:</i> Invalid Argument</p> </li> </ul> </li> <li> <p class=\\\"title\\\"> <b>HTTP 400 Bad Request Error</b> </p> <ul> <li> <p> <i>Code:</i> TooManyConfigurations</p> </li> <li> <p> <i>Cause:</i> You are attempting to create a new configuration but have already reached the 1,000-configuration limit. </p> </li> </ul> </li> <li> <p class=\\\"title\\\"> <b>HTTP 403 Forbidden Error</b> </p> <ul> <li> <p> <i>Code:</i> AccessDenied</p> </li> <li> <p> <i>Cause:</i> You are not the owner of the specified bucket, or you do not have the <code>s3:PutInventoryConfiguration</code> bucket permission to set the configuration on the bucket. </p> </li> </ul> </li> </ul> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketInventoryConfiguration.html\\\">GetBucketInventoryConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketInventoryConfiguration.html\\\">DeleteBucketInventoryConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBucketInventoryConfigurations.html\\\">ListBucketInventoryConfigurations</a> </p> </li> </ul>\"\
    },\
    \"PutBucketLifecycle\":{\
      \"name\":\"PutBucketLifecycle\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?lifecycle\"\
      },\
      \"input\":{\"shape\":\"PutBucketLifecycleRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTlifecycle.html\",\
      \"documentation\":\"<important> <p>For an updated version of this API, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html\\\">PutBucketLifecycleConfiguration</a>. This version has been deprecated. Existing lifecycle configurations will work. For new lifecycle configurations, use the updated API. </p> </important> <p>Creates a new lifecycle configuration for the bucket or replaces an existing lifecycle configuration. For information about lifecycle configuration, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html\\\">Object Lifecycle Management</a> in the <i>Amazon Simple Storage Service Developer Guide</i>. </p> <p>By default, all Amazon S3 resources, including buckets, objects, and related subresources (for example, lifecycle configuration and website configuration) are private. Only the resource owner, the AWS account that created the resource, can access it. The resource owner can optionally grant access permissions to others by writing an access policy. For this operation, users must get the <code>s3:PutLifecycleConfiguration</code> permission.</p> <p>You can also explicitly deny permissions. Explicit denial also supersedes any other permissions. If you want to prevent users or accounts from removing or deleting objects from your bucket, you must deny them permissions for the following actions: </p> <ul> <li> <p> <code>s3:DeleteObject</code> </p> </li> <li> <p> <code>s3:DeleteObjectVersion</code> </p> </li> <li> <p> <code>s3:PutLifecycleConfiguration</code> </p> </li> </ul> <p>For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to your Amazon S3 Resources</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>For more examples of transitioning objects to storage classes such as STANDARD_IA or ONEZONE_IA, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#lifecycle-configuration-examples\\\">Examples of Lifecycle Configuration</a>.</p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycle.html\\\">GetBucketLifecycle</a>(Deprecated)</p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycleConfiguration.html\\\">GetBucketLifecycleConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_RestoreObject.html\\\">RestoreObject</a> </p> </li> <li> <p>By default, a resource ownerâin this case, a bucket owner, which is the AWS account that created the bucketâcan perform any of the operations. A resource owner can also grant others permission to perform the operation. For more information, see the following topics in the Amazon Simple Storage Service Developer Guide: </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\\\">Specifying Permissions in a Policy</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to your Amazon S3 Resources</a> </p> </li> </ul> </li> </ul>\",\
      \"deprecated\":true,\
      \"httpChecksumRequired\":true\
    },\
    \"PutBucketLifecycleConfiguration\":{\
      \"name\":\"PutBucketLifecycleConfiguration\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?lifecycle\"\
      },\
      \"input\":{\"shape\":\"PutBucketLifecycleConfigurationRequest\"},\
      \"documentation\":\"<p>Creates a new lifecycle configuration for the bucket or replaces an existing lifecycle configuration. For information about lifecycle configuration, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <note> <p>Bucket lifecycle configuration now supports specifying a lifecycle rule using an object key name prefix, one or more object tags, or a combination of both. Accordingly, this section describes the latest API. The previous version of the API supported filtering based only on an object key name prefix, which is supported for backward compatibility. For the related API description, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycle.html\\\">PutBucketLifecycle</a>.</p> </note> <p> <b>Rules</b> </p> <p>You specify the lifecycle configuration in your request body. The lifecycle configuration is specified as XML consisting of one or more rules. Each rule consists of the following:</p> <ul> <li> <p>Filter identifying a subset of objects to which the rule applies. The filter can be based on a key name prefix, object tags, or a combination of both.</p> </li> <li> <p>Status whether the rule is in effect.</p> </li> <li> <p>One or more lifecycle transition and expiration actions that you want Amazon S3 to perform on the objects identified by the filter. If the state of your bucket is versioning-enabled or versioning-suspended, you can have many versions of the same object (one current version and zero or more noncurrent versions). Amazon S3 provides predefined actions that you can specify for current and noncurrent object versions.</p> </li> </ul> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html\\\">Object Lifecycle Management</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html\\\">Lifecycle Configuration Elements</a>.</p> <p> <b>Permissions</b> </p> <p>By default, all Amazon S3 resources are private, including buckets, objects, and related subresources (for example, lifecycle configuration and website configuration). Only the resource owner (that is, the AWS account that created it) can access the resource. The resource owner can optionally grant access permissions to others by writing an access policy. For this operation, a user must get the s3:PutLifecycleConfiguration permission.</p> <p>You can also explicitly deny permissions. Explicit deny also supersedes any other permissions. If you want to block users or accounts from removing or deleting objects from your bucket, you must deny them permissions for the following actions:</p> <ul> <li> <p>s3:DeleteObject</p> </li> <li> <p>s3:DeleteObjectVersion</p> </li> <li> <p>s3:PutLifecycleConfiguration</p> </li> </ul> <p>For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>The following are related to <code>PutBucketLifecycleConfiguration</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/lifecycle-configuration-examples.html\\\">Examples of Lifecycle Configuration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycleConfiguration.html\\\">GetBucketLifecycleConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketLifecycle.html\\\">DeleteBucketLifecycle</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutBucketLogging\":{\
      \"name\":\"PutBucketLogging\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?logging\"\
      },\
      \"input\":{\"shape\":\"PutBucketLoggingRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTlogging.html\",\
      \"documentation\":\"<p>Set the logging parameters for a bucket and to specify permissions for who can view and modify the logging parameters. All logs are saved to buckets in the same AWS Region as the source bucket. To set the logging status of a bucket, you must be the bucket owner.</p> <p>The bucket owner is automatically granted FULL_CONTROL to all logs. You use the <code>Grantee</code> request element to grant access to other people. The <code>Permissions</code> request element specifies the kind of access the grantee has to the logs.</p> <p> <b>Grantee Values</b> </p> <p>You can specify the person (grantee) to whom you're assigning access rights (using request elements) in the following ways:</p> <ul> <li> <p>By the person's ID:</p> <p> <code>&lt;Grantee xmlns:xsi=\\\"http://www.w3.org/2001/XMLSchema-instance\\\" xsi:type=\\\"CanonicalUser\\\"&gt;&lt;ID&gt;&lt;&gt;ID&lt;&gt;&lt;/ID&gt;&lt;DisplayName&gt;&lt;&gt;GranteesEmail&lt;&gt;&lt;/DisplayName&gt; &lt;/Grantee&gt;</code> </p> <p>DisplayName is optional and ignored in the request.</p> </li> <li> <p>By Email address:</p> <p> <code> &lt;Grantee xmlns:xsi=\\\"http://www.w3.org/2001/XMLSchema-instance\\\" xsi:type=\\\"AmazonCustomerByEmail\\\"&gt;&lt;EmailAddress&gt;&lt;&gt;Grantees@email.com&lt;&gt;&lt;/EmailAddress&gt;&lt;/Grantee&gt;</code> </p> <p>The grantee is resolved to the CanonicalUser and, in a response to a GET Object acl request, appears as the CanonicalUser.</p> </li> <li> <p>By URI:</p> <p> <code>&lt;Grantee xmlns:xsi=\\\"http://www.w3.org/2001/XMLSchema-instance\\\" xsi:type=\\\"Group\\\"&gt;&lt;URI&gt;&lt;&gt;http://acs.amazonaws.com/groups/global/AuthenticatedUsers&lt;&gt;&lt;/URI&gt;&lt;/Grantee&gt;</code> </p> </li> </ul> <p>To enable logging, you use LoggingEnabled and its children request elements. To disable logging, you use an empty BucketLoggingStatus request element:</p> <p> <code>&lt;BucketLoggingStatus xmlns=\\\"http://doc.s3.amazonaws.com/2006-03-01\\\" /&gt;</code> </p> <p>For more information about server access logging, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerLogs.html\\\">Server Access Logging</a>. </p> <p>For more information about creating a bucket, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a>. For more information about returning the logging status of a bucket, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLogging.html\\\">GetBucketLogging</a>.</p> <p>The following operations are related to <code>PutBucketLogging</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html\\\">PutObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucket.html\\\">DeleteBucket</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLogging.html\\\">GetBucketLogging</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutBucketMetricsConfiguration\":{\
      \"name\":\"PutBucketMetricsConfiguration\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?metrics\"\
      },\
      \"input\":{\"shape\":\"PutBucketMetricsConfigurationRequest\"},\
      \"documentation\":\"<p>Sets a metrics configuration (specified by the metrics configuration ID) for the bucket. You can have up to 1,000 metrics configurations per bucket. If you're updating an existing metrics configuration, note that this is a full replacement of the existing metrics configuration. If you don't include the elements you want to keep, they are erased.</p> <p>To use this operation, you must have permissions to perform the <code>s3:PutMetricsConfiguration</code> action. The bucket owner has this permission by default. The bucket owner can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p>For information about CloudWatch request metrics for Amazon S3, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cloudwatch-monitoring.html\\\">Monitoring Metrics with Amazon CloudWatch</a>.</p> <p>The following operations are related to <code>PutBucketMetricsConfiguration</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketMetricsConfiguration.html\\\">DeleteBucketMetricsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketMetricsConfiguration.html\\\">PutBucketMetricsConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBucketMetricsConfigurations.html\\\">ListBucketMetricsConfigurations</a> </p> </li> </ul> <p> <code>GetBucketLifecycle</code> has the following special error:</p> <ul> <li> <p>Error code: <code>TooManyConfigurations</code> </p> <ul> <li> <p>Description: You are attempting to create a new configuration but have already reached the 1,000-configuration limit.</p> </li> <li> <p>HTTP Status Code: HTTP 400 Bad Request</p> </li> </ul> </li> </ul>\"\
    },\
    \"PutBucketNotification\":{\
      \"name\":\"PutBucketNotification\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?notification\"\
      },\
      \"input\":{\"shape\":\"PutBucketNotificationRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTnotification.html\",\
      \"documentation\":\"<p> No longer used, see the <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketNotificationConfiguration.html\\\">PutBucketNotificationConfiguration</a> operation.</p>\",\
      \"deprecated\":true,\
      \"httpChecksumRequired\":true\
    },\
    \"PutBucketNotificationConfiguration\":{\
      \"name\":\"PutBucketNotificationConfiguration\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?notification\"\
      },\
      \"input\":{\"shape\":\"PutBucketNotificationConfigurationRequest\"},\
      \"documentation\":\"<p>Enables notifications of specified events for a bucket. For more information about event notifications, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\\\">Configuring Event Notifications</a>.</p> <p>Using this API, you can replace an existing notification configuration. The configuration is an XML file that defines the event types that you want Amazon S3 to publish and the destination where you want Amazon S3 to publish an event notification when it detects an event of the specified type.</p> <p>By default, your bucket has no event notifications configured. That is, the notification configuration will be an empty <code>NotificationConfiguration</code>.</p> <p> <code>&lt;NotificationConfiguration&gt;</code> </p> <p> <code>&lt;/NotificationConfiguration&gt;</code> </p> <p>This operation replaces the existing notification configuration with the configuration you include in the request body.</p> <p>After Amazon S3 receives this request, it first verifies that any Amazon Simple Notification Service (Amazon SNS) or Amazon Simple Queue Service (Amazon SQS) destination exists, and that the bucket owner has permission to publish to it by sending a test notification. In the case of AWS Lambda destinations, Amazon S3 verifies that the Lambda function permissions grant Amazon S3 permission to invoke the function from the Amazon S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\\\">Configuring Notifications for Amazon S3 Events</a>.</p> <p>You can disable notifications by adding the empty NotificationConfiguration element.</p> <p>By default, only the bucket owner can configure notifications on a bucket. However, bucket owners can use a bucket policy to grant permission to other users to set this configuration with <code>s3:PutBucketNotification</code> permission.</p> <note> <p>The PUT notification is an atomic operation. For example, suppose your notification configuration includes SNS topic, SQS queue, and Lambda function configurations. When you send a PUT request with this configuration, Amazon S3 sends test messages to your SNS topic. If the message fails, the entire PUT operation will fail, and Amazon S3 will not add the configuration to your bucket.</p> </note> <p> <b>Responses</b> </p> <p>If the configuration in the request body includes only one <code>TopicConfiguration</code> specifying only the <code>s3:ReducedRedundancyLostObject</code> event type, the response will also include the <code>x-amz-sns-test-message-id</code> header containing the message ID of the test notification sent to the topic.</p> <p>The following operation is related to <code>PutBucketNotificationConfiguration</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketNotificationConfiguration.html\\\">GetBucketNotificationConfiguration</a> </p> </li> </ul>\"\
    },\
    \"PutBucketOwnershipControls\":{\
      \"name\":\"PutBucketOwnershipControls\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?ownershipControls\"\
      },\
      \"input\":{\"shape\":\"PutBucketOwnershipControlsRequest\"},\
      \"documentation\":\"<p>Creates or modifies <code>OwnershipControls</code> for an Amazon S3 bucket. To use this operation, you must have the <code>s3:GetBucketOwnershipControls</code> permission. For more information about Amazon S3 permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\\\">Specifying Permissions in a Policy</a>. </p> <p>For information about Amazon S3 Object Ownership, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/about-object-ownership.html\\\">Using Object Ownership</a>. </p> <p>The following operations are related to <code>GetBucketOwnershipControls</code>:</p> <ul> <li> <p> <a>GetBucketOwnershipControls</a> </p> </li> <li> <p> <a>DeleteBucketOwnershipControls</a> </p> </li> </ul>\"\
    },\
    \"PutBucketPolicy\":{\
      \"name\":\"PutBucketPolicy\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?policy\"\
      },\
      \"input\":{\"shape\":\"PutBucketPolicyRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTpolicy.html\",\
      \"documentation\":\"<p>Applies an Amazon S3 bucket policy to an Amazon S3 bucket. If you are using an identity other than the root user of the AWS account that owns the bucket, the calling identity must have the <code>PutBucketPolicy</code> permissions on the specified bucket and belong to the bucket owner's account in order to use this operation.</p> <p>If you don't have <code>PutBucketPolicy</code> permissions, Amazon S3 returns a <code>403 Access Denied</code> error. If you have the correct permissions, but you're not using an identity that belongs to the bucket owner's account, Amazon S3 returns a <code>405 Method Not Allowed</code> error.</p> <important> <p> As a security precaution, the root user of the AWS account that owns a bucket can always use this operation, even if the policy explicitly denies the root user the ability to perform this action. </p> </important> <p>For more information about bucket policies, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html\\\">Using Bucket Policies and User Policies</a>.</p> <p>The following operations are related to <code>PutBucketPolicy</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucket.html\\\">DeleteBucket</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutBucketReplication\":{\
      \"name\":\"PutBucketReplication\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?replication\"\
      },\
      \"input\":{\"shape\":\"PutBucketReplicationRequest\"},\
      \"documentation\":\"<p> Creates a replication configuration or replaces an existing one. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html\\\">Replication</a> in the <i>Amazon S3 Developer Guide</i>. </p> <note> <p>To perform this operation, the user or role performing the operation must have the <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_passrole.html\\\">iam:PassRole</a> permission.</p> </note> <p>Specify the replication configuration in the request body. In the replication configuration, you provide the name of the destination bucket where you want Amazon S3 to replicate objects, the IAM role that Amazon S3 can assume to replicate objects on your behalf, and other relevant information.</p> <p>A replication configuration must include at least one rule, and can contain a maximum of 1,000. Each rule identifies a subset of objects to replicate by filtering the objects in the source bucket. To choose additional subsets of objects to replicate, add a rule for each subset. All rules must specify the same destination bucket.</p> <p>To specify a subset of the objects in the source bucket to apply a replication rule to, add the Filter element as a child of the Rule element. You can filter objects based on an object key prefix, one or more object tags, or both. When you add the Filter element in the configuration, you must also add the following elements: <code>DeleteMarkerReplication</code>, <code>Status</code>, and <code>Priority</code>.</p> <note> <p>The latest version of the replication configuration XML is V2. XML V2 replication configurations are those that contain the <code>Filter</code> element for rules, and rules that specify S3 Replication Time Control (S3 RTC). In XML V2 replication configurations, Amazon S3 doesn't replicate delete markers. Therefore, you must set the <code>DeleteMarkerReplication</code> element to <code>Disabled</code>. For backward compatibility, Amazon S3 continues to support the XML V1 replication configuration.</p> </note> <p>For information about enabling versioning on a bucket, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/Versioning.html\\\">Using Versioning</a>.</p> <p>By default, a resource owner, in this case the AWS account that created the bucket, can perform this operation. The resource owner can also grant others permissions to perform the operation. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\\\">Specifying Permissions in a Policy</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p> <b>Handling Replication of Encrypted Objects</b> </p> <p>By default, Amazon S3 doesn't replicate objects that are stored at rest using server-side encryption with CMKs stored in AWS KMS. To replicate AWS KMS-encrypted objects, add the following: <code>SourceSelectionCriteria</code>, <code>SseKmsEncryptedObjects</code>, <code>Status</code>, <code>EncryptionConfiguration</code>, and <code>ReplicaKmsKeyID</code>. For information about replication configuration, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-config-for-kms-objects.html\\\">Replicating Objects Created with SSE Using CMKs stored in AWS KMS</a>.</p> <p>For information on <code>PutBucketReplication</code> errors, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#ReplicationErrorCodeList\\\">List of replication-related error codes</a> </p> <p>The following operations are related to <code>PutBucketReplication</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketReplication.html\\\">GetBucketReplication</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketReplication.html\\\">DeleteBucketReplication</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutBucketRequestPayment\":{\
      \"name\":\"PutBucketRequestPayment\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?requestPayment\"\
      },\
      \"input\":{\"shape\":\"PutBucketRequestPaymentRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTrequestPaymentPUT.html\",\
      \"documentation\":\"<p>Sets the request payment configuration for a bucket. By default, the bucket owner pays for downloads from the bucket. This configuration parameter enables the bucket owner (only) to specify that the person requesting the download will be charged for the download. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/RequesterPaysBuckets.html\\\">Requester Pays Buckets</a>.</p> <p>The following operations are related to <code>PutBucketRequestPayment</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketRequestPayment.html\\\">GetBucketRequestPayment</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutBucketTagging\":{\
      \"name\":\"PutBucketTagging\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?tagging\"\
      },\
      \"input\":{\"shape\":\"PutBucketTaggingRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTtagging.html\",\
      \"documentation\":\"<p>Sets the tags for a bucket.</p> <p>Use tags to organize your AWS bill to reflect your own cost structure. To do this, sign up to get your AWS account bill with tag key values included. Then, to see the cost of combined resources, organize your billing information according to resources with the same tag key values. For example, you can tag several resources with a specific application name, and then organize your billing information to see the total cost of that application across several services. For more information, see <a href=\\\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html\\\">Cost Allocation and Tagging</a>.</p> <note> <p>Within a bucket, if you add a tag that has the same key as an existing tag, the new value overwrites the old value. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/CostAllocTagging.html\\\">Using Cost Allocation in Amazon S3 Bucket Tags</a>.</p> </note> <p>To use this operation, you must have permissions to perform the <code>s3:PutBucketTagging</code> action. The bucket owner has this permission by default and can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a>.</p> <p> <code>PutBucketTagging</code> has the following special errors:</p> <ul> <li> <p>Error code: <code>InvalidTagError</code> </p> <ul> <li> <p>Description: The tag provided was not a valid tag. This error can occur if the tag did not pass input validation. For information about tag restrictions, see <a href=\\\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html\\\">User-Defined Tag Restrictions</a> and <a href=\\\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/aws-tag-restrictions.html\\\">AWS-Generated Cost Allocation Tag Restrictions</a>.</p> </li> </ul> </li> <li> <p>Error code: <code>MalformedXMLError</code> </p> <ul> <li> <p>Description: The XML provided does not match the schema.</p> </li> </ul> </li> <li> <p>Error code: <code>OperationAbortedError </code> </p> <ul> <li> <p>Description: A conflicting conditional operation is currently in progress against this resource. Please try again.</p> </li> </ul> </li> <li> <p>Error code: <code>InternalError</code> </p> <ul> <li> <p>Description: The service was unable to apply the provided tag to the bucket.</p> </li> </ul> </li> </ul> <p>The following operations are related to <code>PutBucketTagging</code>:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketTagging.html\\\">GetBucketTagging</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketTagging.html\\\">DeleteBucketTagging</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutBucketVersioning\":{\
      \"name\":\"PutBucketVersioning\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?versioning\"\
      },\
      \"input\":{\"shape\":\"PutBucketVersioningRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTVersioningStatus.html\",\
      \"documentation\":\"<p>Sets the versioning state of an existing bucket. To set the versioning state, you must be the bucket owner.</p> <p>You can set the versioning state with one of the following values:</p> <p> <b>Enabled</b>âEnables versioning for the objects in the bucket. All objects added to the bucket receive a unique version ID.</p> <p> <b>Suspended</b>âDisables versioning for the objects in the bucket. All objects added to the bucket receive the version ID null.</p> <p>If the versioning state has never been set on a bucket, it has no versioning state; a <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketVersioning.html\\\">GetBucketVersioning</a> request does not return a versioning state value.</p> <p>If the bucket owner enables MFA Delete in the bucket versioning configuration, the bucket owner must include the <code>x-amz-mfa request</code> header and the <code>Status</code> and the <code>MfaDelete</code> request elements in a request to set the versioning state of the bucket.</p> <important> <p>If you have an object expiration lifecycle policy in your non-versioned bucket and you want to maintain the same permanent delete behavior when you enable versioning, you must add a noncurrent expiration policy. The noncurrent expiration lifecycle policy will manage the deletes of the noncurrent object versions in the version-enabled bucket. (A version-enabled bucket maintains one current and zero or more noncurrent object versions.) For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html#lifecycle-and-other-bucket-config\\\">Lifecycle and Versioning</a>.</p> </important> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html\\\">CreateBucket</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucket.html\\\">DeleteBucket</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketVersioning.html\\\">GetBucketVersioning</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutBucketWebsite\":{\
      \"name\":\"PutBucketWebsite\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?website\"\
      },\
      \"input\":{\"shape\":\"PutBucketWebsiteRequest\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTwebsite.html\",\
      \"documentation\":\"<p>Sets the configuration of the website that is specified in the <code>website</code> subresource. To configure a bucket as a website, you can add this subresource on the bucket with website configuration information such as the file name of the index document and any redirect rules. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html\\\">Hosting Websites on Amazon S3</a>.</p> <p>This PUT operation requires the <code>S3:PutBucketWebsite</code> permission. By default, only the bucket owner can configure the website attached to a bucket; however, bucket owners can allow other users to set the website configuration by writing a bucket policy that grants them the <code>S3:PutBucketWebsite</code> permission.</p> <p>To redirect all website requests sent to the bucket's website endpoint, you add a website configuration with the following elements. Because all requests are sent to another website, you don't need to provide index document name for the bucket.</p> <ul> <li> <p> <code>WebsiteConfiguration</code> </p> </li> <li> <p> <code>RedirectAllRequestsTo</code> </p> </li> <li> <p> <code>HostName</code> </p> </li> <li> <p> <code>Protocol</code> </p> </li> </ul> <p>If you want granular control over redirects, you can use the following elements to add routing rules that describe conditions for redirecting requests and information about the redirect destination. In this case, the website configuration must provide an index document for the bucket, because some requests might not be redirected. </p> <ul> <li> <p> <code>WebsiteConfiguration</code> </p> </li> <li> <p> <code>IndexDocument</code> </p> </li> <li> <p> <code>Suffix</code> </p> </li> <li> <p> <code>ErrorDocument</code> </p> </li> <li> <p> <code>Key</code> </p> </li> <li> <p> <code>RoutingRules</code> </p> </li> <li> <p> <code>RoutingRule</code> </p> </li> <li> <p> <code>Condition</code> </p> </li> <li> <p> <code>HttpErrorCodeReturnedEquals</code> </p> </li> <li> <p> <code>KeyPrefixEquals</code> </p> </li> <li> <p> <code>Redirect</code> </p> </li> <li> <p> <code>Protocol</code> </p> </li> <li> <p> <code>HostName</code> </p> </li> <li> <p> <code>ReplaceKeyPrefixWith</code> </p> </li> <li> <p> <code>ReplaceKeyWith</code> </p> </li> <li> <p> <code>HttpRedirectCode</code> </p> </li> </ul> <p>Amazon S3 has a limitation of 50 routing rules per website configuration. If you require more than 50 routing rules, you can use object redirect. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/how-to-page-redirect.html\\\">Configuring an Object Redirect</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutObject\":{\
      \"name\":\"PutObject\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}/{Key+}\"\
      },\
      \"input\":{\"shape\":\"PutObjectRequest\"},\
      \"output\":{\"shape\":\"PutObjectOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectPUT.html\",\
      \"documentation\":\"<p>Adds an object to a bucket. You must have WRITE permissions on a bucket to add an object to it.</p> <p>Amazon S3 never adds partial objects; if you receive a success response, Amazon S3 added the entire object to the bucket.</p> <p>Amazon S3 is a distributed system. If it receives multiple write requests for the same object simultaneously, it overwrites all but the last object written. Amazon S3 does not provide object locking; if you need this, make sure to build it into your application layer or use versioning instead.</p> <p>To ensure that data is not corrupted traversing the network, use the <code>Content-MD5</code> header. When you use this header, Amazon S3 checks the object against the provided MD5 value and, if they do not match, returns an error. Additionally, you can calculate the MD5 while putting an object to Amazon S3 and compare the returned ETag to the calculated MD5 value.</p> <note> <p> The <code>Content-MD5</code> header is required for any request to upload an object with a retention period configured using Amazon S3 Object Lock. For more information about Amazon S3 Object Lock, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock-overview.html\\\">Amazon S3 Object Lock Overview</a> in the <i>Amazon Simple Storage Service Developer Guide</i>. </p> </note> <p> <b>Server-side Encryption</b> </p> <p>You can optionally request server-side encryption. With server-side encryption, Amazon S3 encrypts your data as it writes it to disks in its data centers and decrypts the data when you access it. You have the option to provide your own encryption key or use AWS managed encryption keys. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingServerSideEncryption.html\\\">Using Server-Side Encryption</a>.</p> <p> <b>Access Control List (ACL)-Specific Request Headers</b> </p> <p>You can use headers to grant ACL- based permissions. By default, all objects are private. Only the owner has full access control. When adding a new object, you can grant permissions to individual AWS accounts or to predefined groups defined by Amazon S3. These permissions are then added to the ACL on the object. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\\\">Access Control List (ACL) Overview</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-using-rest-api.html\\\">Managing ACLs Using the REST API</a>. </p> <p> <b>Storage Class Options</b> </p> <p>By default, Amazon S3 uses the STANDARD Storage Class to store newly created objects. The STANDARD storage class provides high durability and high availability. Depending on performance needs, you can specify a different Storage Class. Amazon S3 on Outposts only uses the OUTPOSTS Storage Class. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html\\\">Storage Classes</a> in the <i>Amazon S3 Service Developer Guide</i>.</p> <p> <b>Versioning</b> </p> <p>If you enable versioning for a bucket, Amazon S3 automatically generates a unique version ID for the object being stored. Amazon S3 returns this ID in the response. When you enable versioning for a bucket, if Amazon S3 receives multiple write requests for the same object simultaneously, it stores all of the objects.</p> <p>For more information about versioning, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/AddingObjectstoVersioningEnabledBuckets.html\\\">Adding Objects to Versioning Enabled Buckets</a>. For information about returning the versioning state of a bucket, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketVersioning.html\\\">GetBucketVersioning</a>. </p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html\\\">CopyObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObject.html\\\">DeleteObject</a> </p> </li> </ul>\"\
    },\
    \"PutObjectAcl\":{\
      \"name\":\"PutObjectAcl\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}/{Key+}?acl\"\
      },\
      \"input\":{\"shape\":\"PutObjectAclRequest\"},\
      \"output\":{\"shape\":\"PutObjectAclOutput\"},\
      \"errors\":[\
        {\"shape\":\"NoSuchKey\"}\
      ],\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectPUTacl.html\",\
      \"documentation\":\"<p>Uses the <code>acl</code> subresource to set the access control list (ACL) permissions for a new or existing object in an S3 bucket. You must have <code>WRITE_ACP</code> permission to set the ACL of an object. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#permissions\\\">What permissions can I grant?</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>This action is not supported by Amazon S3 on Outposts.</p> <p>Depending on your application needs, you can choose to set the ACL on an object using either the request body or the headers. For example, if you have an existing application that updates a bucket ACL using the request body, you can continue to use that approach. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\\\">Access Control List (ACL) Overview</a> in the <i>Amazon S3 Developer Guide</i>.</p> <p> <b>Access Permissions</b> </p> <p>You can set access permissions using one of the following methods:</p> <ul> <li> <p>Specify a canned ACL with the <code>x-amz-acl</code> request header. Amazon S3 supports a set of predefined ACLs, known as canned ACLs. Each canned ACL has a predefined set of grantees and permissions. Specify the canned ACL name as the value of <code>x-amz-ac</code>l. If you use this header, you cannot use other access control-specific headers in your request. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\\\">Canned ACL</a>.</p> </li> <li> <p>Specify access permissions explicitly with the <code>x-amz-grant-read</code>, <code>x-amz-grant-read-acp</code>, <code>x-amz-grant-write-acp</code>, and <code>x-amz-grant-full-control</code> headers. When using these headers, you specify explicit access permissions and grantees (AWS accounts or Amazon S3 groups) who will receive the permission. If you use these ACL-specific headers, you cannot use <code>x-amz-acl</code> header to set a canned ACL. These parameters map to the set of permissions that Amazon S3 supports in an ACL. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html\\\">Access Control List (ACL) Overview</a>.</p> <p>You specify each grantee as a type=value pair, where the type is one of the following:</p> <ul> <li> <p> <code>id</code> â if the value specified is the canonical user ID of an AWS account</p> </li> <li> <p> <code>uri</code> â if you are granting permissions to a predefined group</p> </li> <li> <p> <code>emailAddress</code> â if the value specified is the email address of an AWS account</p> <note> <p>Using email addresses to specify a grantee is only supported in the following AWS Regions: </p> <ul> <li> <p>US East (N. Virginia)</p> </li> <li> <p>US West (N. California)</p> </li> <li> <p> US West (Oregon)</p> </li> <li> <p> Asia Pacific (Singapore)</p> </li> <li> <p>Asia Pacific (Sydney)</p> </li> <li> <p>Asia Pacific (Tokyo)</p> </li> <li> <p>Europe (Ireland)</p> </li> <li> <p>South America (SÃ£o Paulo)</p> </li> </ul> <p>For a list of all the Amazon S3 supported Regions and endpoints, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region\\\">Regions and Endpoints</a> in the AWS General Reference.</p> </note> </li> </ul> <p>For example, the following <code>x-amz-grant-read</code> header grants list objects permission to the two AWS accounts identified by their email addresses.</p> <p> <code>x-amz-grant-read: emailAddress=\\\"xyz@amazon.com\\\", emailAddress=\\\"abc@amazon.com\\\" </code> </p> </li> </ul> <p>You can use either a canned ACL or specify access permissions explicitly. You cannot do both.</p> <p> <b>Grantee Values</b> </p> <p>You can specify the person (grantee) to whom you're assigning access rights (using request elements) in the following ways:</p> <ul> <li> <p>By the person's ID:</p> <p> <code>&lt;Grantee xmlns:xsi=\\\"http://www.w3.org/2001/XMLSchema-instance\\\" xsi:type=\\\"CanonicalUser\\\"&gt;&lt;ID&gt;&lt;&gt;ID&lt;&gt;&lt;/ID&gt;&lt;DisplayName&gt;&lt;&gt;GranteesEmail&lt;&gt;&lt;/DisplayName&gt; &lt;/Grantee&gt;</code> </p> <p>DisplayName is optional and ignored in the request.</p> </li> <li> <p>By URI:</p> <p> <code>&lt;Grantee xmlns:xsi=\\\"http://www.w3.org/2001/XMLSchema-instance\\\" xsi:type=\\\"Group\\\"&gt;&lt;URI&gt;&lt;&gt;http://acs.amazonaws.com/groups/global/AuthenticatedUsers&lt;&gt;&lt;/URI&gt;&lt;/Grantee&gt;</code> </p> </li> <li> <p>By Email address:</p> <p> <code>&lt;Grantee xmlns:xsi=\\\"http://www.w3.org/2001/XMLSchema-instance\\\" xsi:type=\\\"AmazonCustomerByEmail\\\"&gt;&lt;EmailAddress&gt;&lt;&gt;Grantees@email.com&lt;&gt;&lt;/EmailAddress&gt;lt;/Grantee&gt;</code> </p> <p>The grantee is resolved to the CanonicalUser and, in a response to a GET Object acl request, appears as the CanonicalUser.</p> <note> <p>Using email addresses to specify a grantee is only supported in the following AWS Regions: </p> <ul> <li> <p>US East (N. Virginia)</p> </li> <li> <p>US West (N. California)</p> </li> <li> <p> US West (Oregon)</p> </li> <li> <p> Asia Pacific (Singapore)</p> </li> <li> <p>Asia Pacific (Sydney)</p> </li> <li> <p>Asia Pacific (Tokyo)</p> </li> <li> <p>Europe (Ireland)</p> </li> <li> <p>South America (SÃ£o Paulo)</p> </li> </ul> <p>For a list of all the Amazon S3 supported Regions and endpoints, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region\\\">Regions and Endpoints</a> in the AWS General Reference.</p> </note> </li> </ul> <p> <b>Versioning</b> </p> <p>The ACL of an object is set at the object version level. By default, PUT sets the ACL of the current version of an object. To set the ACL of a different version, use the <code>versionId</code> subresource.</p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html\\\">CopyObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutObjectLegalHold\":{\
      \"name\":\"PutObjectLegalHold\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}/{Key+}?legal-hold\"\
      },\
      \"input\":{\"shape\":\"PutObjectLegalHoldRequest\"},\
      \"output\":{\"shape\":\"PutObjectLegalHoldOutput\"},\
      \"documentation\":\"<p>Applies a Legal Hold configuration to the specified object.</p> <p>This action is not supported by Amazon S3 on Outposts.</p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\\\">Locking Objects</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutObjectLockConfiguration\":{\
      \"name\":\"PutObjectLockConfiguration\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?object-lock\"\
      },\
      \"input\":{\"shape\":\"PutObjectLockConfigurationRequest\"},\
      \"output\":{\"shape\":\"PutObjectLockConfigurationOutput\"},\
      \"documentation\":\"<p>Places an Object Lock configuration on the specified bucket. The rule specified in the Object Lock configuration will be applied by default to every new object placed in the specified bucket.</p> <note> <p> <code>DefaultRetention</code> requires either Days or Years. You can't specify both at the same time.</p> </note> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\\\">Locking Objects</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutObjectRetention\":{\
      \"name\":\"PutObjectRetention\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}/{Key+}?retention\"\
      },\
      \"input\":{\"shape\":\"PutObjectRetentionRequest\"},\
      \"output\":{\"shape\":\"PutObjectRetentionOutput\"},\
      \"documentation\":\"<p>Places an Object Retention configuration on an object.</p> <p>This action is not supported by Amazon S3 on Outposts.</p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\\\">Locking Objects</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutObjectTagging\":{\
      \"name\":\"PutObjectTagging\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}/{Key+}?tagging\"\
      },\
      \"input\":{\"shape\":\"PutObjectTaggingRequest\"},\
      \"output\":{\"shape\":\"PutObjectTaggingOutput\"},\
      \"documentation\":\"<p>Sets the supplied tag-set to an object that already exists in a bucket.</p> <p>A tag is a key-value pair. You can associate tags with an object by sending a PUT request against the tagging subresource that is associated with the object. You can retrieve tags by sending a GET request. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectTagging.html\\\">GetObjectTagging</a>.</p> <p>For tagging-related restrictions related to characters and encodings, see <a href=\\\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html\\\">Tag Restrictions</a>. Note that Amazon S3 limits the maximum number of tags to 10 tags per object.</p> <p>To use this operation, you must have permission to perform the <code>s3:PutObjectTagging</code> action. By default, the bucket owner has this permission and can grant this permission to others.</p> <p>To put tags of any other version, use the <code>versionId</code> query parameter. You also need permission for the <code>s3:PutObjectVersionTagging</code> action.</p> <p>For information about the Amazon S3 object tagging feature, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-tagging.html\\\">Object Tagging</a>.</p> <p class=\\\"title\\\"> <b>Special Errors</b> </p> <ul> <li> <ul> <li> <p> <i>Code: InvalidTagError </i> </p> </li> <li> <p> <i>Cause: The tag provided was not a valid tag. This error can occur if the tag did not pass input validation. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-tagging.html\\\">Object Tagging</a>.</i> </p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code: MalformedXMLError </i> </p> </li> <li> <p> <i>Cause: The XML provided does not match the schema.</i> </p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code: OperationAbortedError </i> </p> </li> <li> <p> <i>Cause: A conflicting conditional operation is currently in progress against this resource. Please try again.</i> </p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code: InternalError</i> </p> </li> <li> <p> <i>Cause: The service was unable to apply the provided tag to the object.</i> </p> </li> </ul> </li> </ul> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectTagging.html\\\">GetObjectTagging</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"PutPublicAccessBlock\":{\
      \"name\":\"PutPublicAccessBlock\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}?publicAccessBlock\"\
      },\
      \"input\":{\"shape\":\"PutPublicAccessBlockRequest\"},\
      \"documentation\":\"<p>Creates or modifies the <code>PublicAccessBlock</code> configuration for an Amazon S3 bucket. To use this operation, you must have the <code>s3:PutBucketPublicAccessBlock</code> permission. For more information about Amazon S3 permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\\\">Specifying Permissions in a Policy</a>.</p> <important> <p>When Amazon S3 evaluates the <code>PublicAccessBlock</code> configuration for a bucket or an object, it checks the <code>PublicAccessBlock</code> configuration for both the bucket (or the bucket that contains the object) and the bucket owner's account. If the <code>PublicAccessBlock</code> configurations are different between the bucket and the account, Amazon S3 uses the most restrictive combination of the bucket-level and account-level settings.</p> </important> <p>For more information about when Amazon S3 considers a bucket or an object public, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html#access-control-block-public-access-policy-status\\\">The Meaning of \\\"Public\\\"</a>.</p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetPublicAccessBlock.html\\\">GetPublicAccessBlock</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeletePublicAccessBlock.html\\\">DeletePublicAccessBlock</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketPolicyStatus.html\\\">GetBucketPolicyStatus</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html\\\">Using Amazon S3 Block Public Access</a> </p> </li> </ul>\",\
      \"httpChecksumRequired\":true\
    },\
    \"RestoreObject\":{\
      \"name\":\"RestoreObject\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/{Bucket}/{Key+}?restore\"\
      },\
      \"input\":{\"shape\":\"RestoreObjectRequest\"},\
      \"output\":{\"shape\":\"RestoreObjectOutput\"},\
      \"errors\":[\
        {\"shape\":\"ObjectAlreadyInActiveTierError\"}\
      ],\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectRestore.html\",\
      \"documentation\":\"<p>Restores an archived copy of an object back into Amazon S3</p> <p>This action is not supported by Amazon S3 on Outposts.</p> <p>This action performs the following types of requests: </p> <ul> <li> <p> <code>select</code> - Perform a select query on an archived object</p> </li> <li> <p> <code>restore an archive</code> - Restore an archived object</p> </li> </ul> <p>To use this operation, you must have permissions to perform the <code>s3:RestoreObject</code> action. The bucket owner has this permission by default and can grant this permission to others. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources\\\">Permissions Related to Bucket Subresource Operations</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html\\\">Managing Access Permissions to Your Amazon S3 Resources</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p> <b>Querying Archives with Select Requests</b> </p> <p>You use a select type of request to perform SQL queries on archived objects. The archived objects that are being queried by the select request must be formatted as uncompressed comma-separated values (CSV) files. You can run queries and custom analytics on your archived data without having to restore your data to a hotter Amazon S3 tier. For an overview about select requests, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/querying-glacier-archives.html\\\">Querying Archived Objects</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When making a select request, do the following:</p> <ul> <li> <p>Define an output location for the select query's output. This must be an Amazon S3 bucket in the same AWS Region as the bucket that contains the archive object that is being queried. The AWS account that initiates the job must have permissions to write to the S3 bucket. You can specify the storage class and encryption for the output objects stored in the bucket. For more information about output, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/querying-glacier-archives.html\\\">Querying Archived Objects</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>For more information about the <code>S3</code> structure in the request body, see the following:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html\\\">PutObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html\\\">Managing Access with ACLs</a> in the <i>Amazon Simple Storage Service Developer Guide</i> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html\\\">Protecting Data Using Server-Side Encryption</a> in the <i>Amazon Simple Storage Service Developer Guide</i> </p> </li> </ul> </li> <li> <p>Define the SQL expression for the <code>SELECT</code> type of restoration for your query in the request body's <code>SelectParameters</code> structure. You can use expressions like the following examples.</p> <ul> <li> <p>The following expression returns all records from the specified object.</p> <p> <code>SELECT * FROM Object</code> </p> </li> <li> <p>Assuming that you are not using any headers for data stored in the object, you can specify columns with positional headers.</p> <p> <code>SELECT s._1, s._2 FROM Object s WHERE s._3 &gt; 100</code> </p> </li> <li> <p>If you have headers and you set the <code>fileHeaderInfo</code> in the <code>CSV</code> structure in the request body to <code>USE</code>, you can specify headers in the query. (If you set the <code>fileHeaderInfo</code> field to <code>IGNORE</code>, the first row is skipped for the query.) You cannot mix ordinal positions with header column names. </p> <p> <code>SELECT s.Id, s.FirstName, s.SSN FROM S3Object s</code> </p> </li> </ul> </li> </ul> <p>For more information about using SQL with S3 Glacier Select restore, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-glacier-select-sql-reference.html\\\">SQL Reference for Amazon S3 Select and S3 Glacier Select</a> in the <i>Amazon Simple Storage Service Developer Guide</i>. </p> <p>When making a select request, you can also do the following:</p> <ul> <li> <p>To expedite your queries, specify the <code>Expedited</code> tier. For more information about tiers, see \\\"Restoring Archives,\\\" later in this topic.</p> </li> <li> <p>Specify details about the data serialization format of both the input object that is being queried and the serialization of the CSV-encoded query results.</p> </li> </ul> <p>The following are additional important facts about the select feature:</p> <ul> <li> <p>The output results are new Amazon S3 objects. Unlike archive retrievals, they are stored until explicitly deleted-manually or through a lifecycle policy.</p> </li> <li> <p>You can issue more than one select request on the same Amazon S3 object. Amazon S3 doesn't deduplicate requests, so avoid issuing duplicate requests.</p> </li> <li> <p> Amazon S3 accepts a select request even if the object has already been restored. A select request doesnât return error response <code>409</code>.</p> </li> </ul> <p> <b>Restoring Archives</b> </p> <p>Objects in the GLACIER and DEEP_ARCHIVE storage classes are archived. To access an archived object, you must first initiate a restore request. This restores a temporary copy of the archived object. In a restore request, you specify the number of days that you want the restored copy to exist. After the specified period, Amazon S3 deletes the temporary copy but the object remains archived in the GLACIER or DEEP_ARCHIVE storage class that object was restored from. </p> <p>To restore a specific object version, you can provide a version ID. If you don't provide a version ID, Amazon S3 restores the current version.</p> <p>The time it takes restore jobs to finish depends on which storage class the object is being restored from and which data access tier you specify. </p> <p>When restoring an archived object (or using a select request), you can specify one of the following data access tier options in the <code>Tier</code> element of the request body: </p> <ul> <li> <p> <b> <code>Expedited</code> </b> - Expedited retrievals allow you to quickly access your data stored in the GLACIER storage class when occasional urgent requests for a subset of archives are required. For all but the largest archived objects (250 MB+), data accessed using Expedited retrievals are typically made available within 1â5 minutes. Provisioned capacity ensures that retrieval capacity for Expedited retrievals is available when you need it. Expedited retrievals and provisioned capacity are not available for the DEEP_ARCHIVE storage class.</p> </li> <li> <p> <b> <code>Standard</code> </b> - S3 Standard retrievals allow you to access any of your archived objects within several hours. This is the default option for the GLACIER and DEEP_ARCHIVE retrieval requests that do not specify the retrieval option. S3 Standard retrievals typically complete within 3-5 hours from the GLACIER storage class and typically complete within 12 hours from the DEEP_ARCHIVE storage class. </p> </li> <li> <p> <b> <code>Bulk</code> </b> - Bulk retrievals are Amazon S3 Glacierâs lowest-cost retrieval option, enabling you to retrieve large amounts, even petabytes, of data inexpensively in a day. Bulk retrievals typically complete within 5-12 hours from the GLACIER storage class and typically complete within 48 hours from the DEEP_ARCHIVE storage class.</p> </li> </ul> <p>For more information about archive retrieval options and provisioned capacity for <code>Expedited</code> data access, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/restoring-objects.html\\\">Restoring Archived Objects</a> in the <i>Amazon Simple Storage Service Developer Guide</i>. </p> <p>You can use Amazon S3 restore speed upgrade to change the restore speed to a faster speed while it is in progress. You upgrade the speed of an in-progress restoration by issuing another restore request to the same object, setting a new <code>Tier</code> request element. When issuing a request to upgrade the restore tier, you must choose a tier that is faster than the tier that the in-progress restore is using. You must not change any other parameters, such as the <code>Days</code> request element. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/restoring-objects.html#restoring-objects-upgrade-tier.title.html\\\"> Upgrading the Speed of an In-Progress Restore</a> in the <i>Amazon Simple Storage Service Developer Guide</i>. </p> <p>To get the status of object restoration, you can send a <code>HEAD</code> request. Operations return the <code>x-amz-restore</code> header, which provides information about the restoration status, in the response. You can use Amazon S3 event notifications to notify you when a restore is initiated or completed. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\\\">Configuring Amazon S3 Event Notifications</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>After restoring an archived object, you can update the restoration period by reissuing the request with a new period. Amazon S3 updates the restoration period relative to the current time and charges only for the request-there are no data transfer charges. You cannot update the restoration period when Amazon S3 is actively processing your current restore request for the object.</p> <p>If your bucket has a lifecycle configuration with a rule that includes an expiration action, the object expiration overrides the life span that you specify in a restore request. For example, if you restore an object copy for 10 days, but the object is scheduled to expire in 3 days, Amazon S3 deletes the object in 3 days. For more information about lifecycle configuration, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html\\\">PutBucketLifecycleConfiguration</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html\\\">Object Lifecycle Management</a> in <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p> <b>Responses</b> </p> <p>A successful operation returns either the <code>200 OK</code> or <code>202 Accepted</code> status code. </p> <ul> <li> <p>If the object copy is not previously restored, then Amazon S3 returns <code>202 Accepted</code> in the response. </p> </li> <li> <p>If the object copy is previously restored, Amazon S3 returns <code>200 OK</code> in the response. </p> </li> </ul> <p class=\\\"title\\\"> <b>Special Errors</b> </p> <ul> <li> <ul> <li> <p> <i>Code: RestoreAlreadyInProgress</i> </p> </li> <li> <p> <i>Cause: Object restore is already in progress. (This error does not apply to SELECT type requests.)</i> </p> </li> <li> <p> <i>HTTP Status Code: 409 Conflict</i> </p> </li> <li> <p> <i>SOAP Fault Code Prefix: Client</i> </p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code: GlacierExpeditedRetrievalNotAvailable</i> </p> </li> <li> <p> <i>Cause: S3 Glacier expedited retrievals are currently not available. Try again later. (Returned if there is insufficient capacity to process the Expedited request. This error applies only to Expedited retrievals and not to S3 Standard or Bulk retrievals.)</i> </p> </li> <li> <p> <i>HTTP Status Code: 503</i> </p> </li> <li> <p> <i>SOAP Fault Code Prefix: N/A</i> </p> </li> </ul> </li> </ul> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html\\\">PutBucketLifecycleConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketNotificationConfiguration.html\\\">GetBucketNotificationConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-glacier-select-sql-reference.html\\\">SQL Reference for Amazon S3 Select and S3 Glacier Select </a> in the <i>Amazon Simple Storage Service Developer Guide</i> </p> </li> </ul>\",\
      \"alias\":\"PostObjectRestore\"\
    },\
    \"SelectObjectContent\":{\
      \"name\":\"SelectObjectContent\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/{Bucket}/{Key+}?select&select-type=2\"\
      },\
      \"input\":{\
        \"shape\":\"SelectObjectContentRequest\",\
        \"locationName\":\"SelectObjectContentRequest\",\
        \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
      },\
      \"output\":{\"shape\":\"SelectObjectContentOutput\"},\
      \"documentation\":\"<p>This operation filters the contents of an Amazon S3 object based on a simple structured query language (SQL) statement. In the request, along with the SQL expression, you must also specify a data serialization format (JSON, CSV, or Apache Parquet) of the object. Amazon S3 uses this format to parse object data into records, and returns only records that match the specified SQL expression. You must also specify the data serialization format for the response.</p> <p>This action is not supported by Amazon S3 on Outposts.</p> <p>For more information about Amazon S3 Select, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/selecting-content-from-objects.html\\\">Selecting Content from Objects</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>For more information about using SQL with Amazon S3 Select, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-glacier-select-sql-reference.html\\\"> SQL Reference for Amazon S3 Select and S3 Glacier Select</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p/> <p> <b>Permissions</b> </p> <p>You must have <code>s3:GetObject</code> permission for this operation.Â Amazon S3 Select does not support anonymous access. For more information about permissions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html\\\">Specifying Permissions in a Policy</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p/> <p> <i>Object Data Formats</i> </p> <p>You can use Amazon S3 Select to query objects that have the following format properties:</p> <ul> <li> <p> <i>CSV, JSON, and Parquet</i> - Objects must be in CSV, JSON, or Parquet format.</p> </li> <li> <p> <i>UTF-8</i> - UTF-8 is the only encoding type Amazon S3 Select supports.</p> </li> <li> <p> <i>GZIP or BZIP2</i> - CSV and JSON files can be compressed using GZIP or BZIP2. GZIP and BZIP2 are the only compression formats that Amazon S3 Select supports for CSV and JSON files. Amazon S3 Select supports columnar compression for Parquet using GZIP or Snappy. Amazon S3 Select does not support whole-object compression for Parquet objects.</p> </li> <li> <p> <i>Server-side encryption</i> - Amazon S3 Select supports querying objects that are protected with server-side encryption.</p> <p>For objects that are encrypted with customer-provided encryption keys (SSE-C), you must use HTTPS, and you must use the headers that are documented in the <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a>. For more information about SSE-C, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html\\\">Server-Side Encryption (Using Customer-Provided Encryption Keys)</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>For objects that are encrypted with Amazon S3 managed encryption keys (SSE-S3) and customer master keys (CMKs) stored in AWS Key Management Service (SSE-KMS), server-side encryption is handled transparently, so you don't need to specify anything. For more information about server-side encryption, including SSE-S3 and SSE-KMS, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html\\\">Protecting Data Using Server-Side Encryption</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> </li> </ul> <p> <b>Working with the Response Body</b> </p> <p>Given the response size is unknown, Amazon S3 Select streams the response as a series of messages and includes a <code>Transfer-Encoding</code> header with <code>chunked</code> as its value in the response. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTSelectObjectAppendix.html\\\">Appendix: SelectObjectContent Response</a> .</p> <p/> <p> <b>GetObject Support</b> </p> <p>The <code>SelectObjectContent</code> operation does not support the following <code>GetObject</code> functionality. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a>.</p> <ul> <li> <p> <code>Range</code>: Although you can specify a scan range for an Amazon S3 Select request (see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_SelectObjectContent.html#AmazonS3-SelectObjectContent-request-ScanRange\\\">SelectObjectContentRequest - ScanRange</a> in the request parameters), you cannot specify the range of bytes of an object to return. </p> </li> <li> <p>GLACIER, DEEP_ARCHIVE and REDUCED_REDUNDANCY storage classes: You cannot specify the GLACIER, DEEP_ARCHIVE, or <code>REDUCED_REDUNDANCY</code> storage classes. For more information, about storage classes see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingMetadata.html#storage-class-intro\\\">Storage Classes</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> </li> </ul> <p/> <p> <b>Special Errors</b> </p> <p>For a list of special errors for this operation, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#SelectObjectContentErrorCodeList\\\">List of SELECT Object Content Error Codes</a> </p> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html\\\">GetObject</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycleConfiguration.html\\\">GetBucketLifecycleConfiguration</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html\\\">PutBucketLifecycleConfiguration</a> </p> </li> </ul>\"\
    },\
    \"UploadPart\":{\
      \"name\":\"UploadPart\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}/{Key+}\"\
      },\
      \"input\":{\"shape\":\"UploadPartRequest\"},\
      \"output\":{\"shape\":\"UploadPartOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadUploadPart.html\",\
      \"documentation\":\"<p>Uploads a part in a multipart upload.</p> <note> <p>In this operation, you provide part data in your request. However, you have an option to specify your existing Amazon S3 object as a data source for the part you are uploading. To upload a part from an existing object, you use the <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html\\\">UploadPartCopy</a> operation. </p> </note> <p>You must initiate a multipart upload (see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html\\\">CreateMultipartUpload</a>) before you can upload any part. In response to your initiate request, Amazon S3 returns an upload ID, a unique identifier, that you must include in your upload part request.</p> <p>Part numbers can be any number from 1 to 10,000, inclusive. A part number uniquely identifies a part and also defines its position within the object being created. If you upload a new part using the same part number that was used with a previous part, the previously uploaded part is overwritten. Each part must be at least 5 MB in size, except the last part. There is no size limit on the last part of your multipart upload.</p> <p>To ensure that data is not corrupted when traversing the network, specify the <code>Content-MD5</code> header in the upload part request. Amazon S3 checks the part data against the provided MD5 value. If they do not match, Amazon S3 returns an error. </p> <p>If the upload request is signed with Signature Version 4, then AWS S3 uses the <code>x-amz-content-sha256</code> header as a checksum instead of <code>Content-MD5</code>. For more information see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-auth-using-authorization-header.html\\\">Authenticating Requests: Using the Authorization Header (AWS Signature Version 4)</a>. </p> <p> <b>Note:</b> After you initiate multipart upload and upload one or more parts, you must either complete or abort multipart upload in order to stop getting charged for storage of the uploaded parts. Only after you either complete or abort multipart upload, Amazon S3 frees up the parts storage and stops charging you for the parts storage.</p> <p>For more information on multipart uploads, go to <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html\\\">Multipart Upload Overview</a> in the <i>Amazon Simple Storage Service Developer Guide </i>.</p> <p>For information on the permissions required to use the multipart upload API, go to <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html\\\">Multipart Upload API and Permissions</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>You can optionally request server-side encryption where Amazon S3 encrypts your data as it writes it to disks in its data centers and decrypts it for you when you access it. You have the option of providing your own encryption key, or you can use the AWS managed encryption keys. If you choose to provide your own encryption key, the request headers you provide in the request must match the headers you used in the request to initiate the upload by using <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html\\\">CreateMultipartUpload</a>. For more information, go to <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingServerSideEncryption.html\\\">Using Server-Side Encryption</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>Server-side encryption is supported by the S3 Multipart Upload actions. Unless you are using a customer-provided encryption key, you don't need to specify the encryption parameters in each UploadPart request. Instead, you only need to specify the server-side encryption parameters in the initial Initiate Multipart request. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html\\\">CreateMultipartUpload</a>.</p> <p>If you requested server-side encryption using a customer-provided encryption key in your initiate multipart upload request, you must provide identical encryption information in each part upload using the following headers.</p> <ul> <li> <p>x-amz-server-side-encryption-customer-algorithm</p> </li> <li> <p>x-amz-server-side-encryption-customer-key</p> </li> <li> <p>x-amz-server-side-encryption-customer-key-MD5</p> </li> </ul> <p class=\\\"title\\\"> <b>Special Errors</b> </p> <ul> <li> <ul> <li> <p> <i>Code: NoSuchUpload</i> </p> </li> <li> <p> <i>Cause: The specified multipart upload does not exist. The upload ID might be invalid, or the multipart upload might have been aborted or completed.</i> </p> </li> <li> <p> <i> HTTP Status Code: 404 Not Found </i> </p> </li> <li> <p> <i>SOAP Fault Code Prefix: Client</i> </p> </li> </ul> </li> </ul> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html\\\">CreateMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CompleteMultipartUpload.html\\\">CompleteMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_AbortMultipartUpload.html\\\">AbortMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListParts.html\\\">ListParts</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListMultipartUploads.html\\\">ListMultipartUploads</a> </p> </li> </ul>\"\
    },\
    \"UploadPartCopy\":{\
      \"name\":\"UploadPartCopy\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/{Bucket}/{Key+}\"\
      },\
      \"input\":{\"shape\":\"UploadPartCopyRequest\"},\
      \"output\":{\"shape\":\"UploadPartCopyOutput\"},\
      \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadUploadPartCopy.html\",\
      \"documentation\":\"<p>Uploads a part by copying data from an existing object as data source. You specify the data source by adding the request header <code>x-amz-copy-source</code> in your request and a byte range by adding the request header <code>x-amz-copy-source-range</code> in your request. </p> <p>The minimum allowable part size for a multipart upload is 5 MB. For more information about multipart upload limits, go to <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/qfacts.html\\\">Quick Facts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>. </p> <note> <p>Instead of using an existing object as part data, you might use the <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html\\\">UploadPart</a> operation and provide data in your request.</p> </note> <p>You must initiate a multipart upload before you can upload any part. In response to your initiate request. Amazon S3 returns a unique identifier, the upload ID, that you must include in your upload part request.</p> <p>For more information about using the <code>UploadPartCopy</code> operation, see the following:</p> <ul> <li> <p>For conceptual information about multipart uploads, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/uploadobjusingmpu.html\\\">Uploading Objects Using Multipart Upload</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> </li> <li> <p>For information about permissions required to use the multipart upload API, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html\\\">Multipart Upload API and Permissions</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> </li> <li> <p>For information about copying objects using a single atomic operation vs. the multipart upload, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ObjectOperations.html\\\">Operations on Objects</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> </li> <li> <p>For information about using server-side encryption with customer-provided encryption keys with the UploadPartCopy operation, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html\\\">CopyObject</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html\\\">UploadPart</a>.</p> </li> </ul> <p>Note the following additional considerations about the request headers <code>x-amz-copy-source-if-match</code>, <code>x-amz-copy-source-if-none-match</code>, <code>x-amz-copy-source-if-unmodified-since</code>, and <code>x-amz-copy-source-if-modified-since</code>:</p> <p> </p> <ul> <li> <p> <b>Consideration 1</b> - If both of the <code>x-amz-copy-source-if-match</code> and <code>x-amz-copy-source-if-unmodified-since</code> headers are present in the request as follows:</p> <p> <code>x-amz-copy-source-if-match</code> condition evaluates to <code>true</code>, and;</p> <p> <code>x-amz-copy-source-if-unmodified-since</code> condition evaluates to <code>false</code>;</p> <p>Amazon S3 returns <code>200 OK</code> and copies the data. </p> </li> <li> <p> <b>Consideration 2</b> - If both of the <code>x-amz-copy-source-if-none-match</code> and <code>x-amz-copy-source-if-modified-since</code> headers are present in the request as follows:</p> <p> <code>x-amz-copy-source-if-none-match</code> condition evaluates to <code>false</code>, and;</p> <p> <code>x-amz-copy-source-if-modified-since</code> condition evaluates to <code>true</code>;</p> <p>Amazon S3 returns <code>412 Precondition Failed</code> response code. </p> </li> </ul> <p> <b>Versioning</b> </p> <p>If your bucket has versioning enabled, you could have multiple versions of the same object. By default, <code>x-amz-copy-source</code> identifies the current version of the object to copy. If the current version is a delete marker and you don't specify a versionId in the <code>x-amz-copy-source</code>, Amazon S3 returns a 404 error, because the object does not exist. If you specify versionId in the <code>x-amz-copy-source</code> and the versionId is a delete marker, Amazon S3 returns an HTTP 400 error, because you are not allowed to specify a delete marker as a version for the <code>x-amz-copy-source</code>. </p> <p>You can optionally specify a specific version of the source object to copy by adding the <code>versionId</code> subresource as shown in the following example:</p> <p> <code>x-amz-copy-source: /bucket/object?versionId=version id</code> </p> <p class=\\\"title\\\"> <b>Special Errors</b> </p> <ul> <li> <ul> <li> <p> <i>Code: NoSuchUpload</i> </p> </li> <li> <p> <i>Cause: The specified multipart upload does not exist. The upload ID might be invalid, or the multipart upload might have been aborted or completed.</i> </p> </li> <li> <p> <i>HTTP Status Code: 404 Not Found</i> </p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code: InvalidRequest</i> </p> </li> <li> <p> <i>Cause: The specified copy source is not supported as a byte-range copy source.</i> </p> </li> <li> <p> <i>HTTP Status Code: 400 Bad Request</i> </p> </li> </ul> </li> </ul> <p class=\\\"title\\\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html\\\">CreateMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html\\\">UploadPart</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_CompleteMultipartUpload.html\\\">CompleteMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_AbortMultipartUpload.html\\\">AbortMultipartUpload</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListParts.html\\\">ListParts</a> </p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListMultipartUploads.html\\\">ListMultipartUploads</a> </p> </li> </ul>\"\
    }\
  },\
  \"shapes\":{\
    \"AbortDate\":{\"type\":\"timestamp\"},\
    \"AbortIncompleteMultipartUpload\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DaysAfterInitiation\":{\
          \"shape\":\"DaysAfterInitiation\",\
          \"documentation\":\"<p>Specifies the number of days after which Amazon S3 aborts an incomplete multipart upload.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the days since the initiation of an incomplete multipart upload that Amazon S3 will wait before permanently removing all parts of the upload. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config\\\"> Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
    },\
    \"AbortMultipartUploadOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      }\
    },\
    \"AbortMultipartUploadRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\",\
        \"UploadId\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name to which the upload was taking place. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Key of the object for which the multipart upload was initiated.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"UploadId\":{\
          \"shape\":\"MultipartUploadId\",\
          \"documentation\":\"<p>Upload ID that identifies the multipart upload.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"uploadId\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"AbortRuleId\":{\"type\":\"string\"},\
    \"AccelerateConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Status\":{\
          \"shape\":\"BucketAccelerateStatus\",\
          \"documentation\":\"<p>Specifies the transfer acceleration status of the bucket.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Configures the transfer acceleration state for an Amazon S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html\\\">Amazon S3 Transfer Acceleration</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
    },\
    \"AcceptRanges\":{\"type\":\"string\"},\
    \"AccessControlPolicy\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Grants\":{\
          \"shape\":\"Grants\",\
          \"documentation\":\"<p>A list of grants.</p>\",\
          \"locationName\":\"AccessControlList\"\
        },\
        \"Owner\":{\
          \"shape\":\"Owner\",\
          \"documentation\":\"<p>Container for the bucket owner's display name and ID.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the elements that set the ACL permissions for an object per grantee.</p>\"\
    },\
    \"AccessControlTranslation\":{\
      \"type\":\"structure\",\
      \"required\":[\"Owner\"],\
      \"members\":{\
        \"Owner\":{\
          \"shape\":\"OwnerOverride\",\
          \"documentation\":\"<p>Specifies the replica ownership. For default and valid values, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTreplication.html\\\">PUT bucket replication</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A container for information about access control for replicas.</p>\"\
    },\
    \"AccountId\":{\"type\":\"string\"},\
    \"AllowQuotedRecordDelimiter\":{\"type\":\"boolean\"},\
    \"AllowedHeader\":{\"type\":\"string\"},\
    \"AllowedHeaders\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AllowedHeader\"},\
      \"flattened\":true\
    },\
    \"AllowedMethod\":{\"type\":\"string\"},\
    \"AllowedMethods\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AllowedMethod\"},\
      \"flattened\":true\
    },\
    \"AllowedOrigin\":{\"type\":\"string\"},\
    \"AllowedOrigins\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AllowedOrigin\"},\
      \"flattened\":true\
    },\
    \"AnalyticsAndOperator\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The prefix to use when evaluating an AND predicate: The prefix that an object must have to be included in the metrics results.</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagSet\",\
          \"documentation\":\"<p>The list of tags to use when evaluating an AND predicate.</p>\",\
          \"flattened\":true,\
          \"locationName\":\"Tag\"\
        }\
      },\
      \"documentation\":\"<p>A conjunction (logical AND) of predicates, which is used in evaluating a metrics filter. The operator must have at least two predicates in any combination, and an object must match all of the predicates for the filter to apply.</p>\"\
    },\
    \"AnalyticsConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Id\",\
        \"StorageClassAnalysis\"\
      ],\
      \"members\":{\
        \"Id\":{\
          \"shape\":\"AnalyticsId\",\
          \"documentation\":\"<p>The ID that identifies the analytics configuration.</p>\"\
        },\
        \"Filter\":{\
          \"shape\":\"AnalyticsFilter\",\
          \"documentation\":\"<p>The filter used to describe a set of objects for analyses. A filter must have exactly one prefix, one tag, or one conjunction (AnalyticsAndOperator). If no filter is provided, all objects will be considered in any analysis.</p>\"\
        },\
        \"StorageClassAnalysis\":{\
          \"shape\":\"StorageClassAnalysis\",\
          \"documentation\":\"<p> Contains data related to access patterns to be collected and made available to analyze the tradeoffs between different storage classes. </p>\"\
        }\
      },\
      \"documentation\":\"<p> Specifies the configuration and any analyses for the analytics filter of an Amazon S3 bucket.</p>\"\
    },\
    \"AnalyticsConfigurationList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AnalyticsConfiguration\"},\
      \"flattened\":true\
    },\
    \"AnalyticsExportDestination\":{\
      \"type\":\"structure\",\
      \"required\":[\"S3BucketDestination\"],\
      \"members\":{\
        \"S3BucketDestination\":{\
          \"shape\":\"AnalyticsS3BucketDestination\",\
          \"documentation\":\"<p>A destination signifying output to an S3 bucket.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Where to publish the analytics results.</p>\"\
    },\
    \"AnalyticsFilter\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The prefix to use when evaluating an analytics filter.</p>\"\
        },\
        \"Tag\":{\
          \"shape\":\"Tag\",\
          \"documentation\":\"<p>The tag to use when evaluating an analytics filter.</p>\"\
        },\
        \"And\":{\
          \"shape\":\"AnalyticsAndOperator\",\
          \"documentation\":\"<p>A conjunction (logical AND) of predicates, which is used in evaluating an analytics filter. The operator must have at least two predicates.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The filter used to describe a set of objects for analyses. A filter must have exactly one prefix, one tag, or one conjunction (AnalyticsAndOperator). If no filter is provided, all objects will be considered in any analysis.</p>\"\
    },\
    \"AnalyticsId\":{\"type\":\"string\"},\
    \"AnalyticsS3BucketDestination\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Format\",\
        \"Bucket\"\
      ],\
      \"members\":{\
        \"Format\":{\
          \"shape\":\"AnalyticsS3ExportFileFormat\",\
          \"documentation\":\"<p>Specifies the file format used when exporting data to Amazon S3.</p>\"\
        },\
        \"BucketAccountId\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account ID that owns the destination S3 bucket. If no account ID is provided, the owner is not validated before exporting data.</p> <note> <p> Although this value is optional, we strongly recommend that you set it to help prevent problems if the destination bucket ownership changes. </p> </note>\"\
        },\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the bucket to which data is exported.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The prefix to use when exporting data. The prefix is prepended to all results.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains information about where to publish the analytics results.</p>\"\
    },\
    \"AnalyticsS3ExportFileFormat\":{\
      \"type\":\"string\",\
      \"enum\":[\"CSV\"]\
    },\
    \"Body\":{\"type\":\"blob\"},\
    \"Bucket\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Name\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket.</p>\"\
        },\
        \"CreationDate\":{\
          \"shape\":\"CreationDate\",\
          \"documentation\":\"<p>Date the bucket was created.</p>\"\
        }\
      },\
      \"documentation\":\"<p> In terms of implementation, a Bucket is a resource. An Amazon S3 bucket name is globally unique, and the namespace is shared by all AWS accounts. </p>\"\
    },\
    \"BucketAccelerateStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Enabled\",\
        \"Suspended\"\
      ]\
    },\
    \"BucketAlreadyExists\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The requested bucket name is not available. The bucket namespace is shared by all users of the system. Select a different name and try again.</p>\",\
      \"exception\":true\
    },\
    \"BucketAlreadyOwnedByYou\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The bucket you tried to create already exists, and you own it. Amazon S3 returns this error in all AWS Regions except in the North Virginia Region. For legacy compatibility, if you re-create an existing bucket that you already own in the North Virginia Region, Amazon S3 returns 200 OK and resets the bucket access control lists (ACLs).</p>\",\
      \"exception\":true\
    },\
    \"BucketCannedACL\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"private\",\
        \"public-read\",\
        \"public-read-write\",\
        \"authenticated-read\"\
      ]\
    },\
    \"BucketLifecycleConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\"Rules\"],\
      \"members\":{\
        \"Rules\":{\
          \"shape\":\"LifecycleRules\",\
          \"documentation\":\"<p>A lifecycle rule for individual objects in an Amazon S3 bucket.</p>\",\
          \"locationName\":\"Rule\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the lifecycle configuration for objects in an Amazon S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html\\\">Object Lifecycle Management</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
    },\
    \"BucketLocationConstraint\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"af-south-1\",\
        \"ap-east-1\",\
        \"ap-northeast-1\",\
        \"ap-northeast-2\",\
        \"ap-northeast-3\",\
        \"ap-south-1\",\
        \"ap-southeast-1\",\
        \"ap-southeast-2\",\
        \"ap-southeast-3\",\
        \"ca-central-1\",\
        \"cn-north-1\",\
        \"cn-northwest-1\",\
        \"EU\",\
        \"eu-central-1\",\
        \"eu-north-1\",\
        \"eu-south-1\",\
        \"eu-west-1\",\
        \"eu-west-2\",\
        \"eu-west-3\",\
        \"me-central-1\",\
        \"me-south-1\",\
        \"sa-east-1\",\
        \"us-east-2\",\
        \"us-gov-east-1\",\
        \"us-gov-west-1\",\
        \"us-west-1\",\
        \"us-west-2\"\
      ]\
    },\
    \"BucketLoggingStatus\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"LoggingEnabled\":{\"shape\":\"LoggingEnabled\"}\
      },\
      \"documentation\":\"<p>Container for logging status information.</p>\"\
    },\
    \"BucketLogsPermission\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"FULL_CONTROL\",\
        \"READ\",\
        \"WRITE\"\
      ]\
    },\
    \"BucketName\":{\"type\":\"string\"},\
    \"BucketVersioningStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Enabled\",\
        \"Suspended\"\
      ]\
    },\
    \"Buckets\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"Bucket\",\
        \"locationName\":\"Bucket\"\
      }\
    },\
    \"BypassGovernanceRetention\":{\"type\":\"boolean\"},\
    \"BytesProcessed\":{\"type\":\"long\"},\
    \"BytesReturned\":{\"type\":\"long\"},\
    \"BytesScanned\":{\"type\":\"long\"},\
    \"CORSConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\"CORSRules\"],\
      \"members\":{\
        \"CORSRules\":{\
          \"shape\":\"CORSRules\",\
          \"documentation\":\"<p>A set of origins and methods (cross-origin access that you want to allow). You can add up to 100 rules to the configuration.</p>\",\
          \"locationName\":\"CORSRule\"\
        }\
      },\
      \"documentation\":\"<p>Describes the cross-origin access configuration for objects in an Amazon S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html\\\">Enabling Cross-Origin Resource Sharing</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
    },\
    \"CORSRule\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AllowedMethods\",\
        \"AllowedOrigins\"\
      ],\
      \"members\":{\
        \"AllowedHeaders\":{\
          \"shape\":\"AllowedHeaders\",\
          \"documentation\":\"<p>Headers that are specified in the <code>Access-Control-Request-Headers</code> header. These headers are allowed in a preflight OPTIONS request. In response to any preflight OPTIONS request, Amazon S3 returns any requested headers that are allowed.</p>\",\
          \"locationName\":\"AllowedHeader\"\
        },\
        \"AllowedMethods\":{\
          \"shape\":\"AllowedMethods\",\
          \"documentation\":\"<p>An HTTP method that you allow the origin to execute. Valid values are <code>GET</code>, <code>PUT</code>, <code>HEAD</code>, <code>POST</code>, and <code>DELETE</code>.</p>\",\
          \"locationName\":\"AllowedMethod\"\
        },\
        \"AllowedOrigins\":{\
          \"shape\":\"AllowedOrigins\",\
          \"documentation\":\"<p>One or more origins you want customers to be able to access the bucket from.</p>\",\
          \"locationName\":\"AllowedOrigin\"\
        },\
        \"ExposeHeaders\":{\
          \"shape\":\"ExposeHeaders\",\
          \"documentation\":\"<p>One or more headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript <code>XMLHttpRequest</code> object).</p>\",\
          \"locationName\":\"ExposeHeader\"\
        },\
        \"MaxAgeSeconds\":{\
          \"shape\":\"MaxAgeSeconds\",\
          \"documentation\":\"<p>The time in seconds that your browser is to cache the preflight response for the specified resource.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies a cross-origin access rule for an Amazon S3 bucket.</p>\"\
    },\
    \"CORSRules\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"CORSRule\"},\
      \"flattened\":true\
    },\
    \"CSVInput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"FileHeaderInfo\":{\
          \"shape\":\"FileHeaderInfo\",\
          \"documentation\":\"<p>Describes the first line of input. Valid values are:</p> <ul> <li> <p> <code>NONE</code>: First line is not a header.</p> </li> <li> <p> <code>IGNORE</code>: First line is a header, but you can't use the header values to indicate the column in an expression. You can use column position (such as _1, _2, â¦) to indicate the column (<code>SELECT s._1 FROM OBJECT s</code>).</p> </li> <li> <p> <code>Use</code>: First line is a header, and you can use the header value to identify a column in an expression (<code>SELECT \\\"name\\\" FROM OBJECT</code>). </p> </li> </ul>\"\
        },\
        \"Comments\":{\
          \"shape\":\"Comments\",\
          \"documentation\":\"<p>A single character used to indicate that a row should be ignored when the character is present at the start of that row. You can specify any character to indicate a comment line.</p>\"\
        },\
        \"QuoteEscapeCharacter\":{\
          \"shape\":\"QuoteEscapeCharacter\",\
          \"documentation\":\"<p>A single character used for escaping the quotation mark character inside an already escaped value. For example, the value \\\"\\\"\\\" a , b \\\"\\\"\\\" is parsed as \\\" a , b \\\".</p>\"\
        },\
        \"RecordDelimiter\":{\
          \"shape\":\"RecordDelimiter\",\
          \"documentation\":\"<p>A single character used to separate individual records in the input. Instead of the default value, you can specify an arbitrary delimiter.</p>\"\
        },\
        \"FieldDelimiter\":{\
          \"shape\":\"FieldDelimiter\",\
          \"documentation\":\"<p>A single character used to separate individual fields in a record. You can specify an arbitrary delimiter.</p>\"\
        },\
        \"QuoteCharacter\":{\
          \"shape\":\"QuoteCharacter\",\
          \"documentation\":\"<p>A single character used for escaping when the field delimiter is part of the value. For example, if the value is <code>a, b</code>, Amazon S3 wraps this field value in quotation marks, as follows: <code>\\\" a , b \\\"</code>.</p> <p>Type: String</p> <p>Default: <code>\\\"</code> </p> <p>Ancestors: <code>CSV</code> </p>\"\
        },\
        \"AllowQuotedRecordDelimiter\":{\
          \"shape\":\"AllowQuotedRecordDelimiter\",\
          \"documentation\":\"<p>Specifies that CSV field values may contain quoted record delimiters and such records should be allowed. Default value is FALSE. Setting this value to TRUE may lower performance.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes how an uncompressed comma-separated values (CSV)-formatted input object is formatted.</p>\"\
    },\
    \"CSVOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"QuoteFields\":{\
          \"shape\":\"QuoteFields\",\
          \"documentation\":\"<p>Indicates whether to use quotation marks around output fields. </p> <ul> <li> <p> <code>ALWAYS</code>: Always use quotation marks for output fields.</p> </li> <li> <p> <code>ASNEEDED</code>: Use quotation marks for output fields when needed.</p> </li> </ul>\"\
        },\
        \"QuoteEscapeCharacter\":{\
          \"shape\":\"QuoteEscapeCharacter\",\
          \"documentation\":\"<p>The single character used for escaping the quote character inside an already escaped value.</p>\"\
        },\
        \"RecordDelimiter\":{\
          \"shape\":\"RecordDelimiter\",\
          \"documentation\":\"<p>A single character used to separate individual records in the output. Instead of the default value, you can specify an arbitrary delimiter.</p>\"\
        },\
        \"FieldDelimiter\":{\
          \"shape\":\"FieldDelimiter\",\
          \"documentation\":\"<p>The value used to separate individual fields in a record. You can specify an arbitrary delimiter.</p>\"\
        },\
        \"QuoteCharacter\":{\
          \"shape\":\"QuoteCharacter\",\
          \"documentation\":\"<p>A single character used for escaping when the field delimiter is part of the value. For example, if the value is <code>a, b</code>, Amazon S3 wraps this field value in quotation marks, as follows: <code>\\\" a , b \\\"</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes how uncompressed comma-separated values (CSV)-formatted results are formatted.</p>\"\
    },\
    \"CacheControl\":{\"type\":\"string\"},\
    \"CloudFunction\":{\"type\":\"string\"},\
    \"CloudFunctionConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Id\":{\"shape\":\"NotificationId\"},\
        \"Event\":{\
          \"shape\":\"Event\",\
          \"deprecated\":true\
        },\
        \"Events\":{\
          \"shape\":\"EventList\",\
          \"documentation\":\"<p>Bucket events for which to send notifications.</p>\",\
          \"locationName\":\"Event\"\
        },\
        \"CloudFunction\":{\
          \"shape\":\"CloudFunction\",\
          \"documentation\":\"<p>Lambda cloud function ARN that Amazon S3 can invoke when it detects events of the specified type.</p>\"\
        },\
        \"InvocationRole\":{\
          \"shape\":\"CloudFunctionInvocationRole\",\
          \"documentation\":\"<p>The role supporting the invocation of the Lambda function</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for specifying the AWS Lambda notification configuration.</p>\"\
    },\
    \"CloudFunctionInvocationRole\":{\"type\":\"string\"},\
    \"Code\":{\"type\":\"string\"},\
    \"Comments\":{\"type\":\"string\"},\
    \"CommonPrefix\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>Container for the specified common prefix.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for all (if there are any) keys between Prefix and the next occurrence of the string specified by a delimiter. CommonPrefixes lists keys that act like subdirectories in the directory specified by Prefix. For example, if the prefix is notes/ and the delimiter is a slash (/) as in notes/summer/july, the common prefix is notes/summer/. </p>\"\
    },\
    \"CommonPrefixList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"CommonPrefix\"},\
      \"flattened\":true\
    },\
    \"CompleteMultipartUploadOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Location\":{\
          \"shape\":\"Location\",\
          \"documentation\":\"<p>The URI that identifies the newly created object.</p>\"\
        },\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket that contains the newly created object.</p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The object key of the newly created object.</p>\"\
        },\
        \"Expiration\":{\
          \"shape\":\"Expiration\",\
          \"documentation\":\"<p>If the object expiration is configured, this will contain the expiration date (expiry-date) and rule ID (rule-id). The value of rule-id is URL encoded.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expiration\"\
        },\
        \"ETag\":{\
          \"shape\":\"ETag\",\
          \"documentation\":\"<p>Entity tag that identifies the newly created object's data. Objects with different object data will have different entity tags. The entity tag is an opaque string. The entity tag may or may not be an MD5 digest of the object data. If the entity tag is not an MD5 digest of the object data, it will contain one or more nonhexadecimal characters and/or will consist of less than 32 or more than 32 hexadecimal digits.</p>\"\
        },\
        \"ServerSideEncryption\":{\
          \"shape\":\"ServerSideEncryption\",\
          \"documentation\":\"<p>If you specified server-side encryption either with an Amazon S3-managed encryption key or an AWS KMS customer master key (CMK) in your initiate multipart upload request, the response includes this header. It confirms the encryption algorithm that Amazon S3 used to encrypt the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>Version ID of the newly created object, in case the bucket has versioning turned on.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-version-id\"\
        },\
        \"SSEKMSKeyId\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\"\
        },\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      }\
    },\
    \"CompleteMultipartUploadRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\",\
        \"UploadId\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>Name of the bucket to which the multipart upload was initiated.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Object key for which the multipart upload was initiated.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"MultipartUpload\":{\
          \"shape\":\"CompletedMultipartUpload\",\
          \"documentation\":\"<p>The container for the multipart upload request information.</p>\",\
          \"locationName\":\"CompleteMultipartUpload\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"UploadId\":{\
          \"shape\":\"MultipartUploadId\",\
          \"documentation\":\"<p>ID for the initiated multipart upload.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"uploadId\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"MultipartUpload\"\
    },\
    \"CompletedMultipartUpload\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Parts\":{\
          \"shape\":\"CompletedPartList\",\
          \"documentation\":\"<p>Array of CompletedPart data types.</p>\",\
          \"locationName\":\"Part\"\
        }\
      },\
      \"documentation\":\"<p>The container for the completed multipart upload details.</p>\"\
    },\
    \"CompletedPart\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ETag\":{\
          \"shape\":\"ETag\",\
          \"documentation\":\"<p>Entity tag returned when the part was uploaded.</p>\"\
        },\
        \"PartNumber\":{\
          \"shape\":\"PartNumber\",\
          \"documentation\":\"<p>Part number that identifies the part. This is a positive integer between 1 and 10,000.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Details of the parts that were uploaded.</p>\"\
    },\
    \"CompletedPartList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"CompletedPart\"},\
      \"flattened\":true\
    },\
    \"CompressionType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"NONE\",\
        \"GZIP\",\
        \"BZIP2\"\
      ]\
    },\
    \"Condition\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"HttpErrorCodeReturnedEquals\":{\
          \"shape\":\"HttpErrorCodeReturnedEquals\",\
          \"documentation\":\"<p>The HTTP error code when the redirect is applied. In the event of an error, if the error code equals this value, then the specified redirect is applied. Required when parent element <code>Condition</code> is specified and sibling <code>KeyPrefixEquals</code> is not specified. If both are specified, then both must be true for the redirect to be applied.</p>\"\
        },\
        \"KeyPrefixEquals\":{\
          \"shape\":\"KeyPrefixEquals\",\
          \"documentation\":\"<p>The object key name prefix when the redirect is applied. For example, to redirect requests for <code>ExamplePage.html</code>, the key prefix will be <code>ExamplePage.html</code>. To redirect request for all pages with the prefix <code>docs/</code>, the key prefix will be <code>/docs</code>, which identifies all objects in the <code>docs/</code> folder. Required when the parent element <code>Condition</code> is specified and sibling <code>HttpErrorCodeReturnedEquals</code> is not specified. If both conditions are specified, both must be true for the redirect to be applied.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A container for describing a condition that must be met for the specified redirect to apply. For example, 1. If request is for pages in the <code>/docs</code> folder, redirect to the <code>/documents</code> folder. 2. If request results in HTTP error 4xx, redirect request to another host where you might process the error.</p>\"\
    },\
    \"ConfirmRemoveSelfBucketAccess\":{\"type\":\"boolean\"},\
    \"ContentDisposition\":{\"type\":\"string\"},\
    \"ContentEncoding\":{\"type\":\"string\"},\
    \"ContentLanguage\":{\"type\":\"string\"},\
    \"ContentLength\":{\"type\":\"long\"},\
    \"ContentMD5\":{\"type\":\"string\"},\
    \"ContentRange\":{\"type\":\"string\"},\
    \"ContentType\":{\"type\":\"string\"},\
    \"ContinuationEvent\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p/>\",\
      \"event\":true\
    },\
    \"CopyObjectOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CopyObjectResult\":{\
          \"shape\":\"CopyObjectResult\",\
          \"documentation\":\"<p>Container for all response elements.</p>\"\
        },\
        \"Expiration\":{\
          \"shape\":\"Expiration\",\
          \"documentation\":\"<p>If the object expiration is configured, the response includes this header.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expiration\"\
        },\
        \"CopySourceVersionId\":{\
          \"shape\":\"CopySourceVersionId\",\
          \"documentation\":\"<p>Version of the copied object in the destination bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-version-id\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>Version ID of the newly created copy.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-version-id\"\
        },\
        \"ServerSideEncryption\":{\
          \"shape\":\"ServerSideEncryption\",\
          \"documentation\":\"<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"SSEKMSKeyId\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\"\
        },\
        \"SSEKMSEncryptionContext\":{\
          \"shape\":\"SSEKMSEncryptionContext\",\
          \"documentation\":\"<p>If present, specifies the AWS KMS Encryption Context to use for object encryption. The value of this header is a base64-encoded UTF-8 string holding JSON with the encryption context key-value pairs.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-context\"\
        },\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      },\
      \"payload\":\"CopyObjectResult\"\
    },\
    \"CopyObjectRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"CopySource\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"ACL\":{\
          \"shape\":\"ObjectCannedACL\",\
          \"documentation\":\"<p>The canned ACL to apply to the object.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-acl\"\
        },\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the destination bucket.</p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"CacheControl\":{\
          \"shape\":\"CacheControl\",\
          \"documentation\":\"<p>Specifies caching behavior along the request/reply chain.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Cache-Control\"\
        },\
        \"ContentDisposition\":{\
          \"shape\":\"ContentDisposition\",\
          \"documentation\":\"<p>Specifies presentational information for the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Disposition\"\
        },\
        \"ContentEncoding\":{\
          \"shape\":\"ContentEncoding\",\
          \"documentation\":\"<p>Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Encoding\"\
        },\
        \"ContentLanguage\":{\
          \"shape\":\"ContentLanguage\",\
          \"documentation\":\"<p>The language the content is in.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Language\"\
        },\
        \"ContentType\":{\
          \"shape\":\"ContentType\",\
          \"documentation\":\"<p>A standard MIME type describing the format of the object data.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Type\"\
        },\
        \"CopySource\":{\
          \"shape\":\"CopySource\",\
          \"documentation\":\"<p>Specifies the source object for the copy operation. You specify the value in one of two formats, depending on whether you want to access the source object through an <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-points.html\\\">access point</a>:</p> <ul> <li> <p>For objects not accessed through an access point, specify the name of the source bucket and the key of the source object, separated by a slash (/). For example, to copy the object <code>reports/january.pdf</code> from the bucket <code>awsexamplebucket</code>, use <code>awsexamplebucket/reports/january.pdf</code>. The value must be URL encoded.</p> </li> <li> <p>For objects accessed through access points, specify the Amazon Resource Name (ARN) of the object as accessed through the access point, in the format <code>arn:aws:s3:&lt;Region&gt;:&lt;account-id&gt;:accesspoint/&lt;access-point-name&gt;/object/&lt;key&gt;</code>. For example, to copy the object <code>reports/january.pdf</code> through access point <code>my-access-point</code> owned by account <code>123456789012</code> in Region <code>us-west-2</code>, use the URL encoding of <code>arn:aws:s3:us-west-2:123456789012:accesspoint/my-access-point/object/reports/january.pdf</code>. The value must be URL encoded.</p> <note> <p>Amazon S3 supports copy operations using access points only when the source and destination buckets are in the same AWS Region.</p> </note> <p>Alternatively, for objects accessed through Amazon S3 on Outposts, specify the ARN of the object as accessed in the format <code>arn:aws:s3-outposts:&lt;Region&gt;:&lt;account-id&gt;:outpost/&lt;outpost-id&gt;/object/&lt;key&gt;</code>. For example, to copy the object <code>reports/january.pdf</code> through outpost <code>my-outpost</code> owned by account <code>123456789012</code> in Region <code>us-west-2</code>, use the URL encoding of <code>arn:aws:s3-outposts:us-west-2:123456789012:outpost/my-outpost/object/reports/january.pdf</code>. The value must be URL encoded. </p> </li> </ul> <p>To copy a specific version of an object, append <code>?versionId=&lt;version-id&gt;</code> to the value (for example, <code>awsexamplebucket/reports/january.pdf?versionId=QUpfdndhfd8438MNFDN93jdnJFkdmqnh893</code>). If you don't specify a version ID, Amazon S3 copies the latest version of the source object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source\"\
        },\
        \"CopySourceIfMatch\":{\
          \"shape\":\"CopySourceIfMatch\",\
          \"documentation\":\"<p>Copies the object if its entity tag (ETag) matches the specified tag.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-if-match\"\
        },\
        \"CopySourceIfModifiedSince\":{\
          \"shape\":\"CopySourceIfModifiedSince\",\
          \"documentation\":\"<p>Copies the object if it has been modified since the specified time.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-if-modified-since\"\
        },\
        \"CopySourceIfNoneMatch\":{\
          \"shape\":\"CopySourceIfNoneMatch\",\
          \"documentation\":\"<p>Copies the object if its entity tag (ETag) is different than the specified ETag.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-if-none-match\"\
        },\
        \"CopySourceIfUnmodifiedSince\":{\
          \"shape\":\"CopySourceIfUnmodifiedSince\",\
          \"documentation\":\"<p>Copies the object if it hasn't been modified since the specified time.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-if-unmodified-since\"\
        },\
        \"Expires\":{\
          \"shape\":\"Expires\",\
          \"documentation\":\"<p>The date and time at which the object is no longer cacheable.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Expires\"\
        },\
        \"GrantFullControl\":{\
          \"shape\":\"GrantFullControl\",\
          \"documentation\":\"<p>Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-full-control\"\
        },\
        \"GrantRead\":{\
          \"shape\":\"GrantRead\",\
          \"documentation\":\"<p>Allows grantee to read the object data and its metadata.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-read\"\
        },\
        \"GrantReadACP\":{\
          \"shape\":\"GrantReadACP\",\
          \"documentation\":\"<p>Allows grantee to read the object ACL.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-read-acp\"\
        },\
        \"GrantWriteACP\":{\
          \"shape\":\"GrantWriteACP\",\
          \"documentation\":\"<p>Allows grantee to write the ACL for the applicable object.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-write-acp\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The key of the destination object.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"Metadata\":{\
          \"shape\":\"Metadata\",\
          \"documentation\":\"<p>A map of metadata to store with the object in S3.</p>\",\
          \"location\":\"headers\",\
          \"locationName\":\"x-amz-meta-\"\
        },\
        \"MetadataDirective\":{\
          \"shape\":\"MetadataDirective\",\
          \"documentation\":\"<p>Specifies whether the metadata is copied from the source object or replaced with metadata provided in the request.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-metadata-directive\"\
        },\
        \"TaggingDirective\":{\
          \"shape\":\"TaggingDirective\",\
          \"documentation\":\"<p>Specifies whether the object tag-set are copied from the source object or replaced with tag-set provided in the request.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-tagging-directive\"\
        },\
        \"ServerSideEncryption\":{\
          \"shape\":\"ServerSideEncryption\",\
          \"documentation\":\"<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption\"\
        },\
        \"StorageClass\":{\
          \"shape\":\"StorageClass\",\
          \"documentation\":\"<p>By default, Amazon S3 uses the STANDARD Storage Class to store newly created objects. The STANDARD storage class provides high durability and high availability. Depending on performance needs, you can specify a different Storage Class. Amazon S3 on Outposts only uses the OUTPOSTS Storage Class. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html\\\">Storage Classes</a> in the <i>Amazon S3 Service Developer Guide</i>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-storage-class\"\
        },\
        \"WebsiteRedirectLocation\":{\
          \"shape\":\"WebsiteRedirectLocation\",\
          \"documentation\":\"<p>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-website-redirect-location\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>Specifies the algorithm to use to when encrypting the object (for example, AES256).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKey\":{\
          \"shape\":\"SSECustomerKey\",\
          \"documentation\":\"<p>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key. The key must be appropriate for use with the algorithm specified in the <code>x-amz-server-side-encryption-customer-algorithm</code> header.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"SSEKMSKeyId\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. For information about configuring using any of the officially supported AWS SDKs and AWS CLI, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version\\\">Specifying the Signature Version in Request Authentication</a> in the <i>Amazon S3 Developer Guide</i>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\"\
        },\
        \"SSEKMSEncryptionContext\":{\
          \"shape\":\"SSEKMSEncryptionContext\",\
          \"documentation\":\"<p>Specifies the AWS KMS Encryption Context to use for object encryption. The value of this header is a base64-encoded UTF-8 string holding JSON with the encryption context key-value pairs.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-context\"\
        },\
        \"CopySourceSSECustomerAlgorithm\":{\
          \"shape\":\"CopySourceSSECustomerAlgorithm\",\
          \"documentation\":\"<p>Specifies the algorithm to use when decrypting the source object (for example, AES256).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-server-side-encryption-customer-algorithm\"\
        },\
        \"CopySourceSSECustomerKey\":{\
          \"shape\":\"CopySourceSSECustomerKey\",\
          \"documentation\":\"<p>Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-server-side-encryption-customer-key\"\
        },\
        \"CopySourceSSECustomerKeyMD5\":{\
          \"shape\":\"CopySourceSSECustomerKeyMD5\",\
          \"documentation\":\"<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-server-side-encryption-customer-key-MD5\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"Tagging\":{\
          \"shape\":\"TaggingHeader\",\
          \"documentation\":\"<p>The tag-set for the object destination object this value must be used in conjunction with the <code>TaggingDirective</code>. The tag-set must be encoded as URL Query parameters.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-tagging\"\
        },\
        \"ObjectLockMode\":{\
          \"shape\":\"ObjectLockMode\",\
          \"documentation\":\"<p>The Object Lock mode that you want to apply to the copied object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-mode\"\
        },\
        \"ObjectLockRetainUntilDate\":{\
          \"shape\":\"ObjectLockRetainUntilDate\",\
          \"documentation\":\"<p>The date and time when you want the copied object's Object Lock to expire.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-retain-until-date\"\
        },\
        \"ObjectLockLegalHoldStatus\":{\
          \"shape\":\"ObjectLockLegalHoldStatus\",\
          \"documentation\":\"<p>Specifies whether you want to apply a Legal Hold to the copied object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-legal-hold\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected destination bucket owner. If the destination bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        },\
        \"ExpectedSourceBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected source bucket owner. If the source bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-source-expected-bucket-owner\"\
        }\
      }\
    },\
    \"CopyObjectResult\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ETag\":{\
          \"shape\":\"ETag\",\
          \"documentation\":\"<p>Returns the ETag of the new object. The ETag reflects only changes to the contents of an object, not its metadata. The source and destination ETag is identical for a successfully copied object.</p>\"\
        },\
        \"LastModified\":{\
          \"shape\":\"LastModified\",\
          \"documentation\":\"<p>Returns the date that the object was last modified.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for all response elements.</p>\"\
    },\
    \"CopyPartResult\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ETag\":{\
          \"shape\":\"ETag\",\
          \"documentation\":\"<p>Entity tag of the object.</p>\"\
        },\
        \"LastModified\":{\
          \"shape\":\"LastModified\",\
          \"documentation\":\"<p>Date and time at which the object was uploaded.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for all response elements.</p>\"\
    },\
    \"CopySource\":{\
      \"type\":\"string\",\
      \"pattern\":\"\\\\/.+\\\\/.+\"\
    },\
    \"CopySourceIfMatch\":{\"type\":\"string\"},\
    \"CopySourceIfModifiedSince\":{\"type\":\"timestamp\"},\
    \"CopySourceIfNoneMatch\":{\"type\":\"string\"},\
    \"CopySourceIfUnmodifiedSince\":{\"type\":\"timestamp\"},\
    \"CopySourceRange\":{\"type\":\"string\"},\
    \"CopySourceSSECustomerAlgorithm\":{\"type\":\"string\"},\
    \"CopySourceSSECustomerKey\":{\
      \"type\":\"string\",\
      \"sensitive\":true\
    },\
    \"CopySourceSSECustomerKeyMD5\":{\"type\":\"string\"},\
    \"CopySourceVersionId\":{\"type\":\"string\"},\
    \"CreateBucketConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"LocationConstraint\":{\
          \"shape\":\"BucketLocationConstraint\",\
          \"documentation\":\"<p>Specifies the Region where the bucket will be created. If you don't specify a Region, the bucket is created in the US East (N. Virginia) Region (us-east-1).</p>\"\
        }\
      },\
      \"documentation\":\"<p>The configuration information for the bucket.</p>\"\
    },\
    \"CreateBucketOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Location\":{\
          \"shape\":\"Location\",\
          \"documentation\":\"<p>Specifies the Region where the bucket will be created. If you are creating a bucket on the US East (N. Virginia) Region (us-east-1), you do not need to specify the location.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Location\"\
        }\
      }\
    },\
    \"CreateBucketRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"ACL\":{\
          \"shape\":\"BucketCannedACL\",\
          \"documentation\":\"<p>The canned ACL to apply to the bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-acl\"\
        },\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket to create.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"CreateBucketConfiguration\":{\
          \"shape\":\"CreateBucketConfiguration\",\
          \"documentation\":\"<p>The configuration information for the bucket.</p>\",\
          \"locationName\":\"CreateBucketConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"GrantFullControl\":{\
          \"shape\":\"GrantFullControl\",\
          \"documentation\":\"<p>Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-full-control\"\
        },\
        \"GrantRead\":{\
          \"shape\":\"GrantRead\",\
          \"documentation\":\"<p>Allows grantee to list the objects in the bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-read\"\
        },\
        \"GrantReadACP\":{\
          \"shape\":\"GrantReadACP\",\
          \"documentation\":\"<p>Allows grantee to read the bucket ACL.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-read-acp\"\
        },\
        \"GrantWrite\":{\
          \"shape\":\"GrantWrite\",\
          \"documentation\":\"<p>Allows grantee to create, overwrite, and delete any object in the bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-write\"\
        },\
        \"GrantWriteACP\":{\
          \"shape\":\"GrantWriteACP\",\
          \"documentation\":\"<p>Allows grantee to write the ACL for the applicable bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-write-acp\"\
        },\
        \"ObjectLockEnabledForBucket\":{\
          \"shape\":\"ObjectLockEnabledForBucket\",\
          \"documentation\":\"<p>Specifies whether you want S3 Object Lock to be enabled for the new bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-bucket-object-lock-enabled\"\
        }\
      },\
      \"payload\":\"CreateBucketConfiguration\"\
    },\
    \"CreateMultipartUploadOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AbortDate\":{\
          \"shape\":\"AbortDate\",\
          \"documentation\":\"<p>If the bucket has a lifecycle rule configured with an action to abort incomplete multipart uploads and the prefix in the lifecycle rule matches the object name in the request, the response includes this header. The header indicates when the initiated multipart upload becomes eligible for an abort operation. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config\\\"> Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy</a>.</p> <p>The response also includes the <code>x-amz-abort-rule-id</code> header that provides the ID of the lifecycle configuration rule that defines this action.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-abort-date\"\
        },\
        \"AbortRuleId\":{\
          \"shape\":\"AbortRuleId\",\
          \"documentation\":\"<p>This header is returned along with the <code>x-amz-abort-date</code> header. It identifies the applicable lifecycle configuration rule that defines the action to abort incomplete multipart uploads.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-abort-rule-id\"\
        },\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket to which the multipart upload was initiated. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Object key for which the multipart upload was initiated.</p>\"\
        },\
        \"UploadId\":{\
          \"shape\":\"MultipartUploadId\",\
          \"documentation\":\"<p>ID for the initiated multipart upload.</p>\"\
        },\
        \"ServerSideEncryption\":{\
          \"shape\":\"ServerSideEncryption\",\
          \"documentation\":\"<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"SSEKMSKeyId\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\"\
        },\
        \"SSEKMSEncryptionContext\":{\
          \"shape\":\"SSEKMSEncryptionContext\",\
          \"documentation\":\"<p>If present, specifies the AWS KMS Encryption Context to use for object encryption. The value of this header is a base64-encoded UTF-8 string holding JSON with the encryption context key-value pairs.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-context\"\
        },\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      }\
    },\
    \"CreateMultipartUploadRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"ACL\":{\
          \"shape\":\"ObjectCannedACL\",\
          \"documentation\":\"<p>The canned ACL to apply to the object.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-acl\"\
        },\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket to which to initiate the upload</p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"CacheControl\":{\
          \"shape\":\"CacheControl\",\
          \"documentation\":\"<p>Specifies caching behavior along the request/reply chain.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Cache-Control\"\
        },\
        \"ContentDisposition\":{\
          \"shape\":\"ContentDisposition\",\
          \"documentation\":\"<p>Specifies presentational information for the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Disposition\"\
        },\
        \"ContentEncoding\":{\
          \"shape\":\"ContentEncoding\",\
          \"documentation\":\"<p>Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Encoding\"\
        },\
        \"ContentLanguage\":{\
          \"shape\":\"ContentLanguage\",\
          \"documentation\":\"<p>The language the content is in.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Language\"\
        },\
        \"ContentType\":{\
          \"shape\":\"ContentType\",\
          \"documentation\":\"<p>A standard MIME type describing the format of the object data.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Type\"\
        },\
        \"Expires\":{\
          \"shape\":\"Expires\",\
          \"documentation\":\"<p>The date and time at which the object is no longer cacheable.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Expires\"\
        },\
        \"GrantFullControl\":{\
          \"shape\":\"GrantFullControl\",\
          \"documentation\":\"<p>Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-full-control\"\
        },\
        \"GrantRead\":{\
          \"shape\":\"GrantRead\",\
          \"documentation\":\"<p>Allows grantee to read the object data and its metadata.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-read\"\
        },\
        \"GrantReadACP\":{\
          \"shape\":\"GrantReadACP\",\
          \"documentation\":\"<p>Allows grantee to read the object ACL.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-read-acp\"\
        },\
        \"GrantWriteACP\":{\
          \"shape\":\"GrantWriteACP\",\
          \"documentation\":\"<p>Allows grantee to write the ACL for the applicable object.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-write-acp\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Object key for which the multipart upload is to be initiated.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"Metadata\":{\
          \"shape\":\"Metadata\",\
          \"documentation\":\"<p>A map of metadata to store with the object in S3.</p>\",\
          \"location\":\"headers\",\
          \"locationName\":\"x-amz-meta-\"\
        },\
        \"ServerSideEncryption\":{\
          \"shape\":\"ServerSideEncryption\",\
          \"documentation\":\"<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption\"\
        },\
        \"StorageClass\":{\
          \"shape\":\"StorageClass\",\
          \"documentation\":\"<p>By default, Amazon S3 uses the STANDARD Storage Class to store newly created objects. The STANDARD storage class provides high durability and high availability. Depending on performance needs, you can specify a different Storage Class. Amazon S3 on Outposts only uses the OUTPOSTS Storage Class. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html\\\">Storage Classes</a> in the <i>Amazon S3 Service Developer Guide</i>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-storage-class\"\
        },\
        \"WebsiteRedirectLocation\":{\
          \"shape\":\"WebsiteRedirectLocation\",\
          \"documentation\":\"<p>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-website-redirect-location\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>Specifies the algorithm to use to when encrypting the object (for example, AES256).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKey\":{\
          \"shape\":\"SSECustomerKey\",\
          \"documentation\":\"<p>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key. The key must be appropriate for use with the algorithm specified in the <code>x-amz-server-side-encryption-customer-algorithm</code> header.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"SSEKMSKeyId\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>Specifies the ID of the symmetric customer managed AWS KMS CMK to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. For information about configuring using any of the officially supported AWS SDKs and AWS CLI, see <a href=\\\"https://docs.aws.amazon.com/http:/docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version\\\">Specifying the Signature Version in Request Authentication</a> in the <i>Amazon S3 Developer Guide</i>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\"\
        },\
        \"SSEKMSEncryptionContext\":{\
          \"shape\":\"SSEKMSEncryptionContext\",\
          \"documentation\":\"<p>Specifies the AWS KMS Encryption Context to use for object encryption. The value of this header is a base64-encoded UTF-8 string holding JSON with the encryption context key-value pairs.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-context\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"Tagging\":{\
          \"shape\":\"TaggingHeader\",\
          \"documentation\":\"<p>The tag-set for the object. The tag-set must be encoded as URL Query parameters.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-tagging\"\
        },\
        \"ObjectLockMode\":{\
          \"shape\":\"ObjectLockMode\",\
          \"documentation\":\"<p>Specifies the Object Lock mode that you want to apply to the uploaded object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-mode\"\
        },\
        \"ObjectLockRetainUntilDate\":{\
          \"shape\":\"ObjectLockRetainUntilDate\",\
          \"documentation\":\"<p>Specifies the date and time when you want the Object Lock to expire.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-retain-until-date\"\
        },\
        \"ObjectLockLegalHoldStatus\":{\
          \"shape\":\"ObjectLockLegalHoldStatus\",\
          \"documentation\":\"<p>Specifies whether you want to apply a Legal Hold to the uploaded object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-legal-hold\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"CreationDate\":{\"type\":\"timestamp\"},\
    \"Date\":{\
      \"type\":\"timestamp\",\
      \"timestampFormat\":\"iso8601\"\
    },\
    \"Days\":{\"type\":\"integer\"},\
    \"DaysAfterInitiation\":{\"type\":\"integer\"},\
    \"DefaultRetention\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Mode\":{\
          \"shape\":\"ObjectLockRetentionMode\",\
          \"documentation\":\"<p>The default Object Lock retention mode you want to apply to new objects placed in the specified bucket.</p>\"\
        },\
        \"Days\":{\
          \"shape\":\"Days\",\
          \"documentation\":\"<p>The number of days that you want to specify for the default retention period.</p>\"\
        },\
        \"Years\":{\
          \"shape\":\"Years\",\
          \"documentation\":\"<p>The number of years that you want to specify for the default retention period.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The container element for specifying the default Object Lock retention settings for new objects placed in the specified bucket.</p>\"\
    },\
    \"Delete\":{\
      \"type\":\"structure\",\
      \"required\":[\"Objects\"],\
      \"members\":{\
        \"Objects\":{\
          \"shape\":\"ObjectIdentifierList\",\
          \"documentation\":\"<p>The objects to delete.</p>\",\
          \"locationName\":\"Object\"\
        },\
        \"Quiet\":{\
          \"shape\":\"Quiet\",\
          \"documentation\":\"<p>Element to enable quiet mode for the request. When you add this element, you must set its value to true.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for the objects to delete.</p>\"\
    },\
    \"DeleteBucketAnalyticsConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Id\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket from which an analytics configuration is deleted.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Id\":{\
          \"shape\":\"AnalyticsId\",\
          \"documentation\":\"<p>The ID that identifies the analytics configuration.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"id\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteBucketCorsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>Specifies the bucket whose <code>cors</code> configuration is being deleted.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteBucketEncryptionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket containing the server-side encryption configuration to delete.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteBucketInventoryConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Id\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket containing the inventory configuration to delete.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Id\":{\
          \"shape\":\"InventoryId\",\
          \"documentation\":\"<p>The ID used to identify the inventory configuration.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"id\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteBucketLifecycleRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name of the lifecycle to delete.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteBucketMetricsConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Id\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket containing the metrics configuration to delete.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Id\":{\
          \"shape\":\"MetricsId\",\
          \"documentation\":\"<p>The ID used to identify the metrics configuration.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"id\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteBucketOwnershipControlsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The Amazon S3 bucket whose <code>OwnershipControls</code> you want to delete. </p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteBucketPolicyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteBucketReplicationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p> The bucket name. </p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteBucketRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>Specifies the bucket being deleted.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteBucketTaggingRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket that has the tag set to be removed.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteBucketWebsiteRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name for which you want to remove the website configuration. </p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteMarker\":{\"type\":\"boolean\"},\
    \"DeleteMarkerEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Owner\":{\
          \"shape\":\"Owner\",\
          \"documentation\":\"<p>The account that created the delete marker.&gt;</p>\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The object key.</p>\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>Version ID of an object.</p>\"\
        },\
        \"IsLatest\":{\
          \"shape\":\"IsLatest\",\
          \"documentation\":\"<p>Specifies whether the object is (true) or is not (false) the latest version of an object.</p>\"\
        },\
        \"LastModified\":{\
          \"shape\":\"LastModified\",\
          \"documentation\":\"<p>Date and time the object was last modified.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Information about the delete marker.</p>\"\
    },\
    \"DeleteMarkerReplication\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Status\":{\
          \"shape\":\"DeleteMarkerReplicationStatus\",\
          \"documentation\":\"<p>Indicates whether to replicate delete markers.</p> <note> <p> In the current implementation, Amazon S3 doesn't replicate the delete markers. The status must be <code>Disabled</code>. </p> </note>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies whether Amazon S3 replicates the delete markers. If you specify a <code>Filter</code>, you must specify this element. However, in the latest version of replication configuration (when <code>Filter</code> is specified), Amazon S3 doesn't replicate delete markers. Therefore, the <code>DeleteMarkerReplication</code> element can contain only &lt;Status&gt;Disabled&lt;/Status&gt;. For an example configuration, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-add-config.html#replication-config-min-rule-config\\\">Basic Rule Configuration</a>. </p> <note> <p> If you don't specify the <code>Filter</code> element, Amazon S3 assumes that the replication configuration is the earlier version, V1. In the earlier version, Amazon S3 handled replication of delete markers differently. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-add-config.html#replication-backward-compat-considerations\\\">Backward Compatibility</a>.</p> </note>\"\
    },\
    \"DeleteMarkerReplicationStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Enabled\",\
        \"Disabled\"\
      ]\
    },\
    \"DeleteMarkerVersionId\":{\"type\":\"string\"},\
    \"DeleteMarkers\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"DeleteMarkerEntry\"},\
      \"flattened\":true\
    },\
    \"DeleteObjectOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DeleteMarker\":{\
          \"shape\":\"DeleteMarker\",\
          \"documentation\":\"<p>Specifies whether the versioned object that was permanently deleted was (true) or was not (false) a delete marker.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-delete-marker\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>Returns the version ID of the delete marker created as a result of the DELETE operation.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-version-id\"\
        },\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      }\
    },\
    \"DeleteObjectRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name of the bucket containing the object. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Key name of the object to delete.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"MFA\":{\
          \"shape\":\"MFA\",\
          \"documentation\":\"<p>The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device. Required to permanently delete a versioned object if versioning is configured with MFA delete enabled.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-mfa\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>VersionId used to reference a specific version of the object.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"versionId\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"BypassGovernanceRetention\":{\
          \"shape\":\"BypassGovernanceRetention\",\
          \"documentation\":\"<p>Indicates whether S3 Object Lock should bypass Governance-mode restrictions to process this operation.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-bypass-governance-retention\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteObjectTaggingOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>The versionId of the object the tag-set was removed from.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-version-id\"\
        }\
      }\
    },\
    \"DeleteObjectTaggingRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name containing the objects from which to remove the tags. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Name of the object key.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>The versionId of the object that the tag-set will be removed from.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"versionId\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeleteObjectsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Deleted\":{\
          \"shape\":\"DeletedObjects\",\
          \"documentation\":\"<p>Container element for a successful delete. It identifies the object that was successfully deleted.</p>\"\
        },\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        },\
        \"Errors\":{\
          \"shape\":\"Errors\",\
          \"documentation\":\"<p>Container for a failed delete operation that describes the object that Amazon S3 attempted to delete and the error it encountered.</p>\",\
          \"locationName\":\"Error\"\
        }\
      }\
    },\
    \"DeleteObjectsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Delete\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name containing the objects to delete. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Delete\":{\
          \"shape\":\"Delete\",\
          \"documentation\":\"<p>Container for the request.</p>\",\
          \"locationName\":\"Delete\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"MFA\":{\
          \"shape\":\"MFA\",\
          \"documentation\":\"<p>The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device. Required to permanently delete a versioned object if versioning is configured with MFA delete enabled.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-mfa\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"BypassGovernanceRetention\":{\
          \"shape\":\"BypassGovernanceRetention\",\
          \"documentation\":\"<p>Specifies whether you want to delete this object even if it has a Governance-type Object Lock in place. You must have sufficient permissions to perform this operation.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-bypass-governance-retention\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"Delete\"\
    },\
    \"DeletePublicAccessBlockRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The Amazon S3 bucket whose <code>PublicAccessBlock</code> configuration you want to delete. </p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"DeletedObject\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The name of the deleted object.</p>\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>The version ID of the deleted object.</p>\"\
        },\
        \"DeleteMarker\":{\
          \"shape\":\"DeleteMarker\",\
          \"documentation\":\"<p>Specifies whether the versioned object that was permanently deleted was (true) or was not (false) a delete marker. In a simple DELETE, this header indicates whether (true) or not (false) a delete marker was created.</p>\"\
        },\
        \"DeleteMarkerVersionId\":{\
          \"shape\":\"DeleteMarkerVersionId\",\
          \"documentation\":\"<p>The version ID of the delete marker created as a result of the DELETE operation. If you delete a specific object version, the value returned by this header is the version ID of the object version deleted.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Information about the deleted object.</p>\"\
    },\
    \"DeletedObjects\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"DeletedObject\"},\
      \"flattened\":true\
    },\
    \"Delimiter\":{\"type\":\"string\"},\
    \"Description\":{\"type\":\"string\"},\
    \"Destination\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p> The Amazon Resource Name (ARN) of the bucket where you want Amazon S3 to store the results.</p>\"\
        },\
        \"Account\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>Destination bucket owner account ID. In a cross-account scenario, if you direct Amazon S3 to change replica ownership to the AWS account that owns the destination bucket by specifying the <code>AccessControlTranslation</code> property, this is the account ID of the destination bucket owner. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-change-owner.html\\\">Replication Additional Configuration: Changing the Replica Owner</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
        },\
        \"StorageClass\":{\
          \"shape\":\"StorageClass\",\
          \"documentation\":\"<p> The storage class to use when replicating objects, such as S3 Standard or reduced redundancy. By default, Amazon S3 uses the storage class of the source object to create the object replica. </p> <p>For valid values, see the <code>StorageClass</code> element of the <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTreplication.html\\\">PUT Bucket replication</a> action in the <i>Amazon Simple Storage Service API Reference</i>.</p>\"\
        },\
        \"AccessControlTranslation\":{\
          \"shape\":\"AccessControlTranslation\",\
          \"documentation\":\"<p>Specify this only in a cross-account scenario (where source and destination bucket owners are not the same), and you want to change replica ownership to the AWS account that owns the destination bucket. If this is not specified in the replication configuration, the replicas are owned by same AWS account that owns the source object.</p>\"\
        },\
        \"EncryptionConfiguration\":{\
          \"shape\":\"EncryptionConfiguration\",\
          \"documentation\":\"<p>A container that provides information about encryption. If <code>SourceSelectionCriteria</code> is specified, you must specify this element.</p>\"\
        },\
        \"ReplicationTime\":{\
          \"shape\":\"ReplicationTime\",\
          \"documentation\":\"<p> A container specifying S3 Replication Time Control (S3 RTC), including whether S3 RTC is enabled and the time when all objects and operations on objects must be replicated. Must be specified together with a <code>Metrics</code> block. </p>\"\
        },\
        \"Metrics\":{\
          \"shape\":\"Metrics\",\
          \"documentation\":\"<p> A container specifying replication metrics-related settings enabling metrics and Amazon S3 events for S3 Replication Time Control (S3 RTC). Must be specified together with a <code>ReplicationTime</code> block. </p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies information about where to publish analysis or configuration results for an Amazon S3 bucket and S3 Replication Time Control (S3 RTC).</p>\"\
    },\
    \"DisplayName\":{\"type\":\"string\"},\
    \"ETag\":{\"type\":\"string\"},\
    \"EmailAddress\":{\"type\":\"string\"},\
    \"EnableRequestProgress\":{\"type\":\"boolean\"},\
    \"EncodingType\":{\
      \"type\":\"string\",\
      \"documentation\":\"<p>Requests Amazon S3 to encode the object keys in the response and specifies the encoding method to use. An object key may contain any Unicode character; however, XML 1.0 parser cannot parse some characters, such as characters with an ASCII value from 0 to 10. For characters that are not supported in XML 1.0, you can add this parameter to request that Amazon S3 encode the keys in the response.</p>\",\
      \"enum\":[\"url\"]\
    },\
    \"Encryption\":{\
      \"type\":\"structure\",\
      \"required\":[\"EncryptionType\"],\
      \"members\":{\
        \"EncryptionType\":{\
          \"shape\":\"ServerSideEncryption\",\
          \"documentation\":\"<p>The server-side encryption algorithm used when storing job results in Amazon S3 (for example, AES256, aws:kms).</p>\"\
        },\
        \"KMSKeyId\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>If the encryption type is <code>aws:kms</code>, this optional value specifies the ID of the symmetric customer managed AWS KMS CMK to use for encryption of job results. Amazon S3 only supports symmetric CMKs. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\\\">Using Symmetric and Asymmetric Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"KMSContext\":{\
          \"shape\":\"KMSContext\",\
          \"documentation\":\"<p>If the encryption type is <code>aws:kms</code>, this optional value can be used to specify the encryption context for the restore results.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the type of server-side encryption used.</p>\"\
    },\
    \"EncryptionConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ReplicaKmsKeyID\":{\
          \"shape\":\"ReplicaKmsKeyID\",\
          \"documentation\":\"<p>Specifies the ID (Key ARN or Alias ARN) of the customer managed customer master key (CMK) stored in AWS Key Management Service (KMS) for the destination bucket. Amazon S3 uses this key to encrypt replica objects. Amazon S3 only supports symmetric customer managed CMKs. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\\\">Using Symmetric and Asymmetric Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies encryption-related information for an Amazon S3 bucket that is a destination for replicated objects.</p>\"\
    },\
    \"End\":{\"type\":\"long\"},\
    \"EndEvent\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>A message that indicates the request is complete and no more messages will be sent. You should not assume that the request is complete until the client receives an <code>EndEvent</code>.</p>\",\
      \"event\":true\
    },\
    \"Error\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The error key.</p>\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>The version ID of the error.</p>\"\
        },\
        \"Code\":{\
          \"shape\":\"Code\",\
          \"documentation\":\"<p>The error code is a string that uniquely identifies an error condition. It is meant to be read and understood by programs that detect and handle errors by type. </p> <p class=\\\"title\\\"> <b>Amazon S3 error codes</b> </p> <ul> <li> <ul> <li> <p> <i>Code:</i> AccessDenied </p> </li> <li> <p> <i>Description:</i> Access Denied</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> AccountProblem</p> </li> <li> <p> <i>Description:</i> There is a problem with your AWS account that prevents the operation from completing successfully. Contact AWS Support for further assistance.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> AllAccessDisabled</p> </li> <li> <p> <i>Description:</i> All access to this Amazon S3 resource has been disabled. Contact AWS Support for further assistance.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> AmbiguousGrantByEmailAddress</p> </li> <li> <p> <i>Description:</i> The email address you provided is associated with more than one account.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> AuthorizationHeaderMalformed</p> </li> <li> <p> <i>Description:</i> The authorization header you provided is invalid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>HTTP Status Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> BadDigest</p> </li> <li> <p> <i>Description:</i> The Content-MD5 you specified did not match what we received.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> BucketAlreadyExists</p> </li> <li> <p> <i>Description:</i> The requested bucket name is not available. The bucket namespace is shared by all users of the system. Please select a different name and try again.</p> </li> <li> <p> <i>HTTP Status Code:</i> 409 Conflict</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> BucketAlreadyOwnedByYou</p> </li> <li> <p> <i>Description:</i> The bucket you tried to create already exists, and you own it. Amazon S3 returns this error in all AWS Regions except in the North Virginia Region. For legacy compatibility, if you re-create an existing bucket that you already own in the North Virginia Region, Amazon S3 returns 200 OK and resets the bucket access control lists (ACLs).</p> </li> <li> <p> <i>Code:</i> 409 Conflict (in all Regions except the North Virginia Region) </p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> BucketNotEmpty</p> </li> <li> <p> <i>Description:</i> The bucket you tried to delete is not empty.</p> </li> <li> <p> <i>HTTP Status Code:</i> 409 Conflict</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> CredentialsNotSupported</p> </li> <li> <p> <i>Description:</i> This request does not support credentials.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> CrossLocationLoggingProhibited</p> </li> <li> <p> <i>Description:</i> Cross-location logging not allowed. Buckets in one geographic location cannot log information to a bucket in another location.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> EntityTooSmall</p> </li> <li> <p> <i>Description:</i> Your proposed upload is smaller than the minimum allowed object size.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> EntityTooLarge</p> </li> <li> <p> <i>Description:</i> Your proposed upload exceeds the maximum allowed object size.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> ExpiredToken</p> </li> <li> <p> <i>Description:</i> The provided token has expired.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> IllegalVersioningConfigurationException </p> </li> <li> <p> <i>Description:</i> Indicates that the versioning configuration specified in the request is invalid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> IncompleteBody</p> </li> <li> <p> <i>Description:</i> You did not provide the number of bytes specified by the Content-Length HTTP header</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> IncorrectNumberOfFilesInPostRequest</p> </li> <li> <p> <i>Description:</i> POST requires exactly one file upload per request.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InlineDataTooLarge</p> </li> <li> <p> <i>Description:</i> Inline data exceeds the maximum allowed size.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InternalError</p> </li> <li> <p> <i>Description:</i> We encountered an internal error. Please try again.</p> </li> <li> <p> <i>HTTP Status Code:</i> 500 Internal Server Error</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Server</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidAccessKeyId</p> </li> <li> <p> <i>Description:</i> The AWS access key ID you provided does not exist in our records.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidAddressingHeader</p> </li> <li> <p> <i>Description:</i> You must specify the Anonymous role.</p> </li> <li> <p> <i>HTTP Status Code:</i> N/A</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidArgument</p> </li> <li> <p> <i>Description:</i> Invalid Argument</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidBucketName</p> </li> <li> <p> <i>Description:</i> The specified bucket is not valid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidBucketState</p> </li> <li> <p> <i>Description:</i> The request is not valid with the current state of the bucket.</p> </li> <li> <p> <i>HTTP Status Code:</i> 409 Conflict</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidDigest</p> </li> <li> <p> <i>Description:</i> The Content-MD5 you specified is not valid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidEncryptionAlgorithmError</p> </li> <li> <p> <i>Description:</i> The encryption request you specified is not valid. The valid value is AES256.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidLocationConstraint</p> </li> <li> <p> <i>Description:</i> The specified location constraint is not valid. For more information about Regions, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html#access-bucket-intro\\\">How to Select a Region for Your Buckets</a>. </p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidObjectState</p> </li> <li> <p> <i>Description:</i> The operation is not valid for the current state of the object.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidPart</p> </li> <li> <p> <i>Description:</i> One or more of the specified parts could not be found. The part might not have been uploaded, or the specified entity tag might not have matched the part's entity tag.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidPartOrder</p> </li> <li> <p> <i>Description:</i> The list of parts was not in ascending order. Parts list must be specified in order by part number.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidPayer</p> </li> <li> <p> <i>Description:</i> All access to this object has been disabled. Please contact AWS Support for further assistance.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidPolicyDocument</p> </li> <li> <p> <i>Description:</i> The content of the form does not meet the conditions specified in the policy document.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRange</p> </li> <li> <p> <i>Description:</i> The requested range cannot be satisfied.</p> </li> <li> <p> <i>HTTP Status Code:</i> 416 Requested Range Not Satisfiable</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Please use AWS4-HMAC-SHA256.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> SOAP requests must be made over an HTTPS connection.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Acceleration is not supported for buckets with non-DNS compliant names.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Acceleration is not supported for buckets with periods (.) in their names.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Accelerate endpoint only supports virtual style requests.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Accelerate is not configured on this bucket.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Accelerate is disabled on this bucket.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Acceleration is not supported on this bucket. Contact AWS Support for more information.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Acceleration cannot be enabled on this bucket. Contact AWS Support for more information.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidSecurity</p> </li> <li> <p> <i>Description:</i> The provided security credentials are not valid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidSOAPRequest</p> </li> <li> <p> <i>Description:</i> The SOAP request body is invalid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidStorageClass</p> </li> <li> <p> <i>Description:</i> The storage class you specified is not valid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidTargetBucketForLogging</p> </li> <li> <p> <i>Description:</i> The target bucket for logging does not exist, is not owned by you, or does not have the appropriate grants for the log-delivery group. </p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidToken</p> </li> <li> <p> <i>Description:</i> The provided token is malformed or otherwise invalid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidURI</p> </li> <li> <p> <i>Description:</i> Couldn't parse the specified URI.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> KeyTooLongError</p> </li> <li> <p> <i>Description:</i> Your key is too long.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MalformedACLError</p> </li> <li> <p> <i>Description:</i> The XML you provided was not well-formed or did not validate against our published schema.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MalformedPOSTRequest </p> </li> <li> <p> <i>Description:</i> The body of your POST request is not well-formed multipart/form-data.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MalformedXML</p> </li> <li> <p> <i>Description:</i> This happens when the user sends malformed XML (XML that doesn't conform to the published XSD) for the configuration. The error message is, \\\"The XML you provided was not well-formed or did not validate against our published schema.\\\" </p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MaxMessageLengthExceeded</p> </li> <li> <p> <i>Description:</i> Your request was too big.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MaxPostPreDataLengthExceededError</p> </li> <li> <p> <i>Description:</i> Your POST request fields preceding the upload file were too large.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MetadataTooLarge</p> </li> <li> <p> <i>Description:</i> Your metadata headers exceed the maximum allowed metadata size.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MethodNotAllowed</p> </li> <li> <p> <i>Description:</i> The specified method is not allowed against this resource.</p> </li> <li> <p> <i>HTTP Status Code:</i> 405 Method Not Allowed</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MissingAttachment</p> </li> <li> <p> <i>Description:</i> A SOAP attachment was expected, but none were found.</p> </li> <li> <p> <i>HTTP Status Code:</i> N/A</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MissingContentLength</p> </li> <li> <p> <i>Description:</i> You must provide the Content-Length HTTP header.</p> </li> <li> <p> <i>HTTP Status Code:</i> 411 Length Required</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MissingRequestBodyError</p> </li> <li> <p> <i>Description:</i> This happens when the user sends an empty XML document as a request. The error message is, \\\"Request body is empty.\\\" </p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MissingSecurityElement</p> </li> <li> <p> <i>Description:</i> The SOAP 1.1 request is missing a security element.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MissingSecurityHeader</p> </li> <li> <p> <i>Description:</i> Your request is missing a required header.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoLoggingStatusForKey</p> </li> <li> <p> <i>Description:</i> There is no such thing as a logging status subresource for a key.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoSuchBucket</p> </li> <li> <p> <i>Description:</i> The specified bucket does not exist.</p> </li> <li> <p> <i>HTTP Status Code:</i> 404 Not Found</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoSuchBucketPolicy</p> </li> <li> <p> <i>Description:</i> The specified bucket does not have a bucket policy.</p> </li> <li> <p> <i>HTTP Status Code:</i> 404 Not Found</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoSuchKey</p> </li> <li> <p> <i>Description:</i> The specified key does not exist.</p> </li> <li> <p> <i>HTTP Status Code:</i> 404 Not Found</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoSuchLifecycleConfiguration</p> </li> <li> <p> <i>Description:</i> The lifecycle configuration does not exist. </p> </li> <li> <p> <i>HTTP Status Code:</i> 404 Not Found</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoSuchUpload</p> </li> <li> <p> <i>Description:</i> The specified multipart upload does not exist. The upload ID might be invalid, or the multipart upload might have been aborted or completed.</p> </li> <li> <p> <i>HTTP Status Code:</i> 404 Not Found</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoSuchVersion </p> </li> <li> <p> <i>Description:</i> Indicates that the version ID specified in the request does not match an existing version.</p> </li> <li> <p> <i>HTTP Status Code:</i> 404 Not Found</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NotImplemented</p> </li> <li> <p> <i>Description:</i> A header you provided implies functionality that is not implemented.</p> </li> <li> <p> <i>HTTP Status Code:</i> 501 Not Implemented</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Server</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NotSignedUp</p> </li> <li> <p> <i>Description:</i> Your account is not signed up for the Amazon S3 service. You must sign up before you can use Amazon S3. You can sign up at the following URL: https://aws.amazon.com/s3</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> OperationAborted</p> </li> <li> <p> <i>Description:</i> A conflicting conditional operation is currently in progress against this resource. Try again.</p> </li> <li> <p> <i>HTTP Status Code:</i> 409 Conflict</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> PermanentRedirect</p> </li> <li> <p> <i>Description:</i> The bucket you are attempting to access must be addressed using the specified endpoint. Send all future requests to this endpoint.</p> </li> <li> <p> <i>HTTP Status Code:</i> 301 Moved Permanently</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> PreconditionFailed</p> </li> <li> <p> <i>Description:</i> At least one of the preconditions you specified did not hold.</p> </li> <li> <p> <i>HTTP Status Code:</i> 412 Precondition Failed</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> Redirect</p> </li> <li> <p> <i>Description:</i> Temporary redirect.</p> </li> <li> <p> <i>HTTP Status Code:</i> 307 Moved Temporarily</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> RestoreAlreadyInProgress</p> </li> <li> <p> <i>Description:</i> Object restore is already in progress.</p> </li> <li> <p> <i>HTTP Status Code:</i> 409 Conflict</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> RequestIsNotMultiPartContent</p> </li> <li> <p> <i>Description:</i> Bucket POST must be of the enclosure-type multipart/form-data.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> RequestTimeout</p> </li> <li> <p> <i>Description:</i> Your socket connection to the server was not read from or written to within the timeout period.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> RequestTimeTooSkewed</p> </li> <li> <p> <i>Description:</i> The difference between the request time and the server's time is too large.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> RequestTorrentOfBucketError</p> </li> <li> <p> <i>Description:</i> Requesting the torrent file of a bucket is not permitted.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> SignatureDoesNotMatch</p> </li> <li> <p> <i>Description:</i> The request signature we calculated does not match the signature you provided. Check your AWS secret access key and signing method. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html\\\">REST Authentication</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/SOAPAuthentication.html\\\">SOAP Authentication</a> for details.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> ServiceUnavailable</p> </li> <li> <p> <i>Description:</i> Reduce your request rate.</p> </li> <li> <p> <i>HTTP Status Code:</i> 503 Service Unavailable</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Server</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> SlowDown</p> </li> <li> <p> <i>Description:</i> Reduce your request rate.</p> </li> <li> <p> <i>HTTP Status Code:</i> 503 Slow Down</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Server</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> TemporaryRedirect</p> </li> <li> <p> <i>Description:</i> You are being redirected to the bucket while DNS updates.</p> </li> <li> <p> <i>HTTP Status Code:</i> 307 Moved Temporarily</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> TokenRefreshRequired</p> </li> <li> <p> <i>Description:</i> The provided token must be refreshed.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> TooManyBuckets</p> </li> <li> <p> <i>Description:</i> You have attempted to create more buckets than allowed.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> UnexpectedContent</p> </li> <li> <p> <i>Description:</i> This request does not support content.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> UnresolvableGrantByEmailAddress</p> </li> <li> <p> <i>Description:</i> The email address you provided does not match any account on record.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> UserKeyMustBeSpecified</p> </li> <li> <p> <i>Description:</i> The bucket POST must contain the specified field name. If it is specified, check the order of the fields.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> </ul> <p/>\"\
        },\
        \"Message\":{\
          \"shape\":\"Message\",\
          \"documentation\":\"<p>The error message contains a generic description of the error condition in English. It is intended for a human audience. Simple programs display the message directly to the end user if they encounter an error condition they don't know how or don't care to handle. Sophisticated programs with more exhaustive error handling and proper internationalization are more likely to ignore the error message.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for all error elements.</p>\"\
    },\
    \"ErrorDocument\":{\
      \"type\":\"structure\",\
      \"required\":[\"Key\"],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The object key name to use when a 4XX class error occurs.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The error information.</p>\"\
    },\
    \"Errors\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Error\"},\
      \"flattened\":true\
    },\
    \"Event\":{\
      \"type\":\"string\",\
      \"documentation\":\"<p>The bucket event for which to send notifications.</p>\",\
      \"enum\":[\
        \"s3:ReducedRedundancyLostObject\",\
        \"s3:ObjectCreated:*\",\
        \"s3:ObjectCreated:Put\",\
        \"s3:ObjectCreated:Post\",\
        \"s3:ObjectCreated:Copy\",\
        \"s3:ObjectCreated:CompleteMultipartUpload\",\
        \"s3:ObjectRemoved:*\",\
        \"s3:ObjectRemoved:Delete\",\
        \"s3:ObjectRemoved:DeleteMarkerCreated\",\
        \"s3:ObjectRestore:*\",\
        \"s3:ObjectRestore:Post\",\
        \"s3:ObjectRestore:Completed\",\
        \"s3:Replication:*\",\
        \"s3:Replication:OperationFailedReplication\",\
        \"s3:Replication:OperationNotTracked\",\
        \"s3:Replication:OperationMissedThreshold\",\
        \"s3:Replication:OperationReplicatedAfterThreshold\"\
      ]\
    },\
    \"EventList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Event\"},\
      \"flattened\":true\
    },\
    \"ExistingObjectReplication\":{\
      \"type\":\"structure\",\
      \"required\":[\"Status\"],\
      \"members\":{\
        \"Status\":{\
          \"shape\":\"ExistingObjectReplicationStatus\",\
          \"documentation\":\"<p/>\"\
        }\
      },\
      \"documentation\":\"<p>Optional configuration to replicate existing source bucket objects. For more information, see <a href=\\\" https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-what-is-isnot-replicated.html#existing-object-replication\\\">Replicating Existing Objects</a> in the <i>Amazon S3 Developer Guide</i>. </p>\"\
    },\
    \"ExistingObjectReplicationStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Enabled\",\
        \"Disabled\"\
      ]\
    },\
    \"Expiration\":{\"type\":\"string\"},\
    \"ExpirationStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Enabled\",\
        \"Disabled\"\
      ]\
    },\
    \"ExpiredObjectDeleteMarker\":{\"type\":\"boolean\"},\
    \"Expires\":{\"type\":\"timestamp\"},\
    \"ExposeHeader\":{\"type\":\"string\"},\
    \"ExposeHeaders\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ExposeHeader\"},\
      \"flattened\":true\
    },\
    \"Expression\":{\"type\":\"string\"},\
    \"ExpressionType\":{\
      \"type\":\"string\",\
      \"enum\":[\"SQL\"]\
    },\
    \"FetchOwner\":{\"type\":\"boolean\"},\
    \"FieldDelimiter\":{\"type\":\"string\"},\
    \"FileHeaderInfo\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"USE\",\
        \"IGNORE\",\
        \"NONE\"\
      ]\
    },\
    \"FilterRule\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Name\":{\
          \"shape\":\"FilterRuleName\",\
          \"documentation\":\"<p>The object key name prefix or suffix identifying one or more objects to which the filtering rule applies. The maximum length is 1,024 characters. Overlapping prefixes and suffixes are not supported. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\\\">Configuring Event Notifications</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
        },\
        \"Value\":{\
          \"shape\":\"FilterRuleValue\",\
          \"documentation\":\"<p>The value that the filter searches for in object key names.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the Amazon S3 object key name to filter on and whether to filter on the suffix or prefix of the key name.</p>\"\
    },\
    \"FilterRuleList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"FilterRule\"},\
      \"documentation\":\"<p>A list of containers for the key-value pair that defines the criteria for the filter rule.</p>\",\
      \"flattened\":true\
    },\
    \"FilterRuleName\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"prefix\",\
        \"suffix\"\
      ]\
    },\
    \"FilterRuleValue\":{\"type\":\"string\"},\
    \"GetBucketAccelerateConfigurationOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Status\":{\
          \"shape\":\"BucketAccelerateStatus\",\
          \"documentation\":\"<p>The accelerate configuration of the bucket.</p>\"\
        }\
      }\
    },\
    \"GetBucketAccelerateConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket for which the accelerate configuration is retrieved.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketAclOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Owner\":{\
          \"shape\":\"Owner\",\
          \"documentation\":\"<p>Container for the bucket owner's display name and ID.</p>\"\
        },\
        \"Grants\":{\
          \"shape\":\"Grants\",\
          \"documentation\":\"<p>A list of grants.</p>\",\
          \"locationName\":\"AccessControlList\"\
        }\
      }\
    },\
    \"GetBucketAclRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>Specifies the S3 bucket whose ACL is being requested.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketAnalyticsConfigurationOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AnalyticsConfiguration\":{\
          \"shape\":\"AnalyticsConfiguration\",\
          \"documentation\":\"<p>The configuration and any analyses for the analytics filter.</p>\"\
        }\
      },\
      \"payload\":\"AnalyticsConfiguration\"\
    },\
    \"GetBucketAnalyticsConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Id\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket from which an analytics configuration is retrieved.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Id\":{\
          \"shape\":\"AnalyticsId\",\
          \"documentation\":\"<p>The ID that identifies the analytics configuration.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"id\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketCorsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CORSRules\":{\
          \"shape\":\"CORSRules\",\
          \"documentation\":\"<p>A set of origins and methods (cross-origin access that you want to allow). You can add up to 100 rules to the configuration.</p>\",\
          \"locationName\":\"CORSRule\"\
        }\
      }\
    },\
    \"GetBucketCorsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name for which to get the cors configuration.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketEncryptionOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ServerSideEncryptionConfiguration\":{\"shape\":\"ServerSideEncryptionConfiguration\"}\
      },\
      \"payload\":\"ServerSideEncryptionConfiguration\"\
    },\
    \"GetBucketEncryptionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket from which the server-side encryption configuration is retrieved.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketInventoryConfigurationOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"InventoryConfiguration\":{\
          \"shape\":\"InventoryConfiguration\",\
          \"documentation\":\"<p>Specifies the inventory configuration.</p>\"\
        }\
      },\
      \"payload\":\"InventoryConfiguration\"\
    },\
    \"GetBucketInventoryConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Id\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket containing the inventory configuration to retrieve.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Id\":{\
          \"shape\":\"InventoryId\",\
          \"documentation\":\"<p>The ID used to identify the inventory configuration.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"id\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketLifecycleConfigurationOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Rules\":{\
          \"shape\":\"LifecycleRules\",\
          \"documentation\":\"<p>Container for a lifecycle rule.</p>\",\
          \"locationName\":\"Rule\"\
        }\
      }\
    },\
    \"GetBucketLifecycleConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket for which to get the lifecycle information.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketLifecycleOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Rules\":{\
          \"shape\":\"Rules\",\
          \"documentation\":\"<p>Container for a lifecycle rule.</p>\",\
          \"locationName\":\"Rule\"\
        }\
      }\
    },\
    \"GetBucketLifecycleRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket for which to get the lifecycle information.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketLocationOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"LocationConstraint\":{\
          \"shape\":\"BucketLocationConstraint\",\
          \"documentation\":\"<p>Specifies the Region where the bucket resides. For a list of all the Amazon S3 supported location constraints by Region, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region\\\">Regions and Endpoints</a>. Buckets in Region <code>us-east-1</code> have a LocationConstraint of <code>null</code>.</p>\"\
        }\
      }\
    },\
    \"GetBucketLocationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket for which to get the location.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketLoggingOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"LoggingEnabled\":{\"shape\":\"LoggingEnabled\"}\
      }\
    },\
    \"GetBucketLoggingRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name for which to get the logging information.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketMetricsConfigurationOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"MetricsConfiguration\":{\
          \"shape\":\"MetricsConfiguration\",\
          \"documentation\":\"<p>Specifies the metrics configuration.</p>\"\
        }\
      },\
      \"payload\":\"MetricsConfiguration\"\
    },\
    \"GetBucketMetricsConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Id\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket containing the metrics configuration to retrieve.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Id\":{\
          \"shape\":\"MetricsId\",\
          \"documentation\":\"<p>The ID used to identify the metrics configuration.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"id\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketNotificationConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket for which to get the notification configuration.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketOwnershipControlsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"OwnershipControls\":{\
          \"shape\":\"OwnershipControls\",\
          \"documentation\":\"<p>The <code>OwnershipControls</code> (BucketOwnerPreferred or ObjectWriter) currently in effect for this Amazon S3 bucket.</p>\"\
        }\
      },\
      \"payload\":\"OwnershipControls\"\
    },\
    \"GetBucketOwnershipControlsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the Amazon S3 bucket whose <code>OwnershipControls</code> you want to retrieve. </p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketPolicyOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Policy\":{\
          \"shape\":\"Policy\",\
          \"documentation\":\"<p>The bucket policy as a JSON document.</p>\"\
        }\
      },\
      \"payload\":\"Policy\"\
    },\
    \"GetBucketPolicyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name for which to get the bucket policy.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketPolicyStatusOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"PolicyStatus\":{\
          \"shape\":\"PolicyStatus\",\
          \"documentation\":\"<p>The policy status for the specified bucket.</p>\"\
        }\
      },\
      \"payload\":\"PolicyStatus\"\
    },\
    \"GetBucketPolicyStatusRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the Amazon S3 bucket whose policy status you want to retrieve.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketReplicationOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ReplicationConfiguration\":{\"shape\":\"ReplicationConfiguration\"}\
      },\
      \"payload\":\"ReplicationConfiguration\"\
    },\
    \"GetBucketReplicationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name for which to get the replication information.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketRequestPaymentOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Payer\":{\
          \"shape\":\"Payer\",\
          \"documentation\":\"<p>Specifies who pays for the download and request fees.</p>\"\
        }\
      }\
    },\
    \"GetBucketRequestPaymentRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket for which to get the payment request configuration</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketTaggingOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\"TagSet\"],\
      \"members\":{\
        \"TagSet\":{\
          \"shape\":\"TagSet\",\
          \"documentation\":\"<p>Contains the tag set.</p>\"\
        }\
      }\
    },\
    \"GetBucketTaggingRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket for which to get the tagging information.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketVersioningOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Status\":{\
          \"shape\":\"BucketVersioningStatus\",\
          \"documentation\":\"<p>The versioning state of the bucket.</p>\"\
        },\
        \"MFADelete\":{\
          \"shape\":\"MFADeleteStatus\",\
          \"documentation\":\"<p>Specifies whether MFA delete is enabled in the bucket versioning configuration. This element is only returned if the bucket has been configured with MFA delete. If the bucket has never been so configured, this element is not returned.</p>\",\
          \"locationName\":\"MfaDelete\"\
        }\
      }\
    },\
    \"GetBucketVersioningRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket for which to get the versioning information.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetBucketWebsiteOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RedirectAllRequestsTo\":{\
          \"shape\":\"RedirectAllRequestsTo\",\
          \"documentation\":\"<p>Specifies the redirect behavior of all requests to a website endpoint of an Amazon S3 bucket.</p>\"\
        },\
        \"IndexDocument\":{\
          \"shape\":\"IndexDocument\",\
          \"documentation\":\"<p>The name of the index document for the website (for example <code>index.html</code>).</p>\"\
        },\
        \"ErrorDocument\":{\
          \"shape\":\"ErrorDocument\",\
          \"documentation\":\"<p>The object key name of the website error document to use for 4XX class errors.</p>\"\
        },\
        \"RoutingRules\":{\
          \"shape\":\"RoutingRules\",\
          \"documentation\":\"<p>Rules that define when a redirect is applied and the redirect behavior.</p>\"\
        }\
      }\
    },\
    \"GetBucketWebsiteRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name for which to get the website configuration.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetObjectAclOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Owner\":{\
          \"shape\":\"Owner\",\
          \"documentation\":\"<p> Container for the bucket owner's display name and ID.</p>\"\
        },\
        \"Grants\":{\
          \"shape\":\"Grants\",\
          \"documentation\":\"<p>A list of grants.</p>\",\
          \"locationName\":\"AccessControlList\"\
        },\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      }\
    },\
    \"GetObjectAclRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name that contains the object for which to get the ACL information. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The key of the object for which to get the ACL information.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>VersionId used to reference a specific version of the object.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"versionId\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetObjectLegalHoldOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"LegalHold\":{\
          \"shape\":\"ObjectLockLegalHold\",\
          \"documentation\":\"<p>The current Legal Hold status for the specified object.</p>\"\
        }\
      },\
      \"payload\":\"LegalHold\"\
    },\
    \"GetObjectLegalHoldRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name containing the object whose Legal Hold status you want to retrieve. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The key name for the object whose Legal Hold status you want to retrieve.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>The version ID of the object whose Legal Hold status you want to retrieve.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"versionId\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetObjectLockConfigurationOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ObjectLockConfiguration\":{\
          \"shape\":\"ObjectLockConfiguration\",\
          \"documentation\":\"<p>The specified bucket's Object Lock configuration.</p>\"\
        }\
      },\
      \"payload\":\"ObjectLockConfiguration\"\
    },\
    \"GetObjectLockConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket whose Object Lock configuration you want to retrieve.</p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetObjectOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Body\":{\
          \"shape\":\"Body\",\
          \"documentation\":\"<p>Object data.</p>\",\
          \"streaming\":true\
        },\
        \"DeleteMarker\":{\
          \"shape\":\"DeleteMarker\",\
          \"documentation\":\"<p>Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-delete-marker\"\
        },\
        \"AcceptRanges\":{\
          \"shape\":\"AcceptRanges\",\
          \"documentation\":\"<p>Indicates that a range of bytes was specified.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"accept-ranges\"\
        },\
        \"Expiration\":{\
          \"shape\":\"Expiration\",\
          \"documentation\":\"<p>If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key-value pairs providing object expiration information. The value of the rule-id is URL encoded.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expiration\"\
        },\
        \"Restore\":{\
          \"shape\":\"Restore\",\
          \"documentation\":\"<p>Provides information about object restoration operation and expiration time of the restored object copy.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-restore\"\
        },\
        \"LastModified\":{\
          \"shape\":\"LastModified\",\
          \"documentation\":\"<p>Last modified date of the object</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Last-Modified\"\
        },\
        \"ContentLength\":{\
          \"shape\":\"ContentLength\",\
          \"documentation\":\"<p>Size of the body in bytes.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Length\"\
        },\
        \"ETag\":{\
          \"shape\":\"ETag\",\
          \"documentation\":\"<p>An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"ETag\"\
        },\
        \"MissingMeta\":{\
          \"shape\":\"MissingMeta\",\
          \"documentation\":\"<p>This is set to the number of metadata entries not returned in <code>x-amz-meta</code> headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-missing-meta\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>Version of the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-version-id\"\
        },\
        \"CacheControl\":{\
          \"shape\":\"CacheControl\",\
          \"documentation\":\"<p>Specifies caching behavior along the request/reply chain.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Cache-Control\"\
        },\
        \"ContentDisposition\":{\
          \"shape\":\"ContentDisposition\",\
          \"documentation\":\"<p>Specifies presentational information for the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Disposition\"\
        },\
        \"ContentEncoding\":{\
          \"shape\":\"ContentEncoding\",\
          \"documentation\":\"<p>Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Encoding\"\
        },\
        \"ContentLanguage\":{\
          \"shape\":\"ContentLanguage\",\
          \"documentation\":\"<p>The language the content is in.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Language\"\
        },\
        \"ContentRange\":{\
          \"shape\":\"ContentRange\",\
          \"documentation\":\"<p>The portion of the object returned in the response.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Range\"\
        },\
        \"ContentType\":{\
          \"shape\":\"ContentType\",\
          \"documentation\":\"<p>A standard MIME type describing the format of the object data.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Type\"\
        },\
        \"Expires\":{\
          \"shape\":\"Expires\",\
          \"documentation\":\"<p>The date and time at which the object is no longer cacheable.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Expires\"\
        },\
        \"WebsiteRedirectLocation\":{\
          \"shape\":\"WebsiteRedirectLocation\",\
          \"documentation\":\"<p>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-website-redirect-location\"\
        },\
        \"ServerSideEncryption\":{\
          \"shape\":\"ServerSideEncryption\",\
          \"documentation\":\"<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption\"\
        },\
        \"Metadata\":{\
          \"shape\":\"Metadata\",\
          \"documentation\":\"<p>A map of metadata to store with the object in S3.</p>\",\
          \"location\":\"headers\",\
          \"locationName\":\"x-amz-meta-\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"SSEKMSKeyId\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\"\
        },\
        \"StorageClass\":{\
          \"shape\":\"StorageClass\",\
          \"documentation\":\"<p>Provides storage class information of the object. Amazon S3 returns this header for all objects except for S3 Standard storage class objects.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-storage-class\"\
        },\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        },\
        \"ReplicationStatus\":{\
          \"shape\":\"ReplicationStatus\",\
          \"documentation\":\"<p>Amazon S3 can return this if your request involves a bucket that is either a source or destination in a replication rule.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-replication-status\"\
        },\
        \"PartsCount\":{\
          \"shape\":\"PartsCount\",\
          \"documentation\":\"<p>The count of parts this object has.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-mp-parts-count\"\
        },\
        \"TagCount\":{\
          \"shape\":\"TagCount\",\
          \"documentation\":\"<p>The number of tags, if any, on the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-tagging-count\"\
        },\
        \"ObjectLockMode\":{\
          \"shape\":\"ObjectLockMode\",\
          \"documentation\":\"<p>The Object Lock mode currently in place for this object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-mode\"\
        },\
        \"ObjectLockRetainUntilDate\":{\
          \"shape\":\"ObjectLockRetainUntilDate\",\
          \"documentation\":\"<p>The date and time when this object's Object Lock will expire.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-retain-until-date\"\
        },\
        \"ObjectLockLegalHoldStatus\":{\
          \"shape\":\"ObjectLockLegalHoldStatus\",\
          \"documentation\":\"<p>Indicates whether this object has an active legal hold. This field is only returned if you have permission to view an object's legal hold status. </p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-legal-hold\"\
        }\
      },\
      \"payload\":\"Body\"\
    },\
    \"GetObjectRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name containing the object. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"IfMatch\":{\
          \"shape\":\"IfMatch\",\
          \"documentation\":\"<p>Return the object only if its entity tag (ETag) is the same as the one specified, otherwise return a 412 (precondition failed).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"If-Match\"\
        },\
        \"IfModifiedSince\":{\
          \"shape\":\"IfModifiedSince\",\
          \"documentation\":\"<p>Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"If-Modified-Since\"\
        },\
        \"IfNoneMatch\":{\
          \"shape\":\"IfNoneMatch\",\
          \"documentation\":\"<p>Return the object only if its entity tag (ETag) is different from the one specified, otherwise return a 304 (not modified).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"If-None-Match\"\
        },\
        \"IfUnmodifiedSince\":{\
          \"shape\":\"IfUnmodifiedSince\",\
          \"documentation\":\"<p>Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"If-Unmodified-Since\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Key of the object to get.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"Range\":{\
          \"shape\":\"Range\",\
          \"documentation\":\"<p>Downloads the specified range bytes of an object. For more information about the HTTP Range header, see <a href=\\\"https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35\\\">https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35</a>.</p> <note> <p>Amazon S3 doesn't support retrieving multiple ranges of data per <code>GET</code> request.</p> </note>\",\
          \"location\":\"header\",\
          \"locationName\":\"Range\"\
        },\
        \"ResponseCacheControl\":{\
          \"shape\":\"ResponseCacheControl\",\
          \"documentation\":\"<p>Sets the <code>Cache-Control</code> header of the response.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"response-cache-control\"\
        },\
        \"ResponseContentDisposition\":{\
          \"shape\":\"ResponseContentDisposition\",\
          \"documentation\":\"<p>Sets the <code>Content-Disposition</code> header of the response</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"response-content-disposition\"\
        },\
        \"ResponseContentEncoding\":{\
          \"shape\":\"ResponseContentEncoding\",\
          \"documentation\":\"<p>Sets the <code>Content-Encoding</code> header of the response.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"response-content-encoding\"\
        },\
        \"ResponseContentLanguage\":{\
          \"shape\":\"ResponseContentLanguage\",\
          \"documentation\":\"<p>Sets the <code>Content-Language</code> header of the response.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"response-content-language\"\
        },\
        \"ResponseContentType\":{\
          \"shape\":\"ResponseContentType\",\
          \"documentation\":\"<p>Sets the <code>Content-Type</code> header of the response.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"response-content-type\"\
        },\
        \"ResponseExpires\":{\
          \"shape\":\"ResponseExpires\",\
          \"documentation\":\"<p>Sets the <code>Expires</code> header of the response.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"response-expires\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>VersionId used to reference a specific version of the object.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"versionId\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>Specifies the algorithm to use to when encrypting the object (for example, AES256).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKey\":{\
          \"shape\":\"SSECustomerKey\",\
          \"documentation\":\"<p>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key. The key must be appropriate for use with the algorithm specified in the <code>x-amz-server-side-encryption-customer-algorithm</code> header.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"PartNumber\":{\
          \"shape\":\"PartNumber\",\
          \"documentation\":\"<p>Part number of the object being read. This is a positive integer between 1 and 10,000. Effectively performs a 'ranged' GET request for the part specified. Useful for downloading just a part of an object.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"partNumber\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetObjectRetentionOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Retention\":{\
          \"shape\":\"ObjectLockRetention\",\
          \"documentation\":\"<p>The container element for an object's retention settings.</p>\"\
        }\
      },\
      \"payload\":\"Retention\"\
    },\
    \"GetObjectRetentionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name containing the object whose retention settings you want to retrieve. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The key name for the object whose retention settings you want to retrieve.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>The version ID for the object whose retention settings you want to retrieve.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"versionId\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetObjectTaggingOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\"TagSet\"],\
      \"members\":{\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>The versionId of the object for which you got the tagging information.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-version-id\"\
        },\
        \"TagSet\":{\
          \"shape\":\"TagSet\",\
          \"documentation\":\"<p>Contains the tag set.</p>\"\
        }\
      }\
    },\
    \"GetObjectTaggingRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name containing the object for which to get the tagging information. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Object key for which to get the tagging information.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>The versionId of the object for which to get the tagging information.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"versionId\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetObjectTorrentOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Body\":{\
          \"shape\":\"Body\",\
          \"documentation\":\"<p>A Bencoded dictionary as defined by the BitTorrent specification</p>\",\
          \"streaming\":true\
        },\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      },\
      \"payload\":\"Body\"\
    },\
    \"GetObjectTorrentRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket containing the object for which to get the torrent files.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The object key for which to get the information.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GetPublicAccessBlockOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"PublicAccessBlockConfiguration\":{\
          \"shape\":\"PublicAccessBlockConfiguration\",\
          \"documentation\":\"<p>The <code>PublicAccessBlock</code> configuration currently in effect for this Amazon S3 bucket.</p>\"\
        }\
      },\
      \"payload\":\"PublicAccessBlockConfiguration\"\
    },\
    \"GetPublicAccessBlockRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the Amazon S3 bucket whose <code>PublicAccessBlock</code> configuration you want to retrieve. </p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"GlacierJobParameters\":{\
      \"type\":\"structure\",\
      \"required\":[\"Tier\"],\
      \"members\":{\
        \"Tier\":{\
          \"shape\":\"Tier\",\
          \"documentation\":\"<p>S3 Glacier retrieval tier at which the restore will be processed.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for S3 Glacier job parameters.</p>\"\
    },\
    \"Grant\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Grantee\":{\
          \"shape\":\"Grantee\",\
          \"documentation\":\"<p>The person being granted permissions.</p>\"\
        },\
        \"Permission\":{\
          \"shape\":\"Permission\",\
          \"documentation\":\"<p>Specifies the permission given to the grantee.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for grant information.</p>\"\
    },\
    \"GrantFullControl\":{\"type\":\"string\"},\
    \"GrantRead\":{\"type\":\"string\"},\
    \"GrantReadACP\":{\"type\":\"string\"},\
    \"GrantWrite\":{\"type\":\"string\"},\
    \"GrantWriteACP\":{\"type\":\"string\"},\
    \"Grantee\":{\
      \"type\":\"structure\",\
      \"required\":[\"Type\"],\
      \"members\":{\
        \"DisplayName\":{\
          \"shape\":\"DisplayName\",\
          \"documentation\":\"<p>Screen name of the grantee.</p>\"\
        },\
        \"EmailAddress\":{\
          \"shape\":\"EmailAddress\",\
          \"documentation\":\"<p>Email address of the grantee.</p> <note> <p>Using email addresses to specify a grantee is only supported in the following AWS Regions: </p> <ul> <li> <p>US East (N. Virginia)</p> </li> <li> <p>US West (N. California)</p> </li> <li> <p> US West (Oregon)</p> </li> <li> <p> Asia Pacific (Singapore)</p> </li> <li> <p>Asia Pacific (Sydney)</p> </li> <li> <p>Asia Pacific (Tokyo)</p> </li> <li> <p>Europe (Ireland)</p> </li> <li> <p>South America (SÃ£o Paulo)</p> </li> </ul> <p>For a list of all the Amazon S3 supported Regions and endpoints, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region\\\">Regions and Endpoints</a> in the AWS General Reference.</p> </note>\"\
        },\
        \"ID\":{\
          \"shape\":\"ID\",\
          \"documentation\":\"<p>The canonical user ID of the grantee.</p>\"\
        },\
        \"Type\":{\
          \"shape\":\"Type\",\
          \"documentation\":\"<p>Type of grantee</p>\",\
          \"locationName\":\"xsi:type\",\
          \"xmlAttribute\":true\
        },\
        \"URI\":{\
          \"shape\":\"URI\",\
          \"documentation\":\"<p>URI of the grantee group.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for the person being granted permissions.</p>\",\
      \"xmlNamespace\":{\
        \"prefix\":\"xsi\",\
        \"uri\":\"http://www.w3.org/2001/XMLSchema-instance\"\
      }\
    },\
    \"Grants\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"Grant\",\
        \"locationName\":\"Grant\"\
      }\
    },\
    \"HeadBucketRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name.</p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"HeadObjectOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DeleteMarker\":{\
          \"shape\":\"DeleteMarker\",\
          \"documentation\":\"<p>Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-delete-marker\"\
        },\
        \"AcceptRanges\":{\
          \"shape\":\"AcceptRanges\",\
          \"documentation\":\"<p>Indicates that a range of bytes was specified.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"accept-ranges\"\
        },\
        \"Expiration\":{\
          \"shape\":\"Expiration\",\
          \"documentation\":\"<p>If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key-value pairs providing object expiration information. The value of the rule-id is URL encoded.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expiration\"\
        },\
        \"Restore\":{\
          \"shape\":\"Restore\",\
          \"documentation\":\"<p>If the object is an archived object (an object whose storage class is GLACIER), the response includes this header if either the archive restoration is in progress (see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_RestoreObject.html\\\">RestoreObject</a> or an archive copy is already restored.</p> <p> If an archive copy is already restored, the header value indicates when Amazon S3 is scheduled to delete the object copy. For example:</p> <p> <code>x-amz-restore: ongoing-request=\\\"false\\\", expiry-date=\\\"Fri, 23 Dec 2012 00:00:00 GMT\\\"</code> </p> <p>If the object restoration is in progress, the header returns the value <code>ongoing-request=\\\"true\\\"</code>.</p> <p>For more information about archiving objects, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html#lifecycle-transition-general-considerations\\\">Transitioning Objects: General Considerations</a>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-restore\"\
        },\
        \"LastModified\":{\
          \"shape\":\"LastModified\",\
          \"documentation\":\"<p>Last modified date of the object</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Last-Modified\"\
        },\
        \"ContentLength\":{\
          \"shape\":\"ContentLength\",\
          \"documentation\":\"<p>Size of the body in bytes.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Length\"\
        },\
        \"ETag\":{\
          \"shape\":\"ETag\",\
          \"documentation\":\"<p>An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"ETag\"\
        },\
        \"MissingMeta\":{\
          \"shape\":\"MissingMeta\",\
          \"documentation\":\"<p>This is set to the number of metadata entries not returned in <code>x-amz-meta</code> headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-missing-meta\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>Version of the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-version-id\"\
        },\
        \"CacheControl\":{\
          \"shape\":\"CacheControl\",\
          \"documentation\":\"<p>Specifies caching behavior along the request/reply chain.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Cache-Control\"\
        },\
        \"ContentDisposition\":{\
          \"shape\":\"ContentDisposition\",\
          \"documentation\":\"<p>Specifies presentational information for the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Disposition\"\
        },\
        \"ContentEncoding\":{\
          \"shape\":\"ContentEncoding\",\
          \"documentation\":\"<p>Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Encoding\"\
        },\
        \"ContentLanguage\":{\
          \"shape\":\"ContentLanguage\",\
          \"documentation\":\"<p>The language the content is in.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Language\"\
        },\
        \"ContentType\":{\
          \"shape\":\"ContentType\",\
          \"documentation\":\"<p>A standard MIME type describing the format of the object data.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Type\"\
        },\
        \"Expires\":{\
          \"shape\":\"Expires\",\
          \"documentation\":\"<p>The date and time at which the object is no longer cacheable.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Expires\"\
        },\
        \"WebsiteRedirectLocation\":{\
          \"shape\":\"WebsiteRedirectLocation\",\
          \"documentation\":\"<p>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-website-redirect-location\"\
        },\
        \"ServerSideEncryption\":{\
          \"shape\":\"ServerSideEncryption\",\
          \"documentation\":\"<p>If the object is stored using server-side encryption either with an AWS KMS customer master key (CMK) or an Amazon S3-managed encryption key, the response includes this header with the value of the server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption\"\
        },\
        \"Metadata\":{\
          \"shape\":\"Metadata\",\
          \"documentation\":\"<p>A map of metadata to store with the object in S3.</p>\",\
          \"location\":\"headers\",\
          \"locationName\":\"x-amz-meta-\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"SSEKMSKeyId\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\"\
        },\
        \"StorageClass\":{\
          \"shape\":\"StorageClass\",\
          \"documentation\":\"<p>Provides storage class information of the object. Amazon S3 returns this header for all objects except for S3 Standard storage class objects.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html\\\">Storage Classes</a>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-storage-class\"\
        },\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        },\
        \"ReplicationStatus\":{\
          \"shape\":\"ReplicationStatus\",\
          \"documentation\":\"<p>Amazon S3 can return this header if your request involves a bucket that is either a source or destination in a replication rule.</p> <p>In replication, you have a source bucket on which you configure replication and destination bucket where Amazon S3 stores object replicas. When you request an object (<code>GetObject</code>) or object metadata (<code>HeadObject</code>) from these buckets, Amazon S3 will return the <code>x-amz-replication-status</code> header in the response as follows:</p> <ul> <li> <p>If requesting an object from the source bucket â Amazon S3 will return the <code>x-amz-replication-status</code> header if the object in your request is eligible for replication.</p> <p> For example, suppose that in your replication configuration, you specify object prefix <code>TaxDocs</code> requesting Amazon S3 to replicate objects with key prefix <code>TaxDocs</code>. Any objects you upload with this key name prefix, for example <code>TaxDocs/document1.pdf</code>, are eligible for replication. For any object request with this key name prefix, Amazon S3 will return the <code>x-amz-replication-status</code> header with value PENDING, COMPLETED or FAILED indicating object replication status.</p> </li> <li> <p>If requesting an object from the destination bucket â Amazon S3 will return the <code>x-amz-replication-status</code> header with value REPLICA if the object in your request is a replica that Amazon S3 created.</p> </li> </ul> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\\\">Replication</a>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-replication-status\"\
        },\
        \"PartsCount\":{\
          \"shape\":\"PartsCount\",\
          \"documentation\":\"<p>The count of parts this object has.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-mp-parts-count\"\
        },\
        \"ObjectLockMode\":{\
          \"shape\":\"ObjectLockMode\",\
          \"documentation\":\"<p>The Object Lock mode, if any, that's in effect for this object. This header is only returned if the requester has the <code>s3:GetObjectRetention</code> permission. For more information about S3 Object Lock, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\\\">Object Lock</a>. </p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-mode\"\
        },\
        \"ObjectLockRetainUntilDate\":{\
          \"shape\":\"ObjectLockRetainUntilDate\",\
          \"documentation\":\"<p>The date and time when the Object Lock retention period expires. This header is only returned if the requester has the <code>s3:GetObjectRetention</code> permission.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-retain-until-date\"\
        },\
        \"ObjectLockLegalHoldStatus\":{\
          \"shape\":\"ObjectLockLegalHoldStatus\",\
          \"documentation\":\"<p>Specifies whether a legal hold is in effect for this object. This header is only returned if the requester has the <code>s3:GetObjectLegalHold</code> permission. This header is not returned if the specified version of this object has never had a legal hold applied. For more information about S3 Object Lock, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\\\">Object Lock</a>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-legal-hold\"\
        }\
      }\
    },\
    \"HeadObjectRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket containing the object.</p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"IfMatch\":{\
          \"shape\":\"IfMatch\",\
          \"documentation\":\"<p>Return the object only if its entity tag (ETag) is the same as the one specified, otherwise return a 412 (precondition failed).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"If-Match\"\
        },\
        \"IfModifiedSince\":{\
          \"shape\":\"IfModifiedSince\",\
          \"documentation\":\"<p>Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"If-Modified-Since\"\
        },\
        \"IfNoneMatch\":{\
          \"shape\":\"IfNoneMatch\",\
          \"documentation\":\"<p>Return the object only if its entity tag (ETag) is different from the one specified, otherwise return a 304 (not modified).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"If-None-Match\"\
        },\
        \"IfUnmodifiedSince\":{\
          \"shape\":\"IfUnmodifiedSince\",\
          \"documentation\":\"<p>Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"If-Unmodified-Since\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The object key.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"Range\":{\
          \"shape\":\"Range\",\
          \"documentation\":\"<p>Downloads the specified range bytes of an object. For more information about the HTTP Range header, see <a href=\\\"http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35\\\">http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35</a>.</p> <note> <p>Amazon S3 doesn't support retrieving multiple ranges of data per <code>GET</code> request.</p> </note>\",\
          \"location\":\"header\",\
          \"locationName\":\"Range\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>VersionId used to reference a specific version of the object.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"versionId\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>Specifies the algorithm to use to when encrypting the object (for example, AES256).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKey\":{\
          \"shape\":\"SSECustomerKey\",\
          \"documentation\":\"<p>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key. The key must be appropriate for use with the algorithm specified in the <code>x-amz-server-side-encryption-customer-algorithm</code> header.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"PartNumber\":{\
          \"shape\":\"PartNumber\",\
          \"documentation\":\"<p>Part number of the object being read. This is a positive integer between 1 and 10,000. Effectively performs a 'ranged' HEAD request for the part specified. Useful querying about the size of the part and the number of parts in this object.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"partNumber\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"HostName\":{\"type\":\"string\"},\
    \"HttpErrorCodeReturnedEquals\":{\"type\":\"string\"},\
    \"HttpRedirectCode\":{\"type\":\"string\"},\
    \"ID\":{\"type\":\"string\"},\
    \"IfMatch\":{\"type\":\"string\"},\
    \"IfModifiedSince\":{\"type\":\"timestamp\"},\
    \"IfNoneMatch\":{\"type\":\"string\"},\
    \"IfUnmodifiedSince\":{\"type\":\"timestamp\"},\
    \"IndexDocument\":{\
      \"type\":\"structure\",\
      \"required\":[\"Suffix\"],\
      \"members\":{\
        \"Suffix\":{\
          \"shape\":\"Suffix\",\
          \"documentation\":\"<p>A suffix that is appended to a request that is for a directory on the website endpoint (for example,if the suffix is index.html and you make a request to samplebucket/images/ the data that is returned will be for the object with the key name images/index.html) The suffix must not be empty and must not include a slash character.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for the <code>Suffix</code> element.</p>\"\
    },\
    \"Initiated\":{\"type\":\"timestamp\"},\
    \"Initiator\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ID\":{\
          \"shape\":\"ID\",\
          \"documentation\":\"<p>If the principal is an AWS account, it provides the Canonical User ID. If the principal is an IAM User, it provides a user ARN value.</p>\"\
        },\
        \"DisplayName\":{\
          \"shape\":\"DisplayName\",\
          \"documentation\":\"<p>Name of the Principal.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container element that identifies who initiated the multipart upload. </p>\"\
    },\
    \"InputSerialization\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CSV\":{\
          \"shape\":\"CSVInput\",\
          \"documentation\":\"<p>Describes the serialization of a CSV-encoded object.</p>\"\
        },\
        \"CompressionType\":{\
          \"shape\":\"CompressionType\",\
          \"documentation\":\"<p>Specifies object's compression format. Valid values: NONE, GZIP, BZIP2. Default Value: NONE.</p>\"\
        },\
        \"JSON\":{\
          \"shape\":\"JSONInput\",\
          \"documentation\":\"<p>Specifies JSON as object's input serialization format.</p>\"\
        },\
        \"Parquet\":{\
          \"shape\":\"ParquetInput\",\
          \"documentation\":\"<p>Specifies Parquet as object's input serialization format.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the serialization format of the object.</p>\"\
    },\
    \"InventoryConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Destination\",\
        \"IsEnabled\",\
        \"Id\",\
        \"IncludedObjectVersions\",\
        \"Schedule\"\
      ],\
      \"members\":{\
        \"Destination\":{\
          \"shape\":\"InventoryDestination\",\
          \"documentation\":\"<p>Contains information about where to publish the inventory results.</p>\"\
        },\
        \"IsEnabled\":{\
          \"shape\":\"IsEnabled\",\
          \"documentation\":\"<p>Specifies whether the inventory is enabled or disabled. If set to <code>True</code>, an inventory list is generated. If set to <code>False</code>, no inventory list is generated.</p>\"\
        },\
        \"Filter\":{\
          \"shape\":\"InventoryFilter\",\
          \"documentation\":\"<p>Specifies an inventory filter. The inventory only includes objects that meet the filter's criteria.</p>\"\
        },\
        \"Id\":{\
          \"shape\":\"InventoryId\",\
          \"documentation\":\"<p>The ID used to identify the inventory configuration.</p>\"\
        },\
        \"IncludedObjectVersions\":{\
          \"shape\":\"InventoryIncludedObjectVersions\",\
          \"documentation\":\"<p>Object versions to include in the inventory list. If set to <code>All</code>, the list includes all the object versions, which adds the version-related fields <code>VersionId</code>, <code>IsLatest</code>, and <code>DeleteMarker</code> to the list. If set to <code>Current</code>, the list does not contain these version-related fields.</p>\"\
        },\
        \"OptionalFields\":{\
          \"shape\":\"InventoryOptionalFields\",\
          \"documentation\":\"<p>Contains the optional fields that are included in the inventory results.</p>\"\
        },\
        \"Schedule\":{\
          \"shape\":\"InventorySchedule\",\
          \"documentation\":\"<p>Specifies the schedule for generating inventory results.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the inventory configuration for an Amazon S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETInventoryConfig.html\\\">GET Bucket inventory</a> in the <i>Amazon Simple Storage Service API Reference</i>. </p>\"\
    },\
    \"InventoryConfigurationList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"InventoryConfiguration\"},\
      \"flattened\":true\
    },\
    \"InventoryDestination\":{\
      \"type\":\"structure\",\
      \"required\":[\"S3BucketDestination\"],\
      \"members\":{\
        \"S3BucketDestination\":{\
          \"shape\":\"InventoryS3BucketDestination\",\
          \"documentation\":\"<p>Contains the bucket name, file format, bucket owner (optional), and prefix (optional) where inventory results are published.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the inventory configuration for an Amazon S3 bucket.</p>\"\
    },\
    \"InventoryEncryption\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"SSES3\":{\
          \"shape\":\"SSES3\",\
          \"documentation\":\"<p>Specifies the use of SSE-S3 to encrypt delivered inventory reports.</p>\",\
          \"locationName\":\"SSE-S3\"\
        },\
        \"SSEKMS\":{\
          \"shape\":\"SSEKMS\",\
          \"documentation\":\"<p>Specifies the use of SSE-KMS to encrypt delivered inventory reports.</p>\",\
          \"locationName\":\"SSE-KMS\"\
        }\
      },\
      \"documentation\":\"<p>Contains the type of server-side encryption used to encrypt the inventory results.</p>\"\
    },\
    \"InventoryFilter\":{\
      \"type\":\"structure\",\
      \"required\":[\"Prefix\"],\
      \"members\":{\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The prefix that an object must have to be included in the inventory results.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies an inventory filter. The inventory only includes objects that meet the filter's criteria.</p>\"\
    },\
    \"InventoryFormat\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"CSV\",\
        \"ORC\",\
        \"Parquet\"\
      ]\
    },\
    \"InventoryFrequency\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Daily\",\
        \"Weekly\"\
      ]\
    },\
    \"InventoryId\":{\"type\":\"string\"},\
    \"InventoryIncludedObjectVersions\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"All\",\
        \"Current\"\
      ]\
    },\
    \"InventoryOptionalField\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Size\",\
        \"LastModifiedDate\",\
        \"StorageClass\",\
        \"ETag\",\
        \"IsMultipartUploaded\",\
        \"ReplicationStatus\",\
        \"EncryptionStatus\",\
        \"ObjectLockRetainUntilDate\",\
        \"ObjectLockMode\",\
        \"ObjectLockLegalHoldStatus\",\
        \"IntelligentTieringAccessTier\"\
      ]\
    },\
    \"InventoryOptionalFields\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"InventoryOptionalField\",\
        \"locationName\":\"Field\"\
      }\
    },\
    \"InventoryS3BucketDestination\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Format\"\
      ],\
      \"members\":{\
        \"AccountId\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account ID that owns the destination S3 bucket. If no account ID is provided, the owner is not validated before exporting data. </p> <note> <p> Although this value is optional, we strongly recommend that you set it to help prevent problems if the destination bucket ownership changes. </p> </note>\"\
        },\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the bucket where inventory results will be published.</p>\"\
        },\
        \"Format\":{\
          \"shape\":\"InventoryFormat\",\
          \"documentation\":\"<p>Specifies the output format of the inventory results.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The prefix that is prepended to all inventory results.</p>\"\
        },\
        \"Encryption\":{\
          \"shape\":\"InventoryEncryption\",\
          \"documentation\":\"<p>Contains the type of server-side encryption used to encrypt the inventory results.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the bucket name, file format, bucket owner (optional), and prefix (optional) where inventory results are published.</p>\"\
    },\
    \"InventorySchedule\":{\
      \"type\":\"structure\",\
      \"required\":[\"Frequency\"],\
      \"members\":{\
        \"Frequency\":{\
          \"shape\":\"InventoryFrequency\",\
          \"documentation\":\"<p>Specifies how frequently inventory results are produced.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the schedule for generating inventory results.</p>\"\
    },\
    \"IsEnabled\":{\"type\":\"boolean\"},\
    \"IsLatest\":{\"type\":\"boolean\"},\
    \"IsPublic\":{\"type\":\"boolean\"},\
    \"IsTruncated\":{\"type\":\"boolean\"},\
    \"JSONInput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Type\":{\
          \"shape\":\"JSONType\",\
          \"documentation\":\"<p>The type of JSON. Valid values: Document, Lines.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies JSON as object's input serialization format.</p>\"\
    },\
    \"JSONOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RecordDelimiter\":{\
          \"shape\":\"RecordDelimiter\",\
          \"documentation\":\"<p>The value used to separate individual records in the output. If no value is specified, Amazon S3 uses a newline character ('\\\\n').</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies JSON as request's output serialization format.</p>\"\
    },\
    \"JSONType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"DOCUMENT\",\
        \"LINES\"\
      ]\
    },\
    \"KMSContext\":{\"type\":\"string\"},\
    \"KeyCount\":{\"type\":\"integer\"},\
    \"KeyMarker\":{\"type\":\"string\"},\
    \"KeyPrefixEquals\":{\"type\":\"string\"},\
    \"LambdaFunctionArn\":{\"type\":\"string\"},\
    \"LambdaFunctionConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"LambdaFunctionArn\",\
        \"Events\"\
      ],\
      \"members\":{\
        \"Id\":{\"shape\":\"NotificationId\"},\
        \"LambdaFunctionArn\":{\
          \"shape\":\"LambdaFunctionArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the AWS Lambda function that Amazon S3 invokes when the specified event type occurs.</p>\",\
          \"locationName\":\"CloudFunction\"\
        },\
        \"Events\":{\
          \"shape\":\"EventList\",\
          \"documentation\":\"<p>The Amazon S3 bucket event for which to invoke the AWS Lambda function. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\\\">Supported Event Types</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"locationName\":\"Event\"\
        },\
        \"Filter\":{\"shape\":\"NotificationConfigurationFilter\"}\
      },\
      \"documentation\":\"<p>A container for specifying the configuration for AWS Lambda notifications.</p>\"\
    },\
    \"LambdaFunctionConfigurationList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"LambdaFunctionConfiguration\"},\
      \"flattened\":true\
    },\
    \"LastModified\":{\"type\":\"timestamp\"},\
    \"LifecycleConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\"Rules\"],\
      \"members\":{\
        \"Rules\":{\
          \"shape\":\"Rules\",\
          \"documentation\":\"<p>Specifies lifecycle configuration rules for an Amazon S3 bucket. </p>\",\
          \"locationName\":\"Rule\"\
        }\
      },\
      \"documentation\":\"<p>Container for lifecycle rules. You can add as many as 1000 rules.</p>\"\
    },\
    \"LifecycleExpiration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Date\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p>Indicates at what date the object is to be moved or deleted. Should be in GMT ISO 8601 Format.</p>\"\
        },\
        \"Days\":{\
          \"shape\":\"Days\",\
          \"documentation\":\"<p>Indicates the lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer.</p>\"\
        },\
        \"ExpiredObjectDeleteMarker\":{\
          \"shape\":\"ExpiredObjectDeleteMarker\",\
          \"documentation\":\"<p>Indicates whether Amazon S3 will remove a delete marker with no noncurrent versions. If set to true, the delete marker will be expired; if set to false the policy takes no action. This cannot be specified with Days or Date in a Lifecycle Expiration Policy.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for the expiration for the lifecycle of the object.</p>\"\
    },\
    \"LifecycleRule\":{\
      \"type\":\"structure\",\
      \"required\":[\"Status\"],\
      \"members\":{\
        \"Expiration\":{\
          \"shape\":\"LifecycleExpiration\",\
          \"documentation\":\"<p>Specifies the expiration for the lifecycle of the object in the form of date, days and, whether the object has a delete marker.</p>\"\
        },\
        \"ID\":{\
          \"shape\":\"ID\",\
          \"documentation\":\"<p>Unique identifier for the rule. The value cannot be longer than 255 characters.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>Prefix identifying one or more objects to which the rule applies. This is No longer used; use <code>Filter</code> instead.</p>\",\
          \"deprecated\":true\
        },\
        \"Filter\":{\"shape\":\"LifecycleRuleFilter\"},\
        \"Status\":{\
          \"shape\":\"ExpirationStatus\",\
          \"documentation\":\"<p>If 'Enabled', the rule is currently being applied. If 'Disabled', the rule is not currently being applied.</p>\"\
        },\
        \"Transitions\":{\
          \"shape\":\"TransitionList\",\
          \"documentation\":\"<p>Specifies when an Amazon S3 object transitions to a specified storage class.</p>\",\
          \"locationName\":\"Transition\"\
        },\
        \"NoncurrentVersionTransitions\":{\
          \"shape\":\"NoncurrentVersionTransitionList\",\
          \"documentation\":\"<p> Specifies the transition rule for the lifecycle rule that describes when noncurrent objects transition to a specific storage class. If your bucket is versioning-enabled (or versioning is suspended), you can set this action to request that Amazon S3 transition noncurrent object versions to a specific storage class at a set period in the object's lifetime. </p>\",\
          \"locationName\":\"NoncurrentVersionTransition\"\
        },\
        \"NoncurrentVersionExpiration\":{\"shape\":\"NoncurrentVersionExpiration\"},\
        \"AbortIncompleteMultipartUpload\":{\"shape\":\"AbortIncompleteMultipartUpload\"}\
      },\
      \"documentation\":\"<p>A lifecycle rule for individual objects in an Amazon S3 bucket.</p>\"\
    },\
    \"LifecycleRuleAndOperator\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>Prefix identifying one or more objects to which the rule applies.</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagSet\",\
          \"documentation\":\"<p>All of these tags must exist in the object's tag set in order for the rule to apply.</p>\",\
          \"flattened\":true,\
          \"locationName\":\"Tag\"\
        }\
      },\
      \"documentation\":\"<p>This is used in a Lifecycle Rule Filter to apply a logical AND to two or more predicates. The Lifecycle Rule will apply to any object matching all of the predicates configured inside the And operator.</p>\"\
    },\
    \"LifecycleRuleFilter\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>Prefix identifying one or more objects to which the rule applies.</p>\"\
        },\
        \"Tag\":{\
          \"shape\":\"Tag\",\
          \"documentation\":\"<p>This tag must exist in the object's tag set in order for the rule to apply.</p>\"\
        },\
        \"And\":{\"shape\":\"LifecycleRuleAndOperator\"}\
      },\
      \"documentation\":\"<p>The <code>Filter</code> is used to identify objects that a Lifecycle Rule applies to. A <code>Filter</code> must have exactly one of <code>Prefix</code>, <code>Tag</code>, or <code>And</code> specified.</p>\"\
    },\
    \"LifecycleRules\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"LifecycleRule\"},\
      \"flattened\":true\
    },\
    \"ListBucketAnalyticsConfigurationsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"IsTruncated\":{\
          \"shape\":\"IsTruncated\",\
          \"documentation\":\"<p>Indicates whether the returned list of analytics configurations is complete. A value of true indicates that the list is not complete and the NextContinuationToken will be provided for a subsequent request.</p>\"\
        },\
        \"ContinuationToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The marker that is used as a starting point for this analytics configuration list response. This value is present if it was sent in the request.</p>\"\
        },\
        \"NextContinuationToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p> <code>NextContinuationToken</code> is sent when <code>isTruncated</code> is true, which indicates that there are more analytics configurations to list. The next request must include this <code>NextContinuationToken</code>. The token is obfuscated and is not a usable value.</p>\"\
        },\
        \"AnalyticsConfigurationList\":{\
          \"shape\":\"AnalyticsConfigurationList\",\
          \"documentation\":\"<p>The list of analytics configurations for a bucket.</p>\",\
          \"locationName\":\"AnalyticsConfiguration\"\
        }\
      }\
    },\
    \"ListBucketAnalyticsConfigurationsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket from which analytics configurations are retrieved.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContinuationToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The ContinuationToken that represents a placeholder from where this request should begin.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"continuation-token\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"ListBucketInventoryConfigurationsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ContinuationToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>If sent in the request, the marker that is used as a starting point for this inventory configuration list response.</p>\"\
        },\
        \"InventoryConfigurationList\":{\
          \"shape\":\"InventoryConfigurationList\",\
          \"documentation\":\"<p>The list of inventory configurations for a bucket.</p>\",\
          \"locationName\":\"InventoryConfiguration\"\
        },\
        \"IsTruncated\":{\
          \"shape\":\"IsTruncated\",\
          \"documentation\":\"<p>Tells whether the returned list of inventory configurations is complete. A value of true indicates that the list is not complete and the NextContinuationToken is provided for a subsequent request.</p>\"\
        },\
        \"NextContinuationToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The marker used to continue this inventory configuration listing. Use the <code>NextContinuationToken</code> from this response to continue the listing in a subsequent request. The continuation token is an opaque value that Amazon S3 understands.</p>\"\
        }\
      }\
    },\
    \"ListBucketInventoryConfigurationsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket containing the inventory configurations to retrieve.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContinuationToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The marker used to continue an inventory configuration listing that has been truncated. Use the NextContinuationToken from a previously truncated list response to continue the listing. The continuation token is an opaque value that Amazon S3 understands.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"continuation-token\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"ListBucketMetricsConfigurationsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"IsTruncated\":{\
          \"shape\":\"IsTruncated\",\
          \"documentation\":\"<p>Indicates whether the returned list of metrics configurations is complete. A value of true indicates that the list is not complete and the NextContinuationToken will be provided for a subsequent request.</p>\"\
        },\
        \"ContinuationToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The marker that is used as a starting point for this metrics configuration list response. This value is present if it was sent in the request.</p>\"\
        },\
        \"NextContinuationToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The marker used to continue a metrics configuration listing that has been truncated. Use the <code>NextContinuationToken</code> from a previously truncated list response to continue the listing. The continuation token is an opaque value that Amazon S3 understands.</p>\"\
        },\
        \"MetricsConfigurationList\":{\
          \"shape\":\"MetricsConfigurationList\",\
          \"documentation\":\"<p>The list of metrics configurations for a bucket.</p>\",\
          \"locationName\":\"MetricsConfiguration\"\
        }\
      }\
    },\
    \"ListBucketMetricsConfigurationsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket containing the metrics configurations to retrieve.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContinuationToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The marker that is used to continue a metrics configuration listing that has been truncated. Use the NextContinuationToken from a previously truncated list response to continue the listing. The continuation token is an opaque value that Amazon S3 understands.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"continuation-token\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"ListBucketsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Buckets\":{\
          \"shape\":\"Buckets\",\
          \"documentation\":\"<p>The list of buckets owned by the requestor.</p>\"\
        },\
        \"Owner\":{\
          \"shape\":\"Owner\",\
          \"documentation\":\"<p>The owner of the buckets listed.</p>\"\
        }\
      }\
    },\
    \"ListMultipartUploadsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket to which the multipart upload was initiated.</p>\"\
        },\
        \"KeyMarker\":{\
          \"shape\":\"KeyMarker\",\
          \"documentation\":\"<p>The key at or after which the listing began.</p>\"\
        },\
        \"UploadIdMarker\":{\
          \"shape\":\"UploadIdMarker\",\
          \"documentation\":\"<p>Upload ID after which listing began.</p>\"\
        },\
        \"NextKeyMarker\":{\
          \"shape\":\"NextKeyMarker\",\
          \"documentation\":\"<p>When a list is truncated, this element specifies the value that should be used for the key-marker request parameter in a subsequent request.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>When a prefix is provided in the request, this field contains the specified prefix. The result contains only keys starting with the specified prefix.</p>\"\
        },\
        \"Delimiter\":{\
          \"shape\":\"Delimiter\",\
          \"documentation\":\"<p>Contains the delimiter you specified in the request. If you don't specify a delimiter in your request, this element is absent from the response.</p>\"\
        },\
        \"NextUploadIdMarker\":{\
          \"shape\":\"NextUploadIdMarker\",\
          \"documentation\":\"<p>When a list is truncated, this element specifies the value that should be used for the <code>upload-id-marker</code> request parameter in a subsequent request.</p>\"\
        },\
        \"MaxUploads\":{\
          \"shape\":\"MaxUploads\",\
          \"documentation\":\"<p>Maximum number of multipart uploads that could have been included in the response.</p>\"\
        },\
        \"IsTruncated\":{\
          \"shape\":\"IsTruncated\",\
          \"documentation\":\"<p>Indicates whether the returned list of multipart uploads is truncated. A value of true indicates that the list was truncated. The list can be truncated if the number of multipart uploads exceeds the limit allowed or specified by max uploads.</p>\"\
        },\
        \"Uploads\":{\
          \"shape\":\"MultipartUploadList\",\
          \"documentation\":\"<p>Container for elements related to a particular multipart upload. A response can contain zero or more <code>Upload</code> elements.</p>\",\
          \"locationName\":\"Upload\"\
        },\
        \"CommonPrefixes\":{\
          \"shape\":\"CommonPrefixList\",\
          \"documentation\":\"<p>If you specify a delimiter in the request, then the result returns each distinct key prefix containing the delimiter in a <code>CommonPrefixes</code> element. The distinct key prefixes are returned in the <code>Prefix</code> child element.</p>\"\
        },\
        \"EncodingType\":{\
          \"shape\":\"EncodingType\",\
          \"documentation\":\"<p>Encoding type used by Amazon S3 to encode object keys in the response.</p> <p>If you specify <code>encoding-type</code> request parameter, Amazon S3 includes this element in the response, and returns encoded key name values in the following response elements:</p> <p> <code>Delimiter</code>, <code>KeyMarker</code>, <code>Prefix</code>, <code>NextKeyMarker</code>, <code>Key</code>.</p>\"\
        }\
      }\
    },\
    \"ListMultipartUploadsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket to which the multipart upload was initiated. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Delimiter\":{\
          \"shape\":\"Delimiter\",\
          \"documentation\":\"<p>Character you use to group keys.</p> <p>All keys that contain the same string between the prefix, if specified, and the first occurrence of the delimiter after the prefix are grouped under a single result element, <code>CommonPrefixes</code>. If you don't specify the prefix parameter, then the substring starts at the beginning of the key. The keys that are grouped under <code>CommonPrefixes</code> result element are not returned elsewhere in the response.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"delimiter\"\
        },\
        \"EncodingType\":{\
          \"shape\":\"EncodingType\",\
          \"location\":\"querystring\",\
          \"locationName\":\"encoding-type\"\
        },\
        \"KeyMarker\":{\
          \"shape\":\"KeyMarker\",\
          \"documentation\":\"<p>Together with upload-id-marker, this parameter specifies the multipart upload after which listing should begin.</p> <p>If <code>upload-id-marker</code> is not specified, only the keys lexicographically greater than the specified <code>key-marker</code> will be included in the list.</p> <p>If <code>upload-id-marker</code> is specified, any multipart uploads for a key equal to the <code>key-marker</code> might also be included, provided those multipart uploads have upload IDs lexicographically greater than the specified <code>upload-id-marker</code>.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"key-marker\"\
        },\
        \"MaxUploads\":{\
          \"shape\":\"MaxUploads\",\
          \"documentation\":\"<p>Sets the maximum number of multipart uploads, from 1 to 1,000, to return in the response body. 1,000 is the maximum number of uploads that can be returned in a response.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"max-uploads\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>Lists in-progress uploads only for those keys that begin with the specified prefix. You can use prefixes to separate a bucket into different grouping of keys. (You can think of using prefix to make groups in the same way you'd use a folder in a file system.)</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"prefix\"\
        },\
        \"UploadIdMarker\":{\
          \"shape\":\"UploadIdMarker\",\
          \"documentation\":\"<p>Together with key-marker, specifies the multipart upload after which listing should begin. If key-marker is not specified, the upload-id-marker parameter is ignored. Otherwise, any multipart uploads for a key equal to the key-marker might be included in the list only if they have an upload ID lexicographically greater than the specified <code>upload-id-marker</code>.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"upload-id-marker\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"ListObjectVersionsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"IsTruncated\":{\
          \"shape\":\"IsTruncated\",\
          \"documentation\":\"<p>A flag that indicates whether Amazon S3 returned all of the results that satisfied the search criteria. If your results were truncated, you can make a follow-up paginated request using the NextKeyMarker and NextVersionIdMarker response parameters as a starting place in another request to return the rest of the results.</p>\"\
        },\
        \"KeyMarker\":{\
          \"shape\":\"KeyMarker\",\
          \"documentation\":\"<p>Marks the last key returned in a truncated response.</p>\"\
        },\
        \"VersionIdMarker\":{\
          \"shape\":\"VersionIdMarker\",\
          \"documentation\":\"<p>Marks the last version of the key returned in a truncated response.</p>\"\
        },\
        \"NextKeyMarker\":{\
          \"shape\":\"NextKeyMarker\",\
          \"documentation\":\"<p>When the number of responses exceeds the value of <code>MaxKeys</code>, <code>NextKeyMarker</code> specifies the first key not returned that satisfies the search criteria. Use this value for the key-marker request parameter in a subsequent request.</p>\"\
        },\
        \"NextVersionIdMarker\":{\
          \"shape\":\"NextVersionIdMarker\",\
          \"documentation\":\"<p>When the number of responses exceeds the value of <code>MaxKeys</code>, <code>NextVersionIdMarker</code> specifies the first object version not returned that satisfies the search criteria. Use this value for the version-id-marker request parameter in a subsequent request.</p>\"\
        },\
        \"Versions\":{\
          \"shape\":\"ObjectVersionList\",\
          \"documentation\":\"<p>Container for version information.</p>\",\
          \"locationName\":\"Version\"\
        },\
        \"DeleteMarkers\":{\
          \"shape\":\"DeleteMarkers\",\
          \"documentation\":\"<p>Container for an object that is a delete marker.</p>\",\
          \"locationName\":\"DeleteMarker\"\
        },\
        \"Name\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>Selects objects that start with the value supplied by this parameter.</p>\"\
        },\
        \"Delimiter\":{\
          \"shape\":\"Delimiter\",\
          \"documentation\":\"<p>The delimiter grouping the included keys. A delimiter is a character that you specify to group keys. All keys that contain the same string between the prefix and the first occurrence of the delimiter are grouped under a single result element in <code>CommonPrefixes</code>. These groups are counted as one result against the max-keys limitation. These keys are not returned elsewhere in the response.</p>\"\
        },\
        \"MaxKeys\":{\
          \"shape\":\"MaxKeys\",\
          \"documentation\":\"<p>Specifies the maximum number of objects to return.</p>\"\
        },\
        \"CommonPrefixes\":{\
          \"shape\":\"CommonPrefixList\",\
          \"documentation\":\"<p>All of the keys rolled up into a common prefix count as a single return when calculating the number of returns.</p>\"\
        },\
        \"EncodingType\":{\
          \"shape\":\"EncodingType\",\
          \"documentation\":\"<p> Encoding type used by Amazon S3 to encode object key names in the XML response.</p> <p>If you specify encoding-type request parameter, Amazon S3 includes this element in the response, and returns encoded key name values in the following response elements:</p> <p> <code>KeyMarker, NextKeyMarker, Prefix, Key</code>, and <code>Delimiter</code>.</p>\"\
        }\
      }\
    },\
    \"ListObjectVersionsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name that contains the objects. </p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Delimiter\":{\
          \"shape\":\"Delimiter\",\
          \"documentation\":\"<p>A delimiter is a character that you specify to group keys. All keys that contain the same string between the <code>prefix</code> and the first occurrence of the delimiter are grouped under a single result element in CommonPrefixes. These groups are counted as one result against the max-keys limitation. These keys are not returned elsewhere in the response.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"delimiter\"\
        },\
        \"EncodingType\":{\
          \"shape\":\"EncodingType\",\
          \"location\":\"querystring\",\
          \"locationName\":\"encoding-type\"\
        },\
        \"KeyMarker\":{\
          \"shape\":\"KeyMarker\",\
          \"documentation\":\"<p>Specifies the key to start with when listing objects in a bucket.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"key-marker\"\
        },\
        \"MaxKeys\":{\
          \"shape\":\"MaxKeys\",\
          \"documentation\":\"<p>Sets the maximum number of keys returned in the response. By default the API returns up to 1,000 key names. The response might contain fewer keys but will never contain more. If additional keys satisfy the search criteria, but were not returned because max-keys was exceeded, the response contains &lt;isTruncated&gt;true&lt;/isTruncated&gt;. To return the additional keys, see key-marker and version-id-marker.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"max-keys\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>Use this parameter to select only those keys that begin with the specified prefix. You can use prefixes to separate a bucket into different groupings of keys. (You can think of using prefix to make groups in the same way you'd use a folder in a file system.) You can use prefix with delimiter to roll up numerous objects into a single result under CommonPrefixes. </p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"prefix\"\
        },\
        \"VersionIdMarker\":{\
          \"shape\":\"VersionIdMarker\",\
          \"documentation\":\"<p>Specifies the object version you want to start listing from.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"version-id-marker\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"ListObjectsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"IsTruncated\":{\
          \"shape\":\"IsTruncated\",\
          \"documentation\":\"<p>A flag that indicates whether Amazon S3 returned all of the results that satisfied the search criteria.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"Marker\",\
          \"documentation\":\"<p>Indicates where in the bucket listing begins. Marker is included in the response if it was sent with the request.</p>\"\
        },\
        \"NextMarker\":{\
          \"shape\":\"NextMarker\",\
          \"documentation\":\"<p>When response is truncated (the IsTruncated element value in the response is true), you can use the key name in this field as marker in the subsequent request to get next set of objects. Amazon S3 lists objects in alphabetical order Note: This element is returned only if you have delimiter request parameter specified. If response does not include the NextMarker and it is truncated, you can use the value of the last Key in the response as the marker in the subsequent request to get the next set of object keys.</p>\"\
        },\
        \"Contents\":{\
          \"shape\":\"ObjectList\",\
          \"documentation\":\"<p>Metadata about each object returned.</p>\"\
        },\
        \"Name\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>Keys that begin with the indicated prefix.</p>\"\
        },\
        \"Delimiter\":{\
          \"shape\":\"Delimiter\",\
          \"documentation\":\"<p>Causes keys that contain the same string between the prefix and the first occurrence of the delimiter to be rolled up into a single result element in the <code>CommonPrefixes</code> collection. These rolled-up keys are not returned elsewhere in the response. Each rolled-up result counts as only one return against the <code>MaxKeys</code> value.</p>\"\
        },\
        \"MaxKeys\":{\
          \"shape\":\"MaxKeys\",\
          \"documentation\":\"<p>The maximum number of keys returned in the response body.</p>\"\
        },\
        \"CommonPrefixes\":{\
          \"shape\":\"CommonPrefixList\",\
          \"documentation\":\"<p>All of the keys rolled up in a common prefix count as a single return when calculating the number of returns. </p> <p>A response can contain CommonPrefixes only if you specify a delimiter.</p> <p>CommonPrefixes contains all (if there are any) keys between Prefix and the next occurrence of the string specified by the delimiter.</p> <p> CommonPrefixes lists keys that act like subdirectories in the directory specified by Prefix.</p> <p>For example, if the prefix is notes/ and the delimiter is a slash (/) as in notes/summer/july, the common prefix is notes/summer/. All of the keys that roll up into a common prefix count as a single return when calculating the number of returns.</p>\"\
        },\
        \"EncodingType\":{\
          \"shape\":\"EncodingType\",\
          \"documentation\":\"<p>Encoding type used by Amazon S3 to encode object keys in the response.</p>\"\
        }\
      }\
    },\
    \"ListObjectsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket containing the objects.</p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Delimiter\":{\
          \"shape\":\"Delimiter\",\
          \"documentation\":\"<p>A delimiter is a character you use to group keys.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"delimiter\"\
        },\
        \"EncodingType\":{\
          \"shape\":\"EncodingType\",\
          \"location\":\"querystring\",\
          \"locationName\":\"encoding-type\"\
        },\
        \"Marker\":{\
          \"shape\":\"Marker\",\
          \"documentation\":\"<p>Specifies the key to start with when listing objects in a bucket.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"marker\"\
        },\
        \"MaxKeys\":{\
          \"shape\":\"MaxKeys\",\
          \"documentation\":\"<p>Sets the maximum number of keys returned in the response. By default the API returns up to 1,000 key names. The response might contain fewer keys but will never contain more. </p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"max-keys\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>Limits the response to keys that begin with the specified prefix.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"prefix\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"documentation\":\"<p>Confirms that the requester knows that she or he will be charged for the list objects request. Bucket owners need not specify this parameter in their requests.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"ListObjectsV2Output\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"IsTruncated\":{\
          \"shape\":\"IsTruncated\",\
          \"documentation\":\"<p>Set to false if all of the results were returned. Set to true if more keys are available to return. If the number of results exceeds that specified by MaxKeys, all of the results might not be returned.</p>\"\
        },\
        \"Contents\":{\
          \"shape\":\"ObjectList\",\
          \"documentation\":\"<p>Metadata about each object returned.</p>\"\
        },\
        \"Name\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name.</p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p> Keys that begin with the indicated prefix.</p>\"\
        },\
        \"Delimiter\":{\
          \"shape\":\"Delimiter\",\
          \"documentation\":\"<p>Causes keys that contain the same string between the prefix and the first occurrence of the delimiter to be rolled up into a single result element in the CommonPrefixes collection. These rolled-up keys are not returned elsewhere in the response. Each rolled-up result counts as only one return against the <code>MaxKeys</code> value.</p>\"\
        },\
        \"MaxKeys\":{\
          \"shape\":\"MaxKeys\",\
          \"documentation\":\"<p>Sets the maximum number of keys returned in the response. By default the API returns up to 1,000 key names. The response might contain fewer keys but will never contain more.</p>\"\
        },\
        \"CommonPrefixes\":{\
          \"shape\":\"CommonPrefixList\",\
          \"documentation\":\"<p>All of the keys rolled up into a common prefix count as a single return when calculating the number of returns.</p> <p>A response can contain <code>CommonPrefixes</code> only if you specify a delimiter.</p> <p> <code>CommonPrefixes</code> contains all (if there are any) keys between <code>Prefix</code> and the next occurrence of the string specified by a delimiter.</p> <p> <code>CommonPrefixes</code> lists keys that act like subdirectories in the directory specified by <code>Prefix</code>.</p> <p>For example, if the prefix is <code>notes/</code> and the delimiter is a slash (<code>/</code>) as in <code>notes/summer/july</code>, the common prefix is <code>notes/summer/</code>. All of the keys that roll up into a common prefix count as a single return when calculating the number of returns. </p>\"\
        },\
        \"EncodingType\":{\
          \"shape\":\"EncodingType\",\
          \"documentation\":\"<p>Encoding type used by Amazon S3 to encode object key names in the XML response.</p> <p>If you specify the encoding-type request parameter, Amazon S3 includes this element in the response, and returns encoded key name values in the following response elements:</p> <p> <code>Delimiter, Prefix, Key,</code> and <code>StartAfter</code>.</p>\"\
        },\
        \"KeyCount\":{\
          \"shape\":\"KeyCount\",\
          \"documentation\":\"<p>KeyCount is the number of keys returned with this request. KeyCount will always be less than equals to MaxKeys field. Say you ask for 50 keys, your result will include less than equals 50 keys </p>\"\
        },\
        \"ContinuationToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p> If ContinuationToken was sent with the request, it is included in the response.</p>\"\
        },\
        \"NextContinuationToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p> <code>NextContinuationToken</code> is sent when <code>isTruncated</code> is true, which means there are more keys in the bucket that can be listed. The next list requests to Amazon S3 can be continued with this <code>NextContinuationToken</code>. <code>NextContinuationToken</code> is obfuscated and is not a real key</p>\"\
        },\
        \"StartAfter\":{\
          \"shape\":\"StartAfter\",\
          \"documentation\":\"<p>If StartAfter was sent with the request, it is included in the response.</p>\"\
        }\
      }\
    },\
    \"ListObjectsV2Request\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>Bucket name to list. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Delimiter\":{\
          \"shape\":\"Delimiter\",\
          \"documentation\":\"<p>A delimiter is a character you use to group keys.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"delimiter\"\
        },\
        \"EncodingType\":{\
          \"shape\":\"EncodingType\",\
          \"documentation\":\"<p>Encoding type used by Amazon S3 to encode object keys in the response.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"encoding-type\"\
        },\
        \"MaxKeys\":{\
          \"shape\":\"MaxKeys\",\
          \"documentation\":\"<p>Sets the maximum number of keys returned in the response. By default the API returns up to 1,000 key names. The response might contain fewer keys but will never contain more.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"max-keys\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>Limits the response to keys that begin with the specified prefix.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"prefix\"\
        },\
        \"ContinuationToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>ContinuationToken indicates Amazon S3 that the list is being continued on this bucket with a token. ContinuationToken is obfuscated and is not a real key.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"continuation-token\"\
        },\
        \"FetchOwner\":{\
          \"shape\":\"FetchOwner\",\
          \"documentation\":\"<p>The owner field is not present in listV2 by default, if you want to return owner field with each key in the result then set the fetch owner field to true.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"fetch-owner\"\
        },\
        \"StartAfter\":{\
          \"shape\":\"StartAfter\",\
          \"documentation\":\"<p>StartAfter is where you want Amazon S3 to start listing from. Amazon S3 starts listing after this specified key. StartAfter can be any key in the bucket.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"start-after\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"documentation\":\"<p>Confirms that the requester knows that she or he will be charged for the list objects request in V2 style. Bucket owners need not specify this parameter in their requests.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"ListPartsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AbortDate\":{\
          \"shape\":\"AbortDate\",\
          \"documentation\":\"<p>If the bucket has a lifecycle rule configured with an action to abort incomplete multipart uploads and the prefix in the lifecycle rule matches the object name in the request, then the response includes this header indicating when the initiated multipart upload will become eligible for abort operation. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config\\\">Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy</a>.</p> <p>The response will also include the <code>x-amz-abort-rule-id</code> header that will provide the ID of the lifecycle configuration rule that defines this action.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-abort-date\"\
        },\
        \"AbortRuleId\":{\
          \"shape\":\"AbortRuleId\",\
          \"documentation\":\"<p>This header is returned along with the <code>x-amz-abort-date</code> header. It identifies applicable lifecycle configuration rule that defines the action to abort incomplete multipart uploads.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-abort-rule-id\"\
        },\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket to which the multipart upload was initiated.</p>\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Object key for which the multipart upload was initiated.</p>\"\
        },\
        \"UploadId\":{\
          \"shape\":\"MultipartUploadId\",\
          \"documentation\":\"<p>Upload ID identifying the multipart upload whose parts are being listed.</p>\"\
        },\
        \"PartNumberMarker\":{\
          \"shape\":\"PartNumberMarker\",\
          \"documentation\":\"<p>When a list is truncated, this element specifies the last part in the list, as well as the value to use for the part-number-marker request parameter in a subsequent request.</p>\"\
        },\
        \"NextPartNumberMarker\":{\
          \"shape\":\"NextPartNumberMarker\",\
          \"documentation\":\"<p>When a list is truncated, this element specifies the last part in the list, as well as the value to use for the part-number-marker request parameter in a subsequent request.</p>\"\
        },\
        \"MaxParts\":{\
          \"shape\":\"MaxParts\",\
          \"documentation\":\"<p>Maximum number of parts that were allowed in the response.</p>\"\
        },\
        \"IsTruncated\":{\
          \"shape\":\"IsTruncated\",\
          \"documentation\":\"<p> Indicates whether the returned list of parts is truncated. A true value indicates that the list was truncated. A list can be truncated if the number of parts exceeds the limit returned in the MaxParts element.</p>\"\
        },\
        \"Parts\":{\
          \"shape\":\"Parts\",\
          \"documentation\":\"<p> Container for elements related to a particular part. A response can contain zero or more <code>Part</code> elements.</p>\",\
          \"locationName\":\"Part\"\
        },\
        \"Initiator\":{\
          \"shape\":\"Initiator\",\
          \"documentation\":\"<p>Container element that identifies who initiated the multipart upload. If the initiator is an AWS account, this element provides the same information as the <code>Owner</code> element. If the initiator is an IAM User, this element provides the user ARN and display name.</p>\"\
        },\
        \"Owner\":{\
          \"shape\":\"Owner\",\
          \"documentation\":\"<p> Container element that identifies the object owner, after the object is created. If multipart upload is initiated by an IAM user, this element provides the parent account ID and display name.</p>\"\
        },\
        \"StorageClass\":{\
          \"shape\":\"StorageClass\",\
          \"documentation\":\"<p>Class of storage (STANDARD or REDUCED_REDUNDANCY) used to store the uploaded object.</p>\"\
        },\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      }\
    },\
    \"ListPartsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\",\
        \"UploadId\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket to which the parts are being uploaded. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Object key for which the multipart upload was initiated.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"MaxParts\":{\
          \"shape\":\"MaxParts\",\
          \"documentation\":\"<p>Sets the maximum number of parts to return.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"max-parts\"\
        },\
        \"PartNumberMarker\":{\
          \"shape\":\"PartNumberMarker\",\
          \"documentation\":\"<p>Specifies the part after which listing should begin. Only parts with higher part numbers will be listed.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"part-number-marker\"\
        },\
        \"UploadId\":{\
          \"shape\":\"MultipartUploadId\",\
          \"documentation\":\"<p>Upload ID identifying the multipart upload whose parts are being listed.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"uploadId\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      }\
    },\
    \"Location\":{\"type\":\"string\"},\
    \"LocationPrefix\":{\"type\":\"string\"},\
    \"LoggingEnabled\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TargetBucket\",\
        \"TargetPrefix\"\
      ],\
      \"members\":{\
        \"TargetBucket\":{\
          \"shape\":\"TargetBucket\",\
          \"documentation\":\"<p>Specifies the bucket where you want Amazon S3 to store server access logs. You can have your logs delivered to any bucket that you own, including the same bucket that is being logged. You can also configure multiple buckets to deliver their logs to the same target bucket. In this case, you should choose a different <code>TargetPrefix</code> for each source bucket so that the delivered log files can be distinguished by key.</p>\"\
        },\
        \"TargetGrants\":{\
          \"shape\":\"TargetGrants\",\
          \"documentation\":\"<p>Container for granting information.</p>\"\
        },\
        \"TargetPrefix\":{\
          \"shape\":\"TargetPrefix\",\
          \"documentation\":\"<p>A prefix for all log object keys. If you store log files from multiple Amazon S3 buckets in a single bucket, you can use a prefix to distinguish which log files came from which bucket.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes where logs are stored and the prefix that Amazon S3 assigns to all log object keys for a bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTlogging.html\\\">PUT Bucket logging</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>\"\
    },\
    \"MFA\":{\"type\":\"string\"},\
    \"MFADelete\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Enabled\",\
        \"Disabled\"\
      ]\
    },\
    \"MFADeleteStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Enabled\",\
        \"Disabled\"\
      ]\
    },\
    \"Marker\":{\"type\":\"string\"},\
    \"MaxAgeSeconds\":{\"type\":\"integer\"},\
    \"MaxKeys\":{\"type\":\"integer\"},\
    \"MaxParts\":{\"type\":\"integer\"},\
    \"MaxUploads\":{\"type\":\"integer\"},\
    \"Message\":{\"type\":\"string\"},\
    \"Metadata\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"MetadataKey\"},\
      \"value\":{\"shape\":\"MetadataValue\"}\
    },\
    \"MetadataDirective\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"COPY\",\
        \"REPLACE\"\
      ]\
    },\
    \"MetadataEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Name\":{\
          \"shape\":\"MetadataKey\",\
          \"documentation\":\"<p>Name of the Object.</p>\"\
        },\
        \"Value\":{\
          \"shape\":\"MetadataValue\",\
          \"documentation\":\"<p>Value of the Object.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A metadata key-value pair to store with an object.</p>\"\
    },\
    \"MetadataKey\":{\"type\":\"string\"},\
    \"MetadataValue\":{\"type\":\"string\"},\
    \"Metrics\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Status\",\
        \"EventThreshold\"\
      ],\
      \"members\":{\
        \"Status\":{\
          \"shape\":\"MetricsStatus\",\
          \"documentation\":\"<p> Specifies whether the replication metrics are enabled. </p>\"\
        },\
        \"EventThreshold\":{\
          \"shape\":\"ReplicationTimeValue\",\
          \"documentation\":\"<p> A container specifying the time threshold for emitting the <code>s3:Replication:OperationMissedThreshold</code> event. </p>\"\
        }\
      },\
      \"documentation\":\"<p> A container specifying replication metrics-related settings enabling metrics and Amazon S3 events for S3 Replication Time Control (S3 RTC). Must be specified together with a <code>ReplicationTime</code> block. </p>\"\
    },\
    \"MetricsAndOperator\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The prefix used when evaluating an AND predicate.</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagSet\",\
          \"documentation\":\"<p>The list of tags used when evaluating an AND predicate.</p>\",\
          \"flattened\":true,\
          \"locationName\":\"Tag\"\
        }\
      },\
      \"documentation\":\"<p>A conjunction (logical AND) of predicates, which is used in evaluating a metrics filter. The operator must have at least two predicates, and an object must match all of the predicates in order for the filter to apply.</p>\"\
    },\
    \"MetricsConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\"Id\"],\
      \"members\":{\
        \"Id\":{\
          \"shape\":\"MetricsId\",\
          \"documentation\":\"<p>The ID used to identify the metrics configuration.</p>\"\
        },\
        \"Filter\":{\
          \"shape\":\"MetricsFilter\",\
          \"documentation\":\"<p>Specifies a metrics configuration filter. The metrics configuration will only include objects that meet the filter's criteria. A filter must be a prefix, a tag, or a conjunction (MetricsAndOperator).</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies a metrics configuration for the CloudWatch request metrics (specified by the metrics configuration ID) from an Amazon S3 bucket. If you're updating an existing metrics configuration, note that this is a full replacement of the existing metrics configuration. If you don't include the elements you want to keep, they are erased. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTMetricConfiguration.html\\\"> PUT Bucket metrics</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>\"\
    },\
    \"MetricsConfigurationList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"MetricsConfiguration\"},\
      \"flattened\":true\
    },\
    \"MetricsFilter\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The prefix used when evaluating a metrics filter.</p>\"\
        },\
        \"Tag\":{\
          \"shape\":\"Tag\",\
          \"documentation\":\"<p>The tag used when evaluating a metrics filter.</p>\"\
        },\
        \"And\":{\
          \"shape\":\"MetricsAndOperator\",\
          \"documentation\":\"<p>A conjunction (logical AND) of predicates, which is used in evaluating a metrics filter. The operator must have at least two predicates, and an object must match all of the predicates in order for the filter to apply.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies a metrics configuration filter. The metrics configuration only includes objects that meet the filter's criteria. A filter must be a prefix, a tag, or a conjunction (MetricsAndOperator).</p>\"\
    },\
    \"MetricsId\":{\"type\":\"string\"},\
    \"MetricsStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Enabled\",\
        \"Disabled\"\
      ]\
    },\
    \"Minutes\":{\"type\":\"integer\"},\
    \"MissingMeta\":{\"type\":\"integer\"},\
    \"MultipartUpload\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"UploadId\":{\
          \"shape\":\"MultipartUploadId\",\
          \"documentation\":\"<p>Upload ID that identifies the multipart upload.</p>\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Key of the object for which the multipart upload was initiated.</p>\"\
        },\
        \"Initiated\":{\
          \"shape\":\"Initiated\",\
          \"documentation\":\"<p>Date and time at which the multipart upload was initiated.</p>\"\
        },\
        \"StorageClass\":{\
          \"shape\":\"StorageClass\",\
          \"documentation\":\"<p>The class of storage used to store the object.</p>\"\
        },\
        \"Owner\":{\
          \"shape\":\"Owner\",\
          \"documentation\":\"<p>Specifies the owner of the object that is part of the multipart upload. </p>\"\
        },\
        \"Initiator\":{\
          \"shape\":\"Initiator\",\
          \"documentation\":\"<p>Identifies who initiated the multipart upload.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for the <code>MultipartUpload</code> for the Amazon S3 object.</p>\"\
    },\
    \"MultipartUploadId\":{\"type\":\"string\"},\
    \"MultipartUploadList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"MultipartUpload\"},\
      \"flattened\":true\
    },\
    \"NextKeyMarker\":{\"type\":\"string\"},\
    \"NextMarker\":{\"type\":\"string\"},\
    \"NextPartNumberMarker\":{\"type\":\"integer\"},\
    \"NextToken\":{\"type\":\"string\"},\
    \"NextUploadIdMarker\":{\"type\":\"string\"},\
    \"NextVersionIdMarker\":{\"type\":\"string\"},\
    \"NoSuchBucket\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The specified bucket does not exist.</p>\",\
      \"exception\":true\
    },\
    \"NoSuchKey\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The specified key does not exist.</p>\",\
      \"exception\":true\
    },\
    \"NoSuchUpload\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The specified multipart upload does not exist.</p>\",\
      \"exception\":true\
    },\
    \"NoncurrentVersionExpiration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"NoncurrentDays\":{\
          \"shape\":\"Days\",\
          \"documentation\":\"<p>Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action. For information about the noncurrent days calculations, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#non-current-days-calculations\\\">How Amazon S3 Calculates When an Object Became Noncurrent</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies when noncurrent object versions expire. Upon expiration, Amazon S3 permanently deletes the noncurrent object versions. You set this lifecycle configuration action on a bucket that has versioning enabled (or suspended) to request that Amazon S3 delete noncurrent object versions at a specific period in the object's lifetime.</p>\"\
    },\
    \"NoncurrentVersionTransition\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"NoncurrentDays\":{\
          \"shape\":\"Days\",\
          \"documentation\":\"<p>Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action. For information about the noncurrent days calculations, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#non-current-days-calculations\\\">How Amazon S3 Calculates How Long an Object Has Been Noncurrent</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
        },\
        \"StorageClass\":{\
          \"shape\":\"TransitionStorageClass\",\
          \"documentation\":\"<p>The class of storage used to store the object.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for the transition rule that describes when noncurrent objects transition to the <code>STANDARD_IA</code>, <code>ONEZONE_IA</code>, <code>INTELLIGENT_TIERING</code>, <code>GLACIER</code>, or <code>DEEP_ARCHIVE</code> storage class. If your bucket is versioning-enabled (or versioning is suspended), you can set this action to request that Amazon S3 transition noncurrent object versions to the <code>STANDARD_IA</code>, <code>ONEZONE_IA</code>, <code>INTELLIGENT_TIERING</code>, <code>GLACIER</code>, or <code>DEEP_ARCHIVE</code> storage class at a specific period in the object's lifetime.</p>\"\
    },\
    \"NoncurrentVersionTransitionList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"NoncurrentVersionTransition\"},\
      \"flattened\":true\
    },\
    \"NotificationConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TopicConfigurations\":{\
          \"shape\":\"TopicConfigurationList\",\
          \"documentation\":\"<p>The topic to which notifications are sent and the events for which notifications are generated.</p>\",\
          \"locationName\":\"TopicConfiguration\"\
        },\
        \"QueueConfigurations\":{\
          \"shape\":\"QueueConfigurationList\",\
          \"documentation\":\"<p>The Amazon Simple Queue Service queues to publish messages to and the events for which to publish messages.</p>\",\
          \"locationName\":\"QueueConfiguration\"\
        },\
        \"LambdaFunctionConfigurations\":{\
          \"shape\":\"LambdaFunctionConfigurationList\",\
          \"documentation\":\"<p>Describes the AWS Lambda functions to invoke and the events for which to invoke them.</p>\",\
          \"locationName\":\"CloudFunctionConfiguration\"\
        }\
      },\
      \"documentation\":\"<p>A container for specifying the notification configuration of the bucket. If this element is empty, notifications are turned off for the bucket.</p>\"\
    },\
    \"NotificationConfigurationDeprecated\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TopicConfiguration\":{\
          \"shape\":\"TopicConfigurationDeprecated\",\
          \"documentation\":\"<p>This data type is deprecated. A container for specifying the configuration for publication of messages to an Amazon Simple Notification Service (Amazon SNS) topic when Amazon S3 detects specified events. </p>\"\
        },\
        \"QueueConfiguration\":{\
          \"shape\":\"QueueConfigurationDeprecated\",\
          \"documentation\":\"<p>This data type is deprecated. This data type specifies the configuration for publishing messages to an Amazon Simple Queue Service (Amazon SQS) queue when Amazon S3 detects specified events. </p>\"\
        },\
        \"CloudFunctionConfiguration\":{\
          \"shape\":\"CloudFunctionConfiguration\",\
          \"documentation\":\"<p>Container for specifying the AWS Lambda notification configuration.</p>\"\
        }\
      }\
    },\
    \"NotificationConfigurationFilter\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"S3KeyFilter\",\
          \"locationName\":\"S3Key\"\
        }\
      },\
      \"documentation\":\"<p>Specifies object key name filtering rules. For information about key name filtering, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\\\">Configuring Event Notifications</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
    },\
    \"NotificationId\":{\
      \"type\":\"string\",\
      \"documentation\":\"<p>An optional unique identifier for configurations in a notification configuration. If you don't provide one, Amazon S3 will assign an ID.</p>\"\
    },\
    \"Object\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The name that you assign to an object. You use the object key to retrieve the object.</p>\"\
        },\
        \"LastModified\":{\
          \"shape\":\"LastModified\",\
          \"documentation\":\"<p>The date the Object was Last Modified</p>\"\
        },\
        \"ETag\":{\
          \"shape\":\"ETag\",\
          \"documentation\":\"<p>The entity tag is a hash of the object. The ETag reflects changes only to the contents of an object, not its metadata. The ETag may or may not be an MD5 digest of the object data. Whether or not it is depends on how the object was created and how it is encrypted as described below:</p> <ul> <li> <p>Objects created by the PUT Object, POST Object, or Copy operation, or through the AWS Management Console, and are encrypted by SSE-S3 or plaintext, have ETags that are an MD5 digest of their object data.</p> </li> <li> <p>Objects created by the PUT Object, POST Object, or Copy operation, or through the AWS Management Console, and are encrypted by SSE-C or SSE-KMS, have ETags that are not an MD5 digest of their object data.</p> </li> <li> <p>If an object is created by either the Multipart Upload or Part Copy operation, the ETag is not an MD5 digest, regardless of the method of encryption.</p> </li> </ul>\"\
        },\
        \"Size\":{\
          \"shape\":\"Size\",\
          \"documentation\":\"<p>Size in bytes of the object</p>\"\
        },\
        \"StorageClass\":{\
          \"shape\":\"ObjectStorageClass\",\
          \"documentation\":\"<p>The class of storage used to store the object.</p>\"\
        },\
        \"Owner\":{\
          \"shape\":\"Owner\",\
          \"documentation\":\"<p>The owner of the object</p>\"\
        }\
      },\
      \"documentation\":\"<p>An object consists of data and its descriptive metadata.</p>\"\
    },\
    \"ObjectAlreadyInActiveTierError\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>This operation is not allowed against this storage tier.</p>\",\
      \"exception\":true\
    },\
    \"ObjectCannedACL\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"private\",\
        \"public-read\",\
        \"public-read-write\",\
        \"authenticated-read\",\
        \"aws-exec-read\",\
        \"bucket-owner-read\",\
        \"bucket-owner-full-control\"\
      ]\
    },\
    \"ObjectIdentifier\":{\
      \"type\":\"structure\",\
      \"required\":[\"Key\"],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Key name of the object to delete.</p>\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>VersionId for the specific version of the object to delete.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Object Identifier is unique value to identify objects.</p>\"\
    },\
    \"ObjectIdentifierList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ObjectIdentifier\"},\
      \"flattened\":true\
    },\
    \"ObjectKey\":{\
      \"type\":\"string\",\
      \"min\":1\
    },\
    \"ObjectList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Object\"},\
      \"flattened\":true\
    },\
    \"ObjectLockConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ObjectLockEnabled\":{\
          \"shape\":\"ObjectLockEnabled\",\
          \"documentation\":\"<p>Indicates whether this bucket has an Object Lock configuration enabled.</p>\"\
        },\
        \"Rule\":{\
          \"shape\":\"ObjectLockRule\",\
          \"documentation\":\"<p>The Object Lock rule in place for the specified object.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The container element for Object Lock configuration parameters.</p>\"\
    },\
    \"ObjectLockEnabled\":{\
      \"type\":\"string\",\
      \"enum\":[\"Enabled\"]\
    },\
    \"ObjectLockEnabledForBucket\":{\"type\":\"boolean\"},\
    \"ObjectLockLegalHold\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Status\":{\
          \"shape\":\"ObjectLockLegalHoldStatus\",\
          \"documentation\":\"<p>Indicates whether the specified object has a Legal Hold in place.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A Legal Hold configuration for an object.</p>\"\
    },\
    \"ObjectLockLegalHoldStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ON\",\
        \"OFF\"\
      ]\
    },\
    \"ObjectLockMode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"GOVERNANCE\",\
        \"COMPLIANCE\"\
      ]\
    },\
    \"ObjectLockRetainUntilDate\":{\
      \"type\":\"timestamp\",\
      \"timestampFormat\":\"iso8601\"\
    },\
    \"ObjectLockRetention\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Mode\":{\
          \"shape\":\"ObjectLockRetentionMode\",\
          \"documentation\":\"<p>Indicates the Retention mode for the specified object.</p>\"\
        },\
        \"RetainUntilDate\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p>The date on which this Object Lock Retention will expire.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A Retention configuration for an object.</p>\"\
    },\
    \"ObjectLockRetentionMode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"GOVERNANCE\",\
        \"COMPLIANCE\"\
      ]\
    },\
    \"ObjectLockRule\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DefaultRetention\":{\
          \"shape\":\"DefaultRetention\",\
          \"documentation\":\"<p>The default retention period that you want to apply to new objects placed in the specified bucket.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The container element for an Object Lock rule.</p>\"\
    },\
    \"ObjectLockToken\":{\"type\":\"string\"},\
    \"ObjectNotInActiveTierError\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>The source object of the COPY operation is not in the active tier and is only stored in Amazon S3 Glacier.</p>\",\
      \"exception\":true\
    },\
    \"ObjectOwnership\":{\
      \"type\":\"string\",\
      \"documentation\":\"<p>The container element for object ownership for a bucket's ownership controls.</p> <p>BucketOwnerPreferred - Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the <code>bucket-owner-full-control</code> canned ACL.</p> <p>ObjectWriter - The uploading account will own the object if the object is uploaded with the <code>bucket-owner-full-control</code> canned ACL.</p>\",\
      \"enum\":[\
        \"BucketOwnerPreferred\",\
        \"ObjectWriter\"\
      ]\
    },\
    \"ObjectStorageClass\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"STANDARD\",\
        \"REDUCED_REDUNDANCY\",\
        \"GLACIER\",\
        \"STANDARD_IA\",\
        \"ONEZONE_IA\",\
        \"INTELLIGENT_TIERING\",\
        \"DEEP_ARCHIVE\",\
        \"OUTPOSTS\"\
      ]\
    },\
    \"ObjectVersion\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ETag\":{\
          \"shape\":\"ETag\",\
          \"documentation\":\"<p>The entity tag is an MD5 hash of that version of the object.</p>\"\
        },\
        \"Size\":{\
          \"shape\":\"Size\",\
          \"documentation\":\"<p>Size in bytes of the object.</p>\"\
        },\
        \"StorageClass\":{\
          \"shape\":\"ObjectVersionStorageClass\",\
          \"documentation\":\"<p>The class of storage used to store the object.</p>\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The object key.</p>\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>Version ID of an object.</p>\"\
        },\
        \"IsLatest\":{\
          \"shape\":\"IsLatest\",\
          \"documentation\":\"<p>Specifies whether the object is (true) or is not (false) the latest version of an object.</p>\"\
        },\
        \"LastModified\":{\
          \"shape\":\"LastModified\",\
          \"documentation\":\"<p>Date and time the object was last modified.</p>\"\
        },\
        \"Owner\":{\
          \"shape\":\"Owner\",\
          \"documentation\":\"<p>Specifies the owner of the object.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The version of an object.</p>\"\
    },\
    \"ObjectVersionId\":{\"type\":\"string\"},\
    \"ObjectVersionList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ObjectVersion\"},\
      \"flattened\":true\
    },\
    \"ObjectVersionStorageClass\":{\
      \"type\":\"string\",\
      \"enum\":[\"STANDARD\"]\
    },\
    \"OutputLocation\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"S3\":{\
          \"shape\":\"S3Location\",\
          \"documentation\":\"<p>Describes an S3 location that will receive the results of the restore request.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the location where the restore job's output is stored.</p>\"\
    },\
    \"OutputSerialization\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CSV\":{\
          \"shape\":\"CSVOutput\",\
          \"documentation\":\"<p>Describes the serialization of CSV-encoded Select results.</p>\"\
        },\
        \"JSON\":{\
          \"shape\":\"JSONOutput\",\
          \"documentation\":\"<p>Specifies JSON as request's output serialization format.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes how results of the Select job are serialized.</p>\"\
    },\
    \"Owner\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DisplayName\":{\
          \"shape\":\"DisplayName\",\
          \"documentation\":\"<p>Container for the display name of the owner.</p>\"\
        },\
        \"ID\":{\
          \"shape\":\"ID\",\
          \"documentation\":\"<p>Container for the ID of the owner.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for the owner's display name and ID.</p>\"\
    },\
    \"OwnerOverride\":{\
      \"type\":\"string\",\
      \"enum\":[\"Destination\"]\
    },\
    \"OwnershipControls\":{\
      \"type\":\"structure\",\
      \"required\":[\"Rules\"],\
      \"members\":{\
        \"Rules\":{\
          \"shape\":\"OwnershipControlsRules\",\
          \"documentation\":\"<p>The container element for an ownership control rule.</p>\",\
          \"locationName\":\"Rule\"\
        }\
      },\
      \"documentation\":\"<p>The container element for a bucket's ownership controls.</p>\"\
    },\
    \"OwnershipControlsRule\":{\
      \"type\":\"structure\",\
      \"required\":[\"ObjectOwnership\"],\
      \"members\":{\
        \"ObjectOwnership\":{\"shape\":\"ObjectOwnership\"}\
      },\
      \"documentation\":\"<p>The container element for an ownership control rule.</p>\"\
    },\
    \"OwnershipControlsRules\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"OwnershipControlsRule\"},\
      \"flattened\":true\
    },\
    \"ParquetInput\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>Container for Parquet.</p>\"\
    },\
    \"Part\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"PartNumber\":{\
          \"shape\":\"PartNumber\",\
          \"documentation\":\"<p>Part number identifying the part. This is a positive integer between 1 and 10,000.</p>\"\
        },\
        \"LastModified\":{\
          \"shape\":\"LastModified\",\
          \"documentation\":\"<p>Date and time at which the part was uploaded.</p>\"\
        },\
        \"ETag\":{\
          \"shape\":\"ETag\",\
          \"documentation\":\"<p>Entity tag returned when the part was uploaded.</p>\"\
        },\
        \"Size\":{\
          \"shape\":\"Size\",\
          \"documentation\":\"<p>Size in bytes of the uploaded part data.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for elements related to a part.</p>\"\
    },\
    \"PartNumber\":{\"type\":\"integer\"},\
    \"PartNumberMarker\":{\"type\":\"integer\"},\
    \"Parts\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Part\"},\
      \"flattened\":true\
    },\
    \"PartsCount\":{\"type\":\"integer\"},\
    \"Payer\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Requester\",\
        \"BucketOwner\"\
      ]\
    },\
    \"Permission\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"FULL_CONTROL\",\
        \"WRITE\",\
        \"WRITE_ACP\",\
        \"READ\",\
        \"READ_ACP\"\
      ]\
    },\
    \"Policy\":{\"type\":\"string\"},\
    \"PolicyStatus\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"IsPublic\":{\
          \"shape\":\"IsPublic\",\
          \"documentation\":\"<p>The policy status for this bucket. <code>TRUE</code> indicates that this bucket is public. <code>FALSE</code> indicates that the bucket is not public.</p>\",\
          \"locationName\":\"IsPublic\"\
        }\
      },\
      \"documentation\":\"<p>The container element for a bucket's policy status.</p>\"\
    },\
    \"Prefix\":{\"type\":\"string\"},\
    \"Priority\":{\"type\":\"integer\"},\
    \"Progress\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"BytesScanned\":{\
          \"shape\":\"BytesScanned\",\
          \"documentation\":\"<p>The current number of object bytes scanned.</p>\"\
        },\
        \"BytesProcessed\":{\
          \"shape\":\"BytesProcessed\",\
          \"documentation\":\"<p>The current number of uncompressed object bytes processed.</p>\"\
        },\
        \"BytesReturned\":{\
          \"shape\":\"BytesReturned\",\
          \"documentation\":\"<p>The current number of bytes of records payload data returned.</p>\"\
        }\
      },\
      \"documentation\":\"<p>This data type contains information about progress of an operation.</p>\"\
    },\
    \"ProgressEvent\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Details\":{\
          \"shape\":\"Progress\",\
          \"documentation\":\"<p>The Progress event details.</p>\",\
          \"eventpayload\":true\
        }\
      },\
      \"documentation\":\"<p>This data type contains information about the progress event of an operation.</p>\",\
      \"event\":true\
    },\
    \"Protocol\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"http\",\
        \"https\"\
      ]\
    },\
    \"PublicAccessBlockConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"BlockPublicAcls\":{\
          \"shape\":\"Setting\",\
          \"documentation\":\"<p>Specifies whether Amazon S3 should block public access control lists (ACLs) for this bucket and objects in this bucket. Setting this element to <code>TRUE</code> causes the following behavior:</p> <ul> <li> <p>PUT Bucket acl and PUT Object acl calls fail if the specified ACL is public.</p> </li> <li> <p>PUT Object calls fail if the request includes a public ACL.</p> </li> <li> <p>PUT Bucket calls fail if the request includes a public ACL.</p> </li> </ul> <p>Enabling this setting doesn't affect existing policies or ACLs.</p>\",\
          \"locationName\":\"BlockPublicAcls\"\
        },\
        \"IgnorePublicAcls\":{\
          \"shape\":\"Setting\",\
          \"documentation\":\"<p>Specifies whether Amazon S3 should ignore public ACLs for this bucket and objects in this bucket. Setting this element to <code>TRUE</code> causes Amazon S3 to ignore all public ACLs on this bucket and objects in this bucket.</p> <p>Enabling this setting doesn't affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set.</p>\",\
          \"locationName\":\"IgnorePublicAcls\"\
        },\
        \"BlockPublicPolicy\":{\
          \"shape\":\"Setting\",\
          \"documentation\":\"<p>Specifies whether Amazon S3 should block public bucket policies for this bucket. Setting this element to <code>TRUE</code> causes Amazon S3 to reject calls to PUT Bucket policy if the specified bucket policy allows public access. </p> <p>Enabling this setting doesn't affect existing bucket policies.</p>\",\
          \"locationName\":\"BlockPublicPolicy\"\
        },\
        \"RestrictPublicBuckets\":{\
          \"shape\":\"Setting\",\
          \"documentation\":\"<p>Specifies whether Amazon S3 should restrict public bucket policies for this bucket. Setting this element to <code>TRUE</code> restricts access to this bucket to only AWS services and authorized users within this account if the bucket has a public policy.</p> <p>Enabling this setting doesn't affect previously stored bucket policies, except that public and cross-account access within any public bucket policy, including non-public delegation to specific accounts, is blocked.</p>\",\
          \"locationName\":\"RestrictPublicBuckets\"\
        }\
      },\
      \"documentation\":\"<p>The PublicAccessBlock configuration that you want to apply to this Amazon S3 bucket. You can enable the configuration options in any combination. For more information about when Amazon S3 considers a bucket or object public, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html#access-control-block-public-access-policy-status\\\">The Meaning of \\\"Public\\\"</a> in the <i>Amazon Simple Storage Service Developer Guide</i>. </p>\"\
    },\
    \"PutBucketAccelerateConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"AccelerateConfiguration\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket for which the accelerate configuration is set.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"AccelerateConfiguration\":{\
          \"shape\":\"AccelerateConfiguration\",\
          \"documentation\":\"<p>Container for setting the transfer acceleration state.</p>\",\
          \"locationName\":\"AccelerateConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"AccelerateConfiguration\"\
    },\
    \"PutBucketAclRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"ACL\":{\
          \"shape\":\"BucketCannedACL\",\
          \"documentation\":\"<p>The canned ACL to apply to the bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-acl\"\
        },\
        \"AccessControlPolicy\":{\
          \"shape\":\"AccessControlPolicy\",\
          \"documentation\":\"<p>Contains the elements that set the ACL permissions for an object per grantee.</p>\",\
          \"locationName\":\"AccessControlPolicy\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket to which to apply the ACL.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The base64-encoded 128-bit MD5 digest of the data. This header must be used as a message integrity check to verify that the request body was not corrupted in transit. For more information, go to <a href=\\\"http://www.ietf.org/rfc/rfc1864.txt\\\">RFC 1864.</a> </p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"GrantFullControl\":{\
          \"shape\":\"GrantFullControl\",\
          \"documentation\":\"<p>Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-full-control\"\
        },\
        \"GrantRead\":{\
          \"shape\":\"GrantRead\",\
          \"documentation\":\"<p>Allows grantee to list the objects in the bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-read\"\
        },\
        \"GrantReadACP\":{\
          \"shape\":\"GrantReadACP\",\
          \"documentation\":\"<p>Allows grantee to read the bucket ACL.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-read-acp\"\
        },\
        \"GrantWrite\":{\
          \"shape\":\"GrantWrite\",\
          \"documentation\":\"<p>Allows grantee to create, overwrite, and delete any object in the bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-write\"\
        },\
        \"GrantWriteACP\":{\
          \"shape\":\"GrantWriteACP\",\
          \"documentation\":\"<p>Allows grantee to write the ACL for the applicable bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-write-acp\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"AccessControlPolicy\"\
    },\
    \"PutBucketAnalyticsConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Id\",\
        \"AnalyticsConfiguration\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket to which an analytics configuration is stored.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Id\":{\
          \"shape\":\"AnalyticsId\",\
          \"documentation\":\"<p>The ID that identifies the analytics configuration.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"id\"\
        },\
        \"AnalyticsConfiguration\":{\
          \"shape\":\"AnalyticsConfiguration\",\
          \"documentation\":\"<p>The configuration and any analyses for the analytics filter.</p>\",\
          \"locationName\":\"AnalyticsConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"AnalyticsConfiguration\"\
    },\
    \"PutBucketCorsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"CORSConfiguration\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>Specifies the bucket impacted by the <code>cors</code>configuration.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"CORSConfiguration\":{\
          \"shape\":\"CORSConfiguration\",\
          \"documentation\":\"<p>Describes the cross-origin access configuration for objects in an Amazon S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html\\\">Enabling Cross-Origin Resource Sharing</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"locationName\":\"CORSConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The base64-encoded 128-bit MD5 digest of the data. This header must be used as a message integrity check to verify that the request body was not corrupted in transit. For more information, go to <a href=\\\"http://www.ietf.org/rfc/rfc1864.txt\\\">RFC 1864.</a> </p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"CORSConfiguration\"\
    },\
    \"PutBucketEncryptionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"ServerSideEncryptionConfiguration\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>Specifies default encryption for a bucket using server-side encryption with Amazon S3-managed keys (SSE-S3) or customer master keys stored in AWS KMS (SSE-KMS). For information about the Amazon S3 default encryption feature, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html\\\">Amazon S3 Default Bucket Encryption</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The base64-encoded 128-bit MD5 digest of the server-side encryption configuration. This parameter is auto-populated when using the command from the CLI.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"ServerSideEncryptionConfiguration\":{\
          \"shape\":\"ServerSideEncryptionConfiguration\",\
          \"locationName\":\"ServerSideEncryptionConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"ServerSideEncryptionConfiguration\"\
    },\
    \"PutBucketInventoryConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Id\",\
        \"InventoryConfiguration\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket where the inventory configuration will be stored.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Id\":{\
          \"shape\":\"InventoryId\",\
          \"documentation\":\"<p>The ID used to identify the inventory configuration.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"id\"\
        },\
        \"InventoryConfiguration\":{\
          \"shape\":\"InventoryConfiguration\",\
          \"documentation\":\"<p>Specifies the inventory configuration.</p>\",\
          \"locationName\":\"InventoryConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"InventoryConfiguration\"\
    },\
    \"PutBucketLifecycleConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket for which to set the configuration.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"LifecycleConfiguration\":{\
          \"shape\":\"BucketLifecycleConfiguration\",\
          \"documentation\":\"<p>Container for lifecycle rules. You can add as many as 1,000 rules.</p>\",\
          \"locationName\":\"LifecycleConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"LifecycleConfiguration\"\
    },\
    \"PutBucketLifecycleRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p/>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p/>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"LifecycleConfiguration\":{\
          \"shape\":\"LifecycleConfiguration\",\
          \"documentation\":\"<p/>\",\
          \"locationName\":\"LifecycleConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"LifecycleConfiguration\"\
    },\
    \"PutBucketLoggingRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"BucketLoggingStatus\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket for which to set the logging parameters.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"BucketLoggingStatus\":{\
          \"shape\":\"BucketLoggingStatus\",\
          \"documentation\":\"<p>Container for logging status information.</p>\",\
          \"locationName\":\"BucketLoggingStatus\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The MD5 hash of the <code>PutBucketLogging</code> request body.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"BucketLoggingStatus\"\
    },\
    \"PutBucketMetricsConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Id\",\
        \"MetricsConfiguration\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket for which the metrics configuration is set.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Id\":{\
          \"shape\":\"MetricsId\",\
          \"documentation\":\"<p>The ID used to identify the metrics configuration.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"id\"\
        },\
        \"MetricsConfiguration\":{\
          \"shape\":\"MetricsConfiguration\",\
          \"documentation\":\"<p>Specifies the metrics configuration.</p>\",\
          \"locationName\":\"MetricsConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"MetricsConfiguration\"\
    },\
    \"PutBucketNotificationConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"NotificationConfiguration\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"NotificationConfiguration\":{\
          \"shape\":\"NotificationConfiguration\",\
          \"locationName\":\"NotificationConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"NotificationConfiguration\"\
    },\
    \"PutBucketNotificationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"NotificationConfiguration\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The MD5 hash of the <code>PutPublicAccessBlock</code> request body.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"NotificationConfiguration\":{\
          \"shape\":\"NotificationConfigurationDeprecated\",\
          \"documentation\":\"<p>The container for the configuration.</p>\",\
          \"locationName\":\"NotificationConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"NotificationConfiguration\"\
    },\
    \"PutBucketOwnershipControlsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"OwnershipControls\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the Amazon S3 bucket whose <code>OwnershipControls</code> you want to set.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The MD5 hash of the <code>OwnershipControls</code> request body. </p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        },\
        \"OwnershipControls\":{\
          \"shape\":\"OwnershipControls\",\
          \"documentation\":\"<p>The <code>OwnershipControls</code> (BucketOwnerPreferred or ObjectWriter) that you want to apply to this Amazon S3 bucket.</p>\",\
          \"locationName\":\"OwnershipControls\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        }\
      },\
      \"payload\":\"OwnershipControls\"\
    },\
    \"PutBucketPolicyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Policy\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The MD5 hash of the request body.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"ConfirmRemoveSelfBucketAccess\":{\
          \"shape\":\"ConfirmRemoveSelfBucketAccess\",\
          \"documentation\":\"<p>Set this parameter to true to confirm that you want to remove your permissions to change this bucket policy in the future.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-confirm-remove-self-bucket-access\"\
        },\
        \"Policy\":{\
          \"shape\":\"Policy\",\
          \"documentation\":\"<p>The bucket policy as a JSON document.</p>\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"Policy\"\
    },\
    \"PutBucketReplicationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"ReplicationConfiguration\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The base64-encoded 128-bit MD5 digest of the data. You must use this header as a message integrity check to verify that the request body was not corrupted in transit. For more information, see <a href=\\\"http://www.ietf.org/rfc/rfc1864.txt\\\">RFC 1864</a>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"ReplicationConfiguration\":{\
          \"shape\":\"ReplicationConfiguration\",\
          \"locationName\":\"ReplicationConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"Token\":{\
          \"shape\":\"ObjectLockToken\",\
          \"documentation\":\"<p/>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-bucket-object-lock-token\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"ReplicationConfiguration\"\
    },\
    \"PutBucketRequestPaymentRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"RequestPaymentConfiguration\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>&gt;The base64-encoded 128-bit MD5 digest of the data. You must use this header as a message integrity check to verify that the request body was not corrupted in transit. For more information, see <a href=\\\"http://www.ietf.org/rfc/rfc1864.txt\\\">RFC 1864</a>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"RequestPaymentConfiguration\":{\
          \"shape\":\"RequestPaymentConfiguration\",\
          \"documentation\":\"<p>Container for Payer.</p>\",\
          \"locationName\":\"RequestPaymentConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"RequestPaymentConfiguration\"\
    },\
    \"PutBucketTaggingRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Tagging\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The base64-encoded 128-bit MD5 digest of the data. You must use this header as a message integrity check to verify that the request body was not corrupted in transit. For more information, see <a href=\\\"http://www.ietf.org/rfc/rfc1864.txt\\\">RFC 1864</a>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"Tagging\":{\
          \"shape\":\"Tagging\",\
          \"documentation\":\"<p>Container for the <code>TagSet</code> and <code>Tag</code> elements.</p>\",\
          \"locationName\":\"Tagging\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"Tagging\"\
    },\
    \"PutBucketVersioningRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"VersioningConfiguration\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>&gt;The base64-encoded 128-bit MD5 digest of the data. You must use this header as a message integrity check to verify that the request body was not corrupted in transit. For more information, see <a href=\\\"http://www.ietf.org/rfc/rfc1864.txt\\\">RFC 1864</a>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"MFA\":{\
          \"shape\":\"MFA\",\
          \"documentation\":\"<p>The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-mfa\"\
        },\
        \"VersioningConfiguration\":{\
          \"shape\":\"VersioningConfiguration\",\
          \"documentation\":\"<p>Container for setting the versioning state.</p>\",\
          \"locationName\":\"VersioningConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"VersioningConfiguration\"\
    },\
    \"PutBucketWebsiteRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"WebsiteConfiguration\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The base64-encoded 128-bit MD5 digest of the data. You must use this header as a message integrity check to verify that the request body was not corrupted in transit. For more information, see <a href=\\\"http://www.ietf.org/rfc/rfc1864.txt\\\">RFC 1864</a>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"WebsiteConfiguration\":{\
          \"shape\":\"WebsiteConfiguration\",\
          \"documentation\":\"<p>Container for the request.</p>\",\
          \"locationName\":\"WebsiteConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"WebsiteConfiguration\"\
    },\
    \"PutObjectAclOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      }\
    },\
    \"PutObjectAclRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"ACL\":{\
          \"shape\":\"ObjectCannedACL\",\
          \"documentation\":\"<p>The canned ACL to apply to the object. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\\\">Canned ACL</a>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-acl\"\
        },\
        \"AccessControlPolicy\":{\
          \"shape\":\"AccessControlPolicy\",\
          \"documentation\":\"<p>Contains the elements that set the ACL permissions for an object per grantee.</p>\",\
          \"locationName\":\"AccessControlPolicy\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name that contains the object to which you want to attach the ACL. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The base64-encoded 128-bit MD5 digest of the data. This header must be used as a message integrity check to verify that the request body was not corrupted in transit. For more information, go to <a href=\\\"http://www.ietf.org/rfc/rfc1864.txt\\\">RFC 1864.&gt;</a> </p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"GrantFullControl\":{\
          \"shape\":\"GrantFullControl\",\
          \"documentation\":\"<p>Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-full-control\"\
        },\
        \"GrantRead\":{\
          \"shape\":\"GrantRead\",\
          \"documentation\":\"<p>Allows grantee to list the objects in the bucket.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-read\"\
        },\
        \"GrantReadACP\":{\
          \"shape\":\"GrantReadACP\",\
          \"documentation\":\"<p>Allows grantee to read the bucket ACL.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-read-acp\"\
        },\
        \"GrantWrite\":{\
          \"shape\":\"GrantWrite\",\
          \"documentation\":\"<p>Allows grantee to create, overwrite, and delete any object in the bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-write\"\
        },\
        \"GrantWriteACP\":{\
          \"shape\":\"GrantWriteACP\",\
          \"documentation\":\"<p>Allows grantee to write the ACL for the applicable bucket.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-write-acp\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Key for which the PUT operation was initiated.</p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>VersionId used to reference a specific version of the object.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"versionId\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"AccessControlPolicy\"\
    },\
    \"PutObjectLegalHoldOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      }\
    },\
    \"PutObjectLegalHoldRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name containing the object that you want to place a Legal Hold on. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The key name for the object that you want to place a Legal Hold on.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"LegalHold\":{\
          \"shape\":\"ObjectLockLegalHold\",\
          \"documentation\":\"<p>Container element for the Legal Hold configuration you want to apply to the specified object.</p>\",\
          \"locationName\":\"LegalHold\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>The version ID of the object that you want to place a Legal Hold on.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"versionId\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The MD5 hash for the request body.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"LegalHold\"\
    },\
    \"PutObjectLockConfigurationOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      }\
    },\
    \"PutObjectLockConfigurationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Bucket\"],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket whose Object Lock configuration you want to create or replace.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ObjectLockConfiguration\":{\
          \"shape\":\"ObjectLockConfiguration\",\
          \"documentation\":\"<p>The Object Lock configuration that you want to apply to the specified bucket.</p>\",\
          \"locationName\":\"ObjectLockConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"Token\":{\
          \"shape\":\"ObjectLockToken\",\
          \"documentation\":\"<p>A token to allow Object Lock to be enabled for an existing bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-bucket-object-lock-token\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The MD5 hash for the request body.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"ObjectLockConfiguration\"\
    },\
    \"PutObjectOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Expiration\":{\
          \"shape\":\"Expiration\",\
          \"documentation\":\"<p> If the expiration is configured for the object (see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html\\\">PutBucketLifecycleConfiguration</a>), the response includes this header. It includes the expiry-date and rule-id key-value pairs that provide information about object expiration. The value of the rule-id is URL encoded.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expiration\"\
        },\
        \"ETag\":{\
          \"shape\":\"ETag\",\
          \"documentation\":\"<p>Entity tag for the uploaded object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"ETag\"\
        },\
        \"ServerSideEncryption\":{\
          \"shape\":\"ServerSideEncryption\",\
          \"documentation\":\"<p>If you specified server-side encryption either with an AWS KMS customer master key (CMK) or Amazon S3-managed encryption key in your PUT request, the response includes this header. It confirms the encryption algorithm that Amazon S3 used to encrypt the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>Version of the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-version-id\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"SSEKMSKeyId\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>If <code>x-amz-server-side-encryption</code> is present and has the value of <code>aws:kms</code>, this header specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object. </p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\"\
        },\
        \"SSEKMSEncryptionContext\":{\
          \"shape\":\"SSEKMSEncryptionContext\",\
          \"documentation\":\"<p>If present, specifies the AWS KMS Encryption Context to use for object encryption. The value of this header is a base64-encoded UTF-8 string holding JSON with the encryption context key-value pairs.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-context\"\
        },\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      }\
    },\
    \"PutObjectRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"ACL\":{\
          \"shape\":\"ObjectCannedACL\",\
          \"documentation\":\"<p>The canned ACL to apply to the object. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL\\\">Canned ACL</a>.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-acl\"\
        },\
        \"Body\":{\
          \"shape\":\"Body\",\
          \"documentation\":\"<p>Object data.</p>\",\
          \"streaming\":true\
        },\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name to which the PUT operation was initiated. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"CacheControl\":{\
          \"shape\":\"CacheControl\",\
          \"documentation\":\"<p> Can be used to specify caching behavior along the request/reply chain. For more information, see <a href=\\\"http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9\\\">http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9</a>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Cache-Control\"\
        },\
        \"ContentDisposition\":{\
          \"shape\":\"ContentDisposition\",\
          \"documentation\":\"<p>Specifies presentational information for the object. For more information, see <a href=\\\"http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1\\\">http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1</a>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Disposition\"\
        },\
        \"ContentEncoding\":{\
          \"shape\":\"ContentEncoding\",\
          \"documentation\":\"<p>Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field. For more information, see <a href=\\\"http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11\\\">http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11</a>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Encoding\"\
        },\
        \"ContentLanguage\":{\
          \"shape\":\"ContentLanguage\",\
          \"documentation\":\"<p>The language the content is in.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Language\"\
        },\
        \"ContentLength\":{\
          \"shape\":\"ContentLength\",\
          \"documentation\":\"<p>Size of the body in bytes. This parameter is useful when the size of the body cannot be determined automatically. For more information, see <a href=\\\"http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.13\\\">http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.13</a>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Length\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The base64-encoded 128-bit MD5 digest of the message (without the headers) according to RFC 1864. This header can be used as a message integrity check to verify that the data is the same data that was originally sent. Although it is optional, we recommend using the Content-MD5 mechanism as an end-to-end integrity check. For more information about REST request authentication, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html\\\">REST Authentication</a>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"ContentType\":{\
          \"shape\":\"ContentType\",\
          \"documentation\":\"<p>A standard MIME type describing the format of the contents. For more information, see <a href=\\\"http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17\\\">http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17</a>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Type\"\
        },\
        \"Expires\":{\
          \"shape\":\"Expires\",\
          \"documentation\":\"<p>The date and time at which the object is no longer cacheable. For more information, see <a href=\\\"http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.21\\\">http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.21</a>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Expires\"\
        },\
        \"GrantFullControl\":{\
          \"shape\":\"GrantFullControl\",\
          \"documentation\":\"<p>Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-full-control\"\
        },\
        \"GrantRead\":{\
          \"shape\":\"GrantRead\",\
          \"documentation\":\"<p>Allows grantee to read the object data and its metadata.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-read\"\
        },\
        \"GrantReadACP\":{\
          \"shape\":\"GrantReadACP\",\
          \"documentation\":\"<p>Allows grantee to read the object ACL.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-read-acp\"\
        },\
        \"GrantWriteACP\":{\
          \"shape\":\"GrantWriteACP\",\
          \"documentation\":\"<p>Allows grantee to write the ACL for the applicable object.</p> <p>This action is not supported by Amazon S3 on Outposts.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-grant-write-acp\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Object key for which the PUT operation was initiated.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"Metadata\":{\
          \"shape\":\"Metadata\",\
          \"documentation\":\"<p>A map of metadata to store with the object in S3.</p>\",\
          \"location\":\"headers\",\
          \"locationName\":\"x-amz-meta-\"\
        },\
        \"ServerSideEncryption\":{\
          \"shape\":\"ServerSideEncryption\",\
          \"documentation\":\"<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption\"\
        },\
        \"StorageClass\":{\
          \"shape\":\"StorageClass\",\
          \"documentation\":\"<p>By default, Amazon S3 uses the STANDARD Storage Class to store newly created objects. The STANDARD storage class provides high durability and high availability. Depending on performance needs, you can specify a different Storage Class. Amazon S3 on Outposts only uses the OUTPOSTS Storage Class. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html\\\">Storage Classes</a> in the <i>Amazon S3 Service Developer Guide</i>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-storage-class\"\
        },\
        \"WebsiteRedirectLocation\":{\
          \"shape\":\"WebsiteRedirectLocation\",\
          \"documentation\":\"<p>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata. For information about object metadata, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingMetadata.html\\\">Object Key and Metadata</a>.</p> <p>In the following example, the request header sets the redirect to an object (anotherPage.html) in the same bucket:</p> <p> <code>x-amz-website-redirect-location: /anotherPage.html</code> </p> <p>In the following example, the request header sets the object redirect to another website:</p> <p> <code>x-amz-website-redirect-location: http://www.example.com/</code> </p> <p>For more information about website hosting in Amazon S3, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html\\\">Hosting Websites on Amazon S3</a> and <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/how-to-page-redirect.html\\\">How to Configure Website Page Redirects</a>. </p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-website-redirect-location\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>Specifies the algorithm to use to when encrypting the object (for example, AES256).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKey\":{\
          \"shape\":\"SSECustomerKey\",\
          \"documentation\":\"<p>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key. The key must be appropriate for use with the algorithm specified in the <code>x-amz-server-side-encryption-customer-algorithm</code> header.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"SSEKMSKeyId\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>If <code>x-amz-server-side-encryption</code> is present and has the value of <code>aws:kms</code>, this header specifies the ID of the AWS Key Management Service (AWS KMS) symmetrical customer managed customer master key (CMK) that was used for the object.</p> <p> If the value of <code>x-amz-server-side-encryption</code> is <code>aws:kms</code>, this header specifies the ID of the symmetric customer managed AWS KMS CMK that will be used for the object. If you specify <code>x-amz-server-side-encryption:aws:kms</code>, but do not provide<code> x-amz-server-side-encryption-aws-kms-key-id</code>, Amazon S3 uses the AWS managed CMK in AWS to protect the data.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\"\
        },\
        \"SSEKMSEncryptionContext\":{\
          \"shape\":\"SSEKMSEncryptionContext\",\
          \"documentation\":\"<p>Specifies the AWS KMS Encryption Context to use for object encryption. The value of this header is a base64-encoded UTF-8 string holding JSON with the encryption context key-value pairs.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-context\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"Tagging\":{\
          \"shape\":\"TaggingHeader\",\
          \"documentation\":\"<p>The tag-set for the object. The tag-set must be encoded as URL Query parameters. (For example, \\\"Key1=Value1\\\")</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-tagging\"\
        },\
        \"ObjectLockMode\":{\
          \"shape\":\"ObjectLockMode\",\
          \"documentation\":\"<p>The Object Lock mode that you want to apply to this object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-mode\"\
        },\
        \"ObjectLockRetainUntilDate\":{\
          \"shape\":\"ObjectLockRetainUntilDate\",\
          \"documentation\":\"<p>The date and time when you want this object's Object Lock to expire.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-retain-until-date\"\
        },\
        \"ObjectLockLegalHoldStatus\":{\
          \"shape\":\"ObjectLockLegalHoldStatus\",\
          \"documentation\":\"<p>Specifies whether a legal hold will be applied to this object. For more information about S3 Object Lock, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\\\">Object Lock</a>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-object-lock-legal-hold\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"Body\"\
    },\
    \"PutObjectRetentionOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      }\
    },\
    \"PutObjectRetentionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name that contains the object you want to apply this Object Retention configuration to. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The key name for the object that you want to apply this Object Retention configuration to.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"Retention\":{\
          \"shape\":\"ObjectLockRetention\",\
          \"documentation\":\"<p>The container element for the Object Retention configuration.</p>\",\
          \"locationName\":\"Retention\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>The version ID for the object that you want to apply this Object Retention configuration to.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"versionId\"\
        },\
        \"BypassGovernanceRetention\":{\
          \"shape\":\"BypassGovernanceRetention\",\
          \"documentation\":\"<p>Indicates whether this operation should bypass Governance-mode restrictions.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-bypass-governance-retention\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The MD5 hash for the request body.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"Retention\"\
    },\
    \"PutObjectTaggingOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>The versionId of the object the tag-set was added to.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-version-id\"\
        }\
      }\
    },\
    \"PutObjectTaggingRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\",\
        \"Tagging\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name containing the object. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Name of the object key.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>The versionId of the object that the tag-set will be added to.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"versionId\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The MD5 hash for the request body.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"Tagging\":{\
          \"shape\":\"Tagging\",\
          \"documentation\":\"<p>Container for the <code>TagSet</code> and <code>Tag</code> elements</p>\",\
          \"locationName\":\"Tagging\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"Tagging\"\
    },\
    \"PutPublicAccessBlockRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"PublicAccessBlockConfiguration\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the Amazon S3 bucket whose <code>PublicAccessBlock</code> configuration you want to set.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The MD5 hash of the <code>PutPublicAccessBlock</code> request body. </p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Content-MD5 header will now be automatically computed and injected in associated operation's Http request.\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"PublicAccessBlockConfiguration\":{\
          \"shape\":\"PublicAccessBlockConfiguration\",\
          \"documentation\":\"<p>The <code>PublicAccessBlock</code> configuration that you want to apply to this Amazon S3 bucket. You can enable the configuration options in any combination. For more information about when Amazon S3 considers a bucket or object public, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html#access-control-block-public-access-policy-status\\\">The Meaning of \\\"Public\\\"</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"locationName\":\"PublicAccessBlockConfiguration\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"PublicAccessBlockConfiguration\"\
    },\
    \"QueueArn\":{\"type\":\"string\"},\
    \"QueueConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"QueueArn\",\
        \"Events\"\
      ],\
      \"members\":{\
        \"Id\":{\"shape\":\"NotificationId\"},\
        \"QueueArn\":{\
          \"shape\":\"QueueArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the Amazon SQS queue to which Amazon S3 publishes a message when it detects events of the specified type.</p>\",\
          \"locationName\":\"Queue\"\
        },\
        \"Events\":{\
          \"shape\":\"EventList\",\
          \"documentation\":\"<p>A collection of bucket events for which to send notifications</p>\",\
          \"locationName\":\"Event\"\
        },\
        \"Filter\":{\"shape\":\"NotificationConfigurationFilter\"}\
      },\
      \"documentation\":\"<p>Specifies the configuration for publishing messages to an Amazon Simple Queue Service (Amazon SQS) queue when Amazon S3 detects specified events.</p>\"\
    },\
    \"QueueConfigurationDeprecated\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Id\":{\"shape\":\"NotificationId\"},\
        \"Event\":{\
          \"shape\":\"Event\",\
          \"deprecated\":true\
        },\
        \"Events\":{\
          \"shape\":\"EventList\",\
          \"documentation\":\"<p>A collection of bucket events for which to send notifications</p>\",\
          \"locationName\":\"Event\"\
        },\
        \"Queue\":{\
          \"shape\":\"QueueArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the Amazon SQS queue to which Amazon S3 publishes a message when it detects events of the specified type. </p>\"\
        }\
      },\
      \"documentation\":\"<p>This data type is deprecated. Use <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_QueueConfiguration.html\\\">QueueConfiguration</a> for the same purposes. This data type specifies the configuration for publishing messages to an Amazon Simple Queue Service (Amazon SQS) queue when Amazon S3 detects specified events. </p>\"\
    },\
    \"QueueConfigurationList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"QueueConfiguration\"},\
      \"flattened\":true\
    },\
    \"Quiet\":{\"type\":\"boolean\"},\
    \"QuoteCharacter\":{\"type\":\"string\"},\
    \"QuoteEscapeCharacter\":{\"type\":\"string\"},\
    \"QuoteFields\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ALWAYS\",\
        \"ASNEEDED\"\
      ]\
    },\
    \"Range\":{\"type\":\"string\"},\
    \"RecordDelimiter\":{\"type\":\"string\"},\
    \"RecordsEvent\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Payload\":{\
          \"shape\":\"Body\",\
          \"documentation\":\"<p>The byte array of partial, one or more result records.</p>\",\
          \"eventpayload\":true\
        }\
      },\
      \"documentation\":\"<p>The container for the records event.</p>\",\
      \"event\":true\
    },\
    \"Redirect\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"HostName\":{\
          \"shape\":\"HostName\",\
          \"documentation\":\"<p>The host name to use in the redirect request.</p>\"\
        },\
        \"HttpRedirectCode\":{\
          \"shape\":\"HttpRedirectCode\",\
          \"documentation\":\"<p>The HTTP redirect code to use on the response. Not required if one of the siblings is present.</p>\"\
        },\
        \"Protocol\":{\
          \"shape\":\"Protocol\",\
          \"documentation\":\"<p>Protocol to use when redirecting requests. The default is the protocol that is used in the original request.</p>\"\
        },\
        \"ReplaceKeyPrefixWith\":{\
          \"shape\":\"ReplaceKeyPrefixWith\",\
          \"documentation\":\"<p>The object key prefix to use in the redirect request. For example, to redirect requests for all pages with prefix <code>docs/</code> (objects in the <code>docs/</code> folder) to <code>documents/</code>, you can set a condition block with <code>KeyPrefixEquals</code> set to <code>docs/</code> and in the Redirect set <code>ReplaceKeyPrefixWith</code> to <code>/documents</code>. Not required if one of the siblings is present. Can be present only if <code>ReplaceKeyWith</code> is not provided.</p>\"\
        },\
        \"ReplaceKeyWith\":{\
          \"shape\":\"ReplaceKeyWith\",\
          \"documentation\":\"<p>The specific object key to use in the redirect request. For example, redirect request to <code>error.html</code>. Not required if one of the siblings is present. Can be present only if <code>ReplaceKeyPrefixWith</code> is not provided.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies how requests are redirected. In the event of an error, you can specify a different error code to return.</p>\"\
    },\
    \"RedirectAllRequestsTo\":{\
      \"type\":\"structure\",\
      \"required\":[\"HostName\"],\
      \"members\":{\
        \"HostName\":{\
          \"shape\":\"HostName\",\
          \"documentation\":\"<p>Name of the host where requests are redirected.</p>\"\
        },\
        \"Protocol\":{\
          \"shape\":\"Protocol\",\
          \"documentation\":\"<p>Protocol to use when redirecting requests. The default is the protocol that is used in the original request.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the redirect behavior of all requests to a website endpoint of an Amazon S3 bucket.</p>\"\
    },\
    \"ReplaceKeyPrefixWith\":{\"type\":\"string\"},\
    \"ReplaceKeyWith\":{\"type\":\"string\"},\
    \"ReplicaKmsKeyID\":{\"type\":\"string\"},\
    \"ReplicationConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Role\",\
        \"Rules\"\
      ],\
      \"members\":{\
        \"Role\":{\
          \"shape\":\"Role\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that Amazon S3 assumes when replicating objects. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-how-setup.html\\\">How to Set Up Replication</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
        },\
        \"Rules\":{\
          \"shape\":\"ReplicationRules\",\
          \"documentation\":\"<p>A container for one or more replication rules. A replication configuration must have at least one rule and can contain a maximum of 1,000 rules. </p>\",\
          \"locationName\":\"Rule\"\
        }\
      },\
      \"documentation\":\"<p>A container for replication rules. You can add up to 1,000 rules. The maximum size of a replication configuration is 2 MB.</p>\"\
    },\
    \"ReplicationRule\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Status\",\
        \"Destination\"\
      ],\
      \"members\":{\
        \"ID\":{\
          \"shape\":\"ID\",\
          \"documentation\":\"<p>A unique identifier for the rule. The maximum value is 255 characters.</p>\"\
        },\
        \"Priority\":{\
          \"shape\":\"Priority\",\
          \"documentation\":\"<p>The priority associated with the rule. If you specify multiple rules in a replication configuration, Amazon S3 prioritizes the rules to prevent conflicts when filtering. If two or more rules identify the same object based on a specified filter, the rule with higher priority takes precedence. For example:</p> <ul> <li> <p>Same object quality prefix-based filter criteria if prefixes you specified in multiple rules overlap </p> </li> <li> <p>Same object qualify tag-based filter criteria specified in multiple rules</p> </li> </ul> <p>For more information, see <a href=\\\" https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html\\\">Replication</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>An object key name prefix that identifies the object or objects to which the rule applies. The maximum prefix length is 1,024 characters. To include all objects in a bucket, specify an empty string. </p>\",\
          \"deprecated\":true\
        },\
        \"Filter\":{\"shape\":\"ReplicationRuleFilter\"},\
        \"Status\":{\
          \"shape\":\"ReplicationRuleStatus\",\
          \"documentation\":\"<p>Specifies whether the rule is enabled.</p>\"\
        },\
        \"SourceSelectionCriteria\":{\
          \"shape\":\"SourceSelectionCriteria\",\
          \"documentation\":\"<p>A container that describes additional filters for identifying the source objects that you want to replicate. You can choose to enable or disable the replication of these objects. Currently, Amazon S3 supports only the filter that you can specify for objects created with server-side encryption using a customer master key (CMK) stored in AWS Key Management Service (SSE-KMS).</p>\"\
        },\
        \"ExistingObjectReplication\":{\
          \"shape\":\"ExistingObjectReplication\",\
          \"documentation\":\"<p/>\"\
        },\
        \"Destination\":{\
          \"shape\":\"Destination\",\
          \"documentation\":\"<p>A container for information about the replication destination and its configurations including enabling the S3 Replication Time Control (S3 RTC).</p>\"\
        },\
        \"DeleteMarkerReplication\":{\"shape\":\"DeleteMarkerReplication\"}\
      },\
      \"documentation\":\"<p>Specifies which Amazon S3 objects to replicate and where to store the replicas.</p>\"\
    },\
    \"ReplicationRuleAndOperator\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>An object key name prefix that identifies the subset of objects to which the rule applies.</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagSet\",\
          \"documentation\":\"<p>An array of tags containing key and value pairs.</p>\",\
          \"flattened\":true,\
          \"locationName\":\"Tag\"\
        }\
      },\
      \"documentation\":\"<p>A container for specifying rule filters. The filters determine the subset of objects to which the rule applies. This element is required only if you specify more than one filter. </p> <p>For example:</p> <ul> <li> <p>If you specify both a <code>Prefix</code> and a <code>Tag</code> filter, wrap these filters in an <code>And</code> tag. </p> </li> <li> <p>If you specify a filter based on multiple tags, wrap the <code>Tag</code> elements in an <code>And</code> tag</p> </li> </ul>\"\
    },\
    \"ReplicationRuleFilter\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>An object key name prefix that identifies the subset of objects to which the rule applies.</p>\"\
        },\
        \"Tag\":{\
          \"shape\":\"Tag\",\
          \"documentation\":\"<p>A container for specifying a tag key and value. </p> <p>The rule applies only to objects that have the tag in their tag set.</p>\"\
        },\
        \"And\":{\
          \"shape\":\"ReplicationRuleAndOperator\",\
          \"documentation\":\"<p>A container for specifying rule filters. The filters determine the subset of objects to which the rule applies. This element is required only if you specify more than one filter. For example: </p> <ul> <li> <p>If you specify both a <code>Prefix</code> and a <code>Tag</code> filter, wrap these filters in an <code>And</code> tag.</p> </li> <li> <p>If you specify a filter based on multiple tags, wrap the <code>Tag</code> elements in an <code>And</code> tag.</p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>A filter that identifies the subset of objects to which the replication rule applies. A <code>Filter</code> must specify exactly one <code>Prefix</code>, <code>Tag</code>, or an <code>And</code> child element.</p>\"\
    },\
    \"ReplicationRuleStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Enabled\",\
        \"Disabled\"\
      ]\
    },\
    \"ReplicationRules\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ReplicationRule\"},\
      \"flattened\":true\
    },\
    \"ReplicationStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"COMPLETE\",\
        \"PENDING\",\
        \"FAILED\",\
        \"REPLICA\"\
      ]\
    },\
    \"ReplicationTime\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Status\",\
        \"Time\"\
      ],\
      \"members\":{\
        \"Status\":{\
          \"shape\":\"ReplicationTimeStatus\",\
          \"documentation\":\"<p> Specifies whether the replication time is enabled. </p>\"\
        },\
        \"Time\":{\
          \"shape\":\"ReplicationTimeValue\",\
          \"documentation\":\"<p> A container specifying the time by which replication should be complete for all objects and operations on objects. </p>\"\
        }\
      },\
      \"documentation\":\"<p> A container specifying S3 Replication Time Control (S3 RTC) related information, including whether S3 RTC is enabled and the time when all objects and operations on objects must be replicated. Must be specified together with a <code>Metrics</code> block. </p>\"\
    },\
    \"ReplicationTimeStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Enabled\",\
        \"Disabled\"\
      ]\
    },\
    \"ReplicationTimeValue\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Minutes\":{\
          \"shape\":\"Minutes\",\
          \"documentation\":\"<p> Contains an integer specifying time in minutes. </p> <p> Valid values: 15 minutes. </p>\"\
        }\
      },\
      \"documentation\":\"<p> A container specifying the time value for S3 Replication Time Control (S3 RTC) and replication metrics <code>EventThreshold</code>. </p>\"\
    },\
    \"RequestCharged\":{\
      \"type\":\"string\",\
      \"documentation\":\"<p>If present, indicates that the requester was successfully charged for the request.</p>\",\
      \"enum\":[\"requester\"]\
    },\
    \"RequestPayer\":{\
      \"type\":\"string\",\
      \"documentation\":\"<p>Confirms that the requester knows that they will be charged for the request. Bucket owners need not specify this parameter in their requests. For information about downloading objects from requester pays buckets, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ObjectsinRequesterPaysBuckets.html\\\">Downloading Objects in Requestor Pays Buckets</a> in the <i>Amazon S3 Developer Guide</i>.</p>\",\
      \"enum\":[\"requester\"]\
    },\
    \"RequestPaymentConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\"Payer\"],\
      \"members\":{\
        \"Payer\":{\
          \"shape\":\"Payer\",\
          \"documentation\":\"<p>Specifies who pays for the download and request fees.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for Payer.</p>\"\
    },\
    \"RequestProgress\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Enabled\":{\
          \"shape\":\"EnableRequestProgress\",\
          \"documentation\":\"<p>Specifies whether periodic QueryProgress frames should be sent. Valid values: TRUE, FALSE. Default value: FALSE.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for specifying if periodic <code>QueryProgress</code> messages should be sent.</p>\"\
    },\
    \"ResponseCacheControl\":{\"type\":\"string\"},\
    \"ResponseContentDisposition\":{\"type\":\"string\"},\
    \"ResponseContentEncoding\":{\"type\":\"string\"},\
    \"ResponseContentLanguage\":{\"type\":\"string\"},\
    \"ResponseContentType\":{\"type\":\"string\"},\
    \"ResponseExpires\":{\"type\":\"timestamp\"},\
    \"Restore\":{\"type\":\"string\"},\
    \"RestoreObjectOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        },\
        \"RestoreOutputPath\":{\
          \"shape\":\"RestoreOutputPath\",\
          \"documentation\":\"<p>Indicates the path in the provided S3 output location where Select results will be restored to.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-restore-output-path\"\
        }\
      }\
    },\
    \"RestoreObjectRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name or containing the object to restore. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Object key for which the operation was initiated.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"VersionId\":{\
          \"shape\":\"ObjectVersionId\",\
          \"documentation\":\"<p>VersionId used to reference a specific version of the object.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"versionId\"\
        },\
        \"RestoreRequest\":{\
          \"shape\":\"RestoreRequest\",\
          \"locationName\":\"RestoreRequest\",\
          \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"RestoreRequest\"\
    },\
    \"RestoreOutputPath\":{\"type\":\"string\"},\
    \"RestoreRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Days\":{\
          \"shape\":\"Days\",\
          \"documentation\":\"<p>Lifetime of the active copy in days. Do not use with restores that specify <code>OutputLocation</code>.</p>\"\
        },\
        \"GlacierJobParameters\":{\
          \"shape\":\"GlacierJobParameters\",\
          \"documentation\":\"<p>S3 Glacier related parameters pertaining to this job. Do not use with restores that specify <code>OutputLocation</code>.</p>\"\
        },\
        \"Type\":{\
          \"shape\":\"RestoreRequestType\",\
          \"documentation\":\"<p>Type of restore request.</p>\"\
        },\
        \"Tier\":{\
          \"shape\":\"Tier\",\
          \"documentation\":\"<p>S3 Glacier retrieval tier at which the restore will be processed.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"Description\",\
          \"documentation\":\"<p>The optional description for the job.</p>\"\
        },\
        \"SelectParameters\":{\
          \"shape\":\"SelectParameters\",\
          \"documentation\":\"<p>Describes the parameters for Select job types.</p>\"\
        },\
        \"OutputLocation\":{\
          \"shape\":\"OutputLocation\",\
          \"documentation\":\"<p>Describes the location where the restore job's output is stored.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for restore job parameters.</p>\"\
    },\
    \"RestoreRequestType\":{\
      \"type\":\"string\",\
      \"enum\":[\"SELECT\"]\
    },\
    \"Role\":{\"type\":\"string\"},\
    \"RoutingRule\":{\
      \"type\":\"structure\",\
      \"required\":[\"Redirect\"],\
      \"members\":{\
        \"Condition\":{\
          \"shape\":\"Condition\",\
          \"documentation\":\"<p>A container for describing a condition that must be met for the specified redirect to apply. For example, 1. If request is for pages in the <code>/docs</code> folder, redirect to the <code>/documents</code> folder. 2. If request results in HTTP error 4xx, redirect request to another host where you might process the error.</p>\"\
        },\
        \"Redirect\":{\
          \"shape\":\"Redirect\",\
          \"documentation\":\"<p>Container for redirect information. You can redirect requests to another host, to another page, or with another protocol. In the event of an error, you can specify a different error code to return.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the redirect behavior and when a redirect is applied. For more information about routing rules, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/how-to-page-redirect.html#advanced-conditional-redirects\\\">Configuring advanced conditional redirects</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
    },\
    \"RoutingRules\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"RoutingRule\",\
        \"locationName\":\"RoutingRule\"\
      }\
    },\
    \"Rule\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Prefix\",\
        \"Status\"\
      ],\
      \"members\":{\
        \"Expiration\":{\
          \"shape\":\"LifecycleExpiration\",\
          \"documentation\":\"<p>Specifies the expiration for the lifecycle of the object.</p>\"\
        },\
        \"ID\":{\
          \"shape\":\"ID\",\
          \"documentation\":\"<p>Unique identifier for the rule. The value can't be longer than 255 characters.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>Object key prefix that identifies one or more objects to which this rule applies.</p>\"\
        },\
        \"Status\":{\
          \"shape\":\"ExpirationStatus\",\
          \"documentation\":\"<p>If <code>Enabled</code>, the rule is currently being applied. If <code>Disabled</code>, the rule is not currently being applied.</p>\"\
        },\
        \"Transition\":{\
          \"shape\":\"Transition\",\
          \"documentation\":\"<p>Specifies when an object transitions to a specified storage class. For more information about Amazon S3 lifecycle configuration rules, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/lifecycle-transition-general-considerations.html\\\">Transitioning Objects Using Amazon S3 Lifecycle</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
        },\
        \"NoncurrentVersionTransition\":{\"shape\":\"NoncurrentVersionTransition\"},\
        \"NoncurrentVersionExpiration\":{\"shape\":\"NoncurrentVersionExpiration\"},\
        \"AbortIncompleteMultipartUpload\":{\"shape\":\"AbortIncompleteMultipartUpload\"}\
      },\
      \"documentation\":\"<p>Specifies lifecycle rules for an Amazon S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTlifecycle.html\\\">Put Bucket Lifecycle Configuration</a> in the <i>Amazon Simple Storage Service API Reference</i>. For examples, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html#API_PutBucketLifecycleConfiguration_Examples\\\">Put Bucket Lifecycle Configuration Examples</a> </p>\"\
    },\
    \"Rules\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Rule\"},\
      \"flattened\":true\
    },\
    \"S3KeyFilter\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"FilterRules\":{\
          \"shape\":\"FilterRuleList\",\
          \"locationName\":\"FilterRule\"\
        }\
      },\
      \"documentation\":\"<p>A container for object key name prefix and suffix filtering rules.</p>\"\
    },\
    \"S3Location\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"BucketName\",\
        \"Prefix\"\
      ],\
      \"members\":{\
        \"BucketName\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket where the restore results will be placed.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"LocationPrefix\",\
          \"documentation\":\"<p>The prefix that is prepended to the restore results for this request.</p>\"\
        },\
        \"Encryption\":{\"shape\":\"Encryption\"},\
        \"CannedACL\":{\
          \"shape\":\"ObjectCannedACL\",\
          \"documentation\":\"<p>The canned ACL to apply to the restore results.</p>\"\
        },\
        \"AccessControlList\":{\
          \"shape\":\"Grants\",\
          \"documentation\":\"<p>A list of grants that control access to the staged results.</p>\"\
        },\
        \"Tagging\":{\
          \"shape\":\"Tagging\",\
          \"documentation\":\"<p>The tag-set that is applied to the restore results.</p>\"\
        },\
        \"UserMetadata\":{\
          \"shape\":\"UserMetadata\",\
          \"documentation\":\"<p>A list of metadata to store with the restore results in S3.</p>\"\
        },\
        \"StorageClass\":{\
          \"shape\":\"StorageClass\",\
          \"documentation\":\"<p>The class of storage used to store the restore results.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes an Amazon S3 location that will receive the results of the restore request.</p>\"\
    },\
    \"SSECustomerAlgorithm\":{\"type\":\"string\"},\
    \"SSECustomerKey\":{\
      \"type\":\"string\",\
      \"sensitive\":true\
    },\
    \"SSECustomerKeyMD5\":{\"type\":\"string\"},\
    \"SSEKMS\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>Specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) to use for encrypting inventory reports.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the use of SSE-KMS to encrypt delivered inventory reports.</p>\",\
      \"locationName\":\"SSE-KMS\"\
    },\
    \"SSEKMSEncryptionContext\":{\
      \"type\":\"string\",\
      \"sensitive\":true\
    },\
    \"SSEKMSKeyId\":{\
      \"type\":\"string\",\
      \"sensitive\":true\
    },\
    \"SSES3\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>Specifies the use of SSE-S3 to encrypt delivered inventory reports.</p>\",\
      \"locationName\":\"SSE-S3\"\
    },\
    \"ScanRange\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Start\":{\
          \"shape\":\"Start\",\
          \"documentation\":\"<p>Specifies the start of the byte range. This parameter is optional. Valid values: non-negative integers. The default value is 0. If only start is supplied, it means scan from that point to the end of the file.For example; <code>&lt;scanrange&gt;&lt;start&gt;50&lt;/start&gt;&lt;/scanrange&gt;</code> means scan from byte 50 until the end of the file.</p>\"\
        },\
        \"End\":{\
          \"shape\":\"End\",\
          \"documentation\":\"<p>Specifies the end of the byte range. This parameter is optional. Valid values: non-negative integers. The default value is one less than the size of the object being queried. If only the End parameter is supplied, it is interpreted to mean scan the last N bytes of the file. For example, <code>&lt;scanrange&gt;&lt;end&gt;50&lt;/end&gt;&lt;/scanrange&gt;</code> means scan the last 50 bytes.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the byte range of the object to get the records from. A record is processed when its first byte is contained by the range. This parameter is optional, but when specified, it must not be empty. See RFC 2616, Section 14.35.1 about how to specify the start and end of the range.</p>\"\
    },\
    \"SelectObjectContentEventStream\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Records\":{\
          \"shape\":\"RecordsEvent\",\
          \"documentation\":\"<p>The Records Event.</p>\"\
        },\
        \"Stats\":{\
          \"shape\":\"StatsEvent\",\
          \"documentation\":\"<p>The Stats Event.</p>\"\
        },\
        \"Progress\":{\
          \"shape\":\"ProgressEvent\",\
          \"documentation\":\"<p>The Progress Event.</p>\"\
        },\
        \"Cont\":{\
          \"shape\":\"ContinuationEvent\",\
          \"documentation\":\"<p>The Continuation Event.</p>\"\
        },\
        \"End\":{\
          \"shape\":\"EndEvent\",\
          \"documentation\":\"<p>The End Event.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The container for selecting objects from a content event stream.</p>\",\
      \"eventstream\":true\
    },\
    \"SelectObjectContentOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Payload\":{\
          \"shape\":\"SelectObjectContentEventStream\",\
          \"documentation\":\"<p>The array of results.</p>\"\
        }\
      },\
      \"payload\":\"Payload\"\
    },\
    \"SelectObjectContentRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\",\
        \"Expression\",\
        \"ExpressionType\",\
        \"InputSerialization\",\
        \"OutputSerialization\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The S3 bucket.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>The object key.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>The SSE Algorithm used to encrypt the object. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html\\\">Server-Side Encryption (Using Customer-Provided Encryption Keys</a>. </p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKey\":{\
          \"shape\":\"SSECustomerKey\",\
          \"documentation\":\"<p>The SSE Customer Key. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html\\\">Server-Side Encryption (Using Customer-Provided Encryption Keys</a>. </p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>The SSE Customer Key MD5. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html\\\">Server-Side Encryption (Using Customer-Provided Encryption Keys</a>. </p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"Expression\":{\
          \"shape\":\"Expression\",\
          \"documentation\":\"<p>The expression that is used to query the object.</p>\"\
        },\
        \"ExpressionType\":{\
          \"shape\":\"ExpressionType\",\
          \"documentation\":\"<p>The type of the provided expression (for example, SQL).</p>\"\
        },\
        \"RequestProgress\":{\
          \"shape\":\"RequestProgress\",\
          \"documentation\":\"<p>Specifies if periodic request progress information should be enabled.</p>\"\
        },\
        \"InputSerialization\":{\
          \"shape\":\"InputSerialization\",\
          \"documentation\":\"<p>Describes the format of the data in the object that is being queried.</p>\"\
        },\
        \"OutputSerialization\":{\
          \"shape\":\"OutputSerialization\",\
          \"documentation\":\"<p>Describes the format of the data that you want Amazon S3 to return in response.</p>\"\
        },\
        \"ScanRange\":{\
          \"shape\":\"ScanRange\",\
          \"documentation\":\"<p>Specifies the byte range of the object to get the records from. A record is processed when its first byte is contained by the range. This parameter is optional, but when specified, it must not be empty. See RFC 2616, Section 14.35.1 about how to specify the start and end of the range.</p> <p> <code>ScanRange</code>may be used in the following ways:</p> <ul> <li> <p> <code>&lt;scanrange&gt;&lt;start&gt;50&lt;/start&gt;&lt;end&gt;100&lt;/end&gt;&lt;/scanrange&gt;</code> - process only the records starting between the bytes 50 and 100 (inclusive, counting from zero)</p> </li> <li> <p> <code>&lt;scanrange&gt;&lt;start&gt;50&lt;/start&gt;&lt;/scanrange&gt;</code> - process only the records starting after the byte 50</p> </li> <li> <p> <code>&lt;scanrange&gt;&lt;end&gt;50&lt;/end&gt;&lt;/scanrange&gt;</code> - process only the records within the last 50 bytes of the file.</p> </li> </ul>\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"documentation\":\"<p>Request to filter the contents of an Amazon S3 object based on a simple Structured Query Language (SQL) statement. In the request, along with the SQL expression, you must specify a data serialization format (JSON or CSV) of the object. Amazon S3 uses this to parse object data into records. It returns only records that match the specified SQL expression. You must also specify the data serialization format for the response. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html\\\">S3Select API Documentation</a>.</p>\"\
    },\
    \"SelectParameters\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"InputSerialization\",\
        \"ExpressionType\",\
        \"Expression\",\
        \"OutputSerialization\"\
      ],\
      \"members\":{\
        \"InputSerialization\":{\
          \"shape\":\"InputSerialization\",\
          \"documentation\":\"<p>Describes the serialization format of the object.</p>\"\
        },\
        \"ExpressionType\":{\
          \"shape\":\"ExpressionType\",\
          \"documentation\":\"<p>The type of the provided expression (for example, SQL).</p>\"\
        },\
        \"Expression\":{\
          \"shape\":\"Expression\",\
          \"documentation\":\"<p>The expression that is used to query the object.</p>\"\
        },\
        \"OutputSerialization\":{\
          \"shape\":\"OutputSerialization\",\
          \"documentation\":\"<p>Describes how the results of the Select job are serialized.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the parameters for Select job types.</p>\"\
    },\
    \"ServerSideEncryption\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"AES256\",\
        \"aws:kms\"\
      ]\
    },\
    \"ServerSideEncryptionByDefault\":{\
      \"type\":\"structure\",\
      \"required\":[\"SSEAlgorithm\"],\
      \"members\":{\
        \"SSEAlgorithm\":{\
          \"shape\":\"ServerSideEncryption\",\
          \"documentation\":\"<p>Server-side encryption algorithm to use for the default encryption.</p>\"\
        },\
        \"KMSMasterKeyID\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>AWS Key Management Service (KMS) customer master key ID to use for the default encryption. This parameter is allowed if and only if <code>SSEAlgorithm</code> is set to <code>aws:kms</code>.</p> <p>You can specify the key ID or the Amazon Resource Name (ARN) of the CMK. However, if you are using encryption with cross-account operations, you must use a fully qualified CMK ARN. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html#bucket-encryption-update-bucket-policy\\\">Using encryption for cross-account operations</a>. </p> <p> <b>For example:</b> </p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <important> <p>Amazon S3 only supports symmetric CMKs and not asymmetric CMKs. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\\\">Using Symmetric and Asymmetric Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> </important>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the default server-side encryption to apply to new objects in the bucket. If a PUT Object request doesn't specify any server-side encryption, this default encryption will be applied. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTencryption.html\\\">PUT Bucket encryption</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>\"\
    },\
    \"ServerSideEncryptionConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\"Rules\"],\
      \"members\":{\
        \"Rules\":{\
          \"shape\":\"ServerSideEncryptionRules\",\
          \"documentation\":\"<p>Container for information about a particular server-side encryption configuration rule.</p>\",\
          \"locationName\":\"Rule\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the default server-side-encryption configuration.</p>\"\
    },\
    \"ServerSideEncryptionRule\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ApplyServerSideEncryptionByDefault\":{\
          \"shape\":\"ServerSideEncryptionByDefault\",\
          \"documentation\":\"<p>Specifies the default server-side encryption to apply to new objects in the bucket. If a PUT Object request doesn't specify any server-side encryption, this default encryption will be applied.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the default server-side encryption configuration.</p>\"\
    },\
    \"ServerSideEncryptionRules\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ServerSideEncryptionRule\"},\
      \"flattened\":true\
    },\
    \"Setting\":{\"type\":\"boolean\"},\
    \"Size\":{\"type\":\"integer\"},\
    \"SourceSelectionCriteria\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"SseKmsEncryptedObjects\":{\
          \"shape\":\"SseKmsEncryptedObjects\",\
          \"documentation\":\"<p> A container for filter information for the selection of Amazon S3 objects encrypted with AWS KMS. If you include <code>SourceSelectionCriteria</code> in the replication configuration, this element is required. </p>\"\
        }\
      },\
      \"documentation\":\"<p>A container that describes additional filters for identifying the source objects that you want to replicate. You can choose to enable or disable the replication of these objects. Currently, Amazon S3 supports only the filter that you can specify for objects created with server-side encryption using a customer master key (CMK) stored in AWS Key Management Service (SSE-KMS).</p>\"\
    },\
    \"SseKmsEncryptedObjects\":{\
      \"type\":\"structure\",\
      \"required\":[\"Status\"],\
      \"members\":{\
        \"Status\":{\
          \"shape\":\"SseKmsEncryptedObjectsStatus\",\
          \"documentation\":\"<p>Specifies whether Amazon S3 replicates objects created with server-side encryption using a customer master key (CMK) stored in AWS Key Management Service.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A container for filter information for the selection of S3 objects encrypted with AWS KMS.</p>\"\
    },\
    \"SseKmsEncryptedObjectsStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Enabled\",\
        \"Disabled\"\
      ]\
    },\
    \"Start\":{\"type\":\"long\"},\
    \"StartAfter\":{\"type\":\"string\"},\
    \"Stats\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"BytesScanned\":{\
          \"shape\":\"BytesScanned\",\
          \"documentation\":\"<p>The total number of object bytes scanned.</p>\"\
        },\
        \"BytesProcessed\":{\
          \"shape\":\"BytesProcessed\",\
          \"documentation\":\"<p>The total number of uncompressed object bytes processed.</p>\"\
        },\
        \"BytesReturned\":{\
          \"shape\":\"BytesReturned\",\
          \"documentation\":\"<p>The total number of bytes of records payload data returned.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for the stats details.</p>\"\
    },\
    \"StatsEvent\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Details\":{\
          \"shape\":\"Stats\",\
          \"documentation\":\"<p>The Stats event details.</p>\",\
          \"eventpayload\":true\
        }\
      },\
      \"documentation\":\"<p>Container for the Stats Event.</p>\",\
      \"event\":true\
    },\
    \"StorageClass\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"STANDARD\",\
        \"REDUCED_REDUNDANCY\",\
        \"STANDARD_IA\",\
        \"ONEZONE_IA\",\
        \"INTELLIGENT_TIERING\",\
        \"GLACIER\",\
        \"DEEP_ARCHIVE\",\
        \"OUTPOSTS\"\
      ]\
    },\
    \"StorageClassAnalysis\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DataExport\":{\
          \"shape\":\"StorageClassAnalysisDataExport\",\
          \"documentation\":\"<p>Specifies how data related to the storage class analysis for an Amazon S3 bucket should be exported.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies data related to access patterns to be collected and made available to analyze the tradeoffs between different storage classes for an Amazon S3 bucket.</p>\"\
    },\
    \"StorageClassAnalysisDataExport\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"OutputSchemaVersion\",\
        \"Destination\"\
      ],\
      \"members\":{\
        \"OutputSchemaVersion\":{\
          \"shape\":\"StorageClassAnalysisSchemaVersion\",\
          \"documentation\":\"<p>The version of the output schema to use when exporting data. Must be <code>V_1</code>.</p>\"\
        },\
        \"Destination\":{\
          \"shape\":\"AnalyticsExportDestination\",\
          \"documentation\":\"<p>The place to store the data for an analysis.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for data related to the storage class analysis for an Amazon S3 bucket for export.</p>\"\
    },\
    \"StorageClassAnalysisSchemaVersion\":{\
      \"type\":\"string\",\
      \"enum\":[\"V_1\"]\
    },\
    \"Suffix\":{\"type\":\"string\"},\
    \"Tag\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Key\",\
        \"Value\"\
      ],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Name of the object key.</p>\"\
        },\
        \"Value\":{\
          \"shape\":\"Value\",\
          \"documentation\":\"<p>Value of the tag.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A container of a key value name pair.</p>\"\
    },\
    \"TagCount\":{\"type\":\"integer\"},\
    \"TagSet\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"Tag\",\
        \"locationName\":\"Tag\"\
      }\
    },\
    \"Tagging\":{\
      \"type\":\"structure\",\
      \"required\":[\"TagSet\"],\
      \"members\":{\
        \"TagSet\":{\
          \"shape\":\"TagSet\",\
          \"documentation\":\"<p>A collection for a set of tags</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for <code>TagSet</code> elements.</p>\"\
    },\
    \"TaggingDirective\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"COPY\",\
        \"REPLACE\"\
      ]\
    },\
    \"TaggingHeader\":{\"type\":\"string\"},\
    \"TargetBucket\":{\"type\":\"string\"},\
    \"TargetGrant\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Grantee\":{\
          \"shape\":\"Grantee\",\
          \"documentation\":\"<p>Container for the person being granted permissions.</p>\"\
        },\
        \"Permission\":{\
          \"shape\":\"BucketLogsPermission\",\
          \"documentation\":\"<p>Logging permissions assigned to the grantee for the bucket.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Container for granting information.</p>\"\
    },\
    \"TargetGrants\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"TargetGrant\",\
        \"locationName\":\"Grant\"\
      }\
    },\
    \"TargetPrefix\":{\"type\":\"string\"},\
    \"Tier\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Standard\",\
        \"Bulk\",\
        \"Expedited\"\
      ]\
    },\
    \"Token\":{\"type\":\"string\"},\
    \"TopicArn\":{\"type\":\"string\"},\
    \"TopicConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TopicArn\",\
        \"Events\"\
      ],\
      \"members\":{\
        \"Id\":{\"shape\":\"NotificationId\"},\
        \"TopicArn\":{\
          \"shape\":\"TopicArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the Amazon SNS topic to which Amazon S3 publishes a message when it detects events of the specified type.</p>\",\
          \"locationName\":\"Topic\"\
        },\
        \"Events\":{\
          \"shape\":\"EventList\",\
          \"documentation\":\"<p>The Amazon S3 bucket event about which to send notifications. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\\\">Supported Event Types</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"locationName\":\"Event\"\
        },\
        \"Filter\":{\"shape\":\"NotificationConfigurationFilter\"}\
      },\
      \"documentation\":\"<p>A container for specifying the configuration for publication of messages to an Amazon Simple Notification Service (Amazon SNS) topic when Amazon S3 detects specified events.</p>\"\
    },\
    \"TopicConfigurationDeprecated\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Id\":{\"shape\":\"NotificationId\"},\
        \"Events\":{\
          \"shape\":\"EventList\",\
          \"documentation\":\"<p>A collection of events related to objects</p>\",\
          \"locationName\":\"Event\"\
        },\
        \"Event\":{\
          \"shape\":\"Event\",\
          \"documentation\":\"<p>Bucket event for which to send notifications.</p>\",\
          \"deprecated\":true\
        },\
        \"Topic\":{\
          \"shape\":\"TopicArn\",\
          \"documentation\":\"<p>Amazon SNS topic to which Amazon S3 will publish a message to report the specified events for the bucket.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A container for specifying the configuration for publication of messages to an Amazon Simple Notification Service (Amazon SNS) topic when Amazon S3 detects specified events. This data type is deprecated. Use <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/API_TopicConfiguration.html\\\">TopicConfiguration</a> instead.</p>\"\
    },\
    \"TopicConfigurationList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"TopicConfiguration\"},\
      \"flattened\":true\
    },\
    \"Transition\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Date\":{\
          \"shape\":\"Date\",\
          \"documentation\":\"<p>Indicates when objects are transitioned to the specified storage class. The date value must be in ISO 8601 format. The time is always midnight UTC.</p>\"\
        },\
        \"Days\":{\
          \"shape\":\"Days\",\
          \"documentation\":\"<p>Indicates the number of days after creation when objects are transitioned to the specified storage class. The value must be a positive integer.</p>\"\
        },\
        \"StorageClass\":{\
          \"shape\":\"TransitionStorageClass\",\
          \"documentation\":\"<p>The storage class to which you want the object to transition.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies when an object transitions to a specified storage class. For more information about Amazon S3 lifecycle configuration rules, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/lifecycle-transition-general-considerations.html\\\">Transitioning Objects Using Amazon S3 Lifecycle</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\"\
    },\
    \"TransitionList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Transition\"},\
      \"flattened\":true\
    },\
    \"TransitionStorageClass\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"GLACIER\",\
        \"STANDARD_IA\",\
        \"ONEZONE_IA\",\
        \"INTELLIGENT_TIERING\",\
        \"DEEP_ARCHIVE\"\
      ]\
    },\
    \"Type\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"CanonicalUser\",\
        \"AmazonCustomerByEmail\",\
        \"Group\"\
      ]\
    },\
    \"URI\":{\"type\":\"string\"},\
    \"UploadIdMarker\":{\"type\":\"string\"},\
    \"UploadPartCopyOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CopySourceVersionId\":{\
          \"shape\":\"CopySourceVersionId\",\
          \"documentation\":\"<p>The version of the source object that was copied, if you have enabled versioning on the source bucket.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-version-id\"\
        },\
        \"CopyPartResult\":{\
          \"shape\":\"CopyPartResult\",\
          \"documentation\":\"<p>Container for all response elements.</p>\"\
        },\
        \"ServerSideEncryption\":{\
          \"shape\":\"ServerSideEncryption\",\
          \"documentation\":\"<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"SSEKMSKeyId\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\"\
        },\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      },\
      \"payload\":\"CopyPartResult\"\
    },\
    \"UploadPartCopyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"CopySource\",\
        \"Key\",\
        \"PartNumber\",\
        \"UploadId\"\
      ],\
      \"members\":{\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The bucket name.</p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"CopySource\":{\
          \"shape\":\"CopySource\",\
          \"documentation\":\"<p>Specifies the source object for the copy operation. You specify the value in one of two formats, depending on whether you want to access the source object through an <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-points.html\\\">access point</a>:</p> <ul> <li> <p>For objects not accessed through an access point, specify the name of the source bucket and key of the source object, separated by a slash (/). For example, to copy the object <code>reports/january.pdf</code> from the bucket <code>awsexamplebucket</code>, use <code>awsexamplebucket/reports/january.pdf</code>. The value must be URL encoded.</p> </li> <li> <p>For objects accessed through access points, specify the Amazon Resource Name (ARN) of the object as accessed through the access point, in the format <code>arn:aws:s3:&lt;Region&gt;:&lt;account-id&gt;:accesspoint/&lt;access-point-name&gt;/object/&lt;key&gt;</code>. For example, to copy the object <code>reports/january.pdf</code> through access point <code>my-access-point</code> owned by account <code>123456789012</code> in Region <code>us-west-2</code>, use the URL encoding of <code>arn:aws:s3:us-west-2:123456789012:accesspoint/my-access-point/object/reports/january.pdf</code>. The value must be URL encoded.</p> <note> <p>Amazon S3 supports copy operations using access points only when the source and destination buckets are in the same AWS Region.</p> </note> <p>Alternatively, for objects accessed through Amazon S3 on Outposts, specify the ARN of the object as accessed in the format <code>arn:aws:s3-outposts:&lt;Region&gt;:&lt;account-id&gt;:outpost/&lt;outpost-id&gt;/object/&lt;key&gt;</code>. For example, to copy the object <code>reports/january.pdf</code> through outpost <code>my-outpost</code> owned by account <code>123456789012</code> in Region <code>us-west-2</code>, use the URL encoding of <code>arn:aws:s3-outposts:us-west-2:123456789012:outpost/my-outpost/object/reports/january.pdf</code>. The value must be URL encoded. </p> </li> </ul> <p>To copy a specific version of an object, append <code>?versionId=&lt;version-id&gt;</code> to the value (for example, <code>awsexamplebucket/reports/january.pdf?versionId=QUpfdndhfd8438MNFDN93jdnJFkdmqnh893</code>). If you don't specify a version ID, Amazon S3 copies the latest version of the source object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source\"\
        },\
        \"CopySourceIfMatch\":{\
          \"shape\":\"CopySourceIfMatch\",\
          \"documentation\":\"<p>Copies the object if its entity tag (ETag) matches the specified tag.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-if-match\"\
        },\
        \"CopySourceIfModifiedSince\":{\
          \"shape\":\"CopySourceIfModifiedSince\",\
          \"documentation\":\"<p>Copies the object if it has been modified since the specified time.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-if-modified-since\"\
        },\
        \"CopySourceIfNoneMatch\":{\
          \"shape\":\"CopySourceIfNoneMatch\",\
          \"documentation\":\"<p>Copies the object if its entity tag (ETag) is different than the specified ETag.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-if-none-match\"\
        },\
        \"CopySourceIfUnmodifiedSince\":{\
          \"shape\":\"CopySourceIfUnmodifiedSince\",\
          \"documentation\":\"<p>Copies the object if it hasn't been modified since the specified time.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-if-unmodified-since\"\
        },\
        \"CopySourceRange\":{\
          \"shape\":\"CopySourceRange\",\
          \"documentation\":\"<p>The range of bytes to copy from the source object. The range value must use the form bytes=first-last, where the first and last are the zero-based byte offsets to copy. For example, bytes=0-9 indicates that you want to copy the first 10 bytes of the source. You can copy a range only if the source object is greater than 5 MB.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-range\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Object key for which the multipart upload was initiated.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"PartNumber\":{\
          \"shape\":\"PartNumber\",\
          \"documentation\":\"<p>Part number of part being copied. This is a positive integer between 1 and 10,000.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"partNumber\"\
        },\
        \"UploadId\":{\
          \"shape\":\"MultipartUploadId\",\
          \"documentation\":\"<p>Upload ID identifying the multipart upload whose part is being copied.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"uploadId\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>Specifies the algorithm to use to when encrypting the object (for example, AES256).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKey\":{\
          \"shape\":\"SSECustomerKey\",\
          \"documentation\":\"<p>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key. The key must be appropriate for use with the algorithm specified in the <code>x-amz-server-side-encryption-customer-algorithm</code> header. This must be the same encryption key specified in the initiate multipart upload request.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"CopySourceSSECustomerAlgorithm\":{\
          \"shape\":\"CopySourceSSECustomerAlgorithm\",\
          \"documentation\":\"<p>Specifies the algorithm to use when decrypting the source object (for example, AES256).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-server-side-encryption-customer-algorithm\"\
        },\
        \"CopySourceSSECustomerKey\":{\
          \"shape\":\"CopySourceSSECustomerKey\",\
          \"documentation\":\"<p>Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-server-side-encryption-customer-key\"\
        },\
        \"CopySourceSSECustomerKeyMD5\":{\
          \"shape\":\"CopySourceSSECustomerKeyMD5\",\
          \"documentation\":\"<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-copy-source-server-side-encryption-customer-key-MD5\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected destination bucket owner. If the destination bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        },\
        \"ExpectedSourceBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected source bucket owner. If the source bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-source-expected-bucket-owner\"\
        }\
      }\
    },\
    \"UploadPartOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ServerSideEncryption\":{\
          \"shape\":\"ServerSideEncryption\",\
          \"documentation\":\"<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption\"\
        },\
        \"ETag\":{\
          \"shape\":\"ETag\",\
          \"documentation\":\"<p>Entity tag for the uploaded object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"ETag\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"SSEKMSKeyId\":{\
          \"shape\":\"SSEKMSKeyId\",\
          \"documentation\":\"<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) was used for the object.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\"\
        },\
        \"RequestCharged\":{\
          \"shape\":\"RequestCharged\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-charged\"\
        }\
      }\
    },\
    \"UploadPartRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Bucket\",\
        \"Key\",\
        \"PartNumber\",\
        \"UploadId\"\
      ],\
      \"members\":{\
        \"Body\":{\
          \"shape\":\"Body\",\
          \"documentation\":\"<p>Object data.</p>\",\
          \"streaming\":true\
        },\
        \"Bucket\":{\
          \"shape\":\"BucketName\",\
          \"documentation\":\"<p>The name of the bucket to which the multipart upload was initiated.</p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation with an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\\\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p>When using this API with Amazon S3 on Outposts, you must direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.<i>outpostID</i>.s3-outposts.<i>Region</i>.amazonaws.com. When using this operation using S3 on Outposts through the AWS SDKs, you provide the Outposts bucket ARN in place of the bucket name. For more information about S3 on Outposts ARNs, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3onOutposts.html\\\">Using S3 on Outposts</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Bucket\"\
        },\
        \"ContentLength\":{\
          \"shape\":\"ContentLength\",\
          \"documentation\":\"<p>Size of the body in bytes. This parameter is useful when the size of the body cannot be determined automatically.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Length\"\
        },\
        \"ContentMD5\":{\
          \"shape\":\"ContentMD5\",\
          \"documentation\":\"<p>The base64-encoded 128-bit MD5 digest of the part data. This parameter is auto-populated when using the command from the CLI. This parameter is required if object lock parameters are specified.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-MD5\"\
        },\
        \"Key\":{\
          \"shape\":\"ObjectKey\",\
          \"documentation\":\"<p>Object key for which the multipart upload was initiated.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Key\"\
        },\
        \"PartNumber\":{\
          \"shape\":\"PartNumber\",\
          \"documentation\":\"<p>Part number of part being uploaded. This is a positive integer between 1 and 10,000.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"partNumber\"\
        },\
        \"UploadId\":{\
          \"shape\":\"MultipartUploadId\",\
          \"documentation\":\"<p>Upload ID identifying the multipart upload whose part is being uploaded.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"uploadId\"\
        },\
        \"SSECustomerAlgorithm\":{\
          \"shape\":\"SSECustomerAlgorithm\",\
          \"documentation\":\"<p>Specifies the algorithm to use to when encrypting the object (for example, AES256).</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\"\
        },\
        \"SSECustomerKey\":{\
          \"shape\":\"SSECustomerKey\",\
          \"documentation\":\"<p>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key. The key must be appropriate for use with the algorithm specified in the <code>x-amz-server-side-encryption-customer-algorithm header</code>. This must be the same encryption key specified in the initiate multipart upload request.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key\"\
        },\
        \"SSECustomerKeyMD5\":{\
          \"shape\":\"SSECustomerKeyMD5\",\
          \"documentation\":\"<p>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\"\
        },\
        \"RequestPayer\":{\
          \"shape\":\"RequestPayer\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-request-payer\"\
        },\
        \"ExpectedBucketOwner\":{\
          \"shape\":\"AccountId\",\
          \"documentation\":\"<p>The account id of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP <code>403 (Access Denied)</code> error.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-expected-bucket-owner\"\
        }\
      },\
      \"payload\":\"Body\"\
    },\
    \"UserMetadata\":{\
      \"type\":\"list\",\
      \"member\":{\
        \"shape\":\"MetadataEntry\",\
        \"locationName\":\"MetadataEntry\"\
      }\
    },\
    \"Value\":{\"type\":\"string\"},\
    \"VersionIdMarker\":{\"type\":\"string\"},\
    \"VersioningConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"MFADelete\":{\
          \"shape\":\"MFADelete\",\
          \"documentation\":\"<p>Specifies whether MFA delete is enabled in the bucket versioning configuration. This element is only returned if the bucket has been configured with MFA delete. If the bucket has never been so configured, this element is not returned.</p>\",\
          \"locationName\":\"MfaDelete\"\
        },\
        \"Status\":{\
          \"shape\":\"BucketVersioningStatus\",\
          \"documentation\":\"<p>The versioning state of the bucket.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the versioning state of an Amazon S3 bucket. For more information, see <a href=\\\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTVersioningStatus.html\\\">PUT Bucket versioning</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>\"\
    },\
    \"WebsiteConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ErrorDocument\":{\
          \"shape\":\"ErrorDocument\",\
          \"documentation\":\"<p>The name of the error document for the website.</p>\"\
        },\
        \"IndexDocument\":{\
          \"shape\":\"IndexDocument\",\
          \"documentation\":\"<p>The name of the index document for the website.</p>\"\
        },\
        \"RedirectAllRequestsTo\":{\
          \"shape\":\"RedirectAllRequestsTo\",\
          \"documentation\":\"<p>The redirect behavior for every request to this bucket's website endpoint.</p> <important> <p>If you specify this property, you can't specify any other property.</p> </important>\"\
        },\
        \"RoutingRules\":{\
          \"shape\":\"RoutingRules\",\
          \"documentation\":\"<p>Rules that define when a redirect is applied and the redirect behavior.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies website configuration parameters for an Amazon S3 bucket.</p>\"\
    },\
    \"WebsiteRedirectLocation\":{\"type\":\"string\"},\
    \"Years\":{\"type\":\"integer\"}\
  },\
  \"documentation\":\"<p/>\"\
}\
";
}

@end
