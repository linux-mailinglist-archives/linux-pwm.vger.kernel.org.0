Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32811EF9B3
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 15:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgFEN43 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 09:56:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:43345 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgFEN42 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 5 Jun 2020 09:56:28 -0400
IronPort-SDR: dtvF0M8tF2oigSwNdTCqZiBIErgDcZQlrEnFNiI/V8cKcJ5Xde8Cnkksko+ad0pman0LE1W7DY
 eQwVqw2bKCGA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 06:49:00 -0700
IronPort-SDR: VfNcAbb45DZT7onlISUSKmx2gtBDMc0HADcnc17N6hzy4fzJovD8GhT6mOj/W4WUhzI76L2pfL
 JDbYy5IQb/Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="294695693"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jun 2020 06:49:00 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 5 Jun 2020 06:49:00 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX111.amr.corp.intel.com (10.22.240.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 5 Jun 2020 06:48:59 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 5 Jun 2020 06:48:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/uSdeivW65fequwZjgKPkHHO4jgSxAoI5AD9W8Q5S9KnzuuLJaxG0C1f9qSQFaAe66qnA1MnJOGMo2xY24lJQRj6T1l8FCORw5y/O55z22ZEyFyn5NNZheSMb6sZj1+ygBPPN6Q4rkymrNkiXOcULxKkBN7PMbJWaEEO1m0qwWk1XWPDkK3uBxRjkyWXMZyS3FV0n7vb+MrDW+8soIbXRZmFyW08MKRBI2pj4WN8lsyhFDHLjrlwL2+zn/mNzsQiRuD82/ZaHcYQkU+SWZfaXcBelA4rOyrE7k3epkUTwfVfVRPsmKqR8+c/I6LYHNInXoyb6wXv5+QIH4kFP7fVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2ieFAvJNMW7arMUp80/F14vD5P51EeAWENBDK85384=;
 b=UBFLP1VgBuGVmp/oyWfNfNKbcJ5QYpZBoKLJqjeHA8Yj3dG/3ZOeSjDFD6rkfgnkh1LMcEdA7Rn9mXt7eFg2JHpHCQKh0I0gT5L4V6SKxD7XsSu7TjU7dqctNIVncXC4pOzKx7E9mHPLQKvRGqCk8rVs9g0rU8i9KiwgyYBgx9BtVpSj5LTKPcGdxgHBOHDUElmyOf2hYvViA1ljGMmipAZKkyoVtBHnr3RPtxCbpWA84+bPr6BuxAMXOlexlh3URbm4jRccCazC4jDUTFk8tdBVVhqqLojAKTEC8ZMby4cDrcb5e7XOYSiJCmG2NE98EFOLG+1TYWWpd5jv5OcOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2ieFAvJNMW7arMUp80/F14vD5P51EeAWENBDK85384=;
 b=q3Pm5uas4h/N1B+v/mzJ9UwZ9SIr38MDEIR2EnExsxIr7SW5t08h05aYivTra7Zu83Do6vgWSom0uqQyXJpe3D7zv0K6vYJVj+zKPwCW+xTN+Gfv1cYENC25j6HU9Kuxg7FCZCObbPjl5cOSn/jcoam3eZnTJEAlj8E+qF5dW6I=
Received: from SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20)
 by SN6PR11MB3197.namprd11.prod.outlook.com (2603:10b6:805:c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 13:48:57 +0000
Received: from SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::24f3:9231:b6e0:a13d]) by SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::24f3:9231:b6e0:a13d%4]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 13:48:57 +0000
From:   "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
To:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Subject: RE: [PATCH 2/3] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH 2/3] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWLFMo0iMskLbKfEOz8DABBXNF2ai2POqAgAhVRZA=
Date:   Fri, 5 Jun 2020 13:48:56 +0000
Message-ID: <SN6PR11MB2575BEDD7154E4827A7F9B07F6860@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-3-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200523214031.xpbenusp2i44w237@pengutronix.de>
In-Reply-To: <20200523214031.xpbenusp2i44w237@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30962646-35d7-4736-280b-08d8095731bb
x-ms-traffictypediagnostic: SN6PR11MB3197:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB31970EECD4D3C74E41FEA080F6860@SN6PR11MB3197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FwmXcdmQXgdtKEJmdgAhyTb/4As4mpy8PKUMYN+VcC8pLF8qG/hgoVmEgF1CT/8mHvjtzKOo9B+boJhuCH3e0LEo+OTMmpfyyC1x834X+eFEGRXsKj9f9QOTnTXck5vFQFsILxZwSiv2DUWbd2Wxw0iVJe4T4c+AtielqlfeMGO2zb0hIuishAbSI0X1ZwPWV+o7zvtGLiaQvrMwuTf/AM0Y0gFiPt6MSlLxFwcaL4Pa4MDWrsmiigFrToubjlQ+izJ41zfuj4d8MRHnD6tFfp6atjadlfyWGe5ZOU2kC0lKwRYj/kCAMZ/v5VZq9sE9DzMKGDUNk4FLG3Be6CXZNmli2adiZBafFynvMuwxHgIgfM+u8bawb7936QeVS7rN5Zh/BpF/sqC+9HPeSDLNKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2575.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(376002)(346002)(396003)(136003)(8936002)(83380400001)(8676002)(316002)(76116006)(66946007)(71200400001)(478600001)(54906003)(66476007)(66446008)(4326008)(64756008)(66556008)(2906002)(966005)(55016002)(7696005)(186003)(86362001)(66574014)(26005)(33656002)(53546011)(83080400001)(9686003)(6506007)(5660300002)(30864003)(6916009)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7kw3WA9TaZjvnDXZXjdYmLhd4nBYIp/xBCx+qfUElTGwovaKT9+ID2S3rtgfMHU5MomlDSk4uraH7Y+xeaBhO7sVrrFh2hsO1NLGPL/PyqSfmAKsug8AqrL+lVwvoaisKphLQ4LVL5Grp6C/f2FcVWbAhgVpN1fyB9639fTwTrCAGnMgHUxlS0uIozoCuXVScFggxbJBKvmXMVbms1nx55Nt76sKzNpKIuUQm6DMfvsneQ74XKugoRdIvHROHoyYIlCNdvsKy62zmf/tVloopKXlP4vEPx1vkybSwufT9o+kYydaiqzJLwDj5/rraPz7FsmUbes4MBzYZODoHha3v95i7dt8utKSNxNcscPyQQ1Rbm++czf6XG4vOi9NZud/m5FhqdmnHZheazoPsTJ/X5DbSCNKZPJftRuAGJJmEdwcpyG3W85JfnyxtxLe5eJ7t0SfNf9E/oYT6eR7UH5EkYDQvueIeULKXDEqu490yumIC584CnQ6ZVUlhWPn9cwt
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 30962646-35d7-4736-280b-08d8095731bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 13:48:56.8901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Do+VWrr0e9U7FBELytRzw8FF07fOm5CV4+fq0GbLmNp0OrnWlewDayGgNk/HcR8MfRrKb8AGIRKMJ87wgzqNM3Ei+ui+qtSx3v4cTL3iBrRqHyNSjW8mrPKJSWPMIVll
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3197
X-OriginatorOrg: intel.com
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

