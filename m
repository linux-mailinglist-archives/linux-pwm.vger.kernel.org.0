Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0A37846A0
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Aug 2023 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbjHVQNT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Aug 2023 12:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHVQNT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Aug 2023 12:13:19 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B680137;
        Tue, 22 Aug 2023 09:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMdfIA1qt4wgaN4xux2B2jgwC2a6gAOpGLJHnNlZECzwIHcGzgysY6IdoayhAvnU3DkRyCPROh9z2BgllF1XWs6MZweL0oI9WONUBtcokqShaAEB5GYm4vAHK9HMStKuYvJTU8nqgXkTEnemuQkbxVu6XwBB+dKDQ1XZuMC4oKpCh8xQl1U+A9uLc1y/QFT+hZUSu7SeRd5KgDcwsJW8V6gYPOrbYVvZL8GudgszNywZNoouJi+vQBQ+r92mvRgQC2AV7ThyldWajsYH0b9id/AkIaJDQjx9Tn92TayJwaAysWvFzgzFFW5e1P8/vOmPbNBL3Fs0iOiDINVqyywaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGQhrS/KH1RcfFQSwqIu2HWupyEyN+MvKIT7f3ZTYgA=;
 b=mTxAroB9mJnx9K3QnH6ymdVZ+n6IwJ2d0EjAgv9Gr0U2LFUMAp9dq//qrzSibA37GNR6bWqSFhb+/sXQ8D0PMkPDnLH81IhNK5zTuXBZotBjx6e9yIZQLdEGa6d17MHtA7IlseFLYJuOZ7YHXe2zjxBUR7velbt2RPjadIEWPHzAjqaychb7yGcb5ZQ8g4eKH6sY3VvhVaQ05oVfF/iGkIc7wIdreQXdwkWcMQ7Aa0pOqVGKvFvLoxiLsc1ETn86dFKblQJLT6aUOcdqcSRofEYuIXf/yJzNOKH3qAe9brtsY2+oEY2IXS2jgyrey77IftMndvIFe1YTLm/yKs4jwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGQhrS/KH1RcfFQSwqIu2HWupyEyN+MvKIT7f3ZTYgA=;
 b=s2Bl5Xm+1/rqy+u/JaXG3+vC6hD7zOKg1MFw1WmHGxOV1jPZf1VvcqwyLUjX8fIA1lgZ1+7vh7IFp4XLA0b9CeAzQLS+GyUVy2VF+ClQy+BU4i2x8bYhxXEEL+Pqf6pJyQRh/pSBZ28YI7VijzKy5Jyd4FEmc8t3D8RSLSb3OTo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8872.jpnprd01.prod.outlook.com (2603:1096:400:16f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 16:13:11 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.025; Tue, 22 Aug 2023
 16:13:10 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH v5 0/4] Add RZ/V2{M, MA} PWM driver support
