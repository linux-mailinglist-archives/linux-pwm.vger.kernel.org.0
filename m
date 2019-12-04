Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A0C11290C
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2019 11:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfLDKMp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Dec 2019 05:12:45 -0500
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:54535
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727136AbfLDKMp (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 4 Dec 2019 05:12:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehqWJCk2dHlYvVLIWVQeifBkbafBDij79VsRp9e0YaZoHEBFsP259Wv3w+VgurCgi4ctL4uAXrfAXViAFv2Jm4sNGnqxPXuQ3wZZrLmV9TXlzcGO679H1ytF3J8DQqwAH9a/aafQq7042yQ3fjP8u/CbBIxjNT0b0zPF7HfPoAtNafenKlww0E2KVPrAucTrnO+bxrH8UHycuBVHJ3IQ0xrqRF0LRPAfdUdhcYIS/gGdfWnwmgI4kHZwYfSGAFymWtRo0DzOHNjNefo3QVXFFcpB1NNmD0sI33O0AvxaZQlUBSho/gepd1MVqYTxMypRJZkwp0QZ6e8vGvPEi8THaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSdjGvRbKcnEzwclY2plo2CqFjpQ+aQq/QA9bOEcPqE=;
 b=BmMYbG0mj59h3/XD0WPgROcQWGZ0lIKaYBmj9UKDpd96lDF7ielIlYaOa5upMsFrGBpUB07XikgF/ySJ7AbjG0931kJYHGRK0CNV2GuAaLcWRhJeKWQI+SGaP5D9M1SdluTgKLnYOtPMCkcF/ks2kpjfIM5iUZIsdTBmkpeteMC//0voyDcj6K6m/h0+HeyWzJeEspv0aAplpjHwKRxFw4+ykWWpkdtGKzIpfQ7z+XAdRNqXc/L+8PogKKATAOKKuqyN/87u+HNrgbYKF95MZQksCs2l9AUR0fVYprgBt+VskiWjG/YOUGxdAZTr2HjERkyZj5/sI42TCr2gwdMlzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSdjGvRbKcnEzwclY2plo2CqFjpQ+aQq/QA9bOEcPqE=;
 b=NIJKPQQUAo0qdsrFOrNLwqM3VwVufjCVQ9aVLUyQfpZiAmY0SqlmunnQ/W22IvlVN0uMiZtlVNVHSVpDtoEcOq9hOZvqFfTSS5HZkS5qOx0quzrkXFufiL4hqvy6jst/9V4GBCWhva6gMtC/kz89vDoDMiF8KfdxgzIkUH/BoIM=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5921.eurprd04.prod.outlook.com (20.178.117.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Wed, 4 Dec 2019 10:12:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 10:12:41 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] gpio: bcm-kona: use platform_irq_count
Thread-Topic: [PATCH v3 2/2] gpio: bcm-kona: use platform_irq_count
Thread-Index: AQHVqoSnVgd0oV+avUOUZsuBa7eNT6epwMaAgAAAfjA=
Date:   Wed, 4 Dec 2019 10:12:40 +0000
Message-ID: <AM0PR04MB4481A472580A80B5244CB9C2885D0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1575451330-11112-1-git-send-email-peng.fan@nxp.com>
 <1575451330-11112-2-git-send-email-peng.fan@nxp.com>
 <20191204100925.sjp6cztozlm5qm6y@pengutronix.de>
In-Reply-To: <20191204100925.sjp6cztozlm5qm6y@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b52fbaed-8deb-44bd-761e-08d778a27f68
x-ms-traffictypediagnostic: AM0PR04MB5921:|AM0PR04MB5921:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB59211269BF2B28660EA8BCA4885D0@AM0PR04MB5921.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(189003)(199004)(6116002)(66574012)(11346002)(7416002)(81156014)(81166006)(2906002)(33656002)(8936002)(6916009)(102836004)(478600001)(54906003)(5660300002)(66446008)(64756008)(45080400002)(66946007)(14454004)(52536014)(66556008)(316002)(966005)(66476007)(76116006)(71200400001)(14444005)(25786009)(26005)(8676002)(186003)(71190400001)(7736002)(74316002)(6246003)(9686003)(44832011)(99286004)(305945005)(76176011)(6506007)(6306002)(4326008)(55016002)(86362001)(7696005)(3846002)(229853002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5921;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EvMbP6JFjdoJ+J27RCuOxvtBb8Dtr/VPXC0lCrZDpFj7jFcjRV7jMUA6e4bSgnmTBFZ9rsP+zwpyGGbxgYRJr82wD9hggMOzEH1y0kFCPfruBawl8y6ghxe3M3xwzQEqLHLJev5fh0kw1SxFJfUgEiyBR6lfU4UDRTLIzCKcPWp41E68q1SHsqXPnhE+iVZ0gYBh/aRKJ3K7o5QAi53EGRCfYzhdyEfUm1wVu0YX7sfznEgOEW0uZAwFB3v0DpOdljYHdNYfvmziQN2OT9y/Veii9FTmrGI9rAlrTCbfadae/msQL6Op+2PWGAbd+bEA7nBxHC4X5QsvbD/gz9SNPIIIH/22u5MvYesI6Af0FE8cnSkhTZ/VYexvXlrrlgXio+4rcbK+BcTTBptn5k1pkgaF8HL6UNLPa9lBkQ1GZRUA0wOWmf3MgxKdwi+5oeve
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52fbaed-8deb-44bd-761e-08d778a27f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 10:12:41.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NM4BSkhEfVcqg2KkWXyYVlcuR0nocmM99VRIYVfV3dzi1B5u80DCCt6+JKILrGx7pjIkTN5vxdNWgC0cI7ekNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5921
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> Subject: Re: [PATCH v3 2/2] gpio: bcm-kona: use platform_irq_count
>=20
> On Wed, Dec 04, 2019 at 09:24:39AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > platform_irq_count() is the more generic way (independent of device
> > trees) to determine the count of available interrupts. So use this
> > instead.
> >
> > As platform_irq_count() might return an error code (which of_irq_count
> > doesn't) some additional handling is necessary.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V3:
> >  Use %pe
>=20
> Great. Note that with %pe there is a dependency on commit 57f5677e535b
> ("printf: add support for printing symbolic error names") which was appli=
ed
> during the current merge window.
>=20
> > V2:
> >  Update commit log, and add err handling  Not tested, just code
> > inspection
> >
> >
> >  drivers/gpio/gpio-bcm-kona.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-bcm-kona.c
> > b/drivers/gpio/gpio-bcm-kona.c index 4122683eb1f9..baee8c3f06ad
> 100644
> > --- a/drivers/gpio/gpio-bcm-kona.c
> > +++ b/drivers/gpio/gpio-bcm-kona.c
> > @@ -19,7 +19,6 @@
> >  #include <linux/io.h>
> >  #include <linux/gpio/driver.h>
> >  #include <linux/of_device.h>
> > -#include <linux/of_irq.h>
> >  #include <linux/init.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/irqchip/chained_irq.h> @@ -586,11 +585,18 @@ static
> > int bcm_kona_gpio_probe(struct platform_device *pdev)
> >
> >  	kona_gpio->gpio_chip =3D template_chip;
> >  	chip =3D &kona_gpio->gpio_chip;
> > -	kona_gpio->num_bank =3D of_irq_count(dev->of_node);
> > -	if (kona_gpio->num_bank =3D=3D 0) {
> > +	ret =3D platform_irq_count(pdev);
> > +	if (!ret) {
> >  		dev_err(dev, "Couldn't determine # GPIO banks\n");
> >  		return -ENOENT;
> > +	} else if (ret < 0) {
> > +		if (ret !=3D -EPROBE_DEFER)
> > +			dev_err(dev, "Couldn't determine GPIO banks: (%pe)\n",
> > +				ERR_PTR(ret));
>=20
> I'd say drop either the colon or the parenthesis.

Like this?=20
+	dev_err(dev, "Couldn't determine GPIO banks: %pe\n",

Does it really matter?

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
> pengutronix.de%2F&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C627e1
> 95be7f0467580f908d778a20d60%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C637110509717538199&amp;sdata=3D3FuRYio8G3jtly1hWuGhJGg
> zqaT742y%2B2H6xOwKMvJ8%3D&amp;reserved=3D0 |