Thank you for taking the time to review this patch set.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Sunday, May 24, 2020 5:41 AM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: thierry.reding@gmail.com; robh+dt@kernel.org; linux-
> pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, Wan
> Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Shevchenko,
> Andriy <andriy.shevchenko@intel.com>
> Subject: Re: [PATCH 2/3] pwm: Add PWM driver for Intel Keem Bay
>=20
> Hello,
>=20
> On Sun, May 17, 2020 at 09:52:39PM +0800,
> vineetha.g.jaya.kumaran@intel.com wrote:
> > From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> >
> > Enable PWM support for the Intel Keem Bay SoC.
> >
> > Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
> > Signed-off-by: Vineetha G. Jaya Kumaran
> > <vineetha.g.jaya.kumaran@intel.com>
> > ---
> >  drivers/pwm/Kconfig       |   9 ++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-keembay.c | 308
> > ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 318 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-keembay.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > c13d146..5311975 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -569,4 +569,13 @@ config PWM_ZX
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-zx.
> >
> > +config PWM_KEEMBAY
> > +	tristate "Intel Keem Bay PWM driver"
> > +	depends on ARM64
>=20
> Support for COMPILE_TEST would be nice here.
>=20

I will add this in v2.

> > +	help
> > +	  The platform driver for Intel Keem Bay PWM controller.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-keembay.
> > +
> >  endif
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> > a59c710..0c84ff2 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -55,3 +55,4 @@ obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
> >  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
> >  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> >  obj-$(CONFIG_PWM_ZX)		+=3D pwm-zx.o
> > +obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
> > diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c new
> > file mode 100644 index 0000000..39c7310
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-keembay.c
> > @@ -0,0 +1,308 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Intel Keem Bay PWM driver
> > + *
> > + * Copyright (C) 2020 Intel Corporation
> > + * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
> > + *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.co=
m>
>=20
> Is there publically available documentation? If so, please add a link her=
e.
>=20

