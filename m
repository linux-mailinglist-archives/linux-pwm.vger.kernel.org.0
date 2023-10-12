Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0507C72F5
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379625AbjJLQbn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379644AbjJLQbQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E100DC
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyab-0005iY-Qg; Thu, 12 Oct 2023 18:31:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaZ-001CAG-Fk; Thu, 12 Oct 2023 18:31:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaZ-00F5RV-6g; Thu, 12 Oct 2023 18:31:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 080/109] pwm: renesas-tpu: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:48 +0200
Message-ID: <20231012162827.1002444-191-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=c956yE3LyGOGjGJg4kFVt2dBy1BRj/4S0vxTYlanGQE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8KiVsVsdu95M/0OiG9eTRjHoUaejjln2ScI AF74J5J9MOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfCgAKCRCPgPtYfRL+ Tp63CACQ7umlj5Em00/37P4pp9704sx8QiTYw/R4JNeK3dBnLtjz1Jxw2U7G60FqTC+HcLYsSE8 24Zg5yhaAFG746MUWkq5jB2KJZK1ZvX828C4/WgysDNlQT+7/2Tg5voMsjPPJ8k+I+LzSFawzXS snXYld5qCjscJzF9LLSdJe67bVv2OZpaQuoxjgL2LTGQW/1hwPk+VF4CCOmtFE+IZ5/cL2IfGHz Gq2Ma12dK5ANvFwQx7u4lhyC3D2GOhRme5Lmr+N0+UZUdNj6Np3Pob9WV3epwXx8ECdbQX4sw/i qndXSCKdxzhhe79Guk+pukwlLSKMCK1ZQ0Zu3Qib+X/cujSP
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

This prepares the pwm-renesas-tpu driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 4239f2c3e8b2..2f6b2351619b 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -80,7 +80,6 @@ struct tpu_pwm_device {
 
 struct tpu_device {
 	struct platform_device *pdev;
-	struct pwm_chip chip;
 	spinlock_t lock;
 
 	void __iomem *base;
@@ -88,7 +87,10 @@ struct tpu_device {
 	struct tpu_pwm_device tpd[TPU_CHANNEL_MAX];
 };
 
-#define to_tpu_device(c)	container_of(c, struct tpu_device, chip)
+static inline struct tpu_device *to_tpu_device(struct pwm_chip *chip)
+{
+	return pwmchip_priv(chip);
+}
 
 static void tpu_pwm_write(struct tpu_pwm_device *tpd, int reg_nr, u16 value)
 {
@@ -439,12 +441,14 @@ static const struct pwm_ops tpu_pwm_ops = {
 
 static int tpu_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct tpu_device *tpu;
 	int ret;
 
-	tpu = devm_kzalloc(&pdev->dev, sizeof(*tpu), GFP_KERNEL);
-	if (tpu == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, TPU_CHANNEL_MAX, sizeof(*tpu));
+	if (chip == NULL)
 		return -ENOMEM;
+	tpu = to_tpu_device(chip);
 
 	spin_lock_init(&tpu->lock);
 	tpu->pdev = pdev;
@@ -461,15 +465,13 @@ static int tpu_probe(struct platform_device *pdev)
 	/* Initialize and register the device. */
 	platform_set_drvdata(pdev, tpu);
 
-	tpu->chip.dev = &pdev->dev;
-	tpu->chip.ops = &tpu_pwm_ops;
-	tpu->chip.npwm = TPU_CHANNEL_MAX;
+	chip->ops = &tpu_pwm_ops;
 
 	ret = devm_pm_runtime_enable(&pdev->dev);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to enable runtime PM\n");
 
-	ret = devm_pwmchip_add(&pdev->dev, &tpu->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register PWM chip\n");
 
-- 
2.42.0

