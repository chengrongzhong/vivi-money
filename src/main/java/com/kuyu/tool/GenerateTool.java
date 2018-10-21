package com.kuyu.tool;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.nfwork.dbfound.core.Context;
import com.nfwork.dbfound.core.DBFoundConfig;

import freemarker.template.Configuration;
import freemarker.template.Template;

public class GenerateTool {

    private static String tablename = "sc_game_rule";
    private static String pk = "rule_id";

    public static void generateModel(final String tablename, final String pk, final String fileName) {
        final File file = new java.io.File(getRealValue(fileName));
        GenerateTool.tablename = tablename;
        GenerateTool.pk = pk;
        final Table table = getTable();
        for (final Column column : table.getColumnlist()) {
            column.setType(getDataType(column.getDataType()));
        }
        try {
            generateModel(table, new OutputStreamWriter(new FileOutputStream(file)));
        } catch (final FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    private static String getRealValue(String value) {
        value = value.replace("${@classpath}", DBFoundConfig.getClasspath());
        final String webRoot = DBFoundConfig.getProjectRoot();
        if (webRoot != null) {
            value = value.replace("${@projectRoot}", webRoot);
        }
        return value;
    }

    public static void generateModel(final String tablename, final String pk) {
        GenerateTool.tablename = tablename;
        GenerateTool.pk = pk;
        final Table table = getTable();
        for (final Column column : table.getColumnlist()) {
            column.setType(getDataType(column.getDataType()));
        }
        generateModel(table, new OutputStreamWriter(System.out));
    }

    private static void generateModel(final Table table, final Writer writer) {
        try {
            final Configuration cfg = FreemarkFactory.getConfig();
            final Template template = cfg.getTemplate("model.ftl");
            final Map<String, Object> root = new HashMap<String, Object>();
            root.put("table", table);
            Column pkcColumn = null;
            for (final Column column : table.getColumnlist()) {
                if (column.getColumnName().equals(pk)) {
                    pkcColumn = column;
                    break;
                }
            }
            table.getColumnlist().remove(pkcColumn);
            root.put("pk", pkcColumn);
            template.process(root, writer);
        } catch (final Exception e) {
            e.printStackTrace();
        }

    }

    public static String getDataType(final int key) {
        switch (key) {
        case Types.VARCHAR:
            return "varchar";
        case Types.INTEGER:
            return "number";
        case Types.DOUBLE:
            return "number";
        case Types.FLOAT:
            return "number";
        case Types.DECIMAL:
            return "number";
        case Types.NUMERIC:
            return "number";
        case Types.VARBINARY:
            return "number";
        case Types.BIGINT:
            return "number";
        case Types.REAL:
            return "number";
        default:
            return "varchar";
        }
    }

    public static Table getTable() {
        DBFoundConfig.init("${@projectRoot}/WEB-INF/dbfound-conf.xml");
        final Context context = new Context();
        try {
            final Connection connection = context.getConn();

            final DatabaseMetaData dbmetadata = connection.getMetaData();
            ResultSet rs = dbmetadata.getTables(null, null, tablename, new String[]{ "TABLE" });

            final List<Table> tablelist = new ArrayList<Table>();
            while (rs.next()) {
                final Table table = new Table();
                table.setTableName(rs.getString("TABLE_NAME"));
                table.setRemarks(rs.getString("REMARKS"));
                tablelist.add(table);
            }
            rs.close();

            final Table table = tablelist.get(0);
            rs = dbmetadata.getColumns(null, null, table.getTableName(), null);

            final List<Column> columnlist = new ArrayList<Column>();
            while (rs.next()) {
                final Column column = new Column();
                column.setColumnName(rs.getString("COLUMN_NAME"));
                column.setDataType(rs.getInt("DATA_TYPE"));
                column.setRemarks(rs.getString("REMARKS"));
                column.setColumnSize(rs.getInt("COLUMN_SIZE"));
                column.setNullAble(rs.getString("IS_NULLABLE"));
                column.setDefaultValue(rs.getString("COLUMN_DEF"));
                column.setAutoIncrement(rs.getString("IS_AUTOINCREMENT"));
                columnlist.add(column);
            }
            table.setColumnlist(columnlist);
            return table;
        } catch (final Exception e) {
            e.printStackTrace();
        } finally {
            context.closeConns();
            DBFoundConfig.destory();
        }
        return null;
    }

}
