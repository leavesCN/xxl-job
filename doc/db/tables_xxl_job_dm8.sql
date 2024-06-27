CREATE TABLE "XXL_JOB_GROUP"
(
    "ID" INT AUTO_INCREMENT NOT NULL,
    "APP_NAME" VARCHAR(64) NOT NULL,
    "TITLE" VARCHAR(12) NOT NULL,
    "ADDRESS_TYPE" TINYINT DEFAULT 0 NOT NULL,
    "ADDRESS_LIST" TEXT,
    "UPDATE_TIME" TIMESTAMP(0),
    NOT CLUSTER PRIMARY KEY("ID"))  AUTO_INCREMENT = 1;

COMMENT ON COLUMN "XXL_JOB_GROUP"."ADDRESS_LIST" IS '执行器地址列表，多地址逗号分隔';
COMMENT ON COLUMN "XXL_JOB_GROUP"."ADDRESS_TYPE" IS '执行器地址类型：0=自动注册、1=手动录入';
COMMENT ON COLUMN "XXL_JOB_GROUP"."APP_NAME" IS '执行器AppName';
COMMENT ON COLUMN "XXL_JOB_GROUP"."TITLE" IS '执行器名称';


CREATE TABLE "XXL_JOB_INFO"
(
    "ID" INT AUTO_INCREMENT NOT NULL,
    "JOB_GROUP" INT NOT NULL,
    "JOB_DESC" VARCHAR(255) NOT NULL,
    "ADD_TIME" TIMESTAMP(0),
    "UPDATE_TIME" TIMESTAMP(0),
    "AUTHOR" VARCHAR(64),
    "ALARM_EMAIL" VARCHAR(255),
    "SCHEDULE_TYPE" VARCHAR(50) DEFAULT 'NONE' NOT NULL,
    "SCHEDULE_CONF" VARCHAR(128),
    "MISFIRE_STRATEGY" VARCHAR(50) DEFAULT 'DO_NOTHING' NOT NULL,
    "EXECUTOR_ROUTE_STRATEGY" VARCHAR(50),
    "EXECUTOR_HANDLER" VARCHAR(255),
    "EXECUTOR_PARAM" VARCHAR(512),
    "EXECUTOR_BLOCK_STRATEGY" VARCHAR(50),
    "EXECUTOR_TIMEOUT" INT DEFAULT 0 NOT NULL,
    "EXECUTOR_FAIL_RETRY_COUNT" INT DEFAULT 0 NOT NULL,
    "GLUE_TYPE" VARCHAR(50) NOT NULL,
    "GLUE_SOURCE" CLOB,
    "GLUE_REMARK" VARCHAR(128),
    "GLUE_UPDATETIME" TIMESTAMP(0),
    "CHILD_JOBID" VARCHAR(255),
    "TRIGGER_STATUS" TINYINT DEFAULT 0 NOT NULL,
    "TRIGGER_LAST_TIME" BIGINT DEFAULT 0 NOT NULL,
    "TRIGGER_NEXT_TIME" BIGINT DEFAULT 0 NOT NULL,
    NOT CLUSTER PRIMARY KEY("ID"))  AUTO_INCREMENT = 1;

COMMENT ON COLUMN "XXL_JOB_INFO"."ALARM_EMAIL" IS '报警邮件';
COMMENT ON COLUMN "XXL_JOB_INFO"."AUTHOR" IS '作者';
COMMENT ON COLUMN "XXL_JOB_INFO"."CHILD_JOBID" IS '子任务ID，多个逗号分隔';
COMMENT ON COLUMN "XXL_JOB_INFO"."EXECUTOR_BLOCK_STRATEGY" IS '阻塞处理策略';
COMMENT ON COLUMN "XXL_JOB_INFO"."EXECUTOR_FAIL_RETRY_COUNT" IS '失败重试次数';
COMMENT ON COLUMN "XXL_JOB_INFO"."EXECUTOR_HANDLER" IS '执行器任务handler';
COMMENT ON COLUMN "XXL_JOB_INFO"."EXECUTOR_PARAM" IS '执行器任务参数';
COMMENT ON COLUMN "XXL_JOB_INFO"."EXECUTOR_ROUTE_STRATEGY" IS '执行器路由策略';
COMMENT ON COLUMN "XXL_JOB_INFO"."EXECUTOR_TIMEOUT" IS '任务执行超时时间，单位秒';
COMMENT ON COLUMN "XXL_JOB_INFO"."GLUE_REMARK" IS 'GLUE备注';
COMMENT ON COLUMN "XXL_JOB_INFO"."GLUE_SOURCE" IS 'GLUE源代码';
COMMENT ON COLUMN "XXL_JOB_INFO"."GLUE_TYPE" IS 'GLUE类型';
COMMENT ON COLUMN "XXL_JOB_INFO"."GLUE_UPDATETIME" IS 'GLUE更新时间';
COMMENT ON COLUMN "XXL_JOB_INFO"."JOB_GROUP" IS '执行器主键ID';
COMMENT ON COLUMN "XXL_JOB_INFO"."MISFIRE_STRATEGY" IS '调度过期策略';
COMMENT ON COLUMN "XXL_JOB_INFO"."SCHEDULE_CONF" IS '调度配置，值含义取决于调度类型';
COMMENT ON COLUMN "XXL_JOB_INFO"."SCHEDULE_TYPE" IS '调度类型';
COMMENT ON COLUMN "XXL_JOB_INFO"."TRIGGER_LAST_TIME" IS '上次调度时间';
COMMENT ON COLUMN "XXL_JOB_INFO"."TRIGGER_NEXT_TIME" IS '下次调度时间';
COMMENT ON COLUMN "XXL_JOB_INFO"."TRIGGER_STATUS" IS '调度状态：0-停止，1-运行';


