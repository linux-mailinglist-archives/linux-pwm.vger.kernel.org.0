Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1474126D
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jun 2023 15:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjF1Na7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Jun 2023 09:30:59 -0400
Received: from mail-tycjpn01on2106.outbound.protection.outlook.com ([40.107.114.106]:37869
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231504AbjF1Nap (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 28 Jun 2023 09:30:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPr1z8pefe5EiYTtMK6pG0rJxK8VE4J8qWPIjAU1KZytYI7DdkWx8cOqC+yxfu9KT02usjQQasFuDKZAFuro4BhewoiZ3IHtKcdGIc4jHaoOuyS9Tq/T/ImoGv3B3L4BDBD0t96cZD6gzsm6AieMSjni3CsaqTCUm73fUtHhPuOFKQlaP1Yxz6esRJnO9XWXON72U7DmYmZrWfeGLSOqdIArm/19USrun3rcVc2LyLtU9Qfs8KYi0g0SeBr/0Y1EyxHCNrf6E3lMxeSqaRsg8ecT6bXQuQKCRSS9wH4HJjT5AJPrvNfPXt156nUVkg0EiLsyGd9wKNnu4QKG4wY9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJLor/82sjE7A8yWCTwC51IuXRWCotvkbLgHFxlWiJg=;
 b=f5dno4Fig6WBV46CNt6IhmMgZuveYNnlx253CxuMn7gblmvifl8dfDgYFTzLhG/F3sQrnBTVjHuThAWXDH6aH5tIHuYY1YbT7Hmjiq/euWrXG3SvhBgO2NZYSiizwaRLK3DtZGqQ0n01HZwtVTMqztxJwwLtdI7OslMcp8EYV189zqqkvJM4zNU5VljGeEpYnFikecWGfbWLm+5mekozrW5EqiCf1UTeS1ivdEa85cReGdRqWfqORb1ludrB1id54kx7yWuSrhploCalfQO0UYDikp3zvJ5mMAv/+TZlh1uOktcEB2WBpaTPCaqwUF3p4sPJz0SkP5DuCj6uwGxImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJLor/82sjE7A8yWCTwC51IuXRWCotvkbLgHFxlWiJg=;
 b=iuzPak/B9N3oe6rTb457IAnvmNIgFqmdKNBj2FhmPsI289YVDWERn7t1JTglSEBV/1zt3HPwRAyLmixFw5KqJBq5CN6TaT8ThML4L0Blc1CI6cA/DCXGuTAIHvVUWAiZkTl9Zhz/aXt+eHc/TKmKiT92VYscvnC4Jfu2uNONIg4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB10593.jpnprd01.prod.outlook.com (2603:1096:400:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 13:30:41 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b%4]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 13:30:41 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Topic: [PATCH v4 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Index: AQHZPIYGkrbVamMoeEetW4lVotJABa8eW7+AgH+kyLA=
Date:   Wed, 28 Jun 2023 13:30:40 +0000
Message-ID: <OS0PR01MB59227B491F0A622A7F4FE2848624A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230209125656.191905-1-biju.das.jz@bp.renesas.com>
 <20230209125656.191905-3-biju.das.jz@bp.renesas.com>
 <20230406093017.dsciryvdbavitien@pengutronix.de>
In-Reply-To: <20230406093017.dsciryvdbavitien@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYYPR01MB10593:EE_
x-ms-office365-filtering-correlation-id: 7b3ee98f-8473-4f79-dfeb-08db77dbde07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHXoMMYZBmfs2t5XsttzMYiMLfL/eQWuxttNmBu0BnXO7Zs5rZC9FhHYiMhECD/+vwK8Rpk6F5QShMAq5RtTkHKMqjwmW/zeoJl5nyL4vdMAa/5yO0iyPBcyoggZOwfVup+C4oyrvEli8sUOhGQalgaINceegcrWEPJv1qOaxCjIhpnktRs+y/axFgUxb/kHxpOnwZ4wVpJqWgG24D0c5Sj0pfg/P9nMy9Xh9byiYRfHj4Ny2gPY085rcpVN2aktZ5WI+qpKH4Iv31SAyOn1Uj0i/2xDw6JEEp7aoWObRDYxtV4e9wmG/4woeJaNCHk7XbGgKJh5iEP/JSIDfdSHAoXo+rUbx2PyfEE22+HyI5EnXMoDtAZdq99UqFmBpq6I/KPgHMuSfXWN7fVkwqpyo8oCEO6M9wIIYXmW2hqOedm8i4FiFTC4J+j2fGsElRMzlIAxj8e5RnyzKeDIJQjisayOG4pN+odN2UEMkS5Xc2bedeje5dbH56YIK0ym9l2ghRxstsO6LJ1GJb59Yxpy2hwBBdIYVKGHwEmDUN2RSYVyR76d7Sjb6L5IWjtmHxY/76vCzDdIcMDYaMEsLpn20K59wocd23xrJIM6+A//8RCOVbXxG9pt7MSGWD5M7AqnAQ9D3FxfI7lKtj8ONSSOcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(66446008)(966005)(83380400001)(7696005)(9686003)(71200400001)(54906003)(6506007)(2906002)(186003)(478600001)(52536014)(30864003)(6916009)(122000001)(5660300002)(55016003)(64756008)(4326008)(66946007)(316002)(66574015)(38100700002)(8936002)(76116006)(41300700001)(38070700005)(66476007)(33656002)(8676002)(86362001)(66556008)(66899021)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QN4dLuijyGPfybGtf2M8/xu0i+ZKjB7HO54qCtbhcyx35MdIc/upjWL5VJ?=
 =?iso-8859-1?Q?gX6xWbHbD7x2tAAEa/aRa3MwUDK9zV4oDcAErtZ4fut78Ht/BGg3vNle4B?=
 =?iso-8859-1?Q?YuTzq7X6VDDQZapkToUHBj6GM5Gi54dO+LgRV6u5kbks8zT5c97ZuODJyw?=
 =?iso-8859-1?Q?ACvGOKSn23E+AjR16REFj+5uVgjpYePmz5f6EvyBCd+xn+nwEc9UUa7a1g?=
 =?iso-8859-1?Q?l718M2w2+3f7OOCXBz+d5BsnWFjzWtVYhmtC7+c/IsFxx1eoLpuKa1PhXw?=
 =?iso-8859-1?Q?nB0h41yX5rnq++5MdBtPLXIUNegXfIS/1YLOE7PK/pZXZIHb8peWCBT1zQ?=
 =?iso-8859-1?Q?FyGLNd8rqSPfN37+6DdeRd/c1k4MahRXwwPtIW6iC4Dun2ybQlY0unCZB3?=
 =?iso-8859-1?Q?H0b4fK/kvTApCyKBwUB9cMUbfq6P7fyrZ6+MhQNSMsOqYJKc6klEK+uX29?=
 =?iso-8859-1?Q?HkcCMyWfL/GYEq1hFfrBrcBKsTOFXwkvL6nHxoajq6Q9shjeaKuAxGL3d2?=
 =?iso-8859-1?Q?i9mqaaQxGoiQ/s+X3TIcGDYKQKAa+SYtOQR7mYoVs77Ly0tBU0YyC2xmlq?=
 =?iso-8859-1?Q?JoRc3CxxiWlO9c91o9RHB5EgGrH+WNXXSG471RZvPaOY4wASNQGrCUiIya?=
 =?iso-8859-1?Q?bhP7IMuu1RD8jl9KtwkIIWBiBA7rKyh+g7CJ79vETc5Pa+Zq5N98syo7uM?=
 =?iso-8859-1?Q?ffSID+jPh/vM/Pa/0XxEWPTSWKnjTPK9aEULVKBbkdqW3RqtnohoNk4X6v?=
 =?iso-8859-1?Q?YVwYdRdRNQZcxTLVvdqAWenRUovqM/Way0Lu8CBycIhWXwItUOl4u8kb1t?=
 =?iso-8859-1?Q?LiEn079l/4PRwN9ycS1eb80Tz7b60tIq/tK228SaEjyV0X7X45GBYROrSI?=
 =?iso-8859-1?Q?hAYsv/MN0TdY6G2S9+ygALPDve3+THNFokM78685Dqlq43vWQ9i+fN0Q4c?=
 =?iso-8859-1?Q?7F76uSZij43cIj8AaREkSJ5xWZ4lyufJKSeJgdS31fiNPIo8rj2LP3JH8f?=
 =?iso-8859-1?Q?/y9QY05W5WMg9l4B61XUUHBnDRo33qTtSjvhgfc68kdlY0Q6+/TnS6Mr9c?=
 =?iso-8859-1?Q?IYFOue9R69e7hN9IQkwXZVqMYReXUsJENOl4FcX+r4KzcXxYjlDfi+Dzn2?=
 =?iso-8859-1?Q?wyVAWRuhVxaK7vZT2cf73A1cdwULcE/1X6ZRiyXLRV8bTtQVYKjNst9LQP?=
 =?iso-8859-1?Q?tWkEi4BZddpBxHD7lMrCDmP4RZBcFEq66fyh5XTYzvc6NlVU0GP8fXc0Wv?=
 =?iso-8859-1?Q?MGCRxA6MO+ccZmWRYmyz3HxdvVq+6vp4a3rbiiKvYfQGQU7oNiisvvdKMu?=
 =?iso-8859-1?Q?73UDkZD2s/85hFovSTsPE4TcuEczEzRVoxo50KyWN1EuLoWO22RzkmBMjh?=
 =?iso-8859-1?Q?nnyTVm+bQQK7dcStH8A2DRei1ExANdJDb2a+YzmbrgNT5gf2YUb/NS4xpJ?=
 =?iso-8859-1?Q?WqaGxKA9HVv4SNHDnKWNarUZRg2Z8h+WrtuR787egApbaZZepnmZGBaPZz?=
 =?iso-8859-1?Q?UWKiULIunrMFzRX7ZgunBT2XblScDWPB3CTSJ7tVi2Jh+IaTjVn1XGeTfZ?=
 =?iso-8859-1?Q?OWJ2L2HEqr2UT3k7BnpQBdC+3WVZ7dIBlPaGgUzWwFYZ+WmHNArGpq5IR/?=
 =?iso-8859-1?Q?srBOfO00BwVDg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3ee98f-8473-4f79-dfeb-08db77dbde07
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 13:30:40.9135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agxZnkIzRo5AD9Y924mPX3Bne/y9iOT1IPk5d8XBjnDxsBYz5QdFAqORTo7I5xlt1Mx3QTPzsPTOk1wF/pjoP9bC9H6HsrNxA2/UNgi1fSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10593
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe Kleine-K=F6nig,

Thanks for the feedback.

> Subject: Re: [PATCH v4 2/4] pwm: Add support for RZ/V2M PWM driver
>=20
> Hello,
>=20
> I finally come around to spend some time on your patch. Sorry it took so
> long.
>=20
> On Thu, Feb 09, 2023 at 12:56:54PM +0000, Biju Das wrote:
> > The RZ/V2{M, MA} PWM Timer supports the following functions:
> >
> >  * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
> >  * The frequency division ratio for internal counter operation is
> >    selectable as PWM_CLK divided by 1, 16, 256, or 2048.
> >  * The period as well as the duty cycle is adjustable.
> >  * The low-level and high-level order of the PWM signals can be
> >    inverted.
> >  * The duty cycle of the PWM signal is selectable in the range from
> >    0 to 100%.
> >  * The minimum resolution is 20.83 ns.
> >  * Three interrupt sources: Rising and falling edges of the PWM signal
> >    and clearing of the counter
> >  * Counter operation and the bus interface are asynchronous and both
> >    can operate independently of the magnitude relationship of the
> >    respective clock periods.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v3->v4:
> >  * Documented the hardware properties in "Limitations" section
> >  * Dropped the macros F2CYCLE_NSEC, U24_MASK and U24_MAX.
> >  * Added RZV2M_PWMCYC_PERIOD macro for U24_MAX
> >  * Dropped rzv2m_pwm_freq_div variable and started using 1 << (4 * i)
> for
> >    calculating divider as it is power of 16.
> >  * Reordered the functions to have rzv2m_pwm_config() directly before
> >    rzv2m_pwm_apply().
> >  * Improved the logic for calculating period and duty cycle in
> > config()
> >  * Merged multiple RZV2M_PWMCTR register writes to a single write in
> > config()
> >  * replaced pwm_is_enabled()->pwm->state.enabled
> >  * Avoided assigning bit value as enum pwm_polarity instead used enum
> constant.
> >  * Fixed various issues in probe error path.
> >  * Updated the logic for PWM cycle setting register
> >  * A 100% duty cycle is only possible with PWMLOW > PWMCYC. So
> restricting
> >    PWMCYC values < 0xffffff
> >  * The native polarity of the hardware is inverted (i.e. it starts
> > with the
> >  * low part). So switched the inversion bit handling.
> > v2->v3:
> >  * Added return code for rzv2m_pwm_get_state()
> >  * Added comment in rzv2m_pwm_reset_assert_pm_disable()
> > v1->v2:
> >  * Replaced
> > devm_reset_control_get_optional_shared->devm_reset_control_get_shared
> > ---
> >  drivers/pwm/Kconfig     |  11 +
> >  drivers/pwm/Makefile    |   1 +
> >  drivers/pwm/pwm-rzv2m.c | 436
> > ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 448 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-rzv2m.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > dae023d783a2..31cdc9dae3c5 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -473,6 +473,17 @@ config PWM_RENESAS_TPU
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-renesas-tpu.
> >
> > +config PWM_RZV2M
> > +       tristate "Renesas RZ/V2M PWM support"
> > +       depends on ARCH_R9A09G011 || COMPILE_TEST
> > +       depends on HAS_IOMEM
>=20
> The driver uses readl and writel to access its registers. If that
> justifies a dependency on HAS_IOMEM there are quite some drivers (in
> drivers/pwm and elsewhere) that are missing this dependency.

Looks like "devm_platform_ioremap_resource" depends on iomem.c
https://elixir.bootlin.com/linux/v6.4/source/drivers/base/platform.c#L85

>=20
> > +       help
> > +         This driver exposes the PWM controller found in Renesas
> > +         RZ/V2M like chips through the PWM API.
> > +
> > +         To compile this driver as a module, choose M here: the
> module
> > +         will be called pwm-rzv2m.
> > +
> >  config PWM_ROCKCHIP
> >  	tristate "Rockchip PWM support"
> >  	depends on ARCH_ROCKCHIP || COMPILE_TEST diff --git
> > a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> > 7bf1a29f02b8..a95aabae9115 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -43,6 +43,7 @@ obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
> >  obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-poe.o
> >  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> > +obj-$(CONFIG_PWM_RZV2M)		+=3D pwm-rzv2m.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> > diff --git a/drivers/pwm/pwm-rzv2m.c b/drivers/pwm/pwm-rzv2m.c new
> > file mode 100644 index 000000000000..516e875d6285
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rzv2m.c
> > @@ -0,0 +1,436 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/V2M PWM Timer (PWM) driver
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corporation
> > + *
> > + * Hardware manual for this IP can be found here
> > + *
> > +https://www.renesas.com/in/en/document/mah/rzv2m-users-manual-hardwar
> > +e?language=3Den
> > + *
> > + * Limitations:
> > + * - If the PWMLOW value is changed during PWM operation, the changed
> > +=A0* =A0 value is reflected in the next PWM cycle.
>=20
> Ideally this section is understandable without knowing the hardware. I
> think what you want to say here is that changes to the duty cycle
> configuration get effective only after the next period end?!

Yes, that is correct. Will change to "Changes to the duty cycle
Configuration get effective only after the next period end".

>=20
> > +=A0* - The duty cycle can be changed only by modifying the PWMLOW
> > +register
> > +=A0* =A0 value and changing the pulse width at low level. The duty cyc=
le
> > +becomes
> > +=A0* =A0 0% for the low width when the value of the PWMLOW register is
> > +0x0h
> > +=A0* =A0 and 100% for the low width when the value of the PWMLOW >
> PWMCYC.
>=20
> pulse width =3D period length?

Yes, for 100%dutycycle, pulse width =3D period length.

>=20
> > +=A0* - To change the setting value of the PWM cycle setting register
> > +=A0* =A0 (PWMm_PWMCYC), set the PWME bit of the PWM control register
> > +(PWMm_PWMCTR)
> > +=A0* =A0 to 0b and stop the counter operation. If it is changed during
> > +counter
> > +=A0* =A0 operation, PWM output may not be performed correctly.
>=20
> This is an implementation detail that isn't important for the general
> overview of the driver. The typical question that should be answered in
> the Limitations paragraph is: "Is this driver suitable for my use case?"

OK, will remove this from limitation section.

>=20
> > +=A0* - The registers other than the PWM interrupt register (PWMINT) ar=
e
> > +always
> > +=A0* =A0 synchronized with PWM_CLK at regular intervals. It takes some
> > +time
> > +=A0* =A0 (Min: 2 =D7 PCLK + 4 =D7 PWM_CLK to Max: 6 =D7 PCLK + 9 =D7 P=
WM_CLK) for
> > +the
> > +=A0* =A0 value set in the register to be reflected in the PWM circuit
> > +because
> > +=A0* =A0 there is a synchronizer between the register and the PWM
> circuit.
>=20
> This is a nice information, keep it, but move it out of the Limitations
> paragraph.

OK, will inline with the code on the probe().

>=20
> > + * - The native polarity of the hardware is inverted (i.e. it starts
> with the
> > + *   low part).
>=20
> Another implementation detail. The driver supports both, so which is the
> native one is of little interest.

OK will remove it.

>=20
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/pwm.h>
> > +#include <linux/reset.h>
> > +#include <linux/time.h>
> > +
> > +#define RZV2M_PWMCTR	0x0
> > +#define RZV2M_PWMCYC	0x4
> > +#define RZV2M_PWMLOW	0x8
> > +#define RZV2M_PWMCNT	0xc
> > +
> > +#define RZV2M_PWMCTR_PWMPS	GENMASK(17, 16)
> > +#define RZV2M_PWMCTR_PWMHL	BIT(3)
> > +#define RZV2M_PWMCTR_PWMTM	BIT(2)
> > +#define RZV2M_PWMCTR_PWME	BIT(1)
> > +
> > +#define RZV2M_PWMCYC_PERIOD	GENMASK(23, 0)
> > +
> > +struct rzv2m_pwm_chip {
> > +	struct pwm_chip chip;
> > +	void __iomem *mmio;
> > +	struct reset_control *rstc;
> > +	struct clk *apb_clk;
> > +	struct clk *pwm_clk;
> > +	unsigned long rate;
> > +	unsigned long delay;
> > +};
> > +
> > +static inline struct rzv2m_pwm_chip *to_rzv2m_pwm_chip(struct
> > +pwm_chip *chip) {
> > +	return container_of(chip, struct rzv2m_pwm_chip, chip); }
> > +
> > +static void rzv2m_pwm_wait_delay(struct rzv2m_pwm_chip *chip)
>=20
> Please pick a different variable name. "chip" is usually used for
> variables of type struct pwm_chip. rzv2m_pwm is what you use in other
> functions.

Agreed, will use rzv2m_pwm here as well.

>=20
> > +{
> > +	/* delay timer when change the setting register */
> > +	ndelay(chip->delay);
> > +}
> > +
> > +static void rzv2m_pwm_write(struct rzv2m_pwm_chip *rzv2m_pwm, u32
> > +reg, u32 data) {
> > +	writel(data, rzv2m_pwm->mmio + reg); }
> > +
> > +static u32 rzv2m_pwm_read(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg)
> > +{
> > +	return readl(rzv2m_pwm->mmio + reg); }
> > +
> > +static void rzv2m_pwm_modify(struct rzv2m_pwm_chip *rzv2m_pwm, u32
> reg, u32 clr,
> > +			     u32 set)
> > +{
> > +	rzv2m_pwm_write(rzv2m_pwm, reg,
> > +			(rzv2m_pwm_read(rzv2m_pwm, reg) & ~clr) | set); }
> > +
> > +static u8 rzv2m_pwm_calculate_prescale(struct rzv2m_pwm_chip
> *rzv2m_pwm,
> > +				       u64 period_cycles)
> > +{
> > +	u32 prescaled_period_cycles;
> > +	u8 prescale;
> > +
> > +	prescaled_period_cycles =3D period_cycles >> 24;
> > +	if (prescaled_period_cycles >=3D 256)
> > +		prescale =3D 3;
> > +	else
> > +		prescale =3D (fls(prescaled_period_cycles) + 3) / 4;
> > +
> > +	return prescale;
> > +}
> > +
> > +static bool rzv2m_pwm_is_ch_enabled(struct rzv2m_pwm_chip *rzv2m_pwm)
> > +{
> > +	return !!(rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCTR) &
> > +RZV2M_PWMCTR_PWME); }
> > +
> > +static int rzv2m_pwm_enable(struct rzv2m_pwm_chip *rzv2m_pwm) {
> > +	int rc;
> > +
> > +	rc =3D pm_runtime_resume_and_get(rzv2m_pwm->chip.dev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> > +			 RZV2M_PWMCTR_PWME);
> > +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzv2m_pwm_disable(struct rzv2m_pwm_chip *rzv2m_pwm) {
> > +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME, 0);
> > +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> > +
> > +	pm_runtime_put_sync(rzv2m_pwm->chip.dev);
> > +}
> > +
> > +static int rzv2m_pwm_get_state(struct pwm_chip *chip, struct
> pwm_device *pwm,
> > +			       struct pwm_state *state)
> > +{
> > +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> > +	u8 prescale;
> > +	u32 val;
> > +
> > +	pm_runtime_get_sync(chip->dev);
> > +	val =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCTR);
> > +	state->enabled =3D FIELD_GET(RZV2M_PWMCTR_PWME, val);
> > +	state->polarity =3D FIELD_GET(RZV2M_PWMCTR_PWMHL, val) ?
> > +		PWM_POLARITY_NORMAL : PWM_POLARITY_INVERSED;
> > +	prescale =3D FIELD_GET(RZV2M_PWMCTR_PWMPS, val);
> > +	val =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCYC);
> > +	if (val)
> > +		val +=3D 1;
> > +	state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)val << (4 *
> prescale),
> > +					 rzv2m_pwm->rate);
> > +
> > +	val =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMLOW);
> > +	if (val)
> > +		val +=3D 1;
> > +	state->duty_cycle =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)val << (4
> * prescale),
> > +					     rzv2m_pwm->rate);
> > +	pm_runtime_put(chip->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rzv2m_pwm_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			    const struct pwm_state *state) {
> > +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> > +	unsigned long pwm_cyc, pwm_low;
> > +	u8 prescale;
> > +	u32 pwm_ctr;
> > +	u64 pc, dc;
> > +	int err;
> > +
> > +	/*
> > +	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> > +	 * calculation.
> > +	 */
> > +	if (rzv2m_pwm->rate > NSEC_PER_SEC)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Formula for calculating PWM Cycle Setting Register
> > +	 * PWM cycle =3D (PWM period(ns) / (PWM_CLK period(ns) =D7 Div ratio)=
)
> - 1
> > +	 */
> > +
> > +	pc =3D mul_u64_u32_div(state->period, rzv2m_pwm->rate,
> NSEC_PER_SEC);
> > +	dc =3D mul_u64_u32_div(state->duty_cycle, rzv2m_pwm->rate,
> NSEC_PER_SEC);
> > +	prescale =3D rzv2m_pwm_calculate_prescale(rzv2m_pwm, pc);
> > +
> > +	pwm_cyc =3D pc >> (4 * prescale);
> > +	if (pwm_cyc)
> > +		pwm_cyc -=3D 1;
> > +
> > +	if (!FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_cyc))
> > +		pwm_cyc =3D FIELD_MAX(RZV2M_PWMCYC_PERIOD);
> > +
> > +	pwm_low =3D dc >> (4 * prescale);
> > +	if (pwm_low)
> > +		pwm_low -=3D 1;
> > +
> > +	if (!FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_low))
> > +		pwm_low =3D FIELD_MAX(RZV2M_PWMCYC_PERIOD);
> > +
> > +	/*
> > +	 * A 100% duty cycle is only possible with PWMLOW > PWMCYC. if
> PWMCYC is
> > +	 * 0xffffff a 100% duty cycle is not possible.
> > +	 */
> > +	if (pwm_cyc =3D=3D pwm_low && pwm_cyc =3D=3D
> FIELD_MAX(RZV2M_PWMCYC_PERIOD))
> > +		pwm_cyc -=3D 1;
>=20
> This is a common limitation. The meson driver doesn't use the max value
> for the cycle counter for this reason at all. This is more consistent
> with the usual expectations of a consumer.

