Return-Path: <linux-pwm+bounces-242-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0977FD860
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 14:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F711C20BFE
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF1208B2;
	Wed, 29 Nov 2023 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aY+NgK5Z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A19194
	for <linux-pwm@vger.kernel.org>; Wed, 29 Nov 2023 05:40:34 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b30308c67so51442645e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 29 Nov 2023 05:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701265233; x=1701870033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0+vsbx15h8F7iZEWw3YAZV40GdDwQ9Lrg1zkM7+uXE=;
        b=aY+NgK5Z2G02arce5owTN1KWhw7LuQ7NTBgvCwJBRrYkhz+syWIkLGxeBe8wT/+T9J
         zjmFr6SKmA+Il7Yrfv42nSpZVQ3XGjFPauPzhxyJlIVWjC5SoT69VpEsylS0WUBUGzPI
         MnuQevrdRmB2DepcTvuWngFRJvypRdIh9PK7b40C87yF+ZG5ue9Ve6tnM7+ixMQMDjNM
         UchOROvT4veLJAC6HEa9dr4E5moxYKu92qv0uj5UL8Kar8ixigqKIpj32HujllvKj7n7
         N8/fd5AR+4h+oDs1kzmxvMPcI7LO9dHUA1ExZvbfEGKGsn7tOAZiDNwPl0LatdERmiZD
         I6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701265233; x=1701870033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0+vsbx15h8F7iZEWw3YAZV40GdDwQ9Lrg1zkM7+uXE=;
        b=Tp4UAe+LpQC4vR7gd9h2AWEVBn1DGXDEXbnjk+z492s2oGGv/jbIjrv4gifsWGgunJ
         ob5+7cF5QJMOzhCfVXNRX3f01IrHwev8vkO5r/12rdCs7yEjcg2mRutExqn/gXZMoCYL
         G4+Dl7ekq/AhCglGNIquKeB/z8zME/0nLKxFdzAAgEWHYKADxgr+lV5j/RNmaGOW3Kfi
         8LQZp/FpSdjOfOrfcsgH35N1fbMSlREPZ5aNpg2U1uUo8fjqW0dXJHDIxXkPD20hTl56
         +irBaIOqaznC6TGGN6YB4l2hDFBsmWMPDyKpVdIYik8Xqe4r5d1/1GXrf2viRFwJKONs
         eFlQ==
X-Gm-Message-State: AOJu0YzUG2ddqGQ/1exJb1kLh/E6qDARRuC+vEFqoPM3/vatZUeWZjoo
	433fuv/uCaro3T4pNKUQgMLjEQJFzoJ0HQas0OI=
X-Google-Smtp-Source: AGHT+IGO5xlQpc0pK/xpaBnA/MLmbOocAbg7CZOKArt+y0Fo/ijzvKHBYsC2K/wZmHK3aPfUBnObPA==
X-Received: by 2002:a05:600c:1d17:b0:401:eb0:a974 with SMTP id l23-20020a05600c1d1700b004010eb0a974mr15130701wms.3.1701265232916;
        Wed, 29 Nov 2023 05:40:32 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:6101:5529:fe2d:d7eb])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05600c475100b004080f0376a0sm2285860wmo.42.2023.11.29.05.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:40:32 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Thierry Reding <thierry.reding@gmail.com>,
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
	JunYi Zhao <junyi.zhao@amlogic.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 3/4] pwm: meson: prepare addition of new compatible types
Date: Wed, 29 Nov 2023 14:39:59 +0100
Message-ID: <20231129134004.3642121-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129134004.3642121-1-jbrunet@baylibre.com>
References: <20231129134004.3642121-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Clean the amlogic pwm driver to prepare the addition of new pwm compatibles
* Generalize 4 inputs clock per channel.
  AO pwm may just get 2 extra NULL entries which actually better
  describes the reality of the HW.
* Use driver data to carry the device data and remove pwm_chip from it
* Stop carrying the internal clock elements with the device data.
  These are not needed past init.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 150 +++++++++++++++++++++++-----------------
 1 file changed, 87 insertions(+), 63 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5bea53243ed2..5cbd65cae28a 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -60,7 +60,7 @@
 #define MISC_A_EN		BIT(0)
 
 #define MESON_NUM_PWMS		2
