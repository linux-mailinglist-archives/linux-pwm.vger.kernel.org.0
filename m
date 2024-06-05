Return-Path: <linux-pwm+bounces-2345-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B03F8FC1F8
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 04:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A781C228F4
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 02:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5936A008;
	Wed,  5 Jun 2024 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxxkW2vL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B961FE5;
	Wed,  5 Jun 2024 02:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717555501; cv=none; b=sKyxHQSHzwU93pk6VTIn+G/TVBM8DYcMTNNkZZXlxY7U4DN4cxFw03tWJ3Gxlm2lOckptZTqWGAJ5IkXQhX3/rF8SPbSaDsN/+yfuRB/LJ6rMi+xC3xR2DG+1HEG8L801kZbo1sKzMtuXAogjXtr0oFX/ejXWHEy1EMjTgbUTvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717555501; c=relaxed/simple;
	bh=jyCjgjjbSAhEovi0cCm4ccKk2T1mvw3REIlJ5GXry+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVcqb2eHYTWHdRjWA5S07Up0QTDYArsR92zcX3rKlPx6MJ0kDYy6J1e6y5IoX7NsoPjKs+W68mkLhRadqrZqZYePZ0ggT8fCEM718xjcLjb0g/PeHDdIX6LHu+VTHjy0baNBQk3zrlO34x976oozgwo+tb8Eg6XvvXLmoKRuOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxxkW2vL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80DDEC4AF07;
	Wed,  5 Jun 2024 02:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717555500;
	bh=jyCjgjjbSAhEovi0cCm4ccKk2T1mvw3REIlJ5GXry+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gxxkW2vLpRXd5EWX/sU9s4LyabNjHN6GD8eYbI28yz5Ds4wKH5Yl/IgLOAw9SkkXU
	 Tm2Aq242Urow7hmKE2CMZGiF++Q7wi8qoEFvdfHjKGVGlBTMJlwkBdjEp/K+HqIBy2
	 ydM5HVb4MGDEjoyvn3VMb7upfa7henlhDd83Err2qGNVo3bFTE8OSb4cXti2/cwDBl
	 jsDiFG1bpeOJfadQVkatiHpFcjiJ+B2Z4FKKkQ5+oLoTTsCIl/8b+iUyXuE7ENsG0w
	 /UzqkCsXDLyZLdUEp9Tni17oMiE7aF+gt3JduFwlMKEtKKpNyCKIf9LReOmLxSokJ6
	 /2MjTZtXDcI7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B748C27C5E;
	Wed,  5 Jun 2024 02:45:00 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Wed, 05 Jun 2024 10:44:55 +0800
Subject: [PATCH v7 1/2] pwm: meson: Add support for Amlogic S4 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-s4-pwm-v7-1-e822b271d7b0@amlogic.com>
References: <20240605-s4-pwm-v7-0-e822b271d7b0@amlogic.com>
In-Reply-To: <20240605-s4-pwm-v7-0-e822b271d7b0@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717555496; l=2138;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=PY1LLIlUoEaOvFEAiK0IUMl1TtUUL9kMLCoeJzffQ8s=;
 b=O3AHvuK3WmFNKLuTbYCYnQMWZjsI0xJhfK2Quo47JUGzgeNTjg8IqB5it1K0WOKPzh02VbzRs
 hyqZvrUF/TKCkHYHVAOnh1FYFmY/jadIYbIsTEeNXUFvQV8HZfz/wUi
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
 drivers/pwm/pwm-meson.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index b2f97dfb01bb..4f01847525b2 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -460,6 +460,34 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
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
+		if (IS_ERR(meson->channels[i].clk)) {
+			ret = PTR_ERR(meson->channels[i].clk);
+			dev_err_probe(dev, ret, "Failed to get clk\n");
+			return ret;
+		}
+		devm_add_action_or_reset(dev, meson_pwm_s4_put_clk,
+					 meson->channels[i].clk);
+	}
+
+	return 0;
+}
+
 static const struct meson_pwm_data pwm_meson8b_data = {
 	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
@@ -498,6 +526,10 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_v2,
 };
 
+static const struct meson_pwm_data pwm_s4_data = {
+	.channels_init = meson_pwm_init_channels_s4,
+};
+
 static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8-pwm-v2",
@@ -536,6 +568,10 @@ static const struct of_device_id meson_pwm_matches[] = {
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



