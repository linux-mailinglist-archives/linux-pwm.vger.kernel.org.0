Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1320D22E51C
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 07:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgG0FMU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 01:12:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:46734 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgG0FMT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 27 Jul 2020 01:12:19 -0400
IronPort-SDR: Gvqd/VJIDd87IRrk5PbCIOIPzhl/d73T/EcTZTf5pCPaYV/qbcZC65ghY0uF87rwRHu9f5GKn4
 Oq90Z1eAWW9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="150134241"
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="150134241"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 22:12:17 -0700
IronPort-SDR: RdgdsipbheLP3sdkwIU5kFfM/Gh0GzFJYmszNHK4VbJ6Pa4pfxuql8gStdi4uqm09wQ445o0lT
 R3wCweZg/oTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="364009295"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga001.jf.intel.com with ESMTP; 26 Jul 2020 22:12:17 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Jul 2020 22:12:16 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Jul 2020 22:12:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 26 Jul 2020 22:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi2YMNJdkjtAOrxti0tDOku1f7hujMsmdxzjPcHH9WpDnf23YEoU0qNa5UtLcVPbLdxzd0bjW4Rmzg8TlLbkhyqmbttiLYm7W135eawlA/G4M5DIFm6xbbWdS6BaejVMuIzOEzjLTEhjkVJb5FXmL7Yn5/lq0p1ujaj7wgDKoQfUdYTUiwwJuYMZ+W//ta5sBvryUSED7DuIQioa60BnBM9EKwphVOWI6hv4HP6e1cDRcLpoKXUAlNBr+SEZv31Zru1EbcRJjX4L0jRP14bdBIFPfYWiQ/qZ+k0LvNPKM0tF33TMM7FtnCi2v1oRIN5REIGUgd2eUsexRLkJglSkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu3epoEUef9z9V5lIEDlWzhy2+Jb19WpWgj0GWKiRws=;
 b=AcAAib/sAQi7OYtLXMpZ2leUPNHhN1gBoj2m28I2u/46u52hbHXsHf/dG7xMJ7RCPJMNf5H7fQW8LgNtARff0EKm/m2Yz3IDs7jQwHVDAFBXTCqdXFz5mx5qw2OFn9mFIJ/CcaxndTm0tCjDdK1I8+NL3HDaFOJJZM3riicpEP/ALD9eqtdC7q+hHShLPmMR/ozGTIZCx4SkwDQ8G2gLtbDbT7d/+WZtU+UHlHsdECPAfecWzKicbp5D9+J7b4TCFtJXC1KhZJmof6I0ssYcqrzYg9r+HItR0WdKRr3jNCBhhH36BZRJuHxY7TH+L8XUGkAW5+QCEe/O9UylylblKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu3epoEUef9z9V5lIEDlWzhy2+Jb19WpWgj0GWKiRws=;
 b=DoEA+BFgZFFXg94PSElym+kxQ9ScwjGzGFrCBi5TQqv+MY4NASSf8etoyBc3xw7FV6Ct7DQitMxgVaRj5o83PBx7alnNKevo5PUzKYBiRu6ZnZQCZntZEh60HMue6xf5pJlZTlxmajcmAM9zzXxInNoOPcJta+4N1NecyAOpqcY=
