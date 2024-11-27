create or replace PACKAGE BODY             portal_ucontrol_test
AS
   FUNCTION GetActivatedDialsCount (p_cust_code IN VARCHAR2)
      RETURN INTEGER
   IS
      thecount   INTEGER;
   BEGIN
      SELECT COUNT (dial)
        INTO thecount
        FROM (SELECT DISTINCT ca.dial
                FROM (    SELECT customer_id, custcode
                            FROM customer_all
                      CONNECT BY     PRIOR customer_id = customer_id_high
                                 AND paymntresp IS NULL
                                 AND cstype = 'a'
                      START WITH custcode = p_cust_code) cu
                     INNER JOIN NKADM.corp_acc_serv_new ca
                        ON ca.customer_id = cu.customer_id
                     INNER JOIN profile_service ps
                        ON ps.co_id = ca.co_id
                     INNER JOIN pr_serv_status_hist psh
                        ON     psh.co_id = ps.co_id
                           AND psh.sncode = ps.sncode
                           AND psh.profile_id = ps.profile_id
                           AND psh.histno = ps.status_histno
               WHERE     ps.sncode IN
                            (1,
                             26,
                             27,
                             10,
                             106,
                             11,
                             119,
                             12,
                             120,
                             121,
                             122,
                             123,
                             145,
                             318,
                             319,
                             32,
                             381,
                             401,
                             413,
                             414,
                             415,
                             416,
                             443,
                             456,
                             457,
                             458,
                             459,
                             46,
                             67,
                             68,
                             77,
                             86,
                             92)
                     AND ca.contract_status = 'a'
                     AND (   NOT EXISTS
                                (SELECT 1
                                   FROM profile_service
                                  WHERE co_id = ca.co_id AND sncode = 68)
                          OR EXISTS
                                (SELECT 1
                                   FROM profile_service ps2,
                                        pr_serv_status_hist psh2
                                  WHERE     ps2.co_id = ca.co_id
                                        AND psh2.co_id = ps2.co_id
                                        AND psh2.sncode = ps2.sncode
                                        AND psh2.profile_id = ps2.profile_id
                                        AND psh2.histno = ps2.status_histno
                                        AND ps2.sncode = 68
                                        AND ps2.profile_id = 0
                                        AND psh2.status = 'D')));

      RETURN thecount;
   END;

   FUNCTION GetVlntrySuspendedDialsCount (p_cust_code IN VARCHAR2)
      RETURN INTEGER
   IS
      thecount   INTEGER;
   BEGIN
      SELECT COUNT (dial)
        INTO thecount
        FROM (SELECT DISTINCT ca.dial
                FROM (    SELECT customer_id, custcode
                            FROM customer_all
                      CONNECT BY     PRIOR customer_id = customer_id_high
                                 AND paymntresp IS NULL
                                 AND cstype = 'a'
                      START WITH custcode = p_cust_code) cu
                     INNER JOIN NKADM.corp_acc_serv_new ca
                        ON ca.customer_id = cu.customer_id
                     INNER JOIN profile_service ps
                        ON ps.co_id = ca.co_id
                     INNER JOIN pr_serv_status_hist psh
                        ON     psh.co_id = ps.co_id
                           AND psh.sncode = ps.sncode
                           AND psh.profile_id = ps.profile_id
                           AND psh.histno = ps.status_histno
               WHERE     ps.sncode IN
                            (1,
                             26,
                             27,
                             10,
                             106,
                             11,
                             119,
                             12,
                             120,
                             121,
                             122,
                             123,
                             145,
                             318,
                             319,
                             32,
                             381,
                             401,
                             413,
                             414,
                             415,
                             416,
                             443,
                             456,
                             457,
                             458,
                             459,
                             46,
                             67,
                             68,
                             77,
                             86,
                             92)
                     AND (    ca.contract_status = 's'
                          AND ps.sncode = 119
                          AND psh.status = 'S'));

      RETURN thecount;
   END;

   FUNCTION GetInvlntrySuspendedDialsCount (p_cust_code IN VARCHAR2)
      RETURN INTEGER
   IS
      thecount   INTEGER;
   BEGIN
      SELECT COUNT (dial)
        INTO thecount
        FROM (SELECT DISTINCT ca.dial
                FROM (    SELECT customer_id, custcode
                            FROM customer_all
                      CONNECT BY     PRIOR customer_id = customer_id_high
                                 AND paymntresp IS NULL
                                 AND cstype = 'a'
                      START WITH custcode = p_cust_code) cu
                     INNER JOIN NKADM.corp_acc_serv_new ca
                        ON ca.customer_id = cu.customer_id
                     INNER JOIN profile_service ps
                        ON ps.co_id = ca.co_id
                     INNER JOIN pr_serv_status_hist psh
                        ON     psh.co_id = ps.co_id
                           AND psh.sncode = ps.sncode
                           AND psh.profile_id = ps.profile_id
                           AND psh.histno = ps.status_histno
               WHERE     ps.sncode IN
                            (1,
                             26,
                             27,
                             10,
                             106,
                             11,
                             119,
                             12,
                             120,
                             121,
                             122,
                             123,
                             145,
                             318,
                             319,
                             32,
                             381,
                             401,
                             413,
                             414,
                             415,
                             416,
                             443,
                             456,
                             457,
                             458,
                             459,
                             46,
                             67,
                             68,
                             77,
                             86,
                             92)
                     AND ca.contract_status = 's'
                     AND (   (ps.sncode = 119 AND psh.status = 'D')
                          OR (NOT EXISTS
                                 (SELECT 1
                                    FROM profile_service
                                   WHERE co_id = ca.co_id AND sncode = 119))));

      RETURN thecount;
   END;

   FUNCTION GetSoftDisconnectedCount (p_cust_code IN VARCHAR2)
      RETURN INTEGER
   IS
      thecount   INTEGER;
   BEGIN
      SELECT COUNT (dial)
        INTO thecount
        FROM (SELECT DISTINCT ca.dial
                FROM (    SELECT customer_id, custcode
                            FROM customer_all
                      CONNECT BY     PRIOR customer_id = customer_id_high
                                 AND paymntresp IS NULL
                                 AND cstype = 'a'
                      START WITH custcode = p_cust_code) cu
                     INNER JOIN NKADM.corp_acc_serv_new ca
                        ON ca.customer_id = cu.customer_id
                     INNER JOIN profile_service ps
                        ON ps.co_id = ca.co_id
                     INNER JOIN pr_serv_status_hist psh
                        ON     psh.co_id = ps.co_id
                           AND psh.sncode = ps.sncode
                           AND psh.profile_id = ps.profile_id
                           AND psh.histno = ps.status_histno
               WHERE     ca.contract_status = 'a'
                     AND ps.sncode = 68
                     AND psh.status = 'A');

      RETURN thecount;
   END;

   PROCEDURE GetAccountOverview (p_cust_code                 IN     VARCHAR2,
                                 p_activated_count              OUT INTEGER,
                                 p_vlntrysuspended_count        OUT INTEGER,
                                 p_invlntrysuspended_count      OUT INTEGER,
                                 p_softdisconnected_count       OUT INTEGER)
   IS
    v_INVC_TIME date;
   v_RES_TIME date;
   BEGIN
     execute immediate        'alter session set nls_date_format = ''DD-MON-YYYY HH24:MI:SS'' ';
      BEGIN
         SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
           INTO v_INVC_TIME
           FROM DUAL;
      END;
   BEGIN
      BEGIN
         SELECT getactivateddialscount (p_cust_code)
           INTO p_activated_count
           FROM DUAL;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_activated_count := 0;
      END;

      BEGIN
         SELECT getvlntrysuspendeddialscount (p_cust_code)
           INTO p_vlntrysuspended_count
           FROM DUAL;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_vlntrysuspended_count := 0;
      END;

      BEGIN
         SELECT getinvlntrysuspendeddialscount (p_cust_code)
           INTO p_invlntrysuspended_count
           FROM DUAL;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_invlntrysuspended_count := 0;
      END;

      BEGIN
         SELECT getsoftdisconnectedcount (p_cust_code)
           INTO p_softdisconnected_count
           FROM DUAL;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_softdisconnected_count := 0;
      END;
      BEGIN
                     SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;

                        Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetAccountOverview','PORTAL',v_INVC_TIME,'SUCCESS',v_RES_TIME,
                        p_cust_code,null,null,null,null,'Success',p_activated_count,null,null,null,null,null,null,null,null);
                    commit;
                    exception
                    when OTHERS
                          THEN
                            DBMS_OUTPUT.PUT_LINE(SQLERRM);
                       END;
   END;
