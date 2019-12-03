Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCF2110F83A
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2019 08:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLCHAr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Dec 2019 02:00:47 -0500
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:28856
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbfLCHAr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 3 Dec 2019 02:00:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcvkCBBb1g7qZyktJ8Nv1Xm9Yz7TtrliFBCt4iLKxXBppz4f/yby0Fvu9abAbz6WijEgtSJQuEpPQqxnN4F7p/TcddS+86+qijriEIEOD4Ky4+o9pNp94mOJpqkoN35kRcOFS4T9XQu0kZXk5KGpvzQ2H2xBP2WI4yMwJlkcDwSOEhL3AtaVA5G5zk1VR6Ql882rTMJqrOLtRk/mog6gHzOBjqhlCpfaoU97DnhoXuEnRCU+A2jW4KyFpqyAjocIIJf8Oz/tQYuPbW5GvEWNEdDrFjqbN8vTCxnQ1i23JSknJeiMlRnswAJZTrcg8u3EER7uY+NHHn8aTKNa3EqcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dynm5BJM9OYThwgdFQEscl39Kv/UUN2PioxBZmpI2w=;
 b=cnGPjBb7BJnZtwznsT0m3LbN27okXks9FjE8oWT6H/G391aTADcdA0zzSCUVj13mjK/OJ1pwNobLLx24wQNnbQNVj5s7EgxbXxNcbDeleIZWMi057/be8hXQFMrob9NpbAdwCQs8A9fcEM63zpkWIJRpX1D3fekBTU56sb3YD2qCSANefYJiEiZZ/oN1UnU/fZpmj8JEl783LqTrpl/zopuX/127a5fuyLk8Ydquy+6ffWaIJYiR/3otTFuoSME64RU8HTCRIP3h1gGKTzd92L/PHDB7wGPNv4GtLkFse1Bwmu7F+/IyOEbug9QsBCnag+POrD/CZIUYr6lIvpkN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dynm5BJM9OYThwgdFQEscl39Kv/UUN2PioxBZmpI2w=;
 b=R3Ab2nd2CKw55RdWW3Ift8es3vci8HSSBlGrxJSCrxmSATzHRMzZVUchCFgeSLQ10ed+YBnbqnEXEqGP56USe/hGVNl2M3+gK0GlgAqheyPgOHARzMyk5r0q+wq2nEnjPNEGYV+iGFImq5V2opUUaWQzdSXFoWCJFPku2bISi/Q=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4737.eurprd04.prod.outlook.com (20.177.41.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 07:00:40 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 07:00:40 +0000
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
Thread-Index: AQHVqZ+EtDMj9Zrebkmeuofu5PHegaen+raAgAAAUUA=
Date:   Tue, 3 Dec 2019 07:00:40 +0000
Message-ID: <AM0PR04MB4481AD45530915B0BA18C45F88420@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
 <1575352925-17271-2-git-send-email-peng.fan@nxp.com>
 <20191203065751.w23dypag4745qv7i@pengutronix.de>
In-Reply-To: <20191203065751.w23dypag4745qv7i@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cbb9ffc-839b-4fd6-72d5-08d777be820c
x-ms-traffictypediagnostic: AM0PR04MB4737:|AM0PR04MB4737:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB473743BF24E1A650B5AD9A6D88420@AM0PR04MB4737.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(189003)(199004)(71200400001)(71190400001)(256004)(45080400002)(4326008)(478600001)(6246003)(6436002)(55016002)(9686003)(6306002)(316002)(7696005)(7736002)(86362001)(33656002)(54906003)(229853002)(7416002)(305945005)(76116006)(74316002)(66946007)(99286004)(966005)(6506007)(66066001)(76176011)(446003)(186003)(8936002)(8676002)(14454004)(3846002)(6116002)(102836004)(64756008)(26005)(66556008)(66476007)(2906002)(81166006)(81156014)(25786009)(6916009)(5660300002)(52536014)(11346002)(66446008)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4737;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7n0jTfGL3BorUVjRPySDTh2lJJqamnpmlf3olCZHUNJU/xUK+VtZt+2r7Qk0EYvxPTVwW8V5SHS40GTTisGG4aLr7tixoEsSO97LkpdgoJuhApIwfPZDtr6cxvvjos/WF/+Su6Pnd1tlYdyWbBT3ht+sY08W8OWgIBu1lAP2ylFYv0ndYz47CXLli1W0t1ey3bddbpjqod8Q1sMcv2izjIBIguHRvUHG61a6PDUZzd2pmUrP++iIPDfP5hApT9QtA2QmzzcYgGh1c+KH+Dn/4QLL8MZkvn31fI2LK7eizlDCal3BqzTe3fCIUeJ3TvIO+wQvHRqKfmSAgmJMBU2lz/Rr73Q85PRCKO6fJF6kR9WOUtDj5BSObBpap18mZg/BqtEm3spdajk4tIao9ZEYvFF1xy82xBX3nnwNrhl33YUOoKiS7U+auol+c1DI2uY1KJJ5rSJqiMJ/uTeOst2PpIVuUyobMdX4a5nSEy8xA08=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbb9ffc-839b-4fd6-72d5-08d777be820c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 07:00:40.3921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U2lJzCO6Lvu5zBXnwy/H9y7C3FTsi3QHmKvW3JBYYF1TK+UO+a2BMXt8G91w9v5pfdY+Ca4FK8Uj3nqD7Bv8pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4737
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> Subject: Re: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
>=20
> On Tue, Dec 03, 2019 at 06:04:27AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Use platform_irq_count to replace of_irq_count
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V1:
> >  Code inspection, not tested
> >
> >  drivers/gpio/gpio-bcm-kona.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-bcm-kona.c
> > b/drivers/gpio/gpio-bcm-kona.c index 4122683eb1f9..c50721980a7c
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
> >  #include <linux/irqchip/chained_irq.h> @@ -586,7 +585,7 @@ static int
> > bcm_kona_gpio_probe(struct platform_device *pdev)
> >
> >  	kona_gpio->gpio_chip =3D template_chip;
> >  	chip =3D &kona_gpio->gpio_chip;
> > -	kona_gpio->num_bank =3D of_irq_count(dev->of_node);
> > +	kona_gpio->num_bank =3D platform_irq_count(pdev);
>=20
> of_irq_count returns 0 or a positive int while platform_irq_count might r=
eturn
> a negative error code. This needs handling. Also I wonder why
> platform_irq_count() is better than of_irq_count() which would be good to
> describe in the commit log.

Inspired from https://lkml.org/lkml/2015/11/18/466
From Rob:
"
So I started looking at why you are using of_irq_count which drivers
shouldn't need to. In patch 5 you use it to allocate memory to store
the irq names, then use them here...
"

Is this ok?

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
> pengutronix.de%2F&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C36e86
> 59eca384830eee508d777be21cc%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C637109530809227993&amp;sdata=3Dy95EHGlmw12IVVlWoiUiS
> cQzO7GIBjQmnAfYrtd7P6k%3D&amp;reserved=3D0 |
