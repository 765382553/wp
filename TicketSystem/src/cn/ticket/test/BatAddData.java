package cn.ticket.test;

import java.io.IOException;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

public class BatAddData {

	public static void main(String[] args) throws HttpException, IOException {
		
       HttpClient client = new HttpClient();
       String url = "http://127.0.0.1:8080/TicketSystem/order/createOrder";
       PostMethod post = new PostMethod(url);
       NameValuePair[] data = {new NameValuePair("trainsNum","K889"),
    		   new NameValuePair("seatNum","3"),new NameValuePair("totalPrice","60.0"),
    		   new NameValuePair("customId","320830"),new NameValuePair("customName","zz"),
    		   new NameValuePair("account","test"),new NameValuePair("departPlace","南京"),
    		   new NameValuePair("destination","盐城"),new NameValuePair("date","2016-11-15"),
    		   new NameValuePair("departTime","13:40"),new NameValuePair("ticketBarrier","7")};
       client.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "UTF-8");
       post.setRequestBody(data);
       for(int i=0;i<100;i++){
    	   
    	   client.executeMethod(post);
    	   
       }
	}
}
