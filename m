Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE9869843C
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Feb 2023 20:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjBOTOV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Feb 2023 14:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBOTOU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Feb 2023 14:14:20 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2132.outbound.protection.outlook.com [40.107.113.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7703872B7;
        Wed, 15 Feb 2023 11:14:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWNTkCFbGiYRMZIVjY4n1+4lXrWKku2ceJ6T28XN5iBUfHtUOt/bKnuNvVthzqHEpNzlDYxRdvGd3bTApJ2LUwUUStUE2CqQ7IvgoGFUd+GhBmWEC3C1a7Vc7tMBUjEWKwdthxo7Xh6LdFSrfMfT8deEkusdamXd30KmkNyb3K1TKv66SMinGDtWwE2Pc3whfzG3DYVUVlwx1aQCbSt2OQajdZuB1cb2P0jpxViNR9+HdqQXw4peOWnkBjTOUYdqLin8kFq2QYNkvKXtPqnLmH+zXcMfi4GD+0/KQtRUqyUl3CcdNxuAqaK6BaJu+1BrHIYQGkLUBbMlOyyGlt70lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR8T8foH2zPrbKOmL7z3Ie+QJVydjS1Bo+EOd/g1jAw=;
 b=kC3IGRPHqgmrmiGOHNfLn4X9bQf9aOLoIrg4cJsix1/UvIfjl1QYbq1qiwExxDDzNp0Axkdq+y6M83SJdIS0NIe5LjxGEGLOgTl/hPNIqNUFL9xjbmFASPdpvECqolhKq2/U2xkIB+6Q9HbcTrK/KpY9HkfVERr2bfWRhhluVftrN8LNodv2ig4g7UzmH0OHt8IlDNzq03BxebQo+b9hp0w1rf7wBxwuVPSJp9Dn6XK+9bPuHnQ4CTmuGgyZJ/7BfrcKYkLxVtNOzjh26m3THnRl6RPxiekjMrFbIpSYnSaWjJqKqvxvycLPyUxqSxF1aj6BbbeECzb9xazhB6a3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR8T8foH2zPrbKOmL7z3Ie+QJVydjS1Bo+EOd/g1jAw=;
 b=QLIM3LuEWismd4TO4RCvAqtvaA67A1vscTYXgy1Oa78J6Q6oKSt6sVyUFWmi0Q/bmahOLOFJ2/6IGNnIjeVbmlCRNk2N8ylbw2IBmy9tIm5nhXIjFy8GmEc+EdgolIo0MM8pcv0+bHl6HCLFS+u+kpp756o2NPxkx6TjtB3uRAU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB9337.jpnprd01.prod.outlook.com (2603:1096:400:195::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 19:14:12 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 19:14:12 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lee Jones <lee@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZNyeGRDPllAbhcUe4ZTYF3l33467PwT+AgACrzUA=
Date:   Wed, 15 Feb 2023 19:14:12 +0000
Message-ID: <OS0PR01MB5922D6990B0AC75AA278FE1386A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230202165732.305650-1-biju.das.jz@bp.renesas.com>
 <20230202165732.305650-7-biju.das.jz@bp.renesas.com>
 <20230215083037.ivlmqhp4xngnexca@pengutronix.de>
In-Reply-To: <20230215083037.ivlmqhp4xngnexca@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB9337:EE_
x-ms-office365-filtering-correlation-id: 33f2b5a0-90d3-4a0b-c738-08db0f88d2a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G+dqPfMPvbEemQsayqA2x5nWuo6TaQFsQ3IcJUAM69P04Nq96IUfFdtq/6GGon2w1KKXYNQw6kzJLoaZPVtY0MbbBHxO0gXZjyqzNVq9GFM4Ps/zQEnrNwIicCISsMy0PkxVp1yztG6F/RFLYOSG/6kGYOmE5XvqbbJ/qUpPpWJgglRYr6yBkbeGbkfY3/UXp6qNzTaZdo6kOmibWYFIIrKkwZ+TvNaLhMv0bKogNf1TPvf7j6UknFfVMrdEW8G6205brBQUiR/g7mXnKr/izI1n3xPRv/A26L6OPu4BoLcfIkWNmz18c0m/P57PcN8Q4uoA229WWM5+TRx8dpneSPxgCvSt9mi1fIcuPomsvrqNu+EcbXqOTkmIYd6fhxrySqp47GTFt5rsId6N9iRuWIAWmyJ6JDFUrgQKxloDuoWLtGMmS8PvCkTrex6kmY/W2vlqbtoIVqeLlGT+9vcypDV8l2sEXlVi18/Y9cgRmFvw3sQ3W4vEK7DO8vf6Ns9GmsEJIffs2z2ApKCn3n6ZAkVQXNtwiRttyKwA5LXVUwhyIZOGqiRBuWZPV6GvdTVIoqPMDSIiIXMbSr8w3cRSf3WiraLayiAmjnhkFPF9aCI/rRSH8l2ufjUFVZ/QuvRd4wzzILFzg5i5HUBDF0pj1WZE2gMEaUgX/2vas6CuIdii2ngvlFP6OlhAPYvuPEug/DZ2FByP7o+CKfEp9xMMHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199018)(5660300002)(2906002)(71200400001)(7696005)(33656002)(86362001)(6506007)(186003)(26005)(55016003)(9686003)(478600001)(30864003)(122000001)(4326008)(8676002)(6916009)(83380400001)(41300700001)(38070700005)(66556008)(66476007)(64756008)(66446008)(76116006)(54906003)(66946007)(38100700002)(8936002)(316002)(52536014)(32563001)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AkpLT5PFpASXtqTeGmrv/hjcPznLsZUE45e7U9B2MHlxze9Zk+aHi4N1Si?=
 =?iso-8859-1?Q?rr23kG4uwBoxSI3Ky82Z0FSn2tibd4v/KGibxLua5mzl9i1iKdx9ChgcHg?=
 =?iso-8859-1?Q?8wEkE22x0KB0tjlOTiNAAoPlfxHHHo/0IhUgJztFemKsgSgJf/B4O95t2/?=
 =?iso-8859-1?Q?wmjOlB5eLoKUIBZgTxjM1yeTMfV0VToPpSGn3MajPEPl6WloLXZX8ETV6l?=
 =?iso-8859-1?Q?OWf8mZlurpnhRXtRJ7MOrltLj8sLnc9OVNxv95ohjkH2CLvAgtqtuM1H0W?=
 =?iso-8859-1?Q?i/IU4liTfWaRVFIeihPCt2Rlxtd4KqEWN0tBAIADOfJdfQYrUfDN/fs3fT?=
 =?iso-8859-1?Q?FmQrIX+gXhGlS3PTB2+i33pKDQv7ANvHBbLEWO4KwlLfnO/mr6Y/gESFLe?=
 =?iso-8859-1?Q?oraUcE8HhDsOmoX01FsLH7lPW4byPRR1yGUktal6ns2aEIcBMnpa8dH4Pe?=
 =?iso-8859-1?Q?hgGZGdgxSYch+6g1QDbTSAxukAFtDMBNS+ksYw2jX23OmNB/otPeVyg+9Q?=
 =?iso-8859-1?Q?/iwp9acZDPLNqVO5bYLoCq7QT2fLzBOKSDJS+7Ks20hPbasypRkTVMRY/B?=
 =?iso-8859-1?Q?q4YRK1jcFD5behUaKt6OAlm2k7H/sPj2Vi0YiKRjjC9wrjvyZ07B01sl1Z?=
 =?iso-8859-1?Q?OCB19zyEL1cEVnwqbEICOWK7UCy6pbVMU7ZtPeYE60dGLpxq2hWtCmdTcu?=
 =?iso-8859-1?Q?aa2XHOdFYu/V/l5NOPkjM8uQ1GULJE16gd4BenUxMLEz9wXHu6xYGoluJ9?=
 =?iso-8859-1?Q?OUWzuJrEi3iwG83bSLUn4NtqjkDbTR14+UuHsxj9QsxyNly5WU937DRL25?=
 =?iso-8859-1?Q?Ab+zTvOXSY/84c799HD9vWbZXawtbOiRUFj/CodBQMICnHtGDyRF5junOK?=
 =?iso-8859-1?Q?hWb63JHFYDhTIvtn4oSQ2AkdUfeh2LhiylvF4lZpx6yi1M/tiTthqoNhPC?=
 =?iso-8859-1?Q?XwP49neWujDSzH8VSvLm/pZgahYoXE6/IE2mAxjGDRJOJRjLoT9jO8tKQX?=
 =?iso-8859-1?Q?ylB5UKNQzkAB0OaQqdMB9QHcKzlrPcjcQOBUu+vDLWHrWEigfxOFVT5Yzp?=
 =?iso-8859-1?Q?z7Q07yzlkh/G9o6vyLkkWRjXFV4clKf483BOelVFAL4nt9dufv7v3h0wkv?=
 =?iso-8859-1?Q?NVFBHmRGUGIj7c/yAfTmQyx+3lHCtUazxgnRyv0CwSRoD4I9tf3JwJ/Ax9?=
 =?iso-8859-1?Q?nglQzc9fSlNJBTZZja6qnlLmvqvVxQ16n1FITaU3B6H51JhFPGTqR37P7s?=
 =?iso-8859-1?Q?KXHPYwhIool4eonQi3UJZsaMXGcoQ1CMztvJQUSPDs4MGnQU0ocN2mFcMP?=
 =?iso-8859-1?Q?FAuzpdER8VBMOAB7hVFxyeivZvEpja+xadsaAhpKpYMNNPN2TCj9IGd20k?=
 =?iso-8859-1?Q?xK7BGkFGMMaPaSlqKjZnECXzJgDU6AzxqLlIKaStvbUzcDUTTlzZdseaCp?=
 =?iso-8859-1?Q?Vv5jIfgwU54crAscm+YJ3aJMCEpBV5hOSSjuLNZZ6A0JMZUik1GXSPhS0y?=
 =?iso-8859-1?Q?/J0TBlXf8SRHy129BqWQ65OVYfgoBtRq9G3EzfBZqD39TxqGD9AbjaB9rt?=
 =?iso-8859-1?Q?MAO7tpTViLOiaeyJ3fQ32BRJCUu5p6wpjcUuCqWGVbTHip3oXYaaG0koIk?=
 =?iso-8859-1?Q?xKZbe3G/lMb5SW4aemIr8wKPQn5crkIZBsdKEMoKb2RXUTUlz4/GsX0g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f2b5a0-90d3-4a0b-c738-08db0f88d2a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 19:14:12.7055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c5vhIJj/55RZEdhdVXY6VrE72OxSxQ8gI6dhtfuxT4JnvzU+LKmd3bB3klvCNzFcaL1ROCuPSPEtQjnGShd2EvpPWbnVPWPNnrxuLiZ/+G8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9337
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

> Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> Hello,
>=20
> I'm working on my review backlog, sorry that it took so long.
>=20
> On Thu, Feb 02, 2023 at 04:57:32PM +0000, Biju Das wrote:
> > Add support for RZ/G2L MTU3a PWM driver. The IP supports following PWM
> > modes
> >
> > 1) PWM mode{1,2}
> > 2) Reset-synchronized PWM mode
> > 3) Complementary PWM mode{1,2,3}
>=20
> It's unclear to me what "PWM mode1" and the other modes are. I suspect th=
is
> is some chip specific naming that isn't understandable for outsiders? Wou=
ld
> be great to explain that a bit more.

