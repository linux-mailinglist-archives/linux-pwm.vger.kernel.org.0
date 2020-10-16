Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D0428FCA8
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 05:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394008AbgJPDSP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Oct 2020 23:18:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:15900 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394007AbgJPDSO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 15 Oct 2020 23:18:14 -0400
IronPort-SDR: ocYG7Qovq9U46PtmEwb2q58Ho9QMD3hlWF2PQfj2k5HQlMU80xRfUYkUSqc6JAeAEoTtinjYCn
 y9DDkae7o82A==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="230706694"
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; 
   d="scan'208";a="230706694"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 20:18:11 -0700
IronPort-SDR: JOAgLrcJj6F6DPnrjATr/fZAu6eDNdvmYCUUvBEf6yhMXJMC38IWhG02mhtGDDcQFeLnC/UbCd
 ko0RbIW7AgBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; 
   d="scan'208";a="346389104"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 15 Oct 2020 20:18:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 15 Oct 2020 20:18:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 15 Oct 2020 20:18:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 15 Oct 2020 20:18:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 15 Oct 2020 20:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+H8ezXYKUc94tV9b7Kp9Oyt14eR3lCTKGDUroZUK388LnYD4iPP9U5D4rgVgE9XiAun9oIemZO7If++pDtgq2uARWJiI9uXTWw+VdBQ0STrPZbnMcPGiqaipGcsyngkwm5isDch6EP+JGhXrk5k32zaODIy5Aq7Ds4MgwDQwBS8cnbtTAEMxXewGsaazf2TyJWPyByd23O3+y59glTgUPdTSM6hQ+2tPi+9WATOBYB7/aTUhsh1XnYIZl50BHo0FC3Mzrv1G/kUkKeOCr7+qrLKtkQdSNp1c9YjGvAd4gKw/7Q6PTUvoexzqk6t/fdJ69oBVPpxyE1Ehv8UztzQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtbijDT1y94iiO50iaWJ3H0fvLBxfzCB8/Glsc8Gmic=;
 b=cO85kKpL7BcY3A6OIEIyeY7ujQoODZ8U3rkAZr7fzUsBPNBnUB3IAt92ptMDQ83Kv2oob1NJ0jElko+CPky2hh8kbfKWt8TnePSqhJr/2vrNawJDhsSgCtNYUFk0mCJm6knDwnXstnnHigyJMEccAnHJ6oUqjnSVWVocBokHQwEF2LUPDZ48zS6ctz4XCrhb918eTtGcYUp7yltgBvbWlNFdLX8L+ZweBwLpn2MJeAODubYliyy5wx9pnW6eUaSFlhR64vGQs4fZN5DVJ4/Uct5uTU0QJcRYTKjBP5AHALprbKwmyqvYECstagl+wxSISSiBelfQ8GPPy3t6LEJ3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtbijDT1y94iiO50iaWJ3H0fvLBxfzCB8/Glsc8Gmic=;
 b=oNrtq9k78Epv9/R4I/6ycLHFrHpEIdnp0LJIVEHDjLhCCbl5RzJRjk+IkI5CRJdLqauzMItr+rsHXtENMoY2/tnSciFNQwU4OtEceL0dVx/dfQt8PDQCJmMy1uOwkkMtPoCNfQ/dUcoUSP130STKDokD7aahjnUZc+ddPen5Agg=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB3529.namprd11.prod.outlook.com (2603:10b6:5:63::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 03:18:08 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09%3]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 03:18:08 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWomCF+NkKYBj1fUCQimGsu2FSAKmYevKAgAENFDA=
