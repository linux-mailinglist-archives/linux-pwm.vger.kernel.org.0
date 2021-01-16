Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F44A2F8F51
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Jan 2021 21:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbhAPU4f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 16 Jan 2021 15:56:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:57627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbhAPU4N (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 16 Jan 2021 15:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610830430;
        bh=CNBRA+c+NY/9LumPB+UY4n0iAV9NlGywmp537B5vKd8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KiJ+6HQi0sh/5TcrGBksGevwJEAa39i2VCGib66pvYjsdlC1QSDp7m2NPRGzToIAM
         hRBYh2rB4z6qo7ACn12LzjY+QB7goGWLUZxkaZh5IT5MX2l9JJ4rq1t8xxefHDbxXP
         TXzEQ8M0WJLnihZ7FiqWA4OCyM23fnyPSeaI37Vo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpf3-1llXGr29q3-00mHL8; Sat, 16
 Jan 2021 21:53:50 +0100
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
Subject: [PATCH v8 4/7] pwm: ntxec: Add driver for PWM function in Netronix EC
Date:   Sat, 16 Jan 2021 20:48:23 +0100
Message-Id: <20210116194826.3866540-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210116194826.3866540-1-j.neuschaefer@gmx.net>
References: <20210116194826.3866540-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sR0d3iqo8IyQZSTjKPwyjcol376hsZD6Y/nteZGtp/f6UWwNUfn
 4UICbrr4QpIG3aUq8auyoRBckRdFWzg+sG8RFmnf/0IxP0wmoA4tZQemZ3dsqgqRW2o14fi
 I8aPDY+ijTb03qU1koS3VASpaAYb9qphVjur4vq1H/OCvWUKlPl1P8mlfoW4Gkt8UtlTQc0
 2dScoDyVg8xEv1vdcz3uQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AL4DOgyui78=:C8UVbU7Z4sDYtGu3aOjPpN
 LhHzT6kWMYSxJmRm7ED8GJa4yamikvi9OZvM6HqXVGSjxd8klRRQ3UjKpwI7PPz8eSYuI5hMs
 sH95aVzKWor6v8tRAU0CUusoSw7lu0U8PtRqWjqUITQ9o7/7QPbxuPxrlPCcXmSJ8Fsj5t3L8
 PQ5ltcEcl+GCQ65CfeG0o3dcCyT2cVgLKhVJQ6vFAVlKH2BO2xnWbmTntA9lDI1eyGWL4GmuX
 qjTQ/ukymFL/lGJbDa81sBb33g2xm5TcfRos3pYFxCtWD9DS3QiuFyv0kvEyQ0Mz0SODsNv3k
 TJsJWqZAZ78jpFTxWfijoV3UfS9w1/vLkCXK0A4Rrm6C2N7aax9FxCfzAjQs2L6hGTu50bLTA
 XZS8QcmroRmEXos4eyvcxywaBslyAFZGuecbo744IXakFXBXXyzl1O4Y16/B/JDpEH1etr5uN
 IhDAsFBWzKQsPekso8RiEgvj5D56bbYlTKnYmp40Oh46tETIRZ1olBYdlo2vY/5+nDgETP3QF
 /7MBPn5j/+1+vd49QCmYppNGQ02Uap1HQxkB3f3/7OSFt/v6mObTiQGtNi06mPhiWKrzha4iC
 xpmDhqUz5SFPNHVN3jpqAJLb3NK8JgUFEQ3urPDACNr9GVDVtJblQKD/qekLQlxmOLavRBbs8
 Xq13UPa+UXeG9QhnAW8mh0zl8GFPQudJH1zF+ahpgcMh6GcWEHiJNxHPb7S9/kFWacPDImWbA
 5Ruc85iPSIssEHyZSOnbaMCf2yQGaQZd/EUOqcoMA2ufSXwNb3BoGeXY23Of57lVhtsTpKjIC
 WiTfA+uEbj5/ozndy6Ey2oScDOFndEQ08nsUkSO4KV2sPM5qD/0hz/8zGqLN/ulULkcgNFPvM
 JYZLgX/6k+PzfFSnuqcQ==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Netronix EC provides a PWM output which is used for the backlight
on some ebook readers. This patches adds a driver for the PWM output.

The .get_state callback is not implemented, because the PWM state can't
be read back from the hardware.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
=2D--
v8:
- Add Uwe Kleine-K=C3=B6nig's R-b tag
- Copy dev.of_node from parent device

v7:
- no changes

v6:
- https://lore.kernel.org/lkml/20201208011000.3060239-5-j.neuschaefer@gmx.=
net/
- Move period / duty cycle setting code to a function
- Rename pwmchip_to_priv to ntxec_pwm_from_chip
- Set period and duty cycle only before enabling the output
- Mention that duty=3D0, enable=3D1 is assumed not to happen
- Interleave writes to the period and duty cycle registers, to minimize th=
e
  window of time that an inconsistent state is configured

v5:
- https://lore.kernel.org/lkml/20201201011513.1627028-5-j.neuschaefer@gmx.=
net/
- Avoid truncation of period and duty cycle to 32 bits
- Make ntxec_pwm_ops const
- Use regmap_multi_reg_write
- Add comment about get_state to ntxec_pwm_ops
- Add comments about non-atomicity of (period, duty cycle) update

v4:
- https://lore.kernel.org/lkml/20201122222739.1455132-5-j.neuschaefer@gmx.=
net/
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
 drivers/pwm/pwm-ntxec.c | 184 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/pwm/pwm-ntxec.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0937e1c047acb..a2830b8832b97 100644
=2D-- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -393,6 +393,14 @@ config PWM_MXS
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
index 18b89d7fd092a..7d97eb595bbef 100644
=2D-- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
 obj-$(CONFIG_PWM_MTK_DISP)	+=3D pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
+obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
diff --git a/drivers/pwm/pwm-ntxec.c b/drivers/pwm/pwm-ntxec.c
new file mode 100644
index 0000000000000..50c454c553c46
=2D-- /dev/null
+++ b/drivers/pwm/pwm-ntxec.c
@@ -0,0 +1,184 @@
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
+ * - The period and duty cycle can't be changed together in one atomic ac=
tion.
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
+static struct ntxec_pwm *ntxec_pwm_from_chip(struct pwm_chip *chip)
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
+static int ntxec_pwm_set_raw_period_and_duty_cycle(struct pwm_chip *chip,
+						   int period, int duty)
+{
+	struct ntxec_pwm *priv =3D ntxec_pwm_from_chip(chip);
+
+	/*
+	 * Changes to the period and duty cycle take effect as soon as the
+	 * corresponding low byte is written, so the hardware may be configured
+	 * to an inconsistent state after the period is written and before the
+	 * duty cycle is fully written. If, in such a case, the old duty cycle
+	 * is longer than the new period, the EC may output 100% for a moment.
+	 *
+	 * To minimize the time between the changes to period and duty cycle
+	 * taking effect, the writes are interleaved.
+	 */
+
+	struct reg_sequence regs[] =3D {
+		{ NTXEC_REG_PERIOD_HIGH, ntxec_reg8(period >> 8) },
+		{ NTXEC_REG_DUTY_HIGH, ntxec_reg8(duty >> 8) },
+		{ NTXEC_REG_PERIOD_LOW, ntxec_reg8(period) },
+		{ NTXEC_REG_DUTY_LOW, ntxec_reg8(duty) },
+	};
+
+	return regmap_multi_reg_write(priv->ec->regmap, regs, ARRAY_SIZE(regs));
+}
+
+static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm_=
dev,
+			   const struct pwm_state *state)
+{
+	struct ntxec_pwm *priv =3D ntxec_pwm_from_chip(chip);
+	unsigned int period, duty;
+	int res;
+
+	if (state->polarity !=3D PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	period =3D min_t(u64, state->period, MAX_PERIOD_NS);
+	duty   =3D min_t(u64, state->duty_cycle, period);
+
+	period /=3D TIME_BASE_NS;
+	duty   /=3D TIME_BASE_NS;
+
+	/*
+	 * Writing a duty cycle of zero puts the device into a state where
+	 * writing a higher duty cycle doesn't result in the brightness that it
+	 * usually results in. This can be fixed by cycling the ENABLE register.
+	 *
+	 * As a workaround, write ENABLE=3D0 when the duty cycle is zero.
+	 * The case that something has previously set the duty cycle to zero
+	 * but ENABLE=3D1, is not handled.
+	 */
+	if (state->enabled && duty !=3D 0) {
+		res =3D ntxec_pwm_set_raw_period_and_duty_cycle(chip, period, duty);
+		if (res)
+			return res;
+
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
+static const struct pwm_ops ntxec_pwm_ops =3D {
+	.owner =3D THIS_MODULE,
+	.apply =3D ntxec_pwm_apply,
+	/*
+	 * No .get_state callback, because the current state cannot be read
+	 * back from the hardware.
+	 */
+};
+
+static int ntxec_pwm_probe(struct platform_device *pdev)
+{
+	struct ntxec *ec =3D dev_get_drvdata(pdev->dev.parent);
+	struct ntxec_pwm *priv;
+	struct pwm_chip *chip;
+
+	pdev->dev.of_node =3D pdev->dev.parent->of_node;
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