Will check, and add it here if any are available.

> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +
> > +#define TOTAL_PWM_CHANNELS		6
> > +#define LEAD_IN_DEFAULT			0
> > +#define PWM_COUNT_MAX			65535
>=20
> please use a unique prefix for all defines in your driver. The names as t=
hey are
> are too generic.
>=20

I'll update the naming in v2, to match the mask defines.

> > +
> > +#define KEEMBAY_PWM_EN_BIT		31
> > +
> > +/* Mask */
> > +#define KEEMBAY_PWM_RPT_CNT_MASK	GENMASK(15, 0)
> > +#define KEEMBAY_PWM_LEAD_IN_MASK	GENMASK(30, 16)
> > +#define KEEMBAY_PWM_HIGH_MASK		GENMASK(31, 16)
> > +#define KEEMBAY_PWM_LOW_MASK		GENMASK(15, 0)
> > +
> > +/* PWM Register offset */
> > +#define PWM_LEADIN0_OFFSET		0x00
> > +#define PWM_LEADIN1_OFFSET		0x04
> > +#define PWM_LEADIN2_OFFSET		0x08
> > +#define PWM_LEADIN3_OFFSET		0x0c
> > +#define PWM_LEADIN4_OFFSET		0x10
> > +#define PWM_LEADIN5_OFFSET		0x14
> > +
> > +#define PWM_HIGHLOW0_OFFSET		0x20
> > +#define PWM_HIGHLOW1_OFFSET		0x24
> > +#define PWM_HIGHLOW2_OFFSET		0x28
> > +#define PWM_HIGHLOW3_OFFSET		0x2c
> > +#define PWM_HIGHLOW4_OFFSET		0x30
> > +#define PWM_HIGHLOW5_OFFSET		0x34
> > +
> > +struct keembay_pwm {
> > +	struct pwm_chip chip;
> > +	struct device *dev;
> > +	struct clk *clk;
> > +	void __iomem *regmap;
>=20
> I'd call this member "base" instead of "regmap" as the latter has a diffe=
rent
> meaning in the kernel.
>=20

OK, will update the naming.

> > +};
> > +
> > +static inline struct keembay_pwm *to_keembay_pwm_dev(struct pwm_chip
> > +*chip) {
> > +	return container_of(chip, struct keembay_pwm, chip); }
> > +
> > +static inline void keembay_pwm_enable_channel(struct keembay_pwm
> > +*priv, int ch) {
> > +	u32 buff, offset;
> > +	void __iomem *address;
> > +
> > +	offset =3D PWM_LEADIN0_OFFSET + ch * 4;
> > +	address =3D priv->regmap + offset;
> > +	buff =3D readl(address);
> > +	buff |=3D BIT(KEEMBAY_PWM_EN_BIT);
> > +	writel(buff, address);
> > +}
> > +
> > +static inline void keembay_pwm_disable_channel(struct keembay_pwm
> > +*priv, int ch) {
> > +	u32 buff, offset;
> > +	void __iomem *address;
> > +
> > +	offset =3D PWM_LEADIN0_OFFSET + ch * 4;
> > +	address =3D priv->regmap + offset;
> > +	buff =3D readl(address);
> > +	buff &=3D ~BIT(KEEMBAY_PWM_EN_BIT);
> > +	writel(buff, address);
> > +}
>=20
> The two functions above could make use of keembay_pwm_update_bits().
>=20

