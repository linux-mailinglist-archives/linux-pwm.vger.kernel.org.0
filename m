Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D44CF935
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2019 14:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbfJHMFa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Oct 2019 08:05:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46881 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730932AbfJHMF3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Oct 2019 08:05:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id d1so17198309ljl.13
        for <linux-pwm@vger.kernel.org>; Tue, 08 Oct 2019 05:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TptQKMAgu40zPvzhQ1Z31J/pJlahQ9zU95/IQSGlotQ=;
        b=EQxxLJPuv5kKROn32XBozgwjwLwg89RorArcZU/g8cItI4zFmL7g+GBxM/Ahg/onYr
         /Qq6eZw1P0LGp4IiWbUpBRj0wt8o58C+ixmMvDPdQyY9ckNxJ8fwVC+8j5r3oWi+ocMe
         bAPIcSJt4aI9G1QMFztBqZWK5BjdSrlZzfkn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TptQKMAgu40zPvzhQ1Z31J/pJlahQ9zU95/IQSGlotQ=;
        b=j1N7IWNjYf3Rs0v2KbciqmC9BO8AtOpPgHbzA5vT5Fz3oDnoYZ4pKj2eX2U0q2nr54
         TIrDhuUEeo1wQRI9NpKJ2VnTZmh8hBg275W2cpbboihCm1Tg/SA3z+XTlvYb4BBFVsuU
         FPE8SYWxKO8JpfUJwhDirCcRPk8Bd7m17JjWdCcJ0o91YM4NjrI5h2hUQ59119hkiS8i
         npvXnpb+hHpcB3N4qRIoc2hrCVh2yeffnTrh9mWWvWx38q7Yf2g4EAOqUHVSP2RXgLcw
         Ay2LU3ILvMEmcUdGMHM4MAzjc2/zqhrIvfE/9F1Etz0etqLYEA9fksnf6eQAiqXc81ET
         tZAA==
X-Gm-Message-State: APjAAAX54vLYjnQUY7c1axFgPj69SF9qoQUS1SoDqWllsgrTb4+UY2qb
        99goeewV7s73IWKx8L97rF3zjg==
X-Google-Smtp-Source: APXvYqz1ZVV6abC07XSZS+ewKWoIdZcZT75MUkfMcioX26MZiIhkt3Y7dE8w+s+hfv7TsUNPdK5xaw==
X-Received: by 2002:a2e:b045:: with SMTP id d5mr22159030ljl.105.1570536327398;
        Tue, 08 Oct 2019 05:05:27 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z18sm3918033ljh.17.2019.10.08.05.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:05:25 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] backlight: pwm_bl: switch to power-of-2 base for fixed-point math
Date:   Tue,  8 Oct 2019 14:03:27 +0200
Message-Id: <20191008120327.24208-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
References: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Using a power-of-2 instead of power-of-10 base makes the computations
much cheaper. 2^16 is safe; retval never becomes more than 2^48 +
2^32/2. On a 32 bit platform, the very expensive 64/32 division at the
end of cie1931() instead becomes essentially free (a shift by 32 is
just a register rename).

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/backlight/pwm_bl.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 273d3fb628a0..a99c2210c935 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -148,7 +148,8 @@ static const struct backlight_ops pwm_backlight_ops = {
 };
 
 #ifdef CONFIG_OF
-#define PWM_LUMINANCE_SCALE	10000 /* luminance scale */
+#define PWM_LUMINANCE_SHIFT	16
+#define PWM_LUMINANCE_SCALE	(1 << PWM_LUMINANCE_SHIFT) /* luminance scale */
 
 /*
  * CIE lightness to PWM conversion.
@@ -165,23 +166,25 @@ static const struct backlight_ops pwm_backlight_ops = {
  * The following function does the fixed point maths needed to implement the
  * above formula.
  */
-static u64 cie1931(unsigned int lightness, unsigned int scale)
+static u64 cie1931(unsigned int lightness)
 {
 	u64 retval;
 
 	/*
 	 * @lightness is given as a number between 0 and 1, expressed
-	 * as a fixed-point number in scale @scale. Convert to a
-	 * percentage, still expressed as a fixed-point number, so the
-	 * above formulas can be applied.
+	 * as a fixed-point number in scale
+	 * PWM_LUMINANCE_SCALE. Convert to a percentage, still
+	 * expressed as a fixed-point number, so the above formulas
+	 * can be applied.
 	 */
 	lightness *= 100;
-	if (lightness <= (8 * scale)) {
+	if (lightness <= (8 * PWM_LUMINANCE_SCALE)) {
 		retval = DIV_ROUND_CLOSEST(lightness * 10, 9033);
 	} else {
-		retval = (lightness + (16 * scale)) / 116;
+		retval = (lightness + (16 * PWM_LUMINANCE_SCALE)) / 116;
 		retval *= retval * retval;
-		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
+		retval += 1ULL << (2*PWM_LUMINANCE_SHIFT - 1);
+		retval >>= 2*PWM_LUMINANCE_SHIFT;
 	}
 
 	return retval;
@@ -215,8 +218,7 @@ int pwm_backlight_brightness_default(struct device *dev,
 	/* Fill the table using the cie1931 algorithm */
 	for (i = 0; i < data->max_brightness; i++) {
 		retval = cie1931((i * PWM_LUMINANCE_SCALE) /
-				 data->max_brightness, PWM_LUMINANCE_SCALE) *
-				 period;
+				 data->max_brightness) * period;
 		retval = DIV_ROUND_CLOSEST_ULL(retval, PWM_LUMINANCE_SCALE);
 		if (retval > UINT_MAX)
 			return -EINVAL;
-- 
2.20.1

