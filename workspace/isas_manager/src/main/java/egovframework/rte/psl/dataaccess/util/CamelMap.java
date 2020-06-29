package egovframework.rte.psl.dataaccess.util;

import java.io.BufferedReader;
import java.io.Reader;
import java.sql.Clob;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import org.json.simple.JSONArray;
import org.springframework.web.util.HtmlUtils;

import com.google.gson.JsonArray;

import egovframework.cmmn.util.CommonUtil;

/**
 * Camel한  key와 Escape한 value로 저장
 * 위 기능 외에는 HashMap과 동일
 * @author vary
 *
 * @param <K>
 * @param <V>
 */
public class CamelMap<K, V> extends HashMap<K, V> {
	private static final long serialVersionUID = 1L;

	public CamelMap() {
		super();
	}

	public CamelMap(Map<? extends K, ? extends V> m) {
		super();
		this.putAll(m);
	}

	public V put(K key, V value) {
		key = convertCamelType(key);
		value = convertHtmlUnescape(value);
		return super.put(key, value);
	}

	public V put(K key, V value, boolean flag) {
		value = convertHtmlUnescape(value);
		if (flag) {
			return super.put(key, value);
		} else {
			key = convertCamelType(key);
			return super.put(key, value);
		}
	}

	public void putAll(Map<? extends K, ? extends V> m) {
		if (m.size() > 0) {
			for (Map.Entry<? extends K, ? extends V> e : m.entrySet())
				this.put(e.getKey(), e.getValue());
		}
	}

	public void putAll(Map<? extends K, ? extends V> m, boolean flag) {
		if (m.size() > 0) {
			for (Map.Entry<? extends K, ? extends V> e : m.entrySet())
				this.put(e.getKey(), e.getValue(), flag);
		}
	}

	@SuppressWarnings("unchecked")
	private V convertHtmlUnescape(V value) {
		if (value instanceof String) {
			value = (V) HtmlUtils.htmlUnescape((String) value);
		} else if (value instanceof Clob) {
			Clob clob = (Clob) value;
			final StringBuilder sb = new StringBuilder();
			BufferedReader br = null;
			try {
				final Reader reader = clob.getCharacterStream();
				br = new BufferedReader(reader);
				int b;
				while (-1 != (b = br.read())) {
					sb.append((char) b);
				}
				br.close();
				sb.trimToSize();
			} catch (Exception ex) {
			}
			value = (V) HtmlUtils.htmlUnescape(sb.toString());
		}
		return value;
	}

	@SuppressWarnings("unchecked")
	private K convertCamelType(K key) {
		if (key instanceof String) {
			StringBuilder result = new StringBuilder();
			boolean nextIsUpper = false;
			String _key = CommonUtil.nvl(key);
			if (_key.length() > 0) {
				result.append(_key.substring(0, 1).toLowerCase());
				for (int i = 1; i < _key.length(); i++) {
					String s = _key.substring(i, i + 1);
					if (s.equals("_")) {
						nextIsUpper = true;
					} else {
						if (nextIsUpper) {
							result.append(s.toUpperCase());
							nextIsUpper = false;
						} else {
							result.append(s.toLowerCase());
						}
					}
				}
			}
			return (K) result.toString();
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
		} else if (_value instanceof JsonArray) {
			return CommonUtil.nvl(((JsonArray) _value).get(0));
		}
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
			}
			return new String[] { CommonUtil.nvl(_value) };
		}
	}

}
