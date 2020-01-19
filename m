Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C527142086
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jan 2020 23:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgASWkl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jan 2020 17:40:41 -0500
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:62177
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728827AbgASWkl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 19 Jan 2020 17:40:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbCxSxzFylmUmCM235HGhzXoJB/HXemLuCjWZAIjxn7ZGqsCZH3/aT+2MMZqTY2Xs0hGoVEjfE5VtqlDWUKlQCgj3blonCBjDApy9M7XLp/4RIVF+wOOLba935AWZQYoVwlOP+mVjvy72UWhjnVCehn4dvENc5tGQQ/7ZwwTJDQppEpJesbsL2cf6A7UqEJPjA1tn8TkJqOBCqR5G/eojVBiLfF+5yB9I5F/3ab2K1E0p6nKMgBEX0Y/lMMuD0jlMKpD86AtmdsBBJXEW/SbuuPSHzv892axTl1efAxQOfkBMsJMdozTNmvIHUAmMxU5zvE7f5UuaAVvjO5y9LLVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT+NavxxccjGWFGEYOJgFihWtzZ136SFtAK7lTPMU1w=;
 b=HnuEp0JaGO1xpDDrPv9ZYUgqOVqwNYc08ZgxgdYVDW7RXedLe3K27ZP3KuOrVXaf2N7vkN0JnDtmgT5ezoGiMiYdkt2tC+ueZOPHbGjjSGQ52z506gJrTLWLPqjP/bXxg6wWMU8DxGbSuo/LpAbfBuFK8H3r02Npavf5T8sbaKzujuLnXBVWShaJi7aRkFlEDtq1wbWOx0GIH/fdi083yV2LNo5Oxd9/R0jqSAgTwhZ65RL3z7XPLrxu0scFligpNGw2SbMFbSxJg+KGEalFhvngTe6gqKtWgv768YwtUDYxSHUitdcYNgGvz4N1PEy6ATn3+gVmpwSG9UigN7rLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT+NavxxccjGWFGEYOJgFihWtzZ136SFtAK7lTPMU1w=;
 b=hvLUxIn4NgjjYxsSjqxDu9MElqkw8xWZxEqUTuADWaNzS9LNJ/jcoAGPKXOmgVWvKDbm9KjQq6cxgKfN94kvpBQAcmKtc94/E/E9bj/cN9kwJXALIqxJ03tNazhDkm9+A+CNMxXCvHmGsGwldHBUO1kLXtDGzYkTFJsdtZrQb0w=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB3886.namprd08.prod.outlook.com (52.132.123.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Sun, 19 Jan 2020 22:40:32 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2644.024; Sun, 19 Jan 2020
 22:40:32 +0000
Received: from labundy.com (136.49.227.119) by SN4PR0601CA0024.namprd06.prod.outlook.com (2603:10b6:803:2f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Sun, 19 Jan 2020 22:40:31 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v4 3/7] input: keyboard: Add support for Azoteq
 IQS620A/621/622/624/625
Thread-Topic: [PATCH v4 3/7] input: keyboard: Add support for Azoteq
 IQS620A/621/622/624/625
Thread-Index: AQHVzN7S3WaU3fEi802yBA1xu40FmafvYccAgAM3XIA=
Date:   Sun, 19 Jan 2020 22:40:31 +0000
Message-ID: <20200119224025.GA28865@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-4-git-send-email-jeff@labundy.com>
 <20200117213330.GF47797@dtor-ws>
In-Reply-To: <20200117213330.GF47797@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0024.namprd06.prod.outlook.com
 (2603:10b6:803:2f::34) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbe35c30-5780-405e-9c35-08d79d309738
x-ms-traffictypediagnostic: SN6PR08MB3886:
x-microsoft-antispam-prvs: <SN6PR08MB3886DBFDFA8277513D74FBFFD3330@SN6PR08MB3886.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0287BBA78D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39830400003)(366004)(136003)(346002)(199004)(189003)(4326008)(2906002)(7416002)(36756003)(30864003)(1076003)(2616005)(16526019)(956004)(33656002)(26005)(186003)(86362001)(55016002)(5660300002)(52116002)(7696005)(316002)(508600001)(8676002)(8936002)(81166006)(81156014)(6916009)(64756008)(66556008)(66446008)(66946007)(71200400001)(8886007)(66476007)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB3886;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mxgsBYaWI2ce7cUaBNaa0pHDCLp8EMO1pJF4j021xLEpU8NYTJ9DzxhaBhmdfr1T9Vb2yARKJImoQige+HI346fRZhRbaRiDRizwvm68lnAUrnsD6a2r1pHiEYKCqmMLnpxjuxAtd1o7cAx6ioyvEWLThrZmihgfl4v50cJGi63hH8/RBxrsxhUvWNTyAJyg3/NS5vJbSaRHYdySYVzs31z3CdwPAHyiKrPI/lo8m0HuYAUHRecLycg+IXl4PZ5qEMIwYy7bkAZzSCZY/xHr4DLuNlC8kaT3UCCpdPpHiM034TGNJ1JPAUkB4vKfPcCor38xT91Sc2W81AS+ZH6t27H/TndgI0/EvB40YCF0VgQqi0i8ecm+CE6enx5fReMzccuFFqrwevR6lsA7+0tfLSbtL+zZ/uDqA8KKSvM6qIoYFIuNxg2oPhS7X8cdt2ie
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3EF35AA8512B74A9CD97B07DE10CAB5@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe35c30-5780-405e-9c35-08d79d309738
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2020 22:40:32.0733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2wYNh4IEz678AVskvdw0wlcOYEQhhISnQCl9UJZU3TPUvd1Li4SXQB81ovpzpvbI3ioVCKqCoMv+uFSvXCc1Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB3886
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Dmitry,

