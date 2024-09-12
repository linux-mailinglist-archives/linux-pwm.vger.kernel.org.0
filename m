Return-Path: <linux-pwm+bounces-3220-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 301639761FA
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 08:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE45928549A
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 06:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB45818BC27;
	Thu, 12 Sep 2024 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="b6yvEIt6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011059.outbound.protection.outlook.com [52.101.125.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA15C282FB;
	Thu, 12 Sep 2024 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124234; cv=fail; b=T7IHNlpPW+ZNgs0UQDAc5rx29rjJqzzsN1Kt7cdOZ+uZM/+Vus4hxZeqD1Lh9LTInquuHt54Kj3qr/Y97LAK6RwRqJzt0xXqmbHScW3ou49AlcaVg90CFKvZI20p0nPxiowerivx5MHqK2wKAeOCiZABp5g2qHjvof3A0jfZhb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124234; c=relaxed/simple;
	bh=lx2gf1a/gJ8MYxwU6pce2EhsOvOm75t436ftIG0tuu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j981wOhbLzqZaR6VjGwZ2ovFL63w/KQZxwrNSAKCxf6WtDugsFGH9n5XcBraZibRA5AjVCgxqFqvzoRrpi+ILcxjcfhoaDWg2lJzYgwey53QswuaQLcomuSbCnT6E8luvJrpdvqK1AIEaPJRgEUvlSTiwoA3/RgkI5vBZqsMRAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=b6yvEIt6; arc=fail smtp.client-ip=52.101.125.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Phss7sLt1Y6KXX7IAlArOiBf0wR2gGJVj/vMJhsqZ/3Knzw6q7Uv36cLVdR5LgwU47tzzpP2xkjbU3zGm/hJ4zYTXUGnyvqtfXyAqYjnjUKyt6dMkEzMznaBmvbuEFfwexYYly3QW6JY2IMGhP5RaTCMUS9O1uwoxO5S3vSkt87mJBm+4hHONMFD8BtPQiTreQtwhN0lOMhqV7hV2jA145jvYg7MEnZ/uP3OFaHUtP6glWKzCBaKJUU78+R7E2P4SrWCB+WssKWQ1CHZun/zdyyFQiRobslNhaMUIDpHchGa3nGsfr5TmkOFHitbM9sc4R0/5DJ2Sjz/yfOV0e5irA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V7jPoeYreaIjEy2k3gOwn1rR22ASzIU9QJNy5VnFkc=;
 b=MxoI3/RwIA+4xj//kiUV/ljTjAGBaZh94UZa4jErBYyv78NegAQ+FhkM0bzVqQeIsMd5vjYQ0IV8Xuj9l/52z5sjEWUhP1sEELGR6oN47LNg8b1jP8wRaxlBtL6zVOngxFNLkcKhlUIiqKH77KG49vt29ylFydHLGsG6zv6ng5VkHvQcskXYMjcf4mwCeGb3rBWHvlYE/84G+bTGZ9ZdZI3nEFUeOTaIjwxL4j1zE1+KdamoIypBgJ/fvURWC71Nf2aTA1y+hK9kF444BTc/Bj8JnRDe0aHGIOBPA1HdMieeGMK6Uhv+QxUyQ5bEusxheTLOuA/0t+ujv3Ohc34ugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V7jPoeYreaIjEy2k3gOwn1rR22ASzIU9QJNy5VnFkc=;
 b=b6yvEIt6ahIgNlSa+aCO8vbwOac6p/oFqnfS/Gx4b9vvuKFXbUr1LrPMZPI+i3iZeLWEqoZzeOehyIJ2YqtRbGkqPifTWvXWh7ZV/AnoEPL7+a4mlF6GOjZKidWiCqZkBHPHMJFYHOVajGA5nMaLr9y+BLd/TJeygI8nxp58ghk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11569.jpnprd01.prod.outlook.com (2603:1096:604:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 06:57:06 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 06:56:58 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
	<magnus.damm@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v21 0/4] Add support for RZ/G2L GPT
