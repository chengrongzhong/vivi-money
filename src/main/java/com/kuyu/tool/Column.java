package com.kuyu.tool;

public class Column {
    private String columnName;
    private int dataType;
    private String type;
    private String remarks;
    private int columnSize;
    private boolean nullAble;
    private String defaultValue;
    private boolean autoIncrement;

    public String getColumnName() {
        return this.columnName.toLowerCase();
    }

    public void setColumnName(final String columnName) {
        this.columnName = columnName;
    }

    public int getDataType() {
        return this.dataType;
    }

    public void setDataType(final int dataType) {
        this.dataType = dataType;
    }

    public String getRemarks() {
        return this.remarks;
    }

    public void setRemarks(final String remarks) {
        this.remarks = remarks;
    }

    public int getColumnSize() {
        return this.columnSize;
    }

    public void setColumnSize(final int columnSize) {
        this.columnSize = columnSize;
    }

    public boolean isNullAble() {
        return this.nullAble;
    }

    public void setNullAble(final String nullAble) {
        if ("YES".equals(nullAble)) {
            this.nullAble = true;
        } else {
            this.nullAble = false;
        }
    }

    public String getDefaultValue() {
        return this.defaultValue;
    }

    public void setDefaultValue(final String defaultValue) {
        this.defaultValue = defaultValue;
    }

    public boolean isAutoIncrement() {
        return this.autoIncrement;
    }

    public void setAutoIncrement(final String autoIncrement) {
        if ("YES".equals(autoIncrement)) {
            this.autoIncrement = true;
        } else {
            this.autoIncrement = false;
        }
    }

    public String getExpress() {
        return "${@" + columnName + "}";
    }

    public String getType() {
        return type;
    }

    public void setType(final String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Column [columnName=" + this.columnName + ", dataType=" + this.dataType + ", remarks=" + this.remarks + ", columnSize=" + this.columnSize + ", nullAble=" + this.nullAble
                + ", defaultValue=" + this.defaultValue + ", autoIncrement=" + this.autoIncrement + "]";
    }
}