CREATE TABLE "XXL_JOB_LOCK"
(
    "LOCK_NAME" VARCHAR(50) NOT NULL,
    NOT CLUSTER PRIMARY KEY("LOCK_NAME"))  ;

COMMENT ON COLUMN "XXL_JOB_LOCK"."LOCK_NAME" IS '锁名称';


CREATE TABLE "XXL_JOB_LOG"
(
    "ID" BIGINT AUTO_INCREMENT NOT NULL,
    "JOB_GROUP" INT NOT NULL,
    "JOB_ID" INT NOT NULL,
    "EXECUTOR_ADDRESS" VARCHAR(255),
    "EXECUTOR_HANDLER" VARCHAR(255),
    "EXECUTOR_PARAM" VARCHAR(512),
    "EXECUTOR_SHARDING_PARAM" VARCHAR(20),
    "EXECUTOR_FAIL_RETRY_COUNT" INT DEFAULT 0 NOT NULL,
    "TRIGGER_TIME" TIMESTAMP(0),
    "TRIGGER_CODE" INT NOT NULL,
    "TRIGGER_MSG" TEXT,
    "HANDLE_TIME" TIMESTAMP(0),
    "HANDLE_CODE" INT NOT NULL,
    "HANDLE_MSG" TEXT,
    "ALARM_STATUS" TINYINT DEFAULT 0 NOT NULL,
    NOT CLUSTER PRIMARY KEY("ID"))  AUTO_INCREMENT = 1;

COMMENT ON COLUMN "XXL_JOB_LOG"."ALARM_STATUS" IS '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败';
COMMENT ON COLUMN "XXL_JOB_LOG"."EXECUTOR_ADDRESS" IS '执行器地址，本次执行的地址';
COMMENT ON COLUMN "XXL_JOB_LOG"."EXECUTOR_FAIL_RETRY_COUNT" IS '失败重试次数';
COMMENT ON COLUMN "XXL_JOB_LOG"."EXECUTOR_HANDLER" IS '执行器任务handler';
COMMENT ON COLUMN "XXL_JOB_LOG"."EXECUTOR_PARAM" IS '执行器任务参数';
COMMENT ON COLUMN "XXL_JOB_LOG"."EXECUTOR_SHARDING_PARAM" IS '执行器任务分片参数，格式如 1/2';
COMMENT ON COLUMN "XXL_JOB_LOG"."HANDLE_CODE" IS '执行-状态';
COMMENT ON COLUMN "XXL_JOB_LOG"."HANDLE_MSG" IS '执行-日志';
COMMENT ON COLUMN "XXL_JOB_LOG"."HANDLE_TIME" IS '执行-时间';
COMMENT ON COLUMN "XXL_JOB_LOG"."JOB_GROUP" IS '执行器主键ID';
COMMENT ON COLUMN "XXL_JOB_LOG"."JOB_ID" IS '任务，主键ID';
COMMENT ON COLUMN "XXL_JOB_LOG"."TRIGGER_CODE" IS '调度-结果';
COMMENT ON COLUMN "XXL_JOB_LOG"."TRIGGER_MSG" IS '调度-日志';
COMMENT ON COLUMN "XXL_JOB_LOG"."TRIGGER_TIME" IS '调度-时间';


