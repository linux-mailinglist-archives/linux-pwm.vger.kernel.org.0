Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A08C61EB33
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Nov 2022 07:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiKGGxW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Nov 2022 01:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiKGGxV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Nov 2022 01:53:21 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2094.outbound.protection.outlook.com [40.107.113.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F41512775;
        Sun,  6 Nov 2022 22:53:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xr4KDQXTsnvXYVdDWb14hCBw9AE7/VAwIgMCJ1nLPFlrGi3BQKn5e+u4SGSviyC4DMxAmiCYSsIv+09xdnEmJj0Y+tmokq+qrtgyfmjnSJkoDxA42czd9eZ7R6UaIcVF7LBKUqetAp2H6Mx7YSbRiv33wiaacuHChhWR4Uat5Pnra9v0MZGx23ZP81Rqh9rXxNUmFUxOKEfo5T+DwJqXzFpxvjrGU2208Gc2pRWw9H4CKDlVrr0UcqHmiKy7txVhuBiZH1IL6OEQLfdHbjshUie3uEtchciM10t0nR58yLFQ+acl1nvD7b6IkHLnnVcBSNOhGU8M88XtrpG9iOomRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RPEzcgoKXcXG+RIXpjlZROx17Pd/MLDO/EC8Axjq6U=;
 b=NbyUceDGG8cYCNHAUSS3mbsIUVm5K6VR240DmCbvJrwnZKP4Tmym0jznwHZRsKVFiOV15SvsDxpFQKVVl9EzE6Mo/8VrAWwcGNlFVnMdvavLZnIkil6P6ZqkiDkxfphVDSGqCh8+TqIXVn5aItFVRqCun8BH7v9qq11ubesewD7KRWG6y4FoStk3Aj2tsA7pPJH0IHPetCp+mOvxpRwZf4kuMP/WGJfyzRDDDjZVQzvYcE1w0JUXz28Btuas6EYqI07dhXFo2kCFjssbiH44NdHFYNYEdNZhaSSFk4TyX/lh22c2a//Ynp0YZAR01JNGLmLQGNmdRlMvNEKukdnGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RPEzcgoKXcXG+RIXpjlZROx17Pd/MLDO/EC8Axjq6U=;
 b=krpXyY/yBDIojD4wDMK43eBwK0KmS1bmYhjTXZeP93cx8CtvgQRoVkeNZXz+UBHbIsaISHDlqqxh46yD6KO+iLBu5umlBMHXpgR6ZVL/QnHSQH/bbn6JXBFcIbQjzsCWmGU8Mu1k+/Rx7T8Cli2hA8ILmcWhvBzbly4olP1vXa8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5561.jpnprd01.prod.outlook.com (2603:1096:404:8043::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 06:53:16 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 06:53:15 +0000
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
Subject: RE: [PATCH v9 0/2] Add support for RZ/G2L GPT
Thread-Topic: [PATCH v9 0/2] Add support for RZ/G2L GPT
Thread-Index: AQHY6rn/+iDfEUeli0yGzAQu9CtILK4zFGZw
Date:   Mon, 7 Nov 2022 06:53:14 +0000
Message-ID: <OS0PR01MB59224A8F515067F606241EA0863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221028104231.220426-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221028104231.220426-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5561:EE_
x-ms-office365-filtering-correlation-id: edae94c4-2b21-4a84-106b-08dac08cbe78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0Mw6yDEqj70sxNfSPuxLoXnuw+ZuFn5TXePLeYlk86RWxik9vPVc8Rw7UekVpT5fhd1h4ck6gPGct2lDtYlrFZNRm9nI4hYg5xi+C8CSMyQy963/WDKD94iDaX7qXomIFRXwXnpcG6hvp8S5qX0lkK6oANbWgscLysMxMm9BhYWEq5nmY184s3qR6JO2FIbGcmlxG1Hq49qz5wNjy95AgZdBwaWLQRuHNKzz8yW085JmtArAXJJ/J8lvXJHMR3crCEtDCeakNmNyfgKBWfzmakgF/tOJuFq+kCrGV6EeQu3OIrU4KFUKMBgSG4pkqOzYCxrF3FeL1EnnKrT5ksLoIcKOozp6DTjH6w+h8iMuQTf0gM3SAwqodrmA8aIaTfWc3HUuGILM0rjrwyPaDKWJDmoWi6DO2Bga1iAJJGp0ve0Ck1urufdxN7hLlwtnkZblWPFxv97wZS6u5yLbnp150C7TG4HJzcp6TOQtCOjlLjned/baJJ5Z+GxChAfiIibaJ8arGbaOPxx+p51xH6IF4VcTZ4rOw8oqY/bviJqEYfjkR8X+P8XlSLaYQJOkfzeFE9mzbK7mNl44cCPfvaLCsGBYkPaYN8oHHOhRJp57dX2GHNB0H23xuVKIpMelVNkVZEFs9qgVMjLPoLCXL+N875iotY4AiGQlA8d9naZkKClaApwvyrc5JT+1rrGPsyyYJyZ1lunUqxLy0wCTeKtvU4/o0VCVKhFBAdqtHW3j8He5cqXGathpU3YaoZN5wT+emlnzLEH+I0SQFCfuLyERw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199015)(8676002)(4326008)(33656002)(54906003)(66946007)(66476007)(76116006)(64756008)(66446008)(66556008)(316002)(38070700005)(83380400001)(5660300002)(71200400001)(41300700001)(8936002)(478600001)(55016003)(2906002)(110136005)(52536014)(53546011)(66574015)(9686003)(26005)(186003)(38100700002)(122000001)(86362001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bvLR8HvYqEK9rhAvD1KDs4IE/CH04DvDoNYRFRMUrOIkszYz+PmWJw2AM1?=
 =?iso-8859-1?Q?oBflJtfo4LXskbCfU47ixRmYZlW/Wm4X98VO0ovW7cRmtv3ux0LO494Eim?=
 =?iso-8859-1?Q?c+IxWJiMlwQMEH2WIKKNqcNT1FKT+c2NiCYQmQhIFE3jIOcDYIhhf2bC4e?=
 =?iso-8859-1?Q?RL/O8wOs+np3lnXSqhwXuX6KploGbVQ/jg6n6U988D78zrCmR+rpMph/TD?=
 =?iso-8859-1?Q?HxGYlQJsHeCheA0uO8h4iAr01xuC5vSZiaKqFtnmNt6+ADcTGrzOJRZuOW?=
 =?iso-8859-1?Q?JbAiU1Ghv7fnvvVkm6WwBXp8o/U1nntJtz2H5lh+0x8SjdX/kmx3JmGXL/?=
 =?iso-8859-1?Q?d2cMSfkXw+dHt91GCL+YVvhaRu/f3qZM3mJMjajvi1Lnw1mTS2iry9JBL9?=
 =?iso-8859-1?Q?1D6tm6V72TGVIzMmkFHFs+qij1TkcGSWuMpoy81WHwN/Ek+dh8vkT0y4rH?=
 =?iso-8859-1?Q?q0zYx5cV1Xz/yERsP3S3IEyOyz83PGFL6kxQPB7PC3KNdEKFy2w41935cc?=
 =?iso-8859-1?Q?qS3SLi27NJiP+Mm1FS9AGKarex097IgjY8pftCeN1gbWCwcBsow35+ySEe?=
 =?iso-8859-1?Q?NWDAFip9P3b5WhS3QSc6KV91GrezTMK/7qPAtYwdIfyV0fzCTA6zDaNwO7?=
 =?iso-8859-1?Q?UklaGInRBA8QcIqwR8uJ+fKVJ4S8HsVXWLoqpMSZVctxigS0I76Y9nfdbc?=
 =?iso-8859-1?Q?yP9ooK+sIgFeUw1H9KOfLky5wSR6gWFNsq7Gnpa8IvK3F0zoDzmLTLlIaR?=
 =?iso-8859-1?Q?tIji7kvb5VM0I22yjZ+F7V8rlaWPQtMP0t+ZHfbn+nNcmhR3xb87wj24XH?=
 =?iso-8859-1?Q?y5aMrCKP75qL1erwOZwzfJdG0NihqSiEc14LvL0xAWTWYoE3RRwdLmQK1O?=
 =?iso-8859-1?Q?k+F2zsG88HyX13EJmmjVjaOj1a1iFyGa8XLW17Z9iCn3dUCkEC1q1GskG0?=
 =?iso-8859-1?Q?UDrBCyYWgu4/HhfD1W7ZFmcWTN6PKLpBM6Gk6QoGQu/U74xks/XJhCzHLT?=
 =?iso-8859-1?Q?iU8JYdfl8aQZlcEFQGCtowuDCdrFky33gfQvkKohIvgk07tQR7wMmMjftx?=
 =?iso-8859-1?Q?lx5nPMCw85sZc3pcIBpCjmKttRILw9ywhHYIgX2EwLi9pbdTp/lzNDgbmm?=
 =?iso-8859-1?Q?kNV+Iy9i2jBsIrPyBSpuiyUJX9Qix1NQW5aso1TLX2458I8htx1nemqksx?=
 =?iso-8859-1?Q?kw0bWvUFyAIVDRKK8B/u0wCouwoktswtMeNVfKq6lJG81ybv8Ke6eB/LjY?=
 =?iso-8859-1?Q?xfsbwoxFRj34nqFJ0x6nrMQlf5MN8Lpi+veZVHtPF1wxc/h7GoD/99f6yb?=
 =?iso-8859-1?Q?pkMkWws2a/hh07n72n68kzb/VSWb+7e25hxH0afA9/NfuSeeHVSt+s0ofv?=
 =?iso-8859-1?Q?b01rlpi1VADxNHQvvHVrfpM/r4nlu9Ct78fdxBxD48OtTMjzIW5Y3AiRNE?=
 =?iso-8859-1?Q?4HFMGbUYQH/IdmvR8+5s5cgqVdmHCL4zpX+O5PBnAQP0W0RRJHpktfkMq5?=
 =?iso-8859-1?Q?yI9A0kuLN2+X6vyJkF9ptpIP8K2mjcNlO0x1QLa8IlV4ZQa5DUZxKxbZBv?=
 =?iso-8859-1?Q?VSknhea8GuzqBU1mz6yKbJvSK0vGoxAT0nZh/hKp+4TWjARsqG7kDELGXL?=
 =?iso-8859-1?Q?qr4KDhxAmcGO0dv07oKI0b8npHDRXoc69svWgRA0VitBm9bTPO3Pp1tw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edae94c4-2b21-4a84-106b-08dac08cbe78
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 06:53:14.9684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfnhizHIaVfJ7s7Q6Lewna9tm6UnWSLCfLldhhbxngBEZhG6fLd/kiV8MuqfijfxkQuP8omoAud15cZUBSd27yErysr3oKylqCZkis/XuQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5561
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi All,

Gentle ping. Are we happy with the patch series?
Please let me know.

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 28 October 2022 11:42
> To: Thierry Reding <thierry.reding@gmail.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Philipp Zabel <p.zabel@pengutronix.d=
e>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>; linux-pwm@vger.kernel.org;
> devicetree@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.be>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> <biju.das@bp.renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
> Subject: [PATCH v9 0/2] Add support for RZ/G2L GPT
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
> v8->v9:
>  * Added Rb tag from Rob.
>  * deassert after devm_clk_get() to avoid reset stays deasserted,in case
>    clk_get() fails.
>  * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
>  * Removed clk_disable_unprepare() from probe as it is giving
>    gpt_pclk already disabled warning in the error path.
>    	[    0.915664]  clk_core_disable+0x25c/0x274
> 	[    0.915754]  clk_disable+0x2c/0x44
> 	[    0.915833]  rzg2l_gpt_pm_runtime_suspend+0x1c/0x34
> 	[    0.915938]  pm_generic_runtime_suspend+0x28/0x40
> 	[    0.916042]  genpd_runtime_suspend+0xa8/0x2b0
> 	[    0.916136]  __rpm_callback+0x44/0x13c
> 	[    0.916218]  rpm_callback+0x64/0x70
> 	[    0.916296]  rpm_suspend+0x104/0x630
> 	[    0.916374]  pm_runtime_work+0xb4/0xbc
> 	[    0.916456]  process_one_work+0x288/0x6a
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
>=20
> Biju Das (2):
>   dt-bindings: pwm: Add RZ/G2L GPT binding
>   pwm: Add support for RZ/G2L GPT
>=20
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 378 +++++++++++++
>  drivers/pwm/Kconfig                           |  11 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c                   | 530 ++++++++++++++++++
>  4 files changed, 920 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-
> gpt.yaml
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>=20
> --
> 2.25.1

