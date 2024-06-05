Return-Path: <linux-pwm+bounces-2354-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07708FD146
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 16:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FEDD1C22F05
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 14:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34E827450;
	Wed,  5 Jun 2024 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="uXZ7vBw5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11010000.outbound.protection.outlook.com [52.101.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD82C184;
	Wed,  5 Jun 2024 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599434; cv=fail; b=R4fb3G5I4Pow9n3MIIoNaJcQLJ0KeaYIs4hJqa82/UrQsSgmDqR0JTZMqdXIzIcjXDTHlbn1j6D4CoG0Cd3n37zhLvhNvcJX7FUYRi2AKY/znfrZgJ/8WXh1GB+lVnELKs/efuQhDkbJDJ23gehczbHFLZWOv+EADhSaZLMLdh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599434; c=relaxed/simple;
	bh=WZ8j9czpzPk2rjzy8wEMfFk8FditZDJsZAJRiHpyJI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D0r7w8aQnfP2FKAB9MQnbt528ArmXxlRjDYMYhMDufOp0qGMFGRjzPDFGUW1nhCnZYbcAsUlMP5zi78w8dYI6UTm7Mm/1UDE0hLImLBuvbPi/jT9Ni/Iiu6ZCtm/NQxcBwg9+r5NW1smvcj/i/fB1YgGNP7W1FKgYlyEwNxDmU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=uXZ7vBw5; arc=fail smtp.client-ip=52.101.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VThoiOzUKbjGRXCQIOOi+V7MHU+LdHAkbg9vQjOgg9Jc6drDosanw8Nc7/VL+C8FITWp8qb8YRfnsA83JwDfm8Cm8O9H1NhgAjOWhAybCdWZZsdAzA5FFa+p4vlhSJJcsHc1APHu0JlY7x662fZhhJul8FTD6PVOQHlSHqcisiWdXhkJAcwNqJxX96L2ePu6kawNw2tcqZ2Ll3xu0gb0S4e31dHWwUTPl/a3J308FROoU8j3upHJWGVPd74+6CEpf+xMDuwzUwWkAwVFVILLSvLVVHs7uDuzYLw9i4zqF4vHFSwbQ1itc3R8uQdVlWTnY9SoTPjYolKYnTvrUa5iYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg9jfFaxJ59v+6NGwre59Fq+BoOvGd+QPEN2xJmdKLM=;
 b=R7NXv+erLdKa+j7FH/XQZusnhJk8UgMpYcmUuZ4A2uisXtc/sjMV3GnVfOp2yEGGxCSjtBNNszLC5Dj7UMMx3PvvL4hIfRTFW2Zci7sQfRJ5B1nRacTBtm/OqqgVVYfFc/cvnmbu7FWeOvQQ6m0P+WWJ6erxvDMsHzSnzRngK9Z4xp77s53RliXHDSgyYWY5+VE9NonWmRisZ7Oy6CwW2VFsk3PKbV9bW+L0u1wnOu/xbLKO2ZXjPoV2k2nuDVKVqTEd0QIJJAIdlnxwTfXL3UJC4QnwvkxwOxXyAvX9RBr7Uq2331ZofBXRiFSY6ghFk9w4lkAHjhR4Z4ZE305lUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg9jfFaxJ59v+6NGwre59Fq+BoOvGd+QPEN2xJmdKLM=;
 b=uXZ7vBw5F6jhTmMurQ33dwsmtsJ0h+/XWX6mIq5VxabDP8fLR+K7egPnpHRQ9xqaZfzra557g3f1deJ0t0PD118iluUhvFDI1PM8t8p46ke3uptsUA/rqfOBno9XRvYLB29BXCrZo1b7mHdsb9i1AklZTqOREshYYnuIaoSsbb4=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYCPR01MB6772.jpnprd01.prod.outlook.com (2603:1096:400:b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Wed, 5 Jun
 2024 14:57:08 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 14:57:08 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v19 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v19 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHaduYn16v+zacEeU2GxZ7ljgKlZbFudvgAgEtDgKCAAAhocA==
Date: Wed, 5 Jun 2024 14:57:08 +0000
Message-ID:
 <TYCPR01MB11332A720784C4429BB2E298386F92@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20240315143558.221340-1-biju.das.jz@bp.renesas.com>
 <20240315143558.221340-4-biju.das.jz@bp.renesas.com>
 <xy7qcimczmqyzk2zvysr3mdkzl3m54cjvh2pxx4d42dc7atyvs@itbq2jr4ghmo>
 <TYCPR01MB113321144DE4E9F0D75F8308B86F92@TYCPR01MB11332.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB113321144DE4E9F0D75F8308B86F92@TYCPR01MB11332.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYCPR01MB6772:EE_
x-ms-office365-filtering-correlation-id: ff55d3ce-0cc6-4841-74d3-08dc856fc5bb
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ytyLWZrJRwQvAHQSIhcvWbJqc6NjjvwmUy2+TQKuhmLweo3UUqd6ZQEcJW?=
 =?iso-8859-1?Q?zJ5gQb8x0N2WdDCwgUavCk8BoQam892NB54mXzqiUELAoWfpdWBbQR5ltk?=
 =?iso-8859-1?Q?CKHBzxlkBQwusd3kSj8Dye4PjTPfointmaQg0LL78uX785eH+2YNb3/xd0?=
 =?iso-8859-1?Q?LhtkwEb6RSPRpLcRO3oqPkbSZfFsf8OJKhEMxx1S0w0gDJ73TvaN6TAP2x?=
 =?iso-8859-1?Q?LB0XXZQiri3GXH9Kl13ULVBP6wntqbDwLwZ0vwO9Ck+dQvdbYbL6Yaa6fr?=
 =?iso-8859-1?Q?iYQkelFm2V7S1eteAcUzDExIn2a7cwW3n9BMYVySUsdzTMrKxVI1QfnIc4?=
 =?iso-8859-1?Q?nYLIMfHI6fVBVirNJT1J9fovps0OhVXSk2+oS0Ix3PcGr+tD4nCoOzxoxJ?=
 =?iso-8859-1?Q?ZxtSTpd4+oaCoiSDDG1gEsZGfWhCS+DNs0pFKSDSoUyg3PMECRoicVTPOC?=
 =?iso-8859-1?Q?nbpZAFHoqt/3xc//7UmJLt70zKFq8LoUYaHsdBLLtJlVRouZ1jpHXnJMJR?=
 =?iso-8859-1?Q?NJwXgFWTc5+xtLhhnIa3y2mrrDQUf1Yix1SkbDY4K9B+qRZt+iDpi7repI?=
 =?iso-8859-1?Q?XKJps+JznhKrvSpb3sx3tSGt/sK08fd1usLSaYP4C0LhnQ3n8mWwVVcHA7?=
 =?iso-8859-1?Q?e6BnA1yoI8K3uGWlysy1PzsdRBYP+9PbBHeZzKsjBdmhG+5jlvmq0ndSBe?=
 =?iso-8859-1?Q?YQdJwa7sbvzfchOa/x91H2NXCBjhdIsyfLz4mImRt3rWmZKy2HMrzW1ewH?=
 =?iso-8859-1?Q?jOjlG0ZU3nMfRYuFgZWmCruqEMITvIfSn+cK8p6FuFXDX6PVi3Ao4Vyrno?=
 =?iso-8859-1?Q?quW5XD32ofm7CsHtWe6V4vvV9wYsWyPIkBFLxdLuovtKAUwe8u4tsn/wD2?=
 =?iso-8859-1?Q?rflOfFNHjUo0Anwo5Tla0uyRrLBL/jAwaJOthr3NGUFrd3FIIDf3rYWoUi?=
 =?iso-8859-1?Q?ZQey0UUoQYMIiu1P3G6e6VibW1Z2S97fFTf1HAW/ZMDdLrQTAmRJLvITeG?=
 =?iso-8859-1?Q?WzcXPfaXJHl4mVdIXdotD1dWdk/xiqW2mKRLCEz+mI+Jk31sp0S73dzS/P?=
 =?iso-8859-1?Q?jp9wRAguqXICtkt8wny7BqsusA+UlZ87dET6twRxpRMTJT1u9PDf6hdrD+?=
 =?iso-8859-1?Q?x1ac/XEU18WQVrpivqdOdHJDWXrORK4QX+m6K5XfV7sChSCM8ARZRSoiG6?=
 =?iso-8859-1?Q?jvUMipE3hhCe1Qf6AFl6dOgCVDoggnvxp8cq7P66Q4iTCLnoRPaGuqj5w9?=
 =?iso-8859-1?Q?UchHdQia0svZLf7HZHpyZongNgPOZwvSk9L7YihWASuVneApFxe7nsGyHV?=
 =?iso-8859-1?Q?8FDi1PakhxIWi3Q2iXwVaHEZfgTiRpA7yFY0ODShKC3ckY2bTXIqY6EHg3?=
 =?iso-8859-1?Q?LYk80+ztqmGkKpKJvtn1fNxr1RYFF8LaWUyffNPxB7DTdP5qg7zFo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yKd70LF6/upXUBUZCuUiPOn473D+8qKT3Njq0PlREwFcdCE+K4JcaABe/K?=
 =?iso-8859-1?Q?K3/J+GY69lgOfy+oihphKCBaJg/hhDdASBXk5MeHlciRgH+TrDMKsQjuQP?=
 =?iso-8859-1?Q?tleq6JO30K0/2455UCfL/HH+yZmEmIM0hFkPSG0pqEFSK6ECzd36iZ8vNb?=
 =?iso-8859-1?Q?RfLCQUQNwUM0AhO03pulwSMH2oqWtsVRs4IKrAp5SxculIunxNbMSDvoEh?=
 =?iso-8859-1?Q?lFTH0DeP6uigtwEc84J8qxwyiZ5F9g0pH9wIxWcBgXenYMPvtDC/UzBLop?=
 =?iso-8859-1?Q?CEued35ERmomlNQcuPLRBXBhbOOuq4j/ykKGHe8OiLkxUDgTr5gsVbjl8J?=
 =?iso-8859-1?Q?7NGBGlWcHCo1ZqUFwkhGKeU5OjFizU/W/Hmu7L0Zr5N6CgSJmnzSbvDr7a?=
 =?iso-8859-1?Q?/dnWx80b1wupdm29tvuRdm2ZM6D3lDZGdh1MGEZDy5NhU7n/zVNfue1p2d?=
 =?iso-8859-1?Q?ziF/nTm5nw4dlyauozXl+lc5amZGLErduAONrgSUkgCYI0IITv7xpjEVEx?=
 =?iso-8859-1?Q?QJh139yb1A2BeVjs8pKaK5+ZFJna8b8k8ul5Gm0VTw2irTCmtTGOf+fQkN?=
 =?iso-8859-1?Q?OrNq4bkG/onDoANis7mijGct77Ux75uzhqUBGvVFJSm6/AoZJwdmPiTdkY?=
 =?iso-8859-1?Q?sx6NLZAn9XNo1wMNF3H7B4D57JV4zuwvAbWgdKAnjEggCOSt79Qfvu9CUt?=
 =?iso-8859-1?Q?KaxpXBUYWHASlvi+QBA2ZfS3yO44Ml+ctATzU0oTVyrvgyZgTmJo2df2w1?=
 =?iso-8859-1?Q?jvYtbg/2k3q9ZjUePyUBxk69BFLLxWSKz2bbN7GKtV+3Y+GIYBpqZNuR/6?=
 =?iso-8859-1?Q?aseTrBUfvWX1vDNU0PnIdTOevqFLbqkDAz6gChaNwEDUMylMmMi5HNOHWf?=
 =?iso-8859-1?Q?WF7qolK1gr8PQSeVS+VeOOY66dTX1ROt/fq9BS7/bx2bHuPfsHOYL0jX59?=
 =?iso-8859-1?Q?PZaliUNCdZEgAb3iIZwgshUt/XTMKHZdRwq9uQ2v1R8WymrF9IHJtBykUJ?=
 =?iso-8859-1?Q?lRJKIeETWpJsluiZ9LnmsAjcVmzEg+VGyagfzG6kRbiYPWWphSL16BxuNn?=
 =?iso-8859-1?Q?fsWkbhUJV1ECTsjufon5bDmPpX+uux/U7iRoVSBG+4NowJaxdQW/+fPRPq?=
 =?iso-8859-1?Q?GdebZQl6EzhRL6pFJvfMDXM2cqo2YRCteegeNKAoDkk4tF9ysS3IGPieQT?=
 =?iso-8859-1?Q?ysMqpon3OIs8pNzewoW9wn86SstyXs5aSXSsuNE2eAoceofLZoL7fhmiMM?=
 =?iso-8859-1?Q?8xJImdwAi9JwebOJBGLmdEMqEKMpeJWAf20ORrvJT36IUEJs1GzDCG0cF3?=
 =?iso-8859-1?Q?PReZF8o74dRmJRZUteXjOK6XpmJSAVc+J1M9TZ4+HzE5GV964j9z1wjbVQ?=
 =?iso-8859-1?Q?fkEPSfdoj6lVS1x/wRJja9/GfIGYYSzYKsrRsYw+RM1JLkxGplNywROc6Q?=
 =?iso-8859-1?Q?IDhufSDLAbHknWfVvPaiMH49VHm0lm4v5YzxEYNQI6A/wgFRPvjaZzm1/9?=
 =?iso-8859-1?Q?JYT/PAh4c1aGR7kKutXQY08F+1QSW9kLzjY904rnn0xwZz2bUl19V0vI9s?=
 =?iso-8859-1?Q?06ij8rN4owfJDMwIQHUDJ/aASvtPv5dvAMPMNdaGtyUC/TNpOLqcfqrcJs?=
 =?iso-8859-1?Q?6+siiKiEI4ydXm4bPrCsg4G0wFW4SdpBVQO6AE0YtdJ2B9N5a4qG11zw?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff55d3ce-0cc6-4841-74d3-08dc856fc5bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 14:57:08.4970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rdF+/yz7PMxtljgxMXpY8Q38pa7Hu+Z0EZypcCnCKTbhOtgMCLGiVKpCkiqINXxwatC8FLbK+tRLdl/IV3OGzAZnifcB14Jymgmv5Jy5cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6772

Updated Uwe's Mail address as "u.kleine-koenig@pengutronix.de" is=20
returned with below error

Error Details
Error:	550 5.0.350 Remote server returned an error -> 550 account closed - =
please contact info@pengutronix.de instead=20

Message rejected by:	metis.whiteo.stw.pengutronix.de


Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, June 5, 2024 3:53 PM
> Subject: RE: [PATCH v19 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello Uwe,
>=20
> Thanks for the feedback.
>=20
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Sent: Thursday, April 18, 2024 6:04 PM
> > Subject: Re: [PATCH v19 3/4] pwm: Add support for RZ/G2L GPT
> >
> > Hello Biju,
> >
> > thanks for your patience. I'm quite behind on my review tasks.
> >
> > On Fri, Mar 15, 2024 at 02:35:57PM +0000, Biju Das wrote:
> > > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c
> > > b/drivers/pwm/pwm-rzg2l-gpt.c new file mode 100644 index
> > > 000000000000..8c88f5d536fc
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > > @@ -0,0 +1,542 @@
> > > [...]
> > > +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *rzg2l_gpt,
> > > +			    struct pwm_device *pwm)
> > > +{
> > > +	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > > +	u32 val =3D RZG2L_GTIOR_GTIOx(sub_ch) | RZG2L_GTIOR_OxE(sub_ch);
> > > +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > > +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> > > +
> > > +	/* Enable pin output */
> > > +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR, val,
> > > +			 RZG2L_GTIOR_GTIOx_OUT_HI_END_TOGGLE_CMP_MATCH(sub_ch));
> >
> > That doesn't need protection by the lock?
>=20
> OK, will add this inside lock, similar for below disable case.
>=20
> >
> > > +	mutex_lock(&rzg2l_gpt->lock);
> > > +	if (!rzg2l_gpt->enable_count[ch])
> > > +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, 0,
> > > +RZG2L_GTCR_CST);
> > > +
> > > +	rzg2l_gpt->enable_count[ch]++;
> > > +	mutex_unlock(&rzg2l_gpt->lock);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
> > > +			      struct pwm_device *pwm)
> > > +{
> > > +	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > > +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > > +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> > > +
> > > +	/* Disable pin output */
> > > +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> > > +RZG2L_GTIOR_OxE(sub_ch), 0);
> > > +
> > > +	/* Stop count, Output low on GTIOCx pin when counting stops */
> > > +	mutex_lock(&rzg2l_gpt->lock);
> > > +	/* Don't decrement, if ch_en_bits is set by the probe */
> > > +	if (!test_bit(pwm->hwpwm, rzg2l_gpt->ch_en_bits))
> > > +		rzg2l_gpt->enable_count[ch]--;
> >
> > I don't get the reason why this is skipped if ch_en_bits is set.
>=20
> During testing I found a issue, where disable is called and its value is =
going negative. I will
> remove this check, increment enable_count in probe() for bootloader enabl=
ing pwm case.
>=20
> >
> > > +	if (!rzg2l_gpt->enable_count[ch])
> > > +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST,
> > > +0);
> > > +
> > > +	mutex_unlock(&rzg2l_gpt->lock);
> > > +
> > > +	/*
> > > +	 * Probe() set these bits, if pwm is enabled by bootloader. In such
> > > +	 * case, clearing the bits will avoid errors during unbind.
> > > +	 */
> > > +	if (test_bit(pwm->hwpwm, rzg2l_gpt->ch_en_bits))
> > > +		clear_bit(pwm->hwpwm, rzg2l_gpt->ch_en_bits); }
>=20
> I will move this in apply.
>=20
> > > +
> > > +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip
> > > +*rzg2l_gpt,
> > > +u32 val, u8 prescale) {
> > > +	u64 tmp;
> > > +
> >
> > 	/* This cannot overflow because ... */
>=20
> [1] < [2]
>=20
> The max calculated value is
> [1] 2^32 * 2^10 * 10^6 =3D 4,398,046,511,104,000,000
>=20
> [2] 2^64               =3D18,446,744,073,709,551,616
>=20
> I haven't add this as a comment, as it is clear that calculated value is =
< 2 ^64.
> If it is NSEC_PER_SEC, then it will overflow.
> Basically to avoid overflow. we scaled down by 1000 for all calculation a=
s rate is multiple of
> 10^6.
>=20
> Please let me know, do I need to comment this?
>=20
> >
> > > +	tmp =3D (u64)val << (2 * prescale);
> > > +	tmp *=3D USEC_PER_SEC;
> > > +
> > > +	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz); }
> > > +
> > > [...]
> > > +static int rzg2l_gpt_probe(struct platform_device *pdev) {
> > > +	struct rzg2l_gpt_chip *rzg2l_gpt;
> > > +	struct device *dev =3D &pdev->dev;
> > > +	struct pwm_chip *chip;
> > > +	unsigned long rate;
> > > +	struct clk *clk;
> > > +	int ret;
> > > +	u32 i;
> > > +
> > > +	chip =3D devm_pwmchip_alloc(dev, RZG2L_MAX_PWM_CHANNELS, sizeof(*rz=
g2l_gpt));
> > > +	if (IS_ERR(chip))
> > > +		return PTR_ERR(chip);
> > > +	rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > +
> > > +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(rzg2l_gpt->mmio))
> > > +		return PTR_ERR(rzg2l_gpt->mmio);
> > > +
> > > +	rzg2l_gpt->rstc =3D devm_reset_control_get_exclusive(dev, NULL);
> > > +	if (IS_ERR(rzg2l_gpt->rstc))
> > > +		return dev_err_probe(dev, PTR_ERR(rzg2l_gpt->rstc),
> > > +				     "get reset failed\n");
> > > +
> > > +	clk =3D devm_clk_get(dev, NULL);
> > > +	if (IS_ERR(clk))
> > > +		return dev_err_probe(dev, PTR_ERR(clk), "cannot get clock\n");
> > > +
> > > +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "cannot deassert reset
> > > +control\n");
> > > +
> > > +	pm_runtime_enable(dev);
> > > +	ret =3D pm_runtime_resume_and_get(dev);
> > > +	if (ret)
> > > +		goto err_reset;
> > > +
> > > +	ret =3D devm_clk_rate_exclusive_get(dev, clk);
> > > +	if (ret)
> > > +		goto err_pm_put;
> > > +
> > > +	rate =3D clk_get_rate(clk);
> > > +	if (!rate) {
> > > +		ret =3D dev_err_probe(dev, -EINVAL, "gpt clk rate is 0");
> > > +		goto err_pm_put;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> > > +	 * period and duty cycle.
> > > +	 */
> > > +	if (rate > NSEC_PER_SEC) {
> > > +		ret =3D dev_err_probe(dev, -EINVAL, "gpt clk rate is > 1GHz");
> > > +		goto err_pm_put;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Rate is in MHz and is always integer for peripheral clk
> > > +	 * 2^32 * 2^10 (prescalar) * 10^6 (rate_khz) < 2^64
> > > +	 * So make sure rate is multiple of 1000.
> > > +	 */
> > > +	rzg2l_gpt->rate_khz =3D rate / KILO;
> > > +	if (rzg2l_gpt->rate_khz * KILO !=3D rate) {
> > > +		ret =3D dev_err_probe(dev, -EINVAL, "rate is not multiple of 1000"=
);
> > > +		goto err_pm_put;
> > > +	}
> > > +
> > > +	rzg2l_gpt->max_val =3D div64_u64((u64)U32_MAX * USEC_PER_SEC,
> > > +				       rzg2l_gpt->rate_khz) * RZG2L_MAX_SCALE_FACTOR;
> > > +
> > > +	/*
> > > +	 *  We need to keep the clock on, in case the bootloader has enable=
d the
> > > +	 *  PWM and is running during probe().
> > > +	 */
> > > +	for (i =3D 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> > > +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i)) {
> > > +			set_bit(i, rzg2l_gpt->ch_en_bits);
> >
> > The tracking of which channels were enabled by the bootloader is more
> > extensive than that of other drivers. (That's good from a correctness p=
oint of view.) I consider
> doing something like:
> >
> > 	for (i =3D 0; i < npwm; ++i) {
> > 		pwm =3D &chip->pwm[i];
> >
> > 		pwm->state =3D { 0, };
> >
> > 		ret =3D chip->ops->get_state(chip, pwm, &state);
> > 		if (!ret && state->enabled)
> > 			chip->ops->apply(chip, pwm, &state);
> > 	}
> >
> > (with some more error checking) in pwmchip_register(). That should get
> > the usage count's right, but would (maybe?) conflict with your
> > handling here. Anyhow, that's orthogonal to this patch for now (and
> > needs some more thoughs. For example it might not be a good idea to
> > call
> > .get_state() and .apply() without request before. Also it might not
> > work for chips that cannot be disabled in hardware).
> >
> > Back to your patch: Maybe call .ch_en_bits
> > .bootloader_enabled_channels instead? Also I think this could be
> > simplified (but not entirely sure I grabbed all the details, so take
> > this with a grain of
> > salt):
> >
> >  - In .probe() set .bootloader_enabled_channels[i] if pwm#i is enabled =
and
> >    ensure it stays on.
> >
> >  - In .apply() replace the code that is supposed to enable the HW by:
> >
> > 	if (...->bootloader_enabled_channels[i]) {
> > 		/*
> > 		 * it's already be on. Instead of reenabling in hardware
> > 		 * just take over from the bootloader
> > 		 */
> > 		...->bootloader_enabled_channels[i] =3D 0;
> > 	} else {
> > 		enable_hw();
> > 		... get pm_runtime reference etc.
> > 	}
> >
> >  - in .remove():
> >
> >  	for (i =3D 0; i < npwm; ++i) {
> > 		if (...->bootloader_enabled_channels[i]) {
> >
> > 			... drop pm_runtime reference, but don't disable HW
> >
> > 		}
> > 	}
> >
> > Does that make sense? Did I miss anything?
>=20
> I agree, it is cleaner now. Will send v20, if you are ok with it.
>=20
> On the probe()
> -                       set_bit(i, rzg2l_gpt->ch_en_bits);
> +                       u8 ch =3D RZG2L_GET_CH(i);
> +
> +                       rzg2l_gpt->bootloader_enabled_channels[i] =3D 1;
> +                       rzg2l_gpt->enable_count[ch]++;
>=20
> On Apply()
>         if (!state->enabled) {
>                 if (enabled) {
> +                       /*
> +                        * Probe() sets bootloader_enabled_channels. In s=
uch case,
> +                        * clearing the flag will avoid errors during unb=
ind.
> +                        */
> +                       if (rzg2l_gpt->bootloader_enabled_channels[pwm->h=
wpwm])
> +
> + rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D 0;
> +
>                         rzg2l_gpt_disable(rzg2l_gpt, pwm);
>                         pm_runtime_put_sync(pwmchip_parent(chip));
>                 }
> @@ -366,10 +363,18 @@ static int rzg2l_gpt_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>                 return 0;
>         }
>=20
> -       if (!enabled) {
> -               ret =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
> -               if (ret)
> -                       return ret;
> +       if (rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm]) {
> +               /*
> +                * it's already be on. Instead of reenabling in hardware
> +                * just take over from the bootloader
> +                */
> +               rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D 0;
> +       } else {
> +               if (!enabled) {
> +                       ret =3D pm_runtime_resume_and_get(pwmchip_parent(=
chip));
> +                       if (ret)
> +                               return ret;
> +               }
>         }
>=20
> - .remove
>=20
> @@ -410,8 +415,8 @@ static void rzg2l_gpt_reset_assert_pm_disable(void *d=
ata)
>          * count. Before apply, if there is unbind/remove callback we nee=
d to
>          * decrement the PM usage count.
>          */
> -       for (i =3D 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> -               if (test_bit(i, rzg2l_gpt->ch_en_bits))
> +       for (i =3D 0; i < chip->npwm; i++) {
> +               if (rzg2l_gpt->bootloader_enabled_channels[i])
>=20
> Cheers,
> Biju


