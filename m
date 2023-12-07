Return-Path: <linux-pwm+bounces-440-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4AD808FD5
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Dec 2023 19:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41796B20F8F
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Dec 2023 18:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54E4E637;
	Thu,  7 Dec 2023 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="DGN3znZE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFCA1709;
	Thu,  7 Dec 2023 10:26:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az5800Y23hNQgtCrjd+59DueNbx4jdycQV/qKTHJkF3MO2m9RLFeK5QzHG5t+dDJV6xS/flw8DVs7+F2EmymsdIMlHWtM/LRTOU5B4eGYWMsjPL/rrjEvhKX/kVkRTH0tl1GV1hgcy1kHLrUh0aKFCikrjxd8lFxTsNMQejITeHT48hnzaGbd86VqiDsVYXQF4wzTW1muY9kD0nJmD3pXcQj6sqR+KLFkMp+kc0sqTOxtz1q8yNtcxTHq1NCwijOJhBgOvrYU1z5kLqRVXCt6YpMipntuJAZudbzNJ1a1FjOR80cJ+vklmnIITMC8IcmW5AaT5nMuMRAfptZk+GMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II5OZdjh8u1Huh3pofeMaxK2gTgAIyj7gAwnboHdv4A=;
 b=aEjDW75Lp4MKF0auoPBjFYMvchPYFXJcbmnHVA1djPAnakv2MVSn/RroOP8Qgl0wblrg8sSAcaQkF3tteUZjVvXMQGYFf1VJppbaWIoQFEZG6JQqvowgCxx1dfx5ySylbL6uI3K+nd6YXR9Z2WsEqSr71DEc6KwDFaqMRKMfxkmfdEpkcYEs6wgAAOonP/OkD28TXXn9pW5O87A59m6a1gqBiBIYTFW+hbN1G0pKEwOTcOsoaznno3VJugp+kAfvMU0t8Q+2PBgAe/OnsTkAG8ubOoZaopgi8O7r9UHgJmdZxaG621/SrAoqWd/ZuaGsbPeLPq5N2CIfgAoMB+NxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II5OZdjh8u1Huh3pofeMaxK2gTgAIyj7gAwnboHdv4A=;
 b=DGN3znZE1P4lvSPHitPUkniZSQSJkXFSWXndZdw5Du6mfHl1OzHHB28mOa6VFy55TJtnC3LPexeLIKveesav0icCRFExQ6TuEgHcVtJ+KrWJSlNx7e/f0j0glT+gYZo2yKqVst1Qlc+kvaHkntbMPlB74i2KrEH2IMiTKh3eV34=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYWPR01MB11194.jpnprd01.prod.outlook.com
 (2603:1096:400:3f9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.14; Thu, 7 Dec
 2023 18:26:44 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac%6]) with mapi id 15.20.7091.010; Thu, 7 Dec 2023
 18:26:44 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Magnus Damm
	<magnus.damm@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHaG6VjO3tWbpjOM0KBvyBIicGE/LCcr38AgAGHJgA=
Date: Thu, 7 Dec 2023 18:26:44 +0000
Message-ID:
 <TYCPR01MB1126952E843AC08DB732C18A5868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231120113307.80710-1-biju.das.jz@bp.renesas.com>
 <20231120113307.80710-4-biju.das.jz@bp.renesas.com>
 <20231206183824.g6dc5ib2dfb7um7n@pengutronix.de>
