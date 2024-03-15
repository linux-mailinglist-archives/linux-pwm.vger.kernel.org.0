Return-Path: <linux-pwm+bounces-1767-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FEC87C901
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Mar 2024 08:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAA71C211FF
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Mar 2024 07:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D346818029;
	Fri, 15 Mar 2024 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bvkEYbJn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2079.outbound.protection.outlook.com [40.107.114.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCE818028;
	Fri, 15 Mar 2024 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487149; cv=fail; b=jFK36dPGrXzT944/1Wv7yWgOYDYxTRD2l8qZiznn5XKxkLG17+r0JYbEsqtqMuBF/2k9cT1Oe4M/2LxWb+pfX9aBxZml/jYa3KP0qFej05eoW3HtSa3R5KlWO+SMG3f92Sh2csZW/rB81f5TDPgZleJKZKt981LEacXnSwi0XGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487149; c=relaxed/simple;
	bh=XDxcukPf9pClaDtRZ8QczPn8upPgkc+mWqHOEqJkHIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D419wn1cGBVFew9sfK46FsNfzOAewUaSlQtLxV0siCHQPQrckjwm3mxNVoALRE1kikTMkZ9pMr7m1rJV09d8vHsPha+HPFEOyOHiaigyzPsh/dxXdohY6pH1b1AeKKG4M3VCLWNV5w1fB0tMWLpFocKiaW556NVnJx2XxCGzif8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=bvkEYbJn; arc=fail smtp.client-ip=40.107.114.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ts4kvCgvHPRJLBirJxQ75ePezj8NJp5lun3A2Lp5ZCTupvlWp61CGt/VIrBDOOBvwBiVNC2XpEp60ZTafk1pAguJAqM/yeIZHYPOUgk4Vla2rrIp3+tXfwwYv1xrUKS8YTIYm9PtmMGkPjSTcA9qzQ/8kP26j7NgtanW2CxV9kmLRf9Jk//lJkXDuld+d1Q96SY2597Mfz7mjCo/J33WULfQvG/ApFTmYJWzwrpLT/dsUUZq6nxnoX3NLBkzXqpMi7Xk2Wm6jfy1N/kQJeYNgGIqtAHjSgluv2og7rwS4rzF2WE87mbVRx3/2CYS6meq56fMdtWIS27r/Zpf95ClJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Chuqa7s9nJ6RFiTGNIntoYcucI4cAGS70sbAUm7k9Qk=;
 b=VCkDuaGYdTaoaY8ktn640lliSKxZq+b/egWSay9R+udCSAbGq1Pv5BQR45WT3TdhCFU61+Ng4U9Au2//X0W5fkH7c9q2QUFReJK/6pluUuMjYJUOMZH8d/acCVMBgOpnWjxDLzvaRq0LGrSOWVeqeG4NZDVLvI7cvMh+3ti3gmNvl0tveawj6vU44q5qIOgS9VD8MB+bFl/ZG4XoBAIzkI5vfiSykNykM/oJSphA0xu1WBxAewT6Hkl+jHxMXH6+0Ua+K5PsDTm8cCtOZiJe4dDX+uPzhR6I+80i3ufFCAAPpI3Kngg9OHdCeLAvItWhnHNPcv7SV8w1A0PGcCm3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Chuqa7s9nJ6RFiTGNIntoYcucI4cAGS70sbAUm7k9Qk=;
 b=bvkEYbJnAtBB0++Khcv4USOpGVwWIYSDZ9PcuP2g3xcVszwvbkY4XGitRLsU3RsOi+yBtbTh/YDlIwd8DGcZHECwcR1pO7kPMv7GECdUg7kRcBQxw+5Ffjo+i7BDe3xf/J+sFULfESMMfMWPb8AHcqCgGnA2GhRnehTzxnpWMaI=
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com (2603:1096:603:2e::16)
 by OSZPR01MB7771.jpnprd01.prod.outlook.com (2603:1096:604:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 07:19:02 +0000
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::aef6:c35b:b90d:2e3f]) by OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::aef6:c35b:b90d:2e3f%5]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 07:19:01 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: biju.das.au <biju.das.au@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
	<magnus.damm@gmail.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v18 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v18 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHaZDUd2szw5U1SmEaBqj/KTS2kjrEz0w2AgAPRLgCAAFKYAIAAkaBg
Date: Fri, 15 Mar 2024 07:19:01 +0000
Message-ID:
 <OSAPR01MB15879D814E3B04B12D29052286282@OSAPR01MB1587.jpnprd01.prod.outlook.com>
References: <20240220194318.672443-1-biju.das.jz@bp.renesas.com>
 <20240220194318.672443-4-biju.das.jz@bp.renesas.com>
 <hy5crf2leuvewkn5omgrk2bmkndivwmhst4yrefnd3mepy4nzd@xw3rtkxdnb2g>
 <OSAPR01MB1587400FECDBFDB3E38A594286292@OSAPR01MB1587.jpnprd01.prod.outlook.com>
 <ipm72ujiqm4k2nuq7a6sdmqdrwjwrn7uyp4brgbvmmb5mgu6ko@ljltsjnljett>
