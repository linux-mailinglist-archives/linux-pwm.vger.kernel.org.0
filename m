Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F341637E06
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Nov 2022 18:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiKXRGj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Nov 2022 12:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKXRGi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Nov 2022 12:06:38 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA80442FE;
        Thu, 24 Nov 2022 09:06:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XT4VJeL1m1te6Dbn9MF+BvDhRShYfHjuFgnLo8iNecEjtNZDj8wkuZK2BdSFbDg3IHIYAt8ufyGRmcgwkUJSQFYWCRJmLBh2TGSgjqdwDBZWaSO/0NUaxsehWELrWwkuzFomqYNK6WYuV83XgbXU838jxV272uU5pjHKkW0tE5R/SiNWFI2+N2a535MPVPWd1kwA38P8j/ahP0Bg0wxSSypq18DaPDfHmI2G+UgnDcVHjig4ltTKnUWJMn7/kXkgqCsEdL017CSJjuCji1wlgCAB7J0v6U1hqYUoof/Dk14kHp1C11shnggAE/eYYnSvV1RYEJLsvWN0/AyNAOrkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NW3FCPUzF/VGJpTfOLbJHaTew6ArHrnIbR59OpXpP4s=;
 b=bbgHhlT2GjzxaWtcdLl5HkG/2WwCrtXwwItNh7HndrPbO4Qd1OvU/Fsh8glavvnFw6VjyNMtTu52FTAOGocVO40QLm+0iJGJiKDYPZUdGO3URl7cLOZgeH5JAXLIxkFe0v/2C+qqGwLrSA6rormtS4BBztidlFmL7IG1DFr6VRwEWJbD/1GrYjaXXLdDDLSQuPt9wxcCPoMlCGLcrqd8WwiQQdF66Mp1EE2mf87r9PshgnpXQexgpIje5nj66xFypGuqcXokjYnGYhMFP/mNMHRr3CRUpXhcDfWhS9xm/m89e+0Z1lBFJ1JK2LshvHQcs+VR+cglvfCgBRKZctDd7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW3FCPUzF/VGJpTfOLbJHaTew6ArHrnIbR59OpXpP4s=;
 b=Nx4zGONizI9gaWu2/gnE0TpYHb1yQTZS+QXdMVGyfofgg2t78rPqSUIU4Jd19IAB+5m99EI1q971VtUX/1cq1StFnnRTn1ckk84nRYsDhG12dHx/jcpPoRpCPOD65+n5WcjyMOktf9HXyJP53gB30dCRKpYH/pnYt5Q1hJ+niZw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5530.jpnprd01.prod.outlook.com (2603:1096:404:803b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Thu, 24 Nov
 2022 17:06:32 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%6]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 17:06:32 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v11 0/2] Add support for RZ/G2L GPT
