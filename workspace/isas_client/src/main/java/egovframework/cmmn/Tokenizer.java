package egovframework.cmmn;

/**
 * 문자열을 토큰으로 나누는 기능을 가지고 있는 클래스이다
 * <p>
 * 구분자 사이에 아무것도 없어도 공백을 반환한다.
 * <p>
 * ex) 1||3 -> 1, 공백, 3 이렇게 3개의 토큰을 반환한다.
 */
public class Tokenizer {

	private int currentPosition;
	private int maxPosition;
	private String str;
	private String delimiter;
	private int delimiterSize;

	private int countTokens = -1; // Token의 갯수

	public Tokenizer(String str) {
		this(str, " ");
	}

	/**
	 * 
	 * @param str
	 * @param delim
	 */
	public Tokenizer(String str, String delim) {
		this.str = str;
		this.delimiter = delim;
		currentPosition = 0;
		maxPosition = this.str.length();
		delimiterSize = this.delimiter.length();

	}

	public boolean hasMoreTokens() {
		return ((currentPosition <= maxPosition) || (str.indexOf(delimiter,
				currentPosition) > -1));
	}

	public String nextToken() {
		String result = null;
		int index = str.indexOf(delimiter, currentPosition);
		if (index > -1) {
			result = str.substring(currentPosition, index);
			currentPosition = index + delimiterSize;
		} else {
			result = str.substring(currentPosition);
			currentPosition = maxPosition + delimiterSize;
		}
		return result;
	}

	public int countTokens() {
		if (countTokens < 0) {
			int tCountTokens = 1;
			int cp = 0;
			int index = 0;
			while ((index = str.indexOf(delimiter, cp)) > -1) {
				tCountTokens++;
				cp = index + delimiterSize;
			}
			countTokens = tCountTokens;
		}
		return countTokens;
	}

	public String[] toArray(int arraySize) {
		String[] array = new String[arraySize];
		for (int i = 0; i < arraySize && hasMoreTokens(); i++) {
			array[i] = nextToken();
		}
		return array;
	}

	public String[] toArray() {
		return toArray(countTokens());
	}

}