In-Reply-To: <20231206183824.g6dc5ib2dfb7um7n@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYWPR01MB11194:EE_
x-ms-office365-filtering-correlation-id: 8bc7da2e-cb15-4967-24e0-08dbf75210f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wLq7DewDSac5zX0xsl6+1pHMfSH25frpVFLCLSVVvA3v4SaUiiqh2S3UC9d77GGyIKB3UEaahgXAXwzfQHeCJe3g88VfyL7Z5GupMLe+r1DJH4k11SeNBEueUObxWsXcAYQDUjuyzroKUdRuGHdHACEYKDP56rDq/ZbkTxaEnWcJ5TxMSRF8ceQOAYhaRKm5XLCGVdoh4PCpnxZNPECVAb+noouxTOS70fx6kGlrsJvOTkOp+pGA7xHT7jkUoK6kdDRJJT5ObpmmEEvst1e3//mId4M8qjl30Q8zVxYHZlkGp4jo5AXmuA6Ex72OGu2ylDIIYtpchlMj84dPZZ0iiD6ZPndkJTJ5gjfhy3bqTFNPtWamRb4LsFzRtVZHwFkmDuDITIcDfR8p+dmYeHerVmIZHcSPodjg/C/A8HIxxplBm5YZrBr9NtmQmNXi1jL2XGguGYCjrx1T2Acea7phnWox/KJuZF7YwQAc+If6txy5Fs98kNGY3oW0wY1yuCXAVtLvob+T34eTo+iYlIzcZAJerx9QYG6CkDaJw8kAsD63I6/cyLa8Deeqi8U9QBQs0pZscQdkHC0m85ThFASbKyJ0aNnB7Xi0hUaOIybu07M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(6506007)(7696005)(9686003)(71200400001)(478600001)(53546011)(122000001)(33656002)(38100700002)(86362001)(30864003)(2906002)(26005)(41300700001)(66574015)(83380400001)(107886003)(38070700009)(52536014)(8936002)(76116006)(66946007)(66556008)(4326008)(66446008)(66476007)(5660300002)(6916009)(64756008)(54906003)(316002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VJuZG6qtjAOYZqNKcRe09ETvQOKivZOg9anRb6hNK3Kw9zSvKP1v1MuF0h?=
 =?iso-8859-1?Q?qondCPS+nmnUUvtdxDQoI+Rq7cseFDf9tvDDH/HZxcGmCvBO75+yoF8ETD?=
 =?iso-8859-1?Q?QjdUwmEULmNTUZRt+hyM/TtifbfkuM98LYdI9tJKkjvhT9AIHJTFu8ROg2?=
 =?iso-8859-1?Q?86+I1mtpFc+76DyhXbMQ+V47/wphI4sJcN5En77jD5te533T8MrWbN9I3m?=
 =?iso-8859-1?Q?M7XOsNuiPCKrdgMqvHZ+1prU73IA/OjW3j1fonnSPGw4SDa1RR+PAYp/qE?=
 =?iso-8859-1?Q?y53TbqtR2UH8EqzxAQ78StUGQP5/FGJkLdwrXsMga9vQdDjM8Yb+IeMVhR?=
 =?iso-8859-1?Q?6TroRkU7f1AFFHcRAR1CR0wcogaXY5ZSKSKHj8Qv4HthaazuH4sGHuAKRq?=
 =?iso-8859-1?Q?giTUIZaX8HF8ZYawkrdJYA4ja4h7xlvU+YsqXT/rCR/ADEsyYaWYBuddo+?=
 =?iso-8859-1?Q?21PHeh7nc5f6cuMSTg3koQAdmPgoyRCOO3N6fDOBAVb2EReyPXfHtlpZwS?=
 =?iso-8859-1?Q?SJfFRhs599ysdnUoZkEfE2PzuqWO2xNF8wEqW+nlYcapePOqKNSe35Egdt?=
 =?iso-8859-1?Q?meBpNE/JsxN2CcYgUOu+9+cx04vxEQAuqtS0R3WVir/ac6+KdDLWb25OeE?=
 =?iso-8859-1?Q?nS+8b+nN4Jtd49anBKvgGlWgbPB+Jv4Nc7g060YFDn4+jztyjor6OPS32e?=
 =?iso-8859-1?Q?32kmHqSB73d7yJJWA7TGq5GJ5oBxkyY4ZvPdvFFrEVdunZkohQlpjjPNwf?=
 =?iso-8859-1?Q?3hEBiqI0brfkwt0/aMYh0jlO+u2RyYfKmn+bshHTZ1v2Oc5Wj1zjkwUCkV?=
 =?iso-8859-1?Q?15aoMIoNw2HynvqtNcOFFdzMaJPCo+NN/Z4WgEseUZilJtwxBVnBs+YBVI?=
 =?iso-8859-1?Q?smnP3BiIr4dGCbCLmeKrcy5k/WRVoSWkjqlj640PDjkb5W1TKHs8CT2Cnq?=
 =?iso-8859-1?Q?goEcXpqn+nS64pEkLNj6PX6+JCE/hS6sxeixdXW4afMEWZl6nE5tMjE2M9?=
 =?iso-8859-1?Q?A2t3Y1i9jdwfeTvOlt+VdjRGDECuaKZC2yv7AIt98azwLW5rjln1a4cfjL?=
 =?iso-8859-1?Q?oQl3Y0gBGHJTNkId+eLcsaXYQ63ia1B0Ns9unedX/dOYVUj/2evxFp6xxb?=
 =?iso-8859-1?Q?hNNSMmMe61JSA1dPTasqUrdT63jFBv91HByqKTiMfLVbNX5Yr70D8AFD4q?=
 =?iso-8859-1?Q?eaj0W16keV7fQkMmALGezfVDwyQmxA/H2gkiNrZbgx37nXWsv31vhfJNbb?=
 =?iso-8859-1?Q?5CDQ+you88aWrkx4Ci3vAIhJDms+I1kv3vEtmfYWTA/ICs4YgxI81lFT1/?=
 =?iso-8859-1?Q?YPnn7tZroSligXJL55BltKqrgREPyn43feiVq4eqbwaPQ1uwb+P25mIcE0?=
 =?iso-8859-1?Q?UxvwIU0SUPQIGRaTlMaGPm9SoWZB9vHE4rXpNNCudhOuwUQbKG7U/MiRna?=
 =?iso-8859-1?Q?uEbYOHBq+2Tkawy1+Pt++RfCuFnfr1Ne5QsVI2csgTk5sKOC42bZA/9KdJ?=
 =?iso-8859-1?Q?YVxEwGj85WbgKmxH3gxn7/MJ2Q6LlURXQYwfBd5TyfEvPidpFqeNvFwKDs?=
 =?iso-8859-1?Q?MYS/7DQNqQ/wMY2wKqRC0OhZUxtC3l/GFNK7Z1oFerg5XvNWneS+eNed7F?=
 =?iso-8859-1?Q?/7LXLpTzY6jjrmu8IqKj0P0jHKl+KpjR4NARUwHrZ4pX7ONLkAJ0D02A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc7da2e-cb15-4967-24e0-08dbf75210f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 18:26:44.6944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrCRpZtb3w/VKQeGDz2Q2N1u/f32UlyF50Xlq9ot3Dy0dzaq6bkHVjp+aZt/7hiUuVtENhLZS1DYpNWQxX6WgDWmTsC9mgHBv1KBexEl9kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11194

