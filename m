Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4764A5BEA4A
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Sep 2022 17:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiITPbY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Sep 2022 11:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiITPbX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Sep 2022 11:31:23 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2092.outbound.protection.outlook.com [40.107.114.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FAA61D9F;
        Tue, 20 Sep 2022 08:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqjvbmT9E8ZkI0YB8P56gE81fr1gC/ir9HEUYb5DFY+wC/XVh5DUgeBStsec3BpqZb06wB4bLTVfhZhusdz4w0tffDa2nLXXDHLmGSNH5+IfB815cJucumXovAwL+DP40wBa6tPfZP+f5os9BT6uR+VUbh0XGp7W+dVZvMyybOtc4RkUxef3EWv2bR3SOCgRh76eRXPo57wJyG4jo3rSFRPpwcFS0YBIVthIfN75Jmtx9c9gj+IpooYtHQ0xfFCByVhD6Q2/WB+v/cgJyp8cGviKmACO5iaakkY6e2IADA/M0GviRg89mxGBR8yed1pnQtpG8hyNn+/Wjc7vbK5YXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEbAMLcvHw3CoIsce1y2uFNepzKFVSPQshFDjpD0tCE=;
 b=cby8aKZroq0aSes6O/hH9wZ4HM8veS1NGP0HwXGy0OEuBy73LU/iTNxCuKK7lJbH+8OTEk2cBAk+DVpItROecO2WtgAAu3XvZc6hVb+A9nj2eagTBTtUN5+NdBr8iaaCxbK5/O5QjX5IoW+SYbhoBO8Mn4/nIHg9goswOdeDj8MNqjRDmPezLGXsEcLshjrp3eaR/3pAOgQxscghIGsP9PyWVqZAC+8zEP4DB2wd04XwfwfsUyaWiXBmucUUASQd9NNkox3Exm4QexIo4LmNra9b430QV8aUDqUoOgxj+z4USvxJUYN+S/fpoobnR5wFQ6SlcVtttkNcIJbFlxC6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEbAMLcvHw3CoIsce1y2uFNepzKFVSPQshFDjpD0tCE=;
 b=eVLqLUk4uxXn+rpHosOtLzndM2PJCUrcwaK6H3AIHcz5tAIrihhbl+QoOg+q/A4SlWhOhzkigqikaSQ/YImd/MQgUAAJXJbkB3zSnirfT1zfMbtimOsEPXUJ7f8XM+geN09VFpDY03il3S8Wvx2LDq072wJ5149QTnkBbixsRqI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8112.jpnprd01.prod.outlook.com (2603:1096:400:101::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Tue, 20 Sep
 2022 15:31:17 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5654.015; Tue, 20 Sep 2022
 15:31:16 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYwUrah2CK2PlWrU6yp9jjjlk8rK3meFWAgAIFOuA=
Date:   Tue, 20 Sep 2022 15:31:16 +0000
Message-ID: <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220905171328.991367-1-biju.das.jz@bp.renesas.com>
 <20220905171328.991367-3-biju.das.jz@bp.renesas.com>
 <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
In-Reply-To: <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8112:EE_
x-ms-office365-filtering-correlation-id: b68bea66-c99b-4ba2-d1b2-08da9b1d286f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QDS4+X3+eL1RGjUD/8oiTD8fnJQuYVcgCovXvHbdqAs3jk+fcUiAPqesVBmUeoU5/P2h0nkyud0zfL1qZ5FXktdXacsUkGhcnoIZqmB7VwuUrMmrG/ICmlT0RzELyjO8HSDEnydXrpmoJgijSZ2UtKZkTn1IIijgGTUHvcnCkgR7oUvZKak85JF5cXJct7sMkdZl4sqjqF1uWyseF6jOAi6cHSGSRBlmPVnCXpf8vqbPThsXV+eTxkUXNpL5tOjT5yFtTot4OwbuXaV4G/weMTX2J0Lv7vhfH9HJyTfKc8cJsaCj/nbovz/l2+RWSn84oLyXIQXTH7jXaBs3z/RkSroXY63rWFNsw6UgK+sYpiu409ByAXOhvOYk159sJs78HnJs7Z+gAGmcGamBWWBbzwhmZZClKfJn9RVC4LGKf/XMgxkOxrHKBcQ+IMnjQO7YqhTjdORS/c/iQpjfcFAeSicHUfoRjWHKbgNohNBr/q0/qkJxB5gPg4GoWSJcBWMbNt/RkchdCqHJY4bvYUVB5qqZ8BClRnhGtgHz9mnnQQmjjoG4gs2B+QNr706mpqwxBR0nSLy/eF7ZpWDLzJtQhsmgSsw+Dnes3j+05su3IFLsvDF0ciXsz3jnEx3KYK4FBg9U+kcnglwPAAsuhcmEH1Jl6IR6+ldEW7S9WktH0EvBeIZzzxrLVBd48PrN/kvnHWJwBZLzD/s0kV1VsjSsPOeHSX3TVj9of8y5Fo1m6VUGgSVSTvcprqNVkMjNTp/RsbXzLh3v6YpSwqn5Csww+B6zOQ+VJs8/h2aclmiNKoI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(2906002)(66556008)(5660300002)(52536014)(33656002)(8936002)(86362001)(66446008)(66946007)(4326008)(8676002)(76116006)(66476007)(64756008)(55016003)(122000001)(6916009)(30864003)(54906003)(316002)(71200400001)(478600001)(38100700002)(966005)(41300700001)(6506007)(7696005)(9686003)(38070700005)(186003)(83380400001)(26005)(66574015)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Y+/8n9skDj1PN9XGPRXmcwoWK/cnx1KuO9E5/2jm3HNfBEObWeex15pLzu?=
 =?iso-8859-1?Q?rS64lSE7KEi10/aMSfq9x4RGDL/+v4MHVSWUrbXSplrNxva3a26irzG+6S?=
 =?iso-8859-1?Q?2w3Y9n7Rvo+8xfGHHLWpJbG4txQqN3bvX4TsYpuH2X1DPVkTf0scBp19TC?=
 =?iso-8859-1?Q?+O1Eh1X3yolNCSFwqXugsdaqk+45SWKB6SZX6Gz4w605cbjlOukRFXGCSi?=
 =?iso-8859-1?Q?qbN3whWilQCjr396RucF228/eGbHbMhnOtjV+F3IHEs54AsmycOqzwfFfq?=
 =?iso-8859-1?Q?bHLlqFtufsBzxLcbbvcVX2AQeL+ApNfdHV7wCroiCS0GFfH27EU07k7Bp8?=
 =?iso-8859-1?Q?VdOo5HiQyAlT9u4FKOM2fqmv4YUU1Vv6wC49TW0sn6M2NANpJnUSsiPyGJ?=
 =?iso-8859-1?Q?E+YogZpusVPErz0Xj72x/5tmAuBQhc1YcN6k80/e6dTd4CVqDU1ky2UmMD?=
 =?iso-8859-1?Q?ThquKrH5iOnCjs0RHMqr6umF0RB4ykZTvuWIstHqr36gWgNSZ9oMhEV5Un?=
 =?iso-8859-1?Q?8h+cb/mmPfZ7tTu0AYGTUYXIkKPsv06vpYE1RM7mBlhHDQRg36shlExGeh?=
 =?iso-8859-1?Q?sd0icrbUvvueUHpcTjQsExTMez7Gd1Tq86lhWO1goUEOHbUhEgBr22+/gT?=
 =?iso-8859-1?Q?vKhJikOzLgqpxvSeg4aR/cgT/tjJ/8RESugUqTfAUg4gJOD6NoWu+pJsOP?=
 =?iso-8859-1?Q?8UWxBZEwxFoH7Qs68Mst0FlZRPjrlxWCLB6dtcEnHHs4Nsjo+O0RR6Domw?=
 =?iso-8859-1?Q?yiVPan7zZdzw7FPMno2o8ALR2A6mYT+bVtLT+muItJh8dYJiARoU5ccQQx?=
 =?iso-8859-1?Q?GJoIu070RWsKhkCG33klSTCCH6+D8U5/7qpBfpxaDkunbW64sYSH7KyjXy?=
 =?iso-8859-1?Q?SwkU8iKgE3HKPi70dBZU4/XsRcLOwBsb+XLPwIfi9X/rQ3Hr3fbKpGlIDn?=
 =?iso-8859-1?Q?8R48XJlJsrHfZo+K6OCuBuF37qROeIP0tWRAsX8jGbRi0ZeyJIicWd3K+8?=
 =?iso-8859-1?Q?4rLw0ujwkyT5MIA7bfnEy8iARH4Zq8NDSOUuWBFbULoIx9vnLUo5l3yU97?=
 =?iso-8859-1?Q?mjzLRujbCltX4ygs3Lyk9VN4Xlac1rZiwfW1UniHMLgfnchofH7R0pOfcM?=
 =?iso-8859-1?Q?PH7dASgBBjdYIx+SkzSvSoyQlFRpuJTmcmAzUFk7HideAz0uq6zSkT3CCQ?=
 =?iso-8859-1?Q?VggLpPHyyqf5t+Z/JwEWQFy4QPSfPskQeFanMjVlBO2HkqQeNh8y5+rU/2?=
 =?iso-8859-1?Q?qzDYkrMf6zpJysTC1zttGEOEvJxPR+FSmZfLuvh4BUwHLePWszE0OYkAbq?=
 =?iso-8859-1?Q?fS9h/u4+pHxPFetflEOjH6Jp3y4tkkHXv/CCOMKoXFOSmNZI+2FwUF6wkY?=
 =?iso-8859-1?Q?ZrnieRsfEDKC1gQgUjKb4RIZJikmA6sjsTyslS4SH88rMrB54CTmMqfjhJ?=
 =?iso-8859-1?Q?5wYta96HBg7JP4nNszmyKJLxLjZ9QPK2qL4GNPzVdqTopAfDZS7p4ZaO7y?=
 =?iso-8859-1?Q?HcA59BEMYeMeA3KGC2Tdrg9Zj20b6vQjBoTy/bdc/U7K0r89vNfOwia/Gu?=
 =?iso-8859-1?Q?8Y/rIsPMk/v5wIOK6JhxAuN/mfI/mlHRxRtBTBrZVcUckkv0JBkL8Cf4ZB?=
 =?iso-8859-1?Q?SqpofzuP7LXDPFmZ1VY1tfyFZkBRH2apC9rxRgeBrR2KwHy9KCHOn9xw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68bea66-c99b-4ba2-d1b2-08da9b1d286f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 15:31:16.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8q+XsJ0+RBs66NH0b0x0ln6UcKM7GCbsBiTDMQP7IfEqx/oH/U9gLzVIhooeAnJH36O/0UC//nspjLxWl2xh7cKAptMrsXNTzkMUd3pnrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8112
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

> Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hello,
>=20
> On Mon, Sep 05, 2022 at 06:13:28PM +0100, Biju Das wrote:
> > RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit
> > timer (GPT32E). It supports the following functions
> >  * 32 bits =D7 8 channels
> >  * Up-counting or down-counting (saw waves) or up/down-counting
> >    (triangle waves) for each counter.
> >  * Clock sources independently selectable for each channel
> >  * Two I/O pins per channel
> >  * Two output compare/input capture registers per channel
> >  * For the two output compare/input capture registers of each
> channel,
> >    four registers are provided as buffer registers and are capable
> of
> >    operating as comparison registers when buffering is not in use.
> >  * In output compare operation, buffer switching can be at crests or
> >    troughs, enabling the generation of laterally asymmetric PWM
> waveforms.
> >  * Registers for setting up frame cycles in each channel (with
> capability
> >    for generating interrupts at overflow or underflow)
> >  * Generation of dead times in PWM operation
> >  * Synchronous starting, stopping and clearing counters for
> arbitrary
> >    channels
> >  * Starting, stopping, clearing and up/down counters in response to
> input
> >    level comparison
> >  * Starting, clearing, stopping and up/down counters in response to
> a
> >    maximum of four external triggers
> >  * Output pin disable function by dead time error and detected
> >    short-circuits between output pins
> >  * A/D converter start triggers can be generated (GPT32E0 to
> GPT32E3)
> >  * Enables the noise filter for input capture and external trigger
> >    operation
> >
> > This patch adds basic pwm support for RZ/G2L GPT driver by creating
> > separate logical channels for each IOs.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v5->v6:
> >  * Updated macros RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH and
> >    RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH with computation
> >    involving FIELD_PREP macro.
> >  * Removed struct rzg2l_gpt_phase and started using RZG2L_GTCCR
> macro
> >    for duty_offset.
> >  * replaced misnomer real_period->state_period.
> >  * Added handling for values >=3D (1024 << 32) for both period
> >    and duty cycle.
> >  * Added comments for pwm {en,dis}abled by bootloader during probe.
> > v4->v5:
> >  * Added Hardware manual details
> >  * Replaced the comment GTCNT->Counter
> >  * Removed the macros RZG2L_GPT_IO_PER_CHANNEL and chip.npwm
> directly
> >    used in probe.
> >  * Removed the unsed macro RZG2L_GTPR_MAX_VALUE
> >  * Added driver prefix for the type name and the variable.
> >  * Initialization of per_channel data moved from request->probe.
> >  * Updated clr parameter for rzg2l_gpt_modify for Start count.
> >  * Started using mutex and usage_count for handling shared
> >    period and prescalar for the 2 channels.
> >  * Updated the comment cycle->period.
> >  * Removed clk_disable from rzg2l_gpt_reset_assert_pm_disable()
> >  * Replaced pc->rzg2l_gpt.
> >  * Updated prescale calculation.
> >  * Moved pm_runtime_{get_sync,put} from
> > {request,free}->{enable,disable}
> >  * Removed platform_set_drvdata as it is unused
> >  * Removed the variable pwm_enabled_by_bootloader
> >  * Added dev_err_probe in various error paths in probe.
> >  * Added an error message, if devm_pwmchip_add() fails.
> > v3->v4:
> >  * Changed the local variable type i from u16->u8 and
> prescaled_period_
> >    cycles from u64->u32 in calculate_prescale().
> >  * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div()
> >  * Dropped the comma after the sentinel.
> >  * Add a variable to track pwm enabled by bootloader and added
> comments
> >    in probe().
> >  * Removed unnecessary rzg2l_gpt_reset_assert_pm_disable() from
> probe.
> >  * Replaced devm_clk_get()->devm_clk_get_prepared()
> >  * Removed devm_clk_get_optional_enabled()
> > v2->v3:
> >  * Updated limitation section
> >  * Added prefix "RZG2L_" for all macros
> >  * Modified prescale calculation
> >  * Removed pwm_set_chip_data
> >  * Updated comment related to modifying Mode and Prescaler
> >  * Updated setting of prescale value in rzg2l_gpt_config()
> >  * Removed else branch from rzg2l_gpt_get_state()
> >  * removed the err label from rzg2l_gpt_apply()
> >  * Added devm_clk_get_optional_enabled() to retain clk on status,
> >    in case bootloader turns on the clk of pwm.
> >  * Replaced devm_reset_control_get_exclusive-
> >devm_reset_control_get_shared
> >    as single reset shared between 8 channels.
> > v1->v2:
> >  * Added Limitations section
> >  * dropped "_MASK" from the define names.
> >  * used named initializer for struct phase
> >  * Added gpt_pwm_device into a flexible array member in
> rzg2l_gpt_chip
> >  * Revised the logic for prescale
> >  * Added .get_state callback
> >  * Improved error handling in rzg2l_gpt_apply
> >  * Removed .remove callback
> >  * Tested driver with PWM_DEBUG enabled
> > RFC->V1:
> >  * Updated macros
> >  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
> >  * Added rzg2l_gpt_read()
> > ---
> >  drivers/pwm/Kconfig         |  11 +
> >  drivers/pwm/Makefile        |   1 +
> >  drivers/pwm/pwm-rzg2l-gpt.c | 409
> > ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 421 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > 60d13a949bc5..2723a3e9ff65 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -481,6 +481,17 @@ config PWM_ROCKCHIP
> >  	  Generic PWM framework driver for the PWM controller found on
> >  	  Rockchip SoCs.
> >
> > +config PWM_RZG2L_GPT
> > +	tristate "Renesas RZ/G2L General PWM Timer support"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	depends on HAS_IOMEM
> > +	help
> > +	  This driver exposes the General PWM Timer controller found in
> Renesas
> > +	  RZ/G2L like chips through the PWM API.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-rzg2l-gpt.
> > +
> >  config PWM_SAMSUNG
> >  	tristate "Samsung PWM support"
> >  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS ||
> > COMPILE_TEST diff --git a/drivers/pwm/Makefile
> b/drivers/pwm/Makefile
> > index 7bf1a29f02b8..cac39b18d1ee 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -44,6 +44,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-
> raspberrypi-poe.o
> >  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > +obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
> >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> >  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-
> gpt.c
> > new file mode 100644 index 000000000000..9913dd995891
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -0,0 +1,409 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L General PWM Timer (GPT) driver
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corporation
> > + *
> > + * Hardware manual for this IP can be found here
> > + *
> > +https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-
> group-u
> > +sers-manual-hardware-0?language=3Den
> > + *
> > + * Limitations:
> > + * - Counter must be stopped before modifying Mode and Prescaler.
> > + * - When PWM is disabled, the output is driven to inactive.
> > + * - While the hardware supports both polarities, the driver (for
> now)
> > + *   only handles normal polarity.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/limits.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/pwm.h>
> > +#include <linux/reset.h>
> > +#include <linux/time.h>
> > +
> > +#define RZG2L_GTCR		0x2c
> > +#define RZG2L_GTUDDTYC		0x30
> > +#define RZG2L_GTIOR		0x34
> > +#define RZG2L_GTBER		0x40
> > +#define RZG2L_GTCNT		0x48
> > +#define RZG2L_GTCCRA		0x4c
> > +#define RZG2L_GTCCRB		0x50
> > +#define RZG2L_GTPR		0x64
> > +
> > +#define RZG2L_GTCR_CST		BIT(0)
> > +#define RZG2L_GTCR_MD		GENMASK(18, 16)
> > +#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
> > +
> > +#define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE
> 	FIELD_PREP(RZG2L_GTCR_MD, 0)
> > +
> > +#define RZG2L_GTUDDTYC_UP	BIT(0)
> > +#define RZG2L_GTUDDTYC_UDF	BIT(1)
> > +#define RZG2L_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
> > +
> > +#define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> > +#define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> > +#define RZG2L_GTIOR_OAE		BIT(8)
> > +#define RZG2L_GTIOR_OBE		BIT(24)
> > +
> > +#define RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE	0x07
> > +#define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> > +
> > +#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> > +	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> > +RZG2L_GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH \
> > +	(RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> > +RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
> > +	(FIELD_PREP(RZG2L_GTIOR_GTIOB,
> RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE)
> > +| RZG2L_GTIOR_OBE) #define
> RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
> > +	(FIELD_PREP(RZG2L_GTIOR_GTIOB,
> RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE)
> > +| RZG2L_GTIOR_OBE)
> > +
> > +#define RZG2L_GTCCR(i) (0x4c + 4 * (i))
> > +
> > +struct rzg2l_gpt_chip {
> > +	struct pwm_chip chip;
> > +	void __iomem *mmio;
> > +	struct reset_control *rstc;
> > +	struct clk *clk;
> > +	struct mutex lock;
> > +	u32 user_count;
> > +	u32 state_period;
> > +	unsigned long rate;
> > +	bool pwm_enabled_by_bootloader;
> > +};
> > +
> > +static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct
> > +pwm_chip *chip) {
> > +	return container_of(chip, struct rzg2l_gpt_chip, chip); }
> > +
> > +static void rzg2l_gpt_write(struct rzg2l_gpt_chip *rzg2l_gpt, u32
> > +reg, u32 data) {
> > +	iowrite32(data, rzg2l_gpt->mmio + reg); }
> > +
> > +static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *rzg2l_gpt, u32
> reg)
> > +{
> > +	return ioread32(rzg2l_gpt->mmio + reg); }
> > +
> > +static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32
> reg, u32 clr,
> > +			     u32 set)
> > +{
> > +	rzg2l_gpt_write(rzg2l_gpt, reg,
> > +			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set); }
> > +
> > +static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip
> *rzg2l_gpt,
> > +				   u64 period_cycles)
> > +{
> > +	u32 prescaled_period_cycles;
> > +	u8 prescale;
> > +
> > +	prescaled_period_cycles =3D period_cycles >> 32;
> > +
> > +	if (prescaled_period_cycles >=3D 256)
> > +		prescale =3D 5;
> > +	else
> > +		prescale =3D (roundup_pow_of_two(prescaled_period_cycles + 1)
> + 1) /
> > +2;
> > +
> > +	return prescale;
> > +}
> > +
> > +static int rzg2l_gpt_request(struct pwm_chip *chip, struct
> pwm_device
> > +*pwm) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +
> > +	mutex_lock(&rzg2l_gpt->lock);
> > +	rzg2l_gpt->user_count++;
> > +	mutex_unlock(&rzg2l_gpt->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device
> > +*pwm) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +
> > +	mutex_lock(&rzg2l_gpt->lock);
> > +	rzg2l_gpt->user_count--;
> > +	mutex_unlock(&rzg2l_gpt->lock);
> > +}
> > +
> > +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *rzg2l_gpt) {
> > +	/* Start count */
> > +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, 0, RZG2L_GTCR_CST);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt) {
> > +	/* Stop count, Output low on GTIOCx pin when counting stops */
> > +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_CST, 0); }
> > +
> > +static int rzg2l_gpt_config(struct pwm_chip *chip, struct
> pwm_device *pwm,
> > +			    const struct pwm_state *state) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	unsigned long pv, dc;
> > +	u64 period_cycles;
> > +	u64 duty_cycles;
> > +	u8 prescale;
> > +
> > +	/*
> > +	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> > +	 * calculation.
> > +	 */
> > +	if (rzg2l_gpt->rate > NSEC_PER_SEC)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * GPT counter is shared by multiple channels, so prescale and
> period
> > +	 * can NOT be modified when there are multiple channels in use
> with
> > +	 * different settings.
> > +	 */
> > +	if (state->period !=3D rzg2l_gpt->state_period && rzg2l_gpt-
> >user_count > 1)
> > +		return -EBUSY;
>=20
> I had feedback to that one in v5. Please at least state the potential
> to improve in a comment.

