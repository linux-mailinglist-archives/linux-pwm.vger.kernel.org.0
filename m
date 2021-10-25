Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425B3439D21
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Oct 2021 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbhJYRMP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhJYRLb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 13:11:31 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58551C061220
        for <linux-pwm@vger.kernel.org>; Mon, 25 Oct 2021 10:07:49 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id w9-20020a4adec9000000b002b696945457so3886636oou.10
        for <linux-pwm@vger.kernel.org>; Mon, 25 Oct 2021 10:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OM0cPou9Yt3Ud6BL/XL+O772DGApdgc8zaM9N+mI1Aw=;
        b=wOW1uKfv35wx7ay7/EXrWat8asMllLTqON55vq3ZRfnefbC0dX0T04jeONk1+64HQ8
         OpoYU4vPno1TA9Im73pv9x4M5t5+TlKcL1Twiq4ECRybUTGK53HiERnZNhfLKPD1p5q9
         QPCtp8XLnNAw3SrwNEGMD8sDaaHbbHgY6WunmZ0koO62vWJWioGpvSLSYAE6YFMCd3h2
         3ceambUzY2wWVI0oFRPU0LZZInMMDRO1D6Qkg84P05d9mjdN6ysdKBhpmUM38FSeRV2/
         jTEZqHLwI8OVk75KL3jCHWIoBPBs19mCDiOM74eSf/ggu+IdgALuBNl4kTet5fmx0IXL
         C29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OM0cPou9Yt3Ud6BL/XL+O772DGApdgc8zaM9N+mI1Aw=;
        b=a8zfo/H6T/QPQYTOCCe2ENvhZgeIfg8AIk1t4p8AMv0uziiMxZ1tfvctPsWVfftsU9
         2cgjsz7cX6VY6JlQXcy42Y5JDEmwG1OoUlKY0W/m50scPfOit63pZY0pFkEsQrutETiQ
         lBIxpu69N5NC0TdTK80dXZ7TwK10Jd3OLP1gSXuWkMT0bHhZjc6EDFidIWbvUTA0s3gw
         PaD9Cr9b48En/vuYetVduJHmsIUG1Cnn0J4dmkWxWuiydsccdPYoR0sAF8bgDYBoGBjn
         kx+WS7alaYvBCPHWZQGvxcprtEvrOGJ+EUPszhB/GBvqjMAGKd0HlOqER5v3/jKTcInq
         bWmg==
X-Gm-Message-State: AOAM532nHIC8oVPbyg2pQkjcwGHmpy+HiNkQqhFzanyfu7Xx5X264o0l
        EJMbLMD2/J7M8lrEszfkZXbH/w==
X-Google-Smtp-Source: ABdhPJy7TkF/lMJfJ1Xivrb4nJ+9n0smvlbKluTV6cZf/ycixxWBxfTRT11LZ5PCfDcNtqDv1ltx8A==
X-Received: by 2002:a4a:e9f0:: with SMTP id w16mr13239349ooc.3.1635181668593;
        Mon, 25 Oct 2021 10:07:48 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id q2sm3076003ooe.12.2021.10.25.10.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:07:48 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 2/3] drm/bridge: ti-sn65dsi86: Use regmap_bulk_write API
Date:   Mon, 25 Oct 2021 10:09:24 -0700
Message-Id: <20211025170925.3096444-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
References: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The multi-register u16 write operation can use regmap_bulk_write()
instead of two separate regmap_write() calls.

It's uncertain if this has any effect on the actual updates of the
underlying registers, but this at least gives the hardware the
opportunity and saves us one transation on the bus.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v6:
- None

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6154bed0af5b..5b59d8dd3acd 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -193,8 +193,9 @@ static const struct regmap_config ti_sn65dsi86_regmap_config = {
 static void ti_sn65dsi86_write_u16(struct ti_sn65dsi86 *pdata,
 				   unsigned int reg, u16 val)
 {
-	regmap_write(pdata->regmap, reg, val & 0xFF);
-	regmap_write(pdata->regmap, reg + 1, val >> 8);
+	u8 buf[2] = { val & 0xff, val >> 8 };
+
+	regmap_bulk_write(pdata->regmap, reg, buf, ARRAY_SIZE(buf));
 }
 
 static u32 ti_sn_bridge_get_dsi_freq(struct ti_sn65dsi86 *pdata)
-- 
2.29.2

