Return-Path: <linux-pwm+bounces-1014-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB11883C1F4
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAF41C22CE4
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3B236122;
	Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB333F8CA
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184660; cv=none; b=SdgBgm5aEi2r/MsUrABpjgCdnMIGbN0YqwOTXLEMxfjEbrMermEGuyK/CtHKwGACofqoAZpEFA6ptUe8A0VHD3IevcwAVU3Ww7Hf1iLJGkFfbVfheOTM5mEYRFLwff/3zXZfkwi7aU6uPHeVwk5/gzdesGquFEJkiykMDMDL8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184660; c=relaxed/simple;
	bh=ukuq/upRaKSHMe7wnmqBckKHj+7jwS2TK/A0pkRgwbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmSI2JP8tr5CvvpXsSnQoWxGFa2xUfgNs9nY6AixqQDpiWZf6kMxoUkesG3Fg/jNfDJAoC/swHi0luaV1rcA+/6Txpr9dK898XSazeRlH2/V0wyfzVUocASsMazfIeXtYqfL+hxaDhfHI2rLb6jbR+oq0E5haFN81Md3ltnV6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-0004Tg-P5; Thu, 25 Jan 2024 13:10:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-002HTm-KA; Thu, 25 Jan 2024 13:10:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-007n3Q-1m;
	Thu, 25 Jan 2024 13:10:55 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 079/111] pwm: pxa: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:41 +0100
Message-ID:  <ed802bad17032860c045ffdea22c2d2eb356d0fe.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2323; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ukuq/upRaKSHMe7wnmqBckKHj+7jwS2TK/A0pkRgwbk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+XzjyDy2CyiFzlZvX5jTSmp//K3kWNTfG7j RR24G4I28CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPlwAKCRCPgPtYfRL+ TpzEB/9s1sOHH44KhKGRI3EFLlcR0FQ0oPDXq1cOkF70gD/F7Bf89x5Ds/1cC8yjCW7yJAtz4I+ BekPIa/nqRqOIKTQb+H4pJoJzC6Zsfhyu2qs2dZMljqfE5KU6hL1xf4Mq9UxQx79Mrk+L/2ZCdg FLQrxgHMFigSSjP4yu4l8cONUsFa+HRvVjQlBW9OVfVCxIsf0ZrmN98T+0u2K2J3EYnCYWKEOeb drZvjIuhYkmQ396fDm0kdT4GHzPZor+Rq2+zPnpc5gIlLgjhwUonT5Wh5KWxUr2E65zzS0jVc/f 5NoAedZLF2KZ3862Kunp1ojiTlEbM5alEHdUzpMqSgcGMTMZ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-pxa driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pxa.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 61b74fa1d348..eb12b9f83cee 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -49,7 +49,6 @@ MODULE_DEVICE_TABLE(platform, pwm_id_table);
 #define PWMDCR_FD	(1 << 10)
 
 struct pxa_pwm_chip {
-	struct pwm_chip	chip;
 	struct device	*dev;
 
 	struct clk	*clk;
@@ -58,7 +57,7 @@ struct pxa_pwm_chip {
 
 static inline struct pxa_pwm_chip *to_pxa_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pxa_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /*
@@ -159,6 +158,7 @@ MODULE_DEVICE_TABLE(of, pwm_of_match);
 static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct pwm_chip *chip;
 	struct pxa_pwm_chip *pc;
 	int ret = 0;
 
@@ -168,26 +168,27 @@ static int pwm_probe(struct platform_device *pdev)
 	if (id == NULL)
 		return -EINVAL;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (pc == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev,
+				  (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1,
+				  sizeof(*pc));
+	if (chip == NULL)
 		return -ENOMEM;
+	pc = to_pxa_pwm_chip(chip);
 
 	pc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pc->clk))
 		return PTR_ERR(pc->clk);
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &pxa_pwm_ops;
-	pc->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
+	chip->ops = &pxa_pwm_ops;
 
 	if (IS_ENABLED(CONFIG_OF))
-		pc->chip.of_xlate = of_pwm_single_xlate;
+		chip->of_xlate = of_pwm_single_xlate;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
 		return PTR_ERR(pc->mmio_base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		return ret;
-- 
2.43.0


