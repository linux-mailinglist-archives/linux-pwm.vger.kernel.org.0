Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A35A210F908
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2019 08:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfLCHkz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Dec 2019 02:40:55 -0500
Received: from mail-eopbgr00075.outbound.protection.outlook.com ([40.107.0.75]:43239
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727386AbfLCHky (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 3 Dec 2019 02:40:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fi7w8tvQeWSu95PkeBcg3ym7qNZGi8/s5izdgn4lssYnEPQt1gFC35eRyHlmPyUwyWiaZes1KsecWZffz1jR8YMbj4xtjfAcShy74uQ9ERy4vlvY9L0t3Yetryr3xNb0+NJ7ES+S19Av6OauEz4LMpw6C67aXXFDkDqa5YowqOjQsNCHmWiQ+QRmIIJ3vbDhXNNld986tuFjNnOjti8lraf6Y0rC0ozUfFll91JhuOTiKTJDKSOAkhq+actXupKWC8xVSt5uZZDtRBMxSr7MwvMhcPAVvKi6Z9GyTn20Z7isE9c7WFqs0I6/FVL2zFGiTSGNwJVxIDvu1Z+Nno0cKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV5qmVivb0xVFoOKCjQDw3GPGyWk029g2HjSrlzBFso=;
 b=SACRN5ZuqqTtQ2OzvVz178XKLJ84pXMCPMiEOa2uXt5RigGcLyHxElH5F+9SMGupeF2AdcyYZ9yYEyEmMVNnhePV6ZTXnbXs9EugX1IKmnmZJd0wKbJHOA2QJW0yjvETdcMh4z7/1wcBF9FdjkMxWrXCPkOgcFoEu9qfOLHlWalYjcmgVSB1I+VlfXmIuvoFN+POSjSN9xcRXLNR22z/3S4t2BxxZGN1ybNRPcVLoXc9Sm6qnNeR6pbaORR+rRbZMX5ABAjFXQAMfJLS7g6rsuXgElN1BrP6OjYumY7M0RozTT0An+7KM+1xXONcdlohEt5XDDsA47t3Oym4QjhG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV5qmVivb0xVFoOKCjQDw3GPGyWk029g2HjSrlzBFso=;
 b=jnaZ4VI/vzLrDJuXSCWNlj7jZM2tbicjDKU7BXALXQgOD6I9iV6eHN0QQ874anPeLE5PdxUOQsyOHiAaT19m8DIkS0gmbdNS17hH91uKCXTCY90tIQSMRzaWocscEOcXvJgv4l1gf7D54cSdKJ8JgsvzavORfQ8dztk2M8Ferh8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6514.eurprd04.prod.outlook.com (20.179.254.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Tue, 3 Dec 2019 07:40:49 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 07:40:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "rjui@broadcom.com" <rjui@broadcom.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
Thread-Topic: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
Thread-Index: AQHVqZ+EtDMj9Zrebkmeuofu5PHegaen+raAgAAAUUCAAASiAIAAAMaggAAFr4CAAABPsA==
Date:   Tue, 3 Dec 2019 07:40:49 +0000
Message-ID: <AM0PR04MB448149801572B13676845FF088420@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
 <1575352925-17271-2-git-send-email-peng.fan@nxp.com>
 <20191203065751.w23dypag4745qv7i@pengutronix.de>
 <AM0PR04MB4481AD45530915B0BA18C45F88420@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20191203071534.zqxlizjkav4ul2n5@pengutronix.de>
 <AM0PR04MB4481DE4769CA2504B3EDD4C588420@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20191203073841.6j5viopvzpuckmzo@pengutronix.de>
In-Reply-To: <20191203073841.6j5viopvzpuckmzo@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60858f0f-8fb0-4ab1-7eb6-08d777c41dfe
x-ms-traffictypediagnostic: AM0PR04MB6514:|AM0PR04MB6514:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6514FB0B0E1002BA093F0D8A88420@AM0PR04MB6514.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(76176011)(4326008)(446003)(55016002)(7416002)(6246003)(14444005)(66574012)(256004)(6506007)(966005)(6916009)(71200400001)(99286004)(229853002)(8676002)(9686003)(8936002)(186003)(14454004)(6116002)(3846002)(66946007)(66446008)(2906002)(64756008)(66556008)(44832011)(76116006)(26005)(52536014)(66066001)(7736002)(66476007)(305945005)(5660300002)(102836004)(74316002)(81166006)(54906003)(33656002)(6306002)(7696005)(11346002)(86362001)(6436002)(71190400001)(81156014)(316002)(25786009)(45080400002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6514;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K0HJ6v05CvTpqBJhLLiO460ObDPG0ww2sh9nYQmfbSorCjdIsTAsvEKQqgaIxMmnm+K4X07kdLg8Kx8ChUz80sbQbmx+8hBIVdskSACd5nZ0R20MZIWhpC5k7tbh5InapHsVoelSOoehqDrgkBagRyPA76UU5FQowj7NbqGssIvz9u8Uk1WJMiVkhol4WX0NKNvyUxUfBLXYaJ1r34O3OM/OZ9JbgOL1s8xg7Ln8rf1jKZwIeFAovVsdbLYEM4XfDd5OraorfB+YKSDzmqFyPdHYhb+QLWq5QTaOvL2EVvQGEq0bWlzRnGGQlcxP3UzpatHn5ceE8eQB7hZhhBS8d4LJ0azfClntw4q1ps+ulFmAwvDn/M7boJdDX6llm+qeQTSS/+SSAWBulPNHiUuGtrxZIvmpMuKsfXnYVCgeX9rDqM+sYh75X1CHqMmCoLxE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60858f0f-8fb0-4ab1-7eb6-08d777c41dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 07:40:49.5568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ub96F9ktvyToDSJK8Z7EOLmQVBj6iSKM6xiB0XaDp6/ij+F5VLncQBOstqYQLVEnS6km/A8oiQ12y7mWFaYCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6514
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> Subject: Re: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
>=20
> On Tue, Dec 03, 2019 at 07:23:14AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
> > >
> > > On Tue, Dec 03, 2019 at 07:00:40AM +0000, Peng Fan wrote:
> > > > > Subject: Re: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
> > > > >
> > > > > On Tue, Dec 03, 2019 at 06:04:27AM +0000, Peng Fan wrote:
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > Use platform_irq_count to replace of_irq_count
> > > > > >
> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > ---
> > > > > >
> > > > > > V1:
> > > > > >  Code inspection, not tested
> > > > > >
> > > > > >  drivers/gpio/gpio-bcm-kona.c | 3 +--
> > > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpio/gpio-bcm-kona.c
> > > > > > b/drivers/gpio/gpio-bcm-kona.c index
> > > > > > 4122683eb1f9..c50721980a7c
> > > > > 100644
> > > > > > --- a/drivers/gpio/gpio-bcm-kona.c
> > > > > > +++ b/drivers/gpio/gpio-bcm-kona.c
> > > > > > @@ -19,7 +19,6 @@
> > > > > >  #include <linux/io.h>
> > > > > >  #include <linux/gpio/driver.h>  #include <linux/of_device.h>
> > > > > > -#include <linux/of_irq.h>  #include <linux/init.h>  #include
> > > > > > <linux/irqdomain.h>  #include <linux/irqchip/chained_irq.h> @@
> > > > > > -586,7 +585,7 @@ static int bcm_kona_gpio_probe(struct
> > > > > > platform_device *pdev)
> > > > > >
> > > > > >  	kona_gpio->gpio_chip =3D template_chip;
> > > > > >  	chip =3D &kona_gpio->gpio_chip;
> > > > > > -	kona_gpio->num_bank =3D of_irq_count(dev->of_node);
> > > > > > +	kona_gpio->num_bank =3D platform_irq_count(pdev);
> > > > >
> > > > > of_irq_count returns 0 or a positive int while
> > > > > platform_irq_count might return a negative error code. This
> > > > > needs handling. Also I wonder why
> > > > > platform_irq_count() is better than of_irq_count() which would
> > > > > be good to describe in the commit log.
> > > >
> > > > Inspired from
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > >
> lkml .org%2Flkml%2F2015%2F11%2F18%2F466&amp;data=3D02%7C01%7Cpen
> g.f
> > > an%40nxp.c
> > > >
> > >
> om%7C46364bf12479463df7d308d777c09b39%7C686ea1d3bc2b4c6fa92cd9
> > > 9c5c3016
> > > >
> > >
> 35%7C0%7C0%7C637109541440912984&amp;sdata=3DawTvwwmo4692Hx7IJ
> > > H%2BllEVJH7
> > > > ngINufoMH8UsosU%2BA%3D&amp;reserved=3D0
> > > > From Rob:
> > > > "
> > > > So I started looking at why you are using of_irq_count which
> > > > drivers shouldn't need to. In patch 5 you use it to allocate
> > > > memory to store the irq names, then use them here...
> > > > "
> > > >
> > > > Is this ok?
> > >
> > > I would say something like:
> > >
> > > 	platform_irq_count() is the more generic way (independent of
> > > 	device trees) to determine the count of available interrupts. So
> > > 	use this instead.
> > >
> > > 	As platform_irq_count() might return an error code (which
> > > 	of_irq_count doesn't) some additional handling is necessary.
> >
> > Thanks, how about this change?
> > @@ -586,11 +585,15 @@ static int bcm_kona_gpio_probe(struct
> > platform_device *pdev)
> >
> >         kona_gpio->gpio_chip =3D template_chip;
> >         chip =3D &kona_gpio->gpio_chip;
> > -       kona_gpio->num_bank =3D of_irq_count(dev->of_node);
> > -       if (kona_gpio->num_bank =3D=3D 0) {
> > +       ret =3D platform_irq_count(pdev);
> > +       if (!ret) {
> >                 dev_err(dev, "Couldn't determine # GPIO banks\n");
> >                 return -ENOENT;
> > +       } else if (ret < 0) {
> > +               return ret;
>=20
> This is inconsitent. In the ret=3D=3D0 case you emit an error message, in=
 the ret <
> 0 case you don't. I think the sensible approach would be to
> do:
>=20
> 	if (ret =3D=3D 0) {
!ret should be fine, I think checkpatch might trigger warning using ret =3D=
=3D 0.
> 		dev_err(dev, "Couldn't determine # GPIO banks\n");
> 		return -ENOENT;
> 	} else if (ret < 0) {
> 		if (ret !=3D -EPROBE_DEFER)
> 			dev_err(dev, "Failed to determine count of GPIO banks
> (%pe)\n", ERR_PTR(ret));
> 		return ret;
> 	}

ok, will use this for v2.

Thanks,
Peng.

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7Cab060
> 7335df3485a98e908d777c3d594%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C637109555298587766&amp;sdata=3D9NTBkwRTIuFBF9y97jqyr
> b4Vym8FpvOTZYBrqJqEERk%3D&amp;reserved=3D0 |
