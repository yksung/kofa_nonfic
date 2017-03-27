package kr.co.wisenut.db;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionFactoryManager {
	private static final SqlSessionFactory sqlSessionFactoryDev;
	private static final SqlSessionFactory sqlSessionFactoryProd0;
	private static final SqlSessionFactory sqlSessionFactoryProd1;

	static {
		try {
			String resourceName = "mybatis/configuration.xml";
			Reader resourceDev = Resources.getResourceAsReader(resourceName);
			Reader resourceProd0 = Resources.getResourceAsReader(resourceName);
			Reader resourceProd1 = Resources.getResourceAsReader(resourceName);
			
			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
			sqlSessionFactoryDev = builder.build(resourceDev, "development");		// 개발용 DB
			sqlSessionFactoryProd0 = builder.build(resourceProd0, "production0");	// 운영-일반 데이터 DB
			sqlSessionFactoryProd1 = builder.build(resourceProd1, "production1");	// 운영-로그인 정보 DB

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	public SqlSessionFactoryManager() {
	}

	public static SqlSessionFactory getSqlMapperDev() {
		return sqlSessionFactoryDev;
	}
	public static SqlSessionFactory getSqlMapperProd0() {
		return sqlSessionFactoryProd0;
	}
	public static SqlSessionFactory getSqlMapperProd1() {
		return sqlSessionFactoryProd1;
	}

}
