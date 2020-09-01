Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002D62584EB
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Sep 2020 02:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgIAArV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 20:47:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:59801 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgIAArS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 Aug 2020 20:47:18 -0400
IronPort-SDR: c/iHUYBjvpMsAasLMtXSgiopg52giqEh0Czvz0+5g5GsSWOBjW/V0QQ+5/bCpc9P+0l+KSFu3P
 fjg/pKZqdaMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="137131089"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="137131089"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 17:46:13 -0700
IronPort-SDR: 9gqexfOiLZcRmNJzm4QWuHCd7M6Qv3Q+IXTrfxNqUWPHdo+mb3+V4afw7C0hmglsWcC8n01NGH
 nKJudo2faSbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="374982511"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 31 Aug 2020 17:46:13 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 31 Aug 2020 17:46:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 31 Aug 2020 17:46:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 31 Aug 2020 17:46:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnxxnrMaVH3HrCklmhqlVMVBN/tG1b7aK/9c/M+TFiezQz6i2yBI6eHLtD3FPbCTA4Kp26xPvYkEr4wSj5qzV8zGzN++HbT0mlwPKsOaXRE45s0OZioqxAGbPr+4NaEkGSQRZ7euvM04tPo6NEXUROeWFoawM+foVpo3TOh8vdc8OEsFdixy3557oM2s1z7PBQItOlyy3T8PnhchilXzp0vc5PGRxo3wjGSN8vpXOsrx8ejFCfQZFUbZSh/8lv/WZwgv+OEVatyZ+HDH2t6c/acnXIVPyOSigaFodFIsd0COaJCVHQ6fmr1g2tpMnVRf9M4/ddDEYEvqKMB1ItXBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx4EndzW2UkxQbOYC2sI3DCg25pinmlnU7U52fIJKwI=;
 b=lbGPz7sv7dNwEf+ugEtyJqBjkrjsvFABScPru4lOdMhn0Zndw7XV3bgj/XiLHVZ9KqiMsdmW1GScg00MNflevtLZEzbb44Kk4bdc16QOzErzTUluZw5y+FBkdCWVGBNNMlR+ydul8QmCay6Dk0NAAawdRVVyJh4zahuNebNERpjpUHBr9WY6qYnpCiWSTrHXrYNSNFyFybo0ay6Of9Lu+BF0Y2PN+3jkn0+XoSTBcZ/7uW2dGGBUsCF4BP1ioYrLPCZXB/fGhPGsglHoo2js1uIbuZZi9t374WoAOod79p/DydKf1MMvvEj/fzzfm5TZgKYv0PH5amjMdICDsklu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx4EndzW2UkxQbOYC2sI3DCg25pinmlnU7U52fIJKwI=;
 b=whyTUNXS/LzcZ8fOPNShUAG8l/Sa74rQteOtfadPyt0wxG0hmOSVkdXV5l9W8QGj/szg+0SlPPcHl8nCsR/xkhS1PIJY/L5F4enYxXGBuD0tb3PzZonwczQ6Rc+NDCqQr3wFOd/xHGRj/6fZ6cUxE7rq72WB3dAoP9qeWRkzlb4=
Received: from SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20)
 by SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Tue, 1 Sep
 2020 00:46:07 +0000