Ok I will add below to Limitation sections. Is it ok?

PWM Mode 1: PWM waveforms are output from the MTIOCnA and MTIOCnC pins by
pairing TGRA with TGRB and TGRC with TGRD. The levels specified by the
TIOR.IOA[3:0] and IOC[3:0] bits are output from the MTIOCnA and MTIOCnC pin=
s
at compare matches A and C, and the level specified by the TIOR.IOB[3:0] an=
d
IOD[3:0] bits are output at compare matches B and D (n =3D 0 to 4, 6, 7).


PWM Mode 2: PWM waveform output is generated using one TGR as the cycle
register and the others as duty registers.

Reset-Synchronized PWM Mode: In the reset-synchronized PWM mode, three phas=
es
of positive and negative PWM waveforms (six phases in total) that share a
common wave transition point can be output by combining MTU3 and MTU4 and
MTU6 and MTU7.

Complementary PWM Mode: In complementary PWM mode, dead time can be set for
PWM waveforms to be output. The dead time is the period during which the up=
per
and lower arm transistors are set to the inactive level in order to prevent
short-circuiting of the arms.Six positive-phase and six negative-phase PWM
waveforms (12 phases in total)with dead time can be output by combining
MTU3/ MTU4 and MTU6/MTU7.

In complementary PWM mode, nine registers (compare registers, buffer regist=
ers,
and temporary registers) are used to control the duty ratio for the PWM out=
put.
Complementary PWM mode 1 (transfer at crest)
Complementary PWM mode 2 (transfer at trough)
Complementary PWM mode 3 (transfer at crest and trough)




