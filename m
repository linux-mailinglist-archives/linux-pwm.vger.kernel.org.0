Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F1657036C
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jul 2022 14:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiGKMzj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jul 2022 08:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiGKMzh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jul 2022 08:55:37 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2138.outbound.protection.outlook.com [40.107.113.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0462C2F653;
        Mon, 11 Jul 2022 05:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRd48NbQry9nJ4HpEk7WQjRznhEsGXuqQcKFXV7bBhtrxYJe2q7eCMWnN6iIZBIwp3RmntpYa7qCj4UbMryl97O07UV9f2gz6cuLLei5hJGSGM/6LRrThTL5ZLwAsGP2V7aSiK28PL5gUeDOcpQtfZQxL6dsUSiS2PtypDlYW90qBR8UPE4tOwllOd0IKMtJhUodvJTl1WVqLI6Aw0LbPPOkCfbSV9xb6pl3v6qAup4H0p81fYBlniRJeE9sLJZ2xQZVmlnkWM51MRkxOiU/N2JPoc19PNz65XHAzYqFgycdm8Y5+ZZdwQjxHsgZ5HXjMN2mx2MDepV67/wEJTepWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aloQNbJGqDQ9NugWs+bd7uHJxoya25qu7NIza1ZMT/s=;
 b=lrjLFGkRvYsRiQOwgLT9N3mqGOL8J77ftj4LmodCdzPVE6MR1xh5HeF024qeZ/fjF1Hnrt0fYIzCypqCCeK4o/TyD5dJAMLjWD+xZQ9oIQcLJ+G/pSsxAdb6RvuslGCgU3qs7gn5655VB/Tu4Mii5J3uklOqVJbbv918Y6Z5UCI9tjqhlcMemYWt+nR5bWPnirvamBUybNXPJ9CbCWVgGh/dxME4qnNbnUtgOIh+MtO04AtnCHzr/XerUoyxln2sqohKsU2o8ag5723DiGocxxngfeXDlyKCDLXmHgJ96A5ymTzKJ8aRF9cD291QGCzsjnDHTrY6GjSxcvbxVuV4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aloQNbJGqDQ9NugWs+bd7uHJxoya25qu7NIza1ZMT/s=;
 b=lmkCWyEuRWtmKNn+JhSxHnzr1MsemwYxvvNxdjhRFDO6oIvRao7/2ck0SN4/EucX2Wsu3k4AcLX9XHQnNB00CF+WhglRbAEEwLi3lE2WzqqngJebO0Uko3Nxjf5eAabkGHshmJb4mjPdaG3wCLvIXPF+2sRcenHGXU0LcDReSG0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY2PR01MB3290.jpnprd01.prod.outlook.com (2603:1096:404:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 12:55:31 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::dc06:eb07:874:ecce]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::dc06:eb07:874:ecce%8]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 12:55:31 +0000
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
Subject: RE: [PATCH v2 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v2 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYeb88fVRxU1LRfUqGAdbY2HigvK1IVR2AgDD3jIA=
Date:   Mon, 11 Jul 2022 12:55:31 +0000
Message-ID: <OS0PR01MB592298C8E5FFCCE333F60D6A86879@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220606160509.250962-1-biju.das.jz@bp.renesas.com>
 <20220606160509.250962-3-biju.das.jz@bp.renesas.com>
 <20220610083013.7asxcv4b554ln7pu@pengutronix.de>
In-Reply-To: <20220610083013.7asxcv4b554ln7pu@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59a9986b-5891-4189-af5e-08da633ca324
x-ms-traffictypediagnostic: TY2PR01MB3290:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rLHlvEu4cdCi7Sq+fBCLD/QskrlkiNhqDLWPQVq9NK6nkHHIsLTdIj4a26ZjbatqtydVffhUW22J4sYQLtKfEFeIH5jnEqSY4rsnTw2uZwTKEyhncqi+5GUoQ78+5Szm1KdrnPrW+VqwTWhQn3pS/ht5/LrU5MhxqCS2/6h4LMRdUXQBCcv0S653dxs+E/7z8TYSVnLfqijC2KDBIrV45SMcteQPzhZZ6We6RaYbSJz2QxuhPHiq5xsOCUGTgeo9JJfSPOJkvvbecUy+fwk2WKcVuuga5HbdDd6j+C+592DkgKOHkblKQ5RmIAhE9g6aa/1SdGTScVGgEaHIFxxWIaj8JkWKiHlpoT+139hPUk5HlYLYAi1KnNAIygbXHziUVCWjsXk1nFuRJzxy0BUCq0FvH7MW8XCceFugIY7Ho/2TRRa1nIPNw08XHzWfpvMuJ504OsR3QUm5LqDKjFc7PRKGc2kfTtugMUtk3SYD6kwoj5nka7RZPXc+5McVHwbJ88LgPpRN2qdDryZwgZShWNpA9VoObDIOF8eZVhcPP0IieVLSK1+C8sJbqALM4s7l73ZJQFTHhhsFz7x1qCQkcuH7GswJ5TKtHtDR2YicrHJn+ze2WuVpuYnkChgvEHYd9tWQFcjcdYXtuX22dSuA6wRQnlncJRfD+0fV3iqQbCcO1voOXuizonu6sTsuTqG/LBeQI17QOHFl/NRzwzAYGwoZVnCNc9weMnAiBK56xqtxl+mXL4p/GVh1i2vV2u1TR2cx0beT2raXXqUFEQMU2yrLqSm/Ly0vlLY5hgkGr/g3vdNN7wutl/1ORme/ZXpCJOUBygXGDdU0Zm4B3z5ahFCazye8OVfjMnWHSgEkJRo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(8936002)(4326008)(52536014)(316002)(30864003)(71200400001)(54906003)(55016003)(38100700002)(5660300002)(478600001)(122000001)(83380400001)(2906002)(66946007)(33656002)(966005)(66556008)(38070700005)(9686003)(26005)(66574015)(6506007)(66476007)(186003)(41300700001)(76116006)(66446008)(6916009)(86362001)(8676002)(64756008)(7696005)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XEQNW6yJql/H9KhTjGOGlqJSgpqEX/m6d+nObYSVR/gPwwOdPlfOYTToQP?=
 =?iso-8859-1?Q?cyR7DHfh2ankPksROmC53mIT4QJz6yUH7T0b2GPIq1rB4cGJIz1zJkA+Dd?=
 =?iso-8859-1?Q?XYS0w2qlo6QA0n0wd66nC8A6Wkzmh2ROjdwu1PnmsZCjCssurtCclz9H2K?=
 =?iso-8859-1?Q?gmwajkQa5VeiS4OdhFAk85R7ii54UDoDOudsB1Be05FU3rV87er6TJ4uFZ?=
 =?iso-8859-1?Q?1rjtC7fBb2h8S6xS1GitI1WpHx5h37d/jG8U7Yi9Jd63eUv8lSbEdk2zdZ?=
 =?iso-8859-1?Q?ebPaP+sopmgk7JAfrHLfJWfHNDZIcODCsqIHXyoO0RkxoVZjpCcfCsmzeq?=
 =?iso-8859-1?Q?x4QFHOnDA55n8o9vMskdrLVxU/N49DfoWpbnG+1N70paTgKoDgEhDF83g0?=
 =?iso-8859-1?Q?tc/JB/RIxnLv+dFxuAPKUJGzxEmWhneVivFjdBHwuCyD/aOdIR+O7+W9Uk?=
 =?iso-8859-1?Q?t7LNXNGBjbsLz+32/C7fH9A57892k9ora5pvSBapitXsSzdUjJITspC76Z?=
 =?iso-8859-1?Q?LJCChVDvshFy8ryY+GFl5zGqCv3PFK8RnT/2K74SpeIJqdt4ZxqGifoVd4?=
 =?iso-8859-1?Q?Aa6joEmrHa9pmTf+tQtQOR1CYtUNO7SGXZXjVS0R9VCuJMMcNcu0+wch7d?=
 =?iso-8859-1?Q?klTRmCnErRobxDbLXwb/ezHE2GVZMGvDSj/93bhehSnPcySGjmvDS7Y8/W?=
 =?iso-8859-1?Q?sNGtqGkd2om19wnkVB5WbHxiqHPuqm+LXpHHMvJoSUN5bOPCmSA1Yh2//9?=
 =?iso-8859-1?Q?X72m/DTETy6rOscTuKPJQTF77rcGJ9KggIG99lU2FzKgDtYcc5LO6hUJsb?=
 =?iso-8859-1?Q?L6fxleEdw1IXqyEt1RzmdVYGHn3jS6q5pdV5DNkhSgC+FAMOL3/2KjGwVQ?=
 =?iso-8859-1?Q?7AVEgHLsN3bUCbF/F+135Un+4dS/kRYMOZhnZM5T6925OscXJZgSFOasb/?=
 =?iso-8859-1?Q?YG/FQCyU612bt9lqhp3LO7vdbuWohXX2AqdxCkKzlTbWUws91xrbR9l7Sc?=
 =?iso-8859-1?Q?J1wNrgvrUaqQpSDo9SKUnBJRC9Y/A8hQQyEUavAFU/tRXyM/26ScRxTZM4?=
 =?iso-8859-1?Q?UrAqStbipzNOVwYNz8ctl937BYyn8+zJl0zLBTaEpeviMDjnqBzBr4eKzE?=
 =?iso-8859-1?Q?3CkqlSOvPlH/9M3J2RMaPVufO8QMeyTrhY+L8bH2JCuCp5I3+p+kqkiG6d?=
 =?iso-8859-1?Q?Jgs8qysirlg6v4njYdPnVEeLay+jWh0w6fqJ/eleXvvbf2PUu5LFNjPDPh?=
 =?iso-8859-1?Q?vtyjMsOP49kLk6BcwmcdWIUIVpfhm2hjaq2IKNgNDk4w9TlZmIxs0fSP/G?=
 =?iso-8859-1?Q?oCFz2NXJweaOK3QD1pvQXDjMY+HMhWk1G6eU84L2ZrKE+H9Pz3isNsc26g?=
 =?iso-8859-1?Q?nGCU8q2jjT2rVG+hR79XPZORRTIPffX1LTx163LkhGowcrClzcgOlSFIcU?=
 =?iso-8859-1?Q?1mDN0Er1B4uvV+o9pNcrJGrn5z7Z3eiaHLT+zOWMuxi4KlP1GBKRcMYe3l?=
 =?iso-8859-1?Q?T8Jh4NUXbohJ3TTh+bG0yGn4vZrlZdh3GrRkTpTirlNt51yd12+HN2XVZ5?=
 =?iso-8859-1?Q?NVWqtkYRyl84nnVfptEpMs1WeyTT4GeBqkRKD3OeMxl7ExTrnknsm1N8XA?=
 =?iso-8859-1?Q?NpuMHDJOQOng8an7yHtlXjzFNAIF1M0H++UeTKyPHQxAngD7nhziEjdQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a9986b-5891-4189-af5e-08da633ca324
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 12:55:31.2468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37c1giohtMCr5n1LhMrvEdfiMOSCEPCexUQip4sKmlfwcmviEufkNvbkAgdGG84jSqKA+qVR2/8QYWKEj7F6qOMUeMZ+XakUenU5k+nVQ78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3290
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

> Subject: Re: [PATCH v2 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hello,
>=20
> On Mon, Jun 06, 2022 at 05:05:09PM +0100, Biju Das wrote:
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
> >  drivers/pwm/pwm-rzg2l-gpt.c | 351
> > ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 363 insertions(+)
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
> > new file mode 100644 index 000000000000..f83ba2d5c219
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -0,0 +1,351 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L General PWM Timer (GPT) driver
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corporation
> > + *
> > + * Limitations:
> > + * - Mode and Prescalar must be set, while the GTCNT is stopped.
> > + * - Configured for Output low on GTIOCx pin when counting stops.
>=20
> The last item means the PWM emits the inactive level when disabled,
> right? Then I suggest to write that as:
>=20
>  * - When PWM is disabled, the output is driven to inactive.
>=20
> to simplify understanding that. Also add:
>=20
>  * - While the hardware supports both polarities, the driver (for now)
>  *   only handles normal polarity.

OK.

>=20
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
> > +#define GTCR_CST	BIT(0)
> > +#define GTCR_MD		GENMASK(18, 16)
> > +#define GTCR_TPCS	GENMASK(26, 24)
> > +
> > +#define GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(GTCR_MD, 0)
> > +
> > +#define GTUDDTYC_UP	BIT(0)
> > +#define GTUDDTYC_UDF	BIT(1)
> > +#define UP_COUNTING	(GTUDDTYC_UP | GTUDDTYC_UDF)
> > +
> > +#define GTIOR_GTIOA	GENMASK(4, 0)
> > +#define GTIOR_GTIOB	GENMASK(20, 16)
> > +#define GTIOR_OAE	BIT(8)
> > +#define GTIOR_OBE	BIT(24)
> > +
> > +#define INIT_OUT_LO_OUT_LO_END_TOGGLE	0x07
> > +#define INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> > +
> > +#define GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH
> 	(INIT_OUT_HI_OUT_HI_END_TOGGLE | GTIOR_OAE)
> > +#define GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH
> 	(INIT_OUT_LO_OUT_LO_END_TOGGLE | GTIOR_OAE)
> > +#define GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH
> 	((INIT_OUT_HI_OUT_HI_END_TOGGLE << 16) | GTIOR_OBE)
> > +#define GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH
> 	((INIT_OUT_LO_OUT_LO_END_TOGGLE << 16) | GTIOR_OBE)
>=20
> the LHS of the last define can be better written as:
>=20
> 	FIELD_PREP(GTIOR_GTIOB, INIT_OUT_LO_OUT_LO_END_TOGGLE) | GTIOR_OBE
>=20
> It's a bit longer, but doesn't duplicate the 16. Similar for the other
> defines.

But this is giving compilation error, Any pointers to fix this issue?

In file included from drivers/pwm/pwm-rzg2l-gpt.c:14:
./include/linux/bitfield.h:113:2: error: braced-group within expression all=
owed only inside a function
  113 |  ({        \
      |  ^
drivers/pwm/pwm-rzg2l-gpt.c:57:55: note: in expansion of macro 'FIELD_PREP'
   57 | #define RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH FIELD_PREP(RZ=
G2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE) | RZG2L_GTIOR_OBE
      |                                                       ^~~~~~~~~~
drivers/pwm/pwm-rzg2l-gpt.c:75:12: note: in expansion of macro 'RZG2L_GTIOR=
_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH'
   75 |   .value =3D RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:249: drivers/pwm/pwm-rzg2l-gpt.o] Erro=
r 1
make[1]: *** [scripts/Makefile.build:466: drivers/pwm] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1843: drivers] Error 2
make: *** Waiting for unfinished jobs....

>=20
> Can you please prefix all these defines all by RZG2L_?

Ok, Agreed.

>=20
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
> > +		.value =3D GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH,
> > +		.mask =3D GTIOR_GTIOA | GTIOR_OAE,
> > +		.duty_reg_offset =3D GTCCRA,
> > +	},
> > +	/* Setting for phase B */
> > +	{
> > +		.value =3D GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH,
> > +		.mask =3D GTIOR_GTIOB | GTIOR_OBE,
> > +		.duty_reg_offset =3D GTCCRB,
> > +	},
> > +};
> > +
> > +struct gpt_pwm_device {
> > +	const struct phase *ph;
> > +};
> > +
> > +struct rzg2l_gpt_chip {
> > +	struct pwm_chip chip;
> > +	void __iomem *mmio;
> > +	struct reset_control *rstc;
> > +	struct clk *clk;
> > +	struct gpt_pwm_device gpt[2];
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
> > +	rzg2l_gpt_write(pc, reg, (rzg2l_gpt_read(pc, reg) & ~clr) | set); }
> > +
> > +static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip *pc, u64
> > +period_cycles) {
> > +	u16 i, prod;
> > +	u8 prescale;
> > +
> > +	prescale =3D 5;
> > +	/* prescale 1, 4, 16, 64, 256 and 1024 */
> > +	for (i =3D 0; i < 6; i++) {
> > +		prod =3D 1 << (2 * i);
> > +		if ((period_cycles / (1ULL * GTPR_MAX_VALUE * prod)) =3D=3D 0) {
> > +			prescale =3D i;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return prescale;
>=20
> You must not do 64 bit divisions using /.
> Also you can shorten the calculation using something like:
>=20
> 	prescaled_period_cycles =3D period_cycles;
> 	do_div(prescaled_period_cycles, GTPR_MAX_VALUE);
>=20
> 	prescale =3D fls((prescaled_period_cycles + 1) >> 1);
> 	return min(prescale, 5);
>=20
> (Please double check, I didn't)

OK, will do.

>=20
> > +}
> > +
> > +static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device
> > +*pwm) {
> > +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> > +	struct gpt_pwm_device *gpt;
> > +
> > +	if (pwm->hwpwm >=3D GPT_IO_PER_CHANNEL)
> > +		return -EINVAL;
> > +
> > +	gpt =3D &pc->gpt[pwm->hwpwm];
> > +	gpt->ph =3D &phase_params[pwm->hwpwm];
> > +	pwm_set_chip_data(pwm, gpt);
>=20
> What is the advantage to do that here instead of at the place where gpt
> and gpt->ph is used?

Agreed, will remove pwm_set_chip_data as it is not reqd.

>=20
> > +	pm_runtime_get_sync(chip->dev);
> > +
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
> > +	rzg2l_gpt_modify(pc, GTCR, GTCR_CST, GTCR_CST);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *pc) {
> > +	/* Stop count, Output low on GTIOCx pin when counting stops */
> > +	rzg2l_gpt_modify(pc, GTCR, GTCR_CST, 0); }
> > +
> > +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			    u64 duty_ns, u64 period_ns)
> > +{
> > +	struct gpt_pwm_device *gpt =3D pwm_get_chip_data(pwm);
> > +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
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
> > +	period_cycles =3D mul_u64_u64_div_u64(rate, period_ns, NSEC_PER_SEC);
> > +	prescale =3D rzg2l_calculate_prescale(pc, period_cycles);
> > +
> > +	pv =3D round_down(period_cycles >> (2 * prescale), 1 >> (2 *
> prescale));
> > +	period_cycles =3D mul_u64_u64_div_u64(rate, duty_ns, NSEC_PER_SEC);
> > +	dc =3D round_down(period_cycles >> (2 * prescale), 1 >> (2 *
> > +prescale));
> > +
> > +	/* Mode and Prescalar must be set, while the GTCNT is stopped. */
>=20
> 	/* GTCNT must be stopped before modifying Mode and Prescaler */
>=20
> is more accurate. Would it make sense to check if mode and prescaler have
> to be modified before stopping the hardware?

You mean cache, the mode and prescalar value and stop the H/w if an update =
reqd??
In this case, we need to add additional check before=20
1) rzg2l_gpt_disable
2) GPT set operating mode
3) Select Prescale

