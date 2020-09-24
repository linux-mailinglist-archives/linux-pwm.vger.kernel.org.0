Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9ACC27794A
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 21:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgIXT1e (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 15:27:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:39661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbgIXT1e (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 24 Sep 2020 15:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600975615;
        bh=kPZl/L/V+lSOt6mdHEUfQyfNZV+P9p8a2y5WBNQYGEY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CnuJOq1PXtORLWkaiIZ4QmI99dW2FHYWzW06NlKEat5l5gU2bNrFlwTdbcdomeOQZ
         XsoiyuPtx3Te0JCEZDVplBzV/JD/bJ33Z+rmnYZcxGVO4zER+PJLJsaCzbzI447Bos
         tGA9z8CeZsRUD7pTNBG/ywaKY2lxIkY5gpstQAdM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt79F-1kb0RK27mT-00tSos; Thu, 24
 Sep 2020 21:26:55 +0200
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
Subject: [PATCH v3 4/7] pwm: ntxec: Add driver for PWM function in Netronix EC
Date:   Thu, 24 Sep 2020 21:24:52 +0200
Message-Id: <20200924192455.2484005-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mA3DG95xvQs2E54phiN9UBrtsp5UQWCBcYtK0cDi5xTJIhrE7ca
 vOEVh1mJnsGPvkFa0F5MikCjzc8AwjM4UI8W8Vmgrxyu8QJiYq/N7gvynIzFtFChzWaruhW
 ZBXLRIYiD57d7jEONSAXLmkBXa2WEHh32mKgHDZlItmSli1saRUm0NiQPmmforFMoZBX94V
 ZZYKSV0uM/rfexOlRbbRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WYsN+KbUPa4=:n/AuxUCEn0gediIuwxzYTw
 IU9V261xJuG28lzmMETl5WXmTtBlhHN96Lhs8K9w90KnbEBbPo6tbcR93PH3Jnbb9NOvAgRRG
 +hfcPwwbHwrp7y6G0fdNkLKOA6xNvxnOQTCcULB4//6Hfq/Nq/PcGmKR/qweowraNOr12dtXt
 ZNbEg6iuTe7iHgBn0y1yDzx10Pc39Ty3fqjBvtTzW0pypGWfqF9ct8w1UjrlbdBFVrUK5DxgZ
 aQ5AMkl5I+SptjFFab/T88CR2+cQvbVzjIAljsZYaW1wcGCKhUi+NhA8e4Ni185gmdbeem8FB
 Xmp0lId9WZbioquUhvDNcrznEdN8SyEwFcOas1chAPRLASKtNdy+S+Gz7vzSG3AqId0vuJskT
 QZ260hFBnHQmkkXsF2/wJi5hiplr20SIH+BIBp7HYIohnDAlorkpnlMd87fNSMX49ajllRhuh
 AOGtZxCutuWTVbE5f2t0PtbxLAehn6VCXy29GDXBFShlT8/+mMk7unb6oidFJxGUuxAGdeW9G
 gD8bbfGm8zGqhExrqtoTQ8TrsLwrlkD7PDE7yPI94EWYY3YdG88p+opZkJEehytnbvPahUe2+
 wa7SeDmv5n86l3mtmzK7+307h3VwiDI3XRSFTgMVlbQGs7Mfvk94Tih/M5AFJ1MXdqLIycWZA
 kZvU9ujSi+PLjOSFTQ/kdV94S0pJnoyfpgsS0ahXh2UotQHwJt9dwxbfFEcvhi1XW9qVWorIJ
 K+xfz5HLm23fPTB3DkVWfuEx8c+67hXBfyebxYIYQbKMbh+R1dviJsLjsXFt01mHxleoHlP77
 hLVcMoI41UCm4OmI/j5obNsdRLhY14nCOJeF5biRLRb+eQowd34ruNN1kgA9DL8TnUToBn7U4
 IFnSnAU1F38j7SO7Nv1nD3T97MEFGlN63AyFejPVcqPuWeXTEBG3j3VuFzzOAipR85AfGKlsh
 wuHpaJWaS9eO4VbeUW1CD9xbQyMAHa7AJupqmJ2GYiqUaXaKf1B9Eg39NuSVh7EMjXTWeqGie
 kxtQ2iHCNW/rPdBol56kwQlr6W/dwCKspCH1o7B/kxcrWbXMNvwiCXYTnp9g4i//F2yYxi/JN
 esFXVvfjvTqK8DcZVcjY4xXjKbiZWN53q6aI8WFEfJI4Sfuq/WO7vM+HStH/TJTUsKQzM8NwR
 4MhvoS9qbDMYH5kHwGsjPAvWUtNFgup0toUdvGuJdJXrM9uQBeIpnWg2i+gWn0sfUCmvblTKx
 5QUG/ARAZkqs6C5QIIchQ026KIvxFLSLFDXK5bw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Netronix EC provides a PWM output which is used for the backlight
on some ebook readers. This patches adds a driver for the PWM output.

The .get_state callback is not implemented, because the PWM state can't
be read back from the hardware.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v3:
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
 drivers/pwm/pwm-ntxec.c | 161 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 drivers/pwm/pwm-ntxec.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 7dbcf6973d335..530dfda38d65e 100644
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
+	  controller found in certain e-book readers designed by the ODM
+	  Netronix.
+
 config PWM_OMAP_DMTIMER
 	tristate "OMAP Dual-Mode Timer PWM support"
 	depends on OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 2c2ba0a035577..1cc50dba22d1b 100644
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
index 0000000000000..50da2dc14bb03
=2D-- /dev/null
+++ b/drivers/pwm/pwm-ntxec.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The Netronix embedded controller is a microcontroller found in some
+ * e-book readers designed by the ODM Netronix, Inc. It contains RTC,
+ * battery monitoring, system power management, and PWM functionality.
+ *
+ * This driver implements PWM output.
+ *
+ * Copyright 2020 Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
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
+static struct ntxec_pwm *pwmchip_to_pwm(struct pwm_chip *chip)
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
+#define MAX_PERIOD_NS (TIME_BASE_NS * 0x10000 - 1)
+
+static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm_=
dev,
+			   const struct pwm_state *state)
+{
+	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(pwm_dev->chip);
+	unsigned int duty =3D state->duty_cycle;
+	unsigned int period =3D state->period;
+	int res =3D 0;
+
+	if (period > MAX_PERIOD_NS) {
+		dev_warn(pwm->dev,
+			 "Period is not representable in 16 bits after division by %u: %u\n",
+			 TIME_BASE_NS, period);
+		return -ERANGE;
+	}
+
+	period /=3D TIME_BASE_NS;
+	duty /=3D TIME_BASE_NS;
+
+	res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_PERIOD_HIGH, ntxec_reg8(=
period >> 8));
+	if (res)
+		return res;
+
+	res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_PERIOD_LOW, ntxec_reg8(p=
eriod));
+	if (res)
+		return res;
+
+	res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_DUTY_HIGH, ntxec_reg8(du=
ty >> 8));
+	if (res)
+		return res;
+
+	res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_DUTY_LOW, ntxec_reg8(dut=
y));
+	if (res)
+		return res;
+
+	/*
+	 * Writing a duty cycle of zone puts the device into a state where
+	 * writing a higher duty cycle doesn't result in the brightness that it
+	 * usually results in. This can be fixed by cycling the ENABLE register.
+	 *
+	 * As a workaround, write ENABLE=3D0 when the duty cycle is zero.
+	 */
+	if (state->enabled && duty !=3D 0) {
+		res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(1));
+		if (res)
+			return res;
+
+		/* Disable the auto-off timer */
+		res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_reg8=
(0xff));
+		if (res)
+			return res;
+
+		return regmap_write(pwm->ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_reg8(=
0xff));
+	} else {
+		return regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(0));
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
+	struct ntxec_pwm *pwm;
+	struct pwm_chip *chip;
+	int res;
+
+	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	pwm->ec =3D ec;
+	pwm->dev =3D &pdev->dev;
+
+	chip =3D &pwm->chip;
+	chip->dev =3D &pdev->dev;
+	chip->ops =3D &ntxec_pwm_ops;
+	chip->base =3D -1;
+	chip->npwm =3D 1;
+
+	res =3D pwmchip_add(chip);
+	if (res < 0)
+		return res;
+
+	platform_set_drvdata(pdev, pwm);
+
+	return 0;
+}
+
+static int ntxec_pwm_remove(struct platform_device *pdev)
+{
+	struct ntxec_pwm *pwm =3D platform_get_drvdata(pdev);
+	struct pwm_chip *chip =3D &pwm->chip;
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
=2D-
2.28.0

