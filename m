Return-Path: <linux-pwm+bounces-7700-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC164C8640B
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 18:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C01664E8B2D
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 17:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3AC32938C;
	Tue, 25 Nov 2025 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="snHcZMxS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010031.outbound.protection.outlook.com [52.101.229.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B47A2153E7;
	Tue, 25 Nov 2025 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092377; cv=fail; b=X0zY6Y0f2jtcuE40ywQoVDMM7a0TrHbC0ngEEChwvxkeiLsboiJC3+N9TpqYKHXgswA9A174KNHtsU537h5iXcvgvlRwruiMma534+y4Hy1j/WHp9kaReTuMWi+WOc9yl2UHvg8ynnCeYUMNLM7e0N2uGHPmHsCorNQVfUOGwZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092377; c=relaxed/simple;
	bh=JE601FTi44ZEME49yAIkCSPX8RMBuTVFyQPr+FCuDbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r4A+HdCZkJTIJ7/so3GGQ2jopftom7js1W30irM5xeXB7ZsML9JjooXZSd9pqFJJbzdTjixSy1lyF6Q5yc2ntwuM/mnEZzsvowV3X6ypVr66A9qNluRoJzV0U8g1E4hqJReOu0s3OOxsPfbzzkC4GH3mDAYP6MWc1nGplKp6vog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=snHcZMxS; arc=fail smtp.client-ip=52.101.229.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A22phJ/4U9gZE+wASlY0GgmF89gbTBuYy+UCaPcRXG7ifbmHTTr4iU9B5V29NHfc+bFVDjYv/1Wu7aybp160ZQiubDcS9juhmUZaP3lyjBEg9DUQ5SD/8dlP6iUYhEMpMjnjZRcOJGahJ5D7ypI17Ylfb9eXpteD+C4a//NpMQdcOO7JU2btTsZn18wqRTD6mvoXHFkegTI3Sy6SfYvu59ap0aliqa0fs1qBRqLDC0pOGtMCHynxNBZ9ZZWOmIwD+1q3LUH8RjvgP/r5gn7GH1N0ucIrx0Qz6zuaT+YzO1NRpocYZv1fzzf0xCS4m6rG+a45Sc14vDiycxqeLnEM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP+ZoWNCv3/OEi+Lpbzk1p3mPGo25KYiihePafmfX5k=;
 b=DpGWx9Q+8yHeIGZdRAzsYcHcwNpl54LxRyJTY/0LKTu5kCflsKZ5jda12oTI1n64tpvGqGXUJ8QzDaVAdRbjuKi2+3lYzQyeWoE2WHFhUttVlm8CzEpOJcAjSThx/Pl6MMCW39tlv3sjctnxmQFf1AOiR0mItn0i2lxHewe5jFsBKNpK0uRhxvvJhju/pCAPK8cVJsRs0kVYiMI9ogLGR5I4A+LJmqzb/X9Yu18NpXvMjrU6SPAAxaQGMaoM+0zZYjLAfl4wSuAg9qj3fKx4CTUXLKx4nxjfoxh62+8ZsQ1Tn5aE8yCRBD+rGAnPsx5Dxaex4FjHU1aEC9Mzf1JZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP+ZoWNCv3/OEi+Lpbzk1p3mPGo25KYiihePafmfX5k=;
 b=snHcZMxSwnKN/A6PptZvvqbjnwkvekBXJkm09xC98LQ/78IXtJHJJYrgC7nbMEgxNEkjG5UV5h63UV2uViczFHVTXXZtl4Knw4d0Bs8R5vXHEFYXZC03ZzOu6J3RzV8GBlJwR/8VDosSzE02VJq31YhxiObIIc0k9Larook1qMg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB14763.jpnprd01.prod.outlook.com (2603:1096:604:39b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 17:39:29 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 17:39:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH v5] pwm: rzg2l-gpt: Reinitialize the cache value in
 rzg2l_gpt_disable()
Thread-Topic: [PATCH v5] pwm: rzg2l-gpt: Reinitialize the cache value in
 rzg2l_gpt_disable()
Thread-Index: AQHcWuvr43PBdjpXekuY3kH0RoltM7UCCfkAgAGkkXA=
Date: Tue, 25 Nov 2025 17:39:29 +0000
Message-ID:
 <TY3PR01MB113469EF7F11612946887BEF586D1A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251121133654.364688-1-biju.das.jz@bp.renesas.com>
 <cl3ggzh4sbounylnasm3hp2l2eusloxbv5uw7wxjwc7u47uobw@n24k6buqchu4>
