Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77635858CB
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2019 05:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfHHDw5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Aug 2019 23:52:57 -0400
Received: from mail-eopbgr1410115.outbound.protection.outlook.com ([40.107.141.115]:13536
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727950AbfHHDw5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Aug 2019 23:52:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rzgru6EMSFEXJVzbL7q96O0FjnjzMxcHDv3pfVtP/7P2XOhQwpsh6TVSAuakuzmRZ/+x6X8ArioNGfxckxf+VvPHuA+hAGorLagqsgx/13XFf/omLNy4cATHegnDGefywVDVS8/FH2uRgKWjtQ+/rnVt8ofn5pBmLTMxBQisZT03EUaIBIKxylle/1GPqWt0f8O39d5bzQkFreC6jx9y4VMtT5xwumbM0/w8qNgJxoQRrgWRUReM5PVB5D+1jcW2qe+ps1pYLdwBKrq4pYVgh93PFpbmP30dLunumWCCVTsrEpRDMCzb6togfxoBC0MYfZpmczeHYeT8pGYmHvNqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkvtiKcNE67FLIIqS846jH1e/KqBAVbey8Ci8o4sCzc=;
 b=bTv9wDfUUCvW2fCTtowr2nNRF9aOOO3jgVaXvOVFeNuzzwI4ER9glt/erWQ+qin8iYgPPdHtnS4r1uC+9jiNKKrpgzXKJXd5NYvtOOZEZQiHTp4katSbTe5de5JJzFMHJXIwYs2klkgll66xwzPp0AWN1yX7a2H9zqz7OFg+fyYXMwsuGcMNMJtPLMP6dhoLJjS4UC1u+KovkvEoZSite5bVz9Z7nsvomO9x2HmEtIasNy3imupfCWzZGf1swcB7TdLv12kauRYd3HmpPsfg/ZLbKImrx+jbCziI0EnRbwiuNwD3yYlPvHAx0nBrZfI5aWkZTg0De1Z1I5xiGmcqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkvtiKcNE67FLIIqS846jH1e/KqBAVbey8Ci8o4sCzc=;
 b=nXTbulz4AYsifCWocqOoo2xNQ1ZE5gW8gt/KThST09jBJwPO2UgsOscNr/pWp+G9aVmbfPZjBS3szO0AagqHH3kSziy1J641mAFFoqzMSY4LYAWDIRqIcP87aiXI+az9hQI0MK6sSotXqyCBB/GPr6z8B9szX4g38tzygr2fENU=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2879.jpnprd01.prod.outlook.com (20.177.104.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Thu, 8 Aug 2019 03:52:53 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf%5]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 03:52:53 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 6/7] pwm: rcar: Add gpio support to output duty zero
