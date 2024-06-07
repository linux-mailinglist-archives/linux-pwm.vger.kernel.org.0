Return-Path: <linux-pwm+bounces-2379-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 923569009D8
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 18:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A301F236AF
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56BB199384;
	Fri,  7 Jun 2024 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bIhnUW/i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E80D2EE;
	Fri,  7 Jun 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776181; cv=none; b=uu4+zUn52RHgfMAeJEMt95BU30v/ZHXTZUa5SEq11I8VFwRgeEoEoEOKud55qNwJa12kMWuNSux/80iZjVE0F+8Pc9WnCLvd5SwOzY/NO3SRqa4NLY06DjGdMRHPfBcxCWcSiHB4YdJhbxFry/zVOvHmAbbd4GUVxpDJnxSsFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776181; c=relaxed/simple;
	bh=8xGPJ18+HBP/2spAh6ITaeEbKwVFwjcYNTVE6lfhics=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Pm8fenflAjxLXqfHU+Ikrn/0zeN+RAhwEUFQ3acQVDh0PrGSuL5nG3KgPkHZnL5JCc/5XfA3QjN+Y+AcSwTigXN5NC/Yp3Nzqtn06dOV1cuKMUYyu1d+UJgwa7sU3YkRZfotN2ZZKzNaVTexQXpwK8rZlJ4+y+zGrndH6Etby/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bIhnUW/i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457EmnwF010653;
	Fri, 7 Jun 2024 16:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4zyNQTIq2I6bGzfO6ANQkw
	yFQAtcRA8n30vnfURCfX4=; b=bIhnUW/isCLT0Z+5Jmiezpp0Nt5GmOlKO1TVxU
	WF01DyMVFNxDR9ldgg8FKy1QZNfSaLzHanEboC7I+0EPJMhRhZB9plP7lwvuGnU8
	wR/y7j3cfI/n7Lz4Qrq2KPL2v5pihyNfhJqYh+a+zHU5kb/E+47X1CWzUOZjpcDP
	FcAcwMg/a/ThvIlFw41v6F+Cugu847Uar6PBil5z9t9yOulp3wms1YrtKAzTiQgd
	YB1SL9839Ls/MyBvkEjT2TC2WkBnQyGjC5oQTkH7U9yQERWaX0dqzczBS191Bc5E
	MikG9fAVNoT8PTYsAAsw8hEwM96mk95p2YPaBLlcSgqL24Nw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ym49w066w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 16:02:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457G2YII024794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 16:02:34 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 09:02:34 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 7 Jun 2024 09:02:33 -0700
Subject: [PATCH] pwm: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-md-drivers-pwm-v1-1-27237a2bec6a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABgvY2YC/x3MQQrCQAxG4auUrA2MpejgVcTFtPlrA85YEq2F0
 rs7uvwW723kMIXTpdnIsKjrs1QcDw0NUyp3sEo1taHtwimcOQuL6QJznj+Z49hJFEGMEqhGs2H
 U9T+83qr75ODeUhmm3+ah5b1yTv6C0b5/AdiyANt/AAAA
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
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Xsaju1_HnI3ToMw3WAE6tj1QihTgS0au
X-Proofpoint-GUID: Xsaju1_HnI3ToMw3WAE6tj1QihTgS0au
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_09,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 malwarescore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406070119

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

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
This addresses all of the issues in driver/pwm

Let me know if you want any of the individual module changes
segregated into separate patches.
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
index 19a87873ad60..0b5d68a90e83 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -395,4 +395,5 @@ static struct platform_driver pwm_mediatek_driver = {
 module_platform_driver(pwm_mediatek_driver);
 
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_DESCRIPTION("MediaTek Pulse Width Modulator driver");
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