Oops, I missed to update the comment.

GPT counter is shared by multiple channels, we cache the period value
from the first channel used in Linux and use it for both the
channels.

I will update the comment in the next version.

>=20
> > +
> > +	rzg2l_gpt->state_period =3D state->period;
> > +
> > +	period_cycles =3D mul_u64_u32_div(state->period, rzg2l_gpt->rate,
> NSEC_PER_SEC);
> > +	prescale =3D rzg2l_calculate_prescale(rzg2l_gpt, period_cycles);
> > +
> > +	if (period_cycles >=3D (1024ULL << 32))
> > +		pv =3D U32_MAX;
> > +	else
> > +		pv =3D period_cycles >> (2 * prescale);
>=20
> You're assuming that pv <=3D U32_MAX after this block, right? Then maybe
Yes, That is correct.

>=20
> 	if (period_cycles >> (2 * prescale) <=3D U32_MAX)
>=20
> is the more intuitive check?

Ok will add like below, so we support up to (U32_MAX * 1024);
Is it ok for you?

  if (!(period_cycles >> (2 * prescale) <=3D U32_MAX))
+               return -EINVAL;
+
+       pv =3D period_cycles >> (2 * prescale);


Same case for duty cycle.
>=20
> > +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rzg2l_gpt->rate,
> > +NSEC_PER_SEC);
> > +
> > +	if (duty_cycles >=3D (1024ULL << 32))
> > +		dc =3D U32_MAX;
> > +	else
> > +		dc =3D duty_cycles >> (2 * prescale);
> > +
> > +	/* Counter must be stopped before modifying Mode and Prescaler */
> > +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> > +		rzg2l_gpt_disable(rzg2l_gpt);
>=20
> For v5 I asked if this affects other channels, you said yes and in the
> follow up I failed to reply how to improve this.
>=20
> I wonder how this affects other channels. Does it restart a period
> afterwards, or is the effect only that the currently running period is
> a bit stretched?=20