Hi Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Wednesday, December 6, 2023 6:38 PM
> Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello Biju,
>=20
> On Mon, Nov 20, 2023 at 11:33:06AM +0000, Biju Das wrote:
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > new file mode 100644 index 000000000000..428e6e577db6
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -0,0 +1,572 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L General PWM Timer (GPT) driver
> > + *
> > + * Copyright (C) 2023 Renesas Electronics Corporation
> > + *
> > + * Hardware manual for this IP can be found here
> > + *
> > +https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-u
> > +sers-manual-hardware-0?language=3Den
> > + *
> > + * Limitations:
> > + * - Counter must be stopped before modifying Mode and Prescaler.
> > + * - When PWM is disabled, the output is driven to inactive.
> > + * - While the hardware supports both polarities, the driver (for now)
> > + *   only handles normal polarity.
> > + * - When both channels are used, disabling the channel on one stops
> the
> > + *   other.
>=20
> Just for my understanding: The combination of the first and the last item
> means you cannot update Moed and Prescaler for one channel without
> affecting the other one, right?

Yes that is correct.

>=20
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/limits.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
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
> > +	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE)
> > +| RZG2L_GTIOR_OBE) #define
> RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
> > +	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE)
> > +| RZG2L_GTIOR_OBE)
>=20
> These are not all used. Is it sensible to still keep them?

I will remove unused ones.

>=20
> > +#define RZG2L_GTCCR(i) (0x4c + 4 * (i))
>=20
> For i =3D 0 this is RZG2L_GTCCRA, for i =3D 1 it's RZG2L_GTCCRB. Als
> RZG2L_GTCCRA and RZG2L_GTCCRB are unused. Maybe move the definition of
> RZG2L_GTCCR to the list of registers above?

Agreed.