OK, will drop max value check and will use the below code
For finding PWMLOW value.

	/*
	 * Formula for calculating PWMLOW register
	 * PWMLOW register =3D PWM cycle * Low pulse width ratio (%)
	 */
	pwm_low =3D dc >> (4 * prescale);
	if (!dc) /* 0% duty cycle */
		pwm_low =3D pwm_cyc + 1;
	else if (pc =3D=3D dc) /* 100% duty cycle */
		pwm_low =3D 0;
	else
		pwm_low =3D pwm_cyc - pwm_low;

>=20
> > +
> > +	/*
> > +	 * If the PWM channel is disabled, make sure to turn on the clock
> > +	 * before writing the register.
> > +	 */
> > +	if (!pwm->state.enabled) {
> > +		err =3D pm_runtime_resume_and_get(rzv2m_pwm->chip.dev);
> > +		if (err)
> > +			return err;
>=20
> You can do pm_runtime_resume_and_get unconditionally. I think this would
> simplify the code flow a bit.

OK, will do unconditional pm_runtime_get_sync()

>=20
> > +	} else {
> > +		/*
> > +		 * To change the setting value of the PWM cycle setting
> register
> > +		 * (PWMm_PWMCYC), set the PWME bit of the PWM control
> register
> > +		 * (PWMm_PWMCTR) to 0b and stop the counter operation.
> > +		 */
> > +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> 0);
> > +		rzv2m_pwm_wait_delay(rzv2m_pwm);
>=20
> Would it make sense to only stop the hardware if PWMCYC (or polarity?)
> is about to change? This way you wouldn't introduce glitches for the
> usual request to only change the duty cycle.

