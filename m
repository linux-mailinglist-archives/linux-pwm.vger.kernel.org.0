Return-Path: <linux-pwm+bounces-632-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BD381C8F8
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Dec 2023 12:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614AE28791E
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Dec 2023 11:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9711C6A5;
	Fri, 22 Dec 2023 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="neOxjvl7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B254182BF
	for <linux-pwm@vger.kernel.org>; Fri, 22 Dec 2023 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cc843af59fso20962331fa.0
        for <linux-pwm@vger.kernel.org>; Fri, 22 Dec 2023 03:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1703243847; x=1703848647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLdzLfSEEVamw81pFt4PJ3qeYp2a8WvdFrJ9tUWJ7PY=;
        b=neOxjvl7SApVKcjiDSNvSRbxKF521OAdn4A/DPLOr513S/vRiYFQ6w/+F2MsWfRRDf
         oiCxjAAVThEyS94OcLJ6xlca9QuT7LrEoGnm4fltIuQgjTa7OVWHimBLxvscf7skg4bG
         nKSiHR2maMYlTi353vyAATJVNQDop0wsiBpP6qtY9i/Zfzm1D41euuQGgBsloR/iHqka
         5ioqoVUDmfIAfziBXxq3V8Imuvvg8q3oP7a94Fp5Px1AO/U99Y87NZk+olIbU8ERN3O5
         3ufHMp3culX8PX7NFLEDj2JSL/8aZ/hazBNJGvUwtUpuI+TZ3FI35yQ4Kjk8o7uim0rg
         GEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703243847; x=1703848647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLdzLfSEEVamw81pFt4PJ3qeYp2a8WvdFrJ9tUWJ7PY=;
        b=Z0TWDLbskCELncs3JVLJMLtMi841q4MRFLgKwkbQ713UJifnHPfWNPNeTi4fp6ZVLt
         LvqAXAkIB3jrVWPaAAJvdHKHSuDBAhn/Tydcq5zSetvx5Vg8dQ8D2jGelK9qm6C3b8zV
         3ZxlZpZ56ETuhAd1tA3KAww55jvSx4aDV+tFuIb3QT+GMMzg/44ONPSZdoJzesmzASmY
         j6C4rEQeT4oUKKVNRQohFMvLbL1CM4wxspvgjCm9H79b8EmkTfSZU8Hgv0KWTtJME0V6
         42iB7TYw81amIKYx6pUV2NjPpp0ofR4vB762/gUN/4lwxIQGS0xBuuHiLUFlAcKS5Qr9
         CEnQ==
X-Gm-Message-State: AOJu0YzoVTwenrqBI/34gkifAw0ZBbhE8HoKbG2kA5OjCbHNmcZ/RrR8
	b0Zik9s9hW95W/AAZv9Cg1ngtocSMDYepQ==
X-Google-Smtp-Source: AGHT+IHF8QykG43zRtMmkctjbVuKLYsW7rfsMx5OwczXw8lbMFtHQDq4/lLUPm3DgBYBmQiLWpgdfQ==
X-Received: by 2002:a2e:2407:0:b0:2cc:2678:6d35 with SMTP id k7-20020a2e2407000000b002cc26786d35mr573523ljk.6.1703243846824;
        Fri, 22 Dec 2023 03:17:26 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:c099:e596:3179:b0fa])
        by smtp.googlemail.com with ESMTPSA id f8-20020adffcc8000000b003366b500047sm4054069wrs.50.2023.12.22.03.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:17:26 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	JunYi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH v4 6/6] pwm: meson: add generic compatible for meson8 to sm1
Date: Fri, 22 Dec 2023 12:16:54 +0100
Message-ID: <20231222111658.832167-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231222111658.832167-1-jbrunet@baylibre.com>
References: <20231222111658.832167-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Introduce a new compatible support in the Amlogic PWM driver.

The PWM HW is actually the same for all SoCs supported so far. A specific
compatible is needed only because the clock sources of the PWMs are
hard-coded in the driver.

It is better to have the clock source described in DT but this changes the
bindings so a new compatible must be introduced.

When all supported platform have migrated to the new compatible, support
for the legacy ones may be removed from the driver.

The addition of this new compatible makes the old ones obsolete, as
described in the DT documentation.

