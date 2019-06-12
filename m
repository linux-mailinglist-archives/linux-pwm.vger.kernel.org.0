Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE45430A9
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 22:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbfFLUA0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 16:00:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46879 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbfFLT7g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so18182447wrw.13;
        Wed, 12 Jun 2019 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KG5NgbEDvB0IWCaREHnEKhv/7oNCiEy8ooK1MlRzIPs=;
        b=CHleG6FA879in8tltHJpvsgIsf5EZHkqvpt/fkvG7bN3tzs+3eV9pxxdayzsj3bWPE
         6phqQcl5xXzRfzen7XMRLmPQoqsw2FYntWAColSUhMZHk4WSuBEMlunBhNnY36o7AcRq
         WugutDifp774LpTT8xW7NZnh8Xm1iHcIvs9NgjqJAJ5UWz3qbqtUCq3lXXVPlnEODES7
         MA7sWXkp/3NuDFYVD7GuA2NZEis7efWRa3g+InIacSbt0C9UxZusIzRT6xaJwL1T5F3k
         kgwnjIKVV+apPIiNxTmT+Iz73IjPY/4Is0TPkJCyKX4XPvFzts81bNm9C3UP5uItrcH9
         Qjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KG5NgbEDvB0IWCaREHnEKhv/7oNCiEy8ooK1MlRzIPs=;
        b=WL8a4OXSVO0Kg+uu2g48NJ5Epen8gb4vbSMX1DXipLI9N+DSOPBsRvQx7woRLDaXyY
         B1ZHWHzHjGgJxFltWsIbG+7iV61hplRWWJaIZttX64FkB6p8EVXPeU1V1Cw+ssKHNXKm
         8uwqeayu4UUrDCUoroN8wI4LY9TA/gv8WL7HiYPYL8APrH+p/6PC80GoLK7432c32GbR
         5ZGtgm57WQaNIbRlxp/GyE/rMHfVnSqkIpMVurNUQnuHxuuI8Zq7mCgotSL9kV7hDKhX
         xdsg/oKMJotGxL3aJYlAhp3SEevAQtn4Xuu+zDfmrihjOHOvPYMgQljUiHgBHLplLzGW
         /Gtg==
X-Gm-Message-State: APjAAAVyvyO794Uj45aJJQnscw1KelshUHH0gchOvFUskxzVstuEvtpK
        fnyI/edqi+uZMleFkakWOLs=
X-Google-Smtp-Source: APXvYqy/wh0jbkT+eAUNg4R4m3wc3iCjuVQTA417SP7ImsnL978LUI+5DY8GjJq0y4lA6mp22EcdFA==
X-Received: by 2002:a5d:4bd0:: with SMTP id l16mr26414553wrt.141.1560369573815;
        Wed, 12 Jun 2019 12:59:33 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:33 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 03/14] pwm: meson: use GENMASK and FIELD_PREP for the lo and hi values
Date:   Wed, 12 Jun 2019 21:59:00 +0200
Message-Id: <20190612195911.4442-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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
2.22.0