>=20
> > +#define RZG2L_MAX_HW_CHANNELS	8
> > +#define RZG2L_CHANNELS_PER_IO	2
> > +#define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS *
> RZG2L_CHANNELS_PER_IO)
> > +#define RZG2L_MAX_SCALE_FACTOR	1024
> > +
> > +#define RZG2L_IS_IOB(a)	((a) & 0x1)
> > +#define RZG2L_GET_CH(a)	((a) / 2)
> > +
> > +#define RZG2L_GET_CH_OFFS(i) (0x100 * (i))
> > +
> > +struct rzg2l_gpt_chip {
> > +	struct pwm_chip chip;
> > +	void __iomem *mmio;
> > +	struct reset_control *rstc;
> > +	struct clk *clk;
> > +	struct mutex lock; /* lock to protect shared channel resources */
> > +	unsigned long rate;
> > +	u64 max_val;
> > +	u32 state_period[RZG2L_MAX_HW_CHANNELS];
> > +	u32 user_count[RZG2L_MAX_HW_CHANNELS];
> > +	u32 enable_count[RZG2L_MAX_HW_CHANNELS];
> > +	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS); };
> > +
> > [...]
> > +
> > +static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt,
> > +u8 hwpwm) {
> > +	u8 ch =3D RZG2L_GET_CH(hwpwm);
> > +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> > +	bool is_counter_running, is_output_en;
> > +	u32 val;
> > +
> > +	val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> > +	is_counter_running =3D val & RZG2L_GTCR_CST;
> > +
> > +	val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTIOR);
> > +	if (RZG2L_IS_IOB(hwpwm))
> > +		is_output_en =3D val & RZG2L_GTIOR_OBE;
> > +	else
> > +		is_output_en =3D val & RZG2L_GTIOR_OAE;
>=20
> IIUC the i in RZG2L_GTCCR(i) stands for either A (0) or B (1), right?
> Maybe define RZG2L_GTIOR_OxE(i) assuming this is about the same A and B
> here? Then this could be simplified to:
>=20
> 	is_output_en =3D val & RZG2L_GTIOR_OxE(rzg2l_gpt_subchannel(hwpwm));
>=20
> (maybe modulo better names).

OK.

>=20
> > +	return (is_counter_running && is_output_en);
>=20
> You could return early after knowing that is_counter_running is false
> without determining is_output_en.

Agreed.

>=20
> > +}
> > +
> > +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *rzg2l_gpt,
> > +			    struct pwm_device *pwm)
> > +{
> > +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> > +
> > +	/* Enable pin output */
> > +	if (RZG2L_IS_IOB(pwm->hwpwm))
> > +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> > +				 RZG2L_GTIOR_GTIOB | RZG2L_GTIOR_OBE,
> > +				 RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH);
> > +	else
> > +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> > +				 RZG2L_GTIOR_GTIOA | RZG2L_GTIOR_OAE,
> > +				 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH);
>=20
> Similar suggestion as above for A and B?!

OK.

>=20
> > +	mutex_lock(&rzg2l_gpt->lock);
> > +	if (!rzg2l_gpt->enable_count[ch])
> > +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, 0,
> RZG2L_GTCR_CST);
> > +
> > +	rzg2l_gpt->enable_count[ch]++;
> > +	mutex_unlock(&rzg2l_gpt->lock);
> > +
> > +	return 0;
> > +}
> > +
> > [...]
> > +
> > +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
> > +u32 val, u8 prescale) {
> > +	u64 retval;
> > +	u64 tmp;
> > +
> > +	tmp =3D NSEC_PER_SEC * (u64)val;
> > +	/*
> > +	 * To avoid losing precision for smaller period/duty cycle values
> > +	 * ((2^32 * 10^9 << 2) < 2^64), do not process the rounded values.
> > +	 */
> > +	if (prescale < 2)
> > +		retval =3D DIV64_U64_ROUND_UP(tmp << (2 * prescale), rzg2l_gpt-
> >rate);
> > +	else
> > +		retval =3D DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate) << (2 *
> > +prescale);
>=20
> Maybe introduce a mul_u64_u64_div64_roundup (similar to
> mul_u64_u64_div64) to also be exact for prescale >=3D 2?

mul_u64_u64_div_u64()has a bug already and we are losing precision with ver=
y high values.
See the output with CONFIG_PWM_DEBUG enabled[1]. So we cannot reuse mul_u64=
_u64_div64()
for roundup operation.

Maybe we need to come with 128bit operations for mul_u64_u64_div64_roundup(=
).
Do you have any specific algorithm in mind for doing mul_u64_u64_div64_roun=
dup()?

Fabrizio already developed an algorithm for 128 bit operation, I could reus=
e once it
hits the mainline.

[1]
######[  304.213944] pwm-rzg2l-gpt 10048000.pwm: .apply is not idempotent (=
ena=3D1 pol=3D0 5500000000000/43980352512000) -> (ena=3D1 pol=3D0 550000000=
0000/43980239923200)
	 High setting##
	[  304.230854] pwm-rzg2l-gpt 10048000.pwm: .apply is not idempotent (ena=
=3D1 pol=3D0 23980465100800/43980352512000) -> (ena=3D1 pol=3D0 23980465100=
800/43980239923200)


>=20
> With prescale <=3D 5 and rzg2l_gpt->rate >=3D 1024 this shouldn't work ju=
st
> fine.

Practically this is not possible. Yes, from theoretical point, rate=3D1kHz=
=20
compared to the practical case, 100MHz won't work.