Agreed, will update them to reflect this.

> > +
> > +static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u=
32
> mask,
> > +					   u32 val, u32 reg, int ch)
> > +{
> > +	u32 buff, offset, tmp;
> > +	void __iomem *address;
> > +
> > +	offset =3D reg + ch * 4;
> > +	address =3D priv->regmap + offset;
> > +	buff =3D readl(address);
> > +	tmp =3D buff & ~mask;
> > +	tmp |=3D FIELD_PREP(mask, val);
> > +	writel(tmp, address);
> > +}
> > +
> > +static inline u32 keembay_pwm_config_min(struct keembay_pwm *priv) {
> > +	unsigned long long divd, divs;
> > +
> > +	divd =3D NSEC_PER_SEC;
> > +	divs =3D clk_get_rate(priv->clk);
> > +	do_div(divd, divs);
>=20
> Given that both NSEC_PER_SEC and the return value of clk_get_rate fit int=
o an
> unsigned long, this seems too much.
>=20

Noted, will modify to use a different data type.

> > +	return (u32)divd;
> > +}
> > +
> > +static inline u16 keembay_pwm_config_duty_cycle(struct keembay_pwm
> *priv,
> > +						int duty_ns, u32 ns_min)
> > +{
> > +	unsigned long long divd;
> > +
> > +	divd =3D duty_ns;
> > +	do_div(divd, ns_min);
> > +	if ((u16)divd =3D=3D 0)
> > +		return 0;
> > +
> > +	return (u16)divd - 1;
>=20
> missing range checking.
>=20

Will add this in.

> > +}
> > +
> > +static inline u16 keembay_pwm_config_period(struct keembay_pwm *priv,
> > +					    int period_ns,
> > +					    int duty_ns,
> > +					    u32 ns_min)
> > +{
> > +	unsigned long long divd;
> > +
> > +	divd =3D period_ns - duty_ns;
> > +	do_div(divd, ns_min);
> > +	if ((u16)divd =3D=3D 0)
> > +		return 0;
> > +
> > +	return (u16)divd - 1;
>=20
> I wonder if both keembay_pwm_config_duty_cycle() and
> keembay_pwm_config_period() would be easier to understand if they were no=
t
> separate functions but unrolled into their only user.
>=20
> As above there is no range checking.
>=20

OK - will move this into keembay_pwm_apply, and add the range check as well=
.

> > +}
> > +
> > +/*
> > + *	For calculating "high time" register value:
> > + *	High time (quotient only) =3D duty_cycle / ns_min
> > + *
> > + *	For calculating "low time" register value:
> > + *	Low time (quotient only) =3D (period - duty_cycle) / ns_min
> > + *
> > + *	All values used are in nanoseconds for calculation.
> > + */
> > +static int keembay_pwm_config(struct keembay_pwm *priv, int ch,
> > +			      int duty_ns, int period_ns, int count)
>=20
> this function is only called once, I wonder if it can better be folded in=
to its only
> user.
>=20

Will move this into keembay_pwm_apply.