Received: from SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20)
 by SN6PR11MB3391.namprd11.prod.outlook.com (2603:10b6:805:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 05:12:14 +0000
Received: from SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::cd49:6ea7:530c:95e0]) by SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::cd49:6ea7:530c:95e0%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 05:12:14 +0000
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
Thread-Index: AQHWXRK6NAlLAp2TVUOJw13sJrurl6kRxFEAgAHypbA=
Date:   Mon, 27 Jul 2020 05:12:14 +0000
Message-ID: <SN6PR11MB2575C601FB19C75AB56688ADF6720@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1595083628-20734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1595083628-20734-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200721091344.eka44xmkwmqbchm6@pengutronix.de>
In-Reply-To: <20200721091344.eka44xmkwmqbchm6@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [202.190.91.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 797771e7-1f38-4e6c-c191-08d831eba016
x-ms-traffictypediagnostic: SN6PR11MB3391:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB33918EBDDBC4F65062F2F76BF6720@SN6PR11MB3391.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQeVK8BFS25RMZZrN7kT7RDVbUISQEH8mAyzCackffzlZs4e0MjW2DYASO/b/ueRu8Oxa2/rK8MqCRXISmE5G+QHK4loUj0reZDQNgkQfS9IHOnucol/xZZJDWwPVrCyWMXDG+WjryZGYcmGA0/jZrLcQ5PQK+7pA5lbtmr/9DtIUegMexQxgYTuh4dnUSzvvQp/xib4gaHN3bLBUZHmxgapO8BEYtPx+9/Nr5f84BAgC134IXKUk2ujWzu+zdYCb5lYivsl7cd/5+bpFVxUNhwR3PwqS01jT/y++W/X12cKktFDS/gIHsi5fH/ggyqxr3+mHw2FT/KKjss7cp0YkG3sHqYbVFZIqiNA1EyP9/oFE5LGKttxBT7Emoc7LxACnihmQSkVoXepn/LMA1KsLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2575.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(76116006)(66574015)(4326008)(66946007)(66556008)(66446008)(7696005)(64756008)(6916009)(8936002)(33656002)(66476007)(71200400001)(9686003)(55016002)(2906002)(5660300002)(53546011)(52536014)(86362001)(966005)(478600001)(83380400001)(8676002)(186003)(54906003)(6506007)(26005)(316002)(83080400001)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FZPcbrZLUkLFOzfocDrqQ2tEcg7fEiaOOwGVPFD1jm0kpGM4N6HkQFZtqitcpcJtr1O8sisI9LuMdZMWM+Cn5zJGWWNf8cREV45uCofqyoSiFAqH5V/kLry/nfkRsl/QMfiDd+6QO5DGbp3hERNwpMJefTQTpdNLnqdfl56rNds1IULwu1JWJ0st4jFH9cKNrTVdL41FO1S4Q4S/nGA0NNrBtcU/flpc7XrcDUoxYuJD/97ogljC7wtM03vhdUH3DsbLeVZK1bLHvvurqZRflbnxaJE4Kn+MFIxqhbbCpR98QrX5jx4MXidP2MUu2aAxSZ8jWpkYJvpbprhUoQFJWQvFAWE+uvEOxSunwVwsXQZySDQRlEQ+GAzoyFX/HZHBTeVdOpIdIzTXC5qc7MExxFeM2bKdEXravHCtQFZ196071Vu898KgEXUsXD/AKaGRXMGDCbexExkP9uhpEF91tUWnM0ZSFKNDOuX3m9Rosu44VWqVRufQ3A3RX5DikOQD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2575.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797771e7-1f38-4e6c-c191-08d831eba016
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 05:12:14.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F4EQqi7zJTVcpcub1q+45DDkV7TiLFBUgEpZ9g7y/zU9LVUw8QNyHA2MzCFT/0v6j+B+8qNcFHzAfWOUuaCwF47uGbxwaJRadNikCAquAmmKaYAWCj0bMorLHNgOLOmU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3391
X-OriginatorOrg: intel.com
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for the feedback, will work on the changes for V3.

> -----Original Message-----
> From: linux-pwm-owner@vger.kernel.org <linux-pwm-
> owner@vger.kernel.org> On Behalf Of Uwe Kleine-K=F6nig
> Sent: Tuesday, July 21, 2020 5:14 PM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: thierry.reding@gmail.com; robh+dt@kernel.org; linux-
> pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, Wan
> Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Shevchenko,
> Andriy <andriy.shevchenko@intel.com>
> Subject: Re: [PATCH v2 1/2] pwm: Add PWM driver for Intel Keem Bay
>=20
> Hello,
>=20
> On Sat, Jul 18, 2020 at 10:47:07PM +0800,
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
> >  drivers/pwm/pwm-keembay.c | 239
> > ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 249 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-keembay.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > cb8d739..2b0419b 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -569,4 +569,13 @@ config PWM_ZX
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
> > a59c710..0c84ff2 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -55,3 +55,4 @@ obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
> >  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
> >  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> >  obj-$(CONFIG_PWM_ZX)		+=3D pwm-zx.o
> > +obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
> > diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
> new
> > file mode 100644 index 00000000..fa5fe95
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-keembay.c
> > @@ -0,0 +1,239 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Intel Keem Bay PWM driver
> > + *
> > + * Copyright (C) 2020 Intel Corporation
> > + * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
> > + *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.co=
m>
> > + */
>=20
> If possible, please add a link here to documentation for this chip.
>=20

There is no documentation released publicly (yet), but once there is, I wil=
l add it in.

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
> > +#define KMB_TOTAL_PWM_CHANNELS		6
> > +#define KMB_PWM_COUNT_MAX		65535
>=20
> If you write this as hexadecimal constant it is more obvious.
>=20
> > +#define KMB_PWM_EN_BIT			BIT(31)
> > +
> > +/* Mask */
> > +#define KMB_PWM_HIGH_MASK		GENMASK(31, 16)
> > +#define KMB_PWM_LOW_MASK		GENMASK(15, 0)
> > +#define KMB_PWM_COUNT_MASK		GENMASK(31, 0)
> > +
> > +/* PWM Register offset */
> > +#define KMB_PWM_LEADIN0_OFFSET		0x00
> > +#define KMB_PWM_LEADIN1_OFFSET		0x04
> > +#define KMB_PWM_LEADIN2_OFFSET		0x08
> > +#define KMB_PWM_LEADIN3_OFFSET		0x0c
> > +#define KMB_PWM_LEADIN4_OFFSET		0x10
> > +#define KMB_PWM_LEADIN5_OFFSET		0x14
>=20
> All but ..LEADIN0.. are unused. Is this maybe more useful to write as:
>=20
> 	#define KMB_PWM_LEADIN_OFFSET(ch)	(0x00 + 4 * (ch))
>=20
> ?
>=20

Agreed, will change this for both KMB_PWM_HIGHLOW_OFFSET and KMB_PWM_LEADIN=
_OFFSET.

> > +#define KMB_PWM_HIGHLOW0_OFFSET		0x20
> > +#define KMB_PWM_HIGHLOW1_OFFSET		0x24
> > +#define KMB_PWM_HIGHLOW2_OFFSET		0x28
> > +#define KMB_PWM_HIGHLOW3_OFFSET		0x2c
> > +#define KMB_PWM_HIGHLOW4_OFFSET		0x30
> > +#define KMB_PWM_HIGHLOW5_OFFSET		0x34
>=20
> ditto.
>=20
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
> > +					   u32 val, u32 reg, int ch)
> > +{
> > +	u32 buff, offset, tmp;
> > +	void __iomem *address;
> > +
> > +	offset =3D reg + ch * 4;
> > +	address =3D priv->base + offset;
> > +	buff =3D readl(address);
> > +	tmp =3D buff & ~mask;
> > +	tmp |=3D FIELD_PREP(mask, val);
> > +	writel(tmp, address);
> > +}
> > +
> > +static void keembay_pwm_enable(struct keembay_pwm *priv, int ch) {
> > +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 1,
> > +				KMB_PWM_LEADIN0_OFFSET, ch);
> > +}
> > +
> > +static void keembay_pwm_disable(struct keembay_pwm *priv, int ch) {
> > +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 0,
> > +				KMB_PWM_LEADIN0_OFFSET, ch);
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
> > +	buff =3D readl(priv->base + KMB_PWM_LEADIN0_OFFSET + pwm-
> >hwpwm * 4);
> > +	if (buff & KMB_PWM_EN_BIT)
> > +		state->enabled =3D true;
> > +	else
> > +		state->enabled =3D false;
> > +
> > +	/* Read period and duty cycle*/
>=20
> Missing ' ' before closing */
>=20
> > +	buff =3D readl(priv->base + KMB_PWM_HIGHLOW0_OFFSET + pwm-
> >hwpwm * 4);
> > +	pwm_l_count =3D (buff & KMB_PWM_LOW_MASK) * NSEC_PER_SEC;
> > +	pwm_h_count =3D ((buff & KMB_PWM_HIGH_MASK) >> 16) *
> NSEC_PER_SEC;
>=20
> pwm_h_count =3D FIELD_GET(KMB_PWM_HIGH_MASK, buff) *
> NSEC_PER_SEC
>=20
> > +	state->duty_cycle =3D pwm_h_count / clk_rate;
> > +	state->period =3D (pwm_h_count + pwm_l_count) / clk_rate;
>=20
> Please round up both values.
>=20
> > +}
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
> > +	pwm_get_state(pwm, &current_state);
>=20
> Please check the hardware state, not the value cached in the PWM
> framework.
>=20
> > +	if (!state->enabled && current_state.enabled) {
> > +		keembay_pwm_disable(priv, pwm->hwpwm);
> > +		return 0;
> > +	}
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -ENOSYS;
>=20
> This must be checked before .enabled. That's because the expectation on
>=20
> 	.enabled =3D false
> 	.polarity =3D PWM_POLARITY_INVERSED
>=20
> is that the output gets constant high.
>=20
> > +	/*
> > +	 * The upper 16 bits of the KMB_PWM_HIGHLOWx_OFFSET register
> contain
> > +	 * the high time of the waveform, while the last 16 bits contain
> > +	 * the low time of the waveform, in terms of clock cycles.
>=20
> Just to be sure: Each period starts with the high time, right?
>=20

Yes, each period starts with the high time.

> > +	 * high time =3D clock rate * duty cycle / NSEC_PER_SEC
> > +	 * low time =3D  clock rate * (period - duty cycle) / NSEC_PER_SEC
> > +	 *
> > +	 * e.g. For period 50000ns, duty cycle 30000ns, and clock rate 500MHz=
:
> > +	 * high time =3D (500000000 * 30000) / 1000000000 =3D 0x3A98
> > +	 * low time =3D (500000000 * 20000) / 1000000000 =3D 0x2710
> > +	 * Value written to KMB_PWM_HIGHLOWx_OFFSET =3D 0x3A982710
>=20
> For period =3D 50000ns, duty_cycle =3D 30000ns and clock rate 266666666 H=
z you
> have to configure:
>=20
> 	high =3D 7999
> 	low =3D 5334
>=20
> > +	 */
> > +
> > +	clk_rate =3D clk_get_rate(priv->clk);
> > +
> > +	/* Configure waveform high time */
> > +	div =3D clk_rate * state->duty_cycle;
> > +	do_div(div, NSEC_PER_SEC);
>=20
> Can this overflow?
>=20
> > +	if (div > KMB_PWM_COUNT_MAX)
> > +		return -ERANGE;
> > +
> > +	pwm_h_count =3D (u16)div;
>=20
> No need for this cast.
>=20
> > +	/* Configure waveform low time */
> > +	div =3D clk_rate * (state->period - state->duty_cycle);
> > +	do_div(div, NSEC_PER_SEC);
>=20
> Here the rounding is wrong. (See above example, currently you use low =3D
> 5333 here)
>=20
> > +	if (div > KMB_PWM_COUNT_MAX)
> > +		return -ERANGE;
> > +
> > +	pwm_l_count =3D (u16)div;
> > +
> > +	pwm_count |=3D pwm_h_count << 16;
> > +	pwm_count |=3D pwm_l_count;
>=20
> pwm_count =3D FIELD_PREP(KMB_PWM_HIGH_MASK, pwm_h_count) |
> FIELD_PREP(KMB_PWM_LOW_MASK, pwm_l_count);
>=20
> > +
> > +	keembay_pwm_update_bits(priv, KMB_PWM_COUNT_MASK,
> > +				pwm_count,
> KMB_PWM_HIGHLOW0_OFFSET, pwm->hwpwm);
>=20
> here the rwm-procedure is not necessary as all 32 bits are written anyhow=
.
>=20
> > +	if (state->enabled && !current_state.enabled)
> > +		keembay_pwm_enable(priv, pwm->hwpwm);
> > +
> > +	return 0;
> > +}
> > [...]
> > +MODULE_ALIAS("platform:keembay");
>=20
> This has to match your driver's name, so use:
>=20
> 	MODULE_ALIAS("platform:pwm-keembay");
>=20
> > +MODULE_DESCRIPTION("Intel Keem Bay PWM driver");
> MODULE_LICENSE("GPL
> > +v2");
>=20
> In v1 you told that on reconfiguration the hardware completes the current=
ly
> running period. Please document this in the driver, similar to e.g. pwm-
> sifive.c.
>=20

OK, I will refer to that example and add this information in.

> You only ever write the enable bit in the leadin register. If there is so=
mething
> !=3D 0 at boot this influences the correct behaviour of the driver, right=
?
>=20

That's right, I will add a check during probe to ensure the bit is set to 0=
 as default.

> Further things to note there:
>=20
>  - What is the behaviour on disable (usual candidates: freezes at
>    current value, completes period and emits low, changes to High-Z)?
>=20

For this case, the period does not get completed.
As soon as the channel is disabled, the output goes low.

>  - Can it do 0% and 100% duty ratio?
>=20

Yes, we can set duty cycles of 0% and 100%.

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
