Return-Path: <linux-pwm+bounces-4104-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F35719D262B
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 13:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893F51F246C2
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E271CC8A4;
	Tue, 19 Nov 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="R5PSAdov"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E411384BF;
	Tue, 19 Nov 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020810; cv=none; b=ZQF4ZcLQGJCKzEOK/XoyAsdLUNOq2Rs2vLyNFNvppx36QKXpwN8TQ8DQknlP98lAaB0WPa5hFxEXyq0x5bZhBV0LDNh+5oGwkLiB5EeM2h0VzRcTQRZdYPxWS4MbuUeKpX9g9tZnWoB3N4peDhffoDdfhyYUWy9C5VBA2zyFtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020810; c=relaxed/simple;
	bh=HGVc0BSZb/iEX/jxb8xKy3ph8RAoQfK6m2PObgvtDEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thVqV9GWMsYC4whKtAT7gXDhgTZUKKrDjeLN2rtm7B3mLCNdGC2Yk9Yz7nb+oezyasmtFiYG60Q3aap6/czF6evkk//kbEFANGqpaTnFRMSYlclYwLLMxtBoQq11YXIN0qp3y5eSReYeVrHE+VqecbvMNeoD8kAqsg84kq8dNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=R5PSAdov; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A21A810000C;
	Tue, 19 Nov 2024 15:53:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A21A810000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1732020806;
	bh=1R5Vb+1wmqkDhu3Kp45r3skkS1SI4xzSwU+hBpSaVk4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=R5PSAdovCbpFfnssn2pjZNSC2evkp9fVEwuOQ467iguUUo4CE1jC6UgcQGHqTOuUp
	 Jc+d4e/4gRB2bzLz/sF5Q35lUnor0NDEJYs48VGHpdSCo5KyPnAdyrhmtHfXrwgqBE
	 Vx9i79YAG7uYoZPOsqU8FOhhbXTM4kflLT7seWz4+e2WJW316rgHp5mthLPcoTOpco
	 j24xwdkfQcYbKPzAtvBvgnSqMZH+5W9UIaWc89w1TQsRLVqj7ncIvzI0jw9vhvhvjX
	 AZGdPtfMiiPmQWYrOB7EWVwPd9m5vyJMOROuvzprpVP/5xVUO29vAJm8CfxYgr6qer
	 OLqH6SUigiCdw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Nov 2024 15:53:26 +0300 (MSK)
