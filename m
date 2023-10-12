Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9580A7C72F0
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379604AbjJLQbk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379551AbjJLQbP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:15 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBFBDE
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyac-0005iy-3Y; Thu, 12 Oct 2023 18:31:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaZ-001CAJ-O5; Thu, 12 Oct 2023 18:31:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaZ-00F5RZ-En; Thu, 12 Oct 2023 18:31:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 081/109] pwm: rockchip: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:49 +0200
Message-ID: <20231012162827.1002444-192-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=q8XvQyA1g8mjzzcfShGOUu76JYIKtFksZp2YkC8lMXM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8M6QJGi5hQjtzO9O0eG4R8mxBgzHJiEAEWm YllR9tazOeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfDAAKCRCPgPtYfRL+ TkOyCACTNy26M/Io6XP+j5CEjA4MAzaKv1u+W1bIl+aq2dHNJxTJpvJHJoHVCTXjldCQ/C8ZMRL chmQ+RwcJjXLLOPtKDtfQp+aCN6smRpzwfa/bd6H0H0IFsw6hCqsIs/G97lvuImj5wfNd5byiFF uUV6cZDQX/bx5Xy8ojyfkncC2MMDo8TcmTtY3YHb5YvA1nvVhW2xxIdefN5UuWF+VBBJ8+KT405 KT1JAipVcogDhgupeZO7ln/24vtMHW2UhHLn7ZQZcJEcGFg9Ann9q6MjmlZs0D+/yy5Sa5GWANM oYMpCSj9/cKhRNvfooypX664XfBXOSM5c24Vl3ylbLvdRVu3
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

This prepares the pwm-rockchip driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rockchip.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index cce4381e188a..18fb092f4bec 100644
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
+	return pwmchip_priv(chip);
 }
 
 static int rockchip_pwm_get_state(struct pwm_chip *chip,
@@ -297,6 +296,7 @@ MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
 static int rockchip_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *id;
+	struct pwm_chip *chip;
 	struct rockchip_pwm_chip *pc;
 	u32 enable_conf, ctrl;
 	bool enabled;
@@ -306,9 +306,10 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	if (!id)
 		return -EINVAL;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_rockchip_pwm_chip(chip);
 
 	pc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->base))
@@ -342,18 +343,16 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	platform_set_drvdata(pdev, pc);
+	platform_set_drvdata(pdev, chip);
 
 	pc->data = id->data;
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
@@ -377,9 +376,10 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
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