Adding a callback to setup the clock will also make it easier to add
support for the new PWM HW found in a1, s4, c3 and t7 SoC families.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 240 ++++++++++++++++++++++++----------------
 1 file changed, 143 insertions(+), 97 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index fb113bc8da29..9c0a8a6e4f48 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -95,6 +95,7 @@ struct meson_pwm_channel {
 
 struct meson_pwm_data {
 	const char * const *parent_names;
+	int (*channels_init)(struct device *dev);
 };
 
 struct meson_pwm {
@@ -333,108 +334,14 @@ static const struct pwm_ops meson_pwm_ops = {
 	.get_state = meson_pwm_get_state,
 };
 
-static const char * const pwm_meson8b_parent_names[] = {
-	"xtal", NULL, "fclk_div4", "fclk_div3"
-};
-
-static const struct meson_pwm_data pwm_meson8b_data = {
-	.parent_names = pwm_meson8b_parent_names,
-};
-
-/*
- * Only the 2 first inputs of the GXBB AO PWMs are valid
- * The last 2 are grounded
- */
-static const char * const pwm_gxbb_ao_parent_names[] = {
-	"xtal", "clk81", NULL, NULL,
-};
-
-static const struct meson_pwm_data pwm_gxbb_ao_data = {
-	.parent_names = pwm_gxbb_ao_parent_names,
-};
-
-static const char * const pwm_axg_ee_parent_names[] = {
-	"xtal", "fclk_div5", "fclk_div4", "fclk_div3"
-};
-
-static const struct meson_pwm_data pwm_axg_ee_data = {
-	.parent_names = pwm_axg_ee_parent_names,
-};
-
-static const char * const pwm_axg_ao_parent_names[] = {
-	"xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5"
-};
-
-static const struct meson_pwm_data pwm_axg_ao_data = {
-	.parent_names = pwm_axg_ao_parent_names,
-};
-
-static const char * const pwm_g12a_ao_ab_parent_names[] = {
-	"xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5"
-};
-
-static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
-	.parent_names = pwm_g12a_ao_ab_parent_names,
-};
-
-static const char * const pwm_g12a_ao_cd_parent_names[] = {
-	"xtal", "g12a_ao_clk81", NULL, NULL,
-};
-
-static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
-	.parent_names = pwm_g12a_ao_cd_parent_names,
-};
-
-static const struct of_device_id meson_pwm_matches[] = {
-	{
-		.compatible = "amlogic,meson8b-pwm",
-		.data = &pwm_meson8b_data
-	},
-	{
-		.compatible = "amlogic,meson-gxbb-pwm",
-		.data = &pwm_meson8b_data
-	},
-	{
-		.compatible = "amlogic,meson-gxbb-ao-pwm",
-		.data = &pwm_gxbb_ao_data
-	},
-	{
-		.compatible = "amlogic,meson-axg-ee-pwm",
-		.data = &pwm_axg_ee_data
-	},
-	{
-		.compatible = "amlogic,meson-axg-ao-pwm",
-		.data = &pwm_axg_ao_data
-	},
-	{
-		.compatible = "amlogic,meson-g12a-ee-pwm",
-		.data = &pwm_meson8b_data
-	},
-	{
-		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
-		.data = &pwm_g12a_ao_ab_data
-	},
-	{
-		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
-		.data = &pwm_g12a_ao_cd_data
-	},
-	{},
-};
-MODULE_DEVICE_TABLE(of, meson_pwm_matches);
-
-static int meson_pwm_init_channels(struct device *dev)
+static int meson_pwm_init_clocks_legacy(struct device *dev,
+					struct clk_parent_data *mux_parent_data)
 {
-	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
 	struct meson_pwm *meson = dev_get_drvdata(dev);
 	unsigned int i;
 	char name[255];
 	int err;
 
-	for (i = 0; i < MESON_NUM_MUX_PARENTS; i++) {
-		mux_parent_data[i].index = -1;
-		mux_parent_data[i].name = meson->data->parent_names[i];
-	}
-
 	for (i = 0; i < MESON_NUM_PWMS; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
 		struct clk_parent_data div_parent = {}, gate_parent = {};
@@ -527,6 +434,145 @@ static int meson_pwm_init_channels(struct device *dev)
 	return 0;
 }
 
+static int meson_pwm_init_channels_legacy(struct device *dev)
+{
+	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
+	struct meson_pwm *meson = dev_get_drvdata(dev);
+	int i;
+
+	dev_warn_once(dev, "using obsolete compatible, please consider updating dt\n");
+
+	for (i = 0; i < MESON_NUM_MUX_PARENTS; i++) {
+		mux_parent_data[i].index = -1;
+		mux_parent_data[i].name = meson->data->parent_names[i];
+	}
+
+	return meson_pwm_init_clocks_legacy(dev, mux_parent_data);
+}
+
+static int meson_pwm_init_channels_meson8b_v2(struct device *dev)
+{
+	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
+	int i;
+
+	/*
+	 * NOTE: Instead of relying on the hard coded names in the driver
+	 * as the legacy version, this relies on DT to provide the list of
+	 * clocks.
+	 * For once, using input numbers actually makes more sense than names.
+	 * Also DT requires clock-names to be explicitly ordered, so there is
+	 * no point bothering with clock names in this case.
+	 */
+	for (i = 0; i < MESON_NUM_MUX_PARENTS; i++)
+		mux_parent_data[i].index = i;
+
+	return meson_pwm_init_clocks_legacy(dev, mux_parent_data);
+}
+
+static const char * const pwm_meson8b_parent_names[] = {
+	"xtal", NULL, "fclk_div4", "fclk_div3"
+};
+
+static const struct meson_pwm_data pwm_meson8b_data = {
+	.parent_names = pwm_meson8b_parent_names,
+	.channels_init = meson_pwm_init_channels_legacy,
+};
+
+/*
+ * Only the 2 first inputs of the GXBB AO PWMs are valid
+ * The last 2 are grounded
+ */
+static const char * const pwm_gxbb_ao_parent_names[] = {
+	"xtal", "clk81", NULL, NULL,
+};
+
+static const struct meson_pwm_data pwm_gxbb_ao_data = {
+	.parent_names = pwm_gxbb_ao_parent_names,
+	.channels_init = meson_pwm_init_channels_legacy,
+};
+
+static const char * const pwm_axg_ee_parent_names[] = {
+	"xtal", "fclk_div5", "fclk_div4", "fclk_div3"
+};
+
+static const struct meson_pwm_data pwm_axg_ee_data = {
+	.parent_names = pwm_axg_ee_parent_names,
+	.channels_init = meson_pwm_init_channels_legacy,
+};
+
+static const char * const pwm_axg_ao_parent_names[] = {
+	"xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5"
+};
+
+static const struct meson_pwm_data pwm_axg_ao_data = {
+	.parent_names = pwm_axg_ao_parent_names,
+	.channels_init = meson_pwm_init_channels_legacy,
+};
+
+static const char * const pwm_g12a_ao_ab_parent_names[] = {
+	"xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5"
+};
+
+static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
+	.parent_names = pwm_g12a_ao_ab_parent_names,
+	.channels_init = meson_pwm_init_channels_legacy,
+};
+
+static const char * const pwm_g12a_ao_cd_parent_names[] = {
+	"xtal", "g12a_ao_clk81", NULL, NULL,
+};
+
+static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
+	.parent_names = pwm_g12a_ao_cd_parent_names,
+	.channels_init = meson_pwm_init_channels_legacy,
+};
+
+static const struct meson_pwm_data pwm_meson8_v2_data = {
+	.channels_init = meson_pwm_init_channels_meson8b_v2,
+};
+
+static const struct of_device_id meson_pwm_matches[] = {
+	{
+		.compatible = "amlogic,meson8-pwm-v2",
+		.data = &pwm_meson8_v2_data
+	},
+	/* The following compatibles are obsolete */
+	{
+		.compatible = "amlogic,meson8b-pwm",
+		.data = &pwm_meson8b_data
+	},
+	{
+		.compatible = "amlogic,meson-gxbb-pwm",
+		.data = &pwm_meson8b_data
+	},
+	{
+		.compatible = "amlogic,meson-gxbb-ao-pwm",
+		.data = &pwm_gxbb_ao_data
+	},
+	{
+		.compatible = "amlogic,meson-axg-ee-pwm",
+		.data = &pwm_axg_ee_data
+	},
+	{
+		.compatible = "amlogic,meson-axg-ao-pwm",
+		.data = &pwm_axg_ao_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ee-pwm",
+		.data = &pwm_meson8b_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
+		.data = &pwm_g12a_ao_ab_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
+		.data = &pwm_g12a_ao_cd_data
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, meson_pwm_matches);
+
 static int meson_pwm_probe(struct platform_device *pdev)
 {
 	struct meson_pwm *meson;
@@ -554,7 +600,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
 
 	meson->data = of_device_get_match_data(&pdev->dev);
 
-	err = meson_pwm_init_channels(&pdev->dev);
+	err = meson->data->channels_init(&pdev->dev);
 	if (err < 0)
 		return err;
 
-- 
2.42.0


