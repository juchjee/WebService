package egovframework.cmmn;

import java.util.List;

@SuppressWarnings("rawtypes")
public class ListWrapper {
	/**
	 * taglib에서 사용하기 위한 List를 위한 Wrapper Class
	 */
	
	private List list = null;

	public ListWrapper(List list) {
		this.list = list;
	}

	public List getList() {
		return list;
	}

	public int getSize() {
		if (list != null)
			return list.size();
		else
			return 0;
	}
}
