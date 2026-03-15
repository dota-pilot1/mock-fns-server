-- ============================================================
-- 메뉴 마스터 + 다국어 테이블 DDL & 시드 데이터
-- 실무 테이블: fscps.cm_program_m, fscps.cm_program_language_m
-- ============================================================

CREATE SCHEMA IF NOT EXISTS fscps;

-- ============================================================
-- 1) 프로그램(메뉴) 마스터
-- ============================================================
CREATE TABLE IF NOT EXISTS fscps.cm_program_m (
    prog_cd        VARCHAR(50)   NOT NULL,
    prog_nm        VARCHAR(200),
    prog_no        BIGINT        NOT NULL,
    prog_lvl       INTEGER       NOT NULL,
    up_prog_cd     VARCHAR(50),
    prog_url       VARCHAR(300),
    prog_url_args  VARCHAR(500),
    system_cl      VARCHAR(20)   NOT NULL DEFAULT 'FSBO',
    use_yn         VARCHAR(1)    NOT NULL DEFAULT 'Y',
    menu_yn        VARCHAR(1)    NOT NULL DEFAULT 'Y',
    btn1_nm        VARCHAR(100),
    btn2_nm        VARCHAR(100),
    btn3_nm        VARCHAR(100),
    btn4_nm        VARCHAR(100),
    btn5_nm        VARCHAR(100),
    btn6_nm        VARCHAR(100),
    btn7_nm        VARCHAR(100),
    btn8_nm        VARCHAR(100),
    btn9_nm        VARCHAR(100),
    btn10_nm       VARCHAR(100),
    regr_id        VARCHAR(50),
    reg_dttm       TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    updr_id        VARCHAR(50),
    updt_dttm      TIMESTAMP,
    CONSTRAINT pk_cm_program_m PRIMARY KEY (prog_cd)
);

CREATE INDEX IF NOT EXISTS idx_cm_program_m_no ON fscps.cm_program_m (prog_no);

COMMENT ON TABLE  fscps.cm_program_m IS '프로그램(메뉴) 마스터';
COMMENT ON COLUMN fscps.cm_program_m.prog_cd      IS '프로그램 코드';
COMMENT ON COLUMN fscps.cm_program_m.prog_nm      IS '프로그램 명';
COMMENT ON COLUMN fscps.cm_program_m.prog_no      IS '프로그램 번호 (정렬·계층)';
COMMENT ON COLUMN fscps.cm_program_m.prog_lvl     IS '프로그램 레벨 (3=GNB, 4=LNB, 5=leaf)';
COMMENT ON COLUMN fscps.cm_program_m.prog_url     IS '화면 URL (componentName)';
COMMENT ON COLUMN fscps.cm_program_m.prog_url_args IS '화면 URL 인자 (component path)';
COMMENT ON COLUMN fscps.cm_program_m.system_cl    IS '시스템 구분 (FSBO)';

-- ============================================================
-- 2) 프로그램 다국어 마스터
-- ============================================================
CREATE TABLE IF NOT EXISTS fscps.cm_program_language_m (
    prog_cd   VARCHAR(50)  NOT NULL,
    lang_cl   VARCHAR(10)  NOT NULL,
    prog_nm   VARCHAR(200),
    regr_id   VARCHAR(50),
    reg_dttm  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_cm_program_language_m PRIMARY KEY (prog_cd, lang_cl)
);

COMMENT ON TABLE  fscps.cm_program_language_m IS '프로그램 다국어명';

-- ============================================================
-- 시드 데이터: cm_program_m
-- ============================================================
-- 계층 규칙:
--   prog_no 6자리 = Lv3 (GNB)
--   prog_no 8자리 = Lv4 (LNB 서브메뉴)
--   prog_no 10자리 = Lv5 (하위 메뉴 = 실제 화면)
--   up_prog_no = substring(prog_no, 1, length-2)
-- ============================================================

