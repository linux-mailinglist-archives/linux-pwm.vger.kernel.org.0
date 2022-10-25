Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD7A60CEAE
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Oct 2022 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiJYOOQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Oct 2022 10:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiJYONv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Oct 2022 10:13:51 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2094.outbound.protection.outlook.com [40.107.114.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C2A3BAA;
        Tue, 25 Oct 2022 07:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqZIxjITT4a08nPG74+6Tc81ws2WeKo5AHbvX92J7jic5PuObrEL2i+QBKzMGaNsfnQfVyGw/D1aVvuF2K13iPcH+2+o8PHoM4fZKKKrzK0yPiWZPbb7QjXAuE+EZ/h+BJuBoLUmlGUi9BVIv7802V/UlEfmYe6p0qJhbfc3Jaw0XFNqRL88MUW4tsUNd+KkDixQAZLfkInF06BzDqziafruZsjD/6kUO0biJbYiI90ZN2hJDFzRtATPzOQUv/AIOZrOmUEXhZhVdvC86AezFo4vcw9U2TvjCj1HzWwwNNLxQfWRK9zuFtO05Qx6Epp+8iA7ZSkkRmYViT9eTS9czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEgLE9HhYcdyBo9rPpQLHHlv3mUlL5/tk16xnHvtM9M=;
 b=I36BSMZX7Sd7rMKz3Y2+7O1mslLU+FfdPeR+xjowWkYlvg0EP31nBpHx4FElvDQnrYPAr2a3RXlRY8fFto0JiGWB6dqfXghpXBwGI4eEvbu32EQMpWzVrPi+YvD/aLCqfPeMZT6utbSg9EG2Xxhhh9fxFrOThFhSy92/ozmju/HYeTwRRlcMDz9TtZcrEYKNvzp7Q0i86pVjy5tSMOCV221IDoBy8+h4Tqi69DmCqeiy0RYfA7W1l5HmIcUWNMe1mK3FLuhYSEsrll9w5pYoGAy9LERUmb9l7iGIRIxFd8SK4nFlhZbgAXG1ezS9An0wUrBIa8ptYh8Ca1S3NrXcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEgLE9HhYcdyBo9rPpQLHHlv3mUlL5/tk16xnHvtM9M=;
 b=uZdW9OR9u/fQ/qF6Xu5Pv+TtOEbVDHdyTxUE6QeiuyITTsdxekefT3DQx5GlzJgFLLWOXXAoOoVG9xpy2j4HvTHDJh2ViglEO9barRWPjxgBgS23kAEh1pEKWK8W64+b072KTVfrAOyx7+PbrDDVZA54i7U/HtY2FSOGESfG6wQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10355.jpnprd01.prod.outlook.com (2603:1096:400:253::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 14:13:47 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fea0:9039:b0b3:968f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fea0:9039:b0b3:968f%7]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 14:13:47 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lee Jones <lee@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Thread-Topic: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Thread-Index: AQHY3Lf1ZjO75wmqM0qPUfqcMk9xD64fPDiAgAAAa6A=
Date:   Tue, 25 Oct 2022 14:13:47 +0000
Message-ID: <OS0PR01MB592238C639F8FCB83026FCFA86319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-5-biju.das.jz@bp.renesas.com>
 <CAMuHMdWE+H=aXkt61hZK6mbQairwdk1F522mZRemC0T5LxQtMg@mail.gmail.com>
In-Reply-To: <CAMuHMdWE+H=aXkt61hZK6mbQairwdk1F522mZRemC0T5LxQtMg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB10355:EE_
x-ms-office365-filtering-correlation-id: b93a8b6d-e08f-477e-acf7-08dab693222d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JVXjvlZXAprYu3eKqO/mnsSwSxek+q3n6HWW8uQF4mYf8CChJl2t1l+eCj8tMtexcgdT2TejtanJyi+RDJ6UHw848oLW/LoSDeEq9YJ4AHgPQH1at+9zw0mqXK7CFVgPl+m5evsqZtCALDnfEcWR28d9TUddn4028hjyejZArNwppXIrbk2m7OVhraxJyx44dhmlrfMii3mmxcyrN8FJ/FvG9t6awDCyiPH8rQamk8vT9C/k64RueP6fGh4pw6tLn7N4uZnKBAznmhTrDfiJ/xTgOZ23Cs3IKvdD3Bcg5VQ9AIWqk9GPOQ5xXOQJ4fYVOp7imBRPBGgyRWta5eEQZmlJQ3cyc8LL8GL9K8H/ffPgILg2l48CKf9yuzmTAqoaaDRO/pbeLY7Cy8z5rchzUZ2BsEU89+pbcWyFNZl6kkPPfKxAr7nzccyvAplgfd2u9ieUE/zJuvxhJ5xw4JhCu5D/giI8G5lBMfYvUdY+4qLbE/CSNcD/paiBSk7zXSNkOZdHgweTekjgm2zzGnxfEN1axqFOrPuZNk5niRpBGawiNmM01TBEhigvISWETJlWD92Zwm4c5R/N71kOP+mi8RFxZwbufVnUrLbjFqy1958oGrN5r+8OqvTyv5nRQQIE3/KebdhClVmDU5Mc2CPa37nURQ1amsaNOcMxPjQknnUmBnqWg3HeXgEhZJkbirQbWB/8KaG3SNqlmWQVMvzI3qKP+JrPHGHP5cZSdkcx/5D4iItn8NekYT3GA8JTOjYH3BnbI1MMLip49PNAgC7OzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199015)(478600001)(86362001)(83380400001)(71200400001)(66476007)(66446008)(53546011)(66946007)(64756008)(7696005)(54906003)(6506007)(316002)(76116006)(4326008)(8676002)(9686003)(26005)(41300700001)(52536014)(8936002)(5660300002)(6916009)(66556008)(186003)(55016003)(38100700002)(2906002)(33656002)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ewKRRByCQo45tsDflGj0UWONIIC6br0t2pLjJsuXYEBJ3M4dGMVb0Qxkmd?=
 =?iso-8859-1?Q?dVUDh13niWGCLFwf93tTthuWt++gIMyuXuRz+AxJwHT5l2KKdB4P1NsyTe?=
 =?iso-8859-1?Q?pdpGMlejAaoteAA8dp4KBVyKVrlpXUeuqZ9hyjKqAxiSyYhxmrV5FpqrK9?=
 =?iso-8859-1?Q?wZb9gtZHhZdJWhea0IP+JBmgGYj5pY8WhJZFHtl6xkZ/uvSKFUZl9MVSJ+?=
 =?iso-8859-1?Q?dzfH6ZdsGHYKUBQslJfHVGeP/eXGApzNLzHF0Q9DOZ0bef1ntrrV8Pd9al?=
 =?iso-8859-1?Q?v0g2Cxo9VQd7dyakTqsomc0eO4mqWbdz0T88OZOlMNFV3/iLR5FG+evace?=
 =?iso-8859-1?Q?ifanKxzPDFYs3K17M3l3+IDzaIEYNk0OciGhCAmdxsom9XwPPE8rApdvoA?=
 =?iso-8859-1?Q?sTSieuVWeHv21lvq5QQYvLFQERi7e9JpZBRyiGKuQhPiVYwVNvBbOhPFlH?=
 =?iso-8859-1?Q?61c+Fe+VS8VZd9ZjdKY57zLPBNhEDtOkWHA3U80TGPQ2dPNXvCvveVtKka?=
 =?iso-8859-1?Q?ukFvSMupLThymVqkTo8HkGP5y4eRjyCTqKCbaH27fXOwfTmjv3TNo9ttvb?=
 =?iso-8859-1?Q?jLXOCzOj5W9lMNJQyRFOWw5QTIgLq4vt7vMxuxFRavxaMVx+cVTX1gB3Yy?=
 =?iso-8859-1?Q?1A/tx295HMr45v0KUyGsm/rRe69jTMcHKiyiAujSPYk8k/rzal+Vrt9KB7?=
 =?iso-8859-1?Q?i4bNnqlP6OYCbAvZwY2kSTH++IUwFHFv72Sp0IOHMBhaOYYvGh9637Z+9r?=
 =?iso-8859-1?Q?uETUJO+dwkNRsbSvEiij7f140u7x+62NJdb7MpfjQjQ2+KCiE3i+VKWbFq?=
 =?iso-8859-1?Q?fBGu+yprWnSRjDJpgkeU19Xe7CCM3CsJcSO/BWqHISczXgXGJUmLU5YUqs?=
 =?iso-8859-1?Q?SNlaRlb0hwqTND9Ydj3aCSL79CXp4xKUHk/JOUiOEjaMGGeuLC8nR+kBkd?=
 =?iso-8859-1?Q?v6vLaLcY17an0yl6a5l6D4wdCtaTpr2CRl/V8NoiZhx7MUe5fL6FXQhHmv?=
 =?iso-8859-1?Q?tD3nBYHb+cBA9CXCPgB9br2Vg82qMPLBzPKyNowXZiiiNMyzE3G/RSpCcu?=
 =?iso-8859-1?Q?o25aPScAl1RDuaPwOgr1yeogIt7d63CO9YXvR9ph1OKaEgkPWME+82iKRv?=
 =?iso-8859-1?Q?Zt9fEV+bV7+uWiVNvdzAFqF95g/M5DCXxPbKWM8H8rRPwe+jPKlamL0eAJ?=
 =?iso-8859-1?Q?M73xZOUNbNMEEbmQykp72eURIiR5El/z5DbC5wQLn0qiFj1sz7GyqClnQA?=
 =?iso-8859-1?Q?8zRV6L9QjaOV/81jcEujcsEF/TVBqUEEjg18rK8kwb3BqRDFTMwAj/Q6vy?=
 =?iso-8859-1?Q?fNPIfBgmPiy1IHKHu0CPxxGIyaXp96vfETnEO+cQau0YEXcZtWoe5Bg6Yw?=
 =?iso-8859-1?Q?79eQDIFYqsHifQXyQ2UrEChcJnVr68HXMB6MDv+cpF/8n46yST8hqXp7af?=
 =?iso-8859-1?Q?WN/UA1mfeS5kbwabxu6hKiNYACDuJnp8G3woaItlT8HXb6cSOHpkkV8n55?=
 =?iso-8859-1?Q?q8SfUVo63ex2tsmesQm1HjjiVMgYLhGHrgi3O137df9s2/Sihp2JXrvT1y?=
 =?iso-8859-1?Q?I7zrN3sZKswgzlzn4IYnRmx/5fA4+OR9wOb0O9JDQuWSLgPJnsIIpHHtd8?=
 =?iso-8859-1?Q?0na0JfW4RkAy9GHDtypUl1AIBCeaGhzCZxkH+w2pPKA23AveQYtuBRzw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93a8b6d-e08f-477e-acf7-08dab693222d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 14:13:47.5744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8D0XXVZrETsU0ZwbAWOd6vsztye/EDgMmtIi49HJt2WHO3PTBuweQ1e4rCqTjrRYwSbtW9XzLC6TaqTmC0KASJI4Rklq25dvPpa1eFRj4Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10355
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Geert,