Thread-Topic: [PATCH RFC 6/7] pwm: rcar: Add gpio support to output duty zero
Thread-Index: AQHVNWy7V8gL2ZngqkqByKUc3gWdAabvcZEAgAFBsMA=
Date:   Thu, 8 Aug 2019 03:52:52 +0000
Message-ID: <TYAPR01MB45445D854C1FDBB473A89559D8D70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190807070326.cgkbt4kpzhqvo5a3@pengutronix.de>
In-Reply-To: <20190807070326.cgkbt4kpzhqvo5a3@pengutronix.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd2f6d8e-994c-4d48-f21b-08d71bb3e3c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB2879;
x-ms-traffictypediagnostic: TYAPR01MB2879:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <TYAPR01MB28791AB4CAAB2B64CB77EFF8D8D70@TYAPR01MB2879.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(25786009)(6306002)(7416002)(55016002)(6916009)(81166006)(81156014)(8676002)(486006)(6116002)(2906002)(3846002)(71200400001)(476003)(99286004)(9686003)(8936002)(14454004)(966005)(305945005)(71190400001)(11346002)(7696005)(66066001)(186003)(76176011)(7736002)(102836004)(33656002)(74316002)(6506007)(446003)(229853002)(256004)(14444005)(86362001)(478600001)(26005)(76116006)(6246003)(66556008)(66446008)(64756008)(316002)(5660300002)(6436002)(66574012)(66946007)(52536014)(66476007)(54906003)(4326008)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2879;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XBjt0kkrjY/p1ldkYnlA1jegCPU2xEOcvlAdNHmpLx27fgtNG8ZisQel6tfgyft+lJ5v0HNDuS15CsDUiUM6yfICFwEYWrggVCHfdyCOvWmYeIO873xbstlap8tDWnxojBfPAa6GUhDcc33VpvO7AU6cZHn29vOsQS+W8NQFG48L8vEQg02FoVEz6wgtDUXQFUd8+gIBCtXYU5K6QihbsSLaBv4HwUVIlFkiqsY8e57tAKD+ubt5B4BCvs/5A52pEdyD2uDnTPcoVXC3o5FoJZGEsAHNBe4tmUq6CUBjtGx0iydCrx1C/sz+HQjt9CM+FqFxm7J1oFJBvzAmq+UFzA6+xXkQ61CGEA9xC0sHI1OzbRMDYV+XhsVy+q4gKNYFR23EGZ7H4+tu5rT+poDX/TEwffQCCXEXlBN4T3LJkfs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2f6d8e-994c-4d48-f21b-08d71bb3e3c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 03:52:52.8843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qXph0+jC1dHkJ1bgekXN1KQGqwvEV3Jnfm7oEZ13U/BzF6DflX5qIvx/bl2jO0Ts0KoBxi51RI8545jPD5kNfnlyMr5GJbj44tshmAQmebcGFUo6LKqOwa9ekMCaPGrw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2879
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for your review!

> From: Uwe Kleine-K=F6nig, Sent: Wednesday, August 7, 2019 4:03 PM
>=20
> Hello,
>=20
> On Mon, Jul 08, 2019 at 06:07:47PM +0900, Yoshihiro Shimoda wrote:
> > The R-Car SoCs PWM Timer cannot output duty zero. So, this patch
> > adds gpio support to output it.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pwm/pwm-rcar.c | 36 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 34 insertions(+), 2 deletions(-)
>=20
> I'd like to see a paragraph at the top of the driver describing the
> limitations of this driver similar to what pwm-sifive.c does.
>=20
> Something like:
>=20
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index 5b2b8ecc354c..b67ac84db834 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -3,6 +3,9 @@
>   * R-Car PWM Timer driver
>   *
>   * Copyright (C) 2015 Renesas Electronics Corporation
> + *
> + * Limitations:
> + * - The hardware cannot generate a 0% duty cycle.
>   */

I'll add this.

>  #include <linux/clk.h>
>=20
> While at it: If there is a publicly available reference manual adding a l=
ine:
>=20
> 	Reference Manual: https://...
>=20
> would be great, too.

Unfortunately, the document is not public...

> > diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> > index c8cd43f..1c19a8b 100644
> > --- a/drivers/pwm/pwm-rcar.c
> > +++ b/drivers/pwm/pwm-rcar.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/io.h>
> >  #include <linux/log2.h>
> >  #include <linux/math64.h>
> > @@ -38,6 +39,7 @@ struct rcar_pwm_chip {
> >  	struct pwm_chip chip;
> >  	void __iomem *base;
> >  	struct clk *clk;
> > +	struct gpio_desc *gpio;
> >  };
> >
> >  static inline struct rcar_pwm_chip *to_rcar_pwm_chip(struct pwm_chip *=
chip)
> > @@ -119,8 +121,11 @@ static int rcar_pwm_set_counter(struct rcar_pwm_ch=
ip *rp, int div, int duty_ns,
> >  	ph =3D tmp & RCAR_PWMCNT_PH0_MASK;
> >
> >  	/* Avoid prohibited setting */
> > -	if (cyc =3D=3D 0 || ph =3D=3D 0)
> > +	if (cyc =3D=3D 0)
> >  		return -EINVAL;
> > +	/* Try to use GPIO to output duty zero */
> > +	if (ph =3D=3D 0)
> > +		return -EAGAIN;
>=20
> If there is no gpio requesting cyc=3D0 should still yield an error.

I'm sorry, I cannot understand this.

> >  	rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
> >
> > @@ -157,6 +162,28 @@ static void rcar_pwm_disable(struct rcar_pwm_chip =
*rp)
> >  	rcar_pwm_update(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
> >  }
> >
> > +static int rcar_pwm_gpiod_get(struct rcar_pwm_chip *rp)
> > +{
> > +	if (rp->gpio)
> > +		return 0;
> > +
> > +	rp->gpio =3D gpiod_get(rp->chip.dev, "renesas,duty-zero", GPIOD_OUT_L=
OW);
> > +	if (!IS_ERR(rp->gpio))
> > +		return 0;
> > +
> > +	rp->gpio =3D NULL;
> > +	return -EINVAL;
>=20
> Please use gpiod_get_optional() instead of open coding it.

I got it.

> Does getting the gpio automatically switch the pinmuxing?
>=20
> If yes, this is IMHO a really surprising mis-feature of the gpio
> subsystem. I'd prefer to "get" the gpio at probe time and only switch
> the pinmuxing in .apply(). This makes .apply() quicker, ensures that all
> resources necessary for pwm operation are available, handles
> -EPROBE_DEFER (and maybe other errors) correctly.

The current pinctrl subsystem only has .set_mux(). I checked the pinctrl su=
bsystem
history and the commit 2243a87d90b42eb38bc281957df3e57c712b5e56 removed the=
 ".disable()" ops.
So, IIUC, we cannot such a handling.

> Note you're introducing a bug here because switching to gpio doesn't
> ensure that the currently running period is completed.

Umm, the hardware doesn't have such a condition so that the driver cannot m=
anage it.
So, I'll add this into the "Limitations" too.

> > +static void rcar_pwm_gpiod_put(struct rcar_pwm_chip *rp)
> > +{
> > +	if (!rp->gpio)
> > +		return;
> > +
> > +	gpiod_put(rp->gpio);
> > +	rp->gpio =3D NULL;
> > +}
> > +
> >  static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> >  			  struct pwm_state *state)
> >  {
> > @@ -171,6 +198,7 @@ static int rcar_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> >
> >  	if (!state->enabled) {
> >  		rcar_pwm_disable(rp);
> > +		rcar_pwm_gpiod_put(rp);
>=20
> From the framework's POV disabling a PWM is quite similar to duty cycle
> 0. Assuming disabling the PWM completes the currently running period[1]
> it might be better and easier to disable instead of switching to gpio.
> (Further assuming that disable really yields the inactive level which is
> should and is another limitation if not.)

If we disable the hardware, the duty cycle is 100% unfortunately. So,
I think I should describe it as one of "Limitations".

> >  		return 0;
> >  	}
> >
> > @@ -187,8 +215,12 @@ static int rcar_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> >  	/* The SYNC should be set to 0 even if rcar_pwm_set_counter failed */
> >  	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
> >
> > -	if (!ret)
> > +	if (!ret) {
> >  		ret =3D rcar_pwm_enable(rp);
> > +		rcar_pwm_gpiod_put(rp);
> > +	} else if (ret =3D=3D -EAGAIN) {
> > +		ret =3D rcar_pwm_gpiod_get(rp);
> > +	}
> >
> >  	return ret;
> >  }
>=20
> Best regards
> Uwe
>=20
> [1] if not, please add "Disabling doesn't complete the currently running
>     period" to the list of limitations.

Yeah, the hardware will complete the currently running period, but as I sai=
d,
the hardware doesn't have such a condition, so that the driver's .apply()
returns immediately without the completion. So, I'll add it as a Limitation=
.

Best regards,
Yoshihiro Shimoda

> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
