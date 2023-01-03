Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4897965CA46
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Jan 2023 00:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjACXS7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Jan 2023 18:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjACXS5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Jan 2023 18:18:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2180315FE5
        for <linux-pwm@vger.kernel.org>; Tue,  3 Jan 2023 15:18:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pCqYY-0006N6-ES; Wed, 04 Jan 2023 00:18:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pCqYX-003f90-8r; Wed, 04 Jan 2023 00:18:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pCqYW-00A261-KO; Wed, 04 Jan 2023 00:18:52 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Axel Lin <axel.lin@ingics.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: ab8500:
Date:   Wed,  4 Jan 2023 00:18:41 +0100
Message-Id: <20230103231841.1548913-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SWXagIHsp9OZC1DUE54DJ7SwkNzIIGvcoWq1Chq/ngU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjtLfNmqyF3+pHVdmSTtmyjvHO+3/R9VTUB1N9Yc61 67sG7JKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY7S3zQAKCRDB/BR4rcrsCXIOB/ sECbTOyoAwsYfnIbzO5mLJj9J700G8p4OHAWnTuMb6OzkqIn6DgkJaMxPibkqdqmRtzC6ovo6ex/7Z RtXI2kwNV+qQ+sy+2ZiD9dWTFYkfHu0Ymqjo9Xr50GJaEsPaFiMZWCcDqH4FHJoe5VEADtzkj9fS4e 2koHZYhhY7IJx+hWTVu2pzJZgRiW+i6q99L4lsrFtYKfi+jaevvoSGaDib5U55sOcuK6eLXtXKKfTW JCR54KcD9nM/lM/jlcL/drIyl7taPlkRC6dkaQkkUCcLbT6rwrTqBhmes2koYVDE5WaeQfC61vJ4w6 i/nb7EJK+Pv4iUt8nqYL2UdS1RHlHX
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

The .apply() callback only considered the 10 low bits of .duty_cycle and
didn't check .period at all.

My best guess is the period is fixed at 1024 ns = 0x400 ns. Based on
that assumption refuse configurations that request a lower period (as
usual for PWM drivers) and configure a duty cycle of 0x3ff ns for all
bigger requests.

This improves behaviour for a few requests:

  request  | previous result | new result
-----------+-----------------+------------
 1024/1024 |          0/1024 |  1023/1024
 4000/5000 |        928/1024 |  1023/1024
 5000/5000 |        904/1024 |  1023/1024

(Values specified as duty_cycle / period in ns)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index ad37bc46f272..a7f64371449b 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -37,6 +37,7 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	u8 reg;
 	unsigned int higher_val, lower_val;
 	struct ab8500_pwm_chip *ab8500 = ab8500_pwm_from_chip(chip);
+	unsigned int duty_cycle;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
@@ -52,16 +53,25 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 	}
 
+	/* The period is fixed at 0x400 ns */
+	if (state->period < 0x400)
+		return -EINVAL;
+
+	if (state->duty_cycle >= 0x400)
+		duty_cycle = 0x3ff;
+	else
+		duty_cycle = state->duty_cycle;
+
 	/*
 	 * get the first 8 bits that are be written to
 	 * AB8500_PWM_OUT_CTRL1_REG[0:7]
 	 */
-	lower_val = state->duty_cycle & 0x00FF;
+	lower_val = duty_cycle & 0x00FF;
 	/*
 	 * get bits [9:10] that are to be written to
 	 * AB8500_PWM_OUT_CTRL2_REG[0:1]
 	 */
-	higher_val = ((state->duty_cycle & 0x0300) >> 8);
+	higher_val = (duty_cycle & 0x0300) >> 8;
 
 	reg = AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2);
 
-- 
2.38.1

