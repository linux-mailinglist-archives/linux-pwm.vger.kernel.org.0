Return-Path: <linux-pwm+bounces-1475-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE899854694
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CFC1C2129B
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796B2168D7;
	Wed, 14 Feb 2024 09:53:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FC316423
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904430; cv=none; b=Cf/4PeyMtA2Z1PxUGCWXamiv87j8Qy4T6FaiUvwosuHFRcJbstgifboaqBHzIhxGAVx+BAyg6G7Gi10mDTTg69G+0/LKKM9yEMtqkFCpTLdJbJ8+dQ//eps68wUV3LYgVgj8yccDbGJ+Df7qz4y4AD7iMWw7AmU5MNXO9T8NW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904430; c=relaxed/simple;
	bh=koAN/+/23sPZAVIjNYgBDfSOCZNuNAYktJbEIstyjSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eqx7HxflRHvJstgDnIwVfzO0MqjouQdj5WT5WK+2QgKYaAjCH6oStAclHVbvAwM+4BJgt21L1mla1MW1UE+uPDKU7YYaYKt6nvrnzozUEzkjs3BKNEdaQqEox9l3YNv6sVc5vKBEpO3Gt6rgr/qxXxDmdw7A2ksXEAaoP/dttpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-0004OA-3m; Wed, 14 Feb 2024 10:34:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-000f6Z-By; Wed, 14 Feb 2024 10:34:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-004Xzr-0a;
	Wed, 14 Feb 2024 10:34:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	James Clark <james.clark@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-pwm@vger.kernel.org,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Alexander Shiyan <shc_work@mail.ru>,
	Benson Leung <bleung@chromium.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	=?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Michael Walle <mwalle@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hammer Hsieh <hammerh0314@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Sean Anderson <sean.anderson@seco.com>,
	Michal Simek <michal.simek@amd.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <keescook@chromium.org>,
	Rob Herring <robh@kernel.org>
Cc: linux-doc@vger.kernel.org,
	kernel@pengutronix.de,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-mips@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v6 003/164] pwm: Provide pwmchip_alloc() function and a devm variant of it
Date: Wed, 14 Feb 2024 10:30:50 +0100
Message-ID:  <9577d6053a5a52536057dc8654ff567181c2da82.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6032; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=koAN/+/23sPZAVIjNYgBDfSOCZNuNAYktJbEIstyjSk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhOy3rMjR1GdjpQaPyoW0nJ56JzUO/rQmlQs ZBM0ZtEf82JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyITgAKCRCPgPtYfRL+ TicEB/0dPx8EojmTD1h+4X2160QdFmhEtr9DkNcgvD4MXbJwi2AR0WTiisK1rsmV+6tCkIK7tJ3 ia8xMZ3BnvofoSfLSnXkboz+RdVSIEA7BqEblHXS94KRpF0kJSfkChuZTlsOibS5ccdLl9keCDp Ln92glGKIspJhlUYHC5XJS/5WgVuJIs2zBZ0mj9ssy1fRc7GPSOATaja3kUzueYK4sFeE9sRycR zgSfTLZglcFmMVV6/V8gfK4IdkOlO88EBryyP7oNNXf0XhDmqRiBNvGBpkzOgQFt0cSSObTgx1d uKdMfoMhlp4iXIRqjo0TrOM/JN49b64qgWPy7mfDaS9UVtMr
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This function allocates a struct pwm_chip and driver data. Compared to
the status quo the split into pwm_chip and driver data is new, otherwise
it doesn't change anything relevant (yet).

The intention is that after all drivers are switched to use this
allocation function, its possible to add a struct device to struct
pwm_chip to properly track the latter's lifetime without touching all
drivers again. Proper lifetime tracking is a necessary precondition to
introduce character device support for PWMs (that implements atomic
setting and doesn't suffer from the sysfs overhead of the /sys/class/pwm
userspace support).

The new function pwmchip_priv() (obviously?) only works for chips
allocated with pwmchip_alloc().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 Documentation/driver-api/pwm.rst              | 11 ++--
 drivers/pwm/core.c                            | 58 +++++++++++++++++++
 include/linux/pwm.h                           | 22 +++++++
 4 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index c5f99d834ec5..e4df72c408d2 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -420,6 +420,7 @@ POWER
   devm_reboot_mode_unregister()
 
 PWM
