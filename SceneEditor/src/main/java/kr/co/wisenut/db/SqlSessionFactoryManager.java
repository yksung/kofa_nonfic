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
			sqlSessionFactoryDev = builder.build(resourceDev, "development");
			sqlSessionFactoryProd0 = builder.build(resourceProd0, "production0");
			sqlSessionFactoryProd1 = builder.build(resourceProd1, "production1");

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
