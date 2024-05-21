Return-Path: <linux-pwm+bounces-2201-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83FA8CA9FD
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 10:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B451C20A9E
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B91656448;
	Tue, 21 May 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx3PYm6S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3AF54F89;
	Tue, 21 May 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280318; cv=none; b=tVGxJsKYYdbFdVbMADG0T0E/CpBsFRHJ5cxcGXUa3dd9VBxSnm5rk+QFrGcEHPmmD8Za7Ud8M7QumlU91WphmIEJtY74T3OsRZdL9DszB8PCefzXuJPlzd5kwQhN/Sb0DIzcao0pP2DwaA6udODyGFWKMhFddseOEC/+9pa2inY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280318; c=relaxed/simple;
	bh=FvFfKXmL892C/19FVjh91A40ta7Bup2GELFyNP6Jycw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IzEtOEfCSZST7TY/OchbPZw7hlMZxmZ8s2NaYGCje8IW74mcy3STOZFzXG696gsgJzFFngssKpgKCuk1x4WbeY2DKX4E4xPWz4LNKqojzOPUCp0XC33noWrc8v5lVEsbrqCguzBUFgJUEV5RRXH13lUr8ZomkVd+6OAFqaeC/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx3PYm6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E74EC4AF07;
	Tue, 21 May 2024 08:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716280318;
	bh=FvFfKXmL892C/19FVjh91A40ta7Bup2GELFyNP6Jycw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bx3PYm6SGeIJCgWyRBd4NJFtPuc9zvFFTpshrrRhzpoMWryJgiflnH0ZXAaURqRrl
	 xFjlA9U7Yj2osmMIb5b1zohISb/fOmn1DNUAztFd50SM2/c7xmmWAMQNPS5xEHtbYV
	 Qw3WasyUuGb7lSwDCUvsMHbDrZ0o/jZAuEU5qc9tLYdhmDWR+60WeYlpJ8bl+bDk9Z
	 /kCtpSVQBmQXt3Q80Sdo7ZlCRIFpqSmEgU34q3jGW4UXDUSZIulvieG5on7FULVhS/
	 Oud7Ah9FPnsQ7AMwRdfin5r5nzaHMUO4k6tuys4/zjINhKQB3E+Jyube3+tkGDvO3k
	 bE3bA+eGEkNpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59678C25B78;
	Tue, 21 May 2024 08:31:58 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Tue, 21 May 2024 16:31:34 +0800
Subject: [PATCH v5 1/2] pwm: meson: Add support for Amlogic S4 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-s4-pwm-v5-1-0c91f5fa32cd@amlogic.com>
References: <20240521-s4-pwm-v5-0-0c91f5fa32cd@amlogic.com>
In-Reply-To: <20240521-s4-pwm-v5-0-0c91f5fa32cd@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716280316; l=2531;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=TO8jk1KfAyzCYn3EQLKzqT09OdAOiA4QmoDLOLbNW40=;
 b=5mmETv38pNe+0fspL2pwrWOlZHTqe3xBoP5S/HyPB3sSldBE+iqroQeEX7+lrj6B8K/8KMeGU
 b0igt5ehiIKBiBuNmWcxyEcow9PXSdNQWtU4PVQZpKlNYdMUHcpPyta
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Junyi Zhao <junyi.zhao@amlogic.com>

This patch adds support for Amlogic S4 PWM.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 drivers/pwm/pwm-meson.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index b2f97dfb01bb..9fea28a51921 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -460,6 +460,51 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
 	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
 }
 
+static void meson_pwm_s4_put_clk(void *data)
+{
+	int i;
+	struct meson_pwm *meson;
+	struct meson_pwm_channel *channel;
+
+	meson = (struct meson_pwm *)data;
+	for (i = 0; i < MESON_NUM_PWMS; i++) {
+		channel = &meson->channels[i];
+		clk_put(channel->clk);
+	}
+}
+
+static int meson_pwm_init_channels_meson_s4(struct pwm_chip *chip)
+{
+	int i, ret;
+	struct device *dev = pwmchip_parent(chip);
+	struct device_node *np = dev->of_node;
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel;
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
@@ -498,6 +543,10 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_v2,
 };
 
+static const struct meson_pwm_data pwm_meson_s4_data = {
+	.channels_init = meson_pwm_init_channels_meson_s4,
+};
+
 static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8-pwm-v2",
@@ -536,6 +585,10 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
 		.data = &pwm_g12a_ao_cd_data
 	},
+	{
+		.compatible = "amlogic,meson-s4-pwm",
+		.data = &pwm_meson_s4_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);

-- 
2.37.1