-- ────────────────────────────────────────────────
-- Lv3 GNB 메뉴
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-310100', '인천공항관리',   073101, 3, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-310200', '메뉴관리',       073201, 3, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-310300', '커뮤니티',       073301, 3, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-310400', '매출관리',       073401, 3, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-310500', '마감관리',       073501, 3, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-310600', '시스템관리',     073601, 3, 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv4 서브메뉴 — 인천공항관리 (073101xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-31010100', '브랜드 관리',         07310101, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31010200', '전시 카테고리 관리',  07310102, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31010300', '사이트 관리',         07310103, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31010400', '매장 기준정보',       07310104, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31010500', '매장 메뉴관리',       07310105, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31010600', '쿠폰 관리',           07310106, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31010700', '직원 관리',           07310107, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31010800', 'POS 관리',            07310108, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31010900', '상품 관리',           07310109, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31011000', '프로모션 관리',       07310110, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31011100', '판매단가 관리',       07310111, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31011200', '코너 관리',           07310112, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31011300', 'Airstar 매장관리',    07310113, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31011400', '인천공항 매장관리',   07310114, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31011500', '매장 전시카테고리',   07310115, 4, 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — 브랜드 관리 (0731010101xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101010001', '입점 브랜드 관리', 0731010101, 5, 'BrandRtrv', 'pages/cps/base/brandmng/BrandRtrv', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — 전시 카테고리 관리 (0731010201xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101020001', '전시 카테고리 관리', 0731010201, 5, 'ShopDspCtgMng', 'pages/cps/base/shopdspctg/ShopDspCtgMng', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101020002', '매장별 카테고리 관리', 0731010202, 5, 'CtgByShopMng', 'pages/cps/base/shopdspctg/CtgByShopMng', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — 사이트 관리 (0731010301xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101030001', '사이트 조회', 0731010301, 5, 'SteRtrv', 'pages/cps/base/stemng/SteRtrv', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101030002', '통합정산 대상 사이트', 0731010302, 5, 'InteSttlObjSteMng', 'pages/cps/base/stemng/InteSttlObjSteMng', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — 매장 기준정보 (0731010401xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101040001', '사용 매장(사이트) 관리', 0731010401, 5, 'ShopMstrMng', 'pages/cps/base/shopmng/ShopMstrMng', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101040002', '환율 관리',              0731010402, 5, 'ExrtMng',     'pages/cps/base/shopmng/ExrtMng',     'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101040003', 'Airstar 매장 관리',      0731010403, 5, 'AirstarStoreMng', 'pages/cps/base/airstarstoremng/AirstarStoreMng', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101040004', '인천공항 매장 관리',     0731010404, 5, 'IcnAirportShopMng', 'pages/cps/base/icnairportmng/IcnAirportShopMng', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101040005', '매장 스케줄 관리',       0731010405, 5, 'ShopScheduleMng', 'pages/cps/base/shopschedulemng/ShopScheduleMng', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101040006', '매장 스케줄 긴급 설정',  0731010406, 5, 'ShopScheduleEmgcMng', 'pages/cps/base/shopschedulemng/ShopScheduleEmgcMng', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — 매장 메뉴관리 (0731010501xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101050001', '사이트 메뉴 관리',     0731010501, 5, 'SteMenuMng',  'pages/cps/base/menumng/SteMenuMng',  'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101050002', '세트 메뉴 관리',       0731010502, 5, 'SetMenuMng',  'pages/cps/base/menumng/SetMenuMng',  'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101050003', '메뉴 그룹 관리',       0731010503, 5, 'MenuGrupMng', 'pages/cps/base/menumng/MenuGrupMng', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101050004', '메뉴 옵션 관리',       0731010504, 5, 'MenuOptMng',  'pages/cps/base/menumng/MenuOptMng',  'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101050005', '세트 옵션 관리',       0731010505, 5, 'SetOptMng',   'pages/cps/base/menumng/SetOptMng',   'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101050006', '그룹 메뉴 속성 관리',  0731010506, 5, 'GrupMenuAttrMng', 'pages/cps/base/menumng/GrupMenuAttrMng', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101050007', '메뉴 상품 조회',       0731010507, 5, 'MenuGoodsRtrv', 'pages/cps/base/menumng/MenuGoodsRtrv', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101050008', '코너 메뉴 관리',       0731010508, 5, 'CrnrMenuMng', 'pages/cps/base/crnrmenumng/CrnrMenuMng', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — 쿠폰 관리 (0731010601xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101060001', '쿠폰 마스터 관리',     0731010601, 5, 'CponMstMng',      'pages/cps/base/cponmng/CponMstMng',      'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101060002', '쿠폰 발행 관리',       0731010602, 5, 'CponPblMng',      'pages/cps/base/cponmng/CponPblMng',      'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101060003', '발행 쿠폰 조회',       0731010603, 5, 'PblCponRtrv',     'pages/cps/base/cponmng/PblCponRtrv',     'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101060004', '쿠폰 발행 상세 조회',  0731010604, 5, 'CponPblDetlRtrv', 'pages/cps/base/cponmng/CponPblDetlRtrv', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101060005', '쿠폰 사용 상세 조회',  0731010605, 5, 'CponUseDetlRtrv', 'pages/cps/base/cponmng/CponUseDetlRtrv', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — 직원 관리 (0731010701xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101070001', '직원 정보 수정',       0731010701, 5, 'EmpInfoUpdt',   'pages/cps/base/empmng/EmpInfoUpdt',   'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101070002', '직원 정보 업로드',     0731010702, 5, 'EmpInfoUpload', 'pages/cps/base/empmng/EmpInfoUpload', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — POS 관리 (0731010801xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101080001', '광고 그룹 관리',       0731010801, 5, 'AdGrupMng',       'pages/cps/base/posmng/AdGrupMng',       'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101080002', '장비 마스터 관리',     0731010802, 5, 'EqipMstMng',      'pages/cps/base/posmng/EqipMstMng',      'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101080003', 'POS 영수증 관리',      0731010803, 5, 'PosBillMng',      'pages/cps/base/posmng/PosBillMng',      'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101080004', '장비 현황 조회',       0731010804, 5, 'EqipSttRtrv',     'pages/cps/base/posmng/EqipSttRtrv',     'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101080005', 'K-DEVICE 마스터 관리', 0731010805, 5, 'KdeviceMstMng',   'pages/cps/base/posmng/KdeviceMstMng',   'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101080006', '프로그램 배포 관리',   0731010806, 5, 'PgmDstMng',       'pages/cps/base/posmng/PgmDstMng',       'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101080007', '프로그램 배포 상세',   0731010807, 5, 'PgmDstDetlMng',   'pages/cps/base/posmng/PgmDstDetlMng',   'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101080008', 'POS 공지 기사 관리',   0731010808, 5, 'PosAnnoAtcMng',   'pages/cps/base/posmng/PosAnnoAtcMng',   'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101080009', 'POS 공지 조회',        0731010809, 5, 'PosAnnoRtrv',     'pages/cps/base/posmng/PosAnnoRtrv',     'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101080010', 'POS 작업키 그룹 관리', 0731010810, 5, 'PosJobKeyGrupMng','pages/cps/base/posmng/PosJobKeyGrupMng','FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101080011', 'POS 패턴 그룹 관리',   0731010811, 5, 'PosPtnGrupMng',   'pages/cps/base/posmng/PosPtnGrupMng',   'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101080012', 'VAN 마스터 관리',      0731010812, 5, 'VanMstMng',       'pages/cps/base/posmng/VanMstMng',       'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101080013', '캐셔 마스터 관리',     0731010813, 5, 'CashierMstMng',   'pages/cps/base/posmng/CashierMstMng',   'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101080014', '정산 마스터 관리',     0731010814, 5, 'CalcMstMng',      'pages/cps/base/posmng/CalcMstMng',      'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — 상품 관리 (0731010901xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101090001', '상품 기준 관리',       0731010901, 5, 'ProdBaseMng',  'pages/cps/base/prodbasemng/ProdBaseMng',  'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101090002', '상품 가격 관리',       0731010902, 5, 'ProdPriceMng', 'pages/cps/base/prodpricemng/ProdPriceMng', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — 프로모션 관리 (0731011001xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101100001', '프로모션 등록 관리',     0731011001, 5, 'PrmtRegMng',    'pages/cps/base/prmtmng/PrmtRegMng',    'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101100002', '프로모션 조회',           0731011002, 5, 'PrmtRtrv',      'pages/cps/base/prmtmng/PrmtRtrv',      'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101100003', '프로모션 사용 요청',     0731011003, 5, 'PrmtUseReq',    'pages/cps/base/prmtmng/PrmtUseReq',    'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101100004', '프로모션 사용 요청 승인', 0731011004, 5, 'PrmtUseReqAck', 'pages/cps/base/prmtmng/PrmtUseReqAck', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — 판매단가 관리 (0731011101xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101110001', '판매단가 변경요청 등록',   0731011101, 5, 'SaleUprcChngReqReg', 'pages/cps/base/saleuprcmng/SaleUprcChngReqReg', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101110002', '판매단가 변경요청 승인',   0731011102, 5, 'SaleUprcChngReqAck', 'pages/cps/base/saleuprcmng/SaleUprcChngReqAck', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101110003', '판매단가 가이드 등록',     0731011103, 5, 'SaleUprcGdrReg',     'pages/cps/base/saleuprcmng/SaleUprcGdrReg',     'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101110004', '판매단가 가이드 조회',     0731011104, 5, 'SaleUprcGdrRegRtrv', 'pages/cps/base/saleuprcmng/SaleUprcGdrRegRtrv', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101110005', '사이트 단가 조회',         0731011105, 5, 'SteUprcRtrv',        'pages/cps/base/saleuprcmng/SteUprcRtrv',        'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — 코너 관리 (0731011201xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101120001', '코너 그룹/코너 관리', 0731011201, 5, 'CrnrGrupCrnrMng', 'pages/cps/base/crnrmng/CrnrGrupCrnrMng', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — Airstar 매장관리 (0731011301xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101130001', 'Airstar 매장 관리', 0731011301, 5, 'AirstarStoreMng', 'pages/cps/base/airstarstoremng/AirstarStoreMng', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv5 화면 — 매장 전시카테고리 (0731011501xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3101150001', '매장 전시카테고리 관리', 0731011501, 5, 'ShopDspCtgMng', 'pages/cps/base/shopdspctg/ShopDspCtgMng', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3101150002', '카테고리별 매장 관리',   0731011502, 5, 'CtgByShopMng',  'pages/cps/base/shopdspctg/CtgByShopMng',  'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv4 서브메뉴 — 메뉴관리 (073201xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-31020100', '표준메뉴 관리',   07320101, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31020200', '위생 관리',       07320102, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31020300', '레시피 관리',     07320103, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31020400', '일괄변경 관리',   07320104, 4, 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- Lv5 — 표준메뉴 관리
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3102010001', '표준메뉴 관리 목록', 0732010101, 5, 'StdMenuMngLst', 'pages/menu/standard/StdMenuMngLst', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- Lv5 — 위생 관리
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3102020001', '금지 식재료 메뉴 관리', 0732010201, 5, 'PhbtFdingrMenuMng', 'pages/menu/hygiene/PhbtFdingrMenuMng', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- Lv5 — 레시피 관리
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3102030001', '사이트 레시피 제공', 0732010301, 5, 'SteRecipPsnt', 'pages/menu/rp/SteRecipPsnt', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- Lv5 — 일괄변경 관리
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3102040001', '표준메뉴 일괄변경', 0732010401, 5, 'StdMenuLumpChng', 'pages/menu/masschange/StdMenuLumpChng', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv4 서브메뉴 — 커뮤니티 (073301xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-31030100', '노하우 관리',     07330101, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31030200', '장터 관리',       07330102, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31030300', '사전주문 관리',   07330103, 4, 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-31030400', '상품공지 관리',   07330104, 4, 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- Lv5 — 커뮤니티 화면들
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3103010001', '메뉴 운영 노하우 관리', 0733010101, 5, 'MenuOperKnohowMng', 'pages/cmmty/know/MenuOperKnohowMng', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3103020001', '신선 장바구니 목록',     0733010201, 5, 'FrsCrtLst',         'pages/cmmty/market/FrsCrtLst',       'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3103030001', '사전주문 신청 관리',     0733010301, 5, 'PreGoodsAplctMng',  'pages/cmmty/preorder/PreGoodsAplctMng','FSBO','Y','Y', 'admin'),
('!P!C-COM-FS-3103040001', '프로모션 목록',           0733010401, 5, 'PrmtLst',           'pages/cmmty/prdnotice/PrmtLst',      'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv4 서브메뉴 — 매출관리 (073401xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-31040100', '매출 리포트',     07340101, 4, 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- Lv5 — 매출 리포트
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3104010001', '메뉴별 매출',        0734010101, 5, 'SalesMenu',    'pages/cps/sales/salesrpt/SalesMenu',    'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3104010002', '메뉴분류별 매출',    0734010102, 5, 'SalesMenuCls', 'pages/cps/sales/salesrpt/SalesMenuCls', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv4 서브메뉴 — 마감관리 (073501xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-31050100', '마감 관리',       07350101, 4, 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- Lv5 — 마감관리 화면들
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3105010001', '수기 메뉴매출 등록',   0735010101, 5, 'MnulMenuSalesReg', 'pages/cps/closing/closingmng/MnulMenuSalesReg', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3105010002', 'POS 매출 등록',         0735010102, 5, 'PosSalesReg',      'pages/cps/closing/closingmng/PosSalesReg',      'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3105010003', '일마감 조회',           0735010103, 5, 'DailyClosingRtrv', 'pages/cps/closing/closingmng/DailyClosingRtrv', 'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3105010004', '매출확정',              0735010104, 5, 'SalesAckComp',     'pages/cps/closing/closingmng/SalesAckComp',     'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3105010005', '매출정산 조정',         0735010105, 5, 'SalesCalcAdj',     'pages/cps/closing/closingmng/SalesCalcAdj',     'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3105010006', '매출원장 조회',         0735010106, 5, 'SalesLedgerRtrv',  'pages/cps/closing/closingmng/SalesLedgerRtrv',  'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3105010007', '매장 전도금 등록',      0735010107, 5, 'ShopGdohReg',      'pages/cps/closing/closingmng/ShopGdohReg',      'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3105010008', '전도금 등록취소 승인',  0735010108, 5, 'GdohRegCnclAprv',  'pages/cps/closing/closingmng/GdohRegCnclAprv',  'FSBO', 'Y', 'Y', 'admin'),
('!P!C-COM-FS-3105010009', '수기 고객매출 등록',    0735010109, 5, 'MnulCustSalesReg', 'pages/cps/closing/closingmng/MnulCustSalesReg', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ────────────────────────────────────────────────
-- Lv4 서브메뉴 — 시스템관리 (073601xx)
-- ────────────────────────────────────────────────
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-31060100', '시스템 관리',     07360101, 4, 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- Lv5 — 시스템관리
INSERT INTO fscps.cm_program_m (prog_cd, prog_nm, prog_no, prog_lvl, prog_url, prog_url_args, system_cl, use_yn, menu_yn, regr_id) VALUES
('!P!C-COM-FS-3106010001', '그룹 권한 관리', 0736010101, 5, 'GrupAuthMng', 'pages/cps/system/systemmng/GrupAuthMng', 'FSBO', 'Y', 'Y', 'admin')
ON CONFLICT (prog_cd) DO NOTHING;

-- ============================================================
-- 시드 데이터: cm_program_language_m (한국어)
-- ============================================================

-- Lv3 GNB
INSERT INTO fscps.cm_program_language_m (prog_cd, lang_cl, prog_nm, regr_id) VALUES
('!P!C-COM-FS-310100', 'ko', '인천공항관리', 'admin'),
('!P!C-COM-FS-310200', 'ko', '메뉴관리',     'admin'),
('!P!C-COM-FS-310300', 'ko', '커뮤니티',     'admin'),
('!P!C-COM-FS-310400', 'ko', '매출관리',     'admin'),
('!P!C-COM-FS-310500', 'ko', '마감관리',     'admin'),
('!P!C-COM-FS-310600', 'ko', '시스템관리',   'admin')
ON CONFLICT (prog_cd, lang_cl) DO NOTHING;

-- Lv4 인천공항관리
INSERT INTO fscps.cm_program_language_m (prog_cd, lang_cl, prog_nm, regr_id) VALUES
('!P!C-COM-FS-31010100', 'ko', '브랜드 관리',         'admin'),
('!P!C-COM-FS-31010200', 'ko', '전시 카테고리 관리',  'admin'),
('!P!C-COM-FS-31010300', 'ko', '사이트 관리',         'admin'),
('!P!C-COM-FS-31010400', 'ko', '매장 기준정보',       'admin'),
('!P!C-COM-FS-31010500', 'ko', '매장 메뉴관리',       'admin'),
('!P!C-COM-FS-31010600', 'ko', '쿠폰 관리',           'admin'),
('!P!C-COM-FS-31010700', 'ko', '직원 관리',           'admin'),
('!P!C-COM-FS-31010800', 'ko', 'POS 관리',            'admin'),
('!P!C-COM-FS-31010900', 'ko', '상품 관리',           'admin'),
('!P!C-COM-FS-31011000', 'ko', '프로모션 관리',       'admin'),
('!P!C-COM-FS-31011100', 'ko', '판매단가 관리',       'admin'),
('!P!C-COM-FS-31011200', 'ko', '코너 관리',           'admin'),
('!P!C-COM-FS-31011300', 'ko', 'Airstar 매장관리',    'admin'),
('!P!C-COM-FS-31011400', 'ko', '인천공항 매장관리',   'admin'),
('!P!C-COM-FS-31011500', 'ko', '매장 전시카테고리',   'admin')
ON CONFLICT (prog_cd, lang_cl) DO NOTHING;

-- Lv4 메뉴관리
INSERT INTO fscps.cm_program_language_m (prog_cd, lang_cl, prog_nm, regr_id) VALUES
('!P!C-COM-FS-31020100', 'ko', '표준메뉴 관리',   'admin'),
('!P!C-COM-FS-31020200', 'ko', '위생 관리',       'admin'),
('!P!C-COM-FS-31020300', 'ko', '레시피 관리',     'admin'),
('!P!C-COM-FS-31020400', 'ko', '일괄변경 관리',   'admin')
ON CONFLICT (prog_cd, lang_cl) DO NOTHING;

-- Lv4 커뮤니티
INSERT INTO fscps.cm_program_language_m (prog_cd, lang_cl, prog_nm, regr_id) VALUES
('!P!C-COM-FS-31030100', 'ko', '노하우 관리',     'admin'),
('!P!C-COM-FS-31030200', 'ko', '장터 관리',       'admin'),
('!P!C-COM-FS-31030300', 'ko', '사전주문 관리',   'admin'),
('!P!C-COM-FS-31030400', 'ko', '상품공지 관리',   'admin')
ON CONFLICT (prog_cd, lang_cl) DO NOTHING;

-- Lv4 매출/마감/시스템
INSERT INTO fscps.cm_program_language_m (prog_cd, lang_cl, prog_nm, regr_id) VALUES
('!P!C-COM-FS-31040100', 'ko', '매출 리포트',   'admin'),
('!P!C-COM-FS-31050100', 'ko', '마감 관리',     'admin'),
('!P!C-COM-FS-31060100', 'ko', '시스템 관리',   'admin')
ON CONFLICT (prog_cd, lang_cl) DO NOTHING;

-- Lv5 화면 (주요 화면만 — 나머지는 prog_nm 사용)
INSERT INTO fscps.cm_program_language_m (prog_cd, lang_cl, prog_nm, regr_id) VALUES
('!P!C-COM-FS-3101010001', 'ko', '입점 브랜드 관리',         'admin'),
('!P!C-COM-FS-3101040001', 'ko', '사용 매장(사이트) 관리',   'admin'),
('!P!C-COM-FS-3101040005', 'ko', '매장 스케줄 관리',         'admin'),
('!P!C-COM-FS-3101040006', 'ko', '매장 스케줄 긴급 설정',    'admin'),
('!P!C-COM-FS-3101050001', 'ko', '사이트 메뉴 관리',         'admin'),
('!P!C-COM-FS-3101050002', 'ko', '세트 메뉴 관리',           'admin'),
('!P!C-COM-FS-3101050003', 'ko', '메뉴 그룹 관리',           'admin'),
('!P!C-COM-FS-3101060001', 'ko', '쿠폰 마스터 관리',         'admin'),
('!P!C-COM-FS-3101080001', 'ko', '광고 그룹 관리',           'admin'),
('!P!C-COM-FS-3101080002', 'ko', '장비 마스터 관리',         'admin'),
('!P!C-COM-FS-3101080003', 'ko', 'POS 영수증 관리',          'admin'),
('!P!C-COM-FS-3101100001', 'ko', '프로모션 등록 관리',       'admin'),
('!P!C-COM-FS-3101110001', 'ko', '판매단가 변경요청 등록',   'admin'),
('!P!C-COM-FS-3105010001', 'ko', '수기 메뉴매출 등록',       'admin'),
('!P!C-COM-FS-3105010002', 'ko', 'POS 매출 등록',            'admin'),
('!P!C-COM-FS-3106010001', 'ko', '그룹 권한 관리',           'admin')
ON CONFLICT (prog_cd, lang_cl) DO NOTHING;
