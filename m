Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B92662236
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Jan 2023 10:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjAIJ4F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Jan 2023 04:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjAIJzU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Jan 2023 04:55:20 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2134.outbound.protection.outlook.com [40.107.114.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254EE65FC;
        Mon,  9 Jan 2023 01:53:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm2ziU7h5Gtr6CGdnZcoSbXPv0VOWvoTTnzWRgXGixxnJBvA3pKaFHq/Z0xfkRtmDfNDXVyb2HaBDnKy1IWKTkcEkKb3ccBJgEo9iFo0IWsEkR6VE6ihztIR+XqXYCWjhs4P3NMjqwU0wRJ1sP7PAEX0zg04Nl/a6JsA0muM8dO+u31orOSYBrrmtpSEiGOgp2eN+Yzcz0B9cMUANs8Xo1BTu8zpq7DH9dnLdJx6n2xpqLBD4tpbN9qmAPGSXHmE1a3S66memUrAHRXw0ATwFrYUZe2F08jCCyPu/JGAVMcuX6/tocpAgMzBTTUO8R51tD8G26ZsXpUMzU9yzGygiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9tNib6XxRPPGhNrpAYknA/tkHpEpe9zKtg/cqt4i+g=;
 b=fDfBBlHxx3o6RTCqhN+7hnS32zMdMSThfG1SdKTdLuldEWyFU+iAelFzk+QTDo265yY+jI+dSBYhz+NkkEirHppXI1mIRUuc2I5d9E6bc2koUrlIYmCmf39GuwZyOIZGyOLlChCCOK/t4/xugwpLsXDwo+DAEZrkKl92S5dzFEbferq3eyP2ao+FrGfloWqY/41LZHz2OjXs6bRsS8a4MGu71qxvyYkJmWI5S0UxiZHdfK/Q87lrQRxfEJANzAkwtUz9dPsgK/J/Hm4PUbBG2JH0asb+2/c8heDc7SH/iagqshcPyUo1V4cHU+tWFgtkU/jLe4p/7TIITMLXqU0NpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9tNib6XxRPPGhNrpAYknA/tkHpEpe9zKtg/cqt4i+g=;
 b=Ozd6S9lTmpFjLYFzLzn4AU/DQWjnpYwfauUP011Gl23Ra4IJJNNwGocJagKNsT9jh1KBxMTE6fztZGC3KBpKP1KdsOaRZW+MXtt2RMtkfFTBFuKX8O2k8qFSn4XCBvpjInJ7XVKeTTN0Xd1SdLo7f4vARDwrVO02nCP6ldpvllw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9923.jpnprd01.prod.outlook.com (2603:1096:400:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 09:53:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%3]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 09:53:50 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v10 5/5] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v10 5/5] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZEZAWHgKK+Ach+EizmtVNnlfIVq6V/R5w
Date:   Mon, 9 Jan 2023 09:53:50 +0000
Message-ID: <OS0PR01MB5922DD9B95069953DA3C79B986FE9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221216205028.340795-1-biju.das.jz@bp.renesas.com>
 <20221216205028.340795-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221216205028.340795-6-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9923:EE_
