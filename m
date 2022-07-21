Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F9757C8FF
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Jul 2022 12:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiGUKbm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Jul 2022 06:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiGUKbl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Jul 2022 06:31:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AD960687
        for <linux-pwm@vger.kernel.org>; Thu, 21 Jul 2022 03:31:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSz-0002Vw-QO; Thu, 21 Jul 2022 12:31:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSy-002IMc-9X; Thu, 21 Jul 2022 12:31:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSx-006ZIG-8g; Thu, 21 Jul 2022 12:31:35 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>
Subject: [PATCH 1/7] pwm: sifive: Simplify offset calculation for PWMCMP registers
Date:   Thu, 21 Jul 2022 12:31:23 +0200
Message-Id: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2206; h=from:subject; bh=S9GIGL+Cct/zyqgr/ikWe3LQhbttxTcRa9DxXEHmNkE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi2SrrxbR6WH/xT1XiSbvMGpd7KdnUxvzpxZ52l/3U 7p4plO2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtkq6wAKCRDB/BR4rcrsCdCLCA ChSWsJTopykEY66sAPoljOUbgwbe5BclCZKRJyMy7TtVK5CtIsUs5cBly/ahVIJX4fFuX012X++rop WkUTBtyyB2GNIwvjL4PapHBuV2zOdrljrtPEyjZ2bJGh+4fEXQJR8u6aHpcGaWKoodorvT+OzhegBl 3C9isWIU/SJeALqb9OPWT6tSV3WAjJ1T4o6XnsxuJhKJvq5bEJWqYwIyizoGD/UT7w6BRHrnEUjDSx L45pMXhfRf6aI7ozoSaTE9oq0bppgFSu4rW61kqx5yxzSHiWlgGdis5CAkAFdNktUjpOJY+J/GE7wR 9uIJP94GSbMvn6Th/K02QgD1lFOlj7
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

Instead of explicitly using PWM_SIFIVE_PWMCMP0 + pwm->hwpwm *
PWM_SIFIVE_SIZE_PWMCMP for each access to one of the PWMCMP registers,
introduce a macro that takes the hwpwm id as parameter.

For the register definition using a plain 4 instead of the cpp constant
PWM_SIFIVE_SIZE_PWMCMP is easier to read, so define the offset macro
without the constant. The latter can then be dropped as there are no
users left.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index e6d05a329002..b7fc33b08d82 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -23,7 +23,7 @@
 #define PWM_SIFIVE_PWMCFG		0x0
 #define PWM_SIFIVE_PWMCOUNT		0x8
 #define PWM_SIFIVE_PWMS			0x10
-#define PWM_SIFIVE_PWMCMP0		0x20
+#define PWM_SIFIVE_PWMCMP(i)		(0x20 + 4 * (i))
 
 /* PWMCFG fields */
 #define PWM_SIFIVE_PWMCFG_SCALE		GENMASK(3, 0)
@@ -36,8 +36,6 @@
 #define PWM_SIFIVE_PWMCFG_GANG		BIT(24)
 #define PWM_SIFIVE_PWMCFG_IP		BIT(28)
 
-/* PWM_SIFIVE_SIZE_PWMCMP is used to calculate offset for pwmcmpX registers */
-#define PWM_SIFIVE_SIZE_PWMCMP		4
 #define PWM_SIFIVE_CMPWIDTH		16
 #define PWM_SIFIVE_DEFAULT_PERIOD	10000000
 
@@ -112,8 +110,7 @@ static void pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
 	u32 duty, val;
 
-	duty = readl(ddata->regs + PWM_SIFIVE_PWMCMP0 +
-		     pwm->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
+	duty = readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
 
 	state->enabled = duty > 0;
 
@@ -193,8 +190,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		pwm_sifive_update_clock(ddata, clk_get_rate(ddata->clk));
 	}
 
-	writel(frac, ddata->regs + PWM_SIFIVE_PWMCMP0 +
-	       pwm->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
+	writel(frac, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
 
 	if (state->enabled != enabled)
 		pwm_sifive_enable(chip, state->enabled);

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

