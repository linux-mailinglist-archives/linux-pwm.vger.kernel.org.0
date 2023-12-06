Return-Path: <linux-pwm+bounces-318-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410F806E5D
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9594B1C20A3B
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CED347D3;
	Wed,  6 Dec 2023 11:48:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7C9D4E
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO8-0006CX-IO; Wed, 06 Dec 2023 12:48:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00Dwsb-VM; Wed, 06 Dec 2023 12:48:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00FQxj-MV; Wed, 06 Dec 2023 12:48:23 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Vladimir Zapolskiy <vz@mleia.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 020/115] pwm: lpc18xx-sct: Make use of parent device pointer in driver data
Date: Wed,  6 Dec 2023 12:43:34 +0100
Message-ID:  <107f776436bda40947b00096e966c527dfac98f6.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=vj8QyJeA9eKoJvqOdGoWuM21W7y2YtnS9+qtnroYO8E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF5uI8eFIS56J27w6AyN0yue56wCsQ3LDPn0N N0JJjvRKTOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBebgAKCRCPgPtYfRL+ TlW2B/0UMPGlebzbnnYrARmxUnlS+FjqBjVx26CeJ42TbdCWZGYq8CNKzvvhbCGOgna4qYMcuUB 3iTdNXfzUffcbxd48z2PdrjVOAfJqxiXpsaY9UI5Knz9w2SPrBX+RO1CL1/A/wfZ9zcglyMzVl5 aj7URMaqwAlceT4854zG8/yQcDPZPXs4H7fbSC5rmGZ2LT0COS01pZ+xeSgdwkSzA/ihuRJGT63 zJJwFuGSrFDNdYhfuqqV0uoUxahEHW2GSDu6eW9wgyPQqlWMa5ViHOkglnEzhfNgKp9gs7GM4fn fK43uGHQ1Za4Yh0P2JOFuGc7beeEVCapLgq1XFn+aj5IqQ0x
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
index b3d4a955aa31..9e1db43a5171 100644
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


