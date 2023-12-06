Return-Path: <linux-pwm+bounces-429-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374B4807AC1
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 22:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AA31C2093C
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 21:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA8870998;
	Wed,  6 Dec 2023 21:48:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB3D8F
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 13:48:31 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAzkq-0006V7-IU; Wed, 06 Dec 2023 22:48:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAzko-00E2zQ-W9; Wed, 06 Dec 2023 22:48:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAzko-00Fh9M-LU; Wed, 06 Dec 2023 22:48:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH] pwm: meson: Simplify using dev_err_probe()
Date: Wed,  6 Dec 2023 22:48:18 +0100
Message-ID: <20231206214817.1783227-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2883; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Tn8Hd9ONNtE2oPg+bCO9zcBlXllZPjUZaxCmuYjP46A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcOwiRLiLQc7W+J0r7gA8aypN9RAAEHybHtcjb dHsEK9S3y+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXDsIgAKCRCPgPtYfRL+ Ts2SB/91J0AnPhUkJn5Q3Y5TPHeY4M+MGzxkgGMZ8h8+ulbkSg9UD+Vgpx4wsFEbFTYNiAgOB2X 6GSLD0Nw01kYXexbtt7HqvcyB60mYDzrbRORULe8LS/2WLxCFW9UbvHZG9kh2Q5UnrUoPOJH/Of c+9IDyQ6Xfof38BCSRziGrP069PbbllwC7XxzzeK3uIq4/uhH4PA57w+l1caH75Q7c7stFqF7Ur gSjFqvCS+pQCqMpF/Ca/i8oVOWE0u9lkJg4L5J/baNVCY4vWH0rbcYai/nL+QjCOCljt/fHATZQ TimH1zz1JNxJNaQj3YqOhUT/wuPOSl8mesSFHSr7A8QXPUT9
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Using dev_err_probe() emitting an error message mentioning a return
value and returning that value can be done in a single statement. Make
use of that to simplify the probe part of the driver. This has the
additional advantage to emit the symbolic name for the error instead of
the integer error value.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

while trying to understand Jerome's series[1] I noticed this patch
opportunity.

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/20231129134004.3642121-1-jbrunet@baylibre.com

 drivers/pwm/pwm-meson.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5bea53243ed2..2971bbf3b5e7 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -468,10 +468,9 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		channel->mux.hw.init = &init;
 
 		err = devm_clk_hw_register(dev, &channel->mux.hw);
-		if (err) {
-			dev_err(dev, "failed to register %s: %d\n", name, err);
-			return err;
-		}
+		if (err)
+			return dev_err_probe(dev, err,
+					     "failed to register %s\n", name);
 
 		snprintf(name, sizeof(name), "%s#div%u", dev_name(dev), i);
 
@@ -491,10 +490,9 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		channel->div.lock = &meson->lock;
 
 		err = devm_clk_hw_register(dev, &channel->div.hw);
-		if (err) {
-			dev_err(dev, "failed to register %s: %d\n", name, err);
-			return err;
-		}
+		if (err)
+			return dev_err_probe(dev, err,
+					     "failed to register %s\n", name);
 
 		snprintf(name, sizeof(name), "%s#gate%u", dev_name(dev), i);
 
@@ -513,17 +511,13 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		channel->gate.lock = &meson->lock;
 
 		err = devm_clk_hw_register(dev, &channel->gate.hw);
-		if (err) {
-			dev_err(dev, "failed to register %s: %d\n", name, err);
-			return err;
-		}
+		if (err)
+			return dev_err_probe(dev, err, "failed to register %s\n", name);
 
 		channel->clk = devm_clk_hw_get_clk(dev, &channel->gate.hw, NULL);
-		if (IS_ERR(channel->clk)) {
-			err = PTR_ERR(channel->clk);
-			dev_err(dev, "failed to register %s: %d\n", name, err);
-			return err;
-		}
+		if (IS_ERR(channel->clk))
+			return dev_err_probe(dev, PTR_ERR(channel->clk),
+					     "failed to register %s\n", name);
 	}
 
 	return 0;
@@ -554,10 +548,9 @@ static int meson_pwm_probe(struct platform_device *pdev)
 		return err;
 
 	err = devm_pwmchip_add(&pdev->dev, &meson->chip);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", err);
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(&pdev->dev, err,
+				     "failed to register PWM chip\n");
 
 	return 0;
 }
-- 
2.42.0