> > +	if (rzg2l_gpt_read(pc, GTCR) & GTCR_CST)
> > +		rzg2l_gpt_disable(pc);
> > +
> > +	/* GPT set operating mode (saw-wave up-counting) */
> > +	rzg2l_gpt_modify(pc, GTCR, GTCR_MD, GTCR_MD_SAW_WAVE_PWM_MODE);
> > +
> > +	/* Set count direction */
> > +	rzg2l_gpt_write(pc, GTUDDTYC, UP_COUNTING);
> > +
> > +	/* Select count clock */
> > +	rzg2l_gpt_modify(pc, GTCR, GTCR_TPCS, FIELD_PREP(GTCR_TPCS,
> prescale
> > +& 0x3));
>=20
> prescale is <=3D 5, so there is no need for & 0x3.

OK, Agreed.

>=20
> > +	/* Set cycle */
> > +	rzg2l_gpt_write(pc, GTPR, pv);
> > +
> > +	/* Set duty cycle */
> > +	rzg2l_gpt_write(pc, gpt->ph->duty_reg_offset, dc);
> > +
> > +	/* Set initial value for counter */
> > +	rzg2l_gpt_write(pc, GTCNT, 0);
> > +
> > +	/* Set no buffer operation */
> > +	rzg2l_gpt_write(pc, GTBER, 0);
> > +
> > +	/* Enable pin output */
> > +	rzg2l_gpt_modify(pc, GTIOR, gpt->ph->mask, gpt->ph->value);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzg2l_gpt_get_state(struct pwm_chip *chip, struct
> pwm_device *pwm,
> > +				struct pwm_state *state)
> > +{
> > +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> > +	struct gpt_pwm_device *gpt =3D pwm_get_chip_data(pwm);
> > +	unsigned long rate;
> > +	u8 prescale;
> > +	u32 val;
> > +
> > +	val =3D rzg2l_gpt_read(pc, GTCR);
> > +	state->enabled =3D val & GTCR_CST;
> > +	if (state->enabled) {
> > +		rate =3D clk_get_rate(pc->clk);
> > +		prescale =3D FIELD_GET(GTCR_TPCS, val);
> > +
> > +		val =3D rzg2l_gpt_read(pc, GTPR);
> > +		state->period =3D div_u64(val, rate) << (2 * prescale);
>=20
> Didn't PWM_DEBUG report a problem here?=20
What is rate typically? Which
> ranges did you test with PWM_DEBUG enabled?=20

PWM_DEBUG doesn't report any problem.

Rate is 100MHz and 32bit counter.

I have tested the range you mentioned in previous mail thread.

Assuming you test using sysfs, a good test is:

	echo 0 > duty_cycle

	for i in $(seq 10000 -1 1); do
		echo $i > period
	done

	for i in $(seq 1 10000); do
		echo $i > period
	done

	for i in $(seq 10000 -1 1); do
		echo $i > duty_cycle
	done

	for i in $(seq 1 10000); do
		echo $i > duty_cycle
	done

This doesn't look to match

> .apply(). I suspect .apply is wrong here, if I had to guess the division
> by 0xffffffff is bogus.
>=20
> Also you're loosing precision here. div_u64(val << (2 * prescale), rate)
> would return a more accurate value. (However you had to make sure that
> the shift doesn't overflow.)

OK, will change the logic.

>=20
> > +		val =3D rzg2l_gpt_read(pc, gpt->ph->duty_reg_offset);
> > +		state->duty_cycle =3D div_u64(val, rate) << (2 * prescale);
> > +	} else {
> > +		state->period =3D GTPR_MAX_VALUE;
> > +		state->duty_cycle =3D 0;
>=20
> You can drop this else branch.

OK, Agreed.

>=20
> > +	}
> > +
> > +	state->polarity =3D PWM_POLARITY_NORMAL; }
> > +
> > +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			   const struct pwm_state *state)
> > +{
> > +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> > +	int ret =3D 0;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	if (!state->enabled)
> > +		goto err;
>=20
> I wouldn't call this "err", a request to disable the PWM isn't an error.

I will just return 0 here.

>=20
> > +	ret =3D rzg2l_gpt_config(chip, pwm, state->duty_cycle, state-
> >period);
> > +	if (ret)
> > +		goto err;
>=20
> No need to disable the PWM in this case, just return ret here.

OK.

>=20
> > +	return rzg2l_gpt_enable(pc);
> > +err:
> > +	rzg2l_gpt_disable(pc);
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
> > +	{ /* Sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
> > +
> > +static void rzg2l_gpt_reset_assert_pm_disable(void *data) {
> > +	struct rzg2l_gpt_chip *pc =3D data;
> > +
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
> > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > +				       rzg2l_gpt_reset_assert_pm_disable,
> > +				       rzg2l_gpt);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> > +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> > +	rzg2l_gpt->chip.npwm =3D GPT_IO_PER_CHANNEL;
> > +
> > +	return devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
>=20
> If the PWM is already running during probe (e.g. because the bootloader
> enabled the LCD backlight and showed a splash screen), you should make
> sure to keep the PWM in that state. In this case you are required to
> enable the clk.

OK, I will check the running state and disable the clk, if it is not runnin=
g.

        ret =3D pm_runtime_resume_and_get(&pdev->dev);                     =
       =20
         if (ret < 0)                                                      =
      =20
                return dev_err_probe(&pdev->dev, ret, "pm_runtime_resume_an=
d_get failed");
                                                                           =
      =20
         if (!(rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST))    =
      =20
                 pm_runtime_put(&pdev->dev); =20

Regards,
Biju

>=20
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
> > +MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT) Driver");
> > +MODULE_LICENSE("GPL"); MODULE_ALIAS("platform:pwm-rzg2l-gpt");
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 | https://www.pengutronix.de/
> |