+  devm_pwmchip_alloc()
   devm_pwmchip_add()
   devm_pwm_get()
   devm_fwnode_pwm_get()
diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index 3c28ccc4b611..b41b1c56477f 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -143,11 +143,12 @@ to implement the pwm_*() functions itself. This means that it's impossible
 to have multiple PWM drivers in the system. For this reason it's mandatory
 for new drivers to use the generic PWM framework.
 
-A new PWM controller/chip can be added using pwmchip_add() and removed
-again with pwmchip_remove(). pwmchip_add() takes a filled in struct
-pwm_chip as argument which provides a description of the PWM chip, the
-number of PWM devices provided by the chip and the chip-specific
-implementation of the supported PWM operations to the framework.
+A new PWM controller/chip can be allocated using pwmchip_alloc(), then
+registered using pwmchip_add() and removed again with pwmchip_remove(). To undo
+pwmchip_alloc() use pwmchip_put(). pwmchip_add() takes a filled in struct
+pwm_chip as argument which provides a description of the PWM chip, the number
+of PWM devices provided by the chip and the chip-specific implementation of the
+supported PWM operations to the framework.
 
 When implementing polarity support in a PWM driver, make sure to respect the
 signal conventions in the PWM framework. By definition, normal polarity
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 830a697826af..9fc6f4fa71d6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -454,6 +454,64 @@ of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
 }
 EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
 
+#define PWMCHIP_ALIGN ARCH_DMA_MINALIGN
+
+static void *pwmchip_priv(struct pwm_chip *chip)
+{
+	return (void *)chip + ALIGN(sizeof(*chip), PWMCHIP_ALIGN);
+}
+
+/* This is the counterpart to pwmchip_alloc */
+void pwmchip_put(struct pwm_chip *chip)
+{
+	kfree(chip);
+}
+EXPORT_SYMBOL_GPL(pwmchip_put);
+
+struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
+{
+	struct pwm_chip *chip;
+	size_t alloc_size;
+
+	alloc_size = size_add(ALIGN(sizeof(*chip), PWMCHIP_ALIGN), sizeof_priv);
+
+	chip = kzalloc(alloc_size, GFP_KERNEL);
+	if (!chip)
+		return ERR_PTR(-ENOMEM);
+
+	chip->dev = parent;
+	chip->npwm = npwm;
+
+	pwmchip_set_drvdata(chip, pwmchip_priv(chip));
+
+	return chip;
+}
+EXPORT_SYMBOL_GPL(pwmchip_alloc);
+
+static void devm_pwmchip_put(void *data)
+{
+	struct pwm_chip *chip = data;
+
+	pwmchip_put(chip);
+}
+
+struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
+{
+	struct pwm_chip *chip;
+	int ret;
+
+	chip = pwmchip_alloc(parent, npwm, sizeof_priv);
+	if (IS_ERR(chip))
+		return chip;
+
+	ret = devm_add_action_or_reset(parent, devm_pwmchip_put, chip);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return chip;
+}
+EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
+
 static void of_pwmchip_add(struct pwm_chip *chip)
 {
 	if (!pwmchip_parent(chip) || !pwmchip_parent(chip)->of_node)
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 29a7d9140f77..4a6568dfdf3f 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -403,6 +403,10 @@ static inline bool pwm_might_sleep(struct pwm_device *pwm)
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout);
 
+void pwmchip_put(struct pwm_chip *chip);
+struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv);
+struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv);
+
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner);
 #define pwmchip_add(chip) __pwmchip_add(chip, THIS_MODULE)
 void pwmchip_remove(struct pwm_chip *chip);
@@ -475,6 +479,24 @@ static inline int pwm_capture(struct pwm_device *pwm,
 	return -EINVAL;
 }
 
+static inline void pwmchip_put(struct pwm_chip *chip)
+{
+}
+
+static inline struct pwm_chip *pwmchip_alloc(struct device *parent,
+					     unsigned int npwm,
+					     size_t sizeof_priv)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline struct pwm_chip *devm_pwmchip_alloc(struct device *parent,
+						  unsigned int npwm,
+						  size_t sizeof_priv)
+{
+	return pwmchip_alloc(parent, npwm, sizeof_priv);
+}
+
 static inline int pwmchip_add(struct pwm_chip *chip)
 {
 	return -EINVAL;
-- 
2.43.0


