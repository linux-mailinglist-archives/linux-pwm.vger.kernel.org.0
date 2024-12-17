Return-Path: <linux-pwm+bounces-4372-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A72C9F4AF5
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 13:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4F61891190
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 12:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD7D1F4288;
	Tue, 17 Dec 2024 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="o5S0j1I2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011064.outbound.protection.outlook.com [40.107.74.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C51F4710;
	Tue, 17 Dec 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438622; cv=fail; b=hLM2vgs8R4fA2M44eZtizwnyb8qzTTHOe5hEWvk6eo9OD+6iqhY7i/oGyejL4+P/dSI46QezfFc9mbq5Me9MMtfIlcQuUPeNxF8o9nmqV/w+ZYkR26rlQxlbWEs09J/HkMQ+UPvMXp5hcA4IPG0AfU+WAmcR6z6iTr7wulGlWSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438622; c=relaxed/simple;
	bh=iPEgu/pQ8hjQLqSrWyondEEDtCwhqCUR/eEli1TroEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vu3LAtVAnZyOLF7/al+Mp0K5cbMnHC9uBc3P+P6o2KBabl1GI8z0gBHT4R3Odcm+6CW7RPq3Cea5FkjdZGMA58G4MZa5tGYrkmHhFGI9YMcJSgmz7/adyCkKhnG2rgzZA3PRR6pM1pjwBLaSN/gBCB50a2jL9wJswMrnGIGl270=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=o5S0j1I2; arc=fail smtp.client-ip=40.107.74.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bA6udBTlTwSDpRVnW5IQWrwOrlhGgJdExkOI941nwjt+FJstTtsB5sXHBssFq/XMfzLw9fXnW8OX7BJKuePh1qfg44woEQcpNl1hUljR5pvhRrgdWomhZ5IgVlk/YZSxVAF9jDohsCZWYB8N7H2t4JUsEqL/q7RsR1IpoPWaVFdbAFRi3jGzWfgKzuChawPCNR1hi4sq1o0h3+OEOcUln0D9YEoYNbs9Ey653VPOhli0qMP/25/lGV4pTvNqlgSbn5PAzn5cNPvEJHqOEDDj9XY7ChpG2rA4+wCzCmRlq7Bow4IyDfCA5m7/lysmFT9OC3n6FzfPeSp11WAkpgM9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeFkLirBGRCqFnhJ4QW828fCJtwk8CGOYsGZj0y0nNU=;
 b=NcAitPJZrAZdS5byF6mqmuFARMqK8Uu6amIn/LBKYWBrx0wLB3cSeaYiYNigVWW09ODZ8vvytacS+8McmgZdGZ1n/dcEzX4nZWh1YS56ZkkLGDQxRX15BoSmiKGJFj3lMc2rGA18Q3K+GpHpZjH1AGabGdiSoUT4UsFSgn89yxln7Mj1oyFpu7MlRoFXhzRkZtg9cpWQIe/pEPCSpKBFS9ahwVAgP0B4Q/8EARjEnlLSauHH/QNZ/ZS2EOaNUyu414CHfa4FWNM734cKC6E8SykvemR05nRH/K5QxzyKXWl67upnRywiHb4FLRyGIPG4NWPwAVgVzKa5+OMqKCjJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeFkLirBGRCqFnhJ4QW828fCJtwk8CGOYsGZj0y0nNU=;
 b=o5S0j1I28L4Oi2FiBnTm0w/dMRV9ZynzECq3Xiqb0VtnwyIgxdAVsn4Bwxo2Itr1kTuBKOfInM7te3l4AqPA8lK9CTOndPlvMpFVR/e4jgVOIg8xWroYip4enX3PqVwAO+zUq9VmsQBmwcoepsBMOAnkI056jqLNxjdcruJii6Q=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB13432.jpnprd01.prod.outlook.com (2603:1096:405:1bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 12:30:16 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 12:30:16 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHbIV3QCLVSX2/XSk+pOZR0ZimyzrLORWwAgBx14JA=
Date: Tue, 17 Dec 2024 12:30:16 +0000
Message-ID:
 <TY3PR01MB11346984731163E2E3DD7CB6186042@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241018130049.138775-1-biju.das.jz@bp.renesas.com>
 <20241018130049.138775-4-biju.das.jz@bp.renesas.com>
 <slgs56imb3u6fv35bo2hl4moa77nnhrtcygi4womtuzs2mcipt@ylcvacvhsgcl>
In-Reply-To: <slgs56imb3u6fv35bo2hl4moa77nnhrtcygi4womtuzs2mcipt@ylcvacvhsgcl>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB13432:EE_
x-ms-office365-filtering-correlation-id: eb39c5f3-2c91-4c66-70f9-08dd1e968fb6
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XhVihmdT7jZAOxtJOMbQsN/rYxa7ykzsn90uARwducliyxd01YJCvNhlZW?=
 =?iso-8859-1?Q?0Lh7B9Cfqm20DvNU/1wykxq+wLujBdZV21WY0mAiaAVfaOuBbT+lazZ9td?=
 =?iso-8859-1?Q?Xtmb3zC4b4tVw2OoO6JVZIaxp9XNztSrLWJ6h26bPafKyz/4d/0mD9DPvI?=
 =?iso-8859-1?Q?ngvT3HrDda/XNcUz1Aj/sn8St3z1wa0sbbB2ORdAy5l0Zy8P+5NLXw7HDQ?=
 =?iso-8859-1?Q?HsHvBmoqHXFe/RgkUxB9U1VnbH42gYLIkBUPDTqhYgdGzNpajX2i1mOxLf?=
 =?iso-8859-1?Q?9vWODts5nValYF0gFEn2sZHvB4Go4RnxIHRMIkkyPoPGURIdWXnr69U6Z4?=
 =?iso-8859-1?Q?KNcJcH8IV/qNAY/hzmw8kqK32R5JB0CJ9QG/h0D9IS3YDANZAPL0czwWu4?=
 =?iso-8859-1?Q?Ti4ZDVg86euXaOxfSN0UxGHJqPcvj1NIXSBXpKJBXtyT1K1Mz1LwnIa5kA?=
 =?iso-8859-1?Q?HzH+ezSV4fqIva5LQJH1we244hS1vUu6cvNa+G1UbQJE1Vhd+EVJrDkD2z?=
 =?iso-8859-1?Q?rF7jiDCVP1GA//OkjNx81Frch7xdVnk6MiYI7DdCSQuG862IQ8ylEdHp1E?=
 =?iso-8859-1?Q?J7cPCNMo833kgYLWtgdPxfs4xL1h2WhNOdFm8uCuKEJNiIrp1RQE6HFW1n?=
 =?iso-8859-1?Q?8IDfZ53x6ezETuN1ELFl803U9R7FCNwN+BKcqlD0zXQPUtBBynnwPP8ZgL?=
 =?iso-8859-1?Q?siDaVdp01Wd23/uTlrUlCErJIYX3iH9OwK1W4rXA+/fwF09baqBe++4VWl?=
 =?iso-8859-1?Q?xXKzyKF1q1N+s+e9zQFlJSPEqtzWpq6UaBmab8BR+DWsr5CHeShLPVtZC2?=
 =?iso-8859-1?Q?sB6OHdB8o6+eA/DGjBCQcAu6BM8WAiZlbMITgpxY+yZZ1/en3eYSBMYT8s?=
 =?iso-8859-1?Q?NFeWWnliH//pZfOOuOgLq+3vafE0KSuq0gWba9Q2t37oLLf0HRBpfrizy1?=
 =?iso-8859-1?Q?g1mRfsVGKWb+ylYIeLFyYSQCXGMdt09LzTpAhmV3kSbVqeOrXqB+1jlWwY?=
 =?iso-8859-1?Q?d2jVMcBTZDs2QhlOdF1M2peTQ2+f2AUXArFe+dlipWF93jkD38wjGUvmva?=
 =?iso-8859-1?Q?ajkbb7KYgya6G50WE0xQLIEqtFIoiC/DKFVu27a7zinb2d9AYZ+qVsNhnj?=
 =?iso-8859-1?Q?8taD9hmCBxukF/1RXk9QFUb47mbc0+dbT3QDubgZ6h+nHMcMsr2T8OEOOS?=
 =?iso-8859-1?Q?gW5sHQQkBoau6rvPEJ2M7qkwiirQHli1DT05dnjh8JI1l9A1cDersHS+OO?=
 =?iso-8859-1?Q?aSGys0cEG5aVRqUWly2FEiOuVlPRpyfh47CuDZldkrgO5dzxdbz1tZYW8g?=
 =?iso-8859-1?Q?ojlWYXrcRJ0jgF1tSMTETdbMQrWA3hm251/HffvbgqOEBcRNVg82Q757X2?=
 =?iso-8859-1?Q?E0aULnl2uWU+Oitl2Z7JtMouP4Mci8aytdee/B8DCL1qeKHpcJYqHCevkE?=
 =?iso-8859-1?Q?pFf6E2KmQoggCNCWSx/86c4VNXuy2WrgStWLAaFn6MOhbbBd5zFOYD/ZaK?=
 =?iso-8859-1?Q?QljKNVXs0InK7yGrx+BWm+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RUiVFPpbEP2IXYrm5Cfv5Rb9JcTg+VgdKf0JecLufwXy5d5Y0e531EYlgT?=
 =?iso-8859-1?Q?a/xvED68xMY+15qL9syzuHm5AdOmo2qbjbDPCRMxOruYfwIJQM0DhCpkpc?=
 =?iso-8859-1?Q?w/rWIWpB2n/DFv+c1QTIsIdA0xqqreEgo831+7UlBsvEa9nUbezE9nHw+b?=
 =?iso-8859-1?Q?KKz/4F5Tlx2DOAhxrr+BBlaoDxjlgh4nMBRoiUjaTX8xlJbFwo6fLK12ag?=
 =?iso-8859-1?Q?xyLWRGP/i/xhNyi0CM1yJuPWUg9x1A79YbnkULz+z7mi+7/zPjJOvZAxNt?=
 =?iso-8859-1?Q?yjBxscdLIySSGGUYKeUAzCuaGOvIO1MZt7ME+CSEL1e3sGXmF2yfLp0hUX?=
 =?iso-8859-1?Q?eIQ1NBquqIa39acSFYo4WctEpu8Pm7jj+mYHs/anRDgDBJLkz8hYclCdBa?=
 =?iso-8859-1?Q?yoUVbWYN1bEqo8cEZ2w6Vu4PcAEKHuLHQpFURF26y29L1Mjv/nOmxWPADz?=
 =?iso-8859-1?Q?7teFOln51Mowm5NNlIkYu2lOvztdUXJAgnSVWf/k1aBVLdcvxbyShceI3/?=
 =?iso-8859-1?Q?qitnr19SjcIEMRAUffITlL1r9ovepnycotdpRyuK/j17PbALKzBf11k5rm?=
 =?iso-8859-1?Q?HtjToqg3XsMBs8GHlYFyS8RSZpxkWkC4h/GqTKeKhOnr+KCsFQ1dsaDX6k?=
 =?iso-8859-1?Q?jv3mmBhH50X8oSolfQsEjWal8pey9BvZusBL0F0uDNj7uSCLszmd9mSCUh?=
 =?iso-8859-1?Q?r55FWUX7+FJk3Yx2lk0WGSr0nZ1zmehqVPXQPgUgI9p1b2pEp7mctojkh3?=
 =?iso-8859-1?Q?zhdtaZGV7Eldfbnh8t8LWT972xOD19ZSdhiq0e7MirIyZUufce7dpf3DnK?=
 =?iso-8859-1?Q?fhzNMDt5QZ58CuCSiP5zuIF2Mvv1nF0JEG+pX7ZtxnN9qNXZFNuknDo4Gq?=
 =?iso-8859-1?Q?RyJMK9/uySGH9xRjYO0bkJuV7LUbINXNtzocpDqBAbTdlCOto7GBOPJ/Cb?=
 =?iso-8859-1?Q?wfYIYwMqtekpPDfZZVPnjGRgAa2E+MmXEr0DmJNfzMlQNYW5NKyYnWJt+r?=
 =?iso-8859-1?Q?KGdQynas6PB3O6e40Idhm2uV46KKPhC/Gk2+8ixtYILEBFS8jio4IZCv0D?=
 =?iso-8859-1?Q?mVjVMvvmlTXeIa3ErFibI3KHwepR2QrjHvAr5gq+coRulEkCVtuN8T+fP2?=
 =?iso-8859-1?Q?rFZxokM+cwhRycgvCvCg5j5TyeOiuVmu+0FFy9XLDy2w5gW2c9Lc8LoQvB?=
 =?iso-8859-1?Q?Wa5A5j/OMKnUZDBoOT0Gb8V2Ktgxm3iLV6IEfdvEcA+Ayl6tOfI6kfVp9X?=
 =?iso-8859-1?Q?F23CWDH8iiWuKkPBqvz7pqIEfd0TWFhJOHaldgkWUCCdKsfOlDuo8zt4p7?=
 =?iso-8859-1?Q?VD6MAzU7S7xlc9mYkE2cDqwlNQAb40vECvoTuSO5WFlbyBXO/oLtf8y24u?=
 =?iso-8859-1?Q?9Kusga1zWZTAJytwaTtV5ytP7+q8pChlEQRj8gIDeFRhhhhKF8R0gNb/Ii?=
 =?iso-8859-1?Q?utCGLkSlkUfhCB9D4CqHfoPyhz4J47mkrd8XFq5MNj+pqQyajdB2jwEYqI?=
 =?iso-8859-1?Q?pPyct3sHDCBrJW3F2EHLL6bfCUW6dqmVNpDB3p2MB7BY2xrQyMkgRrZDuD?=
 =?iso-8859-1?Q?/rwewZRxjOEYvwoLAckoJvcSwHpT019mk4L1EsOHDs51TYZ0nBvatkmOF+?=
 =?iso-8859-1?Q?DHWr6Dm9U/CjsdtCM2HXM1Bw3PEbo29neu+tASBaZa0zGcgmz0HtBSrg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb39c5f3-2c91-4c66-70f9-08dd1e968fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 12:30:16.1142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eR1LopzSZfC5YI/BbkEmJp6peKVMw0rFsiYCYBfkrSuVVKahawrlzNxiKumVDbOva1nUzouZSzZdHbTp6qVPBcjnsDCYWd4M1OXXNOPF2Y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13432

Hi Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 29 November 2024 09:50
> Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello,
>=20
> as I already wrote in earlier revisions I find this driver complicated an=
d wonder if this is because
> the hardware is complicated or because the driver adds unneeded complexit=
y. So here come a few
> suggestions that might seem to be trivial but IMHO simplify understanding=
 the driver.
>=20

As discussed, I am going with simplified version of driver with Limitation =
section updated with

* - When both channels are used, the period of both IOs in the HW channel
*   must be same (for now).

Later we can enhance the driver for handling updating period for second IO.
I will send the next version with remaining review comments incorporated.

Cheers,
Biju



