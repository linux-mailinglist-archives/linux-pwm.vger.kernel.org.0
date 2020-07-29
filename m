Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BDE23196C
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgG2GUs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 02:20:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:17256 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgG2GUr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 29 Jul 2020 02:20:47 -0400
IronPort-SDR: 4KfAYKiokePY5Ts+kosjf2mYUTJfzfXIBm/Wz4iUH8IFt85HQ4Oy4dMQBS/Twvwa1hXuwyDetq
 /KRbI7VWsKPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="148823277"
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; 
   d="scan'208";a="148823277"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 23:20:47 -0700
IronPort-SDR: xU5SsWJQTKt4sZgIyrvTPjk+C4bCnDlykTU1WXt+R8jjuS7qR4VPevXiJ2ncP9d2dFeqelK7NU
 sI/rethV+b9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; 
   d="scan'208";a="312914181"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2020 23:20:47 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 28 Jul 2020 23:20:46 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 28 Jul 2020 23:20:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 23:20:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEzyCxqcZ/0GWjakydYT86Ezwi0qNMPPubVRXFva65WlIDqF2flAn1+ytg1+oKh0xfG6lSMLLXhNp8EEyMFIb7mIYx/jkWBjPCJx4++MIYa8IttTku5CGSaXQq62IPBwENDnCx4AoO90USGu/HiJC0cDM1JDSKgwJ0MZhfpnIBLpvacAD84ipK5ZU3i9moTdgABuRoSjg33gLFFon5WGW/PW4jkB6cHi6w6JJBdCSQjjYUk53B/nJRTwsGBjarh+87wVYb6QR/EaNlFDJyKMTuh9kxMlIcqcwnpqBU/7dnuUoYJwOE6rbUvTaWpHLIfB3kzWnCbQh1PlMesAUgDfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w9cYjJVvwjsJM0jgrBNkijQN2sf+hm18Jw109Jd6AA=;
 b=dI8w5BGwZ2SLIQLnowtpJNUJsbXrX0XY2HDZ15RBRH+tZoGOQz1BXCii93MUI7O2MWY4MBbjtzZqmqbGM7lIFnjh7zislS0wyvW0ROFdANSjsQOYYPrx7kocea9g3O63HHfHMnuqjgoO5X+Om4CVonJlRhAM7w8+Qb2xdKKtONOmu0a7k54qsFOVYZCB6bXIM8AQ6dCzcs5chPfIvcw5AqvruxISqLgd54qQCfDW/W8/vkt9TKlVbAuM9d4Q0WJr1znJ2Zs7EzhzdWO/dpSegv8xtmeeVIZCx0CG0ts+vgphTg68lelJElaKaTSkPhm1Y8lILmzeRHBBPvxPBs5nWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w9cYjJVvwjsJM0jgrBNkijQN2sf+hm18Jw109Jd6AA=;
 b=Ww+zypUuWa02Map9YUjgFS7akm+AaPkHzand1oQcS6L6lHs6gRkGz8zfKzGyQyIfiGwPwbfaAjv6adw7mgfzjlejaexWDvLH2lH+9QWHC57msr3fXMmnT18k+2zLI1AuQhslGExIkUIDLTbeu9AetBWqmBTN7sH4xIxsHQHwTvk=
Received: from SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20)
 by SN6PR11MB2640.namprd11.prod.outlook.com (2603:10b6:805:56::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 29 Jul
 2020 06:20:33 +0000
Received: from SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::cd49:6ea7:530c:95e0]) by SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::cd49:6ea7:530c:95e0%4]) with mapi id 15.20.3216.033; Wed, 29 Jul 2020
 06:20:33 +0000
