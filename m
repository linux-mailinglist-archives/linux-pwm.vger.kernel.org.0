Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C934725D553
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Sep 2020 11:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgIDJm6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Sep 2020 05:42:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:4431 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgIDJmy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Sep 2020 05:42:54 -0400
IronPort-SDR: AllAEZ7mBSFoHB/qxQq9CNs7PC9ytiXuOGqQikxb7VJ0I2XfEUyizegcmGWNXwWAvNljY+RDYE
 ma+CYwfeQvcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="156981386"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="156981386"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 02:42:51 -0700
IronPort-SDR: +uFRielVXDnOCuSUH5N2M8fnHhJD+5VfTjCWBLtWRK0v8w/nBskVX55E0rqdSonDA+5fRo/ECv
 KiIf5ZlnhbYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="284372963"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2020 02:42:51 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Sep 2020 02:42:51 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 4 Sep 2020 02:42:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 4 Sep 2020 02:42:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 4 Sep 2020 02:42:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoNQBNLXyqzgmxGMgBhdLGZO0WvReRSONAuo9eIxJWX/U2QVU+rGJrf30bWyCZsiGNsZpfJn6sB4huKXCKgWbdHgqdE+HvDEX5QNcfpqJYO8btH9ldkq6ZvZsJADJmfEBnVu/CyVKJT/hfQv186VQsGWTw9fJBwj9IZFG6WfDXmnGHiJvSbmQXBbFbDikfZXxxeTOcjV0QLOhMUF15k36z3yf+CE39Aa/y9jsNCPe2vI7yInOg+NsRnkJD0IMXGlDbrrig5ys22FDlItmmOW/tKaXQmDR3IZVz3aPV11IOFNDu3bsA3cQcXRLSHh8mTrEGZ8LakkmLAzcmB4KSrIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V9U8ADlEnqk5F7UHzyYVuEOEbT5VLeT1rZJxqRGYz4=;
 b=adEeEB7k22yb6fFeMfldGd3zrgYIdjW4GyGnIM1rwLIgHsS1AlCOdyRcXlDjltuvY16VyhmHq9CkO92LksOBnYaOMJhTSdHwkLn0Sf8strQ1cPWvW+5/ZbE1oKM4wpkkkx8Y8ftl4a0ZmRVdiGTTf95nGauYEll4XwoK6UfOBT3ZdtyIV1Pht6WDERiscJiFZn964CYC81CJAP890zLYBCAPQ6Ytnnny75rQ4V06A6cGewGB0T2/d0KADeO2nmK6y0o3j5vZsUdn7QqqtYu1pwCgCa2bqVbJIDkonyhgSzRB/n2RfET8pLRONYEEKvBPsnYbNY0FsXgZhVWd0RK/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V9U8ADlEnqk5F7UHzyYVuEOEbT5VLeT1rZJxqRGYz4=;
 b=lCtPauSQYkKYlcxzsvuTWVQVQMs/ZzPsCsQR9tEcy/pKcKoDU5tzkfbiJjgJgkr7mA70KL2LktFijqs4FjPRh7l/AUjgYGfXPALrzhmrHOn7SOc6gUZGbZfLL05fnHd5dRtaYFTuhDbEHYtIpZkqzZ/iMiPocIlpp4/8fQZbG/U=