In-Reply-To: <cl3ggzh4sbounylnasm3hp2l2eusloxbv5uw7wxjwc7u47uobw@n24k6buqchu4>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB14763:EE_
x-ms-office365-filtering-correlation-id: 89c6c5d0-6cf0-4988-b070-08de2c4995ed
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Fyf/VNW5m9qsj+IxdWzWq7sHq1AjohxW1w8GOXsb6xOfMjjy7MiPCFAlr7?=
 =?iso-8859-1?Q?ZB8zdrGdu06Pjr9NESCUUqU53JSJAtptUiw5PpIFf1o9xBT4fQxzBweDmf?=
 =?iso-8859-1?Q?JJWw/QSsUcx5Vu451tt8pFyW+ZopOX0EJvZJSd2BDFWzqIUarld2DTr9Qm?=
 =?iso-8859-1?Q?O4gD+zvLAlXCYcx6sU8kT+mJr6YZZvIfpgOBvikLZF/v5Ms5v7YIJyCHgg?=
 =?iso-8859-1?Q?rV+E+iXHj37j8ccvgSPD1aG346yWMlJZvJXtuiN4WLI2gry3dAEdUlJ1yh?=
 =?iso-8859-1?Q?EnXkVZNM6Avm5+Ps3kbXo8M8y/a3vo+zm+DVkfgGfVhxHOWfU12L+tx9of?=
 =?iso-8859-1?Q?dl9u0udsUfUYlwY6N+fyz/b18rXD9j7IiMDhuCh/hFFh6qDRy5EsGZGW2Z?=
 =?iso-8859-1?Q?PrD5mgZqqnW9Sym+RwCZ3eoX5VYOrU8h0o8MWokcTBFPIOJ8xkN9kh3SWB?=
 =?iso-8859-1?Q?TvVxXMWYcOnQWPi3XPlE/twmsfD7iKTsV91eEa6Tei+mUvnxw/2XzvRU5t?=
 =?iso-8859-1?Q?MA116/Wlb6CN1iYAtqSy+hBcjK5XbfUUH8IgthR4fhmT8tmxcpCeoXD94D?=
 =?iso-8859-1?Q?ZkaMPfhYh+tIK9pANrssPfVXuC2yyf7bibFznzYM2LHjVwMWE/x0By9eaK?=
 =?iso-8859-1?Q?C3GXeGwSvGQuPZ3fvPm8VKLik3bY3xh34ABuwtjOVEOy8M2nyAnJUQbQEF?=
 =?iso-8859-1?Q?aG7u/PDL+/gE/pUscF6geKoO0QWfi7o8syOcbdlozIWve5tzRUtmdtCtAx?=
 =?iso-8859-1?Q?Bt8OykboTe49uSF8w218tpXHDjfKVC8kflJExX/03hiMgKgze2Kvmmp7Sx?=
 =?iso-8859-1?Q?1527vrE9I5djNJescXOdcpqMmro0fGhF2gZRSFenR4GXQkCmgJTzyDcXhA?=
 =?iso-8859-1?Q?7d18NXuKlmxJW1EM9CNpqOHNCWcSm/48UjrVoFSRBhw5P8DtwVwXNd+l0H?=
 =?iso-8859-1?Q?c5Kggoymqtq0b245OF+DIHCSOaPkJsYoDoc8RVvNEKTFxrXr0hDOZRKeNw?=
 =?iso-8859-1?Q?9gIt49Azwv2qhN618bnCFtuWYFu2eaYheA4vC9mFUNRrdHfEGTVd4wpph/?=
 =?iso-8859-1?Q?V1iIEjpRCig7LVAU5XQ2kcjChgnAjl+LjxGtQLwlB5zaxiHcx+OTHAG9iJ?=
 =?iso-8859-1?Q?6v6LQUY4o5FyuXYdSz9+manMBs1eDNTP3AL7vhZC/8ex58WyoCSNg4Vtwd?=
 =?iso-8859-1?Q?Kwm623+bQ8sXjC2IlfUWncBIFilDf70PRj+CzmkObjEt2a+ihbPDyPZGN6?=
 =?iso-8859-1?Q?LHLsn5zNrKNqCU/Grx+szUk2pPbhfhhXIMYZOsMN3QFuYNpSqo9sXe0Zp5?=
 =?iso-8859-1?Q?Wj9tdWIu+yvv/o7RIrn03M0zJYD3OX1XXiIGVUst53JTGyR+FhrLRp5e+0?=
 =?iso-8859-1?Q?+kt8dJbabIejPVeQx4lo2j91bLwbupnM6fKolJxUCYX97YtXKoQOk1R5AZ?=
 =?iso-8859-1?Q?XTpWd6mDdHQQfOU3lJnxu8yPnyN38QP2pMJIerOfXU6JcLpJHSx8ymlfNo?=
 =?iso-8859-1?Q?OKPiOAelYhMeilqk0Z3sKJWWX0JmWcQSZke/lrBfvvj6gcwyaSqmbA+C4+?=
 =?iso-8859-1?Q?PKLEChAGsMCUqdgTwfuCuvxtxy35?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4UJP0oA8Id1DgFPAUUpAf3PHp2T5NgkRwhGnOovGqZGhaGOn5McqBNMZBx?=
 =?iso-8859-1?Q?C4w9kiAl+T/tLy/2C+g45WkgwZbqiBRJaoEgM1MMZFkPtWtsyPS5Py75JQ?=
 =?iso-8859-1?Q?2wRDzdKfdbbhpLkwJRMhYdqMjeF01VQCIhShjzijua4NFabEWBCjOGn0Rg?=
 =?iso-8859-1?Q?SzS9SudAyzJdnrUEt4Jwb7JIEcWhK0YFiHVTcHM6m4oFyldDxx/QYTHKjS?=
 =?iso-8859-1?Q?Eplb9pMz+QIFYbexh9yT41qUcdpRB0DlGHL5s5zql756gw8TJuoPrTSRTZ?=
 =?iso-8859-1?Q?9DFWgF9iyU+921Ds8FG6lfzJNxk3lUiqNZfCsNZXjrHil28OpzStfZ7Mho?=
 =?iso-8859-1?Q?B8nAFdqfqx30cnctj7zBEM+3ksW/CZajfaZHUBCYopCaMc0BHa1lVP/7gb?=
 =?iso-8859-1?Q?WS5dXXw/Yx5NU4YtJoGGOmFKHNDbwc9AnwP+fMVzT6eAD49X1y5EZHBGIu?=
 =?iso-8859-1?Q?G6OLUUw45ZBGNqqtTORSI6c8GhyTfD+SNWhO0Pu9d58FufjQJhoA5on6y9?=
 =?iso-8859-1?Q?iYxZpgaazfgIsrwIK+1RcfGe4jOLetP5Ir+4ZL+luqTCZuPhVHE/Mzefjz?=
 =?iso-8859-1?Q?GqkWvwj1jHweWSmOQb09AM5oRuFbihSXxmnixb8xPhX/9LuLXXdaBJcVGU?=
 =?iso-8859-1?Q?s9gzMaF0Q/EqeSCy/qKWQ5ICBRieNt/Cr2PKElCAnatJwGs3sixDToCvKj?=
 =?iso-8859-1?Q?OhICtR+VtauhBKaF8XqC3EaMRdcg/4ROy/VAeqzG7vzAsOtxnji4PrnKPI?=
 =?iso-8859-1?Q?+LXQ/0+dub0zQZ8U6dxxABynzVJGtzqIjetgszEJlbcXRI/rgjyr0J8O5N?=
 =?iso-8859-1?Q?J7nthcQv3fV/6phH8Axjghr3lk4+tTU9q2i4XciAROKgIAPHUfRg6S9ALc?=
 =?iso-8859-1?Q?iORO9fGtoT9JqkT6Z5seCIOEYr1axP0NUalAycQNNnIJWfuB/3HwRLhmGG?=
 =?iso-8859-1?Q?T7H0+nplZc6e9BlC6mWbK81Q51dL1uicmxUPgfWJ7T4gO0LqGIBWfsL9vZ?=
 =?iso-8859-1?Q?CS6naLflbra927jOpwhkOAPOus6imWb8QDDmS9oGyMKiFAfpdhem51pFZX?=
 =?iso-8859-1?Q?WCKzq9JQ6LRDVMBi10HqQ6OD/hn0fg+GxwjsylOnFRM6EcKQHK+bsX6tyj?=
 =?iso-8859-1?Q?xYMhe/cPM8e+/b+enDvLzDhIhpn//iVLP/STLFjl4rx93OK+FLDKhM6UX5?=
 =?iso-8859-1?Q?wK8a30RAKDACFkQWsMR4CM6egtJV2HrKTS2q02hmhLLhfO7rmjgewyxwic?=
 =?iso-8859-1?Q?dosSIk6y/EYP3Jm+PTuC/TsMiLqU4Ix2DbJmRWm6g/zxOucxngBeLuv3nO?=
 =?iso-8859-1?Q?leCptmJcSDCQQWarKM1RxL4sTjx2y2gycl1OFMTEHkqWmHjT3IkFxDqi29?=
 =?iso-8859-1?Q?/bkIS6vdO6PAouCjAiPTuKkLQJkYIpKyuuMFp4YwG8E9KgY4nq1EpEJ/K4?=
 =?iso-8859-1?Q?ytIUDP0OTYfmZIApwCE+VlCw2mmmKezQaTY3vGgXMB4lEkJ1Xk4Ilg4gHs?=
 =?iso-8859-1?Q?Y96iUkfKj4+0ztV+wc0a3TrL7h1c4dehfxh3Exi5Se7Y+lwUvVqZpDtw2l?=
 =?iso-8859-1?Q?6nT3Mm5eo1vByqldTd6G0ozT5cd2zLAtvyjZgd92QwWzbgiDRv4KPGqglq?=
 =?iso-8859-1?Q?HDdCIzK9iHoNOkybD3QrCUWY26hQmtd6EGWkIDQBNQTCpkxS9uYLeS6g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c6c5d0-6cf0-4988-b070-08de2c4995ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 17:39:29.2743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqVLY4V4DxyyPAmj9hcLBLgVUQUvbva82Fj6l8vG1q3UXsX2KTknNE+hLu92a/SPU1mEdfH9nkMuj5SsUcUsOjazxxFVkTUxFRclBYDCixg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14763

