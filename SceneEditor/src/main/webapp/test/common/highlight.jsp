<%@ page language = "java" contentType="text/html; charset=utf-8" %><%@ page pageEncoding = "utf-8" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.sql.DataSource" %>

<%!
	public String replaceEntity(String msg) {
		msg = msg.replaceAll("&", "&amp;").replaceAll("\"", "&quot;").replaceAll("'", "&apos;").replaceAll("<", "&lt;")
				.replaceAll(">", "&gt;");
		return msg;
	}

	public String replaceHighLight(String text, String sHeader, String tHeader) {

		StringBuffer sb = new StringBuffer();

		String SEPARATOR = ":";
		String HS_TAG = "&lt;!HS:";
		String HE_TAG = "&lt;!HE";
		String END_TAG = "&gt;";

		String newText = "";

		int begin = 0;
		int beginHS = 0;
		int endHS = 0;
		int beginTYPE = 0;
		int beginDIST = 0;
		int beginBLOCK = 0;
		int beginHE = 0;
		int endHE = 0;

		while ((beginHS = text.indexOf(HS_TAG, begin)) >= 0) {
			beginTYPE = beginHS + HS_TAG.length();
			beginDIST = text.indexOf(SEPARATOR, beginTYPE) + 1;
			beginBLOCK = text.indexOf(SEPARATOR, beginDIST) + 1;
			endHS = text.indexOf(END_TAG, beginBLOCK);
			beginHE = text.indexOf(HE_TAG, endHS);
			endHE = text.indexOf(END_TAG, beginHE);

			String hType = text.substring(beginTYPE, beginDIST - 1);
			String hDist = text.substring(beginDIST, beginBLOCK - 1);
			String hBlock = text.substring(beginBLOCK, endHS);

			sb.append(text.substring(begin, beginHS));

			if (!hType.equals("CIT")) {
				// block
				String[] blocks = hBlock.split(",");

				if (sHeader != null || tHeader != null) {
					for (int i = 0; i < blocks.length; i++) {
						sb.append("<a class='no-uline' name=" + sHeader + blocks[i] + ">");
					}
					sb.append("<a class='no-uline' href='#" + tHeader + blocks[0] + "'>");
				}

				if (hType.equals("HIGH")) {
					sb.append("<span id='wn_high'>");
				} else if (hType.equals("LOW")) {
					sb.append("<span id='wn_low'>");
				}
				// inner text
				sb.append(text.substring(endHS + END_TAG.length(), beginHE));

				// end tag
				sb.append("</span>");
				
				if (sHeader != null || tHeader != null) {
					sb.append("</a></a>");
				}

			}else{
				if (hType.equals("CIT")) {
					sb.append("<span id='wn_cit'>");
				} else {
					sb.append("<span id='wn_highlight'>");
				}
				// inner text
				sb.append(text.substring(endHS + END_TAG.length(), beginHE));
				// end tag
				sb.append("</span>");
			}

			endHE += END_TAG.length();
			begin = endHE;
		}
		sb.append(text.substring(endHE));
		return sb.toString();
	}
	
	public String replaceHighlight(String text, boolean isHighlight)
	{
	    String SEPARATOR = ":";
	    String HS_TAG = "&lt;!HS:";
	    String HE_TAG = "&lt;!HE";
	    String END_TAG = "&gt;";
	    
	    String newText = "";
	    
	    int beginHS = 0;
	    int endHS = 0;
	    int beginTYPE = 0;
	    int beginDIST = 0;
	    int beginBLOCK = 0;
	    int beginRANGE = 0;
	    int beginHE = 0;
	    int endHE = 0;
	    
	    int count = 0;
	    
	    while( (beginHS = text.indexOf(HS_TAG)) >= 0 )
	    {
	        beginTYPE  = beginHS + HS_TAG.length();
	        beginDIST  = text.indexOf(SEPARATOR, beginTYPE) + 1;
	        beginBLOCK = text.indexOf(SEPARATOR, beginDIST) + 1;
	        endHS      = text.indexOf(END_TAG, beginBLOCK);
	        beginHE    = text.indexOf(HE_TAG, endHS);
	        endHE      = text.indexOf(END_TAG, beginHE);
	        
	        String hType  = text.substring(beginTYPE, beginDIST-1);
	        String hDist  = text.substring(beginDIST, beginBLOCK-1);
	        String hBlock = text.substring(beginBLOCK, endHS);
	        
	        newText = text.substring(0, beginHS);
	        
	        if( isHighlight == false )
	        {
	            newText += "<font style=\"font-style: italic; background-color: #33CCFF;\">";
	            if( hType.equals("") ==  false )
	            {
	                newText += "[타입:"+hType+"]";
	            }
	            if( hDist.equals("") == false )
	            {
	                newText += "[분포도:"+hDist+"]";
	            }
	            if( hBlock.equals("") == false )
	            {
	                newText += "[블럭정보:"+hBlock+"]";
	            }
	            newText += "</font>";
	        }
	        
	        if( isHighlight == true )
	        {
	            if( hType.equals("HIGH") == true )
	            {
	                newText += "<font style=\"font-weight: bold; background-color: #FF6666;\">";
	            }
	            else if( hType.equals("LOW") == true )
	            {
	                newText += "<font style=\"font-weight: bold; background-color: #ffcc00;\">";
	            }
	            else if( hType.equals("CIT") == true )
	            {
	                newText += "<font style=\"font-weight: bold; background-color: #66CC66;\">";
	            }
	            else
	            {
	                newText += "<font style=\"font-weight: bold; background-color: #FFFF33;\">";
	            }
	        }
	        
	        newText += text.substring(endHS + END_TAG.length(), beginHE);
	        
	        if( isHighlight == true )
	        {
	            newText += "</font>";
	        }
	        
	        newText += text.substring(endHE + END_TAG.length());
	        
	        text = newText;
	    }
	    
	    return text;
	}
%>