Received: from SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20)
 by SN6PR11MB3392.namprd11.prod.outlook.com (2603:10b6:805:c5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 09:42:38 +0000
Received: from SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::6407:40fd:19e3:e270]) by SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::6407:40fd:19e3:e270%7]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 09:42:37 +0000
From:   "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
Subject: RE: [PATCH v5 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH v5 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWe5OG7Z7IhOoQU0eHxYJS7P1m0qlU7J6AgALcMRA=
Date:   Fri, 4 Sep 2020 09:42:37 +0000
Message-ID: <SN6PR11MB257504DDA3FA499D6740FD0FF62D0@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1598437559-25828-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1598437559-25828-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200902062543.hf5resp6yci2zojc@pengutronix.de>
In-Reply-To: <20200902062543.hf5resp6yci2zojc@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95018376-5cc1-4ea9-3fd9-08d850b6dc14
x-ms-traffictypediagnostic: SN6PR11MB3392:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3392BB778E0A4110A018D82AF62D0@SN6PR11MB3392.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a3jUpVox0zRTpotY2r64BkEA2N+FZm6CkN6PyJbud8vOx//Vf8gDN5T/YvWv7H+W5QH0Y6Kkyp5cyt1+pxczB/tfLYoiMw5GVO1LqPsXzEQlUjHHfJeaJOlFtgzWN5jIa0Vg8XJoWXXHRtqpHlbE39UfY3Rrh1yO+qT3Vgjrq4ThTrdqqspJdSg+KuIv9MnQEGowJaeisEFasFvyGKkLvEvK/4WCERPKbIgPlg+x/ECNRtteQVZnCCC58XGaVRg/kfFutgb3wmGXtgoO9oCTJ3i9FsNqmY6OBz5UvX1F8X0qojnzsl3jZP9GsiSEHH41P4TwBh3CAzVpRqKwns/dWpAjabcJQSjmn+BFjBJCpR6QRhOg8YrYHxHYgQM9MsS8fo5lZxqL2Hwaa9IQloUcQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2575.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(26005)(8936002)(9686003)(33656002)(55016002)(4326008)(71200400001)(86362001)(316002)(8676002)(2906002)(66476007)(66556008)(966005)(54906003)(66946007)(6916009)(186003)(5660300002)(53546011)(76116006)(83380400001)(66446008)(64756008)(83080400001)(52536014)(7696005)(478600001)(6506007)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4vscVsUd3phAzG8vaQ9E9FXWPSL/OmCJ1S2zYWexgGRQCuNUFzJy+17HUtAkplNghiI90ZcgVJmNGKu3FhToG6L6Y5IWL1tcz1wshGm+y5lG83bthhun3lQ5QDn9NMetdgJeLg9jlslXEV1HQDcoZnQBnDYrW3gF0n4jJjHn3+c3+GhgxWALDks6AmIpElEQ9AATM+pYxWVFuGVSOII+r5AaQrch3G6mLI13umlZAo6+0w0A6MF+BE/G+O4xhBkMZpzFH9pfJYJAwI1kks57I57CKze0q10r8HCvPcSbJYr9kZMmCWJ2vCPYHfNWfocoOXia0wo11735FT3m8QsKzODuQB3W4g+3QXSKbQNgsOk/oCwgHMaHfaJviLJ+xOg6qsiHoOlpNWYFk2KG8mEaHoxDjhPcMohxQr2NN3Ps6i5g31klB9J0uefkOcFH/v5uhbfLZ2DKItH2JTHiln5+U28kwW2YBCDvaXwMR3OdnlQV9aS7YXmQereTWmfCDLwI4HE0lfdAGpr1RazLfbIYFrgDI4DCCsEXYuLdCQyiQJA2V0/mmE21xzbauIJB22UBAdBgKsYY0wxuGbWI2iV5J1DUi1DnTv2USBbO6VMHByWz4YeTjXdpkRIdZ/PuZiKQK8pr4EKXnQPgkbhcHPZSDg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2575.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95018376-5cc1-4ea9-3fd9-08d850b6dc14
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 09:42:37.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6tKBXkxbv2kEZPIDy50n0udjwQAkkkCbqtK6R2qz+pXTM+PxSCcjk8BQz3bbSXpCN/6CyjpzfiaBDnNWr800N7ATdJWqusDPj9/FSFo4XVQ9Fxfs+kaMuQyZ/xhHODk0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3392
X-OriginatorOrg: intel.com
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

> -----Original Message-----
> From: linux-pwm-owner@vger.kernel.org <linux-pwm-
> owner@vger.kernel.org> On Behalf Of Uwe Kleine-K=F6nig
> Sent: Wednesday, September 2, 2020 2:26 PM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: thierry.reding@gmail.com; robh+dt@kernel.org; linux-
> pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, Wan
> Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>;
> andriy.shevchenko@linux.intel.com; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH v5 1/2] pwm: Add PWM driver for Intel Keem Bay
>=20
> Hello,
>=20
> On Wed, Aug 26, 2020 at 06:25:58PM +0800,
> vineetha.g.jaya.kumaran@intel.com wrote:
> > From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> >
> > Enable PWM support for the Intel Keem Bay SoC.
> >
> > Co-developed-by: Vineetha G. Jaya Kumaran
> > <vineetha.g.jaya.kumaran@intel.com>
> > Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
> > Signed-off-by: Vineetha G. Jaya Kumaran
> > <vineetha.g.jaya.kumaran@intel.com>
> > ---
> >  drivers/pwm/Kconfig       |   9 ++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-keembay.c | 228
> > ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 238 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-keembay.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > 7dbcf69..0a68a167 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -560,4 +560,13 @@ config PWM_ZX
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-zx.
> >
> > +config PWM_KEEMBAY
> > +	tristate "Intel Keem Bay PWM driver"
> > +	depends on ARM64 || COMPILE_TEST
> > +	help
> > +	  The platform driver for Intel Keem Bay PWM controller.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-keembay.
>=20
> The symbols in drivers/pwm/Kconfig are ordered alphabetically.
>=20

OK, I will reorder this.