>=20
> > This patch adds basic pwm mode 1 support for RZ/G2L MTU3a pwm driver
> > by creating separate logical channels for each IOs.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v11->v12:
> >  * Updated header file to <linux/mfd/rz-mtu3.h> as core driver is in MF=
D.
> >  * Reordered get_state()
> > v10->v11:
> >  * No change.
> > v9->v10:
> >  * No change.
> > v8->v9:
> >  * Added prescale/duty_cycle variables to struct rz_mtu3_pwm_chip and
> >    cached this values in rz_mtu3_pwm_config and used this cached values
> >    in get_state(), if PWM is disabled.
> >  * Added return code for get_state()
> > v7->v8:
> >  * Simplified rz_mtu3_pwm_request by calling rz_mtu3_request_channel()
> >  * Simplified rz_mtu3_pwm_free by calling rz_mtu3_release_channel()
> > v6->v7:
> >  * Added channel specific mutex lock to avoid race between counter
> >    device and rz_mtu3_pwm_{request,free}
> >  * Added pm_runtime_resume_and_get in rz_mtu3_pwm_enable()
> >  * Added pm_runtime_put_sync in rz_mtu3_pwm_disable()
> >  * Updated rz_mtu3_pwm_config()
> >  * Updated rz_mtu3_pwm_apply()
> > v5->v6:
> >  * Updated commit and Kconfig description
> >  * Sorted the header
> >  * Replaced dev_get_drvdata from rz_mtu3_pwm_pm_disable()
> >  * Replaced SET_RUNTIME_PM_OPS->DEFINE_RUNTIME_DEV_PM_OPS and removed
> >    __maybe_unused from suspend/resume()
> > v4->v5:
> >  * pwm device is instantiated by mtu3a core driver.
> > v3->v4:
> >  * There is no resource associated with "rz-mtu3-pwm" compatible
> >    and moved the code to mfd subsystem as it binds against "rz-mtu".
> >  * Removed struct platform_driver rz_mtu3_pwm_driver.
> > v2->v3:
> >  * No change.
> > v1->v2:
> >  * Modelled as a single PWM device handling multiple channles.
> >  * Used PM framework to manage the clocks.
> > ---
> >  drivers/pwm/Kconfig       |  11 +
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-rz-mtu3.c | 485
> > ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 497 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-rz-mtu3.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > 31cdc9dae3c5..c54cbeabe093 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -492,6 +492,17 @@ config PWM_ROCKCHIP
> >  	  Generic PWM framework driver for the PWM controller found on
> >  	  Rockchip SoCs.
> >
> > +config PWM_RZ_MTU3
> > +	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> > +	depends on RZ_MTU3 || COMPILE_TEST
> > +	depends on HAS_IOMEM
> > +	help
> > +	  This driver exposes the MTU3a PWM Timer controller found in Renesas
> > +	  RZ/G2L like chips through the PWM API.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-rz-mtu3.
> > +
> >  config PWM_SAMSUNG
> >  	tristate "Samsung PWM support"
> >  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS ||
> > COMPILE_TEST diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index a95aabae9115..6b75c0145336 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -45,6 +45,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_RZV2M)		+=3D pwm-rzv2m.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > +obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
> >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> >  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> > diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c new
> > file mode 100644 index 000000000000..d94e3fc36dfb
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rz-mtu3.c
> > @@ -0,0 +1,485 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L MTU3a PWM Timer driver
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corporation
> > + *
> > + * Hardware manual for this IP can be found here
> > + *
> > +https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-u
> > +sers-manual-hardware-0?language=3Den
> > + *
> > + * Limitations:
> > + * - When PWM is disabled, the output is driven to Hi-Z.
> > + * - While the hardware supports both polarities, the driver (for now)
> > + *   only handles normal polarity.
> > + * - While the hardware supports pwm mode{1,2}, reset-synchronized pwm
> and
> > + *   complementary pwm modes, the driver (for now) only handles pwm
> mode1.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/limits.h>
> > +#include <linux/mfd/rz-mtu3.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/pwm.h>
> > +#include <linux/time.h>
> > +
> > +#define RZ_MTU3_TMDR1_MD_NORMAL		(0)
> > +#define RZ_MTU3_TMDR1_MD_PWM_MODE_1	(2)
>=20
> IMHO it would make sense to put these definitions to where RZ_MTU3_TMDR1 =
is
> defined. And I'd do it like this:
>=20
> 	* Timer mode register 1 */
> 	#define RZ_MTU3_TMDR1			5
> 	#define RZ_MTU3_TMDR1_MD			GENMASK(3, 0)
> 	#define RZ_MTU3_TMDR1_MD_NORMAL
> 	FIELD_PREP(RZ_MTU3_TMDR1_MD, 0)
> 	#define RZ_MTU3_TMDR1_MD_PWMMODE1
> 	FIELD_PREP(RZ_MTU3_TMDR1_MD, 2)

