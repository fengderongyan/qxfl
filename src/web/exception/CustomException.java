package web.exception;

/**
 * 自定义异常
 * @author chang
 * @createDate Mar 8, 2013
 * @description
 */
public class CustomException extends Exception {

	private static final long serialVersionUID = 6596385261286232441L;

	public CustomException(String message) {
		super(message);
	}

	public CustomException(String message, Throwable cause) {
		super(message, cause);
	}

}