> > +
> >  endif
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> > 2c2ba0a..293e48f 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -54,3 +54,4 @@ obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
> >  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
> >  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> >  obj-$(CONFIG_PWM_ZX)		+=3D pwm-zx.o
> > +obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
>=20
> ditto.
>=20
> > diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
> new
> > file mode 100644 index 00000000..3c7481f
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-keembay.c
> > @@ -0,0 +1,228 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Intel Keem Bay PWM driver
> > + *
> > + * Copyright (C) 2020 Intel Corporation
> > + * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
> > + *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.co=
m>
> > + *
> > + * Limitation:
>=20
> Please make this "Limitations:" for consitency with other drivers. This a=
llows
> something like
>=20
> 	for f in drivers/pwm/pwm-*; do echo $f; sed -nr
> '/Limitations:/,/\*\/?$/p' $f; done
>=20
> to work nicely.
>=20

OK, will update this to "Limitations:"

> > + * - Upon disabling a channel, the currently running
> > + *   period will not be completed. However, upon
> > + *   reconfiguration of the duty cycle/period, the
> > + *   currently running period will be completed first.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +
> > +#define KMB_TOTAL_PWM_CHANNELS		6
> > +#define KMB_PWM_COUNT_MAX		0xffff
> > +#define KMB_PWM_EN_BIT			BIT(31)
> > +
> > +/* Mask */
> > +#define KMB_PWM_HIGH_MASK		GENMASK(31, 16)
> > +#define KMB_PWM_LOW_MASK		GENMASK(15, 0)
> > +#define KMB_PWM_COUNT_MASK		GENMASK(31, 0)
> > +
> > +/* PWM Register offset */
> > +#define KMB_PWM_LEADIN_OFFSET(ch)	(0x00 + 4 * (ch))
> > +#define KMB_PWM_HIGHLOW_OFFSET(ch)	(0x20 + 4 * (ch))
> > +
> > +struct keembay_pwm {
> > +	struct pwm_chip chip;
> > +	struct device *dev;
> > +	struct clk *clk;
> > +	void __iomem *base;
> > +};
> > +
> > +static inline struct keembay_pwm *to_keembay_pwm_dev(struct
> pwm_chip
> > +*chip) {
> > +	return container_of(chip, struct keembay_pwm, chip); }
> > +
> > +static inline void keembay_pwm_update_bits(struct keembay_pwm
> *priv, u32 mask,
> > +					   u32 val, u32 offset)
> > +{
> > +	u32 buff =3D readl(priv->base + offset);
> > +
> > +	buff =3D u32_replace_bits(buff, val, mask);
> > +	writel(buff, priv->base + offset);
> > +}
> > +
> > +static void keembay_pwm_enable(struct keembay_pwm *priv, int ch) {
> > +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 1,
> > +				KMB_PWM_LEADIN_OFFSET(ch));
> > +}
> > +
> > +static void keembay_pwm_disable(struct keembay_pwm *priv, int ch) {
> > +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 0,
> > +				KMB_PWM_LEADIN_OFFSET(ch));
> > +}
> > +
> > +static void keembay_pwm_get_state(struct pwm_chip *chip, struct
> pwm_device *pwm,
> > +				  struct pwm_state *state)
> > +{
> > +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> > +	unsigned long long pwm_h_count, pwm_l_count;
> > +	unsigned long clk_rate;
> > +	u32 buff;
> > +
> > +	clk_rate =3D clk_get_rate(priv->clk);
>=20
> clk_get_rate() must only be called when the clock is enabled. Unless I mi=
ss
> something this isn't ensured here.
>=20

My understanding is this would not be a problem, as according to databook, =
the GPIO block clock is auto-enabled,=20
and also we are not doing any disabling in the driver for it.=20

> > +
> > +	/* Read channel enabled status */
> > +	buff =3D readl(priv->base + KMB_PWM_LEADIN_OFFSET(pwm-
> >hwpwm));
> > +	if (buff & KMB_PWM_EN_BIT)
> > +		state->enabled =3D true;
> > +	else
> > +		state->enabled =3D false;
> > +
> > +	/* Read period and duty cycle */
> > +	buff =3D readl(priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm-
> >hwpwm));
> > +	pwm_l_count =3D FIELD_GET(KMB_PWM_LOW_MASK, buff) *
> NSEC_PER_SEC;
> > +	pwm_h_count =3D FIELD_GET(KMB_PWM_HIGH_MASK, buff) *
> NSEC_PER_SEC;
> > +	state->duty_cycle =3D DIV_ROUND_UP_ULL(pwm_h_count, clk_rate);
> > +	state->period =3D DIV_ROUND_UP_ULL(pwm_h_count +
> pwm_l_count,
> > +clk_rate); }
> > +
> > +static int keembay_pwm_apply(struct pwm_chip *chip, struct
> pwm_device *pwm,
> > +			     const struct pwm_state *state) {
> > +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> > +	struct pwm_state current_state;
> > +	u16 pwm_h_count, pwm_l_count;
> > +	unsigned long long div;
> > +	unsigned long clk_rate;
> > +	u32 pwm_count =3D 0;
> > +
> > +	keembay_pwm_get_state(chip, pwm, &current_state);
>=20
> This can be moved after the test for state->polarity.
>=20

OK, will move this.

> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -ENOSYS;
> > +
> > +	if (!state->enabled && current_state.enabled) {
> > +		keembay_pwm_disable(priv, pwm->hwpwm);
> > +		return 0;
> > +	}
>=20
> if (!state->enabled) {
> 	if (current_state.enabled)
> 		keembay_pwm_disable(priv, pwm->hwpwm);
> 	return 0;
> }
>=20

OK, I will update this.

> > +
> > +	/*
> > +	 * The upper 16 bits of the KMB_PWM_HIGHLOW_OFFSET register
> contain
> > +	 * the high time of the waveform, while the last 16 bits contain
> > +	 * the low time of the waveform, in terms of clock cycles.
> > +	 *
> > +	 * high time =3D clock rate * duty cycle
> > +	 * low time =3D  clock rate * (period - duty cycle)
> > +	 *
> > +	 * e.g. For period 50us, duty cycle 30us, and clock rate 500MHz:
> > +	 * high time =3D 500MHz * 30us =3D 0x3A98
> > +	 * low time =3D 500MHz * 20us =3D 0x2710
> > +	 * Value written to KMB_PWM_HIGHLOW_OFFSET =3D 0x3A982710
> > +	 */
> > +
> > +	clk_rate =3D clk_get_rate(priv->clk);
> > +
> > +	/* Configure waveform high time */
> > +	div =3D clk_rate * state->duty_cycle;
>=20
> Since v5.9-rc1 (commit a9d887dc1c60ed67f2271d66560cdcf864c4a578)
> state->duty_cycle is a 64 bit type. So div being unsigned long isn't
> big enough on some platforms.
>=20

div is 64-bit here, so I guess I can keep it as is?

> > +	div =3D DIV_ROUND_CLOSEST_ULL(div, NSEC_PER_SEC);
> > +	if (div > KMB_PWM_COUNT_MAX)
> > +		return -ERANGE;
> > +
> > +	pwm_h_count =3D div;
> > +
> > +	/* Configure waveform low time */
> > +	div =3D clk_rate * (state->period - state->duty_cycle);
> > +	div =3D DIV_ROUND_CLOSEST_ULL(div, NSEC_PER_SEC);
> > +	if (div > KMB_PWM_COUNT_MAX)
> > +		return -ERANGE;
> > +
> > +	pwm_l_count =3D div;
> > +
> > +	pwm_count =3D FIELD_PREP(KMB_PWM_HIGH_MASK,
> pwm_h_count) |
> > +		    FIELD_PREP(KMB_PWM_LOW_MASK, pwm_l_count);
> > +
> > +	writel(pwm_count, priv->base +
> KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
> > +
> > +	if (state->enabled && !current_state.enabled)
> > +		keembay_pwm_enable(priv, pwm->hwpwm);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pwm_ops keembay_pwm_ops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.apply =3D keembay_pwm_apply,
> > +	.get_state =3D keembay_pwm_get_state,
> > +};
> > +
> > +static int keembay_pwm_probe(struct platform_device *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct keembay_pwm *priv;
> > +	int ret, ch;
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(priv->clk))
> > +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to
> get
> > +clock\n");
> > +
> > +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> > +
> > +	priv->chip.base =3D -1;
> > +	priv->chip.dev =3D dev;
> > +	priv->chip.ops =3D &keembay_pwm_ops;
> > +	priv->chip.npwm =3D KMB_TOTAL_PWM_CHANNELS;
> > +
> > +	ret =3D pwmchip_add(&priv->chip);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to add PWM chip: %pe\n",
> ERR_PTR(ret));
> > +		return ret;
> > +	}
> > +
> > +	/* Ensure enable bit for each channel is cleared at boot */
> > +	for (ch =3D 0; ch < KMB_TOTAL_PWM_CHANNELS; ch++)
> > +		keembay_pwm_disable(priv, ch);
>=20
> .probe() is not supposed to change the state of the PWM.
>=20

Sorry, I think misunderstood one of your comments in V2 and added this.
The reset value of the enable bit (and all other bits) in the LEADIN regist=
er is 0, so this may not be needed.=20
If it's ok, I'll remove it.

> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	return 0;
> > +}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Thank you,
Vineetha
