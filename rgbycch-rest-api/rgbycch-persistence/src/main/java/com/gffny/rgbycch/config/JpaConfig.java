package edu.harvard.huit.ace.config;

import java.lang.reflect.InvocationTargetException;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.lang.ClassUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.reflect.ConstructorUtils;
import org.hibernate.dialect.Dialect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.PropertyAccessorFactory;
import org.springframework.beans.PropertyValue;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Conditional;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.datasource.LazyConnectionDataSourceProxy;
import org.springframework.jdbc.datasource.TransactionAwareDataSourceProxy;
import org.springframework.jdbc.datasource.lookup.JndiDataSourceLookup;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.TransactionManagementConfigurer;

import edu.harvard.huit.ace.exception.DataServiceException;
import edu.harvard.huit.ace.exception.EncryptionException;
import edu.harvard.huit.ace.hibernate.HibernateEntityListenersAdapter;
import edu.harvard.huit.ace.util.StringEncrypter;

/**
 * 
 * @author John D. Gaffney | Isobar US
 *
 */
@Configuration
@EnableTransactionManagement(proxyTargetClass = true)
@ComponentScan(basePackages = "edu.harvard.huit.ace.repository", includeFilters = @Filter({ Repository.class }))
@Conditional(value = { AcePersistenceUnitCondition.class })
@EnableJpaRepositories(basePackages = "edu.harvard.huit.ace.repository")
public class JpaConfig implements TransactionManagementConfigurer {

	/** */
	private static final Logger LOG = LoggerFactory.getLogger(JpaConfig.class);

	@Value("${dataSource.jndiName:}")
	private String jndiName;
	@Value("${dataSource.driverClassName}")
	private String driver;
	@Value("${dataSource.url}")
	private String url;
	@Value("${dataSource.username}")
	private String username;
	@Value("${dataSource.password.encrypted}")
	private String encryptedPassword;
	@Value("${hibernate.dialect}")
	private String dialect;
	@Value("${hibernate.hbm2ddl.auto}")
	private String hbm2ddlAuto;
	@Value("${hibernate.format_sql:true}")
	private String formatSql;
	@Value("${instance}")
	private String instance;

	@Bean
	protected DataSource internalDataSource() {
		DataSource dataSource;

		if (StringUtils.isEmpty(jndiName)) {
			if (StringUtils.isEmpty(driver)) {
				throw new IllegalArgumentException(
						"When not using jdni, driverClassName must be specified");
			}
			if (StringUtils.isEmpty(url)) {
				throw new IllegalArgumentException(
						"When not using jdni, url must be specified");
			}

			String password;
			try {
				password = (new StringEncrypter("AES"))
						.decrypt(encryptedPassword);
			} catch (EncryptionException ex) {
				throw new RuntimeException(ex);
			}
			boolean tomcatJdbcPoolAvailable;
			try {
				ClassUtils.getClass("org.apache.tomcat.jdbc.pool.DataSource");
				ClassUtils
						.getClass("org.apache.tomcat.jdbc.pool.PoolProperties");
				tomcatJdbcPoolAvailable = true;
			} catch (ClassNotFoundException e) {
				LOG.info("org.apache.tomcat.jdbc.pool.DataSource or org.apache.tomcat.jdbc.pool.PoolProperties not found");
				tomcatJdbcPoolAvailable = false;
			}
			if (tomcatJdbcPoolAvailable) {

				LOG.info("tomcat jdbc pool is available");
				Object poolProperties;
				try {
					poolProperties = ConstructorUtils
							.invokeConstructor(
									Class.forName("org.apache.tomcat.jdbc.pool.PoolProperties"),
									null);

					BeanWrapper poolPropertiesBeanWrapper = PropertyAccessorFactory
							.forBeanPropertyAccess(poolProperties);
					poolPropertiesBeanWrapper
							.setPropertyValue(new PropertyValue("url", url));
					poolPropertiesBeanWrapper
							.setPropertyValue(new PropertyValue("Username",
									username));
					poolPropertiesBeanWrapper
							.setPropertyValue(new PropertyValue("password",
									password));
					poolPropertiesBeanWrapper
							.setPropertyValue(new PropertyValue(
									"driverClassName", driver));

					Object ds = ConstructorUtils.invokeConstructor(Class
							.forName("org.apache.tomcat.jdbc.pool.DataSource"),
							null);
					BeanWrapper dsBeanWrapper = PropertyAccessorFactory
							.forBeanPropertyAccess(ds);
					dsBeanWrapper.setPropertyValue(new PropertyValue(
							"poolProperties", poolProperties));
					dataSource = (DataSource) ds;
				} catch (NoSuchMethodException | IllegalAccessException
						| InvocationTargetException | InstantiationException
						| ClassNotFoundException e) {
					throw new RuntimeException(e);
				}
			} else {
				LOG.info("tomcat jdbc pool is not available");
				boolean boneCpConnectionPoolAvailable;
				try {
					ClassUtils.getClass("com.jolbox.bonecp.BoneCPDataSource");
					boneCpConnectionPoolAvailable = true;
				} catch (ClassNotFoundException e) {
					LOG.error(
							"Class com.jolbox.bonecp.BoneCPDataSource not found {}",
							e.getMessage());
					boneCpConnectionPoolAvailable = false;
				}
				if (boneCpConnectionPoolAvailable) {

					LOG.info("bone cp connection is available");
					try {
						dataSource = (DataSource) ConstructorUtils
								.invokeConstructor(
										Class.forName("com.jolbox.bonecp.BoneCPDataSource"),
										null);
						BeanWrapper poolPropertiesBeanWrapper = PropertyAccessorFactory
								.forBeanPropertyAccess(dataSource);
						poolPropertiesBeanWrapper
								.setPropertyValue(new PropertyValue("jdbcUrl",
										url));
						poolPropertiesBeanWrapper
								.setPropertyValue(new PropertyValue("username",
										username));
						poolPropertiesBeanWrapper
								.setPropertyValue(new PropertyValue("password",
										password));
						poolPropertiesBeanWrapper
								.setPropertyValue(new PropertyValue(
										"driverClass", driver));
					} catch (NoSuchMethodException | IllegalAccessException
							| InvocationTargetException
							| InstantiationException | ClassNotFoundException e) {
						throw new RuntimeException(e);
					}
				} else {
					LOG.warn("No connection pool implementations found, so not using a connection pool. Note that severe performance loss is guaranteed.");
					LOG.info(
							"no connection pool found so using driver {}, with url {}",
							driver, url);
					DriverManagerDataSource ds = new DriverManagerDataSource();
					ds.setDriverClassName(driver);
					ds.setUrl(url);
					ds.setUsername(username);
					ds.setPassword(password);
					dataSource = ds;
				}
			}
		} else {
			if (!StringUtils.isNotEmpty(driver)) {
				LOG.warn("When using jdni, driverClassName should not be specified because it will not be used!");
			}
			if (StringUtils.isNotEmpty(url)) {
				LOG.warn("When using jdni, url should not be specified because it will not be used!");
			}
			if (StringUtils.isNotEmpty(username)) {
				LOG.warn("When using jdni, username should not be specified because it will not be used!");
			}
			if (StringUtils.isNotEmpty(encryptedPassword)) {
				LOG.warn("When using jdni, encryptedPassword should not be specified because it will not be used!");
			}
			final JndiDataSourceLookup dsLookup = new JndiDataSourceLookup();
			dsLookup.setResourceRef(true);
			dataSource = dsLookup.getDataSource(jndiName);
		}
		return dataSource;
	}

