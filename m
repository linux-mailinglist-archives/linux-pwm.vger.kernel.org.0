Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C358225E829
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgIENwx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Sep 2020 09:52:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:39023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgIENg1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 5 Sep 2020 09:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599312876;
        bh=NYuBBLNYiGIhFA8o9V2DO+rgKTITXVswEb0z0J0XHbQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PZZAz0sWRcfz36991DP8m6xp3eKauhXE0K4YfzOn+5QIZBC90lhhZDJG1nKjqtzTK
         p6b+ujbvUAxEabLeXQbGQwXYQ51UjtfS+dAX+gVqZnVTNIA/Vx6DxkPcLbqTN9JWIO
         bfSOsbcnupi2poRxHd9JqGb9YfRvcgC5mu2txxSQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbRs-1kLjKk2AD0-00H3tl; Sat, 05
 Sep 2020 15:34:36 +0200
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 05/10] pwm: ntxec: Add driver for PWM function in Netronix EC
Date:   Sat,  5 Sep 2020 15:32:25 +0200
Message-Id: <20200905133230.1014581-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5pnqftFZLWVKcseh85w/XixgLxNOAvblrI3RkgnBGCnWbcUdOQO
 oR6pTp5i1i9KRv6AEMAEDIyzQAlJojtBLaPfURJpdu1/0ASyla0RXdIjvkOFjaP4sc3LlJ8
 xJh02xjBlZutvFYchDqsCsNhLQrB5vxUZosPqH6NoGqqqXBqmBv/M0bZA8KktA2q35/a5tA
 iCf1U3MUMlRq4AH+juyPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cf/EYcs42qM=:Litgd/tjvyuyvzxMu1YSS2
 fLvKl54JHoKIZ1yz5yGT8zsafFeUBLXMsLyAwwPQ1iOg4nVSfvmt1/RcORbHMgwrfAqvftoV9
 J3Yv+phuDNvr75ci2KGj/034Ok1MbTwUSHKWMfEaoMPvsV+Hof1cu/UU5FO5Po6MqsSYT02OE
 z7TDap1Uo+0ZPUXfuMJbvPdF7YCo64VWmWlv/MQOXS2/vSR0ZqEHNloPxnmSVTobSJEoXHIGu
 8zctdgQs0SkKbxtTJmv/uJi9cyOU5WzDd9udffMShAnOkV22w/nsBFX6Jg3pnZbkuqfb6eVlN
 83Uudbkx08QoY4ieXs3aVt9OSHylJnj7ggKBnUR0W5U5L6kZzaeies/ffCvqCiQYAfjnmvMHz
 Fq9WIAZxhjP92fvAddD8VfvvlF/oXgfmAj+1TYzPiT1lXU/fj1QeoFVZv9XMAqUWVprs7d0pb
 nwd5vaCf+SyTW5JtDFtp7y0uZaJf4+sWsce87DnLMCLYLA92Tqv2h025DjC3ZCusjxP2HjKa6
 3PLrghEwkGsbeerM+SeLDPmnbcO/Qw2mJteHVG6NJGaWr4iFa630RzEnDqvT0ZIaBzjLSB7kU
 KHzjYDh+UOcVPdf0Wx5P0dXKxIHOcY7Q6G0NGmd3OROAJtaD/pA66L2jXGnhWOTC+zrK5z9Kx
 klK8TreMmie5KAyJdgDimR4Xh2JmtWLR4fyggCzLNdzbPeTfC8VGbUFcJei54Lc6jcZ1N6LY/
 hsLpMLjbYCP58rM5Vz11THQEhvCV2eod5Ca1UlEROJMOHOgeGzeBRfmSVAy5hZwVl362qwVMN
 INdHDDqHMt3GDVgkeMqsCjwgq/IwsCqVZE+zRo84i6FvckQ1G5f5CZwb2odoH+mQS9Mpu6ZX4
 Gq7mqzj0j+DbEiCy0PGWN6TCnJHhpamvBffkkmuEH8/175wX62wfgZ6WDeDF5nVTL11n4igLK
 TrV4xWY/9TI3EgnZH8LSqXg51VnNGGMTqQWh31Vx/qVZVwPfGNV4Pez4ZEfRuNwI5R6j72NlF
 l3moxh8K5MQZ0OMKQ8MKONtT6nUs/AuR0E+LYhB3YDH6ixGDqas4WEK5C+xs58w0bQ3HELsG4
 mxnMPP8i793R3UI0OatXaaf+FdOMil+QGbReqxvY+JpvVD3fFjCYXAgXlf4GfxA0Dtd16uyVJ
 YfGjX3iscSx7JKYYXWJ/P2XBbIFkhtd4mTbN7g2SRNRbkh19ppqw7nwQ4vMJhzTnqDiVfKn2I
 c4kGV/RCiw6PquXi36muUXOT19y2In45ftIAsbQ==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Netronix EC provides a PWM output which is used for the backlight
on some ebook readers. This patches adds a driver for the PWM output.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
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
 drivers/pwm/pwm-ntxec.c | 160 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 drivers/pwm/pwm-ntxec.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 7dbcf6973d335..7fd17c6cda95e 100644
=2D-- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -350,6 +350,14 @@ config PWM_MXS
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-mxs.

+config PWM_NTXEC
+	tristate "Netronix embedded controller PWM support"
+	depends on MFD_NTXEC && OF
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
index 0000000000000..325ec0e8f1996
=2D-- /dev/null
+++ b/drivers/pwm/pwm-ntxec.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * The Netronix embedded controller is a microcontroller found in some
+ * e-book readers designed by the ODM Netronix, Inc. It contains RTC,
+ * battery monitoring, system power management, and PWM functionality.
+ *
+ * This driver implements PWM output.
+ *
+ * Copyright 2020 Jonathan Neusch=C3=A4fer
+ */
+
+#include <linux/mfd/ntxec.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
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
+/* Convert an 8-bit value into the correct format for writing into a regi=
ster */
+#define u8_to_reg(x) (((x) & 0xff) << 8)
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
+	res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_PERIOD_HIGH, u8_to_reg(=
period >> 8));
+	res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_PERIOD_LOW, u8_to_reg(p=
eriod));
+	res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_DUTY_HIGH, u8_to_reg(du=
ty >> 8));
+	res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_DUTY_LOW, u8_to_reg(dut=
y));
+
+	if (res < 0)
+		return -EIO;
+
+	/*
+	 * Writing a duty cycle of zone puts the device into a state where
+	 * writing a higher duty cycle doesn't result in the brightness that it
+	 * usually results in. This can be fixed by cycling the ENABLE register.
+	 *
+	 * As a workaround, write ENABLE=3D0 when the duty cycle is zero.
+	 */
+	if (state->enabled && duty !=3D 0) {
+		res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE, u8_to_reg(1));
+
+		/* Disable the auto-off timer */
+		res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_AUTO_OFF_HI, u8_to_reg=
(0xff));
+		res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_AUTO_OFF_LO, u8_to_reg=
(0xff));
+		return res ? -EIO : 0;
+	} else {
+		return regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE, u8_to_reg(0));
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
+	return (res < 0) ? -EIO : 0;
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
+static const struct of_device_id ntxec_pwm_of_match[] =3D {
+	{ .compatible =3D "netronix,ntxec-pwm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ntxec_pwm_of_match);
+
+static struct platform_driver ntxec_pwm_driver =3D {
+	.driver =3D {
+		.name =3D "ntxec-pwm",
+		.of_match_table =3D ntxec_pwm_of_match,
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

