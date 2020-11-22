Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7FD2BFC7B
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Nov 2020 23:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKVWjj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 22 Nov 2020 17:39:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:33403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgKVWji (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 22 Nov 2020 17:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606084722;
        bh=57r1xFqwCJIDRPuJ/P+J2+bFfyswaMLpxJDG6pNT6Us=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=il21FU6NF3dQ4rt6xiuQbnpb4ct4m5PMoflxM5Wuy2FeerQEKr56SV1CUJV6VCG+3
         FTd6R44Z/tYqsBVuaZczEwSoGXUU0JCM3zSe6pe/T2N2to3641x3kbjr+asB/4A9Yx
         wAknJwZ6XnaXMATvFWoJ61RjMNPaGyD2NgYxIxew=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDEm-1jynY22wJk-00iAMf; Sun, 22
 Nov 2020 23:38:42 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 4/7] pwm: ntxec: Add driver for PWM function in Netronix EC
Date:   Sun, 22 Nov 2020 23:27:36 +0100
Message-Id: <20201122222739.1455132-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EE1AT1+Tqq9NOJEAKqjynManQRn7SWiapiXMkOZaDjPer7g1vLD
 +b7hMCkvGaVCfpS1E1m/QFWG61Fj7LvKlsV9H0K/IkFpAbkMPqBqDdhfPUzsP5NzpU5zD+g
 ho1KX0G+QSiz+XMieZQsWQrQVYIdcNH/mvQje10Sn8J1aWZ02d0KQGMP5rHtev4Iky8QO0Q
 2aiLHV3Pa3ggEuVEuISQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iFDVfCBf8eE=:4yNeNHof8H7GxJsk6MPrJc
 W/Dp9uZnYGIchuA2N8vPOvZufdQpfXya+qwEqWlfPNoQXVikNkaG1nloDGJ3EsxLUKeSF9+1m
 JbaFgbhFxcJxA8xbwx4W9yacR0OEfLQzO2QOroqC4jdo3tEOCXGfwnV2MCQLNaLfK87x54xWD
 rfOvBtyY/xplsst3xQnhedvr2Wz632vSOi+TWZ8EvBPGNi4AjuG9MK3QUbZcpz8TAkz75axEQ
 qHfZV+iBh9ZWjuH+262oMvkMVLO/z7v6AZdbiBVrQmtUtRrGVHFbvaMB6E1Cw7t0cPLQVLSCq
 gEKd9DbfGtlLNzEYTFc1rLSUp3QUOiHZh5/m5SZb+l2vmy0KA5CdlnG2x7fmBUu/MZ2J2AGRe
 eTj//sJx4h+thdavIhDiTXn6owNrs9/azXl+R9i2/Y8M+6URaZdehbgQxdppEMQBYMcsbTtW5
 bYhRIdTn7+S6VGtJ8quDKfkYtQfZcJHe6OZsLqrHD0AleR5xDuxCpSDWzV4lcNiRJfmu1uu+K
 B/kFIRWLgPyoOdhgDedfdj5bvOp9MvM3JdGnf3xgyo+1rpUkgfFeG22CBiYucmaM4iVsVcezX
 izAb/gO6tYwfuppCWUUjR5JRTxzz4iIXwfJrppNRpwK9r+O5WQymYMkNjsm2kFUhyAxod9yA1
 cdbtVe9YBUn9B1bISxGAS49CyvecEUi6YMI2PoK8P1+C8w/PdeoeRl+3wELJnHLO4RbzJ/cRV
 QtI1WMT3Ut3wAAbpGKP68fc62lEjmADX/vmbohQ10PLGzxpfVQ2kYv4j9cDp/jUGIN7n+oEFh
 tkXwOINAh4K3AvKyxWFjidypMcNi37LYos0sOUElC/JJgDKrEuBepyAAO4wkA9a8LOwNQCNOZ
 O60HONLsgD0UTcihTWKw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Netronix EC provides a PWM output which is used for the backlight
