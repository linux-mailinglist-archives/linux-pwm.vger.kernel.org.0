Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE2430A7
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 22:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfFLUAV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 16:00:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46881 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389105AbfFLT7g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so18182488wrw.13;
        Wed, 12 Jun 2019 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2ZTxmecaI8j/nsEN2U3OFIk14R4Cf7/mfp7zpgoLfM=;
        b=Q54uXWSOBp86x8VIy7nD49eWrt7nKUUASANXF9km1DmsBhbyaAeGqKorOE3GG77GdY
         1b8zuz7QBFDif20RA39AvYgTbw9EqS1cZ84omHdCAaYuPezVE1afE5SkcI9/UOuM4mQe
         6aK9oArhU8EW2NLW/OnK6ulTCIeb19t+xYmobb2dA/r1ya56pxkV2ipcFoAG0JWS5Kz+
         yZ0/dx0N+2mf68CXrlV54vzW5GVzbzP9CoxoeBC0f0B7rJGcNiS6sX6WfkjrSbtBLADL
         L8M/R0KL71oi5Hd1bhAeXKx7GcDlGi9TqtmmpPzJ77OyZEOuQVnfXE/WRsGsnH2HnYl9
         gsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2ZTxmecaI8j/nsEN2U3OFIk14R4Cf7/mfp7zpgoLfM=;
        b=PzhUq2PxjbZeAi5N0UJq1YmBNzMccduFEHcqYON5lyz15d+q1ZZDI8nJfb9swB0q8Q
         wkBC76b7En1eRC7ZHQ8B5QvbA/VH+VX9A2dyMNYLe10pPMYLeaPc6aWfbm99ESYBmJt1
         m6B50iZoH38ujjWlr7zyPiiP0r91CNGMVVkCk1wYKAj5fnfxjj5WcTi5xnZHJwSzOm1v
         gVzi1T2HFNgnan8HGI5gmLRr7DXsFPKpJq/jvrifJ1yQk+8Ld88NNnfjOgA9Ol/9eQOy
         JqdrpfLVyBhFLqdrCSkIZLZIa9JJw87HNQzHSIeHJ7ktRyjz8aGu7jaBnpkMujJCXFfA
         xe1w==
X-Gm-Message-State: APjAAAXmuuJZY79X+cUAARd3yj6XXjKOXTnnqt5AIYA//PYqWrMy2akN
        z6C7KndNC3uxgDJYzD7oia6RKESW
X-Google-Smtp-Source: APXvYqyspO3oY8Ipnq8K2E0Xl8QIVawbGhRqNZsLBv7lCAtvqLpJOyYoNB7zK5F7Udq8+Q23sINe3Q==
X-Received: by 2002:adf:ead1:: with SMTP id o17mr10900777wrn.176.1560369574888;
        Wed, 12 Jun 2019 12:59:34 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:34 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
Date:   Wed, 12 Jun 2019 21:59:01 +0200
Message-Id: <20190612195911.4442-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

MISC_CLK_SEL_WIDTH is only used in one place where it's converted into
a bit-mask. Rename and change the macro to be a bit-mask so that
conversion is not needed anymore. No functional changes intended.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index c62a3ac924d0..84b28ba0f903 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -33,7 +33,7 @@
 #define MISC_A_CLK_DIV_SHIFT	8
 #define MISC_B_CLK_SEL_SHIFT	6
 #define MISC_A_CLK_SEL_SHIFT	4
-#define MISC_CLK_SEL_WIDTH	2
+#define MISC_CLK_SEL_MASK	0x3
 #define MISC_B_EN		BIT(1)
 #define MISC_A_EN		BIT(0)
 
@@ -463,7 +463,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
 
 		channel->mux.reg = meson->base + REG_MISC_AB;
 		channel->mux.shift = mux_reg_shifts[i];
-		channel->mux.mask = BIT(MISC_CLK_SEL_WIDTH) - 1;
+		channel->mux.mask = MISC_CLK_SEL_MASK;
 		channel->mux.flags = 0;
 		channel->mux.lock = &meson->lock;
 		channel->mux.table = NULL;
-- 
2.22.0

