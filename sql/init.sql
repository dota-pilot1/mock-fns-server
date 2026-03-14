-- 스키마 생성
CREATE SCHEMA IF NOT EXISTS fscps;

-- 매장 스케줄 테이블
CREATE TABLE IF NOT EXISTS fscps.bs_airstar_store_schedule (
    co_id               VARCHAR(20)     NOT NULL,
    store_id            VARCHAR(50)     NOT NULL,
    schedule_date       VARCHAR(8)      NOT NULL,
    open_status         VARCHAR(20),
    schedule_priority   NUMERIC,
    open_time           VARCHAR(6),
    last_order_time     VARCHAR(6),
    close_time          VARCHAR(6),
    closed_reason_kor   TEXT            NOT NULL DEFAULT '',
    closed_reason_en    TEXT            NOT NULL DEFAULT '',
    closed_reason_jp    TEXT,
    closed_reason_zh_cn TEXT            NOT NULL DEFAULT '',
    closed_reason_zh_tw TEXT,
    use_yn              VARCHAR(1)      NOT NULL DEFAULT 'Y',
    sync_status         VARCHAR(1)      NOT NULL DEFAULT 'C',
    regr_id             VARCHAR(50)     NOT NULL,
    reg_dttm            TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updt_id             VARCHAR(50),
    updt_dttm           TIMESTAMP,
    CONSTRAINT pk_bs_airstar_store_schedule PRIMARY KEY (co_id, store_id, schedule_date)
);

COMMENT ON TABLE  fscps.bs_airstar_store_schedule IS '인천공항 매장 스케줄';
COMMENT ON COLUMN fscps.bs_airstar_store_schedule.co_id IS '회사 ID';
COMMENT ON COLUMN fscps.bs_airstar_store_schedule.store_id IS 'Store ID (인천공항 연계 식별자)';
COMMENT ON COLUMN fscps.bs_airstar_store_schedule.schedule_date IS '정책 적용일 (YYYYMMDD)';
COMMENT ON COLUMN fscps.bs_airstar_store_schedule.open_status IS '오픈 상태';
COMMENT ON COLUMN fscps.bs_airstar_store_schedule.schedule_priority IS '우선순위';
COMMENT ON COLUMN fscps.bs_airstar_store_schedule.open_time IS '오픈 시간 (HHmmss)';
COMMENT ON COLUMN fscps.bs_airstar_store_schedule.last_order_time IS '라스트 오더 시간 (HHmmss)';
COMMENT ON COLUMN fscps.bs_airstar_store_schedule.close_time IS '닫는 시간 (HHmmss)';
COMMENT ON COLUMN fscps.bs_airstar_store_schedule.use_yn IS '사용여부 (Y/N)';
COMMENT ON COLUMN fscps.bs_airstar_store_schedule.sync_status IS '연동 상태 (C:FS생성, S:Airstar생성)';

-- 샘플 데이터 (2026년 3월)
INSERT INTO fscps.bs_airstar_store_schedule
    (co_id, store_id, schedule_date, open_status, schedule_priority, open_time, last_order_time, close_time, closed_reason_kor, closed_reason_en, closed_reason_zh_cn, use_yn, sync_status, regr_id)
VALUES
    ('FW00', 'STORE001', '20260301', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260302', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260303', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260304', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260305', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260306', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260307', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260308', 'HOLIDAY_CLOSED', 3, NULL,     NULL,     NULL,     '정기휴무', 'Regular Holiday', '定期休息', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260309', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260310', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260311', 'BREAK_TIME',     7, '090000', '140000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260312', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260313', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260314', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260315', 'HOLIDAY_CLOSED', 3, NULL,     NULL,     NULL,     '정기휴무', 'Regular Holiday', '定期休息', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260316', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260317', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260318', 'TEMPORARILY_CLOSED', 4, NULL, NULL,     NULL,     '시설점검', 'Facility Maintenance', '设施检查', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260319', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260320', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260321', 'OPEN',           9, '100000', '193000', '203000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260322', 'HOLIDAY_CLOSED', 3, NULL,     NULL,     NULL,     '정기휴무', 'Regular Holiday', '定期休息', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260323', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260324', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260325', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260326', 'SOLD_OUT',       6, '090000', '150000', '160000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260327', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260328', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260329', 'HOLIDAY_CLOSED', 3, NULL,     NULL,     NULL,     '정기휴무', 'Regular Holiday', '定期休息', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260330', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin'),
    ('FW00', 'STORE001', '20260331', 'OPEN',           9, '090000', '200000', '210000', '', '', '', 'Y', 'C', 'admin');
