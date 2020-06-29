package egovframework.cmmn;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

/**
 *메소드 캐쉬를 사용할때 메소드를 구별하기위한 키
 */
@SuppressWarnings("rawtypes")
public class MethodKey {

	private static Map<Object, Object> readMethodMap = new HashMap<Object, Object>();

	private Class objectClass;
    private String propertyName;
    private Class parameterType;
    private int hashCode;

	public MethodKey(Class objectClass, String propertyName) {
	    this(objectClass, propertyName, null);
	}

	public MethodKey(Class objectClass, String propertyName, Class parameterType) {
	    this.objectClass = objectClass;
	    this.propertyName = propertyName;
	    this.parameterType = parameterType;
	    this.hashCode = propertyName.hashCode() + objectClass.hashCode()
	            + (null != parameterType ? parameterType.hashCode() : 0);
	}

	public boolean equals(Object obj) {
	    boolean result = false;
	    if (obj instanceof MethodKey) {
	        MethodKey other = (MethodKey) obj;
	        if (propertyName.equals(other.propertyName)
	                && objectClass.equals(other.objectClass)) {
	            if (parameterType == null) {
	                result = other.parameterType == null;
                } else if(parameterType.equals(other.parameterType)) {
                    result = true;
                }
	        }
	    }

	    return result;
	}

	public int hashCode() {
	    return hashCode;
	}

	/**
	 * get/is method추출
	 * @param objectClass
	 * @param propertyName
	 * @return
	 * @throws IntrospectionException
	 * @throws NoSuchMethodException
	 */
	@SuppressWarnings({ "unchecked" })
	public static Method getReadMethod(Class objectClass, String propertyName) throws IntrospectionException, NoSuchMethodException {
	    Method method = null;
	    MethodKey key = new MethodKey(objectClass, propertyName);
	    method = (Method)readMethodMap.get(key);
	    if (method == null) {
	        BeanInfo info = Introspector.getBeanInfo(objectClass);
	        PropertyDescriptor[] pd = info.getPropertyDescriptors();
	        if (pd != null) {
	            for (int i = 0; i < pd.length; i++) {
                    if (propertyName.equals(pd[i].getName())) {
                        method = pd[i].getReadMethod();
                        break;
                    }
	            }
	        }
	        if (method == null) {
	            String methodName = new StringBuffer("get").append(propertyName.substring(0, 1).toUpperCase()).append(propertyName.substring(1)).toString();
	            method = objectClass.getMethod(methodName);
		        if (method == null) {
		            methodName = new StringBuffer("is").append(propertyName.substring(0, 1).toUpperCase()).append(propertyName.substring(1)).toString();
		            method = objectClass.getMethod(methodName);
		        }
	        }
	        if (method == null) {
	            throw new NoSuchMethodException(new StringBuffer(objectClass.getName()).append("클래스의 get").append(propertyName.substring(0, 1).toUpperCase()).append(propertyName.substring(1)).append(" 메소드를 찾을 수 없습니다.").toString());
	        }
	        readMethodMap.put(key, method);

	    }
	    return method;
	}

	/**
	 *
	 * @param object
	 * @param propertyName
	 * @return
	 * @throws IllegalArgumentException
	 * @throws IntrospectionException
	 * @throws NoSuchMethodException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	public static Object getMethodValue(Object object, String propertyName) throws IllegalArgumentException, IntrospectionException, NoSuchMethodException, IllegalAccessException, InvocationTargetException {
		Object result = null;

        if (object != null) {
            int dotIndex = propertyName.indexOf('.');
            if (dotIndex > -1) {
                String varName1 = propertyName.substring(0, dotIndex);
                String varName2 = propertyName.substring(dotIndex+1);

                Method getter = getReadMethod(object.getClass(), varName1);
                if(getter != null) {
                    Object value1 =  getter.invoke(object);
                    result = getMethodValue(value1, varName2);
                }
            } else {
                Method getter = getReadMethod(object.getClass(), propertyName);
                if(getter != null) {
                    result =  getter.invoke(object);
                }
            }
        }

		return result;
	}
}
