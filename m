Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E963D93B
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Nov 2022 16:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiK3PWP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Nov 2022 10:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiK3PWO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 10:22:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846F27CA8E
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 07:22:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuN-00009x-8E; Wed, 30 Nov 2022 16:21:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuK-001Ldc-Dn; Wed, 30 Nov 2022 16:21:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuK-001Vql-Hb; Wed, 30 Nov 2022 16:21:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 04/11] leds: qcom-lpg: Propagate errors in .get_state() to the caller
Date:   Wed, 30 Nov 2022 16:21:41 +0100
Message-Id: <20221130152148.2769768-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=rTgdm7QcRlAMP1sQaYC5ejnejFtK5h3Bb5Wbh9vWlBY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjh3TsyoxxNhNODW0uhVVOPMVUxb7Ug9yLEluTeZZZ taGw4tyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY4d07AAKCRDB/BR4rcrsCYrRB/ 98SOdKJxqHQqepn7vCvWI5RREAncDY4tG2CtWL68mXstJCkkBz377zQSvR6KSUlf7nCOnGN1W1qcPu Zrkr+U1+h0RFnnRIbJAl29PjaOPvANnFdKCkSIc08ZNuCQMCk+W3nJOsvSvBmMefUTs2B1Nr7TR73r TMbQCysmrf9tajNzNmHy8PJLbtw78zV4Jf90cZr/bQelQLcC++Mhz4ODltKSdW+50REPOKlwr+Ebez FhjgfZchCl2pBFG1gpW8vptAF9yl6vqnY94Wc+hN8ksj1nJlNNkzsuTXXea4taZHYipN0cyr2w4t8S cKT5SUD/YP5nGMv1+eJSXDH+IJx5vq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

.get_state() can return an error indication. Make use of it to propagate
failing hardware accesses.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 741cc2fd817d..0dcc046a9a19 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -982,20 +982,20 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = regmap_read(lpg->map, chan->base + LPG_SIZE_CLK_REG, &val);
 	if (ret)
-		return 0;
+		return ret;
 
 	refclk = lpg_clk_rates[val & PWM_CLK_SELECT_MASK];
 	if (refclk) {
 		ret = regmap_read(lpg->map, chan->base + LPG_PREDIV_CLK_REG, &val);
 		if (ret)
-			return 0;
+			return ret;
 
 		pre_div = lpg_pre_divs[FIELD_GET(PWM_FREQ_PRE_DIV_MASK, val)];
 		m = FIELD_GET(PWM_FREQ_EXP_MASK, val);
 
 		ret = regmap_bulk_read(lpg->map, chan->base + PWM_VALUE_REG, &pwm_value, sizeof(pwm_value));
 		if (ret)
-			return 0;
+			return ret;
 
 		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * LPG_RESOLUTION * pre_div * (1 << m), refclk);
 		state->duty_cycle = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * pwm_value * pre_div * (1 << m), refclk);
@@ -1006,7 +1006,7 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = regmap_read(lpg->map, chan->base + PWM_ENABLE_CONTROL_REG, &val);
 	if (ret)
-		return 0;
+		return ret;
 
 	state->enabled = FIELD_GET(LPG_ENABLE_CONTROL_OUTPUT, val);
 	state->polarity = PWM_POLARITY_NORMAL;
-- 
2.38.1

