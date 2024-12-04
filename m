Return-Path: <linux-pwm+bounces-4224-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 626539E4476
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2024 20:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC87B396C5
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2024 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207A1A8F94;
	Wed,  4 Dec 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="vf3NlXZq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011046.outbound.protection.outlook.com [40.107.74.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2942907;
	Wed,  4 Dec 2024 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336672; cv=fail; b=ZaBXRiG3tL3vgssBAnOPejXbcrhEu77knbA9HjqZfGHV38JjEi3t+U1OJZLnnMSI8TSqu4iJ5cpb3PkD1r2QfAomR2IzqM2WxrDSpVoyxni24zEyab0XQWyqbqKMcXmHprIz8AFHtqP9J8b0FLWH3QVt5vIGvstrm9pgQid0ags=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336672; c=relaxed/simple;
	bh=tWsk3pIuCxgPIf0oJHXUuDHtHgvfKp9Q9Zbjx7DJ138=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jt2U7uMpvv03iYcin4bFpar13VzKPug+XXtZuG12k2cvRrgjSM9GW2A2hS5ph8QDlka/D1sBMcq7FZg+fjMXbo9Dp1NjlNwCbe5xdseDvpVra8QUbvMS8Siu+75ogqpPomixmRuvzVLHBSZKCYHfzsvchytLoOC/GgsfdgfCMDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=vf3NlXZq; arc=fail smtp.client-ip=40.107.74.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fK/WWOoHjgUZ/5yGCbhVYzwPQi9NIGi3Wl6/ruZJljM54UFaDpHXe5ECsrq2A6duq36moBshHhUVdT4r1i/UwS4uWUsf9Abo0/Bd1Z+oi+9DDLy3nqJRN1CevGM7oG91oD+T8mPhnR57/9HwEyeSbrdqOKQEjsgTQO+0vMNqvd38gU3h/pLA41VJ28dhia0UijkH73P6Yv7QYlHWMAioDsKLlyFzdDSeYw0/Vf1pB95nijna/5E5RYNQNyGhz7DrO1DQQ3+WfD6JFTfp6XJrz3o2NjnBNLc1HLbXs9KO0a9LbuXe9G0sNOUm0siAmZC2TefA3UT9XzyMv+gUbF2l6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdrVo/Dui4UyOqpus9L5LOpq+ImXj1NTQXDziBMEZMM=;
 b=p2aExl0e2wGY0jaceC1A9CFwtT7dDZRf9KT/kma+5QEmMLOGRVFEEczR1NRLu0nnWk+mRtymukWV3jKaRZiuRopopVs0UMto9lGgxJiiliDz0+MiqJKJDSt/vVgeL7r+3+l4PpzBc1LYoyyd7RPOBje0DRc6XPsEwLZfKbubCPOvklCfG/KeAGcLl4o7UQnFz2MScAiaWakZpYM9KKY/bY6bC09N3ygZRN3U9yOV0T20mzfNVDGVZLi6/LyTYTdlW1g16WXeJ2y1KSrhAkJyvyhw5ujqk8WloTitbLhMgn4LB/vb4NkQx2HpjeET6J6zLZdZX0hiPeoR1x2uFEv2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdrVo/Dui4UyOqpus9L5LOpq+ImXj1NTQXDziBMEZMM=;
 b=vf3NlXZqPlgSsaq4TuBOZQFt1daQ1wznN00hebRi/DghXZy97MFQrs58gje/QafhSHmRT2TI9qIMzkjOsNJqNnaWKqpZ31ZqyKEn0JC3+H8uKBYg6hKEmAW5ZCM31mgsNeXrTFOTgbuBkLUKFcm86rCxf7ry7qjQCistJy6BJWg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB10679.jpnprd01.prod.outlook.com (2603:1096:400:2a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Wed, 4 Dec
 2024 18:24:21 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8207.014; Wed, 4 Dec 2024
 18:24:19 +0000
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
Thread-Index: AQHbIV3QCLVSX2/XSk+pOZR0ZimyzrLORWwAgAhm5eA=
Date: Wed, 4 Dec 2024 18:24:19 +0000
Message-ID:
 <TY3PR01MB11346421B5C0C4A193F70C3A586372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB10679:EE_
x-ms-office365-filtering-correlation-id: c83910bf-8946-49d5-ce80-08dd1490de4e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9I2zhB2I3jkOywG4jwmLkjTU1W7oHB7/9iA79kh1e6vHOzpiueCq+TInYB?=
 =?iso-8859-1?Q?YzjFHTrb1zbm0kQ4LrQP3lD4wfYPheR29SyfTDuFnfiZGGJhLJzXzzlzgP?=
 =?iso-8859-1?Q?AEXqcDEglqfTNzTiB1pK2JCwU+CzYYQJ4rm//a7JzlSk2eJ+3iU7uMWAZ0?=
 =?iso-8859-1?Q?GDHTJeDWVLvRKMK3K+72YgKTfSp7H5qfUKJ8A/lQrJee9aAzmphfjSJp+d?=
 =?iso-8859-1?Q?GE6gXG/DC6BfrHYcWfJaiZ/vEE8BuBLYph+9oe0Zk2RWEw5pg+HWMapKYQ?=
 =?iso-8859-1?Q?+49u8Fk8xfpF8ZUMlRuPjn3RD29Z8Y0H+IQQhKBckvDPGL+cHaz0biJF/P?=
 =?iso-8859-1?Q?hQeQnXGH8vmagvtYsBpL7RP/NtUvLk9aIQ3q/Xkk89lNid/SBgPMuqEqpg?=
 =?iso-8859-1?Q?pmsOp2BupinARifuiwWLdug8BHVMD91zF248Kx7PHzOq/vHBihd5Wrhi6j?=
 =?iso-8859-1?Q?AAKhv2OpYNds5liRIRI6ZSPRwCk5fvLLT/B2dIWjH1xKVYc3FRiVHU4qNk?=
 =?iso-8859-1?Q?/oW5GG1PF7fqHJT/pRg+4FOZnvC5NWnOod+ZrQOocf3w1q4vsNX8LBbeVz?=
 =?iso-8859-1?Q?dKLyZXumqv4ckyYviXnIWYmEyhPeYCxFY+Q5yLaRGgD+kBbUQ/UgGIPFQf?=
 =?iso-8859-1?Q?+rHjFVwtBd+lCyHNCpYfAypm5YRRbJ+GatUlMR/1kiP6dycOoDyQclPnYa?=
 =?iso-8859-1?Q?mw4pS0hMD3tL1vCAiyPzdumd5Q1a5GjovNUyuL4va4aH6DGbAt1L6qoSuQ?=
 =?iso-8859-1?Q?7CBRr6z2ug4hn8hQ6HE9y/r4l0e1tCGok2A5IqJRG6R01r4fBRUMuIIGCV?=
 =?iso-8859-1?Q?iuodqnGrX76Y4eYn238xlj68e5dViiiEd8/fwXP0ShPN47+9vHcHqEK9cd?=
 =?iso-8859-1?Q?gCsvtDKeRwX9Ghq8kEaFSJNg1pJFLJ4qTK5woDK4F9CPVFDZJ6cWn7HKt0?=
 =?iso-8859-1?Q?8WowSWJVKnS9iT3hKOxmchmt7I+L4jHffXm4LOa8+Urw1RRb9hDS4Zcdx3?=
 =?iso-8859-1?Q?GDCDAvr+5bSVHXViGf3R0wV3YSi+s+zcw0ZRJ7tQ7len10rGds+fgFGEqp?=
 =?iso-8859-1?Q?xvwwHSQ6p1DACX8v6kddftYFQBDsv4vsFO3x+MuldpRlGkh4IVtekdyGMB?=
 =?iso-8859-1?Q?kmiZMgwCR4k8sJvnsU1WHdukCfPlF8TZNVwmGsIKxu7sPYueSo7BR2pe7S?=
 =?iso-8859-1?Q?cHViADNS5yaZayKgiNi/iSVI/R9La381CMHb0Ki4Zs+704toK3Wl3JgD0B?=
 =?iso-8859-1?Q?2NdAmplacEmG0fbv6mT2xb4ciNFTKNCstj2NoIrc+tO6KxIyioXZKaPS2z?=
 =?iso-8859-1?Q?qmwS3Xc/9kq7aiIXn8xLy9v65jeU2fSzWNU1eFHxiD4OpiwWR/pWmVGfMo?=
 =?iso-8859-1?Q?AfyvDYMT2pR2nOBMW/UiIZfQyAoKOjdH/jY/IDvIFcm65XfN1+82BjqX+Y?=
 =?iso-8859-1?Q?ylNO1rrZB6d3phLq0JlKX0RFFa8UuyCscJZsIw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CqaUO9ljWMNRh1nsLBMk0cr+/6dUie3ogzMeeok37BbxnDcXJ/vqvTGoXL?=
 =?iso-8859-1?Q?M8MAfCDg4CpLc6j807u/jkD6s4NYtPNSl9p0ctrLuI8kA5hAsTm2Df1HrP?=
 =?iso-8859-1?Q?i06SolhTndsqTs9vSfhXPyiE47sVYChIiRcJp/d+0VKqc1nUpCz1LBcLy2?=
 =?iso-8859-1?Q?rim3QASG4f0VNZQ1VKg45CMZbDsy+IckVri5wTf//Nx7Nm+3U3dL2PoMzR?=
 =?iso-8859-1?Q?v/yjpM2LyjclY6A3KZLpjASTAJ3l8PFGFnBPMmrkfjUvBzyJTqvyDlD63e?=
 =?iso-8859-1?Q?e6e4upRFEYyzybr4fBXyl0lz5OetcPq3AKCHLaRw9x1y8wHetD5Fx8znBX?=
 =?iso-8859-1?Q?Ecn55GyHFNbT7QaCerDWmFFNUe8KNOXvA24FVlx8f+gas7ypQwolJ8YTIE?=
 =?iso-8859-1?Q?Lu3YBxG8Kae9LEy9IsL3v5tSV/15Z7PtFweS2Z64M/BVZxlDHBVPeDGcQy?=
 =?iso-8859-1?Q?HXXQ4KI4ubTLOrbVlYVCVwazdVFhW9oP+FUrUxMCUymsK0r1n46nt2B5TW?=
 =?iso-8859-1?Q?JbVrghShH7mLwslNkzu/GZ1YcoRsXKEr6jTAdaz9uJuRS9UYcGM87P3e/8?=
 =?iso-8859-1?Q?R43kZY7Dnf6nHFp3XhttsOs2I6hhTPb6wbF3eUesmOPmsnoe8U5WCWzX2z?=
 =?iso-8859-1?Q?gEaEdCzUFTZc6JXomIG8eQ0MipZApCwKmzMTXFRkoJKv5nK+HZ/8ENeJ02?=
 =?iso-8859-1?Q?RzYlL8KLQaAABBu9HhsctyY0w2Q0SBElfgFAPHsHrwEq22l57/ZbD2h17Z?=
 =?iso-8859-1?Q?GN087t/5QO6SjHmUC5YNNH8BpPUcYdyh0o/u6HMlwoER4ul5p2f0bSFDxU?=
 =?iso-8859-1?Q?mwPOhah784Mk0p+TtNzQpPIJX97MNXtHtpJtFAPVOvwsXmJo77CpzGERmb?=
 =?iso-8859-1?Q?G44ACmoXfIEG0eYfFq1R3wEaEZwBwVIYjthmAHNMVJ+NpE87LWOnHQl2Iu?=
 =?iso-8859-1?Q?8XWRFygVFbp+Yx/uhBuo5nG6kRS3CDade+Hc/zlRT94emUlcO/nDj/AG9r?=
 =?iso-8859-1?Q?470hdrMCy6qIM0C2u6qcOfTEGEz+1AkRvhdd+kWS3S+XHvXeIpqxFrwpdt?=
 =?iso-8859-1?Q?tRpF6sT5KYMj0ugjbvhG2mzudysG92DdB4cI5bgs/mYJyyy8cT4LKYqqxU?=
 =?iso-8859-1?Q?iIDE6sCRc4C9gkEkYZJKbNeCzUBgFh+i2SSWjB8BpbIqBYRKJkFnycyKBY?=
 =?iso-8859-1?Q?wDivYTOX0Nr+zhLW+J+olnNGwO5NoKdVgCYnnjgj2vY8SUiSyYO6Rk0ZoM?=
 =?iso-8859-1?Q?bIBPUnjQGNjhzSTii8m2IXbBjnKU9gLv5Vm4VoJ7pExcmMp7NURKv78fef?=
 =?iso-8859-1?Q?SGrOvt1FuRy+NUMdXhOPr98aPLnmk3HJxqXpoDMns8cVyIzQ7p0VEdv+T5?=
 =?iso-8859-1?Q?NZWP/RvaMZ4PARoHBwtP+a3Fv7uT5iIsA2nXDRcK/OMp14xlv+OFApg2j/?=
 =?iso-8859-1?Q?zHYqYFhLUXTkwPLaTVftH7T66bGFRv3guC2MaqeWumYZ2lDG6rkM3rN0Qq?=
 =?iso-8859-1?Q?tpkCoRq7IYsgqHsI2OqqISr/4LRVvKDw29h4aCyRS+9VsbCdQMbD3njs58?=
 =?iso-8859-1?Q?MpfEw2e8ZQ3P3Gacw/Q9mx9y+KdB0/hqXQncZ8Bmw0gThAMyck7ZTiRk6N?=
 =?iso-8859-1?Q?RkKmrp9X3UGMwv20SGHySGHMLeEuvdqssMi5kNHzzplJO26eAv5eXc3A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c83910bf-8946-49d5-ce80-08dd1490de4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 18:24:19.3873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HAFuHfOdv0BRO9oj920V7bdknjPa5ZOHlBUvjSAVa/wYauDUNV8Eu/6H4I5NEN7KuCnnzgwhn2UhJTMv3eNUALmDYis/NVKXqtjzkUtZ1Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10679

Hi Uwe,

Thanks for the feedback.

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

I agree the hardware is complicated or the driver maybe adding unneeded com=
plexity.

>=20
> On Fri, Oct 18, 2024 at 02:00:44PM +0100, Biju Das wrote:
> > [...]
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > new file mode 100644 index 000000000000..28ed39eecb93
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -0,0 +1,473 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L General PWM Timer (GPT) driver
> > + *
> > + * Copyright (C) 2024 Renesas Electronics Corporation
> > + *
> > + * Hardware manual for this IP can be found here
> > + *
> > +https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-u
> > +sers-manual-hardware-0?language=3Den
> > + *
> > + * Limitations:
> > + * - Counter must be stopped before modifying Mode and Prescaler.
> > + * - When PWM is disabled, the output is driven to inactive.
> > + * - While the hardware supports both polarities, the driver (for now)
> > + *   only handles normal polarity.
> > + * - General PWM Timer (GPT) has 8 HW channels for PWM operations and
> > + *   each HW channel have 2 IOs.
> > + * - Each IO is modelled as an independent PWM channel.
> > + * - When both channels are used, disabling the channel on one stops t=
he
> > + *   other.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/limits.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/reset.h>
> > +#include <linux/time.h>
> > +#include <linux/units.h>
> > +
> > +#define RZG2L_GET_CH(a)		((a) / 2)
>=20
> The parameter is a hwpwm value. If you use "hwpwm" instead of "a" this is=
 directly obvious.
Ok. Will fix.

>=20
> > +#define RZG2L_GET_CH_OFFS(i)	(0x100 * (i))
>=20
> The parameter is a channel number, rename it to ch.
Ok. Will fix.

>=20
> > +#define RZG2L_GTCR(ch)		(0x2c + RZG2L_GET_CH_OFFS(ch))
> > +#define RZG2L_GTUDDTYC(ch)	(0x30 + RZG2L_GET_CH_OFFS(ch))
> > +#define RZG2L_GTIOR(ch)		(0x34 + RZG2L_GET_CH_OFFS(ch))
> > +#define RZG2L_GTBER(ch)		(0x40 + RZG2L_GET_CH_OFFS(ch))
> > +#define RZG2L_GTCNT(ch)		(0x48 + RZG2L_GET_CH_OFFS(ch))
> > +#define RZG2L_GTCCR(ch, sub_ch)	(0x4c + RZG2L_GET_CH_OFFS(ch) + 4 * (s=
ub_ch))
> > +#define RZG2L_GTPR(ch)		(0x64 + RZG2L_GET_CH_OFFS(ch))
> > +
> > +#define RZG2L_GTCR_CST		BIT(0)
> > +#define RZG2L_GTCR_MD		GENMASK(18, 16)
> > +#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
> > +
> > +#define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
> > +
> > +#define RZG2L_GTUDDTYC_UP	BIT(0)
> > +#define RZG2L_GTUDDTYC_UDF	BIT(1)
> > +#define RZG2L_GTUDDTYC_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC=
_UDF)
> > +
> > +#define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> > +#define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> > +#define RZG2L_GTIOR_GTIOx(a)	((a) ? RZG2L_GTIOR_GTIOB : RZG2L_GTIOR_GT=
IOA)
>=20
> sub_ch instead of a.
Ok. Will fix.

