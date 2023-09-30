Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A7E7B400C
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Sep 2023 13:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjI3LFR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 30 Sep 2023 07:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjI3LFQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 30 Sep 2023 07:05:16 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B51ACA;
        Sat, 30 Sep 2023 04:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UplRVngmXu1EymbNUoK7hLaG7iJXgvMWcDFlLjmDQkkUygsq+JswVbZfdx4+1hVk4iPKBVYQU6gBQAOzOiiqXJLhNSSQFkSpWBHqNbbvQZEvXt9+c24Z6TL6uM5RLB9kFT8hcXRRPu3tPYYcsgwVFWB1039ixXpYrH98535+oCrxgkk185gntqs2DtWPPB7AGeRyutxg/86kWZZsPf9l/jPy0B08F3BpdW113H+MOO836Fn87ncki+ubl/Op3izzYDn6ZQ77IAigxUfRHhCXc+ZRHwu0Zt33LtJP088T5j3WpJz5Y+IcV6GorWOzJ/x99Brx//ea1JSj2JPHNTfhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f64AYec9F8Wci8S/wi8VIwEDvWglecU512GppoibQVk=;
 b=LsbEwQrfYVlH68Aq4VKIrlDdpNyA8zxs7/w678mYOk2xjMx8WPRAk7jLRSeWRdmbd+h4AwgL0QE2ATv3aKr02Z93brv7PAIq6MAGRfnEFWAUs8oc6XK65oBeuRxPmLqd471O3GgkIuI6UTNuN+BQyToAN5ar9L8IOueKVsT8XoUbNEeP2YuVYW5weRo8mMAUFo4x9KHur6olVeBjidpMFUpVs3KaicqnO50lC/2sM98dFVG15lQg//pEg4qkxyiQKboAjFJdovVpffgWl9wmhw4HCYIcwJYdKpOD4guQj6jFcdCYLwcLrgP8d9hqbAsa5iBmK7lojUAeAK0H6LkysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f64AYec9F8Wci8S/wi8VIwEDvWglecU512GppoibQVk=;
 b=we3E9GcC4dpa7z91puSC0fpdCivNhmUER06ixXaAAxiP1jtX/2Q8W/SSYHqqZodb+XwJm0Jhf8CEjPPviAFTxt0Sl7+NqZXbcSeJOzOyK1efpFCXR9m41FgceBuQ8TEBJeg2QNh6/bjXyU7vON1Ox0jRTm/aiaukYAaEE9e1BUY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8814.jpnprd01.prod.outlook.com (2603:1096:604:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Sat, 30 Sep
 2023 11:05:07 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.028; Sat, 30 Sep 2023
 11:05:04 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH v5 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Topic: [PATCH v5 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Index: AQHZq0enz8HRn1kGbUSmOUzUBPgy+rAeD4gAgBW0ttA=
Date:   Sat, 30 Sep 2023 11:05:03 +0000
Message-ID: <OS0PR01MB59223A7E93B59E9DA240F6DF86C7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230630114003.320641-1-biju.das.jz@bp.renesas.com>
 <20230630114003.320641-3-biju.das.jz@bp.renesas.com>
 <20230916153248.27k7erg7i7ruf76w@pengutronix.de>
In-Reply-To: <20230916153248.27k7erg7i7ruf76w@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8814:EE_
x-ms-office365-filtering-correlation-id: 676c1db3-ff58-44ba-41f3-08dbc1a51939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sLfMOMouVbYN4nAFiYjxU/2Bo9GRJIv84HUzwzx6QXocGTpMbmiriNaIVZ8fVKHn/rqzsPCwWb4Gau4X4pK8M9VU5y+qZT1A1QNzysXClQAtL6fcbD4ZAvDMjoR0MsUT4YFPNXLe34uWXgAYvs40h793vSJYjqMR7JA8zHz1Yj3myR2FO0lEbrBnEorDa6PypBES+zk9xtO9X/MlAxRU7q9H9byG+5hPZKN0EREXQMoknRE9lMm6AqL+QUN3fUzYNXPY9+w2whWv8++ZFsR5vkulQCGLHFLKuxwC4ut2Z4gb58UO6R3Xonqf9L0P+EaJiX6W8TKT9kFHD3Ht0SD8xrJYyvDtts0qWPMsN5u4iKsOrfUjcdwcG39Hd+17SdT2YiqrbVymxXGJMemG9FDJ5zLVgpGKMNNfc4rpYp9TkqCGxLKgPKW8qdWYt5JClBm34iEmuQx6qsZTcXQFOoFfbufshOUujELIv4HLzpBKgHLhQbIBCaeGZa47vd6Zs3L9Uc3d8d1cfPlnia7Tk4GG1vh93SHgo13EeaBxGTs7F2Kr8EQWTZaxpRMMLsPYW0yCLJzQZMXe5GzqUDMN9iGAsaP15d2xn00S356O4euMCeU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(71200400001)(6506007)(53546011)(7696005)(966005)(478600001)(66574015)(83380400001)(9686003)(26005)(107886003)(2906002)(30864003)(41300700001)(316002)(66556008)(6916009)(76116006)(64756008)(66446008)(66476007)(54906003)(5660300002)(4326008)(8676002)(8936002)(52536014)(66946007)(33656002)(38070700005)(38100700002)(122000001)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SowwKjrunfxn6cHWdyXU7joQpj+g+ng6vXVlDmtzEJIndMBgNnICrVsD4k?=
 =?iso-8859-1?Q?0C+mRA5Q39fQeYDGvBB/xOZ5KIO3Z4Me/LGPDmqMHf97LAD311coNPYW2T?=
 =?iso-8859-1?Q?PYTvP5kC6zeJmAlhDZPufedXtvSwBrVWgnPhuTXsCWkJaDi+vPFNy1EbAi?=
 =?iso-8859-1?Q?SPrUGf8jBBi3RSsvQgysuOF/glDV/tHbIEiQ7vIwbmySqOafCyUKV0XcHh?=
 =?iso-8859-1?Q?Wk34qWXqZ9klZea5eBaTZYayGGQB07Nz8an+h6FKDY1Mhgn7GNsL+SSswp?=
 =?iso-8859-1?Q?/sBphAIi2F7bhJjZRBa1ltmh3b0up6jVHMiIw2RHGvsalIyTD0jF4QPk/X?=
 =?iso-8859-1?Q?pSY1WMVt7WCpYjBFoJRJZdGy5jem6dU27Bl3aOrNAJCI6SCjLNCFQFGVWW?=
 =?iso-8859-1?Q?M2M3X2WZBdHAg+22wATpVQ/+/18uOCyFSP1k0YIE+ZNuXfNkhnzxQB7myW?=
 =?iso-8859-1?Q?AT01KXu5QLVooCzSEqbKn0NxrL3qAUd6+eH4PqJtnOUt2HTpUuyHnEdnFi?=
 =?iso-8859-1?Q?qVfa/UBlY1eteNDYq9yH6oO47ppFaSSo3k1OK0HlmUa98P+lvTJdbSwlzZ?=
 =?iso-8859-1?Q?ZAAmnpUE/k3yxsDpsUDsDuzlBIxzP0rEAu5TaDkBiQju04OIgZgxRuxMqD?=
 =?iso-8859-1?Q?4Ilj03KSRCHbMfdUUWY/MX6VF9thbJzT26zMP3VZ+3ZG15qGWotgEw+zkT?=
 =?iso-8859-1?Q?m6IVuU/A+mox65GZpqILhJEFPfdENNYUSy1oVhV16zlSfEESA4gAnLsBVa?=
 =?iso-8859-1?Q?tiLl0I40jWZasNbvmU+ZbYTcvltprJ+IgMhHV09+T+ieZIjAe/THQtU+5G?=
 =?iso-8859-1?Q?BQ2zM7rA1xxbg/vnl2MRN/YGCSVrYH1HT5lQb3LiNkmazZFEfcapWYNLkD?=
 =?iso-8859-1?Q?rPxShmoh4i6NeLwhx/24Yfj9CxbCeXqDnh2LD459ISOStnWsKuDhh0Pan8?=
 =?iso-8859-1?Q?u36p/+etrDAdT1ZIUGSXH7R+m7UIZnKvXIpUS+Db6tOMtfcQI9drIa9bTh?=
 =?iso-8859-1?Q?HIR7Y1VjS6cxAMH1VvX6Cq8/cXUWZdTawfLRORUeUQMTfePdNCYJYEV8tW?=
 =?iso-8859-1?Q?cffBNFGTBNrfk8GVgjl4YIs9xukASWhL8idWpwYxauvECk35vVGrgdGbyv?=
 =?iso-8859-1?Q?9wzvBHAFn+jl5YH+cbJJqe6qvE8gUqwK9l4KT4FxPUntpi3yi6erjvSvXS?=
 =?iso-8859-1?Q?+Y4dXuW5J9teLZ55J3xoILs1egrxB7fUTnp/5Vxd+Dg0W31EWsaxPhbuFP?=
 =?iso-8859-1?Q?QISKOn6q0U08FYZ7p6NyQP66XOf7tWTyZ/OMORtkAh0pNP6b8qEWC2dg1p?=
 =?iso-8859-1?Q?vHUWsBWXtmXONU8oNo5wI0my0MTHtbun4w9LaX8xpDLZcDxmYtoOB7B/Gy?=
 =?iso-8859-1?Q?Lv/8+51U7DpKpymVNRRtKcKzCxGxIhFy+hvJv94v0CT34mHoEPDto5W/es?=
 =?iso-8859-1?Q?7VIc0Axldlq5cOWSpYfrkhAXkjai+75FaVWlkd10EHkgkE0AujUbvqcT3S?=
 =?iso-8859-1?Q?dmpJ9VIU0HFNa2iI1ZoiilP0KuObyrmCxRmy+vsyCCWsRwjNu8Jim4V7gU?=
 =?iso-8859-1?Q?2Em/kKtYnwPeXJdLblw1QroXxibjm35dY7lwWR1n4kzBhLOYHke4kL9s+x?=
 =?iso-8859-1?Q?l//8UKG5vdCdVPKdPVBpw5iiP7eLa4/Pp+X0pec056em3VWMBjryet9w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676c1db3-ff58-44ba-41f3-08dbc1a51939
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2023 11:05:03.9962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fEnfUcRTGXGjhSftJWysL15AoulFiWcVyqAtR+kSOumMWlIUMSVI9UB/KSoktnE94/1LnkXrFSHQhFG4lPkgzrsGmoHkxrIfOhSSY4w//8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8814
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

As I am busy with other activities, Fabrizio will respond to your comments =
as he has RZ/V2M board.

Cheers,
Biju

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Saturday, September 16, 2023 4:33 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>; Philipp Zabel
> <p.zabel@pengutronix.de>; Geert Uytterhoeven <geert+renesas@glider.be>;
> Magnus Damm <magnus.damm@gmail.com>; linux-pwm@vger.kernel.org; linux-
> renesas-soc@vger.kernel.org; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: Re: [PATCH v5 2/4] pwm: Add support for RZ/V2M PWM driver
>=20
> Hello,
>=20
> sorry this took so long.
>=20
> On Fri, Jun 30, 2023 at 12:40:01PM +0100, Biju Das wrote:
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
> > v4->v5:
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
> >  * Added logic for supporting 0% , 100% and remaining duty cycle.
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
> >  drivers/pwm/pwm-rzv2m.c | 451
> > ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 463 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-rzv2m.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > 6210babb0741..1c8dbb064ee5 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -514,6 +514,17 @@ config PWM_RZ_MTU3
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-rz-mtu3.
> >
> > +config PWM_RZV2M
> > +       tristate "Renesas RZ/V2M PWM support"
> > +       depends on ARCH_R9A09G011 || COMPILE_TEST
> > +       depends on HAS_IOMEM
> > +       help
> > +         This driver exposes the PWM controller found in Renesas
> > +         RZ/V2M like chips through the PWM API.
> > +
> > +         To compile this driver as a module, choose M here: the module
> > +         will be called pwm-rzv2m.
> > +
> >  config PWM_SAMSUNG
> >  	tristate "Samsung PWM support"
> >  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS ||
> > COMPILE_TEST diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index c822389c2a24..ee190df16279 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -47,6 +47,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> >  obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
> > +obj-$(CONFIG_PWM_RZV2M)		+=3D pwm-rzv2m.o
> >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> >  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> > diff --git a/drivers/pwm/pwm-rzv2m.c b/drivers/pwm/pwm-rzv2m.c new
> > file mode 100644 index 000000000000..0c5c0b9f0e70
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rzv2m.c
> > @@ -0,0 +1,451 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/V2M PWM Timer (PWM) driver
> > + *
> > + * Copyright (C) 2023 Renesas Electronics Corporation
> > + *
> > + * Hardware manual for this IP can be found here
> > + *
> > +https://www.renesas.com/in/en/document/mah/rzv2m-users-manual-hardwar
> > +e?language=3Den
> > + *
> > + * Limitations:
> > + * - Changes to the duty cycle configuration get effective only after
> the next
> > + *   period end.
> > +=A0* - The duty cycle can be changed only by modifying the PWMLOW
> > +register
> > +=A0* =A0 value and changing the pulse width at low level. The duty cyc=
le
> > +becomes
> > +=A0* =A0 0% for the low width when the value of the PWMLOW register is
> > +0x0h
> > +=A0* =A0 and 100% for the low width when the value of the PWMLOW > PWM=
CYC.
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
> > +	unsigned long pwm_cyc;
> > +	enum pwm_polarity polarity;
> > +	bool is_ch_enabled;
> > +};
> > +
> > +static inline struct rzv2m_pwm_chip *to_rzv2m_pwm_chip(struct
> > +pwm_chip *chip) {
> > +	return container_of(chip, struct rzv2m_pwm_chip, chip); }
> > +
> > +static void rzv2m_pwm_wait_delay(struct rzv2m_pwm_chip *rzv2m_pwm) {
> > +	/* delay timer when change the setting register */
> > +	ndelay(rzv2m_pwm->delay);
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
> > +static void rzv2m_pwm_modify(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg=
,
> u32 clr,
> > +			     u32 set)
> > +{
> > +	rzv2m_pwm_write(rzv2m_pwm, reg,
> > +			(rzv2m_pwm_read(rzv2m_pwm, reg) & ~clr) | set); }
> > +
> > +static u8 rzv2m_pwm_calculate_prescale(struct rzv2m_pwm_chip *rzv2m_pw=
m,
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
> > +	rzv2m_pwm->is_ch_enabled =3D true;
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzv2m_pwm_disable(struct rzv2m_pwm_chip *rzv2m_pwm) {
> > +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME, 0);
> > +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> > +	pm_runtime_put_sync(rzv2m_pwm->chip.dev);
> > +	rzv2m_pwm->is_ch_enabled =3D false;
> > +}
> > +
> > +static int rzv2m_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e
> *pwm,
> > +			       struct pwm_state *state)
> > +{
> > +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> > +	u32 period, low, val;
> > +	u8 prescale;
> > +
> > +	pm_runtime_get_sync(chip->dev);
> > +	val =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCTR);
> > +	state->enabled =3D FIELD_GET(RZV2M_PWMCTR_PWME, val);
> > +	state->polarity =3D FIELD_GET(RZV2M_PWMCTR_PWMHL, val) ?
> > +		PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > +	prescale =3D FIELD_GET(RZV2M_PWMCTR_PWMPS, val);
> > +	period =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCYC);
> > +	low =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMLOW);
> > +	if (low > period) /* 0% duty cycle */
> > +		val =3D 0;
> > +	else if (!low) /* 100% duty cycle */
> > +		val =3D period;
> > +	else
> > +		val =3D period - low;
>=20
> This could be simplified to:
>=20
> 	if (low > period) /* 0% duty cycle */
> 		val =3D 0;
> 	else
> 		val =3D period - low;
>=20
> Maybe it makes sense add another variable "duty_cycle" here and use that
> for improved clarity? And then maybe rename "val" to "ctr"?
>=20
> > +	if (period)
> > +		period +=3D 1;
>=20
> This looks bogus, why don't you add 1 if RZV2M_PWMCYC is 0?
>=20
> Also it suggests that the hardware cannot do a 100% relative duty cycle?
> If I didn't miss anything here, please add that to the list of Limitation=
s
> above.
>=20
> > +	state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)period << (4 *
> prescale),
> > +					 rzv2m_pwm->rate);
>=20
> The multiplication can overflow. I see no easy way to prevent this withou=
t
> introducing a mul_u64_u64_div_roundup helper. Maybe I miss something?
>=20
> > +	state->duty_cycle =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)val << (4 =
*
> prescale),
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
) -
> 1
> > +	 */
> > +	pc =3D mul_u64_u32_div(state->period, rzv2m_pwm->rate, NSEC_PER_SEC);
>=20
> rzv2m_pwm->rate is an unsigned long. So mul_u64_u32_div is the wrong
> function (at least on archs where sizeof(long) > 4).
>=20
> > +	dc =3D mul_u64_u32_div(state->duty_cycle, rzv2m_pwm->rate,
> NSEC_PER_SEC);
> > +	prescale =3D rzv2m_pwm_calculate_prescale(rzv2m_pwm, pc);
> > +
> > +	pwm_cyc =3D pc >> (4 * prescale);
>=20
> The division above might have round down the result, so you're losing
> precision here?
>=20
> > +	if (pwm_cyc)
> > +		pwm_cyc -=3D 1;
>=20
> If the requested period is too small, please refuse the request.
> PWM_DEBUG should catch that and emit a warning.
>=20
> > +	if (!FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_cyc))
> > +		pwm_cyc =3D FIELD_MAX(RZV2M_PWMCYC_PERIOD);
> > +
> > +	/*
> > +	 * Formula for calculating PWMLOW register
> > +	 * PWMLOW register =3D PWM cycle * Low pulse width ratio (%)
> > +	 */
> > +	pwm_low =3D dc >> (4 * prescale);
> > +	if (!dc) /* 0% duty cycle */
> > +		pwm_low =3D pwm_cyc + 1;
>=20
> if pwm_cyc =3D=3D FIELD_MAX(RZV2M_PWMCYC_PERIOD) that + 1 isn't a good id=
ea, is
> it?
>=20
> > +	else if (pc =3D=3D dc) /* 100% duty cycle */
> > +		pwm_low =3D 0;
> > +	else
> > +		pwm_low =3D pwm_cyc - pwm_low;
> > +
> > +	/*
> > +	 * If the PWM channel is disabled, make sure to turn on the clock
> > +	 * before writing the register.
> > +	 */
> > +	if (!pwm->state.enabled)
> > +		pm_runtime_get_sync(rzv2m_pwm->chip.dev);
>=20
> Can it happen that this already makes the hardware emit a (probably
> wrong) signal?
>=20
> > +	/*
> > +	 * To change the setting value of the PWM cycle setting register
> > +	 * (PWMm_PWMCYC) or polarity, set the PWME bit of the PWM control
> > +	 * register (PWMm_PWMCTR) to 0b and stop the counter operation.
> > +	 */
> > +	if (rzv2m_pwm->polarity !=3D state->polarity || rzv2m_pwm->pwm_cyc !=
=3D
> pwm_cyc) {
> > +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> 0);
> > +		rzv2m_pwm_wait_delay(rzv2m_pwm);
> > +	}
> > +
> > +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMCYC, pwm_cyc);
> > +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMLOW, pwm_low);
> > +
> > +	pwm_ctr =3D FIELD_PREP(RZV2M_PWMCTR_PWMPS, prescale);
> > +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> > +		pwm_ctr |=3D RZV2M_PWMCTR_PWMHL;
> > +
> > +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMTM |
> > +			 RZV2M_PWMCTR_PWMPS | RZV2M_PWMCTR_PWMHL, pwm_ctr);
> > +
> > +	if (rzv2m_pwm->polarity !=3D state->polarity || rzv2m_pwm->pwm_cyc !=
=3D
> pwm_cyc) {
> > +		rzv2m_pwm->polarity =3D state->polarity;
> > +		rzv2m_pwm->pwm_cyc =3D pwm_cyc;
> > +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> > +				 RZV2M_PWMCTR_PWME);
> > +	}
> > +
> > +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> > +
> > +	/* If the PWM is not enabled, turn the clock off again to save power.
> */
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
> > +
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
> > +	int err;
> > +
> > +	err =3D clk_prepare_enable(rzv2m_pwm->apb_clk);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D clk_prepare_enable(rzv2m_pwm->pwm_clk);
> > +	if (err)
> > +		return err;
>=20
> It would be consequent here to disable apb_clk in the error case to preve=
nt
> a clk enable imbalance.
>=20
> > +
> > +	return 0;
> > +}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