on some ebook readers. This patches adds a driver for the PWM output.

The .get_state callback is not implemented, because the PWM state can't
be read back from the hardware.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v4:
- Document hardware/driver limitations
- Only accept normal polarity
- Fix a typo ("zone" -> "zero")
- change MAX_PERIOD_NS to 0xffff * 125
- Clamp period to the maximum rather than returning an error
- Rename private struct pointer to priv
- Rearrage control flow in _probe to save a few lines and a temporary vari=
able
- Add missing MODULE_ALIAS line
- Spell out ODM

v3:
- https://lore.kernel.org/lkml/20200924192455.2484005-5-j.neuschaefer@gmx.=
net/
- Relicense as GPLv2 or later
- Add email address to copyright line
- Remove OF compatible string and don't include linux/of_device.h
- Fix bogus ?: in return line
- Don't use a comma after sentinels
- Avoid ret |=3D ... pattern
- Move 8-bit register conversion to ntxec.h

v2:
- https://lore.kernel.org/lkml/20200905133230.1014581-6-j.neuschaefer@gmx.=
net/
- Various grammar and style improvements, as suggested by Uwe Kleine-K=C3=
=B6nig,
  Lee Jones, and Alexandre Belloni
- Switch to regmap
- Prefix registers with NTXEC_REG_
- Add help text to the Kconfig option
- Use the .apply callback instead of the old API
- Add a #define for the time base (125ns)
- Don't change device state in .probe; this avoids multiple problems
- Rework division and overflow check logic to perform divisions in 32 bits
- Avoid setting duty cycle to zero, to work around a hardware quirk
=2D--
 drivers/pwm/Kconfig     |   8 ++
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-ntxec.c | 166 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 drivers/pwm/pwm-ntxec.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 63be5362fd3a5..815f329ed5b46 100644
=2D-- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -350,6 +350,14 @@ config PWM_MXS
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-mxs.

+config PWM_NTXEC
+	tristate "Netronix embedded controller PWM support"
+	depends on MFD_NTXEC
+	help
+	  Say yes here if you want to support the PWM output of the embedded
+	  controller found in certain e-book readers designed by the original
+	  design manufacturer Netronix.
+
 config PWM_OMAP_DMTIMER
 	tristate "OMAP Dual-Mode Timer PWM support"
 	depends on OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index cbdcd55d69eef..1deb29e6ae8e5 100644
=2D-- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
 obj-$(CONFIG_PWM_MTK_DISP)	+=3D pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
+obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
diff --git a/drivers/pwm/pwm-ntxec.c b/drivers/pwm/pwm-ntxec.c
new file mode 100644
index 0000000000000..4f4f736d71aba
=2D-- /dev/null
+++ b/drivers/pwm/pwm-ntxec.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The Netronix embedded controller is a microcontroller found in some
+ * e-book readers designed by the original design manufacturer Netronix, =
Inc.
+ * It contains RTC, battery monitoring, system power management, and PWM
+ * functionality.
+ *
+ * This driver implements PWM output.
+ *
+ * Copyright 2020 Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+ *
+ * Limitations:
+ * - The get_state callback is not implemented, because the current state=
 of
