Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E0F762266
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jul 2023 21:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGYTgS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jul 2023 15:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGYTgR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jul 2023 15:36:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9D32110;
        Tue, 25 Jul 2023 12:36:14 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PITfBj024049;
        Tue, 25 Jul 2023 19:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=XpJZlDsxNVnkBft+r2+70NbIRgyngyL49kGOJtZRTG4=;
 b=ScP+j+tGwXf651IPd0xwCvB+QvI0qUTr5HBd8qCYOcYYxN5AJIIi72r0m9SeT5xxHh4Y
 OSlR5q9megz0E8csoOQsm9gUE7P5TEjT5x5RgU4Oqv3Mn1386Wk+/fhgPQIBPU4h0dnX
 jibW4QgJSAcfDTgOZUtuNi6Axbz0zY71KuSTiOkPX/43qGZ9e+hJinFi5s1C1oJKulhp
 cTahHlC05Rj098BfTuh71UFgDZX17n1q+kTkx6WwdnFa051QJ41IHtJ8kfHuvEI2KsX7
 m7R5b2AH8nboyVW0YPiRCUw/gkPef3nKWFAVXO4XDdw9OHoYBngkCyCRaSrSydCOc2N0 ow== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2gp1rjyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 19:36:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PJa3Cj015788
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 19:36:03 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 12:36:02 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v2 2/7] dt-bindings: leds: leds-qcom-lpg: Add support for LPG PPG
Date:   Tue, 25 Jul 2023 12:34:18 -0700
Message-ID: <20230725193423.25047-3-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725193423.25047-1-quic_amelende@quicinc.com>
References: <20230725193423.25047-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x--k-mwBZvbhyojwBHBsTpw3fFyKgLsg
X-Proofpoint-ORIG-GUID: x--k-mwBZvbhyojwBHBsTpw3fFyKgLsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_10,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=843 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Update leds-qcom-lpg bindings to support LPG PPG.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 .../bindings/leds/leds-qcom-lpg.yaml          | 92 ++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index e6f1999cb22f..6feca859fb74 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: >
   The Qualcomm Light Pulse Generator consists of three different hardware blocks;
-  a ramp generator with lookup table, the light pulse generator and a three
+  a ramp generator with lookup table (LUT), the light pulse generator and a three
   channel current sink. These blocks are found in a wide range of Qualcomm PMICs.
 
 properties:
@@ -63,6 +63,27 @@ properties:
         - description: dtest line to attach
         - description: flags for the attachment
 
+  nvmem:
+    description: >
+      This property is required for PMICs that supports PPG, which is when a
+      PMIC stores LPG per-channel data and pattern LUT in SDAM modules instead
+      of in a LUT peripheral. For PMICs, such as PM8350C, per-channel data
+      and pattern LUT is separated into 2 SDAM modules. In that case, phandles
+      to both SDAM modules need to be specified.
+    minItems: 1
+    maxItems: 2
+
+  nvmem-names:
+    minItems: 1
+    maxItems: 2
+
+  qcom,pbs:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: >
+      Phandle of the Qualcomm Programmable Boot Sequencer node (PBS).
+      PBS node is used to trigger LPG pattern sequences for PMICs that support
+      single SDAM PPG.
+
   multi-led:
     type: object
     $ref: leds-class-multicolor.yaml#
@@ -106,6 +127,44 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,pmi632-lpg
+    then:
+      properties:
+        nvmem:
+          maxItems: 1
+        nvmem-names:
+          items:
+            - const: lpg_chan_sdam
+        qcom,pbs:
+          maxItems: 1
+      required:
+        - nvmem
+        - nvmem-names
+        - qcom,pbs
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8350c-pwm
+              - qcom,pm8550-pwm
+    then:
+      properties:
+        nvmem:
+          minItems: 2
+        nvmem-names:
+          items:
+            - const: lpg_chan_sdam
+            - const: lut_sdam
+      required:
+        - nvmem
+        - nvmem-names
+
 examples:
   - |
     #include <dt-bindings/leds/common.h>
@@ -191,4 +250,35 @@ examples:
       compatible = "qcom,pm8916-pwm";
       #pwm-cells = <2>;
     };
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    led-controller {
+      compatible = "qcom,pmi632-lpg";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #pwm-cells = <2>;
+      nvmem-names = "lpg_chan_sdam";
+      nvmem = <&pmi632_sdam_7>;
+      qcom,pbs = <&pmi632_pbs_client3>;
+
+      led@1 {
+        reg = <1>;
+        color = <LED_COLOR_ID_RED>;
+        label = "red";
+      };
+
+      led@2 {
+        reg = <2>;
+        color = <LED_COLOR_ID_GREEN>;
+        label = "green";
+      };
+
+      led@3 {
+        reg = <3>;
+        color = <LED_COLOR_ID_BLUE>;
+        label = "blue";
+      };
+    };
+
 ...
-- 
2.41.0

