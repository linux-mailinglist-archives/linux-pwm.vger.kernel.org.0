Return-Path: <linux-pwm+bounces-7749-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF04C981B5
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Dec 2025 16:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234DD3A4838
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Dec 2025 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D4E333437;
	Mon,  1 Dec 2025 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="rQMHQYfE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010065.outbound.protection.outlook.com [52.101.229.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44440333421;
	Mon,  1 Dec 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604216; cv=fail; b=s9mbRxu0UF8zokCvj7qZjvqMLqoQGde4iyDCiyxCgqR4yfTmOuyLF9itaEZKg6J9THCcCthvOskVZhEzHqAyrFQJQv564QJ1dtkcARw1jc2RdC/Q+aJQTDMJITJjvIsPhKVquW125YhjQFO9Zx9uMnjKy97XsI4psl5+0FNDcGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604216; c=relaxed/simple;
	bh=+wmEEnFHxKfHoUHbL7pD9kf96JmxLPdgoBHRDvN3mKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YVdr3EhqVq+SV7EsX8tMWw7rEZhWA9/cMtsV5uM0NEoga3/UT+De/i1wLzNXp+JgOEba0twki/lk7gvgtqi9Q3Gymq8Mo9R6HDQ1xpxjPmgtLs+JNbHqO26FX0tPMvXEtWS5htXyk1Ja3UQPRTbuomg+3fKgZpRb7Xugokx69+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=rQMHQYfE; arc=fail smtp.client-ip=52.101.229.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzY683wXXs04QuET94OreD6lalx7DNB37yfhB7COsXXo30SFleOOElrUaRJsA3e2YQ/y/bcCMi4sSibCsFQqZ+IZWT+Xdl0OnQrQ2sPjDaM360PHxY9YfhYXWkQjO7QSU9gDKa/Zhi00QSoCX0o9v1U1ZMX8PcT/hW3nMtkMaTOJBuDgjpISuwW+CyDYmtF1IW7VpqmJnZvc8L6vq3DIyacALQkB5gUyr9cAFJ425KfkOGwSu0F3maUQnmjtQfXnImhqs7PC4TuQc+cZxOwdYl2eyRmSx7LBe8NYDt2mapVdXu5RM93WIXx3A8c6VyKzZ7Ub2KWwrNlGQ6FSRaOWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQWW1MZEihfA1kWIpjo12kyt8nLFnCXKZrM0bGCmKW8=;
 b=mW4ZYJ0uAG6RtCSONdZlf5tCTQo5SbGkcEKk+AUGszNJI+lwnKsdTxJX5HZcJ7A9sXrLu7HpFmjN3Teca/EGpbGC5+yejR80FH0r9j8+HhPaGik1vWMlN1R4TEGr9vWcbEyPhkIKsMJ68tuXqgIQFqRWDgsy4FLdVmf7QfS7kNcC0XI9hkbeBGy+hpqzZEVpcLZPZr41Vnesct/TddF1C8u+01CTWuhEnOmMTaXpe7jF2Vxd1ehSnPBCa5WzR7e7sFhwkvqE6R1cObiQUjeZsUJhDpf3WNODNhlfparVjY5DeW750Lxnc8qQNrcj3/BZSUUxqySHS124uGIQ9vCzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQWW1MZEihfA1kWIpjo12kyt8nLFnCXKZrM0bGCmKW8=;
 b=rQMHQYfE9xbfpoNWBFXQ7zEmPNRWmyQXVIOYCE8rQVwKNZwqATPhhyizvbXoFCZd0Udo2x8A1kbH7QK4vaPDYvOKtYQ0cQmKa/3g6P1CYu8Fxotu9bGZyjlEFJ78flh9hOvPuiaxEnKUoPOBUP0w+xTpfBdx7ShPaqdJd/bAFzE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB9750.jpnprd01.prod.outlook.com (2603:1096:400:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 1 Dec
 2025 15:50:09 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9388.003; Mon, 1 Dec 2025
 15:50:09 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: biju.das.au <biju.das.au@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
Thread-Topic: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
Thread-Index:
 AQHcLJi5Wq0nvzczj0CSEUAgjJVVOrULUGQAgAG46lCAADdsgIAABTVAgAAHJmCAAAglAIAABKSw
Date: Mon, 1 Dec 2025 15:50:09 +0000
Message-ID:
 <TY3PR01MB11346F105FD6CCE1167F9095686DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-7-biju.das.jz@bp.renesas.com>
 <wah57av7ypb42zcaosx7n64j6qmmcq5ylhgnde2brbiy6o7sun@7rqkr6ke3g5k>
 <TY3PR01MB1134692D7D9F5B67116D2BC7786DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <pilx2etxezmr6rhbwculwjqcxotzkxus5bqdpjrt5na5c7fqhj@mdfm2yh2aptp>
 <TY3PR01MB11346DE28875EFD9B9D86DE5186DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113464F283A3ED4A8AAC813D886DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ydqyvme43ul6ui7bl37kv3kuhn7js7tvkje2u4a3vasiw4kgdv@w2govkhaa3xz>
In-Reply-To: <ydqyvme43ul6ui7bl37kv3kuhn7js7tvkje2u4a3vasiw4kgdv@w2govkhaa3xz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB9750:EE_
x-ms-office365-filtering-correlation-id: 680189f1-548a-42fa-6b92-08de30f14e81
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9Wr6EPQOfTl+q99S85ulIlYqfiT9LFoM2+JlcmqrmyMePAiYJZ0EodZmvm?=
 =?iso-8859-1?Q?0ruDZ1CrJUILyTEOifI+IrNIvxZMKIy2cVH45cXriV10JRlgpDJgq0zLuM?=
 =?iso-8859-1?Q?BzjBG/U5a+SgxPV05f84qypSu2m3MCvqP24vvovf+NEPtjO2BivnOij8TE?=
 =?iso-8859-1?Q?Nw6d/TGJ/bzPT1fuBYWLwzWWXEjQxGfYDaFA7rI8eIEoJ+Hk24HQatBJLq?=
 =?iso-8859-1?Q?+jxTsYLQnshvO+MjwODKppoYu76ZFfzn79pv8Epk49fM0i45sDZwoGt/il?=
 =?iso-8859-1?Q?L3tBHJtVDMM0RE/D4M6m9DdQeLkthVfK0oy7UervJTFZSFjMpGol47AknU?=
 =?iso-8859-1?Q?AtqcpX1lO6hfz7rudd3iJI+YWYw0r3ZiCNi64rpwf5pYJMWiuchldC4OaI?=
 =?iso-8859-1?Q?zrB7wcQTZGoh0ctsfb8vSwAj9PJaasTmhNObs88UXGYKOf3MHxKHkfcgWz?=
 =?iso-8859-1?Q?ZBeJcfljnsBTNFvI/7Sijhsa2ULHuc9EwT3txv7E7m2o9EoQV6E/qBQZBa?=
 =?iso-8859-1?Q?E8lxSWJF70nTKsUYPEbHelzAVi8taV/vllGTjzDQClA0cbXBBTsbCdfaGN?=
 =?iso-8859-1?Q?3bbN5lc7FDUE3mcq7JETMyGjPBQ7n0fSNDhW5i99a0nybjlGz/rc6M2yKP?=
 =?iso-8859-1?Q?kJnbLIHfdBAcJhDa6qpAoYS4eMGhjqe3PEMCFBDtqrALInZYEUWU+o6voG?=
 =?iso-8859-1?Q?QuQq0e9y4OidhOCGZ/pXL0pVRA6UrG/1JoDXUyz+HRzBjlpWfLVlr28i5O?=
 =?iso-8859-1?Q?wW3GuP4ft0FMC9GUjHvcsV4o6Tv7RgT/BopcF6BiSSrtoQtmmT56h5ZC4I?=
 =?iso-8859-1?Q?9no2kUvOz/taivZRtnkQMClqaHkRew/393Ob9JCcZmKoHcWTLR/PWbw2Yi?=
 =?iso-8859-1?Q?tSnZ3omNhLMhAK32tCXmT4zeOcmydtnsla8tBjOyjNwi6pFi2/7EgkPXa/?=
 =?iso-8859-1?Q?7eAcThYk4hBI7faXq6NF7bNZAHG5tQWp27jLZKb33cx0hZnV9NaIPDFymB?=
 =?iso-8859-1?Q?qieVYBYVP93O9ShvfjiXsPT/EUKSMf3AWX3Z+HXPm55j9w50BNWp4G9L1z?=
 =?iso-8859-1?Q?N1G0ogapz+kqexLZLQXd0DX48aEDzJGB13qy+gdj94+DwLHgbnHLoNSfco?=
 =?iso-8859-1?Q?26wdQICeQGgsOq40ZzY1cIeqpX2b4JaCsOnVAayKn2Svd8F5gr+etekFqT?=
 =?iso-8859-1?Q?AvON1rnpem2Ar0olopq4tmBRRKQ4g5FArH3xGquwEy1pzGJjUje4vGK9B2?=
 =?iso-8859-1?Q?NkWDU3Tt72lQfuqZPpSnETR0xG+fGXauVKUKQKgzZL7wySk6TDCI+mD3si?=
 =?iso-8859-1?Q?Cdbn3cgxJ5ePv7RXfzQD9WszHoJEhSAdYTOh4CkcL4ukxLhd/dmikqMe7C?=
 =?iso-8859-1?Q?OisrLp3izL/QhU9SisG9ffU8SU4/tkbCLZWGz3vpSR9rS3RKVnNwb1/Hns?=
 =?iso-8859-1?Q?7vJt5QpDNLfeyuqgBzRoEh1q30AWr8QS28+T1bdj25eSJNdZa7n5TzxzcW?=
 =?iso-8859-1?Q?TNXYzo6bUWMaWuCw+S3ezXmawv0KTBsnwet4ZkBSYCiOEfVcX63DMNCSmX?=
 =?iso-8859-1?Q?3op0wgAbVkSpq0Sj5FpVFA66FG31?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?A+iXKOa4kREms334VGoVpY4bvWicU+vslmoD3Fr2SngULj1g3Z95JirUV7?=
 =?iso-8859-1?Q?HNcewhLWAGLxDwdSzXoy2xTAGVwWDXgUriWCdKBUCWWPsHSn29byTzyk4v?=
 =?iso-8859-1?Q?TFBZYztX0b3k7XjNqyTT/2wvOFNcatCpmOAXV2ddPCRrkRvzQyb0NxjB1S?=
 =?iso-8859-1?Q?izJTFDUhjsM1PWz5G6g8v5p44cIhgnKklyYvPac1UyjOoaTN8C0vXOvd6c?=
 =?iso-8859-1?Q?8Ew1uYg0/oVpYdaTAwDc8mp4qhE3fufWBHAqZfYCAUfmcMARvxQ/OditLE?=
 =?iso-8859-1?Q?Ds5NBNXRllS5w+wmtNs8my7++KJPsbkbl3hJvBcmIn47F6dgIS+5ejIBWz?=
 =?iso-8859-1?Q?ja7Hp3TAsGWBjLuEwld8X1sntf9Gl52Aoq/oBeThC+mitRisZR6YEplxfi?=
 =?iso-8859-1?Q?CfrH3Us6fUO/77ZlU2lF5YCi9OCVHOK/l6Bw6LlZ908ROsEGIV++0raTz+?=
 =?iso-8859-1?Q?DJs2Tuh70151Ls3dwZ7aHwIGo2efStKPa/Zl9blf7y+FcjV+eD/SCa31zs?=
 =?iso-8859-1?Q?yHK+mVqcYGeQhoz9JGPRNxhdo9T8ETSLaTZ6w0SHrIWPaCPRR85qKOkULL?=
 =?iso-8859-1?Q?qp9IbvtUn+Wy5n2vHqcvmBqHMt5poyafwEXj0rwT6kdBGfj3e4+B2ryAdZ?=
 =?iso-8859-1?Q?OPwCDoSHyoYlRFKRpNZLpzfB8yfXxz7kGf2taXcB3dbe5H/xQcgPEA7jqE?=
 =?iso-8859-1?Q?Ga9bT93sqVaunxxRHtsOcbBct2x0JkB0OACACyTXmvdw/6fmmFMOAEP3XD?=
 =?iso-8859-1?Q?dtnCIihFldO5dA0c7YDWjVfQdhGHiRvRTmiplyRALzZ2LAVGxBlmD+xKRE?=
 =?iso-8859-1?Q?e5Q4yPHPJun0nvhFDMOqiFEBgjchNGfoLVD6fHq6n2CzbYEEnHVjMJq018?=
 =?iso-8859-1?Q?zgVSmQ8DZewnoQv+ki8OWvWWH40yUVSt4CBjq5QBbQBZhQU+ANUlBISxSX?=
 =?iso-8859-1?Q?8+awWG92dT2jsQGgwkOjiss2Y/QGMOy5O3Nr9DbQYS6+Dq+JuFhobv5DCL?=
 =?iso-8859-1?Q?ZJfWk8dowButafAcnGtPXi7rrFVyNuaxrDCHoRMPFweiezgrH+lwuNI2Gp?=
 =?iso-8859-1?Q?rgDc448w5isOxmxClxhlsCz3xgsdKjSQxbeFNp9vohodNhjrcFhkYVjrUx?=
 =?iso-8859-1?Q?frKL51KOOLqyY6540Du+9xx/S7kwKWKCjsjHy/suAIh9FCI8ppLUFrPkb7?=
 =?iso-8859-1?Q?lRIsnZt5fHpXySXpzZv2wf1UXbNWRkntGuATU3zUiHYyVPGu0tUEOHMoTM?=
 =?iso-8859-1?Q?6Gf5rxMiM/VtTjlAS4WROyYcrO3TN3CzPxFb8RyH660XnNgmrxe76L186m?=
 =?iso-8859-1?Q?a5+KMQQfZnn6r0K961WS1/qZvmxkoFTN5hgMjYV/OrIDYWz/usNcLNgPoX?=
 =?iso-8859-1?Q?GmWGlBqOyuCfFd168eJnaprBHP994CuGbMR1jz10tYxEghp6rAiI92QMJL?=
 =?iso-8859-1?Q?7Wtp3r4pLjc7iLyinyx1PWaOl1bXOqjrN8S4/cnDEPsF1t/C2Yd8oOiGNo?=
 =?iso-8859-1?Q?RkEWqbHhDxLFmxG0toR72tmhy35YZzcZfzb5PRIupJd965O3G69bilWmIF?=
 =?iso-8859-1?Q?ye/GzKOujIIiPodTsrvazxI6ypOvkB9eNYIo/yNUIWLe1UGcqktie/oWSy?=
 =?iso-8859-1?Q?JxKAuoaZ1DbxZAf09C38FjwLqP0Uu2ElmXX7PkRBF2AGP8YLD3RUpT+g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 680189f1-548a-42fa-6b92-08de30f14e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 15:50:09.5523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AF+DsrmEr8GuFv6GQrwo5LpVjh2WxDpczJjfv+NZJjkiCutNo+boQqw0H5Af1ocVk1eQcvWIm/6Q6hzlZ6w7qyx365avhmit3/2R53RToYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9750

Hi Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 01 December 2025 15:29
> Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
>=20
> Hello Biju,
>=20
> On Mon, Dec 01, 2025 at 03:04:08PM +0000, Biju Das wrote:
> > You mean to avoid unbalance between suspend()/resume(), we should not
> > do error handling in resume()??
>=20
> Consider the following resume function:
>=20
> 	static int myresume(...)
> 	{
> 		ret =3D enable_some_resource(...);
> 		if (ret)
> 			return ret;
>=20
> 		ret =3D enable_some_other_resource(...)
> 		if (ret) {
> 			disable_some_resource();
> 			return ret;
>=20
> 		}
>=20
> 		return 0;
> 	}
>=20
> If disable_some_resource() can fail it might happen that the first call t=
o myresume() is left with
> some_resource enabled and some_other_resource disabled (i.e. if both enab=
le_some_other_resource() and
> disable_some_resource() fail). Now if the resume is retried some_resource=
 is enabled a second time
> without being tracked and a later suspend (or remove) won't bring the ena=
ble count to 0 and thus leak
> a resource.

OK, what about for making balanced usage count for suspend()/resume() to av=
oid resource=20
like below

static int myresume(...)
{
	ret =3D enable_some_resource(...);
	ret |=3D enable_some_other_resource(...);

	return ret;
}

static int mysuspend(...)
{
	disable_some_resource(...);
	disable_some_other_resource(...)

	return 0;
}