>=20
> > +#define RZG2L_GTIOR_OAE		BIT(8)
> > +#define RZG2L_GTIOR_OBE		BIT(24)
> > +#define RZG2L_GTIOR_OxE(a)	((a) ? RZG2L_GTIOR_OBE : RZG2L_GTIOR_OAE)
> > +
> > +#define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> > +#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> > +	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> > +RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
> > +	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE)
> > +| RZG2L_GTIOR_OBE)
> > +
> > +#define RZG2L_GTIOR_GTIOx_OUT_HI_END_TOGGLE_CMP_MATCH(a) \
> > +	((a) ? RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH : \
> > +	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
> > +
> > +#define RZG2L_MAX_HW_CHANNELS	8
> > +#define RZG2L_CHANNELS_PER_IO	2
> > +#define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS=
_PER_IO)
> > +#define RZG2L_MAX_SCALE_FACTOR	1024
> > +#define RZG2L_MAX_TICKS ((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
> > +
> > +struct rzg2l_gpt_chip {
> > +	void __iomem *mmio;
> > +	struct mutex lock; /* lock to protect shared channel resources */
>=20
> Hmm, I nearly claimed you'd not need that lock since 1cc2e1faafb3 ("pwm:
> Add more locking") but that doesn't cover ->request(). Probably that shou=
ld change. (i.e. no action
> item for you.)
>=20
> > +	unsigned long rate_khz;
> > +	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
> > +	u32 user_count[RZG2L_MAX_HW_CHANNELS];
>=20
> This tracks the count of requests per channel. So maybe call it channel_r=
equest_count?
Ok. Will fix.

>=20
> > +	u32 enable_count[RZG2L_MAX_HW_CHANNELS];
>=20
> channel_enable_count?

Ok. Will fix.

>=20
> > +};
> > [...]
> > +/* Caller holds the lock while calling rzg2l_gpt_disable() */ static
> > +void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
> > +			      struct pwm_device *pwm)
> > +{
> > +	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > +
> > +	/* Stop count, Output low on GTIOCx pin when counting stops */
> > +	rzg2l_gpt->enable_count[ch]--;
> > +
> > +	if (!rzg2l_gpt->enable_count[ch])
> > +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
> > +
> > +	/* Disable pin output */
> > +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch),
> > +RZG2L_GTIOR_OxE(sub_ch), 0); }
> > +
> > +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
> > +u32 val, u8 prescale)
>=20
> Missing name prefix