OK will do it.

>=20
> > +	}
> > +
> > +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMCYC, pwm_cyc);
> > +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMLOW, pwm_low);
> > +
> > +	pwm_ctr =3D FIELD_PREP(RZV2M_PWMCTR_PWMPS, prescale);
> > +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> > +		pwm_ctr |=3D RZV2M_PWMCTR_PWMHL;
> > +
> > +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMTM |
> > +			 RZV2M_PWMCTR_PWMPS | RZV2M_PWMCTR_PWMHL, pwm_ctr);
> > +
> > +	if (pwm->state.enabled)
> > +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> > +				 RZV2M_PWMCTR_PWME);
>=20
> If pwm->state.enabled, RZV2M_PWMCTR_PWME should already be set?

OK. Will update this logic. It is basically reenabling as we stopped counte=
r for
Updating PWM cycles.

>=20
> > +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> > +
> > +	/* If the PWM is not enabled, turn the clock off again to save
> power. */
> > +	if (!pwm->state.enabled)
> > +		pm_runtime_put(rzv2m_pwm->chip.dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rzv2m_pwm_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			   const struct pwm_state *state)
> > +{
> > +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> > +	bool enabled =3D pwm->state.enabled;
> > +	int ret;
> > +
> > +	if (!state->enabled) {
> > +		if (enabled)
> > +			rzv2m_pwm_disable(rzv2m_pwm);
>=20
> How does a disabled PWM behave?

PIN output goes low.

>=20
> > +		return 0;
> > +	}
> > +
> > +	ret =3D rzv2m_pwm_config(chip, pwm, state);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!enabled)
> > +		ret =3D rzv2m_pwm_enable(rzv2m_pwm);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct pwm_ops rzv2m_pwm_ops =3D {
> > +	.get_state =3D rzv2m_pwm_get_state,
> > +	.apply =3D rzv2m_pwm_apply,
> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> > +static int rzv2m_pwm_pm_runtime_suspend(struct device *dev) {
> > +	struct rzv2m_pwm_chip *rzv2m_pwm =3D dev_get_drvdata(dev);
> > +
> > +	clk_disable_unprepare(rzv2m_pwm->pwm_clk);
> > +	clk_disable_unprepare(rzv2m_pwm->apb_clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rzv2m_pwm_pm_runtime_resume(struct device *dev) {
> > +	struct rzv2m_pwm_chip *rzv2m_pwm =3D dev_get_drvdata(dev);
> > +
> > +	clk_prepare_enable(rzv2m_pwm->apb_clk);
> > +	clk_prepare_enable(rzv2m_pwm->pwm_clk);
>=20
> Missing error checking.

OK, will do.

>=20
> > +	return 0;
> > +}
> > +
> > +static DEFINE_RUNTIME_DEV_PM_OPS(rzv2m_pwm_pm_ops,
> > +				 rzv2m_pwm_pm_runtime_suspend,
> > +				 rzv2m_pwm_pm_runtime_resume, NULL);
> > +
> > +static void rzv2m_pwm_reset_assert_pm_disable(void *data) {
> > +	struct rzv2m_pwm_chip *rzv2m_pwm =3D data;
> > +
> > +	/*
> > +	 * The below check is for making balanced PM usage count in
> probe/remove
> > +	 * eg: boot loader is turning on PWM and probe increments the PM
> usage
> > +	 * count. Before apply, if there is unbind/remove callback we need
> to
> > +	 * decrement the PM usage count.
> > +	 */
> > +	clk_prepare_enable(rzv2m_pwm->apb_clk);
> > +	clk_prepare_enable(rzv2m_pwm->pwm_clk);
>=20
> What happens if enabling fails here? Maybe it would be easier and safer
> to cache the info if a channel is enabled in driver data? Then you don't
> need to enable the clks just to call rzv2m_pwm_is_ch_enabled().

Agreed.

>=20
> > +	if (rzv2m_pwm_is_ch_enabled(rzv2m_pwm))
> > +		pm_runtime_put(rzv2m_pwm->chip.dev);
> > +
> > +	clk_disable_unprepare(rzv2m_pwm->pwm_clk);
> > +	clk_disable_unprepare(rzv2m_pwm->apb_clk);
> > +
> > +	pm_runtime_disable(rzv2m_pwm->chip.dev);
> > +	pm_runtime_set_suspended(rzv2m_pwm->chip.dev);
> > +	reset_control_assert(rzv2m_pwm->rstc);
> > +}
> > +
> > +static int rzv2m_pwm_probe(struct platform_device *pdev) {
> > +	struct rzv2m_pwm_chip *rzv2m_pwm;
> > +	unsigned long apb_clk_rate;
> > +	int ret;
> > +
> > +	rzv2m_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rzv2m_pwm),
> GFP_KERNEL);
> > +	if (!rzv2m_pwm)
> > +		return -ENOMEM;
> > +
> > +	rzv2m_pwm->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(rzv2m_pwm->mmio))
> > +		return PTR_ERR(rzv2m_pwm->mmio);
> > +
> > +	rzv2m_pwm->apb_clk =3D devm_clk_get(&pdev->dev, "apb");
> > +	if (IS_ERR(rzv2m_pwm->apb_clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm-
> >apb_clk),
> > +				     "cannot get apb clock\n");
> > +
> > +	apb_clk_rate =3D clk_get_rate(rzv2m_pwm->apb_clk);
> > +	if (!apb_clk_rate)
> > +		return dev_err_probe(&pdev->dev, -EINVAL, "apb clk rate is
> 0");
> > +
> > +	rzv2m_pwm->pwm_clk =3D devm_clk_get(&pdev->dev, "pwm");
> > +	if (IS_ERR(rzv2m_pwm->pwm_clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm-
> >pwm_clk),
> > +				     "cannot get pwm clock\n");
> > +
> > +	rzv2m_pwm->rate =3D clk_get_rate(rzv2m_pwm->pwm_clk);
>=20
> The value returned by clk_get_rate() isn't reliable for a clk that
> wasn't enabled. (See also https://lore.kernel.org/linux-
> clk/20230201082309.233348-1-u.kleine-koenig@pengutronix.de
> .)

OK, will call clk_rate_exclusive_get() before calling get_rate().

>=20
> > +	if (!rzv2m_pwm->rate)
> > +		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clk rate is
> 0");
> > +
> > +	/* delay =3D 6 * PCLK + 9 * PWM_CLK */
>=20
> Here would be a nice place for the comment about synchronisation of the
> two clks.

Agreed.

>=20
> > +	rzv2m_pwm->delay =3D DIV_ROUND_UP(6 * 1000000000UL, apb_clk_rate) +
> > +		DIV_ROUND_UP(9 * 1000000000UL, rzv2m_pwm->rate);
>=20
> s/1000000000UL/NSEC_PER_SEC/

OK.=20

>=20
> On 32 bit archs, 6 * 1000000000 > MAX_ULONG resulting in a too small
> delay.

OK will do 6 * DIV_ROUND_UP(NSEC_PER_SEC, apb_clk_rate) + 9 * DIV_ROUND_UP(=
NSEC_PER_SEC, rzv2m_pwm->rate);

>=20
> > +	rzv2m_pwm->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL);
> > +	if (IS_ERR(rzv2m_pwm->rstc))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->rstc),
> > +				     "get reset failed\n");
> > +
> > +	platform_set_drvdata(pdev, rzv2m_pwm);
> > +	clk_prepare_enable(rzv2m_pwm->apb_clk);
> > +	clk_prepare_enable(rzv2m_pwm->pwm_clk);
>=20
> error checking missing.