Thank you for your continued support on this project.

On Fri, Jan 17, 2020 at 01:33:30PM -0800, dmitry.torokhov@gmail.com wrote:
> Hi Jeff,
>=20
> On Fri, Jan 17, 2020 at 02:35:46AM +0000, Jeff LaBundy wrote:
> > This patch adds key and switch support for the Azoteq IQS620A,
> > IQS621, IQS622, IQS624 and IQS625 multi-function sensors.
> >=20
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > ---
> > Changes in v4:
> >   - None
> >=20
> > Changes in v3:
> >   - None
> >=20
> > Changes in v2:
> >   - Merged 'Copyright' and 'Author' lines into one in introductory comm=
ents
> >   - Replaced 'error' with 'ret' throughout
> >   - Updated iqs62x_keys_parse_prop to use unified device property inter=
face
> >   - Clarified the comment in iqs62x_keys_notifier to state that wheel u=
p or
> >     down events elicit an emulated release cycle
> >   - Eliminated tabbed alignment of platform_driver struct members
> >=20
> >  drivers/input/keyboard/Kconfig       |  10 ++
> >  drivers/input/keyboard/Makefile      |   1 +
> >  drivers/input/keyboard/iqs62x-keys.c | 340 +++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 351 insertions(+)
> >  create mode 100644 drivers/input/keyboard/iqs62x-keys.c
> >=20
> > diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kc=
onfig
> > index 4706ff0..28de965 100644
> > --- a/drivers/input/keyboard/Kconfig
> > +++ b/drivers/input/keyboard/Kconfig
> > @@ -663,6 +663,16 @@ config KEYBOARD_IPAQ_MICRO
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called ipaq-micro-keys.
> >=20
> > +config KEYBOARD_IQS62X
> > +	tristate "Azoteq IQS620A/621/622/624/625 keys and switches"
> > +	depends on MFD_IQS62X
> > +	help
> > +	  Say Y here to enable key and switch support for the Azoteq IQS620A,
> > +	  IQS621, IQS622, IQS624 and IQS625 multi-function sensors.
> > +
> > +	  To compile this driver as a module, choose M here: the module will
> > +	  be called iqs62x-keys.
> > +
> >  config KEYBOARD_OMAP
> >  	tristate "TI OMAP keypad support"
> >  	depends on ARCH_OMAP1
> > diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/M=
akefile
> > index f5b1752..1d689fd 100644
> > --- a/drivers/input/keyboard/Makefile
> > +++ b/drivers/input/keyboard/Makefile
> > @@ -28,6 +28,7 @@ obj-$(CONFIG_KEYBOARD_TCA8418)		+=3D tca8418_keypad.o
> >  obj-$(CONFIG_KEYBOARD_HIL)		+=3D hil_kbd.o
> >  obj-$(CONFIG_KEYBOARD_HIL_OLD)		+=3D hilkbd.o
> >  obj-$(CONFIG_KEYBOARD_IPAQ_MICRO)	+=3D ipaq-micro-keys.o
> > +obj-$(CONFIG_KEYBOARD_IQS62X)		+=3D iqs62x-keys.o
> >  obj-$(CONFIG_KEYBOARD_IMX)		+=3D imx_keypad.o
> >  obj-$(CONFIG_KEYBOARD_IMX_SC_KEY)	+=3D imx_sc_key.o
> >  obj-$(CONFIG_KEYBOARD_HP6XX)		+=3D jornada680_kbd.o
> > diff --git a/drivers/input/keyboard/iqs62x-keys.c b/drivers/input/keybo=
ard/iqs62x-keys.c
> > new file mode 100644
> > index 0000000..b477334
> > --- /dev/null
> > +++ b/drivers/input/keyboard/iqs62x-keys.c
> > @@ -0,0 +1,340 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Azoteq IQS620A/621/622/624/625 Keys and Switches
> > + *
> > + * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/input.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/iqs62x.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +enum {
> > +	IQS62X_SW_HALL_N,
> > +	IQS62X_SW_HALL_S,
> > +};
> > +
> > +static const char * const iqs62x_switch_names[] =3D {
> > +	[IQS62X_SW_HALL_N] =3D "hall-switch-north",
> > +	[IQS62X_SW_HALL_S] =3D "hall-switch-south",
> > +};
> > +
> > +struct iqs62x_switch_desc {
> > +	enum iqs62x_event_flag flag;
> > +	unsigned int code;
> > +	bool enabled;
> > +};
> > +
> > +struct iqs62x_keys_private {
> > +	struct iqs62x_core *iqs62x;
> > +	struct input_dev *input;
> > +	struct notifier_block notifier;
> > +	struct iqs62x_switch_desc switches[ARRAY_SIZE(iqs62x_switch_names)];
> > +	unsigned int keycode[IQS62X_NUM_KEYS];
> > +	unsigned int keycodemax;
> > +	u8 interval;
> > +};
> > +
> > +static int iqs62x_keys_parse_prop(struct platform_device *pdev,
> > +				  struct iqs62x_keys_private *iqs62x_keys)
> > +{
> > +	struct fwnode_handle *child;
> > +	unsigned int val;
> > +	int ret, i;
> > +
> > +	ret =3D device_property_read_u32_array(&pdev->dev, "linux,keycodes",
> > +					     NULL, 0);
>=20
> You can use device_property_count_u32().

Sure thing, will do.

>=20
> > +	if (ret > IQS62X_NUM_KEYS) {
> > +		dev_err(&pdev->dev, "Too many keycodes present\n");
> > +		return -EINVAL;
> > +	} else if (ret < 0) {
> > +		dev_err(&pdev->dev, "Failed to count keycodes: %d\n", ret);
> > +		return ret;
> > +	}
> > +	iqs62x_keys->keycodemax =3D ret;
> > +
> > +	ret =3D device_property_read_u32_array(&pdev->dev, "linux,keycodes",
> > +					     iqs62x_keys->keycode,
> > +					     iqs62x_keys->keycodemax);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to read keycodes: %d\n", ret);
> > +		return ret;
> > +	}
>=20
> I wonder why you can't simply use
>=20
> 	error =3D device_property_read_u32_array(&pdev->dev, "linux,keycodes",
> 						iqs62x_keys->keycode,
> 						IQS62X_NUM_KEYS);
>=20
> Are you concerned with someone trying to set up keys that are not
> actually exposed later via EVOCSKEYCODES and that is why you are
> limiting keycodemax?

