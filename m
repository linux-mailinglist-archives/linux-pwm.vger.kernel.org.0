Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608A16B50C3
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Mar 2023 20:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCJTOX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Mar 2023 14:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCJTOW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Mar 2023 14:14:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4DD12A168
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 11:14:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1paiC0-00039I-AU; Fri, 10 Mar 2023 20:14:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paiBz-003F4t-1o; Fri, 10 Mar 2023 20:14:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paiBy-003s90-C1; Fri, 10 Mar 2023 20:14:14 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Munehisa Kamata <kamatam@amazon.com>, kernel@pengutronix.de
Subject: [PATCH] pwm: meson: Explicitly set .polarity in .get_state()
Date:   Fri, 10 Mar 2023 20:14:05 +0100
Message-Id: <20230310191405.2606296-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2146; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=AkvlThN+cI4a7dkV/VVfPk4VyPpzaAaoFocdrcBpL8w=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkC4F69olWoJ7Ed8sEbDh/GIath8w3HSWFxFiab mqyHO9+FZqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAuBegAKCRDB/BR4rcrs Cd1cCACRuq4c1vOJc5h+ju5vADCJKzKpVpiaqj7YLKTdWqMgE2/XsTqcRN7wE1LuoYXAj/cD/kI JEhpkS/9pfiN6KggwQnUPcv6eqw2hHGodfX6WMxbTAN/1iOI2fPWWTs8jK8XrQFZJJsLaa/DEav bPbvFVeAfaHXy/Qb7HM6J6grZZB1HA0IuLz8uW/jAi6hvMiAtCNrdSLXKTw+BxhF3RSd2aHD9DU LDlFiybwK6hYAIknDz6VkMG2GAduKOc8Ky8XcQWZXZ8LHggcDCNJL1Jg6uVlHv0c6ljmGCPfn/i JsNZZvcnjzmHzgNcjakO23YJoNWJ51LwDaMvKmhWHdDp72tz
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The driver only supports normal polarity. Complete the implementation of
.get_state() by setting .polarity accordingly.

This fixes a regression that was possible since commit c73a3107624d
("pwm: Handle .get_state() failures") which stopped to zero-initialize
the state passed to the .get_state() callback. This was reported at
https://forum.odroid.com/viewtopic.php?f=177&t=46360 . While this was an
unintended side effect, the real issue is the driver's callback not
setting the polarity.

There is a complicating fact, that the .apply() callback fakes support
for inversed polarity. This is not (and cannot) be matched by
.get_state(). As fixing this isn't easy, only point it out in a comment
to prevent authors of other drivers from copying that approach.

Fixes: c375bcbaabdb ("pwm: meson: Read the full hardware state in meson_pwm_get_state()")
Reported-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

similar to the patches for four other drivers[1], I think we should
apply this patch as a fix.

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/20230228135508.1798428-1-u.kleine-koenig@pengutronix.de

 drivers/pwm/pwm-meson.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 16d79ca5d8f5..5cd7b90872c6 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -162,6 +162,12 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	duty = state->duty_cycle;
 	period = state->period;
 
+	/*
+	 * Note this is wrong. The result is an output wave that isn't really
+	 * inverted and so is wrongly identified by .get_state as normal.
+	 * Fixing this needs some care however as some machines might rely on
+	 * this.
+	 */
 	if (state->polarity == PWM_POLARITY_INVERSED)
 		duty = period - duty;
 
@@ -358,6 +364,8 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		state->duty_cycle = 0;
 	}
 
+	state->polarity = PWM_POLARITY_NORMAL;
+
 	return 0;
 }
 
-- 
2.39.1

