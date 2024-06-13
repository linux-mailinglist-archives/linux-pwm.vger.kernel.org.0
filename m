Return-Path: <linux-pwm+bounces-2441-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A73C906C49
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2024 13:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113CE1C21A12
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2024 11:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F24A145FE0;
	Thu, 13 Jun 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWQznOZS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5C1145B29;
	Thu, 13 Jun 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279234; cv=none; b=Ko8JpJ1Os48jiRhg01S0zBCaH62Kir31Fkep/7wJokUi/JE82urUlGI/paykmiGWqDwzW1M5kxxxSOYYtziQYYyVPblnLoDNN47/nvJo0/oT5jCJUn492G9QA98KEo2C/FRul+Juk2YBKLdyvngaW2CYJ7VoOn6MtUZ+in0yxJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279234; c=relaxed/simple;
	bh=P9Nv2rPgkyI+rwI9+K/xy5zN9qQW0189/gZkEhjsAc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVr2BGfNrZD/zp1EyT6FC98fuk7qk8+ybk/myNZcf5ukMAYMmNC4yL3EH6lnaL2XB5ubJ7oVbIv/IBK6m1KfYda+uemMLnlMqhQJ+xpW+Zk0USY2xEZWmoNDvVQG48TlsIDlfqMCD3zf3Vlu30XslZWN1igw2PITVFVhJijz1LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWQznOZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D25FAC4AF1C;
	Thu, 13 Jun 2024 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718279233;
	bh=P9Nv2rPgkyI+rwI9+K/xy5zN9qQW0189/gZkEhjsAc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UWQznOZSzAxaB/69SwoQbOVV1SZMylhjYX8UlpXapkTCYDaYZ2CUe3NrXwekA3b9V
	 tGmGjRKjnkTMczrAccXJ6Ol/UybrgNCSTwbsApreReTm8dfmDmwQYgvf7X7QPU82gv
	 sdPYUGNsa0wIO/GSX4jBizVmiOQjXIROlbutwTzsMe+SrcC8z6l/1PcSbT6od3l6qN
	 XQUiW0vyotvGnXkSsVs6Scowe+UImPZTPpItfwz0sQwgtPmsVYkih2ZDKozVkNVy+I
	 Q7l4moI/7sI7ddurX1aeTzCW45/cOcNLuM57jCtjFDEHbbnXim0eI8rVfstUub+iQp
	 5p7f6BDj5rQoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE9DC27C79;
	Thu, 13 Jun 2024 11:47:13 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Thu, 13 Jun 2024 19:46:35 +0800
Subject: [PATCH v8 1/2] pwm: meson: Add support for Amlogic S4 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com>
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
In-Reply-To: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718279231; l=2242;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=dwmGsdqAEwQLKSoMsQIDCvsk9F7mUyX4lQiaMw6xB40=;
 b=PUnfZ4mzns+rxE0HtGPXEcYGpdRjcKqzUBEqN9+o9pLHDZtrkOzknLMkJy6Pm8l7A8vDYRg7E
 16ZoAfi0aG3C8LnJUQ8nrYtr4L3Zsy/ZbWEA+3a4QtgxKIaDCmvSR7w
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
 drivers/pwm/pwm-meson.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index b2f97dfb01bb..98e6c1533312 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -460,6 +460,37 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
 	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
 }
 
+static void meson_pwm_s4_put_clk(void *data)
+{
+	struct clk *clk = data;
+
+	clk_put(clk);
+}
+
+static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
+{
+	struct device *dev = pwmchip_parent(chip);
+	struct device_node *np = dev->of_node;
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	int i, ret;
+
+	for (i = 0; i < MESON_NUM_PWMS; i++) {
+		meson->channels[i].clk = of_clk_get(np, i);
+		if (IS_ERR(meson->channels[i].clk))
+			return dev_err_probe(dev,
+					     PTR_ERR(meson->channels[i].clk),
+					     "Failed to get clk\n");
+
+		ret = devm_add_action_or_reset(dev, meson_pwm_s4_put_clk,
+					       meson->channels[i].clk);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to add clk_put action\n");
+	}
+
+	return 0;
+}
+
 static const struct meson_pwm_data pwm_meson8b_data = {
 	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
@@ -498,6 +529,10 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_v2,
 };
 
+static const struct meson_pwm_data pwm_s4_data = {
+	.channels_init = meson_pwm_init_channels_s4,
+};
+
 static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8-pwm-v2",
@@ -536,6 +571,10 @@ static const struct of_device_id meson_pwm_matches[] = {
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