Agreed, will move to include/linux/mfd/rz-mtu3.h.

>=20
> > +#define RZ_MTU3_TIOR_OC_RETAIN		(0)
> > +#define RZ_MTU3_TIOR_OC_0_H_COMP_MATCH	(2)
> > +#define RZ_MTU3_TIOR_OC_1_TOGGLE	(7)
> > +#define RZ_MTU3_TIOR_OC_IOA		GENMASK(3, 0)
> > +
> > +#define RZ_MTU3_TCR_CCLR_TGRC		(5 << 5)
> > +#define RZ_MTU3_TCR_CKEG_RISING		(0 << 3)
> > +
> > +#define RZ_MTU3_TCR_TPCS		GENMASK(2, 0)
> > +
> > +#define RZ_MTU3_MAX_PWM_MODE1_CHANNELS	(12)
> > +
> > +#define RZ_MTU3_MAX_HW_PWM_CHANNELS	(7)
> > +
> > +static const u8 rz_mtu3_pwm_mode1_num_ios[] =3D { 2, 1, 1, 2, 2, 2, 2
> > +};
> > +
> > +/**
> > + * struct rz_mtu3_pwm_chip - MTU3 pwm private data
> > + *
> > + * @chip: MTU3 pwm chip data
> > + * @clk: MTU3 module clock
> > + * @lock: Lock to prevent concurrent access for usage count
> > + * @rate: MTU3 clock rate
> > + * @user_count: MTU3 usage count
> > + * @rz_mtu3_channel: HW channels for the PWM  */
> > +
> > +struct rz_mtu3_pwm_chip {
> > +	struct pwm_chip chip;
> > +	struct clk *clk;
> > +	struct mutex lock;
> > +	unsigned long rate;
> > +	u32 user_count[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> > +	struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> > +
> > +	/*
> > +	 * The driver cannot read the current duty cycle/prescale from the
> > +	 * hardware if the hardware is disabled. Cache the last programmed
> > +	 * duty cycle/prescale value to return in that case.
>=20
> If the hardware is disabled, just doing .enabled =3D false in .get_state =
is
> fine and easier. So this can be dropped I think.

Yes, it can be dropped, after adding below check in get_state()

+       if (state->duty_cycle > state->period)
+               state->duty_cycle =3D state->period;
+

>=20
> > +	 */
> > +	u8 prescale[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> > +	unsigned int duty_cycle[RZ_MTU3_MAX_PWM_MODE1_CHANNELS];
> > +};
> > +
> > +static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct
> > +pwm_chip *chip) {
> > +	return container_of(chip, struct rz_mtu3_pwm_chip, chip); }
> > +
> > +static u8 rz_mtu3_pwm_calculate_prescale(struct rz_mtu3_pwm_chip
> *rz_mtu3,
> > +					 u64 period_cycles)
> > +{
> > +	u32 prescaled_period_cycles;
> > +	u8 prescale;
> > +
> > +	prescaled_period_cycles =3D period_cycles >> 16;
> > +	if (prescaled_period_cycles >=3D 16)
> > +		prescale =3D 3;
> > +	else
> > +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> > +
> > +	return prescale;
> > +}
> > +
> > +static struct rz_mtu3_channel *
> > +rz_mtu3_get_hw_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32
> > +channel) {
> > +	unsigned int i, ch_index =3D 0;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_pwm_mode1_num_ios); i++) {
> > +		ch_index +=3D rz_mtu3_pwm_mode1_num_ios[i];
> > +
> > +		if (ch_index > channel)
> > +			break;
> > +	}
> > +
> > +	return rz_mtu3_pwm->ch[i];
> > +}
> > +
> > +static u32 rz_mtu3_get_hw_channel_index(struct rz_mtu3_pwm_chip
> *rz_mtu3_pwm,
> > +					struct rz_mtu3_channel *ch)
> > +{
> > +	u32 i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_pwm_mode1_num_ios); i++) {
> > +		if (ch =3D=3D rz_mtu3_pwm->ch[i])
> > +			break;
> > +	}
> > +
> > +	return i;
> > +}
> > +
> > +static bool rz_mtu3_pwm_is_second_channel(u32 ch_index, u32 hwpwm) {
> > +	u32 i, pwm_ch_index =3D 0;
> > +
> > +	for (i =3D 0; i < ch_index; i++)
> > +		pwm_ch_index +=3D rz_mtu3_pwm_mode1_num_ios[i];
> > +
> > +	return pwm_ch_index !=3D hwpwm;
> > +}
>=20
> I don't understand that channel allocation, maybe worth an explaining
> comment?!

