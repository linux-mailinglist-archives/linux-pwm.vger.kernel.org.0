Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3406296F7
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Nov 2022 12:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKOLP2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Nov 2022 06:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiKOLO7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Nov 2022 06:14:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5815D10573
        for <linux-pwm@vger.kernel.org>; Tue, 15 Nov 2022 03:14:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt9-0006Wo-F7; Tue, 15 Nov 2022 12:13:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt7-004Qgn-E5; Tue, 15 Nov 2022 12:13:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt7-00GmRi-6z; Tue, 15 Nov 2022 12:13:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 4/5] pwm: stm32-lp: Use regmap_clear_bits and regmap_set_bits where applicable
Date:   Tue, 15 Nov 2022 12:13:46 +0100
Message-Id: <20221115111347.3705732-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115111347.3705732-1-u.kleine-koenig@pengutronix.de>
References: <20221115111347.3705732-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iXmxqmw+3c/LhQoVXeLJZkQYjKkipArmZYpun72ed08=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjc3Rg6EF/v6toXb9ehA0tWaV+ggiioRELXaT1wl60 t5MBC3GJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY3N0YAAKCRDB/BR4rcrsCbBfB/ 49WX5r7TXwnTAK9ZxI/61+6e2ptsbZE6O1cSNc2pO+06WYZclF7yUrG+XYeqvLEAhUHw17W0wFx3U7 Lc3dtKRCF5SmnZ4X0waN4f9fCMWojCF27b9EgFEsxaKkeSVXOQcanCWnnSEHcHnE82SilGAQisvnCT kBL8rfCtml7jDZ+5QgYocnG28dqs/sZSjilDhoc1B54CG0BHsMvg/1i0M0qUX+ueHuuDq7Nc/Rlaia Q2e7gXjHBnskzeFBkJwWJBBuwn4s79FPqTQvyeMiHzLKhv+enXWrHSc/WRKvyyHESN2NcZbjaYJN8Q oiBkn/3q7a32A/09cWboo62RDUNMV6
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

Found using coccinelle and the following semantic patch:

@@
expression map, reg, bits;
@@

- regmap_update_bits(map, reg, bits, bits)
+ regmap_set_bits(map, reg, bits)

@@
expression map, reg, bits;
@@

- regmap_update_bits(map, reg, bits, 0)
+ regmap_clear_bits(map, reg, bits)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32-lp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 3115abb3f52a..212bdc7d51ee 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -140,9 +140,8 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (reenable) {
 		/* Start LP timer in continuous mode */
-		ret = regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
-					 STM32_LPTIM_CNTSTRT,
-					 STM32_LPTIM_CNTSTRT);
+		ret = regmap_set_bits(priv->regmap, STM32_LPTIM_CR,
+				      STM32_LPTIM_CNTSTRT);
 		if (ret) {
 			regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
 			goto err;
-- 
2.38.1

