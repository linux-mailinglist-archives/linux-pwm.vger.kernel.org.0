Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43048ED4A1
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2019 21:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfKCUdy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 Nov 2019 15:33:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36311 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfKCUdx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 3 Nov 2019 15:33:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id c22so13985501wmd.1;
        Sun, 03 Nov 2019 12:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUeiGo0R+gRoTCDPxtQNMpLNs+clHYgzXZYMbnUhgxI=;
        b=vgfsoFmqWnYJGwMjsGV2Odt0D8NSTyG9E+5hCSheKsanHvWu07coSlIDscsj9Sh9CM
         j2JrSNwXf6QPE0WgMOwP8C5DU2JfQbQcRaW0E2XS4bUeG1ack8vaIlZVo7aosx07RON7
         FHrUSNH2pTMmd2h3Qi6En28Z/AzaaoODD2dp1CVpSNBf4t8iVClmznw59w3XsXt0U/gv
         NOngc76ihhicU73cnbLpZ1nI5yVwcGil0Kzjv2dyscuXOZaOL5L5hXwrpguU3MTAB/Jm
         E/Sg6NfEywGWD3HuaMaQyiC+lhoRdfizHMGUDYOhqINyiCgwXXCzjxPkLimcj/7J1Gmm
         8izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUeiGo0R+gRoTCDPxtQNMpLNs+clHYgzXZYMbnUhgxI=;
        b=FsUmCVtB270kHUXUejIMpzRY8fWG3U6zC8zHNE0/cg6kpMEMy0ihyZ+qaJM4M4Pz4F
         wlv9YB46DeWtZ4jls/ELtcBVuTu8HzLaPL8MRPo9oZlq7dITfpJdm6vGKBaFlImSeWgn
         BOxTB+sCaHlkL3eASWdjZI8W3klSeeRjfkf84hcvQUEmV47exR3zfnF9w3d66/GnLbgC
         JWuTtzPmICFDLsCPLIW5Qy3eAf+JnJvksvwqXVaHsNIwPMNLsImxAOtcMK7cwOVSV+CD
         oWa9oCI/BPkClZHqYIXj25NorU8AxVR5R7K2QF0W4Lwv1O6Riyn9/lG2Yel7BtXOuX4y
         4b8g==
X-Gm-Message-State: APjAAAV8HaAPTHAV/I8lwSZrDyliJaO4xjAnpRO0zMBhvKX2sna/87BG
        hdhdQKq6Ceh340T8pTADOiA=
X-Google-Smtp-Source: APXvYqwmgKG+INCrPX13UEFFneIbv5IIAxc4giEnGPO8aDGbsi1UsyRGszhDvwR6s3IiltSpLgyEYg==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr6327398wmg.117.1572813230261;
        Sun, 03 Nov 2019 12:33:50 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id x16sm13644026wrp.91.2019.11.03.12.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:33:49 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 5/7] pwm: sun4i: Add support for H6 PWM
Date:   Sun,  3 Nov 2019 21:33:32 +0100
Message-Id: <20191103203334.10539-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191103203334.10539-1-peron.clem@gmail.com>
References: <20191103203334.10539-1-peron.clem@gmail.com>
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
index 2441574674d9..0ccc93ce33f4 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -360,6 +360,12 @@ static const struct sun4i_pwm_data sun4i_pwm_single_bypass = {
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
@@ -376,6 +382,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
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