I will add below comment just above rz_mtu3_get_hw_channel(). Is it ok?

+/*
+ * PWM Mode1 has MTU{0..4}, MTU6 and MTU7, Probe function skips MTU5 and M=
TU8.
+ * So struct rz_mtu3_channel *ch contains only PWM mode1 MTU channels.
+ * MTU{1, 2} channels has a single IO each compared to 2 IOs for the rest =
of the
+ * channels. A LUT rz_mtu3_pwm_mode1_num_ios introduced to get the PWM cha=
nnel
+ * and HW channel.
+ */

>=20
> > +static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip
> *rz_mtu3_pwm,
> > +				      u32 hwpwm)
> > +{
> > +	struct rz_mtu3_channel *ch;
> > +	bool is_channel_en;
> > +	u32 ch_index;
> > +	u8 val;
> > +
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > +	is_channel_en =3D rz_mtu3_is_enabled(ch);
> > +
> > +	if (rz_mtu3_pwm_is_second_channel(ch_index, hwpwm))
> > +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORL);
> > +	else
> > +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORH);
> > +
> > +	return (is_channel_en && (val & RZ_MTU3_TIOR_OC_IOA)); }
> > +
> > +static int rz_mtu3_pwm_request(struct pwm_chip *chip, struct
> > +pwm_device *pwm) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > +	struct rz_mtu3_channel *ch;
> > +	u32 ch_index;
> > +
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > +	if (!rz_mtu3_pwm->user_count[ch_index] &&
> !rz_mtu3_request_channel(ch))
> > +		return -EBUSY;
> > +
> > +	mutex_lock(&rz_mtu3_pwm->lock);
> > +	rz_mtu3_pwm->user_count[ch_index]++;
> > +	mutex_unlock(&rz_mtu3_pwm->lock);
>=20
> The lock must protect the check, too, otherwise that's racy.

