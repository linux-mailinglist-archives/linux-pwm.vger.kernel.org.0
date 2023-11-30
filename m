Return-Path: <linux-pwm+bounces-256-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500267FE62F
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 02:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D110285747
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 01:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8EEF9CE;
	Thu, 30 Nov 2023 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AvFmGq7e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034B610CB;
	Wed, 29 Nov 2023 17:36:54 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU0Guml007535;
	Thu, 30 Nov 2023 01:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=uEQzzl4ceRlKkxGu38WAcqokWeN1eQqjwXh336oDT3Y=;
 b=AvFmGq7eXwf2l4+wqyBw+Z4pyAz9VIg8atq32do5nbXziQ5Zc23ObBRDKFSHjPNSHkRo
 IkSMYd7WO5nYXj4XS8A1in7Kf2vrByiRRpdzgs+5Y4Re6UO1R6Pmw13xU+gM1p1xQsH8
 b5Riok9Ft9lLfWjo3z8I1ABDFmODA0suTepJ7MI5tnB47zKNbefZK6mYnRFi91xUbxjo
 RudQT+H1xuOEKjbIbOVlSKOxxiKfKJw6O/T70oW+rMEbI+aah5tW4/I0b3nxrQP97Hpw
 ebDS0+9PQhqYIt3m8KYR8+R+wNroc2zGmZNSIdgg2w+AlzmoDgQzkPj6KAruTUd0/5Qm dg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up2s0a6qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 01:36:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AU1agFM014535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 01:36:42 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 17:36:42 -0800
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC: <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        "Anjelique
 Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH v7 5/7] leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data to support PPG
Date: Wed, 29 Nov 2023 17:36:13 -0800
Message-ID: <20231130013615.14287-6-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130013615.14287-1-quic_amelende@quicinc.com>
References: <20231130013615.14287-1-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EFetVc-Yx7lKql84HK9XebZqxiRe9HWR
X-Proofpoint-GUID: EFetVc-Yx7lKql84HK9XebZqxiRe9HWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311300010

Update the pmi632 lpg_data struct so that pmi632 devices use PPG
for LUT pattern.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
Reviewed-by: Lee Jones <lee@kernel.org>
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index a3e4adffb8df..8d2647aeb3b4 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1637,11 +1637,13 @@ static const struct lpg_data pm8994_lpg_data = {
 static const struct lpg_data pmi632_lpg_data = {
 	.triled_base = 0xd000,
 
+	.lut_size = 64,
+
 	.num_channels = 5,
 	.channels = (const struct lpg_channel_data[]) {
-		{ .base = 0xb300, .triled_mask = BIT(7) },
-		{ .base = 0xb400, .triled_mask = BIT(6) },
-		{ .base = 0xb500, .triled_mask = BIT(5) },
+		{ .base = 0xb300, .triled_mask = BIT(7), .sdam_offset = 0x48 },
+		{ .base = 0xb400, .triled_mask = BIT(6), .sdam_offset = 0x56 },
+		{ .base = 0xb500, .triled_mask = BIT(5), .sdam_offset = 0x64 },
 		{ .base = 0xb600 },
 		{ .base = 0xb700 },
 	},
-- 
2.41.0