CREATE OR REPLACE  INDEX "I_TRIGGER_TIME" ON "XXL_JOB_LOG"("TRIGGER_TIME" ASC)  ;
CREATE OR REPLACE  INDEX "I_HANDLE_CODE" ON "XXL_JOB_LOG"("HANDLE_CODE" ASC)  ;

CREATE TABLE "XXL_JOB_LOG_REPORT"
(
    "ID" INT AUTO_INCREMENT NOT NULL,
    "TRIGGER_DAY" TIMESTAMP(0),
    "RUNNING_COUNT" INT DEFAULT 0 NOT NULL,
    "SUC_COUNT" INT DEFAULT 0 NOT NULL,
    "FAIL_COUNT" INT DEFAULT 0 NOT NULL,
    "UPDATE_TIME" TIMESTAMP(0),
    NOT CLUSTER PRIMARY KEY("ID"),
    CONSTRAINT "I_TRIGGER_DAY" UNIQUE("TRIGGER_DAY"))  AUTO_INCREMENT = 1;

COMMENT ON COLUMN "XXL_JOB_LOG_REPORT"."FAIL_COUNT" IS '执行失败-日志数量';
COMMENT ON COLUMN "XXL_JOB_LOG_REPORT"."RUNNING_COUNT" IS '运行中-日志数量';
COMMENT ON COLUMN "XXL_JOB_LOG_REPORT"."SUC_COUNT" IS '执行成功-日志数量';
COMMENT ON COLUMN "XXL_JOB_LOG_REPORT"."TRIGGER_DAY" IS '调度-时间';


CREATE TABLE "XXL_JOB_LOGGLUE"
(
    "ID" INT AUTO_INCREMENT NOT NULL,
    "JOB_ID" INT NOT NULL,
    "GLUE_TYPE" VARCHAR(50),
    "GLUE_SOURCE" CLOB,
    "GLUE_REMARK" VARCHAR(128) NOT NULL,
    "ADD_TIME" TIMESTAMP(0),
    "UPDATE_TIME" TIMESTAMP(0),
    NOT CLUSTER PRIMARY KEY("ID"))  AUTO_INCREMENT = 1;

COMMENT ON COLUMN "XXL_JOB_LOGGLUE"."GLUE_REMARK" IS 'GLUE备注';
COMMENT ON COLUMN "XXL_JOB_LOGGLUE"."GLUE_SOURCE" IS 'GLUE源代码';
COMMENT ON COLUMN "XXL_JOB_LOGGLUE"."GLUE_TYPE" IS 'GLUE类型';
COMMENT ON COLUMN "XXL_JOB_LOGGLUE"."JOB_ID" IS '任务，主键ID';


CREATE TABLE "XXL_JOB_REGISTRY"
(
    "ID" INT AUTO_INCREMENT NOT NULL,
    "REGISTRY_GROUP" VARCHAR(50) NOT NULL,
    "REGISTRY_KEY" VARCHAR(255) NOT NULL,
    "REGISTRY_VALUE" VARCHAR(255) NOT NULL,
    "UPDATE_TIME" TIMESTAMP(0),
    NOT CLUSTER PRIMARY KEY("ID"))  AUTO_INCREMENT = 1;

CREATE OR REPLACE  INDEX "I_G_K_V" ON "XXL_JOB_REGISTRY"("REGISTRY_GROUP" ASC,"REGISTRY_KEY" ASC,"REGISTRY_VALUE" ASC)  ;

CREATE TABLE "XXL_JOB_USER"
(
    "ID" INT AUTO_INCREMENT NOT NULL,
    "USERNAME" VARCHAR(50) NOT NULL,
    "PASSWORD" VARCHAR(50) NOT NULL,
    "ROLE" TINYINT NOT NULL,
    "PERMISSION" VARCHAR(255),
    NOT CLUSTER PRIMARY KEY("ID"),
    CONSTRAINT "I_USERNAME" UNIQUE("USERNAME"))  AUTO_INCREMENT = 1;

COMMENT ON COLUMN "XXL_JOB_USER"."PASSWORD" IS '密码';
COMMENT ON COLUMN "XXL_JOB_USER"."PERMISSION" IS '权限：执行器ID列表，多个逗号分割';
COMMENT ON COLUMN "XXL_JOB_USER"."ROLE" IS '角色：0-普通用户、1-管理员';
COMMENT ON COLUMN "XXL_JOB_USER"."USERNAME" IS '账号';


INSERT INTO XXL_JOB_USER (ID, USERNAME, PASSWORD, ROLE, PERMISSION) VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, null);
