package com.ffunding.web.util;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;
import org.springframework.web.servlet.view.document.AbstractPdfView;
 
import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;
 
@Component("pdfDownView")
public class pdfDownView extends AbstractPdfView{
 
    @Override
    protected void buildPdfDocument(Map<String, Object> model, Document doc, PdfWriter writer, 
            HttpServletRequest req,
            HttpServletResponse res) throws Exception {
          // TODO Auto-generated method stub
          System.out.println("---- PdfDownloadView.buildPdfDocument() ----");
          
          String userAgent = req.getHeader("User-Agent");
          String fileName = "product_data.pdf";
          
          if(userAgent.indexOf("MSIE") > -1){
           fileName = URLEncoder.encode(fileName, "utf-8");
          }else{
           fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
          }
          
          res.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
          res.setHeader("Content-Transfer-Encoding", "binary");
          
          Map<String, String> map = (HashMap<String, String>)model.get("map");
          
          Table table = new Table(2, map.size()+1);
          table.setPadding(5);
          
          BaseFont bfKorea = BaseFont.createFont("c:\\windows\\fonts\\batang.ttc,0",BaseFont.IDENTITY_H,BaseFont.EMBEDDED);
  		Font font = new Font(bfKorea);
          Cell cell = new Cell(new Paragraph("product", font));
          cell.setHeader(true);
          table.addCell(cell);
          
          cell = new Cell(new Paragraph("value", font));
          cell.setHeader(true);
          table.addCell(cell);
          table.endHeaders();
          
          Set<String> set = map.keySet();
          Iterator<String> it = set.iterator();
          
          while(it.hasNext()){
           String key = it.next();
           table.addCell(key);
           table.addCell(map.get(key));
          }

          doc.add(table);    
    }
 
}

