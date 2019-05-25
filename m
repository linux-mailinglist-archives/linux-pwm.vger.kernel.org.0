Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 804292A635
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2019 20:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfEYSLw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 May 2019 14:11:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36796 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfEYSLu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 May 2019 14:11:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id v22so4816450wml.1;
        Sat, 25 May 2019 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTuYf2SN++XrzgOo/LowMD7xHt6KeFYnBiXdbjNn1Mc=;
        b=VnKfwh0bGoV85geiehf3lF7Ro/8ZshaPwzuqppSHFpjUxlW8nxcaz1HWoxyvGuTRHz
         8obIqVm7h0WsDAyI+PoOHI1yEHv+a7fGSkrf5sUrJhHMhyjVZtFCB2VVfe7dg6cEofUR
         dF3Yp4zbu3MiZn2VSAbwd77ukSrzUO/HqTAvT+lLvwLrqfIQbXDT91zKKyBLxuKgXCgK
         bbaGpLyRRMeYKs3Vm9/fMUZs+8EP+AKTGTAGqrh8Wj6NObw8RVZWCVpuoQZDIuJJsLRa
         kiK7rS/YY0lojeU0Pe3Kps2/+Oxqbt+LcAy7z44txeLaCTs7d72Dhg8lTx2lWyCosVIX
         XHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTuYf2SN++XrzgOo/LowMD7xHt6KeFYnBiXdbjNn1Mc=;
        b=NTN0LFYuALnzC6EFAsj/rm2UTe1uh2U52beMbGvLJlRuHsCeiN8XeJmfy9eFSwpiDi
         q16m90WugxGvQfDNEWe9sMfq8JDSspWlz43QVGiV2nqMainT/6q6bV3C9x4DzsEL6y3J
         nRFEMYU5NTG+O3qZS5gDzOdJE3hjMCIjbtD77GFTPAnmN5fcoUYnhvmzhTijSMulLZTM
         91L4EGVerzQzdIiEK+lGX+KALNTsRkN1z7P/who5teh3t8H5k/T9jhT0sfpewxzommke
         TxsUfOajrta/8Y67hWj72qM5CLZNXH3FTbaXSuH/ap4mVBdFhiyl4efWLmwD68C/rSkj
         X+IA==
X-Gm-Message-State: APjAAAV6BxAFnl3iM1SeErM0M6RIhwBLSmAH7IL2tX5qKlwzj+BeWpHz
        A9CtQcE4XldBb0smy3tEnWc=
X-Google-Smtp-Source: APXvYqxzNHr1KHGccEbFz4UmNfvsgrRoH6NuLmip3pRZHRxdOtQ8QuPVBMnJaq2uWniu0zSEdRHOgA==
X-Received: by 2002:a1c:e009:: with SMTP id x9mr4094446wmg.117.1558807908370;
        Sat, 25 May 2019 11:11:48 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:47 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
Date:   Sat, 25 May 2019 20:11:23 +0200
Message-Id: <20190525181133.4875-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

MISC_CLK_SEL_WIDTH is only used in one place where it's converted into
a bit-mask. Rename and change the macro to be a bit-mask so that
conversion is not needed anymore. No functional changes intended.

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
2.21.0