Agreed, will move lock above 'ch' assignment.

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static void rz_mtu3_pwm_free(struct pwm_chip *chip, struct pwm_device
> > +*pwm) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > +	struct rz_mtu3_channel *ch;
> > +	u32 ch_index;
> > +
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > +
> > +	mutex_lock(&rz_mtu3_pwm->lock);
> > +	rz_mtu3_pwm->user_count[ch_index]--;
> > +	mutex_unlock(&rz_mtu3_pwm->lock);
> > +
> > +	if (!rz_mtu3_pwm->user_count[ch_index])
> > +		rz_mtu3_release_channel(ch);
>=20
> I didn't check what rz_mtu3_release_channel() does, but I wonder what
> happens if another thread calls rz_mtu3_pwm_request for the same channel
> just after the if check.

Agreed, will protect the entire section of this code.

>=20
> > +}
> > +
> > +static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> > +			      struct pwm_device *pwm)
> > +{
> > +	struct rz_mtu3_channel *ch;
> > +	u32 ch_index;
> > +	u8 val;
> > +	int rc;
> > +
> > +	rc =3D pm_runtime_resume_and_get(rz_mtu3_pwm->chip.dev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > +	val =3D (RZ_MTU3_TIOR_OC_1_TOGGLE << 4) |
> > +RZ_MTU3_TIOR_OC_0_H_COMP_MATCH;
> > +
> > +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_MD_PWM_MODE_1)=
;
> > +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm))
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORL, val);
> > +	else
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORH, val);
> > +
> > +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> > +		rz_mtu3_enable(ch);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> > +				struct pwm_device *pwm)
> > +{
> > +	struct rz_mtu3_channel *ch;
> > +	u32 ch_index;
> > +
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > +
> > +	/* Return to normal mode and disable output pins of MTU3 channel */
> > +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1,
> RZ_MTU3_TMDR1_MD_NORMAL);
> > +
> > +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm))
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORL,
> RZ_MTU3_TIOR_OC_RETAIN);
> > +	else
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORH,
> RZ_MTU3_TIOR_OC_RETAIN);
> > +
> > +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> > +		rz_mtu3_disable(ch);
> > +
> > +	pm_runtime_put_sync(rz_mtu3_pwm->chip.dev);
> > +}
> > +
> > +static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_dev=
ice
> *pwm,
> > +				 struct pwm_state *state)
> > +{
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > +	struct rz_mtu3_channel *ch;
> > +	u8 prescale, val;
> > +	u32 ch_index;
> > +	u16 dc, pv;
> > +	u64 tmp;
> > +
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > +	pm_runtime_get_sync(chip->dev);
> > +	state->enabled =3D rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, pwm->hwpwm)=
;
> > +	if (state->enabled) {
> > +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TCR);
> > +		prescale =3D FIELD_GET(RZ_MTU3_TCR_TPCS, val);
> > +
> > +		if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
> > +			dc =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRD);
> > +			pv =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRC);
> > +		} else {
> > +			dc =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRB);
> > +			pv =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRA);
> > +		}
> > +
> Add a comment like:
>=20
> 	/* With prescale <=3D 7 and pv <=3D 0xffff this doesn't overflow. */
>

