Return-Path: <linux-pwm+bounces-7741-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8D4C96C50
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Dec 2025 11:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1723A385C
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Dec 2025 10:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE077305048;
	Mon,  1 Dec 2025 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ignVK6W9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011005.outbound.protection.outlook.com [40.107.74.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE77A305044;
	Mon,  1 Dec 2025 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764586589; cv=fail; b=cx+wtuoW2Ov7ymFugR10X5J+5mDV2c+K7U8j0RnhoO9IZp6hJnijcqTZ1tUWCPkk/zRe3xIuUH2B3Ksn2/KvnQzS4XJfDR5lszc5JqH122sxk0fi6E2lSFOamBIyKUL/xwQhUFnH9GYl8HjjwznErjbVyKDYAgec39N30Qb/PSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764586589; c=relaxed/simple;
	bh=ByuVvOfQf6NnXogZEbrpAJXkbLEZf7HufxkhZgy3OB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TbpZL4kg0fmSdqn/EQL0wbA5PLtPoJK7fAJodwwN+bAHZYe1xjuw220lNaeYAJQlgiHDfgiuYD6OUCcFOKqhbXP7h9sOvMDkpsXO8MuuxHeqn/up87eywHk+G0KVLaHFslWN/PbZBpGe5++Ep1Z94SSxKxMN6zSmx5NsC0ymtw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ignVK6W9; arc=fail smtp.client-ip=40.107.74.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUIw+uJcdavqMg/RwSHUng+MwTZyrF5MqxjmVaeHPdWYmaEB1988uGdut7mZUN3/tGeV8lioCceB65IyR7dgGBPTC/SpaGHPnwC8SaSgz117pjimOO49teol8KwzqftlR2xUyHMTpCa1r0uaTQ/+7lKmdSoOU0oBzqWOLptpcNhCZDSjc2si5qwC5WUD48Ov6eKD2/0NhXl7d+CoIQmc+9L5Pq5L4lD2TgL639g6FwQph59ZlsGSkYSLJqsuDbtIQ5GOjeukdxqwYRXe1Ej2lkweWkHmVCg9irwGFx3hkAtO6Xlz2Oh0+IRxrnc0VbNzek47ctl8YNzMU4yucTS4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH0VM1aeOj0ysKS6B3Nr8M8oynFOI2zLeCHJVVHDLJA=;
 b=bhsxLewG2WaZLTzPI2GyBsOCBmpqaSxeP7qeZS6c/xfU0EcKF3cSfLxHZYzMqFkC+bxg0Apy06mUL0y1XtotssxsWNk/zKNTWaasym6flx2eHeXaCD/CTgUGltgS9xkRUaoknw/7BKPIl7kGv5ezOVUEoA16o1RUcQQq2ucFXdrKGf1Wa72XDhe/nxt/S8q2wbI1z5fYsf8QXEi0GWKjAMClPGyAmFdHwEur7+oDYWwibOlgIoIWKEAJq9pxUiYJ0dN/7F3jJzCAmWFGMV7tiIpOcFYmEq8hLwIBxTImM32gvBBNXgnatHJh4UYMWuLwNb8Q2ohw8gZJqfsJUTfYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH0VM1aeOj0ysKS6B3Nr8M8oynFOI2zLeCHJVVHDLJA=;
 b=ignVK6W9C4hXq54oATizHEkLLZIG1U4ULz/itOQgZAW72O2ideZjUPorv5xVbCY6Kr5cSr8Qh1WwuGD2YTx7s21E1He5FMGx89jKv5jmVEP/L0KYfW7yzp7sUVaMjGklZ2D9f1Zo/n8mvhhP+prqk87Hq1/uiRMv6XBws+wzH+g=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB13485.jpnprd01.prod.outlook.com (2603:1096:405:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 1 Dec
 2025 10:56:23 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9388.003; Mon, 1 Dec 2025
 10:56:23 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, magnus.damm
	<magnus.damm@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Tommaso Merciai
	<tommaso.merciai.xr@bp.renesas.com>
Subject: RE: [PATCH v3 2/8] pwm: rzg2l-gpt: Add info variable to struct
 rzg2l_gpt_chip
Thread-Topic: [PATCH v3 2/8] pwm: rzg2l-gpt: Add info variable to struct
 rzg2l_gpt_chip
Thread-Index: AQHcLJi2hGfoYmQieU2FfTDX1hfYhLULTLCAgAG7wbA=
Date: Mon, 1 Dec 2025 10:56:23 +0000
Message-ID:
 <TY3PR01MB113463D0252F16927DEC9E9A286DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-3-biju.das.jz@bp.renesas.com>
 <lb4h7cm5jv7xngwihq3k3kgcj7a33suictdjztv5xcy75wpafd@i4rf44e5sigi>
In-Reply-To: <lb4h7cm5jv7xngwihq3k3kgcj7a33suictdjztv5xcy75wpafd@i4rf44e5sigi>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB13485:EE_
x-ms-office365-filtering-correlation-id: d6b99bb9-eabf-4c38-4b0e-08de30c84495
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?vRhXB0bmUChoqR5rVlJq3dHM0jcGEwLCFiOACDVmwTXPXrkRZcO12hodS8?=
 =?iso-8859-1?Q?zkYN3hI+utyk0QhT1dFpa5szglYQF/5qqy2M69cBM1FoQaw1XsvDfNRHEg?=
 =?iso-8859-1?Q?LoIaXZngbxwZp0cjc3YFLrHVd3SsayMRgOPTg85HgMQJAxMOkA3UHFqvse?=
 =?iso-8859-1?Q?mKKfFGWfPQ4LAm9OgxI53R8Mu3V84DcYiU+WyoExs3sIniOcpD7F6Y6mvn?=
 =?iso-8859-1?Q?X4xQdalC1OCcH3to/59M/kOPpM9YOY0mn0ZaPNoIiyaVVXqlP2HHXgI8bv?=
 =?iso-8859-1?Q?cpk4j8erVE7SBeE0oZ6i4jloVqWp4LcaGaRd9flNK2zCM3MoW5fqLU454/?=
 =?iso-8859-1?Q?eLYX0aiR5hiX4qs5I68IvXnvlT2SV3DISvTzaD61ere36P39pbPjsNaCL1?=
 =?iso-8859-1?Q?joAEQOOxQv9GfSp54CiArmxf1mUsPO9prZz0GUPiwxFmaHStmkt/2B+2Ku?=
 =?iso-8859-1?Q?ECd9tUCHXnqi2kByO2Nia+pJ5/R8aRPJgrayfRqzViahKXEtTQpPLwkGH0?=
 =?iso-8859-1?Q?iBSFWCYnojNHnB1+LiNp36nlu6qzXgLJ/l16aPDfTUinJ4i0TrRItJmkV3?=
 =?iso-8859-1?Q?M3Yu7bHzstemqU3ZMZ4Gtqn78BKuEiSm9Jp2RylneEOenFn4Xy3YWUW5Cq?=
 =?iso-8859-1?Q?2/sHmJx5UgNlQnslzW59qBS8hyMBkI1gnViNfQccNk3u3PwjWQOSGFnxtz?=
 =?iso-8859-1?Q?2XqUVbXN/rX82CC10hmDrSZ5pNOsQ7j4S8IB3c1yHvgP9Dwhoru77wg+Nn?=
 =?iso-8859-1?Q?cWN4WEgGS2tYM9payGZ/BBrFeBM2J29dJX8oBl6GKn+pF3pJ18Fk3IPxAT?=
 =?iso-8859-1?Q?S2Bx0qk2UlSYdbuko83fYxsF5UGhDTktYGEbUGDzEQCsNRDkZGu92jd2az?=
 =?iso-8859-1?Q?gR34TF9Y3nkgdk2gxsy51CmnG33ltD6HmQfKAKSHfC0kBzPJJPLIU0J5uU?=
 =?iso-8859-1?Q?1gjSyww9wl3ZSIJPjkwMPEBM9IbCvXAlRmaak2GncXIMDF7PSJ5gODsE/k?=
 =?iso-8859-1?Q?uEIcfBtsfY0V6KfIpPD/MHh3wFt82cl/TWgLfyjMzkFt+1yHJG8Wt2gOV9?=
 =?iso-8859-1?Q?I2hE10FkF7uQBP5/5IeUWVpsIfcS86fo0ruZpI3MKuXoy4nQCCMLt68NQ7?=
 =?iso-8859-1?Q?0M0pUqpQEumiVQ71SDuWCQygJ82q/Aj5+SwfBUqesEI3PlxwqLsXkWuhZC?=
 =?iso-8859-1?Q?w52wRm89g8E3ozK25yRuXR9R5Rv5bFi0CJNcCk+o4hhpIkX7BGHN++wa8b?=
 =?iso-8859-1?Q?cJfvx43z1lXhMkwFlp6TDxbyucnd1tNYCVdpQkXzbq9EuJGClk0FIIWsYU?=
 =?iso-8859-1?Q?9N+9KkLWKqjJrNLqV9wXvED9POJW1lqHsHFQFnSQPmXgq3uapWqBrQNQ8U?=
 =?iso-8859-1?Q?aBawFmxC857+oaqm08G6rtECbg88Zyd2KvXPL1Zz/JqbGp7KnY0OVNqu4o?=
 =?iso-8859-1?Q?jklUUMokb5Lt4doiwei8TqPTz4keoSTvGMXM+l5i2yF/jiItBTJYkJKn4h?=
 =?iso-8859-1?Q?OVcqS1KpnQEXQM4nrWrsKeVjoMxu9iVv5x5LICnF06VFl8V0G1+Mt71IMG?=
 =?iso-8859-1?Q?wPMhuao01lI0ZbzbJ58kmiT60DYl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?N1Toau+MIJFtgMheEzI2S1hm5Smwf6pHJ5tgFbRZkQnUY9Ji7dyHstJyF5?=
 =?iso-8859-1?Q?Cd5uijswVEddW5axr8Vbp3EHWfQmvyrgPNiAhUd3iloaWzpUF+B00tXUPq?=
 =?iso-8859-1?Q?HZ7sRUI+YlOpajeGprEgnqj3u6gRacGpdyDvMlOnIKC89ZMrJJQ2qeHTjT?=
 =?iso-8859-1?Q?2R10EpxSrxaQfYpDTK8evpVfyaFMJfqaR++4yS9INxusQjIOrdapAsFQMR?=
 =?iso-8859-1?Q?7DfhmBf+M156MVuzFukOcunBl+NvKs18wOdZNxc33mbGq1grwVmCov9OQU?=
 =?iso-8859-1?Q?rkM3A30e3FUvvUz9iQj621tKblpfygYpd4AJFutR/zfiFMk7Wok/GNULd5?=
 =?iso-8859-1?Q?4u5pXW4BR1kKOoJ8ddnw3D3Y9iQUYKfety/D6qqzcilqJy7ofQhge4DeCv?=
 =?iso-8859-1?Q?y380Dfd7Y5MW/p5k23b34VPlH7G83oyktmcj/lfTe/wAvQaDGg8kUwPCT8?=
 =?iso-8859-1?Q?pJ2COvPyhFQdkHbUZBsGf3wimmHpWSrHMLo2zhRd8L2yWiTk3YT2wUfV5V?=
 =?iso-8859-1?Q?UeV19P++xHCFQtrr8lX/5+iU6hAZlwgghYOdlS0FeuXKehV+04czRzKhJy?=
 =?iso-8859-1?Q?clpIpdtabxU1PYsx8o7c6PWQE4T08EuD6GjjerSWvnTWN3aWBp4XMbTCyt?=
 =?iso-8859-1?Q?IQN5SEWDOs8dAL5J4HzDmR0Ik/iF0lL3Wkj89C+pjMdUvnyFEN17rkvTkk?=
 =?iso-8859-1?Q?BBEQjQzwO5ife/IFi8Izf2GiXkmIFO4+1tVdea3VdGxc0HSxwPmMPOQ5WZ?=
 =?iso-8859-1?Q?NULCRvm+tisDPLATIVj2WOUmg8eiDjBLVZCm2kL32RMyV7++yR5ie0oNWI?=
 =?iso-8859-1?Q?v9va+2dsVhV10ko1WCcyYMW+KkXyr9BfDge577dlF9m2bhRHy3OPFLsb79?=
 =?iso-8859-1?Q?MmAERXcAzyr1h2zHWWFAFgSEJx19HgsdIrTlbqL4G1DAf9C5tqf+ETSsoh?=
 =?iso-8859-1?Q?Qbz1Wl4KKmjvIwb4L1OZGivoagJ73obJsBn+0wZAj/Yzm37Du5oGf61FIO?=
 =?iso-8859-1?Q?FmRJjLeNULFGHrPVRFBRaJtAcGJ3/GXRZbMppW27e77+ZHOf5LKxVXOUD7?=
 =?iso-8859-1?Q?ryWHHkxzkb/y2+rl90elCSNmxQmp7/8ekJoK/qOryX3ke1248bPRsalwsj?=
 =?iso-8859-1?Q?2GmGQhjAwRC9OrfOWvQodQ+LOVcGogTdRfyqSOrmJ6HEaIYvA3kh2h3NL9?=
 =?iso-8859-1?Q?Ww91umsNraMtY0AE4fxHOA5zJVGUZMvU3AHvpl1oF7448aYtbALbXZe6kN?=
 =?iso-8859-1?Q?IdXtJtskROr0RprF8Xso4XX0dDbojSVehwovMONA9wT0hT2GI70SeAdARw?=
 =?iso-8859-1?Q?h1vkqWZRFBpm8tN7B0AxBpMEUF0d3r9aXhnqf3y5rQ1PpYYxJIZz+FwHrj?=
 =?iso-8859-1?Q?rmQ7H3xe7iglyu7DsM7UYHEpPUdHQU3uLCbwQ+cGmF3k4wTIbkcO5haYKM?=
 =?iso-8859-1?Q?IbrOVTfkzrBbbLmxHdEf4GjDxr1QDaUHH3mHYl7aGlYMDtu9Co3e+2OEkK?=
 =?iso-8859-1?Q?ysttHF2eznwYfDjx4sw1k1JhNngSlAxPYnvUHSruzgaq00GSJPoR7K+ZvP?=
 =?iso-8859-1?Q?Nr2DUPSsCk3HuR/80ZEjFTlPEOKhxSHs+IGgDgXq6dLESxp3hZlahR3+Vr?=
 =?iso-8859-1?Q?AiDRLAm+DRpXHDw5QG2Grkt1Qn2nQkHvAYpOgvtx1n8H29ZuXSA1fn8w?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b99bb9-eabf-4c38-4b0e-08de30c84495
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 10:56:23.5325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcJYoqYiBj5zqW8h+A/aXJPAllxadH1p7q7aMgPEmm0cObsQ5FQhqdYfMq1mBxlFnSFwxfRi1Zadr73zaPvLFj4tElZhblC1ZYbH98G6Y1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13485

Hello Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 30 November 2025 08:26
> Subject: Re: [PATCH v3 2/8] pwm: rzg2l-gpt: Add info variable to struct r=
zg2l_gpt_chip
>=20
> Hello Biju,
>=20
> thanks for your patience, now I finally come around to tackle your series=
.

Thanks for the review.

>=20
> On Tue, Sep 23, 2025 at 03:45:06PM +0100, Biju wrote:
> >
> > @@ -46,7 +59,6 @@
> >
> >  #define RZG2L_GTCR_CST		BIT(0)
> >  #define RZG2L_GTCR_MD		GENMASK(18, 16)
> > -#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
>=20
> Even though this is only used once now, I wonder if it's beneficial to ke=
ep the name to have the
> definitions relevant to registers all together.

OK, I will keep the definition.

>=20
> >  #define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
> >
> > @@ -77,9 +89,14 @@
> >  #define RZG2L_MAX_SCALE_FACTOR	1024
> >  #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
> >
> > +struct rzg2l_gpt_info {
> > +	u32 gtcr_tpcs_mask;
>=20
> For consistency I would have called this only gtcr_tpcs without _mask.
> But here I'm not entirely sure if this will be confused by the occasional=
 reader with the actual
> value. What's your thought here?

Agreed. Will use gtcr_tpcs.

>=20
> > +};
> > +
> >  struct rzg2l_gpt_chip {
> >  	void __iomem *mmio;
> >  	struct mutex lock; /* lock to protect shared channel resources */
> > +	const struct rzg2l_gpt_info *info;
> >  	unsigned long rate_khz;
> >  	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
> >  	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
>=20
> Just these two very weak suggestions. Please consider these and tell me w=
hat you prefer. If you like
> to keep them as they are, that's fine for me.

I am Ok with your suggestion. Will fix it in next version.

Cheers,
Biju

