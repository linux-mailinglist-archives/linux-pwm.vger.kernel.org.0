Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDFD53AD63
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jun 2022 21:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiFATam (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Jun 2022 15:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFATak (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Jun 2022 15:30:40 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2132.outbound.protection.outlook.com [40.107.113.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAD0243ECD;
        Wed,  1 Jun 2022 12:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHDpsmdP7WHFSHbTEcCPS3IINOfRKd5FsOIsJnkt+xOzRyfXRcOZ6FArTGN4A/R9NCygIeWaH5b37tiEqvI3GkX6LPZMcBG0ScGfhpxRjwWxHjInK/Xi0B4Y6EJEpfZZBqugfPGLWl+IBj0QuByy/TDgWPrmhVaSEIgOmLVM3FmQon1Ob56+0S4EcI5gEHmWJFh10rIopU6EKh7de10LlEIw4TMN1m0hRtsYGBNjc7nnqXTSHTYrqh2NyRO7IBtVEKHtKAgNgHZcHw0bbjz7YokQyP83HdUGaR1mC3BQRCXFKol0oqQ0VTMVqtR5wk8nQWtHuQyIqBay9SmKiVwThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVcqg54uYkLcPng+HDqkiH5JgW2m4PP0tSJHVE7KT1c=;
 b=H4AyuhXsl7LRses0bi0qEdS1I6Qixv73fMoEC1wgoBfgMUn3u3VokHd5VABGv/WgSGBlWTN20QBtSDnrvpnlxpM5RvDoTZAz7oKCgQYepqmnMbLW9IfvhgjEQ63dXmb4tsdY8Q2lsqs97BxfIImnK2KBpEGiV1OJXQZ0VGVWwx/J9+0vmJ7DnqLZIlmkRw/47ppfIDcl6HEnRJezvTmU2iajoCHqiY54stxEHNNU/Z2Uau5ADLYXnuev0REemvsLk1uJJp+m+0wi9rjMCaA/YtyAku3UxIN3I3xltbk2MCmlxV+5nnisL85XPKjLkU0s/YhByeHBDXIoU9d3sY1RYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVcqg54uYkLcPng+HDqkiH5JgW2m4PP0tSJHVE7KT1c=;
 b=Ly9z+iMFeGNaMKT7oBuua/ajzOuIsppuHCwfK7vaQEQ4n+YMKmBjeLhiM2JVhyE0nhC8gOGPdmwNFcPsd5NAR55PM+1O+EbxUsAbJmfuPwqw26ph3NLZ2NH/o8lHKZwGwJRIRiI8nmmokWIINn8BuL3PKASZk2cLFiLUpac0Ifo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB5060.jpnprd01.prod.outlook.com (2603:1096:604:6e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 19:25:28 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 19:25:28 +0000
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
Subject: RE: [PATCH 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYZHxJPKj+on69sUCHtZySxVH6FK0YTo6AgCK97uA=
Date:   Wed, 1 Jun 2022 19:25:28 +0000
Message-ID: <OS0PR01MB59227827AD31CBD0CCC31A6A86DF9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220510144259.9908-1-biju.das.jz@bp.renesas.com>
 <20220510144259.9908-3-biju.das.jz@bp.renesas.com>
 <20220510163405.pts6mm7zdoxxpmqt@pengutronix.de>
In-Reply-To: <20220510163405.pts6mm7zdoxxpmqt@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c307c95-1f2d-44ae-0848-08da44047c67
x-ms-traffictypediagnostic: OSAPR01MB5060:EE_
x-microsoft-antispam-prvs: <OSAPR01MB5060D0E6B9802DC88990A5F586DF9@OSAPR01MB5060.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TaSQcTrPLd3pF8SWMMPJSCsPYyFy0+UUeUBGULP/U/ix8JJfg5OTwkSqZ7WbeEz8laUYHHyzGM0+n/V5RQLZOT1NtWcAtAXFuW/a5V7ZMFnHCRcJiDHmzU0XK5SQaoK5mG7kD8jXyhHN4iZ2AI+ksEPhSp3bF2NaBl5PLIbRlOqb/1ggLMowDaomF1z88PzjEZpTI46cDx04Wz2vtuZQfIpPkTAml6UC9+U5a6nb4SCZF7fVaw6sb7yjVLrQYMeQQgnkXsMQiK4094LPsSyQNPHpYyGeJiH2bcTrBRTwrJUhLP5omq8dMzAP7VuVXza1nagn0GySBzEukXff4zgSwTxFem34dj3P/AZDu6eF5OM8CKiJN418t52L2ZfRo7g3RGl5YFABZV4zqxQTAFD4VnN7WYFhq8WIN1nNVGb2TUcKnohT8jVB2HqXLhh/Kl8NseWkj6hqXykRiFcPxrMvIFMiKUnk9S5z3V5izBn42mpDitJ7CbtWpXx7UeXHp5bmIxhRnttJT+ZghW/GHprOqnQh5t/9e6c4ziB2WOlH8iP6anSJoPLsQlZ0ZDvRyCOJ1tVTQSNzvx/Re7GyBIrZ0muvznj1Fko0vkPk1uBiU+71H1jz5sPiTMK7nSu1+c2QrCe/CKwiVH/dnJvGTCk9mvppQf/ysMagHi3Uwk6BZP8u3QMKVVGaxqv7aYpFgNiTKWS8IcIrZLAQP48xbE2UDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(52536014)(38100700002)(26005)(2906002)(7696005)(83380400001)(38070700005)(76116006)(186003)(122000001)(71200400001)(5660300002)(66446008)(64756008)(66556008)(66946007)(66476007)(508600001)(54906003)(9686003)(6916009)(86362001)(6506007)(55016003)(30864003)(33656002)(316002)(8936002)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hOhVf8eYLquPfEAsM6740oaAN4MdQUpDx88p8XlTF+4ZoDJT3gSIvZIAOb?=
 =?iso-8859-1?Q?UJhAq+Uc4fMpph9tWoI5TepCu77aUW6fmiT3pRtlODMFEQ3TEfGcHNEQqZ?=
 =?iso-8859-1?Q?skiEFEwLxFXXDtZOzTxZTkyfoGdtFjAPCBBxNTFA+OR9T2AQxfT/T8FAAG?=
 =?iso-8859-1?Q?jAd2cHcaB8GUYBqE70mzYBuIZ0Ene5t1GibyKIbfNmelytdtEM1nO9nCZr?=
 =?iso-8859-1?Q?IYfTHazpsaWfoM9VR+Di5P+751acpj1tyd+XvlJ8VJ2aCRNu6OryvX5kR2?=
 =?iso-8859-1?Q?VJieIRp5AUUFsRQs7B3GLFmIuuR6pzmONXaumJtf1EMxOrduBPS33M9m8t?=
 =?iso-8859-1?Q?mIxjrJ11ZAIAAKzFVFJoKnhZcxGqBNxFIvZ4Q7nFVZE0U3uT8XtdBKwjrU?=
 =?iso-8859-1?Q?QUuLhSg8c6y9nzE9qXJVGJR6VlDbNlR/yYObGaMIK1AEvE/JTcVgxAV06y?=
 =?iso-8859-1?Q?yBfM6FP80UKJc3QSfREZaC3xeCLgplrM6PDMzM4W1gNrCS31JsteyQSjs5?=
 =?iso-8859-1?Q?+NVnh0Qhus1PEa0obSL/hmej07AjgN3j3a1a1ddQ5up3c7qtk91xe7BNTi?=
 =?iso-8859-1?Q?6jYcLZoUehSQ6gvCbftcjcgQW0FdI6NeMVYfqtm3d7McBPSYrwBJTLOTn8?=
 =?iso-8859-1?Q?B3YwDUKv8g/XtEOPhnIiCKQpUAfRVhTzTk4qv3C1kdhCUCa0SLt21IYL1a?=
 =?iso-8859-1?Q?fF02iLMCNSFiVd6wHuENnr4938czEv9M7ALyS5hf6mKYkM8IxVM9O0ZxHt?=
 =?iso-8859-1?Q?8xPLzLxzBM/xYg50Nz6AmyR86J8dTHVFomoAm6lXE3t7/TmKD9iBKvdOMx?=
 =?iso-8859-1?Q?q3FdEbuIJv8RWuEntTsMjQfa8wNS8yaHoxJy8oWZqsJhnmOE7lbWO4WKJ6?=
 =?iso-8859-1?Q?KQX5bMd0s3aSas1G18QeCUSFCE/ce0apWrN6IQzd2jsrStMWlZt+GeZpIL?=
 =?iso-8859-1?Q?1GpKuNUU/UUpUttD5TTpE53fy9Z0nx14qFaLRdGUZyGRZRSfREJms4e3qu?=
 =?iso-8859-1?Q?iSRazUGumMDPbal64CRAetgcM1TRsvBwDMY0ItrI/fhHYrSpDgqzvHTmJT?=
 =?iso-8859-1?Q?3s/bAXjQbFC07G0AICqkWN+xoAI90rNeiGXzHac73AqegbvcD0WHra0HzI?=
 =?iso-8859-1?Q?Aof54t0WMe3kD7rxxKfkGShpL6i6PTEghvIX5Ol8aKwkISp4z/oMAF0zNM?=
 =?iso-8859-1?Q?2YHAOTGFNw4RVXJVCKfMoPRNKGca0ANO7JfNnj1+DUDol4EAC+Ib2ZLfos?=
 =?iso-8859-1?Q?8Yv4N7njI8I5OBhH4sfyO79gE3aFA08xyi3XmgsNkmskV/EFtn9hbyaXYI?=
 =?iso-8859-1?Q?jUs9xlwRMFMvCeDQDeaUUIVHSfE93CF5Z92I9PEdznYBLQfKbQ7cHQ3XRZ?=
 =?iso-8859-1?Q?1t3qvrB6Ps80Hi14wRkshXKnBSbZ+9kWgO/dDEqPLtL4Lu6F/yH6mP5cnw?=
 =?iso-8859-1?Q?7evUC6P+PbBj0SCuQ1PSpzM2i7y4XZBOhJ6pqTla9B4HnggMWzy8UqngTg?=
 =?iso-8859-1?Q?6hocJNxhzTPq4sJ0u3PCV1B7Cpd7Omzvwzc1K8k47RzmvdaqAT5QZ6UCud?=
 =?iso-8859-1?Q?AkX1OVOFWldSpC94U9MJthqzMWdEbYQsjm7lM/rjrFJvybzDQuPmIVHQ1g?=
 =?iso-8859-1?Q?qwK/rUDybUbNyc+ispTPLn8kpN/Gdi8TjVjy6uSBWCTXQ9NWbpB99WBsox?=
 =?iso-8859-1?Q?NPTNNYowAmuGsO9gnFbsOW+5RLd2XA5Z7j+ZhjDSwnIbTH57vzjCaR3oll?=
 =?iso-8859-1?Q?YxGmWu8oQzKd6/rYhpuESS/teOTk0caG9u8ry8O4uZwWgJ012w8DskPvps?=
 =?iso-8859-1?Q?0NcPLE/sPYjMPFfB0GJzU7KXlYImEc0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c307c95-1f2d-44ae-0848-08da44047c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 19:25:28.3562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xsuu8QLc1Dr7a2O7Um0T4Vd99+fOqIGHEUy2Vxw4yhjFp3UVFXp2Suh87ig/eJEYpcNoJnT2PFeWThrcBgP2piqE3SfYX3pbFgV61OAdmCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

> Subject: Re: [PATCH 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hello,
>=20
> On Tue, May 10, 2022 at 03:42:59PM +0100, Biju Das wrote:
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
> >  * Registers for setting up frame cycles in each channel (with capabili=
ty
> >    for generating interrupts at overflow or underflow)
> >  * Generation of dead times in PWM operation
> >  * Synchronous starting, stopping and clearing counters for arbitrary
> >    channels
> >  * Starting, stopping, clearing and up/down counters in response to inp=
ut
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
> > RFC->V1:
> >  * Updated macros
> >  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
> >  * Added rzg2l_gpt_read()
> > ---
> >  drivers/pwm/Kconfig         |  11 ++
> >  drivers/pwm/Makefile        |   1 +
> >  drivers/pwm/pwm-rzg2l-gpt.c | 355
> > ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 367 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > 21e3b05a5153..d93b510f9ca8 100644
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
> > index 708840b7fba8..bd213ae64074 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -43,6 +43,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberryp=
i-
> poe.o
> >  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > +obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
> >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> >  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > new file mode 100644 index 000000000000..d5d22b1ff792
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -0,0 +1,355 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L General PWM Timer (GPT) driver
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corporation  */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/pwm.h>
> > +#include <linux/reset.h>
> > +#include <linux/units.h>
> > +
> > +#define GPT_IO_PER_CHANNEL	2
> > +
> > +#define GTPR_MAX_VALUE	0xFFFFFFFF
> > +#define GTCR		0x2c
> > +#define GTUDDTYC	0x30
> > +#define GTIOR		0x34
> > +#define GTBER		0x40
> > +#define GTCNT		0x48
> > +#define GTCCRA		0x4c
> > +#define GTCCRB		0x50
> > +#define GTPR		0x64
> > +
> > +#define GTCR_CST			BIT(0)
> > +#define GTCR_MD_MASK			GENMASK(18, 16)
> > +#define GTCR_TPCS_MASK			GENMASK(26, 24)
> > +#define GTCR_MD_SAW_WAVE_PWM_MODE	(0 << 16)
>=20
> I assume this should better be FIELD_PREF(GTCR_MD_MASK, 0).
>=20
> Also I suggest to drop "_MASK" from the define names.

OK.

>=20
> > +#define GTUDDTYC_UP	BIT(0)
> > +#define GTUDDTYC_UDF	BIT(1)
> > +#define UP_COUNTING	(GTUDDTYC_UP | GTUDDTYC_UDF)
> > +
> > +#define GTIOR_GTIOA_MASK			GENMASK(4, 0)
> > +#define GTIOR_GTIOB_MASK			GENMASK(20, 16)
> > +#define GTIOR_OAE				BIT(8)
> > +#define GTIOR_OBE				BIT(24)
> > +
> > +#define INIT_OUT_LO_OUT_LO_END_TOGGLE		(0x07)
> > +#define INIT_OUT_HI_OUT_HI_END_TOGGLE		(0x1B)
> > +#define GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH
> 	(INIT_OUT_HI_OUT_HI_END_TOGGLE | GTIOR_OAE)
> > +#define GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH
> 	(INIT_OUT_LO_OUT_LO_END_TOGGLE | GTIOR_OAE)
> > +#define GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH
> 	((INIT_OUT_HI_OUT_HI_END_TOGGLE << 16) | GTIOR_OBE)
> > +#define GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH
> 	((INIT_OUT_LO_OUT_LO_END_TOGGLE << 16) | GTIOR_OBE)
> > +
> > +struct phase {
> > +	u32 value;
> > +	u32 mask;
> > +	u32 duty_reg_offset;
> > +};
> > +
> > +static const struct phase phase_params[] =3D {
> > +	/* Setting for phase A */
> > +	{
> > +		GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH,
> > +		GTIOR_GTIOA_MASK | GTIOR_OAE,
> > +		GTCCRA,
>=20
> Please use named initializer (i.e.
>=20
> 	.value =3D GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH,
> 	.mask =3D GTIOR_GTIOA_MASK | GTIOR_OAE,
> 	.duty_reg_offset =3D GTCCRA,
>=20
> )
OK. Agreed.

>=20
> > +	},
> > +
> > +	/* Setting for phase B */
> > +	{
> > +		GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH,
> > +		GTIOR_GTIOB_MASK | GTIOR_OBE,
> > +		GTCCRB,
> > +	},
> > +};
> > +
> > +struct rzg2l_gpt_chip;
> > +
> > +struct gpt_pwm_device {
> > +	struct rzg2l_gpt_chip *pc;
> > +	const struct phase *ph;
> > +	unsigned int channel;	/* IO channel number in the GPT */
> > +
> > +	enum pwm_polarity polarity;
> > +};
> > +
> > +struct rzg2l_gpt_chip {
> > +	struct pwm_chip chip;
> > +	void __iomem *mmio;
> > +	struct reset_control *rstc;
> > +	struct clk *clk;
> > +};
>=20
> I suggest to not allocate memory in .request, instead put the two struct
> gpt_pwm_device into a flexible array member in rzg2l_gpt_chip.
> I also suspect that most of struct gpt_pwm_device isn't worth being
> tracked. E.g. polarity is a write only variable.

OK. Will add to rzg2l_gpt_chip.

>=20
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
> > +	rzg2l_gpt_write(pc, reg, (rzg2l_gpt_read(pc, reg) & ~clr) | set); }
> > +
> > +static int rzg2l_calculate_prescale(struct rzg2l_gpt_chip *pc, int
> > +period_ns) {
> > +	unsigned long long c, clk_rate;
> > +	unsigned long period_cycles;
> > +	int prescale;
> > +	int i, prod;
> > +
> > +	clk_rate =3D clk_get_rate(pc->clk);
> > +	c =3D clk_rate * period_ns;
>=20
> This might overflow (once you keep period_ns as u64).
OK, the logic is changed like below to avoid overflow.

	freq =3D div_u64(clk_get_rate(pc->clk), 1000000);
	period_cycles =3D div_u64(freq * period_ns, 1000);

>=20
> > +	period_cycles =3D div_u64(c, NANO);
>=20
> Please use NSEC_PER_SEC here.
>=20
> > +
> > +	if (period_cycles < 1)
> > +		period_cycles =3D 1;
> > +
> > +	prescale =3D -1;
> > +	/* prescale 1, 4, 16, 64, 256 and 1024 */
> > +	for (i =3D 0, prod =3D 1; i < 6; i++) {
> > +		if ((period_cycles / GTPR_MAX_VALUE * prod) =3D=3D 0) {
> > +			prescale =3D i;
> > +			break;
> > +		}
> > +
> > +		prod *=3D 4;
> > +	}
>=20
> This would be better understandable if you used:
>=20
> 	for (i =3D 0; i < 6; i++) {
> 		prod =3D 1 << (2 * i);
> 		...
>=20
> 	}
>=20
> Have you tested this? The division by GTPR_MAX_VALUE (=3D 0xFFFFFFFF) loo=
ks
> suspicious. Unless I'm missing something
>=20
> 	if ((period_cycles / GTPR_MAX_VALUE * prod) =3D=3D 0)
>=20
> is equivalent to:
>=20
> 	if (period_cycles < GTPR_MAX_VALUE)
>=20
> . Is this really what you want here?

On the next version, I have changed the logic to check this condition in ca=
ller function.

	if (period_cycles > 1UL * GTPR_MAX_VALUE * GPT_MAX_PRESCALE_VAL) {
		dev_warn(chip->dev, "ch=3D%d period exceed limit\n", pwm->hwpwm);
		return -EINVAL;
	}


>=20
> > +
> > +	return prescale;
> > +}
> > +
> > +static unsigned long
> > +rzg2l_time_to_tick_number(struct rzg2l_gpt_chip *pc, int time_ns,
> > +			  unsigned long prescale)
> > +{
> > +	unsigned long long c, clk_rate;
> > +	unsigned long period_cycles;
> > +	int i, prod;
> > +
> > +	clk_rate =3D clk_get_rate(pc->clk);
> > +	c =3D clk_rate * time_ns;
> > +	period_cycles =3D div_u64(c, NANO);
> > +
> > +	if (period_cycles < 1)
> > +		period_cycles =3D 1;
> > +
> > +	/* Divide by 1, 4, 16, 64, 256 and 1024 */
> > +	for (i =3D 0, prod =3D 1; i < prescale; i++)
> > +		prod *=3D 4;
>=20
> 	prod =3D 1 << (2 * prescale);
>=20
> > +
> > +	return period_cycles / prod;
>=20
> 	return period_cycles >> (2 * prescale);

OK this function is removed in next version and directly using in the calle=
r.

	period_cycles =3D div_u64(freq * duty_ns, 1000);
	dc =3D period_cycles >> (2 * prescale);

>=20
> > +}
> > +
> > +static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device
> > +*_pwm) {
> > +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> > +	struct gpt_pwm_device *pwm;
> > +
> > +	if (_pwm->hwpwm >=3D GPT_IO_PER_CHANNEL)
> > +		return -EINVAL;
> > +
> > +	pwm =3D kzalloc(sizeof(*pwm), GFP_KERNEL);
> > +	if (!pwm)
> > +		return -ENOMEM;
> > +
> > +	pwm->pc =3D pc;
> > +	pwm->channel =3D _pwm->hwpwm;
> > +	pwm->polarity =3D PWM_POLARITY_NORMAL;
> > +	pwm->ph =3D &phase_params[pwm->channel & 0x1];
> > +	pwm_set_chip_data(_pwm, pwm);
> > +
> > +	pm_runtime_get_sync(chip->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device
> > +*_pwm) {
> > +	struct gpt_pwm_device *pwm =3D pwm_get_chip_data(_pwm);
> > +
> > +	pm_runtime_put(chip->dev);
> > +	kfree(pwm);
> > +}
> > +
> > +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device
> *_pwm,
> > +			    int duty_ns, int period_ns)
> > +{
> > +	struct gpt_pwm_device *pwm =3D pwm_get_chip_data(_pwm);
>=20
> Please use the variable name pwm only for pointers to struct pwm_device.
Agreed.

>=20
> > +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> > +	unsigned long pv, dc;
> > +	int prescale;
> > +
> > +	if (duty_ns < 0 || period_ns < 0) {
> > +		dev_err(chip->dev, "ch=3D%d Set time negative\n", pwm->channel);
> > +		return -EINVAL;
> > +	}
> > +
> > +	prescale =3D rzg2l_calculate_prescale(pc, period_ns);
> > +	if (prescale < 0) {
> > +		dev_err(chip->dev, "ch=3D%d wrong prescale val\n", pwm-
> >channel);
> > +		return -EINVAL;
> > +	}
> > +
> > +	pv =3D rzg2l_time_to_tick_number(pc, period_ns, prescale);
> > +	dc =3D rzg2l_time_to_tick_number(pc, duty_ns, prescale);
>=20
> I think the algorithm could be implemented in a much more understandable
> way.
>=20
> > +	if (duty_ns =3D=3D period_ns)
> > +		dc =3D pv;
>=20
> Isn't that already the case? If not, why? If yes, why do you calculate dc
> using rzg2l_time_to_tick_number at all?

It is not required.

>=20
> > +	/* GPT setting saw-wave up-counting */
> > +	rzg2l_gpt_modify(pc, GTCR, GTCR_MD_MASK, GTCR_MD_SAW_WAVE_PWM_MODE);
> > +	rzg2l_gpt_modify(pc, GTCR, GTCR_TPCS_MASK, prescale << 24);
>=20
> You're doing 2 reads and 2 writes here. Wouldn't a single write be better=
?

As per the hardware flow the sequence is like this, I need to set count dir=
ection
In between.
	/* GPT set operating mode (saw-wave up-counting) */
	/* Set count direction */
	/* Select count clock(prescalar) */


>=20
> Also please use FIELD_PREP(GTCR_TPCS_MASK, prescale) instead of the abov
> expression.

Agreed.

>=20
> > +	/* Set counting mode */
> > +	rzg2l_gpt_write(pc, GTUDDTYC, UP_COUNTING);
> > +	/* Set period */
> > +	rzg2l_gpt_write(pc, GTPR, pv);
> > +
> > +	/* Enable pin output */
> > +	rzg2l_gpt_modify(pc, GTIOR, pwm->ph->mask, pwm->ph->value);
> > +
> > +	/* Set duty cycle */
> > +	rzg2l_gpt_write(pc, pwm->ph->duty_reg_offset, dc);
> > +
> > +	/* Set initial value for counter */
> > +	rzg2l_gpt_write(pc, GTCNT, 0);
> > +	/* Set no buffer operation */
> > +	rzg2l_gpt_write(pc, GTBER, 0);
>=20
> How does the output behave on reprogramming? Does it complete the current=
ly
> programmed period? Please document this behaviour as e.g.
> drivers/pwm/pwm-sl28cpld.c does.

Mode and Prescalar must be set, only when the GTCNT is stopped.
This condition will document.

>=20
> > +	return 0;
> > +}
> > +
> > +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *pc) {
> > +	/* Start count */
> > +	rzg2l_gpt_modify(pc, GTCR, GTCR_CST, GTCR_CST);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *pc) {
> > +	/* Stop count */
> > +	rzg2l_gpt_modify(pc, GTCR, GTCR_CST, 0);
>=20
> Same question here: How does the hardware behave? Does it complete the
> currently running period? How does the output behave? (Typical candidates
> are: freeze at the level where it is currently, constant 0,
> high-z.)

It is set to output low during stop.

>=20
> > +}
> > +
> > +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			   const struct pwm_state *state)
> > +{
> > +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> > +	int ret;
>=20
> As you don't support different polarities, there is the following
> missing:

There is a plan to add polarity in later version.

>=20
> 	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> 		return -EINVAL;

Agree, will add this check in initial version.

>=20
> > +
> > +	if (!state->enabled) {
> > +		rzg2l_gpt_disable(pc);
> > +		return 0;
> > +	}
> > +
> > +	ret =3D rzg2l_gpt_config(chip, pwm, state->duty_cycle, state->period)=
;
>=20
> Note that state->duty_cycle is an u64, but the 3rd parameter to
> rzg2l_gpt_config is an int. So you're loosing bits here. (Yes, that is a
> problem that the core has, too, but you should still do better here.)
>=20
> > +	if (!ret)
> > +		ret =3D rzg2l_gpt_enable(pc);
> > +
> > +	return ret;
>=20
> It would make sense to unroll the function calls here.

OK, Agreed.

>=20
> > +}
> > +
> > +static const struct pwm_ops rzg2l_gpt_ops =3D {
> > +	.request =3D rzg2l_gpt_request,
> > +	.free =3D rzg2l_gpt_free,
> > +	.apply =3D rzg2l_gpt_apply,
>=20
> Please implement .get_state()

Agreed.

>=20
> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> > +static const struct of_device_id rzg2l_gpt_of_table[] =3D {
> > +	{ .compatible =3D "renesas,rzg2l-gpt", },
> > +	{ /* Sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
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
> > +	rzg2l_gpt->rstc =3D devm_reset_control_get_exclusive(&pdev->dev,
> NULL);
> > +	if (IS_ERR(rzg2l_gpt->rstc))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> > +				     "get reset failed\n");
> > +
> > +	rzg2l_gpt->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(rzg2l_gpt->clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> > +				     "cannot get clock\n");
> > +
> > +	platform_set_drvdata(pdev, rzg2l_gpt);
> > +
> > +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "cannot deassert reset control: %pe\n",
> > +			ERR_PTR(ret));
> > +		return ret;
> > +	}
> > +
> > +	pm_runtime_enable(&pdev->dev);
> > +
> > +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> > +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> > +	rzg2l_gpt->chip.npwm =3D GPT_IO_PER_CHANNEL;
> > +
> > +	ret =3D pwmchip_add(&rzg2l_gpt->chip);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to register GPT chip: %d\n", ret);
>=20
> Please use dev_err_probe.

OK.

>=20
> > +		pm_runtime_disable(&pdev->dev);
> > +		reset_control_assert(rzg2l_gpt->rstc);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int rzg2l_gpt_remove(struct platform_device *pdev) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D platform_get_drvdata(pdev);
> > +
> > +	pwmchip_remove(&rzg2l_gpt->chip);
> > +	pm_runtime_disable(&pdev->dev);
> > +	reset_control_assert(rzg2l_gpt->rstc);
>=20
> All these have devm variants that can be used to simplify the error paths
> in .probe and then you don't need a .remove function at all.

Agreed.

>=20
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver rzg2l_gpt_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "pwm-rzg2l-gpt",
> > +		.of_match_table =3D of_match_ptr(rzg2l_gpt_of_table),
> > +	},
> > +	.probe =3D rzg2l_gpt_probe,
> > +	.remove =3D rzg2l_gpt_remove,
> > +};
> > +module_platform_driver(rzg2l_gpt_driver);
> > +
> > +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> > +MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT) Driver");
> > +MODULE_LICENSE("GPL"); MODULE_ALIAS("platform:pwm-rzg2l-gpt");
>=20
> Please test your driver with PWM_DEBUG enabled.

OK.

>=20
> Assuming you test using sysfs, a good test is:
>=20
> 	echo 0 > duty_cycle
>=20
> 	for i in $(seq 10000 -1 1); do
> 		echo $i > period
> 	done
>=20
> 	for i in $(seq 1 10000); do
> 		echo $i > period
> 	done
>=20
> 	for i in $(seq 10000 -1 1); do
> 		echo $i > duty_cycle
> 	done
>=20
> 	for i in $(seq 1 10000); do
> 		echo $i > duty_cycle
> 	done

Cheers,
Biju
