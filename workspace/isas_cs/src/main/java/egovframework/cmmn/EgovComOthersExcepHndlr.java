package egovframework.cmmn;


import egovframework.rte.fdl.cmmn.exception.handler.ExceptionHandler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class EgovComOthersExcepHndlr implements ExceptionHandler {
	private static final Logger logger = LoggerFactory.getLogger(EgovComOthersExcepHndlr.class);

    public void occur(Exception exception, String packageName) {
    	logger.error(packageName, exception);
    }
}