If we stops the counter, it resets to starting count position.

>At least point that this stops the global counter and
> so affects the other PWMs provided by this chip.

We should not allow Counter to stop if it is running.=20
We should allow changing mode and prescalar only for the first=20
enabled channel in Linux.

Also as per the HW manual, we should not change RZG2L_GTCNT, RZG2L_GTBER wh=
ile
Counter is running.

Will add bool is_counter_running to take care of this conditions.

Is it ok with you?

>=20
> > +
> > +	/* GPT set operating mode (saw-wave up-counting) */
> > +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR,
> > +			 RZG2L_GTCR_MD, RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> > +
> > +	/* Set count direction */
> > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
> > +
> > +	/* Select count clock */
> > +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_TPCS,
> > +			 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> > +
> > +	/* Set period */
> > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR, pv);
> > +
> > +	/* Set duty cycle */
> > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(pwm->hwpwm), dc);
> > +
> > +	/* Set initial value for counter */
> > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT, 0);
> > +
> > +	/* Set no buffer operation */
> > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER, 0);
> > +
> > +	/* Enable pin output */
> > +	if (pwm->hwpwm)
> > +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR,
> > +				 RZG2L_GTIOR_GTIOB | RZG2L_GTIOR_OBE,
> > +
> RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH);
> > +	else
> > +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR,
> > +				 RZG2L_GTIOR_GTIOA | RZG2L_GTIOR_OAE,
> > +
> RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzg2l_gpt_get_state(struct pwm_chip *chip, struct
> pwm_device *pwm,
> > +				struct pwm_state *state)
> > +{
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	u8 prescale;
> > +	u64 tmp;
> > +	u32 val;
> > +
> > +	/* get period */
> > +	state->period =3D rzg2l_gpt->state_period;
>=20
> This is useless. For one thing .state_period is only set by .apply()
> which might not have been called and in the interesting cases (i.e.
> with .enabled =3D true) the value is overwritten anyhow. I'd just drop
> this line.

OK , Agreed Will drop it.

>=20
> > +	pm_runtime_get_sync(chip->dev);
> > +	val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR);
> > +	state->enabled =3D val & RZG2L_GTCR_CST;
> > +	if (state->enabled) {
> > +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> > +
> > +		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR);
> > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
>=20
> This can overflow.

