Return-Path: <linux-pwm+bounces-2282-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297E38D33E7
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 12:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1E71F220F6
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB7E17B42C;
	Wed, 29 May 2024 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omxfpRCS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FF317A938;
	Wed, 29 May 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976878; cv=none; b=pSox/dwK0HXeoeVMg1C/3OB0rAzOHGHnkjFs35m6wxKUpukEVL9QZHb8rJE9x28OQtzbEWciAyOn3QxNUH9HWiiT13JAaVf85M5w9i/mCKlLxOep026c9wZALmDSVMOED3eHgxVa/rDvjJhYXoC7XU4cLB+3UBzl1sgPg3HWRzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976878; c=relaxed/simple;
	bh=8ZKgQ6HDURS9lZbhYYRP1FlK44swQk44vF9iL4f8vjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iSr3eSyVuVNGL8OZHx3M59c5hGxXno0SXhG/uWJ5vp7CkzaJp6TKdOzCuS/1csGcUBZky29f6jE/5pKdJW2O5so24ZTKOXgVZ01/ubEYBQ11/OZC6yQOGtjS3xYizZ9JY5kDDILIcSZDEqeOKWgQMVJs421fK0dMKt1pz2WjWZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omxfpRCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B57EBC32786;
	Wed, 29 May 2024 10:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976877;
	bh=8ZKgQ6HDURS9lZbhYYRP1FlK44swQk44vF9iL4f8vjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=omxfpRCS+BoYU6p579+U4qWBBrimrfNMcdYqj6k0zG8ZD4dZiNo7tckkZrS6wqQs0
	 ZnBOVPh8hsXqB3hwX/mMzNliZyTNIG9nQ53fn+Xjw3BGfWeQol8DeKtBpc3/rEzu8P
	 V6EQe0oVeD8PZwjz17lIqvK36Eeg2s3Ykr2lwxghLhpEfROmg24at2q+VkEhbWl0fp
	 zIUBDGmTd4GnHRM0vuvLMCLg7Uaxn3WvzN72LWzQKw5DV3zyOsvUbgAojredWDHiGt
	 0JM2arRfjgerXzUFSfYNnRtv5yK3keQ+NYqJJhi3kouXZDWOviFkej2yL9KXLDQ1Gb
	 TEUJuZPB74R2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F917C27C44;
	Wed, 29 May 2024 10:01:17 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Wed, 29 May 2024 18:00:56 +0800
Subject: [PATCH v6 1/2] pwm: meson: Add support for Amlogic S4 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-s4-pwm-v6-1-270f63049f20@amlogic.com>
References: <20240529-s4-pwm-v6-0-270f63049f20@amlogic.com>
In-Reply-To: <20240529-s4-pwm-v6-0-270f63049f20@amlogic.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kelvin Zhang <kelvin.zhang@amlogic.com>, 
 Junyi Zhao <junyi.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716976876; l=2415;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=8sG15QArjOg32TnDx5atK6muQxwE/8zIMoEGBdYsNU0=;
 b=xckEUtXiz+UAPnFeNXgRskIwNtR3eYtZJMf1R5mGYu+oGQ25XoliidjORSerGwmAPGCZKySzh
 QUO2Eb4P9uqAfJg4F3jzq1qCFNq4Zqd7I+034OIQKrlVHJB1c27Jb/b
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Junyi Zhao <junyi.zhao@amlogic.com>

Add support for Amlogic S4 PWM.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 drivers/pwm/pwm-meson.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index b2f97dfb01bb..a513ebbb5666 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -460,6 +460,47 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
 	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
 }
 
+static void meson_pwm_s4_put_clk(void *data)
+{
+	struct meson_pwm *meson = (struct meson_pwm *)data;
+	int i;
+
+	for (i = 0; i < MESON_NUM_PWMS; i++)
+		clk_put(meson->channels[i].clk);
+}
+
+static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
+{
+	struct device *dev = pwmchip_parent(chip);
+	struct device_node *np = dev->of_node;
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel;
+	int i, ret;
+
+	for (i = 0; i < MESON_NUM_PWMS; i++) {
+		channel = &meson->channels[i];
+		channel->clk = of_clk_get(np, i);
+		if (IS_ERR(channel->clk)) {
+			ret = PTR_ERR(channel->clk);
+			dev_err_probe(dev, ret, "Failed to get clk\n");
+			goto err;
+		}
+	}
+	ret = devm_add_action_or_reset(dev, meson_pwm_s4_put_clk, meson);
+	if (ret)
+		return ret;
+
+	return 0;
+
+err:
+	while (--i >= 0) {
+		channel = &meson->channels[i];
+		clk_put(channel->clk);
+	}
+
+	return ret;
+}
+
 static const struct meson_pwm_data pwm_meson8b_data = {
 	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
@@ -498,6 +539,10 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_v2,
 };
 
+static const struct meson_pwm_data pwm_s4_data = {
+	.channels_init = meson_pwm_init_channels_s4,
+};
+
 static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8-pwm-v2",
@@ -536,6 +581,10 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
 		.data = &pwm_g12a_ao_cd_data
 	},
+	{
+		.compatible = "amlogic,meson-s4-pwm",
+		.data = &pwm_s4_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);

-- 
2.37.1



