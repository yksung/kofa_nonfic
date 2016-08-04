package kr.co.wisenut.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class JdbcVO {
	public static String driver;
	public static String vendor;
	public static String username;
	public static String password;
	public static String url;
	
	public static void readJDBCProperties(String propFile) {
		Properties prop = new Properties();
		ClassLoader loader = null;           
		InputStream stream = null;
		
		try
		{			
			loader = Thread.currentThread().getContextClassLoader();           
			stream = loader.getResourceAsStream(propFile);
			
		    //load a properties file from class path, inside static method
		    prop.load(stream);

		    //get the property value and print it out
		    driver = prop.getProperty("jdbc.driver");
		    url = prop.getProperty("jdbc.url");
		    username = prop.getProperty("jdbc.username");
		    password = prop.getProperty("jdbc.password");
		    vendor = prop.getProperty("jdbc.vendor");
		} 
		catch (IOException ex)
		{
			System.out.println("[JdbcVO>readJDBCProperties]" + ex.getMessage());
		}
	}
}