END;
   PROCEDURE GetLineDetails (p_cust_code       IN     VARCHAR2,
                             p_line_id         IN     INTEGER,
                             services_cursor      OUT cursorreference,
                             failure_id           OUT INTEGER,
                             failure_reason       OUT VARCHAR2)
   IS
   --logging part
   v_INVC_TIME date;
   v_RES_TIME date;
   BEGIN
     execute immediate        'alter session set nls_date_format = ''DD-MON-YYYY HH24:MI:SS'' ';
      BEGIN
         SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
           INTO v_INVC_TIME
           FROM DUAL;
      END;
--end
   BEGIN
      OPEN services_cursor FOR
         SELECT ca.co_id lineid,
                cu.custcode custcode,
                ca.dial dial,
                ca.contract_status contractstatus,
                ca.typ TYPE,
                ca.tm tm,
                ca.rate_plan rateplan,
                (CASE WHEN ps.sncode = ca.sncode THEN 'X' ELSE NULL END)
                   mainsp,
                psp.spcode spcode,
                (CASE WHEN ca.sncode = 1 THEN sp.des ELSE ca.rate_plan END)
                   servicepackage,
                ps.sncode sncode,
                sn.des service,
                LOWER (psh.status) servicestatus
           FROM (    SELECT customer_id, custcode
                       FROM customer_all
                 CONNECT BY     PRIOR customer_id = customer_id_high
                            AND paymntresp IS NULL
                            AND cstype = 'a'
                 START WITH custcode = p_cust_code) cu
                INNER JOIN NKADM.corp_acc_serv_new ca
                   ON ca.customer_id = cu.customer_id
                INNER JOIN profile_service ps
                   ON ps.co_id = ca.co_id
                INNER JOIN pr_serv_spcode_hist psp
                   ON     psp.co_id = ps.co_id
                      AND psp.sncode = ps.sncode
                      AND psp.profile_id = ps.profile_id
                      AND psp.histno = ps.spcode_histno
                INNER JOIN pr_serv_status_hist psh
                   ON     psh.co_id = ps.co_id
                      AND psh.sncode = ps.sncode
                      AND psh.profile_id = ps.profile_id
                      AND psh.histno = ps.status_histno
                INNER JOIN mpusptab sp
                   ON sp.spcode = psp.spcode
                INNER JOIN mpusntab sn
                   ON sn.sncode = ps.sncode
          WHERE     ps.sncode IN
                       (1,
                        26,
                        27,
                        10,
                        106,
                        11,
                        119,
                        12,
                        120,
                        121,
                        122,
                        123,
                        145,
                        318,
                        319,
                        32,
                        381,
                        401,
                        413,
                        414,
                        415,
                        416,
                        443,
                        456,
                        457,
                        458,
                        459,
                        46,
                        67,
                        68,
                        77,
                        86,
                        92)
                AND ps.sncode = ca.sncode -- MAIN_SP = 'X'
                AND ca.co_id = p_line_id
                AND ROWNUM <= 1;

      failure_id := 0;
      failure_reason := 'Success';
--Second part Logging
  BEGIN
                     SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;

                        Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetLineDetails','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_line_id,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
                    exception
                    when OTHERS
                          THEN
                            DBMS_OUTPUT.PUT_LINE(SQLERRM);
                       END;      
   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            failure_id := 112;
            failure_reason := SQLCODE || ': ' || SQLERRM;
            
            SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;
            Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetLineDetails','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_line_id,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
         END;
   END;
END;

   PROCEDURE GetLineDetailsByDialNumber (
      p_cust_code       IN     VARCHAR2,
      p_dial_number     IN     VARCHAR2,
      services_cursor      OUT cursorreference,
      failure_id           OUT INTEGER,
      failure_reason       OUT VARCHAR2)
   IS
   v_INVC_TIME date;
   v_RES_TIME date;
   BEGIN
   execute immediate        'alter session set nls_date_format = ''DD-MON-YYYY HH24:MI:SS'' ';
      BEGIN
         SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
           INTO v_INVC_TIME
           FROM DUAL;
      END;
   BEGIN
      OPEN services_cursor FOR
         SELECT ca.co_id lineid,
                cu.custcode custcode,
                ca.dial dial,
                ca.contract_status contractstatus,
                ca.typ TYPE,
                ca.tm tm,
                ca.rate_plan rateplan,
                (CASE WHEN ps.sncode = ca.sncode THEN 'X' ELSE NULL END)
                   mainsp,
                psp.spcode spcode,
                (CASE WHEN ca.sncode = 1 THEN sp.des ELSE ca.rate_plan END)
                   servicepackage,
                ps.sncode sncode,
                sn.des service,
                LOWER (psh.status) servicestatus
           FROM (    SELECT customer_id, custcode
                       FROM customer_all
                 CONNECT BY     PRIOR customer_id = customer_id_high
                            AND paymntresp IS NULL
                            AND cstype = 'a'
                 START WITH custcode = p_cust_code) cu
                INNER JOIN NKADM.corp_acc_serv_new ca
                   ON ca.customer_id = cu.customer_id
                INNER JOIN profile_service ps
                   ON ps.co_id = ca.co_id
                INNER JOIN pr_serv_spcode_hist psp
                   ON     psp.co_id = ps.co_id
                      AND psp.sncode = ps.sncode
                      AND psp.profile_id = ps.profile_id
                      AND psp.histno = ps.spcode_histno
                INNER JOIN pr_serv_status_hist psh
                   ON     psh.co_id = ps.co_id
                      AND psh.sncode = ps.sncode
                      AND psh.profile_id = ps.profile_id
                      AND psh.histno = ps.status_histno
                INNER JOIN mpusptab sp
                   ON sp.spcode = psp.spcode
                INNER JOIN mpusntab sn
                   ON sn.sncode = ps.sncode
          WHERE     ps.sncode IN
                       (1,
                        26,
                        27,
                        10,
                        106,
                        11,
                        119,
                        12,
                        120,
                        121,
                        122,
                        123,
                        145,
                        318,
                        319,
                        32,
                        381,
                        401,
                        413,
                        414,
                        415,
                        416,
                        443,
                        456,
                        457,
                        458,
                        459,
                        46,
                        67,
                        68,
                        77,
                        86,
                        92)
                AND ps.sncode = ca.sncode -- MAIN_SP = 'X'
                AND ca.dial = p_dial_number
                AND ROWNUM <= 1;

      failure_id := 0;
      failure_reason := 'Success';
                  BEGIN
                     SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;

                        Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetLineDetailsByDialNumber','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
                    exception
                    when OTHERS
                          THEN
                            DBMS_OUTPUT.PUT_LINE(SQLERRM);
                       END;

   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            failure_id := 112;
            failure_reason := SQLCODE || ': ' || SQLERRM;
            
            SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;
            Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetLineDetailsByDialNumber','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
         END;
    END;