From:   "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
To:     Uwe Kleine Konig <u.kleine-koenig@pengutronix.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: RE: [PATCH v2 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH v2 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWXRK6NAlLAp2TVUOJw13sJrurl6kRxFEAgAHypbCACYGT8A==
Date:   Wed, 29 Jul 2020 06:20:33 +0000
Message-ID: <SN6PR11MB25752F3A399C02D382F229A0F6700@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1595083628-20734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1595083628-20734-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200721091344.eka44xmkwmqbchm6@pengutronix.de>
 <SN6PR11MB2575C601FB19C75AB56688ADF6720@SN6PR11MB2575.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB2575C601FB19C75AB56688ADF6720@SN6PR11MB2575.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd18eb1d-c851-47c1-f236-08d833877fe6
x-ms-traffictypediagnostic: SN6PR11MB2640:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2640C6FEC936A2BAA3EC9F43F6700@SN6PR11MB2640.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uqOE+pP2/YtgBx6WzYm4Thcg2OzIVLApq0PbUJ56ntKEN9evQPTlsljdFPT/qjQaItf7nM/k6zcywBiMmf8o4GH0ZwOdyeQOz4nJd32AG8wDgGFQZpQuBUUdRbMEW4oVpzbywIPX6DxSTeESk4dcAO+qsu1EEPeDz664K4QFs3YcV/CLSM05xIJJP3oFQzxwX1tZI2obMIhB/iAyGbEYau7KZrSoZoDe/xjctIkMiNDf6xuwOH6tFcvhYtUqXWwrJn026POkTeauUrZASDjXAxwHgTuBv3gBT/AYfQRmjgvCmtru83fGqkk75RlCg5h75ML9xnVNc0OmIggeXtM7E8s1JlC1UhWjoyyGcjEyCm5bBORYxYoJEuZTBXGe/s65XZM+Ci28S7A3KHjtaVtzDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2575.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(39850400004)(396003)(366004)(54906003)(7696005)(64756008)(66946007)(66556008)(66446008)(6916009)(6506007)(71200400001)(30864003)(66476007)(83080400001)(66574015)(8676002)(186003)(33656002)(26005)(53546011)(478600001)(76116006)(55016002)(9686003)(4326008)(83380400001)(316002)(2906002)(52536014)(966005)(86362001)(5660300002)(107886003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cMi3Ox7VthRS9/6Ggg0MSTN+0vn1t/sn68FVaEEipi/VOIZKypc35EdN0xdAL7K3lECSoFZGKzrVjRoZ0AN8XeX42zZWvtIit0TlEC1I0wL+ZTV1vSzyZ4sF2ZPencbWcJ+UXmeBNeKtuZPfjyYebusuBiEPSaND8t2cX0DPgGfl7IrtPBoDVtevYpv0uR6Qu9XfSIAQK+V+SHEGh85x4PA8ZMAuyN8dlsBFDlbPNHakjC+pm3S2WxsTP8D20E34Fxos+L7T2SbqwNNw5mGM4EGq7Dkvr/1/hfeJI0RHxAE0MpaubFoVKZuU5P3Sh0CJ+KOrul88pky7uvBPIFFXzAGMzFEVJ/GTDXt+nHuZiYvHKrWEOBU+YFAvcNW9EpB+LMK0LcO+0wrvBHyuPl/2vAy80Ut8umaR+ZUiEyAhIE6nmXt+CfHSDHK+H0oM7/Y3pdcuQWlGc450HVGfo3B9gVmmh2546BBJDWqa5IXHsO1Uj+3kNFX44Q5qq+rRbuOU
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2575.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd18eb1d-c851-47c1-f236-08d833877fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 06:20:33.0619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSYnOSm9adhGjyQNR6L1+h8+McS3GRGKH0muOeOD+3DfE46f4DM2MTYQVEmb8kwbV+x7RNDaQpIfwdz3FS4aJl7WU+m6U3+IfvlI6AvqxZZH/MqZokoHjbuHX/J0lKur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2640
X-OriginatorOrg: intel.com
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


> -----Original Message-----
> From: linux-pwm-owner@vger.kernel.org <linux-pwm-
> owner@vger.kernel.org> On Behalf Of G Jaya Kumaran, Vineetha
> Sent: Monday, July 27, 2020 1:12 PM
> To: Uwe Kleine Konig <u.kleine-koenig@pengutronix.de>
> Cc: thierry.reding@gmail.com; robh+dt@kernel.org; linux-
> pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, Wan
> Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Shevchenko,
> Andriy <andriy.shevchenko@intel.com>
> Subject: RE: [PATCH v2 1/2] pwm: Add PWM driver for Intel Keem Bay
>=20
> Hi Uwe,
>=20
> Thank you for the feedback, will work on the changes for V3.
>=20
> > -----Original Message-----
> > From: linux-pwm-owner@vger.kernel.org <linux-pwm-
> > owner@vger.kernel.org> On Behalf Of Uwe Kleine-K=F6nig
> > Sent: Tuesday, July 21, 2020 5:14 PM
> > To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> > Cc: thierry.reding@gmail.com; robh+dt@kernel.org; linux-
> > pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, Wan
> > Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>;
> Shevchenko,
> > Andriy <andriy.shevchenko@intel.com>
> > Subject: Re: [PATCH v2 1/2] pwm: Add PWM driver for Intel Keem Bay
> >
> > Hello,
> >
> > On Sat, Jul 18, 2020 at 10:47:07PM +0800,
> > vineetha.g.jaya.kumaran@intel.com wrote:
> > > From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> > >
> > > Enable PWM support for the Intel Keem Bay SoC.
> > >
> > > Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
> > > Signed-off-by: Vineetha G. Jaya Kumaran
> > > <vineetha.g.jaya.kumaran@intel.com>
> > > ---
> > >  drivers/pwm/Kconfig       |   9 ++
> > >  drivers/pwm/Makefile      |   1 +
> > >  drivers/pwm/pwm-keembay.c | 239
> > > ++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 249 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-keembay.c
> > >
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > > cb8d739..2b0419b 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -569,4 +569,13 @@ config PWM_ZX
> > >  	  To compile this driver as a module, choose M here: the module
> > >  	  will be called pwm-zx.
> > >
> > > +config PWM_KEEMBAY
> > > +	tristate "Intel Keem Bay PWM driver"
> > > +	depends on ARM64 || COMPILE_TEST
> > > +	help
> > > +	  The platform driver for Intel Keem Bay PWM controller.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module
> > > +	  will be called pwm-keembay.
> > > +
> > >  endif
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> > > a59c710..0c84ff2 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -55,3 +55,4 @@ obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
> > >  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
> > >  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> > >  obj-$(CONFIG_PWM_ZX)		+=3D pwm-zx.o
> > > +obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
> > > diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-
> keembay.c
> > new
> > > file mode 100644 index 00000000..fa5fe95
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-keembay.c
> > > @@ -0,0 +1,239 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Intel Keem Bay PWM driver
> > > + *
> > > + * Copyright (C) 2020 Intel Corporation
> > > + * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
> > > + *          Vineetha G. Jaya Kumaran
> <vineetha.g.jaya.kumaran@intel.com>
> > > + */
> >
> > If possible, please add a link here to documentation for this chip.
> >
>=20
> There is no documentation released publicly (yet), but once there is, I w=
ill
> add it in.
>=20
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#define KMB_TOTAL_PWM_CHANNELS		6
> > > +#define KMB_PWM_COUNT_MAX		65535
> >
> > If you write this as hexadecimal constant it is more obvious.
> >
> > > +#define KMB_PWM_EN_BIT			BIT(31)
> > > +
> > > +/* Mask */
> > > +#define KMB_PWM_HIGH_MASK		GENMASK(31, 16)
> > > +#define KMB_PWM_LOW_MASK		GENMASK(15, 0)
> > > +#define KMB_PWM_COUNT_MASK		GENMASK(31, 0)
> > > +
> > > +/* PWM Register offset */
> > > +#define KMB_PWM_LEADIN0_OFFSET		0x00
> > > +#define KMB_PWM_LEADIN1_OFFSET		0x04
> > > +#define KMB_PWM_LEADIN2_OFFSET		0x08
> > > +#define KMB_PWM_LEADIN3_OFFSET		0x0c
> > > +#define KMB_PWM_LEADIN4_OFFSET		0x10
> > > +#define KMB_PWM_LEADIN5_OFFSET		0x14
> >
> > All but ..LEADIN0.. are unused. Is this maybe more useful to write as:
> >
> > 	#define KMB_PWM_LEADIN_OFFSET(ch)	(0x00 + 4 * (ch))
> >
> > ?
> >
>=20
> Agreed, will change this for both KMB_PWM_HIGHLOW_OFFSET and
> KMB_PWM_LEADIN_OFFSET.
>=20
> > > +#define KMB_PWM_HIGHLOW0_OFFSET		0x20
> > > +#define KMB_PWM_HIGHLOW1_OFFSET		0x24
> > > +#define KMB_PWM_HIGHLOW2_OFFSET		0x28
> > > +#define KMB_PWM_HIGHLOW3_OFFSET		0x2c
> > > +#define KMB_PWM_HIGHLOW4_OFFSET		0x30
> > > +#define KMB_PWM_HIGHLOW5_OFFSET		0x34
> >
> > ditto.
> >
> > > +struct keembay_pwm {
> > > +	struct pwm_chip chip;
> > > +	struct device *dev;
> > > +	struct clk *clk;
> > > +	void __iomem *base;
> > > +};
> > > +
> > > +static inline struct keembay_pwm *to_keembay_pwm_dev(struct
> > pwm_chip
> > > +*chip) {
> > > +	return container_of(chip, struct keembay_pwm, chip); }
> > > +
> > > +static inline void keembay_pwm_update_bits(struct keembay_pwm
> > *priv, u32 mask,
> > > +					   u32 val, u32 reg, int ch)
> > > +{
> > > +	u32 buff, offset, tmp;
> > > +	void __iomem *address;
> > > +
> > > +	offset =3D reg + ch * 4;
> > > +	address =3D priv->base + offset;
> > > +	buff =3D readl(address);
> > > +	tmp =3D buff & ~mask;
> > > +	tmp |=3D FIELD_PREP(mask, val);
> > > +	writel(tmp, address);
> > > +}
> > > +
> > > +static void keembay_pwm_enable(struct keembay_pwm *priv, int ch) {
> > > +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 1,
> > > +				KMB_PWM_LEADIN0_OFFSET, ch);
> > > +}
> > > +
> > > +static void keembay_pwm_disable(struct keembay_pwm *priv, int ch) {
> > > +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 0,
> > > +				KMB_PWM_LEADIN0_OFFSET, ch);
> > > +}
> > > +
> > > +static void keembay_pwm_get_state(struct pwm_chip *chip, struct
> > pwm_device *pwm,
> > > +				  struct pwm_state *state)
> > > +{
> > > +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> > > +	unsigned long long pwm_h_count, pwm_l_count;
> > > +	unsigned long clk_rate;
> > > +	u32 buff;
> > > +
> > > +	clk_rate =3D clk_get_rate(priv->clk);
> > > +
> > > +	/* Read channel enabled status */
> > > +	buff =3D readl(priv->base + KMB_PWM_LEADIN0_OFFSET + pwm-
> > >hwpwm * 4);
> > > +	if (buff & KMB_PWM_EN_BIT)
> > > +		state->enabled =3D true;
> > > +	else
> > > +		state->enabled =3D false;
> > > +
> > > +	/* Read period and duty cycle*/
> >
> > Missing ' ' before closing */
> >
> > > +	buff =3D readl(priv->base + KMB_PWM_HIGHLOW0_OFFSET + pwm-
> > >hwpwm * 4);
> > > +	pwm_l_count =3D (buff & KMB_PWM_LOW_MASK) * NSEC_PER_SEC;
> > > +	pwm_h_count =3D ((buff & KMB_PWM_HIGH_MASK) >> 16) *
> > NSEC_PER_SEC;
> >
> > pwm_h_count =3D FIELD_GET(KMB_PWM_HIGH_MASK, buff) *
> NSEC_PER_SEC
> >
> > > +	state->duty_cycle =3D pwm_h_count / clk_rate;
> > > +	state->period =3D (pwm_h_count + pwm_l_count) / clk_rate;
> >
> > Please round up both values.
> >
> > > +}
> > > +
> > > +static int keembay_pwm_apply(struct pwm_chip *chip, struct
> > pwm_device *pwm,
> > > +			     const struct pwm_state *state) {
> > > +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> > > +	struct pwm_state current_state;
> > > +	u16 pwm_h_count, pwm_l_count;
> > > +	unsigned long long div;
> > > +	unsigned long clk_rate;
> > > +	u32 pwm_count =3D 0;
> > > +
> > > +	pwm_get_state(pwm, &current_state);
> >
> > Please check the hardware state, not the value cached in the PWM
> > framework.
> >
> > > +	if (!state->enabled && current_state.enabled) {
> > > +		keembay_pwm_disable(priv, pwm->hwpwm);
> > > +		return 0;
> > > +	}
> > > +
> > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > +		return -ENOSYS;
> >
> > This must be checked before .enabled. That's because the expectation
> > on
> >
> > 	.enabled =3D false
> > 	.polarity =3D PWM_POLARITY_INVERSED
> >
> > is that the output gets constant high.
> >
> > > +	/*
> > > +	 * The upper 16 bits of the KMB_PWM_HIGHLOWx_OFFSET register
> > contain
> > > +	 * the high time of the waveform, while the last 16 bits contain
> > > +	 * the low time of the waveform, in terms of clock cycles.
> >
> > Just to be sure: Each period starts with the high time, right?
> >
>=20
> Yes, each period starts with the high time.
>=20
> > > +	 * high time =3D clock rate * duty cycle / NSEC_PER_SEC
> > > +	 * low time =3D  clock rate * (period - duty cycle) / NSEC_PER_SEC
> > > +	 *
> > > +	 * e.g. For period 50000ns, duty cycle 30000ns, and clock rate 500M=
Hz:
> > > +	 * high time =3D (500000000 * 30000) / 1000000000 =3D 0x3A98
> > > +	 * low time =3D (500000000 * 20000) / 1000000000 =3D 0x2710
> > > +	 * Value written to KMB_PWM_HIGHLOWx_OFFSET =3D 0x3A982710
> >
> > For period =3D 50000ns, duty_cycle =3D 30000ns and clock rate 266666666=
 Hz
> > you have to configure:
> >
> > 	high =3D 7999
> > 	low =3D 5334
> >
> > > +	 */
> > > +
> > > +	clk_rate =3D clk_get_rate(priv->clk);
> > > +
> > > +	/* Configure waveform high time */
> > > +	div =3D clk_rate * state->duty_cycle;
> > > +	do_div(div, NSEC_PER_SEC);
> >
> > Can this overflow?
> >

Hi Uwe, sorry for missing this in my previous reply.
Yes, it may exceed the 16-bit limit for the high/low time, depending on the=
 selected duty cycle.
There is a range check after, and -ERANGE will be returned if the high/low =
time range is exceeded.

> > > +	if (div > KMB_PWM_COUNT_MAX)
> > > +		return -ERANGE;
> > > +
> > > +	pwm_h_count =3D (u16)div;
> >
> > No need for this cast.
> >
> > > +	/* Configure waveform low time */
> > > +	div =3D clk_rate * (state->period - state->duty_cycle);
> > > +	do_div(div, NSEC_PER_SEC);
> >
> > Here the rounding is wrong. (See above example, currently you use low
> > =3D
> > 5333 here)
> >

Will fix the rounding to the nearest integer for the high/low time.

> > > +	if (div > KMB_PWM_COUNT_MAX)
> > > +		return -ERANGE;
> > > +
> > > +	pwm_l_count =3D (u16)div;
> > > +
> > > +	pwm_count |=3D pwm_h_count << 16;
> > > +	pwm_count |=3D pwm_l_count;
> >
> > pwm_count =3D FIELD_PREP(KMB_PWM_HIGH_MASK, pwm_h_count) |
> > FIELD_PREP(KMB_PWM_LOW_MASK, pwm_l_count);
> >
> > > +
> > > +	keembay_pwm_update_bits(priv, KMB_PWM_COUNT_MASK,
> > > +				pwm_count,
> > KMB_PWM_HIGHLOW0_OFFSET, pwm->hwpwm);
> >
> > here the rwm-procedure is not necessary as all 32 bits are written anyh=
ow.
> >
> > > +	if (state->enabled && !current_state.enabled)
> > > +		keembay_pwm_enable(priv, pwm->hwpwm);
> > > +
> > > +	return 0;
> > > +}
> > > [...]
> > > +MODULE_ALIAS("platform:keembay");
> >
> > This has to match your driver's name, so use:
> >
> > 	MODULE_ALIAS("platform:pwm-keembay");
> >
> > > +MODULE_DESCRIPTION("Intel Keem Bay PWM driver");
> > MODULE_LICENSE("GPL
> > > +v2");
> >
> > In v1 you told that on reconfiguration the hardware completes the
> > currently running period. Please document this in the driver, similar
> > to e.g. pwm- sifive.c.
> >
>=20
> OK, I will refer to that example and add this information in.
>=20
> > You only ever write the enable bit in the leadin register. If there is
> > something !=3D 0 at boot this influences the correct behaviour of the d=
river,
> right?
> >
>=20
> That's right, I will add a check during probe to ensure the bit is set to=
 0 as
> default.
>=20
> > Further things to note there:
> >
> >  - What is the behaviour on disable (usual candidates: freezes at
> >    current value, completes period and emits low, changes to High-Z)?
> >
>=20
> For this case, the period does not get completed.
> As soon as the channel is disabled, the output goes low.
>=20
> >  - Can it do 0% and 100% duty ratio?
> >
>=20
> Yes, we can set duty cycles of 0% and 100%.
>=20
> > Best regards
> > Uwe
> >
> > --
> > Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
> > Industrial Linux Solutions                 | https://www.pengutronix.de=
/ |
