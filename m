Return-Path: <linux-pwm+bounces-67-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47AD7F2F8E
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A1D1C2165E
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB98537F6;
	Tue, 21 Nov 2023 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD8110CE
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAP-0005RD-Ku; Tue, 21 Nov 2023 14:51:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAP-00Aaz4-7b; Tue, 21 Nov 2023 14:51:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAO-004xdZ-UZ; Tue, 21 Nov 2023 14:51:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 042/108] pwm: atmel-tcb: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:44 +0100
Message-ID: <20231121134901.208535-43-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=L6bY1P95YdygQ4i+oOpurr4QcCnsVr3WMtE6/wYkUOQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLV7wEISurhP2i6nnsdgJu7lLVDad707aqF2+ clVtvS8LbuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1ewAKCRCPgPtYfRL+ TjtsB/9TrztZ423jc0Qtre3gUphyKUbXTgqmnoZWcWRM4HHGoIiK8A1ZMYgYJFDF0AYKyzLYuft 8Ngy8k1C5kh88ICv+25zapx6q0uqjzubaNFFqlPBxkZahsu1Vat20BwJdC3qrjxZY0uInu7SzWU Mte7VE2kMU+2rIbLrtXQ1Dt3hx6Sl13hO6/lB14scTVN2JtAaFwD5BH0AfKbBod2ctsapWQ0EAE knmegWk0FqtnvhW6YtmhQaCBKGmvUZLu8NOHIpxZWLrUHuhGk/385T0QA+k1jmvgiQFr0OC7dUM IbCHvCZ3wcMqvwL7fL/v5pynVls8i8O105FHwRbm2g1x+PRS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-atmel-tcb driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 80121ab81a01..9c66d1e00384 100644
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


