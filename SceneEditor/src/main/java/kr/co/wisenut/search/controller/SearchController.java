package kr.co.wisenut.search.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import kr.co.wisenut.search.model.ArkVO;
import kr.co.wisenut.util.StringUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * Handles requests for the application home page.
 */
@Controller
public class SearchController {
	
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	
	private static final String MANAGER_IP = "127.0.0.1";
	private static final String MANAGER_PORT = "7800";
	
	@RequestMapping(value = "/ark/event", method = RequestMethod.POST)
	public void getEventArk(@RequestParam String query, HttpServletResponse response) {
		
		int timeout = 1000;	// 1000분의 500초 : 0.5초이내에 응답이 없는 경우 연결 종료
		String convert = "fw";
		String target = "event";
		String charset = "UTF-8";
		String datatype = "json";
		//System.out.println("--> Query:" + query + "/ datatype:" + datatype);

		try {
			query = URLEncoder.encode(query, "UTF-8");
			String url = "http://" + MANAGER_IP + ":" + MANAGER_PORT + "/manager/WNRun.do";
			String param = "query=" + query + "&convert=" + convert + "&target=" + target + "&charset=" + charset + "&datatype=" + datatype;
			
			response.getWriter().print(getHtmls(url, param, timeout));
		} catch (UnsupportedEncodingException e) {
			logger.error(StringUtil.getStackTrace(e));
		} catch (IOException e) {
			logger.error(StringUtil.getStackTrace(e));
		}

	}
	
	public String getHtmls(String receiverURL, String parameter, int timeout) {
		StringBuffer receiveMsg = new StringBuffer();
		HttpURLConnection uc = null;
		int errorCode = 0;
		try {
			URL servletUrl = new URL(receiverURL);
			uc = (HttpURLConnection) servletUrl.openConnection();
			uc.setRequestProperty("Content-type", "application/x-www-form-urlencoded");
			uc.setRequestMethod("POST");
			uc.setDoOutput(true);
			uc.setDoInput(true);
			uc.setUseCaches(false);
			uc.setDefaultUseCaches(false);
			DataOutputStream dos = new DataOutputStream (uc.getOutputStream());
			dos.write(parameter.getBytes());
			dos.flush();
			dos.close();
			
			// -- Network error check
			//System.out.println("[URLConnection Response Code] " + uc.getResponseCode());
			if (uc.getResponseCode() == HttpURLConnection.HTTP_OK) {
				String currLine = "";
                // UTF-8. ..
                BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream(), "UTF-8"));
                while ((currLine = in.readLine()) != null) {
                	receiveMsg.append(currLine).append("\r\n");
                }
                in.close();
            } else {
                  errorCode = uc.getResponseCode();
                  return receiveMsg.toString();
             }
       } catch(Exception ex) {
    	   logger.error("[SearchController][getHtmls] errorCode : " + errorCode);
    	   logger.error(StringUtil.getStackTrace(ex));
       } finally {
            uc.disconnect();
       }

       //System.out.println(receiveMsg.toString());
       return receiveMsg.toString();
	}
}

