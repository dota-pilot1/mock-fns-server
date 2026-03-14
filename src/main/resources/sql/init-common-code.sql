-- ============================================================
-- 공통코드 테이블 생성 + 시드 데이터
-- 실무 테이블: fscps.cm_cl_code_m_if, fscps.cm_code_m_if
-- ============================================================

-- 스키마 생성
CREATE SCHEMA IF NOT EXISTS fscps;

-- ============================================================
-- 1) 분류코드 마스터
-- ============================================================
CREATE TABLE IF NOT EXISTS fscps.cm_cl_code_m_if (
    comm_cl_cd    VARCHAR(20)  NOT NULL,
    comm_cl_cd_nm VARCHAR(100) NOT NULL,
    use_yn        VARCHAR(1)   NOT NULL DEFAULT 'Y',
    reg_dttm      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (comm_cl_cd)
);

-- ============================================================
-- 2) 공통코드 마스터
-- ============================================================
CREATE TABLE IF NOT EXISTS fscps.cm_code_m_if (
    comm_cl_cd    VARCHAR(20)  NOT NULL,
    comm_cd       VARCHAR(50)  NOT NULL,
    comm_cd_nm    VARCHAR(200) NOT NULL,
    dflt_yn       VARCHAR(1)   DEFAULT 'N',
    up_comm_cd    VARCHAR(50),
    lnup_ord      VARCHAR(10),
    chartr_ref1   VARCHAR(200),
    chartr_ref2   VARCHAR(200),
    chartr_ref3   VARCHAR(200),
    chartr_ref4   VARCHAR(200),
    chartr_ref5   VARCHAR(200),
    num_ref1      INTEGER,
    num_ref2      INTEGER,
    num_ref3      INTEGER,
    num_ref4      INTEGER,
    num_ref5      INTEGER,
    use_yn        VARCHAR(1)   NOT NULL DEFAULT 'Y',
    reg_dttm      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (comm_cl_cd, comm_cd)
);

-- ============================================================
-- 시드 데이터: 분류코드
-- ============================================================
INSERT INTO fscps.cm_cl_code_m_if (comm_cl_cd, comm_cl_cd_nm, use_yn) VALUES
('AS001', '사용여부',         'Y'),
('AS003', '점포유형',         'Y'),
('AS004', '계약구분',         'Y'),
('AS006', '운영형태',         'Y'),
('AS007', '코너유형',         'Y'),
('AS008', '매장상태',         'Y'),
('AS009', '스케줄상태',       'Y'),
('AS020', '결제수단',         'Y'),
('FS438', '사업장',           'Y'),
('FS613', '브랜드구분',       'Y'),
('FS615', '전시카테고리유형', 'Y'),
('FS675', '매장기준정보구분', 'Y'),
('FS677', '요일구분',         'Y'),
('FS695', '긴급스케줄유형',   'Y'),
('FS705', '전시카테고리상태', 'Y'),
('FS811', '메뉴판유형',       'Y'),
('CB021', '세금구분',         'Y'),
('CB405', '통화',             'Y'),
('CB409', '단위',             'Y'),
('MNTYP', '메뉴유형',         'Y'),
('MNCNC', '메뉴개념',         'Y')
ON CONFLICT (comm_cl_cd) DO NOTHING;

-- ============================================================
-- 시드 데이터: 공통코드
-- ============================================================