Date:   Fri, 16 Oct 2020 03:18:08 +0000
Message-ID: <DM6PR11MB425089996A0CC9A43CBC50C5FB030@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <5fc6189f9c4cf382d54ae00e663f296baeb2c06e.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <20201015104217.GR4077@smile.fi.intel.com>
In-Reply-To: <20201015104217.GR4077@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.111.145.160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2c07f45-4513-457d-ee90-08d871821ae6
x-ms-traffictypediagnostic: DM6PR11MB3529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB352903846EA761B77A2CC70AFB030@DM6PR11MB3529.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9KguAZNAZe9wEa8Gu6FBYTlxxJADJlRuDu1RKL6ER4ZGIgbRYKbn57C589ixGZfQyOErpI2WnQSj24Bg+pL3W2m6tLcQw+lj5iifvzRFzw4066FKmKVPjP+tR4hsAGITpR3YYBU0I3VE5Pife3wc3J9sYOMI7hWV7FcqHC5FbZHzb2vmLcqUMSHMjTCAmdWFB0PIEX8vBWozz0m0VunmGKC/recuK2A9Of55ZWYFpnMHHuP12NBEZBPsHdgGzdQF35k4XVQJYqK2tX/B4KEgE84BwqySIem4C0x19PVVm0HYh/gL+IoO4ra70k/9kzgxU4+PEvYXIafeW0X27+Tjlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(6506007)(33656002)(52536014)(53546011)(66556008)(64756008)(66446008)(83380400001)(66946007)(86362001)(316002)(66476007)(76116006)(71200400001)(6916009)(5660300002)(54906003)(8676002)(478600001)(26005)(9686003)(4326008)(55016002)(7696005)(2906002)(186003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CKVL5mig/1RKlolNrovvllHHm4ZtO+DaBUBNa/aFgPz7aO87U74hp8z3pw1kpHUjTgmk0XZSM17KCY+uMXkVsEzL8z6Bwr7XDJJEflPKtv8KBuRBpnlUS+SSRedwDuLZLpNFc0z/dLAIrg3eZQq802IY1UPf2nAr1IXGVqO826girDmKLypMh8zVhXNtMcmBPPf/PsGW3kgK5sRXiP7W3i4vqFcmhcpheKIiB2OmMQgVeVmaffzkIo13j7uO4N9camf/ENnu4u7SUYaxviU46IzmpSsiQmN8/AXjMeKlf+R6ObMma00vbsSSP/4UIv5jNXH+u6df53voIqSw7BCMYx6c6IB/BsiR6grF+SIul9QYQ4VksSIAWy8BFBdO7RVwPo5EJkiHwhdRrvmqg9159DENYbPZ3+lOOQMz9GnMXibxW/4U+sW3Fh21Mr2Qx/2f/MdIYG3YGQSudgOm/AFtq6JNoYxtCJIXkrxtMSvBu/aIGIxMZx2CJoOiLOcPsrmFqkFI16RMDLXzYkc/nA49NHfefzywv/dB8Go1ALrT3PKZg5JCIetjjEPF3d/3j0ptGOd/MUFf092Dw9x7+rBibbly37oCQzv1mXjP8ddY4yTVdHZWil3T2eSr+zcCzAOyb5z/5XxXDMTlQFBKglEVNQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c07f45-4513-457d-ee90-08d871821ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 03:18:08.3334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jqp5k2pEGHkaqXwNb1s8j31pkRM7t6xyqRRY/ckUFEgmmf5jVXgX+TuNsJQEdFrkIAx2V7nAMhvU/cdicfkxiAtJAexT3XcT0IVbinzR8BHyhgCagY+lxUYwutxUDKBL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3529
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andy,

-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=20
Sent: Thursday, 15 October, 2020 4:12 PM
To: Ayyathurai, Vijayakannan <vijayakannan.ayyathurai@intel.com>
Cc: thierry.reding@gmail.com; u.kleine-koenig@pengutronix.de; robh+dt@kerne=
l.org; linux-pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, =
Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; mgross@linux.int=
el.com; Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.c=
om>
Subject: Re: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay

On Thu, Oct 15, 2020 at 03:36:09AM +0800, vijayakannan.ayyathurai@intel.com=
 wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
>=20
> The Intel Keem Bay SoC requires PWM support.
> Add the pwm-keembay driver to enable this.
>=20
> Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>

Missed Co-developed-by?

Sure. I will add my Co-developed-by tag.

> Co-developed-by: Vineetha G. Jaya Kumaran=20
> <vineetha.g.jaya.kumaran@intel.com>
> Signed-off-by: Vineetha G. Jaya Kumaran=20
> <vineetha.g.jaya.kumaran@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Vijayakannan Ayyathurai=20
> <vijayakannan.ayyathurai@intel.com>
> ---
>  drivers/pwm/Kconfig       |   9 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-keembay.c | 233=20
> ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 243 insertions(+)
>  create mode 100644 drivers/pwm/pwm-keembay.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index=20
> 7dbcf6973d33..6129a9dbbfa8 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -254,6 +254,15 @@ config PWM_JZ4740
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-jz4740.
> =20
> +config PWM_KEEMBAY
> +	tristate "Intel Keem Bay PWM driver"
> +	depends on ARCH_KEEMBAY || COMPILE_TEST
> +	help
> +	  The platform driver for Intel Keem Bay PWM controller.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-keembay.
> +
>  config PWM_LP3943
>  	tristate "TI/National Semiconductor LP3943 PWM support"
>  	depends on MFD_LP3943
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index=20
> 2c2ba0a03557..a1051122eb07 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
>  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
> +obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
>  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
>  obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
>  obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
> diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c new=20
> file mode 100644 index 000000000000..ced6d4010add
> --- /dev/null
> +++ b/drivers/pwm/pwm-keembay.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Keem Bay PWM driver
> + *
> + * Copyright (C) 2020 Intel Corporation
> + * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
> + *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> + *
> + * Limitations:
> + * - Upon disabling a channel, the currently running
> + *   period will not be completed. However, upon
> + *   reconfiguration of the duty cycle/period, the
> + *   currently running period will be completed first.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +#define KMB_TOTAL_PWM_CHANNELS		6
> +#define KMB_PWM_COUNT_MAX		U16_MAX
> +#define KMB_PWM_EN_BIT			BIT(31)
> +
> +/* Mask */
> +#define KMB_PWM_HIGH_MASK		GENMASK(31, 16)
> +#define KMB_PWM_LOW_MASK		GENMASK(15, 0)
> +#define KMB_PWM_LEADIN_MASK		GENMASK(30, 0)
> +
> +/* PWM Register offset */
> +#define KMB_PWM_LEADIN_OFFSET(ch)	(0x00 + 4 * (ch))
> +#define KMB_PWM_HIGHLOW_OFFSET(ch)	(0x20 + 4 * (ch))
> +
> +struct keembay_pwm {
> +	struct pwm_chip chip;
> +	struct device *dev;
> +	struct clk *clk;
> +	void __iomem *base;
> +};
> +
> +static inline struct keembay_pwm *to_keembay_pwm_dev(struct pwm_chip=20
> +*chip) {
> +	return container_of(chip, struct keembay_pwm, chip); }
> +
> +static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u32=
 mask,
> +					   u32 val, u32 offset)
> +{
> +	u32 buff =3D readl(priv->base + offset);
> +
> +	buff =3D u32_replace_bits(buff, val, mask);
> +	writel(buff, priv->base + offset);
> +}
> +
> +static void keembay_pwm_enable(struct keembay_pwm *priv, int ch) {
> +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 1,
> +				KMB_PWM_LEADIN_OFFSET(ch));
> +}
> +
> +static void keembay_pwm_disable(struct keembay_pwm *priv, int ch) {
> +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 0,
> +				KMB_PWM_LEADIN_OFFSET(ch));
> +}
> +
> +static void keembay_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> +	unsigned long long high, low;
> +	unsigned long clk_rate;
> +	u32 highlow;
> +
> +	clk_rate =3D clk_get_rate(priv->clk);
> +
> +	/* Read channel enabled status */
> +	highlow =3D readl(priv->base + KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
> +	if (highlow & KMB_PWM_EN_BIT)
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +
> +	/* Read period and duty cycle */
> +	highlow =3D readl(priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
> +	low =3D FIELD_GET(KMB_PWM_LOW_MASK, highlow) * NSEC_PER_SEC;
> +	high =3D FIELD_GET(KMB_PWM_HIGH_MASK, highlow) * NSEC_PER_SEC;
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(high, clk_rate);
> +	state->period =3D DIV_ROUND_UP_ULL(high + low, clk_rate);
> +	state->polarity =3D PWM_POLARITY_NORMAL; }
> +
> +static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state) {
> +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> +	struct pwm_state current_state;
> +	unsigned long long div;
> +	unsigned long clk_rate;
> +	u32 pwm_count =3D 0;
> +	u16 high, low;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -ENOSYS;
> +
> +	/*
> +	 * Configure the pwm repeat count as infinite at (15:0) and leadin
> +	 * low time as 0 at (30:16), which is in terms of clock cycles.
> +	 */
> +	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
> +				KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
> +
> +	keembay_pwm_get_state(chip, pwm, &current_state);
> +
> +	if (!state->enabled) {
> +		if (current_state.enabled)
> +			keembay_pwm_disable(priv, pwm->hwpwm);
> +		return 0;
> +	}
> +
> +	/*
> +	 * The upper 16 bits and lower 16 bits of the KMB_PWM_HIGHLOW_OFFSET
> +	 * register contain the high time and low time of waveform accordingly.
> +	 * All the values are in terms of clock cycles.
> +	 */
> +
> +	clk_rate =3D clk_get_rate(priv->clk);
> +	div =3D clk_rate * state->duty_cycle;
> +	div =3D DIV_ROUND_DOWN_ULL(div, NSEC_PER_SEC);
> +	if (div > KMB_PWM_COUNT_MAX)
> +		return -ERANGE;
> +
> +	high =3D div;
> +	div =3D clk_rate * state->period;
> +	div =3D DIV_ROUND_DOWN_ULL(div, NSEC_PER_SEC);
> +	div =3D div - high;
> +	if (div > KMB_PWM_COUNT_MAX)
> +		return -ERANGE;
> +
> +	low =3D div;
> +
> +	pwm_count =3D FIELD_PREP(KMB_PWM_HIGH_MASK, high) |
> +		    FIELD_PREP(KMB_PWM_LOW_MASK, low);
> +
> +	writel(pwm_count, priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
> +
> +	if (state->enabled && !current_state.enabled)
> +		keembay_pwm_enable(priv, pwm->hwpwm);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops keembay_pwm_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.apply =3D keembay_pwm_apply,
> +	.get_state =3D keembay_pwm_get_state,
> +};
> +
> +static int keembay_pwm_probe(struct platform_device *pdev) {
> +	struct device *dev =3D &pdev->dev;
> +	struct keembay_pwm *priv;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get=20
> +clock\n");
> +
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base)) {

> +		clk_disable_unprepare(priv->clk);

See below.

> +		return PTR_ERR(priv->base);
> +	}
> +
> +	priv->chip.base =3D -1;
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &keembay_pwm_ops;
> +	priv->chip.npwm =3D KMB_TOTAL_PWM_CHANNELS;
> +
> +	ret =3D pwmchip_add(&priv->chip);
> +	if (ret) {
> +		dev_err(dev, "Failed to add PWM chip: %pe\n", ERR_PTR(ret));

> +		clk_disable_unprepare(priv->clk);

This messes up with ordering of things.

That's why devm golden rule is either all or none. You may fix this by swit=
ching to devm_add_action_or_reset().

One of possible way is like in below drivers:

	% git grep -n devm_add_action_or_reset.*disable_unprepare -- drivers/

But it may be fixed in follow up change. Depends on maintainers' wishes.

Sure. I shall incorporate and check based on maintainers wish in the next v=
ersion.

> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static int keembay_pwm_remove(struct platform_device *pdev) {
> +	struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret =3D pwmchip_remove(&priv->chip);
> +	clk_disable_unprepare(priv->clk);
> +
> +	return ret;

...and this will be simplified to

	return pwmchip_remove(&priv->chip);

Until v10, It is as per your suggestion. But I have changed it in v11 to ov=
ercome the issue mentioned by Uwe. I have kept the snip of v10 FYR below.

//Start snip from v10 review mailing list
//> +static int keembay_pwm_remove(struct platform_device *pdev) {
//> +	struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
//> +
//> +	clk_disable_unprepare(priv->clk);
//> +
//> +	return pwmchip_remove(&priv->chip);
//
//You have to call pwmchip_remove first. Otherwise you're stopping the PWM =
while the framework still believes everything to be fine.
//
//> +}
//End snip from v10 review mailing review

> +}
> +
> +static const struct of_device_id keembay_pwm_of_match[] =3D {
> +	{ .compatible =3D "intel,keembay-pwm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, keembay_pwm_of_match);
> +
> +static struct platform_driver keembay_pwm_driver =3D {
> +	.probe	=3D keembay_pwm_probe,
> +	.remove	=3D keembay_pwm_remove,
> +	.driver	=3D {
> +		.name =3D "pwm-keembay",
> +		.of_match_table =3D keembay_pwm_of_match,
> +	},
> +};
> +module_platform_driver(keembay_pwm_driver);
> +
> +MODULE_ALIAS("platform:pwm-keembay");
> +MODULE_DESCRIPTION("Intel Keem Bay PWM driver"); MODULE_LICENSE("GPL=20
> +v2");
> --
> 2.17.1
>=20

--=20
With Best Regards,
Andy Shevchenko

Thanks,
Vijay