Thread-Topic: [PATCH v5 0/4] Add RZ/V2{M, MA} PWM driver support
Thread-Index: AQHZq0eivZXELtqdK0mRuV6/HyPYya/e9ERwgBfcJjA=
Date:   Tue, 22 Aug 2023 16:13:10 +0000
Message-ID: <OS0PR01MB5922DAD6372DA551976148BB861FA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230630114003.320641-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB59225AA08163660946229E19860CA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59225AA08163660946229E19860CA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8872:EE_
x-ms-office365-filtering-correlation-id: 7506ce78-39f2-436f-5116-08dba32aae26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rcTjpfd7WZ/ypXZ0FYBdGRObkkHBzGDdILPHg8cUsGeG/HsWhkpGwZErK73mcaUXyQzPHL+/Z30+Is1h8cBhpd9yV539anR7DwXi+QYX3f8eiKWqSvV3BMSH0OUaoeUIi8/OKqBGGwx00Ab/ecvVUf+XpK49rarLNNd+VietZfEPPPQfyKTopl49aLWt+muEnJaiDjQyCpkSLBzexBuBcSD3pKZZKmJ/0YbRaHxL8H7R14VwIOVl2yGaICWpitseooFrf65n8hQgopqEJQqvyW0vC13qIk/qHNPwC+FOqRDIViF0ild+SdnSzkowzPvT+p6/GFyfawH6leP+JTf47g5HE/m3Er6okduPQCF3IbCkeQ6w4kRWoFmPZGYRdbzC89XS15zlQeMcIOyi3xfKxRWVRuTto8Wa5u+zCcTB8IADHR07dJNE22WNxmoVLpRB6Zur1CFgZecuDza/5w8R1z390Bv+6dO5bgHKKvpKo4daeB70uo9Uyjj+OtbBfZJ4zWWf4EsJWlh3MxWE/n3w+fjOzcsGe4NWO8rXFHqvKx8GKP/QOoKkyjenwNkIugnckah37xsWlzU6le0Sgt8zwIj/9u75mIzlfyVjkB5eH6A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(186009)(1800799009)(451199024)(33656002)(86362001)(55016003)(122000001)(66946007)(316002)(66556008)(66476007)(478600001)(76116006)(110136005)(66446008)(38070700005)(38100700002)(41300700001)(966005)(54906003)(64756008)(9686003)(7696005)(6506007)(71200400001)(26005)(107886003)(8936002)(7416002)(8676002)(52536014)(2906002)(4326008)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pEgJFrgdmGvq1PPBYH5zSdGnrjhWcYxjYMH184XtE7NCncEyJGw7sQ7ksZ?=
 =?iso-8859-1?Q?7p1NHC9cuKJKjJS9MjajVF+gexKxNllXWnmneOWUK16EHFeFHQK2Eu6ENw?=
 =?iso-8859-1?Q?PWgFRlsZDQVSTJ+zyu9oit+PE01YZ8gAK7SX/vZsKYLJAY2sE2PQS36gcH?=
 =?iso-8859-1?Q?ajgQRzXamQZPOCSNDv/R6V38WtCEZiHrJjtahQMPIDwf4vAS4q27Mljj6v?=
 =?iso-8859-1?Q?DkaEViqN3pbSyrG6H1CipxQlp2hDaOGw1oqEe7wM3WvUyiAVJsroMNbi5v?=
 =?iso-8859-1?Q?QQl83j0pXIDgYMoZOX3DS/pO6Ct9AiNsZv4Ftl5cjvQ4cKIMk5gu8ueZyr?=
 =?iso-8859-1?Q?o6tQWK6lmL+Oj+M4oKAgE/FCTsUYFN+1rurM/+imUeygKO7es3zdrKlTZQ?=
 =?iso-8859-1?Q?1BUMW17T9jVyONU+B9wAuvxNJr5PP+CPWBtfsmPCmJZAMEOkctFNngxXhQ?=
 =?iso-8859-1?Q?pWItMUU7E2zYOJdxuuVvS0Gv8xx6qoY3iWX0WMI8bHrJZp6tXn/3D+akJz?=
 =?iso-8859-1?Q?NTR0b2HmQCEc0O7pesCq/MA46I/26ClxwidcX8/OwIT3L4P+bBLL3YXBbj?=
 =?iso-8859-1?Q?7ZorIJi4l0inM32bUNSp3HH1zWFoE2sNIU+LlTUXRClF1EiCYwkThFJ8dA?=
 =?iso-8859-1?Q?uUH7otjE92xnAFOYkhirwXEbBYydDUEJ2TQCzEbGR66TluR4ITOoleZo5N?=
 =?iso-8859-1?Q?SzkZAcQdUqZmjMSVPlS8gFuKoOhF8RzzBihIAkcuqSaOi9C04rrsx4Mn4x?=
 =?iso-8859-1?Q?lnk5jqebUFLhI2SO4/L11thaZy98cyXzZqzfAaneiK6yK703cjc0hedKub?=
 =?iso-8859-1?Q?dghNYo6QTblBbXct2zXxE526wq+GdW+c5jhD2y6LXzglxyZGis6eom/wx0?=
 =?iso-8859-1?Q?wBNKw6mWdhoSE5L3aPuvKlV7YssEGCpJ8RQWZGzNxlcivN3ksqllH8qXYu?=
 =?iso-8859-1?Q?WslotxTgtvAddKxEpLfSBv7nBx2IT6tNY0Mcwh3u8wgbRWs/X8doOKtyCd?=
 =?iso-8859-1?Q?1p03CCiyDiaHU+zIFN5Ff0RbjkZubPq7I6/Ztb05LMB1ShWAR+ljxDA1nu?=
 =?iso-8859-1?Q?BZ8ndlHXK+3xGEjr8dP8kWtdVvQ6T8yd65BMzVwgBnE95e9EeZT/pCFTrU?=
 =?iso-8859-1?Q?5Xad9I9fs9TCipHUvr7ktgdgjNd/7ATNrXor9/KR95pg8AOWbzFsRTGqLm?=
 =?iso-8859-1?Q?h5+kO1vjnZOY8ZpArXk2+I28EtlJ2aD5yE1HPXOG/6ZEkOBonq4YO0lznV?=
 =?iso-8859-1?Q?O/DPmDsyhh7ZTlpnwtzzuPuh0sHsr+6B91W9C484OEh4+2mutWIQdp1oGP?=
 =?iso-8859-1?Q?H9ad6JoZfKicgZZAL3oFQNCl2ol5kxaNcxbnTh3Z7rOUBebpy0qVDbvl9H?=
 =?iso-8859-1?Q?IgPzjuaAWDfX0SwjHr6inE88cbtDAT+BII+Pg6zy+Z0h56bw92RRQLV9mf?=
 =?iso-8859-1?Q?Kfu7zrtJ0EqV2NppVZeLZcJX9Y1dvEvDxjVSY/8BkP01AtfOo46EpLebal?=
 =?iso-8859-1?Q?ggXNrLJmdTmJm45WM3qjm5sfTCZQFsCf9m5xfc1UMZtdFAeFHUkwSwiQwN?=
 =?iso-8859-1?Q?DPgwJFGEFcB21Zrd4snlEKr8D0nUFe+cnCPOWEFOkF18KDd8oClBKpsRv9?=
 =?iso-8859-1?Q?HpfKHcYd34rJSoQ5WjuLAuozxy3RgPtKf/KyuMqGgyogljk2b+xQ9PWw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7506ce78-39f2-436f-5116-08dba32aae26
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 16:13:10.8471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ceIFUxdjqmRddEL/a7oWV633sHbAgydsJ3F+sSEfUvg9vCmNf7dJrTFH1a7aa33jxtF5gc1vVxdFyl4PKMbZvv9dZD/g1DOpp1GhSuK1B8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8872
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Gentle ping.

