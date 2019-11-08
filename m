Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC465F426D
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Nov 2019 09:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfKHIpd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Nov 2019 03:45:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53309 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbfKHIpc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Nov 2019 03:45:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id x4so5260729wmi.3;
        Fri, 08 Nov 2019 00:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R2H2SvNfp2D1pWuVIAXfuUZmaanE3ag429BW1Qs5Xbw=;
        b=l7g2WJEpz9iGWpW4GTr4NP4iWFjfeqIW/bvPcR3EzXT2ZRovXiQKEnOhFWbdCJXCxk
         Iz2ZpqyTGYXS9YGss2IsRNMUjehpu59CVhlJ5oLvIHrCnAWn+z+hav9dakiqTp43ILcn
         /8HOFk22TZhhXrZ0AY5tdwQvrF3pNUeVis/lWQzmJxGS9gbhAtpmq/RJIFEfNjeC+K3L
         3PUpygxp1f49wq+iE/Ygu2Hv8TR5hQVWalsNamPIhh2ikiGMmYEOJ4g4JePT8KBF7n7q
         8poH1me3sjiJpA62sJOTO/xoo4FuCUtcPWlQCHb2xPf65p3lVNY9C/egXNNNerIfJwWw
         S3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2H2SvNfp2D1pWuVIAXfuUZmaanE3ag429BW1Qs5Xbw=;
        b=NEGDUu47Jn7FrTyb+NWu5MG6Goe8mTaWQpFQwHNxVNXKZq8OU47Kjvxu04qeylSGCq
         ZbHznuCuoIMaWxN/hJo2uE8c0vT4VlZ/Yr5ihqU6foZzp08PKVsUPSQuNkok9N5vf9Dd
         9ObnWkaF350RIB179t6YnkqzF2hPPlbtGOFnKBkPLMrtdRuquAcmArWXd8BAmjs187MM
         Lbfmosb5ydySz7HPRRuA45SbibgK3t83NZfYMnBdgvnhDPKZp++1BZlm8+RA5eRyGbFt
         kFJs7YzOkUX3jIL8x+4fJfLC7ekkfJ//08UiCGK1RhwJjU/Yggh8yxLPP9GC6UottJAm
         DH0A==
X-Gm-Message-State: APjAAAWrbmxzWW/kS9rPOqLlPLg5MdIXoVnsefpAK2tXOHr4LH6PtgET
        9shXXXXMIGz3NoDpWEg/CkU=
X-Google-Smtp-Source: APXvYqyXzyJC3Dq6/PPn4+ahFI8wCQAvazATqLEj08DnRqbjTFB1hb1Zf/mNsFjSrGyw/2NztoTOgA==
X-Received: by 2002:a05:600c:210c:: with SMTP id u12mr4568420wml.49.1573202730371;
        Fri, 08 Nov 2019 00:45:30 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id q25sm6662665wra.3.2019.11.08.00.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 00:45:29 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 5/7] pwm: sun4i: Add support for H6 PWM
Date:   Fri,  8 Nov 2019 09:45:15 +0100
Message-Id: <20191108084517.21617-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108084517.21617-1-peron.clem@gmail.com>
References: <20191108084517.21617-1-peron.clem@gmail.com>
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
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sun4i.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 9cc928ab47bc..a57637de41c9 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -367,6 +367,12 @@ static const struct sun4i_pwm_data sun4i_pwm_single_bypass = {
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
@@ -383,6 +389,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
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

