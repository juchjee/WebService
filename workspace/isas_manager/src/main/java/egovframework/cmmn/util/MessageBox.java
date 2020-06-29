package egovframework.cmmn.util;

public class MessageBox {

	protected String id;
	protected String message;
	protected Exception exception;
	protected Object caller;

	public MessageBox(){}
	
	public MessageBox(String id){
		this.id = id;
	}
	
	public MessageBox(String id, String message){
		this.id = id;
		this.message = message;
	}
	
	public MessageBox(String id, String message, Exception exception){
		this.id = id;
		this.message = message;
		this.exception = exception;
	}
	
	public MessageBox(String id, String message, Exception exception, Object caller){
		this.id = id;
		this.message = message;
		this.exception = exception;
		this.caller = caller;
	}
	/**
	 * @return Returns the exception.
	 */
	public Exception getException() {
		return exception;
	}

	/**
	 * @param exception
	 *            The exception to set.
	 */
	public void setException(Exception exception) {
		this.exception = exception;
	}

	/**
	 * @return Returns the id.
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id
	 *            The id to set.
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return Returns the value.
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @param value
	 *            The value to set.
	 */
	public void setMessage(String value) {
		this.message = value;
	}

	/**
	 * @return Returns the caller.
	 */
	public Object getCaller() {
		return caller;
	}

	/**
	 * @param caller
	 *            The caller to set.
	 */
	public void setCaller(Object caller) {
		this.caller = caller;
	}

}
