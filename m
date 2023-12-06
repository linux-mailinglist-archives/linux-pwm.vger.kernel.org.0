Return-Path: <linux-pwm+bounces-377-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B67806EB0
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046F01F215D5
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21350364BF;
	Wed,  6 Dec 2023 11:48:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675FD10D3
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOI-0006qb-CI; Wed, 06 Dec 2023 12:48:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOF-00DwvL-6p; Wed, 06 Dec 2023 12:48:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOE-00FR0j-U5; Wed, 06 Dec 2023 12:48:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v4 064/115] pwm: imx27: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:18 +0100
Message-ID:  <a415a12f067bfd915c16459622b3efc1df8b8760.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2468; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+k3c/BNFs+KXGssS5D9fkck+HGWhgZ82KfNo1bW2Szg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF7JihS0PvJI4tr7qWFEAGgEYWpLpONuTWesc eM9hUzDPmuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeyQAKCRCPgPtYfRL+ TsLaB/sElJfl31C8w6bsYKcHoouhKfYBI5PcetqNwH57gIR9zUmRqAqZ7Z4Oiafjeoi02s2cKv5 9XRhGCbwI6/xp+FxyrkYWXHyOWiW+Du43FvBfkn0DCobRsn+XDHTnDdzRsL6fQq8HW5X5T7NVSP KaDo+ieQBwabyDivzAw2mnB/AJO4aJlGowSHs9Q/Twl2gI7zQlnvz7A7CiXDkm8oVzZEIS7OSaL ZHVUPbIgk4s+JrZR/SY3HdavvRd/8j/9JYHWL7wkdSUNaqCXaG6ix40+T1YUaegwetlHX1nmq6U diPa9mzD9cG0PZe3AaRu6Lt9iWFSw+Y/FoD1mlO/6rfd/kiI
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-imx27 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 5d796453519a..54589f0b3b78 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -83,7 +83,6 @@ struct pwm_imx27_chip {
 	struct clk	*clk_ipg;
 	struct clk	*clk_per;
 	void __iomem	*mmio_base;
-	struct pwm_chip	chip;
 
 	/*
 	 * The driver cannot read the current duty cycle from the hardware if
@@ -93,7 +92,10 @@ struct pwm_imx27_chip {
 	unsigned int duty_cycle;
 };
 
-#define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
+static inline struct pwm_imx27_chip *to_pwm_imx27_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
 
 static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
 {
@@ -306,13 +308,15 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
 
 static int pwm_imx27_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_imx27_chip *imx;
 	int ret;
 	u32 pwmcr;
 
-	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
-	if (imx == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*imx));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	imx = to_pwm_imx27_chip(chip);
 
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg))
@@ -324,9 +328,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
 				     "failed to get peripheral clock\n");
 
-	imx->chip.ops = &pwm_imx27_ops;
-	imx->chip.dev = &pdev->dev;
-	imx->chip.npwm = 1;
+	chip->ops = &pwm_imx27_ops;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
@@ -341,7 +343,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	if (!(pwmcr & MX3_PWMCR_EN))
 		pwm_imx27_clk_disable_unprepare(imx);
 
-	return devm_pwmchip_add(&pdev->dev, &imx->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver imx_pwm_driver = {
-- 
2.42.0


