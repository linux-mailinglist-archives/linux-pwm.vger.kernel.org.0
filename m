Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729241273C7
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2019 04:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLTDTo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Dec 2019 22:19:44 -0500
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:6023
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726964AbfLTDTo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 19 Dec 2019 22:19:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqfBTxf56n/XuRj5SJ42M81d/1xwPIIX/qulZNHvqRzskuWa+G1A1kA2SVw6fLBBht4oQkGUUpW1dPVTfAttgsT3KPYc7myC2ZIsSbEv1pfdrLDZm/fTFIdkmzb1Tn6lwmZojN1/Oy0SBHNvUIrvRg1Oul1bh76IAHpG9ogem42Jc+thw3hfnAD+n+fdB53aWrANanR8I/WEBcW8cHJhgJx+da8/KEwNzCFlPOz+X3vIg3ViI4EArWy5xralaDT+RQsCpgqHajgjUYiJemwwR94PrOsfYbf4GoXHPEiqnX+CPoro+H/QY5j4xrp6nEopEPq4ii5Yp+YjNVk+0t+eRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrYquEYMuF2pXtfMUGua143yl8C2PsS5GH9Pw2P9++M=;
 b=VRT/xMySl9Xwe9vm0rTa4wlNaLHlGht0uczIQQk6kkCrwF05ARYoOJPELBl2rSsU8l7PJoa0o3iS+91dYgxpGTNkW7BxrH3Wgekpou8XRbWaxBGs8+gJCAVNq8DVzi9QunXzTgFkAAYaoBEjQpyBmM4z6cxCkbcAmDozFrvutTXD1sxDRJxMS+mXZxUs1p1e5Ip3tvZozk99lklDlzwixMat/zftdpUI3+TbHPsxGGMNxJ7eQt8KO9o8qNdtrnIDyQ8H00yTIfoutcqkTQAK+4x0gOs0Ae9SVpwmCj4uqNjbAyvlkdvvy1K6uOq+MsZ6y57rxz2A7hLQ268RNwMLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrYquEYMuF2pXtfMUGua143yl8C2PsS5GH9Pw2P9++M=;
 b=NtjohNRgWS2VHXpz9d6P5n/HOeK1NMs7H2LuOjehmArU7rfRLXuIA1AUmuOElPLa4j93+BoT+ODmwnNfQg55e3czRYGR9CQrgB0Zkr0w8RViY8kvdq0Ic0CpxLKatAuyZXmsWFqvf1DG0t1F7BcZjWFCy3Smx+TUjDl8jNWEfuA=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4845.namprd08.prod.outlook.com (52.135.102.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 03:19:32 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2559.016; Fri, 20 Dec 2019
 03:19:32 +0000
Received: from labundy.com (136.49.227.119) by SN4PR0501CA0120.namprd05.prod.outlook.com (2603:10b6:803:42::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.7 via Frontend Transport; Fri, 20 Dec 2019 03:19:30 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Topic: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Index: AQHVrij+8yO8xEtV+ECzt9/U9i+G6qexaTEAgAEU0QCAAHrSgIAIuWeAgADVNACABeTNAA==
Date:   Fri, 20 Dec 2019 03:19:31 +0000
Message-ID: <20191220031924.GA2658@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-5-git-send-email-jeff@labundy.com>
 <20191209073206.6pftsak5v25jdepz@pengutronix.de>
 <20191210000252.GA6361@labundy.com>
 <20191210072227.434hyv5wl3rwztqx@pengutronix.de>
 <20191215203607.GA31390@labundy.com>
 <20191216091912.r4onikojbkbmguag@pengutronix.de>
In-Reply-To: <20191216091912.r4onikojbkbmguag@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0120.namprd05.prod.outlook.com
 (2603:10b6:803:42::37) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a0b1c71-c493-4107-77ae-08d784fb6de1
x-ms-traffictypediagnostic: SN6PR08MB4845:
x-microsoft-antispam-prvs: <SN6PR08MB48456A02634FF2DEDBDFD869D32D0@SN6PR08MB4845.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39830400003)(34096005)(189003)(199004)(2906002)(55016002)(7696005)(316002)(956004)(2616005)(8886007)(8936002)(8676002)(30864003)(66574012)(81156014)(5660300002)(81166006)(1076003)(66476007)(66446008)(64756008)(66556008)(66946007)(508600001)(186003)(16526019)(26005)(966005)(36756003)(4326008)(54906003)(52116002)(86362001)(7416002)(33656002)(71200400001)(6916009)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4845;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6hs9a6g6HnXLj+dnlyTPeqX1IONQnnisFTuvgdo754zZEU2Qch2cdaNwjWbXWTHmuIalgiGkSOurupELZCyupBynpqufbZXqEFfhh+8qHcYjwfNbeNq0Hn/5/VVbAnTbWLhLgluLNqVLGaI4Rn1E8OkGlgDeMJov6K7t15KYPgJDxRDh1mOwttNxBSL+7eqGiaEOVIhWroUnQWkCcq1GG716bERveHGiA4ipoXl+IeXFkcmXy7GCb5C5x8Klbf3ZmQJ8mRRoLpVg4SSRIT62vP1c23eV9inDuyQg91iU9CwQn2SryGUCIKkSda1sTvc4VhIOBC1Y6FyPnNo7e5FO+qL5Qw41oFfcNQ/nlVTnJ8D1YvZKccYDCloCwsOhDEV3eSMCm7p/dDYdI1yPAbInWglRcDy65GcnP6UL13PaKDJ5kMbRf/LcgwB/Rvx1/+6sYsUiopmoXkJuJCIvqO0sABe/Wo3bTr8PbIZJLzV21jI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <3016171A80D60E458C9A0204994D90AD@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0b1c71-c493-4107-77ae-08d784fb6de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 03:19:31.7131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etpM+tu0ycvhetPZb2USVkmiVYl4ZRul6mYgPrn308s/qm2ZUJiR3SFDX1gOd3y5uqqFNQ6/Kxqhy8c9OpIuAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4845
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

I apologize for my delayed replies as I have been traveling.

On Mon, Dec 16, 2019 at 10:19:12AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Jeff,
>=20
> On Sun, Dec 15, 2019 at 08:36:12PM +0000, Jeff LaBundy wrote:
> > On Tue, Dec 10, 2019 at 08:22:27AM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Tue, Dec 10, 2019 at 12:03:02AM +0000, Jeff LaBundy wrote:
> > > > On Mon, Dec 09, 2019 at 08:32:06AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > > On Mon, Dec 09, 2019 at 12:38:36AM +0000, Jeff LaBundy wrote:
> > > > > > This patch adds support for the Azoteq IQS620A, capable of gene=
rating
> > > > > > a 1-kHz PWM output with duty cycle between 0.4% and 100% (inclu=
sive).
> > > > > >=20
> > > > > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > >   - Merged 'Copyright' and 'Author' lines into one in introduct=
ory comments
> > > > > >   - Added 'Limitations' section to introductory comments
> > > > > >   - Replaced 'error' with 'ret' throughout
> > > > > >   - Added const qualifier to state argument of iqs620_pwm_apply=
 and removed all
> > > > > >     modifications to the variable's contents
> > > > > >   - Updated iqs620_pwm_apply to return -ENOTSUPP or -EINVAL if =
the requested
> > > > > >     polarity is inverted or the requested period is below 1 ms,=
 respectively
> > > > > >   - Updated iqs620_pwm_apply to disable the PWM output if duty =
cycle is zero
> > > > > >   - Added iqs620_pwm_get_state
> > > > > >   - Eliminated tabbed alignment of pwm_ops and platform_driver =
struct members
> > > > > >   - Moved notifier unregistration to already present iqs620_pwm=
_remove, which
> > > > > >     eliminated the need for a device-managed action and ready f=
lag
> > > > > >   - Added a comment in iqs620_pwm_probe to explain the order of=
 operations
> > > > > >   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE=
_TEST
> > > > > >=20
> > > > > >  drivers/pwm/Kconfig       |  10 +++
> > > > > >  drivers/pwm/Makefile      |   1 +
> > > > > >  drivers/pwm/pwm-iqs620a.c | 206 ++++++++++++++++++++++++++++++=
++++++++++++++++
> > > > > >  3 files changed, 217 insertions(+)
> > > > > >  create mode 100644 drivers/pwm/pwm-iqs620a.c
> > > > > >=20
> > > > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > > > index bd21655..60bcf6c 100644
> > > > > > --- a/drivers/pwm/Kconfig
> > > > > > +++ b/drivers/pwm/Kconfig
> > > > > > @@ -222,6 +222,16 @@ config PWM_IMX_TPM
> > > > > >  	  To compile this driver as a module, choose M here: the modu=
le
> > > > > >  	  will be called pwm-imx-tpm.
> > > > > >=20
> > > > > > +config PWM_IQS620A
> > > > > > +	tristate "Azoteq IQS620A PWM support"
> > > > > > +	depends on MFD_IQS62X || COMPILE_TEST
> > > > > > +	help
> > > > > > +	  Generic PWM framework driver for the Azoteq IQS620A multi-f=
unction
> > > > > > +	  sensor.
> > > > > > +
> > > > > > +	  To compile this driver as a module, choose M here: the modu=
le will
> > > > > > +	  be called pwm-iqs620a.
> > > > > > +
> > > > > >  config PWM_JZ4740
> > > > > >  	tristate "Ingenic JZ47xx PWM support"
> > > > > >  	depends on MACH_INGENIC
> > > > > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > > > > index 9a47507..a59c710 100644
> > > > > > --- a/drivers/pwm/Makefile
> > > > > > +++ b/drivers/pwm/Makefile
> > > > > > @@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
> > > > > >  obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
> > > > > >  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
> > > > > >  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
> > > > > > +obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
> > > > > >  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
> > > > > >  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
> > > > > >  obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
> > > > > > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620=
a.c
> > > > > > new file mode 100644
> > > > > > index 0000000..1ea11b9
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/pwm/pwm-iqs620a.c
> > > > > > @@ -0,0 +1,206 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > +/*
> > > > > > + * Azoteq IQS620A PWM Generator
> > > > > > + *
> > > > > > + * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
> > > > > > + *
> > > > > > + * Limitations:
> > > > > > + * - The period is not guaranteed to run to completion when th=
e duty cycle is
> > > > > > + *   changed or the output is disabled.
> > > > >=20
> > > > > Do you know more details here? "not guaranteed" means that the ne=
w
> > > > > period starts immediately when duty_cycle or the enabled bit is w=
ritten?
> > > > >=20
> > > >=20
> > > > Increasing the duty cycle on-the-fly (e.g. 25% to 75%) results in t=
he
> > > > following behavior (depending on where the I2C write falls):
> > > >=20
> > > >                        I2C write
> > > >    __        __        __  V_    ______    ______    ______    __
> > > > __|  |______|  |______|  |_|x|__|      |__|      |__|      |__|
> > > >   ^---1ms---^---1ms---^---1ms---^---1ms---^---1ms---^---1ms---^
> > > >=20
> > > > The PWM continues to tick at 1 ms, but the currently running period=
 suffers
> > > > an extraneous pulse as the output is abruptly set high to "catch up=
" to the
> > > > new duty cycle.
> > > >=20
> > > > A similar behavior can occur if the duty cycle is decreased, meanin=
g the
> > > > output is abruptly set low if the I2C transaction completes in what=
 has
> > > > suddenly become the inactive region of the currently running period=
.
> > > >=20
> > > > The PWM seems to be a simple counter that rolls over at a period of=
 1 ms.
> > > > Both the counter and the IQS620_PWM_DUTY_CYCLE register effectively=
 go to
> > > > a comparator whose output is ANDed with IQS620_PWR_SETTINGS_PWM_OUT=
 which
> > > > then drives the PWM output.
> > > >=20
> > > > As such, if either IQS620_PWM_DUTY_CYCLE or IQS620_PWR_SETTINGS_PWM=
_OUT
> > > > change, so may the PWM output state depending on the counter's valu=
e at
> > > > the time the I2C write is completed within the 1-ms continuous loop=
.
> > > >=20
> > > > For v3 I will update the note as follows:
> > > >=20
> > > > - Changes in duty cycle or enable/disable state are immediately ref=
lected
> > > >   by the PWM output and are not aligned to the start of any period.
> > >=20
> > > I'd like to see a bit more information in the driver. Something about
> > > the 1ms rhythm being unaffected by the duty_cycle and enable setting.
> > > Maybe:
> > >=20
> > >  - The periods run continuously with a fixed length of 1 ms which is
> > >    unaffected by register updates. Writing duty cycle or enable
> > >    registers gets active immediately which might result in glitches.
> > >=20
> > > ?
> > >=20
> >=20
> > I adjusted the wording a bit as per my preference and settled on the
> > following:
> >=20
> >   - The period is fixed to 1 ms and is generated continuously despite c=
hanges
> >     to the duty cycle or enable/disable state.
> >   - Changes to the duty cycle or enable/disable state take effect immed=
iately
> >     and may result in a glitch during the period in which the change is=
 made.
> >=20
> > I believe these capture the spirit of your message; please let me know =
if
> > you have any concerns.
>=20
> That's fine.
>=20
> > Upon further experimentation, I found that disabling the output (which =
v2
> > does so as to simulate a 0% duty cycle) does not actively drive zero, b=
ut
> > rather places the output in a high-impedance state with only the device=
's
> > own internal leakage eventually discharging the pin.
>=20
> But maybe this is still the best you can do in this case. @Thierry, what
> do you think?
>=20
> > This is fundamentally different than actively driving the pin low to ma=
ke
> > a 0% duty cycle, which does not appear to be possible at all. Therefore=
 I
> > have removed the control of IQS620_PWR_SETTINGS_PWM_OUT based on the du=
ty
> > cycle requested by the user and reverted to the behavior of v1, where t=
he
> > duty cycle requested by the user is mapped only to IQS620_PWM_DUTY_CYCL=
E.
> >=20
> > As such, I have also added a third bullet point similar to what you fir=
st
> > suggested following v1:
> >=20
> >   - The device cannot generate a 0% duty cycle.
>=20
> Then this would be:
>=20
>   - The device cannot actively drive a 0% duty cycle. The driver is
>     disabled for small duty_cycles relying on a pull down on the board.
>=20
> But maybe it would be more prudent to do this only if the board
> configuration suggests this is save?!
>=20

Given the policy for the actual duty cycle generated by the hardware not to
exceed that which is requested by the user, it seems there are ultimately 3
options for duty_cycle below 1 / 256 ms:

1. Return -EINVAL.
2. Disable the output as in v2.
3. Add an optional boolean in the dts that identifies whether a pull-down i=
s
   present; default to option (1) but use option (2) if the boolean is ther=
e.

I don't like option (1) because consumers (including leds-pwm) do in fact a=
sk
for a 0% duty cycle which would make iqs620_pwm_apply return an error. Thin=
gs
happen to still work since leds-pwm does not check pwm_config's return valu=
e,
but I don't want to rely on this coincidence.

Option (2) is better, but I know from experience that board designers do no=
t
consult driver comments and the requirement to add a pull-down may be easil=
y
missed as it is not discussed in the data sheet (which is where that sort o=
f
information belongs, in my opinion).

Option (3) seems like overkill for such a simple PWM, and ultimately doesn'=
t
add any value because I don't want to allow option (1) behavior in any case=
.
Whether the PWM is disabled because it is truly disabled or to simulate a 0=
%
duty cycle as in option (2), the pull-down is ultimately required regardles=
s
of whether or not the data sheet happens to go into such detail.

Therefore I have opted to carry forward option (2) from v2 to v3. I reworde=
d
the third limitation a bit as follows:

- The device cannot generate a 0% duty cycle. For duty cycles below 1 / 256
  ms, the output is disabled and relies upon an external pull-down resistor
  to hold the GPIO3/LTX pin low.

I did reach out to the vendor and asked them to consider recommending a pul=
l-
down resistor in a future revision of the data sheet, although at the time =
of
this writing I have not heard back.

> > > > > > + * - The period is fixed to 1 ms.
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/device.h>
> > > > > > +#include <linux/kernel.h>
> > > > > > +#include <linux/mfd/iqs62x.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/platform_device.h>
> > > > > > +#include <linux/pwm.h>
> > > > > > +#include <linux/regmap.h>
> > > > > > +#include <linux/slab.h>
> > > > > > +
> > > > > > +#define IQS620_PWR_SETTINGS			0xD2
> > > > > > +#define IQS620_PWR_SETTINGS_PWM_OUT		BIT(7)
> > > > > > +
> > > > > > +#define IQS620_PWM_DUTY_CYCLE			0xD8
> > > > > > +
> > > > > > +#define IQS620_PWM_PERIOD_NS			1000000
> > > > > > +
> > > > > > +struct iqs620_pwm_private {
> > > > > > +	struct iqs62x_core *iqs62x;
> > > > > > +	struct pwm_chip chip;
> > > > > > +	struct notifier_block notifier;
> > > > > > +};
> > > > > > +
> > > > > > +static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_=
device *pwm,
> > > > > > +			    const struct pwm_state *state)
> > > > > > +{
> > > > > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > > > > +	struct iqs62x_core *iqs62x;
> > > > > > +	unsigned int pwm_out =3D 0;
> > > > > > +	int duty_scale, ret;
> > > > > > +
> > > > > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > > > > +		return -ENOTSUPP;
> > > > > > +
> > > > > > +	if (state->period < IQS620_PWM_PERIOD_NS)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, =
chip);
> > > > > > +	iqs62x =3D iqs620_pwm->iqs62x;
> > > > > > +
> > > > > > +	duty_scale =3D DIV_ROUND_CLOSEST(state->duty_cycle * 256,
> > > > > > +				       IQS620_PWM_PERIOD_NS);
> > > > > > +
> > > > > > +	if (duty_scale) {
> > > > > > +		ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
> > > > > > +				   min(duty_scale - 1, 0xFF));
> > > > > > +		if (ret)
> > > > > > +			return ret;
> > > > > > +
> > > > > > +		if (state->enabled)
> > > > > > +			pwm_out =3D IQS620_PWR_SETTINGS_PWM_OUT;
> > > > > > +	}
> > > > > > +
> > > > > > +	return regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> > > > > > +				  IQS620_PWR_SETTINGS_PWM_OUT, pwm_out);
> > > > >=20
> > > > > A comment explaining the semantic here would be good. I assume
> > > > > IQS620_PWM_DUTY_CYCLE takes a value between 0 and 255 and the res=
ulting
> > > > > duty cycle is:
> > > > >=20
> > > > > 	(IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
> > > > >=20
> > > > > .
> > > > >=20
> > > > > If this is right, please use:
> > > > >=20
> > > > > 	duty_scale =3D (state->duty_cycle * 256) / IQS620_PWM_PERIOD_NS
> > > > >=20
> > > >=20
> > > > Sure thing, will do. I'll add a comment and round down. Your assump=
tion is
> > > > correct as well.
> > > >=20
> > > > > Also, when the hardware is running at
> > > > >=20
> > > > > 	.enabled =3D 1, .duty_cycle =3D 1/256 ms, .period =3D 1ms
> > > > >=20
> > > > > and you reconfigure to
> > > > >=20
> > > > > 	.enabled =3D 0, .duty_cycle =3D 1ms, .period =3D 1ms
> > > > >=20
> > > > > the output might be active for > 1/256 ms if the process is preem=
pted
> > > > > between writing IQS620_PWM_DUTY_CYCLE and IQS620_PWR_SETTINGS_PWM=
_OUT.
> > > > >=20
> > > >=20
> > > > Good catch. I think we can solve this by writing IQS620_PWM_DUTY_CY=
CLE
> > > > first followed by IQS620_PWR_SETTINGS_PWM_OUT when the PWM is going=
 to
> > > > be enabled, and the reverse when the PWM is going to be disabled (i=
.e.
> > > > turn OFF to prevent a stale duty cycle from being temporarily drive=
n).
> > >=20
> > > Sounds like a plan. After disabling you even don't need to write the
> > > duty cycle register. (But there might be a discussion ahead that
> > > .get_state should return the duty cycle.)
> > > =20
> >=20
> > For v3, I've opted to write IQS620_PWM_DUTY_CYCLE regardless of whether=
 the PWM
> > is enabled as a matter of principle (i.e. faithfully pass the entire st=
ate down
> > to the hardware without making assumptions).
> >=20
> > And since some consumers (e.g. leds-pwm, the primary use-case for this =
PWM) may
> > pre-configure the duty cycle while the PWM is disabled, this method ens=
ures the
> > driver is already compliant in case 01ccf903edd6 returns.
> >=20
> > Also, as mentioned above, I have dropped the automatic disabling of the=
 PWM to
> > simulate a 0% duty cycle if the requested duty cycle is < 1 / 256 ms si=
nce the
> > device does not actively drive a zero with IQS620_PWR_SETTINGS_PWM_OUT =
=3D 0. In
> > the interest of transparency, here is what I currently have for v3:
> >=20
> > static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> > 			    const struct pwm_state *state)
> > {
> > 	struct iqs620_pwm_private *iqs620_pwm;
> > 	struct iqs62x_core *iqs62x;
> > 	int duty_scale, ret;
> >=20
> > 	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > 		return -ENOTSUPP;
> >=20
> > 	if (state->period < IQS620_PWM_PERIOD_NS)
> > 		return -EINVAL;
> >=20
> > 	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
> > 	iqs62x =3D iqs620_pwm->iqs62x;
> >=20
> > 	if (!state->enabled) {
> > 		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> > 					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
> > 		if (ret)
> > 			return ret;
> > 	}
> >=20
> > 	/*
> > 	 * The duty cycle generated by the device is calculated as follows:
> > 	 *
> > 	 * duty_cycle =3D (IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
> > 	 *
> > 	 * ...where IQS620_PWM_DUTY_CYCLE is a register value between 0 and 25=
5
> > 	 * (inclusive). Therefore the lowest duty cycle the device can generat=
e
> > 	 * while the output is enabled is 1 / 256 ms.
> > 	 */
> > 	duty_scale =3D state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS - 1;
>=20
> Hmm, this is violating the policy to implement a value not bigger than
> requested with state->duty_cycle =3D=3D 0. I see this has downsides to no=
t
> simply cheat here, but only claiming to have implemented 0% can hurt,
> too. pwm-rcar returns -EINVAL in this case.
>=20

That's a great point and is addressed by sticking with option (2) described
above. Here is what I've got for v3:

static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
			    const struct pwm_state *state)
{
	struct iqs620_pwm_private *iqs620_pwm;
	struct iqs62x_core *iqs62x;
	int duty_scale, ret;

	if (state->polarity !=3D PWM_POLARITY_NORMAL)
		return -ENOTSUPP;

	if (state->period < IQS620_PWM_PERIOD_NS)
		return -EINVAL;

	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
	iqs62x =3D iqs620_pwm->iqs62x;

	mutex_lock(&iqs620_pwm->lock);

	/*
	 * The duty cycle generated by the device is calculated as follows:
	 *
	 * duty_cycle =3D (IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
	 *
	 * ...where IQS620_PWM_DUTY_CYCLE is a register value between 0 and 255
	 * (inclusive). Therefore the lowest duty cycle the device can generate
	 * while the output is enabled is 1 / 256 ms.
	 *
	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
	 * allow an on-board pull-down resistor to hold the GPIO3/LTX pin low.
	 */
	duty_scale =3D state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS;

	if (!state->enabled || !duty_scale) {
		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
		if (ret)
			goto err_mutex;
	}

	if (duty_scale) {
		ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
				   min(duty_scale - 1, 0xFF));
		if (ret)
			goto err_mutex;
	}

	if (state->enabled && duty_scale)
		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
					 IQS620_PWR_SETTINGS_PWM_OUT, 0xFF);

