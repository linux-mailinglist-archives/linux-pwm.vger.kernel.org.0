Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7928563F3AF
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 16:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLAPWk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Dec 2022 10:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLAPWi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Dec 2022 10:22:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93C03B04
        for <linux-pwm@vger.kernel.org>; Thu,  1 Dec 2022 07:22:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01A8AD6E;
        Thu,  1 Dec 2022 07:22:41 -0800 (PST)
Received: from e110479.cambridge.arm.com (e110479.cambridge.arm.com [10.1.38.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 342893F67D;
        Thu,  1 Dec 2022 07:22:32 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] pwm: sun4i: Propagate errors in .get_state() to the caller
Date:   Thu,  1 Dec 2022 15:22:23 +0000
Message-Id: <20221201152223.3133-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

.get_state() can return an error indication now. Make use of it to
propagate an impossible prescaler encoding, should that have sneaked in
somehow.
Also check the return value of clk_get_rate(). That's unlikely to fail,
but we use that in two divide operations down in the code, so let's
avoid a divide-by-zero condition on the way.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

this goes on top of Uwe's series to introduce and observe .get_state
failures: https://lore.kernel.org/linux-pwm/20221130152148.2769768-12-u.kleine-koenig@pengutronix.de/T/#m9af39aa03bbd9bb7b31b3600f110c65ee0e8e70b
Actually it only relies on patch 01/11 from that.

Cheers,
Andre

 drivers/pwm/pwm-sun4i.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 37d75e252d4e..b973da73e9ab 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -118,6 +118,8 @@ static int sun4i_pwm_get_state(struct pwm_chip *chip,
 	unsigned int prescaler;
 
 	clk_rate = clk_get_rate(sun4i_pwm->clk);
+	if (!clk_rate)
+		return -EINVAL;
 
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
@@ -142,7 +144,7 @@ static int sun4i_pwm_get_state(struct pwm_chip *chip,
 		prescaler = prescaler_table[PWM_REG_PRESCAL(val, pwm->hwpwm)];
 
 	if (prescaler == 0)
-		return 0;
+		return -EINVAL;
 
 	if (val & BIT_CH(PWM_ACT_STATE, pwm->hwpwm))
 		state->polarity = PWM_POLARITY_NORMAL;
-- 
2.17.1

