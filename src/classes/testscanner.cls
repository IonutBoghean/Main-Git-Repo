public with sharing class testscanner {
public transient string imagecode {get;set;}
public void submit()
{
Attachment test = new attachment();
test.name = 'test1.pdf';
test.body = EncodingUtil.base64Decode(imagecode);
test.parentid = '00124000008F5cm';
insert test;
}
}