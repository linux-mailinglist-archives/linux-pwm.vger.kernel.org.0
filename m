Return-Path: <linux-pwm+bounces-373-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F66B806EA7
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037541F21167
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828C364A4;
	Wed,  6 Dec 2023 11:48:54 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10169D69
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOK-0007HD-V6; Wed, 06 Dec 2023 12:48:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOI-00Dwwg-Oo; Wed, 06 Dec 2023 12:48:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOI-00FR29-Fj; Wed, 06 Dec 2023 12:48:34 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v4 086/115] pwm: rockchip: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:40 +0100
Message-ID:  <6ff62a16862768b6817819b95e2924e41e05274f.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2782; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=S7YX0LwIqVOrST7fEGIoSpGkN5LeF/GvgXdy7bmFJng=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF8L7yvFClcAEsxR7qwjFMFeptLj1uN1lQo+j wAiKYkyHf2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfCwAKCRCPgPtYfRL+ ToOgB/4nxtvlkfat2L0pkMInq5YCqdx6qHhSfWrrtVUm/8qDbeIWh/3BRuLQDYDSc4e1YNgmz9d qUFCK+r0kDwnNgxqszPj5/LRlviTZu3RnwGvk7U0RR+DKL8trUKjhvSgbNLBf8KXHXNICPn9pus 2N9CpNc2NerpHDaoZSALAyFfNAbORgCNIjLFXS91n1rVyz6Sa3VIFdM/OmHSqMw6zNPy8RWXSNQ Nhd7AIMObGFCVQG+lz3FsgT8WM92EVzuHu3DPbYFZnMaHqKWi1oFNeitaMtrvWwAqKe63z9zDZ6 oDfMan+q7WhGdIIgT7+Oha1hDVbif2lDlNjlAXLUxm/sJnGj
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-rockchip driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rockchip.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index a7c647e37837..0fa7575dbb54 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -30,7 +30,6 @@
 #define PWM_LP_DISABLE		(0 << 8)
 
 struct rockchip_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	struct clk *pclk;
 	const struct rockchip_pwm_data *data;
@@ -54,7 +53,7 @@ struct rockchip_pwm_data {
 
 static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct rockchip_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int rockchip_pwm_get_state(struct pwm_chip *chip,
@@ -296,14 +295,16 @@ MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
 
 static int rockchip_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct rockchip_pwm_chip *pc;
 	u32 enable_conf, ctrl;
 	bool enabled;
 	int ret, count;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_rockchip_pwm_chip(chip);
 
 	pc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->base))
@@ -337,18 +338,16 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	platform_set_drvdata(pdev, pc);
+	platform_set_drvdata(pdev, chip);
 
 	pc->data = device_get_match_data(&pdev->dev);
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &rockchip_pwm_ops;
-	pc->chip.npwm = 1;
+	chip->ops = &rockchip_pwm_ops;
 
 	enable_conf = pc->data->enable_conf;
 	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
 	enabled = (ctrl & enable_conf) == enable_conf;
 
-	ret = pwmchip_add(&pc->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 		goto err_pclk;
@@ -372,9 +371,10 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 static void rockchip_pwm_remove(struct platform_device *pdev)
 {
-	struct rockchip_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 
-	pwmchip_remove(&pc->chip);
+	pwmchip_remove(chip);
 
 	clk_unprepare(pc->pclk);
 	clk_unprepare(pc->clk);
-- 
2.42.0