x-ms-office365-filtering-correlation-id: 7299b474-67ce-4ea8-a9cb-08daf2276901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jnESRXxnM7egAWAFEejU7GXDGHrNn25ceqviAXZ9Iq3LfmuqBKHIb8I6MNdv0xE+HLkmd412jHYYhAms7BD/DkSjvXcG5iRkEermZEQqDQt3Q7THI/BrgUOB9BwbnanexdG3oDzdRpph2oPNtMW/3xjf6VGktEr2G1wjAA05CrY83C0zMvwOtMsRQrvMUfcyxdeMXX7ndb5wUA9DadGw75vZISlxLvhlPlqpdOWDV69pzU1u/o4kfbGrd//3X0hHS6zH2kFLM0jCOK8gIeaHearufOdvitfylMxBEY0advYQG0ePOeIt6+2ESAVkzCXCzv3A2zPlecEzuJ5S2dkI3eXVt+Wcllh+yV8HlzuyOO0BN88jSE+SzO4aVGE0bztFSMmh4u0rOK+F3RghybxwlGEH9Ve/OHrFfmFhNZOEVMEP38iD1G8rEb5ushNvSdLWK51tEfKxhzWC7886r88ZoacYDFK64dSaKg3+R0p6vm+IkHYWl+U1T0vHCMePhSBgR8SMNOc1/LVIATloivXDmiSinBlR1L7v5u79mfOu3NbAXpkRT8X9RHZcuy/QAjLKzytnZMLh7TbnH/OLQeqZSiaL/VOFDHSNpuquvsWkBica1XJJ2wPYr8G2/JeVl8GPQf2BGHIdVbkWXnVO+97Sq8h+buDFfZI8mGWC0gL1uDVBenRKZFaawRIzAxpGArUjumE2HpgZmdMPud20YyH20Klv5A9V+b3oqeHOYFkmRo3KFehr1V1mGUrIJgplqulB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199015)(52536014)(2906002)(8936002)(5660300002)(30864003)(66556008)(41300700001)(66574015)(8676002)(66946007)(66446008)(66476007)(76116006)(64756008)(316002)(71200400001)(7696005)(110136005)(54906003)(4326008)(33656002)(53546011)(26005)(478600001)(6506007)(9686003)(186003)(55016003)(86362001)(83380400001)(38070700005)(122000001)(38100700002)(32563001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3s/AMKAXL7nyBHghbkYhiUS5f+Q2XqHQss/zXm/8C3q2mm1boJayYngrAY?=
 =?iso-8859-1?Q?BeYQQY3rXB+3VTrSwTh4e3JiUd88OZgfdr+lOfP8+U/N23VrsrSoWTMmol?=
 =?iso-8859-1?Q?2y1uwREVhC3bxEtHYveYz2gy2jrqPRzFl9qpUqtbBhUBX+v8zL+mjFAMH/?=
 =?iso-8859-1?Q?R7e92vxKEkfdy5ql+p9ZmLap+b6m6g9wI/ny0yIHWHkTFvvyQQdxQ1Rkcn?=
 =?iso-8859-1?Q?ZhIokp2/oqtFOHOpPK3UuTldasn7MUQyjP/QFkOJHeiE1N1j9a2A6PgP9N?=
 =?iso-8859-1?Q?fflBBE+kQRKLU6WTMy3bjwukMEr2eMw879V0NROLDMdpJujh+3IjVcNJgL?=
 =?iso-8859-1?Q?kSL2hkV+vjvHTiZOPk0J5iiKqaaxKZ1NMJlQf/mfyar8Cgx9RLvHExc36Y?=
 =?iso-8859-1?Q?B54ISEaL77fbtGL/QaBJvxmxWIJfo0ihLNT8jRoQy4dtGZ+MzdfeMLOmmN?=
 =?iso-8859-1?Q?Re/vJ9H1Ng3BI67LQiVnj3h+ON4uOw+HAbWKQXn1JjnJbw9w9tEReCdA6v?=
 =?iso-8859-1?Q?cP2qCTN+VsFHoQ4hf2OaWWL2/bqaGhDeus9Kl1hWmuUGkKZL7vMn68HIlJ?=
 =?iso-8859-1?Q?n1c4eJ134/UIhNVHzI1dbDVdf3ICDr8fBki2vPz063HzfzNw0iUbQyyohT?=
 =?iso-8859-1?Q?3BNc7vusuSWi1wSKHRk5hX1pjqZP0T5W3991T2Jx8YCVuGiQbyDpv2AP8r?=
 =?iso-8859-1?Q?O8cNx3lT7fxJYq2ju7v+drYOyNlj4Xb07rGtlZU60zXfswQJlB7LF+kcUl?=
 =?iso-8859-1?Q?FvUtv+9KdSgtKWhxYWWjRmttlTW1I2GfcmPjP/ggihlHU3vjJk27uqE5nI?=
 =?iso-8859-1?Q?L8NfkpBojwhSWkK5MpUx+yxisD0esM2riv9lDa358CdTaSZ4Va3zrxbr31?=
 =?iso-8859-1?Q?RTgRnG/DiNkza2yE84ckxj2VZKeYZwTnAeZLTJNgGLu6KZ8JAsXJou2P4p?=
 =?iso-8859-1?Q?Tvz+GmgGX4TmY8BWu6369G2waCfje0PNHss5xx/ALjYTfSURmmHZiiCsY+?=
 =?iso-8859-1?Q?qY3aoXFxR6xOF0DWZtLmWTci1nGLrVNb2mTwHUh7s3gSEeIG378shF9VrU?=
 =?iso-8859-1?Q?ji8APimEEMNRQY4o4G/7QJGQ5fO9hZiHmJBo717FeG6AeMt3jP2OhfT2bd?=
 =?iso-8859-1?Q?HJgAQP14wRtwjeYe+LrZ8SJPdOWdhM6r+EqCphHlPB6qqBamZ5pgkqq+oe?=
 =?iso-8859-1?Q?UupeHvuAcBfebqLGfU6L7EQFb+k/LE44y1BSLwgwnsmoDi3z4ZOt+qc90x?=
 =?iso-8859-1?Q?eK6s8oAzvRZKfpl4DOoyKyJNHY2qo56n9HTVf4O35WmKlhwWTn/gIDgg3h?=
 =?iso-8859-1?Q?+3Gozzi8qvoxae995BG2KB+mufLX/zkvqCuLQ0M77EFfflKt0Py57LFjEQ?=
 =?iso-8859-1?Q?0Tv+KGT1eBLI3/rnLMs/yYXIUjuCwqrmAlV8CMKE1g3tGOcNEXRmWk6Fqt?=
 =?iso-8859-1?Q?DV4sBCNT5XWNjeXfqk0AeosjEyayn2LWLhmw5lXkb6uiIOwV/aVnsiuu7k?=
 =?iso-8859-1?Q?AzJYBRTKm7wjoVJ+mo86uJNXNYfFQMbeSzOzwu+8kWWoNlaePlQeSO8nkn?=
 =?iso-8859-1?Q?QS23f/zB/pNCCU4nXaYahKdhIi3530jP+VKftFbuhQmGQ3mepsWncoSurq?=
 =?iso-8859-1?Q?NkLKhbN9x2ewOpC0lB0C0KNXH56nDRqf6ww1ryWRmiYhXOexRt0OC2fw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7299b474-67ce-4ea8-a9cb-08daf2276901
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 09:53:50.4647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCHYsPtXaB8HgdvNbzQ/Dmbd+I+fHFhf8CVgFOHTF+ngr808JDwSr5BsIQ5DogYPyWlMPokbO6SUGys37IGAtaJ/4EV/HlHrl/jHMxOGgdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9923
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry, Uwe, Geert and PWM folks,

