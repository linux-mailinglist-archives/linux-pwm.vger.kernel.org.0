Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F00459F3A
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Nov 2021 10:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhKWJdE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Nov 2021 04:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbhKWJdE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Nov 2021 04:33:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9593EC061714
        for <linux-pwm@vger.kernel.org>; Tue, 23 Nov 2021 01:29:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7e-0004zN-By; Tue, 23 Nov 2021 10:29:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7c-000acJ-EV; Tue, 23 Nov 2021 10:29:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7b-0004YY-FL; Tue, 23 Nov 2021 10:29:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Sean Anderson <sean.anderson@seco.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 3/5] pwm: sun4i: Rename variable pointing to driver private data
Date:   Tue, 23 Nov 2021 10:29:37 +0100
Message-Id: <20211123092939.82705-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123092939.82705-1-u.kleine-koenig@pengutronix.de>
References: <20211123092939.82705-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=cjdLkA3LZeHWzYecFxlzrpQ2mOkbiVMypVUnsbU8I1M=; m=BXHJHrUN+O84L+Xrt1jBdNnjPN4/Gs+4D0WYNGSAJ6s=; p=1EpuS5K8SIVpQtaFTworj1LZkqEhu03mND0JYFcH54s=; g=b6f39cd8c9d77da536fa94ab35d3f27d106335a8
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGctHkACgkQwfwUeK3K7AmMzQf7BfN G2crKhlQDby77QU0zEbff286wzJUaDEeONOuAG4xB0dnFrWfBGeHjzQ8QlBlMUnW9g6phxSn+hXJA 2v/yk+ojCXuaYvk4TQ7X+oEyJ6v1wxamhdGkgXcMqowSbi6PwTc0wH91g0lDaaI8J847bpcspmCJr UEFfhK7dY/HkNkDLFD4iKVg7/SlkUeLwyeGEfQ0WtD9u+lpehOTZlEhPHlomZODjJX785O48JOnCi JOC3CHfVJ/4kp0CFoMeeOabA7YxYGvIRl9QsGN+hAVLo81xJZHTnvw5bxlNDwyB8zq59YZ2bVPUxc HN6Ndp+lTe5D4Ldf20HDr7ljDQrOJrA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Status quo is that variables of type struct sun4i_pwm_chip * are named
"pwm". This name is usually reserved for variabled of type struct
pwm_chip *.

So consistently use the same and non-conflicting name "sun4ichip" which
better reflects the intend

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sun4i.c | 70 ++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 91ca67651abd..16d75f9aa36a 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -390,20 +390,20 @@ MODULE_DEVICE_TABLE(of, sun4i_pwm_dt_ids);
 
 static int sun4i_pwm_probe(struct platform_device *pdev)
 {
-	struct sun4i_pwm_chip *pwm;
+	struct sun4i_pwm_chip *sun4ichip;
 	int ret;
 
-	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
+	sun4ichip = devm_kzalloc(&pdev->dev, sizeof(*sun4ichip), GFP_KERNEL);
+	if (!sun4ichip)
 		return -ENOMEM;
 
-	pwm->data = of_device_get_match_data(&pdev->dev);
-	if (!pwm->data)
+	sun4ichip->data = of_device_get_match_data(&pdev->dev);
+	if (!sun4ichip->data)
 		return -ENODEV;
 
-	pwm->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pwm->base))
-		return PTR_ERR(pwm->base);
+	sun4ichip->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sun4ichip->base))
+		return PTR_ERR(sun4ichip->base);
 
 	/*
 	 * All hardware variants need a source clock that is divided and
@@ -416,30 +416,30 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	 * unnamed one of the PWM device) and if this is not found we fall
 	 * back to the first clock of the PWM.
 	 */
-	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
-	if (IS_ERR(pwm->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->clk),
+	sun4ichip->clk = devm_clk_get_optional(&pdev->dev, "mod");
+	if (IS_ERR(sun4ichip->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun4ichip->clk),
 				     "get mod clock failed\n");
 
-	if (!pwm->clk) {
-		pwm->clk = devm_clk_get(&pdev->dev, NULL);
-		if (IS_ERR(pwm->clk))
-			return dev_err_probe(&pdev->dev, PTR_ERR(pwm->clk),
+	if (!sun4ichip->clk) {
+		sun4ichip->clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(sun4ichip->clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(sun4ichip->clk),
 					     "get unnamed clock failed\n");
 	}
 
-	pwm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
-	if (IS_ERR(pwm->bus_clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->bus_clk),
+	sun4ichip->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
+	if (IS_ERR(sun4ichip->bus_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun4ichip->bus_clk),
 				     "get bus clock failed\n");
 
-	pwm->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
-	if (IS_ERR(pwm->rst))
-		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->rst),
+	sun4ichip->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+	if (IS_ERR(sun4ichip->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun4ichip->rst),
 				     "get reset failed\n");
 
 	/* Deassert reset */
-	ret = reset_control_deassert(pwm->rst);
+	ret = reset_control_deassert(sun4ichip->rst);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot deassert reset control: %pe\n",
 			ERR_PTR(ret));
@@ -450,45 +450,45 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	 * We're keeping the bus clock on for the sake of simplicity.
 	 * Actually it only needs to be on for hardware register accesses.
 	 */
-	ret = clk_prepare_enable(pwm->bus_clk);
+	ret = clk_prepare_enable(sun4ichip->bus_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot prepare and enable bus_clk %pe\n",
 			ERR_PTR(ret));
 		goto err_bus;
 	}
 
-	pwm->chip.dev = &pdev->dev;
-	pwm->chip.ops = &sun4i_pwm_ops;
-	pwm->chip.npwm = pwm->data->npwm;
+	sun4ichip->chip.dev = &pdev->dev;
+	sun4ichip->chip.ops = &sun4i_pwm_ops;
+	sun4ichip->chip.npwm = sun4ichip->data->npwm;
 
-	spin_lock_init(&pwm->ctrl_lock);
+	spin_lock_init(&sun4ichip->ctrl_lock);
 
-	ret = pwmchip_add(&pwm->chip);
+	ret = pwmchip_add(&sun4ichip->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 		goto err_pwm_add;
 	}
 
-	platform_set_drvdata(pdev, pwm);
+	platform_set_drvdata(pdev, sun4ichip);
 
 	return 0;
 
 err_pwm_add:
-	clk_disable_unprepare(pwm->bus_clk);
+	clk_disable_unprepare(sun4ichip->bus_clk);
 err_bus:
-	reset_control_assert(pwm->rst);
+	reset_control_assert(sun4ichip->rst);
 
 	return ret;
 }
 
 static int sun4i_pwm_remove(struct platform_device *pdev)
 {
-	struct sun4i_pwm_chip *pwm = platform_get_drvdata(pdev);
+	struct sun4i_pwm_chip *sun4ichip = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&pwm->chip);
+	pwmchip_remove(&sun4ichip->chip);
 
-	clk_disable_unprepare(pwm->bus_clk);
-	reset_control_assert(pwm->rst);
+	clk_disable_unprepare(sun4ichip->bus_clk);
+	reset_control_assert(sun4ichip->rst);
 
 	return 0;
 }
-- 
2.30.2

