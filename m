Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C23202713
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 00:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgFTWnV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 18:43:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:46107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbgFTWnU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592692957;
        bh=SdBTcHanE6ZbSETuw4jjAPlmlGZ23qUH4Z8rV7FhLqQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YxTuL3n+V481rorkdamPXRDikXiZ4sMt+CjKxF7N/98UoosFo6tpOzlGWFGEWX8LQ
         FrAgzp+7ELpv2f3k2RR5PgS5R1JGO7IZDTFM43JWT9mCYGGt8pEr2Gf4fw/nUtyMQ2
         Q+DpRzkhb3wal/Nxdl4tv8ABsVmOslJKe86GEpyQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1jDiUW2ILp-00Zk6L; Sun, 21
 Jun 2020 00:42:37 +0200
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
        Andreas Kemnade <andreas@kemnade.info>
Subject: [RFC PATCH 06/10] pwm: ntxec: Add driver for PWM function in Netronix EC
Date:   Sun, 21 Jun 2020 00:42:17 +0200
Message-Id: <20200620224222.1312520-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eUueW2vxa2QRAe4bcVFkBFTG7+5ALMF64PP7ISg/TUL89veAYiC
 zNUGbINCeiB6/qRtz4KAMnR3JUw7xGXKew+ZBUrBM10Q0UeTbHaaKg3U1aQSCDiw7aJ75Za
 BBGTWP6sb28uRrD0BeaGVgXJeGRFse0w/cyOUT9B79R1CPGIMv/z+IPZ0GlEQrMP7b2QryO
 ZibNSqbrHPhHazAKutaLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PnzBkUcOKAY=:V/ttZBJ1+lucSMD75nMnsM
 NcaH7eRcrfkSiMMtNRhBRb6dlxCaJNWhZcOHwJE4pvBxci7QR13NHaI5rVXfJKKRKipsRueQr
 pu+xkoqWqQQWc8MlcQlssPJHG7Lwp6w8J6FSyG3ADFOfyz9Mn2ojGY4JWyJ6yAKVRAOy5rfUf
 4lqBNnCswq7wBvemfMX6tz0+N1NkFLcrm6bFGEDe06ZIhD85zKWQo2pDWEairDkxk8YTQ3ngd
 uXeWAeHAP6nziJ3D3URuKszcZc1YipjlrcKNybiM/LMKL6iqg8JvHCGRQNZPeGtuF0Smq8zw/
 9fn0zfYMLuu7bFTzUgHXpDQwcH+0olIbLlXTLIdZIOJEYokEyRxZdXe9uBOXx+9FUriGIzI6v
 7wIC73OJU43mjtR7t9iPn0I+dVW8vFbnMllgBkqUvHA0puZhbjkkueXoJUDOvkZNWacAvpKMK
 6brbCfpeI7ev3ItssXpNBpZj0HgX2pC/bmYQAdxLuvjR/qt/7l1iC/uzGcgX8vFM3xFC8+ZnG
 coYL7eTXJ7Y8WAn5wKSab5t/KhscnJFOslx8clj3k3Q1wjZQib1Zt7nLs981UHZQQGq+9M5Ej
 bJSlZiKjmcJvhc4HMb0tRsAhvqcRl7ZAEw3KuIJLlrrZGhYcGwIZt7lRfOG7dwL0Bf3DlYOkz
 xNFunhlzcgHK0YudeDBnlZYRW2I6ta2niX90haz+Ey2NilqYpqASSfhOoDyruBIS8R5Nk2jFo
 pYyscau9KBBCnfFkJ7fU45z+F99AAzH8p19xLqSJfLKwCsJvlxng3889fpOL8TVKXo0x/da8k
 lxoUu18wG6+D14kTz+Z1nOM0t23I+vFXkDOXPuQD80LLBO840c/djV/zHu+wU6JcMqw+KFRn0
 0u65/B84cQqih5Yx8a7xOtriEWAhHpfv3ZHeI9JMTHH8M1k/NP0DL+8Km0UzXzk6JeQVW7knk
 jF5oAgSsPW/zIMcGLkZ9AEOFE8yT9a5TIbt3DR0psuqpGDr5PZE02aIsPJsD/7vDGTrvak8Vf
 tZUl7nvsY4ZTUEAFNuqt3IYNu5iW72E7hUUc0uNnWlL5roX0EbiAvzwUd4xq8xY2dXGLylqf1
 ihgWpydBZJmc7tNGYNVVnq7qR/TXMrVcC/N33Cm5PT/0FSFUyAcP+iNDzoK/AHvRF8vo5KIM0
 Z3i9Evmup2f6fATU3TCUE57JimLZ8AQ+egNfAs8lJZyQdojNsC4jM97SsQ1pjQyDwg4uxzE6K
 P28bc+lylSvUrFUxi
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Netronix EC provides a PWM output, which is used for the backlight
on ebook readers. This patches adds a driver for the PWM output.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/pwm/Kconfig     |   4 ++
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-ntxec.c | 148 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 drivers/pwm/pwm-ntxec.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index cb8d739067d2f..147d6629e662c 100644
=2D-- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -350,6 +350,10 @@ config PWM_MXS
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-mxs.

