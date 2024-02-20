Return-Path: <linux-pwm+bounces-1571-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D8985C0AF
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 17:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47A71C23AF5
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 16:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD477A08;
	Tue, 20 Feb 2024 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="EvBRxKwO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2070.outbound.protection.outlook.com [40.107.114.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A176404;
	Tue, 20 Feb 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445085; cv=fail; b=FrN4eiTyvXnpW9O/tEUbiaeFYvxIZsGYkmmMBwLXksTGcvdygj143uEuiAjAgXDBhuOcKtktt1I+6R1fmtHRvFxe9MiE8a27t0aazCaAvfQMGdcy6LQHoLV0lhWTt+dsM6EzO3u72OY234hruN7k5V6iygyKpNq90q6wH3zcvJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445085; c=relaxed/simple;
	bh=bL7m8+1jNZroQO6utNHHucAvZy3U9hWxS91dzK8xFbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TR9W5qrjOlPsv0eb0SWe2LJMsZCgfF7SkhRDzs7/+rMrgPqUTaDthSX2PuCS0HCWuXsmLeJmL9BEiyxpmsZge+sgHhnKu0+0ZMaBYU7XduoUwrMp3UpFHVwIyMjml56FRon9VwpOVa4opny7HPK52DlXHXQtzpH2W7MofMAwVpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=EvBRxKwO; arc=fail smtp.client-ip=40.107.114.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAeo0kPADq6wQV77aZIJtabGsRW2K4RxvtvPNjnpaDYvnZrzgrpb4lQKBLSKnTjbnUMfnsFtc5LnezrGOY4f1OmwgN0Z/O5/G4A8VsoJOO8VTtvxwnRH7c6x38TXVtWu+eGwhVHuMsacu60Mo4lFoGAhlsFyTaqgTDJetsn1Q/5W1k9+sXpu9dcdagN/3nI6iVq7GBahpHYqaFmEIxq1oHWtKoPmupwlLBi0oP3IgEHhSG0pP9HiGLKEhix0575bdKU1wyz+Kn66OSmG/sFZRR++brZrZFOlT8akFSVphUx9mus9GCJWs3Q+xPEsw6D1+jyWJUtM4gUHmottCDIi0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFxR7VhTZWr0WxfMVvEKGQQesYMZmpYbzROHD60xnCs=;
 b=jb319ppt3eshyrLVZdpij4pUp1Q0P9nld8KWe8iuY03xziOj9SK2z/Dq1pmCVu46j6sTsdYb5vBUUp89exRHeOGDOTv8xjPp/WU+s92+z8bzBz6a0N7tDS/+/1Gq1UCblShyGvGfGGFcAWbG4+4j+BiYEA1ePQdMvVIsnBLWJQi5wq8AWyv8BTzy6qaClhs33AqfHlO5nUIX4qyGXipUAGX1FZpczQceC05ddVNWAEbBRtgWziSkn0k2n+f7p9VUxwL00TyBeKPzObls4/ArfWvL5NeHngDCZ55Vwz+0yxknAPM8zLJPhkbW1BOkJda0rukKwnAwpo56ANM8gq17Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFxR7VhTZWr0WxfMVvEKGQQesYMZmpYbzROHD60xnCs=;
 b=EvBRxKwOOMNovtlPalQp7aJaKdQEsvTnfxNFQPDEuajgkGysrIf5afwcQEzTAqJQkhChLMW/O2DUDmwLAnIMIbNKU+IYJ8Katp9GP96oC8vULwppTXsQXQ+aWQNXwO4jqGUISXkj8t3+LCmdEA8hVgdjfklowfZRk0zdGhOSQYA=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TY3PR01MB10174.jpnprd01.prod.outlook.com
 (2603:1096:400:1d9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 16:04:36 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:04:35 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Magnus Damm
	<magnus.damm@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index:
 AQHaG6VjO3tWbpjOM0KBvyBIicGE/LCcr38AgAGHJgCAAD55gIAAsVCggABh/ACAAACWkIAHckBwgAA/rwCAWz9yAIAReWlg
Date: Tue, 20 Feb 2024 16:04:35 +0000
Message-ID:
 <TYCPR01MB11269807ECEDDEC9F47EA153B86502@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231120113307.80710-1-biju.das.jz@bp.renesas.com>
 <20231120113307.80710-4-biju.das.jz@bp.renesas.com>
 <20231206183824.g6dc5ib2dfb7um7n@pengutronix.de>
 <TYCPR01MB1126952E843AC08DB732C18A5868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20231207214159.i5347ikpbt2ihznr@pengutronix.de>
 <TYCPR01MB11269C233892B6E3002622C3B868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20231208140718.laekt3jlsmwvzc7x@pengutronix.de>
 <TYCPR01MB11269900EF62D8CA3E906DBAC868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <TYCPR01MB1126992DD51F714AEDADF0A4F868DA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20231213114004.cuei66hi3jmcpocj@pengutronix.de>
 <TYVPR01MB11279298D880FA94B31219865864B2@TYVPR01MB11279.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYVPR01MB11279298D880FA94B31219865864B2@TYVPR01MB11279.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TY3PR01MB10174:EE_
x-ms-office365-filtering-correlation-id: 5d35f8af-6703-42db-9790-08dc322da255
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qwUdxLBPJX5MPJC14SQSBGJ4iL3txnKH6j8vDG4EKabatA4titsHMW0AgtRLk+vdRMT0xSV72yvGRH6fnJ49aqvwp4SXnYjVU4/DXAyRKuEvqLrVOMfga/nqxGCW2hEZ+kos0CaQfeFfhuqf3jhXsNraGvk1roOiPxPbPHtYe55R9rlm2QxklQUF7c2FkcSAWM3lsGjPzPbcYzuUxKvBVMlJ7A03JVH4g4Aik8dcXxwWWbEg2WJW7IbfFMYp/V4kdQQ4WflXR/O0hE9klzqw+dUb3Tt4UJqVoq1gGJ7vuD3uy2rVK9uz+8QfJwbiTnzoFbjFpvB8bkMPMTLhIpqQKbz6nYRYlRf/Y3C0qOzl44V9UKBvkU4OfJUEJXirTQQQnCi1YXphSDEbSX72/dTbdK3a9ef8z3PBxqeJJMCV+peDf2BZcRVJQ3QT22KGLjlHdfCWmUokC7JLo04UhLFu67eMVfxb0/bTrDCVAHX3Gv8YZ7DESh3bhCyQrARKji4RVbVDdNlwSjG8fb2E5r2cHBwJ+y0KUFskUD5kEBtB0HvLZqvvASIV66c2u3rHermLfs6g7jy5z0gZP9XoS8cwHBgZ0iHgCS17d0yPOSYMqLo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5hImbV81xza1RJKrVQcnqaUtBWBwcByOkYuBRmEL/8St1jleO1RSEPzKpL?=
 =?iso-8859-1?Q?cXv59E3lIFbmJ6EjhlmtqOQxywwW3ZgnM4P2pXTgCPoSuyp86ZlPkTZ4FC?=
 =?iso-8859-1?Q?fOhI7ggupKRJyN9FeP8AWqLjYurtCaMq8OCbrIZ7RZbm4zXxfj01Gdi+/q?=
 =?iso-8859-1?Q?8XCVKXm+7br0beXjuHdS4JOYBxFclBk77cLUhDBO2Pv3yKrmMnU+E4buOJ?=
 =?iso-8859-1?Q?b6oz3PnV26CNG6ocf0AlRiVCCxG9CFUR4RkyDph3ETI1E+8ytYpE5pCRcj?=
 =?iso-8859-1?Q?boyEhSm6BIm5bRELL8LdpCXUSoxun6guf7BrgfDZFJC1Inv+rbpeP0+mwl?=
 =?iso-8859-1?Q?uC6E4zyhTE7b5loQuRA5dM9w5M65NgPjOokM+lEx9MquB8CJ0WrjkQk6ri?=
 =?iso-8859-1?Q?Lt690ZELrs6juZqlH/Dn5gtNtZckpIIGO4uKZ9GRU3evsqqECum3LiPS3g?=
 =?iso-8859-1?Q?e5nZv1Qbwa6Pv04UcBRz8xZ/Xf/MNlK4jzTGHX64QGeEFoq6l8OtPBCNU3?=
 =?iso-8859-1?Q?vyU4RBQnzBxiMug/9p4JPGwXo2p2ki7YwUXjOwHcw3eD4bVoHLNoSgTnKj?=
 =?iso-8859-1?Q?V0LpvwdAaMb6rGSVXIB6GFU07HOMKgp4ibn5PmKjdcLnHSiixPAXdrPqQZ?=
 =?iso-8859-1?Q?bPE2G1zY4ePs0QkjfHQ5y1MZP06isKidntmH4FtVp5dnntiTl6I3YzqwKV?=
 =?iso-8859-1?Q?0DZJN7FFWNV5tCqucabzUb2TuXfvAPyyyn/ZJ2uZG5NaYyvvY3NNrnx4HB?=
 =?iso-8859-1?Q?yGi/lOMK5Yua1poYUqcoa+X6+fwj2TZwcCniw+j2kjswmYQI2CavVBFrXL?=
 =?iso-8859-1?Q?P+JND1gftuGnqzdxImHc9658J+VAMPEtr9hqcVZ5mtb6SYPTz0+GQ2e/om?=
 =?iso-8859-1?Q?RobdcTt5eCCkFY1MNFNWFrUmJfOoHWd7aclWUl2UGQbtuLgR7uvQpPbtkv?=
 =?iso-8859-1?Q?RIS64nLLR2LQzdnAUDj1bXAEkt2hpPZwjSmkidYn2/FrrbY9bH2mtc4HbY?=
 =?iso-8859-1?Q?1NnGsRrMiHrT72DFyZKNqmgtkZFHWDwGSW2BlIerFEfuudfGYlYMQRqvG8?=
 =?iso-8859-1?Q?4ZlA6M+Gezpyvq36+7Euc7lfTfISvAVAGQYbKCpKyCoMXN88pwqdMETIow?=
 =?iso-8859-1?Q?KsMZkCdnJhXVAEGIgZlOWbrWZBfvsHIoht26iqi3ZbnaIRlW9iepmY2nKX?=
 =?iso-8859-1?Q?AgvtaDMxOJRnGeUq+r+f280f0OUUmYsVY60LZc+gWtVK10eXlWqcNyuH4O?=
 =?iso-8859-1?Q?kGnRqB1U67gqSjMW+tBFG9JkW6HvvMLVzuI4A2r0in1u4FGqczzSxQ5zQh?=
 =?iso-8859-1?Q?6JZQKU1eiAqIZBkWf/qu91kswYtpP+06RSkIH+L2qD3cw2XH7bcNL9Eg/x?=
 =?iso-8859-1?Q?fNW72bxEGzJK2UdJ9xxfNWozwPcxUJRLN3w3JYeripJuR9FoZZ1Q5sEOM2?=
 =?iso-8859-1?Q?npMQcU6b6ahuG+Dni6V6Euz4Nt9irY8rGEGtRRf5bpoVw+mI7awc/UgviZ?=
 =?iso-8859-1?Q?dfqNeJ87eEdEE5Dh45y5deVXU2hUOZsWbAvH/O2druvJHZcxcIsw8Svqal?=
 =?iso-8859-1?Q?zzduRGQ0+naiH1J5TZKs3JyG2HVc5kfpJ/wKbmR5BhF1iIC/u7+mYmOXtH?=
 =?iso-8859-1?Q?+HGt/Mm5om2O5r8PTIjhqIsVEpJfw9WLZKfNQkm8hq9mkrcUBX8k75Eg?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d35f8af-6703-42db-9790-08dc322da255
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 16:04:35.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqCxPNO9TQ3sYAYawtgORofRTqk58sPp3HjZCf5VW6pXcnL85eBCU3H55BfxTq0vkOnXxYmAJ+NmS8uHh0RpYy5Dtx2z88o3sxEfy5MiLoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10174

Hi Uwe,

> -----Original Message-----
> From: Biju Das
> Sent: Friday, February 9, 2024 1:39 PM
> To: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>; Philipp Zabel
> <p.zabel@pengutronix.de>; Geert Uytterhoeven <geert+renesas@glider.be>;
> Fabrizio Castro <fabrizio.castro.jz@renesas.com>; Magnus Damm
> <magnus.damm@gmail.com>; linux-pwm@vger.kernel.org; linux-renesas-
> soc@vger.kernel.org; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: RE: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hi Uwe,
>=20
> Thanks for the feedback
>=20
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Sent: Wednesday, December 13, 2023 11:40 AM
> > Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> >
> > On Wed, Dec 13, 2023 at 09:06:56AM +0000, Biju Das wrote:
> > > Hi Uwe,
> > >
> > > > -----Original Message-----
> > > > From: Biju Das
> > > > Sent: Friday, December 8, 2023 2:12 PM
> > > > Subject: RE: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> > > >
> > > > Hi Uwe Kleine-K=F6nig,
> > > >
> > > > > -----Original Message-----
> > > > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > > Sent: Friday, December 8, 2023 2:07 PM
> > > > > Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> > > > >
> > > > > Hello Biju,
> > > > >
> > > > > On Fri, Dec 08, 2023 at 10:34:55AM +0000, Biju Das wrote:
> > > > > > > -----Original Message-----
> > > > > > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > > > > Sent: Thursday, December 7, 2023 9:42 PM
> > > > > > > Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> > > > > > >
> > > > > > > Hello Biju,
> > > > > > >
> > > > > > > On Thu, Dec 07, 2023 at 06:26:44PM +0000, Biju Das wrote:
> > > > > > > > ######[  304.213944] pwm-rzg2l-gpt 10048000.pwm: .apply is
> > > > > > > > not idempotent (ena=3D1 pol=3D0 5500000000000/4398035251200=
0)
> > > > > > > > ->
> > > > > > > > (ena=3D1
> > > > > > > > pol=3D0
> > > > > > > > 5500000000000/43980239923200)
> > > > > > > > 	 High setting##
> > > > > > > > 	[  304.230854] pwm-rzg2l-gpt 10048000.pwm: .apply is not
> > > > > > > > idempotent
> > > > > > > > (ena=3D1 pol=3D0 23980465100800/43980352512000) -> (ena=3D1
> > > > > > > > pol=3D0
> > > > > > > > 23980465100800/43980239923200)
> > > > > > >
> > > > > > > Have you tried to understand that? What is the clk rate when
> > > > > > > this
> > > > > happens?
> > > > > > > You're not suggesting that mul_u64_u64_div_u64 is wrong, are
> > you?
> > > > > >
> > > > > > mul_u64_u64_div_u64() works for certain values. But for very
> > > > > > high values we are losing precision and is giving unexpected
> > values.
> > > > >
> > > > > Can you reduce the problem to a bogus result of
> > mul_u64_u64_div_u64()?
> > > > > I'd be very surprised if the problem was mul_u64_u64_div_u64()
> > > > > and not how it's used in your pwm driver.
> > > >
> > > > When I looked last time, it drops precision here[1]. I will
> > > > recheck
> > again.
> > > > On RZ/G2L family devices, the PWM rate is 100MHz.
> > > >
> > >  [1]
> > > https://elixir.bootlin.com/linux/v6.7-rc4/source/lib/math/div64.c#L2
> > > 14
> > >
> > >
> > > Please find the bug details in mul_u64_u64_div_u64() compared to
> > > mul_u64_u32_div()
> > >
> > > Theoretical calculation:
> > >
> > > Period =3D 43980465100800 nsec
> > > Duty_cycle =3D 23980465100800 nsec
> > > PWM rate =3D 100MHz
> > >
> > > period_cycles(tmp) =3D 43980465100800 * (100 * 10 ^ 6) / (10 ^ 9) =3D
> > > 4398046510080 prescale =3D ((43980465100800 >> 32) >=3D 256) =3D 5
> > > period_cycles =3D min (round_up(4398046510080,( 1 << (2 * 5 )),
> > > U32_MAX) =3D min (4295162607, U32_MAX) =3D U32_MAX =3D 0xFFFFFFFF
> > > duty_cycles =3D min (2398046510080, ,( 1 << (2 * 5 )), U32_MAX) =3D  =
min
> > > (2341842295,
> > > U32_MAX) =3D 0x8B95AD77
> > >
> > >
> > > with mul_u64_u64_div_u64 (ARM64):
> > > [   54.551612] ##### period_cycles_norm=3D43980465100800
> > > [   54.305923] ##### period_cycles_tmp=3D4398035251080 ---> This is t=
he
> > bug.
> >
> > It took me a while to read from your mail that
> >
> > 	mul_u64_u64_div_u64(43980465100800, 100000000, 1000000000)
> >
> > yields 4398035251080 on your machine (which isn't the exact result).
> >
> > I came to the same conclusion, damn, I thought mul_u64_u64_div_u64()
> > was exact. I wonder if it's worth to improve that. One fun fact is
> > that while mul_u64_u64_div_u64(43980465100800, 100000000, 1000000000)
> > yields
> > 4398035251080 (which is off by 11259000), swapping the parameters (and
> > thus using mul_u64_u64_div_u64(100000000, 43980465100800, 1000000000))
> > yields 4398046510080 which is the exact result.
> >
> > So this exact issue can be improved by:
> >
> > diff --git a/lib/math/div64.c b/lib/math/div64.c index
> > 55a81782e271..9523c3cd37f7 100644
> > --- a/lib/math/div64.c
> > +++ b/lib/math/div64.c
> > @@ -188,6 +188,9 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
> >  	u64 res =3D 0, div, rem;
> >  	int shift;
> >
> > +	if (a > b)
> > +		return mul_u64_u64_div_u64(b, a, c);
> > +
> >  	/* can a * b overflow ? */
> >  	if (ilog2(a) + ilog2(b) > 62) {
> >  		/*
> >
> > but the issue stays in principle. I'll think about that for a while.
>=20
> OK, I found a way to fix this issue
>=20
> static inline u64 rzg2l_gpt_mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64
> c) {
> 	u64 retval;
>=20
> 	if (a > b)
> 		retval =3D mul_u64_u64_div_u64(b, a, c / 2);
> 	else
> 		retval =3D mul_u64_u64_div_u64(a, b, c / 2);
>=20
> 	return DIV64_U64_ROUND_UP(retval, 2);
> }
>=20
> In my case divisor is multiple of 2 as it is clk frequency.
>=20
> a =3D 43980465100800, b=3D 100000000, c =3D 1000000000, expected result a=
fter
> rounding up =3D 4398046510080
>=20
> with using above api,
>=20
> 43980465100800 * 100000000 / 500000000 =3D 8796093020160. roundup
> (8796093020160, 2) =3D 4398046510080
>=20
> I am planning to send v18 with these changes.
>=20
> Please let me know if you have any comments.


I found another way to avoid overflow and also we are not losing any precis=
ion.

+	 * Rate is in MHz and is always integer for peripheral clk
+	 * 2^32(val) * 2^10 (prescalar) * 10^9 > 2^64
+	 * 2^32(val) * 2^10 (prescalar) * 10^6 < 2^64
+	 * Multiply val with prescalar first, if the result is less than
+	 * 2^34, then multiply by 10^9. Otherwise divide nr and dr by 10^3
+	 * so that it will never overflow.
 	 */

Here I can useDIV64_U64_ROUND_UP() instead. I will send v18 based on this.

Cheers,
Biju