Thread-Topic: [PATCH v11 0/2] Add support for RZ/G2L GPT
Thread-Index: AQHY9enyZIO4nqEIHEqv2jUwQbH4J65OYflg
Date:   Thu, 24 Nov 2022 17:06:32 +0000
Message-ID: <OS0PR01MB59224828217BC94EAD786303860F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221111162325.471963-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221111162325.471963-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5530:EE_
x-ms-office365-filtering-correlation-id: 18ca7633-fa95-4701-3081-08dace3e3c5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U0TVViUYCkXZ8Y9HgUG7Onth8LYREHGmQRoPicYk8WCcOigWo4KTfcCk6Cj9BaHYcMtvXY7yLcGnhd0awxaytxj5ZhElFvG60dFpCaHgSK5pcKiAUgDBl3UBuxtjeXqLZs2B1FtcCTv88Ybei7eVvFT76Js6IKbr0VsjwyqMfprQrZMJTi1GzobDhXKsTlOp60GSbsT+gzyNK45SLXCG//SCZvBc27Slk6ld88b5zHSpuHrfiIlyxfS1sbSxx2vc7Cgk8XsFXfDJWLn4+f7P0WTQ6lyoqiRKBmHpH+uqGHUeVq07IUs89opjYjhVog+Jvwl/O0s6U3B7GP75wMl1P1/Ov1Gby68HeR3NPf8Bld609+7akAx8ar1EprkuDnzFXxEw2R9jKFOQb2UwIxNt/mKDjqftRrE3i1AGbnnzTjdOKIiQ0ojtrZLWNbx3iCrqu6NngeZgUlhhGbfpB/0I9CmfcEa118nuV/HkrikgDvqc0Q02+KNQvfrGexukvRxkkLcyQPMM0XW9GFrD5w+hOROCUP3CFu68eE8ASANDoaClLgH1D8cHTPUPNVWSVcb3EMCDDn5SBUj4qDZEdIcrR+46e6Z1yOWDSHknjHMWCbY4y5gGjC1j+Eq0meM7nfkZDshBPqtZm63QOaevxCeINE+lJ8bHURFx2UMKR9lzipK3Kt8nRiqstg5M5YQ391ZtalsfedTravteQMvk8Mc+qCF4o4ASsniNsObfCq+MfnI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(316002)(6506007)(7696005)(33656002)(186003)(26005)(9686003)(71200400001)(478600001)(966005)(54906003)(45080400002)(110136005)(38100700002)(122000001)(55016003)(38070700005)(86362001)(83380400001)(66446008)(66556008)(76116006)(66946007)(64756008)(4326008)(8676002)(52536014)(66476007)(8936002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tVXgpKDy1XbT0v2Iy3L7M7kqnu+swO8I89rgUfAuiw6VJHggWSyQ29H9OV?=
 =?iso-8859-1?Q?yDP+pG3a+xVPrIPwU5QET5t/bOWLbvFXJ3BPDRcWc7yj8SnyGhCEeQ4a5k?=
 =?iso-8859-1?Q?XoFX65xzndKkJi4VYS42xLYIwxJQqgNvJ5JzQo6SR042HFQXqyfOmJX1Pr?=
 =?iso-8859-1?Q?n+Zfkkoap35bXFKSDXxfKL6ZR07fZporA5+QoMyeiyeOpM4yfT3VSElvcD?=
 =?iso-8859-1?Q?n89IX2ldQQ2XZ9ACupZ9vlQiEWPNX5DFmiRCP7bpSXTlMeGpBwD9yqbO4i?=
 =?iso-8859-1?Q?FH61Nr4c9LyczvkeFD2BPC3rfSVqEF0IRtx4KxM9YQE3GcT6t8oYjhRRBz?=
 =?iso-8859-1?Q?WLKMhh9gJWtDN7dFEzlrKIdkhsGNbgaa5m/90XBh5UFYXnDmu/JM8fGQfe?=
 =?iso-8859-1?Q?6OHLeU68ZTtPncFyF3jqJsduu/TwDTcLHl1sXbjvvbtWkLw94marKBSimb?=
 =?iso-8859-1?Q?bcM7da48kvEwvJvEWzPr4k9JvzM9MHQVxGCDQJWYHxW2D9JW/1LiC9tXug?=
 =?iso-8859-1?Q?tume6wjLg/4mht98j2GZYHhrgPSxscY2bSZ7CPhb0i/7hRsMBxD4efzzcz?=
 =?iso-8859-1?Q?1A/Mtm/NsoMUhoi8lSgTf3t5z81dnb8Z5z9JyIZ4nwGhjuFtsmJWduDtVL?=
 =?iso-8859-1?Q?vY8l9VyMB0c/21XR5H6H/3WZEVq2Zz2i3PIcdbeFI+jyodQ+K5Y8DDbUPl?=
 =?iso-8859-1?Q?n/LSNzI35gtCuCbQ0+PJX6m4V5jQqCCE0ZCBwxd2P9M9UZDY7B255IC0fy?=
 =?iso-8859-1?Q?musZ1RJXesSMDQQYuMseFLNwWZIvBfRdgo/niQ+/awvwNiMfSVrrkyirOV?=
 =?iso-8859-1?Q?lxXdbs0uDM/dEBoa0Dob7iT2kRJWsSnhzN0s3DiyiMCeUolcsYHfSh1bDe?=
 =?iso-8859-1?Q?XqvWYQWUOXsZhsYB6uYBgVIFIIn7x0QEw/e2xpFPj5QZNwghfjXdl77N5z?=
 =?iso-8859-1?Q?urIxRQJ+i/w62c5Fn438V3uz1c0MUc593O11+6Q8fu0FFqvlo3zENXflUK?=
 =?iso-8859-1?Q?ZbM9sjFseAiZkNsHC1T3HmPeKPTJ1bs13Ab+D+MnjLxmvctosUqiiLQj/U?=
 =?iso-8859-1?Q?FplmM+1hmb15KKLbJlsMIjiqRaNT8Gsm3phbhq43anFwHZkTpycf9IGH9F?=
 =?iso-8859-1?Q?DhIgN8HqjDFPTwAE6d02QxZbWyjtZUSlxHgJdH440pii915dKr0TI11Y/h?=
 =?iso-8859-1?Q?FiqbElAp/VqVXOi7V6NvgNhMpie7tKYLrth92AF61OsmJ990K3rryeC4R/?=
 =?iso-8859-1?Q?IMlFRbe7lBCbFJaWkXapoV5UlI2TOzZUjVdjj0+YNmKOQ1dlH8AiJpnAa9?=
 =?iso-8859-1?Q?cSJFt6W8EZ8wsFZoqghemimgpWM3WAWtkMwK4KQPHIYjYCfviqvf4p03Nq?=
 =?iso-8859-1?Q?8jr5vTqAJU/l4YN9rHgqMjsppcem/F+uw1Lb48PY+BQ25I7cGGhiDq4zCr?=
 =?iso-8859-1?Q?iCUPZySI/vKzCAiVXr0WL2k6fAfu89W28uQQJkld9Auw1yJytf55RGV/Gy?=
 =?iso-8859-1?Q?ZeNd1U1BvtnGLT2xdFZhfB7dPotRGz+ikIuzbaK30adQy+rNsm6qDo81Mf?=
 =?iso-8859-1?Q?kv2/tk2/ys5JH0igjR2nhZQipDqIqP7ugiQbjoUmuEEMhqm03QK13qD5b7?=
 =?iso-8859-1?Q?oeFkU7YjoTQYJQaR+Dcka5yqQ/IBAOVsiZqhmgh4gVgbqHTP393uIrvw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ca7633-fa95-4701-3081-08dace3e3c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 17:06:32.1886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4r+cArEmhN4IvsBYWQWqMerhmF02KEG/98BFKYolzy3TEO81AlpK/Zm92RgsThcg7YBk7/Z2sQzTFDFjQKhQ4hhxQqe4hU1Qri+t8yWl34Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5530
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi All,

