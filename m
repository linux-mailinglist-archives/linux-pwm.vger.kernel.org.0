Return-Path: <linux-pwm+bounces-1761-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8617B87C26E
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Mar 2024 19:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145961F21963
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Mar 2024 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A674C0A;
	Thu, 14 Mar 2024 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="u+KrULC9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2084.outbound.protection.outlook.com [40.107.114.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4FB74BF2;
	Thu, 14 Mar 2024 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710439859; cv=fail; b=gg4zCIqK2vvBJw5RnUo9UE5k6McPUMGXMfIDLsWWmMgxpI/VqvyCiELIwN+IpxoMw9txN7180yT6DXegBZpemw0jtV065wPGBYJ4TWcbTRaF2ilkl9KcLKL5iLdaXimFSTeBikHrr3jP5iMubxloevhLxqXGsxuDmVSGHNIbd7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710439859; c=relaxed/simple;
	bh=RhtQnixAl9VQAcseggpEDN3igeTO6j98+klUIOFsYXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ftxcn/mQ9kUh78ZFND76YQUL/0XBz2LNWA1kr6x5sn/DHnK5l4OK0ZuDTiwsdfwgj35OlDxn6IbQX9SdSYq7X1AAf1Z33ARSnpWgqSJIexSQGxoyc9xMPshgrYCYysSRWisEgG0gBqYPuOu/Pbe95bhUQWKN6qBC4/Mw8AbgAFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=u+KrULC9; arc=fail smtp.client-ip=40.107.114.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMuOoufmFlW1PD3Va9da6FTbhNbkx6T3BL7LpS9R3hMydoX3MfVMpmzoj3KtDntJYxzWMUW9EeRxLZbcCZj1owRfo7Y+2i1lIzGOO3nbwH9uiMRAlSeEba+KL3x6SkLHEqxwJJogjxxQpr/3c8ZmABb/3bYVa3zGzz1bg6XrnkOXkWgBwtwF3RLXQFo+VdcWRx/v1JTjaqnLxwC0T4gabvnTzFAZrwP44TNi9OKVdN1/FbfpG8MwF/Wvup7JpjtEFssblTW8KsV4r6p+81Yf6YnzlTMvpqLJJpp2jynS3VRSMcpHOfBTsg/xyBW7Z00P1K8DGX/q6UmUT+tQT1ytEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VON3NkF8Ajs/sKWD/3x9WuOrIdvgpxeTMXhmRmUe7iQ=;
 b=aXREp64FaMk/tHWWq4Av8biZHWX/h6VaUXDQMEtsYfGYmVe0a1UlWdZ6blbAXu2cgjLidzySKsQIDdr1nF7Jtj5xj5UnmRWr7TerM+qHq00rB0D87T42EmeSjRNMrArvG2plyujWBVs8jYz7JHDOxuDCtdg+nFPDBTp4O5NkMh7uphhztIS/go1q08GG323fDO19cLWR9CFSfZ2D2XHjNeuZBwEaE7BKgoAaJplN3+D+ePv44wk90IJL+cBUI3VrMOjsIkGalnRLHrmlZ/zhREC5CKEIDT/gvGtPo4Q6gVdlJOJgPrc13brEECjGMx7QiKSby9vCvoy0NBj7Vy7O1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VON3NkF8Ajs/sKWD/3x9WuOrIdvgpxeTMXhmRmUe7iQ=;
 b=u+KrULC9QEM7HocX6Entqsknwdm93U4PBQ1EYTtKVyhup0NLnC+cs/FzoyAeHUVsfwIbqeRVYtS3Fr1G7MJRacVFoHFDARfC7UORybHJNTBZEd9jPSxUlNHV9b0GQACYsXuLPzX4r63PLs/vWJ5T3lk603YlQnkmAxrwJvCfe8k=
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com (2603:1096:603:2e::16)
 by OS3PR01MB10027.jpnprd01.prod.outlook.com (2603:1096:604:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 18:10:51 +0000
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::aef6:c35b:b90d:2e3f]) by OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::aef6:c35b:b90d:2e3f%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 18:10:51 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Magnus Damm
	<magnus.damm@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v18 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v18 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHaZDUd2szw5U1SmEaBqj/KTS2kjrEz0w2AgAPRLgA=
