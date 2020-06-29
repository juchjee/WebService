package site.comm.startUpServer;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

@Component
public class BeanLoader implements ServletContextAware {

	@Autowired
	IConstant iConstant;

	private ServletContext servletContext;

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;

	}

	@PostConstruct
	public void init() {
		this.servletContext.setAttribute("iConstant", iConstant);
	}

}
