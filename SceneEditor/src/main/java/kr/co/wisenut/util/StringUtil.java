package kr.co.wisenut.util;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

public class StringUtil {
	public static String getStackTrace(Exception e){
		ByteArrayOutputStream out =   new ByteArrayOutputStream();
		PrintStream printStream  =   new PrintStream(out);
		e.printStackTrace(printStream);
		
		return out.toString();
	}
}