Date: Thu, 14 Mar 2024 18:10:50 +0000
Message-ID:
 <OSAPR01MB1587400FECDBFDB3E38A594286292@OSAPR01MB1587.jpnprd01.prod.outlook.com>
References: <20240220194318.672443-1-biju.das.jz@bp.renesas.com>
 <20240220194318.672443-4-biju.das.jz@bp.renesas.com>
 <hy5crf2leuvewkn5omgrk2bmkndivwmhst4yrefnd3mepy4nzd@xw3rtkxdnb2g>
In-Reply-To: <hy5crf2leuvewkn5omgrk2bmkndivwmhst4yrefnd3mepy4nzd@xw3rtkxdnb2g>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1587:EE_|OS3PR01MB10027:EE_
x-ms-office365-filtering-correlation-id: e2b5b3c7-3fa2-4f0b-00f7-08dc445214f3
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8hT2SSNDHjkuJYgzDwlrPzlrb3vn2UXK26umUqGP2ie2Kr1WnMjiWSF/3PETFnlQsHz8L2gtLtk8PHeDYqlF6//IxC+/G7+40yFMHqso8BReVU10EdMgMC9pExkcneiLTwgfSB8jdEw4RRWqlfF3RAN6xHPhD93DtnzAtB9UsOdBOoQUZR6tsGHMm2mSBhnXozdfqfgh+RKmhMntgMDVp1iSx4T2wEngdq7bs6ffp8m32MoH9o6w0eOVUyH/oEfLdwbHpqY6oS6NeEbkIwLxne4a9LqDpIOH/0EtWg+8gkM7tcV2EBkJnQyPEZ498B5mNilbfHdt82KN6YWiIBXuHHqWn6c7XADHJ8/3oNDZZkxt3iUQp6qrhVTTcnz83UkQtxdUqE4mV++Qxw+kMXAv5b9TpY0j9gCJ8sPrCaR1Bn6n/XHS7/OoicdfIPvcRAMTgGKf6CM5TuGKlYGvmj3AqYAsZsrpiDwcJ+ttC7j6nyyJGzZJxe6qmVKxnkPXY7NapQVs2BQ4EUoHmp8YZ30et5K/INRG4yULDqTVcZslqLduvUcwq0xD3Gl1RiqKrArxsqmzregKEeGGCcKvLxgYDLs6GblBW7B3Eqxs7TVmT2uzGRNQD3z1YGZsAKRGZ9NqNtAw+0/DwMJNmAI6u6hflAm9MPjlPU5n4obK5zvneG71pTEnQulFl/o3nVU9Z06A
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1587.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Nptt+t14eh3ytSgV/ee2zqbqpSpagzDZjTiy9qo9yl49R30Cr2238Id5NU?=
 =?iso-8859-1?Q?4qtWVVoW0OV+xR1LXmgv4avaPqOfAfztwUdZNl7i3dmRsjFcFraBDZgjXW?=
 =?iso-8859-1?Q?fhKCQ7m5CyvelVmIZR9Lsz7h2hTj2rh/CIX9znGs0Ei/Z6R3Oaesv1DINF?=
 =?iso-8859-1?Q?sYV2zgcpfcl98389OS3/ia9gxSFpC54uXnnl2LwxsWkGYNqFPCAfSG5B6Z?=
 =?iso-8859-1?Q?XC7pzIytZs+rO8XqRx1oIHKkgOQkq9FJSdV1RxmE8t9bgqvic0bgsAYrXo?=
 =?iso-8859-1?Q?ZO0Ygo1ciugVIg/U+rNrF7by/HWy7evguMT1KVP8LWsuF0dDmyp228dJ/k?=
 =?iso-8859-1?Q?+/1RnRPq4NMZ4udRwQdysmXsXr+rn17vVhkQRyIpQbhEFnpE+uj8D2mxoy?=
 =?iso-8859-1?Q?gU8Gka8jFrFvT6haIrWnysK4b095+1sH3ZyGEY4aSZRvW2ago6jXCqG+KX?=
 =?iso-8859-1?Q?zABdckBjarfMC7UWiYPilm6l9XeoVPyfQxIOS5t4F5KuphMlBXCtytY6dz?=
 =?iso-8859-1?Q?WWBofQoh9KGac2xiM5SZuQqFXXPh1hY1Qqor4yLOHB5Rn1lS1vhLsZHlFN?=
 =?iso-8859-1?Q?oRAofUH9+Rtlm9roRLwFa/L66fHUcO3kMoanIjF6FrUvPqyOPyTcqzMsfo?=
 =?iso-8859-1?Q?Br4W8XV/rJt6rVMg7IQGPc3SeywkF2x0a82p/BBvbDCR79I7zeywA5BkK2?=
 =?iso-8859-1?Q?+52eI2YCMR5AAqI63uj6kBBnseMuN4yjjysLXQTWv+Roi18ICLMyIAgLff?=
 =?iso-8859-1?Q?6ZMeDZHTv3A50BsUxjhBgeKxm4aHR5VS8aOTyVmAfxU2EfhYcZjzRlFKq0?=
 =?iso-8859-1?Q?ED9pHJm6ukK564ibqn/u2p3iqyEKNM6uSDRmiSa7T/DlgCbxk+X7no5rFW?=
 =?iso-8859-1?Q?UM81TugTyE3IBqyr/Dw1TBwA2RRGpvMrUqAZiGPmWoxazKfUwRE/HifQtb?=
 =?iso-8859-1?Q?IoY6Dpf1z+l1GB7hlA6ZGUd1KsJnSYLuH93kHT23E2ztQv9/eTN9zvB1Iv?=
 =?iso-8859-1?Q?LlVxlz63X1YceVd5x2fVmTPmOFMbstOCS11uoHygATBr5rH+wM656/vBuG?=
 =?iso-8859-1?Q?TIkK3DCJWWsLa4qtasrlCbCyKL263T6WvO6bwUr4WVZWbcnEvnQvJJnyVA?=
 =?iso-8859-1?Q?e+g6dfSQvxCa3cd31OiNTPXoJ7PD7jUofqhonsLE2iyupVaT9ycCS9LNb6?=
 =?iso-8859-1?Q?Aa92XYcCH5VEbmYFZoUco1kSkyf7kDyfosn6V32+rRMSbVpIJgcDfsk1m1?=
 =?iso-8859-1?Q?W6OSAziSiuokb+1fELdLLpk8khY7D75qT5Fl7yibXM1RpEc4rgqO60wr9n?=
 =?iso-8859-1?Q?n7QM+c8S4K9yy40eJuxwFTVlGI4/j09NABzUf1I7EudZ9moER1uPEKQPDI?=
 =?iso-8859-1?Q?j8XrCowOGQY1sSD1d68kkgiLJfQRTkgpDj5HYZiBKvJD47FBn9y/rARScm?=
 =?iso-8859-1?Q?w7ybWy2jua+JorJTLB+yW1D+xHhPiab3iLLQhCqgqZGTQHvmGbTnl1n1/1?=
 =?iso-8859-1?Q?GdgUOGfuhwu/AqY+E/OEUWYYn8HGLMHaGqOPq7Bh0PO0rStZvWMbKFQTP1?=
 =?iso-8859-1?Q?tgWDAq30UOMho7KdzeGkoRJCPJToGbgR/SeiI3pBG7j9CKxVBXskHCHTaj?=
 =?iso-8859-1?Q?zk0Fr8cOESBjuiECZQpMGn5xG/x/Mt78AIe7wQdRxe0Hy4ay0qHuIHvQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1587.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b5b3c7-3fa2-4f0b-00f7-08dc445214f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 18:10:50.8875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +N6YLfRqORA8n4MpheCLcVZjjN8I9K7JHIws0PpBkF+V54UFsqVrpjCvUHrFm5TauCf8gFZXhQW0uaFfHG70TsRBluM8fswKvaYM7JXipR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10027