OK will use inverse calculation to avoid overflow.
mul_u64_u32_div(val << (2 * prescale), NSEC_PER_SEC, rzg2l_gpt->rate);

Is it ok?

>=20
> > +		state->period =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate);
> > +
> > +		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(pwm->hwpwm));
> > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
>=20
> ditto.
>=20
> > +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate);
> > +		/*
> > +		 * Ordering is important, when we set a period for the
> second
> > +		 * channel, as pwm_request_from_chip() calling get_state()
> will
> > +		 * have an invalid duty cycle value as the register is not
> > +		 * initialized yet. So set duty_cycle to zero.
> > +		 */
> > +		if (state->duty_cycle > state->period &&
> > +		    rzg2l_gpt->user_count > 1)
> > +			state->duty_cycle =3D 0;
>=20
> I would expect
>=20
> 		if (state->duty_cycle > state->period)
> 			state->duty_cycle =3D state->period;
>=20
> here?

OK. Agreed.

>=20
> > +	}
> > +
> > +	state->polarity =3D PWM_POLARITY_NORMAL;
> > +	pm_runtime_put(chip->dev);
> > +}
> > +
> > +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			   const struct pwm_state *state)
> > +{
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	int ret;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	pm_runtime_get_sync(chip->dev);
> > +	if (!state->enabled) {
> > +		if (rzg2l_gpt->pwm_enabled_by_bootloader) {
> > +			/*
> > +			 * For PWM enabled by bootloader case, Release the
> clk
> > +			 * framework resources and set the
> pwm_enabled_by_bootloader
> > +			 * variable to false. After this clock is managed by
> PM.
> > +			 */
> > +			rzg2l_gpt->pwm_enabled_by_bootloader =3D false;
> > +			devm_clk_put(chip->dev, rzg2l_gpt->clk);
> > +		}
> > +
> > +		rzg2l_gpt_disable(rzg2l_gpt);
> > +		ret =3D 0;
> > +		goto done;
> > +	}
> > +
> > +	mutex_lock(&rzg2l_gpt->lock);
> > +	ret =3D rzg2l_gpt_config(chip, pwm, state);
> > +	mutex_unlock(&rzg2l_gpt->lock);
> > +	if (ret)
> > +		goto done;
> > +
> > +	return rzg2l_gpt_enable(rzg2l_gpt);
> > +
> > +done:
> > +	pm_runtime_put(chip->dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct pwm_ops rzg2l_gpt_ops =3D {
> > +	.request =3D rzg2l_gpt_request,
> > +	.free =3D rzg2l_gpt_free,
> > +	.get_state =3D rzg2l_gpt_get_state,
> > +	.apply =3D rzg2l_gpt_apply,
> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> > +static const struct of_device_id rzg2l_gpt_of_table[] =3D {
> > +	{ .compatible =3D "renesas,rzg2l-gpt", },
> > +	{ /* Sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
> > +
> > +static void rzg2l_gpt_reset_assert_pm_disable(void *data) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D data;
> > +
> > +	pm_runtime_disable(rzg2l_gpt->chip.dev);
> > +	reset_control_assert(rzg2l_gpt->rstc);
> > +}
> > +
> > +static int rzg2l_gpt_probe(struct platform_device *pdev) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt;
> > +	int ret;
> > +
> > +	rzg2l_gpt =3D devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt),
> GFP_KERNEL);
> > +	if (!rzg2l_gpt)
> > +		return -ENOMEM;
> > +
> > +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(rzg2l_gpt->mmio))
> > +		return PTR_ERR(rzg2l_gpt->mmio);
> > +
> > +	rzg2l_gpt->rstc =3D devm_reset_control_get_shared(&pdev->dev,
> NULL);
> > +	if (IS_ERR(rzg2l_gpt->rstc))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> > +				     "get reset failed\n");
> > +
> > +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "cannot deassert reset control\n");
> > +
> > +	pm_runtime_enable(&pdev->dev);
> > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > +				       rzg2l_gpt_reset_assert_pm_disable,
> > +				       rzg2l_gpt);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	rzg2l_gpt->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > +	if (IS_ERR(rzg2l_gpt->clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> > +				     "cannot get clock\n");
> > +
> > +	rzg2l_gpt->rate =3D clk_get_rate(rzg2l_gpt->clk);
> > +	/*
> > +	 *  We need to keep the clock on, in case the bootloader has
> enabled the
> > +	 *  PWM and is running during probe(). A variable pwm_enabled_by_
> > +	 *  bootloader is set to true in that case and during first
> > +	 *  pwm_disable(), it is set to false and release the clock
> resource.
> > +	 *
> > +	 *  In case the pwm is not enabled by the bootloader,
> devm_clk_put
> > +	 *  disables the clk and holding a reference on the clk isn't
> needed
> > +	 *  because runtime-pm handles the needed enabling.
> > +	 */
> > +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> > +		rzg2l_gpt->pwm_enabled_by_bootloader =3D true;
> > +	else
> > +		devm_clk_put(&pdev->dev, rzg2l_gpt->clk);
>=20
> While it works I don't particularly like this construct. But maybe
> that's only me and I don't have a nice alternative to offer.

OK.

Cheers,
Biju

>=20
> > +
> > +	mutex_init(&rzg2l_gpt->lock);
> > +
> > +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> > +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> > +	rzg2l_gpt->chip.npwm =3D 2;
> > +
> > +	ret =3D devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
> > +	if (ret)
> > +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static struct platform_driver rzg2l_gpt_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "pwm-rzg2l-gpt",
> > +		.of_match_table =3D of_match_ptr(rzg2l_gpt_of_table),
> > +	},
> > +	.probe =3D rzg2l_gpt_probe,
> > +};
> > +module_platform_driver(rzg2l_gpt_driver);
> > +
> > +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> > +MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT)
> Driver");
> > +MODULE_LICENSE("GPL"); MODULE_ALIAS("platform:pwm-rzg2l-gpt");
> > --
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://www.pengutronix.de/ |
