package com.example.art_backend.response;

/**
 * 返回状态码
 */
public enum ResponseCode {
    /**
     * 成功返回的状态码
     */
    SUCCESS(200, "success"),
    /**
     * 资源不存在的状态码
     */
    RESOURCES_NOT_EXIST(201, "Resource does not exist!"),
    /**
     * 所有无法识别的异常默认的返回状态码
     */
    SERVICE_ERROR(500, "Server exception!"),

    JWT_EXPIRE(410,"token已经过期"),

    JWT_FALSE(411,"token验证失败"),

    LOGIN_FALSE(412,"用户名或密码错误"),

    LOGIN_NOT(413,"未登录"),

    REGISTER_USERNAME_DUPLICATE(414,"Username already exists!"),

    REGISTER_FALSE(415,"注册失败"),

    USER_NOT_EXIST(416,"User does not exist!"),

    INVALID_EMAIL(417,"INVALID_EMAIL"),

    REGISTER_EMAIL_DUPLICATE(418,"DUPLICATE_EMAIL"),

    INSUFFICIENT_BALANCE(419,"INSUFFICIENT_BALANCE"),

    ;
    /**
     * 状态码
     */
    private int status;
    /**
     * 返回信息
     */
    private String message;

    ResponseCode(int status, String message) {
        this.status = status;
        this.message = message;
    }

    public int getStatus() {
        return status;
    }

    public String getMessage() {
        return message;
    }
}
