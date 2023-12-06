Return-Path: <linux-pwm+bounces-379-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D53806EB1
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E55B1F2161B
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1824E3455A;
	Wed,  6 Dec 2023 11:48:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A1810D0
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:39 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOJ-00076x-GN; Wed, 06 Dec 2023 12:48:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOH-00Dww8-9N; Wed, 06 Dec 2023 12:48:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOH-00FR1Z-0J; Wed, 06 Dec 2023 12:48:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v4 077/115] pwm: mtk-disp: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:31 +0100
Message-ID:  <e5852ac7208917932f9e6bce96a40ecd1a2b5991.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=3mAoZwowhY5Q8LCYbYjvGDo+okdiQ2FoVEfE9Yl1Q1g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF7xh32gzhap3jjyjBbN3xzzHqKLN2B8d4VSv x40XBxRKimJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBe8QAKCRCPgPtYfRL+ Tn5qB/4jM5NCMPtVpE7/WT8nG1cdwNbVeL5IHXkTjMY3RcH0zqTyQrnkxNcJgk8B1lDuXZ+41oE pNbPJUAsu8g3Z9U+YiQE32GukVNXxUttZxMVm4fKsIiCRboZD9TrPURE13Lq5xCkjW+5JusZLAc njClh0Mg+XDBZ51RwUO9D74m54USiy+8bTyUD+4jZ0ig7t8+h9eYDImSP3YBpa8HVKzVFmgYAcr Mf2resUYHXr4FgFDvnbdJxzfPtUImqMsJAgiqBVQqP80GndKWQsuIpOzFu5DhO0voSwk9fwI1bq 1gOpCfYzKCoftO5sk6ganeKLuRraJZilfrxaXZ9rHWD6TbNf
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-mtk-disp driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mtk-disp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 186aa5c04435..bafd6b6195f6 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -42,7 +42,6 @@ struct mtk_pwm_data {
 };
 
 struct mtk_disp_pwm {
-	struct pwm_chip chip;
 	const struct mtk_pwm_data *data;
 	struct clk *clk_main;
 	struct clk *clk_mm;
@@ -52,7 +51,7 @@ struct mtk_disp_pwm {
 
 static inline struct mtk_disp_pwm *to_mtk_disp_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct mtk_disp_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void mtk_disp_pwm_update_bits(struct mtk_disp_pwm *mdp, u32 offset,
@@ -231,12 +230,14 @@ static const struct pwm_ops mtk_disp_pwm_ops = {
 
 static int mtk_disp_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct mtk_disp_pwm *mdp;
 	int ret;
 
-	mdp = devm_kzalloc(&pdev->dev, sizeof(*mdp), GFP_KERNEL);
-	if (!mdp)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*mdp));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	mdp = to_mtk_disp_pwm(chip);
 
 	mdp->data = of_device_get_match_data(&pdev->dev);
 
@@ -254,11 +255,9 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(mdp->clk_mm),
 				     "Failed to get mm clock\n");
 
-	mdp->chip.dev = &pdev->dev;
-	mdp->chip.ops = &mtk_disp_pwm_ops;
-	mdp->chip.npwm = 1;
+	chip->ops = &mtk_disp_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &mdp->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 
-- 
2.42.0