> Subject: RE: [PATCH v5 0/4] Add RZ/V2{M, MA} PWM driver support
>=20
> Hi Uwe,
>=20
> Gentle ping.
>=20
> Cheers,
> Biju
>=20
> > Subject: [PATCH v5 0/4] Add RZ/V2{M, MA} PWM driver support
> >
> > The RZ/V2{M, MA} PWM Timer (PWM) is composed of 16 channels. Linux is
> > only allowed access to channels 8 to 14 on RZ/V2M, while there is no
> > restriction for RZ/V2MA.
> >
> > The RZ/V2{M, MA} PWM Timer (PWM) supports the following functions:
> >  * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
> >  * The frequency division ratio for internal counter operation is
> > selectable
> >     as PWM_CLK divided by 1, 16, 256, or 2048.
> >  * The period as well as the duty cycle is adjustable.
> >  * The low-level and high-level order of the PWM signals can be inverte=
d.
> >  * The duty cycle of the PWM signal is selectable in the range from 0
> > to 100%.
> >  * The minimum resolution is 20.83 ns.
> >  * Three interrupt sources: Rising and falling edges of the PWM signal
> and
> >    clearing of the counter
> >  * Counter operation and the bus interface are asynchronous and both ca=
n
> >    operate independently of the magnitude relationship of the respectiv=
e
> >    clock periods.
> >
> > v4->v5:
> >  * rebased to pwm for-next.
> >  * Sorted KConfig file
> >  * Sorted Make file
> >  * Updated copyright header 2022->2023.
> >  * Updated limitation section.
> >  * Replaced the variable chip->rzv2m_pwm in rzv2m_pwm_wait_delay()
> >  * Replaced polarity logic as per HW manual dutycycle =3D Ton/Ton+Toff,=
 so
