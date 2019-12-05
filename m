Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC1BF113C43
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2019 08:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfLEHYN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Dec 2019 02:24:13 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43361 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfLEHYN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Dec 2019 02:24:13 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iclUg-0004Nm-EN; Thu, 05 Dec 2019 08:24:10 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iclUf-00075g-Ed; Thu, 05 Dec 2019 08:24:09 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Colin King <colin.king@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] pwm: sun4i: Narrow scope of local variable
Date:   Thu,  5 Dec 2019 08:24:04 +0100
Message-Id: <20191205072404.6858-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191002101624.gljyf7g4nia2rcbx@pengutronix.de>
References: <20191002101624.gljyf7g4nia2rcbx@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
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

While the diffstat for this patch is negative for this patch I still
thing the advantage of having a narrower scope is beneficial.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

for the patch that became

	1b98ad3b3be9 ("pwm: sun4i: Drop redundant assignment to variable pval")

(and which yielded the situation that pval is only used in this single
block) I suggested to do this change. This was ignored however by both
Colin and Thierry without comment. So I suggest the change here
separately.

Best regards
Uwe

 drivers/pwm/pwm-sun4i.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 581d23287333..8919e6ab7577 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -149,7 +149,7 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 			       u32 *dty, u32 *prd, unsigned int *prsclr)
 {
 	u64 clk_rate, div = 0;
-	unsigned int pval, prescaler = 0;
+	unsigned int prescaler = 0;
 
 	clk_rate = clk_get_rate(sun4i_pwm->clk);
 
@@ -170,6 +170,8 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 	if (prescaler == 0) {
 		/* Go up from the first divider */
 		for (prescaler = 0; prescaler < PWM_PRESCAL_MASK; prescaler++) {
+			unsigned int pval;
+
 			if (!prescaler_table[prescaler])
 				continue;
 			pval = prescaler_table[prescaler];
-- 
2.24.0

