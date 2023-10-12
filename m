Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB88A7C72BC
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379635AbjJLQbL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379602AbjJLQa7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970D5A9
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaO-0004vU-MV; Thu, 12 Oct 2023 18:30:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaO-001C73-9q; Thu, 12 Oct 2023 18:30:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaO-00F5Nz-0o; Thu, 12 Oct 2023 18:30:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 028/109] pwm: stm32-lp: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:56 +0200
Message-ID: <20231012162827.1002444-139-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uRk+/sMfmtxInKzcTIVz2H1ttRi3S5vrmAPSsZ8hwWI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7NGoqwOigV00TymyJkR741Ml8j6scU3JUGv d1Nbb8heu2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgezQAKCRCPgPtYfRL+ TuyEB/4ylNXZRX0UTQ/VN8C8phtusbiWt/eVne79nLSC5A05OTB4DRHxD10B7xsGmLxd+0tDhTH UfVOd8cpu/dXBAi/R6CXiM2NiOa6iFc02N32AkpKLR9vNWI8Adpi73AvTd99DajpqRdwsbJtuA1 STNzb54n7TNT4EyqcjuqzdDX2n6apUF3n+PoJdFD4ZlVpztx2KObnEG3cxog5PmvHxi46Ca3vEP sjoevJeZnE8kaI6spB8gdglK5+Iu1vGyP11N+3yc6BLZ3B92CMZZJTE3uXEsqJY8o8vPvW+0fP0 aAAla/A8HUxq1YgJQCxLeQe48s4hQutj+a+TbOLNBy0OB15m
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
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32-lp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index b67974cc1872..1ed04664355f 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -61,7 +61,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(div, NSEC_PER_SEC);
 	if (!div) {
 		/* Clock is too slow to achieve requested period. */
-		dev_dbg(priv->chip.dev, "Can't reach %llu ns\n", state->period);
+		dev_dbg(pwmchip_parent(chip), "Can't reach %llu ns\n", state->period);
 		return -EINVAL;
 	}
 
@@ -69,7 +69,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	while (div > STM32_LPTIM_MAX_ARR) {
 		presc++;
 		if ((1 << presc) > STM32_LPTIM_MAX_PRESCALER) {
-			dev_err(priv->chip.dev, "max prescaler exceeded\n");
+			dev_err(pwmchip_parent(chip), "max prescaler exceeded\n");
 			return -EINVAL;
 		}
 		div = prd >> presc;
@@ -130,7 +130,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				       (val & STM32_LPTIM_CMPOK_ARROK) == STM32_LPTIM_CMPOK_ARROK,
 				       100, 1000);
 	if (ret) {
-		dev_err(priv->chip.dev, "ARR/CMP registers write issue\n");
+		dev_err(pwmchip_parent(chip), "ARR/CMP registers write issue\n");
 		goto err;
 	}
 	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
-- 
2.42.0

