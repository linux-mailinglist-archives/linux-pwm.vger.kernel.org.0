Return-Path: <linux-pwm+bounces-932-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4974B83B79A
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 04:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83C11F25482
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 03:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ECC79C3;
	Thu, 25 Jan 2024 03:09:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF366FC5;
	Thu, 25 Jan 2024 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152169; cv=none; b=Zr3kWry79ZNHuThhBhv75ROctna7qTYGz516bw5zJZ5FNiNwRgVux/GgGfDfXS9zOzHzna16kiDbfCms0EI2/Jclg1qH8r5rQy3eAutiOKgmxJqFra0YVUDCh+iBi4cPl5MHsDTe8cemOblQ2QrBzt0TNa1yhHfCzI6dxLmW8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152169; c=relaxed/simple;
	bh=0KbeYM1emDbbUkaKgcHB/jj/ya65prK23nCjPOG+0Y0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILc9Q7fqNIoC2I2Gu0V5HqIwlAfN63oFqhxoEOSNX7M4VTd4OVxWj3a/Iyh0HTyKM0jzkRIYKVFJtbK3jg3hpVfq0by94LrNv8Wq7/ZyAE6lpROSz1Di07JzbcgMinyo6ovgmifLi4wBY0iXZOGiZY29yfoor1I6NqAWQ2zRtVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40P38cmE061480;
	Thu, 25 Jan 2024 11:08:38 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TL5F50ct9z2Rq2lq;
	Thu, 25 Jan 2024 11:01:13 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 25 Jan
 2024 11:08:36 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua
 Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        zhaochen
 su <zhaochen.su29@gmail.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>,
        Xiaolong
 Wang <Xiaolong.Wang@unisoc.com>
Subject: [PATCH V2 2/6] pwm: sprd: Improve the pwm backlight control function
Date: Thu, 25 Jan 2024 10:55:29 +0800
Message-ID: <20240125025533.10315-3-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
References: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 40P38cmE061480

The pwm-sprd driver support only 8-bit linear control of backlight. Now,
new requests of supporting 9-bit, 10-bit, 11-bit and 12-bit linear
control of backlight are proposed. Besides, different channels of pwm
could be configured into different linear control of backlight. Thus,
sprd,mod attribute is introduced into dts for every channel of pwm
device. This attribute would determine the value of MOD and eventually
realize the new requirements.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/pwm/pwm-sprd.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index bc1e3ed13528..cc54aa77c7e6 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -18,7 +18,8 @@
 #define SPRD_PWM_DUTY		0x8
 #define SPRD_PWM_ENABLE		0x18
 
-#define SPRD_PWM_MOD_MAX	GENMASK(7, 0)
+#define SPRD_PWM_MOD_MAX	GENMASK(15, 0)
+#define SPRD_PWM_MOD_DEFAULT	GENMASK(9, 0)
 #define SPRD_PWM_DUTY_MSK	GENMASK(15, 0)
 #define SPRD_PWM_PRESCALE_MSK	GENMASK(7, 0)
 #define SPRD_PWM_ENABLE_BIT	BIT(0)
@@ -43,6 +44,7 @@ struct sprd_pwm_chip {
 	const struct sprd_pwm_data *pdata;
 	int num_pwms;
 	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
+	u32 mod[SPRD_PWM_CHN_NUM];
 };
 
 static const struct sprd_pwm_data ums512_data = {
@@ -120,7 +122,7 @@ static int sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
 	prescale = val & SPRD_PWM_PRESCALE_MSK;
-	tmp = (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
+	tmp = (prescale + 1) * NSEC_PER_SEC * spc->mod[pwm->hwpwm];
 	state->period = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
 
 	val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
@@ -140,7 +142,7 @@ static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
 			   int duty_ns, int period_ns)
 {
 	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
-	u32 prescale, duty;
+	u32 prescale, duty, mod;
 	u64 tmp;
 
 	/*
@@ -148,16 +150,21 @@ static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
 	 * The period length is (PRESCALE + 1) * MOD counter steps.
 	 * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
 	 *
-	 * To keep the maths simple we're always using MOD = SPRD_PWM_MOD_MAX.
+	 * The value for MOD is obtained from dts.
 	 * The value for PRESCALE is selected such that the resulting period
 	 * gets the maximal length not bigger than the requested one with the
-	 * given settings (MOD = SPRD_PWM_MOD_MAX and input clock).
+	 * given settings (MOD and input clock).
 	 */
-	duty = duty_ns * SPRD_PWM_MOD_MAX / period_ns;
+	mod = spc->mod[pwm->hwpwm];
+	duty = duty_ns * mod / period_ns;
 
 	tmp = (u64)chn->clk_rate * period_ns;
 	do_div(tmp, NSEC_PER_SEC);
-	prescale = DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) - 1;
+	prescale = DIV_ROUND_CLOSEST_ULL(tmp, mod);
+	if (prescale < 1)
+		prescale = 1;
+	prescale--;
+
 	if (prescale > SPRD_PWM_PRESCALE_MSK)
 		prescale = SPRD_PWM_PRESCALE_MSK;
 
@@ -170,7 +177,7 @@ static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
 	 * before changing a new configuration to avoid mixed settings.
 	 */
 	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);
-	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
+	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, mod);
 	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);
 
 	return 0;
@@ -263,6 +270,21 @@ static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
 	return 0;
 }
 
+static int sprd_pwm_get_mod(struct platform_device *pdev)
+{
+	int i, ret;
+	struct sprd_pwm_chip *spc = platform_get_drvdata(pdev);
+
+	ret = of_property_read_u32_array(pdev->dev.of_node,
+					 "sprd,mod", spc->mod, spc->num_pwms);
+	if (ret) {
+		for (i = 0; i < spc->num_pwms; i++)
+			spc->mod[i] = SPRD_PWM_MOD_DEFAULT;
+	}
+
+	return ret;
+}
+
 static int sprd_pwm_probe(struct platform_device *pdev)
 {
 	struct sprd_pwm_chip *spc;
@@ -288,6 +310,10 @@ static int sprd_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = sprd_pwm_get_mod(pdev);
+	if (ret)
+		dev_info(&pdev->dev, "get pwm mod failed! Use default setting\n");
+
 	spc->chip.dev = &pdev->dev;
 	spc->chip.ops = &sprd_pwm_ops;
 	spc->chip.npwm = spc->num_pwms;
-- 
2.17.1


