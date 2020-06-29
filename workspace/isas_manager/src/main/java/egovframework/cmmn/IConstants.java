package egovframework.cmmn;

/**
 * 로컬용
 * 사이트 공통 상수 설정
 */
public interface IConstants {

	/**
	 * 개발 모드 여부
	 */
	public static final boolean isDev = !(EgovProperties.getSiteProperty("isDev").equals("false"));

	/**
	 *  absolute class path portion
	 */
	public static final String CLASSES_ROOT = IConstants.class.getResource("/").getPath();

	/**
	 * admin 루트
	 */
	public static final String MNG_URI = "mng/";

	/**
	 * absolute WEB-INF path portion
	 */
	public static final String WEBINF_ROOT = CLASSES_ROOT.replace("classes/", "");
	//public static final String WEBINF_ROOT = "D:/initiative6/workspace/ISDS_ADMIN/src/main/webapp/WEB-INF/";

	/**
	 * absolute WebApp path portion
	 */
	public static final String LOCAL_ROOT = WEBINF_ROOT.replace("WEB-INF/", "");

	/**
	 * site.properties의 ROOT_URI
	 */
	public static final String HOME_URL = EgovProperties.getSiteProperty("HomeUrl");

	/**
	 * site.properties의 ROOT_URI
	 */
	public static final String PROPERTY_ROOT_URI = EgovProperties.getSiteProperty("rootUri");
	public static final String ROOT_URI = HOME_URL + PROPERTY_ROOT_URI;

    /**
     * DB 유형
     */
    public static final int ORACLE = 0;
    public static final int MSSQL = 1;
    public static final int DB_TYPE = "oracle".equals(EgovProperties.getGlobalsProperty("Globals.DbType")) ? IConstants.ORACLE : IConstants.MSSQL;

    /**
     * 메인 페이지
     */
    public static final String MAIN_PAGE = EgovProperties.getSiteProperty("MainPage");
    /**
     * 관리자 메인 페이지
     */
    public static final String SA_MAIN_PAGE = EgovProperties.getSiteProperty("SaMainPage");
    /**
     * 프론트 url
     */
    public static final String FRONT_URL = EgovProperties.getSiteProperty("FrontUrl");

	/** message name */
	public static final String MESSAGE_BOX_KEY = EgovProperties.getSiteProperty("messageBoxKey");

	/**
	 * site 인코딩
	 */
	public static final String CHARSET = EgovProperties.getSiteProperty("charSet");

	/**
	 * RemoteAddr, loginAddr, RequestURI, RequestParams 표출 여부
	 */
	public static final boolean IS_SHOW_LOG = "true".equals(EgovProperties.getSiteProperty("isRequestLogger"));

	/**
	 * 정품 혹은 평가판의 만료일을 판단하기 위한 라이센스 파일의 위치를 지정.
	 */
	public static final String DEXTUPLOADJ_CONFIG = WEBINF_ROOT + "config/dextuploadj.config";

	/**
	 * 업로드 파일 크기
	 */
	public static final int FILE_MAX_SIZE = EgovProperties.getSitePropertyInt("fileMaxSize") * 1024 * 1024;

	/**
	 * 한번에 올릴 수 있는 업로드 파일 크기
	 */
	public static final int FILE_MAX_SIZE_TOTAL = EgovProperties.getSitePropertyInt("fileMaxSizeTotal") * 1024 * 1024;

	/**
	 * 업로드 파일 홈경로
	*/
	public static final String HOME_PATH = EgovProperties.getSiteProperty("HomePath");

	/**
	 * 이미지 업로드 기본 폴더
	 */
	public static final String IMAGE_UPLOAD_PATH = HOME_PATH + EgovProperties.getSiteProperty("imageUploadPath");

	/**
	 * 이미지 가로 최대 크기
	 */
	public static final int IMAGE_MAX_WIDTH = EgovProperties.getSitePropertyInt("imageMaxWidth");

	/**
	 * 이미지 참조 URL
	 */
	public static final String IMAGES_UPLOAD_URL = EgovProperties.getSiteProperty("imagesUploadUrl");

	/**
	 * 네이버에디터 사진 업로드 name
	 */
	public static final String IMAGE_UPLOAD_NAME = EgovProperties.getSiteProperty("imageUploadName");

	/**
	 * 발신자 번호
	 */
	public static final String SMS_SEND_PHONE = EgovProperties.getSiteProperty("smsSendPhone");

	/**
	 * html 이미지 업로드후 실행시킬 콜백 함수
	 */
	public static final String CALL_BACK = "callback";
	public static final String CALLBACK_FUNC = "callback_func";
	/**
	 * 문서 파일 업로드 기본 폴더
	 */
	public static final String DOC_UPLOAD_PATH = HOME_PATH + EgovProperties.getSiteProperty("docUploadPath");
	public static final String DOC_UPLOAD_URL = EgovProperties.getSiteProperty("docUploadUrl");
	/**
	 * 팝업 파일 업로드 기본 폴더
	 */
	public static final String POP_UPLOAD_PATH = HOME_PATH + EgovProperties.getSiteProperty("popUploadPath");
	public static final String POP_UPLOAD_URL = EgovProperties.getSiteProperty("popUploadUrl");
	
	

	public static final String INSERT = "I";
	public static final String UPDATE = "U";
	public static final String DELETE = "D";

}
