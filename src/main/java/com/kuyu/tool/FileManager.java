package com.kuyu.tool;

import java.io.File;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.nfwork.dbfound.core.DBFoundConfig;
import com.nfwork.dbfound.dto.QueryResponseObject;
import com.nfwork.dbfound.exception.DBFoundRuntimeException;
import com.nfwork.dbfound.model.base.JavaSupport;
import com.nfwork.dbfound.util.JsonUtil;
import com.nfwork.dbfound.web.WebWriter;

public class FileManager extends JavaSupport {

    Log log = LogFactory.getLog(this.getClass());

    @Override
    public void execute() throws Exception {
        final FileItem fileItem = (FileItem) params.get("file").getValue();
        String path = params.get("path").getStringValue();
        path = path.replace("${@prejectRoot}", DBFoundConfig.getProjectRoot());
        path = path.replace("${@classpath}", DBFoundConfig.getClasspath());

        final String fileName = params.get("file_name").getStringValue();
        final File fold = new File(path);
        if (fold.exists() == false) {
            fold.mkdir();
        }
        final File newFile = new File(path + fileName);
        fileItem.write(newFile);
    }

    public void delete() throws Exception {
        String path = params.get("path").getStringValue();
        path = path.replace("${@prejectRoot}", DBFoundConfig.getProjectRoot());
        path = path.replace("${@classpath}", DBFoundConfig.getClasspath());

        final String fileName = params.get("file_name").getStringValue();
        final File newFile = new File(path + fileName);

        delete(newFile);
    }

    public void delete(final File file) {
        if (file.isDirectory()) {
            final File[] files = file.listFiles();
            for (int i = 0; i < files.length; i++) {
                if (files[i].isFile()) {
                    delete(files[i]);
                }
            }
            file.delete();
        } else {
            file.delete();
        }
    }

    public void down() throws Exception {
        String path = params.get("path").getStringValue();
        // path = new String(path.getBytes("ISO-8859-1"), "UTF-8");

        path = path.replace("${@prejectRoot}", DBFoundConfig.getProjectRoot());
        path = path.replace("${@classpath}", DBFoundConfig.getClasspath());
        final String fileName = path.substring(path.lastIndexOf("/") + 1);
        params.get("file_name").setValue(fileName);
        params.get("file").setValue(path);
    }

    @SuppressWarnings("unchecked")
    public void listFile() {
        String path = params.get("path").getStringValue();
        path = path.replace("${@prejectRoot}", DBFoundConfig.getProjectRoot());
        path = path.replace("${@classpath}", DBFoundConfig.getClasspath());

        final File fold = new File(path);
        if (fold.exists() == false) {
            throw new DBFoundRuntimeException("文件夹：" + path + "不存在！");
        }
        final File[] files = fold.listFiles();

        final QueryResponseObject object = new QueryResponseObject();
        final List<Map> datas = new ArrayList<Map>();
        final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for (final File file : files) {
            final Map data = new HashMap();
            data.put("file_type", file.isDirectory() ? 1 : 0);
            data.put("file_name", file.getName());
            if (file.isFile()) {
                data.put("file_size", formatFileSize(file.length()));
            }
            data.put("last_update_time", format.format(new Date(file.lastModified())));
            datas.add(data);
        }

        object.setDatas(datas);
        object.setSuccess(true);
        WebWriter.jsonWriter(context.response, JsonUtil.beanToJson(object));
        context.outMessage = false;
    }

    public String formatFileSize(final long fileS) {// 转换文件大小
        final DecimalFormat df = new DecimalFormat("#.00");
        String fileSizeString = "";
        if (fileS < 1024) {
            fileSizeString = df.format((double) fileS) + "B";
        } else if (fileS < 1048576) {
            fileSizeString = df.format((double) fileS / 1024) + "K";
        } else if (fileS < 1073741824) {
            fileSizeString = df.format((double) fileS / 1048576) + "M";
        } else {
            fileSizeString = df.format((double) fileS / 1073741824) + "G";
        }
        return fileSizeString;
    }
}