END;

   PROCEDURE FilterDials (p_cust_code         IN     VARCHAR2,
                          p_dials_list        IN     VARCHAR2 := NULL,
                          p_dial_number       IN     VARCHAR2 := NULL,
                          p_start_dial        IN     VARCHAR2 := NULL,
                          p_end_dial          IN     VARCHAR2 := NULL,
                          p_service_code      IN     INTEGER := NULL,
                          p_service_status    IN     VARCHAR2 := NULL,
                          p_rate_plan_code    IN     INTEGER := NULL,
                          p_package_code      IN     VARCHAR2 := NULL,
                          p_isdatalines       IN     INTEGER := NULL,
                          p_contract_status   IN     VARCHAR2 := NULL,
                          p_start_row_index   IN     INTEGER,
                          p_page_size         IN     INTEGER,
                          services_cursor        OUT cursorreference,
                          failure_id             OUT INTEGER,
                          failure_reason         OUT VARCHAR2)
   IS
   --Begin LOGGING
    v_INVC_TIME date;
   v_RES_TIME date;
   BEGIN
     execute immediate        'alter session set nls_date_format = ''DD-MON-YYYY HH24:MI:SS'' ';
      BEGIN
         SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
           INTO v_INVC_TIME
           FROM DUAL;
      END;
     -- End first part
   BEGIN
      OPEN services_cursor FOR
         SELECT lineid,
                custcode,
                dial,
                contractstatus,
                TYPE,
                tm,
                rateplan,
                mainsp,
                spcode,
                servicepackage,
                sncode,
                service service,
                servicestatus,
                totalrowscount
           FROM (SELECT lineid,
                        custcode,
                        dial dial,
                        co_status contractstatus,
                        typ TYPE,
                        tm tm,
                        rate_plan rateplan,
                        main_sp mainsp,
                        sp spcode,
                        service_package servicepackage,
                        sn sncode,
                        service service,
                        sn_status servicestatus,
                        COUNT (*) OVER () totalrowscount,
                        ROW_NUMBER () OVER (ORDER BY custcode) AS ROWNUMBER
                   FROM (SELECT /*+ INDEX(CA CUSTOMER_ID_IDX) */
                               ca.co_id lineid,
                                cu.custcode custcode,
                                ca.dial,
                                ca.contract_status co_status,
                                ca.typ,
                                ca.tm,
                                ca.rate_plan,
                                (CASE
                                    WHEN ps.sncode = ca.sncode THEN 'X'
                                    ELSE NULL
                                 END)
                                   main_sp,
                                psp.spcode sp,
                                (CASE
                                    WHEN ca.sncode = 1 THEN sp.des
                                    ELSE ca.rate_plan
                                 END)
                                   service_package,
                                ps.sncode sn,
                                sn.des service,
                                LOWER (psh.status) sn_status
                           FROM (    SELECT customer_id, custcode
                                       FROM customer_all
                                 CONNECT BY     PRIOR customer_id =
                                                   customer_id_high
                                            AND paymntresp IS NULL
                                            AND cstype = 'a'
                                 START WITH custcode = p_cust_code) cu
                                INNER JOIN NKADM.corp_acc_serv_new ca
                                   ON ca.customer_id = cu.customer_id
                                INNER JOIN profile_service ps
                                   ON ps.co_id = ca.co_id
                                INNER JOIN pr_serv_spcode_hist psp
                                   ON     psp.co_id = ps.co_id
                                      AND psp.sncode = ps.sncode
                                      AND psp.profile_id = ps.profile_id
                                      AND psp.histno = ps.spcode_histno
                                INNER JOIN pr_serv_status_hist psh
                                   ON     psh.co_id = ps.co_id
                                      AND psh.sncode = ps.sncode
                                      AND psh.profile_id = ps.profile_id
                                      AND psh.histno = ps.status_histno
                                INNER JOIN mpusptab sp
                                   ON sp.spcode = psp.spcode
                                INNER JOIN mpusntab sn
                                   ON sn.sncode = ps.sncode
                          WHERE     ps.sncode IN
                                       (1,
                                        26,
                                        27,
                                        10,
                                        106,
                                        11,
                                        119,
                                        12,
                                        120,
                                        121,
                                        122,
                                        123,
                                        145,
                                        318,
                                        319,
                                        32,
                                        381,
                                        401,
                                        413,
                                        414,
                                        415,
                                        416,
                                        443,
                                        456,
                                        457,
                                        458,
                                        459,
                                        46,
                                        67,
                                        68,
                                        77,
                                        86,
                                        92)
                                AND (   ca.tm IN (87, 97, 152, 108, 109)
                                     OR p_isdatalines IS NULL
                                     OR p_isdatalines = 0)
                                AND (   psp.spcode = p_rate_plan_code
                                     OR p_rate_plan_code IS NULL)
                                AND (   ca.typ = p_package_code
                                     OR p_package_code IS NULL)
                                AND (   (ca.dial LIKE
                                            ('%' || p_dial_number || '%'))
                                     OR p_dial_number IS NULL)
                                AND (   ca.dial >= p_start_dial
                                     OR p_start_dial IS NULL)
                                AND (   ca.dial <= p_end_dial
                                     OR p_end_dial IS NULL)
                                AND (   p_contract_status IS NULL
                                     OR (    p_contract_status = 'a'
                                         AND ca.contract_status = 'a'
                                         AND (   NOT EXISTS
                                                        (SELECT 1
                                                           FROM profile_service
                                                          WHERE     co_id =
                                                                       ca.co_id
                                                                AND sncode =
                                                                       68)
                                              OR EXISTS
                                                    (SELECT 1
                                                       FROM profile_service ps2,
                                                            pr_serv_status_hist psh2
                                                      WHERE     ps2.co_id =
                                                                   ca.co_id
                                                            AND psh2.co_id =
                                                                   ps2.co_id
                                                            AND psh2.sncode =
                                                                   ps2.sncode
                                                            AND psh2.profile_id =
                                                                   ps2.profile_id
                                                            AND psh2.histno =
                                                                   ps2.status_histno
                                                            AND ps2.sncode =
                                                                   68
                                                            AND ps2.profile_id =
                                                                   0
                                                            AND psh2.status =
                                                                   'D')))
                                     OR (    p_contract_status = 'f'
                                         AND ca.contract_status = 'a'
                                         AND EXISTS
                                                (SELECT 1
                                                   FROM profile_service ps2,
                                                        pr_serv_status_hist psh2
                                                  WHERE     ps2.co_id =
                                                               ca.co_id
                                                        AND psh2.co_id =
                                                               ps2.co_id
                                                        AND psh2.sncode =
                                                               ps2.sncode
                                                        AND psh2.profile_id =
                                                               ps2.profile_id
                                                        AND psh2.histno =
                                                               ps2.status_histno
                                                        AND ps2.sncode = 68
                                                        AND ps2.profile_id =
                                                               0
                                                        AND psh2.status = 'A'))
                                     OR (    p_contract_status =
                                                ca.contract_status
                                         AND p_contract_status NOT IN
                                                ('a', 'f')))
                                AND (   ca.dial IN
                                           (    SELECT REGEXP_SUBSTR (
                                                          p_dials_list,
                                                          '[^,]+',
                                                          1,
                                                          LEVEL)
                                                  FROM DUAL
                                            CONNECT BY REGEXP_SUBSTR (
                                                          p_dials_list,
                                                          '[^,]+',
                                                          1,
                                                          LEVEL)
                                                          IS NOT NULL)
                                     OR p_dials_list IS NULL)
                                AND (   (    p_service_code IS NULL
                                         AND p_service_status IS NULL)
                                     OR EXISTS
                                           (SELECT 1
                                              FROM profile_service PS3,
                                                   pr_serv_status_hist psh3
                                             WHERE     ps3.co_id = ca.co_id
                                                   AND psh3.co_id = ps3.co_id
                                                   AND psh3.sncode =
                                                          ps3.sncode
                                                   AND psh3.profile_id =
                                                          ps3.profile_id
                                                   AND psh3.histno =
                                                          ps3.status_histno
                                                   AND ps3.sncode =
                                                          p_service_code
                                                   AND ps3.profile_id = 0
                                                   AND LOWER (psh3.status) =
                                                          LOWER (
                                                             p_service_status)))) allrecords
                  WHERE main_sp = 'X')
          WHERE (   (   p_page_size = 0
                     OR (rownumber BETWEEN p_start_row_index + 1
                                       AND p_start_row_index + p_page_size))
                 OR (p_page_size IS NULL AND p_start_row_index IS NULL));



      failure_id := 0;
      failure_reason := 'Success';
      
       BEGIN
                     SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;

                        Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('FilterDials','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
                    exception
                    when OTHERS
                          THEN
                            DBMS_OUTPUT.PUT_LINE(SQLERRM);
                       END;
                   
   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            failure_id := 112;
            failure_reason := SQLCODE || ': ' || SQLERRM;
            
            SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;
            Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('FilterDials','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
         END;
   END;
End;    

   PROCEDURE FilterIControlDials (
      p_cust_code         IN     VARCHAR2,
      p_dial_number       IN     VARCHAR2 := NULL,
      p_start_dial        IN     VARCHAR2 := NULL,
      p_end_dial          IN     VARCHAR2 := NULL,
      p_service_code      IN     INTEGER := NULL,
      p_service_status    IN     VARCHAR2 := NULL,
      p_rate_plan         IN     VARCHAR2 := NULL,
      p_package_code      IN     VARCHAR2 := NULL,
      p_contract_status   IN     VARCHAR2 := NULL,
      p_start_row_index   IN     INTEGER,
      p_page_size         IN     INTEGER,
      services_cursor        OUT cursorreference,
      failure_id             OUT INTEGER,
      failure_reason         OUT VARCHAR2)
   IS
   
    v_INVC_TIME date;
   v_RES_TIME date;
   BEGIN
     execute immediate        'alter session set nls_date_format = ''DD-MON-YYYY HH24:MI:SS'' ';
      BEGIN
         SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
           INTO v_INVC_TIME
           FROM DUAL;
      END;
      
   BEGIN
      OPEN services_cursor FOR
         SELECT lineid,
                custcode,
                dial dial,
                co_status contractstatus,
                typ TYPE,
                tm tm,
                rate_plan rateplan,
                main_sp mainsp,
                sp spcode,
                service_package servicepackage,
                sn sncode,
                service service,
                sn_status servicestatus,
                totalrowscount
           FROM (SELECT ca.co_id lineid,
                        cu.custcode custcode,
                        ca.dial,
                        ca.contract_status co_status,
                        ca.typ,
                        ca.tm,
                        ca.rate_plan,
                        (CASE
                            WHEN ps.sncode = ca.sncode THEN 'X'
                            ELSE NULL
                         END)
                           main_sp,
                        psp.spcode sp,
                        (CASE
                            WHEN ca.sncode = 1 THEN sp.des
                            ELSE ca.rate_plan
                         END)
                           service_package,
                        ps.sncode sn,
                        sn.des service,
                        LOWER (psh.status) sn_status,
                        COUNT (*) OVER () totalrowscount,
                        ROW_NUMBER () OVER (ORDER BY cu.custcode) rownumber
                   FROM (    SELECT customer_id, custcode
                               FROM customer_all
                         CONNECT BY     PRIOR customer_id = customer_id_high
                                    AND paymntresp IS NULL
                                    AND cstype = 'a'
                         START WITH custcode = p_cust_code) cu
                        INNER JOIN NKADM.corp_acc_serv_new ca
                           ON ca.customer_id = cu.customer_id
                        INNER JOIN profile_service ps
                           ON ps.co_id = ca.co_id
                        INNER JOIN pr_serv_spcode_hist psp
                           ON     psp.co_id = ps.co_id
                              AND psp.sncode = ps.sncode
                              AND psp.profile_id = ps.profile_id
                              AND psp.histno = ps.spcode_histno
                        INNER JOIN pr_serv_status_hist psh
                           ON     psh.co_id = ps.co_id
                              AND psh.sncode = ps.sncode
                              AND psh.profile_id = ps.profile_id
                              AND psh.histno = ps.status_histno
                        INNER JOIN mpusptab sp
                           ON sp.spcode = psp.spcode
                        INNER JOIN mpusntab sn
                           ON sn.sncode = ps.sncode
                  WHERE     ps.sncode IN
                               (1,
                                26,
                                27,
                                10,
                                106,
                                11,
                                119,
                                12,
                                120,
                                121,
                                122,
                                123,
                                145,
                                318,
                                319,
                                32,
                                381,
                                401,
                                413,
                                414,
                                415,
                                416,
                                443,
                                456,
                                457,
                                458,
                                459,
                                46,
                                67,
                                68,
                                77,
                                86,
                                92)
                        AND (   ca.rate_plan = p_rate_plan
                             OR p_rate_plan IS NULL)
                        AND (   ca.typ = p_package_code
                             OR p_package_code IS NULL)
                        AND (   (ca.dial LIKE ('%' || p_dial_number || '%'))
                             OR p_dial_number IS NULL)
                        AND (ca.dial >= p_start_dial OR p_start_dial IS NULL)
                        AND (ca.dial <= p_end_dial OR p_end_dial IS NULL)
                        AND (   p_contract_status IS NULL
                             OR (    p_contract_status = 'a'
                                 AND ca.contract_status = 'a'
                                 AND (   NOT EXISTS
                                                (SELECT 1
                                                   FROM profile_service
                                                  WHERE     co_id = ca.co_id
                                                        AND sncode = 68)
                                      OR EXISTS
                                            (SELECT 1
                                               FROM profile_service ps2,
                                                    pr_serv_status_hist psh2
                                              WHERE     ps2.co_id = ca.co_id
                                                    AND psh2.co_id =
                                                           ps2.co_id
                                                    AND psh2.sncode =
                                                           ps2.sncode
                                                    AND psh2.profile_id =
                                                           ps2.profile_id
                                                    AND psh2.histno =
                                                           ps2.status_histno
                                                    AND ps2.sncode = 68
                                                    AND ps2.profile_id = 0
                                                    AND psh2.status = 'D')))
                             OR (    p_contract_status = 'f'
                                 AND ca.contract_status = 'a'
                                 AND EXISTS
                                        (SELECT 1
                                           FROM profile_service ps2,
                                                pr_serv_status_hist psh2
                                          WHERE     ps2.co_id = ca.co_id
                                                AND psh2.co_id = ps2.co_id
                                                AND psh2.sncode = ps2.sncode
                                                AND psh2.profile_id =
                                                       ps2.profile_id
                                                AND psh2.histno =
                                                       ps2.status_histno
                                                AND ps2.sncode = 68
                                                AND ps2.profile_id = 0
                                                AND psh2.status = 'A'))
                             OR (    p_contract_status = ca.contract_status
                                 AND p_contract_status NOT IN ('a', 'f')))
                        AND (   psh.status = p_service_status
                             OR p_service_status IS NULL)
                        AND (   sn.sncode = p_service_code
                             OR p_service_code IS NULL)
                        --AND (sp.des IN ('iControl', 'iControl on net'))
                        AND (LOWER (sp.des) LIKE 'icontrol%')
                        AND ps.sncode = ca.sncode             -- MAIN_SP = 'X'
                                                 ) allpages
          WHERE (   (   p_page_size = 0
                     OR (rownumber BETWEEN p_start_row_index + 1
                                       AND p_start_row_index + p_page_size))
                 OR (p_page_size IS NULL AND p_start_row_index IS NULL));

      failure_id := 0;
      failure_reason := 'Success';
      
      BEGIN
                     SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;

                        Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('FilterIControlDials','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
                    exception
                    when OTHERS
                          THEN
                            DBMS_OUTPUT.PUT_LINE(SQLERRM);
                       END;
   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            failure_id := 112;
            failure_reason := SQLCODE || ': ' || SQLERRM;
            
            SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;
            Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('FilterIControlDials','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
         END;
   END;
END;
      
PROCEDURE FilterDialsForAddons (
      p_cust_code         IN     VARCHAR2,
      p_dials_list        IN     VARCHAR2 := NULL,
      p_dial_number       IN     VARCHAR2 := NULL,
      p_start_dial        IN     VARCHAR2 := NULL,
      p_end_dial          IN     VARCHAR2 := NULL,
      p_service_code      IN     INTEGER := NULL,
      p_service_status    IN     VARCHAR2 := NULL,
      p_rate_plan_code    IN     INTEGER := NULL,
      p_package_code      IN     VARCHAR2 := NULL,
      p_contract_status   IN     VARCHAR2 := NULL,
      p_start_row_index   IN     INTEGER,
      p_page_size         IN     INTEGER,
      services_cursor        OUT cursorreference,
      failure_id             OUT INTEGER,
      failure_reason         OUT VARCHAR2)
   IS
   
    v_INVC_TIME date;
   v_RES_TIME date;
   BEGIN
     execute immediate        'alter session set nls_date_format = ''DD-MON-YYYY HH24:MI:SS'' ';
      BEGIN
         SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
           INTO v_INVC_TIME
           FROM DUAL;
      END;
      
   BEGIN
      OPEN services_cursor FOR
         SELECT lineid,
                custcode,
                dial dial,
                co_status contractstatus,
                typ TYPE,
                tm tm,
                rate_plan rateplan,
                main_sp mainsp,
                sp spcode,
                service_package servicepackage,
                sn sncode,
                service service,
                sn_status servicestatus,
                totalrowscount
           FROM (SELECT ca.co_id lineid,
                        cu.custcode custcode,
                        ca.dial,
                        ca.contract_status co_status,
                        ca.typ,
                        ca.tm,
                        ca.rate_plan,
                        (CASE
                            WHEN ps.sncode = ca.sncode THEN 'X'
                            ELSE NULL
                         END)
                           main_sp,
                        psp.spcode sp,
                        (CASE
                            WHEN ca.sncode = 1 THEN sp.des
                            ELSE ca.rate_plan
                         END)
                           service_package,
                        ps.sncode sn,
                        sn.des service,
                        LOWER (psh.status) sn_status,
                        COUNT (*) OVER () totalrowscount,
                        ROW_NUMBER () OVER (ORDER BY cu.custcode) rownumber
                   FROM (    SELECT customer_id, custcode
                               FROM customer_all
                         CONNECT BY     PRIOR customer_id = customer_id_high
                                    AND paymntresp IS NULL
                                    AND cstype = 'a'
                         START WITH custcode = p_cust_code) cu
                        INNER JOIN NKADM.corp_acc_serv_new ca
                           ON ca.customer_id = cu.customer_id
                        INNER JOIN profile_service ps
                           ON ps.co_id = ca.co_id
                        INNER JOIN pr_serv_spcode_hist psp
                           ON     psp.co_id = ps.co_id
                              AND psp.sncode = ps.sncode
                              AND psp.profile_id = ps.profile_id
                              AND psp.histno = ps.spcode_histno
                        INNER JOIN pr_serv_status_hist psh
                           ON     psh.co_id = ps.co_id
                              AND psh.sncode = ps.sncode
                              AND psh.profile_id = ps.profile_id
                              AND psh.histno = ps.status_histno
                        INNER JOIN mpusptab sp
                           ON sp.spcode = psp.spcode
                        INNER JOIN mpusntab sn
                           ON sn.sncode = ps.sncode
                  WHERE     ps.sncode IN
                               (1,
                                26,
                                27,
                                10,
                                106,
                                11,
                                119,
                                12,
                                120,
                                121,
                                122,
                                123,
                                145,
                                318,
                                319,
                                32,
                                381,
                                401,
                                413,
                                414,
                                415,
                                416,
                                443,
                                456,
                                457,
                                458,
                                459,
                                46,
                                67,
                                68,
                                77,
                                86,
                                92)
                       -- AND ca.typ <> 'CC' -- Modified in 23-June-2023 to display the CC dials also 
                        AND (   psp.spcode = p_rate_plan_code
                             OR p_rate_plan_code IS NULL)
                        AND (   ca.typ = p_package_code
                             OR p_package_code IS NULL)
                        AND (   (ca.dial LIKE ('%' || p_dial_number || '%'))
                             OR p_dial_number IS NULL)
                        AND (ca.dial >= p_start_dial OR p_start_dial IS NULL)
                        AND (ca.dial <= p_end_dial OR p_end_dial IS NULL)
                        AND (   p_contract_status IS NULL
                             OR (    p_contract_status = 'a'
                                 AND ca.contract_status = 'a'
                                 AND (   NOT EXISTS
                                                (SELECT 1
                                                   FROM profile_service
                                                  WHERE     co_id = ca.co_id
                                                        AND sncode = 68)
                                      OR EXISTS
                                            (SELECT 1
                                               FROM profile_service ps2,
                                                    pr_serv_status_hist psh2
                                              WHERE     ps2.co_id = ca.co_id
                                                    AND psh2.co_id =
                                                           ps2.co_id
                                                    AND psh2.sncode =
                                                           ps2.sncode
                                                    AND psh2.profile_id =
                                                           ps2.profile_id
                                                    AND psh2.histno =
                                                           ps2.status_histno
                                                    AND ps2.sncode = 68
                                                    AND ps2.profile_id = 0
                                                    AND psh2.status = 'D')))
                             OR (    p_contract_status = 'f'
                                 AND ca.contract_status = 'a'
                                 AND EXISTS
                                        (SELECT 1
                                           FROM profile_service ps2,
                                                pr_serv_status_hist psh2
                                          WHERE     ps2.co_id = ca.co_id
                                                AND psh2.co_id = ps2.co_id
                                                AND psh2.sncode = ps2.sncode
                                                AND psh2.profile_id =
                                                       ps2.profile_id
                                                AND psh2.histno =
                                                       ps2.status_histno
                                                AND ps2.sncode = 68
                                                AND ps2.profile_id = 0
                                                AND psh2.status = 'A'))
                             OR (    p_contract_status = ca.contract_status
                                 AND p_contract_status NOT IN ('a', 'f')))
                        AND (   ca.dial IN
                                   (    SELECT REGEXP_SUBSTR (p_dials_list,
                                                              '[^,]+',
                                                              1,
                                                              LEVEL)
                                          FROM DUAL
                                    CONNECT BY REGEXP_SUBSTR (p_dials_list,
                                                              '[^,]+',
                                                              1,
                                                              LEVEL)
                                                  IS NOT NULL)
                             OR p_dials_list IS NULL)
                                     
                                AND ( ( p_service_code IS NULL AND p_service_code IS NULL  )   
                                        OR EXISTS (SELECT 1 FROM profile_service PS3, pr_serv_status_hist psh3
                                                      WHERE  ps3.co_id =ca.co_id   
                                                            AND  psh3.co_id =ps3.co_id
                                                            AND psh3.sncode = ps3.sncode
                                                            AND psh3.profile_id =ps3.profile_id
                                                            AND psh3.histno = ps3.status_histno
                                                            AND ps3.sncode = p_service_code
                                                            AND ps3.profile_id = 0                                                                 
                                                            AND Lower(psh3.status) = Lower(p_service_status) 
                                                    )   
                                    )      
                        AND ps.sncode = ca.sncode             -- MAIN_SP = 'X'
                                                 ) allpages
          WHERE (   (   p_page_size = 0
                     OR (rownumber BETWEEN p_start_row_index + 1
                                       AND p_start_row_index + p_page_size))
                 OR (p_page_size IS NULL AND p_start_row_index IS NULL));

      failure_id := 0;
      failure_reason := 'Success';
      
                        BEGIN
                     SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;

                        Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('FilterDialsForAddons','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
                    exception
                    when OTHERS
                          THEN
                            DBMS_OUTPUT.PUT_LINE(SQLERRM);
                       END;
      
   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            failure_id := 112;
            failure_reason := SQLCODE || ': ' || SQLERRM;
            
            SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;
            Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('FilterDialsForAddons','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
         END;
   END;
END;

   PROCEDURE GetManagePlanActivatedDials (
      p_cust_code         IN     VARCHAR2,
      p_dials_list        IN     VARCHAR2 := NULL,
      p_dial_number       IN     VARCHAR2 := NULL,
      p_start_dial        IN     VARCHAR2 := NULL,
      p_end_dial          IN     VARCHAR2 := NULL,
      p_service_code      IN     INTEGER := NULL,
      p_service_status    IN     VARCHAR2 := NULL,
      p_rate_plan_code    IN     INTEGER := NULL,
      p_package_code      IN     VARCHAR2 := NULL,
      p_start_row_index   IN     INTEGER,
      p_page_size         IN     INTEGER,
      services_cursor        OUT cursorreference,
      failure_id             OUT INTEGER,
      failure_reason         OUT VARCHAR2)
   IS
   v_INVC_TIME date;
   v_RES_TIME date;
   BEGIN
     execute immediate        'alter session set nls_date_format = ''DD-MON-YYYY HH24:MI:SS'' ';
      BEGIN
         SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
           INTO v_INVC_TIME
           FROM DUAL;
      END;
   BEGIN
      OPEN services_cursor FOR
         SELECT lineid,
                custcode,
                dial dial,
                co_status contractstatus,
                typ TYPE,
                tm tm,
                rate_plan rateplan,
                main_sp mainsp,
                sp spcode,
                service_package servicepackage,
                sn sncode,
                service service,
                sn_status servicestatus,
                totalrowscount
           FROM (SELECT ca.co_id lineid,
                        cu.custcode custcode,
                        ca.dial,
                        ca.contract_status co_status,
                        ca.typ,
                        ca.tm,
                        ca.rate_plan,
                        (CASE
                            WHEN ps.sncode = ca.sncode THEN 'X'
                            ELSE NULL
                         END)
                           main_sp,
                        psp.spcode sp,
                        (CASE
                            WHEN ca.sncode = 1 THEN sp.des
                            ELSE ca.rate_plan
                         END)
                           service_package,
                        ps.sncode sn,
                        sn.des service,
                        LOWER (psh.status) sn_status,
                        COUNT (*) OVER () totalrowscount,
                        ROW_NUMBER () OVER (ORDER BY cu.custcode) rownumber
                   FROM (    SELECT customer_id, custcode
                               FROM customer_all
                         CONNECT BY     PRIOR customer_id = customer_id_high
                                    AND paymntresp IS NULL
                                    AND cstype = 'a'
                         START WITH custcode = p_cust_code) cu
                        INNER JOIN NKADM.corp_acc_serv_new ca
                           ON ca.customer_id = cu.customer_id
                        INNER JOIN profile_service ps
                           ON ps.co_id = ca.co_id
                        INNER JOIN pr_serv_spcode_hist psp
                           ON     psp.co_id = ps.co_id
                              AND psp.sncode = ps.sncode
                              AND psp.profile_id = ps.profile_id
                              AND psp.histno = ps.spcode_histno
                        INNER JOIN pr_serv_status_hist psh
                           ON     psh.co_id = ps.co_id
                              AND psh.sncode = ps.sncode
                              AND psh.profile_id = ps.profile_id
                              AND psh.histno = ps.status_histno
                        INNER JOIN mpusptab sp
                           ON sp.spcode = psp.spcode
                        INNER JOIN mpusntab sn
                           ON sn.sncode = ps.sncode
                  WHERE     ps.sncode IN
                               (1,
                                26,
                                27,
                                10,
                                106,
                                11,
                                119,
                                12,
                                120,
                                121,
                                122,
                                123,
                                145,
                                318,
                                319,
                                32,
                                381,
                                401,
                                413,
                                414,
                                415,
                                416,
                                443,
                                456,
                                457,
                                458,
                                459,
                                46,
                                67,
                                68,
                                77,
                                86,
                                92)
                        AND (   psp.spcode = p_rate_plan_code
                             OR p_rate_plan_code IS NULL)
                        AND (   ca.typ = p_package_code
                             OR p_package_code IS NULL)
                        AND (ca.dial = p_dial_number OR p_dial_number IS NULL)
                        AND (ca.dial >= p_start_dial OR p_start_dial IS NULL)
                        AND (ca.dial <= p_end_dial OR p_end_dial IS NULL)
                        AND ca.sncode = 1
                        AND ca.contract_status = 'a'
                        AND (   NOT EXISTS
                                   (SELECT 1
                                      FROM profile_service
                                     WHERE co_id = ca.co_id AND sncode = 68)
                             OR EXISTS
                                   (SELECT 1
                                      FROM profile_service ps2,
                                           pr_serv_status_hist psh2
                                     WHERE     ps2.co_id = ca.co_id
                                           AND psh2.co_id = ps2.co_id
                                           AND psh2.sncode = ps2.sncode
                                           AND psh2.profile_id =
                                                  ps2.profile_id
                                           AND psh2.histno =
                                                  ps2.status_histno
                                           AND ps2.sncode = 68
                                           AND ps2.profile_id = 0
                                           AND psh2.status = 'D'))
                        AND (   ca.dial IN
                                   (    SELECT REGEXP_SUBSTR (p_dials_list,
                                                              '[^,]+',
                                                              1,
                                                              LEVEL)
                                          FROM DUAL
                                    CONNECT BY REGEXP_SUBSTR (p_dials_list,
                                                              '[^,]+',
                                                              1,
                                                              LEVEL)
                                                  IS NOT NULL)
                             OR p_dials_list IS NULL)
                        AND (   (    p_service_code IS NULL
                                         AND p_service_status IS NULL)
                                     OR EXISTS
                                           (SELECT 1
                                              FROM profile_service PS3,
                                                   pr_serv_status_hist psh3
                                             WHERE     ps3.co_id = ca.co_id
                                                   AND psh3.co_id = ps3.co_id
                                                   AND psh3.sncode =
                                                          ps3.sncode
                                                   AND psh3.profile_id =
                                                          ps3.profile_id
                                                   AND psh3.histno =
                                                          ps3.status_histno
                                                   AND ps3.sncode =
                                                          p_service_code
                                                   AND ps3.profile_id = 0
                                                   AND LOWER (psh3.status) =
                                                          LOWER(p_service_status)))
                        AND ps.sncode = ca.sncode             -- MAIN_SP = 'X'
                                                 ) allpages
          WHERE (   (   p_page_size = 0
                     OR (rownumber BETWEEN p_start_row_index + 1
                                       AND p_start_row_index + p_page_size))
                 OR (p_page_size IS NULL AND p_start_row_index IS NULL));

      failure_id := 0;
      failure_reason := 'Success';
      
      BEGIN
                     SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;

                        Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetManagePlanActivatedDials','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
                    exception
                    when OTHERS
                      THEN
                        DBMS_OUTPUT.PUT_LINE(SQLERRM);
                   END;

   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            failure_id := 112;
            failure_reason := SQLCODE || ': ' || SQLERRM;
            
            SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;
            Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetManagePlanActivatedDials','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
         END;
   END;
END;

   PROCEDURE GetInvlntrySuspendedDials (
      p_cust_code         IN     VARCHAR2,
      p_dials_list        IN     VARCHAR2 := NULL,
      p_dial_number       IN     VARCHAR2 := NULL,
      p_start_dial        IN     VARCHAR2 := NULL,
      p_end_dial          IN     VARCHAR2 := NULL,
      p_service_code      IN     INTEGER := NULL,
      p_service_status    IN     VARCHAR2 := NULL,
      p_rate_plan_code    IN     INTEGER := NULL,
      p_package_code      IN     VARCHAR2 := NULL,
      p_start_row_index   IN     INTEGER,
      p_page_size         IN     INTEGER,
      services_cursor        OUT cursorreference,
      failure_id             OUT INTEGER,
      failure_reason         OUT VARCHAR2)
   IS
    v_INVC_TIME date;
   v_RES_TIME date;
   BEGIN
     execute immediate        'alter session set nls_date_format = ''DD-MON-YYYY HH24:MI:SS'' ';
      BEGIN
         SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
           INTO v_INVC_TIME
           FROM DUAL;
      END;
   BEGIN
      OPEN services_cursor FOR
         SELECT lineid,
                custcode,
                dial dial,
                co_status contractstatus,
                typ TYPE,
                tm tm,
                rate_plan rateplan,
                main_sp mainsp,
                sp spcode,
                service_package servicepackage,
                sn sncode,
                service service,
                sn_status servicestatus,
                totalrowscount
           FROM (SELECT ca.co_id lineid,
                        cu.custcode custcode,
                        ca.dial,
                        ca.contract_status co_status,
                        ca.typ,
                        ca.tm,
                        ca.rate_plan,
                        (CASE
                            WHEN ps.sncode = ca.sncode THEN 'X'
                            ELSE NULL
                         END)
                           main_sp,
                        psp.spcode sp,
                        (CASE
                            WHEN ca.sncode = 1 THEN sp.des
                            ELSE ca.rate_plan
                         END)
                           service_package,
                        ps.sncode sn,
                        sn.des service,
                        LOWER (psh.status) sn_status,
                        COUNT (*) OVER () totalrowscount,
                        ROW_NUMBER () OVER (ORDER BY cu.custcode) rownumber
                   FROM (    SELECT customer_id, custcode
                               FROM customer_all
                         CONNECT BY     PRIOR customer_id = customer_id_high
                                    AND paymntresp IS NULL
                                    AND cstype = 'a'
                         START WITH custcode = p_cust_code) cu
                        INNER JOIN NKADM.corp_acc_serv_new ca
                           ON ca.customer_id = cu.customer_id
                        INNER JOIN profile_service ps
                           ON ps.co_id = ca.co_id
                        INNER JOIN pr_serv_spcode_hist psp
                           ON     psp.co_id = ps.co_id
                              AND psp.sncode = ps.sncode
                              AND psp.profile_id = ps.profile_id
                              AND psp.histno = ps.spcode_histno
                        INNER JOIN pr_serv_status_hist psh
                           ON     psh.co_id = ps.co_id
                              AND psh.sncode = ps.sncode
                              AND psh.profile_id = ps.profile_id
                              AND psh.histno = ps.status_histno
                        INNER JOIN mpusptab sp
                           ON sp.spcode = psp.spcode
                        INNER JOIN mpusntab sn
                           ON sn.sncode = ps.sncode
                  WHERE     ps.sncode IN
                               (1,
                                26,
                                27,
                                10,
                                106,
                                11,
                                119,
                                12,
                                120,
                                121,
                                122,
                                123,
                                145,
                                318,
                                319,
                                32,
                                381,
                                401,
                                413,
                                414,
                                415,
                                416,
                                443,
                                456,
                                457,
                                458,
                                459,
                                46,
                                67,
                                68,
                                77,
                                86,
                                92)
                        AND (   psp.spcode = p_rate_plan_code
                             OR p_rate_plan_code IS NULL)
                        AND (   ca.typ = p_package_code
                             OR p_package_code IS NULL)
                        AND (ca.dial = p_dial_number OR p_dial_number IS NULL)
                        AND (ca.dial >= p_start_dial OR p_start_dial IS NULL)
                        AND (ca.dial <= p_end_dial OR p_end_dial IS NULL)
                        AND ca.contract_status = 's'
                        AND (   EXISTS
                                   (SELECT *
                                      FROM profile_service ps2,
                                           pr_serv_status_hist psh2
                                     WHERE     ps2.co_id = ca.co_id
                                           AND psh2.co_id = ps2.co_id
                                           AND psh2.sncode = ps2.sncode
                                           AND psh2.profile_id =
                                                  ps2.profile_id
                                           AND psh2.histno =
                                                  ps2.status_histno
                                           AND ps2.sncode = 119
                                           AND psh2.status = 'D')
                             OR NOT EXISTS
                                   (SELECT *
                                      FROM profile_service
                                     WHERE co_id = ca.co_id AND sncode = 119))
                        AND (   ca.dial IN
                                   (    SELECT REGEXP_SUBSTR (p_dials_list,
                                                              '[^,]+',
                                                              1,
                                                              LEVEL)
                                          FROM DUAL
                                    CONNECT BY REGEXP_SUBSTR (p_dials_list,
                                                              '[^,]+',
                                                              1,
                                                              LEVEL)
                                                  IS NOT NULL)
                             OR p_dials_list IS NULL)
                        AND (   (    p_service_code IS NULL
                                         AND p_service_status IS NULL)
                                     OR EXISTS
                                           (SELECT 1
                                              FROM profile_service PS3,
                                                   pr_serv_status_hist psh3
                                             WHERE     ps3.co_id = ca.co_id
                                                   AND psh3.co_id = ps3.co_id
                                                   AND psh3.sncode =
                                                          ps3.sncode
                                                   AND psh3.profile_id =
                                                          ps3.profile_id
                                                   AND psh3.histno =
                                                          ps3.status_histno
                                                   AND ps3.sncode =
                                                          p_service_code
                                                   AND ps3.profile_id = 0
                                                   AND LOWER (psh3.status) =
                                                          LOWER(p_service_status)))
                        AND ps.sncode = ca.sncode             -- MAIN_SP = 'X'
                                                 ) allpages
          WHERE (   (   p_page_size = 0
                     OR (rownumber BETWEEN p_start_row_index + 1
                                       AND p_start_row_index + p_page_size))
                 OR (p_page_size IS NULL AND p_start_row_index IS NULL));

      failure_id := 0;
      failure_reason := 'Success';
       BEGIN
                     SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;

                        Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetInvlntrySuspendedDials','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
                    exception
                    when OTHERS
                          THEN
                            DBMS_OUTPUT.PUT_LINE(SQLERRM);
                       END;

   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            failure_id := 112;
            failure_reason := SQLCODE || ': ' || SQLERRM;
            
            SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;
            Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetInvlntrySuspendedDials','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
         END;
   END;
END;

PROCEDURE GetVlntrySuspendedDials (
      p_cust_code         IN     VARCHAR2,
      p_dials_list        IN     VARCHAR2 := NULL,
      p_dial_number       IN     VARCHAR2 := NULL,
      p_start_dial        IN     VARCHAR2 := NULL,
      p_end_dial          IN     VARCHAR2 := NULL,
      p_service_code      IN     INTEGER := NULL,
      p_service_status    IN     VARCHAR2 := NULL,
      p_rate_plan_code    IN     INTEGER := NULL,
      p_package_code      IN     VARCHAR2 := NULL,
      p_start_row_index   IN     INTEGER,
      p_page_size         IN     INTEGER,
      services_cursor        OUT cursorreference,
      failure_id             OUT INTEGER,
      failure_reason         OUT VARCHAR2)
   IS
      v_INVC_TIME date;
   v_RES_TIME date;
   BEGIN
     execute immediate        'alter session set nls_date_format = ''DD-MON-YYYY HH24:MI:SS'' ';
      BEGIN
         SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
           INTO v_INVC_TIME
           FROM DUAL;
      END;
   BEGIN
      OPEN services_cursor FOR
         SELECT lineid,
                custcode,
                dial dial,
                co_status contractstatus,
                typ TYPE,
                tm tm,
                rate_plan rateplan,
                main_sp mainsp,
                sp spcode,
                service_package servicepackage,
                sn sncode,
                ca_sn sncode2,
                service service,
                sn_status servicestatus,
                totalrowscount
           FROM (SELECT ca.co_id lineid,
                        cu.custcode custcode,
                        ca.dial,
                        ca.contract_status co_status,
                        ca.typ,
                        ca.tm,
                        ca.rate_plan,
                        (CASE
                            WHEN ps.sncode = ca.sncode THEN 'X'
                            ELSE NULL
                         END)
                           main_sp,
                        psp.spcode sp,
                        (CASE
                            WHEN ca.sncode = 1 THEN sp.des
                            ELSE ca.rate_plan
                         END)
                           service_package,
                        ps.sncode sn,
                        ca.sncode ca_sn,
                        sn.des service,
                        LOWER (psh.status) sn_status,
                        COUNT (*) OVER () totalrowscount,
                        ROW_NUMBER () OVER (ORDER BY cu.custcode) rownumber
                   FROM (    SELECT customer_id, custcode
                               FROM customer_all
                         CONNECT BY     PRIOR customer_id = customer_id_high
                                    AND paymntresp IS NULL
                                    AND cstype = 'a'
                         START WITH custcode = p_cust_code) cu
                        INNER JOIN NKADM.corp_acc_serv_new ca
                           ON ca.customer_id = cu.customer_id
                        INNER JOIN profile_service ps
                           ON ps.co_id = ca.co_id
                        INNER JOIN pr_serv_spcode_hist psp
                           ON     psp.co_id = ps.co_id
                              AND psp.sncode = ps.sncode
                              AND psp.profile_id = ps.profile_id
                              AND psp.histno = ps.spcode_histno
                        INNER JOIN pr_serv_status_hist psh
                           ON     psh.co_id = ps.co_id
                              AND psh.sncode = ps.sncode
                              AND psh.profile_id = ps.profile_id
                              AND psh.histno = ps.status_histno
                        INNER JOIN mpusptab sp
                           ON sp.spcode = psp.spcode
                        INNER JOIN mpusntab sn
                           ON sn.sncode = ps.sncode
                  WHERE     ps.sncode IN
                               (1,
                                26,
                                27,
                                10,
                                106,
                                11,
                                119,
                                12,
                                120,
                                121,
                                122,
                                123,
                                145,
                                318,
                                319,
                                32,
                                381,
                                401,
                                413,
                                414,
                                415,
                                416,
                                443,
                                456,
                                457,
                                458,
                                459,
                                46,
                                67,
                                68,
                                77,
                                86,
                                92)
                        AND (   psp.spcode = p_rate_plan_code
                             OR p_rate_plan_code IS NULL)
                        AND (   ca.typ = p_package_code
                             OR p_package_code IS NULL)
                        AND (ca.dial = p_dial_number OR p_dial_number IS NULL)
                        AND (ca.dial >= p_start_dial OR p_start_dial IS NULL)
                        AND (ca.dial <= p_end_dial OR p_end_dial IS NULL)
                        AND (    ca.contract_status = 's'
                            )
                        AND (   ca.dial IN
                                   (    SELECT REGEXP_SUBSTR (p_dials_list,
                                                              '[^,]+',
                                                              1,
                                                              LEVEL)
                                          FROM DUAL
                                    CONNECT BY REGEXP_SUBSTR (p_dials_list,
                                                              '[^,]+',
                                                              1,
                                                              LEVEL)
                                                  IS NOT NULL)
                             OR p_dials_list IS NULL)
                        AND (   (    p_service_code IS NULL
                                         AND p_service_status IS NULL)
                                     OR EXISTS
                                           (SELECT 1
                                              FROM profile_service PS3,
                                                   pr_serv_status_hist psh3
                                             WHERE     ps3.co_id = ca.co_id
                                                   AND psh3.co_id = ps3.co_id
                                                   AND psh3.sncode =
                                                          ps3.sncode
                                                   AND psh3.profile_id =
                                                          ps3.profile_id
                                                   AND psh3.histno =
                                                          ps3.status_histno
                                                   AND ps3.sncode =
                                                          p_service_code
                                                   AND ps3.profile_id = 0
                                                   AND LOWER (psh3.status) =
                                                          LOWER(p_service_status)))
                        
                        AND (   
                                      EXISTS
                                           (SELECT 1
                                              FROM profile_service PS2,
                                                   pr_serv_status_hist psh2
                                             WHERE     ps2.co_id = ca.co_id
                                                   AND psh2.co_id = ps2.co_id
                                                   AND psh2.sncode =
                                                          ps2.sncode
                                                   AND psh2.profile_id =
                                                          ps2.profile_id
                                                   AND psh2.histno =
                                                          ps2.status_histno
                                                   AND ps2.sncode =
                                                          119
                                                   AND ps2.profile_id = 0
                                                   AND LOWER (psh2.status) =
                                                          LOWER('S')))
                        AND ps.sncode = ca.sncode     
                             
                                                       ) allpages
          WHERE (   (   p_page_size = 0
                     OR (rownumber BETWEEN p_start_row_index + 1
                                       AND p_start_row_index + p_page_size))
                 OR (p_page_size IS NULL AND p_start_row_index IS NULL));
                 
      failure_id := 0;
      failure_reason := 'Success';
                        BEGIN
                     SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;

                        Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetVlntrySuspendedDials','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
                    exception
                    when OTHERS
                          THEN
                            DBMS_OUTPUT.PUT_LINE(SQLERRM);
                       END;

   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            failure_id := 112;
            failure_reason := SQLCODE || ': ' || SQLERRM;
            
            SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;
                        Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetVlntrySuspendedDials','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,p_dial_number,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
         END;
   END;                 
END;

   PROCEDURE GetAvailableTariffPlans (
      p_cust_code       IN     VARCHAR2,
      services_cursor      OUT cursorreference,
      failure_id           OUT INTEGER,
      failure_reason       OUT VARCHAR2)
   IS
   v_INVC_TIME date;
   v_RES_TIME date;
   BEGIN
     execute immediate        'alter session set nls_date_format = ''DD-MON-YYYY HH24:MI:SS'' ';
      BEGIN
         SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
           INTO v_INVC_TIME
           FROM DUAL;
      END;
   BEGIN
      OPEN services_cursor FOR
         SELECT DISTINCT
                psp.spcode spcode,
                (CASE WHEN ca.sncode = 1 THEN sp.des ELSE ca.rate_plan END)
                   servicepackage
           FROM (    SELECT customer_id, custcode
                       FROM customer_all
                 CONNECT BY     PRIOR customer_id = customer_id_high
                            AND paymntresp IS NULL
                            AND cstype = 'a'
                 START WITH custcode = p_cust_code) cu
                INNER JOIN NKADM.corp_acc_serv_new ca
                   ON ca.customer_id = cu.customer_id
                INNER JOIN profile_service ps
                   ON ps.co_id = ca.co_id
                INNER JOIN pr_serv_spcode_hist psp
                   ON     psp.co_id = ps.co_id
                      AND psp.sncode = ps.sncode
                      AND psp.profile_id = ps.profile_id
                      AND psp.histno = ps.spcode_histno
                INNER JOIN mpusptab sp
                   ON sp.spcode = psp.spcode
          WHERE ps.sncode IN
                   (1,
                    26,
                    27,
                    10,
                    106,
                    11,
                    119,
                    12,
                    120,
                    121,
                    122,
                    123,
                    145,
                    318,
                    319,
                    32,
                    381,
                    401,
                    413,
                    414,
                    415,
                    416,
                    443,
                    456,
                    457,
                    458,
                    459,
                    46,
                    67,
                    68,
                    77,
                    86,
                    92)           AND ps.sncode = ca.sncode -- MAIN_SP = 'X'
                       ;

      failure_id := 0;
      failure_reason := 'Success';
      
      BEGIN
                     SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;
                        Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetAvailableTariffPlans','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,null,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
                    exception
                    when OTHERS
                          THEN
                            DBMS_OUTPUT.PUT_LINE(SQLERRM);
                       END;
   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            failure_id := 112;
            failure_reason := SQLCODE || ': ' || SQLERRM;
            SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;
            Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetAvailableTariffPlans','PORTAL',v_INVC_TIME,decode (failure_id,0,'SUCCESS','FAILED'),v_RES_TIME,
                        p_cust_code,null,null,null,null,failure_reason,null,null,null,null,null,null,null,null,null);
                    commit;
         END;
   END;
END;


   PROCEDURE GetIControlMasterLine (p_cust_code              IN     VARCHAR2,
                                    p_icontrol_master_line      OUT VARCHAR2)
   IS
   v_INVC_TIME date;
   v_RES_TIME date;
   BEGIN
     execute immediate        'alter session set nls_date_format = ''DD-MON-YYYY HH24:MI:SS'' ';
      BEGIN
         SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
           INTO v_INVC_TIME
           FROM DUAL;
      END;
   BEGIN
      SELECT dial
        INTO p_icontrol_master_line
        FROM (SELECT ca.dial
                FROM (    SELECT customer_id, custcode
                            FROM customer_all
                      CONNECT BY     PRIOR customer_id = customer_id_high
                                 AND paymntresp IS NULL
                                 AND cstype = 'a'
                      START WITH custcode = p_cust_code) cu
                     INNER JOIN NKADM.corp_acc_serv_new ca
                        ON ca.customer_id = cu.customer_id
                     INNER JOIN profile_service ps
                        ON ps.co_id = ca.co_id
                     INNER JOIN pr_serv_spcode_hist psp
                        ON     psp.co_id = ps.co_id
                           AND psp.sncode = ps.sncode
                           AND psp.profile_id = ps.profile_id
                           AND psp.histno = ps.spcode_histno
                     INNER JOIN mpusptab sp
                        ON sp.spcode = psp.spcode
               WHERE     ps.sncode IN
                            (1,
                             26,
                             27,
                             10,
                             106,
                             11,
                             119,
                             12,
                             120,
                             121,
                             122,
                             123,
                             145,
                             318,
                             319,
                             32,
                             381,
                             401,
                             413,
                             414,
                             415,
                             416,
                             443,
                             456,
                             457,
                             458,
                             459,
                             46,
                             67,
                             68,
                             77,
                             86,
                             92)
                     AND LOWER (sp.des) LIKE 'icontrol%'
                     AND LOWER (sp.des) <> 'icontrol on net'
                     AND ROWNUM <= 1);
                     
             BEGIN
                     SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;

                        Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetIControlMasterLine','PORTAL',v_INVC_TIME,'SUCCESS',v_RES_TIME,
                        p_cust_code,null,null,null,null,p_icontrol_master_line,null,null,null,null,null,null,null,null,null);
                    commit;
                    exception
                    when OTHERS
                          THEN
                            DBMS_OUTPUT.PUT_LINE(SQLERRM);
                       END;
   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            p_icontrol_master_line := NULL;
            SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;
            Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('GetIControlMasterLine','PORTAL',v_INVC_TIME,'SUCCESS',v_RES_TIME,
                        p_cust_code,null,null,null,null,p_icontrol_master_line,null,null,null,null,null,null,null,null,null);
                    commit;
         END;
   END;
END;


   PROCEDURE IsPrepaidAccount (p_cust_code    IN     VARCHAR2,
                               p_is_prepaid      OUT INTEGER)
   IS
   v_INVC_TIME date;
   v_RES_TIME date;
   BEGIN
     execute immediate        'alter session set nls_date_format = ''DD-MON-YYYY HH24:MI:SS'' ';
      BEGIN
         SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
           INTO v_INVC_TIME
           FROM DUAL;
      END;
   BEGIN
      SELECT 1
        INTO p_is_prepaid
        FROM DUAL
       WHERE EXISTS
                (SELECT ca.dial
                   FROM (    SELECT customer_id, custcode
                               FROM customer_all
                         CONNECT BY     PRIOR customer_id = customer_id_high
                                    AND paymntresp IS NULL
                                    AND cstype = 'a'
                         START WITH custcode = p_cust_code) cu
                        INNER JOIN NKADM.corp_acc_serv_new ca
                           ON ca.customer_id = cu.customer_id
                        INNER JOIN profile_service ps
                           ON ps.co_id = ca.co_id
                  WHERE     ps.sncode IN
                               (1,
                                26,
                                27,
                                10,
                                106,
                                11,
                                119,
                                12,
                                120,
                                121,
                                122,
                                123,
                                145,
                                318,
                                319,
                                32,
                                381,
                                401,
                                413,
                                414,
                                415,
                                416,
                                443,
                                456,
                                457,
                                458,
                                459,
                                46,
                                67,
                                68,
                                77,
                                86,
                                92)
                        AND ca.tm = 20);
                        
                                     BEGIN
                     SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;

                        Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('IsPrepaidAccount','PORTAL',v_INVC_TIME,'SUCCESS',v_RES_TIME,
                        p_cust_code,null,null,null,null,p_is_prepaid,null,null,null,null,null,null,null,null,null);
                    commit;
                    exception
                    when OTHERS
                          THEN
                            DBMS_OUTPUT.PUT_LINE(SQLERRM);
                       END;
   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            p_is_prepaid := 0;
            SELECT to_date(sysdate,'DD-MON-RR HH24:MI:SS') 
                       INTO v_RES_TIME
                       FROM DUAL;
            Insert into NKADM.WS_TRACKING (NK_WS,USERNAME,INVC_TIME,ERROR,RES_TIME,INPUT1,INPUT2,INPUT3,INPUT4,INPUT5,OUTPUT1,OUTPUT2,OUTPUT3,OUTPUT4,OUTPUT5,OUTPUT6,OUTPUT7,OUTPUT8,OUTPUT9,OUTPUT10) 
                        values ('IsPrepaidAccount','PORTAL',v_INVC_TIME,'SUCCESS',v_RES_TIME,
                        p_cust_code,null,null,null,null,p_is_prepaid,null,null,null,null,null,null,null,null,null);
                    commit;
         END;
   END;
END;
END portal_ucontrol_test;