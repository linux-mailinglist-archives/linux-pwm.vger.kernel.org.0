Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2410F8A0
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2019 08:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfLCHXV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Dec 2019 02:23:21 -0500
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:8374
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727386AbfLCHXV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 3 Dec 2019 02:23:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViPjZwaAIDVT3rJFwaZFTa7lnZH8TS4mlAo5dzL5pKrejOEcWNqX5TtFcq6gLfQX5FbX7TzLIbvqFUVdnnSDmCkebiTNyKMCtFNu+iBWRgtLUoGYs6v+U3Dg//zy5XDutnKFI09o/lbc9aQ9+dCAQzziyoDfjrMYJTDTRMbKLi/8vxYgb8vEBsAMNqlgow2ogHmnZmv4pcCCIgOGYd2SKroFHDK7bYEsWe3Osc3ob36MCnVpVYgS3oOAWA7I2Fd1CRTykxhik+CpiWqKGNEPa3oTCWkkrqdPwP7HdjSlYfFe2HnOTN6L9p9/VXqZGNINig7CSh0f3XaLsuhW6Mkb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yqK/ChGBANYHCdqkyHRY0LchaIcKZSaMsQkSCcgdl0=;
 b=L7OCqp1gyfL2q4Nzi8ZimEvYcW3IXTP82zH3a3lHq1O4JnKo1hfs/8mGhCKgxXisppbBo5luy5vl732lfsIbArUCu6C+bJwHBiy9IyA5np4qEIa6zAvfbtaM/GT5y2OpG94qm0ROBcaXmDZe9lcLevYFnoab6t4c/8Ukb7HzmSRJJEO39+YLSjzv6sGGWzG3KXwXsllh4/PAMiF+wkDVutHGEiGGKVQX5p9DFGrSOPAPHHFCQcyBjW7YR/l/3iu0FuE66srtaeCU2DEoeHlxy3DRk+twaH88xCHrzENv3bmJfz4vHk68k8azESPGKgzCJfsFhosMKSR55YJBWB7URg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yqK/ChGBANYHCdqkyHRY0LchaIcKZSaMsQkSCcgdl0=;
 b=fslFbCt60JUpdghjfgliuYeWSgOkJAhF14P3xhnNPXsXihBj8hx0C34p7kD0wcbPLYnlEjzsmzZIWB3pYJRnR4ZmeoC0FlaKvcM/xfifsctHebkX+1HJqO7CFWF8aMeGYWBMORniAO3CjGGzdZZQDPX/+8IZAW92yEaWiw5hhD0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4484.eurprd04.prod.outlook.com (52.135.146.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 07:23:14 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 07:23:14 +0000
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
Thread-Index: AQHVqZ+EtDMj9Zrebkmeuofu5PHegaen+raAgAAAUUCAAASiAIAAAMag
Date:   Tue, 3 Dec 2019 07:23:14 +0000
Message-ID: <AM0PR04MB4481DE4769CA2504B3EDD4C588420@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
 <1575352925-17271-2-git-send-email-peng.fan@nxp.com>
 <20191203065751.w23dypag4745qv7i@pengutronix.de>
 <AM0PR04MB4481AD45530915B0BA18C45F88420@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20191203071534.zqxlizjkav4ul2n5@pengutronix.de>
In-Reply-To: <20191203071534.zqxlizjkav4ul2n5@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a173bfc-c52e-414c-0ea0-08d777c1a933
x-ms-traffictypediagnostic: AM0PR04MB4484:|AM0PR04MB4484:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB44844A92FB8753BE81C1DB0B88420@AM0PR04MB4484.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(199004)(189003)(52536014)(5660300002)(3846002)(6116002)(2906002)(33656002)(71200400001)(71190400001)(6506007)(66066001)(44832011)(446003)(256004)(26005)(186003)(76176011)(102836004)(11346002)(86362001)(7696005)(8676002)(7736002)(6436002)(316002)(81166006)(81156014)(229853002)(14454004)(45080400002)(74316002)(4326008)(25786009)(55016002)(6246003)(6306002)(9686003)(305945005)(6916009)(966005)(8936002)(7416002)(99286004)(64756008)(66556008)(66476007)(478600001)(66446008)(66946007)(76116006)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4484;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pqv+sEtbTU1J+Qh1tun7JI4kquWKEMbJrUQ+2WpNdUqKIby9zqT/A0Vl7XMomcr5bbL/yxIBXWMKjOZvjyg6HpXiI/u1koZdxKQtW/z92zFQHyp5ryf61JsSQ4mhcDRbXQoGAWO72DQkKy+n1c31lOvYdTnOtx4G4wQKe6wfjVB7VWT9mHt6mDakW9qq4CpOvGrQ0XW5iGgjFTe8+tdkG0psbTraBX0zRXzB7xZUt4A59lVIzK8QqcAEjC68ItOT9xCwRGCa7Yqs8NgUs3xeR3RmjN0P4aZFApVmmpKKTVzyL2depj9Y6DWJn5sVybnfV+ci4W0Q+Eoz6zwOMa+nuwaxlf/dcXjgODEa6UIfthnSyI7rahIwhW1cpZCGwqTsCesB0zeNuieMVGcFW/hoQuH9p+KUr3sMY98JTOOTLRo/HogsIPPE123Yn9/dsAHD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a173bfc-c52e-414c-0ea0-08d777c1a933
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 07:23:14.5954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K72xUrqMzK9eOfeojJOcY634+vsKZhGpEj86CKnGJ1iUU5uEJVoBbEKb4DxE+4sPKNWCYOQfAN9x6ioECT/X8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4484
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> Subject: Re: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
>=20
> On Tue, Dec 03, 2019 at 07:00:40AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
> > >
> > > On Tue, Dec 03, 2019 at 06:04:27AM +0000, Peng Fan wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Use platform_irq_count to replace of_irq_count
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >
> > > > V1:
> > > >  Code inspection, not tested
> > > >
> > > >  drivers/gpio/gpio-bcm-kona.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpio/gpio-bcm-kona.c
> > > > b/drivers/gpio/gpio-bcm-kona.c index 4122683eb1f9..c50721980a7c
> > > 100644
> > > > --- a/drivers/gpio/gpio-bcm-kona.c
> > > > +++ b/drivers/gpio/gpio-bcm-kona.c
> > > > @@ -19,7 +19,6 @@
> > > >  #include <linux/io.h>
> > > >  #include <linux/gpio/driver.h>
> > > >  #include <linux/of_device.h>
> > > > -#include <linux/of_irq.h>
> > > >  #include <linux/init.h>
> > > >  #include <linux/irqdomain.h>
> > > >  #include <linux/irqchip/chained_irq.h> @@ -586,7 +585,7 @@ static
> > > > int bcm_kona_gpio_probe(struct platform_device *pdev)
> > > >
> > > >  	kona_gpio->gpio_chip =3D template_chip;
> > > >  	chip =3D &kona_gpio->gpio_chip;
> > > > -	kona_gpio->num_bank =3D of_irq_count(dev->of_node);
> > > > +	kona_gpio->num_bank =3D platform_irq_count(pdev);
> > >
> > > of_irq_count returns 0 or a positive int while platform_irq_count
> > > might return a negative error code. This needs handling. Also I
> > > wonder why
> > > platform_irq_count() is better than of_irq_count() which would be
> > > good to describe in the commit log.
> >
> > Inspired from
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkm=
l
> > .org%2Flkml%2F2015%2F11%2F18%2F466&amp;data=3D02%7C01%7Cpeng.f
> an%40nxp.c
> >
> om%7C46364bf12479463df7d308d777c09b39%7C686ea1d3bc2b4c6fa92cd9
> 9c5c3016
> >
> 35%7C0%7C0%7C637109541440912984&amp;sdata=3DawTvwwmo4692Hx7IJ
> H%2BllEVJH7
> > ngINufoMH8UsosU%2BA%3D&amp;reserved=3D0
> > From Rob:
> > "
> > So I started looking at why you are using of_irq_count which drivers
> > shouldn't need to. In patch 5 you use it to allocate memory to store
> > the irq names, then use them here...
> > "
> >
> > Is this ok?
>=20
> I would say something like:
>=20
> 	platform_irq_count() is the more generic way (independent of
> 	device trees) to determine the count of available interrupts. So
> 	use this instead.
>=20
> 	As platform_irq_count() might return an error code (which
> 	of_irq_count doesn't) some additional handling is necessary.

Thanks, how about this change?
@@ -586,11 +585,15 @@ static int bcm_kona_gpio_probe(struct platform_device=
 *pdev)

        kona_gpio->gpio_chip =3D template_chip;
        chip =3D &kona_gpio->gpio_chip;
-       kona_gpio->num_bank =3D of_irq_count(dev->of_node);
-       if (kona_gpio->num_bank =3D=3D 0) {
+       ret =3D platform_irq_count(pdev);
+       if (!ret) {
                dev_err(dev, "Couldn't determine # GPIO banks\n");
                return -ENOENT;
+       } else if (ret < 0) {
+               return ret;
        }
+       kona_gpio->num_bank =3D ret;
+
        if (kona_gpio->num_bank > GPIO_MAX_BANK_NUM) {

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
> pengutronix.de%2F&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C46364
> bf12479463df7d308d777c09b39%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C637109541440922981&amp;sdata=3D8zAFDgy56%2BjS4I4dUvB6
> y37AMHBu1PDdzESa6c2jUlc%3D&amp;reserved=3D0 |