Hello Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 24 November 2025 16:32
> Subject: Re: [PATCH v5] pwm: rzg2l-gpt: Reinitialize the cache value in r=
zg2l_gpt_disable()
>=20
> Hello Biju,
>=20
> On Fri, Nov 21, 2025 at 01:36:51PM +0000, Biju wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > The rzg2l_gpt_config() test the rzg2l_gpt->period_tick variable. This
> > check is not valid, if enabling of a channel happens after disabling
> > all the channels as it test against the cached value. Therefore,
> > reinitialize the variable rzg2l_gpt->period_tick to 0 in
> > rzg2l_gpt_disable(), when all the logical channels of a hardware
> > channel is disabled, and also don't allow to set the cached value in
> > rzg2l_gpt_config(), if the other channel is not enabled.
> >
> > Cc: stable@kernel.org
> > Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v4->v5:
> >  * Updated commit description and code comment to give more details on =
why
> >    reinitialising the cached value to zero
> >  * Added a check in rzg2l_gpt_config(), to prevent setting the cached v=
alue, if
> >    the other channel is not enabled.
> > v3->v4:
> >  * Split the patch as separate from [1] for easy merging.
> >  * Updated commit description
> >  * Added comments about the fix in rzg2l_gpt_disable()
> > v3:
> >  * New patch
> >
> > [1]
> > https://lore.kernel.org/all/20250915163637.3572-1-biju.das.jz@bp.renes
> > as.com/#t
> > ---
> >  drivers/pwm/pwm-rzg2l-gpt.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > index 360c8bf3b190..38ad03ded9ce 100644
> > --- a/drivers/pwm/pwm-rzg2l-gpt.c
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -190,8 +190,17 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chi=
p *rzg2l_gpt,
> >  	/* Stop count, Output low on GTIOCx pin when counting stops */
> >  	rzg2l_gpt->channel_enable_count[ch]--;
> >
> > -	if (!rzg2l_gpt->channel_enable_count[ch])
> > +	if (!rzg2l_gpt->channel_enable_count[ch]) {
> >  		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
> > +		/*
> > +		 * The rzg2l_gpt_config() test the rzg2l_gpt->period_tick
> > +		 * variable. This check is not valid, if enabling of a channel
> > +		 * happens after disabling all the channels as it test against
> > +		 * the cached value. Therefore, reinitialize the variable
> > +		 * rzg2l_gpt->period_tick to 0.
> > +		 */
> > +		rzg2l_gpt->period_ticks[ch] =3D 0;
> > +	}
> >
> >  	/* Disable pin output */
> >  	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch),
> > RZG2L_GTIOR_OxE(sub_ch), 0); @@ -271,10 +280,14 @@ static int rzg2l_gpt=
_config(struct pwm_chip
> *chip, struct pwm_device *pwm,
> >  	 * in use with different settings.
> >  	 */
> >  	if (rzg2l_gpt->channel_request_count[ch] > 1) {
> > -		if (period_ticks < rzg2l_gpt->period_ticks[ch])
> > -			return -EBUSY;
> > -		else
> > -			period_ticks =3D rzg2l_gpt->period_ticks[ch];
> > +		u8 other_sub_ch =3D sub_ch ? (pwm->hwpwm - 1) : (pwm->hwpwm + 1);
>=20
> I think this is the same as the simpler
>=20
> 	u8 other_sub_ch =3D pwm->hwpwm ^ 1;

OK.

>=20
> which might not be too magic when put in an inline function next to rzg2l=
_gpt_subchannel().

Will add inline function rzg2l_gpt_other_subchannel().

>=20
> > +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, other_sub_ch)) {
> > +			if (period_ticks < rzg2l_gpt->period_ticks[ch])
> > +				return -EBUSY;
> > +			else
> > +				period_ticks =3D rzg2l_gpt->period_ticks[ch];
>=20
> Do you need to set rzg2l_gpt->period_ticks[ch] to zero in the disable fun=
ction given that it's only
> used if the other channel is enabled?

It is not required. I will drop it and update the commit header and descrip=
tion.

Cheers,
Biju


