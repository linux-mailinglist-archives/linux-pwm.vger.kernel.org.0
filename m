Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6ED2459F38
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Nov 2021 10:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbhKWJdE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Nov 2021 04:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhKWJdE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Nov 2021 04:33:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53426C061574
        for <linux-pwm@vger.kernel.org>; Tue, 23 Nov 2021 01:29:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7e-0004zR-28; Tue, 23 Nov 2021 10:29:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7c-000acR-Rt; Tue, 23 Nov 2021 10:29:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7b-0004Z9-Rr; Tue, 23 Nov 2021 10:29:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Sean Anderson <sean.anderson@seco.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5] pwm: stmpe: Rename variable pointing to driver private data
Date:   Tue, 23 Nov 2021 10:29:39 +0100
Message-Id: <20211123092939.82705-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123092939.82705-1-u.kleine-koenig@pengutronix.de>
References: <20211123092939.82705-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=ejLSCnLAvxFlJdcNxj9mRQEM+iCHs91+Xy7/VzJyNuw=; m=hUjS9WrbEAC59OGYXSioWWffMZSxuJVJLBvP6HrOxF0=; p=eudYY9q6qK0YHclhuxX5IqP1Oj52MamwQVWqkdldsbQ=; g=d49de416a459cc92504a5420ecfb8f80182ddcb0
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGctIAACgkQwfwUeK3K7Akgcgf7BvR cDL4JfvIrZu62xUp0VDOoqiIpNDLefWsYIyty3nPptUqtMg2n0PleoW8dw75TzpmB3kXdGwz0BmNW 2zvpKQy7tpCDhutWoXT3pmvYRFR30q9aikd+THSJpR4CfZofrGbq7a9B2EUYa5nARC5eaqiu8sTi5 8zzJJ6sDvr9VCLDFhyq1tKvAmZ+iOL9jZN011Rh+bjTY0gn7/pMhLhJbZ9jIRSCZYfvtYCMl6XYKw VOK689eeATEmKeJVJo1T/n3Bq+bKapY5Jy+KZTg6Ab+h7WUQs6juXanUm+ztcAfxcjpEsFA5B7sw7 bjE5AWOaKXaprLnXVfZQpNYlrRznpqw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In all code locations but the probe function variables of type struct
stmpe_pwm * are called "stmpe_pwm". Align the name used in
stmpe_pwm_probe() accordingly. Still more as the current name "pwm" is
usually reserved for variables of type struct pwm_device *.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stmpe.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index 7c0e567ff71c..c4336d3bace3 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -269,19 +269,19 @@ static const struct pwm_ops stmpe_24xx_pwm_ops = {
 static int __init stmpe_pwm_probe(struct platform_device *pdev)
 {
 	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
-	struct stmpe_pwm *pwm;
+	struct stmpe_pwm *stmpe_pwm;
 	int ret;
 
-	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
+	stmpe_pwm = devm_kzalloc(&pdev->dev, sizeof(*stmpe_pwm), GFP_KERNEL);
+	if (!stmpe_pwm)
 		return -ENOMEM;
 
-	pwm->stmpe = stmpe;
-	pwm->chip.dev = &pdev->dev;
+	stmpe_pwm->stmpe = stmpe;
+	stmpe_pwm->chip.dev = &pdev->dev;
 
 	if (stmpe->partnum == STMPE2401 || stmpe->partnum == STMPE2403) {
-		pwm->chip.ops = &stmpe_24xx_pwm_ops;
-		pwm->chip.npwm = 3;
+		stmpe_pwm->chip.ops = &stmpe_24xx_pwm_ops;
+		stmpe_pwm->chip.npwm = 3;
 	} else {
 		if (stmpe->partnum == STMPE1601)
 			dev_err(&pdev->dev, "STMPE1601 not yet supported\n");
@@ -295,7 +295,7 @@ static int __init stmpe_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = pwmchip_add(&pwm->chip);
+	ret = pwmchip_add(&stmpe_pwm->chip);
 	if (ret) {
 		stmpe_disable(stmpe, STMPE_BLOCK_PWM);
 		return ret;
-- 
2.30.2

