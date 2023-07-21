Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0D875BDB4
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jul 2023 07:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGUFV0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Jul 2023 01:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGUFVZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Jul 2023 01:21:25 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2122.outbound.protection.outlook.com [40.107.114.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382791BFC;
        Thu, 20 Jul 2023 22:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/n3dNSG0l/ERaB/SQzkYr0fhIi9+b8W5YvoesJlLcVHpku2GZpQzfLgbAhGkFkzc8hEvmyqCo3N9E3w9JXOgKjKwxwRPeBbjYmrYAv13120jQtiu+4dhz1lsf7aPXEuy3xnZC9L7BV42AXRzgDtvDUS7L2YUrrlRISXlp2B2LqqQG1B3/wY1B8Fo5a6uCNA0OAx6GCO0SiRV2mvT9bMb0U9yz/WslJF/yXgsvmiJ9jf310oTo0sC3xFquKcoojq6swSWg4cnLnSvT5M336pCjqYusnkxGoDRbcvaZKsKoG02N4tcBcsbabxG7sBFfVWMHO60I8G++hoAS6IGh9G9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3xBH3EuNiZjLSVLp0h/ZylEkm/mobT1H/FO7/eLsE8=;
 b=QFQThWh+VEJOu4TwhyJNWOHuLPHQhHFFEAFWdeiGSc9dtazCKNfZWJOFLD+ZRj4k0k8XTp5zYRShvZpB3WE4pa7MSJ0EoyO9sbMEVUaYuZqodewEJNSm02E6dOLOI99qlMTZFKt/XAwpD112D6q17DUbWzVFn5a6vgvwQwkK450GINNCQsKSJ1uIItvXNxE0C3W+FCEM2L+osR5YnjOCaeyRgHp7+1Rv9AGnnycMcNixxGcECzfC0u9pjDWcd+x2Ch0UPNi1wybb/wgDYrjYOPJ+CM11b8pRlvJ4VUSewF7vr+77wfS06vZdl80Y1W1H0cIGj/9jnQv5AylLtqOl5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3xBH3EuNiZjLSVLp0h/ZylEkm/mobT1H/FO7/eLsE8=;
 b=lNNwoCSZtUy5eJAfXoOKDpNEeLmlpik6FyrjFA5LiVzA6cLPkyvQUcdd3XAZfQWPZ9fH9CAppg/1Xw5GXu7yIJo31En5pIal5+gCAQVXyEoyv2TJq1jEijg9TqK3+LiE6pE4+iS0IfSqTzUnphpvneLB3ezU6S/0ShsCrhR1/Wk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8365.jpnprd01.prod.outlook.com (2603:1096:604:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 05:21:16 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 05:21:15 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v14 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v14 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHZS4Z8mtyaEYL5+EuCWDZqhi7XZq/EjnLA
Date:   Fri, 21 Jul 2023 05:21:15 +0000
Message-ID: <OS0PR01MB5922C6AFEE231B70E9DFD824863FA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230228150756.482432-1-biju.das.jz@bp.renesas.com>
 <20230228150756.482432-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230228150756.482432-4-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8365:EE_
x-ms-office365-filtering-correlation-id: 265b2c4b-6444-4056-70ef-08db89aa4e25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: USVgs0Qh7ASEk5zL684LNoh+aadO+29PclhYeOzBBNzDnq1b9yM2HHw2NW6IfUq/5QrbD8VBJrwGy2LN1+vnE57QpfJn4npZk+FdtQ4mSitMTTPSqg+6EcjQ4TAl9ixXakPNGq4EiM9jgfEnXbSB5SPWT+A8TXNOIIRZ7EXStFNGaJm2WbuM4MALXR+XP0h0ocnKLUIzCgdetAKMeSn7qlTk4/w7bbfkgg513zzsA76nsH0bF9u8Z2r8atv3UXmpNkD8zPXOH4DgxhYM0HhiydF4mFQC1H4Y5sPuuCPnRhriCiDtrxKgoSQHzbYudzP4Z4Ujbwyb+3fBvhcLq0y/IB2DQJQ61Up9Q5ZvmGqZuvhOP47lDVpzgK/qe7g+9eMBRZz8JjaHZ2hHA1Wevdmyi1yhbQ+Q79hMNZthFtrxbNgCct32CN8j7vzLtSWLNTmX9bk1qZCEbuW0NepPQB6Q3o2vIAqB/dmEHq1tHyrJA7Xk9e+CWGWiXGzssZIeV2rGFBevSqig8IySgKATPPwy7Nx/N1mcKfssKE4XVc83JrGZAIe5lby4RPEF7r2fiZHOyka5OCay+2mkxvSbKBxQm2Y/tzZFLt6AoEuS6ehMWB0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(316002)(66574015)(64756008)(4326008)(66446008)(41300700001)(7696005)(66556008)(54906003)(110136005)(9686003)(71200400001)(66946007)(186003)(76116006)(66476007)(478600001)(53546011)(6506007)(26005)(55016003)(33656002)(30864003)(86362001)(2906002)(52536014)(5660300002)(8676002)(122000001)(8936002)(83380400001)(38070700005)(38100700002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xH1XpKz7EShlrVIzyci0Tgu3r3viPD0cy5+NC7G1gb9k74gc3js2XfBSOZ?=
 =?iso-8859-1?Q?q5UphNt2pLm2Y+Rw2nD2JI3JxSZPkaEz5jcdYcrW8Q2ut182mkvDIq8k9j?=
 =?iso-8859-1?Q?rKHDIuDCzP0Tcqkjg4TFO9Cbnz3nMxWIWMAGL9z3KPErzUlh3VNiKCxDL7?=
 =?iso-8859-1?Q?dLt2T5Cs0t+YH6FVQ4mPOjt2i6hIQdBTFo+3uSYk/jlK0WTXA+RjiAKbBw?=
 =?iso-8859-1?Q?0gMA51ZHVGV34umHJQT4LBbVZUjce097IKVEvT2pmNCd2vHGnTcTZKewoc?=
 =?iso-8859-1?Q?rIh13ybP41BqMMNiKOEY/S82lJ+oNapZ6Yb20cnohGaYFfbJRkClldXd3F?=
 =?iso-8859-1?Q?zAAYKCvjiAyWRwXVbwg8UQa5hsEYBMd3uRTNs/pfECWS+QxXz9AXgNQFWe?=
 =?iso-8859-1?Q?yRgKMJdPFVpPMPMLkSFrT0Ubms0e9bCG5gzkG5unjd95dTj6JN6oMvYOmh?=
 =?iso-8859-1?Q?/l/jMt704ZZsMxrrQa3F+w6EDzLEwqrecwGshmpDSekpQXhmMvfL91AMdw?=
 =?iso-8859-1?Q?SdnE9hx06E282L3SmB3MazK9WhQACaJXvYvrDISGCakG/+pGYAw/ZO9zo5?=
 =?iso-8859-1?Q?cuNza37/F0Ex0Ooi08l15cGcblwnYWGE8TEmZuxZrdxZ2RvDKc/OEI/Fvq?=
 =?iso-8859-1?Q?OLz62LVZIxWrIt9cZRIMqbBkvmLqiV4TKN+6sWawZiT9zSpaqyapX2YB7+?=
 =?iso-8859-1?Q?vt2+fubBbJWMx9W5RXH8SSRnQ+cvLErpVRfVwhP+3ziVefbM91X+yG4HyK?=
 =?iso-8859-1?Q?smwIGgQH3WqFwOfHUQHqSH1ysoV3e5xsP9vb4DqxNobq/i4xJL8wowmEb9?=
 =?iso-8859-1?Q?Gie02KaOkSoH6N6yTGwAHrK29tP035is41havlh69pR9DjxVr7/KjDiSDH?=
 =?iso-8859-1?Q?rCEHJZbFfRVR65q1FSwf6XHU/0T3j5lOS+5ZLAanMf1i50DmPHWz5dbsJ2?=
 =?iso-8859-1?Q?YDdpbIFhJ1Znn5EvajZCnsXQ74zDzgmI2zd7mnUvdglTrlaUi77YCySsrK?=
 =?iso-8859-1?Q?bsArSSmS33bDtngnTfE4eW0vqNFH5WUhXzl3pjxdo/4M+Uiu7pKh2LEJIB?=
 =?iso-8859-1?Q?Wglig7hOWqH78DU5oJrHMSBJUzd+yEoGOFYqM5tsj3O9cjJhjNT5kkgp9y?=
 =?iso-8859-1?Q?Lkc1ZJ6z9JTBokBNgXWT9QxPvpu9f7U0zIu5a/VuArJ3Yr+mqicJuPNciO?=
 =?iso-8859-1?Q?r9AytWp8QVQMmj9qx/roNUUf2YJ4Ijlg5UrUZNPkpxVc5rmPyKh5S2wyoe?=
 =?iso-8859-1?Q?ZRTREsTzlwX4s567Oj6UTwPNQKM+RRx7w1u5lP/e1WAjN4nA0byY4pfmUT?=
 =?iso-8859-1?Q?CLWjKIkKbdzMKrIpcTk8fTaYOvt3KCFKAsqxOOsV0ShoO8K092y0lGcQeL?=
 =?iso-8859-1?Q?xJ+JLBXIFn34biJtQAsJ6XMd1WICKP8CAPoFD61MHjsYofqzjTulrmZB9b?=
 =?iso-8859-1?Q?0TyX+8hyFH/FuyN56d7fw3K2TZKgkVUK+QflU5EXLdc9jYStzkGCIYVg8h?=
 =?iso-8859-1?Q?FBx/Hnu0vx/CjLnR7bAwNb7LpWFtiar7ZplWhCgoMaiATPTOcOtAanwuPJ?=
 =?iso-8859-1?Q?yGxjPr0QUTVKHwG2mGuxVeRlRBFYn/Dz6kY7Ho6SALvc1Fs/K++4u3e0hT?=
 =?iso-8859-1?Q?ejyrg+4ra36HZYL7rNfxPexd2fsTe2n0Dc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265b2c4b-6444-4056-70ef-08db89aa4e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 05:21:15.1281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tMTYgBWKIGV3W7XdDOe/MkkGN3BiTczC5UHtGA6FekNZlVOapzlNRL3VojqrOKsXJpuPjBInP5UqPMexlFWG9i7yn2oHLH9qyKEnRp6re8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8365
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

I have made some improvements on this driver by referring
to the changes made in PWM MTU3 driver. I will be sending
V15 soon.

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, February 28, 2023 3:08 PM
> To: Thierry Reding <thierry.reding@gmail.com>; Philipp Zabel
> <p.zabel@pengutronix.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>; linux-pwm@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>; Chris Paterson <Chris.Paterson2@renesas.com>;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; linux-
> renesas-soc@vger.kernel.org
> Subject: [PATCH v14 3/4] pwm: Add support for RZ/G2L GPT
>=20
> RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
> (GPT32E). It supports the following functions
>  * 32 bits =D7 8 channels
>  * Up-counting or down-counting (saw waves) or up/down-counting
>    (triangle waves) for each counter.
>  * Clock sources independently selectable for each channel
>  * Two I/O pins per channel
>  * Two output compare/input capture registers per channel
>  * For the two output compare/input capture registers of each channel,
>    four registers are provided as buffer registers and are capable of
>    operating as comparison registers when buffering is not in use.
>  * In output compare operation, buffer switching can be at crests or
>    troughs, enabling the generation of laterally asymmetric PWM
> waveforms.
>  * Registers for setting up frame cycles in each channel (with
> capability
>    for generating interrupts at overflow or underflow)
>  * Generation of dead times in PWM operation
>  * Synchronous starting, stopping and clearing counters for arbitrary
>    channels
>  * Starting, stopping, clearing and up/down counters in response to
> input
>    level comparison
>  * Starting, clearing, stopping and up/down counters in response to a
>    maximum of four external triggers
>  * Output pin disable function by dead time error and detected
>    short-circuits between output pins
>  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
>  * Enables the noise filter for input capture and external trigger
>    operation
>=20
> This patch adds basic pwm support for RZ/G2L GPT driver by creating
> separate logical channels for each IOs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v13->v14:
>  * Removed parenthesis for RZG2L_MAX_HW_CHANNELS and
> RZG2L_CHANNELS_PER_IO
>  * Removed duty_cycle variable from struct rzg2l_gpt_chip and added
> comment
>    for cache for prescale variable.
>  * Fixed a bug in rzg2l_gpt_cntr_need_stop().
>  * Reordered rzg2l_gpt_config() just above apply()
>  * Replaced pwm_is_enabled()->pwm->state.enabled in config
>  * Replaced pm_runtime_resume_and_get with unconditional
> pm_runtime_get_sync()
>    in config().
>  * Restored duty_cycle > period check in rzg2l_gpt_get_state().
>  * Added error check for clk_prepare_enable() in probe() and propagating
> error
>    to the caller for pm_runtime_resume()
>  * clk_get_rate() is called after enabling the clock and
> clk_rate_exclusive_get()
>  * Simplified rzg2l_gpt_probe() by removing bitmap variables.
>  * Added pm_runtime_idle() to suspend the device during probe.
>  * Moved overflow condition check from config->probe().
>  * Simplified rzg2l_gpt_reset_assert_pm_disable().
> v12->v13:
>  * Replaced Kconfig dependency from ARCH_RENESAS->ARCH_RZG2L
>  * Sorted #include <linux/limits.h> alphabetically
>  * Added a comment for mutex_lock to fix check patch warning
>  * Replaced data type of duty_cycle from unsigned int->u32 as
>    the maximum value stored is U32_MAX.
>  * Improved rzg2l_gpt_config() by removing unwanted duty_cycle related
> code.
>  * Improved rzg2l_gpt_get_state() by setting "val =3D rzg2l_gpt-
> >duty_cycle[pwm->hwpwm];",
>    and factor "tmp =3D NSEC_PER_SEC * (u64)val;" out of the if-statement.
>  * Started using DEFINE_RUNTIME_DEV_PM_OPS(), and dropped __maybe_unused
>    from the callbacks.
> v11->v12:
>  * Added return code for get_state()
>  * Cache duty cycle/prescale as the driver cannot read the current duty
>    cycle/prescale from the hardware if the hardware is disabled. Cache
> the
>    last programmed duty cycle/prescale value to return in that case.
>  * Updated rzg2l_gpt_enable to enable the clocks.
>  * Updated rzg2l_gpt_disable to disable the clocks.
>  * Updated rzg2l_gpt_config() to cache duty cucle/prescale value
>  * Updated rzg2l_gpt_get_state to use cached value of duty
> cycle/prescale,If the PWM
>    is disabled.
>  * Simplified rzg2l_gpt_apply()
>  * Added comments in rzg2l_gpt_reset_assert_pm_disable()
> v10->v11:
>  * Used bitmap_zero for initializing bitmap varable.
>  * Fixed clock imbalance during remove for the case bootloader turning
>    on PWM and module unload is called just after the boot.
>  * Fixed over flow condition in get_state() for a prescale value of 2 &
> more.
>  * Improved rzg2l_gpt_cntr_need_stop() based on prescale as it is the
>    only runtime variable.
>  * Added array for Cache variables state_period and prescale
>  * Probe caches the prescale value set by the bootloader.
>  * Updated rzg2l_gpt_config() to make use of array variables.
> v9->v10:
>  * Updated the error handling in probe(), clk_disable_unprepare called
>    on the error path.
>  * Removed ch_en array and started using bitmask instead.
> v8->v9:
>  * deassert after devm_clk_get() to avoid reset stays deasserted,in case
>    clk_get() fails.
>  * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
>  * Updated error handling in probe()
> v7->v8:
>  * Modelled as single PWM device handling multiple channels
>  * Replaced shared reset->devm_reset_control_get_exclusive()
>  * Replaced iowrite32->writel and ioread32->readl
>  * Updated prescale calculation
>  * Added PM runtime callbacks
>  * Updated PM handling and removed "pwm_enabled_by_bootloader" variable
>  * Introduced rzg2l_gpt_is_ch_enabled for checking enable status on both
>    IO's
>  * Moved enable/disable output pins from config->enable/disable.
>  * Added rzg2l_gpt_cntr_need_stop() for caching prescalar/mode values.
> v6->v7:
>  * Added the comment for cacheing rzg2l_gpt->state_period.
>  * Fixed boundary values for pv and dc.
>  * Added comment for modifying mode, prescaler, timer counter and buffer
> enable
>    registers.
>  * Fixed buffer overflow in get_state()
>  * Removed unnecessary assignment of state->period value in get_state().
>  * Fixed state->duty_cycle value in get_state().
>  * Added a limitation for disabling the channels.
> v5->v6:
>  * Updated macros RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH and
>    RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH with computation
>    involving FIELD_PREP macro.
>  * Removed struct rzg2l_gpt_phase and started using RZG2L_GTCCR macro
>    for duty_offset.
>  * replaced misnomer real_period->state_period.
>  * Added handling for values >=3D (1024 << 32) for both period
>    and duty cycle.
>  * Added comments for pwm {en,dis}abled by bootloader during probe.
> v4->v5:
>  * Added Hardware manual details
>  * Replaced the comment GTCNT->Counter
>  * Removed the macros RZG2L_GPT_IO_PER_CHANNEL and chip.npwm directly
>    used in probe.
>  * Removed the unsed macro RZG2L_GTPR_MAX_VALUE
>  * Added driver prefix for the type name and the variable.
>  * Initialization of per_channel data moved from request->probe.
>  * Updated clr parameter for rzg2l_gpt_modify for Start count.
>  * Started using mutex and usage_count for handling shared
>    period and prescalar for the 2 channels.
>  * Updated the comment cycle->period.
>  * Removed clk_disable from rzg2l_gpt_reset_assert_pm_disable()
>  * Replaced pc->rzg2l_gpt.
>  * Updated prescale calculation.
>  * Moved pm_runtime_{get_sync,put} from {request,free}->{enable,disable}
>  * Removed platform_set_drvdata as it is unused
>  * Removed the variable pwm_enabled_by_bootloader
>  * Added dev_err_probe in various error paths in probe.
>  * Added an error message, if devm_pwmchip_add() fails.
> v3->v4:
>  * Changed the local variable type i from u16->u8 and prescaled_period_
>    cycles from u64->u32 in calculate_prescale().
>  * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div()
>  * Dropped the comma after the sentinel.
>  * Add a variable to track pwm enabled by bootloader and added comments
>    in probe().
>  * Removed unnecessary rzg2l_gpt_reset_assert_pm_disable() from probe.
>  * Replaced devm_clk_get()->devm_clk_get_prepared()
>  * Removed devm_clk_get_optional_enabled()
> v2->v3:
>  * Updated limitation section
>  * Added prefix "RZG2L_" for all macros
>  * Modified prescale calculation
>  * Removed pwm_set_chip_data
>  * Updated comment related to modifying Mode and Prescaler
>  * Updated setting of prescale value in rzg2l_gpt_config()
>  * Removed else branch from rzg2l_gpt_get_state()
>  * removed the err label from rzg2l_gpt_apply()
>  * Added devm_clk_get_optional_enabled() to retain clk on status,
>    in case bootloader turns on the clk of pwm.
>  * Replaced devm_reset_control_get_exclusive-
> >devm_reset_control_get_shared
>    as single reset shared between 8 channels.
> v1->v2:
>  * Added Limitations section
>  * dropped "_MASK" from the define names.
>  * used named initializer for struct phase
>  * Added gpt_pwm_device into a flexible array member in rzg2l_gpt_chip
>  * Revised the logic for prescale
>  * Added .get_state callback
>  * Improved error handling in rzg2l_gpt_apply
>  * Removed .remove callback
>  * Tested driver with PWM_DEBUG enabled
> RFC->V1:
>  * Updated macros
>  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
>  * Added rzg2l_gpt_read()
> ---
>  drivers/pwm/Kconfig         |  11 +
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c | 549 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 561 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> dae023d783a2..74cbc674d846 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -481,6 +481,17 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
>=20
> +config PWM_RZG2L_GPT
> +	tristate "Renesas RZ/G2L General PWM Timer support"
> +	depends on ARCH_RZG2L || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the General PWM Timer controller found in
> Renesas
> +	  RZ/G2L like chips through the PWM API.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-rzg2l-gpt.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS ||
> COMPILE_TEST diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 7bf1a29f02b8..cac39b18d1ee 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-
> poe.o
>  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> new file mode 100644 index 000000000000..f69c2507b4f6
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -0,0 +1,549 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L General PWM Timer (GPT) driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + *
> + * Hardware manual for this IP can be found here
> + *
> +https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-use
> +rs-manual-hardware-0?language=3Den
> + *
> + * Limitations:
> + * - Counter must be stopped before modifying Mode and Prescaler.
> + * - When PWM is disabled, the output is driven to inactive.
> + * - While the hardware supports both polarities, the driver (for now)
> + *   only handles normal polarity.
> + * - When both channels are used, disabling the channel on one stops
> the
> + *   other.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/time.h>
> +
> +#define RZG2L_GTCR		0x2c
> +#define RZG2L_GTUDDTYC		0x30
> +#define RZG2L_GTIOR		0x34
> +#define RZG2L_GTBER		0x40
> +#define RZG2L_GTCNT		0x48
> +#define RZG2L_GTCCRA		0x4c
> +#define RZG2L_GTCCRB		0x50
> +#define RZG2L_GTPR		0x64
> +
> +#define RZG2L_GTCR_CST		BIT(0)
> +#define RZG2L_GTCR_MD		GENMASK(18, 16)
> +#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
> +
> +#define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
> +
> +#define RZG2L_GTUDDTYC_UP	BIT(0)
> +#define RZG2L_GTUDDTYC_UDF	BIT(1)
> +#define RZG2L_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
> +
> +#define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> +#define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> +#define RZG2L_GTIOR_OAE		BIT(8)
> +#define RZG2L_GTIOR_OBE		BIT(24)
> +
> +#define RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE	0x07
> +#define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> +
> +#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> +RZG2L_GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH \
> +	(RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> +RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(FIELD_PREP(RZG2L_GTIOR_GTIOB,
> RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE) |
> +RZG2L_GTIOR_OBE) #define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH
> \
> +	(FIELD_PREP(RZG2L_GTIOR_GTIOB,
> RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE) |
> +RZG2L_GTIOR_OBE)
> +
> +#define RZG2L_GTCCR(i) (0x4c + 4 * (i))
> +
> +#define RZG2L_MAX_HW_CHANNELS	8
> +#define RZG2L_CHANNELS_PER_IO	2
> +#define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS *
> RZG2L_CHANNELS_PER_IO)
> +
> +#define RZG2L_IS_IOB(a) ((a) & 0x1)
> +#define RZG2L_GET_CH_INDEX(a) ((a) / 2)
> +
> +#define RZG2L_GET_CH_OFFS(i) (0x100 * (i))
> +
> +struct rzg2l_gpt_chip {
> +	struct pwm_chip chip;
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	struct clk *clk;
> +	struct mutex lock; /* lock to protect shared channel resources */
> +	unsigned long rate;
> +	u32 state_period[RZG2L_MAX_HW_CHANNELS];
> +	u32 user_count[RZG2L_MAX_HW_CHANNELS];
> +	/*
> +	 * Counter must be stopped before modifying prescaler. So update
> +	 * the register only if there is mismatch with cached value.
> +	 */
> +	u8 prescale[RZG2L_MAX_HW_CHANNELS];
> +};
> +
> +static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip
> +*chip) {
> +	return container_of(chip, struct rzg2l_gpt_chip, chip); }
> +
> +static void rzg2l_gpt_write(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg,
> +u32 data) {
> +	writel(data, rzg2l_gpt->mmio + reg);
> +}
> +
> +static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg) {
> +	return readl(rzg2l_gpt->mmio + reg);
> +}
> +
> +static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg,
> u32 clr,
> +			     u32 set)
> +{
> +	rzg2l_gpt_write(rzg2l_gpt, reg,
> +			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set); }
> +
> +static u8 rzg2l_gpt_calculate_prescale(struct rzg2l_gpt_chip
> *rzg2l_gpt,
> +				       u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	prescaled_period_cycles =3D period_cycles >> 32;
> +	if (prescaled_period_cycles >=3D 256)
> +		prescale =3D 5;
> +	else
> +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> +
> +	return prescale;
> +}
> +
> +static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u32 ch_index =3D RZG2L_GET_CH_INDEX(pwm->hwpwm);
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	rzg2l_gpt->user_count[ch_index]++;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u32 ch_index =3D RZG2L_GET_CH_INDEX(pwm->hwpwm);
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	rzg2l_gpt->user_count[ch_index]--;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +}
> +
> +static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt,
> +u8 ch) {
> +	u8 ch_index =3D RZG2L_GET_CH_INDEX(ch);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch_index);
> +	bool is_counter_running, is_output_en;
> +	u32 val;
> +
> +	val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> +	is_counter_running =3D val & RZG2L_GTCR_CST;
> +
> +	val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTIOR);
> +	if (RZG2L_IS_IOB(ch))
> +		is_output_en =3D val & RZG2L_GTIOR_OBE;
> +	else
> +		is_output_en =3D val & RZG2L_GTIOR_OAE;
> +
> +	return (is_counter_running && is_output_en); }
> +
> +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *rzg2l_gpt,
> +			    struct pwm_device *pwm)
> +{
> +	u8 ch_index =3D RZG2L_GET_CH_INDEX(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch_index);
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(rzg2l_gpt->chip.dev);
> +	if (rc)
> +		return rc;
> +
> +	/* Enable pin output */
> +	if (RZG2L_IS_IOB(pwm->hwpwm))
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> +				 RZG2L_GTIOR_GTIOB | RZG2L_GTIOR_OBE,
> +				 RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH);
> +	else
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> +				 RZG2L_GTIOR_GTIOA | RZG2L_GTIOR_OAE,
> +				 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH);
> +
> +	/* Start count */
> +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, 0, RZG2L_GTCR_CST);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
> +			      struct pwm_device *pwm)
> +{
> +	u8 ch_index =3D RZG2L_GET_CH_INDEX(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch_index);
> +
> +	/* Disable pin output */
> +	if (RZG2L_IS_IOB(pwm->hwpwm))
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> RZG2L_GTIOR_OBE, 0);
> +	else
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> RZG2L_GTIOR_OAE, 0);
> +
> +	/* Stop count, Output low on GTIOCx pin when counting stops */
> +	if (rzg2l_gpt->user_count[ch_index] <=3D 1)
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR,
> RZG2L_GTCR_CST, 0);
> +
> +	pm_runtime_put_sync(rzg2l_gpt->chip.dev);
> +}
> +
> +static bool rzg2l_gpt_cntr_need_stop(struct rzg2l_gpt_chip *rzg2l_gpt,
> u32 ch,
> +				     u8 prescale)
> +{
> +	u8 ch_index =3D RZG2L_GET_CH_INDEX(ch);
> +
> +	return rzg2l_gpt->prescale[ch_index] !=3D prescale; }
> +
> +static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device
> *pwm,
> +			       struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u32 ch_index =3D RZG2L_GET_CH_INDEX(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch_index);
> +	u8 prescale;
> +	u64 tmp;
> +	u32 val;
> +
> +	pm_runtime_get_sync(chip->dev);
> +	val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> +	state->enabled =3D rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
> +	if (state->enabled) {
> +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTPR);
> +		tmp =3D NSEC_PER_SEC * (u64)val;
> +		state->period =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate) << (2
> * prescale);
> +		val =3D rzg2l_gpt_read(rzg2l_gpt,
> +				     offs + RZG2L_GTCCR(RZG2L_IS_IOB(pwm-
> >hwpwm)));
> +
> +		tmp =3D NSEC_PER_SEC * (u64)val;
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate)
> << (2 * prescale);
> +	}
> +
> +	if (state->duty_cycle > state->period)
> +		state->duty_cycle =3D state->period;
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u8 ch_index =3D RZG2L_GET_CH_INDEX(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch_index);
> +	bool is_counter_running;
> +	unsigned long pv, dc;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u8 prescale;
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, so prescale and
> period
> +	 * can NOT be modified when there are multiple channels in use
> with
> +	 * different settings.
> +	 */
> +	if (state->period !=3D rzg2l_gpt->state_period[ch_index] &&
> +	    rzg2l_gpt->user_count[ch_index] > 1)
> +		return -EBUSY;
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, we cache the period
> value
> +	 * from the first enabled channel and use the same value for both
> +	 * channels.
> +	 */
> +	rzg2l_gpt->state_period[ch_index] =3D state->period;
> +
> +	period_cycles =3D mul_u64_u32_div(state->period, rzg2l_gpt->rate,
> NSEC_PER_SEC);
> +	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_cycles);
> +
> +	if (period_cycles >> (2 * prescale) <=3D U32_MAX)
> +		pv =3D period_cycles >> (2 * prescale);
> +	else
> +		pv =3D U32_MAX;
> +
> +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rzg2l_gpt->rate,
> NSEC_PER_SEC);
> +	if (duty_cycles >> (2 * prescale) <=3D U32_MAX)
> +		dc =3D duty_cycles >> (2 * prescale);
> +	else
> +		dc =3D U32_MAX;
> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register.
> +	 */
> +	if (!pwm->state.enabled)
> +		pm_runtime_get_sync(chip->dev);
> +
> +	/*
> +	 * Counter must be stopped before modifying mode, prescaler, timer
> +	 * counter and buffer enable registers. These registers are shared
> +	 * between both channels. So allow updating these registers only
> for the
> +	 * first enabled channel.
> +	 */
> +	if (rzg2l_gpt->user_count[ch_index] <=3D 1 &&
> +	    rzg2l_gpt_cntr_need_stop(rzg2l_gpt, pwm->hwpwm, prescale))
> +		rzg2l_gpt_modify(rzg2l_gpt,
> +				 offs + RZG2L_GTCR, RZG2L_GTCR_CST, 0);
> +
> +	is_counter_running =3D rzg2l_gpt_read(rzg2l_gpt,
> +					    offs + RZG2L_GTCR) & RZG2L_GTCR_CST;
> +	if (!is_counter_running)
> +		/* GPT set operating mode (saw-wave up-counting) */
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR,
> RZG2L_GTCR_MD,
> +				 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> +
> +	/* Set count direction */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTUDDTYC,
> RZG2L_UP_COUNTING);
> +	if (!is_counter_running) {
> +		/* Select count clock */
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR,
> RZG2L_GTCR_TPCS,
> +				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> +		rzg2l_gpt->prescale[ch_index] =3D prescale;
> +	}
> +
> +	/* Set period */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTPR, pv);
> +
> +	/* Set duty cycle */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCCR(RZG2L_IS_IOB(pwm-
> >hwpwm)),
> +			dc);
> +	if (!is_counter_running) {
> +		/* Set initial value for counter */
> +		rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCNT, 0);
> +
> +		/* Set no buffer operation */
> +		rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTBER, 0);
> +	}
> +
> +	/* If the PWM is not enabled, turn the clock off again to save
> power. */
> +	if (!pwm->state.enabled)
> +		pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	bool enabled =3D pwm->state.enabled;
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		if (enabled)
> +			rzg2l_gpt_disable(rzg2l_gpt, pwm);
> +
> +		return 0;
> +	}
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	ret =3D rzg2l_gpt_config(chip, pwm, state);
> +	mutex_unlock(&rzg2l_gpt->lock);
> +	if (ret)
> +		return ret;
> +
> +	if (!enabled)
> +		ret =3D rzg2l_gpt_enable(rzg2l_gpt, pwm);
> +
> +	return ret;
> +}
> +
> +static const struct pwm_ops rzg2l_gpt_ops =3D {
> +	.request =3D rzg2l_gpt_request,
> +	.free =3D rzg2l_gpt_free,
> +	.get_state =3D rzg2l_gpt_get_state,
> +	.apply =3D rzg2l_gpt_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static const struct of_device_id rzg2l_gpt_of_table[] =3D {
> +	{ .compatible =3D "renesas,rzg2l-gpt", },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
> +
> +static int rzg2l_gpt_pm_runtime_suspend(struct device *dev) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(rzg2l_gpt->clk);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_pm_runtime_resume(struct device *dev) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D dev_get_drvdata(dev);
> +
> +	return clk_prepare_enable(rzg2l_gpt->clk);
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(rzg2l_gpt_pm_ops,
> +				 rzg2l_gpt_pm_runtime_suspend,
> +				 rzg2l_gpt_pm_runtime_resume, NULL);
> +
> +static void rzg2l_gpt_reset_assert_pm_disable(void *data) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D data;
> +	u32 i;
> +
> +	/*
> +	 * The below check is for making balanced PM usage count
> +	 * eg: boot loader is turning on PWM and probe increments the PM
> usage
> +	 * count. Before apply, if there is unbind/remove callback we need
> to
> +	 * decrement the PM usage count.
> +	 */
> +	pm_runtime_get_sync(rzg2l_gpt->chip.dev);
> +	for (i =3D 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i))
> +			pm_runtime_put(rzg2l_gpt->chip.dev);
> +	}
> +
> +	pm_runtime_put(rzg2l_gpt->chip.dev);
> +	clk_rate_exclusive_put(rzg2l_gpt->clk);
> +	pm_runtime_disable(rzg2l_gpt->chip.dev);
> +	pm_runtime_set_suspended(rzg2l_gpt->chip.dev);
> +	reset_control_assert(rzg2l_gpt->rstc);
> +}
> +
> +static int rzg2l_gpt_probe(struct platform_device *pdev) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt;
> +	u32 ch_index, offs, val;
> +	int ret;
> +	u32 i;
> +
> +	rzg2l_gpt =3D devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt),
> GFP_KERNEL);
> +	if (!rzg2l_gpt)
> +		return -ENOMEM;
> +
> +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rzg2l_gpt->mmio))
> +		return PTR_ERR(rzg2l_gpt->mmio);
> +
> +	rzg2l_gpt->rstc =3D devm_reset_control_get_exclusive(&pdev->dev,
> NULL);
> +	if (IS_ERR(rzg2l_gpt->rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> +				     "get reset failed\n");
> +
> +	rzg2l_gpt->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> +				     "cannot get clock\n");
> +
> +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot deassert reset control\n");
> +
> +	ret =3D clk_prepare_enable(rzg2l_gpt->clk);
> +	if (ret)
> +		goto err_reset;
> +
> +	clk_rate_exclusive_get(rzg2l_gpt->clk);
> +	rzg2l_gpt->rate =3D clk_get_rate(rzg2l_gpt->clk);
> +
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflow later for
> computing
> +	 * period and duty cycle.
> +	 */
> +	if (rzg2l_gpt->rate > NSEC_PER_SEC) {
> +		ret =3D -EINVAL;
> +		goto err_clk_rate_put;
> +	}
> +
> +	mutex_init(&rzg2l_gpt->lock);
> +	platform_set_drvdata(pdev, rzg2l_gpt);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> +
> +	/*
> +	 *  We need to keep the clock on, in case the bootloader has
> enabled the
> +	 *  PWM and is running during probe().
> +	 */
> +	for (i =3D 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i)) {
> +			ch_index =3D RZG2L_GET_CH_INDEX(i);
> +			offs =3D RZG2L_GET_CH_OFFS(ch_index);
> +			val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> +			rzg2l_gpt->prescale[ch_index] =3D
> FIELD_PREP(RZG2L_GTCR_TPCS,
> +								   val);
> +			pm_runtime_get_sync(&pdev->dev);
> +		}
> +	}
> +
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rzg2l_gpt_reset_assert_pm_disable,
> +				       rzg2l_gpt);
> +	if (ret < 0)
> +		return ret;
> +
> +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> +	rzg2l_gpt->chip.npwm =3D RZG2L_MAX_PWM_CHANNELS;
> +	ret =3D devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM
> chip\n");
> +
> +	pm_runtime_idle(&pdev->dev);
> +
> +	return 0;
> +
> +err_clk_rate_put:
> +	clk_rate_exclusive_put(rzg2l_gpt->clk);
> +	clk_disable_unprepare(rzg2l_gpt->clk);
> +err_reset:
> +	reset_control_assert(rzg2l_gpt->rstc);
> +	return ret;
> +}
> +
> +static struct platform_driver rzg2l_gpt_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-rzg2l-gpt",
> +		.pm =3D pm_ptr(&rzg2l_gpt_pm_ops),
> +		.of_match_table =3D of_match_ptr(rzg2l_gpt_of_table),
> +	},
> +	.probe =3D rzg2l_gpt_probe,
> +};
> +module_platform_driver(rzg2l_gpt_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT) Driver");
> +MODULE_LICENSE("GPL"); MODULE_ALIAS("platform:pwm-rzg2l-gpt");
> --
> 2.25.1