err_mutex:
	mutex_unlock(&iqs620_pwm->lock);

	return ret;
}

And for the get_state callback:

static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device *=
pwm,
				 struct pwm_state *state)
{
	struct iqs620_pwm_private *iqs620_pwm;
	struct iqs62x_core *iqs62x;
	unsigned int val;
	int ret;

	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
	iqs62x =3D iqs620_pwm->iqs62x;

	mutex_lock(&iqs620_pwm->lock);

	ret =3D regmap_read(iqs62x->map, IQS620_PWR_SETTINGS, &val);
	if (ret)
		goto err_mutex;
	state->enabled =3D val & IQS620_PWR_SETTINGS_PWM_OUT;

	ret =3D regmap_read(iqs62x->map, IQS620_PWM_DUTY_CYCLE, &val);
	if (ret)
		goto err_mutex;
	state->duty_cycle =3D DIV_ROUND_UP((val + 1) * IQS620_PWM_PERIOD_NS, 256);
	state->period =3D IQS620_PWM_PERIOD_NS;

err_mutex:
	mutex_unlock(&iqs620_pwm->lock);

	if (ret)
		dev_err(iqs620_pwm->chip.dev, "Failed to get state: %d\n", ret);
}

If you and/or Thierry have any concerns, please let me know.

> > 	ret =3D regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE,
> > 			   clamp(duty_scale, 0, 0xFF));
> > 	if (ret)
> > 		return ret;
>=20
> I understand your motivation to configure the duty cycle also when the
> the request has enabled=3Dfalse, but a strange side effect is that a
> failure to configure the dutycycle with .enabled=3Dfalse isn't really a
> problem, is it?
> (This is not a request to change anything, it's only expression of my
> frustration that we cannot get away without strange effects.)
>=20

