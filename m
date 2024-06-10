Return-Path: <linux-pwm+bounces-2400-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A5E90249B
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 16:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F11C21110
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 14:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E95132136;
	Mon, 10 Jun 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DdmHsHh/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6078C132108;
	Mon, 10 Jun 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031100; cv=none; b=DkDyn4Np/nnxMBT5SUzbMmMLIVl0P9+BkoQOkC3MYPUmcGlQXnHOTYwtuBVFwcTYvOUJfTunPZq7anQS6GJeEzdzjuUt9I9hD9tzO/xBBTkyYLTEClUujtFHkr2tLBxEaRKwmYUYBDf/x7iSGRNAk1MF+gVoc+BwEUrG9uDfkv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031100; c=relaxed/simple;
	bh=90FTsv6dScWN5UzScpJ/8KwuMAzNq5tLntsYs2eBTXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=jGFBFWL3Ul1SZS+7ED0PKYJw6GguDgOb+s8zzznbSPutXDTE5nSeelJ9P8yFkHMXSrjT5G6tWc9aqeKPcsNj8ZjJxR3eNXnqsDPQ5LqtOSVsz2KKW9DEpIOmrogErzVH3fweaqy1p6sIX36/7KxsnFrUuSbS5QfSaOkUcpyQix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DdmHsHh/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ADdHjC006505;
	Mon, 10 Jun 2024 14:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dO85qnNR874xjrfA9oUBJs
	FPd+deDOJ01X32rKUnTug=; b=DdmHsHh/c4YSVrgqfJ7WbFgLOF0IiSJ7ByTUcH
	W+EO1gzDuAH9NH+gEEPHn7ynrh4ymV9GGHp72PLKXhLvfgELcqY/CBMeOtGw2GRN
	sXjmRPQitS/BqsbHkkzlpAJLnTtKYLnmm4U2QA2TKsxeWHT/YhHkI91KuuxbAnbo
	HCHDoEQ1mzvr/nJ8N9qBC5mRmJpf6hiL1vsgzU3bqtPUMNWPCwPDSeTITDgcuebp
	BIuejm0q1AOG5eiGjFTtwrUbcr3V912xSrGRMYbRp6/pbo0qRunD1PLs1ntWgrU1
	Mrr/eow/Et89hMpynAnH/Zie1omAJENUe/5Dfcz8t2jJ/oRg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymgfk4ajm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:51:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45AEpHjS011360
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:51:17 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 07:51:16 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 10 Jun 2024 07:51:15 -0700
Subject: [PATCH v2] pwm: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240610-md-drivers-pwm-v2-1-b337cfaa70ea@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOISZ2YC/3WNQQ6CMBBFr0K6dkypBBpX3sOwKO0gk9iiU6gYw
 t0t7F2+5P/3VhGRCaO4FqtgTBRpDBnUqRB2MOGBQC6zUFJVspYNeAeOKSFHeH086L5y2jnU2km
 RTy/GnpZDeG8zdyYidGyCHXbNk8K8gDdxQt7nA8Vp5O+RT+V++ltKJZSgGnVpjOrQ1ub2nslSs
 Gc7etFu2/YDp+mzzM0AAAA=
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Shawn Guo
	<shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix
 Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Matthias Brugger
	<matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pwm@vger.kernel.org>, <imx@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zHjYqTrcAzlWXM4YwnwTfTacrLPE8f1E
X-Proofpoint-ORIG-GUID: zHjYqTrcAzlWXM4YwnwTfTacrLPE8f1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100113

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-imx1.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-imx27.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-intel-lgm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-mediatek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-pxa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-samsung.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-spear.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-visconti.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
This addresses all of the issues in driver/pwm

Let me know if you want any of the individual module changes
segregated into separate patches.
---
Changes in v2:
- Updated pwm-mediatek.c description per AngeloGioacchino Del Regno
- Link to v1: https://lore.kernel.org/r/20240607-md-drivers-pwm-v1-1-27237a2bec6a@quicinc.com
---
 drivers/pwm/pwm-imx1.c      | 1 +
 drivers/pwm/pwm-imx27.c     | 1 +
 drivers/pwm/pwm-intel-lgm.c | 1 +
 drivers/pwm/pwm-mediatek.c  | 1 +
 drivers/pwm/pwm-pxa.c       | 1 +
 drivers/pwm/pwm-samsung.c   | 1 +
 drivers/pwm/pwm-spear.c     | 1 +
 drivers/pwm/pwm-visconti.c  | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index 1d2aae2d278f..d5535d208005 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -194,5 +194,6 @@ static struct platform_driver pwm_imx1_driver = {
 };
 module_platform_driver(pwm_imx1_driver);
 
+MODULE_DESCRIPTION("i.MX1 and i.MX21 Pulse Width Modulator driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index e1412116ef65..9e2bbf5b4a8c 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -352,5 +352,6 @@ static struct platform_driver imx_pwm_driver = {
 };
 module_platform_driver(imx_pwm_driver);
 
+MODULE_DESCRIPTION("i.MX27 and later i.MX SoCs Pulse Width Modulator driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
index f9cc7c17c8f0..084c71a0a11b 100644
--- a/drivers/pwm/pwm-intel-lgm.c
+++ b/drivers/pwm/pwm-intel-lgm.c
@@ -230,4 +230,5 @@ static struct platform_driver lgm_pwm_driver = {
 };
 module_platform_driver(lgm_pwm_driver);
 
+MODULE_DESCRIPTION("Intel LGM Pulse Width Modulator driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 19a87873ad60..01dfa0fab80a 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -395,4 +395,5 @@ static struct platform_driver pwm_mediatek_driver = {
 module_platform_driver(pwm_mediatek_driver);
 
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_DESCRIPTION("MediaTek general purpose Pulse Width Modulator driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index bb7bb48b2e6d..430bd6a709e9 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -208,4 +208,5 @@ static struct platform_driver pwm_driver = {
 
 module_platform_driver(pwm_driver);
 
+MODULE_DESCRIPTION("PXA Pulse Width Modulator driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index efb60c9f0cb3..7adf4f2b1049 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -644,6 +644,7 @@ static struct platform_driver pwm_samsung_driver = {
 };
 module_platform_driver(pwm_samsung_driver);
 
+MODULE_DESCRIPTION("Samsung Pulse Width Modulator driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Tomasz Figa <tomasz.figa@gmail.com>");
 MODULE_ALIAS("platform:samsung-pwm");
diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index 6c6f3b38c835..4f372279f313 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -255,6 +255,7 @@ static struct platform_driver spear_pwm_driver = {
 
 module_platform_driver(spear_pwm_driver);
 
+MODULE_DESCRIPTION("ST Microelectronics SPEAr Pulse Width Modulator driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Shiraz Hashim <shiraz.linux.kernel@gmail.com>");
 MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.com>");
diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
index 9e55380957be..28fae4979e3f 100644
--- a/drivers/pwm/pwm-visconti.c
+++ b/drivers/pwm/pwm-visconti.c
@@ -170,6 +170,7 @@ static struct platform_driver visconti_pwm_driver = {
 };
 module_platform_driver(visconti_pwm_driver);
 
+MODULE_DESCRIPTION("Toshiba Visconti Pulse Width Modulator driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>");
 MODULE_ALIAS("platform:pwm-visconti");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240607-md-drivers-pwm-8f4d8dde88d0


