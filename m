Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D7C140201
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2020 03:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbgAQCgB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Jan 2020 21:36:01 -0500
Received: from mail-mw2nam10on2069.outbound.protection.outlook.com ([40.107.94.69]:23297
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388056AbgAQCgB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Jan 2020 21:36:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYjhz2+S/rswVI4lJGI5KjXWv+GRgklV65Zwz3pLeooIFVsybHtBn0IGwx8ilzLO9FiDG/CP9181Nqlv/k+Ot0xs5MlndUHOB+vgipn9CMUBKEkcPoZTuTJVWM/YhjKDkocKocMuPsL1V8DX9UuhM77mO6MQb35khw8VXU1kOHvUPcmcWtZQ09YARvwd3w5ERQ2aS6f8N0gqS5rgDLCw20lNOmCtWBqIoyVnReEN8IlY5+vLLc+I0ub6sbMEAaTuoMe/MjmSk59+DS7TtcBABRYH4QQnaBD6Ce2g7lGwnSRalqbde/BvdaLmZwaYRNf9VkLm5RIRr3QW/9AV1GrTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtKKu9+z1hhdgwWlXXezhcjjimZRYH4LUzludK+KrQ0=;
 b=FiSKYr6Hg2qpX9/M6g1i2IYBEictv9cqlpigCs5fCW6F4/FaafQLaw2c6b+JFvFhzIfQ7waPKuTqcgmYkgtjX6IjXFQAXH+27XfcvmCbD2A0mEJlDfG/EckA8cHwuxFYKHsmvwiKLmetyEpj8/J2hVOodmO+7p69Kko7uvhZGY92F8LC6RzBtD98QXQCEU2fb0BRaY4K+XruehfKaGQgwjBePdLCZOej3eBpVSqKn2ov4LwdKLw42NZBCfMsXZcgFUBrliGsDfsT81zQvsjBJsnfxKGxIBpGtuAzU5l18YI39hL2JDp11u0ba2u42oyJ9AvURSXZKIa/02Khog70WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtKKu9+z1hhdgwWlXXezhcjjimZRYH4LUzludK+KrQ0=;
 b=CI0RxakUPCHF9tGv9gjdfaM2gEFZavAceBuRe3mW8OSTc0jRLUUSEEqeJA8M3JvY6ig3OHOaT/3114YphV2b6Q9uJRyCQvYx8vWXIhNRac4cxGc54XXT//tH1SfQ2pXaj+D6zWAjc7czXIbBzoeYd0N8JkANMAnpnbOr0sOFmqE=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4671.namprd08.prod.outlook.com (52.135.117.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 17 Jan 2020 02:35:57 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 02:35:57 +0000
Received: from localhost.localdomain (136.49.227.119) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Fri, 17 Jan 2020 02:35:47 +0000
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
Subject: [PATCH v4 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Topic: [PATCH v4 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Index: AQHVzN7ZeNwr91HvDUacFRX9W6PqAg==
Date:   Fri, 17 Jan 2020 02:35:57 +0000
Message-ID: <1579228475-6681-5-git-send-email-jeff@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1579228475-6681-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f46e5521-8ce6-4c87-ae6d-08d79af5fb66
x-ms-traffictypediagnostic: SN6PR08MB4671:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR08MB4671921BEBF7B9D7F9635774D3310@SN6PR08MB4671.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(34096005)(396003)(136003)(376002)(346002)(366004)(39830400003)(189003)(199004)(64756008)(66946007)(66556008)(66476007)(107886003)(4326008)(69590400006)(2616005)(186003)(956004)(52116002)(66446008)(6506007)(71200400001)(5660300002)(30864003)(6666004)(16526019)(36756003)(6512007)(7416002)(54906003)(316002)(26005)(508600001)(81166006)(8676002)(6486002)(110136005)(86362001)(2906002)(8936002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4671;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PC+aPyAyrpfjm9dVEjb7KL1xoX8EJ6aTBNr9d/vwcyJhrSOUaAZF7E4dVajI5GqcgKPapJPHxAFiPIWBwBoeH7dR+3O1q5ZOL6CHSeI9Y9zbZky4dtO+FA5dZ81jtDAsFHTke0SYnyHFMxzyt9eAcSUggogjOYK6HHuKrmlZ3YD5DY2BkW6NulTFCpL/GKuOw0d4UfN5CzBdENjEdcTJ8sXmw7AcO8lEj/G/tXdIQ5rs0i+axrL3/nwEZUGhPa6dothFbeBI+mI9wMthXBeDDqhcniW8/RPzmj6AtSbG8uyWdiJ7DIK2IBD2fuYnRrSxBchHkeAr+uGswbCRp6fbG9BbRNowenuWeiivpzmzcWjut3A+ydCq60YI8recmX0/HIT5bkTcN/oargiLJ/QUGo4ZgGhWxmsgrkQVqyIlOuvsfa++FiIHZ53i4l47hVhVldaAHxXMxJYawpbFSogdjqUIj2IK6Aus5loEDMA+KGbK7GXJqglH6GOUmleGp7Rk
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46e5521-8ce6-4c87-ae6d-08d79af5fb66
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 02:35:57.7556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sc7cu+jVuO4T7pHFDeMJF4Y1WPsH9QsjhI800Jm003OVQFJrS/vzmdhginL3muykxcGasXy1j7GCGhY+rmEmIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4671
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS620A, capable of generating
a 1-kHz PWM output with duty cycle between ~0.4% and 100% (inclusive).

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
Changes in v4:
  - Updated iqs620_pwm_apply and iqs620_pwm_get_state to hold the lock arou=
nd
    only the minimum necessary code
  - Removed the completion protecting against early use of chip->pwms[0] fr=
om
    inside iqs620_pwm_notifier in favor of cached register values
  - Updated iqs620_pwm_get_state to use the cached register values instead =
of
    reading IQS620_PWR_SETTINGS_PWM_OUT and IQS620_PWM_DUTY_CYCLE (both equ=
al
    to zero by default)
  - Added a comment in iqs620_pwm_notifier to note that the parent MFD driv=
er
    prints an error message in the event of a device reset

Changes in v3:
  - Updated the commit message to say "~0.4%" instead of "0.4%"
  - Clarified the effect of duty cycle and state changes in the 'Limitation=
s'
    section and added a restriction regarding 0% duty cycle
  - Added a comment in iqs620_pwm_apply to explain how duty cycle is derive=
d
  - Updated iqs620_pwm_apply to disable the output first and enable it last=
 to
    prevent temporarily driving a stale duty cycle
  - Rounded the calculation for duty cycle up and down in iqs620_pwm_get_st=
ate
    and iqs620_pwm_apply, respectively
  - Added a comment in iqs620_pwm_get_state to explain what it reports foll=
ow-
    ing requests to set duty cycle to 0%
  - Added a lock to prevent back-to-back access of IQS620_PWR_SETTINGS_PWM_=
OUT
    and IQS620_PWM_DUTY_CYCLE from being interrupted
  - Updated iqs620_pwm_notifier to reference pwm->state directly as opposed=
 to
    calling pwm_get_state
  - Moved notifier unregistration back to a device-managed action
  - Added a completion to prevent iqs620_pwm_notifier from referencing the
    pwm_chip structure until it has been initialized by pwmchip_add

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

 drivers/pwm/Kconfig       |  10 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-iqs620a.c | 258 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 269 insertions(+)
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
index 0000000..75ca482
--- /dev/null
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620A PWM Generator
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
+ *
+ * Limitations:
+ * - The period is fixed to 1 ms and is generated continuously despite cha=
nges
+ *   to the duty cycle or enable/disable state.
+ * - Changes to the duty cycle or enable/disable state take effect immedia=
tely
+ *   and may result in a glitch during the period in which the change is m=
ade.
+ * - The device cannot generate a 0% duty cycle. For duty cycles below 1 /=
 256
+ *   ms, the output is disabled and relies upon an external pull-down resi=
stor
+ *   to hold the GPIO3/LTX pin low.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
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
+	struct mutex lock;
+	bool out_en;
+	u8 duty_val;
+};
+
+static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	struct iqs62x_core *iqs62x;
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
+	/*
+	 * The duty cycle generated by the device is calculated as follows:
+	 *
+	 * duty_cycle =3D (IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
+	 *
+	 * ...where IQS620_PWM_DUTY_CYCLE is a register value between 0 and 255
+	 * (inclusive). Therefore the lowest duty cycle the device can generate
+	 * while the output is enabled is 1 / 256 ms.
+	 *
+	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
+	 * allow an on-board pull-down resistor to hold the GPIO3/LTX pin low.
+	 */
+	duty_scale =3D state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS;
+
+	mutex_lock(&iqs620_pwm->lock);
+
+	if (!state->enabled || !duty_scale) {
+		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
+					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
+		if (ret)
+			goto err_mutex;
+	}
+
+	if (duty_scale) {
+		u8 duty_val =3D min(duty_scale - 1, 0xFF);
+
+		ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
+				   duty_val);
+		if (ret)
+			goto err_mutex;
+
+		iqs620_pwm->duty_val =3D duty_val;
+	}
+
+	if (state->enabled && duty_scale) {
+		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
+					 IQS620_PWR_SETTINGS_PWM_OUT, 0xFF);
+		if (ret)
+			goto err_mutex;
+	}
+
+	iqs620_pwm->out_en =3D state->enabled;
+
+err_mutex:
+	mutex_unlock(&iqs620_pwm->lock);
+
+	return ret;
+}
+
+static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
+				 struct pwm_state *state)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+
+	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
+
+	mutex_lock(&iqs620_pwm->lock);
+
+	/*
+	 * Since the device cannot generate a 0% duty cycle, requests to do so
+	 * cause subsequent calls to iqs620_pwm_get_state to report the output
+	 * as disabled with duty cycle equal to that which was in use prior to
+	 * the request. This is not ideal, but is the best compromise based on
+	 * the capabilities of the device.
+	 */
+	state->enabled =3D iqs620_pwm->out_en;
+	state->duty_cycle =3D DIV_ROUND_UP((iqs620_pwm->duty_val + 1) *
+					 IQS620_PWM_PERIOD_NS, 256);
+
+	mutex_unlock(&iqs620_pwm->lock);
+
+	state->period =3D IQS620_PWM_PERIOD_NS;
+}
+
+static int iqs620_pwm_notifier(struct notifier_block *notifier,
+			       unsigned long event_flags, void *context)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	struct iqs62x_core *iqs62x;
+	int ret;
+
+	if (!(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
+		return NOTIFY_DONE;
+
+	iqs620_pwm =3D container_of(notifier, struct iqs620_pwm_private,
+				  notifier);
+	iqs62x =3D iqs620_pwm->iqs62x;
+
+	mutex_lock(&iqs620_pwm->lock);
+
+	/*
+	 * The parent MFD driver already prints an error message in the event
+	 * of a device reset, so nothing else is printed here unless there is
+	 * an additional failure.
+	 */
+	ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
+			   iqs620_pwm->duty_val);
+	if (ret)
+		goto err_mutex;
+
+	ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
+				 IQS620_PWR_SETTINGS_PWM_OUT,
+				 iqs620_pwm->out_en ? 0xFF : 0);
+
+err_mutex:
+	mutex_unlock(&iqs620_pwm->lock);
+
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
+static void iqs620_pwm_notifier_unregister(void *context)
+{
+	struct iqs620_pwm_private *iqs620_pwm =3D context;
+	int ret;
+
+	ret =3D blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
+						 &iqs620_pwm->notifier);
+	if (ret)
+		dev_err(iqs620_pwm->chip.dev,
+			"Failed to unregister notifier: %d\n", ret);
+}
+
+static int iqs620_pwm_probe(struct platform_device *pdev)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	int ret;
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
+	mutex_init(&iqs620_pwm->lock);
+
+	iqs620_pwm->notifier.notifier_call =3D iqs620_pwm_notifier;
+	ret =3D blocking_notifier_chain_register(&iqs620_pwm->iqs62x->nh,
+					       &iqs620_pwm->notifier);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D devm_add_action_or_reset(&pdev->dev,
+				       iqs620_pwm_notifier_unregister,
+				       iqs620_pwm);
+	if (ret)
+		return ret;
+
+	ret =3D pwmchip_add(&iqs620_pwm->chip);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to add device: %d\n", ret);
+
+	return ret;
+}
+
+static int iqs620_pwm_remove(struct platform_device *pdev)
+{
+	struct iqs620_pwm_private *iqs620_pwm =3D platform_get_drvdata(pdev);
+	int ret;
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