> >    eventhough native polarity is inverted from period point of view it =
is
> >    correct.
> >  * Updated logic for supporting 0% , 100% and remaining duty cycles.
> >  * On config() replaced
> > pm_runtime_resume_and_get()->pm_runtime_get_sync()
> >  * Counter is stopped while updating period/polarity to avoid glitches.
> >  * Added error check for clk_prepare_enable()
> >  * Introduced is_ch_enabled variable to cache channel enable status.
> >  * clk_get_rate is called after enabling the clock and
> > clk_rate_exclusive_get()
> >  * Added comment for delay
> >  * Replaced 1000000000UL->NSEC_PER_SEC.
> >  * Improved error handling in probe().
> > v3->v4:
> >  * Documented the hardware properties in "Limitations" section
> >  * Dropped the macros F2CYCLE_NSEC, U24_MASK and U24_MAX.
> >  * Added RZV2M_PWMCYC_PERIOD macro for U24_MAX
> >  * Dropped rzv2m_pwm_freq_div variable and started using 1 << (4 * i) f=
or
> >    calculating divider as it is power of 16.
> >  * Reordered the functions to have rzv2m_pwm_config() directly before
> >    rzv2m_pwm_apply().
> >  * Improved the logic for calculating period and duty cycle in
> > config()
> >  * Merged multiple RZV2M_PWMCTR register writes to a single write in
> > config()
> >  * replaced pwm_is_enabled()->pwm->state.enabled
> >  * Avoided assigning bit value as enum pwm_polarity instead used enum
> > constant.
> >  * Fixed various issues in probe error path.
> >  * Updated the logic for PWM cycle setting register
> >  * A 100% duty cycle is only possible with PWMLOW > PWMCYC. So
> restricting
> >    PWMCYC values < 0xffffff
> >  * The native polarity of the hardware is inverted (i.e. it starts
> > with the
> >  * low part). So switched the inversion bit handling.
> > v2->v3:
> >  * Removed clock patch#1 as it is queued for 6.3 renesas-clk
> >  * Added Rb tag from Geert for bindings and dt patches
> >  * Added return code for rzv2m_pwm_get_state()
> >  * Added comment in rzv2m_pwm_reset_assert_pm_disable()
> > v1->v2:
> >  * Updated commit description
> >  * Replaced pwm8_15_pclk->cperi_grpf
> >  * Added reset entry R9A09G011_PWM_GPF_PRESETN
> >  * Added Rb tag from Krzysztof for bindings and the keep the Rb tag as
> >    the below changes are trivial
> >  * Updated the description for APB clock
> >  * Added resets required property
> >  * Updated the example with resets property
> >  * Replaced devm_reset_control_get_optional_shared-
> > >devm_reset_control_get_shared
> >  * Added resets property in pwm nodes.
> >
> > Note:
> >  Hardware manual for this IP can be found here
> > https://www.renesas.com/in/en/document/mah/rzv2m-users-manual-
> > hardware?language=3Den
> >
> > Biju Das (4):
> >   dt-bindings: pwm: Add RZ/V2M PWM binding
> >   pwm: Add support for RZ/V2M PWM driver
> >   arm64: dts: renesas: r9a09g011: Add pwm nodes
> >   arm64: dts: renesas: rzv2m evk: Enable pwm
> >
> >  .../bindings/pwm/renesas,rzv2m-pwm.yaml       |  90 ++++
> >  .../boot/dts/renesas/r9a09g011-v2mevk2.dts    |  70 +++
> >  arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  98 ++++
> >  drivers/pwm/Kconfig                           |  11 +
> >  drivers/pwm/Makefile                          |   1 +
> >  drivers/pwm/pwm-rzv2m.c                       | 451 ++++++++++++++++++
> >  6 files changed, 721 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/renesas,rzv2m-
> > pwm.yaml
> >  create mode 100644 drivers/pwm/pwm-rzv2m.c
> >
> >
> > base-commit: 92554cdd428fce212d2a71a06939e7cab90f7c77
> > --
> > 2.25.1

