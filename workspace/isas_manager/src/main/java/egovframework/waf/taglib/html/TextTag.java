package egovframework.waf.taglib.html;

import java.net.URLEncoder;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import egovframework.cmmn.util.CommonUtil;

/**
 * \n 을 &lt;br&gt;로 포맷화 시킨다.
 * @author seominho
 *
 */
public class TextTag extends BodyTagSupport {


    //protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
	 *
	 */
	private static final long serialVersionUID = 3039991603651748898L;
	private String text;
    private String tag = "<br />";
    private String length;
    private String ignoreXml;
    private String crlfdel; //CR, LF 삭제여부
    private String option;
    private String urlEncode;

    @SuppressWarnings("deprecation")
	public int doAfterBody() {
        BodyContent body = getBodyContent();
        if (body != null) {
            text = body.getString();
        }
        if (text != null) {
            try {
                JspWriter out = getPreviousOut();

                // HTML 무시
                if (ignoreXml != null && CommonUtil.convertBoolean(ignoreXml, false)) {
                    text = ignoreXml(text);
                    text = text.replaceAll("&nbsp;", " ");
                }

                if (urlEncode != null && CommonUtil.convertBoolean(urlEncode, true)) {
                    text = URLEncoder.encode(text);
                }

                if ("T".equals(option)) {
                    // 체험수기
                    int bIndex = 0;
                    int eIndex = 0;
                    int count = 0;
                    while ((eIndex = text.indexOf('\n', bIndex)) > -1 && (count++ < 20)) {
                        if (text.substring(bIndex, eIndex).length() > 130) {
                            text = text.substring(bIndex);
                            break;
                        } else {
                            bIndex = eIndex + 1;
                        }
                    }
                }

                if (tag!=null && !"".equals(tag.trim())) {
                    // CR, LP 변경
                    if (text.indexOf("\r\n") > -1) {
                        if(crlfdel != null && CommonUtil.convertBoolean(crlfdel, false))
                            text = text.replaceAll("\r\n", tag);
                        else
                            text = text.replaceAll("\r\n", tag + "\r\n");
                    } else if (text.indexOf("\n") > -1) {
                        if(crlfdel != null && CommonUtil.convertBoolean(crlfdel, false))
                            text = text.replaceAll("\n", tag);
                        else
                            text = text.replaceAll("\n", tag + "\n");
                    }
                }


                if (length != null) {
                    int len = CommonUtil.convertInt(length, 0);
                    if (len > 0) {
                        text = CommonUtil.crop(text, len, "...");
                    }
                }
                out.print(text);
            } catch (Exception e) {
            	e.printStackTrace();
    			System.out.println("TAG : " + e.toString());
            }
        }
        return SKIP_BODY;
    }

   protected String ignoreXml(String text) {
       StringBuffer result = new StringBuffer();

       int position = 0;
       int bIndex = -1;
       int eIndex = -1;
       String temp = text;
       int textLength = temp.length();
       while (position < textLength) {
           bIndex = temp.indexOf("<", position);
           eIndex = temp.indexOf(">", bIndex);

           if (bIndex > -1) {

               if (eIndex < 0 || eIndex > textLength) {
                   eIndex = textLength - 1;
               }

               result.append(temp.substring(position, bIndex));
               String tag = temp.substring(bIndex, eIndex + 1);

               position = eIndex + 1;
               if (tag.equalsIgnoreCase("<style>")) {
                   String closeTag = getCloseTag(tag);
                   int cIndex = temp.indexOf(closeTag, position);
                   if (cIndex > -1) {
                       position = cIndex + closeTag.length();
                   }
               } else if (tag.equalsIgnoreCase("<br>") || tag.equalsIgnoreCase("<br/>") || tag.equalsIgnoreCase("<br />")) {
                   if (this.tag!=null && !"".equals(this.tag.trim())) {
                       result.append(tag);
                   }
               }

            } else {
                result.append(temp.substring(position));
                position = textLength;
            }
        }

       if (position < textLength) {
           result.append(temp.substring(position));
       }

       return result.toString();
   }

   protected String getCloseTag(String openTag) {
       String closeTag = openTag;
       if (openTag != null && openTag.length() > 1) {
           StringBuffer sb = new StringBuffer();
           sb.append("</").append(openTag.substring(1));
           closeTag = sb.toString();
       }
       return closeTag;
   }

    /**
     * @param length The length to set.
     */
    public void setLength(String length) {
        this.length = length;
    }


    /**
     * @param tag The tag to set.
     */
    public void setTag(String tag) {
        this.tag = tag;
    }


    /**
     * @param ignoreXml The ignoreXml to set.
     */
    public void setIgnoreXml(String ignoreXml) {
        this.ignoreXml = ignoreXml;
    }

    /**
     * @param option The option to set.
     */
    public void setOption(String option) {
        this.option = option;
    }

    /**
     * @param crlfdel The crlfdel to set.
     */
    public void setCrlfdel(String crlfdel) {
        this.crlfdel = crlfdel;
    }

    public void setUrlEncode(String urlEncode) {
        this.urlEncode = urlEncode;
    }

}
