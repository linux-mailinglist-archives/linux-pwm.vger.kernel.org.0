Return-Path: <linux-pwm+bounces-7631-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E75C5CFDA
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 13:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27F2735B4E3
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F7317712;
	Fri, 14 Nov 2025 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="LpMWVuDt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011046.outbound.protection.outlook.com [40.107.74.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0077C3168EA;
	Fri, 14 Nov 2025 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121653; cv=fail; b=kcP95GiRsd4GsYrSpw8g/AJKMnNgJyb91hHH35k0UG8J19j3Q2NwlawgjygUivNhOFFQByiYPl8LBUFHPhJyS8eAhLKB65ogAB5kY+NuFqyEqgxNkdXA+yXBzbaKWXuZ9hlnyR/e11meYuicbZSRzcbLD8GkTZUq3xzQJLZfxkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121653; c=relaxed/simple;
	bh=tRKdSGsEGSizjjnGtYrQbcplxXgDU6jpLSJzYS5YWPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AzoIstsOsQNAUwdacGPU7Hvhi30Tv1NyA9KRtcfLwcpPraJAUfVJ7hTxCmElrzwSq+76QTkYxEsBrU1t+AwTkuZQ95VAalS66x+338da9ftapMffCGQD62EizSHYSKk6dNnqwHQFxcyjdI3MOnt+nK7/YZVlMhxe71EyQYMxDyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=LpMWVuDt; arc=fail smtp.client-ip=40.107.74.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMyMg45nnaX9Rc02+cZfv6+S3AYRFtMbbVVnvaWxIuxE2K+Zyu7xbIu5GQU3SlUy1cyrd5TOrE3n8VRr3afwimUpJMMmaOjAIOYbBdP5TCTzPniqP5eqMDZhzjw7Wb6enKf6ANGf/489akDkabNsAKeJB6eNYStJAbQI9Lj0CQqkWfRj68/oL8Psjf6OGYgqIlTzZqq/yWmw4r302gYBdZO+fDNtSoi11LKWAOaIG9RU/jujkvyfZDFEnreL1koHlUDMXgNFlCjmiEK6x56o/HW+dThwldZPjqIke/QS8ToWnFpr7GmhNUfphXgip7d4gA1Vkqs/aB98lPiYFBFqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uo1/6RF8FaWOYRp2DV+Oy1Iouc0r26eknwh2p2Lo5p4=;
 b=vQDRrDZbeK4Qguk9Pqvv6pN2qKe94+5vc5MojDE+LHDLecaKBfLU857hAUCUjE4nkoFnNSGv8bi8/YEAdZu59EgD5VZXI0rw5L81LXG4s3/on456lTg1u/CDhuK3EIFI8RqoloH6w43cma0mJl+syqWzS1RPcx7lS8kh56Yc/DMzRO8jI44wzhXFUmZSJ4PpyFcqMxN7SUU1DUjui21Ffo/LkL+9DtgpvOv/rupNaBTWYYFFfNut7PuGPwvq4clsgRqB1yDoxuIbTmafdRBgHpFOQBDOvPy2NymQoPlBn2I1wrRZT+EHAlfhHCbhKX/zkGPtiCQJs5rRauLAqApJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo1/6RF8FaWOYRp2DV+Oy1Iouc0r26eknwh2p2Lo5p4=;
 b=LpMWVuDt2TUJfdMg0ZYh5qNAK1XF4yIV3LTO0UTGOf2QblmI27b9SjuMnoJ71/97ZiH+PFZhhNVJDAGL7WM1VXBmN8tda0rl7sfUEx/a7aTJfu08GOhUsZ3+gFR00x83g8g3j/q3EDQT+U5fdf7qTL+vdwJu9OJpzBfGNPpdbHM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8890.jpnprd01.prod.outlook.com (2603:1096:604:153::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 12:00:46 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 12:00:45 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] pwm: rzg2l-gpt: Reinitialize cache value