> > +{
> > +	u32 ns_min;
> > +	u16 pwm_h_count, pwm_l_count;
> > +
> > +	/* Write to lead in */
> > +	keembay_pwm_update_bits(priv, KEEMBAY_PWM_LEAD_IN_MASK,
> > +				LEAD_IN_DEFAULT,
> > +				PWM_LEADIN0_OFFSET, ch);
>=20
> What is the effect of this "lead in"?
>=20

It is used to specify a low period between the trigger(enable bit set) and =
start of the waveform.
So the PWM output remains low for the number of clock cycles specified by t=
his LEAD_IN value.

> > +	/* Write the number of PWM pulse repetition */
> > +	keembay_pwm_update_bits(priv, KEEMBAY_PWM_RPT_CNT_MASK,
> count,
> > +				PWM_LEADIN0_OFFSET, ch);
>=20
> Is this racy? E.g. if the PWM is already running and just after you updat=
e the
> repetition count completes a period?
>=20

The repetition count will only take effect once the channel is disabled and=
 reenabled again.
So, it will not affect the currently running waveform.

> This writes to the same register as the lead in above. Can this be done i=
n a single
> register access?
>=20

Yes -- will change this to single access instead.=20

> > +	/* Calculate min */
> > +	ns_min =3D keembay_pwm_config_min(priv);
>=20
> What is "min"?
>=20

This refers to the ns equivalent of 1 clock cycle.
However, since the calculation for the high/low time will be changed in v2 =
(based on further comments below),=20
I will remove this.

> > +	/* For duty cycle */
> > +	pwm_h_count =3D keembay_pwm_config_duty_cycle(priv, duty_ns,
> ns_min);
>=20
> this is ineffective and less exact as possible. ns_min is the result of a=
 division and
> in keembay_pwm_config_duty_cycle you divide by it.
>=20

Understood - will change the formula used to get the high time/low time to =
something like below instead:
value =3D clk_rate * state->duty_cycle;
pwm_h_count =3D do_div(value, NSEC_PER_SEC);


> > +	/* Write to high registers */
> > +	keembay_pwm_update_bits(priv, KEEMBAY_PWM_HIGH_MASK,
> pwm_h_count,
> > +				PWM_HIGHLOW0_OFFSET, ch);
> > +
> > +	/* For period */
> > +	pwm_l_count =3D keembay_pwm_config_period(priv, period_ns, duty_ns,
> > +						ns_min);
> > +
> > +	/* Write to low registers */
> > +	keembay_pwm_update_bits(priv, KEEMBAY_PWM_LOW_MASK,
> pwm_l_count,
> > +				PWM_HIGHLOW0_OFFSET, ch);
>=20
> Can you please explain in a comment what's the resulting wave form for a =
given
> value of this register?
>=20

Okay, I will add a comment in the driver explaining this.
In summary, the upper/lower 16 bits of the register represent the waveform'=
s high/low time in number of clock cycles - 1.
e.g. for a period of 70000ns, duty cycle of 35000ns and clock rate of 500MH=
z:
The resulting register value would be 0x445B445B.

> Can writing h_count and l_count be combined in a single register access?
> (And if not, what happens if a period completes between the two
> updates?)
>=20
> How does the hardware behave on a change here? Is the currently running
> period completed before the new values take effect?
>=20

The write can be combined, I will make this change for v2.=20
As for the HW behaviour, yes, the current period will
be completed before the new configuration takes effect.

> > +
> > +	return 0;
> > +}
> > +
> > +static int keembay_pwm_enable(struct keembay_pwm *priv, int ch) {
> > +	int ret;
> > +
> > +	ret =3D clk_enable(priv->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable channel */
> > +	keembay_pwm_enable_channel(priv, ch);
> > +
> > +	return 0;
> > +}
> > +
> > +static void keembay_pwm_disable(struct keembay_pwm *priv, int ch) {
> > +	/* Disable channel */
> > +	keembay_pwm_disable_channel(priv, ch);
> > +
> > +	clk_disable(priv->clk);
> > +}
> > +
> > +static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			     const struct pwm_state *state) {
> > +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> > +
> > +	if (!state->enabled && pwm_is_enabled(pwm)) {
>=20
> Please don't call API functions in the driver.
>=20

Noted, will change this in v2.

> > +		keembay_pwm_disable(priv, pwm->hwpwm);
>=20
> Is a currently running period completed here? How does the output behave =
on
> disable? (i.e. does it go in its inactive state?)
>=20

Upon disable (the "enable" bit is cleared), the output signal is stopped/in=
active.
The currently running period will not be completed.

> > +		return 0;
> > +	}
> > +
> > +	if (state->count > PWM_COUNT_MAX)
> > +		return -EINVAL;
> > +
> > +	if (state->polarity !=3D pwm_get_polarity(pwm))
>=20
> Using:
>=20
> 	if (state->polarity !=3D PWM_POLARITY_NORMAL)
>=20
> seems both more robust and easier to understand.
>=20

Will update this.

> > +		return -ENOSYS;
> > +
> > +	keembay_pwm_config(priv, pwm->hwpwm, state->duty_cycle,
> > +			   state->period, state->count);
> > +
> > +	if (state->enabled && !pwm_is_enabled(pwm))
> > +		return keembay_pwm_enable(priv, pwm->hwpwm);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pwm_ops keembay_pwm_ops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.apply =3D keembay_pwm_apply,
>=20
> Please implement .get_state().
>=20

Will add this in v2.

> > +};
> > +
> > +static int keembay_pwm_probe(struct platform_device *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct keembay_pwm *priv;
> > +	int ret;
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(priv->clk))
>=20
> Error message please. (Something like:
>=20
> 		int ret =3D PTR_ERR(ret);
>=20
> 		if (ret !=3D -EPROBE_DEFER)
> 			dev_err(pdev->dev, "Failed to get clk: %pE\n", priv-
> >clk);
>=20
> 		return ret;
> )
>=20

