Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE03DD8EE8
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 13:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390729AbfJPLGK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 07:06:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40785 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390722AbfJPLGJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 07:06:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id o28so4904663wro.7
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obeRTq+p1VlEmmeq++OfFHO7dhjYSvxZrhuu1WnJYuw=;
        b=o2j2Q4NVlZTp0Bw3tIasV1/Rxr6CRKQGAhQxlO4fmwR6tsCYKPlBRUqy4WGAGn6gZJ
         i+to/bZHE2fKPhZngH4pqYUZFhZFHvkcQsbVAynmS2mCKPJMFv9H1i6znH/snlIn0L2a
         z0ZrmsbmWuCKSak/LTQv0Y7b6vl0tT8BLDyRtNBxxt7B3Ntd/BSH/QtUgLOUdq1OB4Ut
         AhQU5CdUQrvqU4EdhYKjl4eHk+pVLUzC+xhQYFEqLlwBSseHoQ1zd1wrdExgJZ1nZrD/
         s8Nv13qfWlkSQfFs16NpbN97Dc+nthoPZdjvt7bN3fbwBD9pnL1wGohRGSaRgm5d1j7y
         HmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obeRTq+p1VlEmmeq++OfFHO7dhjYSvxZrhuu1WnJYuw=;
        b=lumiSatc0otCH9HdEQwdOFw09u2hzxEzvVqQvJWJpyX6giOw23EJZmsyoJUBSRP7Nl
         1gCyh6WxgDNgFDPumIy/Y4pHrIxrhHjx/FkXipkBUOER4ildhjtnWFBd9BVxR1R6MXSK
         jqDpBKCdZ+bLiqgNBJlBEAvLzkzF7X2E0FBC2TsQvLAfbbpW5/jsm2aiAqmAo42Oou18
         4+NjHw1D7fH5E49XvD6P+IAZf1z6WrJIaDc0VfS8u4cwdgbli4Si4sC9rQownrx+cC1V
         faf2lelrabGSoj5v/S/efvyp44rzWDeESvTgEI02UmBtY74rkKFMdQjiGzgLiRBo9ulk
         YYog==
X-Gm-Message-State: APjAAAWGtTyXnpl6mzlyozAVkK0dZvd2N5SKLB4FaUkSuXhFdmEG2+wo
        PatNRhXmE3Wu1xwFKosRbFI=
X-Google-Smtp-Source: APXvYqxvTdTPNk4JS+pZkqORxmHCchxIAiHaVEkCgx4TA/iMtjJp0zG8ug4zvezzN0TRWQEPZuraHw==
X-Received: by 2002:adf:a497:: with SMTP id g23mr2082189wrb.135.1571223966386;
        Wed, 16 Oct 2019 04:06:06 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id l11sm2179382wmh.34.2019.10.16.04.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 04:06:05 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2 1/3] pwm: stm32: Remove clutter from ternary operator
Date:   Wed, 16 Oct 2019 13:05:59 +0200
Message-Id: <20191016110601.1765415-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016110601.1765415-1-thierry.reding@gmail.com>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Remove usage of the ternary operator to assign values for register
fields. Instead, parameterize the register and field offset macros
and pass the index to them.

This removes clutter and improves readability.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-stm32.c          | 21 +++++++++------------
 include/linux/mfd/stm32-timers.h | 12 ++++--------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 9430b4cd383f..a5b323432d8c 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -493,20 +493,17 @@ static const struct pwm_ops stm32pwm_ops = {
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
 				    int index, int level, int filter)
 {
-	u32 bke = (index == 0) ? TIM_BDTR_BKE : TIM_BDTR_BK2E;
-	int shift = (index == 0) ? TIM_BDTR_BKF_SHIFT : TIM_BDTR_BK2F_SHIFT;
-	u32 mask = (index == 0) ? TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF
-				: TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
-	u32 bdtr = bke;
+	u32 shift = TIM_BDTR_BKF_SHIFT(index);
+	u32 bke = TIM_BDTR_BKE(index);
+	u32 bkp = TIM_BDTR_BKP(index);
+	u32 bkf = TIM_BDTR_BKF(index);
+	u32 mask = bkf | bkp | bke;
+	u32 bdtr;
 
-	/*
-	 * The both bits could be set since only one will be wrote
-	 * due to mask value.
-	 */
-	if (level)
-		bdtr |= TIM_BDTR_BKP | TIM_BDTR_BK2P;
+	bdtr = (filter & TIM_BDTR_BKF_MASK) << shift | bke;
 
-	bdtr |= (filter & TIM_BDTR_BKF_MASK) << shift;
+	if (level)
+		bdtr |= bkp;
 
 	regmap_update_bits(priv->regmap, TIM_BDTR, mask, bdtr);
 
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 067d14655c28..f8db83aedb2b 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -70,14 +70,11 @@
 #define TIM_CCER_CC4E	BIT(12)	/* Capt/Comp 4  out Ena    */
 #define TIM_CCER_CC4P	BIT(13)	/* Capt/Comp 4  Polarity   */
 #define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
-#define TIM_BDTR_BKE	BIT(12) /* Break input enable	   */
-#define TIM_BDTR_BKP	BIT(13) /* Break input polarity	   */
+#define TIM_BDTR_BKE(x)	BIT(12 + (x) * 12) /* Break input enable */
+#define TIM_BDTR_BKP(x)	BIT(13 + (x) * 12) /* Break input polarity */
 #define TIM_BDTR_AOE	BIT(14)	/* Automatic Output Enable */
 #define TIM_BDTR_MOE	BIT(15)	/* Main Output Enable      */
-#define TIM_BDTR_BKF	(BIT(16) | BIT(17) | BIT(18) | BIT(19))
-#define TIM_BDTR_BK2F	(BIT(20) | BIT(21) | BIT(22) | BIT(23))
-#define TIM_BDTR_BK2E	BIT(24) /* Break 2 input enable	   */
-#define TIM_BDTR_BK2P	BIT(25) /* Break 2 input polarity  */
+#define TIM_BDTR_BKF(x)	(0xf << (16 + (x) * 4))
 #define TIM_DCR_DBA	GENMASK(4, 0)	/* DMA base addr */
 #define TIM_DCR_DBL	GENMASK(12, 8)	/* DMA burst len */
 
@@ -87,8 +84,7 @@
 #define TIM_CR2_MMS2_SHIFT	20
 #define TIM_SMCR_TS_SHIFT	4
 #define TIM_BDTR_BKF_MASK	0xF
-#define TIM_BDTR_BKF_SHIFT	16
-#define TIM_BDTR_BK2F_SHIFT	20
+#define TIM_BDTR_BKF_SHIFT(x)	(16 + (x) * 4)
 
 enum stm32_timers_dmas {
 	STM32_TIMERS_DMA_CH1,
-- 
2.23.0

