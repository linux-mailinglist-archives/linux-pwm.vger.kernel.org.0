Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99370112583
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2019 09:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbfLDIl6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Dec 2019 03:41:58 -0500
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:50782
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbfLDIl6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 4 Dec 2019 03:41:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtN2sWIKHsMfYDSbwbyUepPsFE3oJBFS3S+9o5dcavfam18wBhyPVD32WGf8GxTv6IL3JSdvBfxA8ijZjXhsAcHcovQ3a+4ByvoGy+B5B4DWLBnN1Ad9PoDgVqJty+GEVjkfhLkAap1Z6uHhtm+oBtYo0Am3SoGpyO+tE4uc6AJk+xqtKa8vpXOl0LOAxdhADv7gKcdhNxTc4MVddISCURFs9DITivH6wTRa2CAmwlOXTXqO+khC0UGhTr07gx8hL+jxp3sM0rU1y50aqQWOdCo1XZwJBpRuCUdDw9fmux4CljzPFLj/PKoED2pS8YJtHHUEYrM/fdAiDnHeJsSL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzjyAQGgMCQAlNPMtBUU4sEHPx2N2Ry3NU9SWnVZl7I=;
 b=ZjH83s+15NVN0E/UPFMLDQzY+eS9XzW+AA4CJ00U300EK5qXwL/2bFbJkbmEU/iFL+LKfLfBucpSPsoJc2cYFhYJ4FjdHUZu5TUNZ0m5scTTUK9y/i19fwkEvpX5OrYmOVZYBH3DbG0fVIpW7PWSrxRnVZiqwwtYTo0qqIOuqSV5R9WFhMGY5nElVm8LjxEJynHTi0QhWPzycMTf9hP1mK470r03KUyHiCXYU1atx0P58fTZjlQIw+nz2ElE5VOAFkKDyT72EBOiJCPZMC44sdDaeHvI8yQ8MQ80O0NfDbT2tnRM7a+3+ZYWI9DMYEhkJdemGruLa3ke9FUY+DPUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzjyAQGgMCQAlNPMtBUU4sEHPx2N2Ry3NU9SWnVZl7I=;
 b=ULT1OgofHRJQdgBBPAPO4DNzuzXZg1T+qmDSBwf3pYlBboliuVe0+SMhhTBDzOSZzBZ72fiTclAKva2R5IXoGmG4B+ZfEeor13frVM2hQYS5UOpsrwoxySl1lZ3WRONkPuTwqTFR07jxjBgg1EzlnXF9wBsMJOZWZKwMqYTisyE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5795.eurprd04.prod.outlook.com (20.178.118.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 4 Dec 2019 08:41:14 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 08:41:14 +0000
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
Subject: RE: [PATCH v2 2/2] gpio: bcm-kona: use platform_irq_count
Thread-Topic: [PATCH v2 2/2] gpio: bcm-kona: use platform_irq_count
Thread-Index: AQHVqlozVqivwz8NTU6lWRKFCpUzKKepk+4AgAAUS0A=
Date:   Wed, 4 Dec 2019 08:41:14 +0000
Message-ID: <AM0PR04MB4481D76A9779C2DA7B1331C3885D0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
 <1575433106-16171-2-git-send-email-peng.fan@nxp.com>
 <20191204072744.b7ytzi5gffjcq6sj@pengutronix.de>
In-Reply-To: <20191204072744.b7ytzi5gffjcq6sj@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c874850-7a51-4a23-0312-08d77895b902
x-ms-traffictypediagnostic: AM0PR04MB5795:|AM0PR04MB5795:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5795C57F6899852ED5923909885D0@AM0PR04MB5795.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:252;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(189003)(33656002)(6916009)(5660300002)(7736002)(71190400001)(6436002)(81156014)(102836004)(8936002)(2906002)(64756008)(66556008)(316002)(45080400002)(66476007)(66446008)(6116002)(3846002)(966005)(25786009)(14454004)(99286004)(478600001)(229853002)(186003)(305945005)(74316002)(66574012)(52536014)(8676002)(55016002)(11346002)(9686003)(256004)(7416002)(54906003)(81166006)(76116006)(4326008)(76176011)(6306002)(6506007)(44832011)(26005)(14444005)(446003)(7696005)(86362001)(71200400001)(6246003)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5795;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dQhs+9FsIpiKOXx5+0G6EdqAuauJ//4eOYBCgDE6vBbM5cRvyCGP/wOENBxoQ4YqV9bBwTEXvmhUoEnBRMOeltbALgHODfyqBRmm0yjVyZHnuipKkDEaLoA+2dpRbyOeWRgj7AzCoXxBUTa25SgkEXn8j4IS+1yDDt6nKeSPs4+jb6Knk/IsWeXakx3Rf/bouTXz0qO+q7sxXKGDfXN3CVbvGCmGfIDb2EBvPKZVnDUphos1N4XZjahSYDDo0MaguyXXLUM3eCg5jVc1DHChKU/Jf2ctc/pcX3Eau4Bu6DSa9vTLZqyZwOhb6SrvqFJv7dqmUmDODk7BJVcpGlhVda/eNAroQvkgU8TCprCvWPm/9IrR9Sn+94x9hn7r8LldKnvNJTJMvmNgM5XaK/PBkd5HL1/7Qxl2iGEthEvv+vVHDdnAYJ8lhOI80G92px8Y
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c874850-7a51-4a23-0312-08d77895b902
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 08:41:14.3882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1nwL7tQpyi55R/4TSHce6bIQs/FI24wPQ3CUt3JLHw9ke5cZR72QUBfkE1WKOx/adfjbkD8RQCbuZHSEVSiaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5795
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> Subject: Re: [PATCH v2 2/2] gpio: bcm-kona: use platform_irq_count
>=20
> On Wed, Dec 04, 2019 at 04:20:45AM +0000, Peng Fan wrote:
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
> > V2:
> >  Update commit log, and add err handling  Not tested, just code
> > inspection
> >
> >  drivers/gpio/gpio-bcm-kona.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-bcm-kona.c
> > b/drivers/gpio/gpio-bcm-kona.c index 4122683eb1f9..52ff56166263
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
> > +			dev_err(dev, "Couldn't determine GPIO banks: %d\n",
> > +				ret);
>=20
> You can use the new %pe feature here:

Checkpatch reports warning:

WARNING: Invalid vsprintf pointer extension '%pe'
#49: FILE: drivers/gpio/gpio-bcm-kona.c:593:
+               if (ret !=3D -EPROBE_DEFER)
+                       dev_err(dev, "Couldn't determine GPIO banks: (%pe)\=
n",
+                               ERR_PTR(ret));

Thanks,
Peng.

>=20
> 	dev_err(dev, "Couldn't determine GPIO banks: %pe\n",
> 		ERR_PTR(ret));
>=20
> > +		return ret;
> >  	}
> > +	kona_gpio->num_bank =3D ret;
> > +
>=20
> Looks otherwise ok.
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C8c566
> 59ba01b4b5db43608d7788b77fa%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C637110412715339679&amp;sdata=3DMDjn8C9mtDqZCN01nOT
> KhVJoLiqPue8In5v5OT91B6Y%3D&amp;reserved=3D0 |
