Return-Path: <linux-pwm+bounces-4964-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9643A3EE9F
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Feb 2025 09:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4C97A8DED
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Feb 2025 08:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E6C1FC0FB;
	Fri, 21 Feb 2025 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="HcGdXJN4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010013.outbound.protection.outlook.com [52.101.228.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58012AEF1;
	Fri, 21 Feb 2025 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126086; cv=fail; b=I6URG/KGO6aLU3qyhO1QZrSP3MNoGmuLM0hzRS2H6M9Lfv2tfx5O2q8uPkJ2mj7g7Y9qQY74oVX0A91zFhU7nODcqBXF1+3eaTbOWqeghbE0igKzJuPil1QSRHW20Y7T4QafwGLbayMSC13BR1Lx+cTI1Qlc4Z0WeBLVUNP8rbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126086; c=relaxed/simple;
	bh=dGoFjfCBCMORRg16vXjadlN8WNBcAStiA8kvl++lja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QmtZMcB+qSWauxEKczsXY1vULt1gatNPQW04sQPlVo5iUexg/we7PGzh6wqkkvFPGIOgnuPlO1bfpK1bIzgCbrPP5DAsfYRDrru8b9lRpv27yQpnGjIds9mzED2um3k+Tz2BpMK4/0VdN3CsE8wX085UJbEzvmXgS0wRmA0+aqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=HcGdXJN4; arc=fail smtp.client-ip=52.101.228.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMN7sYg3xFo4QdfkoZrKwILSuV3wvCziBnWZeA8CFwMCl397nMHaQ9fsX8AYvUC3GGFmub4L6CvPjbLWd2NzoC0t/ysS3t994UoJjvxYV+uGL5wlVuwqZRnTba7xHO+DXsLhnJv9alvxWRnlmZlKRiTRFBOZmQH6M35Km3Pww0V5MLKXdhzcZV7Iwkb5sJLATkzBAhY+XZBC+1b4T3rUlFng62tZIe72gtw68ZdIBUGIc2O31xMAtDMkpE7YO+ubvqk4SLpshZl7geA8G+uRNkzvsWxFReISOqwwi4rBafKA83WhTY8mVItwWj2UGSMGsckV7cdQVIPNxN6/imGXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGoFjfCBCMORRg16vXjadlN8WNBcAStiA8kvl++lja8=;
 b=KjO+kmjgZtIbZOESP+8fKfKitTxhVkZGXV3oyLI9QoKtfZgUqMV7nQc/3/kUYRguEqWGaMuZPttEN9wSkgKSaxTduoD1/RqrSM6e6sAPk2kWCib0g/SJOosKsg6I5ryE1tXN+ZWX+h35YOZahT7L/iMihWEpGGyrNxG+5ixnPZjdkUQd9AAm7qq5IWbzm7nB4gyFALhBZPNSuMPoiTsm9LVyLVoztjEPCfzRC33XRGq1v1HDM5Koha9ieR44GV4+xrd9sJq55+/ybNYZK2HsLKQv8sQRgfDpUcQK44Nvq/hk7X1ZqJ1VYdxAzbK3Hv/VVtGEWqs1sFNX18Egt0G+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGoFjfCBCMORRg16vXjadlN8WNBcAStiA8kvl++lja8=;
 b=HcGdXJN43j85ACpssCesBjsxxwYZ7c1XHbf0y4Y1liym0v4gAvNhQcBzG1sBZUNSq5M0udORaGztr6hcfSRjJ1Wa6XOHodT71FyD/Fe5/BK7u8yYtfUTiSilq3nC85u/6RLzIIkYcJr4u0TiNmVU/rNaU3wXptyHTQeD2Mg8lzE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB8461.jpnprd01.prod.outlook.com (2603:1096:400:176::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 08:21:20 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 08:21:20 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: kernel test robot <lkp@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHbUIfEye5JKGoBg0O4godryy/UCLLsKj8AgCDikqCAAUJZAIAAAFoggEOCZUA=
Date: Fri, 21 Feb 2025 08:21:20 +0000
Message-ID:
 <TY3PR01MB113468D1C6E2EC2EBA903BC4986C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241217132921.169640-4-biju.das.jz@bp.renesas.com>
 <202412182358.9wma1UUE-lkp@intel.com>
 <TY3PR01MB11346CC402843A628226F5C6186122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <b7woae7iquvuzs4vcollns7qcyand4ginrbjqs75bnsiockrjc@c4pyody6zdcr>
 <TY3PR01MB1134690173EBB583582DE8E3386132@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB1134690173EBB583582DE8E3386132@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB8461:EE_
x-ms-office365-filtering-correlation-id: 85c75599-8bf0-4ef4-0e19-08dd5250b8ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?t/gX0YiotQpS3LQlga3jrXCvrow4RuirQoQg4PDwUT4B92nBg7j21RX0z0?=
 =?iso-8859-1?Q?UIkL6qdmagVMMIPGnYpeyhX1Km4RtMe0M58CLqWvn7Nvhlf/6sIx/AsLu2?=
 =?iso-8859-1?Q?lf7+w0aRu4nFJJS4+ragBTi7SRNA1Rvt9ZzOTqHyczv2u0OC6mJ8yVnC6X?=
 =?iso-8859-1?Q?/6TgoEGatl8NHyHY5pxIx9AP4VZHmK2Lj3ZlWy+scX05RhgfrrZgdnha/+?=
 =?iso-8859-1?Q?xpEazPdD3EMIEujtbHNOC36aJauIZUlUE7nWfAsnjj29sSnzBt3pP0LmkF?=
 =?iso-8859-1?Q?vfgzhPbeIWavClrrZzPiMDcrT7PjvfENfjU+J7iPBMg96+7tUwPkRW6sZV?=
 =?iso-8859-1?Q?P8H1b9l2bED1If/Be8YN3IzZvXgj9m1C7Aa8qR5DLyo/dSAirG2G+/1302?=
 =?iso-8859-1?Q?ni354pC35RFgokt6LqD+74Npd2rV4kTwJh2PuoB0DE9g+fuTvnklBew1fc?=
 =?iso-8859-1?Q?9R6sdPlg2dsRRMWER3vIkCzSAUi0HNJ9EF6yefh7Ai0w0NXGiPNjoZ9Qya?=
 =?iso-8859-1?Q?Tf5XKxb0A5i1axAqYUwAoVMk2GqQCinOCKTNAp2GzjFKqT1LxNrjbdQdzL?=
 =?iso-8859-1?Q?17f80YkILZgMicPxep667FP7SxLYTuaehgPGP72F3lMVZ2DIwlJ7hd69j5?=
 =?iso-8859-1?Q?kG6UcS6vK9a1bOOWzqt8BVrvLhdnmuske8o15VrxSklu2Ku+uAolCJONh3?=
 =?iso-8859-1?Q?8fAHd/YeI2lCoygc4QVLx9AE0fxYNccER21VpR1j/233+IbBxkIS8yi+qc?=
 =?iso-8859-1?Q?uPom8g3ZZFTGmqsh318IlEWi7CHGo9NfA9Vd+pQvWOenINJ7IVZeK5EBEG?=
 =?iso-8859-1?Q?epd01fMdMJGgoPdf9EroWn0EJnlddKgNwgIA88Cjf3ArvNEhSor3p/mPhS?=
 =?iso-8859-1?Q?hNx/+qxWqtaIQmcCOgG0CcwamAhEL3JlBBHkyTCJisAIamiQzUpl0X0pGX?=
 =?iso-8859-1?Q?2aQRxxiGIlmNHR3Ua6HU9kRUgvPxN95R+O127CK/WAy3eWulqqAbG6QqBP?=
 =?iso-8859-1?Q?EcLPGtZtsEgFD/GIeLgvy9rsjlqtsAu1/KWBo0fq7byxkbbZCnVWJ36UD0?=
 =?iso-8859-1?Q?L6+b+MDRGkdSllqzuIuGT45PszL4o7DmEnQMpvI8+tdLY36eJJ20ltMQDA?=
 =?iso-8859-1?Q?C/u5tR//Ha/NOYrdNTZ7M8WnWf9CEElGreREETWyllF/t/SjC8/h32g7SD?=
 =?iso-8859-1?Q?DvObWHAO+8tDMD6PU9DwMHhx7MhFXi02d1MgFmNP5D5DaogMaXx/waZW7G?=
 =?iso-8859-1?Q?yP6ncYzhciZaWLwvmYUX6YFqzyEyCY/4Xzlfo1minlfAAMlxByrLPfduqZ?=
 =?iso-8859-1?Q?n+6uHol+ECDxUEKNmsbOXofs/7pFWvZMKaXH2WXCRkCF4ypxEpEHw2f9fO?=
 =?iso-8859-1?Q?gM+CTuLDZ2L29DI2chcEibofS3zxgPtt5929lu5Nnikr/1xvZHh59hX7No?=
 =?iso-8859-1?Q?uV8jFxVe6I3ONKk1xYS152OHLM/WrbRoB8qTK0+3SSZVFDsxkbepKoUiRq?=
 =?iso-8859-1?Q?H/ik9rZAjrx9S8dVji3x5T?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xpfZY1ZMNrPBaWuFRwnnstrMC0ZmKylGt00Np1tZrIVjztVgQGLb0wgChv?=
 =?iso-8859-1?Q?oA1sGiRyqW1CT0iGCtNlnd45LEEJnrrCgH7H1ckpupSVf6B93eIRKukchU?=
 =?iso-8859-1?Q?RcrLmlQp0LLXqaf2gSpUGKvaFy11MY86rf1IQRmEtrVQBgdzRev2e25bhL?=
 =?iso-8859-1?Q?WDc8St666BTogID9VPIVyrkZ1AqNfEpVmiwnS11jizWFgHR7aiDYdzKRus?=
 =?iso-8859-1?Q?1/KoS1gkMJirWnpKIr+gz5jbl30/xJH2mHymv1vY5FXbhzmBFd/N7VQUiV?=
 =?iso-8859-1?Q?BGRd/RZtKlXSoft0lopWqkAv25RdwxYDUn0paZNOs39stknwTXPYrt8c7V?=
 =?iso-8859-1?Q?GMsFg+U/tCCJFHCZIJh3TBgZFxubMhnnbKGZerj4C7TvcY6RMm/lNIaI9m?=
 =?iso-8859-1?Q?jmDtrDseykzeV4RhiAJrGnhvBZ7ByP415pk6K+VDepkBwDyeaBL1dqce7G?=
 =?iso-8859-1?Q?gZjTh9Cvk+XbeG72YtDasDUR0DoX51b6DLF+Ufauv6fwxHB7ny3OG/87X/?=
 =?iso-8859-1?Q?Y2XXd4zQEhSIzAbk+dWXRfoM2PNn9DHCMKSpgXskOCqPrZzu/ikR1IArgl?=
 =?iso-8859-1?Q?TyfonWepcy4qfuHZrIQweHOhjilCHDAI00TsQ9ts7f2hmL6804aW86oMyd?=
 =?iso-8859-1?Q?Sz9cKNvVqQfFLX2I1zppsY5pxcIgAthDgqcwSJfT54+8EhsontoNvAxCcl?=
 =?iso-8859-1?Q?zFK17PAfXPamKa8Gq3iyGVkHQRs1tvc3dovTQegwvtlsXCCFxFWDOLsbLi?=
 =?iso-8859-1?Q?KzV/9VTFr5LBfTsWGoqlnqDwJA5u3Ksh1Pn9I89zD9RgiDD8ZYRwWBot1/?=
 =?iso-8859-1?Q?SVc07QfvnxZ5mf3Dkti2qV2F+sl8jieTkYcwp3xPxTJj3QzfnvGjtixvJA?=
 =?iso-8859-1?Q?FmPy5lDZiXirdIjZjxW+R1scowxYabDgZYcMB4hg16XbqDuB/kSSJrGNL7?=
 =?iso-8859-1?Q?RXAR4sMoSswDNDFjg2UVAjcyvtX8h7XFDIhHqruFJI5u8lSVqxXkt8HCFw?=
 =?iso-8859-1?Q?4O4zd4vQqbvfhYg6s+VjzTX2YG3TOu4liQ4tbEp5UlLXCJVLBI+LTWLK6B?=
 =?iso-8859-1?Q?Q3ffhT3MvcoSbsAh+QMhxC1HVgl6mAacLiZQqMaC7Phc/EBFMLKvOV9og7?=
 =?iso-8859-1?Q?Ooj9yUUrpPiNOiJzVUaVDc8KCRxUnSaVMPyvj/Atqd8fpr4Wdhd590SmS2?=
 =?iso-8859-1?Q?Wnm+hx6KCEgUrwdkmwn5kuwsYC8PjyS3H9T79wXTFl5BHPPBfNTeH5ifj8?=
 =?iso-8859-1?Q?ttXFoVPQqnfXAttL03GR4TpJxUikm6CK85L+BjUCBldhdKRQP1JNrNWnRm?=
 =?iso-8859-1?Q?vAQRYlSuCY+qPFd1wPRxG5H+DJRZvP0vWKzruIOCjZ9iVwsZHXVGP9yUbJ?=
 =?iso-8859-1?Q?vaBbLLkv3Vyrn1Gr++U8HiX9cYLgRquYXXfVv3romsGb3oToPzgMPSB0ip?=
 =?iso-8859-1?Q?qvP5WfjvpnigqTV5KFfssaD5Cd4b1H9AenquUoj1LYD8PUVki39DH5Qe0l?=
 =?iso-8859-1?Q?hi+CMjheGcpjs7rzW01yO61lQpc7sh+f7DFvlMA59EoVx+JlmlMfKwJ7af?=
 =?iso-8859-1?Q?rF4rQ+Lj0r74DNkw8n93DAlimsoo4NPxNnfwmVL7E01bDGEZPFdC1tTsyW?=
 =?iso-8859-1?Q?CjdksJkdp9wERbyuZ9nVUdIJ3z3w4BCsLZfQ15ddGXEC1qAmNS+tEZxA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c75599-8bf0-4ef4-0e19-08dd5250b8ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:21:20.5319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4NbCLlw7De3IcIdjcWUma5CERjJU0J9FiRy63UuxwO4PbY23edCM+qujwd7irxxH7UqD32lyw9s0kDC65ZEoWmtR/DPTon2l9WFUsiaxHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8461

Hi Uwe,

> -----Original Message-----
> From: Biju Das
> Sent: 09 January 2025 09:33
> Subject: RE: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hi Uwe,
>=20
> Thanks for the feedback.
>=20
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > Sent: 09 January 2025 09:23
> > Subject: Re: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
> >
> > Hello Biju,
> >
> > On Wed, Jan 08, 2025 at 02:13:09PM +0000, Biju Das wrote:
> > > Please let me know, if there is any feedback for this patch series
> > > or any new API to be adapted in next kernel version which simplifies
> > > the code, So that I can send next
> > version.
> >
> > I didn't look, but if you're ambitious you can convert your driver to t=
he waveform callbacks.
>=20
> Is it ok, after the acceptance of initial version, will switch to wavefor=
m callbacks to enable the
> users of GPT(Reason: lot of customers are using GPT for backlight for LCD=
 panels)?
>=20
> Please let me know.
>=20
> Is there any documentation available for waveform callback? What scenario=
s we can use Waveform
> callbacks compared to traditional one?
>=20
> > Otherwise I didn't take a look into this revision yet (also because of =
the kernel bot message).
>=20
> I just need to remove unused variable, that is a simple fix.

Gentle ping.

Cheers,
Biju