In-Reply-To: <ipm72ujiqm4k2nuq7a6sdmqdrwjwrn7uyp4brgbvmmb5mgu6ko@ljltsjnljett>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1587:EE_|OSZPR01MB7771:EE_
x-ms-office365-filtering-correlation-id: d3a4eb1f-5d3a-41d5-6d5a-08dc44c03073
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IrfjUYmkOZNvPTc2dD5vaypIRPWlyEeIsHqrvgpr1XPMizE6XrLf/XWgrSPIyenVED+mQUtbEEY0l/slBXEm1FiL5NSovN+Rma5U5xjqj+kFClE22bw22ubVxe9M6EkDT1ZeI57iAJ3LqzEVYPBea2m45DRQMRUlAH9LdqscdUzL342xlH+N1W8yzzCXyArK+1aaj1Feqv4aSzBBQWgvXUxAOHVL56J++8lTHXef9FF5gIpqFtwAOScyEe6QW6ZieZpVsEdGMemlI9DdwqNddZpYhZEWhUVmJuEf25RwMSP3harMC7Q1Fh2mjVCwswN0fkC5anMTbSyzRXbxLkq+R6ZV8or2W4VKi5sHJuxVg03sY46P1ClcofFzb6w98/dODkKnqfjgwxRfFngYI6JOkZ8OMQ01hg/a5PIMmNMw9xUTQmNldNdh0vz81rGKfR2tT7y5ilYka4PkFiRs78QMS5LSgc0AmC725XjM00AdWCNGpy2aJsRMTs/wTM+mqsWkqeygZocxNVJQ36c0cmHSEIJcB29RCJOM90Zzv0VvRfjFC9qQlNw+KuiYE4wWt6MXCx0JBjJBIbeVvko7XVBYW2i59CLJBbQq1zjYTCQikqkXerUignTTWAAHDE0xOB2R2PdW3Mtt2DVIhhBSFTtknwAyZcI0JrsDGukuRxVAmd8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1587.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mlE27su7iNmVR6zLq8XRncqxJUImMxKMvga2Y5RyBrhOVZ9btC21uR2yjM?=
 =?iso-8859-1?Q?0rN9BsfLpxGnhOnjj1emoyJNKUZGfN8SIFwqX8nS1zT8jLx4KCWesm5nMw?=
 =?iso-8859-1?Q?SpCQ6EKdVlzixNSr/wZMXdoGLxu1Pv6wkTgUknfZ2Ikfluj6y6/Z68VjMp?=
 =?iso-8859-1?Q?ODZyK5XSp2WieFLBhawyACoVqiUXF1Oe4THqBX5L1cJkSw4XhtWRViPiw/?=
 =?iso-8859-1?Q?PLifawpFLkF70W5l7t61BY9G21Qaxqcs+Hw2gP34WfBMEHdvCl3lnNbbj7?=
 =?iso-8859-1?Q?Wp06bP11GfW2awdEojHnYDNMOUGTAIZsxZbfIadeh87Pn18vwDt3TnuaeF?=
 =?iso-8859-1?Q?E5eMs2gmviujMeWv0RsKS4kLhThi9CdM7SP1C8KT0aTxebt+mnW6/k8JMj?=
 =?iso-8859-1?Q?FRTWIDkaRVTRozI4SM2apJfxqptUhNaBifFkFeojTcem/57mBMQ0pDBYiN?=
 =?iso-8859-1?Q?WWaUtPA3qNe5m0IzU/uffHp7mOyzZPI207Q+Ss/1mNdlI3GDgGb4T7cyQ2?=
 =?iso-8859-1?Q?aeU6vrUcvdanHIUO35w+xAnWSG0gD1DoSXwWL83aTH8Y9M9MP5ryK+PKhy?=
 =?iso-8859-1?Q?oYhOOKEmzCSmowXaObSq6EUynCT4H8eZyVCwT0184r/4wuX5pui05H44hY?=
 =?iso-8859-1?Q?ZZhn+F9w28phH2kR5ic5FvUjryK+6i8Bxuw/tEgY8nYxDwQLiVna0PfQ4N?=
 =?iso-8859-1?Q?SWsHhrD4t9aoxJCUGNvGjmYd+87ykZxrK3FJMXmgk5JKeOtFMdN4rXAN9Z?=
 =?iso-8859-1?Q?R4Qj7Pm1WBvDeHUIx63HJrwBKc60d8sOpqouRPc9kxYud+sRU7G/hBEMXs?=
 =?iso-8859-1?Q?NizuDJgHkk63Tef5m1YCpTxbDX8W2HVqZx5IRFSskkjgFsiw/6z2WQRvHx?=
 =?iso-8859-1?Q?ejMchQRO1xugPqB6yByVagjVMcIKhFJjlf+/AOcJDxAoG1wV4WIjaF5sfq?=
 =?iso-8859-1?Q?V4/1rJAkbZk5sLe05wqXM8gYGG53OK9B1SI/r9uNEjo21nxKWnXhcaLZTv?=
 =?iso-8859-1?Q?9iNH5nsXrbr8wMmsDqRLdeGTlmQEAebqbSLZ/N5DMgdY7tuy16KKT+L0ev?=
 =?iso-8859-1?Q?z1XxSuyIR60JlkZe2ky/PJCDb6/cQNHR+eVO0KO4yM7Q4qv71nUmLqjn4B?=
 =?iso-8859-1?Q?XUHf3ArzcAz3CE+Q6yxNbUBT2dYC4G2X0Zp6XcYuWulpulM/LSoVbrUlfn?=
 =?iso-8859-1?Q?qhpFtbaPOrxwnQyWPIBgdeU8r9zIHUnIZOiQfyZWjGQ91xyLApysWr+csC?=
 =?iso-8859-1?Q?tLpQ8Edilj5Mon8UeVcAHuBcgFjF0w0FIlEuh/ZX0X/Df7JAWYqjWp31Sm?=
 =?iso-8859-1?Q?Gi8dgOXmxK7hHZA0ek7LoQRXlrfwqPw/DkhuvHE8swlMfqZB3EstzlzJQh?=
 =?iso-8859-1?Q?zHhR0RbhkAp0j2JorWd2co3+wU8MHfgvFdGYszJ7BQJATDue6JHfDB4t2l?=
 =?iso-8859-1?Q?04xb0Ix8WujMMpc6GKjql9L//TvvfDutJdDi2wKCSGfk4en4zzGgqDXocd?=
 =?iso-8859-1?Q?CnSuztbrBm4IqdDv1xmqm6mF6Z1sIHwYKEt3x3l04uzRSYesXsjxqbN7O9?=
 =?iso-8859-1?Q?OX+Vtl/f02hVLjLtJ8eFLmhHW6QKiHUBua4qiqxbGODXrpZAjnypy6Kl6S?=
 =?iso-8859-1?Q?ljUvPEtYT2fqvx9y5/oUMvItLru26obGaMeJAOcD12yxQfR19ZZyEENg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a4eb1f-5d3a-41d5-6d5a-08dc44c03073
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 07:19:01.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9FKcl93oCuQcp5MJKRnswU+XRPTN3MftEooAdkb6qZJYvDxswm/e8eVbo0m5fsGGgcrqoAYJZvpRk3My2N2PLfasPQ4GdJKGH2wfpXH067c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7771

