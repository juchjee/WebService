package egovframework.waf.taglib.html;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.IOUtil;
import egovframework.waf.taglib.DefaultTagSupport;

/**
 * 웹에디터 태크
 * @author seominho
 *
 */
public class WysiwygTag extends DefaultTagSupport {
    
    /**
     * 
     */
    private static final long serialVersionUID = -1719874752753512802L;


    @SuppressWarnings("rawtypes")
	protected static Map htmlMap = new HashMap();

    
    protected String form;
    protected String content;
    protected String tbColor = "#EFEBDE";
    protected String reload;
    
    protected String path    = "";
    
    
    protected String replaceVar(String text, String[] strArray) {
        StringBuffer result = new StringBuffer();
        if (text != null) {
            int index = 0;
            for (int i = 0; i < strArray.length; i++) {
                String var = "{" + i + "}";
                index = text.indexOf(var);
                if (index > -1) {
                    result.append(text.substring(0, index));
                    result.append(strArray[i]);
                    text = text.substring(index + var.length());
                } else {
                    result.append(text);
                    text = "";
                }
            }
            result.append(text);
            
        }
        
        return result.toString();
    }
    
    @SuppressWarnings("unchecked")
	public int doStartTag() throws JspException {
        FileInputStream fis = null;
        try {
            String id = new StringBuffer().append(form).append("|").append("contentName").append("|").append("tbColor").toString();
            boolean reload = CommonUtil.convertBoolean(this.reload, false);
            String html = (reload) ? null : (String)htmlMap.get(id);
            
            if (html == null) {
                fis = new FileInputStream(pageContext.getServletContext().getRealPath(path + "/editor.htm"));
                html = replaceVar(IOUtil.readContents(fis, "utf-8"), new String[] {form, content, tbColor});
                htmlMap.put(id, html);
            }
            out(pageContext, html);
        } catch (IOException e) {
            throw new JspException(e.toString(), e);
        }  finally {
            if (fis != null) try { fis.close(); } catch(IOException ioe) {}
        }
        return SKIP_BODY;
    }
    
    public static void out(PageContext pageContext, String html) throws IOException {
        JspWriter w = pageContext.getOut();
        w.write(html);
    }
    
    
    
    /**
     * @param contentName The contentName to set.
     */
    public void setContent(String contentName) {
        this.content = contentName;
    }
    /**
     * @param formName The formName to set.
     */
    public void setForm(String formName) {
        this.form = formName;
    }
    /**
     * @param tbColor The tbColor to set.
     */
    public void setTbColor(String tbColor) {
        this.tbColor = tbColor;
    }
    
    
    /**
     * @param reload The reload to set.
     */
    public void setReload(String reload) {
        this.reload = reload;
    }

    /**
     * @param path The path to set.
     */
    public void setPath(String path) {
        this.path = path;
    }
    
    
}