Hi Uwe Kleine-K=F6nig,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Tuesday, March 12, 2024 7:20 AM
> Subject: Re: [PATCH v18 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello,
>=20
> On Tue, Feb 20, 2024 at 07:43:17PM +0000, Biju Das wrote:
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > new file mode 100644 index 000000000000..0dc8163ee92b
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -0,0 +1,559 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L General PWM Timer (GPT) driver
> > + *
> > + * Copyright (C) 2024 Renesas Electronics Corporation
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
> > + * - When both channels are used, disabling the channel on one stops t=
he
> > + *   other.
>=20
> Do I understand right that the driver doesn't disable one channel if the =
other is running?

Yes, that is correct. We will allow to set only duty cycle for other channe=
l.
The first enabled channel sets the shared registers and duty cycle.

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
> > +#include <linux/units.h>
> > +
> > +#define RZG2L_GTCR		0x2c
> > +#define RZG2L_GTUDDTYC		0x30
> > +#define RZG2L_GTIOR		0x34
> > +#define RZG2L_GTBER		0x40
> > +#define RZG2L_GTCNT		0x48
> > +#define RZG2L_GTCCR(i)		(0x4c + 4 * (i))
> > +#define RZG2L_GTPR		0x64
> > +
> > +#define RZG2L_GTCR_CST		BIT(0)
> > +#define RZG2L_GTCR_MD		GENMASK(18, 16)
> > +#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
> > +
> > +#define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
> > +
> > +#define RZG2L_GTUDDTYC_UP	BIT(0)
> > +#define RZG2L_GTUDDTYC_UDF	BIT(1)
> > +#define RZG2L_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
>=20
> Would it make sense to have GTUDDTYC in the last define's name?

Will make it RZG2L_GTUDDTYC_UP_COUNTING as RZG2L_GTUDDTYC reg offset define=
d above.

>=20
> > +#define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> > +#define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> > +#define RZG2L_GTIOR_GTIOx(a)	((a) ? RZG2L_GTIOR_GTIOB : RZG2L_GTIOR_GT=
IOA)
> > +#define RZG2L_GTIOR_OAE		BIT(8)
> > +#define RZG2L_GTIOR_OBE		BIT(24)
> > +#define RZG2L_GTIOR_OxE(a)	((a) ? RZG2L_GTIOR_OBE : RZG2L_GTIOR_OAE)
> > +
> > +#define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> > +#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> > +	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> > +RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
> > +	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE)
> > +| RZG2L_GTIOR_OBE)
> > +
> > +#define RZG2L_GTIOR_GTIOx_OUT_HI_END_TOGGLE_CMP_MATCH(a) \
> > +	((a) ? RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH : \
> > +	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
> > +
> > +#define RZG2L_MAX_HW_CHANNELS	8
> > +#define RZG2L_CHANNELS_PER_IO	2
> > +#define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS=
_PER_IO)
> > +#define RZG2L_MAX_SCALE_FACTOR	1024
> > +
> > +#define RZG2L_GET_CH(a)	((a) / 2)
> > +
> > +#define RZG2L_GET_CH_OFFS(i) (0x100 * (i))
> > +
> > +struct rzg2l_gpt_chip {
> > +	struct pwm_chip chip;

Will remove it in next version as devm_pwmchip_alloc() will be used.

> > +	void __iomem *mmio;
> > +	struct reset_control *rstc;
> > +	struct clk *clk;
> > +	struct mutex lock; /* lock to protect shared channel resources */
> > +	unsigned long rate;
> > +	u64 max_val;
> > +	u32 period_cycles[RZG2L_MAX_HW_CHANNELS];
> > +	u32 user_count[RZG2L_MAX_HW_CHANNELS];
> > +	u32 enable_count[RZG2L_MAX_HW_CHANNELS];
> > +	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS); };
> > +
> > +static inline unsigned int rzg2l_gpt_subchannel(unsigned int hwpwm) {
> > +	return hwpwm & 0x1;
> > +}
> > +
> > +static inline u64 rzg2l_gpt_mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
> > +{
> > +	u64 retval;
> > +
> > +	if (a > b)
> > +		retval =3D mul_u64_u64_div_u64(b, a, c);
> > +	else
> > +		retval =3D mul_u64_u64_div_u64(a, b, c);
>=20
> With
> https://lore.kernel.org/lkml/20240303092408.662449-2-u.kleine-koenig@peng=
utronix.de
> this function can be replaced by a direct call to mul_u64_u64_div_u64().
> I expect this patch to go into v6.9-rc1 as akpm picked it up before the m=
erge window opened.

Ok, I will hold next version until v6.9-rc1 as for-pwm-nexxt doesn't have t=
his patch??

>=20
> > +	return retval;
> > +}
> > [...]
> > +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
> > +u32 val, u8 prescale) {
> > +	u64 tmp, d;
> > +
> > +	/*
> > +	 * Rate is in MHz and is always integer for peripheral clk
> > +	 * 2^32 * 2^10 (prescalar) * 10^9 > 2^64
> > +	 * 2^32 * 2^10 (prescalar) * 10^6 < 2^64
> > +	 * Multiply val with prescalar first, if the result is less than
> > +	 * 2^34, then multiply by 10^9. Otherwise divide nr and dr by 10^3
> > +	 * so that it will never overflow.
> > +	 */
> > +
> > +	tmp =3D (u64)val << (2 * prescale);
> > +	if (tmp <=3D (1ULL << 34)) {
>=20
> I would have written that as:
>=20
> 	if (tmp >> 34 =3D=3D 0)
>=20
> (which implements tmp < (1ULL << 34), which doesn't matter much).
>=20
> > +		tmp *=3D NSEC_PER_SEC;
> > +		d =3D rzg2l_gpt->rate;
> > +	} else {
> > +		tmp *=3D div64_u64(NSEC_PER_SEC, KILO);
>=20
> I don't know if the compiler is clever enough to not calculate that every=
 time? Also using div64_u64 is
> too heavy given that both values fit into an u32.
>=20
> > +		d =3D div64_u64(rzg2l_gpt->rate, KILO);
>=20
> At first I thought you could better use 1024 as the common divisor here a=
s it could be implemented
> using a shift operation. But I understood with the comment above that we'=
re not losing precision here
> as both NSEC_PER_SEC and rate are a multiple of 1000.
>=20
> Maybe s/Rate is in MHz and is always integer for peripheral clk/Rate is a=
 multiple of 1000000, and so
> dividing by 1000 is an exact operation./ ?

I will use rate_khz as suggested in the later thread and getrid of all abov=
e checks.

+	tmp =3D (u64)val << (2 * prescale);
+	tmp *=3D USEC_PER_SEC;
+
+	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);


>=20
>=20
> > +	}
> > +
> > +	return DIV64_U64_ROUND_UP(tmp, d);
> > +}
> > +
> > +static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > +			       struct pwm_state *state)
> > +{
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	int rc;
> > +
> > +	rc =3D pm_runtime_resume_and_get(chip->dev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	state->enabled =3D rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
> > +	if (state->enabled) {
> > +		u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > +		u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> > +		u8 prescale;
> > +		u32 val;
> > +
> > +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> > +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> > +
> > +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTPR);
> > +		state->period =3D calculate_period_or_duty(rzg2l_gpt, val, prescale)=
;
> > +
> > +		val =3D rzg2l_gpt_read(rzg2l_gpt,
> > +				     offs + RZG2L_GTCCR(rzg2l_gpt_subchannel(pwm->hwpwm)));
> > +		state->duty_cycle =3D calculate_period_or_duty(rzg2l_gpt, val, presc=
ale);
> > +		if (state->duty_cycle > state->period)
> > +			state->duty_cycle =3D state->period;
> > +	}
> > +
> > +	state->polarity =3D PWM_POLARITY_NORMAL;
> > +	pm_runtime_put(chip->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8
> > +prescale) {
> > +	return min_t(u64, (period_or_duty_cycle + (1 << (2 * prescale)) - 1) =
>> (2 * prescale),
> > +		     U32_MAX);
>=20
> Can the addition overflow? Is the addition even right? This function is u=
sed in .apply() where it's
> usually right to round down.

No, It won't overflow. The logic is proposed by you in v17 for DIV64_U64_RO=
UND_UP and it is
passing all tests with PWM_DEBUG=3Dy.

VAL=3D10000
echo "#### Zero duty cycle ###"
echo 0 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/duty_cycle

echo "#### decrement Period ###"
for i in $(seq ${VAL} -1 1); do

echo "#### Increment Period ###"
for i in $(seq 1 ${VAL}); do

echo "#### decrement duty cycle ###"
for i in $(seq ${VAL} -1 1); do

echo "#### Increment duty cycle ###"
for i in $(seq 1 ${VAL}); do

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
> > +	/* Limit period/duty cycle to max value supported by the HW */
> > +	if (state->period > rzg2l_gpt->max_val)
> > +		period_cycles =3D rzg2l_gpt->max_val;
> > +	else
> > +		period_cycles =3D state->period;
>=20
> this is equivalent to
>=20
> 	period_cycles =3D min(state->period, rzg2l_gpt->max_val);
>=20
> Is this less readable to justify keeping the if?

Agreed.

>=20
> > +	period_cycles =3D rzg2l_gpt_mul_u64_u64_div_u64(period_cycles,
> > +rzg2l_gpt->rate, NSEC_PER_SEC);
>=20
> After this operation period_cycles's unit is really hardware cycles.
> Before it isn't. I suggest to introduce another variable "period" for the=
 value above. So make this
> read:
>=20
> 	period =3D min(state->period, rzg2l_gpt->max_val);
> 	period_cycles =3D mul_u64_u64_div_u64(period, rzg2l_gpt->rate, NSEC_PER_=
SEC);
>=20
> . This shouldn't be harder for the compiler but easier for the human read=
er.

Agreed.

Will use period, duty_cycle, period_cycles, duty_cycles variables
and later two variables are for hardware cycles.

>=20
> > +	/*
> > +	 * GPT counter is shared by multiple channels, so prescale and period
> > +	 * can NOT be modified when there are multiple channels in use with
> > +	 * different settings.
> > +	 */
> > +	if (period_cycles < rzg2l_gpt->period_cycles[ch] &&
> > +rzg2l_gpt->user_count[ch] > 1)
>=20
> Would it make sense to swap the checks? Technically it doesn't make a dif=
ference, but if rzg2l_gpt-
> >user_count[ch] =3D=3D 0 rzg2l_gpt->period_cycles[ch] might be an invalid=
 value?

Agreed.

>=20
> > +		return -EBUSY;
> > +
> > +	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_cycles);
> > +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_cycles, prescale);
> > +
> > +	if (state->duty_cycle > rzg2l_gpt->max_val)
> > +		duty_cycles =3D rzg2l_gpt->max_val;
> > +	else
> > +		duty_cycles =3D state->duty_cycle;
> > +
> > +	duty_cycles =3D rzg2l_gpt_mul_u64_u64_div_u64(duty_cycles, rzg2l_gpt-=
>rate, NSEC_PER_SEC);
> > +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_cycles, prescale);
> > +
> > +	/*
> > +	 * GPT counter is shared by multiple channels, we cache the period cy=
cles
> > +	 * from the first enabled channel and use the same value for both
> > +	 * channels.
> > +	 */
> > +	rzg2l_gpt->period_cycles[ch] =3D period_cycles;
> > +
> > +	/*
> > +	 * Counter must be stopped before modifying mode, prescaler, timer
> > +	 * counter and buffer enable registers. These registers are shared
> > +	 * between both channels. So allow updating these registers only for =
the
> > +	 * first enabled channel.
> > +	 */
> > +	if (rzg2l_gpt->enable_count[ch] <=3D 1)
> > +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST, 0);
>=20
> What happens for the second running channel here? You're still writing to=
 the relevant registers, just