	/**
	 * use LazyConnectionDataSourceProxy to eliminate unnecessary database
	 * connections, improve performance
	 * 
	 * @return
	 */
	@Bean
	protected DataSource lazyConnectionDataSourceProxy() {
		return new LazyConnectionDataSourceProxy(internalDataSource());
	}

	@Bean
	protected DataSource transactionAwareDataSourceProxy() {
		return new TransactionAwareDataSourceProxy(
				lazyConnectionDataSourceProxy());
	}

	@Bean
	public DataSource dataSource() {
		return transactionAwareDataSourceProxy();
	}

	/**
	 * 
	 * @return
	 * @throws DataServiceException
	 * @throws EncryptionException
	 */
	@Bean(name = "aceEMF")
	public LocalContainerEntityManagerFactoryBean configureEntityManagerFactory() {
		LOG.debug("creating instance of LocalContainerEntityManagerFactoryBean (emf)");
		LocalContainerEntityManagerFactoryBean entityManagerFactoryBean = new LocalContainerEntityManagerFactoryBean();
		entityManagerFactoryBean.setDataSource(dataSource());
		entityManagerFactoryBean.setPackagesToScan("edu.harvard.huit.ace");
		LOG.debug(
				"creating instance of HibernateJpaVendorAdapter with dialect {}",
				dialect);
		HibernateJpaVendorAdapter hibernateJpaVendorAdapter = new HibernateJpaVendorAdapter();
		hibernateJpaVendorAdapter.setDatabasePlatform(dialect);
		entityManagerFactoryBean.setJpaVendorAdapter(hibernateJpaVendorAdapter);
		entityManagerFactoryBean.setPersistenceUnitName("acePU");

		Map<String, Object> jpaProperties = entityManagerFactoryBean
				.getJpaPropertyMap();
		jpaProperties.put(org.hibernate.cfg.Environment.DIALECT, dialect);
		jpaProperties.put(org.hibernate.cfg.Environment.HBM2DDL_AUTO,
				hbm2ddlAuto);
		jpaProperties.put(org.hibernate.cfg.Environment.FORMAT_SQL, formatSql);
		jpaProperties.put(
				org.hibernate.cfg.Environment.ENABLE_LAZY_LOAD_NO_TRANS, true);

		// enable ordered and batches inserts and updates to improve performance
		// see
		// http://vladmihalcea.com/2015/03/18/how-to-batch-insert-and-update-statements-with-hibernate/
		jpaProperties.put(org.hibernate.cfg.Environment.ORDER_INSERTS, true);
		jpaProperties.put(org.hibernate.cfg.Environment.ORDER_UPDATES, true);
		jpaProperties.put(org.hibernate.cfg.Environment.STATEMENT_BATCH_SIZE,
				Dialect.DEFAULT_BATCH_SIZE);
		jpaProperties.put(org.hibernate.cfg.Environment.BATCH_VERSIONED_DATA,
				true);

		// 'hibernate.temp.use_jdbc_metadata_defaults' is a temporary magic
		// value. The need for it is intended to be alleviated with future
		// development, thus it is not defined as an Environment constant...
		//
		// it is used to control whether we should consult the JDBC metadata to
		// determine certain Settings default values; it is useful to *not* do
		// this when
		// the database may not be available (mainly in tools usage).
		jpaProperties.put("hibernate.temp.use_jdbc_metadata_defaults", "false");

		LOG.debug("returning instance of entity manager factory bean");
		return entityManagerFactoryBean;
	}

	/**
	 * 
	 */
	@Override
	@Bean
	@Primary
	public PlatformTransactionManager annotationDrivenTransactionManager() {
		JpaTransactionManager tm = new JpaTransactionManager();
		tm.setPersistenceUnitName("acePU");
		return tm;
	}

	@Bean
	public HibernateEntityListenersAdapter hibernateEntityListenersAdapter() {
		return new HibernateEntityListenersAdapter();
	}
}
