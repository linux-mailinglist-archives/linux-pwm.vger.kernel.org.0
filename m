Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E11663D931
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Nov 2022 16:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiK3PWE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Nov 2022 10:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3PWC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 10:22:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAA17CA90
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 07:22:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuM-0000AO-OS; Wed, 30 Nov 2022 16:21:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuL-001Ldr-Ap; Wed, 30 Nov 2022 16:21:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuK-001Vqo-OZ; Wed, 30 Nov 2022 16:21:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2 05/11] pwm: crc: Propagate errors in .get_state() to the caller
Date:   Wed, 30 Nov 2022 16:21:42 +0100
Message-Id: <20221130152148.2769768-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GTdLWiZ/fF1hKV8lF9r5ohxHkx5KHNMuzBCLUYB/wRI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjh3TwVQ+pD5diF4LmShD6mTaQEYq8a5wAnp9Q7Yao hulCYK6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY4d08AAKCRDB/BR4rcrsCROoCA CRe+m8IpTav8H13p1h6tzrJvHCy4ANtvuvRJWY9d2kW75TUFDmGKJM4avi2aFcAjqotirBO3oQ/9+q eTazkoTwK3eoyjOpXckE26q3K6a4HTgGsvY+yibos7la+YV46XH/E+njF582C887kM2SawLXrMa8Ww XTV/VNckLieElkJuihVYqd8TzEmL9A+Wzu2JGuUZZtr3HGY3Fx4Hp1xioJZNU7lzAJc3Z0INZ4hNvH EZ917enhdBKWi9P1Q88IvoycqCNV+VoC91KKEQWxFDqQbo+NGIFvTxHnRKfTuP2srZEs7PgXZ4RCuc ppXbJzuFnm36k5hGTWbyONg+A5zVj/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

.get_state() can return an error indication. Make use of it to propagate
failing hardware accesses.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-crc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 4099850117ba..4703b4a0b6e4 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -132,13 +132,13 @@ static int crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	error = regmap_read(crc_pwm->regmap, PWM0_CLK_DIV, &clk_div_reg);
 	if (error) {
 		dev_err(dev, "Error reading PWM0_CLK_DIV %d\n", error);
-		return 0;
+		return error;
 	}
 
 	error = regmap_read(crc_pwm->regmap, PWM0_DUTY_CYCLE, &duty_cycle_reg);
 	if (error) {
 		dev_err(dev, "Error reading PWM0_DUTY_CYCLE %d\n", error);
-		return 0;
+		return error;
 	}
 
 	clk_div = (clk_div_reg & ~PWM_OUTPUT_ENABLE) + 1;
-- 
2.38.1

