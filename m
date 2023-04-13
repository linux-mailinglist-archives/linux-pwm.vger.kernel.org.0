Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D4A6E0694
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 07:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDMFzS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 01:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjDMFzR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 01:55:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9CE526C
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 22:55:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id q23so25073392ejz.3
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 22:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681365315; x=1683957315;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P54WqQ6ttxssfZnCLvERrSx5J7WBjwRUTax22UHoySE=;
        b=Yk6H84kSXPn6GUvL7iJ5Mlqx2REDU2PaQ3hycknlrUEAp+BcHSvsDad7QazANgMtTD
         Q0zC6iaX1ma4PgFW8pWd0w6fE6q00Yhm4AdkFhPjLbzfAEL7ikoeUocelGwS79M937or
         WxJH9PPRjO6FueaGwK+ifg48KXOfArWK5nf3ayDDlT7SZ0C0TskklrDC3qdXQdDaT6gf
         XM9n1f5uJX47rlJ5Jt3jp3OV4cKV8szOWSd1goQZ8h9QmV2v0Hjiu8yM4q0eOfEuDaYM
         9LFf7B7iRUx/fZhJ902FpL3gGdtvCb5+r/FUZLfVlvo64CBmuMMVZ1owcXE0k+k8VMbB
         n1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681365315; x=1683957315;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P54WqQ6ttxssfZnCLvERrSx5J7WBjwRUTax22UHoySE=;
        b=I+K97olSmYl+sESkD9Li2M6BE6EhyvU71F/jPu3F4oc+vsPTDMpExvAg9T3Chjfxk/
         axgWxQ8yGaECTcJDDbvej2Gci6ADaZKwDNPqp/4oyCvn1XLJunRWQOe/5qIIMDi4Jwfa
         exqUKY4CCkjJn2g8CiiDFnlCHFIOX0EtaDIRPFwsQR/MLIpngyylZNGK3CIdP6yUA+oN
         xfiIi1FwqmxRpOHqZgXbytRd/dx6QmbkslCPkYg1j/+LNJnsgeMDT5zkJFMnhjdpaE0s
         INf6MBO72Dpxu8UFFF2AT16vCCmuBrRxo78l51FyyMV+xlwjEBeokTJg2SHnh9B6Og4h
         apTQ==
X-Gm-Message-State: AAQBX9ezjFP2VjoNzmg0WsH7IzKqjSdONvTLl6zRTf6h4Hfl2+cdpFuZ
        2ju5uwH22AanGgj6n9jGuZw=
X-Google-Smtp-Source: AKy350anK3iDzZnssp0S6ENBBi2b8VkpkYa7umUO1HGP54vhv2rwjLvtrdokUEtipzY+yiWerTtqVg==
X-Received: by 2002:a17:906:70d1:b0:92d:145a:6115 with SMTP id g17-20020a17090670d100b0092d145a6115mr1897215ejk.38.1681365315256;
        Wed, 12 Apr 2023 22:55:15 -0700 (PDT)
Received: from ?IPV6:2a01:c22:738e:4400:9dd0:adc5:d6d8:61d8? (dynamic-2a01-0c22-738e-4400-9dd0-adc5-d6d8-61d8.c22.pool.telefonica.de. [2a01:c22:738e:4400:9dd0:adc5:d6d8:61d8])
        by smtp.googlemail.com with ESMTPSA id s5-20020a170906168500b0094d69608f5fsm414212ejd.97.2023.04.12.22.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 22:55:14 -0700 (PDT)
Message-ID: <4236e082-fd21-c393-dc75-ad6bb0533249@gmail.com>
Date:   Thu, 13 Apr 2023 07:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: [PATCH v4 3/4] pwm: meson: change clk/pwm gate from mask to bit
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
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
In-Reply-To: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
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

Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 2a86867c1..40a8709ff 100644
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


