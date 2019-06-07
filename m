Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7EB39118
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2019 17:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfFGP4p (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Jun 2019 11:56:45 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:48130 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbfFGPoY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Jun 2019 11:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559922262; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26+L+Bp4HK/u4QnZbuhObP9UxrCUGOzAtZwA+cAECmo=;
        b=K7tV06JxEvyJs0RWkoC7q9Bqd6iOLPhe9UTHzhWu8hu2vM+lg5LjyzDg5tYsImpjLLT6N0
        uTJn/rjcK9Bj/0y6Q1D4IvMCkzgJZ23OqG0MCHLVe1avAIB+lyZYmOGVj9GPzjBfl+NZ6v
        FvagXEq5istz13o9LqXW8hjeuz+qYRY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 5/6] pwm: jz4740: Force TCU2 channels to return to their init level
Date:   Fri,  7 Jun 2019 17:44:09 +0200
Message-Id: <20190607154410.10633-6-paul@crapouillou.net>
In-Reply-To: <20190607154410.10633-1-paul@crapouillou.net>
References: <20190607154410.10633-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When the PWM mode of TCU2 channels is disabled, their corresponding pin
does not always return to its initial level. Force this by using a small
trick: we set duty > period, which is an invalid configuration for the
hardware, which then correctly resets the pin to the initial level.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch

 drivers/pwm/pwm-jz4740.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 75254360621c..f901e8a0d33d 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -63,7 +63,15 @@ static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->hwpwm);
 
-	/* Disable PWM output.
+	/*
+	 * Set duty > period. This trick allows the TCU channels in TCU2 mode to
+	 * properly return to their init level.
+	 */
+	jz4740_timer_set_duty(pwm->hwpwm, 0xffff);
+	jz4740_timer_set_period(pwm->hwpwm, 0x0);
+
+	/*
+	 * Disable PWM output.
 	 * In TCU2 mode (channel 1/2 on JZ4750+), this must be done before the
 	 * counter is stopped, while in TCU1 mode the order does not matter.
 	 */
-- 
2.21.0.593.g511ec345e18

