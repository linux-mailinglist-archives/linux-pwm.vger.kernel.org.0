Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5097BA293
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Oct 2023 17:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjJEPlv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Oct 2023 11:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjJEPl1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Oct 2023 11:41:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D40677FF;
        Thu,  5 Oct 2023 07:55:59 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3954WAN5022298;
        Thu, 5 Oct 2023 04:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=O9G6aJwwwtzXKgwKWSw8c7oRidhefF3dxtbgZvE+dvY=;
 b=mdxUiPnhC/PoFlL6za8Cxtmm9oBNXVNA0udE0UepR1J4pq9py1TlVKyTnQZbpDVtwNwE
 qnPK220gn4YYpXcZvxawaVDM9NrY+Y7T4z2rnwAonQt+lZFzWFaTkmC84xymVZ8U+6uI
 6Ff0BDDv/CjYUUz67doT7/Bp/OwSzPTXo2jkzOmonHo0Q2R7QYLU8WSgG9ZPy6Dro1kG
 xlcDjgJB/epDZoM/rx7bXqC8n7+cUWWyOxr6zXgggT9d18yWdpOd+5G0IGB+cZwQ0lJB
 jMcKfb+O3C0On+1uugyVeS2mwfErKai9sletqFnx4DsFUG78AUJDuRcCp06+bXwXCbTz cg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgqth3thd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 04:32:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3954W9s7012196
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 04:32:09 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 21:32:03 -0700
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
Subject: [PATCH V14 4/4] arm64: dts: qcom: ipq6018: add pwm node
Date:   Thu, 5 Oct 2023 10:01:27 +0530
Message-ID: <20231005043127.2690639-5-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005043127.2690639-1-quic_devipriy@quicinc.com>
References: <20231005043127.2690639-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YZOByDK8Xz85dZZbV5JolnEdYeqlHHcB
X-Proofpoint-GUID: YZOByDK8Xz85dZZbV5JolnEdYeqlHHcB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Describe the PWM block on IPQ6018.

The PWM is in the TCSR area. Make &tcsr "simple-mfd" compatible, and add
&pwm as child of &tcsr.

Add also ipq6018 specific compatible string.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
v14:

  Moved ranges just after reg as suggested by Krzysztof

  Picked up the R-b tag

v13:

  No change

v12: 

  No change

v11:

  No change

v10:

  No change

v9:

  Add 'ranges' property (Rob)

v8:

  Add size cell to 'reg' (Rob)

v7:

  Use 'reg' instead of 'offset' (Rob)

  Add qcom,tcsr-ipq6018 (Rob)

  Drop clock-names (Bjorn)

v6:

  Make the PWM node child of TCSR (Rob Herring)

  Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)

v5: Use qcom,pwm-regs for TCSR phandle instead of direct regs

v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index e59b9df96c7e..565e61ce382f 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -390,8 +390,21 @@ tcsr_mutex: hwlock@1905000 {
 		};
 
 		tcsr: syscon@1937000 {
-			compatible = "qcom,tcsr-ipq6018", "syscon";
+			compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
 			reg = <0x0 0x01937000 0x0 0x21000>;
+			ranges = <0x0 0x0 0x01937000 0x21000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			 pwm: pwm@a010 {
+				compatible = "qcom,ipq6018-pwm";
+				reg = <0xa010 0x20>;
+				clocks = <&gcc GCC_ADSS_PWM_CLK>;
+				assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+				assigned-clock-rates = <100000000>;
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
 		};
 
 		usb2: usb@70f8800 {
-- 
2.34.1

