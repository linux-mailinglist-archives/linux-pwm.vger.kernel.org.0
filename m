Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF9EFE1D
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 14:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389086AbfKENPH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 08:15:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56312 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389058AbfKENPG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 08:15:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id m17so11588830wmi.5;
        Tue, 05 Nov 2019 05:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Vnt9sMCBMLu8w8+z/tM0UPoRwgCIImfZjdha8S2Hvo=;
        b=fFmrMG6z+heryOiIoZe22e7Ay6QaIMDoQ0lyGyLwxhXc2kC2+1LNe9PDmqLmvWhL38
         DImcPUDlCRtykfFdC7ZOrE4liyy2pa8B8Zs6gg/W2bPebCmf9hgzKKbScLOKbC/umovX
         ItceCkYzR5FHLb8XFoMdOb5kcUbARO0Wd04P9JPQ7JLTGeYg6H4VBWdYpA9m95DupPVn
         Dgt8QMRqQfADfjUxcZu+HjCw4zCl0aBRBeGIcKx1uJ/K6jSj7RayNOXCqFAy7U8SjsgE
         qmHffAidfGrypuhcF2qK0dut6UyFyrwDX6ekEBIH9pg0D/PLFSssRbtWvtHH7Juy2ROT
         ypIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Vnt9sMCBMLu8w8+z/tM0UPoRwgCIImfZjdha8S2Hvo=;
        b=KC30Ew2ux0Huoavj976/+UZ2KHMqK5vXTaYYksYduvUuxKDia2YXmu8//gg1L3IvxQ
         WbqbNob3aZjKnTS1chonYf2LLr7CTFuYONRuYnN3E3iBwvRQAUdxHYfTDCm+R53DDjMt
         zopjXdBgh08GmbJPtYMJmosvuqlze/bg++0Ik4pFUwwcrx0Iyt3uFZHNSbOkkmgOrtZY
         i/3r+Ml0UlVIg/6MMtFzFg0uoKBb/gVD69zHyXJItF6WxN8vMH7G6AWiNXxJuGY0K4HA
         rCKtTRRq3pu42mOAx3o4tTnt4P7krZGskzr6litmaZeVkbZ6ragYDBlnFhfHXAIoKMUb
         Dk2A==
X-Gm-Message-State: APjAAAWrJKhq62jB7TohahhwPug0mDN0vXHbGMx//e39fIZocpGNB01l
        gvkRqefSk1AN9HkMVfX99kc=
X-Google-Smtp-Source: APXvYqy7cIzX7d3Z3MnPrxaP5dgDyUpjHytLsGWwqekG/5Gcc7AIElqdEyNi7FWNrf9kuBGftMxF7A==
X-Received: by 2002:a1c:453:: with SMTP id 80mr4274482wme.5.1572959704769;
        Tue, 05 Nov 2019 05:15:04 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id a6sm13549920wmj.1.2019.11.05.05.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 05:15:04 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 5/7] pwm: sun4i: Add support for H6 PWM
Date:   Tue,  5 Nov 2019 14:14:54 +0100
Message-Id: <20191105131456.32400-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105131456.32400-1-peron.clem@gmail.com>
References: <20191105131456.32400-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

Now that sun4i PWM driver supports deasserting reset line and enabling
bus clock, support for H6 PWM can be added.

Note that while H6 PWM has two channels, only first one is wired to
output pin. Second channel is used as a clock source to companion AC200
chip which is bundled into same package.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 810abf47c261..e257c1b1fc67 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -359,6 +359,12 @@ static const struct sun4i_pwm_data sun4i_pwm_single_bypass = {
 	.npwm = 1,
 };
 
+static const struct sun4i_pwm_data sun50i_h6_pwm_data = {
+	.has_prescaler_bypass = true,
+	.has_direct_mod_clk_output = true,
+	.npwm = 2,
+};
+
 static const struct of_device_id sun4i_pwm_dt_ids[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-pwm",
@@ -375,6 +381,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 	}, {
 		.compatible = "allwinner,sun8i-h3-pwm",
 		.data = &sun4i_pwm_single_bypass,
+	}, {
+		.compatible = "allwinner,sun50i-h6-pwm",
+		.data = &sun50i_h6_pwm_data,
 	}, {
 		/* sentinel */
 	},
-- 
2.20.1

