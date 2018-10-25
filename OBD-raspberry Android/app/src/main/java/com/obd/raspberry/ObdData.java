package com.obd.raspberry;

public class ObdData {
    private String timestamp;
    private String msgcnt;
    private String cool_temp;
    private String rpm;
    private String time_after;
    private String vehicle_spd;
    private String engine_oil_temp;
    private String fuel_type;
    private String bettery_rmn;
    private String remain_oil;
    private String consume_oil;

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getMsgcnt() {
        return msgcnt;
    }

    public void setMsgcnt(String msgcnt) {
        this.msgcnt = msgcnt;
    }

    public String getCool_temp() {
        return cool_temp;
    }

    public void setCool_temp(String cool_temp) {
        this.cool_temp = cool_temp;
    }

    public String getRpm() {
        return rpm;
    }

    public void setRpm(String rpm) {
        this.rpm = rpm;
    }

    public String getTime_after() {
        return time_after;
    }

    public void setTime_after(String time_after) {
        this.time_after = time_after;
    }

    public String getVehicle_spd() {
        return vehicle_spd;
    }

    public void setVehicle_spd(String vehicle_spd) {
        this.vehicle_spd = vehicle_spd;
    }

    public String getEngine_oil_temp() {
        return engine_oil_temp;
    }

    public void setEngine_oil_temp(String engine_oil_temp) {
        this.engine_oil_temp = engine_oil_temp;
    }

    public String getFuel_type() {
        return fuel_type;
    }

    public void setFuel_type(String fuel_type) {
        this.fuel_type = fuel_type;
    }

    public String getBettery_rmn() {
        return bettery_rmn;
    }

    public void setBettery_rmn(String bettery_rmn) {
        this.bettery_rmn = bettery_rmn;
    }

    public String getRemain_oil() {
        return remain_oil;
    }

    public void setRemain_oil(String remain_oil) {
        this.remain_oil = remain_oil;
    }

    public String getConsume_oil() {
        return consume_oil;
    }

    public void setConsume_oil(String consume_oil) {
        this.consume_oil = consume_oil;
    }
}
