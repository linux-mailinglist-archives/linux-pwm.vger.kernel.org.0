Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B305EFC1D
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Sep 2022 19:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiI2Rgr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Sep 2022 13:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiI2Rgp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Sep 2022 13:36:45 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2139.outbound.protection.outlook.com [40.107.114.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BD512167A;
        Thu, 29 Sep 2022 10:36:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evRRtRzdSo9+t04IqbRfwSHuiWzkFQN18OQqPMJxG5ed6ha+qI6SVcoemrUUX3As54dKvLpIrWad2ZgIhxBvoe6VaN3+TR4Zz49TUCoxYeCrju9q8M9tElYfbi3Dd79/qTeCAoMHWXijBYh+MGnRFRqDT/FlKa29o0HPs/TemMcbpF7+lsLIZi9eMK8QSFf09sU8oA9xSSFhXkQAz4yKjs4Cdvz+QXKVvAJ2NqMWDoO4rML9RdLNrKd+gCHRdJtHW6Wno4GZoUDBDGaae3PqCwvqVkE89I0lonUqSkd0zjuUSJ9h0G5Kz5PIeLFtLl9ficzb0afWJ5sJMM8pAUCLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS0SjM/UeaZs84ee/WWGiL/QZoYslRvdIjTURrmN9YQ=;
 b=Wry8at+pyWBbHoJzKHBDuoM41K4KWn+RS9W11OQH6plSdbbJzT0+bqFZwiZeXVmo7LZxGMZeE1z/Gonb8JUqw1xV6d6GlG7l9pym9VG4Jfu4hXyE4VwVwXB29sqa6CVXOl7W++S7OqZPBtn6sA36K+grO+QrWt1WVyOaBMXxjxF9FgsvV3Pe8zQb19gVEj6NWnzYFCdu0pPINihvip08LnC/Aw/5A/HZKh4J4TRIKS34B+1fMKVHgVQHSyNBes9BJUBpLN+AiPduFnLVHMQrtWueDhv3AJDh+E0yG2hx9D6S39hG/9xg5uW3U1dnEMUWSLK/44OwSoIUD0AhZtK/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS0SjM/UeaZs84ee/WWGiL/QZoYslRvdIjTURrmN9YQ=;
 b=edZGK8o6lrHWkedX3WndNxTjfSZdZ7ciBT+VgBm1DeJZoTUp1MzajMYRh9mhJGzbPYdwz7TqA9TPBfzltx+8CnvhroOE8RR5/lwb+kx13V4uZCfvopWMxwQoJ6E4i/R+4umhxstbenQUKIi+BS9fl7wN61RmteiQDMSXkSGhgjY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8431.jpnprd01.prod.outlook.com (2603:1096:400:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 17:36:40 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 17:36:39 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYzcqKYY4b2kXLe0WOhVN2yiYRM632twhg
Date:   Thu, 29 Sep 2022 17:36:38 +0000
Message-ID: <OS0PR01MB59223AB5F30A55A0CD54B08886579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220921145741.901784-1-biju.das.jz@bp.renesas.com>
 <20220921145741.901784-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220921145741.901784-3-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8431:EE_
x-ms-office365-filtering-correlation-id: 7643cd6c-455d-47a4-f251-08daa2412a20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QGA/9hY4colz7Kw87E8gVHtyy0c+VBPhisNWRczuZE3zIkHPPwnuqw/SAZW+bCQ6JHmFo86jX3ZEUBE5kZl8X2PwpaE2GYUA0ONWn61pUi6QU18bgYXVoNe0RKLnhzSomhF2IoGWVjWMSaxFdjqVLmWXiIkl71yAQRcIyjxQaiTwK+W57S5gTT2yrgylPf0DxOJIy3Ld6R0LHus2D3AaIVnSRIX5a+frfqBSINTZsLppdkRjGIrwSLd1s80IrJNouoSfiKgQsCF98Lo4luyH/XwPItgjI7nP4wVuo6Wh51chDl12uG1im1mrkgiqF4Mb/jk5dr+4L8yWvOTI/c1D+Rjr/IztIXpo6lHvG6JX8o444aAUv7A48YV4iMDwYTrcsJHpFGYeZpIG7n5oW1hJlBFfbrtLYp9C243rjH/x3EsJj0w9OJPQ+TcHrSjP2VYWKmG1jfldlvD/aItXVhEZiwHlFU6aWulssIQsIMDJtmC6L6gRfOLnkujBsAFFLzw64Vr4I+yVuSmCHq4LpPIXw4QpbJq7eXXQ3GP91If+iujB1xWU+DXo0euiwXKfcnoAZ4+goOheguLBTOYc/VTmLxtgKgHad6G25IoVufbf+XKP6b6uJQXyJxCokD2KOttQRt64CVZ7Tjt+kOxXUgKNM/or5ioi5ZWLFF2JjGb4VP21tpWF0SWhweKFIvoNTFumwYqqrxKQkiZWM8By3b3WCGmDAcVlOb/jYpQrqq9aiPZi+6EZGiigZdzh+pIzqSEkvlqYkX0EpwBlw/i0K6AbuG/kS6m8Ve+ECtBXzmac0N2JrG1NDtN3J7ZXDc8++TNxKJ9YYnYlD2Ll2dx010qLjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199015)(26005)(38100700002)(122000001)(33656002)(86362001)(38070700005)(7696005)(6506007)(8676002)(9686003)(4326008)(5660300002)(41300700001)(30864003)(52536014)(8936002)(64756008)(66476007)(966005)(54906003)(478600001)(71200400001)(76116006)(66556008)(66946007)(66446008)(316002)(2906002)(83380400001)(6916009)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6PsXrN1AuPAwwy6Y9wO5umSM3nl2snqhlliOWmoxEftJ7jHIileBF2QYBj?=
 =?iso-8859-1?Q?RsYqPPCH9eIzJbDzqLVbm7waInyVzTxU+wn37MKCyh7Ackc/vo89QO8Qyc?=
 =?iso-8859-1?Q?vYGJX9AD33ggUEtXIchHz81oSUsSdS1D5y1/gsEhtDyNfTAOm8qXoh6+sU?=
 =?iso-8859-1?Q?H9Kdr8vDmJYbLVWCEywouDbvT6FSgF5cHFJkf0BSYi2N2gOoStK+y+LjQJ?=
 =?iso-8859-1?Q?WKTOmBXoBKnkYf5qxe4lA6m4W9jLScnmbJW7kn9hxm4D1+rZo2MCgUF0v/?=
 =?iso-8859-1?Q?OTjMEGI8lKLxqDAVVLYWt95kgy4SjbJutaKYXyKRn/CqCyF4pddh+ZpY/u?=
 =?iso-8859-1?Q?cSoBU4yyOeT943HWTH9jbUJDZJ1eYEjiMg3A+wX6yBBFH3mvwr8b9Ug+AQ?=
 =?iso-8859-1?Q?BQIThn0dFsLjZTluKlJhLmgyTTqop0GA1QvCoINPnAubvfGk4HuCi/pux1?=
 =?iso-8859-1?Q?r7Yu5UN82x5BUMlVbnID2TMnLQqgzznRwX1OFxhH+yEVyXeER5WQFxNYAW?=
 =?iso-8859-1?Q?esfPBRYUAdq0tcowpBwsKo7memVye5u6Umyf8SLbUZYUicDu75o4Td850o?=
 =?iso-8859-1?Q?4YTDF2wM+PKKCTyNPxL8C0bk3aVm9yBiOSTDoNvjJu/wZtXvLkQ+CBUbvc?=
 =?iso-8859-1?Q?hvSl4CyHIHpPiRpxuW2wtxPiZeo1Qp10ldUVoSXH/Kb0N2ubmm12ejJLuQ?=
 =?iso-8859-1?Q?N+HhQhW9aPXtbzXJ+KrLNwIz8+dhNsRqNDrfMErdxXaiO+itVNpzuuPPB2?=
 =?iso-8859-1?Q?vdXr36gRJF9WYH1a2KhIa4LilENEB2li/PpRpJJGU683xv4koA9ZzG6cvP?=
 =?iso-8859-1?Q?966OKGwRzsKC/M19bWycDT9YOCj17wlucZaMMtqClBoW8jldYPnB6lKllm?=
 =?iso-8859-1?Q?tG6IWvOxVTWRjsVFdMAKFH9S+28MUv0VBGePoN/KldLb7AH7gk+MlFk72p?=
 =?iso-8859-1?Q?JXWkqOQ5h+jzJmaHK1dYsm6JaKNAhHQVuuuczHWDHTC/OetHJU05yCNoPX?=
 =?iso-8859-1?Q?GmBHUUZdfO2r9LCTU2yhDrAZCno/8qf4QvKw+qMenTKn2+HLDn5V5o3FTJ?=
 =?iso-8859-1?Q?vbNYybmL5j8WEHClYlDi6vcC4PBj0A2rOIYohPZJ0Ri64dV5FCo1yjWgyF?=
 =?iso-8859-1?Q?Dyn7FNUB7m9xtMkoRQeo8SzLfDIL4JSxPaCRUDHVpB1eZo0MS/oP5F+xdn?=
 =?iso-8859-1?Q?bYfSX57miXPwavkQzM1EMf89LpjsOoHokHOKXsz9APO0ghH0quCYlv4gTM?=
 =?iso-8859-1?Q?aPpEfwo2M8OdnO1KPOUZZ8dWAzRy9cA8ZYACxMPmlqO5jtl15Tz5mH/te+?=
 =?iso-8859-1?Q?3vFsAGzuXl++TlNWXu5VwmRrmvC7OMDs6FvafyUfP8+t/1+HEYeQPAiO0M?=
 =?iso-8859-1?Q?dYj0ROryjRngZ4CQNbCsN+Li+RXYWGVNb/Kl62ZzvP2j84iuF2CSISmRUI?=
 =?iso-8859-1?Q?X95pkHviRkRe60OYWQorSLSGgPPrZR4jrGwD2eIsAc2dqvHnaeov7Us6J4?=
 =?iso-8859-1?Q?ZUd2cz4qLpuByD5wSzxRt7Bv5iWHv/OV7hSFZJAx+2bXxTGENG6TGT2w9P?=
 =?iso-8859-1?Q?PlhdftdrNk3JL+YIV2TCUYMAw813hnxfyGrMsoIraBIZpXfI6SNf5D3vfe?=
 =?iso-8859-1?Q?qHV73X66WOp8ZOz8/XCLOSIjWVgrV5gvnPgDPA6ENmydceXBXYFhabYw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7643cd6c-455d-47a4-f251-08daa2412a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 17:36:38.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5/WwOjqN5lfHf72z7fULmr8/C4RzgeNKmnvDK6qcsEynlw79TYuNaxBaPAx6LqoMZUg0e2u2CKGCRNJ38Cl3hcVMqlXGbs12h72RNb1Afs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8431
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

> Subject: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
>=20
> RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit
> timer (GPT32E). It supports the following functions
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
> v6->v7:
>  * Added the comment for cacheing rzg2l_gpt->state_period.
>  * Fixed boundary values for pv and dc.
>  * Added comment for modifying mode, prescaler, timer counter and
> buffer enable
>    registers.
>  * Fixed buffer overflow in get_state()
>  * Removed unnecessary assignment of state->period value in
> get_state().
>  * Fixed state->duty_cycle value in get_state().
>  * Added a limitation for disabling the channels, when both channels
> used.
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
>  * Moved pm_runtime_{get_sync,put} from {request,free}-
> >{enable,disable}
>  * Removed platform_set_drvdata as it is unused
>  * Removed the variable pwm_enabled_by_bootloader
>  * Added dev_err_probe in various error paths in probe.
>  * Added an error message, if devm_pwmchip_add() fails.
> v3->v4:
>  * Changed the local variable type i from u16->u8 and
> prescaled_period_
>    cycles from u64->u32 in calculate_prescale().
>  * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div()
>  * Dropped the comma after the sentinel.
>  * Add a variable to track pwm enabled by bootloader and added
> comments
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
>  drivers/pwm/pwm-rzg2l-gpt.c | 423
> ++++++++++++++++++++++++++++++++++++
>  3 files changed, 435 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> 60d13a949bc5..2723a3e9ff65 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -481,6 +481,17 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
>=20
> +config PWM_RZG2L_GPT
> +	tristate "Renesas RZ/G2L General PWM Timer support"
> +	depends on ARCH_RENESAS || COMPILE_TEST
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
> @@ -44,6 +44,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-
> raspberrypi-poe.o
>  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> new file mode 100644 index 000000000000..c4e011f2a843
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -0,0 +1,423 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L General PWM Timer (GPT) driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + *
> + * Hardware manual for this IP can be found here
> + *
> +https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-
> use
> +rs-manual-hardware-0?language=3Den
> + *
> + * Limitations:
> + * - Counter must be stopped before modifying Mode and Prescaler.
> + * - When PWM is disabled, the output is driven to inactive.
> + * - While the hardware supports both polarities, the driver (for
> now)
> + *   only handles normal polarity.
> + * - When both channels are used, disabling the channel on one stops
> the
> + *   other.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/limits.h>
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
> +RZG2L_GTIOR_OBE) #define
> RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
> +	(FIELD_PREP(RZG2L_GTIOR_GTIOB,
> RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE) |
> +RZG2L_GTIOR_OBE)
> +
> +#define RZG2L_GTCCR(i) (0x4c + 4 * (i))
> +
> +struct rzg2l_gpt_chip {
> +	struct pwm_chip chip;
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	struct clk *clk;
> +	struct mutex lock;
> +	u32 user_count;
> +	u32 state_period;
> +	unsigned long rate;
> +	bool pwm_enabled_by_bootloader;
> +};
> +
> +static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct
> pwm_chip
> +*chip) {
> +	return container_of(chip, struct rzg2l_gpt_chip, chip); }
> +
> +static void rzg2l_gpt_write(struct rzg2l_gpt_chip *rzg2l_gpt, u32
> reg,
> +u32 data) {
> +	iowrite32(data, rzg2l_gpt->mmio + reg); }
> +
> +static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg)
> {
> +	return ioread32(rzg2l_gpt->mmio + reg); }
> +
> +static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32
> reg, u32 clr,
> +			     u32 set)
> +{
> +	rzg2l_gpt_write(rzg2l_gpt, reg,
> +			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set); }
> +
> +static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
> +				   u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	prescaled_period_cycles =3D period_cycles >> 32;
> +
> +	if (prescaled_period_cycles >=3D 256)
> +		prescale =3D 5;
> +	else
> +		prescale =3D (roundup_pow_of_two(prescaled_period_cycles + 1)
> + 1) / 2;


This algorithm won't give desired result.

prescaled_period_cycles		Expected result
0					->0
1..3					->1
4..15					->2
16..63				->3
64..255				->4
256 >					->5

I believe we need a for loop like in patch[4] to get the desired result.

Please correct me if you think otherwise.

[4] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2022072816=
2526.330542-3-biju.das.jz@bp.renesas.com/

Cheers,
Biju
