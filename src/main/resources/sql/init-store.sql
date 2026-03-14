-- ============================================================
-- AIRSTAR 매장 마스터 테이블 + 시드 데이터
-- 실무 테이블: fscps.bs_airstar_store, fscps.bs_airstar_store_map
-- ============================================================

CREATE SCHEMA IF NOT EXISTS fscps;

-- ============================================================
-- 1) AIRSTAR 매장 마스터
-- ============================================================
CREATE TABLE IF NOT EXISTS fscps.bs_airstar_store (
    co_id            VARCHAR(20)  NOT NULL,
    store_id         VARCHAR(50)  NOT NULL,
    store_type_cd    VARCHAR(20),
    ste_id           VARCHAR(50),
    store_name_ko    VARCHAR(200),
    store_name_en    VARCHAR(200),
    store_name_jp    VARCHAR(200),
    store_name_zh_cn VARCHAR(200),
    store_name_zh_tw VARCHAR(200),
    use_yn           VARCHAR(1)   NOT NULL DEFAULT 'Y',
    regr_id          VARCHAR(50),
    reg_dttm         TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updt_id          VARCHAR(50),
    updt_dttm        TIMESTAMP,
    CONSTRAINT pk_bs_airstar_store PRIMARY KEY (co_id, store_id)
);

COMMENT ON TABLE  fscps.bs_airstar_store IS 'AIRSTAR 매장 마스터';
COMMENT ON COLUMN fscps.bs_airstar_store.co_id IS '회사 ID';
COMMENT ON COLUMN fscps.bs_airstar_store.store_id IS 'AIRSTAR 매장 ID';
COMMENT ON COLUMN fscps.bs_airstar_store.store_type_cd IS '매장 유형 코드 (AS003)';
COMMENT ON COLUMN fscps.bs_airstar_store.ste_id IS '사이트 코드';
COMMENT ON COLUMN fscps.bs_airstar_store.store_name_ko IS '매장 한글명';
COMMENT ON COLUMN fscps.bs_airstar_store.store_name_en IS '매장 영문명';
COMMENT ON COLUMN fscps.bs_airstar_store.use_yn IS '사용여부';

-- ============================================================
-- 시드 데이터: 매장 마스터
-- ============================================================
INSERT INTO fscps.bs_airstar_store (co_id, store_id, store_type_cd, ste_id, store_name_ko, store_name_en, use_yn, regr_id) VALUES
('FW00', 'STORE001', 'STANDALONE', '2650', '인천공항 T1 한식당',       'ICN T1 Korean Restaurant',    'Y', 'admin'),
('FW00', 'STORE002', 'STANDALONE', '2650', '인천공항 T1 양식당',       'ICN T1 Western Restaurant',   'Y', 'admin'),
('FW00', 'STORE003', 'FOODCOURT',  '2650', '인천공항 T1 푸드코트',     'ICN T1 Food Court',           'Y', 'admin'),
('FW00', 'STORE004', 'CORNER',     '2650', '인천공항 T1 디저트코너',   'ICN T1 Dessert Corner',       'Y', 'admin'),
('FW00', 'STORE005', 'STANDALONE', '2660', '인천공항 T2 일식당',       'ICN T2 Japanese Restaurant',  'Y', 'admin'),
('FW00', 'STORE006', 'FOODCOURT',  '2660', '인천공항 T2 푸드코트',     'ICN T2 Food Court',           'Y', 'admin'),
('FW00', 'STORE007', 'STANDALONE', '2620', '김포공항 한식당',          'Gimpo Korean Restaurant',     'Y', 'admin'),
('FW00', 'STORE008', 'POPUP',      '2620', '김포공항 팝업스토어',      'Gimpo Popup Store',           'Y', 'admin'),
('FW00', 'STORE009', 'KIOSK',      '2600', '김해공항 키오스크',        'Gimhae Kiosk',                'Y', 'admin'),
('FW00', 'STORE010', 'STANDALONE', '2630', '제주공항 식당',            'Jeju Airport Restaurant',     'N', 'admin')
ON CONFLICT (co_id, store_id) DO NOTHING;

-- ============================================================
-- 추가 스케줄 시드 데이터: STORE002 (2026년 3월)
-- ============================================================
INSERT INTO fscps.bs_airstar_store_schedule
    (co_id, store_id, schedule_date, open_status, schedule_priority, open_time, last_order_time, close_time, closed_reason_kor, closed_reason_en, closed_reason_zh_cn, use_yn, sync_status, regr_id)
VALUES
    ('FW00', 'STORE002', '20260301', 'OPEN',           9, '080000', '193000', '200000', '', '', '', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260302', 'OPEN',           9, '080000', '193000', '200000', '', '', '', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260303', 'HOLIDAY_CLOSED', 3, NULL,     NULL,     NULL,     '정기휴무(매주 화)', 'Closed on Tuesday', '周二休息', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260304', 'OPEN',           9, '080000', '193000', '200000', '', '', '', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260305', 'OPEN',           9, '080000', '193000', '200000', '', '', '', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260306', 'OPEN',           9, '080000', '193000', '200000', '', '', '', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260307', 'OPEN',           9, '080000', '193000', '200000', '', '', '', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260308', 'OPEN',           9, '080000', '193000', '200000', '', '', '', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260309', 'OPEN',           9, '080000', '193000', '200000', '', '', '', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260310', 'HOLIDAY_CLOSED', 3, NULL,     NULL,     NULL,     '정기휴무(매주 화)', 'Closed on Tuesday', '周二休息', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260311', 'OPEN',           9, '080000', '193000', '200000', '', '', '', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260312', 'OPEN',           9, '080000', '193000', '200000', '', '', '', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260313', 'OPEN',           9, '080000', '193000', '200000', '', '', '', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260314', 'BREAK_TIME',     7, '080000', '140000', '200000', '', '', '', 'Y', 'S', 'admin'),
    ('FW00', 'STORE002', '20260315', 'OPEN',           9, '080000', '193000', '200000', '', '', '', 'Y', 'S', 'admin')
ON CONFLICT (co_id, store_id, schedule_date) DO NOTHING;
