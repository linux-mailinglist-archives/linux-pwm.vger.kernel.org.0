Return-Path: <linux-pwm+bounces-64-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F927F2F98
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA65B20EAB
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F9553819;
	Tue, 21 Nov 2023 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E264D6F
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAV-0005gS-J4; Tue, 21 Nov 2023 14:51:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAS-00Aazy-9i; Tue, 21 Nov 2023 14:51:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAS-004xeX-0b; Tue, 21 Nov 2023 14:51:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 057/108] pwm: imx1: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:59 +0100
Message-ID: <20231121134901.208535-58-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iYureV1+Vd9s2wh3vZQrnZF6wHumB2re5t3FN8kVhAs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWLVqGKbZ8r6i0eKADj3QeX1OW3oky8kmtCt OSSWqn8caSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1iwAKCRCPgPtYfRL+ TpE2B/9hA5i8pjp0qJI1LXjY25zT9nfIPwbhHTYAjW6D7DLdI6tCnx7nwV0YoAh9x7U6pWJklTp 77uzUN2HQ6iKFnmW2hDF7lDYU9bRf2b78A0h30nRQUvYnbAsllR+WsMLeshZbfa1nooFxq0752f GK9njdsREnpIHx51TvjorN0QnlpU3DRdHkf/moi5Z3ESDcW+ojtZ1P+3O+XC7HeBZQmuy5cWb4X /uzmWw4caYm6G28ysZ3DgyGHI1AAU6anUW9C7ELjUl+45DZDY4YlIHSaOL/O3sZnCaS6guzRF0e CkOqro+g7+WzN80D0CN8GAuae7WPNY7tcpiy5OGHrQLG8LY8
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-imx1 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx1.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index d175d895f22a..e4cf6e957b63 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -28,10 +28,9 @@ struct pwm_imx1_chip {
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	void __iomem *mmio_base;
-	struct pwm_chip chip;
 };
 
-#define to_pwm_imx1_chip(chip)	container_of(chip, struct pwm_imx1_chip, chip)
+#define to_pwm_imx1_chip(chip)	pwmchip_priv(chip)
 
 static int pwm_imx1_clk_prepare_enable(struct pwm_chip *chip)
 {
@@ -156,11 +155,13 @@ MODULE_DEVICE_TABLE(of, pwm_imx1_dt_ids);
 
 static int pwm_imx1_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_imx1_chip *imx;
 
-	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
-	if (!imx)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*imx));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	imx = to_pwm_imx1_chip(chip);
 
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg))
@@ -172,15 +173,13 @@ static int pwm_imx1_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
 				     "failed to get peripheral clock\n");
 
-	imx->chip.ops = &pwm_imx1_ops;
-	imx->chip.dev = &pdev->dev;
-	imx->chip.npwm = 1;
+	chip->ops = &pwm_imx1_ops;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-	return devm_pwmchip_add(&pdev->dev, &imx->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver pwm_imx1_driver = {
-- 
2.42.0


