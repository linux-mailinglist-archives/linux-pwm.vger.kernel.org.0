Return-Path: <linux-pwm+bounces-22-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA87D7F2F62
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14F12B20BD6
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472953805;
	Tue, 21 Nov 2023 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B913510DB
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAL-00055h-0M; Tue, 21 Nov 2023 14:51:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAJ-00AaxL-S1; Tue, 21 Nov 2023 14:51:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAJ-004xbf-JB; Tue, 21 Nov 2023 14:51:47 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 015/108] pwm: lpc18xx-sct: Make use of parent device pointer in driver data
Date: Tue, 21 Nov 2023 14:49:17 +0100
Message-ID: <20231121134901.208535-16-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=21O5uADd6r1enmfcbkwiYrTC5RgwuoEbmplC6sEKY0w=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSYrbFvFh2MkNVLVwyN211XW75ypq7ul4cC6QfslrByG s1/9kOok9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJmIRxMDTK68Xy+JrvP36m rUhRTOmM80WdQ0tSeTjTvmv9E/KRNuxa69r0I4wlKEqQS0cv70X9lfd872r+PHK8a9h89pG5z3K 5fCf7zbGR1Z85Hjud2JObuk1Hc8JS4dPrqiRfGDJM0mbfZ/j0k7nXcqaLpeYbf6TEbey8I3JAUd X4p/HfhOd/9vefZYz89+W7Ve6TDdbRs8zrzm+acDeu27+A+fyBDA+7Q1qGRziWBy70jr3x4JJFb NvBR6tVJ1t97Os0e7Ci2c3WTVM2ep6c0JrXnzmVL+i9msdwRO1nt+Lr6smu0unSUyfksdsbyDFb OjgVCsg227oxeSz/G8t9R2gH+8zpxU4zEw+1GbNfZtwLAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, make use of the
already existing pointer to the parent device in driver data. However
rename the pointer to "parent" for consistency with other drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index ef7d0da137ed..1fda3f11b3a6 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -92,7 +92,7 @@ struct lpc18xx_pwm_data {
 };
 
 struct lpc18xx_pwm_chip {
-	struct device *dev;
+	struct device *parent;
 	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *pwm_clk;
@@ -198,7 +198,7 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (period_ns < lpc18xx_pwm->min_period_ns ||
 	    period_ns > lpc18xx_pwm->max_period_ns) {
-		dev_err(chip->dev, "period %d not in range\n", period_ns);
+		dev_err(lpc18xx_pwm->parent, "period %d not in range\n", period_ns);
 		return -ERANGE;
 	}
 
@@ -214,7 +214,7 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (requested_events > 2 && lpc18xx_pwm->period_ns != period_ns &&
 	    lpc18xx_pwm->period_ns) {
-		dev_err(chip->dev, "conflicting period requested for PWM %u\n",
+		dev_err(lpc18xx_pwm->parent, "conflicting period requested for PWM %u\n",
 			pwm->hwpwm);
 		mutex_unlock(&lpc18xx_pwm->period_lock);
 		return -EBUSY;
@@ -291,7 +291,7 @@ static int lpc18xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 				    LPC18XX_PWM_EVENT_MAX);
 
 	if (event >= LPC18XX_PWM_EVENT_MAX) {
-		dev_err(lpc18xx_pwm->dev,
+		dev_err(lpc18xx_pwm->parent,
 			"maximum number of simultaneous channels reached\n");
 		return -EBUSY;
 	}
@@ -360,7 +360,7 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	if (!lpc18xx_pwm)
 		return -ENOMEM;
 
-	lpc18xx_pwm->dev = &pdev->dev;
+	lpc18xx_pwm->parent = &pdev->dev;
 
 	lpc18xx_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lpc18xx_pwm->base))
-- 
2.42.0


