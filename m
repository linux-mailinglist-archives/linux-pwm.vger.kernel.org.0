Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678117C72CC
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378739AbjJLQbW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379574AbjJLQbF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:05 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734BECC
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaS-00057l-QI; Thu, 12 Oct 2023 18:31:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaR-001C80-EM; Thu, 12 Oct 2023 18:30:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaR-00F5Ox-5O; Thu, 12 Oct 2023 18:30:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 043/109] pwm: atmel-tcb: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:11 +0200
Message-ID: <20231012162827.1002444-154-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6fUgRCZtq6T6w9tuehzp9v4WMoKTB3KKl2kI80F5gDE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7eBtlbWkH4iuemAf7Ug70zKEqVU3L9mTZs3 0L4KyKfOZ6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge3gAKCRCPgPtYfRL+ TvGhB/9VcnM6sVt2Gz8f/+ol7dT2CxEb4nh/H+1wZD/xFdwEW4g4l/x+nWHdRrLsdZ/kgcnFjyr YBI+8ETwAnCW5omPoHH4DcrTGZYS4ZkaCvLiaA+JyiiSSM8JCDZ9HGvI/Ekr9Iv2byFWZxDJ0Sd Rfh6z7XpEFUH2f6//inMYxKeejsYfXTPLb42KvY8jKMYFd7eyjF9qwx4VTOOsjINEjGCm+SAT6O LOWVtpxlPasLTdlbCD4FvblMK1s0YtZOTeD83X2kjyI61QQLfNbyj80SZId34SZprhYILhzU11P Q+NbR0RWUjrqOhOtIQAqm5piwBJtQ6kxTiChIZGTc4rrEYHU
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

This prepares the pwm-atmel-tcb driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 9d335773c2fc..35d4c4987edb 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -47,7 +47,6 @@ struct atmel_tcb_channel {
 };
 
 struct atmel_tcb_pwm_chip {
-	struct pwm_chip chip;
 	spinlock_t lock;
 	u8 channel;
 	u8 width;
@@ -63,7 +62,7 @@ static const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128, 0, };
 
 static inline struct atmel_tcb_pwm_chip *to_tcb_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct atmel_tcb_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int atmel_tcb_pwm_request(struct pwm_chip *chip,
@@ -389,6 +388,7 @@ static const struct of_device_id atmel_tcb_of_match[] = {
 static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
+	struct pwm_chip *chip;
 	struct atmel_tcb_pwm_chip *tcbpwm;
 	const struct atmel_tcb_config *config;
 	struct device_node *np = pdev->dev.of_node;
@@ -396,9 +396,10 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	int err;
 	int channel;
 
-	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
-	if (tcbpwm == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, NPWM, sizeof(*tcbpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	tcbpwm = to_tcb_chip(chip);
 
 	err = of_property_read_u32(np, "reg", &channel);
 	if (err < 0) {
@@ -436,9 +437,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
-	tcbpwm->chip.dev = &pdev->dev;
-	tcbpwm->chip.ops = &atmel_tcb_pwm_ops;
-	tcbpwm->chip.npwm = NPWM;
+	chip->ops = &atmel_tcb_pwm_ops;
 	tcbpwm->channel = channel;
 	tcbpwm->width = config->counter_width;
 
@@ -448,11 +447,11 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 
 	spin_lock_init(&tcbpwm->lock);
 
-	err = pwmchip_add(&tcbpwm->chip);
+	err = pwmchip_add(chip);
 	if (err < 0)
 		goto err_disable_clk;
 
-	platform_set_drvdata(pdev, tcbpwm);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 
@@ -473,9 +472,10 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 
 static void atmel_tcb_pwm_remove(struct platform_device *pdev)
 {
-	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct atmel_tcb_pwm_chip *tcbpwm = to_tcb_chip(chip);
 
-	pwmchip_remove(&tcbpwm->chip);
+	pwmchip_remove(chip);
 
 	clk_disable_unprepare(tcbpwm->slow_clk);
 	clk_put(tcbpwm->gclk);
-- 
2.42.0