Agreed.

> > +		tmp =3D NSEC_PER_SEC * (u64)pv << (2 * prescale);
> > +		state->period =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
> > +	} else {
> > +		/* If the PWM is disabled, use the cached value. */
> > +		prescale =3D rz_mtu3_pwm->prescale[ch_index];
> > +		dc =3D rz_mtu3_pwm->duty_cycle[pwm->hwpwm];
> > +	}
> > +
> > +	tmp =3D NSEC_PER_SEC * (u64)dc << (2 * prescale);
> > +	state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
> > +	state->polarity =3D PWM_POLARITY_NORMAL;
> > +	pm_runtime_put(chip->dev);
>=20
> Can it happen that dc > pv? I assume this implements a 100% relative duty
> then. Please set .duty_cycle =3D .period in this case.

OK, will add this check.

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			      const struct pwm_state *state) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > +	struct rz_mtu3_channel *ch;
> > +	unsigned long pv, dc;
> > +	u64 period_cycles;
> > +	u64 duty_cycles;
> > +	u32 ch_index;
> > +	u8 prescale;
> > +	int err;
> > +	u8 val;
> > +
> > +	/*
> > +	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> > +	 * calculation.
> > +	 */
> > +	if (rz_mtu3_pwm->rate > NSEC_PER_SEC)
> > +		return -EINVAL;
>=20
> Maybe refuse this case in .probe() already?

OK, will move to probe()

+       /*
+        * Refuse clk rates > 1 GHz to prevent overflow later for computing
+        * period and duty cycle.
+        */


>=20
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > +	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
> > +					NSEC_PER_SEC);
> > +	prescale =3D rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm,
> > +period_cycles);
> > +
> > +	if (period_cycles >> (2 * prescale) <=3D U16_MAX)
> > +		pv =3D period_cycles >> (2 * prescale);
> > +	else
> > +		pv =3D U16_MAX;
> > +
> > +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rz_mtu3_pwm->rate,
> > +				      NSEC_PER_SEC);
> > +	if (duty_cycles >> (2 * prescale) <=3D U16_MAX)
> > +		dc =3D duty_cycles >> (2 * prescale);
> > +	else
> > +		dc =3D U16_MAX;
> > +
> > +	/*
> > +	 * Store the duty cycle/prescale for future reference in cases where
> the
> > +	 * corresponding registers can't be read (i.e. when the PWM is
> disabled).
> > +	 */
> > +	rz_mtu3_pwm->prescale[ch_index] =3D prescale;
> > +	rz_mtu3_pwm->duty_cycle[pwm->hwpwm] =3D dc;
>=20
> Above I suggested to drop this, but if you don't: This is broken.
> rz_mtu3_pwm_config is only ever called with .enable =3D 1 and the values =
are
> not updated when .apply() is called with .enable =3D 0, so you're investi=
ng
> some effort to report an outdated value that is ignored in the end.

OK will drop this.

>=20
> > +	/*
> > +	 * If the PWM channel is disabled, make sure to turn on the clock
> > +	 * before writing the register.
> > +	 */
> > +	if (!pwm->state.enabled) {
> > +		err =3D pm_runtime_resume_and_get(chip->dev);
> > +		if (err)
> > +			return err;
> > +	}
>=20
> Maybe it's easier to call pm_runtime_resume_and_get() unconditionally?

OK, will use below unconditional call instead. Is it ok?

pm_runtime_get_sync(chip->dev);

