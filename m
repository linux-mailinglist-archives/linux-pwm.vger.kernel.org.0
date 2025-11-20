Return-Path: <linux-pwm+bounces-7647-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DE3C758CC
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Nov 2025 18:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B8204E7347
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Nov 2025 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F27350A26;
	Thu, 20 Nov 2025 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PIqVleGR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010024.outbound.protection.outlook.com [52.101.229.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5978284689;
	Thu, 20 Nov 2025 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658049; cv=fail; b=H349PF6zQQsGwIhc1HcMPJvCokiQkwlUXp6FLFojxmKiCJI175bE4sam4lZN+t82oCbU7bSbyaOX0jgGD2GjtOiUiTyS19/6KPQvrsl0wEYz1NI/Pz/wad18OnoVIPCnwNtICmxZAlhXaOpx2hvK1NX02RsCdtXzJn/PnhhPSEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658049; c=relaxed/simple;
	bh=V/JUBbGnBI4sGSCMtGkAednyP50BgISw0qTGvtIrpdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jaj7+rzcaG+kB/4JjrU9pe6mTt7zDNVfQKHhhzsgu6JJ2BU/l3KkfNXayWwh4jSdV5VoxaG7t8K93t5CycHxL47hFc5R4WUDZqpfWEkZrD09mMfBAmkonaymLxePFyrT6eqzgxt6UMOo0+bIyIfzBiEW0UV1U+MIYkNHn/GK0Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=PIqVleGR; arc=fail smtp.client-ip=52.101.229.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmeLSLpVrXtK30GskipBMgJhq7+Eu90P/miu6txzHxUcNO+IFn7SA0h8VoAG9i30BIWLc0EbXHLm7gwzJ734skd/sLaZ2e2bPJmAB9N14flVbeSFTvkfTtGsoKLdzqHfMyydcWyqSETiWj4i94Mo0NZ2I/NIDPoMsJRjLs6arazanJqQA1Q7Kiwzl+q3bfLVEIvBWR0WvWOhRIbsZrRjXmg4axWJSndBE88JqOHsOMKo60mkbMkzbsu7eU9HQt61SXHQeARdEcuEf9DFwHpnR+1AXxxFdIfaJgDqiV0E2YHDk2Y/fr+d3Pdpe7YrfzRlN1eQ9jpoN2s0dklUhwRK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItBu8STP4KTxGBoDMsklIFunwC3xoKKSiOiyO3MNXDc=;
 b=VoBoqN5RZK8v5dYPbPA6AWIEe0elhmou3a2ZS+0QbbPxwJfHfMfPqeu7sHQVJ09eazaDJOm97rsh/UkCd5nbS3uTVLMHvhzdYspfaZaNRMN6jr3/SRotnF6gknmukDE9fsphi+pNIdcty2Y0qiKdH8A6aZmCkxfiyTNyHhheLe+gVOx8B1BaWL8WLEXOvPZHFRJYftOc7yeHsKn84+BKrN5wJOeNYThAu2iLVyf/nNhA347oJZLYR0ByFezc3hBLG6eeO608e0L13i8G0TJKyUoRo48f9HSePdwWAVO3s/FkYpxgC0daWi14eXA64Tkwu2wgAvxmNeJe6HvBCzhbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItBu8STP4KTxGBoDMsklIFunwC3xoKKSiOiyO3MNXDc=;
 b=PIqVleGRUoPk2WJUBQXcJF24ZHDeZKp0trXyX6xpcY49Js3Hi1H3hTbv92mMHjfhS6n7AtAFx6j+fYC9F41SZlgjDxFMn8ZpVVLTU58QAlUXTDFunzf7msQtVkCn7UoLIOle94kHjAwwBKpleZ2p80ERJ4uLZGNQ/4E5NatIwl8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSZPR01MB9582.jpnprd01.prod.outlook.com (2603:1096:604:1d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 17:00:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 17:00:35 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, magnus.damm
	<magnus.damm@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v24 4/4] pwm: rzg2l-gpt: Add support for gpt linking with
 poeg
Thread-Topic: [PATCH v24 4/4] pwm: rzg2l-gpt: Add support for gpt linking with
 poeg
Thread-Index: AQHbiF0jDWHirCt3OUSeUJ2A7P2d47TtVpqAgBATF/A=
Date: Thu, 20 Nov 2025 17:00:35 +0000
Message-ID:
 <TY3PR01MB11346940A5BD83A5AD79FE46486D4A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250226144531.176819-1-biju.das.jz@bp.renesas.com>
 <20250226144531.176819-5-biju.das.jz@bp.renesas.com>
 <mipf6ogg45h5bsdekr27sf3nfllbbylkqjiowutg5cugbyosy4@r4glajhjcorn>
In-Reply-To: <mipf6ogg45h5bsdekr27sf3nfllbbylkqjiowutg5cugbyosy4@r4glajhjcorn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSZPR01MB9582:EE_
x-ms-office365-filtering-correlation-id: 906b2e84-5004-400b-acec-08de285652bc
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rM47H5FIgyBNJX0/Lg7+FaoavBWf1To7Z+zMpwJpax0Py7RaV6w68eNJgx?=
 =?iso-8859-1?Q?WKGBjgOTx8KpfSvfPKoLoZ0dRQ4/nQvu4UBddhVg8JKhMZMQ63u4raAdf1?=
 =?iso-8859-1?Q?fznyOd0xM3LGnVn0bpM0NmidGbk8YdJKX8FfVM7SNYZORula09NqJLyGEW?=
 =?iso-8859-1?Q?eWUeayLZAm2vMf3OnAG4UBsyCZATVFbioFMLu9p+/cFRFxS0ISErZlcfw4?=
 =?iso-8859-1?Q?GpkcE64GLT0yVAKpoIlHtS9nOMX/fsIfYQvNRQ32cB6Lqx5y+kx734zZJr?=
 =?iso-8859-1?Q?jX0Vv0ZHuzNYYU7qNl3Rjv1nAxT1jXSZSQpmWyySiU9fNV9hWPEAxrkgY4?=
 =?iso-8859-1?Q?IyLJo1YQ8aPNaa1JAWwd/eBk0iNzofJ1EELiTBrCIj+lcTPr5sd4MpsL7I?=
 =?iso-8859-1?Q?OQCZHT26ejIIl+P8WK0yOAV5kkdfpq2IxsjqINx6heJ/RXGH41Eai9Df50?=
 =?iso-8859-1?Q?55UMsRoXfnmTzIS9s8ZN0E9//uP77qho7342/qrFQ3Kkd7okLac/afXgUf?=
 =?iso-8859-1?Q?CB84pYrEWW77oVkdXv6Vdw2WTem0qcqV3IZRqG8LbbzkJLREnDXxC45Syu?=
 =?iso-8859-1?Q?ZJ8CrlSKJvbpG6KJ4uN4AxVZcqocRy4jpf/nuYJ6U9GIWorlsZVEF3gBSV?=
 =?iso-8859-1?Q?y9CLqMWvLBxdsAXI8ORfsjgCnAQK/Z++XdhisHLt79kQdemngqePn94WSe?=
 =?iso-8859-1?Q?SZEzFm9qv8m2Z5IuWxvWHboBt+6xhTVYHTmSBrzmsdzpz017Y7GeXTCkrl?=
 =?iso-8859-1?Q?jdHMKfTpBArOshY5nAsdX6ozy3zIncZRHLMO8qj6F3WpgdLg2oxkhc6hap?=
 =?iso-8859-1?Q?rDJEm50Y0sTypVKn2aSw3of4bI9IiPksb1p/jgwTedFgHvw6WIJDZForBA?=
 =?iso-8859-1?Q?TD1nyUkg4OnSdQtv64qVTKnCN1KXOXyrp/VzBPBK7y0Jx+d7gmdXdzrcix?=
 =?iso-8859-1?Q?+c7DdoSuktL+0Ffc+0OfpWkIfn3uJqq1mSTIFY8mvxXzodbLpcBNrNN6kq?=
 =?iso-8859-1?Q?Gl2gsShfNUsNg2njwNsGrib8v9XmJm1rAmDgsSL/plRW2ad2q3EenlK+OR?=
 =?iso-8859-1?Q?Pilr1aBv3WFnomh8QbzLDJq7tL3GjSm+AqRBhewR4Fv7EL/RWs6B5HfDoC?=
 =?iso-8859-1?Q?JvvuLIOriavOvodnZe/gUCvDlEEr/Cc5DKnqyrOtR05iZpcI/j81go87YG?=
 =?iso-8859-1?Q?oOV5btsfiDGGRMOrUQOCIjIUBW6oHlnXWebcEws0/oV79M8MATLduwGGNP?=
 =?iso-8859-1?Q?ypJ8/b8SqbCE17twx7SZS0Dt15aytf01hou6cGhQ1fbRs9D/eJzWwgrYkw?=
 =?iso-8859-1?Q?1QdK1d6XVDgjsxJIklSB1JcTmqYhtxZqaOuQ+ppys510wIoU2rFVa0h7V5?=
 =?iso-8859-1?Q?oVpJX6Bgjubl8+5F9BRgH0OfrFfFOftOOYVFbcM1nJmB8YZ2Pykl1oWgxL?=
 =?iso-8859-1?Q?x3BtDuAkFeQcGpKTc9hDbJ6FRvcBmAlT1Bb3shpbTUOEMB8Dlo1LPjcfZk?=
 =?iso-8859-1?Q?cBcHi6YwhK/8bUAJihW8CDYTxxe7Vty41IX5jY2TBCBg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ies3ligJo9X9ZBtylfxQitX+wgnFjQbybRC8swkygaRDrMJYX6xwI6hSAS?=
 =?iso-8859-1?Q?YAGHvTlOxgsQ4uhQUayp7+uNO9LoTN6uTMfCbBKARqoeCJKpaRU0IHQ+QE?=
 =?iso-8859-1?Q?1pNWXSFdhbVyH89Mvp6NT5e8PgcuT/pi3xczvwZEweOUJCUDIlEMGyWXbh?=
 =?iso-8859-1?Q?fXcEnQjYAfMaYK1/AxoORT5aLyMmCpdluwxstOJDrShZWS/KGdl2sQFrlV?=
 =?iso-8859-1?Q?o2M+YU2Dba+2jn95aAKIMzalWXBPK9d8o49cDL7KtZEfiTulxWcT3CIcj9?=
 =?iso-8859-1?Q?J0CjfQCO9hi7NYosclF43mTWAs4OW1PAJTJapA4zQXAgYgL9LS2kKUWZr/?=
 =?iso-8859-1?Q?BMiidq+EC29z4q9HX0owfTy72AhbC075i7ay/EGlb0F4LNRuvuQ4ezV7xy?=
 =?iso-8859-1?Q?QPj38FNDFaid7845YtMKP1i5o72CFU6xiuucME4USnYa6CshQ6EgsIDLhk?=
 =?iso-8859-1?Q?R+mhIuiFClQfpMvDBG5NdgArwvuC9V31Ea86WqoW7vAUfeEloVZvNnQ+rL?=
 =?iso-8859-1?Q?GP7QGAyCszs2Jiueup6w0lMYPuyaDGORAd/TNrg2gP3X5abGFg5LjBafmo?=
 =?iso-8859-1?Q?1hmhM9S3aFIEADERbqmzikpsFhMFUeBLyqJJtAB5djxm6W0T7Sm+k5U1d9?=
 =?iso-8859-1?Q?Ct/WMQ3GUJsOaqbdUZUSDjjJ7yu8yZlFsAvF2r/fSeiiihGQ5Px+vfdTP3?=
 =?iso-8859-1?Q?GCx6mKscONWWNPLyh+gYxrcQ4pgBaEhmTJHRgBviZnNb5U6cbhVaJiJhba?=
 =?iso-8859-1?Q?fP+lLkOwXpSg9NS9xvdk0IGwFk/AgYejR30fBB7in/EsSOlkrgFmg1YsWs?=
 =?iso-8859-1?Q?PW9p8BFSltyVA0ZmqR1q1n01qvpeOKPxk97RTU5TmGmTcPBOl2MWQ/KMzx?=
 =?iso-8859-1?Q?BLsky5OXPEqCQym61QaADvCGWMGUZceKhuzvoCZwctMki8cWRlAaCzHcxa?=
 =?iso-8859-1?Q?DdQdMuldBvKHsKj5Sy51q9rGMirhsz0qWHTD/OAVcKnF2DCVpyPWXKpFoL?=
 =?iso-8859-1?Q?hqlnYeObqaO+Y7J6Accf6Jn4Mrh+X+wNK7RYwLlzZsAfTfXBk4pyMO93yq?=
 =?iso-8859-1?Q?BBukxNUHFTAi24R5QjIFiA7A7i1r29jDmLgr/mKr53Q2Vp9fgaK5Rla2qG?=
 =?iso-8859-1?Q?zQa3bFFf0B/sIlMKOfhr3OEpxsKN/jYPjFPwoqY6MebaB8LnJzWYDAbpBn?=
 =?iso-8859-1?Q?JrpPREPZB9YeNegzIngruMC6fiBRmFmujjVVK0VuWgetY+UFSXqfFbF38N?=
 =?iso-8859-1?Q?vXLphmJET7s98r8cDZdjLd/KJ/TCSkEWJdwFOnSmUUNlq4LXLeRMxGBsMy?=
 =?iso-8859-1?Q?/tnjOW0K7W6gAbdQYzNhMBVv6YS0GhSR4id9joRZZaM76r01Mhj6n4FQzl?=
 =?iso-8859-1?Q?XCDSoSQ173e9OpPio+6BvdUG1rX6A1Ae2n1PKuBCyCXi6sSuvm6bKW4DAv?=
 =?iso-8859-1?Q?3fn2Lculzx/vEh7gpJ4xUzFG5wtM463pV/NSN7v22lTiGg1bnwcSqfLTGw?=
 =?iso-8859-1?Q?PLqJE+W6Ic4Z6BdhlJgVCyEYfag66HbbNuOtx/cB3fanLEmlqFwlvd09Qc?=
 =?iso-8859-1?Q?MgNjFwsketnHzOwCYBR9PMQgo63XM+FwIqDSUamI8u8Z7jt5QLooHmAwfT?=
 =?iso-8859-1?Q?R1MeipCjChNt6TOWUPOcNlBoitK3PHv68BtgsR6GbiU15cJft+0iN71g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 906b2e84-5004-400b-acec-08de285652bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 17:00:35.3178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09PGE5jtc54dKKD9orrZ5zoKOPjNUsgUjOb4GmfAv1LmxHgRs/LqHJXsqzDQMJcZN0mniP9Lb6ZwYEg+iMo2gRBSLOZISTUqi7MeBeq7Xok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9582

Hi Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 10 November 2025 11:18
> Subject: Re: [PATCH v24 4/4] pwm: rzg2l-gpt: Add support for gpt linking =
with poeg
>=20
> On Wed, Feb 26, 2025 at 02:45:23PM +0000, Biju Das wrote:
> > The General PWM Timer (GPT) is capable of detecting "dead time error
> > and short-circuits between output pins" and send Output disable
> > request to poeg(Port Output Enable for GPT).
> >
> > Add support for linking poeg group with gpt, so that gpt can control
> > the output disable function.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v23->v24:
> >  * No change.
> > v22>v23:
> >  * No change
> > v21>v22:
> >  * No change
> > v20->21:
> >  * Dropped local variable offs for calculating RZG2L_GTINTAD channel re=
gister
> >    and instead using the macro RZG2L_GTINTAD(ch).
> > v19->v20:
> >  * No change
> > v18->v19:
> >  * No change
> > v17->v18:
> >  * Moved bitpos near to the user.
> > v16->v17:
> >  * No change
> > v15->v16:
> >  * No change.
> > v14->v15:
> >  * Updated commit description by replacing "This patch add"-> "Add".
> > v3->v14:
> >  * Removed the parenthesis for RZG2L_MAX_POEG_GROUPS.
> >  * Renamed rzg2l_gpt_parse_properties()->rzg2l_gpt_poeg_init() as it no=
t only parse
> >    the properties but also implements the needed register writes.
> >  * Added acomment here about the purpose of the function
> > rzg2l_gpt_poeg_init()
> >  * Removed magic numbers from rzg2l_gpt_poeg_init()
> >  * Fixed resource leak in rzg2l_gpt_poeg_init().
> >  * Moved the patch from series[1] to here  [1]
> > https://lore.kernel.org/linux-renesas-soc/20221215205843.4074504-1-bij
> > u.das.jz@bp.renesas.com/T/#t
> > v2->v3:
> >  * Updated commit header and description
> >  * Added check for poeg group in rzg2l_gpt_parse_properties().
> > v1->v2:
> >  * Replaced id->poeg-id as per poeg bindings.
> > This patch depend upon [1]
> > [1]
> > https://patchwork.kernel.org/project/linux-renesas-soc/patch/202212141
> > 32232.2835828-3-biju.das.jz@bp.renesas.com/
> > ---
> >  drivers/pwm/pwm-rzg2l-gpt.c | 83
> > +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > index 2ddbb13f50aa..a551554aec77 100644
> > --- a/drivers/pwm/pwm-rzg2l-gpt.c
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -39,6 +39,7 @@
> >  #define RZG2L_GTCR(ch)		(0x2c + RZG2L_GET_CH_OFFS(ch))
> >  #define RZG2L_GTUDDTYC(ch)	(0x30 + RZG2L_GET_CH_OFFS(ch))
> >  #define RZG2L_GTIOR(ch)		(0x34 + RZG2L_GET_CH_OFFS(ch))
> > +#define RZG2L_GTINTAD(ch)	(0x38 + RZG2L_GET_CH_OFFS(ch))
> >  #define RZG2L_GTBER(ch)		(0x40 + RZG2L_GET_CH_OFFS(ch))
> >  #define RZG2L_GTCNT(ch)		(0x48 + RZG2L_GET_CH_OFFS(ch))
> >  #define RZG2L_GTCCR(ch, sub_ch)	(0x4c + RZG2L_GET_CH_OFFS(ch) + 4 * (s=
ub_ch))
> > @@ -55,12 +56,21 @@
> >  #define RZG2L_GTUDDTYC_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC=
_UDF)
> >
> >  #define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> > +#define RZG2L_GTIOR_OADF	GENMASK(10, 9)
> >  #define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> > +#define RZG2L_GTIOR_OBDF	GENMASK(26, 25)
> > +
> >  #define RZG2L_GTIOR_GTIOx(sub_ch)	((sub_ch) ? RZG2L_GTIOR_GTIOB : RZG2=
L_GTIOR_GTIOA)
> > +
> >  #define RZG2L_GTIOR_OAE		BIT(8)
> >  #define RZG2L_GTIOR_OBE		BIT(24)
> >  #define RZG2L_GTIOR_OxE(sub_ch)		((sub_ch) ? RZG2L_GTIOR_OBE : RZG2L_G=
TIOR_OAE)
> >
> > +#define RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE	BIT(9)
> > +#define RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE	BIT(25)
> > +#define RZG2L_GTIOR_PIN_DISABLE_SETTING \
> > +	(RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE |
> > +RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE)
> > +
> >  #define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> >  #define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> >  	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE) @@ -71,12
> > +81,17 @@
> >  	((sub_ch) ? RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH : \
> >  	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
> >
> > +#define RZG2L_GTINTAD_GRP_MASK	GENMASK(25, 24)
> > +
> >  #define RZG2L_MAX_HW_CHANNELS	8
> >  #define RZG2L_CHANNELS_PER_IO	2
> >  #define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS=
_PER_IO)
> >  #define RZG2L_MAX_SCALE_FACTOR	1024
> >  #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
> >
> > +#define RZG2L_MAX_POEG_GROUPS	4
> > +#define RZG2L_LAST_POEG_GROUP	3
> > +
> >  struct rzg2l_gpt_chip {
> >  	void __iomem *mmio;
> >  	struct mutex lock; /* lock to protect shared channel resources */ @@
> > -84,6 +99,7 @@ struct rzg2l_gpt_chip {
> >  	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
> >  	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
> >  	u32 channel_enable_count[RZG2L_MAX_HW_CHANNELS];
> > +	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS *
> > +RZG2L_MAX_HW_CHANNELS);
> >  };
> >
> >  static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct
> > pwm_chip *chip) @@ -362,6 +378,72 @@ static const struct pwm_ops rzg2l_=
gpt_ops =3D {
> >  	.apply =3D rzg2l_gpt_apply,
> >  };
> >
> > +/*
> > + * This function links a poeg group{A,B,C,D} with a gpt channel{0..7}
> > +and
> > + * configure the pin for output disable.
> > + */
> > +static void rzg2l_gpt_poeg_init(struct platform_device *pdev,
> > +				struct rzg2l_gpt_chip *rzg2l_gpt) {
> > +	struct of_phandle_args of_args;
> > +	unsigned int i;
> > +	u32 poeg_grp;
> > +	u32 bitpos;
> > +	int cells;
> > +	int ret;
> > +
> > +	cells =3D of_property_count_u32_elems(pdev->dev.of_node, "renesas,poe=
gs");
> > +	if (cells =3D=3D -EINVAL)
> > +		return;
>=20
> Please catch other errors, too.

Ok.

>=20
> > +	cells >>=3D 1;
>=20
> Is it an error if cells is an odd number?


Yes. It expects (POEG phandle)/pwm channel pair

>=20
> > +	for (i =3D 0; i < cells; i++) {
> > +		ret =3D of_parse_phandle_with_fixed_args(pdev->dev.of_node,
> > +						       "renesas,poegs", 1, i,
> > +						       &of_args);
> > +		if (ret) {
> > +			dev_err(&pdev->dev,
> > +				"Failed to parse 'renesas,poegs' property\n");
> > +			return;
>=20
> So .probe() might emit an error message now, but it doesn't fail. I would=
 suggest to change the
> latter.

OK, Will do.

>=20
> > +		}
> > +
> > +		if (of_args.args[0] >=3D RZG2L_MAX_HW_CHANNELS) {
> > +			dev_err(&pdev->dev, "Invalid channel %d >=3D %d\n",
> > +				of_args.args[0], RZG2L_MAX_HW_CHANNELS);
> > +			of_node_put(of_args.np);
> > +			return;
> > +		}
> > +
> > +		if (!of_device_is_available(of_args.np)) {
> > +			/* It's fine to have a phandle to a non-enabled poeg. */
> > +			of_node_put(of_args.np);
> > +			continue;
>=20
> Does of_device_is_available() return false if the poeg is enabled, but no=
t yet probed? In that
> case .probe() should return -EPROBE_DEFER.

No. Returns true if the status property is absent or set to "okay" or "ok

renesas,poegs =3D <&poeggd 4>;--> this will make poeg probed first.

Cheers,
Biju

