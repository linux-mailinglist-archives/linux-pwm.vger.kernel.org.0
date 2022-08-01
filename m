Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31614587159
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Aug 2022 21:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiHATYN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Aug 2022 15:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiHATYM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Aug 2022 15:24:12 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2115.outbound.protection.outlook.com [40.107.113.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085012AC70;
        Mon,  1 Aug 2022 12:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+EnD0ls89Yr2z9ha390jpXXNlpKZes//oXhlYnKjnXWQNIGc3U/3Gq7nAt9tjsVfs3sCEFWX93CT1izgk7zO9oOvch0DPnqtLKVU3XTc2jAepTVzEsGjzZ/IKKpWox9q96fUjaD68ia6o6b0CUaWsCQhc3j4EK2FqFtSgRwmegyjaf2L05wWf/TE/6HzQD02yh5BA0kc5o+h7r5hkNi5VMyVcNGQQ4pgDAtVSxf+V17YdwiWkIl/WN0OkmYcl/jnM56W5Uv1snmDtQ4NJ4+aUPatu490R9lwNO7wBD8CqiOYqWjPPwPxLSmZe4MjJNDswiMpz8N6jqucK3iL66I4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mXx/Xrk5ndsE10if8UGVuedB797/1kNpoxClBQo9sI=;
 b=HgFyZhwhJsO5fIO+KuvgD6Rdm5y+MULAnmUCUwei7EJ2+3FMcSQCozw3dKT3el5qV+Kx9ZPpKKw6d0D+6CFsrIiHmRbebJwOxIw72BT9KK2+O/AxPByqq6Yhu0JrGwDXDxIybR4DwkzJxIkzw4LE+vvKM231jj6KM7MYa+D+lPdbUjFXMMuIxr/sMFGMy2NM6ECjlAyUZT/2i+n036gkHTcAOdew9M99mQFf0RzvMIBtWvY5L4JmKHteuQ8VfLiPGkFjufa92l5QlaQITanzmYgHPamGHuu2bvY//B+g9tZ89U7h7eE20qqqOWPj8lTAwVtxp5YskJx58zEtKbUM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mXx/Xrk5ndsE10if8UGVuedB797/1kNpoxClBQo9sI=;
 b=rbzDV45gJolU5cp2UxXbvlaWlgsm2Ycr0bINMnD5Dir46yDIL0ujnSXZ3ObJSnpEKMnpTQME9BS84SreGCC+gaLXHbOuCK3QFTPJ6l1MSscf4NDk5oNjmFLRBiMQ4aT6U0ekPm2NVgGjTrJ3rK6X9Mfnx7II7x7mESP1gJUt/XM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB7569.jpnprd01.prod.outlook.com (2603:1096:400:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 19:24:07 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:24:06 +0000
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
Subject: RE: [PATCH v4 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v4 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYop6viWpAzgfhNkuf1fxYJomgoK2YlLCAgAHZcbA=
Date:   Mon, 1 Aug 2022 19:24:06 +0000
Message-ID: <OS0PR01MB59228AB5226BD45C6E8C5B70869A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220728162526.330542-1-biju.das.jz@bp.renesas.com>
 <20220728162526.330542-3-biju.das.jz@bp.renesas.com>
 <20220731145107.iepktigt4g63ranr@pengutronix.de>
In-Reply-To: <20220731145107.iepktigt4g63ranr@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37503659-59d5-49e9-69eb-08da73f366d9
x-ms-traffictypediagnostic: TYWPR01MB7569:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xam0/s+Om8AxlFQ9B0XmVLUFUpf6RuyHpMyNlzX4+ewjpDRouVhS/yh9GBh3ahoDW+iNt+wKuC/U8hWahnmpiKjFgM+FZsikQDEqH6Prg30upW9CYSf6QNTe9Kyih5k5mWfyYfg9nAemsRU8JUmaN8KtJcWy4ljmgYcE5JXiZLzcj8Fh6CTRyzvkIkQQf+4NNgqmGpPazonj2kvzxcAldhRNyTUUZVOXb23RTPaMiHR1yHh0GRTj2xFlWTNN5kAx0MHaghIHhdIwcbxPsNB9ZOp1Dq4V+7v/gL/CTEzGTuPx55Qv9K5yTB8bK4x9S71YsrAl1Ao0x7XVNvff920rEI37Hn7YrVkLne0oTuNt3VyN3OfMFCyCGs9Eg1cS0qLOxEXzJupfFlxN9cOW3Aqa1dqjI98TkrCuWcGyg47doBbdilGUZaQqafhleAbtXU4A592/ZkGTIwVX/xV8spkXeODMqU1vBrirKgB3oKpAwKdhiNXCdW5yog5H2sYeGtD239aO7R+YRsjbeS1dRGHEKsFyjicpnoASNpI3d3tgHs6G7wBT+f/sF9Hd+RWdskuz484Ss6YW6VvXpJwyeP+L6hIAXDiXFGMLI6WrTOXiiTL6pqlxn/uvyKUaqxGZU3kimKoCDY+8C1qk2pCgQi4p34U+qJVwg2pe/09wvW/awuYbGHvWo5QtttTUkmkfs5Myqksz8odVTgOUVeHOb1qY37akjxRwvXEdCgJBthVVCqzSOEyHlRbuuKHgpXVJUV8GCYDGt0VfuLnoeSSsLKbb6msTHnQQLrv9YgdwkDkfNpJ7pyZ/nEyd9K7eJPMaCqMtgeOmpBF5sODWMGwfdny5Dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(55016003)(66476007)(76116006)(71200400001)(66946007)(8676002)(316002)(41300700001)(64756008)(33656002)(2906002)(66556008)(66446008)(4326008)(186003)(6916009)(54906003)(83380400001)(26005)(122000001)(9686003)(38100700002)(8936002)(86362001)(5660300002)(966005)(478600001)(38070700005)(6506007)(7696005)(52536014)(30864003)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZQaTXpW6H1KvVyM4wKnCxFdb3sYCTX9cgOBr1+ZDXvhwvNc4ikIggR5dGU?=
 =?iso-8859-1?Q?Y8I1DaeFdkzEv6uJCvx4WZsCxPzUtp8LfV56dd5/tbRpFa+Eom1YfhBHz5?=
 =?iso-8859-1?Q?Pt5gL3D8+Wv/r3mt9jHdzAMJNVofcAvDgndXWv9M6VlcqgviCkfZ5cIZZJ?=
 =?iso-8859-1?Q?loHqm6fK5XBFY9iHoHQFZ08Fr6EVwSqvNd59FhDuTWMsZflneYn9S7dTWc?=
 =?iso-8859-1?Q?2iRoFh9TCuDWwjQcGwZ75qYe7Mcj7n2/tRaJDr97FE+fVEsPPm4KwZyA3E?=
 =?iso-8859-1?Q?imp4zG+bO2StGku+KFEUKeSUcxJ4Jy0Y5/kv4QJ398rw1MuUTO+dJm4/Se?=
 =?iso-8859-1?Q?YIgFvYgPRDlxBLiEHK/YmujWO+jq4rTrTrmrKK5tbRg8C8hN/UFysrvtFJ?=
 =?iso-8859-1?Q?UiIW49eoewTTbbEfxjWo1ANt1BungmTJbcV6ATYk9QRcCDbmHDdmc46yua?=
 =?iso-8859-1?Q?iBmXwjFTWH+qmITopGlKZmWaaWGOp1nnfEQN0nPPlb+1mQT8hJ45EwWTE1?=
 =?iso-8859-1?Q?qy+mRoeYd1KN/uop/FPMrzFQEdRBm8B7sTaOwMv/8P9gTFJtCGqebVhp9a?=
 =?iso-8859-1?Q?vb/8WKgoQI0iHDV8dLN7vwE3YbF/eFYddPTvv565dX27JCWmQp1V2gAO+z?=
 =?iso-8859-1?Q?AZ6NqtWcOjX3NjVj8Hcj3CYGSfCpU4CKcsRQLWSkgXmoaI6G2iJeKHW6YY?=
 =?iso-8859-1?Q?Bf1gKydMO9Ji3f5MXc+Fzt/h7ruIf9GzKqBsN6ywfZlXJpe0K7H+2DhtCb?=
 =?iso-8859-1?Q?4YH8Kw4ezn5ol2Pu0N3wnR6OgWSpyXoCYxCjhOTtPtiA5gppVjdDHzs8j4?=
 =?iso-8859-1?Q?BLW2RLZ5goAxauYsbleaWoeNAJ1xhAX1rRg4LR2ayaOJhknJawf+Vn0HN8?=
 =?iso-8859-1?Q?ug0iJ2A/+ALAnJr5LUNb/7Fqewrx195A3vsMC18PUmnuRVaikGVgkPqkFn?=
 =?iso-8859-1?Q?4bgFqlve/u2Sx/UFcUN4iKigYoPKs/8QUvGLVp59AQpB/gBFE/GzXwiIXS?=
 =?iso-8859-1?Q?yJF2Q01JyS0uq3MDZHNLdC189VV4EBSlc//497Mz4RfaLH6rxs5lokK5t3?=
 =?iso-8859-1?Q?C7PKSJFL5fl/Z9poVMdKyBECDer+KBkLdOcUtJok4GlBpo7zSTyOeXnIkL?=
 =?iso-8859-1?Q?WuwtoWK+QFIngx/g2Ekyt53lZJdCXKr0kd1vjvJQSk9Z2sppFcW9wQIugC?=
 =?iso-8859-1?Q?8q5CzYnlUm7lIA+a/68ska2oGZQbyvlq++nii/MBOoIfjBmL3D15NPZL0f?=
 =?iso-8859-1?Q?cTczeJVNrn0QdVqMWIJlhXJqv7zE13/PnMgtpkJOefWAgBZngBiKW67klE?=
 =?iso-8859-1?Q?CwwdJLenKiDbbArqsoBQie7ok/FsF8eJBqh3CBTtsqrxvo9wymZrEXALCv?=
 =?iso-8859-1?Q?Dl0DDlfFiRJIYMymj6nZQFyfSxnssEOz9YjjDRTjLo2hjByiowOcA4tkUQ?=
 =?iso-8859-1?Q?SQKHj3McZvVFbMsmSIOn0G30ANOG4eyoR3uFrMEvOuXRkXaryOJmEXDUUR?=
 =?iso-8859-1?Q?CKobsyB2/7GMZCw6Dh4B4jkPNEQvj0BtBmCW9z0pRaYzN9JZ+bbw34Pm4j?=
 =?iso-8859-1?Q?f1giH5/4eLwLkfu+M+EqCi9ByzC2r6g9Z3wzSNFQQo32U89Q75//VWtP46?=
 =?iso-8859-1?Q?CZ7Kep8W8bbRBAcTeyFKTQ5lEiUpuAvj1CUjw3YfOKaljcvBeFqeUb5g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37503659-59d5-49e9-69eb-08da73f366d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 19:24:06.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zpfh5CJHQN2MGPUQTY09t/BfKC+g/o2hh2ehL7hyQudfpMBfC7Mq8KU9fISRQhsQtFG7h8IgjUtmaPDqq2BkqPCr1CqMxVbShorKPx8B4Fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7569
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

> Subject: Re: [PATCH v4 2/2] pwm: Add support for RZ/G2L GPT
>=20
> On Thu, Jul 28, 2022 at 05:25:26PM +0100, Biju Das wrote:
> > RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit
> > timer (GPT32E). It supports the following functions
> >  * 32 bits =D7 8 channels
> >  * Up-counting or down-counting (saw waves) or up/down-counting
> >    (triangle waves) for each counter.
> >  * Clock sources independently selectable for each channel
> >  * Two I/O pins per channel
> >  * Two output compare/input capture registers per channel
> >  * For the two output compare/input capture registers of each channel,
> >    four registers are provided as buffer registers and are capable of
> >    operating as comparison registers when buffering is not in use.
> >  * In output compare operation, buffer switching can be at crests or
> >    troughs, enabling the generation of laterally asymmetric PWM
> waveforms.
> >  * Registers for setting up frame cycles in each channel (with
> capability
> >    for generating interrupts at overflow or underflow)
> >  * Generation of dead times in PWM operation
> >  * Synchronous starting, stopping and clearing counters for arbitrary
> >    channels
> >  * Starting, stopping, clearing and up/down counters in response to
> input
> >    level comparison
> >  * Starting, clearing, stopping and up/down counters in response to a
> >    maximum of four external triggers
> >  * Output pin disable function by dead time error and detected
> >    short-circuits between output pins
> >  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
> >  * Enables the noise filter for input capture and external trigger
> >    operation
> >
> > This patch adds basic pwm support for RZ/G2L GPT driver by creating
> > separate logical channels for each IOs.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v3->v4:
> >  * Changed the local variable type i from u16->u8 and
> prescaled_period_
> >    cycles from u64->u32 in calculate_prescale().
> >  * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div()
> >  * Dropped the comma after the sentinel.
> >  * Add a variable to track pwm enabled by bootloader and added
> comments
> >    in probe().
> >  * Removed unnecessary rzg2l_gpt_reset_assert_pm_disable() from probe.
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
> >  * Added gpt_pwm_device into a flexible array member in rzg2l_gpt_chip
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
> >  drivers/pwm/Kconfig         |  11 ++
> >  drivers/pwm/Makefile        |   1 +
> >  drivers/pwm/pwm-rzg2l-gpt.c | 371
> > ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 383 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > 904de8d61828..a6cf24cb31e0 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -471,6 +471,17 @@ config PWM_ROCKCHIP
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
> > COMPILE_TEST diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 5c08bdb817b4..12bc2a005e24 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -43,6 +43,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-
> raspberrypi-poe.o
> >  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > +obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
> >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> >  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > new file mode 100644 index 000000000000..8d25428bed69
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -0,0 +1,371 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L General PWM Timer (GPT) driver
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corporation
>=20
> If there is a publicly available manual, adding a link here would be
> great.

Ok Will add the below details

+ * Hardware manual for this IP can be found here
+ * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-use=
rs-manual-hardware-0?language=3Den

>=20
> > + * Limitations:
> > + * - GTCNT must be stopped before modifying Mode and Prescaler.
>=20
> GTCNT is the counter of the hardware unit, right? So I suggest
> s/GTCNT/counter/ for better general understandability.

OK, Will use Counter
>=20
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
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/pwm.h>
> > +#include <linux/reset.h>
> > +#include <linux/time.h>
> > +
> > +#define RZG2L_GPT_IO_PER_CHANNEL	2
>=20
> I would not introduce a define for that number, trust the PWM framework
> to not pass a hwpwm >=3D 2 in .request and just use a plain
>=20
> 	rzg2l_gpt->chip.npwm =3D 2;
>=20
> in .probe.

OK, Agreed.
>=20
> > +
> > +#define RZG2L_GTPR_MAX_VALUE	0xFFFFFFFF
>=20
> This is unused.

Ok, will remove.

>=20
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
> > +#define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD,
> 0)
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
> > +	((RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE << 16) | RZG2L_GTIOR_OBE)
> > +#define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
> > +	((RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE << 16) | RZG2L_GTIOR_OBE)
> > +
> > +struct phase {
> > +	u32 value;
> > +	u32 mask;
> > +	u32 duty_reg_offset;
> > +};
> > +
> > +static const struct phase phase_params[] =3D {
>=20
> driver prefix for the type name and the variable please.
OK agreed.

>=20
> > +	/* Setting for phase A */
> > +	{
> > +		.value =3D RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH,
> > +		.mask =3D RZG2L_GTIOR_GTIOA | RZG2L_GTIOR_OAE,
> > +		.duty_reg_offset =3D RZG2L_GTCCRA,
> > +	},
> > +	/* Setting for phase B */
> > +	{
> > +		.value =3D RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH,
> > +		.mask =3D RZG2L_GTIOR_GTIOB | RZG2L_GTIOR_OBE,
> > +		.duty_reg_offset =3D RZG2L_GTCCRB,
> > +	},
> > +};
> > +
> > +struct gpt_pwm_device {
> > +	const struct phase *ph;
> > +};
>=20
> ditto
OK.

>=20
> > +
> > +struct rzg2l_gpt_chip {
> > +	struct pwm_chip chip;
> > +	void __iomem *mmio;
> > +	struct reset_control *rstc;
> > +	struct clk *clk;
> > +	struct gpt_pwm_device gpt[2];
> > +	bool pwm_enabled_by_bootloader;
> > +};
> > +
> > +static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct
> > +pwm_chip *chip) {
> > +	return container_of(chip, struct rzg2l_gpt_chip, chip); }
> > +
> > +static void rzg2l_gpt_write(struct rzg2l_gpt_chip *pc, u32 reg, u32
> > +data) {
> > +	iowrite32(data, pc->mmio + reg);
> > +}
> > +
> > +static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *pc, u32 reg) {
> > +	return ioread32(pc->mmio + reg);
> > +}
> > +
> > +static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *pc, u32 reg, u32
> > +clr, u32 set) {
> > +	rzg2l_gpt_write(pc, reg, (rzg2l_gpt_read(pc, reg) & ~clr) | set);
> }
> > +
> > +static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip *pc, u64
> > +period_cycles) {
> > +	u32 prescaled_period_cycles;
> > +	u8 prescale, i;
> > +
> > +	prescaled_period_cycles =3D period_cycles >> 32;
> > +	prescale =3D 5;
> > +	/* prescale 1, 4, 16, 64, 256 and 1024 */
> > +	for (i =3D 0; i < 6; i++) {
> > +		if ((1 << (2 * i)) > prescaled_period_cycles) {
> > +			prescale =3D i;
> > +			break;
> > +		}
> > +	}
>=20
> The following should be equivalent and (I guess) more effective to
> calculate as:
>=20
> 	prescaled_period_cycles =3D period_cycles >> 32;
> 	if (prescaled_period_cycles >=3D 256)
> 		prescale =3D 5;
> 	else
> 		prescale =3D (roundup_pow_of_two(prescaled_period_cycles + 1)
> + 1) / 2
>=20
> (Should prescaled_period_cycles =3D 256 really yield prescale =3D 5?)

Ok will use the above equation.

>=20
> > +
> > +	return prescale;
> > +}
> > +
> > +static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device
> > +*pwm) {
> > +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> > +	struct gpt_pwm_device *gpt;
> > +
> > +	if (pwm->hwpwm >=3D RZG2L_GPT_IO_PER_CHANNEL)
> > +		return -EINVAL;
> > +
> > +	gpt =3D &pc->gpt[pwm->hwpwm];
> > +	gpt->ph =3D &phase_params[pwm->hwpwm];
>=20
> This can already be done in .probe, doesn't it?

Ok, will remove this and will be do it in probe.

>=20
> > +	pm_runtime_get_sync(chip->dev);
>=20
> runtime PM is one of my bigger unknown spots, so my question might be
> missleading here: Doesn't that only have an effect if there is a suspend
> and resume callback for the device?

No, you can use that one for turning on/off multiple clocks with just one
API Call, provided PM domain implementation supports multi clock handling.

> Also I would expect these calls to be more sensible on enable + disable
> instead of request + free.

OK, Agreed.

>=20
> > +	return 0;
> > +}
> > +
> > +static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device
> > +*pwm) {
> > +	pm_runtime_put(chip->dev);
> > +}
> > +
> > +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *pc) {
> > +	/* Start count */
> > +	rzg2l_gpt_modify(pc, RZG2L_GTCR, RZG2L_GTCR_CST, RZG2L_GTCR_CST);
>=20
> Given the parameters to rzg2l_gpt_modify are called clr ("clear") and
> set, it's unintuitive what should happen if you pass the same bits to
> both parameters. I suggest to either rename the parameters to mask and
> set (and adapt the implementation accordingly) or to pass clr=3D0 here.

Will pass 0 here.

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *pc) {
> > +	/* Stop count, Output low on GTIOCx pin when counting stops */
> > +	rzg2l_gpt_modify(pc, RZG2L_GTCR, RZG2L_GTCR_CST, 0); }
> > +
> > +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			    u64 duty_ns, u64 period_ns)
> > +{
> > +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> > +	struct gpt_pwm_device *gpt =3D &pc->gpt[pwm->hwpwm];
> > +	unsigned long rate, pv, dc;
> > +	u64 period_cycles;
> > +	u8 prescale;
> > +
> > +	rate =3D clk_get_rate(pc->clk);
> > +	/*
> > +	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> > +	 * calculation.
> > +	 */
> > +	if (rate > NSEC_PER_SEC)
> > +		return -EINVAL;
> > +
> > +	period_cycles =3D mul_u64_u32_div(period_ns, rate, NSEC_PER_SEC);
> > +	prescale =3D rzg2l_calculate_prescale(pc, period_cycles);
> > +
> > +	pv =3D round_down(period_cycles >> (2 * prescale), 1 << (2 *
> prescale));
> > +	period_cycles =3D mul_u64_u32_div(duty_ns, rate, NSEC_PER_SEC);
> > +	dc =3D round_down(period_cycles >> (2 * prescale), 1 << (2 *
> > +prescale));
>=20
> It would be a bit less irritating to not reuse period_cycles for the
> duty cycle calculation. Either rename to cycles so it's not specific to
> the period length, or introduce a separate variable for the duty stuff.

Will introduce separate variable.

>=20
> Is it really true, that prescale influences both parameters of
> round_down as programmed here? I didn't thought deeply about that, but
> it feels strange.

I just made it like period as, rounddown of period value should never
go down compared to duty cycle.=20

>=20
> > +	/* GTCNT must be stopped before modifying Mode and Prescaler */
> > +	if (rzg2l_gpt_read(pc, RZG2L_GTCR) & RZG2L_GTCR_CST)
> > +		rzg2l_gpt_disable(pc);
>=20
> Your chip provides two PWMs. Do the two outputs share a single prescaler
> and period? In that case you need to make sure that modifying one of
> them doesn't change the other one. In case of conflict refuse the
> request. There are examples for that, see e.g.
> drivers/pwm/pwm-imx-tpm.c.

OK will add usage count and mutex like pwm-imx-tpm.c

>=20
> > +	/* GPT set operating mode (saw-wave up-counting) */
> > +	rzg2l_gpt_modify(pc, RZG2L_GTCR, RZG2L_GTCR_MD,
> > +RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> > +
> > +	/* Set count direction */
> > +	rzg2l_gpt_write(pc, RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
> > +
> > +	/* Select count clock */
> > +	rzg2l_gpt_modify(pc, RZG2L_GTCR, RZG2L_GTCR_TPCS,
> > +FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> > +
> > +	/* Set cycle */
>=20
> s/cycle/period/
OK.

>=20
> > +	rzg2l_gpt_write(pc, RZG2L_GTPR, pv);
> > +
> > +	/* Set duty cycle */
> > +	rzg2l_gpt_write(pc, gpt->ph->duty_reg_offset, dc);
> > +
> > +	/* Set initial value for counter */
> > +	rzg2l_gpt_write(pc, RZG2L_GTCNT, 0);
> > +
> > +	/* Set no buffer operation */
> > +	rzg2l_gpt_write(pc, RZG2L_GTBER, 0);
> > +
> > +	/* Enable pin output */
> > +	rzg2l_gpt_modify(pc, RZG2L_GTIOR, gpt->ph->mask, gpt->ph->value);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzg2l_gpt_get_state(struct pwm_chip *chip, struct
> pwm_device *pwm,
> > +				struct pwm_state *state)
> > +{
> > +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> > +	struct gpt_pwm_device *gpt =3D &pc->gpt[pwm->hwpwm];
> > +	unsigned long rate;
> > +	u8 prescale;
> > +	u64 tmp;
> > +	u32 val;
> > +
> > +	val =3D rzg2l_gpt_read(pc, RZG2L_GTCR);
> > +	state->enabled =3D val & RZG2L_GTCR_CST;
> > +	if (state->enabled) {
> > +		rate =3D clk_get_rate(pc->clk);
> > +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> > +
> > +		val =3D rzg2l_gpt_read(pc, RZG2L_GTPR);
> > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> > +		state->period =3D DIV_ROUND_UP_ULL(tmp, rate);
> > +
> > +		val =3D rzg2l_gpt_read(pc, gpt->ph->duty_reg_offset);
> > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> > +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rate);
> > +	}
> > +
> > +	state->polarity =3D PWM_POLARITY_NORMAL; }
> > +
> > +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			   const struct pwm_state *state)
> > +{
> > +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> > +	int ret;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	if (!state->enabled) {
> > +		rzg2l_gpt_disable(pc);
> > +		return 0;
> > +	}
> > +
> > +	ret =3D rzg2l_gpt_config(chip, pwm, state->duty_cycle, state-
> >period);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return rzg2l_gpt_enable(pc);
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
> > +	struct rzg2l_gpt_chip *pc =3D data;
>=20
> In the probe function the parameter is called rzg2l_gpt. Would be great
> to have always the same name for the same thing.

OK will use rzg2l_gpt throughout.

>=20
> > +
> > +	if (pc->pwm_enabled_by_bootloader)
> > +		clk_disable(pc->clk);
>=20
> When this function is called as part of remove, not disabling the clk is
> wrong, isn't it?

I will remove pwm_enabled_by_bootloader variable and=20
use the below changes, so it is taken care for the bootloader case.

+	rzg2l_gpt->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(rzg2l_gpt->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
+				     "cannot get clock\n");
+
+	rzg2l_gpt->rate =3D clk_get_rate(rzg2l_gpt->clk);
+
+	/*
+	 *  We need to keep the clock on, in case the bootloader enabled PWM and
+	 *  is running during probe().
+	 */
+	if (!(rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST))
+		devm_clk_put(&pdev->dev, rzg2l_gpt->clk);

>=20
> > +	pm_runtime_disable(pc->chip.dev);
> > +	reset_control_assert(pc->rstc);
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
> > +	rzg2l_gpt->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL);
> > +	if (IS_ERR(rzg2l_gpt->rstc))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> > +				     "get reset failed\n");
> > +
> > +	rzg2l_gpt->clk =3D devm_clk_get_prepared(&pdev->dev, NULL);
> > +	if (IS_ERR(rzg2l_gpt->clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> > +				     "cannot get clock\n");
> > +
> > +	platform_set_drvdata(pdev, rzg2l_gpt);
>=20
> This is unused.

OK will remove it.

>=20
> > +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "cannot deassert reset control: %pe\n",
> > +			ERR_PTR(ret));
>=20
> dev_err_probe for consistency

OK.

>=20
> > +		return ret;
> > +	}
> > +
> > +	pm_runtime_enable(&pdev->dev);
> > +
> > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > +				       rzg2l_gpt_reset_assert_pm_disable,
> > +				       rzg2l_gpt);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D clk_enable(rzg2l_gpt->clk);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret, "clk enable
> failed\n");
> > +	/*
> > +	 *  We need to keep the clock on, in case the bootloader enabled
> PWM and
> > +	 *  is running during probe().
> > +	 */
> > +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> > +		rzg2l_gpt->pwm_enabled_by_bootloader =3D true;
> > +	else
> > +		clk_disable(rzg2l_gpt->clk);
> > +
> > +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> > +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> > +	rzg2l_gpt->chip.npwm =3D RZG2L_GPT_IO_PER_CHANNEL;
> > +
> > +	return devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
>=20
> Please add an error message here if devm_pwmchip_add fails.

OK, Agreed.

Cheers,
Biju
