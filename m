Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CBF7ED5E8
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Nov 2023 22:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjKOVSd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Nov 2023 16:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbjKOVSd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Nov 2023 16:18:33 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D069BC
        for <linux-pwm@vger.kernel.org>; Wed, 15 Nov 2023 13:18:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3NHI-0006G5-FG; Wed, 15 Nov 2023 22:18:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3NHH-009JDk-5F; Wed, 15 Nov 2023 22:18:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3NHG-002CuR-SP; Wed, 15 Nov 2023 22:18:26 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: stm32: Mark capture support as broken
Date:   Wed, 15 Nov 2023 22:18:16 +0100
Message-ID: <20231115211815.441067-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=BZKH3ZxO84YAiSgwdMqmba3f4RyDATsx3QyWDxalWYk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVTWXNItUtJBO01LGz1NyDIcRrKLSdOJcj1P0i MIoV/EXEY2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVU1lwAKCRCPgPtYfRL+ Tty/B/4j6mAnPwS4EMHpXl3vVefQbQ65omFEM46jp8+X4qQUUfVNCX+HApJJIzVT+UAb9fVjEEh mFLjBdTiCTorA14iRAK239QDYO5y9br7FjaMBOOZgkriWODZ73a5SWzSgvyxQq9rJ46SO14P1ia GafwOrnNv9l8CNDT45PZjk8gSwLh1DaGA6es0+gy/bvOJ+Dd4U/zh+hIMEiGk/t6CyTDoiQi0NW ysJGxe8vM5U+qKjJkKDl2gD3dpPnB3UK9OjNmcYGMwjGlhDwvHtMFfVTEft8OcgYRB/7XGw0qeO 1shfapkggRAw0NfqxaNy4T0oRlwa8CuUKxZXVNWQrj1MdbKC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As described in the added comment, calling capture on one channel stops
all PWM output on the other channels. While it probably isn't hard to
fix, I cannot test it. Also this bug supports my guess that capture
isn't used in practise. So instead of an untested fix, mark capture
support as broken. If indeed there are users this will hopefully make
them speak up and provide a tested fix.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 3303a754ea02..20705bc814f1 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -488,7 +488,13 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static const struct pwm_ops stm32pwm_ops = {
 	.apply = stm32_pwm_apply_locked,
-	.capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
+	/*
+	 * stm32_pwm_raw_capture() (which is called by stm32_pwm_capture())
+	 * unconditionally clears TIM_CR1_CEN. So capturing on one channel
+	 * results in stopping all PWM outputs on the other channels of the same
+	 * chip.
+	 */
+	.capture = IS_ENABLED(CONFIG_BROKEN) && IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
 };
 
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.42.0.586.gbc5204569f7d.dirty

