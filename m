Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA417C72D5
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379610AbjJLQbZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379597AbjJLQbI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:08 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310BACF
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaV-0005Is-EC; Thu, 12 Oct 2023 18:31:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaT-001C8W-Bu; Thu, 12 Oct 2023 18:31:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaT-00F5Pc-2f; Thu, 12 Oct 2023 18:31:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 052/109] pwm: cros-ec: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:20 +0200
Message-ID: <20231012162827.1002444-163-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3448; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=e8/SuPnxTLgrP5C8bJZ/5xPYolAFPGXd6mgGRsmDOJo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7phVI/vRknNnEUm2tLVwUS04OePsQsmAmxy 5QwFU8EVSqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge6QAKCRCPgPtYfRL+ Tg1+CACkJX92wsZ5/z6N8USFOu1l7ZvLqsaKp+K24CfXLh3vHlGV+0iVV7RNzL5CHeCsXdJ4Icm PrDUQ92DuRxP2Uwa7fo46EJu/N0vacyUXP0PP2Iu5S/ITn8mJ+KiZyOYhzpZphb12SPYCFBMm2l 9RRd7244ACzjFRQ7B3fk9DvXTNH5rYbkVhoeJ18Hu2S3udZT9BJEcq4xaC5CTiIt95T61Ccgr6V WujZIHJXnVvke65Nw2dg2TUQ7vycfm5vWoIJVDNxp//dNesOnH6OwJ6PEyPSdfX6MeKsKYLZGo3 oY6n6RTOIbkXacYORxtb0+JAdnejwKc8j7maRYdmOP3xG6U7
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

This prepares the pwm-cros-ec driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.
The probe function had to be changed a bit because the number of PWMs
must be determined before allocation of the pwm_chip and its private
data now.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-cros-ec.c | 42 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 0ce8220646ea..290b22423804 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -26,7 +26,6 @@
  */
 struct cros_ec_pwm_device {
 	struct cros_ec_device *ec;
-	struct pwm_chip chip;
 	bool use_pwm_type;
 	struct cros_ec_pwm *channel;
 };
@@ -41,7 +40,7 @@ struct cros_ec_pwm {
 
 static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct cros_ec_pwm_device, chip);
+	return pwmchip_priv(chip);
 }
 
 static int cros_ec_dt_type_to_pwm_type(u8 dt_index, u8 *pwm_type)
@@ -226,13 +225,13 @@ static const struct pwm_ops cros_ec_pwm_ops = {
  * of PWMs it supports directly, so we have to read the pwm duty cycle for
  * subsequent channels until we get an error.
  */
-static int cros_ec_num_pwms(struct cros_ec_pwm_device *ec_pwm)
+static int cros_ec_num_pwms(struct cros_ec_device *ec, bool use_pwm_type)
 {
 	int i, ret;
 
 	/* The index field is only 8 bits */
 	for (i = 0; i <= U8_MAX; i++) {
-		ret = cros_ec_pwm_get_duty(ec_pwm->ec, ec_pwm->use_pwm_type, i);
+		ret = cros_ec_pwm_get_duty(ec, use_pwm_type, i);
 		/*
 		 * We look for SUCCESS, INVALID_COMMAND, or INVALID_PARAM
 		 * responses; everything else is treated as an error.
@@ -261,35 +260,36 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct cros_ec_pwm_device *ec_pwm;
 	struct pwm_chip *chip;
+	bool use_pwm_type = false;
+	unsigned npwm;
 	int ret;
 
 	if (!ec)
 		return dev_err_probe(dev, -EINVAL, "no parent EC device\n");
 
-	ec_pwm = devm_kzalloc(dev, sizeof(*ec_pwm), GFP_KERNEL);
-	if (!ec_pwm)
-		return -ENOMEM;
-	chip = &ec_pwm->chip;
+	if (of_device_is_compatible(np, "google,cros-ec-pwm-type")) {
+		use_pwm_type = true;
+		npwm = CROS_EC_PWM_DT_COUNT;
+	} else {
+		ret = cros_ec_num_pwms(ec, use_pwm_type);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Couldn't find PWMs\n");
+		npwm = ret;
+	}
+
+	chip = devm_pwmchip_alloc(dev, npwm, sizeof(*ec_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	ec_pwm = pwm_to_cros_ec_pwm(chip);
+	ec_pwm->use_pwm_type = use_pwm_type;
 	ec_pwm->ec = ec;
 
-	if (of_device_is_compatible(np, "google,cros-ec-pwm-type"))
-		ec_pwm->use_pwm_type = true;
-
 	/* PWM chip */
-	chip->dev = dev;
 	chip->ops = &cros_ec_pwm_ops;
 	chip->of_xlate = cros_ec_pwm_xlate;
 	chip->of_pwm_n_cells = 1;
 
-	if (ec_pwm->use_pwm_type) {
-		chip->npwm = CROS_EC_PWM_DT_COUNT;
-	} else {
-		ret = cros_ec_num_pwms(ec_pwm);
-		if (ret < 0)
-			return dev_err_probe(dev, ret, "Couldn't find PWMs\n");
-		chip->npwm = ret;
-	}
-
 	ec_pwm->channel = devm_kcalloc(dev, chip->npwm, sizeof(*ec_pwm->channel),
 					GFP_KERNEL);
 	if (!ec_pwm->channel)
-- 
2.42.0

