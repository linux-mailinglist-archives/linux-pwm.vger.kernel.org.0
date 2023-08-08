Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2AB774D51
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 23:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjHHVsV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 17:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjHHVsN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 17:48:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE97175DD3
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-0006nl-3M; Tue, 08 Aug 2023 19:19:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMx-00223C-Ev; Tue, 08 Aug 2023 19:19:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMw-00BTAW-Lc; Tue, 08 Aug 2023 19:19:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 006/101] pwm: atmel-tcb: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:17:56 +0200
Message-Id: <20230808171931.944154-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=784m6nP9BAJYkeY+/kAD9UPRo55q4eNjvEgsB7ZSlSk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0ni2aIXbFtcePnO0sHy0U4DZD4T9jvrNKtF8H VrUz9O75q6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4tgAKCRCPgPtYfRL+ Tib4B/4mOWgipnDAuT8DtK1wQdKbvDgN+ZLzimoLV41jKvjSAYwo/iPI56CX7ONQHQC0u+RkRZ1 el3f6oJWacHT0UgIKjUSRhKY4jXgaROwAHOAH+gqHkkoJoZu3f40Vtj4ijZnR7yOA3YaNXP99T8 svVsp0SYInLGg+XckUKA79Fb/Akd4Y9U32Lp7M6Kj1W8JLvhGfZ4G1TnwsrksCv+LJ55tO3Nvxf WAetRNA5e1kBbygk8sLgiB7UDUz16vllSSlNKuG9JymE/Z1IiT7jSxM77ZS4QfT8trIK+9tuWe7 aehj214gThV2wKMaqyjKdeD4W/dpdt/uVgJ+TxBnAVOiMCLA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 9415d3373e4b..a5dfd244811b 100644
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
@@ -386,6 +385,7 @@ static const struct of_device_id atmel_tcb_of_match[] = {
 static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
+	struct pwm_chip *chip;
 	struct atmel_tcb_pwm_chip *tcbpwm;
 	const struct atmel_tcb_config *config;
 	struct device_node *np = pdev->dev.of_node;
@@ -393,9 +393,10 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
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
@@ -433,9 +434,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
-	tcbpwm->chip.dev = &pdev->dev;
-	tcbpwm->chip.ops = &atmel_tcb_pwm_ops;
-	tcbpwm->chip.npwm = NPWM;
+	chip->ops = &atmel_tcb_pwm_ops;
 	tcbpwm->channel = channel;
 	tcbpwm->width = config->counter_width;
 
@@ -445,11 +444,11 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 
 	spin_lock_init(&tcbpwm->lock);
 
-	err = pwmchip_add(&tcbpwm->chip);
+	err = pwmchip_add(chip);
 	if (err < 0)
 		goto err_disable_clk;
 
-	platform_set_drvdata(pdev, tcbpwm);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 
@@ -470,9 +469,10 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 
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
2.40.1

