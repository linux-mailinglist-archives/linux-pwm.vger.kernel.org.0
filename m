Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE50F6DE4EE
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 21:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjDKT0j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Apr 2023 15:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKT0h (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2023 15:26:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B95B12B
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:26:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id s8so5236586wmo.0
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681241194; x=1683833194;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2IQ1M5BMFas/wX1eONZkvXXJkqyMTMp78nC08EBVyZc=;
        b=gIWTuhJlpBJDlZUymscknkzviuToH7Nnqiv7YnRTpAIhgf2PxOAEzAVq49IjAl2Ov8
         MuS3p6BtX/2etmDJbU2vcPkuVi9Bq/UGo59omDZTrG7177VGBgj0YOVv0dWl0guig3of
         0HEc9ph9i2WxEB3pjGZsbk+34tD6BZQalRWkFpXR8zqS0wUUL4ymMd0ah3jPlzdGEwD+
         /oDnd9cVwzGxLJFa44M/+GaJbZj7vMQOWuTzyzXhNKkPs6j7oycdEEWoTFibawiMK3Ph
         YvwnYba6aEuceTVlBmvDJhgmddYuLrVXUVW4rW+JDnPPzu2chTQQz08BoXiO1dr/4F6A
         XIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681241194; x=1683833194;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IQ1M5BMFas/wX1eONZkvXXJkqyMTMp78nC08EBVyZc=;
        b=KWcewNkvbazyfrYFyYKbCG1wmdO0JO/75hi2HTSYCt3CXVggVlHIgo83ld5FaDcdkv
         fsU8ONNvML7ey+isZTEAElvMSCoSy8j2q2aWURdWh85zq/aH1tskJ5ZPP0BXCNDM8cwD
         Ybx6EhFsh+MC7lszjrsUHRTro6QpClG6XZQsxwfJH3+saTqhLBJYPpwOefWZGsIO7qPX
         ++1oVZdlrNWu5TlQLoMcMInKJlCbg+GtjZaOp9Lu8Vt3lVRIpxh8mvktbSKlMh9q+RnO
         jUC+l+E2ptq+/Cg1nqDWCBCrhIH7sEYoV57boaHdlVsc5OipehfoePqWObTp9x7ngnWF
         Gtvg==
X-Gm-Message-State: AAQBX9dbeAADNW8FIfMGcCV4oaCjsYvAX0sR+H0hc1z8dHCy/7qTfP0m
        llbOu6Dcys5JMqJghOoIzXs=
X-Google-Smtp-Source: AKy350aFVdr29HDi8szE4pmFLAcT6lc7CfvJUtVkQOa5yHVWxDcOsRLrPcV/zDvURqNbUqoYWWiKjQ==
X-Received: by 2002:a05:600c:2214:b0:3eb:2e1e:beae with SMTP id z20-20020a05600c221400b003eb2e1ebeaemr7590680wml.25.1681241194561;
        Tue, 11 Apr 2023 12:26:34 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c4bb:c200:90e3:4731:63e4:d333? (dynamic-2a01-0c23-c4bb-c200-90e3-4731-63e4-d333.c23.pool.telefonica.de. [2a01:c23:c4bb:c200:90e3:4731:63e4:d333])
        by smtp.googlemail.com with ESMTPSA id s6-20020a5d4ec6000000b002efb6e0c495sm10593820wrv.91.2023.04.11.12.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 12:26:34 -0700 (PDT)
Message-ID: <cdb9253d-ae39-14a2-a112-d0615b1a9f3d@gmail.com>
Date:   Tue, 11 Apr 2023 21:24:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: [PATCH v2 3/4] pwm: meson: change clk/pwm gate from mask to bit
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
References: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com>
In-Reply-To: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Change single-bit values from mask to bit. This facilitates
CCF initialization for the clock gate in a follow-up patch.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 931cf14ca..f7595f81c 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -49,16 +49,16 @@
 #define PWM_HIGH_MASK		GENMASK(31, 16)
 
 #define REG_MISC_AB		0x8
-#define MISC_B_CLK_EN		BIT(23)
-#define MISC_A_CLK_EN		BIT(15)
+#define MISC_B_CLK_EN		23
+#define MISC_A_CLK_EN		15
 #define MISC_CLK_DIV_MASK	0x7f
 #define MISC_B_CLK_DIV_SHIFT	16
 #define MISC_A_CLK_DIV_SHIFT	8
 #define MISC_B_CLK_SEL_SHIFT	6
 #define MISC_A_CLK_SEL_SHIFT	4
 #define MISC_CLK_SEL_MASK	0x3
-#define MISC_B_EN		BIT(1)
-#define MISC_A_EN		BIT(0)
+#define MISC_B_EN		1
+#define MISC_A_EN		0
 
 #define MESON_NUM_PWMS		2
 #define MESON_MAX_MUX_PARENTS	4
@@ -67,22 +67,22 @@ static struct meson_pwm_channel_data {
 	u8		reg_offset;
 	u8		clk_sel_shift;
 	u8		clk_div_shift;
-	u32		clk_en_mask;
-	u32		pwm_en_mask;
+	u8		clk_en_bit;
+	u8		pwm_en_bit;
 } meson_pwm_per_channel_data[MESON_NUM_PWMS] = {
 	{
 		.reg_offset	= REG_PWM_A,
 		.clk_sel_shift	= MISC_A_CLK_SEL_SHIFT,
 		.clk_div_shift	= MISC_A_CLK_DIV_SHIFT,
-		.clk_en_mask	= MISC_A_CLK_EN,
-		.pwm_en_mask	= MISC_A_EN,
+		.clk_en_bit	= MISC_A_CLK_EN,
+		.pwm_en_bit	= MISC_A_EN,
 	},
 	{
 		.reg_offset	= REG_PWM_B,
 		.clk_sel_shift	= MISC_B_CLK_SEL_SHIFT,
 		.clk_div_shift	= MISC_B_CLK_DIV_SHIFT,
-		.clk_en_mask	= MISC_B_CLK_EN,
-		.pwm_en_mask	= MISC_B_EN,
+		.clk_en_bit	= MISC_B_CLK_EN,
+		.pwm_en_bit	= MISC_B_EN,
 	}
 };
 
@@ -231,7 +231,7 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 	value = readl(meson->base + REG_MISC_AB);
 	value &= ~(MISC_CLK_DIV_MASK << channel_data->clk_div_shift);
 	value |= channel->pre_div << channel_data->clk_div_shift;
-	value |= channel_data->clk_en_mask;
+	value |= BIT(channel_data->clk_en_bit);
 	writel(value, meson->base + REG_MISC_AB);
 
 	value = FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
@@ -239,7 +239,7 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 	writel(value, meson->base + channel_data->reg_offset);
 
 	value = readl(meson->base + REG_MISC_AB);
-	value |= channel_data->pwm_en_mask;
+	value |= BIT(channel_data->pwm_en_bit);
 	writel(value, meson->base + REG_MISC_AB);
 
 	spin_unlock_irqrestore(&meson->lock, flags);
@@ -253,7 +253,7 @@ static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
 	spin_lock_irqsave(&meson->lock, flags);
 
 	value = readl(meson->base + REG_MISC_AB);
-	value &= ~meson_pwm_per_channel_data[pwm->hwpwm].pwm_en_mask;
+	value &= ~BIT(meson_pwm_per_channel_data[pwm->hwpwm].pwm_en_bit);
 	writel(value, meson->base + REG_MISC_AB);
 
 	spin_unlock_irqrestore(&meson->lock, flags);
@@ -335,7 +335,7 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	value = readl(meson->base + REG_MISC_AB);
 
-	tmp = channel_data->pwm_en_mask | channel_data->clk_en_mask;
+	tmp = BIT(channel_data->pwm_en_bit) | BIT(channel_data->clk_en_bit);
 	state->enabled = (value & tmp) == tmp;
 
 	tmp = value >> channel_data->clk_div_shift;
-- 
2.40.0