Thanks for the feedback.

> Subject: Re: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
>=20
> Hi Biju,
>=20
> On Mon, Oct 10, 2022 at 4:52 PM Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> > Add support for RZ/G2L MTU3 PWM driver. The IP supports following
> PWM
> > modes
> >
> > 1) PWM mode{1,2}
> > 2) Reset-synchronized PWM mode
> > 3) Complementary PWM mode{1,2,3}
> >
> > This patch adds basic pwm mode 1 support for RZ/G2L MTU3 driver by
> > creating separate logical channels for each IOs.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1994,6 +1994,12 @@ config MFD_RZ_MTU3_CNT
> >           SoCs. This IP supports both 16-bit and 32-bit phase
> counting mode
> >           support.
> >
> > +config MFD_RZ_MTU3_PWM
> > +       tristate "Renesas RZ/G2L MTU3 PWM Timer support"
> > +       depends on MFD_RZ_MTU3
>=20
> depends on PWM || COMPILE_TEST

OK, this will move to PWM as the core is going to be part of timer bindings
And pwm device is instantiated using mfd_add_device()


>=20
> Note that currently the build fails if CONFIG_PWM=3Dn.

> I have sent a patch to fix that
> "[PATCH] pwm: Add missing dummy for devm_pwmchip_add()".

OK, looks currently no one outside pwm subsystem is accessing this function=
.

Cheers,
Biju

>=20
> > +       help
> > +         Enable support for RZ/G2L MTU3 PWM Timer controller.
> > +
> >  config MFD_STM32_LPTIMER
> >         tristate "Support for STM32 Low-Power Timer"
> >         depends on (ARCH_STM32 && OF) || COMPILE_TEST
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>=20
> In personal conversations with technical people, I call myself a
> hacker. But when I'm talking to journalists I just say "programmer" or
> something like that.
>                                 -- Linus Torvalds