Gentle Ping. Are we happy with this patch series?

Cheers,
Biju

> Subject: [PATCH v11 0/2] Add support for RZ/G2L GPT
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
> This patch series aims to add basic pwm support for RZ/G2L GPT driver by
> creating separate logical channels for each IOs.
>=20
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
>  * Added a limitation for disabling the channels, when both channels
> used
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
>  * Replaced devm_reset_control_get_exclusive-
> >devm_reset_control_get_shared
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
k
> ernel.org%2Flinux-renesas-soc%2F20220430075915.5036-1-
> biju.das.jz%40bp.renesas.com%2FT%2F%23t&amp;data=3D05%7C01%7Cbiju.das.jz%=
4
> 0bp.renesas.com%7Ca5694df81ca948716f0f08dac401132e%7C53d82571da1947e49cb
> 4625a166a4a2a%7C0%7C0%7C638037806144463316%7CUnknown%7CTWFpbGZsb3d8eyJWI
> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> 7C%7C&amp;sdata=3DOhup1bqYLN3O67hvaf%2FiEYaO8hzsr5eSPS4ueXCUTz4%3D&amp;re=
s
> erved=3D0
>=20
> Biju Das (2):
>   dt-bindings: pwm: Add RZ/G2L GPT binding
>   pwm: Add support for RZ/G2L GPT
>=20
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 378 ++++++++++++
>  drivers/pwm/Kconfig                           |  11 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c                   | 538 ++++++++++++++++++
>  4 files changed, 928 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-
> gpt.yaml
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>=20
> --
> 2.25.1

