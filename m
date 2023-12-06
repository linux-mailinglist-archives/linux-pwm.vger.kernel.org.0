Return-Path: <linux-pwm+bounces-391-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AC4806EC4
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D508B20DE5
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D2434552;
	Wed,  6 Dec 2023 11:49:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ED110E9
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOK-00076B-8s; Wed, 06 Dec 2023 12:48:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOH-00Dww5-4V; Wed, 06 Dec 2023 12:48:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOG-00FR1V-RY; Wed, 06 Dec 2023 12:48:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 076/115] pwm: microchip-core: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:30 +0100
Message-ID:  <2dda818b8bbbe8ba4b9df5ab54f960ff4a4f1ab5.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2673; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=O91DAufZtIdpecS5GjcVtAu43YTifjp2DD84oKMoiQ4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF7w02HcUkYomobV9EpgiVKZNLKi9HhzNAK8u 6PTGLIc66aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBe8AAKCRCPgPtYfRL+ TvlTB/43dhCjkvfOwxLcHlj5eVH8cQihuwWD6HipskzoY6wOBTk/4OfgHuXBW3qLUqGQATKfEqQ Biw70nce8bXSYYTw1sSc4FzKrcBDeyC1lz+mhpJ8rBLmRRrgQ/iHw/YRf0S6CZKeuUVKBe/Juic ZgXNy3g7ysBnNJeEPQGwD/PvejSlq41ALzzA0I3OgcRlL2FMaT19jBGiO85/XII53Hu4QauNJLI hBDWlgJ54AQJ5o4ec4DtAARiIf+jWxfk5zHKsT+jz0q0WmRL+Lwx9LFodc0KVvKhMaEfT2l358w QUrrNUdt3D0HEGvukxh+HclDHLvfNq5GJvNEbqpUYMMQsWpC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-microchip-core driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-microchip-core.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-core.c
index c0c53968f3e9..c1f2287b8e97 100644
--- a/drivers/pwm/pwm-microchip-core.c
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -54,7 +54,6 @@
 #define MCHPCOREPWM_TIMEOUT_MS	100u
 
 struct mchp_core_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct mutex lock; /* protects the shared period */
@@ -65,7 +64,7 @@ struct mchp_core_pwm_chip {
 
 static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct mchp_core_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -447,13 +446,15 @@ MODULE_DEVICE_TABLE(of, mchp_core_of_match);
 
 static int mchp_core_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct mchp_core_pwm_chip *mchp_core_pwm;
 	struct resource *regs;
 	int ret;
 
-	mchp_core_pwm = devm_kzalloc(&pdev->dev, sizeof(*mchp_core_pwm), GFP_KERNEL);
-	if (!mchp_core_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 16, sizeof(*mchp_core_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	mchp_core_pwm = to_mchp_core_pwm(chip);
 
 	mchp_core_pwm->base = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
 	if (IS_ERR(mchp_core_pwm->base))
@@ -470,9 +471,7 @@ static int mchp_core_pwm_probe(struct platform_device *pdev)
 
 	mutex_init(&mchp_core_pwm->lock);
 
-	mchp_core_pwm->chip.dev = &pdev->dev;
-	mchp_core_pwm->chip.ops = &mchp_core_pwm_ops;
-	mchp_core_pwm->chip.npwm = 16;
+	chip->ops = &mchp_core_pwm_ops;
 
 	mchp_core_pwm->channel_enabled = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(0));
 	mchp_core_pwm->channel_enabled |=
@@ -485,7 +484,7 @@ static int mchp_core_pwm_probe(struct platform_device *pdev)
 	writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
 	mchp_core_pwm->update_timestamp = ktime_get();
 
-	ret = devm_pwmchip_add(&pdev->dev, &mchp_core_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to add pwmchip\n");
 
-- 
2.42.0


