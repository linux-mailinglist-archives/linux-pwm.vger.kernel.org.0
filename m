Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9E7BA5E5
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Oct 2023 18:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbjJEQUs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Oct 2023 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242461AbjJEQSE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Oct 2023 12:18:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61A53F023;
        Thu,  5 Oct 2023 09:06:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395DiBDh026642;
        Thu, 5 Oct 2023 16:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=zpPueMzy8NacgapM4hPPe1DYhp5ru0FS8kAbfBI2rSE=;
 b=p1OPRm2U++3oj0FDPkmqzzlevDAXENAmBLfKFwiG2galGYzuRt3SF9RA5Hx0+mALNKlS
 FFNacDyyvy21BT1chOjdftdM+OyivPcCmUvsgqBlivO81TNRV+qVmw4VLsVcbl7VymYU
 kwAucFqfEiK3eUofRe6ObWu/mUvcW2wpCvfKM1x5R9R8SeAxOsDvAJq7XT/jZtIG/csx
 Il+e5UtTzRtNCitpgpB9Vepujb4r4JntwXiOGXCZOzZYKwh8At0zqz+Q7MiYRjw9BGbM
 PpnqnaDJ6A3EUQF+FtjybG457/JEPm5M5H7soiSbiHXzHBwtRgvWumjai7xbDadB5ma5 Uw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thnfa9bak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 16:06:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395G6XSJ027626
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 16:06:34 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 5 Oct 2023 09:06:28 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thierry.reding@gmail.com>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <baruch@tkos.co.il>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
CC:     <linux-pwm@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <nathan@kernel.org>
Subject: [PATCH V15 3/4] dt-bindings: mfd: qcom,tcsr: Add simple-mfd support for IPQ6018
Date:   Thu, 5 Oct 2023 21:35:49 +0530
Message-ID: <20231005160550.2423075-4-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005160550.2423075-1-quic_devipriy@quicinc.com>
References: <20231005160550.2423075-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 12pXrpyw4m_B8_1g7uyH7Pg47S1eo8qT
X-Proofpoint-ORIG-GUID: 12pXrpyw4m_B8_1g7uyH7Pg47S1eo8qT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_11,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Update the binding to include pwm as the child node to TCSR block and
add simple-mfd support for IPQ6018.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
v15:

 Picked up the R-b tag

v14:

Addressed comments suggested by krzysztof

 Added type: object to patternProperties and added the complete path to
 pwm.yaml in the reference

 Disallow pwm for targets other than ipq6018

 Moved ranges property just after reg in the examples

v13:

 Added simple-mfd support for IPQ6018 based devices

 Added support to include pwm as the child node to TCSR

 Included syscon node found on IPQ6018 to the examples

 .../devicetree/bindings/mfd/qcom,tcsr.yaml    | 112 +++++++++++++-----
 1 file changed, 81 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index 33c3d023a106..f836b973e382 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -15,50 +15,100 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - qcom,msm8976-tcsr
-          - qcom,msm8998-tcsr
-          - qcom,qcs404-tcsr
-          - qcom,sc7180-tcsr
-          - qcom,sc7280-tcsr
-          - qcom,sc8280xp-tcsr
-          - qcom,sdm630-tcsr
-          - qcom,sdm845-tcsr
-          - qcom,sdx55-tcsr
-          - qcom,sdx65-tcsr
-          - qcom,sm4450-tcsr
-          - qcom,sm8150-tcsr
-          - qcom,sm8450-tcsr
-          - qcom,tcsr-apq8064
-          - qcom,tcsr-apq8084
-          - qcom,tcsr-ipq5332
-          - qcom,tcsr-ipq6018
-          - qcom,tcsr-ipq8064
-          - qcom,tcsr-ipq8074
-          - qcom,tcsr-ipq9574
-          - qcom,tcsr-mdm9615
-          - qcom,tcsr-msm8226
-          - qcom,tcsr-msm8660
-          - qcom,tcsr-msm8916
-          - qcom,tcsr-msm8953
-          - qcom,tcsr-msm8960
-          - qcom,tcsr-msm8974
-          - qcom,tcsr-msm8996
-      - const: syscon
+    oneOf:
+      - items:
+          - enum:
+              - qcom,msm8976-tcsr
+              - qcom,msm8998-tcsr
+              - qcom,qcs404-tcsr
+              - qcom,sc7180-tcsr
+              - qcom,sc7280-tcsr
+              - qcom,sc8280xp-tcsr
+              - qcom,sdm630-tcsr
+              - qcom,sdm845-tcsr
+              - qcom,sdx55-tcsr
+              - qcom,sdx65-tcsr
+              - qcom,sm4450-tcsr
+              - qcom,sm8150-tcsr
+              - qcom,sm8450-tcsr
+              - qcom,tcsr-apq8064
+              - qcom,tcsr-apq8084
+              - qcom,tcsr-ipq5332
+              - qcom,tcsr-ipq8064
+              - qcom,tcsr-ipq8074
+              - qcom,tcsr-ipq9574
+              - qcom,tcsr-mdm9615
+              - qcom,tcsr-msm8226
+              - qcom,tcsr-msm8660
+              - qcom,tcsr-msm8916
+              - qcom,tcsr-msm8953
+              - qcom,tcsr-msm8960
+              - qcom,tcsr-msm8974
+              - qcom,tcsr-msm8996
+          - const: syscon
+      - items:
+          - const: qcom,tcsr-ipq6018
+          - const: syscon
+          - const: simple-mfd
 
   reg:
     maxItems: 1
 
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+patternProperties:
+  "pwm@[a-f0-9]+$":
+    type: object
+    $ref: /schemas/pwm/qcom,ipq6018-pwm.yaml
+
 required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,tcsr-ipq6018
+    then:
+      patternProperties:
+        "pwm@[a-f0-9]+$": false
+
 additionalProperties: false
 
 examples:
+  # Example 1 - Syscon node found on MSM8960
   - |
     syscon@1a400000 {
         compatible = "qcom,tcsr-msm8960", "syscon";
         reg = <0x1a400000 0x100>;
     };
+  # Example 2 - Syscon node found on IPQ6018
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
+
+    syscon@1937000 {
+        compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
+        reg = <0x01937000 0x21000>;
+        ranges = <0 0x1937000 0x21000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        pwm: pwm@a010 {
+            compatible = "qcom,ipq6018-pwm";
+            reg = <0xa010 0x20>;
+            clocks = <&gcc GCC_ADSS_PWM_CLK>;
+            assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+            assigned-clock-rates = <100000000>;
+            #pwm-cells = <2>;
+        };
+    };
-- 
2.34.1