Ok. Will fix.
>=20
> > +{
> > [...]
> > +/* Caller holds the lock while calling rzg2l_gpt_config() */ static
> > +int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			    const struct pwm_state *state) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > +	u64 period_ticks, duty_ticks;
> > +	unsigned long pv, dc;
> > +	u8 prescale;
> > +
> > +	/* Limit period/duty cycle to max value supported by the HW */
> > +	period_ticks =3D mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate_k=
hz, USEC_PER_SEC);
> > +	if (period_ticks > RZG2L_MAX_TICKS)
> > +		period_ticks =3D RZG2L_MAX_TICKS;
> > +	/*
> > +	 * GPT counter is shared by multiple channels, so prescale and
> > +period
>=20
> shared by the two IOs of a single channel?

Correct
>=20
> > +	 * can NOT be modified when there are multiple channels in use with
>=20
> multiple IOs?

Correct.

>=20
> > +	 * different settings.
> > +	 */
> > +	if (rzg2l_gpt->user_count[ch] > 1 && period_ticks < rzg2l_gpt->period=
_ticks[ch])
> > +		return -EBUSY;

Do we need to allow this operation (period_ticks < rzg2l_gpt->period_ticks[=
ch]) ?

For example,
   First IO (IO_A) period/duty is in the order nsec (PWM frequency in MHz) =