Received: from SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::6407:40fd:19e3:e270]) by SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::6407:40fd:19e3:e270%7]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 00:46:07 +0000
From:   "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v5 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH v5 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWe5OG7Z7IhOoQU0eHxYJS7P1m0qlKNtCAgAjEZ5A=
Date:   Tue, 1 Sep 2020 00:46:07 +0000
Message-ID: <SN6PR11MB257539FFCF78220A6DBEB420F62E0@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1598437559-25828-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1598437559-25828-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200826105225.GI1891694@smile.fi.intel.com>
In-Reply-To: <20200826105225.GI1891694@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.153.157.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d15ec4d1-15c5-480e-2293-08d84e106a0d
x-ms-traffictypediagnostic: SN6PR11MB2575:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2575366A93945B367380AF52F62E0@SN6PR11MB2575.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XIXEe028LxKCTsiHLNTQePSWCJwl22JFig5Ny0sRpbeP3stPYEhsL3DuISroAj/mEsIGcVJEz8KmFgIdqKYzDnhXQgkiertlwjCQWVuKygeoYilbdrtKSpf9xhNPoFryMvBEkOnnQBN9llJm7kCFZZpJdtvHUfgKts/NZmU0XXgNR3gY40r/MHia/bxjo3L73R9FWALY/BlT/8DKDlvo15Wosl5kKyQuOYCXoPii6VPyEPF67E9lAf2PKgmeQuK3cO65y0rc3ctB/8w/eL+kXl7tS/kBuevksmKP2Ui9JfKCCfCj2Fmbp1MKturFFFkXwhe6xu2nOuoG//D3fIO5VA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2575.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(8936002)(7696005)(26005)(5660300002)(8676002)(186003)(53546011)(6506007)(316002)(9686003)(54906003)(52536014)(76116006)(4326008)(55016002)(2906002)(71200400001)(66946007)(33656002)(86362001)(83380400001)(6916009)(478600001)(64756008)(66556008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pjzNS7go2aYd/cSzK8hi+jYEIcgFEHwGkuQM0DUcHMY4smeSEr0aZwEco7mp7/w/jmBx7fSZsQZ9DCM8daGMJcuFNP4tS3jIqfSV9SgOunBXjYTjFRVSyX2kYIKfajF29tpZgGpFAP4S4EAZKa4j6JioBPwK7RFh10ZdbHZt/1rClwEJpp14XCoti5PICyMh/rVHBxLZGahmGS4t8HPfbmSrey+E7hCo1yfczoh/nlW4Ki1/vp4j72vdcsT9nRVyiZrik6XpjNTVc2VEz7dQqxz10n1rVxZitdvVqVFl9nB2rL2OLFAVA6gHUE1WiI3A7mww6FvB6ztX3r4NV2oh8yXnDG6nonoISB+2N7fCGSh9g3McqyOXILznzNuk9lRoUqZxmDI7V1HRiaS5iCYgAUkMzliLoNSIoRdC7LJhRA8Q2JsGaWVagWKm4JUvYr8ReUWvNGSX9Jr6c7B/Fi9EqVNbKGovWldsdKBAJnCMG8PmTiRGjojIfuXUm721UgLNd4U67f6jpVeakKb4rRhZ7kZQa47z+dUK7C1VzNqLCMQWtRuDOgwcRB0fl4SIpX7MpfhDvXX+mX7sEfgxiXVvhktiEh2YXeyI5GQ7EEAkYLgWsbpPHsQ+/XZS2UUpntOzW694XFItQiKnmCF8THfH/A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2575.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15ec4d1-15c5-480e-2293-08d84e106a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 00:46:07.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PF2qzTYtKCyb9MdPL+ujNdVkHCip8PtYXzG8x1G8pXmJlNZ8KX6j5n5b1WTcQfLINMBnXXZAEKoS6qU4GfyVloIevkDLA8fyof8/ymqpfoeKEt1LuzDOamtrisKhaQtX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2575
X-OriginatorOrg: intel.com
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, August 26, 2020 6:52 PM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: thierry.reding@gmail.com; u.kleine-koenig@pengutronix.de;
> robh+dt@kernel.org; linux-pwm@vger.kernel.org;
> devicetree@vger.kernel.org; Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>; Raja Subramanian, Lakshmi
> Bai <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH v5 1/2] pwm: Add PWM driver for Intel Keem Bay
>=20
> On Wed, Aug 26, 2020 at 06:25:58PM +0800,
> vineetha.g.jaya.kumaran@intel.com wrote:
> > From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> >
> > Enable PWM support for the Intel Keem Bay SoC.
>=20
> LGTM, FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20

Thanks Andy.

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
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -ENOSYS;
> > +
> > +	if (!state->enabled && current_state.enabled) {
> > +		keembay_pwm_disable(priv, pwm->hwpwm);
> > +		return 0;
> > +	}
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
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	return 0;
> > +}
> > +
> > +static int keembay_pwm_remove(struct platform_device *pdev) {
> > +	struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
> > +
> > +	return pwmchip_remove(&priv->chip);
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
> > +MODULE_ALIAS("platform:pwm-keembay");
> > +MODULE_DESCRIPTION("Intel Keem Bay PWM driver");
> MODULE_LICENSE("GPL
> > +v2");
> > --
> > 1.9.1
> >
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

