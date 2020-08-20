Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB9A24C813
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Aug 2020 00:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgHTW4C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Aug 2020 18:56:02 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:50013 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbgHTW4B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Aug 2020 18:56:01 -0400
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 74499100005;
        Thu, 20 Aug 2020 22:55:58 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/4] pwm: atmel-tcb: add sama5d2 support
Date:   Fri, 21 Aug 2020 00:55:45 +0200
Message-Id: <20200820225546.2246517-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820225546.2246517-1-alexandre.belloni@bootlin.com>
References: <20200820225546.2246517-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add sama5d2 support. The sama5d2 has a new clock input, its gclk. Index 0
of the clock selector is the gclk instead of the peripheral clock divided
by 2.

For now, the gclk is not used because the peripheral clock divided by 8
already gives a 9.6ns resolution which is enough for most use cases.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/pwm/pwm-atmel-tcb.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 82edb44fbbd8..5ccc3e7420e9 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -55,6 +55,7 @@ struct atmel_tcb_pwm_chip {
 	u8 width;
 	struct regmap *regmap;
 	struct clk *clk;
+	struct clk *gclk;
 	struct clk *slow_clk;
 	struct atmel_tcb_pwm_device *pwms[NPWM];
 	struct atmel_tcb_channel bkup;
@@ -292,7 +293,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
 	struct atmel_tcb_pwm_device *atcbpwm = NULL;
-	int i;
+	int i = 0;
 	int slowclk = 0;
 	unsigned period;
 	unsigned duty;
@@ -303,8 +304,11 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/*
 	 * Find best clk divisor:
 	 * the smallest divisor which can fulfill the period_ns requirements.
+	 * If there is a gclk, the first divisor is actuallly the gclk selector
 	 */
-	for (i = 0; i < ARRAY_SIZE(atmel_tcb_divisors); ++i) {
+	if (tcbpwmc->gclk)
+		i = 1;
+	for (; i < ARRAY_SIZE(atmel_tcb_divisors); ++i) {
 		if (atmel_tcb_divisors[i] == 0) {
 			slowclk = i;
 			continue;
@@ -383,9 +387,15 @@ static struct atmel_tcb_config tcb_sam9x5_config = {
 	.counter_width = 32,
 };
 
+static struct atmel_tcb_config tcb_sama5d2_config = {
+	.counter_width = 32,
+	.has_gclk = 1,
+};
+
 static const struct of_device_id atmel_tcb_of_match[] = {
 	{ .compatible = "atmel,at91rm9200-tcb", .data = &tcb_rm9200_config, },
 	{ .compatible = "atmel,at91sam9x5-tcb", .data = &tcb_sam9x5_config, },
+	{ .compatible = "atmel,sama5d2-tcb", .data = &tcb_sama5d2_config, },
 	{ /* sentinel */ }
 };
 
@@ -396,7 +406,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	const struct atmel_tcb_config *config;
 	struct device_node *np = pdev->dev.of_node;
 	struct regmap *regmap;
-	struct clk *clk;
+	struct clk *clk, *gclk = NULL;
 	struct clk *slow_clk;
 	char clk_name[] = "t0_clk";
 	int err;
@@ -428,6 +438,12 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	match = of_match_node(atmel_tcb_of_match, np->parent);
 	config = match->data;
 
+	if (config->has_gclk) {
+		gclk = of_clk_get_by_name(np->parent, "gclk");
+		if (IS_ERR(gclk))
+			return PTR_ERR(gclk);
+	}
+
 	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
 	if (tcbpwm == NULL) {
 		err = -ENOMEM;
@@ -443,6 +459,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	tcbpwm->channel = channel;
 	tcbpwm->regmap = regmap;
 	tcbpwm->clk = clk;
+	tcbpwm->gclk = gclk;
 	tcbpwm->slow_clk = slow_clk;
 	tcbpwm->width = config->counter_width;
 
-- 
2.26.2