Thread-Topic: [PATCH v3 1/2] pwm: rzg2l-gpt: Reinitialize cache value
Thread-Index: AQHcJl7slNueg0SJnEmF87vJijr6cLTltM4AgAy6eHA=
Date: Fri, 14 Nov 2025 12:00:45 +0000
Message-ID:
 <TY3PR01MB113467AFC001615450B06E82E86CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250915163637.3572-1-biju.das.jz@bp.renesas.com>
 <20250915163637.3572-2-biju.das.jz@bp.renesas.com>
 <ct7zlhhexzjsogtthsmhejm37idby3pphljzzdarylkcupmblg@gripvo3dxzqq>
In-Reply-To: <ct7zlhhexzjsogtthsmhejm37idby3pphljzzdarylkcupmblg@gripvo3dxzqq>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8890:EE_
x-ms-office365-filtering-correlation-id: 22570809-57a4-4643-9d5b-08de2375719f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?LbZC60efqJTgXo2nXJpHtJ+/3A+8u7oQD7iTaVk7VdoPTyPG8Ldk1/3OP9?=
 =?iso-8859-1?Q?ukWGrsCOGC03B/K2jj2RdHr1h+x08oWE63D1mvE2U4WmZ071ummghGq2v6?=
 =?iso-8859-1?Q?vkHE5QoKV32ptCVV49ohxssd8bH46Modr5diPRlc6Qp3yJ063/T4VYy7zY?=
 =?iso-8859-1?Q?PtYXmTJj4JEYak5pepFY66bcZN/vTzSjuZLNW1Y9jaSJ9cpDyw6qHZ5UFm?=
 =?iso-8859-1?Q?p+OG0/CDZoVhB7P7+57PpXCt5vMr/w6cr8VTl4mGA6csS7sCO1zOXQUN3p?=
 =?iso-8859-1?Q?LeHoJReDzuARDGVLRr0qLhIpBNba6e6s/2m7TvZodqnZ3W0JVzJnJ13IVM?=
 =?iso-8859-1?Q?qqIGX2PsTnl7Sv2hlDHIOptnIxOy1sWo5gL+OhUAzxqkNWAuuMpEzCDU4d?=
 =?iso-8859-1?Q?zv874iLyTx0xoWXsJcBrqXKehcIShoWUwG9NHbaLHBXr9NvaY2lPiSdjMB?=
 =?iso-8859-1?Q?dKsDmQJd0lQflpyxIKH+D4LtXABhcHSLRnWlSxDsrG/kxOoxL0qdqUTnim?=
 =?iso-8859-1?Q?49y4VJze5F+qVVeULUJwzS5+/ETUiAxjlzDXW2hzf4JlbU0JoA/lOw8Ywd?=
 =?iso-8859-1?Q?eIxpfe84jqSSBP4bS5lDI2eA7YP8CDG85kZ/nCdGINGc1bAVHTlXDJUG0i?=
 =?iso-8859-1?Q?L4g02onE8o7TQ/lpwg64gDnKXh4d+cLP2SGkSw8z7GlOnjPG3St8iKiGsI?=
 =?iso-8859-1?Q?15McfAf54qr+f0PaBMNkwPBQIo6FDDeeZHwSVlHljL+w6Aril2wAvdOzm3?=
 =?iso-8859-1?Q?JlMSCZTzZutlLoL0g38du0QTccSdBKQy1k3L9fWWBFAgakcaUjyzg6VvIH?=
 =?iso-8859-1?Q?YWxSj67h/QiQrxzznaidos1kUhO+u3NFd0N8xfTZgonkgPR15eeDcNuBaZ?=
 =?iso-8859-1?Q?K46J6rsijbz47GvrNd6gaaN4bcD9FKzFaQPGXC0d9XvLVtnTiC/yIEh4zH?=
 =?iso-8859-1?Q?ojrtWBSZH6HvqQtEkDChvgYBenR/yYUk8hy7EXuYaMR5L0x3a0Joy+A6D0?=
 =?iso-8859-1?Q?KufF8oLZ1FqqTLl3hMU2xKuc4CGLVq1i6FZwN2/4GxF5t29XxlvtR7/khn?=
 =?iso-8859-1?Q?gavuxQbJxDcKIjJYzz69PRpNNKj66rn4AHcbc0lnJjaNx3N6I6fyD5mUEp?=
 =?iso-8859-1?Q?eXDxk0M7PcsYU+mit+N1z/vWKb987Xq5FBs6ezLA8oAArn2nT8njI4Bv5F?=
 =?iso-8859-1?Q?pMRGkLbVUf9YFQ8YB0nT16UGIxKfpLy9wLn+jwL/DXNndiM9+Ne6WcZOte?=
 =?iso-8859-1?Q?wWBHgDInNgwE7HCstZc8wCsgTZ3ePirwM1RbiHexBxU8KAtjMuZUBvs8ue?=
 =?iso-8859-1?Q?JXWgRDW2tYg/RoNsIsNZdBWji1x0bXybmt20RdvQoHNJIkf/I6gN/IYkQW?=
 =?iso-8859-1?Q?VaDQWgEkVPVUBaQb8/Q7i5vDWKiVd+ZObuVwx/OhbGKzHFWJgMWts1Vcin?=
 =?iso-8859-1?Q?TR4hD6wb8lDgav4EQlKBTNAqFfUggtWYYhrrGy7p392IAoS1sFqM9wK2JQ?=
 =?iso-8859-1?Q?xQ1fDknF1ynYWFlGC0OzkpCqN2WQ0rASwOPTYpKM5xZcJLDMbetpXDhtik?=
 =?iso-8859-1?Q?Y4x23Xp4DqPoS/GTVE8aTOHUg+1m?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hoxOKoqRF4h1gq5QXKW6ssxTSbN+bD/e0wtahEdY/NT1BWDn85s052nleq?=
 =?iso-8859-1?Q?rCQ2JXvx3wgrtq8gbVPMhW53NmyyaI90B1KuHdkdhPdoATkYvkTbvGJHzj?=
 =?iso-8859-1?Q?2Xx6iOsxw355X8oJbBb6Paa9LR6o3xUJfGVoSgwsCPyE/mm8ISWBy80Xvk?=
 =?iso-8859-1?Q?IGVmn+VtKHbf2us6pYWyKl9mm5qWbtg4PbQwbmZ4kGQ+ZOgSr3JasXOTEk?=
 =?iso-8859-1?Q?9uc0s/FNur2v15LCF8W5LyCA5sFsBYbhc+cp+2uG6F4cboOkMyqBzGKOJs?=
 =?iso-8859-1?Q?5XN2k8W/ebdQ1aKsJDU97swHr1c6K04+ywqhImU9jIOaK9nkljiGUy8ZBc?=
 =?iso-8859-1?Q?eyg4vUAnl7bPfsi/e4irmYNAc19ZVUYwS9FsgmxIrcc5ortBfOtLmCOpvd?=
 =?iso-8859-1?Q?y4MChAKEYOQihBHDuElf9pb00Rb6j/Ea+1tJTIVMCG/axVdU0MCEjKgyvU?=
 =?iso-8859-1?Q?GRJ4TyYGFCqURwzU+y4nFHTUjHLLHK4Nn3jZXLXH4YBjd9dUwge0EIw/02?=
 =?iso-8859-1?Q?elWftcENBQVAByjYgUhF+TA/TdXlw3KaWud+2ZGMjimtaRQqq2pIva/Wbq?=
 =?iso-8859-1?Q?/Rf1g1f3FS8QCPvvK29xQX3txjTGghxuwDPGjmE0zSdafblEV4A6wWOcgv?=
 =?iso-8859-1?Q?RlNVzPI3tRmaZkj39gcwLjnnWSU9T7kuDtTqOPlLviHEzhZQClEpqqlKIQ?=
 =?iso-8859-1?Q?LRkDmD6gUyCoHtmbkg/I1Sa2lmer32luxoRuv6G6OKSJIEuRm5dBSZRq6n?=
 =?iso-8859-1?Q?mppQepY9aS+E+4m/1nMNCv1dhWVkJY+9YoLTqt0hIt3E44QfDSQKLaTdbC?=
 =?iso-8859-1?Q?E2IS84VnGaFmsAxqKnDjpRY6a7K79cvOem8iWaX8yoAM6SCwiDamW/TrQ8?=
 =?iso-8859-1?Q?hUuw4U85UXuKPbjPpzSpI4gk4od2DjqIqFJ0NRjPYgvlGbKb54yd1dNyCL?=
 =?iso-8859-1?Q?xh3XCuf+2OCeKNFVhv0cyHSjhwOZtUUWQic0ik3WiMvqv+DZXtrBYCVpgR?=
 =?iso-8859-1?Q?FQu6FtZSOPl3FEytqrd5rYXeoAtK2vAmKRr9uIKRQn1kA4gV4tIb69fgN8?=
 =?iso-8859-1?Q?PQ4FqjMww6hytlkf31zKA2rU7pJuwSe1lAybrjDbQmJd3FTihw2s0TyEvX?=
 =?iso-8859-1?Q?AqJeMu9YG4/ZQF3U9zdrsuvMhmwovSOkNzKbJEXrE6iHJ4usrv9IGsaXa0?=
 =?iso-8859-1?Q?SHOAauaswTuLIw1jj+E6IA2kC0QuGw72Y622DgXxbzBvo6k9gUAN92uKDU?=
 =?iso-8859-1?Q?HIv2g/Oy5u0Fmz5mvA1MR1sehUfrPEP3LInGw2surC8UoGSwHTlNuyWfq6?=
 =?iso-8859-1?Q?n4cku0koLzpz4ITvO8SfuO5hcIrkMBnO3eLIkmG409mmNQ0PFYmn4oeGIQ?=
 =?iso-8859-1?Q?ZPU8wIuPSJryZqipYEd+M82sz++rFQcexNLPPpO4UhihNujqkfFcBKQ0iJ?=
 =?iso-8859-1?Q?QiwH+ZBhkrtsmeranEkKfp/UoTTJj74kbBkOO9Xy76d08n5Lg1kO6y7alU?=
 =?iso-8859-1?Q?IiHNQ5C+6S2cVSjFbyWS6f+K8Wja4RS7YMyIYlg5aVxuT6pLrvufA1OZHl?=
 =?iso-8859-1?Q?/jrsMORF0jHAoZ9o8WkC+Pq+S9uayjRw1p7I1jI+FuAOL1Q5VDP7vLRYQf?=
 =?iso-8859-1?Q?1+oeBLgC/jftyJ2Jo4ZthEm5a4+j8KlHtsltOsCO6stk7x/YqMqMBcqA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22570809-57a4-4643-9d5b-08de2375719f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 12:00:45.7295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wrh1nQeTquP62sCuHhdkmA6dY/kcjS4XbpeGomtsfMlF7T14jHRT5xNZFfj6BRXprK/btnBmEWe9FJWubuBH+vNJVbf8YHW8NIbIsSXdtxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8890