Thread-Topic: [PATCH v21 0/4] Add support for RZ/G2L GPT
Thread-Index: AQHa6ZUxaVFXpEsK30+XxMaJkmVekLJT7VqQ
Date: Thu, 12 Sep 2024 06:56:58 +0000
Message-ID:
 <TY3PR01MB11346ED865BB395DF47AA4ED186642@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240808131626.87748-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240808131626.87748-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11569:EE_
x-ms-office365-filtering-correlation-id: 909501b1-951b-4450-c9ac-08dcd2f8189f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?jMCRj49iEAzoTVV/T5AYfThJxk5UqoIFnQNIcJt16UhgNrDNRA6cMP6QW2?=
 =?iso-8859-1?Q?J+vtHPSC9fjzVcug0kLAUP06bnGdwnXH3qtXSh6Au7tblTyT3QZeOFpf0N?=
 =?iso-8859-1?Q?zlnAwmGOLSCRSUbmQwPrNNhz64lMJEy8MuKhRyDAu/EHrPDtM/fAgx9PRX?=
 =?iso-8859-1?Q?CmfpbBcUCXgncTW8pWZ/SN05O2H1r6FSWM9s2pJsbPiRCS0/Xu6naGB2Ft?=
 =?iso-8859-1?Q?QdYCTCZDbfiicivSJ8MiSaco7p0WBbJ0SfYXHRbYtJ1LduKzgfOTgtmEP0?=
 =?iso-8859-1?Q?J3NYGOo17pdkthaOZOAO61JdcE573GX7TkL0lh/daWSd8PCVg4xNOV7Css?=
 =?iso-8859-1?Q?kHzdSDboUt2LoDrRLURVjvsxI/Oc1Xuy13Wv84fg0dc5mQeeG7zxWO75Gt?=
 =?iso-8859-1?Q?ty1sVPH5C17W6S4oFuHQ8fWKEgQjEIj0tZSee2YkpwJCnr78AJGUXSTPEW?=
 =?iso-8859-1?Q?IPB/0uFG3797fhctvSAts36f0ayvRfewbYxO4RqHuM7geTp5G3Q9LqiDxX?=
 =?iso-8859-1?Q?BfM9ILppzLBmkvn1NhLecQgEY/DCWlBjsORkR6qXc6JiN/1JsmvRHhHB0v?=
 =?iso-8859-1?Q?75H/uqvTYagz9R1KDtueS3RL46fPCXp/h4OH9rSumv9g23D2RfuxfsI7fC?=
 =?iso-8859-1?Q?BWzxLXKdHmbWbDMqqc3Wymy/U0h2jIeoSO5ybGsmkntDSKX/2cVgS7FWID?=
 =?iso-8859-1?Q?CqsO39AXNV0EiWHFOA6aI0Fq68ZuN/pbzzBsDJPHj+6fTLOKGCw4Zy6L61?=
 =?iso-8859-1?Q?J+CfSbwSH6WIFZ6vY9+52/TjpqFDe8n0pjuWQvXuouc6uBSnqi92ur49+6?=
 =?iso-8859-1?Q?0t32sXgsixqao20y43fQ40aH1xMmWHn6D4NrXaTt6EHBM9FOUCM1aFdjTP?=
 =?iso-8859-1?Q?+f3tscdEI4UULjPFJMA2B5hHD6pxuwN97YMDbGJYwSM+cYcye8fSqLFV8o?=
 =?iso-8859-1?Q?umRudrLoNpgfJMCaR9zfwUUxQBW2ulRH69VzTycX1Il25+j1zyiMHabCYh?=
 =?iso-8859-1?Q?8IkXGSYKtrTg2KE7y0DPY2ToZAWIz8w0XaI10VwoMlUb4gLV/3Q+lfARy1?=
 =?iso-8859-1?Q?jTuebojBF6Hf+xFyTtTNc5erQU5fDQ4FgUEbHBqOt+YC5JdW9rL8lGja7A?=
 =?iso-8859-1?Q?Y3AYPF8u55xzVC755WsrrhzrPyKrXIJ98BXx9AWKpiSpIFvc+iVbXH2+sl?=
 =?iso-8859-1?Q?1ywYDvdcbUYs7Rjwa9m7i7PVz49S9pOMTTRVftV54gjR8MsEkW4sh4MoEo?=
 =?iso-8859-1?Q?TALkqSTrN0t5mA171ayPYd108RQyTonx+cIwvU7wDrfhLzqZBFNJEEEfdu?=
 =?iso-8859-1?Q?0E9HGaIbQUNOkd9yF7pkWvz06IBb8togqMUQi1bK7wrJnVtqaJmPY+WAc9?=
 =?iso-8859-1?Q?B6XvmqOKBAxXKv3Z4N7YCJE1qs2F1O7JnqSQHWDV/3JPjgr9BlHv0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qs01pxAplKj4UHxrhdiMooU4AU/vGXDL/1XJLUOLXsrJoG3TpQz5sXrU/k?=
 =?iso-8859-1?Q?HI053Jrpf+sriiG+PbmfHA7sHULj5nfqMAZlvSSHYst/mKytoYgK7kH3ck?=
 =?iso-8859-1?Q?54BoFRL2yzX46vXML+FmK0IqqRAwLrI5R3kMwyeSEkilKi2P/RH36dxII7?=
 =?iso-8859-1?Q?vAxwLOV8wr8sAjGnjWx6QA7eFKviNKYnlbkiBds7DxowYtnOjUS1QYv9HC?=
 =?iso-8859-1?Q?gbEOeqyanKydNdTIWV48O2TavHF2F4kitT5obJBud9B/xd1cBf/lJ/rVYo?=
 =?iso-8859-1?Q?Kj4Dz+TnuGCs2vjCDyhj/0PiwuYd4iKc/aFgp17IyWzoHWsnoNNApS2eDH?=
 =?iso-8859-1?Q?w8HCqmnbra7vilSs/4FEVeWY+gMS//xhjicxuWdg99UzJqUs/fdN8Fbxad?=
 =?iso-8859-1?Q?rQ0UUMvvMKayTJxfUyD1wF0CsD3ms/uXtfNmZLlN0o4eV9wVEF2u/nUgN6?=
 =?iso-8859-1?Q?IsJ/UiDLmHAviH5exBzUXx4yvf7ZzY/TBdg1HB3dlx8ofIRgX2fChJUGVJ?=
 =?iso-8859-1?Q?5wL9xGiupolDAbFn2Fkuk9q/ojiQAAEdYHOjYtb8E4e2wUfAhP9AzdV7vl?=
 =?iso-8859-1?Q?BoUkPa3Cej00ZkDZCOD+1jsDpkTWPjVZwfIQEn07dy7FYGVC4XmMAPibJW?=
 =?iso-8859-1?Q?ly13tSuEmmzAzXkM8DxB33S6ojH+kVlinEcNkm6jBItMMucJeU6B8KkePw?=
 =?iso-8859-1?Q?K9sQrzxmDRNXDMiH7eWeYS7VWAOULmv1aGXPkROI0Jx0e+H07IXflhU7lh?=
 =?iso-8859-1?Q?fFSqZhrYm9DY+0rd7laXsNfIArG9pB9kdigt4Ym9+AVR0ASE6UXJR4F5+g?=
 =?iso-8859-1?Q?nbCeeTTZMH8PHo5/9ZwK9eX3L7wMzvXvlPtwm1r2znSRUEBPNbw3eJq2gB?=
 =?iso-8859-1?Q?3Ka4J285ldGYqnMTb/RpZ1TqWz7gZA94EjzoKKiBlRxXK7phgDftewRWyr?=
 =?iso-8859-1?Q?tHIrirm+wluDnK5+RCA+FTWiP/HxSCdEnaFBRM922NiqZMdCuyfUm+cxY2?=
 =?iso-8859-1?Q?ORfFsRA18CcGvFRcWX4SkmJ4vGm9o4Ffrzd0TIFptsAujz5XWuBc7J27yj?=
 =?iso-8859-1?Q?CNYVhqa5sJA/NhX7Gyt2l9Hnvj24PdnsuUuVwRVeWao8gttUUx7UYjFWiG?=
 =?iso-8859-1?Q?ZWblTIHsf6SKw7EfOz7XBi7/lU0CIbHXeHJvcp5q7qtMubFvU9oL3/tdHf?=
 =?iso-8859-1?Q?mh+bWuu6MG7rboRClG7PnrkiCArtlpdfoHxxv2Da1bVtKku7mVs3c7uLmK?=
 =?iso-8859-1?Q?C944qXahprVpwykG5LuLQsOvAREDjxBOwZDnDU35cbswI+3/ZvMvR8KgAk?=
 =?iso-8859-1?Q?/KX8EvKAPJjpWLDatYW5p6sPJsr1Vw7Pos/N1GhLMZ3x2hTaKBGHzDMkjh?=
 =?iso-8859-1?Q?2MXDBN+LrvW2iCQUpD7rBW2TF2MCCddVmZHRdxyR+gIJO5d2ZYAhRIrS1f?=
 =?iso-8859-1?Q?yb2zEHapFQaKlihyyFTV1uidqg+qtUXhaxjSHZKKvZdDEwmYBe/m/n3ppB?=
 =?iso-8859-1?Q?63k8zIeZEcUrKShyfRSkA1BWslN8FFVKQadUdY+Q8lEpDZdCcagYWR8TT0?=
 =?iso-8859-1?Q?kKl1qX8S/491NPEfbIywLSzdUdhiZl7MOaeGr2idaZ8aVRL1Oc5a937Ki+?=
 =?iso-8859-1?Q?PjEpo5K6xkqQ2kn3m3xD2HYFkJo7tRtRHc?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909501b1-951b-4450-c9ac-08dcd2f8189f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 06:56:58.6084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Srp5ERQ5YXKuIDWjcsWvNPsaFuLvxe0AE2+9ym38dcl5i+HUsV6lxGlR9yalw5tIPxXV+H69Fkj5YnpOJ+uf53KM7HEh7Y47OaYKmQsk2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11569

