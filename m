Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8AC03A11A
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfFHSGh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:06:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45895 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfFHSGg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so5193894wre.12;
        Sat, 08 Jun 2019 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/ZdyCdUpCbl6sdGSUwuqAXTOUbbEuekR+mbdliL/JU=;
        b=unpnaSltvyV5UP5pYykDFAOirz9gbFNoCcnwJl1dgbD8WFjjc81hdFU/1ucbxivIKf
         cFySDh6u4EctBiHKLnFyIEei+ptTRT9L8oLdahFjBVUGZFG0JQBLiJonM6Uuoaq/HOsg
         37BeaBfVcS6VfzHTjqB8dtWzc+6b7TZFKDg0+r8USWQ+w5379puy4ELRPPZPeIp5aFoL
         gtlleazDZyRx+5U+rciCO/NekaHJDgjIom0WFMb4FPYyO10FNTBG2J2w2SrKzHtqkh8g
         AxQnsy/KeoS0Tt2yQ0UXgUPF0FhIROHPa1aWw0kQFLZN4x2DZ6XIXo7UMIuv/5Cl9BPB
         WEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/ZdyCdUpCbl6sdGSUwuqAXTOUbbEuekR+mbdliL/JU=;
        b=nFE0BXETjQflobBp3yUX6m+RH48bP02YXdc6HEhu2MEOuOCeqUnX57/u1bTZWXAlb1
         2p7pyN5nb4szlMHcew9/mOtAQ98izYKbbj2J4HMMIO8nj/kqA1/b6bTWNGkyUKTPRZ3k
         fhAN3cKOc5oAIVLZoO0Mmr8BfjqyqQiAQYdgPj3wVHPaMvTZQJWUW4siNDGjN/5j7ycO
         Dap81ae4YT1fCffgj9ev3wcv0MPVQNi+F2kxX5t0NXJcU8tu58NR08MzLUa0CAubLV4o
         lMEh3eYFpsVXFZfTdieE1hsQc0oFHh1z9VBoZYIN4Zmc1nyLdxB6Mhhl5kLaiwqFgxjQ
         QZsw==
X-Gm-Message-State: APjAAAWlrHlsd+fQ/gGTqNSqfKppw9Khc07XrF5JW3u/rMOfwO/DEd64
        CR1Je0Uf7hcHpTxrfqOmAn0=
X-Google-Smtp-Source: APXvYqxgbZeUFxwnIFozRiNMOXGIrJumTj7Cyk+fnTBqPuOxK7ygTJiAEH64GkWJdbzN4lTdbj75Ow==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr36583935wrn.80.1560017194899;
        Sat, 08 Jun 2019 11:06:34 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:34 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 01/14] pwm: meson: unify the parameter list of meson_pwm_{enable,disable}
Date:   Sat,  8 Jun 2019 20:06:13 +0200
Message-Id: <20190608180626.30589-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is a preparation for a future cleanup. Pass struct pwm_device
instead of passing the individual values required by each function as
these can be obtained for each struct pwm_device instance.

As a nice side-effect the driver now uses "switch (pwm->hwpwm)"
everywhere. Before some functions used "switch (id)" while others used
"switch (pwm->hwpwm)".

No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5fef7e925282..3fbbc4128ce8 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -183,15 +183,14 @@ static int meson_pwm_calc(struct meson_pwm *meson,
 	return 0;
 }
 
-static void meson_pwm_enable(struct meson_pwm *meson,
-			     struct meson_pwm_channel *channel,
-			     unsigned int id)
+static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 {
+	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	u32 value, clk_shift, clk_enable, enable;
 	unsigned int offset;
 	unsigned long flags;
 
-	switch (id) {
+	switch (pwm->hwpwm) {
 	case 0:
 		clk_shift = MISC_A_CLK_DIV_SHIFT;
 		clk_enable = MISC_A_CLK_EN;
@@ -228,12 +227,12 @@ static void meson_pwm_enable(struct meson_pwm *meson,
 	spin_unlock_irqrestore(&meson->lock, flags);
 }
 
-static void meson_pwm_disable(struct meson_pwm *meson, unsigned int id)
+static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
 {
 	u32 value, enable;
 	unsigned long flags;
 
-	switch (id) {
+	switch (pwm->hwpwm) {
 	case 0:
 		enable = MISC_A_EN;
 		break;
@@ -266,7 +265,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 
 	if (!state->enabled) {
-		meson_pwm_disable(meson, pwm->hwpwm);
+		meson_pwm_disable(meson, pwm);
 		channel->state.enabled = false;
 
 		return 0;
@@ -293,7 +292,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (state->enabled && !channel->state.enabled) {
-		meson_pwm_enable(meson, channel, pwm->hwpwm);
+		meson_pwm_enable(meson, pwm);
 		channel->state.enabled = true;
 	}
 
-- 
2.21.0