For the practical case, the current logic is fine. If we need to achieve
theoretical example like you mentioned then we need to have=20
mul_u64_u64_div64_roundup().

>=20
> > +	return retval;
> > +}
> > +
> > [...]
> > +static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8
> > +prescale) {
> > +	return min_t(u64, DIV64_U64_ROUND_UP(period_or_duty_cycle, 1 << (2 *
> prescale)),
> > +		     (u64)U32_MAX);
>=20
> DIV64_U64_ROUND_UP(period_or_duty_cycle, 1 << (2 * prescale)) can be
> calculated a bit cheaper by using:
>=20
> 	(period_or_duty_cycle + 1 << (2 * prescale) - 1) >> (2 * prescale)
>=20
> assuming the LHS doesn't overflow.

Need to check this.

>=20
> When using min_t, you can drop the cast for U32_MAX.

OK.

>=20
> > +}
> > +
> > +/* Caller holds the lock while calling rzg2l_gpt_config() */ static
> > +int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			    const struct pwm_state *state) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> > +	unsigned long pv, dc;
> > +	u64 period_cycles;
> > +	u64 duty_cycles;
> > +	u8 prescale;
> > +
> > +	/*
> > +	 * GPT counter is shared by multiple channels, so prescale and
> period
> > +	 * can NOT be modified when there are multiple channels in use with
> > +	 * different settings.
> > +	 */
> > +	if (state->period !=3D rzg2l_gpt->state_period[ch] && rzg2l_gpt-
> >user_count[ch] > 1)
> > +		return -EBUSY;
>=20
> if (state->period < rzg2l_gpt->state_period[ch] && rzg2l_gpt-
> >user_count[ch] > 1)
>=20
> would be more forgiving and still correct.

OK.

>=20
> > +	/* Limit period/duty cycle to max value supported by the HW */
> > +	if (state->period > rzg2l_gpt->max_val)
> > +		period_cycles =3D rzg2l_gpt->max_val;
> > +	else
> > +		period_cycles =3D state->period;
> > +
> > +	period_cycles =3D mul_u64_u32_div(period_cycles, rzg2l_gpt->rate,
> NSEC_PER_SEC);
> > +	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_cycles);
> > +
> > +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_cycles, prescale);
> > +
> > +	if (state->duty_cycle > rzg2l_gpt->max_val)
> > +		duty_cycles =3D rzg2l_gpt->max_val;
> > +	else
> > +		duty_cycles =3D state->duty_cycle;
> > +
> > +	duty_cycles =3D mul_u64_u32_div(duty_cycles, rzg2l_gpt->rate,
> NSEC_PER_SEC);
> > +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_cycles, prescale);
> > +
> > +	/*
> > +	 * GPT counter is shared by multiple channels, we cache the period
> value
> > +	 * from the first enabled channel and use the same value for both
> > +	 * channels.
> > +	 */
> > +	rzg2l_gpt->state_period[ch] =3D state->period;
>=20
> With the rounding that happens above, I think it would be more approriate
> to track period_cycles here instead of period.

OK.

>=20
> > [...]
> > +	rzg2l_gpt->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(rzg2l_gpt->clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> > +				     "cannot get clock\n");
> > +
> > +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "cannot deassert reset control\n");
> > +
> > +	ret =3D clk_prepare_enable(rzg2l_gpt->clk);
> > +	if (ret)
> > +		goto err_reset;
>=20
> devm_clk_get_enabled()?

OK.

>=20
> > [...]
> > +	/*
> > +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> > +	 * period and duty cycle.
> > +	 */
> > +	if (rzg2l_gpt->rate > NSEC_PER_SEC) {
> > +		ret =3D -EINVAL;
> > +		goto err_clk_rate_put;
> > +	}
> > +
> > +	rzg2l_gpt->max_val =3D mul_u64_u64_div_u64(U32_MAX, NSEC_PER_SEC,
> > +						 rzg2l_gpt->rate) *
> RZG2L_MAX_SCALE_FACTOR;
>=20
> Is it clear that this won't overflow?

It won't over flow as [2] < [3]

(2^32 * 10 ^9 % 100 * 10^6) * 1024.

2^32 * 10 ^9 =3D 4,294,967,296,000,000,000 --[2]
2^64         =3D 18,446,744,073,709,551,616--[3]

Cheers,
Biju

>=20
> > +	/*
> > +	 *  We need to keep the clock on, in case the bootloader has enabled
> the
> > +	 *  PWM and is running during probe().
> > +	 */
>=20