When I try this, I find that device_property_read_u32_array returns -EOVERF=
LOW
for arrays with fewer than IQS62X_NUM_KEYS elements. To avoid forcing users=
 to
pad the array all the way out to IQS62X_NUM_KEYS in the case of simple chan=
nel
assignments (like those in the example bindings), keycodemax must be passed=
 to
device_property_read_u32_array which means it must be limited before-hand. =
The
same method seems to be used in other drivers as well (e.g. mpr121_touchkey=
).

>=20
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++) {
> > +		child =3D device_get_named_child_node(&pdev->dev,
> > +						    iqs62x_switch_names[i]);
> > +		if (!child)
> > +			continue;
> > +
> > +		ret =3D fwnode_property_read_u32(child, "linux,code", &val);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Failed to read switch code: %d\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +		iqs62x_keys->switches[i].code =3D val;
> > +		iqs62x_keys->switches[i].enabled =3D true;
> > +
> > +		if (fwnode_property_present(child, "azoteq,use-prox"))
> > +			iqs62x_keys->switches[i].flag =3D (i =3D=3D IQS62X_SW_HALL_N ?
> > +							 IQS62X_EVENT_HALL_N_P :
> > +							 IQS62X_EVENT_HALL_S_P);
> > +		else
> > +			iqs62x_keys->switches[i].flag =3D (i =3D=3D IQS62X_SW_HALL_N ?
> > +							 IQS62X_EVENT_HALL_N_T :
> > +							 IQS62X_EVENT_HALL_S_T);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int iqs62x_keys_init(struct iqs62x_keys_private *iqs62x_keys)
> > +{
> > +	struct iqs62x_core *iqs62x =3D iqs62x_keys->iqs62x;
> > +	enum iqs62x_event_flag flag;
> > +	unsigned int event_mask_reg;
> > +	unsigned int event_mask =3D 0;
> > +	unsigned int val;
> > +	int ret, i;
> > +
> > +	switch (iqs62x->dev_desc->prod_num) {
> > +	case IQS620_PROD_NUM:
> > +	case IQS621_PROD_NUM:
> > +	case IQS622_PROD_NUM:
> > +		event_mask_reg =3D IQS620_GLBL_EVENT_MASK;
> > +
> > +		/*
> > +		 * Discreet button, hysteresis and SAR UI flags represent keys
> > +		 * and are unmasked if mapped to a valid keycode.
> > +		 */
> > +		for (i =3D 0; i < iqs62x_keys->keycodemax; i++) {
> > +			if (iqs62x_keys->keycode[i] =3D=3D KEY_RESERVED)
> > +				continue;
> > +
> > +			if (iqs62x_events[i].reg =3D=3D IQS62X_EVENT_PROX)
> > +				event_mask |=3D iqs62x->dev_desc->prox_mask;
> > +			else if (iqs62x_events[i].reg =3D=3D IQS62X_EVENT_HYST)
> > +				event_mask |=3D (iqs62x->dev_desc->hyst_mask |
> > +					       iqs62x->dev_desc->sar_mask);
> > +		}
> > +
> > +		ret =3D regmap_read(iqs62x->map, iqs62x->dev_desc->hall_flags,
> > +				  &val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/*
> > +		 * Hall UI flags represent switches and are unmasked if their
> > +		 * corresponding child nodes are present.
> > +		 */
> > +		for (i =3D 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++) {
> > +			if (!(iqs62x_keys->switches[i].enabled))
> > +				continue;
> > +
> > +			flag =3D iqs62x_keys->switches[i].flag;
> > +
> > +			if (iqs62x_events[flag].reg !=3D IQS62X_EVENT_HALL)
> > +				continue;
> > +
> > +			event_mask |=3D iqs62x->dev_desc->hall_mask;
> > +
> > +			input_report_switch(iqs62x_keys->input,
> > +					    iqs62x_keys->switches[i].code,
> > +					    (val & iqs62x_events[flag].mask) =3D=3D
> > +					    iqs62x_events[flag].val);
> > +		}
> > +
> > +		input_sync(iqs62x_keys->input);
> > +		break;
> > +
> > +	case IQS624_PROD_NUM:
> > +		event_mask_reg =3D IQS624_HALL_UI;
> > +
> > +		/*
> > +		 * Interval change events represent keys and are unmasked if
> > +		 * either wheel movement flag is mapped to a valid keycode.
> > +		 */
> > +		if (iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_UP] !=3D KEY_RESERVED)
> > +			event_mask |=3D IQS624_HALL_UI_INT_EVENT;
> > +
> > +		if (iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_DN] !=3D KEY_RESERVED)
> > +			event_mask |=3D IQS624_HALL_UI_INT_EVENT;
> > +
> > +		ret =3D regmap_read(iqs62x->map, iqs62x->dev_desc->interval,
> > +				  &val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		iqs62x_keys->interval =3D val;
> > +		break;
> > +
> > +	default:
> > +		return 0;
> > +	}
> > +
> > +	return regmap_update_bits(iqs62x->map, event_mask_reg, event_mask, 0)=
;
> > +}
> > +
> > +static int iqs62x_keys_notifier(struct notifier_block *notifier,
> > +				unsigned long event_flags, void *context)
> > +{
> > +	struct iqs62x_event_data *event_data =3D context;
> > +	struct iqs62x_keys_private *iqs62x_keys;
> > +	int ret, i;
> > +
> > +	iqs62x_keys =3D container_of(notifier, struct iqs62x_keys_private,
> > +				   notifier);
> > +
> > +	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
> > +		ret =3D iqs62x_keys_init(iqs62x_keys);
> > +		if (ret) {
> > +			dev_err(iqs62x_keys->input->dev.parent,
> > +				"Failed to re-initialize device: %d\n", ret);
> > +			return NOTIFY_BAD;
> > +		}
> > +
> > +		return NOTIFY_OK;
> > +	}
> > +
> > +	for (i =3D 0; i < iqs62x_keys->keycodemax; i++) {
> > +		if (iqs62x_events[i].reg =3D=3D IQS62X_EVENT_WHEEL &&
> > +		    event_data->interval =3D=3D iqs62x_keys->interval)
> > +			continue;
> > +
> > +		input_report_key(iqs62x_keys->input, iqs62x_keys->keycode[i],
> > +				 event_flags & BIT(i));
> > +	}
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++)
> > +		if (iqs62x_keys->switches[i].enabled)
> > +			input_report_switch(iqs62x_keys->input,
> > +					    iqs62x_keys->switches[i].code,
> > +					    event_flags &
> > +					    BIT(iqs62x_keys->switches[i].flag));
> > +
> > +	input_sync(iqs62x_keys->input);
> > +
> > +	if (event_data->interval =3D=3D iqs62x_keys->interval)
> > +		return NOTIFY_OK;
> > +
> > +	/*
> > +	 * Each frame contains at most one wheel event (up or down), in which
> > +	 * case a complementary release cycle is emulated.
> > +	 */
> > +	if (event_flags & BIT(IQS62X_EVENT_WHEEL_UP)) {
> > +		input_report_key(iqs62x_keys->input,
> > +				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_UP],
> > +				 0);
> > +		input_sync(iqs62x_keys->input);
> > +	} else if (event_flags & BIT(IQS62X_EVENT_WHEEL_DN)) {
> > +		input_report_key(iqs62x_keys->input,
> > +				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_DN],
> > +				 0);
> > +		input_sync(iqs62x_keys->input);
> > +	}
> > +
> > +	iqs62x_keys->interval =3D event_data->interval;
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static int iqs62x_keys_probe(struct platform_device *pdev)
> > +{
> > +	struct iqs62x_core *iqs62x =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct iqs62x_keys_private *iqs62x_keys;
> > +	struct input_dev *input;
> > +	int ret, i;
> > +
> > +	iqs62x_keys =3D devm_kzalloc(&pdev->dev, sizeof(*iqs62x_keys),
> > +				   GFP_KERNEL);
> > +	if (!iqs62x_keys)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, iqs62x_keys);
> > +
> > +	ret =3D iqs62x_keys_parse_prop(pdev, iqs62x_keys);
> > +	if (ret)
> > +		return ret;
> > +
> > +	input =3D devm_input_allocate_device(&pdev->dev);
> > +	if (!input)
> > +		return -ENOMEM;
> > +
> > +	input->keycodemax =3D iqs62x_keys->keycodemax;
> > +	input->keycode =3D iqs62x_keys->keycode;
> > +	input->keycodesize =3D sizeof(*iqs62x_keys->keycode);
> > +
> > +	input->name =3D iqs62x->dev_desc->dev_name;
> > +	input->id.bustype =3D BUS_I2C;
> > +
> > +	__set_bit(EV_KEY, input->evbit);
> > +
> > +	for (i =3D 0; i < iqs62x_keys->keycodemax; i++)
> > +		__set_bit(iqs62x_keys->keycode[i], input->keybit);
> > +
> > +	__clear_bit(KEY_RESERVED, input->keybit);

