Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED3066213B
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Jan 2023 10:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbjAIJRv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Jan 2023 04:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbjAIJR1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Jan 2023 04:17:27 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2122.outbound.protection.outlook.com [40.107.114.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A78719C07;
        Mon,  9 Jan 2023 01:13:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhJxjqUHBZRZz5fOjc4IepZ0rPRwltQvSIBg2JV5nzK8poo08YeoV1ihPKAzSjmGVxNJE0DQyNqkB+jAVLE4adt5uHCC0HFyPFAuosS5m7ZhxPZsmImlZZn3oSJSNCIHY++59NMYtLU4/BxXL2anj2f5sDXzYeIohDysGHJzrnpN57WLgDP1iZaRDBCFL8gXnxwfezhqjggZWE7fXUY6S/RbFykOxatsri0QKek+15+9KA5vidaXQNIdvS8/piuv7BbTkBTHQO/a/zGVICbcOyjx9Ffy++Pf9rtO4jK4C+sJtujmvYwGaQk8kKsSX+vietmem8gC5aKzlfXUtNIJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNZ8jcevdL81Od67+iMw3841zMxKZ05oDhnu38iWciU=;
 b=AwrnOFvK5arAkS0JQoTslDfj/bGBtLf9517iaIZVDRLLBQtgpKcCQoYcAhzQBhuY661gB4FtN8xvTp34aSV6EOnXfz4vka1xt97KOwTZNYV1WwBxvFsH/mr6AiMsMaLrMZe8Nf6Jbsry73ZSNznPzTPA4n5hh+QGLXRwOzFyQdWxvz2RRnGezhBL+iso5PmzrgRZO01eAivHmDBIUs+4wnJ15JvdJgchZt/40J+WSzORB6qHFSkoogagNUxTBQYn9U4OAr2AIbtu8YTcFsqm3O/db840LSC6XL6/DBqb/Xhuc5evemt5KLypYUOYEj/M7eEbjCQBjEoc2vIF42/jOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNZ8jcevdL81Od67+iMw3841zMxKZ05oDhnu38iWciU=;
 b=k0P8RNR/fRQx4r8jyF44QyRZI0JG/1+eYwgsgr115urVkTYQDC8ZRUXr6Um1ckn2ChLv3k9TcqOf16QuIShai4GFZ3MBRR/HbkuEHms8QCXiR5aErJ1sSDgEwzEktVSj3OPzCSJ9srk/IPPSLdzHN9mzy3Wu1rxjitskNVrih1c=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYBPR01MB5376.jpnprd01.prod.outlook.com (2603:1096:404:8021::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 09:13:24 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%3]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 09:13:24 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v12 0/2] Add support for RZ/G2L GPT
