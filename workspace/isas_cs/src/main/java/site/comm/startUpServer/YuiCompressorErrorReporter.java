package site.comm.startUpServer;

import org.mozilla.javascript.ErrorReporter;
import org.mozilla.javascript.EvaluatorException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class YuiCompressorErrorReporter implements ErrorReporter {

	protected static final Logger LOGGER = LoggerFactory.getLogger(YuiCompressorErrorReporter.class);
	
	public void warning(String message, String sourceName, int line, String lineSource, int lineOffset) {
		if (line < 0) {
			LOGGER.warn(message);
		} else {
			LOGGER.warn(line + ':' + lineOffset + ':' + message);
		}
	}

	public void error(String message, String sourceName, int line, String lineSource, int lineOffset) {
		if (line < 0) {
			LOGGER.warn(message);
		} else {
			LOGGER.warn(line + ':' + lineOffset + ':' + message);
		}
	}

	public EvaluatorException runtimeError(String message, String sourceName, int line, String lineSource, int lineOffset) {
		error(message, sourceName, line, lineSource, lineOffset);
		return new EvaluatorException(message);
	}
}