+config PWM_NTXEC
+	tristate "Netronix embedded controller PWM support"
+	depends on MFD_NTXEC && OF
+
 config PWM_OMAP_DMTIMER
 	tristate "OMAP Dual-Mode Timer PWM support"
 	depends on OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index a59c710e98c76..15507a6d9ca12 100644
=2D-- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
 obj-$(CONFIG_PWM_MTK_DISP)	+=3D pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
+obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
 obj-$(CONFIG_PWM_PUV3)		+=3D pwm-puv3.o
diff --git a/drivers/pwm/pwm-ntxec.c b/drivers/pwm/pwm-ntxec.c
new file mode 100644
index 0000000000000..eca305d8e915b
=2D-- /dev/null
+++ b/drivers/pwm/pwm-ntxec.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2020 Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+//
+// PWM driver for Netronix embedded controller.
+
+#include <linux/mfd/ntxec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/of_device.h>
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
+#define NTXEC_UNK_A		0xa1
+#define NTXEC_UNK_B		0xa2
+#define NTXEC_ENABLE		0xa3
+#define NTXEC_PERIOD_LOW	0xa4
+#define NTXEC_PERIOD_HIGH	0xa5
+#define NTXEC_DUTY_LOW		0xa6
+#define NTXEC_DUTY_HIGH		0xa7
+
+/*
+ * The time base used in the EC is 8MHz, or 125ns. Period and duty cycle =
are
+ * measured in this unit.
+ */
+static int ntxec_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm=
_dev,
+				 int duty_ns, int period_ns)
+{
+	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
+	uint64_t duty =3D duty_ns;
+	uint64_t period =3D period_ns;
+	int res =3D 0;
+
+	do_div(period, 125);
+	if (period > 0xffff) {
+		dev_warn(pwm->dev,
+			 "Period is not representable in 16 bits: %llu\n", period);
+		return -ERANGE;
+	}
+
+	do_div(duty, 125);
+	if (duty > 0xffff) {
+		dev_warn(pwm->dev, "Duty cycle is not representable in 16 bits: %llu\n"=
,
+			duty);
+		return -ERANGE;
+	}
+
+	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_HIGH, period >> 8);
+	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_LOW, period);
+	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_HIGH, duty >> 8);
+	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_LOW, duty);
+
+	return (res < 0) ? -EIO : 0;
+}
+
+static int ntxec_pwm_enable(struct pwm_chip *chip,
+				 struct pwm_device *pwm_dev)
+{
+	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
+
+	return ntxec_write8(pwm->ec, NTXEC_ENABLE, 1);
+}
+
+static void ntxec_pwm_disable(struct pwm_chip *chip,
+				   struct pwm_device *pwm_dev)
+{
+	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
+
+	ntxec_write8(pwm->ec, NTXEC_ENABLE, 0);
+}
+
+static struct pwm_ops ntxec_pwm_ops =3D {
+	.config		=3D ntxec_pwm_config,
+	.enable		=3D ntxec_pwm_enable,
+	.disable	=3D ntxec_pwm_disable,
+	.owner		=3D THIS_MODULE,
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
+	res |=3D ntxec_write8(pwm->ec, NTXEC_ENABLE, 0);
+	res |=3D ntxec_write8(pwm->ec, NTXEC_UNK_A, 0xff);
+	res |=3D ntxec_write8(pwm->ec, NTXEC_UNK_B, 0xff);
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
2.27.0