Hi Uwe,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, August 8, 2024 2:16 PM
> Subject: [PATCH v21 0/4] Add support for RZ/G2L GPT
>=20
> RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer (=
GPT32E). It supports the
> following functions
>  * 32 bits x 8 channels
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
> This patch series aims to add basic pwm support for RZ/G2L GPT driver by =
creating separate logical
> channels for each IOs.
>=20
> v20->v21:
>  * Added documentation about the relation between channels and outputs an=
d
>    subchannels.
>  * Dropped using the local variable offs for calculating channel regs and
>    instead start using macros.
>  * Replaced u8->bool for the  bootloader_enabled_channels variable in
>    struct rzg2l_gpt_chip
>  * Replaced duty_cycles->duty_ticks and period_cycles->period_ticks as it
>    represent hw ticks.
>  * Introduced RZG2L_MAX_TICKS macro for max hw ticks and dropped the
>    variable max_val from struct rzg2l_gpt_chip.
>  * Updated comment related to 64-bit overflow calculation in
>    calculate_period_or_duty().
>  * Simplified handling of bootloader_enabled_channels[pwm->hwpwm] =3D=3D =
true
>    in a single place in rzg2l_gpt_apply()
>  * For config error case, don't call pm_runtime_put_sync() and with
>    enable()->acquire pm_runtime reference and disable()-->release the
>    pm_runtime reference
>  * Split the cleanups into two. One for reset_control_deassert() earlier
>    in .probe() and dropped rstc variable from struct rzg2l_gpt_chip.
>  * Added warn_once() message in probe() for bootloader setting wrong
>    prescale values.
> v19->v20:
>  * Added locks for rmw operations in rzg2l_gpt_{en,dis}able().
>  * Dropped decremeng enable_count based ch_en_bits in rzg2l_gpt_disable()=
.
>  * Added a comment in calculate_period_or_duty() related to overflow.
>  * Replaced ch_en_bits->bootloader_enabled_channels and used this variabl=
e
>    in probe(), apply() and remove() for simplification
>  * Replaced pm_runtime_enable()->devm_pm_runtime_enable()
> v18->v19:
>  * Replaced RZG2L_UP_COUNTING->RZG2L_GTUDDTYC_UP_COUNTING macro.
>  * Aligned RZG2L_GET_CH and RZG2L_GET_CH_OFFS macro
>  * Dropped chip and clk from struct rzg2l_gpt_chip as started using
>    devm_pwmchip_alloc() and devm_clk_rate_exclusive_get() to replace it.
>  * Replaced rate->rate_khz in struct rzg2l_gpt_chip and added a check in
>    probe() to make sure rate is multiple of 1000.
>  * Replaced container_of->pwmchip_get_drvdata() to get device data.
>  * Added a check in rzg2l_gpt_disable() not to decrement enable_count if
>    ch_en_bits is set by the probe.
>  * Dropped rzg2l_gpt_mul_u64_u64_div_u64()
>  * Simplified calculate_period_or_duty() using rate_khz
>  * Simplified rzg2l_gpt_config() using min macro for calculating period
>    and duty_cycle.
>  * Added checks in rzg2l_gpt_config() to prevent second channel setting
>    shared register.
>  * Updated error handling rzg2l_gpt_apply()
>  * Added local variable dev for &pdev->dev in probe()
>  * Added local varibles rate, chip and clk in probe()
>  * Dropped err_clk_rate_put label as started using
>    devm_clk_rate_exclusive_get()
>  * Replaced rzg2l_gpt->chip as data for devm_add_action_or_reset().
>  * Added error message for rate > 1GHz in probe.
> v17->v18:
>  * Added units.h for KILO macro.
>  * Replaced RZG2L_GTCCR{A,B}->RZG2L_GTCCR(i)
>  * Introduced macros RZG2L_GTIOR_{GTIOx,OxE} to handle subchannels.
>  * Replaced RZG2L_IS_IOB()->rzg2l_gpt_subchannel()
>  * Replaced the cache period->period_cycles.
>  * Updated rzg2l_gpt_is_ch_enabled() to return early if counter is not
>    running.
>  * Updated calculate_period_or_duty() for avoiding overflows.
>  * Updated rzg2l_gpt_calculate_pv_or_dc() with simplified calculation for
>    DIV64_U64_ROUND_UP() and dropped the cast for U32_MAX in min_t.
>  * Replaced mul_u64_u32_div->rzg2l_gpt_mul_u64_u64_div_u64() helper.
>  * Dropped pm pointer from struct rzg2l_gpt_driver() and simplified clk
>    handling in probe().
>  * Updated copyright from 2023->2024.
>  * Moved bitpos near to the user in patch#4.
> v16->v17:
>  * Added ret =3D dev_err_probe() to avoid return success in probe().
>  * Dropped unneeded MODULE_ALIAS().
>  * Dropped .owner from struct rzg2l_gpt_ops.
>  * Fixed build issue reported by kernel test robot <lkp@intel.com> by
>    replacing DIV_ROUND_UP()->DIV64_U64_ROUND_UP() in
>    rzg2l_gpt_calculate_pv_or_dc().
>  * Added max_val to struct rzg2l_gpt_chip to compute maximum period
>    supported by the HW in probe() and limit its value in apply() to
>    avoid 64-bit overflow with computation.
>  * Added helper function calculate_period_or_duty() to avoid losing
>    precision for smaller period/duty cycle values
>    ((2^32 * 10^9 << 2) < 2^64), by not processing the rounded values.
>  * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div() as the former is
>    giving warnings with CONFIG_PWM_DEBUG enabled for very high values.
> v15->v16:
>  * Replaced the macro DIV_ROUND_UP_ULL->DIV64_U64_ROUND_UP
>  * Added DIV_ROUND_UP in rzg2l_gpt_calculate_pv_or_dc() to avoid loss of
>    precision.
>  * Replaced min->min_t() in rzg2l_gpt_calculate_pv_or_dc().
>  * Added a comment for rzg2l_gpt_config()
>  * Replaced mul_u64_u32_div()->mul_u64_u64_div_u64() in rzg2l_gpt_config(=
)
>  * Fixed the logical condition related to counter stop in
>    rzg2l_gpt_config().
>  * Dropped pm_runtime_resume_*() from rzg2l_gpt_config() as it is managed
>    by rzg2l_gpt_apply().
>  * Moved pm_runtime_resume_*() from rzg2l_gpt_{en,dis}able() to
>    rzg2l_gpt_apply().
> v14->v15:
>  * Added enable_count and ch_en_bits variables to struct rzg2l_gpt_chip
>    based on feedback for pwm_mtu3 driver.
>  * Updated copyright header and commit description by replacing "This pat=
ch
>    adds"-> "Add"
>  * Replaced macro RZG2L_GET_CH_INDEX->RZG2L_GET_CH and replaced ch_index-=
>ch
>    throughout
>  * rzg2l_gpt_{enable,disable}() enables/disables PWM based on the
>    enable_count.
>  * Replaced pm_runtime_get_sync->pm_runtime_resume_and_get and propogated
>    the error in rzg2l_gpt_get_state() and rzg2l_gpt_config()
>  * Reduced variable scope in rzg2l_gpt_get_state() by moving most of
>    variables inside the if statement.
>  * Updated rzg2l_gpt_get_state() by moving duty > period check
>    inside the top if block.
>  * Added helper functions rzg2l_gpt_calculate_pv_or_dc()to simplify confi=
g.
>    Also Improved the logic in rzg2l_gpt_calculate_pv_or_dc() by using
>    min(period_or_duty_cycle >> (2 * prescale), (u64)U32_MAX);
>  * Updated rzg2l_gpt_get_state() by moving duty > period check
>    inside the top if block.
>  * Simplified rzg2l_gpt_config() for updating registers
>  * Dropped pm_runtime_get_sync() and used bitmap variable "ch_en_bits"
>    to make balanced PM usage count in rzg2l_gpt_reset_assert_pm_disable()
>    For case were unbind is called before apply where pwm is enabled by
>    bootloader.
>  * Added error check for clk_rate_exclusive_get() and clk_get_rate() in
>    probe().
>  * Dropped prescale from struct rzg2l_gpt_chip.
>  * Replaced of_match_ptr(rzg2l_gpt_of_table)->rzg2l_gpt_of_table in struc=
t
>    rzg2l_gpt_driver
>  * Updated commit description of patch#4 by replacing "This patch add"->
>    "Add".
> v13->v14:
>  * Moved the patch from series[1] to here.
>  [1] https://lore.kernel.org/linux-renesas-soc/20221215205843.4074504-1-
> biju.das.jz@bp.renesas.com/T/#t
>  * Add Rb tag from Rob for patch#2
>  * Removed parenthesis for RZG2L_MAX_HW_CHANNELS and RZG2L_CHANNELS_PER_I=
O
>  * Removed duty_cycle variable from struct rzg2l_gpt_chip and added comme=
nt
>    for cache for prescale variable.
>  * Fixed a bug in rzg2l_gpt_cntr_need_stop().
>  * Reordered rzg2l_gpt_config() just above apply()
>  * Replaced pwm_is_enabled()->pwm->state.enabled in config
>  * Replaced pm_runtime_resume_and_get with unconditional
>    pm_runtime_get_sync() in config().
>  * Restored duty_cycle > period check in rzg2l_gpt_get_state().
>  * Added error check for clk_prepare_enable() in probe() and propagating
>    error to the caller for pm_runtime_resume()
>  * clk_get_rate() is called after enabling the clock and
>    clk_rate_exclusive_get()
>  * Simplified rzg2l_gpt_probe() by removing bitmap variables.
>  * Added pm_runtime_idle() to suspend the device during probe.
>  * Moved overflow condition check from config->probe().
>  * Simplified rzg2l_gpt_reset_assert_pm_disable().
>  * Removed the parenthesis for RZG2L_MAX_POEG_GROUPS.
>  * Renamed rzg2l_gpt_parse_properties()->rzg2l_gpt_poeg_init() as it
>    not only parse the properties but also implements the needed register
>    writes.
>  * Added acomment here about the purpose of the function
>    rzg2l_gpt_poeg_init()
>  * Removed magic numbers from rzg2l_gpt_poeg_init()
>  * Fixed resource leak in rzg2l_gpt_poeg_init().
> v12->v13:
>  * Added test logs in [1] below
>  * Replaced Kconfig dependency from ARCH_RENESAS->ARCH_RZG2L
>  * Sorted #include <linux/limits.h> alphabetically
>  * Added a comment for mutex_lock to fix check patch warning
>  * Replaced data type of duty_cycle from unsigned int->u32 as
>    the maximum value stored is U32_MAX.
>  * Improved rzg2l_gpt_config() by removing unwanted duty_cycle related
>    code.
>  * Improved rzg2l_gpt_get_state() by setting
>   "val =3D rzg2l_gpt->duty_cycle[pwm->hwpwm];",  and factor
>   "tmp =3D NSEC_PER_SEC * (u64)val;" out of the if-statement.
>  * Started using DEFINE_RUNTIME_DEV_PM_OPS(), and dropped __maybe_unused
>    from the callbacks.
> v11->v12:
>  * Added return code for get_state()
>  * Cache duty cycle/prescale as the driver cannot read the current duty
>    cycle/prescale from the hardware if the hardware is disabled. Cache th=
e
>    last programmed duty cycle/prescale value to return in that case.
>  * Updated rzg2l_gpt_enable to enable the clocks.
>  * Updated rzg2l_gpt_disable to disable the clocks.
>  * Updated rzg2l_gpt_config() to cache duty cucle/prescale value
>  * Updated rzg2l_gpt_get_state to use cached value of duty cycle/prescale=
,
>    If the PWM is disabled.
>  * Simplified rzg2l_gpt_apply()
>  * Added comments in rzg2l_gpt_reset_assert_pm_disable()
> v10->v11:
>  * Used bitmap_zero for initializing bitmap varable.
>  * Fixed clock imbalance during remove for the case bootloader turning
>    on PWM and module unload is called just after the boot.
>  * Fixed over flow condition in get_state() for a prescale value of
>    2 & more.
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
>    enable registers.
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
> v1->v2:
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
>  * https://lore.kernel.org/linux-renesas-soc/20220430075915.5036-1-biju.d=
as.jz@bp.renesas.com/T/#t
>=20
>=20
> Biju Das (4):
>   dt-bindings: pwm: Add RZ/G2L GPT binding
>   dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
>   pwm: Add support for RZ/G2L GPT
>   pwm: rzg2l-gpt: Add support for gpt linking with poeg
>=20
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 401 +++++++++++
>  drivers/pwm/Kconfig                           |  11 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c                   | 626 ++++++++++++++++++
>  4 files changed, 1039 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-g=
pt.yaml
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c

Gentle ping. Are you happy with the patch series?

Cheers,
Biju

>=20
>=20
> base-commit: 2e8b1b881a36223c337e07c63a52ed6c8a47afc7
> --
> 2.43.0


