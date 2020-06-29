package egovframework.rte.psl.dataaccess.util;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import org.json.simple.JSONArray;
import org.springframework.web.util.HtmlUtils;

import egovframework.cmmn.util.CommonUtil;

/**
 * UnCamel한  key와 UnEscape한 value로 저장
 * 위 기능 외에는 HashMap과 동일
 * @author vary
 *
 * @param <K>
 * @param <V>
 */
public class UnCamelMap<K, V> extends HashMap<K, V> {

	private static final long serialVersionUID = 1L;

	public UnCamelMap() {
		super();
	}

	public UnCamelMap(Map<? extends K, ? extends V> m) {
		super();
		this.putAll(m);
	}

	public void putAll(Map<? extends K, ? extends V> m) {
		int s = m.size();
		if (s > 0) {
			for (Map.Entry<? extends K, ? extends V> e : m.entrySet()) {
				this.put(e.getKey(), e.getValue());
			}
		}
	}

	public V put(K key, V value) {
		key = convertUnCamelType(key);
		value = convertHtmlEscape(value);
		return super.put(key, value);
	}

	@SuppressWarnings("unchecked")
	private V convertHtmlEscape(V value) {
		if (value instanceof String) {
			if (value != null && ((String) value).indexOf("&amp;") == -1) {
				value = (V) HtmlUtils.htmlEscape((String) value);
			}
		} else if (value instanceof String[]) {
			String[] vs = (String[]) value;
			for (int i = 0; i < vs.length; i++) {
				if (vs[i] != null && ((String) vs[i]).indexOf("&amp;") == -1) {
					vs[i] = HtmlUtils.htmlEscape(vs[i]);
				}
			}
			value = (V) vs;
		}
		return value;
	}

	private static final String UN_CAMEL_CASING_REGEX = "(?<=\\p{Ll})(?=\\p{Lu})|(?<=\\p{L})(?=\\p{Lu}\\p{Ll})";

	@SuppressWarnings("unchecked")
	private K convertUnCamelType(K key) {
		if (key instanceof String) {
			return (K) CommonUtil.nvl(key).replaceAll(UN_CAMEL_CASING_REGEX, "_").toUpperCase();
		}
		return key;
	}

	public String getString(Object key) {
		Object _value = get(key);
		if (_value instanceof String) {
			return CommonUtil.nvl(_value);
		} else if (_value instanceof String[]) {
			String[] _values = (String[]) _value;
			String returnValue = "";
			if (_values != null) {
				for (int i = 0; i < _values.length; i++) {
					returnValue = CommonUtil.nvl(_values[i]);
					if (!"".equals(returnValue)) {
						break;
					}
				}
			}
			return returnValue;
		} else if (_value instanceof LinkedList<?>) {
			return CommonUtil.nvl(((LinkedList<?>) _value).get(0));
		} else if (_value instanceof Integer) {
			return CommonUtil.nvl(_value);
		} else if (_value instanceof Integer[]) {
			Integer[] _values = (Integer[]) _value;
			return CommonUtil.nvl(_values[0]);
		} else if (_value instanceof JSONArray) {
			return CommonUtil.nvl(((JSONArray) _value).get(0));
		}
		/*else if (_value instanceof JsonArray) {
			return CommonUtil.nvl(((JsonArray) _value).get(0));
		}*/
		return CommonUtil.nvl(_value);
	}

	public String[] getArray(Object key) {
		Object _value = get(key);
		if (_value == null) {
			return null;
		} else {
			if (_value instanceof String) {
				return new String[] { CommonUtil.nvl(_value) };
			} else if (_value instanceof String[]) {
				return (String[]) _value;
			} else if (_value instanceof LinkedList<?>) {
				LinkedList<?> linkedList = (LinkedList<?>) _value;
				int cnt = linkedList.size();
				String[] _values = new String[cnt];
				for (int i = 0; i < cnt; i++) {
					_values[i] = CommonUtil.nvl(linkedList.get(i));
				}
				return _values;
			} else if (_value instanceof Integer) {
				return new String[] { CommonUtil.nvl(_value) };
			} else if (_value instanceof Integer[]) {
				Integer[] intvalues = (Integer[]) _value;
				int cnt = intvalues.length;
				String[] _values = new String[cnt];
				for (int i = 0; i < cnt; i++) {
					_values[i] = CommonUtil.nvl(intvalues[i]);
				}
				return _values;
			} else if (_value instanceof JSONArray) {
				JSONArray jsonArray = (JSONArray) _value;
				int size = jsonArray.size();
				String[] _values = new String[size];
				for (int i = 0; i < size; i++) {
					_values[i] = CommonUtil.nvl(jsonArray.get(i));
				}
				return _values;
			}
			/*else if (_value instanceof JsonArray) {
				JsonArray jsonArray = (JsonArray) _value;
				int size = jsonArray.size();
				String[] _values = new String[size];
				for (int i = 0; i < size; i++) {
					_values[i] = CommonUtil.nvl(jsonArray.get(i));
				}
				return _values;
			}*/
			return new String[] { CommonUtil.nvl(_value) };
		}
	}

}
