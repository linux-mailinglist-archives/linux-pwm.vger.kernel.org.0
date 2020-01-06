Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40F43130B0E
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2020 01:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgAFAsn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 5 Jan 2020 19:48:43 -0500
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:6166
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727215AbgAFAsn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 5 Jan 2020 19:48:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXsNgeKicbR1qd9gQlIcwp8Per+pIE4VGP16aKrrXGcHUCgWg/JdrGZ+K1iVAKYidxRZ6mV9RwVLSEVwbi6zqQ2UjLJgbUEPMsrDMWCLbjdE081rz2X160/nQxWrySkTb3W+++SPVmnxQge46A25W1F/iZAOpoMsxUm76+LmN/slK6E9m43OeOwGoD0LXqRbehLGYm5XhxOmA4543dD9LUPkYxXxsGjOpWdrdyRgDr29njujdsW0DmABGQLuBfLYBBSJbCpjug9thNJBEJ7YvEMBK9OW660RXAz+mKjfXxQR/I7m1ppCPAdO38TifKzYeAqHok7UxZ40aC4vcJWvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzuCve0csxMPnyxcx+URnL0j7SSZ2YyLyqYJSZ1xwC0=;
 b=BJzKVzkXhZlB7REwAdrfVNxpAOyobhvSTGzrsOv2Lcbqa1iOr4abKC3QHG86+vmsIRJ26+ijvhG+V3DWC1GPGQ/nbTyS8WxMvehGz+4Tb4s4KCm0dKIVT+X+RYnzG8ja0S7YBSW7GSd/BNQcWqN6Sroh6NpGN3/JkUmdnbjeHQX4h70SpszONJZtEWOZX12irk7/wmV+4dgK6QiPfsZJs/wLBZMWPD3oqXu+LcjORzpG3h7DqqAEgrBiL8KlSkJxqFT0M0S3p3zrY9nIXG1C04ZyuS9nvKBtlnzIvG2fwARr2je1AJd8VE2FbdWJzn8sFmc2D9UjBxdHhr7/DaN5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzuCve0csxMPnyxcx+URnL0j7SSZ2YyLyqYJSZ1xwC0=;
 b=a164uhC9oluDLKnS8eMUT35oNu5egwsWy/xeRY+bFltGi6GjT48gDXBcHHmEKqVBiE3KZXXRtCzDkqF2ZQRKHjrlk3W4j+Phyy0gzSEq4iWCgEDsFPm1RokcasYKAux8egDTqJLmU+6woQCoXf8LpEQJBzy6Kx9vtovGdh+Ijxk=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4175.namprd08.prod.outlook.com (52.135.69.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 00:48:03 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 00:48:03 +0000
Received: from localhost.localdomain (136.49.227.119) by SN4PR0701CA0020.namprd07.prod.outlook.com (2603:10b6:803:28::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.13 via Frontend Transport; Mon, 6 Jan 2020 00:48:02 +0000
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
Subject: [PATCH v3 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Topic: [PATCH v3 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Index: AQHVxCrzh4C7ONAGT0GQryJS4hKCGA==
Date:   Mon, 6 Jan 2020 00:48:02 +0000
Message-ID: <1578271620-2159-5-git-send-email-jeff@labundy.com>
References: <1578271620-2159-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1578271620-2159-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0020.namprd07.prod.outlook.com
 (2603:10b6:803:28::30) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eaf285ea-c90c-44a7-215a-08d7924215cf
x-ms-traffictypediagnostic: SN6PR08MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR08MB4175B986D0C85AA06FFF2E2AD33C0@SN6PR08MB4175.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39830400003)(136003)(376002)(346002)(34096005)(199004)(189003)(36756003)(107886003)(2616005)(956004)(316002)(69590400006)(5660300002)(86362001)(6486002)(508600001)(2906002)(4326008)(6506007)(81166006)(110136005)(6512007)(54906003)(16526019)(26005)(8676002)(186003)(7416002)(8936002)(66476007)(71200400001)(52116002)(66946007)(30864003)(66446008)(66556008)(64756008)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4175;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4HLehEvYlo5voscxXYgzphlGMW6eaRq7jtMtDEUQj0z03plpXyvKCjuNtthw3+FX3r6EHzvgntzdzBp4JmKHW6M/upxo1KEh/rP6UfqOjj9XnI/5sa8Czlb8m0OC16G83Je82pJBdafZGZHEsuxD4LkFJDKQNTznNtf3rdKgrRFqhtw2ndgBoPWzk8Q+12DTdQ5TJ3Awxm7VSX//UGmz28cY12qv0bulPS0tbmuUx+im9JkhOcBimQ5yidQiJRML2Y0CR62r5LBu7JBI3O2jWX9yfYCyKY2u+JZgbXkQ5QEbJwywnRSGOB4QhcOhqLby7ha4iW4KaUKpse+tJXw2feD+DFEkgw8uhewbypUjkjtnCaczmh3xGMTo+U6sDE4QYDpAGG9K6lhcNglEIvpcPTf05xJA1O5kNH3N52fgS6HjDVK0TlyzKCT74tzYCnTJGVrwLvTubr5Jl35E4WQAjaR8EaPLLSfBWuImLr+YFtPbq0vBIF3oJL1Hv9RXWYgs
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf285ea-c90c-44a7-215a-08d7924215cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 00:48:02.9426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vY+7qqqh+uLDSthVw+THmCcYFltymWlixdWl75wP7m8G7dQEiajivDZJxkRop1VOvz8qcwhYTZy/e02mrUYKyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4175
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS620A, capable of generating
a 1-kHz PWM output with duty cycle between ~0.4% and 100% (inclusive).

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
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
 drivers/pwm/pwm-iqs620a.c | 254 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 265 insertions(+)
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
index 0000000..ee5d8b5
--- /dev/null
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -0,0 +1,254 @@
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
+#include <linux/completion.h>
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
+	struct completion chip_ready;
+	struct mutex lock;
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
+	mutex_lock(&iqs620_pwm->lock);
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
+	if (!state->enabled || !duty_scale) {
+		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
+					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
+		if (ret)
+			goto err_mutex;
+	}
+
+	if (duty_scale) {
+		ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
+				   min(duty_scale - 1, 0xFF));
+		if (ret)
+			goto err_mutex;
+	}
+
+	if (state->enabled && duty_scale)
+		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
+					 IQS620_PWR_SETTINGS_PWM_OUT, 0xFF);
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
+	struct iqs62x_core *iqs62x;
+	unsigned int val;
+	int ret;
+
+	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
+	iqs62x =3D iqs620_pwm->iqs62x;
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
+	ret =3D regmap_read(iqs62x->map, IQS620_PWR_SETTINGS, &val);
+	if (ret)
+		goto err_mutex;
+	state->enabled =3D val & IQS620_PWR_SETTINGS_PWM_OUT;
+
+	ret =3D regmap_read(iqs62x->map, IQS620_PWM_DUTY_CYCLE, &val);
+	if (ret)
+		goto err_mutex;
+	state->duty_cycle =3D DIV_ROUND_UP((val + 1) * IQS620_PWM_PERIOD_NS, 256)=
;
+	state->period =3D IQS620_PWM_PERIOD_NS;
+
+err_mutex:
+	mutex_unlock(&iqs620_pwm->lock);
+
+	if (ret)
+		dev_err(iqs620_pwm->chip.dev, "Failed to get state: %d\n", ret);
+}
+
+static int iqs620_pwm_notifier(struct notifier_block *notifier,
+			       unsigned long event_flags, void *context)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	int ret;
+
+	iqs620_pwm =3D container_of(notifier, struct iqs620_pwm_private,
+				  notifier);
+
+	if (!completion_done(&iqs620_pwm->chip_ready) ||
+	    !(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
+		return NOTIFY_DONE;
+
+	ret =3D iqs620_pwm_apply(&iqs620_pwm->chip, &iqs620_pwm->chip.pwms[0],
+			       &iqs620_pwm->chip.pwms[0].state);
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
+	init_completion(&iqs620_pwm->chip_ready);
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
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add device: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * pwmchip_add is called last to avoid a messy tear-down path, so the
+	 * following completion prevents iqs620_pwm_notifier from referencing
+	 * the pwm_chip structure until it has been completely initialized.
+	 */
+	complete_all(&iqs620_pwm->chip_ready);
+
+	return 0;
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