OK will do.

Cheers,
Biju
>=20
> > +	pm_runtime_set_active(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +	ret =3D reset_control_deassert(rzv2m_pwm->rstc);
> > +	if (ret) {
> > +		dev_err_probe(&pdev->dev, ret,
> > +			      "cannot deassert reset control\n");
> > +		goto pm_clk_disable;
> > +	}
> > +
> > +	rzv2m_pwm->chip.dev =3D &pdev->dev;
> > +	/*
> > +	 *  We need to keep the clock on, in case the bootloader has
> enabled the
> > +	 *  PWM and is running during probe().
> > +	 */
> > +	if (rzv2m_pwm_is_ch_enabled(rzv2m_pwm))
> > +		pm_runtime_get_sync(&pdev->dev);
> > +
> > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > +				       rzv2m_pwm_reset_assert_pm_disable,
> > +				       rzv2m_pwm);
> > +	if (ret < 0)
> > +		goto channel_disable;
> > +
> > +	rzv2m_pwm->chip.ops =3D &rzv2m_pwm_ops;
> > +	rzv2m_pwm->chip.npwm =3D 1;
> > +	ret =3D devm_pwmchip_add(&pdev->dev, &rzv2m_pwm->chip);
> > +	if (ret) {
> > +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> > +		goto channel_disable;
> > +	}
> > +
> > +	return 0;
> > +
> > +pm_clk_disable:
> > +	pm_runtime_disable(&pdev->dev);
> > +	pm_runtime_set_suspended(&pdev->dev);
> > +channel_disable:
> > +	if (rzv2m_pwm_is_ch_enabled(rzv2m_pwm))
> > +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> 0);
> > +
> > +	clk_disable_unprepare(rzv2m_pwm->pwm_clk);
> > +	clk_disable_unprepare(rzv2m_pwm->apb_clk);
> > +	return ret;
> > +}
> > +
> > +static const struct of_device_id rzv2m_pwm_of_table[] =3D {
> > +	{ .compatible =3D "renesas,rzv2m-pwm", },
> > +	{ /* Sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, rzv2m_pwm_of_table);
> > +
> > +static struct platform_driver rzv2m_pwm_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "pwm-rzv2m",
> > +		.pm =3D pm_ptr(&rzv2m_pwm_pm_ops),
> > +		.of_match_table =3D of_match_ptr(rzv2m_pwm_of_table),
> > +	},
> > +	.probe =3D rzv2m_pwm_probe,
> > +};
> > +module_platform_driver(rzv2m_pwm_driver);
> > +
> > +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> > +MODULE_DESCRIPTION("Renesas RZ/V2M PWM Timer Driver");
> > +MODULE_LICENSE("GPL"); MODULE_ALIAS("platform:pwm-rzv2m");
> > --
> > 2.25.1
> >
> >
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 | https://www.pengutronix.de/
> |
