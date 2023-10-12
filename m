Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259997C72AF
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379497AbjJLQbE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379574AbjJLQa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D51BE1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaM-0004oJ-LI; Thu, 12 Oct 2023 18:30:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaL-001C6F-UM; Thu, 12 Oct 2023 18:30:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaL-00F5N7-LG; Thu, 12 Oct 2023 18:30:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 016/109] pwm: lpc18xx-sct: Make use of parent device pointer in driver data
Date:   Thu, 12 Oct 2023 18:28:44 +0200
Message-ID: <20231012162827.1002444-127-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=21O5uADd6r1enmfcbkwiYrTC5RgwuoEbmplC6sEKY0w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB6+7KLBWB0uZyFVXrt+fXepmS0t9OEQZ8A+p AUJMp/m+BKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgevgAKCRCPgPtYfRL+ TuurB/93S5PscwXNdBGGgJGIixS+P6TGqrQ9FoFY7uucVuFGsZPAgltVo0H8SeB1iKmh4LKWX1G 2oCY5htpxKw4zbs+6Z0bG1364WRzifNGp3LhabFZtNbV8O8fUNgfTYQZhynGdJTDAyjkpM5k1O2 uRkB0o5NIFtfxq8JBAU6K3kQgdupySxRQn+AX6KAroAwoy6FRcGp9DCQPfkR7pEwZ+yoBgPVSEE 1D3Eh3I0d6zmPDyTZI5TSRQiNU2cv0vvkiVrgNzmuhO5QSZEqHnf5Qg0JCxSB8pTnu7ql07Rcnr 7ttUJfmwXtkZjQ53Uk4P8/vA42EG0GDOSjuW20nJdLB9J5Ad
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