Hi Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Thursday, March 14, 2024 10:33 PM
> Subject: Re: [PATCH v18 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello,
>=20
> On Thu, Mar 14, 2024 at 06:10:50PM +0000, Biju Das wrote:
> > > On Tue, Feb 20, 2024 at 07:43:17PM +0000, Biju Das wrote:
> > > > +
> > > > +static inline u64 rzg2l_gpt_mul_u64_u64_div_u64(u64 a, u64 b, u64
> > > > +c) {
> > > > +	u64 retval;
> > > > +
> > > > +	if (a > b)
> > > > +		retval =3D mul_u64_u64_div_u64(b, a, c);
> > > > +	else
> > > > +		retval =3D mul_u64_u64_div_u64(a, b, c);
> > >
> > > With
> > > https://lore.kernel.org/lkml/20240303092408.662449-2-u.kleine-koenig
> > > @pengutronix.de this function can be replaced by a direct call to
> > > mul_u64_u64_div_u64().
> > > I expect this patch to go into v6.9-rc1 as akpm picked it up before t=
he merge window opened.
> >
> > Ok, I will hold next version until v6.9-rc1 as for-pwm-nexxt doesn't ha=
ve this patch??
>=20
> I will rebase the stuff for the v6.10-rc1 merge window on v6.9-rc1, so (a=
ssuming my guess is right) you
> can profit of the improved
> mul_u64_u64_div_u64() call. (And even if the patch will go in later, we c=
an live with the inexact
> configuration for that period.)

OK.

>=20
> > > > +static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle,
> > > > +u8
> > > > +prescale) {
> > > > +	return min_t(u64, (period_or_duty_cycle + (1 << (2 * prescale)) -=
 1) >> (2 * prescale),
> > > > +		     U32_MAX);
> > >
> > > Can the addition overflow? Is the addition even right? This function
> > > is used in .apply() where it's usually right to round down.
> >
> > No, It won't overflow. The logic is proposed by you in v17 for
> > DIV64_U64_ROUND_UP and it is passing all tests with PWM_DEBUG=3Dy.
>=20
> Then believe my former self, I didn't redo all the maths in this cycle.
>=20
> > > > +	pm_runtime_enable(&pdev->dev);
> > > > +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> > > > +	if (ret)
> > > > +		goto err_reset;
> > > > +
> > > > +	ret =3D clk_rate_exclusive_get(rzg2l_gpt->clk);
> > >
> > > There is a devm variant of this function in the mean time.
> >
> > OK, currently for testing I picked it from next.
>=20
> For the next submission round make sure to properly use the --base parame=
ter to not annoy the build
> bots. Or feel free to base your patch on next.

OK, I will rebase to next and send v19.

Note:
6.9-rc1 on for-nexxt is still missing a patch[1] for cpu performance on ARM=
64

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?h=3Dv6.8&id=3D98323e9d70172f1b46d1cadb20d6c54abf62870d

Cheers,
Biju





