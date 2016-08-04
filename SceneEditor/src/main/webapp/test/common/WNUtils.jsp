<%@ page language = "java" contentType="text/html; charset=utf-8" %><%@ page pageEncoding = "utf-8" %><%@ page import = "java.lang.*,RefAPI210.*,java.text.DecimalFormat,java.text.FieldPosition,java.io.UnsupportedEncodingException,java.text.*,java.util.*" %><%!
/**
 *  file: WNUtils.jsp
 *  subject: 검색 구현에 필요한 일반 메소드를 구현한다.
 *  ------------------------------------------------------------------------
 *  @original author: KoreaWISEnut
 *  @edit author: KoreaWISEnut
 *  @update date 2006.12.03
 *  ------------------------------------------------------------------------
 */
 /**
	 * 검색 결과 페이징 번호를 출력한다. 
	 * @param startCount 검색 결과 시작 offset
	 * @param totalCount 검색 결과의 총 개수
	 * @param viewListCount 검색결과로 요청된 offset의 개수
	 * @param bundleCount 페이지 이동할 개수
	 * @return 페이징 문자열 반환
	 */
	
    /*
    *	문자셋 관련 설정
    */
    final static String ENCODE_ORI = "EUC-KR";
    final static String ENCODE_NEW = "UTF-8";

	/**
     * 문자 배열 값을 검색하여 키 값을 리턴
     * @param fieldName
     * @param value
     * @param operation
     * @return
     */
    private int findArrayValue(String find, String[] arr) {
        int findKey = -1;
        for (int i = 0; i < arr.length; i++) {
            if (find.equals(arr[i])){
                findKey = i;
                break;
            }
        }
        return findKey;
    }

    /**
     *
     * @param s
     * @param findStr
     * @param replaceStr
     * @return
     */
    public static String replace(String s, String findStr, String replaceStr){
        int   pos;
        int   index = 0;

        while ((pos = s.indexOf(findStr, index)) >= 0) {
            s = s.substring(0, pos) + replaceStr + s.substring(pos + findStr.length());
            index = pos + replaceStr.length();
        }

        return s;
    }

    /**
     *
     * @param s
     * @return
     */
    public static String trimDuplecateSpace(String s){
        StringBuffer sb = new StringBuffer();
        for(int i=0; i<s.length(); i++){
            char c = s.charAt(i);
            if(i < s.length()-1) {
                if( c == ' ' && s.charAt(i+1)==' '){
                    continue;
                }
            }
            sb.append(c);
        }
        return sb.toString().trim();
    }