Hi Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 06 November 2025 09:36
> Subject: Re: [PATCH v3 1/2] pwm: rzg2l-gpt: Reinitialize cache value
>=20
> On Mon, Sep 15, 2025 at 05:36:30PM +0100, Biju wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Reinitialize the cache value to 0 during disable().
> >
> > Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v3:
> >  * New patch.
> > ---
> >  drivers/pwm/pwm-rzg2l-gpt.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > index 360c8bf3b190..b2452e50d618 100644
> > --- a/drivers/pwm/pwm-rzg2l-gpt.c
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -190,8 +190,10 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chi=
p *rzg2l_gpt,
> >  	/* Stop count, Output low on GTIOCx pin when counting stops */
> >  	rzg2l_gpt->channel_enable_count[ch]--;
> >
> > -	if (!rzg2l_gpt->channel_enable_count[ch])
> > +	if (!rzg2l_gpt->channel_enable_count[ch]) {
> >  		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
> > +		rzg2l_gpt->period_ticks[ch] =3D 0;
> > +	}
>=20
> A code comment and/or a more verbose commit log would be very welcome.

Thanks, will add both code comment/commit log for reinitializing the cache =
value.

Cheers,
Biju

>=20
> >  	/* Disable pin output */
> >  	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch),
> > RZG2L_GTIOR_OxE(sub_ch), 0);
>=20
> Best regards
> Uwe

