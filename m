Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F2B117C09
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Dec 2019 01:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLJADR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Dec 2019 19:03:17 -0500
Received: from mail-eopbgr680063.outbound.protection.outlook.com ([40.107.68.63]:54094
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727286AbfLJADR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 9 Dec 2019 19:03:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZfUDAnh9Q+mAPiv9b1M1TEpvtDnOFBX+GNTiXAZQumLzPcNXnt8eCZfg2snmULLH4TExxcsf7q3sdCdKySeIdyNcTv0EZ7J2MAUxsi8oa3vTCI1LdwgOhmXaGbFsR80mgUpBXG8+cQ9y0Unrnl+CgxSc1viAQmJLWQqrmbiZXrCzgIlECq0So8terZ/94Ry/uBeWOfibqS2bKX0/BX13a5+IZL+4x9zFtQ9UFJedrQr9tcUkCw4QIJjFeJbprxD3ts+K0QatL/dgnx5msX4C62esLQS1QqcUlz0ooFASA2PmaeR5DSmGmdWVK+JWkDTIPYBZsZX8/vHRm/wHOmkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TH+Sxc7Ugx9S37ZYZhG79e6JTikyl4x1528n/mcIEU=;
 b=BBIS4G4sqd2kHOGBaJrgoapfEWWs53V0jnWpSYfwPaQghdg5qIwPQANmGxTRY7/t0rvrZf59JFpo8/egDLixzF/KT1w2gnkV9aaCqCIl6gAmzSmeFXkFXBzLYBe6mKY9Vnx4Xm68gWAW3H/hrkwgmZzUeA5/JAjStK+0eOH10IsMddDo4I066ouxQND5bjy9+qDBLn6C2v0b9qhRLR1kBY0Igifh80EZVw/wxSaJflL3ZyFLLZnuFfno8UJpWijxc782hNdqhbrHARcBYSPxWUtVcgUuFCVkm5hXX24GDDt2GtKKF4Jjqb7gbN+a8Q7E1tUkx0mS8AVrVsct7+EBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TH+Sxc7Ugx9S37ZYZhG79e6JTikyl4x1528n/mcIEU=;
 b=sZTOQwEuN4hDIH7krCdsAi/OH1Hus5RcN192uTY1li3uVojvNizrpvwqoBv9LFGGqo1mTpnMZ3K/gBBtks5ExzBKhxnK6htmN29cxayo++UexN7kSXMQ/jtUW7cOntjc2jjzK2JxhpYkI7Bg4aFtrlAbUXIvHC0zmJT7rW74JV0=
Received: from BN7PR08MB5042.namprd08.prod.outlook.com (20.176.177.14) by
 BN7PR08MB4884.namprd08.prod.outlook.com (20.176.27.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 00:03:03 +0000
Received: from BN7PR08MB5042.namprd08.prod.outlook.com
 ([fe80::48de:9418:73ef:d7c1]) by BN7PR08MB5042.namprd08.prod.outlook.com
 ([fe80::48de:9418:73ef:d7c1%6]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 00:03:03 +0000
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
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Topic: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Index: AQHVrij+8yO8xEtV+ECzt9/U9i+G6qexaTEAgAEU0QA=
Date:   Tue, 10 Dec 2019 00:03:02 +0000
Message-ID: <20191210000252.GA6361@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-5-git-send-email-jeff@labundy.com>
 <20191209073206.6pftsak5v25jdepz@pengutronix.de>
In-Reply-To: <20191209073206.6pftsak5v25jdepz@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0103.namprd12.prod.outlook.com
 (2603:10b6:802:21::38) To BN7PR08MB5042.namprd08.prod.outlook.com
 (2603:10b6:408:2c::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ac041fb-1f02-49a7-bd7d-08d77d045320
x-ms-traffictypediagnostic: BN7PR08MB4884:
x-microsoft-antispam-prvs: <BN7PR08MB4884F9D02E8023A770569900D35B0@BN7PR08MB4884.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(136003)(346002)(34096005)(366004)(376002)(396003)(501634003)(199004)(189003)(6506007)(6512007)(4326008)(2616005)(305945005)(186003)(26005)(229853002)(6916009)(8936002)(81166006)(8676002)(71190400001)(81156014)(71200400001)(36756003)(1076003)(2906002)(66574012)(66946007)(54906003)(33656002)(66446008)(5660300002)(66476007)(52116002)(6486002)(30864003)(38610400001)(586005)(7416002)(66556008)(498600001)(86362001)(966005)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB4884;H:BN7PR08MB5042.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DkghDTWw2adpDius7Wyxs2/+I1ewXpTReGuOVGoqQj1mb2A/+XB78frzjRa/SLfDytmHp9BK1fhFI8w534mMlfmoC1HQwd6fmwFJL2W7I3f5Mv7xLu+rCXl37AxXrbmZFFNRaG6vQwqUUkZJgNlcj2IY49QUSjacDnu+783mCs5dhcKzoeH2uW0DqqHM5fzMrzBrggcjFcBTFsMFCWC8Et8AEkc/vp3yWnP4teiyalck3muP2utnX0LHntzIGn8KSGs/rXB6i6d1ulq5e1NRrfpzb+HOkpIQe9yx1em4im6NXl4K0snOQ3E8WDtGGAYXeGRr2FWnqbd5uOm42RfnfJx6HhxlMi2Y+xGvfSwtuRGmHlQKHdXt726l9eoXVR3+xus34ru2EyYmUYtGxfscGF8chRsy/GqrqFcwbaeKsDpsU42LeKrmBvAieegIO0uSOuDG7BfOBHUk/ZXoIgkqEsbvs+UovxrYv5fbTbbSDyUzTfRbmKEoi1irc2ZXUk2oXB0jm2+Yuj2Yrk9r8kUTLkr0upR09ACGlBLmFuClz7w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2C206301E7CC524A9910495803F7A961@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac041fb-1f02-49a7-bd7d-08d77d045320
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 00:03:02.6615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nnqKdMy1gZnrUzuigcOkMDzOKcQqkG1dBcEf1JPeWKeaII0JD2MvFf3p9nVMR8SAnYJXKGqht0ohaD0e5CkYPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4884
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for your continued support on this project.

On Mon, Dec 09, 2019 at 08:32:06AM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Dec 09, 2019 at 12:38:36AM +0000, Jeff LaBundy wrote:
> > This patch adds support for the Azoteq IQS620A, capable of generating
> > a 1-kHz PWM output with duty cycle between 0.4% and 100% (inclusive).
> >=20
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > ---
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
> >  drivers/pwm/Kconfig       |  10 +++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-iqs620a.c | 206 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 217 insertions(+)
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
> > index 0000000..1ea11b9
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-iqs620a.c
> > @@ -0,0 +1,206 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Azoteq IQS620A PWM Generator
> > + *
> > + * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
> > + *
> > + * Limitations:
> > + * - The period is not guaranteed to run to completion when the duty c=
ycle is
> > + *   changed or the output is disabled.
>=20
> Do you know more details here? "not guaranteed" means that the new
> period starts immediately when duty_cycle or the enabled bit is written?
>=20

Increasing the duty cycle on-the-fly (e.g. 25% to 75%) results in the
following behavior (depending on where the I2C write falls):

                       I2C write
   __        __        __  V_    ______    ______    ______    __
__|  |______|  |______|  |_|x|__|      |__|      |__|      |__|
  ^---1ms---^---1ms---^---1ms---^---1ms---^---1ms---^---1ms---^

The PWM continues to tick at 1 ms, but the currently running period suffers
an extraneous pulse as the output is abruptly set high to "catch up" to the
new duty cycle.

A similar behavior can occur if the duty cycle is decreased, meaning the
output is abruptly set low if the I2C transaction completes in what has
suddenly become the inactive region of the currently running period.

The PWM seems to be a simple counter that rolls over at a period of 1 ms.
Both the counter and the IQS620_PWM_DUTY_CYCLE register effectively go to
a comparator whose output is ANDed with IQS620_PWR_SETTINGS_PWM_OUT which
then drives the PWM output.

As such, if either IQS620_PWM_DUTY_CYCLE or IQS620_PWR_SETTINGS_PWM_OUT
change, so may the PWM output state depending on the counter's value at
the time the I2C write is completed within the 1-ms continuous loop.

For v3 I will update the note as follows:

- Changes in duty cycle or enable/disable state are immediately reflected
  by the PWM output and are not aligned to the start of any period.

> > + * - The period is fixed to 1 ms.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/iqs62x.h>
> > +#include <linux/module.h>
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
> > +};
> > +
> > +static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > +			    const struct pwm_state *state)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +	struct iqs62x_core *iqs62x;
> > +	unsigned int pwm_out =3D 0;
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
> > +	duty_scale =3D DIV_ROUND_CLOSEST(state->duty_cycle * 256,
> > +				       IQS620_PWM_PERIOD_NS);
> > +
> > +	if (duty_scale) {
> > +		ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
> > +				   min(duty_scale - 1, 0xFF));
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (state->enabled)
> > +			pwm_out =3D IQS620_PWR_SETTINGS_PWM_OUT;
> > +	}
> > +
> > +	return regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> > +				  IQS620_PWR_SETTINGS_PWM_OUT, pwm_out);
>=20
> A comment explaining the semantic here would be good. I assume
> IQS620_PWM_DUTY_CYCLE takes a value between 0 and 255 and the resulting
> duty cycle is:
>=20
> 	(IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
>=20
> .
>=20
> If this is right, please use:
>=20
> 	duty_scale =3D (state->duty_cycle * 256) / IQS620_PWM_PERIOD_NS
>=20

Sure thing, will do. I'll add a comment and round down. Your assumption is
correct as well.

> Also, when the hardware is running at
>=20
> 	.enabled =3D 1, .duty_cycle =3D 1/256 ms, .period =3D 1ms
>=20
> and you reconfigure to
>=20
> 	.enabled =3D 0, .duty_cycle =3D 1ms, .period =3D 1ms
>=20
> the output might be active for > 1/256 ms if the process is preempted
> between writing IQS620_PWM_DUTY_CYCLE and IQS620_PWR_SETTINGS_PWM_OUT.
>=20

Good catch. I think we can solve this by writing IQS620_PWM_DUTY_CYCLE
first followed by IQS620_PWR_SETTINGS_PWM_OUT when the PWM is going to
be enabled, and the reverse when the PWM is going to be disabled (i.e.
turn OFF to prevent a stale duty cycle from being temporarily driven).

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
> > +	ret =3D regmap_read(iqs62x->map, IQS620_PWR_SETTINGS, &val);
> > +	if (ret)
> > +		goto err_out;
> > +	state->enabled =3D val & IQS620_PWR_SETTINGS_PWM_OUT;
> > +
> > +	ret =3D regmap_read(iqs62x->map, IQS620_PWM_DUTY_CYCLE, &val);
> > +	if (ret)
> > +		goto err_out;
> > +	state->duty_cycle =3D DIV_ROUND_CLOSEST((val + 1) * IQS620_PWM_PERIOD=
_NS,
> > +					      256);
>=20
> Please round up.
>=20

Sure thing, will do.

> > +	state->period =3D IQS620_PWM_PERIOD_NS;
> > +
> > +err_out:
> > +	if (ret)
> > +		dev_err(iqs620_pwm->chip.dev, "Failed to get state: %d\n", ret);
> > +}
> > +
> > +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> > +			       unsigned long event_flags, void *context)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +	struct pwm_state state;
> > +	int ret;
> > +
> > +	if (!(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
> > +		return NOTIFY_DONE;
> > +
> > +	iqs620_pwm =3D container_of(notifier, struct iqs620_pwm_private,
> > +				  notifier);
> > +	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
>=20
> Please don't call pwm API functions in callbacks. I assume you rely on
> pwm_get_state returning the previously set state and that
> iqs620_pwm_get_state isn't called. Please use pwm->state for that.
>=20

Sure thing, will do. Your assumption is correct. If pwm_get_state called
chip->ops->get_state instead of return pwm->state as it does today, this
function would break because it would restore the hardware using default
register values (since this function follows a reset).

Just for my own understanding, are you saying the PWM framework reserves
the right to update pwm_get_state to call chip->ops->get_state some time
in the future? In any event I will refer to pwm->state as that is what I
ultimately need here.

FWIW, I borrowed the idea from the resume callback of [0] which possibly
suffers the same fate if I have understood the concern correctly.

This discussion also made me realize that we need a lock around back-to-
back access to IQS620_PWR_SETTINGS_PWM_OUT and IQS620_PWM_DUTY_CYCLE in
case iqs620_pwm_get_state is called while iqs620_pwm_apply restores them
on behalf of iqs620_pwm_notifier. I will add that in v3.

> > +	ret =3D iqs620_pwm_apply(&iqs620_pwm->chip,
> > +			       &iqs620_pwm->chip.pwms[0], &state);
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
> > +static int iqs620_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +	int ret1, ret2;
> > +
> > +	iqs620_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*iqs620_pwm), GFP_KERN=
EL);
> > +	if (!iqs620_pwm)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, iqs620_pwm);
> > +	iqs620_pwm->iqs62x =3D dev_get_drvdata(pdev->dev.parent);
> > +
> > +	iqs620_pwm->chip.dev =3D &pdev->dev;
> > +	iqs620_pwm->chip.ops =3D &iqs620_pwm_ops;
> > +	iqs620_pwm->chip.base =3D -1;
> > +	iqs620_pwm->chip.npwm =3D 1;
> > +
> > +	ret1 =3D pwmchip_add(&iqs620_pwm->chip);
> > +	if (ret1) {
> > +		dev_err(&pdev->dev, "Failed to add device: %d\n", ret1);
> > +		return ret1;
> > +	}
> > +
> > +	/*
> > +	 * Since iqs620_pwm_notifier uses iqs620_pwm->chip.pwms[], the notifi=
er
> > +	 * is not registered until pwmchip_add (which allocates that array) h=
as
> > +	 * been called. If registration fails, the newly added device has to =
be
> > +	 * removed because the driver fails to probe and iqs620_pwm_remove wi=
ll
> > +	 * never be called.
> > +	 */
> > +	iqs620_pwm->notifier.notifier_call =3D iqs620_pwm_notifier;
> > +	ret1 =3D blocking_notifier_chain_register(&iqs620_pwm->iqs62x->nh,
> > +						&iqs620_pwm->notifier);
> > +	if (ret1) {
> > +		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret1);
> > +
> > +		ret2 =3D pwmchip_remove(&iqs620_pwm->chip);
> > +		if (ret2) {
> > +			dev_err(&pdev->dev, "Failed to remove device: %d\n",
> > +				ret2);
> > +			return ret2;
>=20
> This exitpoint is bad. The PWM driver is active but the module gets
> unloaded. I liked the approach from v1 better.
>=20

Sure thing, I'll revert the behavior to that of v1.

> ret2 could be local to this block.
>=20

This will go away automatically.

> > +		}
> > +	}
> > +
> > +	return ret1;
> > +}
>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

[0] drivers/pwm/pwm-atmel-hlcdc.c

Kind regards,
Jeff LaBundy