Thread-Topic: [PATCH v12 0/2] Add support for RZ/G2L GPT
Thread-Index: AQHZD78kcJ2lt4Fb/0OmygdyX7iJWa6V9JSA
Date:   Mon, 9 Jan 2023 09:13:24 +0000
Message-ID: <OS0PR01MB5922046A0C08D732681E36E386FE9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221214132232.2835828-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221214132232.2835828-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYBPR01MB5376:EE_
x-ms-office365-filtering-correlation-id: fc690d47-6cfb-4909-7433-08daf221c301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jdm1GlksWeOerVxaFV+e/v/xSYFI8CT6KadvpQvo1mmiHy+mu6rG+vPS49961IeqdCu9rIfJ2jpsSbCFRL9voMQYXXp58uhrEDgzaNzE7zcVv0pbQDU9CzI49GYD7pnZFrHfsXjcYhe9+coA0ZeQ3ojX6IFQpX//ppOevtESrFFq4m6yud3mmrFKOEf71hTGHfw5vtCUmp+GTz55M0N3f0kIP3PKfy0RQjYy+cCEswlRE3vEV8JhBIiE4qlbdJEoeekG+CtEj3m/LGadQtdSSRyBo7F4cuRAxqzsrRmFykTTSHWDCdHa97DrKy586+WbQqXfzM+PVlIdMsPkqzHYSCKk/W/RGSP355LpBLfD49gw0uEzLhQ67V55f/fFhZcrSYy2ngxjZiM7is0v4wvBIydsVUd6byF0GtJaeeGw/4/1gY+8ZgLETAwJBwmMdRQGPXApQbnhMdyDUzH5PpdWimbWb4A/URf9AvBn48+CeTwsRvgX9EQXH7kFogFqBIHmOG/xKAraoz94RN/Idvcl4dhsatVrlQwUvQ6qWQkCxx0aYjAh2dNUCnQrXahEehpVNy6HlFz7nAz5SFLxLdMGtPf5cnFjvbDCR6OKk5XPTjmZSfKFLZN6xMFD+VnfxoLI1+BQaMGwQLLdhW/YSul43UhhjBYzsk9wE3t+w0sPNIUD7GBEBJ3Bvi4hIgNNzdE3FzDiqefqK0MA3iCSbnvaDuXSP+ja+GsmpEcuu3wT7j0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(52536014)(41300700001)(8936002)(5660300002)(2906002)(66946007)(8676002)(66446008)(64756008)(66556008)(66476007)(76116006)(45080400002)(316002)(7696005)(71200400001)(110136005)(54906003)(33656002)(966005)(6506007)(478600001)(26005)(9686003)(4326008)(186003)(55016003)(86362001)(83380400001)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zDcZAJZFgEacBrsKGg3zhhYsymLer5c7zJJi84htQ32z4qjoKQtfhgyavz?=
 =?iso-8859-1?Q?r2ndmb6kNdBh6DDDasqnfESyAs6akFduIB9FaRE/ATY7fDy01cgsc+CqIF?=
 =?iso-8859-1?Q?iO1o03MrKv8DIC/eyMg9f9RYdPS0QBnkFRU15R2JzeHpO+J5VCpUes5pic?=
 =?iso-8859-1?Q?2ue0pHxmq2Wn4BhIyyJuxdOMEPQHtEqi8OywsTfw7wpza3oy+BO9vR3SsF?=
 =?iso-8859-1?Q?L0UOFYHnPbEyG83M7vg437RYmUTzpHcSfA4n/pHqwnmKts9blMGCe/Juej?=
 =?iso-8859-1?Q?wMpP3ccAgRxdXbZQ8UUvR7YDjl7rI8gvBDHtGGmj3Bd/6Vp7QZ1jYDqVRe?=
 =?iso-8859-1?Q?dQ8wdym0pTHvATaTmU3IjvQ7hqw4R7NryrcpzOHfB+AcrM8kNMrdU9+x6j?=
 =?iso-8859-1?Q?slSJos867geJwIsdaXGfnxN7re2zJo/yuB9mW5flnkunLDx0rFn75TiIWq?=
 =?iso-8859-1?Q?0QPTgE9hOw+ofXYF9a92b85vGYeNec+SM1hcRSCBTjU1bmvQw4Fjw2n9Tx?=
 =?iso-8859-1?Q?o6yJrUjZw55posktdpHbFA+zO40b2FFuCGrpnlSb774gpeIBSS17r4QXUh?=
 =?iso-8859-1?Q?trUYRf6HXr1EgoJ4gqsYVFpc+J80zrILweYForx1DdKC8khlB9kRjzN9G+?=
 =?iso-8859-1?Q?YJJ9QUUoVJT1ysyBA65lZaXIj/DqHiciskEqipf6mTqRFEQojhGzkMvvRn?=
 =?iso-8859-1?Q?kG9NcrhYIGyk5qtG2fx0eF8GwRJeWOFDRHllgdcKdoqhzNzxrJQ/6hbkXE?=
 =?iso-8859-1?Q?YUKKD3F02+u6m/3M5I0GjO40n5tNufdRrlBF+HOFSxWLfwBuXDwOyO8Y1S?=
 =?iso-8859-1?Q?UkDnxo+rGz7NJTPDrErtGyVJMMuHgLLLisSjYR2XloG0lxVMmV+wupetWY?=
 =?iso-8859-1?Q?JYSsb2R0fBiJ+47LV3w1sLU5kABM8/XiytVKmtxf2oVvokWrrOdgbaFKCj?=
 =?iso-8859-1?Q?DDfL6kHjq2gYEW0itVua3JvYk+Vg2DCHEGWcsmbthe+zX0CUo8gi1hfxKh?=
 =?iso-8859-1?Q?nievpnSRUtNlpDanafXkmrv0GubffNNPcYw1bZHRum2weknG/+54lRGbDK?=
 =?iso-8859-1?Q?fB4MXkEUHt92EMaEgzBrtXxt47JEalnf2B5VIEjG1rHIRM8mrfTE78NZlx?=
 =?iso-8859-1?Q?rt3M9F/vGL/bgNJaI3OWbRn6zYxTHN+EMiigo86/e6T6q3omvN0XUv/T96?=
 =?iso-8859-1?Q?KCW53sLHXxPwZDMXDjWYp/HfArEgJaEjE5nz8yYYW2kIEmS5oRs5zrbpTL?=
 =?iso-8859-1?Q?LCoDSeYbsL8sM0keL6INRViP68kRop/b+xTneu+/AzvpeElhvtOXhAUnBw?=
 =?iso-8859-1?Q?WuvTODzOUU/5ZULR4x3wpM3y+wl2jlicEHe1WEohgbNkQsT9TT+qqDYf54?=
 =?iso-8859-1?Q?UMxE3IKmGtrJpW50hHblAxZEBu+6jAwZAMYQDGTEtHtBax92XCFWoFr4C5?=
 =?iso-8859-1?Q?nrVuH9wCz6ZuICTERmLIOxQlRnjGSbJ26Mpdy1L7DuVSFuI2mMHjpyG2vk?=
 =?iso-8859-1?Q?DaHT4dLvqEprjumJnyIDOZmT3Lc+t9AMXggL05qQxz5gtIuIbTGncYpGFo?=
 =?iso-8859-1?Q?BrglNglYZqkaDDGJ80+i/qThmQijLVB0ylGqtyXsZQ+RaNDGxXmWYr/5Yw?=
 =?iso-8859-1?Q?stnqBmunL0ZnC7Cgl7CmKxNrIgf3ip2AMNOP3y/nExVmO+5mvQyxsN0A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc690d47-6cfb-4909-7433-08daf221c301
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 09:13:24.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hu7Wo9AwSoIlIwo+wXDPGV/0DA/2dGRYRuHuiP7rl/C4lSESwtZosJK3tdDXIl3QYBHPO/dws2gFxZ6aX8YwbDN5iKPcgPE7+tN+Q+waG38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5376
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