It occurs to me that we can also collapse the __set_bit ... __clear_bit log=
ic
above into the following:

for (i =3D 0; i < iqs62x_keys->keycodemax; i++)
	if (iqs62x_keys->keycode[i] !=3D KEY_RESERVED)
		input_set_capability(input, EV_KEY, iqs62x_keys->keycode[i]);

Since this seems straightforward enough, I plan on sneaking it into v5 alon=
g
with the change below while keeping your Acked-by. If you have any objectio=
n,
please let me know.

> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++)
> > +		if (iqs62x_keys->switches[i].enabled) {
> > +			__set_bit(EV_SW, input->evbit);
> > +			__set_bit(iqs62x_keys->switches[i].code, input->swbit);
>=20
> input_set_capability(input, EV_SW, iqs62x_keys->switches[i].code)

Sure thing, will do.

>=20
> > +		}
> > +
> > +	iqs62x_keys->iqs62x =3D iqs62x;
> > +	iqs62x_keys->input =3D input;
> > +
> > +	ret =3D iqs62x_keys_init(iqs62x_keys);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to initialize device: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D input_register_device(iqs62x_keys->input);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to register device: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	iqs62x_keys->notifier.notifier_call =3D iqs62x_keys_notifier;
> > +	ret =3D blocking_notifier_chain_register(&iqs62x_keys->iqs62x->nh,
> > +					       &iqs62x_keys->notifier);
> > +	if (ret)
> > +		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int iqs62x_keys_remove(struct platform_device *pdev)
> > +{
> > +	struct iqs62x_keys_private *iqs62x_keys =3D platform_get_drvdata(pdev=
);
> > +	int ret;
> > +
> > +	ret =3D blocking_notifier_chain_unregister(&iqs62x_keys->iqs62x->nh,
> > +						 &iqs62x_keys->notifier);
> > +	if (ret)
> > +		dev_err(&pdev->dev, "Failed to unregister notifier: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static struct platform_driver iqs62x_keys_platform_driver =3D {
> > +	.driver =3D {
> > +		.name =3D IQS62X_DRV_NAME_KEYS,
> > +	},
> > +	.probe =3D iqs62x_keys_probe,
> > +	.remove =3D iqs62x_keys_remove,
> > +};
> > +module_platform_driver(iqs62x_keys_platform_driver);
> > +
> > +MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
> > +MODULE_DESCRIPTION("Azoteq IQS620A/621/622/624/625 Keys and Switches")=
;
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:" IQS62X_DRV_NAME_KEYS);
>=20
> Otherwise
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> I suppose it will be merged through MFD?

That's the plan; Lee confirmed this would be OK once the series is ready. J=
ust
as a heads up, I expect minor changes to this and other patches as iqs62x.h=
 is
hardened (e.g. "iqs62x->map" --> "iqs62x->regmap"). I assume you're OK with=
 me
keeping your Acked-by unless there are major changes, but let me know if yo=
u'd
prefer I didn't.

>=20
> Thanks.
>=20
> --=20
> Dmitry

Kind regards,
Jeff LaBundy