> without stopping the hardware. Sounds strange.

It is a mistake.
I will add check for shared registers, so that it won't set by the second r=
unning channel.

>=20
> > +
> > +	/* GPT set operating mode (saw-wave up-counting) */
> > +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_MD,
> > +			 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> > +
> > [...]
> > +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> > +			   const struct pwm_state *state)
> > +{
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	bool enabled =3D pwm->state.enabled;
> > +	int ret;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	if (!state->enabled) {
> > +		if (enabled) {
> > +			rzg2l_gpt_disable(rzg2l_gpt, pwm);
> > +			pm_runtime_put_sync(rzg2l_gpt->chip.dev);
> > +		}
> > +
> > +		return 0;
> > +	}
> > +
> > +	if (!enabled) {
> > +		ret =3D pm_runtime_resume_and_get(rzg2l_gpt->chip.dev);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	mutex_lock(&rzg2l_gpt->lock);
> > +	ret =3D rzg2l_gpt_config(chip, pwm, state);
> > +	mutex_unlock(&rzg2l_gpt->lock);
> > +	if (ret)
>=20
> Is here a conditional pm_runtime_put_sync() missing?

Will fix it.


>=20
> > +		return ret;
> > +
> > +	if (!enabled)
> > +		ret =3D rzg2l_gpt_enable(rzg2l_gpt, pwm);
>=20
> and here?

OK.

>=20
> > +	return ret;
> > +}
> > +
> > [...]
> > +static int rzg2l_gpt_probe(struct platform_device *pdev) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt;
> > +	int ret;
> > +	u32 i;
> > +
> > +	rzg2l_gpt =3D devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt), GFP_KERNEL=
);
> > +	if (!rzg2l_gpt)
> > +		return -ENOMEM;
> > +
> > +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(rzg2l_gpt->mmio))
> > +		return PTR_ERR(rzg2l_gpt->mmio);
> > +
> > +	rzg2l_gpt->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL=
);
> > +	if (IS_ERR(rzg2l_gpt->rstc))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> > +				     "get reset failed\n");
> > +
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
> > +	pm_runtime_enable(&pdev->dev);
> > +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> > +	if (ret)
> > +		goto err_reset;
> > +
> > +	ret =3D clk_rate_exclusive_get(rzg2l_gpt->clk);
>=20
> There is a devm variant of this function in the mean time.

