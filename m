Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B547C11646D
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2019 01:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLIAir (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Dec 2019 19:38:47 -0500
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:11831
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbfLIAir (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 8 Dec 2019 19:38:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz6PkOJKPTTkgIldAs5mRKgAIrYVHDaIFaBr4e2eKcA4sLb7OzkYgatdviuvR9x3V4QT685vY7Ydg+pqEpH15mpyBSa9fn4ZUqDX2kOwr7cvIdGehUzCEQJyOqFmFMzNAYSE1KCJw/QUfpOuwaH7AdKlwdtbGTew1tlJSAqoKfNItm9K4KKziqfaz+2q30Do6E4rKSK1KYWeGckHk2jiDH/sbHKiIxrJLrUOky6vajkJwfxROg5jZhJkljoSGuxg+wNQJAXWLSJMAYE75soB0By0s7soUDck5QR2mgVKBMUbKuI8D093rL1ukHIezbfnPYFNMKt6YrwYNkAp0fq2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSO6vpuxPuJIEW5Lt1VY9IduJ+r6rltft3Onl7Vl6CI=;
 b=jmVv0SsfEyZ2p/EPAJ8q0enfRs3Ls37Fw95r1TA0b8gKox+lF3Sn/MQOWGAYYLJuML/89Sjoc7PC2r/r3scymINPCFPTp22DXsh5NF25hudLOntAuqOpX4IEULR/0Shnr5OGxNUc+e+JvVBU6dCs/xrOnOW8g6PEYMcZHv7oe/XYesqUg/gLYKxtu/4G6Qofi0xBEohu0lX38Sh7mO65iw+E+6+8D78rkFc0SHrwqKL9jQ9CA2tf2oRz1B6q3k4+2wkKKqCGvHGkuj2uC131PvKmx4KGCCHuZhymRWNH4qsqBOtg4c4MLyxH70Fy7TwAzTE5hIEcJBtmjZYYYhTqZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSO6vpuxPuJIEW5Lt1VY9IduJ+r6rltft3Onl7Vl6CI=;
 b=uGHsRR75BL8eRuzDI901bXKP9OZKNaLN7OEJwTBNDQZTzKhKc3VzjKwDS0GLgW3KMjEGot0Al3hUzB+LtN82t1JUOaKRY/JMjVh5+Nv5YBb1FcXLXICI0g9xM5Tgn6v0dn48+aLqDBZ8V6JMcnH2GN6prCzrb5LThhhi43QjuXs=
Received: from BN7PR08MB5042.namprd08.prod.outlook.com (20.176.177.14) by
 BN7PR08MB4402.namprd08.prod.outlook.com (52.132.223.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Mon, 9 Dec 2019 00:38:37 +0000
Received: from BN7PR08MB5042.namprd08.prod.outlook.com
 ([fe80::48de:9418:73ef:d7c1]) by BN7PR08MB5042.namprd08.prod.outlook.com
 ([fe80::48de:9418:73ef:d7c1%6]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 00:38:37 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Topic: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Index: AQHVrij+8yO8xEtV+ECzt9/U9i+G6g==
Date:   Mon, 9 Dec 2019 00:38:36 +0000
Message-ID: <1575851866-18919-5-git-send-email-jeff@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1575851866-18919-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0082.namprd12.prod.outlook.com
 (2603:10b6:802:21::17) To BN7PR08MB5042.namprd08.prod.outlook.com
 (2603:10b6:408:2c::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d4b9967-ac84-444f-344d-08d77c4020dd
x-ms-traffictypediagnostic: BN7PR08MB4402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR08MB4402597FC70E35482023B4DED3580@BN7PR08MB4402.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(34096005)(366004)(136003)(396003)(346002)(39830400003)(199004)(189003)(99286004)(76176011)(71200400001)(52116002)(71190400001)(54906003)(4326008)(2906002)(6512007)(38610400001)(66556008)(66476007)(6486002)(66946007)(586005)(64756008)(66446008)(110136005)(107886003)(36756003)(8936002)(102836004)(50226002)(305945005)(2616005)(7416002)(5660300002)(6506007)(81166006)(81156014)(498600001)(26005)(86362001)(186003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB4402;H:BN7PR08MB5042.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rphtfl0oR5lYDxbKWSJD+9KjMMcxc844/JcYon7Uz292lXk3emGLTdgZDP4bWcyubIJVKVLKEB7a7pL0rBTlvRecz8JcFgkm9uXYmUA2N9Gi7mSi4rKJdjyWCXx+FO9VZQ1cYRUnYYveEoGoOzgZ8sAF8EeQVV82Eb7FUW5GT8U7qvYyWIpYvx0ihuOZpWL9uqLqTLUO9gnjAjDIfGZ88f6rsffDvJsPU6EaN/ZmAbkh7W10EENNOiNolcg0iT18X7nvVQG9g5cHHD+5JogwZpB7vmTlvH0Sn8tmxEsyNYtl9QtuJwcrA6Y1Z+u8ZEQdqcSlrMiXyKxw/jEescHJO1vHhy9rIpEQ0M2I5jg0F3c4M7+QawJ3JgFksGJPX1yiuUNbMj+772oaoz2xIfjcPSXjJHReMm5IjxN02QLd2uNN3CuZpjLuRjL0VapfQfWf
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4b9967-ac84-444f-344d-08d77c4020dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 00:38:36.9853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6XAybU6eogDX9hrmIcaaphJ0ovTpTifWOF4+nNakLD8FQFwQ62153+9+chbxtpSg0hiONK8FcPN077Ue2kXcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4402
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS620A, capable of generating
a 1-kHz PWM output with duty cycle between 0.4% and 100% (inclusive).

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
Changes in v2:
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Added 'Limitations' section to introductory comments
  - Replaced 'error' with 'ret' throughout
  - Added const qualifier to state argument of iqs620_pwm_apply and removed=
 all
    modifications to the variable's contents
  - Updated iqs620_pwm_apply to return -ENOTSUPP or -EINVAL if the requeste=
d
    polarity is inverted or the requested period is below 1 ms, respectivel=
y
  - Updated iqs620_pwm_apply to disable the PWM output if duty cycle is zer=
o
  - Added iqs620_pwm_get_state
  - Eliminated tabbed alignment of pwm_ops and platform_driver struct membe=
rs
  - Moved notifier unregistration to already present iqs620_pwm_remove, whi=
ch
    eliminated the need for a device-managed action and ready flag
  - Added a comment in iqs620_pwm_probe to explain the order of operations
  - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST

 drivers/pwm/Kconfig       |  10 +++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-iqs620a.c | 206 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/pwm/pwm-iqs620a.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index bd21655..60bcf6c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -222,6 +222,16 @@ config PWM_IMX_TPM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx-tpm.

+config PWM_IQS620A
+	tristate "Azoteq IQS620A PWM support"
+	depends on MFD_IQS62X || COMPILE_TEST
+	help
+	  Generic PWM framework driver for the Azoteq IQS620A multi-function
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called pwm-iqs620a.
+
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9a47507..a59c710 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
 obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
 obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
+obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
 obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
new file mode 100644
index 0000000..1ea11b9
--- /dev/null
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620A PWM Generator
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
+ *
+ * Limitations:
+ * - The period is not guaranteed to run to completion when the duty cycle=
 is
+ *   changed or the output is disabled.
+ * - The period is fixed to 1 ms.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define IQS620_PWR_SETTINGS			0xD2
+#define IQS620_PWR_SETTINGS_PWM_OUT		BIT(7)
+
+#define IQS620_PWM_DUTY_CYCLE			0xD8
+
+#define IQS620_PWM_PERIOD_NS			1000000
+
+struct iqs620_pwm_private {
+	struct iqs62x_core *iqs62x;
+	struct pwm_chip chip;
+	struct notifier_block notifier;
+};
+
+static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	struct iqs62x_core *iqs62x;
+	unsigned int pwm_out =3D 0;
+	int duty_scale, ret;
+
+	if (state->polarity !=3D PWM_POLARITY_NORMAL)
+		return -ENOTSUPP;
+
+	if (state->period < IQS620_PWM_PERIOD_NS)
+		return -EINVAL;
+
+	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
+	iqs62x =3D iqs620_pwm->iqs62x;
+
+	duty_scale =3D DIV_ROUND_CLOSEST(state->duty_cycle * 256,
+				       IQS620_PWM_PERIOD_NS);
+
+	if (duty_scale) {
+		ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
+				   min(duty_scale - 1, 0xFF));
+		if (ret)
+			return ret;
+
+		if (state->enabled)
+			pwm_out =3D IQS620_PWR_SETTINGS_PWM_OUT;
+	}
+
+	return regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
+				  IQS620_PWR_SETTINGS_PWM_OUT, pwm_out);
+}
+
+static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
+				 struct pwm_state *state)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	struct iqs62x_core *iqs62x;
+	unsigned int val;
+	int ret;
+
+	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
+	iqs62x =3D iqs620_pwm->iqs62x;
+
+	ret =3D regmap_read(iqs62x->map, IQS620_PWR_SETTINGS, &val);
+	if (ret)
+		goto err_out;
+	state->enabled =3D val & IQS620_PWR_SETTINGS_PWM_OUT;
+
+	ret =3D regmap_read(iqs62x->map, IQS620_PWM_DUTY_CYCLE, &val);
+	if (ret)
+		goto err_out;
+	state->duty_cycle =3D DIV_ROUND_CLOSEST((val + 1) * IQS620_PWM_PERIOD_NS,
+					      256);
+	state->period =3D IQS620_PWM_PERIOD_NS;
+
+err_out:
+	if (ret)
+		dev_err(iqs620_pwm->chip.dev, "Failed to get state: %d\n", ret);
+}
+
+static int iqs620_pwm_notifier(struct notifier_block *notifier,
+			       unsigned long event_flags, void *context)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	struct pwm_state state;
+	int ret;
+
+	if (!(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
+		return NOTIFY_DONE;
+
+	iqs620_pwm =3D container_of(notifier, struct iqs620_pwm_private,
+				  notifier);
+	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
+
+	ret =3D iqs620_pwm_apply(&iqs620_pwm->chip,
+			       &iqs620_pwm->chip.pwms[0], &state);
+	if (ret) {
+		dev_err(iqs620_pwm->chip.dev,
+			"Failed to re-initialize device: %d\n", ret);
+		return NOTIFY_BAD;
+	}
+
+	return NOTIFY_OK;
+}
+
+static const struct pwm_ops iqs620_pwm_ops =3D {
+	.apply =3D iqs620_pwm_apply,
+	.get_state =3D iqs620_pwm_get_state,
+	.owner =3D THIS_MODULE,
+};
+
+static int iqs620_pwm_probe(struct platform_device *pdev)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	int ret1, ret2;
+
+	iqs620_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*iqs620_pwm), GFP_KERNEL);
+	if (!iqs620_pwm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, iqs620_pwm);
+	iqs620_pwm->iqs62x =3D dev_get_drvdata(pdev->dev.parent);
+
+	iqs620_pwm->chip.dev =3D &pdev->dev;
+	iqs620_pwm->chip.ops =3D &iqs620_pwm_ops;
+	iqs620_pwm->chip.base =3D -1;
+	iqs620_pwm->chip.npwm =3D 1;
+
+	ret1 =3D pwmchip_add(&iqs620_pwm->chip);
+	if (ret1) {
+		dev_err(&pdev->dev, "Failed to add device: %d\n", ret1);
+		return ret1;
+	}
+
+	/*
+	 * Since iqs620_pwm_notifier uses iqs620_pwm->chip.pwms[], the notifier
+	 * is not registered until pwmchip_add (which allocates that array) has
+	 * been called. If registration fails, the newly added device has to be
+	 * removed because the driver fails to probe and iqs620_pwm_remove will
+	 * never be called.
+	 */
+	iqs620_pwm->notifier.notifier_call =3D iqs620_pwm_notifier;
+	ret1 =3D blocking_notifier_chain_register(&iqs620_pwm->iqs62x->nh,
+						&iqs620_pwm->notifier);
+	if (ret1) {
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret1);
+
+		ret2 =3D pwmchip_remove(&iqs620_pwm->chip);
+		if (ret2) {
+			dev_err(&pdev->dev, "Failed to remove device: %d\n",
+				ret2);
+			return ret2;
+		}
+	}
+
+	return ret1;
+}
+
+static int iqs620_pwm_remove(struct platform_device *pdev)
+{
+	struct iqs620_pwm_private *iqs620_pwm =3D platform_get_drvdata(pdev);
+	int ret;
+
+	ret =3D blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
+						 &iqs620_pwm->notifier);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to unregister notifier: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D pwmchip_remove(&iqs620_pwm->chip);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to remove device: %d\n", ret);
+
+	return ret;
+}
+
+static struct platform_driver iqs620_pwm_platform_driver =3D {
+	.driver =3D {
+		.name =3D IQS620_DRV_NAME_PWM,
+	},
+	.probe =3D iqs620_pwm_probe,
+	.remove =3D iqs620_pwm_remove,
+};
+module_platform_driver(iqs620_pwm_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS620A PWM Generator");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" IQS620_DRV_NAME_PWM);
--
2.7.4