and second channel period/duty in the
order of microsec(PWM frequency in kHz)

Allowing period_ticks < rzg2l_gpt->period_ticks[ch] will lead to incorrect =
operations=20
for First IO (IO_A) as PWM frequency will be in kHz compared to MHz.

According to me, we should not allow updating periods for second enabled ch=
annel.

Please correct me if I am wrong.


> > +
> > +	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
> > +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> > +
> > +	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate=
_khz, USEC_PER_SEC);
> > +	if (duty_ticks > RZG2L_MAX_TICKS)
> > +		duty_ticks =3D RZG2L_MAX_TICKS;
> > +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
> > +
> > +	/*
> > +	 * GPT counter is shared by multiple channels, we cache the period ti=
cks
> > +	 * from the first enabled channel and use the same value for both
> > +	 * channels.
> > +	 */
> > +	rzg2l_gpt->period_ticks[ch] =3D period_ticks;
>=20
> Unless I'm missing something you might overwrite the value of the other I=
O in the same channel here.

based on above.

>=20
> > +	/*
> > +	 * Counter must be stopped before modifying mode, prescaler, timer
> > +	 * counter and buffer enable registers. These registers are shared
> > +	 * between both channels. So allow updating these registers only for
> > +the
>=20
> both IOs?

based on above.

>=20
> > +	 * first enabled channel.
> > +	 */
> > +	if (rzg2l_gpt->enable_count[ch] <=3D 1) {
> > +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
> > +
> > +		/* GPT set operating mode (saw-wave up-counting) */
> > +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_MD,
> > +				 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> > +
> > +		/* Set count direction */
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC(ch),
> > +RZG2L_GTUDDTYC_UP_COUNTING);
> > +
> > +		/* Select count clock */
> > +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
> > +				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> > +
> > +		/* Set period */
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), pv);
> > +	}
> > +
> > +	/* Set duty cycle */
> > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), dc);
> > +
> > +	if (rzg2l_gpt->enable_count[ch] <=3D 1) {
> > +		/* Set initial value for counter */
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT(ch), 0);
> > +
> > +		/* Set no buffer operation */
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER(ch), 0);
> > +
> > +		/* Restart the counter after updating the registers */
> > +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch),
> > +				 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
> > +	}
>=20
> So you're not writing duty_cycle to hardware. Then you should check that =
the actual value in use is <=3D
> the intended value as you did above with period.

