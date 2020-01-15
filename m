Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC8F13B827
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jan 2020 04:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgAODaD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Jan 2020 22:30:03 -0500
Received: from mail-bn7nam10on2048.outbound.protection.outlook.com ([40.107.92.48]:6100
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728884AbgAODaC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 14 Jan 2020 22:30:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IisyelP6PRUgeUKtU+Hike0lfDXHEDUudq3Yk5Fog44oJN+0njMfgXncadB9H8M4irfcu24iXyuOxDAAUuPh+qYvy/XOMrRQv9yaT8n6MPYesvqN+gGUcIdV8BuhyZ6sm+lrZEpgs8Nk+Bw7vBOL94xPwl+zTXCJeril4oRh/p/cjdBh3BfLh0kN9ezCHg0Oi/rVPeC+9ThEc1UMAph67lPr9B/RMDAS9A5FZXrrg8NPXo1227koEk9Cs9RkztseMJndPpBTAvEDBH+LU8dQKcPPu5Bm780ZES1gbq4En9hx6bQt5rpft2JE73Bl9uPBAYp24l3v0jsJf5ZsrmMsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kKQ1MKF2szVUgxBqhMJsdtt9nRfKR/p+B1nduMtFME=;
 b=IS9Kw+nIM6j0/LLvKgWIPrMN9JzQBhStoG61nA5ffkTjsPc1qZZQHJw51czNL3+uin0IYe9ECwjc5gUA/jmhKCCbAEj4yvioHZFAVQq1vzz0JIjycaxjd+g1v1lKQqpRLfaEQp6kAYbFlYLOpnp3BzkGKStKUQdShAgOei01vUjg9FjR52BH8JA6Lt8fBSn8aXulow6wGkRHWrO5bLCbIexUCuV0puqIHf/qKtrWegb0+rWI2Xmz7dEOj6hSB/cJN7uXoUVMz8Y2EG+qHK7qA5u+LVTkX9YQOj+NnlobgHR1Nw4VyqavYDnttZ3SVnDdSNoFl/TAwrj0bJI5P94+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kKQ1MKF2szVUgxBqhMJsdtt9nRfKR/p+B1nduMtFME=;
 b=Bj7wK0wWNFkzR2TSWino1RpADjcracrF/an+V4gArBp//1aHmQvEyAuKtfpLMaPqJsN23rcaVACBBykYCWzfbfaonZy0cTavIBnqRnY7zILWSFPyBAY2DvOuHoyzbtCbZJgWteXh3oBS5Q+PDW9UMoe35aeUtEU/2Qj+JiyoMYA=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4957.namprd08.prod.outlook.com (52.135.100.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 15 Jan 2020 03:29:53 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2623.018; Wed, 15 Jan 2020
 03:29:52 +0000
Received: from labundy.com (136.49.227.119) by SN4PR0501CA0028.namprd05.prod.outlook.com (2603:10b6:803:40::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.16 via Frontend Transport; Wed, 15 Jan 2020 03:29:51 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v3 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Topic: [PATCH v3 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Index: AQHVxCrzh4C7ONAGT0GQryJS4hKCGKfp20QAgAFEdoA=
Date:   Wed, 15 Jan 2020 03:29:52 +0000
Message-ID: <20200115032945.GA6229@labundy.com>
References: <1578271620-2159-1-git-send-email-jeff@labundy.com>
 <1578271620-2159-5-git-send-email-jeff@labundy.com>
 <20200114080828.vv7ilksklt27ysh3@pengutronix.de>
In-Reply-To: <20200114080828.vv7ilksklt27ysh3@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0028.namprd05.prod.outlook.com
 (2603:10b6:803:40::41) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8605d6d9-5804-4e16-6751-08d7996b2ebd
x-ms-traffictypediagnostic: SN6PR08MB4957:
x-microsoft-antispam-prvs: <SN6PR08MB4957F01CAF96121E6328E6C2D3370@SN6PR08MB4957.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(366004)(39830400003)(34096005)(55674003)(189003)(199004)(6916009)(55016002)(5660300002)(316002)(81156014)(81166006)(30864003)(71200400001)(8676002)(8936002)(36756003)(8886007)(54906003)(66476007)(1076003)(2906002)(4326008)(66574012)(508600001)(7416002)(966005)(16526019)(186003)(33656002)(956004)(2616005)(66556008)(86362001)(26005)(66946007)(52116002)(7696005)(64756008)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4957;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ptqp1czJ5K5FlOOJcILggdAeS0SqEs7MRtBOhGzOdt7QFCOy5yHAlIKyJR0Hm3fEYJzLYrZUvoaUjnQvs/ecpj9UAnOSjWpP3VmMIjkmhdQs8r0fdxoEc1sYwqNX3FkseIaQc1vQ1oeyZ7tV4RPi1wHalfCJT4Z9qLY4MIOS9qer+fECUkYnDEvXL+KEgQQuh1dh51OtFb/HfVWigmJYDyuJ9REfMSHRMKeMNewFpvP4jioEbbdcblDRECWG0GCjqEsI40qg3jgaYOkSSWgEiZ1dXfalEMhFG5zkAAfzxFnyJoQz1BkYjKVrPDzWmanvueUuLQ/fYhnjO+C6BTjTKNzD0AUyzCDC/llzEdUvsSYblElpyPLnQMlQPM+WBwz97tL3fEOPnvdu+r/9Eq84Dpu9VkCPZN+tv8btaH6h+STWJl4JMI7zwOEjs1xIsDTO0/3lJA8/jlx67+YA567TEkaROZXzHSnyfO+gzrjg8RrtjF8flnXZwu4YPKijsgpEZ4SCAmVJFnPfpEBXfxYRYZg0O6l90/yJJNaojyt20IjdJ5AsbtA5hFs5aB7Y/bGw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E4E36EA051CCA544973393C89797BF90@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8605d6d9-5804-4e16-6751-08d7996b2ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 03:29:52.6526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4Gh/XO59bwn/9C4wet8et5z9XDMZpua28QqCYCWWbbzcqTOGga8iJNtz6HNm7LU41ZrmBK75wL3lWXgXiCedw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4957
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for your kind words and thorough review.

On Tue, Jan 14, 2020 at 09:08:28AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Jeff,
>=20
> On Mon, Jan 06, 2020 at 12:48:02AM +0000, Jeff LaBundy wrote:
> > This patch adds support for the Azoteq IQS620A, capable of generating
> > a 1-kHz PWM output with duty cycle between ~0.4% and 100% (inclusive).
>=20
> Overall a very nice driver, some minor issues below.
>=20
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > ---
> > Changes in v3:
> >   - Updated the commit message to say "~0.4%" instead of "0.4%"
> >   - Clarified the effect of duty cycle and state changes in the 'Limita=
tions'
> >     section and added a restriction regarding 0% duty cycle
> >   - Added a comment in iqs620_pwm_apply to explain how duty cycle is de=
rived
> >   - Updated iqs620_pwm_apply to disable the output first and enable it =
last to
> >     prevent temporarily driving a stale duty cycle
> >   - Rounded the calculation for duty cycle up and down in iqs620_pwm_ge=
t_state
> >     and iqs620_pwm_apply, respectively
> >   - Added a comment in iqs620_pwm_get_state to explain what it reports =
follow-
> >     ing requests to set duty cycle to 0%
> >   - Added a lock to prevent back-to-back access of IQS620_PWR_SETTINGS_=
PWM_OUT
> >     and IQS620_PWM_DUTY_CYCLE from being interrupted
> >   - Updated iqs620_pwm_notifier to reference pwm->state directly as opp=
osed to
> >     calling pwm_get_state
> >   - Moved notifier unregistration back to a device-managed action
> >   - Added a completion to prevent iqs620_pwm_notifier from referencing =
the
> >     pwm_chip structure until it has been initialized by pwmchip_add
> >=20
> > Changes in v2:
> >   - Merged 'Copyright' and 'Author' lines into one in introductory comm=
ents
> >   - Added 'Limitations' section to introductory comments
> >   - Replaced 'error' with 'ret' throughout
> >   - Added const qualifier to state argument of iqs620_pwm_apply and rem=
oved all
> >     modifications to the variable's contents
> >   - Updated iqs620_pwm_apply to return -ENOTSUPP or -EINVAL if the requ=
ested
> >     polarity is inverted or the requested period is below 1 ms, respect=
ively
> >   - Updated iqs620_pwm_apply to disable the PWM output if duty cycle is=
 zero
> >   - Added iqs620_pwm_get_state
> >   - Eliminated tabbed alignment of pwm_ops and platform_driver struct m=
embers
> >   - Moved notifier unregistration to already present iqs620_pwm_remove,=
 which
> >     eliminated the need for a device-managed action and ready flag
> >   - Added a comment in iqs620_pwm_probe to explain the order of operati=
ons
> >   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST
> >=20
> >  drivers/pwm/Kconfig       |  10 ++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-iqs620a.c | 254 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 265 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-iqs620a.c
> >=20
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index bd21655..60bcf6c 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -222,6 +222,16 @@ config PWM_IMX_TPM
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-imx-tpm.
> >=20
> > +config PWM_IQS620A
> > +	tristate "Azoteq IQS620A PWM support"
> > +	depends on MFD_IQS62X || COMPILE_TEST
> > +	help
> > +	  Generic PWM framework driver for the Azoteq IQS620A multi-function
> > +	  sensor.
> > +
> > +	  To compile this driver as a module, choose M here: the module will
> > +	  be called pwm-iqs620a.
> > +
> >  config PWM_JZ4740
> >  	tristate "Ingenic JZ47xx PWM support"
> >  	depends on MACH_INGENIC
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 9a47507..a59c710 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
> >  obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
> >  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
> >  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
> > +obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
> >  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
> >  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
> >  obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
> > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> > new file mode 100644
> > index 0000000..ee5d8b5
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-iqs620a.c
> > @@ -0,0 +1,254 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Azoteq IQS620A PWM Generator
> > + *
> > + * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
> > + *
> > + * Limitations:
> > + * - The period is fixed to 1 ms and is generated continuously despite=
 changes
> > + *   to the duty cycle or enable/disable state.
> > + * - Changes to the duty cycle or enable/disable state take effect imm=
ediately
> > + *   and may result in a glitch during the period in which the change =
is made.
> > + * - The device cannot generate a 0% duty cycle. For duty cycles below=
 1 / 256
> > + *   ms, the output is disabled and relies upon an external pull-down =
resistor
> > + *   to hold the GPIO3/LTX pin low.
> > + */
> > +
> > +#include <linux/completion.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/iqs62x.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/notifier.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#define IQS620_PWR_SETTINGS			0xD2
> > +#define IQS620_PWR_SETTINGS_PWM_OUT		BIT(7)
> > +
> > +#define IQS620_PWM_DUTY_CYCLE			0xD8
> > +
> > +#define IQS620_PWM_PERIOD_NS			1000000
> > +
> > +struct iqs620_pwm_private {
> > +	struct iqs62x_core *iqs62x;
> > +	struct pwm_chip chip;
> > +	struct notifier_block notifier;
> > +	struct completion chip_ready;
> > +	struct mutex lock;
> > +};
> > +
> > +static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > +			    const struct pwm_state *state)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +	struct iqs62x_core *iqs62x;
> > +	int duty_scale, ret;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -ENOTSUPP;
> > +
> > +	if (state->period < IQS620_PWM_PERIOD_NS)
> > +		return -EINVAL;
> > +
> > +	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
> > +	iqs62x =3D iqs620_pwm->iqs62x;
> > +
> > +	mutex_lock(&iqs620_pwm->lock);
> > +
> > +	/*
> > +	 * The duty cycle generated by the device is calculated as follows:
> > +	 *
> > +	 * duty_cycle =3D (IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
> > +	 *
> > +	 * ...where IQS620_PWM_DUTY_CYCLE is a register value between 0 and 2=
55
> > +	 * (inclusive). Therefore the lowest duty cycle the device can genera=
te
> > +	 * while the output is enabled is 1 / 256 ms.
> > +	 *
> > +	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled =
to
> > +	 * allow an on-board pull-down resistor to hold the GPIO3/LTX pin low=
.
> > +	 */
> > +	duty_scale =3D state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS;
>=20
> minor optimisation: You could do the division before grabbing the lock.
> (But unsure if this actually gives a better result or the compiler is
> clever enough to do this.)
>=20

That's a great point. Regardless of the result I think it is better to re-o=
rder
as you suggest, simply to keep with the idea of locking around only the min=
imum
necessary code.

> > +
> > +	if (!state->enabled || !duty_scale) {
> > +		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> > +					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
> > +		if (ret)
> > +			goto err_mutex;
> > +	}
> > +
> > +	if (duty_scale) {
> > +		ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
> > +				   min(duty_scale - 1, 0xFF));
> > +		if (ret)
> > +			goto err_mutex;
> > +	}
> > +
> > +	if (state->enabled && duty_scale)
> > +		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> > +					 IQS620_PWR_SETTINGS_PWM_OUT, 0xFF);
> > +
> > +err_mutex:
> > +	mutex_unlock(&iqs620_pwm->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> > +				 struct pwm_state *state)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +	struct iqs62x_core *iqs62x;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
> > +	iqs62x =3D iqs620_pwm->iqs62x;
> > +
> > +	mutex_lock(&iqs620_pwm->lock);
> > +
> > +	/*
> > +	 * Since the device cannot generate a 0% duty cycle, requests to do s=
o
> > +	 * cause subsequent calls to iqs620_pwm_get_state to report the outpu=
t
> > +	 * as disabled with duty cycle equal to that which was in use prior t=
o
> > +	 * the request. This is not ideal, but is the best compromise based o=
n
> > +	 * the capabilities of the device.
> > +	 */
> > +	ret =3D regmap_read(iqs62x->map, IQS620_PWR_SETTINGS, &val);
> > +	if (ret)
> > +		goto err_mutex;
> > +	state->enabled =3D val & IQS620_PWR_SETTINGS_PWM_OUT;
> > +
> > +	ret =3D regmap_read(iqs62x->map, IQS620_PWM_DUTY_CYCLE, &val);
> > +	if (ret)
> > +		goto err_mutex;
> > +	state->duty_cycle =3D DIV_ROUND_UP((val + 1) * IQS620_PWM_PERIOD_NS, =
256);
> > +	state->period =3D IQS620_PWM_PERIOD_NS;
> > +
> > +err_mutex:
> > +	mutex_unlock(&iqs620_pwm->lock);
> > +
> > +	if (ret)
> > +		dev_err(iqs620_pwm->chip.dev, "Failed to get state: %d\n", ret);
> > +}
> > +
>=20
> I thought we dicussed having a comment here, saying something like:
>=20
> 	The device might reset when [...] and as a result looses it's
> 	configuration. So the registers must be rewritten when this
> 	happens to restore the expected operation.
>=20
> Is it worth to issue a warning when this happens?
>=20

