Return-Path: <linux-pwm+bounces-89-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 707A27F2FB4
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10240B20B8C
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6883553806;
	Tue, 21 Nov 2023 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A15D67
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAd-0006Zk-5Z; Tue, 21 Nov 2023 14:52:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAb-00Ab2c-RP; Tue, 21 Nov 2023 14:52:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAb-004xhV-IR; Tue, 21 Nov 2023 14:52:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 098/108] pwm: vt8500: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:40 +0100
Message-ID: <20231121134901.208535-99-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=HzjuSrKnWX8ZPRAZT/TNFfYQbfuRgII0D79E6MOrP6Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLW4qNYRp9Emm0I4TN4q5I0oFssqH6D7Hu9+y 21ExAPYH7uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1uAAKCRCPgPtYfRL+ TmSsB/sGp7ZgHRMkW64R4AEscM1/w9a/kG24kn06aPeo6N+fpPOI2ZSgUH5n+x1YYEKIvTUIfsw OoTO3pYtwk5Y6sCQTY211bGBYdOnAaKG2XNToP+lnRHwySnguyV5Gi7Ney73G8fI8kgTInZYcR2 lMjK7hw50TJrqOhcQ7FpCMkkLNW5/Fz/o4vbLbA1+l7ZX8YQmqwfTyrPrQi9PGqtsQErdFlo3yD qrOprBwCeA15g+J0hKyCkGm1Ludd1dN5Wqq3EhKH9dnEz4B5gNy0G2s7B3pJZVmlj6SCg75kZEV 5ULNv8CBzdi9BHBd1JWUZS4raEQk0K9NsfCBPdjQcxiFOxEL
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-vt8500 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-vt8500.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 16046f936d98..22c8695c3337 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -45,12 +45,14 @@
 #define STATUS_ALL_UPDATE	0x0F
 
 struct vt8500_chip {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
-#define to_vt8500_chip(chip)	container_of(chip, struct vt8500_chip, chip)
+static inline struct vt8500_chip *to_vt8500_chip(struct pwm_chip *chip)
+{
+	return pwmchip_priv(chip);
+}
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 static inline void vt8500_pwm_busy_wait(struct pwm_chip *chip, int nr, u8 bitmask)
@@ -232,6 +234,7 @@ MODULE_DEVICE_TABLE(of, vt8500_pwm_dt_ids);
 
 static int vt8500_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct vt8500_chip *vt8500;
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
@@ -239,13 +242,12 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	if (!np)
 		return dev_err_probe(&pdev->dev, -EINVAL, "invalid devicetree node\n");
 
-	vt8500 = devm_kzalloc(&pdev->dev, sizeof(*vt8500), GFP_KERNEL);
-	if (vt8500 == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, VT8500_NR_PWMS, sizeof(*vt8500));
+	if (chip == NULL)
 		return -ENOMEM;
+	vt8500 = to_vt8500_chip(chip);
 
-	vt8500->chip.dev = &pdev->dev;
-	vt8500->chip.ops = &vt8500_pwm_ops;
-	vt8500->chip.npwm = VT8500_NR_PWMS;
+	chip->ops = &vt8500_pwm_ops;
 
 	vt8500->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(vt8500->clk))
@@ -255,7 +257,7 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(vt8500->base))
 		return PTR_ERR(vt8500->base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &vt8500->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-- 
2.42.0


