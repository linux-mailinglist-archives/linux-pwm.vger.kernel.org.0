Return-Path: <linux-pwm+bounces-71-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E027F2F96
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C081F240AF
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89EF53807;
	Tue, 21 Nov 2023 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F63BD72
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAX-0005yZ-2W; Tue, 21 Nov 2023 14:52:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAU-00Ab0Z-TE; Tue, 21 Nov 2023 14:51:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAU-004xfP-JO; Tue, 21 Nov 2023 14:51:58 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 068/108] pwm: mediatek: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:10 +0100
Message-ID: <20231121134901.208535-69-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2926; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=NvNSjL4xJ1Ai1FiR6lC3rZ+UFrgPRfr2vb9OTrIV/7A=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSYrdOD3v95z3ll09H/H2vlIvjanNbMU3NP+5lpuuWuU 5RrL39tJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATqTvP/leC5/dHFZn1uyMv KuXuzBabmJYl5JXWoFbwWDPZ/LnKumJJ5nkzDB30HWLK7/m63JAqmnRd/fkOg181biJs+14Wntw oW8ZdyveJ8dz+2urDsc9t216uvx5z3JO147jlkq7irJ3HTVYc0GHu98g//n9vx+ZjwYqJEW1vWQ 4yi6g2Tr7Z9jrf272mebF2pGV7lI30JJnn56L2eFw8+kTD9qCFWGTKjm2Cho0zBX9IR7Wu8N+Yc NlB48CyiVOmfe1WZXe+N1t8h3ruzhr2A7eOVRl/WMpxTvevCv/e97IirGeV2mVOtx5dtK1LNuRA eahFEXNoMY+OxpSOhw2lJ85NkYzyk9j5rKtgjqpX8zlxAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-mediatek driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mediatek.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index ba76d9753f1b..bc614618086d 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -51,7 +51,6 @@ struct pwm_mediatek_of_data {
  * @soc: pointer to chip's platform data
  */
 struct pwm_mediatek_chip {
-	struct pwm_chip chip;
 	void __iomem *regs;
 	struct clk *clk_top;
 	struct clk *clk_main;
@@ -70,7 +69,7 @@ static const unsigned int mtk_pwm_reg_offset_v2[] = {
 static inline struct pwm_mediatek_chip *
 to_pwm_mediatek_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pwm_mediatek_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int pwm_mediatek_clk_enable(struct pwm_chip *chip,
@@ -233,21 +232,26 @@ static const struct pwm_ops pwm_mediatek_ops = {
 
 static int pwm_mediatek_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_mediatek_chip *pc;
+	const struct pwm_mediatek_of_data *soc;
 	unsigned int i;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	soc = of_device_get_match_data(&pdev->dev);
 
-	pc->soc = of_device_get_match_data(&pdev->dev);
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_pwms, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_pwm_mediatek_chip(chip);
+
+	pc->soc = soc;
 
 	pc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	pc->clk_pwms = devm_kmalloc_array(&pdev->dev, pc->soc->num_pwms,
+	pc->clk_pwms = devm_kmalloc_array(&pdev->dev, soc->num_pwms,
 				    sizeof(*pc->clk_pwms), GFP_KERNEL);
 	if (!pc->clk_pwms)
 		return -ENOMEM;
@@ -262,7 +266,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_main),
 				     "Failed to get main clock\n");
 
-	for (i = 0; i < pc->soc->num_pwms; i++) {
+	for (i = 0; i < soc->num_pwms; i++) {
 		char name[8];
 
 		snprintf(name, sizeof(name), "pwm%d", i + 1);
@@ -273,11 +277,9 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 					     "Failed to get %s clock\n", name);
 	}
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &pwm_mediatek_ops;
-	pc->chip.npwm = pc->soc->num_pwms;
+	chip->ops = &pwm_mediatek_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 
-- 
2.42.0