The detailed comments and an error message have always been in iqs62x_irq o=
f the
parent MFD driver. The pwm is only one of up to three sub-devices that subs=
cribe
to the chain and must update their locally owned registers after the MFD ha=
ndles
the interrupt and restores the device's firmware. I opted to keep these com=
ments
in the common MFD rather than repeating throughout the series.

> > +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> > +			       unsigned long event_flags, void *context)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +	int ret;
> > +
> > +	iqs620_pwm =3D container_of(notifier, struct iqs620_pwm_private,
> > +				  notifier);
> > +
> > +	if (!completion_done(&iqs620_pwm->chip_ready) ||
> > +	    !(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
> > +		return NOTIFY_DONE;
>=20
> Is here a (relevant?) race?  Consider the notifier triggers just when
> pwmchip_add returned, (maybe even a consumer configured the device) and
> before complete_all() is called. With my limited knowledge about
> notifiers I'd say waiting for the completion here might be reasonable
> and safe.
>=20

Great catch; this is theoretically possible. The problem with waiting, howe=
ver,
is if the notifier is triggered right away during probe but probe returns e=
arly
due to an error (and completion never happens).

At this point, I think the best option is to simply cache the values writte=
n to
IQS620_PWR_SETTINGS_PWM_OUT and IQS620_PWM_DUTY_CYCLE and restore them from=
 the
notifier, which is essentially what is done for the IIO drivers in this ser=
ies.

This simple solution avoids messy tear-down paths and race conditions resul=
ting
from trying to piggy-back chip->pwms[0] before it may be available. As an a=
dded
bonus it also alleviates any register access from get_state, which could si=
mply
use the cached values to return the quantized duty cycle.

> > +	ret =3D iqs620_pwm_apply(&iqs620_pwm->chip, &iqs620_pwm->chip.pwms[0]=
,
> > +			       &iqs620_pwm->chip.pwms[0].state);
> > +	if (ret) {
> > +		dev_err(iqs620_pwm->chip.dev,
> > +			"Failed to re-initialize device: %d\n", ret);
> > +		return NOTIFY_BAD;
> > +	}
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static const struct pwm_ops iqs620_pwm_ops =3D {
> > +	.apply =3D iqs620_pwm_apply,
> > +	.get_state =3D iqs620_pwm_get_state,
> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> > +static void iqs620_pwm_notifier_unregister(void *context)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm =3D context;
> > +	int ret;
> > +
> > +	ret =3D blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
> > +						 &iqs620_pwm->notifier);
> > +	if (ret)
> > +		dev_err(iqs620_pwm->chip.dev,
> > +			"Failed to unregister notifier: %d\n", ret);
>=20
> 	dev_err(iqs620_pwm->chip.dev,
> 		"Failed to unregister notifier: %pe\n", ERR_PTR(ret));
>=20
> gives a nicer output. (Also applies to other error messages of course.)
>=20

I don't disagree, but this gives me some pause. If I made this change here,=
 I'd
prefer to do so across the series for consistency. However, I am hesitant t=
o do
so at this stage in the review since several patches are somewhat stable by=
 now
(unless there was a compelling reason from a functional perspective).

Another reason is that there are many dev_err cases throughout this series,=
 and
adopting this very recently introduced functionality would make the series =
even
harder to back port to the present lot of LTS kernels.

Unless this is a deal breaker, I'd like to pass on this for v4. However, pl=
ease
let me know if you feel strongly about it. In the meantime, I'll get starte=
d on
the couple of other changes discussed here.

> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Kind regards,
Jeff LaBundy