-- AS001 사용여부
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord, dflt_yn) VALUES
('AS001', 'Y', '사용',   '1', 'Y'),
('AS001', 'N', '미사용', '2', 'N')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- AS003 점포유형
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('AS003', 'CORNER',     '코너',       '1'),
('AS003', 'STANDALONE', '독립매장',    '2'),
('AS003', 'POPUP',      '팝업스토어', '3'),
('AS003', 'FOODCOURT',  '푸드코트',   '4'),
('AS003', 'KIOSK',      '키오스크',   '5')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- AS004 계약구분
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('AS004', 'DIRECT',    '직영',   '1'),
('AS004', 'FRANCHISE', '가맹',   '2'),
('AS004', 'CONSIGN',   '위탁',   '3')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- AS006 운영형태
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('AS006', 'SELF',      '셀프서비스', '1'),
('AS006', 'FULL',      '풀서비스',   '2'),
('AS006', 'TAKEOUT',   '테이크아웃', '3'),
('AS006', 'DELIVERY',  '배달',       '4')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- AS007 코너유형
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('AS007', 'MAIN',    '메인코너',   '1'),
('AS007', 'SUB',     '서브코너',   '2'),
('AS007', 'DESSERT', '디저트코너', '3'),
('AS007', 'DRINK',   '음료코너',   '4')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- AS008 매장상태
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('AS008', 'ACTIVE',     '운영중',   '1'),
('AS008', 'INACTIVE',   '미운영',   '2'),
('AS008', 'PREPARING',  '준비중',   '3'),
('AS008', 'CLOSED',     '폐점',     '4')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- AS009 스케줄상태
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('AS009', 'OPEN',                '영업중',       '1'),
('AS009', 'CLOSED',              '영업종료',     '2'),
('AS009', 'OPENING_SOON',        '오픈예정',     '3'),
('AS009', 'BREAK_TIME',          '브레이크타임', '4'),
('AS009', 'SOLD_OUT',            '품절마감',     '5'),
('AS009', 'TEMPORARILY_CLOSED',  '임시휴무',     '6'),
('AS009', 'HOLIDAY_CLOSED',      '정기휴무',     '7'),
('AS009', 'PERMANENTLY_CLOSED',  '영구폐점',     '8'),
('AS009', 'PAUSED',              '일시중지',     '9')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- AS020 결제수단
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('AS020', 'CARD',   '카드',       '1'),
('AS020', 'CASH',   '현금',       '2'),
('AS020', 'MOBILE', '모바일결제', '3'),
('AS020', 'COUPON', '쿠폰',       '4')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- FS438 사업장
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('FS438', '2650', '인천공항T1',   '1'),
('FS438', '2660', '인천공항T2',   '2'),
('FS438', '2620', '김포공항',     '3'),
('FS438', '2600', '김해공항',     '4'),
('FS438', '2630', '제주공항',     '5'),
('FS438', '2260', '대구공항',     '6'),
('FS438', '2230', '청주공항',     '7'),
('FS438', '2041', '무안공항',     '8')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- FS613 브랜드구분
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('FS613', 'OWN',      '자체브랜드',   '1'),
('FS613', 'EXTERNAL', '외부브랜드',   '2'),
('FS613', 'COLLAB',   '콜라보브랜드', '3')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- FS615 전시카테고리유형
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('FS615', 'FOOD',    '음식',     '1'),
('FS615', 'DRINK',   '음료',     '2'),
('FS615', 'DESSERT', '디저트',   '3'),
('FS615', 'SET',     '세트메뉴', '4')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- FS675 매장기준정보구분
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('FS675', 'GENERAL', '일반매장',   '1'),
('FS675', 'CORNER',  '코너',       '2')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- FS677 요일구분
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('FS677', 'MON', '월요일', '1'),
('FS677', 'TUE', '화요일', '2'),
('FS677', 'WED', '수요일', '3'),
('FS677', 'THU', '목요일', '4'),
('FS677', 'FRI', '금요일', '5'),
('FS677', 'SAT', '토요일', '6'),
('FS677', 'SUN', '일요일', '7')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- FS695 긴급스케줄유형
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('FS695', 'EMERGENCY_CLOSE', '긴급휴무', '1'),
('FS695', 'EMERGENCY_OPEN',  '긴급영업', '2'),
('FS695', 'TIME_CHANGE',     '시간변경', '3')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- FS705 전시카테고리상태
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('FS705', 'ACTIVE',   '활성', '1'),
('FS705', 'INACTIVE', '비활성', '2')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- FS811 메뉴판유형
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('FS811', 'DIGITAL', '디지털메뉴판', '1'),
('FS811', 'PAPER',   '종이메뉴판',   '2'),
('FS811', 'KIOSK',   '키오스크메뉴', '3')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- CB021 세금구분
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('CB021', 'TAX',      '과세', '1'),
('CB021', 'TAX_FREE', '면세', '2'),
('CB021', 'ZERO',     '영세', '3')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- CB405 통화
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('CB405', 'KRW', '원화(KRW)', '1'),
('CB405', 'USD', '달러(USD)', '2'),
('CB405', 'JPY', '엔화(JPY)', '3'),
('CB405', 'CNY', '위안(CNY)', '4'),
('CB405', 'EUR', '유로(EUR)', '5')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- CB409 단위
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('CB409', 'EA',  '개',  '1'),
('CB409', 'SET', '세트', '2'),
('CB409', 'BOX', '박스', '3'),
('CB409', 'KG',  'kg',  '4'),
('CB409', 'G',   'g',   '5'),
('CB409', 'L',   'L',   '6'),
('CB409', 'ML',  'ml',  '7')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- MNTYP 메뉴유형
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord) VALUES
('MNTYP', '10', '단품',       '1'),
('MNTYP', '11', '단품(옵션)', '2'),
('MNTYP', '12', '단품(사이드)', '3'),
('MNTYP', '20', '세트',       '4'),
('MNTYP', '30', '옵션그룹',   '5'),
('MNTYP', '31', '옵션항목',   '6'),
('MNTYP', '40', '추가메뉴',   '7'),
('MNTYP', '50', '토핑',       '8'),
('MNTYP', '60', '음료',       '9'),
('MNTYP', '61', '음료(HOT)',  '10'),
('MNTYP', '62', '음료(ICE)',  '11'),
('MNTYP', '70', '기타',       '12')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;

-- MNCNC 메뉴개념
INSERT INTO fscps.cm_code_m_if (comm_cl_cd, comm_cd, comm_cd_nm, lnup_ord, chartr_ref2) VALUES
('MNCNC', 'KOREAN',   '한식',     '1', 'Y'),
('MNCNC', 'CHINESE',  '중식',     '2', 'Y'),
('MNCNC', 'JAPANESE', '일식',     '3', 'Y'),
('MNCNC', 'WESTERN',  '양식',     '4', 'Y'),
('MNCNC', 'SNACK',    '분식',     '5', 'Y'),
('MNCNC', 'DESSERT',  '디저트',   '6', 'Y'),
('MNCNC', 'DRINK',    '음료',     '7', 'Y'),
('MNCNC', 'FUSION',   '퓨전',     '8', 'Y')
ON CONFLICT (comm_cl_cd, comm_cd) DO NOTHING;
