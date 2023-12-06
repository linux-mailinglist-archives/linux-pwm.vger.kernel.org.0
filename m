Return-Path: <linux-pwm+bounces-356-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B10C806E97
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4E81C20A11
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB2F3588D;
	Wed,  6 Dec 2023 11:48:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C99F10C0
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOI-0006tK-K4; Wed, 06 Dec 2023 12:48:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOF-00DwvT-GK; Wed, 06 Dec 2023 12:48:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOF-00FR0r-7c; Wed, 06 Dec 2023 12:48:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 066/115] pwm: intel-lgm: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:20 +0100
Message-ID:  <1200602ce4d257050f0fded7022811467b0553c9.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=vcFdgymCfrNEjlNqyUYIy1MeiwEkQEyE4acXhnncSAM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF7VrxxzY88Pwe+Ind0e9poiNhcPS7W7uOpMj 9izhB4jY76JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBe1QAKCRCPgPtYfRL+ TvkzB/0R4gpFmHmNpojz+Z/3c3RUtB2203OZB8J9oGdQk5M9caRAj0yJBqajn/pdFDBvX2VFIMb UrdHAgYGrCM0LVxCK+5tkYmGJcd7m3eZTupBZIsqA1iw29tEAXlgixJCcHIOGD+a1K1IQkBiPwK BicZrXuzjHxrubx29pCD3GfT777rWSKTGfI0VNmIFdmgxqvtHtmMvPE1DwWbdJaB6+Y9s1RRgUW ap/1wp9zB5rlugdynjDJK9YVNtG7HkjaWVQX7XlRrwQr9WUckUqV/rK64YyClVuLKiHhEebbRX7 wBoyJT4OtztzdSoYmUknIlItbYONDhmTA7pT1SM7mXXDgRtR
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-intel-lgm driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-intel-lgm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
index 54ecae7f937e..f9cc7c17c8f0 100644
--- a/drivers/pwm/pwm-intel-lgm.c
+++ b/drivers/pwm/pwm-intel-lgm.c
@@ -42,14 +42,13 @@
 #define LGM_PWM_PERIOD_2WIRE_NS		(40 * NSEC_PER_MSEC)
 
 struct lgm_pwm_chip {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 	u32 period;
 };
 
 static inline struct lgm_pwm_chip *to_lgm_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lgm_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int lgm_pwm_enable(struct pwm_chip *chip, bool enable)
@@ -168,14 +167,16 @@ static int lgm_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct reset_control *rst;
+	struct pwm_chip *chip;
 	struct lgm_pwm_chip *pc;
 	void __iomem *io_base;
 	struct clk *clk;
 	int ret;
 
-	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_lgm_pwm_chip(chip);
 
 	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
@@ -203,13 +204,11 @@ static int lgm_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
 
-	pc->chip.dev = dev;
-	pc->chip.ops = &lgm_pwm_ops;
-	pc->chip.npwm = 1;
+	chip->ops = &lgm_pwm_ops;
 
 	lgm_pwm_init(pc);
 
-	ret = devm_pwmchip_add(dev, &pc->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
 
-- 
2.42.0