Gentle ping for review.=20

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 16 December 2022 20:50
> To: Thierry Reding <thierry.reding@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>; linux-pwm@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>; Chris Paterson <Chris.Paterson2@renesas.com>;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; linux-
> renesas-soc@vger.kernel.org
> Subject: [PATCH v10 5/5] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> Add support for RZ/G2L MTU3a PWM driver. The IP supports following PWM mo=
des
>=20
> 1) PWM mode{1,2}
> 2) Reset-synchronized PWM mode
> 3) Complementary PWM mode{1,2,3}
>=20
> This patch adds basic pwm mode 1 support for RZ/G2L MTU3a pwm driver by
> creating separate logical channels for each IOs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v9->v10:
>  * No change.
> v8->v9:
>  * Added prescale/duty_cycle variables to struct rz_mtu3_pwm_chip and
>    cached this values in rz_mtu3_pwm_config and used this cached values
>    in get_state(), if PWM is disabled.
>  * Added return code for get_state()
> v7->v8:
>  * Simplified rz_mtu3_pwm_request by calling rz_mtu3_request_channel()
>  * Simplified rz_mtu3_pwm_free by calling rz_mtu3_release_channel()
> v6->v7:
>  * Added channel specific mutex lock to avoid race between counter
>    device and rz_mtu3_pwm_{request,free}
>  * Added pm_runtime_resume_and_get in rz_mtu3_pwm_enable()
>  * Added pm_runtime_put_sync in rz_mtu3_pwm_disable()
>  * Updated rz_mtu3_pwm_config()
>  * Updated rz_mtu3_pwm_apply()
> v5->v6:
>  * Updated commit and Kconfig description
>  * Sorted the header
>  * Replaced dev_get_drvdata from rz_mtu3_pwm_pm_disable()
>  * Replaced SET_RUNTIME_PM_OPS->DEFINE_RUNTIME_DEV_PM_OPS and removed
>    __maybe_unused from suspend/resume()
> v4->v5:
>  * pwm device is instantiated by mtu3a core driver.
> v3->v4:
>  * There is no resource associated with "rz-mtu3-pwm" compatible
>    and moved the code to mfd subsystem as it binds against "rz-mtu".
>  * Removed struct platform_driver rz_mtu3_pwm_driver.
> v2->v3:
>  * No change.
> v1->v2:
>  * Modelled as a single PWM device handling multiple channles.
>  * Used PM framework to manage the clocks.
> ---
>  drivers/pwm/Kconfig       |  11 +
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-rz-mtu3.c | 486 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 498 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rz-mtu3.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> dae023d783a2..ccc0299fd0dd 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -481,6 +481,17 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
>=20
> +config PWM_RZ_MTU3
> +	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> +	depends on RZ_MTU3 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the MTU3a PWM Timer controller found in Renesas
> +	  RZ/G2L like chips through the PWM API.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-rz-mtu3.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> 7bf1a29f02b8..b85fc9fba326 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-
> poe.o
>  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c new fi=
le
> mode 100644 index 000000000000..fddff20c98a7
> --- /dev/null
> +++ b/drivers/pwm/pwm-rz-mtu3.c
> @@ -0,0 +1,486 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L MTU3a PWM Timer driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + *
> + * Hardware manual for this IP can be found here
> + *
> +https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-use
> +rs-manual-hardware-0?language=3Den
> + *
> + * Limitations:
> + * - When PWM is disabled, the output is driven to Hi-Z.
> + * - While the hardware supports both polarities, the driver (for now)
> + *   only handles normal polarity.
> + * - While the hardware supports pwm mode{1,2}, reset-synchronized pwm a=
nd
> + *   complementary pwm modes, the driver (for now) only handles pwm mode=
1.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/time.h>
> +
> +#include <clocksource/rz-mtu3.h>
> +
> +#define RZ_MTU3_TMDR1_MD_NORMAL		(0)
> +#define RZ_MTU3_TMDR1_MD_PWM_MODE_1	(2)
> +
> +#define RZ_MTU3_TIOR_OC_RETAIN		(0)
> +#define RZ_MTU3_TIOR_OC_0_H_COMP_MATCH	(2)
> +#define RZ_MTU3_TIOR_OC_1_TOGGLE	(7)
> +#define RZ_MTU3_TIOR_OC_IOA		GENMASK(3, 0)
> +
> +#define RZ_MTU3_TCR_CCLR_TGRC		(5 << 5)
> +#define RZ_MTU3_TCR_CKEG_RISING		(0 << 3)
> +
> +#define RZ_MTU3_TCR_TPCS		GENMASK(2, 0)
> +
> +#define RZ_MTU3_MAX_PWM_MODE1_CHANNELS	(12)
> +
> +#define RZ_MTU3_MAX_HW_PWM_CHANNELS	(7)
> +
> +static const u8 rz_mtu3_pwm_mode1_num_ios[] =3D { 2, 1, 1, 2, 2, 2, 2 };
> +
> +/**
> + * struct rz_mtu3_pwm_chip - MTU3 pwm private data
> + *
> + * @chip: MTU3 pwm chip data
> + * @clk: MTU3 module clock
> + * @lock: Lock to prevent concurrent access for usage count
> + * @rate: MTU3 clock rate
> + * @user_count: MTU3 usage count
> + * @rz_mtu3_channel: HW channels for the PWM  */
> +
> +struct rz_mtu3_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct mutex lock;
> +	unsigned long rate;
> +	u32 user_count[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> +	struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> +
> +	/*
> +	 * The driver cannot read the current duty cycle/prescale from the
> +	 * hardware if the hardware is disabled. Cache the last programmed
> +	 * duty cycle/prescale value to return in that case.
> +	 */
> +	u8 prescale[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> +	unsigned int duty_cycle[RZ_MTU3_MAX_PWM_MODE1_CHANNELS];
> +};
> +
> +static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct
> +pwm_chip *chip) {
> +	return container_of(chip, struct rz_mtu3_pwm_chip, chip); }
> +
> +static u8 rz_mtu3_pwm_calculate_prescale(struct rz_mtu3_pwm_chip *rz_mtu=
3,
> +					 u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	prescaled_period_cycles =3D period_cycles >> 16;
> +	if (prescaled_period_cycles >=3D 16)
> +		prescale =3D 3;
> +	else
> +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> +
> +	return prescale;
> +}
> +
> +static struct rz_mtu3_channel *
> +rz_mtu3_get_hw_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32
> +channel) {
> +	unsigned int i, ch_index =3D 0;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_pwm_mode1_num_ios); i++) {
> +		ch_index +=3D rz_mtu3_pwm_mode1_num_ios[i];
> +
> +		if (ch_index > channel)
> +			break;
> +	}
> +
> +	return rz_mtu3_pwm->ch[i];
> +}
> +
> +static u32 rz_mtu3_get_hw_channel_index(struct rz_mtu3_pwm_chip
> *rz_mtu3_pwm,
> +					struct rz_mtu3_channel *ch)
> +{
> +	u32 i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_pwm_mode1_num_ios); i++) {
> +		if (ch =3D=3D rz_mtu3_pwm->ch[i])
> +			break;
> +	}
> +
> +	return i;
> +}
> +
> +static bool rz_mtu3_pwm_is_second_channel(u32 ch_index, u32 hwpwm) {
> +	u32 i, pwm_ch_index =3D 0;
> +
> +	for (i =3D 0; i < ch_index; i++)
> +		pwm_ch_index +=3D rz_mtu3_pwm_mode1_num_ios[i];
> +
> +	return pwm_ch_index !=3D hwpwm;
> +}
> +
> +static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip *rz_mtu3_p=
wm,
> +				      u32 hwpwm)
> +{
> +	struct rz_mtu3_channel *ch;
> +	bool is_channel_en;
> +	u32 ch_index;
> +	u8 val;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	is_channel_en =3D rz_mtu3_is_enabled(ch);
> +
> +	if (rz_mtu3_pwm_is_second_channel(ch_index, hwpwm))
> +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORL);
> +	else
> +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORH);
> +
> +	return (is_channel_en && (val & RZ_MTU3_TIOR_OC_IOA)); }
> +
> +static int rz_mtu3_pwm_request(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_channel *ch;
> +	u32 ch_index;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	if (!rz_mtu3_pwm->user_count[ch_index] &&
> !rz_mtu3_request_channel(ch))
> +		return -EBUSY;
> +
> +	mutex_lock(&rz_mtu3_pwm->lock);
> +	rz_mtu3_pwm->user_count[ch_index]++;
> +	mutex_unlock(&rz_mtu3_pwm->lock);
> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_pwm_free(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_channel *ch;
> +	u32 ch_index;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +
> +	mutex_lock(&rz_mtu3_pwm->lock);
> +	rz_mtu3_pwm->user_count[ch_index]--;
> +	mutex_unlock(&rz_mtu3_pwm->lock);
> +
> +	if (!rz_mtu3_pwm->user_count[ch_index])
> +		rz_mtu3_release_channel(ch);
> +}
> +
> +static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> +			      struct pwm_device *pwm)
> +{
> +	struct rz_mtu3_channel *ch;
> +	u32 ch_index;
> +	u8 val;
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(rz_mtu3_pwm->chip.dev);
> +	if (rc)
> +		return rc;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	val =3D (RZ_MTU3_TIOR_OC_1_TOGGLE << 4) |
> +RZ_MTU3_TIOR_OC_0_H_COMP_MATCH;
> +
> +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_MD_PWM_MODE_1);
> +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm))
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORL, val);
> +	else
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORH, val);
> +
> +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> +		rz_mtu3_enable(ch);
> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> +				struct pwm_device *pwm)
> +{
> +	struct rz_mtu3_channel *ch;
> +	u32 ch_index;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +
> +	/* Return to normal mode and disable output pins of MTU3 channel */
> +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1,
> RZ_MTU3_TMDR1_MD_NORMAL);
> +
> +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm))
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORL,
> RZ_MTU3_TIOR_OC_RETAIN);
> +	else
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORH,
> RZ_MTU3_TIOR_OC_RETAIN);
> +
> +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> +		rz_mtu3_disable(ch);
> +
> +	pm_runtime_put_sync(rz_mtu3_pwm->chip.dev);
> +}
> +
> +static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> +			      const struct pwm_state *state) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_channel *ch;
> +	unsigned long pv, dc;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u32 ch_index;
> +	u8 prescale;
> +	int err;
> +	u8 val;
> +
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> +	 * calculation.
> +	 */
> +	if (rz_mtu3_pwm->rate > NSEC_PER_SEC)
> +		return -EINVAL;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
> +					NSEC_PER_SEC);
> +	prescale =3D rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm, period_cycles)=
;
> +
> +	if (period_cycles >> (2 * prescale) <=3D U16_MAX)
> +		pv =3D period_cycles >> (2 * prescale);
> +	else
> +		pv =3D U16_MAX;
> +
> +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rz_mtu3_pwm->rate,
> +				      NSEC_PER_SEC);
> +	if (duty_cycles >> (2 * prescale) <=3D U16_MAX)
> +		dc =3D duty_cycles >> (2 * prescale);
> +	else
> +		dc =3D U16_MAX;
> +
> +	/*
> +	 * Store the duty cycle/prescale for future reference in cases where
> the
> +	 * corresponding registers can't be read (i.e. when the PWM is
> disabled).
> +	 */
> +	rz_mtu3_pwm->prescale[ch_index] =3D prescale;
> +	rz_mtu3_pwm->duty_cycle[pwm->hwpwm] =3D dc;
> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register.
> +	 */
> +	if (!pwm_is_enabled(pwm)) {
> +		err =3D pm_runtime_resume_and_get(chip->dev);
> +		if (err)
> +			return err;
> +	}
> +
> +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_TGRC | val);
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRD, dc);
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRC, pv);
> +	} else {
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_TGRA | val);
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRB, dc);
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, pv);
> +	}
> +
> +	/* If the PWM is not enabled, turn the clock off again to save power.
> */
> +	if (!pwm_is_enabled(pwm))
> +		pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e
> *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_channel *ch;
> +	u8 prescale, val;
> +	u32 ch_index;
> +	u16 dc, pv;
> +	u64 tmp;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	pm_runtime_get_sync(chip->dev);
> +	state->enabled =3D rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, pwm->hwpwm);
> +	if (state->enabled) {
> +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TCR);
> +		prescale =3D FIELD_GET(RZ_MTU3_TCR_TPCS, val);
> +
> +		if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
> +			dc =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRD);
> +			pv =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRC);
> +		} else {
> +			dc =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRB);
> +			pv =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRA);
> +		}
> +
> +		tmp =3D NSEC_PER_SEC * (u64)pv << (2 * prescale);
> +		state->period =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
> +	} else {
> +		/* If the PWM is disabled, use the cached value. */
> +		prescale =3D rz_mtu3_pwm->prescale[ch_index];
> +		dc =3D rz_mtu3_pwm->duty_cycle[pwm->hwpwm];
> +	}
> +
> +	tmp =3D NSEC_PER_SEC * (u64)dc << (2 * prescale);
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	bool enabled =3D pwm->state.enabled;
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		if (enabled)
> +			rz_mtu3_pwm_disable(rz_mtu3_pwm, pwm);
> +
> +		return 0;
> +	}
> +
> +	ret =3D rz_mtu3_pwm_config(chip, pwm, state);
> +	if (ret)
> +		return ret;
> +
> +	if (!enabled)
> +		ret =3D rz_mtu3_pwm_enable(rz_mtu3_pwm, pwm);
> +
> +	return ret;
> +}
> +
> +static const struct pwm_ops rz_mtu3_pwm_ops =3D {
> +	.request =3D rz_mtu3_pwm_request,
> +	.free =3D rz_mtu3_pwm_free,
> +	.get_state =3D rz_mtu3_pwm_get_state,
> +	.apply =3D rz_mtu3_pwm_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int rz_mtu3_pwm_pm_runtime_suspend(struct device *dev) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_pwm_pm_runtime_resume(struct device *dev) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(rz_mtu3_pwm->clk);
> +
> +	return 0;
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_pwm_pm_ops,
> +				 rz_mtu3_pwm_pm_runtime_suspend,
> +				 rz_mtu3_pwm_pm_runtime_resume, NULL);
> +
> +static void rz_mtu3_pwm_pm_disable(void *data) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D data;
> +
> +	pm_runtime_disable(rz_mtu3_pwm->chip.dev);
> +	pm_runtime_set_suspended(rz_mtu3_pwm->chip.dev);
> +}
> +
> +static int rz_mtu3_pwm_probe(struct platform_device *pdev) {
> +	struct rz_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
> +	struct device *dev =3D &pdev->dev;
> +	int num_pwm_hw_ch =3D 0;
> +	unsigned int i;
> +	int ret;
> +
> +	rz_mtu3_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm),
> GFP_KERNEL);
> +	if (!rz_mtu3_pwm)
> +		return -ENOMEM;
> +
> +	rz_mtu3_pwm->clk =3D ddata->clk;
> +	rz_mtu3_pwm->rate =3D clk_get_rate(rz_mtu3_pwm->clk);
> +	for (i =3D 0; i < RZ_MTU_NUM_CHANNELS; i++) {
> +		if (i =3D=3D RZ_MTU5 || i =3D=3D RZ_MTU8)
> +			continue;
> +
> +		rz_mtu3_pwm->ch[num_pwm_hw_ch] =3D &ddata->channels[i];
> +		rz_mtu3_pwm->ch[num_pwm_hw_ch]->dev =3D dev;
> +		num_pwm_hw_ch++;
> +	}
> +
> +	mutex_init(&rz_mtu3_pwm->lock);
> +	platform_set_drvdata(pdev, rz_mtu3_pwm);
> +	clk_prepare_enable(rz_mtu3_pwm->clk);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rz_mtu3_pwm_pm_disable,
> +				       rz_mtu3_pwm);
> +	if (ret < 0)
> +		goto disable_clock;
> +
> +	rz_mtu3_pwm->chip.dev =3D &pdev->dev;
> +	rz_mtu3_pwm->chip.ops =3D &rz_mtu3_pwm_ops;
> +	rz_mtu3_pwm->chip.npwm =3D RZ_MTU3_MAX_PWM_MODE1_CHANNELS;
> +	ret =3D devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +		goto disable_clock;
> +	}
> +
> +	return 0;
> +
> +disable_clock:
> +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> +	return ret;
> +}
> +
> +static struct platform_driver rz_mtu3_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-rz-mtu3",
> +		.pm =3D pm_ptr(&rz_mtu3_pwm_pm_ops),
> +	},
> +	.probe =3D rz_mtu3_pwm_probe,
> +};
> +module_platform_driver(rz_mtu3_pwm_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_ALIAS("platform:pwm-rz-mtu3");
> +MODULE_DESCRIPTION("Renesas RZ/G2L MTU3a PWM Timer Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1

