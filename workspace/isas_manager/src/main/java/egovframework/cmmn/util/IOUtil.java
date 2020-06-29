package egovframework.cmmn.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;

/**
 * 데이터 입출력용 유틸리티 클래스
 */
public class IOUtil {

	/**
	 * 
	 * @param in
	 * @param out
	 * @throws IOException
	 */
    public static void copy(InputStream in, OutputStream out) throws IOException {
        int c = -1;
        while ((c = in.read()) != -1) {
            out.write(c);
        }
        out.flush();
    }
    
    /**
     * 
     * @param in
     * @param out
     * @throws IOException
     */
    public static void copy(Reader in, Writer out) throws IOException {
        int c = -1;
        while ((c = in.read()) != -1) {
            out.write(c);
        }
        out.flush();
    }
    
    
    /**
     * 입력 스트림에서 데이터를 읽어와 문자열(String)으로 반환한다.
     * 
     * @param in 입력 스트림
     * @param charsetName 
     * @return
     * @throws IOException
     */
    public static String readContents(InputStream in, String charsetName) throws IOException {
        StringWriter writer = new StringWriter();
        Reader reader = null;
        try {
            reader = new BufferedReader(new InputStreamReader(in, charsetName));
            copy(reader, writer);
        } finally {
            if (reader != null) try { reader.close(); } catch(IOException iex) {}
            if (writer != null) try { writer.close(); } catch(IOException iex) {}            
        }
        return writer.toString();
    }
    
    /**
     * 텍스트(문자열)을 출력 스트림으로 출력한다.
     * 
     * @param out 출력 스트림
     * @param charsetName
     * @param text 텍스트
     * @throws IOException
     */
    public static void writeContents(OutputStream out, String charsetName, String text) throws IOException {
        BufferedReader reader = null;
        BufferedWriter writer = null;
        try {
            reader = new BufferedReader(new StringReader(text));
            writer = new BufferedWriter(new OutputStreamWriter(out, charsetName)); 
            copy(reader, writer);
        } finally {
            if (reader != null) try { reader.close(); } catch(IOException iex) {}
            if (writer != null) try { writer.close(); } catch(IOException iex) {}            
        }
    }
}
