Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21C16AD99D
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Mar 2023 09:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCGIxQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Mar 2023 03:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCGIxN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Mar 2023 03:53:13 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2100.outbound.protection.outlook.com [40.107.113.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74938279A5;
        Tue,  7 Mar 2023 00:53:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrWe88LCYbCfojZhA8drmCO9hPu4YTjUYjqxHobPEolV0+tUHHY653VTIzpHh5BzOo5YYgntU5yG5teXcg0dm7ce4cspbrX00r0Xo8ZhqYUoGOZug64WkvbUt9t3g0w4t4igOROrch+Cb9DnkvzXzWWcxhtZa+TMKawWik5Ko2cfPiLuTFn8awEg8tg3f9VwWfLWMnAAHUyR0hBiMTbwrN6dQkzEfGZZQDCcRfjKyKeeyvJAcP8Wm/krN/tfYpP0zpq9a7cjmKPQLyctIYm0+I7YPWJh1mgfGVFuZ+jRseb8LDes8vQKgIsWvJbZoAV5nvKiaNSER0AkzQ+nn8Q/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK57tOHcNi+iX45y+whGm7Jl/UCLifTiANtwoWiHRDw=;
 b=OEFu5o8rScgJzS7aE+fC5thCsmxtkXeU/HwZ7lXmbNwLojEkR95GIE9+0qMDnGiaxvMyG5JGJ2+tImnPXOtN5eHiwbDLl8Ic9NWpLtJvM7/2l8bD9dKX61VR84H8Z5eL4ksFKy3GgNBQP+vKIGZi9CzO8agzLUpLcT8MQpqaCz/GYOHBFOkhIoPSG10FNDTO9T4e17MWwdkZJChh0zpfIzbYh4mwN+k1vqOjuJ8VFvfAFvxDOzcSByy44Q07TG3gvNeAd1r+gA2qAtVNtn6jUA7OOKasCxKuz3RwHi+qCWuzrhgO9i9KjQ1lFE97UcFDfei5UM6sH3cssxm1soACJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK57tOHcNi+iX45y+whGm7Jl/UCLifTiANtwoWiHRDw=;
 b=DGu9Bmp19q/sS/BzVpqi7JJQWckYlvQaYPcMjW3IhaBW9SvTcX00vYzBTBAhqNLBcrJNkRshR8ysm2D3AS+rI2s1VmjiX6TDYe0+f/tlk1h11nCVYDwVsFKgqLrIvt1NPpNf5HeaCZbupoEmCUYKRAxyNL4IZhUci5rhI2/Hhgo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB7992.jpnprd01.prod.outlook.com (2603:1096:400:11d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 08:53:07 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 08:53:07 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v6 06/13] drivers: pinctrl: renesas: Add RZ/G2L POEG
 driver support
Thread-Topic: [PATCH v6 06/13] drivers: pinctrl: renesas: Add RZ/G2L POEG
 driver support
Thread-Index: AQHZUAojNP3mD44BfE2nuzra+Sv8J67uaLkAgACVQcA=
Date:   Tue, 7 Mar 2023 08:53:07 +0000
Message-ID: <OS0PR01MB59223AF6B7850592F34CABF086B79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
 <20230306090014.128732-7-biju.das.jz@bp.renesas.com>
 <ZAZ43tylTNxPIun8@surfacebook>
In-Reply-To: <ZAZ43tylTNxPIun8@surfacebook>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB7992:EE_
x-ms-office365-filtering-correlation-id: c2e4c278-a916-44c3-8d41-08db1ee95f0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tFnwGAVoJTspTamaJDPYvovxsHk+yYzIeocRSoB9VmUiEzbT76Pn6mSGXyns666t5KMqZbGoZ72xJVK9yl+ew+yBOd+iPSfNfuMGG43QJsOICR4UAiN6nIs4wok1I7n9O+J9wq7F1aqWYrhrBPTxg2NXxKPHHUvgj6fFMzIb567MjhrymzzTcIeaD5ScZOBI9h2qt4TjbOlfMMhhYLAGz3NY2QBO/iCt93XV6hJPDvEKfyr2vx1sskh0ghuggNoD4EYkSdbaKTOD75T+XS0PcI9xZmzpJxWziyxTg2Xj2N6zD8uo9+GFVNbe6/EVnSnh7F6TkdbCYCiZcFGKHy1cvEu1D/w0eSYzkajmB3W3rq8W2r3U8WkCLIZZ2pG9OCu8BCvAznv01V7F3KRA4UB95pJ8rA3V3VFuH0UiAc0nPgm3VM+8pivpCvAfuScgVOIHxtSSdUFeeLDWHMt8MXN7a+dmfUVFBADGGnkNnu8rVyGZ8RgUwGn2lPLrkSnC7kjVO52ky+BaBv1zNYxBIxMCeR52ztjsj2Je5SAY/8mHxqhxCXZMjkAaQiW1Cn3Nj1OTDwgq/L6v4t6+6YfCxSbi0+5vDWEoi5b5i1SIYCqG1W91pIAm40Xo2UvrS2xc//Ds/fTVqyrJfMoT6B23LpwfVt5ks5prRAl/pBJS6XwDtSyGt1P9GKzaKS42CstD4aE4eUKsc577LSiGR4QDN7QtJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199018)(107886003)(52536014)(4326008)(76116006)(64756008)(41300700001)(66946007)(66556008)(6916009)(66446008)(8676002)(8936002)(6506007)(5660300002)(2906002)(122000001)(86362001)(38100700002)(38070700005)(33656002)(66476007)(7696005)(26005)(71200400001)(54906003)(55016003)(316002)(478600001)(83380400001)(66574015)(186003)(9686003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M4w/8JCkXSdqaxq/ZH5OUml8VeeOARr9uKUKvhjMDnsA7OCJXaZnUcHMS/?=
 =?iso-8859-1?Q?mh0ReroPOzJQ8uWfkNh58js3/usn+LmNZqq++kOic87JQnpU+GVNv+bE3N?=
 =?iso-8859-1?Q?elCbHaTrQaPkoX5xPEvJMADhfCPuKlSzcaSqvoZtK75J01cHNnBZ7dC4Wn?=
 =?iso-8859-1?Q?ruf4aKYxrt2UHcnp7cgxpuia07rsR8unNnrNv+SPfshFy3E3l32IsViG4l?=
 =?iso-8859-1?Q?zK9y43P/4NYagjjMUVNrQM04X/NYmP1myaj4YI2o2BEMeI6WQClihF4mLM?=
 =?iso-8859-1?Q?e4v51np2B+OyONMiQNN16kLYZuNi6YGEw+RpFJI6SzkTGw5eLMOYsdozPB?=
 =?iso-8859-1?Q?PJOCqyZNpf3kMS4weM2Wp8GaM/6KnU0pp/VQGPwI5TcufhHIwBqzEbvnt1?=
 =?iso-8859-1?Q?bvKsO1URk48F8afdnMlPtrwQWDZhAVNxBnkg3YDQNE7z3n9b8s1vi25wRz?=
 =?iso-8859-1?Q?Rb57mqm8IiT8/2OMIocw1JAQM7Qbp0WMfus2xEnpXI9mWmNoEFwdKNaJcL?=
 =?iso-8859-1?Q?4Dt3RoX2ilHahjlP4ibcQv2sqTE/4SWC2nToPKjf6GKiJ7ixNVmCir1OiX?=
 =?iso-8859-1?Q?6KY4OZJHJEhdfIrphmyGiezU8TcW77N5kPk8lfdlszN08QLQQfNZpVyRvj?=
 =?iso-8859-1?Q?i1qR0nfrjOqModO2IADqSIrrrB4lD5Gr89xxNCDDCiPbjQvXgsEYoFJGfN?=
 =?iso-8859-1?Q?4ClZ94Y0s8GeLSXW+22uvbbT0CuKPI4jequ5hGgT8LWKeDHzOrb3S+5qbw?=
 =?iso-8859-1?Q?F2Ndh9IxblUsWL1fDZFl5hjwemBRNxcu+FE+6uwN/euh1cc0+gTePDsBn/?=
 =?iso-8859-1?Q?3ImSwlRzbE55Y1g6antSHK4rfNm9AawsuDZ5VHx7BzSM8uPZL1GENct6Mr?=
 =?iso-8859-1?Q?nAwXZsE1wsunIwpV/69l6ucMEu03Qw4uLRPqJc2JLti+mrqEq+iizgYjG9?=
 =?iso-8859-1?Q?JurgRGWoizaJmHaDgixSBItOtj8AZJFuNlEa7YNGN7m/Ld806O9sYnDXaM?=
 =?iso-8859-1?Q?G8eB+RCYOx4YaHV8uQCGXWuVNFikOLO5ft4yV34LbNOdlqA6L5SiRzl9K+?=
 =?iso-8859-1?Q?/FYPAfFIGAz3EWq50Ow43WFlDl6xztseGWbmi4ESXlJgNQyOkVdmb0bgsB?=
 =?iso-8859-1?Q?o8+TYqRNRt0QxAcx868Nqa54boOsjHeg1aJUHylk+KrZ+qwuHmlNCMi8iM?=
 =?iso-8859-1?Q?z7cglzZ4kvJ7tOZo8QrZWEHDX9T265NsJayS3GBVG3bipeT2ibzu4iXx8+?=
 =?iso-8859-1?Q?FgfauWqOd8GGEvQbuD3hPyb02op/8Mio6M3pM/yZtDTDtbUMrTUefllyfr?=
 =?iso-8859-1?Q?ddVNOq6ftzZTmGhTKcoNMU8jld3Bb6HvWmsMdVqx0TIpBKmZSJveWVXLvK?=
 =?iso-8859-1?Q?K5YYCh5e3UkOBU3QwNvCF3U/NRMYi7osSW5XMyvCiL99pZeOqHJTKsxOCO?=
 =?iso-8859-1?Q?5lsC7wkznwtVXz+xXyS7LbHppxC0RgUFe+iGGBQpitc761E5/EYTfQCGD7?=
 =?iso-8859-1?Q?3avtctD4mZ3M4GkVk/idE4YrA0CqwzHzk3X0Rc/byCU3qneoyFnbGqcHBL?=
 =?iso-8859-1?Q?qHksioQ5QN1k4GTMHD91kTx4c8kXaWU0SCscztQLt/4lXMad98OJOcBpmF?=
 =?iso-8859-1?Q?6gyDdzAiJECMkqooBpH7ZNU09IXCyhkDs6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e4c278-a916-44c3-8d41-08db1ee95f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 08:53:07.3394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDccrbekl0QT5uJ/pgvc7mRFe1uFyIdV5vaAmVMtFolgYqYF/vc/bJGD4ulKnx4YzMvVEPOmSjfw5+JibM8llWs7uTOm+Yf1RB83UJDsx3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7992
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andy Shevchenko,

Thanks for the feedback.

> -----Original Message-----
> From: andy.shevchenko@gmail.com <andy.shevchenko@gmail.com>
> Sent: Monday, March 6, 2023 11:36 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>; Philipp Zabel
> <p.zabel@pengutronix.de>; Geert Uytterhoeven <geert+renesas@glider.be>;
> Thierry Reding <thierry.reding@gmail.com>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>; linux-pwm@vger.kernel.org; linux-renesas-
> soc@vger.kernel.org; linux-gpio@vger.kernel.org; Chris Paterson
> <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: Re: [PATCH v6 06/13] drivers: pinctrl: renesas: Add RZ/G2L POEG
> driver support
>=20
> Mon, Mar 06, 2023 at 09:00:07AM +0000, Biju Das kirjoitti:
> > The output pins of the RZ/G2L general PWM timer (GPT) can be disabled
> > by using the port output enabling function for the GPT (POEG).
> >
> > Add basic support using s/w control through generic pincontrol sysfs
> > to enable/disable output from GPT by registering with RZ/G2L
> > pincontrol driver.
>=20
> You have wrong Subject prefix.

Oops. Will fix.

>=20
> ...
>=20
> > +static void rzg2l_poeg_write(struct rzg2l_poeg_chip *chip, u32 data)
> > +{
> > +	iowrite32(data, chip->mmio);
> > +}
> > +
> > +static u32 rzg2l_poeg_read(struct rzg2l_poeg_chip *chip) {
> > +	return ioread32(chip->mmio);
> > +}
>=20
> Why not regmap MMIO?

Some drivers used iowrite32, some uses writel, some uses regmap.=20

will use regmap for read/write,If the preference is regmap MMIO
as it comes with spinlock for MMIO access.

>=20
> ...
>=20
> > +static struct platform_driver rzg2l_poeg_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "rzg2l-poeg",
> > +		.of_match_table =3D of_match_ptr(rzg2l_poeg_of_table),
>=20
> Why do you need of_match_ptr()?


Not needed. Will remove it.

Cheers,
Biju

>=20
> > +	},
> > +	.probe =3D rzg2l_poeg_probe,
> > +	.remove =3D rzg2l_poeg_remove,
> > +};
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

