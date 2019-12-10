Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E51184ED
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Dec 2019 11:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfLJKYx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Dec 2019 05:24:53 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51637 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJKYx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Dec 2019 05:24:53 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iechH-0002GB-4u; Tue, 10 Dec 2019 11:24:51 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iechG-000777-It; Tue, 10 Dec 2019 11:24:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Colin King <colin.king@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Walter Harms <wharms@bfs.de>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2] pwm: sun4i: Narrow scope of local variable
Date:   Tue, 10 Dec 2019 11:24:44 +0100
Message-Id: <20191210102444.26594-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210101229.rvqelc2hanisd2cp@pengutronix.de>
References: <20191210101229.rvqelc2hanisd2cp@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The variable pval is only used in a single block in the function
sun4i_pwm_calculate(). So declare it in a more local scope to simplify
the function for humans and compilers.

While at it also simplify assignment to pval.

While the diffstat for this patch is negative for this patch I still
thing the advantage of having a narrower scope is beneficial.

In my compiler / .config setup (gcc 8.2.1, arm/imx_v6_v7_defconfig +
COMPILE_TEST + PWM_SUN4I) this change doesn't result in any binary
changes.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

changes since (implicit) v1:

 - also simplify assignment to pval as suggested by Walter
 - verify the patch doesn't introduce binary changes

Best regards
Uwe

 drivers/pwm/pwm-sun4i.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1fa2057419fb..4f77ebc8ae69 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -152,7 +152,7 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 			       u32 *dty, u32 *prd, unsigned int *prsclr)
 {
 	u64 clk_rate, div = 0;
-	unsigned int pval, prescaler = 0;
+	unsigned int prescaler = 0;
 
 	clk_rate = clk_get_rate(sun4i_pwm->clk);
 
@@ -173,9 +173,11 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 	if (prescaler == 0) {
 		/* Go up from the first divider */
 		for (prescaler = 0; prescaler < PWM_PRESCAL_MASK; prescaler++) {
+			unsigned int pval = prescaler_table[prescaler];
+
-			if (!prescaler_table[prescaler])
+			if (!pval)
 				continue;
-			pval = prescaler_table[prescaler];
+
 			div = clk_rate;
 			do_div(div, pval);
 			div = div * state->period;
-- 
2.24.0