>=20
> > +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> > +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> > +				      RZ_MTU3_TCR_CCLR_TGRC | val);
> > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRD, dc);
> > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRC, pv);
> > +	} else {
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> > +				      RZ_MTU3_TCR_CCLR_TGRA | val);
> > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRB, dc);
> > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, pv);
> > +	}
> > +
> > +	/* If the PWM is not enabled, turn the clock off again to save power.
> */
> > +	if (!pwm->state.enabled)
> > +		pm_runtime_put(chip->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_pwm_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			     const struct pwm_state *state) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > +	bool enabled =3D pwm->state.enabled;
> > +	int ret;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	if (!state->enabled) {
> > +		if (enabled)
> > +			rz_mtu3_pwm_disable(rz_mtu3_pwm, pwm);
> > +
> > +		return 0;
> > +	}
> > +
> > +	ret =3D rz_mtu3_pwm_config(chip, pwm, state);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!enabled)
> > +		ret =3D rz_mtu3_pwm_enable(rz_mtu3_pwm, pwm);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct pwm_ops rz_mtu3_pwm_ops =3D {
> > +	.request =3D rz_mtu3_pwm_request,
> > +	.free =3D rz_mtu3_pwm_free,
> > +	.get_state =3D rz_mtu3_pwm_get_state,
> > +	.apply =3D rz_mtu3_pwm_apply,
> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> > +static int rz_mtu3_pwm_pm_runtime_suspend(struct device *dev) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D dev_get_drvdata(dev);
> > +
> > +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_pwm_pm_runtime_resume(struct device *dev) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D dev_get_drvdata(dev);
> > +
> > +	clk_prepare_enable(rz_mtu3_pwm->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_pwm_pm_ops,
> > +				 rz_mtu3_pwm_pm_runtime_suspend,
> > +				 rz_mtu3_pwm_pm_runtime_resume, NULL);
> > +
> > +static void rz_mtu3_pwm_pm_disable(void *data) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D data;
> > +
> > +	pm_runtime_disable(rz_mtu3_pwm->chip.dev);
> > +	pm_runtime_set_suspended(rz_mtu3_pwm->chip.dev);
> > +}
> > +
> > +static int rz_mtu3_pwm_probe(struct platform_device *pdev) {
> > +	struct rz_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
> > +	struct device *dev =3D &pdev->dev;
> > +	int num_pwm_hw_ch =3D 0;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	rz_mtu3_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm),
> GFP_KERNEL);
> > +	if (!rz_mtu3_pwm)
> > +		return -ENOMEM;
> > +
> > +	rz_mtu3_pwm->clk =3D ddata->clk;
> > +	rz_mtu3_pwm->rate =3D clk_get_rate(rz_mtu3_pwm->clk);
>=20
> Note that clk_get_rate isn't reliable for disabled clocks, so please enab=
le
> first and then call clk_get_rate(). Also consider calling
> clk_rate_exclusive_get().


OK, will call get_rate() after enable. Runtime PM use clockenable/disable
Frequently, so unnecessary to use clk_rate_exclusive_{get,put}. Is it ok?

>=20
> > +	for (i =3D 0; i < RZ_MTU_NUM_CHANNELS; i++) {
> > +		if (i =3D=3D RZ_MTU5 || i =3D=3D RZ_MTU8)
> > +			continue;
> > +
> > +		rz_mtu3_pwm->ch[num_pwm_hw_ch] =3D &ddata->channels[i];
> > +		rz_mtu3_pwm->ch[num_pwm_hw_ch]->dev =3D dev;
> > +		num_pwm_hw_ch++;
> > +	}
> > +
> > +	mutex_init(&rz_mtu3_pwm->lock);
> > +	platform_set_drvdata(pdev, rz_mtu3_pwm);
>=20
> This is unused.

Nope. It used in runtime PM calls.

>=20
> > +	clk_prepare_enable(rz_mtu3_pwm->clk);
>=20
> Missing error checking.

OK, will add error check.

>=20
> > +	pm_runtime_set_active(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > +				       rz_mtu3_pwm_pm_disable,
> > +				       rz_mtu3_pwm);
> > +	if (ret < 0)
> > +		goto disable_clock;
> > +
> > +	rz_mtu3_pwm->chip.dev =3D &pdev->dev;
> > +	rz_mtu3_pwm->chip.ops =3D &rz_mtu3_pwm_ops;
> > +	rz_mtu3_pwm->chip.npwm =3D RZ_MTU3_MAX_PWM_MODE1_CHANNELS;
> > +	ret =3D devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
> > +	if (ret) {
> > +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> > +		goto disable_clock;
> > +	}
> > +
> > +	return 0;
> > +
> > +disable_clock:
> > +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> > +	return ret;
> > +}
>=20
> On .remove the clk isn't disabled.

It is not required. It is already disabled after probe.

Clock_enable_prepare  enables the clk during probe, Then later
PM runtime suspend turns off the clock using clk_prepare_disable().

On error case, in probe, PM suspend won't get called, So we need to use
clk_prepare_disable().

After probe:
[   15.680492] rzg2l-cpg 11010000.clock-controller: CLK_ON 1336/mtu_x_mck O=
N
[   15.725015] rzg2l-cpg 11010000.clock-controller: CLK_ON 1336/mtu_x_mck O=
FF
devmem2 0x11010538 | grep Read

Unbind and bind call reports, balanced clk usage.

Please correct me, if I am wrong or need any clarification.

Cheers,
Biju

