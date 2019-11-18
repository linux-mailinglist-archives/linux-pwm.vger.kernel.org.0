Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A70810032E
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 12:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKRLAq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 06:00:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36873 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfKRLAp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 06:00:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so18240155wmj.2;
        Mon, 18 Nov 2019 03:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3PWy3cFb/7J+Rxg3fcaYJEk3LUN9QrWLTJanLEpmxI=;
        b=lqFiFGfEjlOyJdMo+LwLnwc1FWulJ+c/qGY/aVFkwdUbPFOOhNeoSGjHxfUwNnzlLr
         J5/wl/qleAx9N5DqnEw9w5udIpP9jnvnNwcYkOyjwGhSdynL52nvD3nZtNFnmvfGN+Pw
         La92CMaO87+qeEuGskGIRTgQgPo3KHiSW8PZPRT7a2FyU+T45Sy7B4AClODYKBkk6w2O
         zz7pPLHgOyuvryoFIeDDVX53Ljv/Hb8DLVGT8K5fcknzDMwCjf3O9SEOgVtukeNaSR/O
         aPut4FD76o5oWhRQE6KnvIwhUTTfbe0xvqe6WPYMbQVbBpZTt+NUnWxEBd1R4aAwebVF
         LX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3PWy3cFb/7J+Rxg3fcaYJEk3LUN9QrWLTJanLEpmxI=;
        b=npOj0BHIuanTL1NKXfF83/1U50v52hc5Y+ueUB7Np19m2TgyEovcbFrcgtIP410YO+
         IUKuoJd7zXrISVkbzFgiWjiTrvb9k5g80PL2J/vg4Syqnd2+jbwTPg3yT5QsP39hs/JT
         rT2Mwmnmt6Egmximet+4iiUICdHbK9w0oYGVZEDEl0rgZOHHdi1ziao5l1x9oobD3TqW
         puwusUnK3uGOj6yh1Y4pwCzP5Z6tCgbrdxxaYZnsCkHVV8f7E2nWoTC41Q8KX8m55V9j
         xndZTDHcTjEZ+c0vzcSSXvh33CGeLZ0I+tV1f+stk5BuSJNhoij+JfZkNiySBEkTvo+j
         t70g==
X-Gm-Message-State: APjAAAU9P+L4Xaa2qslkQkVpqd3uHNz5Cxd0/N6lXQ9NfaJl7ui3qdsu
        bG32Z4Qr9lH6jH0UPOTM2iE=
X-Google-Smtp-Source: APXvYqz5oI2WXuyJXr0xQbPksS/Aff1WCNMfgC+OGCxFB9b/PfDIb+Mg7WcB52n+N87+rwEgv9LqBg==
X-Received: by 2002:a05:600c:24c9:: with SMTP id 9mr27548319wmu.137.1574074843900;
        Mon, 18 Nov 2019 03:00:43 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f67sm19873313wme.16.2019.11.18.03.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:00:43 -0800 (PST)
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
Subject: [PATCH v6 6/8] pwm: sun4i: Add support for H6 PWM
Date:   Mon, 18 Nov 2019 12:00:32 +0100
Message-Id: <20191118110034.19444-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118110034.19444-1-peron.clem@gmail.com>
References: <20191118110034.19444-1-peron.clem@gmail.com>
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
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index a1d8851b18f0..640f6349e36f 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -358,6 +358,12 @@ static const struct sun4i_pwm_data sun4i_pwm_single_bypass = {
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
@@ -374,6 +380,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
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