> Subject: [PATCH v12 0/2] Add support for RZ/G2L GPT
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
>    troughs, enabling the generation of laterally asymmetric PWM waveforms=
.
>  * Registers for setting up frame cycles in each channel (with capability
>    for generating interrupts at overflow or underflow)
>  * Generation of dead times in PWM operation
>  * Synchronous starting, stopping and clearing counters for arbitrary
>    channels
>  * Starting, stopping, clearing and up/down counters in response to input
>    level comparison
>  * Starting, clearing, stopping and up/down counters in response to a
>    maximum of four external triggers
>  * Output pin disable function by dead time error and detected
>    short-circuits between output pins
>  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
>  * Enables the noise filter for input capture and external trigger
>    operation
>=20
> This patch series aims to add basic pwm support for RZ/G2L GPT driver by
> creating separate logical channels for each IOs.
>=20
> v11->v12:
>  * Added return code for get_state()
>  * Cache duty cycle/prescale as the driver cannot read the current duty
>    cycle/prescale from the hardware if the hardware is disabled. Cache th=
e
>    last programmed duty cycle/prescale value to return in that case.
>  * Updated rzg2l_gpt_enable to enable the clocks.
>  * Updated rzg2l_gpt_disable to disable the clocks.
>  * Updated rzg2l_gpt_config() to cache duty cucle/prescale value
>  * Updated rzg2l_gpt_get_state to use cached value of duty cycle/prescale=
,If
> the PWM
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
>  * Updated the example gpt4: pwm@10048400-> gpt: pwm@10048000
>  * Keep Rb tag from Rob as the above change is trivial one.
>  * Updated the error handling in probe(), clk_disable_unprepare called
>    on the error path.
>  * Removed ch_en array and started using bitmask instead.
> v8->v9:
>  * Added Rb tag from Rob.
>  * deassert after devm_clk_get() to avoid reset stays deasserted,in case
>    clk_get() fails.
>  * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
>  * Updated error handling in probe()
> v7->v8:
>  * Removed Rb tags from Rob and Geert as it modelled as single GPT
>    device handling multiple channels.
>  * Updated description
>  * Updated interrupts and interrupt-names properties
>  * Updated binding example
>  * Modelled as single PWM device handling multiple channels
>  * Replaced shared reset->devm_reset_control_get_exclusive()
>  * Added PM runtime callbacks
>  * Updated PM handling and removed "pwm_enabled_by_bootloader" variable
>  * Replaced iowrite32->writel and ioread32->readl
>  * Updated prescale calculation
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
>  * Added a limitation for disabling the channels, when both channels used
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
>  * Added dev_err_probe in various probe error path.
>  * Added an error message, if devm_pwmchip_add fails.
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
>  * Added Rb tag from Rob for the bindings.
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
>  * Replaced devm_reset_control_get_exclusive->devm_reset_control_get_shar=
ed
>    as single reset shared between 8 channels.
> V1->v2:
>  * Added '|' after 'description:' to preserve formatting.
>  * Removed description for pwm_cells as it is common property.
>  * Changed the reg size in example from 0xa4->0x100
>  * Added Rb tag from Geert for bindings.
>  * Added Limitations section
>  * dropped "_MASK" from the define names.
>  * used named initializer for struct phase
>  * Added gpt_pwm_device into a flexible array member in rzg2l_gpt_chip
>  * Revised the logic for prescale
>  * Added .get_state callback
>  * Improved error handling in rzg2l_gpt_apply
>  * Removed .remove callback
>  * Tested the driver with PWM_DEBUG enabled.
>=20
> RFC->v1:
>  * Added Description in binding patch
>  * Removed comments from reg and clock
>  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
>  * Added rzg2l_gpt_read() and updated macros
>  * Removed dtsi patches, will send it separately
>=20
> RFC:
>  *
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kerne
> l.org%2Flinux-renesas-soc%2F20220430075915.5036-1-
> biju.das.jz%40bp.renesas.com%2FT%2F%23t&data=3D05%7C01%7Cbiju.das.jz%40bp=
.rene
> sas.com%7C7c8baf2b02984371f2c308daddd64607%7C53d82571da1947e49cb4625a166a=
4a2
> a%7C0%7C0%7C638066209617005815%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD=
AiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DUmY=
bVZnI
> qFciTNH2VvVMviGWZrNNLu412C2yhzt%2FnkA%3D&reserved=3D0
>=20
> Biju Das (2):
>   dt-bindings: pwm: Add RZ/G2L GPT binding
>   pwm: Add support for RZ/G2L GPT
>=20
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 378 ++++++++++++
>  drivers/pwm/Kconfig                           |  11 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c                   | 570 ++++++++++++++++++
>  4 files changed, 960 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-
> gpt.yaml
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>=20
> --
> 2.25.1