-#define MESON_MAX_MUX_PARENTS	4
+#define MESON_NUM_MUX_PARENTS	4
 
 static struct meson_pwm_channel_data {
 	u8		reg_offset;
@@ -90,19 +90,14 @@ struct meson_pwm_channel {
 	unsigned int hi;
 	unsigned int lo;
 
-	struct clk_mux mux;
-	struct clk_divider div;
-	struct clk_gate gate;
 	struct clk *clk;
 };
 
 struct meson_pwm_data {
 	const char * const *parent_names;
-	unsigned int num_parents;
 };
 
 struct meson_pwm {
-	struct pwm_chip chip;
 	const struct meson_pwm_data *data;
 	struct meson_pwm_channel channels[MESON_NUM_PWMS];
 	void __iomem *base;
@@ -115,7 +110,7 @@ struct meson_pwm {
 
 static inline struct meson_pwm *to_meson_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct meson_pwm, chip);
+	return dev_get_drvdata(chip->dev);
 }
 
 static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -147,6 +142,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
+	struct device *dev = pwm->chip->dev;
 	unsigned int cnt, duty_cnt;
 	unsigned long fin_freq;
 	u64 duty, period, freq;
@@ -169,19 +165,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 	fin_freq = clk_round_rate(channel->clk, freq);
 	if (fin_freq == 0) {
-		dev_err(meson->chip.dev, "invalid source clock frequency\n");
+		dev_err(dev, "invalid source clock frequency\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
+	dev_dbg(dev, "fin_freq: %lu Hz\n", fin_freq);
 
 	cnt = div_u64(fin_freq * period, NSEC_PER_SEC);
 	if (cnt > 0xffff) {
-		dev_err(meson->chip.dev, "unable to get period cnt\n");
+		dev_err(dev, "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "period=%llu cnt=%u\n", period, cnt);
+	dev_dbg(dev, "period=%llu cnt=%u\n", period, cnt);
 
 	if (duty == period) {
 		channel->hi = cnt;
@@ -192,7 +188,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	} else {
 		duty_cnt = div_u64(fin_freq * duty, NSEC_PER_SEC);
 
-		dev_dbg(meson->chip.dev, "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
+		dev_dbg(dev, "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
 
 		channel->hi = duty_cnt;
 		channel->lo = cnt - duty_cnt;
@@ -215,7 +211,7 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 
 	err = clk_set_rate(channel->clk, channel->rate);
 	if (err)
-		dev_err(meson->chip.dev, "setting clock rate failed\n");
+		dev_err(pwm->chip->dev, "setting clock rate failed\n");
 
 	spin_lock_irqsave(&meson->lock, flags);
 
@@ -343,7 +339,6 @@ static const char * const pwm_meson8b_parent_names[] = {
 
 static const struct meson_pwm_data pwm_meson8b_data = {
 	.parent_names = pwm_meson8b_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_meson8b_parent_names),
 };
 
 /*
@@ -351,12 +346,11 @@ static const struct meson_pwm_data pwm_meson8b_data = {
  * The last 2 are grounded
  */
 static const char * const pwm_gxbb_ao_parent_names[] = {
-	"xtal", "clk81"
+	"xtal", "clk81", NULL, NULL,
 };
 
 static const struct meson_pwm_data pwm_gxbb_ao_data = {
 	.parent_names = pwm_gxbb_ao_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_gxbb_ao_parent_names),
 };
 
 static const char * const pwm_axg_ee_parent_names[] = {
@@ -365,7 +359,6 @@ static const char * const pwm_axg_ee_parent_names[] = {
 
 static const struct meson_pwm_data pwm_axg_ee_data = {
 	.parent_names = pwm_axg_ee_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_axg_ee_parent_names),
 };
 
 static const char * const pwm_axg_ao_parent_names[] = {
@@ -374,7 +367,6 @@ static const char * const pwm_axg_ao_parent_names[] = {
 
 static const struct meson_pwm_data pwm_axg_ao_data = {
 	.parent_names = pwm_axg_ao_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
 };
 
 static const char * const pwm_g12a_ao_ab_parent_names[] = {
@@ -383,16 +375,14 @@ static const char * const pwm_g12a_ao_ab_parent_names[] = {
 
 static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
 	.parent_names = pwm_g12a_ao_ab_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_g12a_ao_ab_parent_names),
 };
 
 static const char * const pwm_g12a_ao_cd_parent_names[] = {
-	"xtal", "g12a_ao_clk81",
+	"xtal", "g12a_ao_clk81", NULL, NULL,
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
 	.parent_names = pwm_g12a_ao_cd_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_names),
 };
 
 static const struct of_device_id meson_pwm_matches[] = {
@@ -432,23 +422,25 @@ static const struct of_device_id meson_pwm_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
 
-static int meson_pwm_init_channels(struct meson_pwm *meson)
+static int meson_pwm_init_clocks_legacy(struct device *dev,
+					struct clk_parent_data *mux_parent_data)
 {
-	struct clk_parent_data mux_parent_data[MESON_MAX_MUX_PARENTS] = {};
-	struct device *dev = meson->chip.dev;
+	struct meson_pwm *meson = dev_get_drvdata(dev);
 	unsigned int i;
 	char name[255];
 	int err;
 
-	for (i = 0; i < meson->data->num_parents; i++) {
-		mux_parent_data[i].index = -1;
-		mux_parent_data[i].name = meson->data->parent_names[i];
-	}
-
-	for (i = 0; i < meson->chip.npwm; i++) {
+	for (i = 0; i < MESON_NUM_PWMS; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
 		struct clk_parent_data div_parent = {}, gate_parent = {};
 		struct clk_init_data init = {};
+		struct clk_divider *div;
+		struct clk_gate *gate;
+		struct clk_mux *mux;
+
+		mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+		if (!mux)
+			return -ENOMEM;
 
 		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
 
@@ -456,69 +448,76 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		init.ops = &clk_mux_ops;
 		init.flags = 0;
 		init.parent_data = mux_parent_data;
-		init.num_parents = meson->data->num_parents;
-
-		channel->mux.reg = meson->base + REG_MISC_AB;
-		channel->mux.shift =
-				meson_pwm_per_channel_data[i].clk_sel_shift;
-		channel->mux.mask = MISC_CLK_SEL_MASK;
-		channel->mux.flags = 0;
-		channel->mux.lock = &meson->lock;
-		channel->mux.table = NULL;
-		channel->mux.hw.init = &init;
-
-		err = devm_clk_hw_register(dev, &channel->mux.hw);
+		init.num_parents = MESON_NUM_MUX_PARENTS;
+
+		mux->reg = meson->base + REG_MISC_AB;
+		mux->shift = meson_pwm_per_channel_data[i].clk_sel_shift;
+		mux->mask = MISC_CLK_SEL_MASK;
+		mux->flags = 0;
+		mux->lock = &meson->lock;
+		mux->table = NULL;
+		mux->hw.init = &init;
+
+		err = devm_clk_hw_register(dev, &mux->hw);
 		if (err) {
 			dev_err(dev, "failed to register %s: %d\n", name, err);
 			return err;
 		}
 
+		div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
+		if (!div)
+			return -ENOMEM;
+
 		snprintf(name, sizeof(name), "%s#div%u", dev_name(dev), i);
 
 		init.name = name;
 		init.ops = &clk_divider_ops;
 		init.flags = CLK_SET_RATE_PARENT;
 		div_parent.index = -1;
-		div_parent.hw = &channel->mux.hw;
+		div_parent.hw = &mux->hw;
 		init.parent_data = &div_parent;
 		init.num_parents = 1;
 
-		channel->div.reg = meson->base + REG_MISC_AB;
-		channel->div.shift = meson_pwm_per_channel_data[i].clk_div_shift;
-		channel->div.width = MISC_CLK_DIV_WIDTH;
-		channel->div.hw.init = &init;
-		channel->div.flags = 0;
-		channel->div.lock = &meson->lock;
+		div->reg = meson->base + REG_MISC_AB;
+		div->shift = meson_pwm_per_channel_data[i].clk_div_shift;
+		div->width = MISC_CLK_DIV_WIDTH;
+		div->hw.init = &init;
+		div->flags = 0;
+		div->lock = &meson->lock;
 
-		err = devm_clk_hw_register(dev, &channel->div.hw);
+		err = devm_clk_hw_register(dev, &div->hw);
 		if (err) {
 			dev_err(dev, "failed to register %s: %d\n", name, err);
 			return err;
 		}
 
+		gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
+		if (!gate)
+			return -ENOMEM;
+
 		snprintf(name, sizeof(name), "%s#gate%u", dev_name(dev), i);
 
 		init.name = name;
 		init.ops = &clk_gate_ops;
 		init.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED;
 		gate_parent.index = -1;
-		gate_parent.hw = &channel->div.hw;
+		gate_parent.hw = &div->hw;
 		init.parent_data = &gate_parent;
 		init.num_parents = 1;
 
-		channel->gate.reg = meson->base + REG_MISC_AB;
-		channel->gate.bit_idx = meson_pwm_per_channel_data[i].clk_en_shift;
-		channel->gate.hw.init = &init;
-		channel->gate.flags = 0;
-		channel->gate.lock = &meson->lock;
+		gate->reg = meson->base + REG_MISC_AB;
+		gate->bit_idx = meson_pwm_per_channel_data[i].clk_en_shift;
+		gate->hw.init = &init;
+		gate->flags = 0;
+		gate->lock = &meson->lock;
 
-		err = devm_clk_hw_register(dev, &channel->gate.hw);
+		err = devm_clk_hw_register(dev, &gate->hw);
 		if (err) {
 			dev_err(dev, "failed to register %s: %d\n", name, err);
 			return err;
 		}
 
-		channel->clk = devm_clk_hw_get_clk(dev, &channel->gate.hw, NULL);
+		channel->clk = devm_clk_hw_get_clk(dev, &gate->hw, NULL);
 		if (IS_ERR(channel->clk)) {
 			err = PTR_ERR(channel->clk);
 			dev_err(dev, "failed to register %s: %d\n", name, err);
@@ -529,31 +528,56 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 	return 0;
 }
 
+static int meson_pwm_init_channels(struct device *dev)
+{
+	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
+	struct meson_pwm *meson = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < MESON_NUM_MUX_PARENTS; i++) {
+		mux_parent_data[i].index = -1;
+		mux_parent_data[i].name = meson->data->parent_names[i];
+	}
+
+	return meson_pwm_init_clocks_legacy(dev, mux_parent_data);
+}
+
 static int meson_pwm_probe(struct platform_device *pdev)
 {
 	struct meson_pwm *meson;
+	struct pwm_chip *chip;
 	int err;
 
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
 	meson = devm_kzalloc(&pdev->dev, sizeof(*meson), GFP_KERNEL);
 	if (!meson)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, meson);
+
 	meson->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(meson->base))
 		return PTR_ERR(meson->base);
 
 	spin_lock_init(&meson->lock);
-	meson->chip.dev = &pdev->dev;
-	meson->chip.ops = &meson_pwm_ops;
-	meson->chip.npwm = MESON_NUM_PWMS;
+	chip->dev = &pdev->dev;
+	chip->ops = &meson_pwm_ops;
+	chip->npwm = MESON_NUM_PWMS;
 
 	meson->data = of_device_get_match_data(&pdev->dev);
+	if (!meson->data) {
+		dev_err(&pdev->dev, "failed to match device\n");
+		return -ENODEV;
+	}
 
-	err = meson_pwm_init_channels(meson);
+	err = meson_pwm_init_channels(&pdev->dev);
 	if (err < 0)
 		return err;
 
-	err = devm_pwmchip_add(&pdev->dev, &meson->chip);
+	err = devm_pwmchip_add(&pdev->dev, chip);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", err);
 		return err;
-- 
2.42.0