OK, currently for testing I picked it from next.

>=20
> > +	if (ret)
> > +		goto err_pm_put;
> > +
> > +	rzg2l_gpt->rate =3D clk_get_rate(rzg2l_gpt->clk);
> > +	if (!rzg2l_gpt->rate) {
> > +		ret =3D dev_err_probe(&pdev->dev, -EINVAL, "gpt clk rate is 0");
> > +		goto err_clk_rate_put;
> > +	}
> > +
> > +	/*
> > +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> > +	 * period and duty cycle.
> > +	 */
> > +	if (rzg2l_gpt->rate > NSEC_PER_SEC) {
> > +		ret =3D -EINVAL;
>=20
> Error message please.

OK.

Other than this, I will use the below changes in next version
1) devm_pwmchip_alloc()
2) use a local variable dev to replace &pdev->dev in probe() in the next ve=
rsion.
3) Also will add below check in probe as you suggested in later thread.

+	/*
+	 * Rate is in MHz and is always integer for peripheral clk
+	 * 2^32 * 2^10 (prescalar) * 10^6 (rate_khz) < 2^64
+	 * So make sure rate is multiple of 1000.
+	 */
+	rzg2l_gpt->rate_khz =3D rate / KILO;
+	if (rzg2l_gpt->rate_khz * KILO !=3D rate) {
+		ret =3D dev_err_probe(dev, -EINVAL, "rate is not multiple of 1000");
+		goto err_pm_put;
+	}


Cheers,
Biju


