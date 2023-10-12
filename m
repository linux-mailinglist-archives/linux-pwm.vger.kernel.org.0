Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55E37C72FB
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379641AbjJLQbt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379512AbjJLQbS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08C9D7
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyae-0005q8-9O; Thu, 12 Oct 2023 18:31:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyac-001CBA-Eh; Thu, 12 Oct 2023 18:31:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyac-00F5SU-5c; Thu, 12 Oct 2023 18:31:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 094/109] pwm: tegra: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:30:02 +0200
Message-ID: <20231012162827.1002444-205-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2569; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IVxivwViCvf6mlnIWgQw+fkT5k+uuDSJeGaKYqBS8jo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8bUgTphMFCYobi8vF1ciSiVFmO8tJU/D+TO AHKpJGySzuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfGwAKCRCPgPtYfRL+ TrjGB/4r3zR67vlLd8xP+PQ5LvaJm+5h/2NBocm8CeLUVvWS2h09W54Bm1A1WywuRBoU1DUmTIp 9vE9KcNBI85WeR3W45rWKg3qhGxoXhNSR0uKWMoxBcLkRjbJvF47KPXwcg8gsrrJts551d83XAu hliY/z6G3ShocXTHy1HYhoQub8EsZNWBWy4d9nzTFKxkwUWp2ux3Pqk6Sis6BZ/dlvaJFbKV5yt W10ilb4T+8C13vepKy1UHidVP6kjDc/bIqePlauCc60vIsy3WkYd+Yc4nV5vgkamkQxS/JpbnEh azwTHGLwOjq5e7LxpixMsEwE+m43YO5Zr2rGn2UQ4HlcI1lI
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-tegra driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tegra.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 39ea51e08c94..f41791d7630d 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -65,7 +65,6 @@ struct tegra_pwm_soc {
 };
 
 struct tegra_pwm_chip {
-	struct pwm_chip chip;
 	struct device *dev;
 
 	struct clk *clk;
@@ -81,7 +80,7 @@ struct tegra_pwm_chip {
 
 static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct tegra_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline u32 pwm_readl(struct tegra_pwm_chip *pc, unsigned int offset)
@@ -272,14 +271,19 @@ static const struct pwm_ops tegra_pwm_ops = {
 
 static int tegra_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct tegra_pwm_chip *pc;
+	const struct tegra_pwm_soc *soc;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	soc = of_device_get_match_data(&pdev->dev);
 
-	pc->soc = of_device_get_match_data(&pdev->dev);
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_channels, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_tegra_pwm_chip(chip);
+
+	pc->soc = soc;
 	pc->dev = &pdev->dev;
 
 	pc->regs = devm_platform_ioremap_resource(pdev, 0);
@@ -328,11 +332,9 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	reset_control_deassert(pc->rst);
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &tegra_pwm_ops;
-	pc->chip.npwm = pc->soc->num_channels;
+	chip->ops = &tegra_pwm_ops;
 
-	ret = pwmchip_add(&pc->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		reset_control_assert(pc->rst);
@@ -350,9 +352,10 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 static void tegra_pwm_remove(struct platform_device *pdev)
 {
-	struct tegra_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 
-	pwmchip_remove(&pc->chip);
+	pwmchip_remove(chip);
 
 	reset_control_assert(pc->rst);
 
-- 
2.42.0