True, but it would definitely be a problem in case 01ccf903edd6 returns and
we're relying on the device's own registers to hold the PWM state.

Thinking about this more, I agree with your earlier comment that a means to
get the actual (quantized) state needs to be a new API function (of integer
type). Since chip->ops->get_state is void, there is no way for the callback
to warn the core that a register read failed and the PWM state may be junk.

> >=20
> > 	if (state->enabled)
> > 		ret =3D regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
> > 					 IQS620_PWR_SETTINGS_PWM_OUT, 0xFF);
> >=20
> > 	return ret;
> > }
> >=20
> > I believe this captures all of the discussion thus far; please let me k=
now if you
> > have any concerns.
> >=20
> > > > > > +static int iqs620_pwm_notifier(struct notifier_block *notifier=
,
> > > > > > +			       unsigned long event_flags, void *context)
> > > > > > +{
> > > > > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > > > > +	struct pwm_state state;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	if (!(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
> > > > > > +		return NOTIFY_DONE;
> > > > > > +
> > > > > > +	iqs620_pwm =3D container_of(notifier, struct iqs620_pwm_priva=
te,
> > > > > > +				  notifier);
> > > > > > +	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
> > > > >=20
> > > > > Please don't call pwm API functions in callbacks. I assume you re=
ly on
> > > > > pwm_get_state returning the previously set state and that
> > > > > iqs620_pwm_get_state isn't called. Please use pwm->state for that=
.
> > > > >=20
> > > >=20
> > > > Sure thing, will do. Your assumption is correct. If pwm_get_state c=
alled
> > > > chip->ops->get_state instead of return pwm->state as it does today,=
 this
> > > > function would break because it would restore the hardware using de=
fault
> > > > register values (since this function follows a reset).
> > > >=20
> > > > Just for my own understanding, are you saying the PWM framework res=
erves
> > > > the right to update pwm_get_state to call chip->ops->get_state some=
 time
> > > > in the future? In any event I will refer to pwm->state as that is w=
hat I
> > > > ultimately need here.
> > >=20
> > > This already was the case for a short time before v5.4. See 01ccf903e=
dd6
> > > and 40a6b9a00930. (And note that the lazyness mentioned above about n=
ot
> > > needing to write duty_cycle when the PWM is off is what made the
> > > approach break however.) I don't know yet how to proceed here. Being
> > > able to get the actually implemented setting would be nice, probably =
it
> > > is prudent to do this with another API function.
> > >=20
> > > Other than that I consider it a layer violation to call a function th=
at
> > > is designed for consumers in a lowlevel driver. I don't know if we ne=
ed
> > > locking at some time, but if the core holded a lock when .apply is
> > > called, .apply calls pwm_get_state which wanted to grab the lock agai=
n
> > > we get a dead-lock.
> >=20
> > I think we may be imagining two different hazards (please correct me if=
 I have
> > misunderstood). Originally I thought you were warning that pwm_get_stat=
e (which
> > simply returns pwm->state) may in the future call chip->ops->get_state =
instead,
> > which here would have caused iqs620_pwm_notifier to call iqs620_pwm_app=
ly with
> > a reset-like state rather than the last state requested by the user (si=
nce this
> > notifier is called after the device resets itself).
> >=20
> > The short-lived change during the 5.4-rc phase, however, was to fill pw=
m->state
> > in pwm_apply_state with the quantized state from the hardware instead o=
f the raw
> > state requested by the user. Whether pwm->state (accessed directly or b=
y calling
> > pwm_get_state) gives the raw state or the quantized output of get_state=
 following
> > the last call to pwm_apply_state does not change the outcome (for this =
particular
> > driver) because iqs620_pwm_apply ultimately writes the same register va=
lues. Just
> > to be safe, I've been testing with and without 01ccf903edd6 applied loc=
ally so as
> > to validate the behavior in both scenarios.
> >=20
> > What I missed originally is that pwm_get_state is intended for consumer=
s only, in
> > which case I agree it is fundamentally wrong to cannibalize it in the d=
river. For
> > v3 I have changed iqs620_pwm_notifier to reference pwm->state directly =
since that
> > is what is ultimately needed in the first place.
> >=20
> > You're correct that a lock within the core would cause a deadlock; in t=
his case I
> > was proposing a lock around the pair of reads/writes to IQS620_PWM_DUTY=
_CYCLE and
> > IQS620_PWR_SETTINGS_PWM_OUT since v2 introduced an implied relationship=
 between
> > the two. That would be safe since chip->ops->apply returns before pwm_a=
pply_state
> > calls chip->ops->get_state.
> >=20
> > However, even that is no longer necessary since IQS620_PWR_SETTINGS_PWM=
_OUT is now
> > written independently of IQS620_PWM_DUTY_CYCLE due to withdrawing suppo=
rt for a 0%
> > duty cycle starting in v3. In short, I didn't end up adding any locks a=
s there was
> > no need.
>=20
> That's fine. I'm not sure we actually need locks in the framework in the
> long run because (other than clocks) a PWM always has at most a single
> consumer and up to now it seems reasonable that this single consumer
> doesn't race with itself.
> =20

Agreed. You will see that I have added my own lock in the apply/get_state f=
unctions
now that I've restored v2's behavior, but that is to account for this devic=
e's case
where its interrupt handler is in the process of re-initializing the couple=
 of PWM-
related registers when get_state is called.

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