/*
    public static String parseDate(String input, String inFormat, String outFormat) {
        String retStr = "";
        Date date = null;
        SimpleDateFormat formatter = null;
        try {
            date = (new SimpleDateFormat(inFormat)).parse(input.trim());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        formatter = new SimpleDateFormat(outFormat);
        retStr = formatter.format(date);
        return retStr;
    }

    public static String getCurrentDate() {
        java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat
                ("yyyy/MM/dd", java.util.Locale.KOREA);
        return dateFormat.format(new java.util.Date());
    }
*/
    /**
     *
     * @param strNum
     * @param def
     * @return
     */
    public static int parseInt(String strNum, int def){
        if(strNum == null) return def;
        try{
            return Integer.parseInt(strNum);
        }catch(Exception e){
            return def;
        }
    }

	/**
	*
	* @param strNum
	* @param def
	* @return
	*/
	public static Float parseFloat(String strNum, float def){
	   if(strNum == null) return def;
	   try{
	       return Float.parseFloat(strNum);
	   }catch(Exception e){
	       return def;
	   }
	}


    /**
     * String의 값이 null일 경우 ""로 변환하여 리턴한다.
     * @param temp
     * @return
     */
    public static String checkNull(String temp) {
        if (temp != null) {
            temp = temp.trim();
        } else {
            temp = "";
        }
        return temp;
    }

    /**
     * 1차원 배열의 값중 null인 값을 ""로 변환하여 리턴한다.
     * @param temp
     * @return
     */
    public static String[] checkNull(String[] temp){
        for(int i=0; i<temp.length; i++) {
            temp[i] = checkNull(temp[i]);
        }
        return temp;
    }

    /**
     * 2차원 배열의 값중 null인 값을 ""로 변환하여 리턴한다.
     * @param temp
     * @return
     */
    public static String[][] checkNull(String[][] temp) {
        for(int i=0; i<temp.length; i++) {
            temp[i][0] = checkNull(temp[i][0]);
            temp[i][1] = checkNull(temp[i][1]);
        }
        return temp;
    }

    /**
     * 스트링을 format 에 맞게 변환을 한다.
     * convertFormat("1", "00") return "01" 로 입력 값을 리턴한다.
     * @param inputStr
     * @param format
     * @return String
     */
    public static String convertFormat(String inputStr, String format){
        int _input = Integer.parseInt(inputStr);
        StringBuffer result = new StringBuffer();
        DecimalFormat df = new DecimalFormat(format);
        df.format( _input, result, new FieldPosition(1) );
        return result.toString();
    }

    /**
     *
     * @param str
     * @param outFormat
     * @return
     */
    public static String numberFormat(float num, String outFormat) {
        return new DecimalFormat(outFormat).format(num);
    }

    /**
     *
     * @param str
     * @param oriEncode
     * @param newEncode
     * @return
     */
    public static String encoding(String str, String oriEncode, String newEncode) {
        str = checkNull(str);
        if(str.length() > 0) {
            try {
                str = new String(str.getBytes(oriEncode), newEncode);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return str;
    }


    /**
     * 구분자를 가지고 있는 문자열을 구분자를 기준으로 나누어주는 메소드
     * @param splittee 구분자를 가진 문자열
     * @param splitChar 구분자
     * @return
     */
    public static String[] split(String splittee, String splitChar){
        String taRetVal[] = null;
        StringTokenizer toTokenizer = null;
        int tnTokenCnt = 0;

        try {
            toTokenizer = new StringTokenizer(splittee, splitChar);
            tnTokenCnt = toTokenizer.countTokens();
            taRetVal = new String[tnTokenCnt];

            for(int i=0; i<tnTokenCnt; i++) {
                if(toTokenizer.hasMoreTokens())	taRetVal[i] = toTokenizer.nextToken();
            }
        } catch (Exception e) {
            taRetVal = new String[0];
        }
        return taRetVal ;
    }

    /**
     * String 을 받아 UTF-8 범위내 문자가 이닌경우 공백(0x0020) 으로 치환
     * @param str
     * @return String
     */
    public static String validate(String str) {
        StringBuffer buf = new StringBuffer();

        char ch;
        for(int i=0; i < str.length(); i++) {
            ch = str.charAt(i);
            if(Character.isLetterOrDigit(ch)) {
            } else {
                if(Character.isWhitespace(ch)) {
                } else {
                    if(Character.isISOControl(ch)) {
                        // UTF-8 에서 지원하지 않는 문자 제거
                        ch = (char)0x0020;
                    }
                }
            }

            buf.append(ch);
        }

        return buf.toString();
    }

    /**
     * request XSS 처리
     **/
    public String getCheckReqXSS(javax.servlet.http.HttpServletRequest req, String parameter, String default_value) {
        String req_value = (req.getParameter(parameter) == null ||  req.getParameter(parameter).equals("")) ? default_value : req.getParameter(parameter);
        req_value = req_value.replaceAll("</?[a-zA-Z][0-9a-zA-Z가-\uD7A3ㄱ-ㅎ=/\"\'%;:,._()\\-# ]+>","");
        req_value = req_value.replaceAll(">","");
        req_value = req_value.replaceAll(">","");
        return req_value;
    }
    /**
     * request null체크
     **/
    public String getCheckReq(javax.servlet.http.HttpServletRequest req, String parameter, String default_value) {
        String req_value = (req.getParameter(parameter) == null ||  req.getParameter(parameter).equals("")) ? default_value : req.getParameter(parameter);
        return req_value;
    }

    /**
     * request Array null체크
     **/
    public String[] getCheckReqs(javax.servlet.http.HttpServletRequest req, String parameter, String[] default_value) {
        String[] req_value = req.getParameterValues(parameter);
        String[] tmp = null;
        int c = 0;
        if(req_value!=null) {
            tmp = new String[req_value.length];
            for(int i=0; i<req_value.length; i++) {
                tmp[c] = req_value[i];
                c++;
            }
        }
        req_value = req.getParameterValues(parameter)!=null ? tmp : default_value;
        return req_value;
    }

	public String replaceURL(String base, String url, String param, String value) {

		String sURL = "";
		if ( url != null && !url.equals("")) {
			if ( url.indexOf(param) < 0 )
				url = url + "&" + param + "=" + value;

			String [] params = url.split("&");
			for ( int idx=0; idx < params.length; idx++ ) {
				if ( params[idx].indexOf(param) >= 0 ) {
					params[idx] = param + "=" + value;
				}

				sURL = sURL + params[idx] ;

				if ( idx + 1 < params.length)
					sURL = sURL + "&" ;

			}

		} else {
				sURL = param + "=" + value;
		}

		sURL = base + "?" + sURL;


		return sURL;

	}

    /**
     * null체크
     **/
    public String nvl(String parameter, String default_value) {
        String req_value = parameter !=null ? parameter:default_value;
        return req_value;
    }

    /**
     * request null체크, uncoding
     **/
    public String getCheckReqUnocode(javax.servlet.http.HttpServletRequest req, String parameter, String default_value) {
        String req_value = req.getParameter(parameter)!=null ? encoding(req.getParameter(parameter), ENCODE_ORI, ENCODE_NEW):default_value;
        return req_value;
    }

    /**
     * request Array null체크, uncoding
     **/
    public String[] getCheckReqsUnocode(javax.servlet.http.HttpServletRequest req, String parameter, String[] default_value) {
        String[] req_value = req.getParameterValues(parameter);
        String[] tmp = null;
        int c = 0;
        if(req_value!=null) {
            tmp = new String[req_value.length];
            for(int i=0; i<req_value.length; i++) {
                tmp[c] = encoding(req_value[i], ENCODE_ORI, ENCODE_NEW);
                c++;
            }
        }
        req_value = req.getParameterValues(parameter)!=null ? tmp : default_value;
        return req_value;
    }
    /**
     * json 데이타 제외 특수문자
     **/
    public String getJSonFilter(String data) {
        if(!data.equals("") && data != null){
			//data = data.replaceAll(">"," ");
			//data = data.replaceAll("<"," ");
			//data = data.replaceAll("&"," ");
			data = data.replaceAll("\r"," ");
			data = data.replaceAll("\t"," ");
			data = data.replaceAll("\n"," ");
			data = data.replaceAll("\""," ");
			data = data.replaceAll(","," ");
			data = data.replaceAll("\\\\"," ");
		}
        return data;
    }

	public String getKeywordReplace(String keyword){

      String spchar = "\\\t!;?'\\=\"";
      StringTokenizer st = new StringTokenizer(keyword, spchar);
      String vUreplaceKeyWord = "";
      while (st.hasMoreTokens()) {
    	  vUreplaceKeyWord += st.nextToken() + " ";
      }
      return vUreplaceKeyWord ;
	}
%>