package com.kuyu.tool;

import java.util.Locale;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateExceptionHandler;

public class FreemarkFactory {
    private static Configuration cfg;
    private static final String ftlPath = "/com/nfwork/demo/tool";

    /**
     * get config
     * 
     * @return
     */
    public static Configuration getConfig() {
        if (cfg == null) {
            try {
                cfg = new Configuration();
                cfg.setEncoding(Locale.getDefault(), "utf-8");
                // set object Wrapper
                cfg.setObjectWrapper(new DefaultObjectWrapper());
                // set Exception handler
                cfg.setTemplateExceptionHandler(TemplateExceptionHandler.IGNORE_HANDLER);
                // where from Template file
                cfg.setClassForTemplateLoading(Configuration.class, ftlPath);
            } catch (final Exception e) {
                e.printStackTrace();
            }
        }
        return cfg;
    }
}
