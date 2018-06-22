package gitTest;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

public class Test {
	public static void main(String[] args) throws Exception{
		File file=new File("e:\\图片.jpg");
		File file1=new File("src/img/图片.jpg");
		System.out.println(file1.getAbsolutePath());
		file1.getParentFile().mkdirs();
		file1.createNewFile();
		FileInputStream inputStream=new FileInputStream(file);
		FileOutputStream outputStream=new FileOutputStream(file1);
		int b=0;
		while ((b=inputStream.read())!=-1) {
			outputStream.write(b);
			
		}
		inputStream.close();
		outputStream.close();
		System.out.println("111");
	}
}