Noted, I will add this in.

> > +		return PTR_ERR(priv->clk);
> > +
> > +	/*
> > +	 * Prepare clock here, and carry out clock enabling/disabling
> > +	 * during channel enablement/disablement.
> > +	 * The clock will not be unprepared due to shared usage with GPIO.
>=20
> What has this clock to do with GPIO? If the GPIO drivers gets and enables=
 this
> clock itself there should be no problem.
>=20

The PWM outputs are actually part of the GPIO block, hence use the same clo=
ck as it.
The current behaviour is unpreparing causes the system to hang - I will cro=
ss-check regarding this.

> > +	 */
> > +	ret =3D clk_prepare(priv->clk);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to prepare PWM clock\n");
>=20
> Please include the error code in the message (preferably using %pE as abo=
ve).
>=20

Noted, will update.

> > +		return ret;
> > +	}
> > +
> > +	priv->regmap =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->regmap))
> > +		return PTR_ERR(priv->regmap);
> > +
> > +	priv->chip.base =3D -1;
> > +	priv->chip.dev =3D dev;
> > +	priv->chip.ops =3D &keembay_pwm_ops;
> > +	priv->chip.npwm =3D TOTAL_PWM_CHANNELS;
> > +
> > +	ret =3D pwmchip_add(&priv->chip);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to add PWM chip: %d\n", ret);
>=20
> %pE please.
>=20

Will update.

> > +		return ret;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	return 0;
> > +}
> > +
> > +static int keembay_pwm_remove(struct platform_device *pdev) {
> > +	struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < priv->chip.npwm; i++)
> > +		pwm_disable(&priv->chip.pwms[i]);
>=20
> That's wrong. It's the responsibility of the consumer to disable the cloc=
k.
>=20

Noted, will remove this.

> > +
> > +	pwmchip_remove(&priv->chip);
>=20
> clk_unprepare missing here.
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id keembay_pwm_of_match[] =3D {
> > +	{ .compatible =3D "intel,keembay-pwm" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, keembay_pwm_of_match);
> > +
> > +static struct platform_driver keembay_pwm_driver =3D {
> > +	.probe	=3D keembay_pwm_probe,
> > +	.remove	=3D keembay_pwm_remove,
> > +	.driver	=3D {
> > +		.name =3D "pwm-keembay",
> > +		.of_match_table =3D keembay_pwm_of_match,
> > +	},
> > +};
> > +module_platform_driver(keembay_pwm_driver);
> > +
> > +MODULE_ALIAS("platform:keembay");
> > +MODULE_DESCRIPTION("Intel Keem Bay PWM driver");
> MODULE_LICENSE("GPL
> > +v2");
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