+ *   the PWM output can't be read back from the hardware.
+ * - The hardware can only generate normal polarity output.
+ */
+
+#include <linux/mfd/ntxec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+struct ntxec_pwm {
+	struct device *dev;
+	struct ntxec *ec;
+	struct pwm_chip chip;
+};
+
+static struct ntxec_pwm *pwmchip_to_priv(struct pwm_chip *chip)
+{
+	return container_of(chip, struct ntxec_pwm, chip);
+}
+
+#define NTXEC_REG_AUTO_OFF_HI	0xa1
+#define NTXEC_REG_AUTO_OFF_LO	0xa2
+#define NTXEC_REG_ENABLE	0xa3
+#define NTXEC_REG_PERIOD_LOW	0xa4
+#define NTXEC_REG_PERIOD_HIGH	0xa5
+#define NTXEC_REG_DUTY_LOW	0xa6
+#define NTXEC_REG_DUTY_HIGH	0xa7
+
+/*
+ * The time base used in the EC is 8MHz, or 125ns. Period and duty cycle =
are
+ * measured in this unit.
+ */
+#define TIME_BASE_NS 125
+
+/*
+ * The maximum input value (in nanoseconds) is determined by the time bas=
e and
+ * the range of the hardware registers that hold the converted value.
+ * It fits into 32 bits, so we can do our calculations in 32 bits as well=
.
+ */
+#define MAX_PERIOD_NS (TIME_BASE_NS * 0xffff)
+
+static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm_=
dev,
+			   const struct pwm_state *state)
+{
+	struct ntxec_pwm *priv =3D pwmchip_to_priv(pwm_dev->chip);
+	unsigned int duty =3D state->duty_cycle;
+	unsigned int period =3D state->period;
+	int res =3D 0;
+
+	if (state->polarity !=3D PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (period > MAX_PERIOD_NS) {
+		period =3D MAX_PERIOD_NS;
+
+		if (duty > period)
+			duty =3D period;
+	}
+
+	period /=3D TIME_BASE_NS;
+	duty /=3D TIME_BASE_NS;
+
+	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_PERIOD_HIGH, ntxec_reg8=
(period >> 8));
+	if (res)
+		return res;
+
+	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_PERIOD_LOW, ntxec_reg8(=
period));
+	if (res)
+		return res;
+
+	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_DUTY_HIGH, ntxec_reg8(d=
uty >> 8));
+	if (res)
+		return res;
+
+	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_DUTY_LOW, ntxec_reg8(du=
ty));
+	if (res)
+		return res;
+
+	/*
+	 * Writing a duty cycle of zero puts the device into a state where
+	 * writing a higher duty cycle doesn't result in the brightness that it
+	 * usually results in. This can be fixed by cycling the ENABLE register.
+	 *
+	 * As a workaround, write ENABLE=3D0 when the duty cycle is zero.
+	 */
+	if (state->enabled && duty !=3D 0) {
+		res =3D regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(1))=
;
+		if (res)
+			return res;
+
+		/* Disable the auto-off timer */
+		res =3D regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_reg=
8(0xff));
+		if (res)
+			return res;
+
+		return regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_reg8=
(0xff));
+	} else {
+		return regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(0));
+	}
+}
+
+static struct pwm_ops ntxec_pwm_ops =3D {
+	.apply =3D ntxec_pwm_apply,
+	.owner =3D THIS_MODULE,
+};
+
+static int ntxec_pwm_probe(struct platform_device *pdev)
+{
+	struct ntxec *ec =3D dev_get_drvdata(pdev->dev.parent);
+	struct ntxec_pwm *priv;
+	struct pwm_chip *chip;
+
+	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->ec =3D ec;
+	priv->dev =3D &pdev->dev;
+
+	platform_set_drvdata(pdev, priv);
+
+	chip =3D &priv->chip;
+	chip->dev =3D &pdev->dev;
+	chip->ops =3D &ntxec_pwm_ops;
+	chip->base =3D -1;
+	chip->npwm =3D 1;
+
+	return pwmchip_add(chip);
+}
+
+static int ntxec_pwm_remove(struct platform_device *pdev)
+{
+	struct ntxec_pwm *priv =3D platform_get_drvdata(pdev);
+	struct pwm_chip *chip =3D &priv->chip;
+
+	return pwmchip_remove(chip);
+}
+
+static struct platform_driver ntxec_pwm_driver =3D {
+	.driver =3D {
+		.name =3D "ntxec-pwm",
+	},
+	.probe =3D ntxec_pwm_probe,
+	.remove =3D ntxec_pwm_remove,
+};
+module_platform_driver(ntxec_pwm_driver);
+
+MODULE_AUTHOR("Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>");
+MODULE_DESCRIPTION("PWM driver for Netronix EC");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ntxec-pwm");
=2D-
2.29.2