From: George Stark <gnstark@salutedevices.com>
To: <ukleinek@kernel.org>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v3 2/4] pwm: meson: Support constant and polarity bits
Date: Tue, 19 Nov 2024 15:53:16 +0300
Message-ID: <20241119125318.3492261-3-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241119125318.3492261-1-gnstark@salutedevices.com>
References: <20241119125318.3492261-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189267 [Nov 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/19 08:41:00 #26886618
X-KSMG-AntiVirus-Status: Clean, skipped

Newer meson PWM IPs support constant and polarity bits. Support them to
correctly implement constant and inverted output levels.

Using constant bit allows to have truly stable low or high output level.
Since hi and low regs internally increment its values by 1 just writing
zero to any of them gives 1 clock count impulse. If constant bit is set
zero value in hi and low regs is not incremented.

Using polarity bit instead of swapping hi and low reg values allows to
correctly identify inversion in .get_state().

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/pwm/pwm-meson.c | 61 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index c4ee019ce577..d7335efa3db7 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -6,7 +6,7 @@
  * PWM output is achieved by calculating a clock that permits calculating
  * two periods (low and high). The counter then has to be set to switch after
  * N cycles for the first half period.
- * The hardware has no "polarity" setting. This driver reverses the period
+ * Partly the hardware has no "polarity" setting. This driver reverses the period
  * cycles (the low length is inverted with the high length) for
  * PWM_POLARITY_INVERSED. This means that .get_state cannot read the polarity
  * from the hardware.
@@ -56,6 +56,10 @@
 #define MISC_B_CLK_SEL_SHIFT	6
 #define MISC_A_CLK_SEL_SHIFT	4
 #define MISC_CLK_SEL_MASK	0x3
+#define MISC_B_CONSTANT_EN	BIT(29)
+#define MISC_A_CONSTANT_EN	BIT(28)
+#define MISC_B_INVERT_EN	BIT(27)
+#define MISC_A_INVERT_EN	BIT(26)
 #define MISC_B_EN		BIT(1)
 #define MISC_A_EN		BIT(0)
 
@@ -68,6 +72,8 @@ static struct meson_pwm_channel_data {
 	u8		clk_div_shift;
 	u8		clk_en_shift;
 	u32		pwm_en_mask;
+	u32		const_en_mask;
+	u32		inv_en_mask;
 } meson_pwm_per_channel_data[MESON_NUM_PWMS] = {
 	{
 		.reg_offset	= REG_PWM_A,
@@ -75,6 +81,8 @@ static struct meson_pwm_channel_data {
 		.clk_div_shift	= MISC_A_CLK_DIV_SHIFT,
 		.clk_en_shift	= MISC_A_CLK_EN_SHIFT,
 		.pwm_en_mask	= MISC_A_EN,
+		.const_en_mask	= MISC_A_CONSTANT_EN,
+		.inv_en_mask	= MISC_A_INVERT_EN,
 	},
 	{
 		.reg_offset	= REG_PWM_B,
@@ -82,6 +90,8 @@ static struct meson_pwm_channel_data {
 		.clk_div_shift	= MISC_B_CLK_DIV_SHIFT,
 		.clk_en_shift	= MISC_B_CLK_EN_SHIFT,
 		.pwm_en_mask	= MISC_B_EN,
+		.const_en_mask	= MISC_B_CONSTANT_EN,
+		.inv_en_mask	= MISC_B_INVERT_EN,
 	}
 };
 
@@ -89,6 +99,8 @@ struct meson_pwm_channel {
 	unsigned long rate;
 	unsigned int hi;
 	unsigned int lo;
+	bool constant;
+	bool inverted;
 
 	struct clk_mux mux;
 	struct clk_divider div;
@@ -99,6 +111,8 @@ struct meson_pwm_channel {
 struct meson_pwm_data {
 	const char *const parent_names[MESON_NUM_MUX_PARENTS];
 	int (*channels_init)(struct pwm_chip *chip);
+	bool has_constant;
+	bool has_polarity;
 };
 
 struct meson_pwm {
@@ -160,7 +174,7 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Fixing this needs some care however as some machines might rely on
 	 * this.
 	 */
-	if (state->polarity == PWM_POLARITY_INVERSED)
+	if (state->polarity == PWM_POLARITY_INVERSED && !meson->data->has_polarity)
 		duty = period - duty;
 
 	freq = div64_u64(NSEC_PER_SEC * 0xffffULL, period);
@@ -187,9 +201,11 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (duty == period) {
 		channel->hi = cnt;
 		channel->lo = 0;
+		channel->constant = true;
 	} else if (duty == 0) {
 		channel->hi = 0;
 		channel->lo = cnt;
+		channel->constant = true;
 	} else {
 		duty_cnt = mul_u64_u64_div_u64(fin_freq, duty, NSEC_PER_SEC);
 
@@ -197,6 +213,7 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		channel->hi = duty_cnt;
 		channel->lo = cnt - duty_cnt;
+		channel->constant = false;
 	}
 
 	channel->rate = fin_freq;
@@ -227,6 +244,19 @@ static void meson_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	value = readl(meson->base + REG_MISC_AB);
 	value |= channel_data->pwm_en_mask;
+
+	if (meson->data->has_constant) {
+		value &= ~channel_data->const_en_mask;
+		if (channel->constant)
+			value |= channel_data->const_en_mask;
+	}
+
+	if (meson->data->has_polarity) {
+		value &= ~channel_data->inv_en_mask;
+		if (channel->inverted)
+			value |= channel_data->inv_en_mask;
+	}
+
 	writel(value, meson->base + REG_MISC_AB);
 
 	spin_unlock_irqrestore(&meson->lock, flags);
@@ -235,13 +265,24 @@ static void meson_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void meson_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
+	struct meson_pwm_channel_data *channel_data;
 	unsigned long flags;
 	u32 value;
 
+	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
+
 	spin_lock_irqsave(&meson->lock, flags);
 
 	value = readl(meson->base + REG_MISC_AB);
-	value &= ~meson_pwm_per_channel_data[pwm->hwpwm].pwm_en_mask;
+	value &= ~channel_data->pwm_en_mask;
+
+	if (meson->data->has_polarity) {
+		value &= ~channel_data->inv_en_mask;
+		if (channel->inverted)
+			value |= channel_data->inv_en_mask;
+	}
+
 	writel(value, meson->base + REG_MISC_AB);
 
 	spin_unlock_irqrestore(&meson->lock, flags);
@@ -254,10 +295,12 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	int err = 0;
 
+	channel->inverted = (state->polarity == PWM_POLARITY_INVERSED);
+
 	if (!state->enabled) {
-		if (state->polarity == PWM_POLARITY_INVERSED) {
+		if (channel->inverted && !meson->data->has_polarity) {
 			/*
-			 * This IP block revision doesn't have an "always high"
+			 * Some of IP block revisions don't have an "always high"
 			 * setting which we can use for "inverted disabled".
 			 * Instead we achieve this by setting mux parent with
 			 * highest rate and minimum divider value, resulting
@@ -271,6 +314,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			channel->rate = ULONG_MAX;
 			channel->hi = ~0;
 			channel->lo = 0;
+			channel->constant = true;
 
 			meson_pwm_enable(chip, pwm);
 		} else {
@@ -317,6 +361,11 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	value = readl(meson->base + REG_MISC_AB);
 	state->enabled = value & channel_data->pwm_en_mask;
 
+	if (meson->data->has_polarity && (value & channel_data->inv_en_mask))
+		state->polarity = PWM_POLARITY_INVERSED;
+	else
+		state->polarity = PWM_POLARITY_NORMAL;
+
 	value = readl(meson->base + channel_data->reg_offset);
 	lo = FIELD_GET(PWM_LOW_MASK, value);
 	hi = FIELD_GET(PWM_HIGH_MASK, value);
@@ -324,8 +373,6 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->period = meson_pwm_cnt_to_ns(chip, pwm, lo + hi);
 	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, hi);
 
-	state->polarity = PWM_POLARITY_NORMAL;
-
 	return 0;
 }
 
-- 
2.25.1


