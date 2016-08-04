package kr.co.wisenut.db;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionFactoryManager {
	private static final SqlSessionFactory sqlSessionFactory;

	static {
		try {
			String resourceName = "mybatis/configuration.xml";
			Reader resource = Resources.getResourceAsReader(resourceName);
			
			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
			sqlSessionFactory = builder.build(resource);

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	public SqlSessionFactoryManager() {
	}

	public static SqlSessionFactory getSqlMapper() {
		return sqlSessionFactory;
	}

}