based on above.

>=20
> > +static int rzg2l_gpt_probe(struct platform_device *pdev) {
> > [...]
> > +	rstc =3D devm_reset_control_get_exclusive(dev, NULL);
> > +	if (IS_ERR(rstc))
> > +		return dev_err_probe(dev, PTR_ERR(rstc), "get reset failed\n");
> > +
> > +	clk =3D devm_clk_get_enabled(dev, NULL);
> > +	if (IS_ERR(clk))
> > +		return dev_err_probe(dev, PTR_ERR(clk), "cannot get clock\n");
> > +
> > +	ret =3D devm_clk_rate_exclusive_get(dev, clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	rate =3D clk_get_rate(clk);
> > +	if (!rate)
> > +		return dev_err_probe(dev, -EINVAL, "gpt clk rate is 0");
> > +
> > +	/*
> > +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> > +	 * period and duty cycle.
> > +	 */
> > +	if (rate > NSEC_PER_SEC)
> > +		return dev_err_probe(dev, -EINVAL, "gpt clk rate is > 1GHz");
> > +
> > +	/*
> > +	 * Rate is in MHz and is always integer for peripheral clk
> > +	 * 2^32 * 2^10 (prescalar) * 10^6 (rate_khz) < 2^64
> > +	 * So make sure rate is multiple of 1000.
> > +	 */
> > +	rzg2l_gpt->rate_khz =3D rate / KILO;
> > +	if (rzg2l_gpt->rate_khz * KILO !=3D rate)
> > +		return dev_err_probe(dev, -EINVAL, "rate is not multiple of 1000");
> > +
> > +	ret =3D reset_control_deassert(rstc);
>=20
> Please move reset deassertion directly after
> devm_reset_control_get_exclusive() that it can later be trivially convert=
ed to
> devm_reset_control_get_exclusive_deasserted().
> If you base the next revision on top of v6.13-rc1 you can also make use o=
f it already.

Agreed.

>=20
> > +	chip->ops =3D &rzg2l_gpt_ops;
> > +	ret =3D devm_pwmchip_add(dev, chip);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
>=20
> nitpick: Can you make the error messages all start with a capital letter =
please?


Agreed. Will fix this.


Cheers,
Biju

