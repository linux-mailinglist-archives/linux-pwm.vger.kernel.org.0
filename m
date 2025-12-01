Return-Path: <linux-pwm+bounces-7742-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79617C96C56
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Dec 2025 11:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 089C64E131C
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Dec 2025 10:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E3C3054EF;
	Mon,  1 Dec 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wNthI5Kc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010064.outbound.protection.outlook.com [52.101.229.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D0304BD4;
	Mon,  1 Dec 2025 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764586634; cv=fail; b=GLUCuF60R8gKH0cLZsEZDxlVRD6iN5TIqodjycO3C3nvQjHHpqXHM0xEhmXGwpM4oVw6WJa8TQVpnm0Pp8nb0LJbA2qJkxm2mARiwvRqn7dGv0yxyJZhK5B2f7uCsMOweL1xoV/fDejQHhWvhu1QD5W4OoWt58sdEZBbs9JDBP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764586634; c=relaxed/simple;
	bh=eSfMWsu2uDkdiOuVL1MQ6x/FNBwZ9LSQr2HUOBzthWg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bipzkxaXSHEqO27cVJ8gw0qmtvHHqGrIYpFPF7I734Cx3WpNwZUB0Zgd4QqsG0bPiWEyZWRKM70ffVDtGFZWrZt+FjlEs5xgLRfVubz+YbJS2GA44q9pdDgk/2KU/0T0VyiehwOjPNgqll7Diq/2Hiyv6wJtid9vHbqiRUjt2dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wNthI5Kc; arc=fail smtp.client-ip=52.101.229.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBfY/gC0BmaCO78axZU6lxXDMDBRujlDBse3JgWrvVUQcqbULwIORM8b/PaJ7Ck/BOXzB0s2NNJIrOfDBb6Tf/E9ENLYfj2S8etGixO4u7HERn+7FdWUsDv/oXgcWHRAR14mOU7ktfLYFX8AO5+/mWdDI4EeUSlj31VSBgy8TQcwjxcLvp0ybD+wJqKVSIY0xnXGr7H4x2FyBxwtOK05RRT2xfQu2cP2D+hebzdA80c+cScLNEiAZAf93DIwncnFFZ7A8rK9AqHKiiphT8aIVc7nRYrUwU4sMh39pgJuuuY75g573W2e/IR/WtsAhR7pBeSlcB/qHsoWSXvGjkoHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5SGIoJWS7Ra69C5aZldII9mkVMlr66IxCmZVgZ4fv4=;
 b=LJODxnopNJirk6UqgbkyDXt6KiLYGY1dG/yjGsFVarDx7DJH+65aA71vtQjQvAwlUzVz4wlNAHAF81FTXihk3MKmmRJ6TPsHXBPjaHLDo+N8zTQhMpgTgtgUlkLbpSgTqBCGL5hg9pbfm+EFNynWNSn2u5m839shBPrEm5GomzabaW86YyTHmU4hR/e3MB8cKf/tAdIKuPM6Z1fbXhoJpADm4UAx1ZP4hTT7tysWu9JJv+GyhtnheHgPXyu5TWqMS14T9qitEcHYCq//JPYQMza3BcmO3OzHDHKl5XRhs5df5VRIw8FpPcVf1k0WUhA+W6e/yOgc1g9tfEqtG65o2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5SGIoJWS7Ra69C5aZldII9mkVMlr66IxCmZVgZ4fv4=;
 b=wNthI5KcZ/foXmjHe7OJaAK2vbrwo2YCiH4ckEHrE6BNSlINv0hzB1TRYEeLCRyFH5pjk9K0GxlI3ab3PY3O85Nzja6C4sp0KT9vF6svJCqeyt09NTsQdOqNTXio6GJMZDw1IkKQSBYkm0hk4dayLqorqlWV+nOT7oVa2LgDrME=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB13485.jpnprd01.prod.outlook.com (2603:1096:405:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 1 Dec
 2025 10:57:09 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9388.003; Mon, 1 Dec 2025
 10:57:09 +0000
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
Subject: RE: [PATCH v3 3/8] pwm: rzg2l-gpt: Add
 prescale_pow_of_two_mult_factor variable to struct rzg2l_gpt_info
Thread-Topic: [PATCH v3 3/8] pwm: rzg2l-gpt: Add
 prescale_pow_of_two_mult_factor variable to struct rzg2l_gpt_info
Thread-Index: AQHcLJi4Z1b4DMK8BUW9O8pbw00iVrULTZWAgAG7hPA=
Date: Mon, 1 Dec 2025 10:57:09 +0000
Message-ID:
 <TY3PR01MB11346923E317A16B00DFA1DEB86DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-4-biju.das.jz@bp.renesas.com>
 <yvqxc75orn7t4iew3l74yesuclphcx7lfm7omyrid7gm2eq6ks@ulg5tcx75hyo>
In-Reply-To: <yvqxc75orn7t4iew3l74yesuclphcx7lfm7omyrid7gm2eq6ks@ulg5tcx75hyo>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB13485:EE_
x-ms-office365-filtering-correlation-id: dc20cd77-75b5-48d7-0231-08de30c85fe4
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?fu85OufhtClVYTHHObCDJZxp8gA1hMTDk0vMwuslflQ+I9+Dn19Y9tcrgB?=
 =?iso-8859-1?Q?FTzmmUQvMA36ibwocPFdfkLlPrE5jtzFZIdaR66NpTB5jZtPy9tmlbC/G+?=
 =?iso-8859-1?Q?GuQNB++fMRViaWHLm/zBgYO11LqQT5kkbFKRQD6jt5BOQljTz4YUloUYm1?=
 =?iso-8859-1?Q?LUXldb4q0T2InQ+mo85dAwBJat7F4V6RPv/j7f66DEC4uqP4Be45C80FHq?=
 =?iso-8859-1?Q?u3+CVaUpj/9maiKuiPrQ6N1pKAagZ+CEpuy/hZPtqwMk4eqPqOTDSHLFBA?=
 =?iso-8859-1?Q?/fpl675I5jkfc3EERt7cbKP+Pq+5s/QbFpzVmIJ+tihXbim2oTNS1vFV5I?=
 =?iso-8859-1?Q?sxw6GPvY5wrXJ+QbUwlszPwwbh3CtUkcVThWCtcHwOzFoN4AACsb/XsIY+?=
 =?iso-8859-1?Q?rAsEhm2fzgKnTdUoNJxUSI6Xg9i2K7zDieXdNoCTwiTYout/X+WNJ0fcMb?=
 =?iso-8859-1?Q?OOxndnV5vVkZo19OquPaioyRhD50pkWs0bMfLWz2EQqqeQEkSzV7ypAd0X?=
 =?iso-8859-1?Q?afT0BpFiPoBiS9se3srXqlCL9Zxa74pYCW3mLLbM1IPksY0JuwrAqhdRUA?=
 =?iso-8859-1?Q?Iy7v5b47zK+yNGmUJCNEVm23rOhoP0duLuqyKuwFt22fbXe0oF68lVEZCT?=
 =?iso-8859-1?Q?5aUvJoD33J8tJt0qHneIi5/BdaAiJkulknj/NO/78/x0OXmvLfKxeZieUY?=
 =?iso-8859-1?Q?87ML0LKk6mNQU1LBagCrf9FcN2SWyJb7mFMaZsQ9uJ9KaDgWzUpncQxnbK?=
 =?iso-8859-1?Q?YTiC5ClRUShTaAjtY9Y9AFKRb1wsy3V5V0RDIA58g5xonYUzJKdZeRN3pP?=
 =?iso-8859-1?Q?uHbGWlB1jjhfCRz803O3ZRV0qh7KnIn45c5b0znw6m0iG8XzmnwgaUlyZI?=
 =?iso-8859-1?Q?I+uKi8uFZCMTyjgeHby8JGIk4CJa3YXtUs9kt0/FJXRpt/nM1WJQ1W7pPv?=
 =?iso-8859-1?Q?IOPEZpkl5vltxFGw9bFA1WD/PcPRWuDvBTIj2nVXxwxYPHJjNpKXL7nF/N?=
 =?iso-8859-1?Q?ccmuy9QxW2v+rTdIZ0J6GQ2X5RjQrsuQozm14XWx/XuZB4Ip950bWetaV7?=
 =?iso-8859-1?Q?mWLu0zTrhDJPb5HzdiGn2vQRG9jYBsHINPp1j0WPSFsW2raLfjrkpZ5BSZ?=
 =?iso-8859-1?Q?Z5QRUJ4dQjWqqyCSja/IctYmTDz7NcZtki+fNOMb6s5m/gas9ud6eSCMPc?=
 =?iso-8859-1?Q?wr5hHQ+PprElzOSU3c4I6+J5mdxHFSoXi4cl/kJGphvWN3BdWtE2GAdA1H?=
 =?iso-8859-1?Q?veIWlmcHIsu4FpF0n5TbJTt57WdW88LapchadL3rM8HcQOtPcmXSHA3Huu?=
 =?iso-8859-1?Q?KwdlE198phUww2KcrQUqyjjZiYPFvYI2BUanhVvNlNfEkt9cJwtD5YJnaO?=
 =?iso-8859-1?Q?HQA2azcIR4U7p3wzfy8x8ztO0b6+uY8n43/8gR74XIk/rJoOPEucs0efzX?=
 =?iso-8859-1?Q?X9Nj47kOgvop+9uicU51AE33oPvckAyYp8lk3WUdVMEJci/dFXs1ETv27R?=
 =?iso-8859-1?Q?91Ua6YGiwzTehmlvlx44EY8zwhzJ97WxYS0zvrLAt5wXqSieEeDef9DvtR?=
 =?iso-8859-1?Q?hbYe8qEYJay9HnZt6NJ1LhYdWd1o?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?x3RRln6RLvG0JBM4MBSPJ6xD3ZxpyY+yjQE6LKU0ylypvfO8F0wa1/s3V3?=
 =?iso-8859-1?Q?VgCp8OBOTScHgIETzrVD5AAQimQ7mKoTZAXQFKvK82wyBycRXhjmiK624k?=
 =?iso-8859-1?Q?9aW0AyjLG6fvCvQMRUCEmPuwRg/RVEKPJDIfe+43kms0WGZeXI75gRsign?=
 =?iso-8859-1?Q?8K/Y+wIps1onQN0oXbqyHovQR8VZm5/dlgSAmK7SxziJxc9yFYFvkmOTUC?=
 =?iso-8859-1?Q?WvnioKSm7dwl09XTdWQIvfbdCYvOtabxp9Ee7LeZ9wSVs287vl/+Ur0K4P?=
 =?iso-8859-1?Q?4zN3zGWSb+Ws2BSG8lTUf8ScA2VmUycnGW4XDddd8eVLrnECI/rw+TPWof?=
 =?iso-8859-1?Q?VPlZPJF3eLSk1o7VUcJ28Ed8ieORnSdzeLVLwwS9ezF+QJzbSg9Hp4fPCA?=
 =?iso-8859-1?Q?LEFVstcsoka0GFE8zGyzdJTcVxO7gbsf8lInZ7DY4YO7ktsI0aY75fJjN1?=
 =?iso-8859-1?Q?z4xfN9s06fS6ZZyTT6W7Hu7Pzng4MsFrIB97CCFxAix29ghNl4pmIIYEvV?=
 =?iso-8859-1?Q?5nNmfiYAUD7/MtgWg+Nfdt/ViQkKUNBVOYQCcgW25ite9dk5DaKqO4owQ8?=
 =?iso-8859-1?Q?LQW+f58iONtc3nVn3uPju5IZW/HMHEq0wyzr8WGDniKLiwE/QShHmVhlHP?=
 =?iso-8859-1?Q?mMM6Wjk/lULxC8+gRsD68neeSxJZRrzngiT3A071oxDpwxB7Gd36uZlR1m?=
 =?iso-8859-1?Q?PN6FKPYJiLcNN4KuJd9Z/Tr6f2V2Q1ut8h/m1z7+DRUiXvKR/PL/GJ0oqW?=
 =?iso-8859-1?Q?EGYNlIOhMKL4GtUz2r8XJ8KDH3upUgLuAFSRwytqz67zJSu5tfDsDznFTb?=
 =?iso-8859-1?Q?+jP001X6pXmuM4yMPJ1moumfU6n6Ms/FntAeHyWpWYNc5v26wUycnkYXaV?=
 =?iso-8859-1?Q?spTmV/pmKeJaewQfj8vxxSHESXHFrrFY8U9btj+NV3wP3HGoEKE06d+DNi?=
 =?iso-8859-1?Q?vOLjVHeI0pZ5eFm9chLMKs46yzBy1tfbWTEqzkS3JgHZTLzhYaNMBnk2ot?=
 =?iso-8859-1?Q?nJ4298kiP2mqPxbL8XrFagpmQ8S81Oe0Rd4nQyJ0BFYBvNVe37oRiBvQOS?=
 =?iso-8859-1?Q?dZOSWei3xPeLf8bcIIciQscUQw/5xbyCgFayshqaexeJmqJeE4u89RDiyH?=
 =?iso-8859-1?Q?KUQ49uDKwvHaf5Gjp38quAUFvOtz6NMC8PmXj1su5myHu19/oVqwCB6dPJ?=
 =?iso-8859-1?Q?FDcu3MVnmHaCViUymfCBfwAVuAV51BYq7xzAeCGQcgRe+xrxqBLI5IEGz9?=
 =?iso-8859-1?Q?57LhbVeipJ2amF6ZzFttK39wBIJoIl6rE7ss2K4RpxuqdjP62HWNXZlZFk?=
 =?iso-8859-1?Q?DqA5M2GbzXJEkd8K+F1he4Ugb0jDJ8nQikuN3oxagiMablGY4AXBtFYpLy?=
 =?iso-8859-1?Q?9c4RusaTETyGxWjbzeciOgtwc7f57t68A22basc3znPDTosc+Qp/POpvUw?=
 =?iso-8859-1?Q?JM4FnTWSovpd4niVy6Bkh89GzlLxQlqbBYTbbHK9P6rmb7NMi3zBfTJiBq?=
 =?iso-8859-1?Q?HcoxTobdIcbQViLwxHBPN5VpVBR7IZqGSv/EMPeujq1z7QK3u3hNHS9rwH?=
 =?iso-8859-1?Q?fB6zWIhCZ2B+PKeVRVmJoByuR6SngkNB1dn8Eivn5awHEh4Xx62wFLhVvq?=
 =?iso-8859-1?Q?dzixrziF8YBzaEFv0abLoPpduCGDl+eo8NnwJkjFt3m2ENY+eBc12tdA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dc20cd77-75b5-48d7-0231-08de30c85fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 10:57:09.3196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuGkzKXOoNjn1xm4J38zCrCl4QhbBGADcyTnYcoiiSbm5IIqF/a1SBWjeELdVZ4A51/CUo9cdyxwSVBaKz+92PCrYxAFSOJj7EW5BlPAs10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13485

Hello Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 30 November 2025 08:29
> Subject: Re: [PATCH v3 3/8] pwm: rzg2l-gpt: Add prescale_pow_of_two_mult_=
factor variable to struct
> rzg2l_gpt_info
>=20
> Hello Biju,
>=20
> On Tue, Sep 23, 2025 at 03:45:07PM +0100, Biju wrote:
> > @@ -91,6 +91,7 @@
> >
> >  struct rzg2l_gpt_info {
> >  	u32 gtcr_tpcs_mask;
> > +	u8 prescale_pow_of_two_mult_factor;
>=20
> To reduce the line length a bit I suggest to call this just "prescale_mul=
t". That this is (up to
> now :-) a power of two isn't relevant enough to be mentioned in the name.
>=20
> Otherwise looks fine.

OK, will change it to "prescale_mult".

Cheers,
Biju

