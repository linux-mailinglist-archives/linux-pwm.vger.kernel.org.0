Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDA651DDD5
	for <lists+linux-pwm@lfdr.de>; Fri,  6 May 2022 18:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443890AbiEFQwF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 May 2022 12:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348426AbiEFQwF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 May 2022 12:52:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B460A5523B
        for <linux-pwm@vger.kernel.org>; Fri,  6 May 2022 09:48:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nn17q-0004bJ-CO; Fri, 06 May 2022 18:48:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nn17q-000jxz-HT; Fri, 06 May 2022 18:48:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nn17o-007zgo-Gd; Fri, 06 May 2022 18:48:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH] pwm: tegra: Implement .apply() callback
Date:   Fri,  6 May 2022 18:48:06 +0200
Message-Id: <20220506164806.138203-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=uwe@kleine-koenig.org; h=from:subject; bh=LNv6wLNopxpE7DacpSgJbuRMG4n8OffM7qrNV3tDsNs=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMSSVBtrJflzXHW310KGiveXd+k3Ca+JLVD4fbiswqUgxSspP SdzcyWjMwsDIxSArpshSV6QlNkFizX+7kiXcMINYmUCmMHBxCsBE0h6w/89d2FDGtcX1vH/CxRi5VS ZX1rRG7mo9Gia5yf2J6ebMR4d6ZX8tsc74/UR7vVPsy+/V8QlfM0/YiP9ViT603jGaSTTTcsfeL0lL F8avvOZUvYPT4NJpUyEVKe3sY3+7XSeudw0IVuXYpbexzUPC/YCalEz5b4v98ZPlFV47Wn3J9NLmad SZfMP24+NLl3kCGVw/BYqyaxRF97MldzbaKU1c9OtI1/rkZ02s66tF/cJ2zJSozDI96xg8Y23AiwuK NyRrT9vP/r3yQGh5YcDlPUVKcdKOfI0c1+/d/nDm6Mv7bFW5PLmCO7e5F2+6HeAr8J8nOlb8FdPHU0 o6J5Z9jLNWa1/6/9C/2s8t+jPTAQ==
X-Developer-Key: i=uwe@kleine-koenig.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply().
This just pushed a variant of pwm_apply_legacy() into the driver that was
slightly simplified because the driver doesn't provide a .set_polarity()
callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tegra.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index e5a9ffef4a71..30d331bbe718 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -230,10 +230,34 @@ static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	pm_runtime_put_sync(pc->dev);
 }
 
+static int tegra_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	int err;
+	bool enabled = pwm->state.enabled;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (enabled)
+			tegra_pwm_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = tegra_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!enabled)
+		err = tegra_pwm_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops tegra_pwm_ops = {
-	.config = tegra_pwm_config,
-	.enable = tegra_pwm_enable,
-	.disable = tegra_pwm_disable,
+	.apply = tegra_pwm_apply,
 	.owner = THIS_MODULE,
 };
 

base-commit: 2bf8ee0faa988b5cec3503ebf2f970a0e84d24ee
-- 
2.35.1

