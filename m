Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E83B3A119
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfFHSHa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:07:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35919 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfFHSGi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so5232788wrs.3;
        Sat, 08 Jun 2019 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwMt4DN+k+wf0lkZogt5PADN1rzK1u4y6aP41xI0QnE=;
        b=Ai7/QxvXeXJfCjaGIQtUgT0iNOxXJwKg0n0kBlr3qjXO5upyFeXiPfrcnxSDErQlqt
         z3CcgSiDYliWk8qfwFQfdIGenTNvz7W3LmWvsgjivpjVimSrOT9/iTq29lttJxYWO3in
         TpBorSmDyJ58Ey4jcxg/5EGToYDZRxFctSUgdmjxLPkNHZohT/Pi5zEuz7KJ07xmnqqq
         FyPbfsiE7l0h+XwUplRemSXg57k3ZTNpsVu9wiurZXxg7FvIqpiYpJKePoCK5iZmPX2/
         sVVunTRAz/+8AtGYFz60gaSG1xWcbhYBZL0/VbTP7KjG5E84GG3PsY1iXemJjHV76kef
         hl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwMt4DN+k+wf0lkZogt5PADN1rzK1u4y6aP41xI0QnE=;
        b=pXTM1AOBCUbN/Axf98rfgiop0I05LDyqcU4/JS2vDVMPSVaJrgEyTrNGSu2rITZF7Z
         MKQ6r3XgjpHeq5bkrUMt3vK4Fem4aL75fVSSu7jH/obN+Xz1ekxWL0RCRPgUC9P/mUSO
         AS902sFyej/NWCj2AsVj6VwrXxlH8pBtQvqUcQf1E/sKmkHMokqBE7ifEnGcOJ0En6oL
         ow8wA2wolXU5/p791t1q5JwXLLAbhu1PtFQHVKx8WfItjIRPM8IujwW9DiClPEfBkEwE
         FWElLxsd4XCtKYXwP93/f+HF8QbS4qjT+OpZJDhGnvYCRUDjwC/av20BmH/MSzYlJrzs
         SKcw==
X-Gm-Message-State: APjAAAUIjvAc+mS1rI673m59DSbcHHp4TnPNzySx48YapbKHClOfi7aM
        0QKWO7tp5x4hpkCgEw3APi8=
X-Google-Smtp-Source: APXvYqw7+qy9TgcaIMEP5Xeg6k3+WyCNQC4Ctm4DlNXGe2zSe+3cQwnCPGb4yd8IR61g60M4nm9H7Q==
X-Received: by 2002:a5d:4cc3:: with SMTP id c3mr11748878wrt.259.1560017196918;
        Sat, 08 Jun 2019 11:06:36 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:36 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 03/14] pwm: meson: use GENMASK and FIELD_PREP for the lo and hi values
Date:   Sat,  8 Jun 2019 20:06:15 +0200
Message-Id: <20190608180626.30589-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

meson_pwm_calc() ensures that "lo" is always less than 16 bits wide
(otherwise it would overflow into the "hi" part of the REG_PWM_{A,B}
register).
Use GENMASK and FIELD_PREP for the lo and hi values to make it easier to
spot how wide these are internally. Additionally this is a preparation
step for the .get_state() implementation where the GENMASK() for lo and
hi becomes handy because it can be used with FIELD_GET() to extract the
values from the register REG_PWM_{A,B} register.

No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 35b38c7201c3..c62a3ac924d0 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2014 Amlogic, Inc.
  */
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
@@ -20,7 +22,8 @@
 
 #define REG_PWM_A		0x0
 #define REG_PWM_B		0x4
-#define PWM_HIGH_SHIFT		16
+#define PWM_LOW_MASK		GENMASK(15, 0)
+#define PWM_HIGH_MASK		GENMASK(31, 16)
 
 #define REG_MISC_AB		0x8
 #define MISC_B_CLK_EN		BIT(23)
@@ -217,7 +220,8 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 	value |= clk_enable;
 	writel(value, meson->base + REG_MISC_AB);
 
-	value = (channel->hi << PWM_HIGH_SHIFT) | channel->lo;
+	value = FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
+		FIELD_PREP(PWM_LOW_MASK, channel->lo);
 	writel(value, meson->base + offset);
 
 	value = readl(meson->base + REG_MISC_AB);
-- 
2.21.0

