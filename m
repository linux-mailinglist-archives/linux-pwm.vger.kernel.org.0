Return-Path: <linux-pwm+bounces-7130-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0DAB2EF0B
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Aug 2025 09:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CBDA01DF8
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Aug 2025 07:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2612254AE1;
	Thu, 21 Aug 2025 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kvWa2oi/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011043.outbound.protection.outlook.com [52.101.125.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132924336D;
	Thu, 21 Aug 2025 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759849; cv=fail; b=QCFMfZ0o9ltFqyjYxNpLSn8fJSOGYJKEnI4LNe7RG6mduB2aJ238Ke/+IJVSpUtY/r1qEze85nQSD8dGf0BPx4PqIlcVoGXIDBO4bUefGZH6zjWNJS2Hsik4qXhBuZBnM2SrN9HxYF/lbDXGl7Z6I3N1Jhn2fGqXyg7oSLY3SmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759849; c=relaxed/simple;
	bh=WV4RVH6NZx7ldRr6cqHjlYv0cbKXKDDsxXWk2LF7Nf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y56dI4o1VbpInIdUwpMbqhGuU/5Y/Cvopls0iDOfxlbMxgPMSBqL4/waMTlbw5OfyDZqepVnfYMzsjsQ8trPeQv1fLbDOdEV26E+HSFjPTB6KR1sxaC8z3hsw3KOoWqZVzXTbNrI9LZdDuW25GHSBLS7mU01vwXNHw8p9C1N0RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=kvWa2oi/; arc=fail smtp.client-ip=52.101.125.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxXAwZKCh29cFB7TWM+sK8NNVwjYyrlYSZV21FtmkMaMbGd+Nyd1mjNGCN+TSDTyGl461nuA5T5lsczLobbFbgvnqN6X67XkDWHz4RuqeFe+7BgWTh1DbNvnpjIZlHzJLrkZSdZLxVe9Yqb4fJFF78Lfi/qG8bL2kNpbUwenrmI97MwfovfD6ZbYyT30ydClru4d4rDU0gsC8VHb6BaMokPxhZHt4ghanvBQA1TcXOfH60HPLfDtudnsJFJQZDHr+AfUDVfQlrGE5zDyhBCDy4L1mvoQSYliQSPjGDpuPH5PtGLcaoKwrj0+wMJX5RQYeyYe6G+1MaocibgvfcbZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV4RVH6NZx7ldRr6cqHjlYv0cbKXKDDsxXWk2LF7Nf8=;
 b=TzXzLW/inv/CkDLFg5Glka/CGXJo/MDzi7FE0vW3rRgv3s1IFYPMmi5IJgbiRe5PuTFI5dVDSN9EwWYNADmfKc04Ta26TvCVW8mSaj0XoNzY+G8nsLEgwufmKzEkFzd1emjes8yEnCf4lN6o6XNlkteSl7zpsPBser91C/o//31n9Ie7i5sYiO2IXC5zx/ekFTY1WjbZVHvDzhI8qJVJrKLligS8T6K59mG1QxtgwNv0/+eHoXQa0S6uJ2Lxp/c8rmdTC0RaC9GhrY4EYZHLRw3fQyCqsqAsOOKUPOCzIeeUpj3uHQiSI4JBq0VHc+hVYKHW9Nn1jCtkC3sVRbSPFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV4RVH6NZx7ldRr6cqHjlYv0cbKXKDDsxXWk2LF7Nf8=;
 b=kvWa2oi/effULPD38PAjs7GBNyFbp8szSTjfkAtB1PMmeDFEcRsJAuNaIkMhv6uLs4Vs2wvr8gOJ+G2M4Or58bNpopHpkr20ZCAWDBjsuznHdQexnGyb/gTdttLKxUk+yfYQq2ZU0SwIxdnN6QYTRpOt6jaUc0l2bwguS4s3Cnc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB17137.jpnprd01.prod.outlook.com (2603:1096:604:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 07:04:04 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 07:04:04 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Rob Herring <robh@kernel.org>, biju.das.au <biju.das.au@gmail.com>
CC: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 1/7] dt-bindings: pwm: renesas,rzg2l-gpt: Document RZ/G3E
 support
Thread-Topic: [PATCH 1/7] dt-bindings: pwm: renesas,rzg2l-gpt: Document RZ/G3E
 support
Thread-Index: AQHcDUsJKpJVRh5HckuiNJlGRemQlbRsB54AgACw8YA=
Date: Thu, 21 Aug 2025 07:04:03 +0000
Message-ID:
 <TY3PR01MB11346ACAC1E818B07BAC7E8568632A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
 <20250814184115.192930-2-biju.das.jz@bp.renesas.com>
 <20250820202918.GA712198-robh@kernel.org>
In-Reply-To: <20250820202918.GA712198-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB17137:EE_
x-ms-office365-filtering-correlation-id: b6a48809-25ed-4d34-2491-08dde080e9d5
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?oczkl69tItoUV3dnJa0EHL05SGYzDCNBDxhgIifGaaihRSnqxaILiXI+kx?=
 =?iso-8859-1?Q?hFulp30deyHU+gL2Wj42XSlq1/82k1/NMyXktRfqDWPqIyuewdhnWrQcPl?=
 =?iso-8859-1?Q?+qsERzbHF8VhGlhY5NHzchDnZY+Apg4yybRAec9UWQMHFo/knXQD3+KWUB?=
 =?iso-8859-1?Q?Nxwwk8jq4abS+0xdWtIEwMoTucjiQ913AiAsOlNRVBA0oHGffUftlulFjg?=
 =?iso-8859-1?Q?mcZJhFx3NCEVLI8zVoiz4A2iJ2IN4CGFNdkVt5H48i+lO0tKdx3Msaahtc?=
 =?iso-8859-1?Q?kwfsFwGZ8j2JtUOrkFhhwUGxyUI+2vsI0wiVReZSl7948LkMXMBtHBcCzK?=
 =?iso-8859-1?Q?43erV/OCQA6rsqpFhUZYMGKLGMTh+55KRkGAkR+OyraqytVPq8I0OFVuVY?=
 =?iso-8859-1?Q?3A+SSW89nvYKm/IRsYOLeNnu2OMLfnTc8VhoFbJo3AhQYvpAExNYzbLVvp?=
 =?iso-8859-1?Q?iWhajuq4VpsU58oiuhISV/u3Q9HZHWMRFlZV6WcQyAJUm04FKMEUhVHT8y?=
 =?iso-8859-1?Q?jyMaCi/k1rfKZWhagBpVoSNyqZym0WpgSyq53hhy50n1il+63Zs6Y8/UUM?=
 =?iso-8859-1?Q?3KQ4URyJaPfov8Dj53BBNVFnXV+OxBDm9WRvutnGB3bEtEFxygdBTJ66LI?=
 =?iso-8859-1?Q?SEB1dSyhuV8x/ZCEye/fv9L78QEeTG92DRx4OM+t2a1Cg0I+5FlGzccxwz?=
 =?iso-8859-1?Q?HHBggShJ/oYc6NR0S9t9EBOxQr88o8c7r8j73umyYG9U5wfwx35nZ7a1Oc?=
 =?iso-8859-1?Q?FwZ/vKMv1QM884s3AEwbr8l7f8V0s+LA1xhMPLoJSna2hkmuIjMp5PBzyW?=
 =?iso-8859-1?Q?brhF3uBmSHMlVLujS2Ef7yhkSc/QCnN6NcrLF1j0uQ+fgDaRbOa3Mmxkq/?=
 =?iso-8859-1?Q?xuu2TarMvvFT7FpCl034le2X++i5YeXxph7+YH5P2hZO71bvZsGKxas36p?=
 =?iso-8859-1?Q?Qh5F1o+kEYZNbFqOOrsjV+3xA+xtJtcu5r4jQwVsO/SsZ2PcnEImL6Uf9E?=
 =?iso-8859-1?Q?l041N6S8j6fAsIiIEKt8aWzyuY5hORNvIcZkPzfSCPQb6GWK7/2l8uuOMM?=
 =?iso-8859-1?Q?ud+57nHwRiz76sRnpKhKgN8XML39uq0ohLcftIIGz32ET2n/sEjTwJuwKT?=
 =?iso-8859-1?Q?4mzne/YW1JI9M64yMACnUCyw17zwOzCVwLVXpZXYeYc4RWyD5yIx001zxW?=
 =?iso-8859-1?Q?pfx03SoFkQD+SPrm6vlGY3h+Ym86kZ5SvNM7JUxO3P1wSUHozv1WWz2wiF?=
 =?iso-8859-1?Q?nFpgsxfkHW83e0QmRv+8DncVHJAKLpzrcEOQqvB99Sw5KkdqbYsb57+7ce?=
 =?iso-8859-1?Q?ScIw5ZzCJitV3ANE8N+m3KwjzkBOnHNsGD5hF9391sAj4yo/0vNwsscy7F?=
 =?iso-8859-1?Q?gsl4c9cn5JECiyCx4zbioJwKy6bJyv/5oZpD68gx/i6xhoQ1sZzzAr7CfT?=
 =?iso-8859-1?Q?77ydUFvvNPqc98bar/dv4ELBxHxxJY6KmAomVFuXM/5njZKCRFugKBTdw9?=
 =?iso-8859-1?Q?jrbA7ufSXeypm9YkCYFLlJ/4bpfHSd9dwBPljySwu8V3Pen+/zLgTHJyN9?=
 =?iso-8859-1?Q?IPt0w2c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6RQxLUv+BrPgUOzlzbYRe4kQ1RxX6DVLWcPIK1+IqGggPFCCXZsijx1UcB?=
 =?iso-8859-1?Q?3zyhuAUQVHgf1U6/ZQwkghMtrta8iDZfKTx2bDIFlgrPirqAkc3RMPVYuE?=
 =?iso-8859-1?Q?D4AtM96ETGZfscLpkdu34mRH36HmQpC/QXI3t0qSES7e4Pgs8VzgD60LIH?=
 =?iso-8859-1?Q?LKrpHRb2mG4HDkwW/slTpaAbfozi5dinO5BdXvmN/hxafVgVb2b9vdG1if?=
 =?iso-8859-1?Q?CUDYK5fqtn7KJRLPQGpEh2VLZFndC5NZCF9yYily3hJlJkTeksZLpO+6RD?=
 =?iso-8859-1?Q?bUjmpbZ7OwyC3803RFzx65zAi2t+sl06wmO3jdfz2W+FXeOgCBQHhPjljJ?=
 =?iso-8859-1?Q?xh5yacB/SaaspRJmdrOEv782VMS23jq5stjTpyk2Q+AVP5XzdanIKg6C+E?=
 =?iso-8859-1?Q?OM2PBBl5lOgPLI2cP9ZViNo/vd/aAgziwp4jchzr0PMRC9ZgiqyJeVR5bl?=
 =?iso-8859-1?Q?WX0IJaT87ahZcCuSyRIuJuR6R+OBLevzsK+xuYfZrYmT5dO2HQy5TCIgUC?=
 =?iso-8859-1?Q?U3cFkzLDeN7xmDQXADUOrFhjqWILA30lPZAV6z3wDKkAaSnzkstxt9b65l?=
 =?iso-8859-1?Q?8p65zzZ44goXN2+AmfJ0O63xw+Yr72k0BxJ30y0vvaXkvo3NI4kGdGZ/q3?=
 =?iso-8859-1?Q?bavhOyrniRjxpCfFyqyrYQB9qokPN/6Ed8mzATWfjcS2+SPAB9X5yNBsQb?=
 =?iso-8859-1?Q?9X6K63iL06KHK67KRSKRdSzGmEfgutPXDOJbyPI2fNUGF3wOCcploPBEqt?=
 =?iso-8859-1?Q?lml7L9ccFELkvNmkzmThDucFwPQ1atdTdTKoi0a+th85vkeAeF60b/Fadr?=
 =?iso-8859-1?Q?VCITeC35EWNmMQeGsEB3BcvHDmz+rcfAM/ZVdf9edUDI6jmVGRng2sB7UL?=
 =?iso-8859-1?Q?31xWx4wrAXjOHR9rzqkeD7GtV4KoUJNaYF7HBR5XhHMorqI7gbeJ1SbKPB?=
 =?iso-8859-1?Q?euSvG6ecM9XF99+BoI3Ve60RM4QAVk/RexUYgklZg+CoXeio6QtUySM5sP?=
 =?iso-8859-1?Q?lLGQBe5ClV2rsC/Rcl7wrQRSE4jqIB/nqdkHcoxqHSP5KoWn5BFVhyRQxK?=
 =?iso-8859-1?Q?aWY+sb3ayfFLi8W7igM4iAvrnzHwSzvbn08TAM2lf4nBTScSpKewl9X7w5?=
 =?iso-8859-1?Q?RCkEJJXXg85wr1c/P/1EfRaRVk/wt4jo2m0b+qnQLTRU2nAVlYq1jAJ8Wd?=
 =?iso-8859-1?Q?yWmbYqGq3K6HXT+shS2PxQcZIzy0ocVnRWa79fiUt/n/dA+SFPqeJi++SY?=
 =?iso-8859-1?Q?giuuZQpCCv5pbFlMTCN5df8qgwswWuCi/1D5n4Q6x3c10RnWywcKVBQkdx?=
 =?iso-8859-1?Q?RS4pukxGvo5ZYC7kKO0zpPcdkAGunRI4HPsMXoNVem3s+Hgt8DTosvhKGa?=
 =?iso-8859-1?Q?NEcSAQHQcpLPwiCswnO3SzN0ITx7drvoV4tw5IHH48DnIj8uSDIbtuvA08?=
 =?iso-8859-1?Q?Xz3OcB100xW92El1/GozPvwbwJGFReYZPQ+OaiPSOra3fpJuxeB7DC2ke1?=
 =?iso-8859-1?Q?whk88OqBwFBdb8OtYFxePo7tGTF3uRgv3P5IqiPfKAmIWxbyLCwsxZF22J?=
 =?iso-8859-1?Q?uPos6WCyYODalNrJqB8QfFoyA8fjOPkzE7aMu7aTOimcYqvUToznaJZfFx?=
 =?iso-8859-1?Q?XFFSjor4bYHJBb+I5gOFbUhtFuRKaLa9ZkUm/1NADSF/Ii9UHlcRKEtw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a48809-25ed-4d34-2491-08dde080e9d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 07:04:03.9884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzqy7KIZ2e4wX2xtVPiARyRWqYRibtqmYMRoIa6FtiQ+P9BeaN366X30/u55sjtcKG7PcWx6jOb7oEXFFtOIMQIm4HuKUvNEp6C/Jaxn+34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17137

Hi Rob,

Thanks for the feedback.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 20 August 2025 21:29
> Subject: Re: [PATCH 1/7] dt-bindings: pwm: renesas,rzg2l-gpt: Document RZ=
/G3E support
>=20
> On Thu, Aug 14, 2025 at 07:41:05PM +0100, Biju wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Document support for the GPT found on the Renesas RZ/G3E (R9A09G047)
> > SoC.
> >
> > The GPT IP on these parts is similar to that on RZ/G2L but supports
> > only 8 interrupts per channel and has multiple clocks and resets.
> > Introduce a new compatible string `renesas,r9a09g047-gpt` for RZ/G3E.
>=20
> Doesn't look like a lot in common to me. I think this should be a separat=
e document.

OK, I will describe it in a separate document.

Cheers,
Biju



