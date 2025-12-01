Return-Path: <linux-pwm+bounces-7745-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFF4C97E26
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Dec 2025 15:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AFE7343F51
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Dec 2025 14:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8E531A7F8;
	Mon,  1 Dec 2025 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="XYCVhVqm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010051.outbound.protection.outlook.com [52.101.228.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04F314B88;
	Mon,  1 Dec 2025 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600192; cv=fail; b=lgbW5qdlo0wTpMoH0MuC7IikJ65diGnqIUleJg6zjqk8tIBhZtwDAH5key+p6nIynBZKpGHXXUigT/yvMDloRBE0EawLEDGpWuBMzHsoDNfIUYDnBc0+zKgJA0qZeUVAWd+niYmEy8+PlreOMQ8EDl3VGbrRFicIbJ5S1SI8hl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600192; c=relaxed/simple;
	bh=qPZTDDQuDV6lWNkWR4Ejen7S4Bgx/j+09rIlw+HkqE4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZGneBx0v66GxiPoUCHs5QxETNV5QhLWXmCGiu4gXfe3DjuXOpJ/hBuSVtkx4XlYXW0E2DxP+zDOT6wPoNttWwCJb87K4TTD6JTVbBMCB6e/6W3wjEQaaU9TmWOzQf4n3tbLa0sBU/SEvGA234hiZYFP65z5p8D6DcLoewrohkYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=XYCVhVqm; arc=fail smtp.client-ip=52.101.228.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAFO/9V9f7or5gDoD4QbrGp7QvVaRVXebg5SD5VQLep44hvje/MOTYnixdvMn+6OazcqR5+ShCiBJtS/a6W8t3Ay7lVUJgLmofzjBALgP//t753/HMRV+ZyoCvNM/w0ptMyF1pq+JNqoZtSISJdhbjydt1n8sHo7XU9UdmjNnnPuhQO6QiMecjSgRO0aBki9guvPw9HJj3w44AntQImxD5jrtcrrs2t5V2HUQc4khVbc2kILdJBnuVDc0BFSZcP3pjcioNtJGlNqqgVFcvi3ZgKGeCvs4ajoA3MhPScYDMA18Ptx4IreD6+Ym/xTaq2+fN0s01vffYF+vgyuAstWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUbLGve7/uyDQMgx5FqJqpyKsfB2NKTcExmOnyjo28A=;
 b=HPrHGKYj1ryzO5TaHQhr7KG00yEOFiHV8EaIX15H6wU1oaJti7uBPfFNB7vag/0iGZ4JBN6saFVIwDCt26wg7ynAuuiQVjbQDTTKi/BNd46ZnJR+GqUtjnwO8dwq/wgpfTFoixXTRDw+l8pCN5bi2u0obhiLx2MKYVzfpMRRE1LJRySDS0p5qjhaHfoz6aCNCwEzmMOlxaZiiza2weJ9YVR0W5rnOnuUNmRbyRVaVlsL/YL8DQ4BYpw/aGVWcJWApx17ssqH36uyHLMRJkfLUdocXhqAYx91t9/oUG0UDQ0/7XJI1Pvq0en6mtloJZav6nKolbh2MEhpMHUfQ3oCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUbLGve7/uyDQMgx5FqJqpyKsfB2NKTcExmOnyjo28A=;
 b=XYCVhVqm/MO5YpFMY78elxtXEzjyy1oXDBIk1usqTxXhclL7qgU+Tm8QQzETldC7dr854dz9wi8730kGGrDNwtmuga/r/DlXAXMyXM+vFP8azqK4r/Js/OZ+4Hei5Bc7o4IohV+c6lIMacOUcUS3VohRC3EUeoX4e5oJMG9J+dE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB14536.jpnprd01.prod.outlook.com (2603:1096:405:23a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 1 Dec
 2025 14:43:02 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9388.003; Mon, 1 Dec 2025
 14:43:02 +0000
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
Thread-Index: AQHcLJi5Wq0nvzczj0CSEUAgjJVVOrULUGQAgAG46lCAADdsgIAABTVA
Date: Mon, 1 Dec 2025 14:43:02 +0000
Message-ID:
 <TY3PR01MB11346DE28875EFD9B9D86DE5186DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-7-biju.das.jz@bp.renesas.com>
 <wah57av7ypb42zcaosx7n64j6qmmcq5ylhgnde2brbiy6o7sun@7rqkr6ke3g5k>
 <TY3PR01MB1134692D7D9F5B67116D2BC7786DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <pilx2etxezmr6rhbwculwjqcxotzkxus5bqdpjrt5na5c7fqhj@mdfm2yh2aptp>
In-Reply-To: <pilx2etxezmr6rhbwculwjqcxotzkxus5bqdpjrt5na5c7fqhj@mdfm2yh2aptp>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB14536:EE_
x-ms-office365-filtering-correlation-id: 10b18a60-6c12-497a-1f97-08de30e7ee44
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XbVpzZb94GJUft72OIF89NNyFLtvWJGlqFXlbO2cyFwlfFmAFFm9WmesDg?=
 =?iso-8859-1?Q?ald1zQ+O66BvBax5kyudTPFeozyHka97dfVmydOHbLBQMPkBJVQFQp3YDS?=
 =?iso-8859-1?Q?XrqyduGmhqv8n91zJsQZv/SDVLPU2li83j+gVsoCH2pmK7No/aSNTLvvD2?=
 =?iso-8859-1?Q?saTCZjL0Sja4UBXP02nqkNOhwMiO6H4kYeEEJU2igkSqlNo7C14M/ebcHT?=
 =?iso-8859-1?Q?itE8fKZDRHr4Zlsx5v+QKNYAjwF6iKk+5oGho3+O+RzHsoURWZ31/Nx6Z8?=
 =?iso-8859-1?Q?Pogo3RyV9BKpeLUnT0/9beVZnzOgymSMjUbkWZS/4SU7YEtHPy5giJwITx?=
 =?iso-8859-1?Q?WMJtStlrO97v9FDISi/xLgKE+SAZMYcRMx1DO/2/CfejuUEOupCkjV6UBG?=
 =?iso-8859-1?Q?mHml1b56aCBGf5EmpvzkGxQp75xv3bpCYOsF1YEpO8sm0Fgvw0ZAMKa4Bu?=
 =?iso-8859-1?Q?a9oGvqdkmJiT5Jn7viApJTGUmyo298K5rz/t7q7ovDiI5hzxoDqfWbCxbW?=
 =?iso-8859-1?Q?hEvJPhoabdJ9izRrQ/gMcLqcaSOSXrxHPzwGIODN/SIexWXmVRsxf9tKOc?=
 =?iso-8859-1?Q?bQmYBoQR6z8bKTsQYSnFk4J/Lc7+uCrEXD0DDngv6xFHFMpWTiFc8Sspsm?=
 =?iso-8859-1?Q?BfB9Eh3E7Oaz3Ngxwnhhvn0uGcN8tPZZai4OLbvb/pL/O7Lx9SnibxmyN+?=
 =?iso-8859-1?Q?Yja2SRUKruqNn7qsOiJv6O/hdd4bAgo1PyybUaAr1P3lU78qNV6xjrBbWS?=
 =?iso-8859-1?Q?0Dpo4Wg7IWx5Pmtk9T1RVGsLLnWhkywuQIhcbjll3vZ92smHf9/nz566l0?=
 =?iso-8859-1?Q?mXVVuWPVzqwMocCMwQOpjLQ4yp7G0AKjQ4UMwSloPdl6LOpZKB0V7jJTIL?=
 =?iso-8859-1?Q?U0/isBKG8jjPTmolkhutkzrXK7kTD+ow9JtlHMvDpZOgtVdykNaU8wrZUp?=
 =?iso-8859-1?Q?s8hJus34RdJVRiixytIExzd27wYLMvWlApakCOx8i2Z3T8wDWdYpFeZLbc?=
 =?iso-8859-1?Q?La5eX9fB6sJUS4kRB7vp0rmV9tyyZ8r+hJciA67TCSfoBinRePcU0j+R+g?=
 =?iso-8859-1?Q?RFz/XyQoPSjrhVMZwzOzMT5AeHREiWQC91eDhlfbmQuL6X/vHmuCKlFYzz?=
 =?iso-8859-1?Q?mxqxzsUn/+G+/ir6tRKc3eN/WgMzJclRAUEsNyDC/80wEAFn/6NmhcWD0R?=
 =?iso-8859-1?Q?9sKY/ch/eUeUDhb29+gwFY0jDKWODByTOLue6A5OE8OnwCnBtgH/Y9MMQf?=
 =?iso-8859-1?Q?hvAwk0XLl89JMkGi+okdUvm+xpRRaGiOE1UywVPjqBctmoXHFkqtBIA3CE?=
 =?iso-8859-1?Q?2LeO3mGzQDmQuiUog90FaTu0au2PzUIZZZONTdNyKCvLk37oCZzhCf+PBI?=
 =?iso-8859-1?Q?RM1KMxqoPkx7W8D3YNVKvSn1ejq8kR6Pj/JxSR0pjBDu8+WXyKE7YGuNZ0?=
 =?iso-8859-1?Q?Jfa98LXOy9kCoUSIIkQHJAz04RBSOBhFA22LaCZeBStFDIckdyAIguXKH+?=
 =?iso-8859-1?Q?f0c4mJGENg3Lm72PbAXAqBdnag8iusPY/t5FdwB6iVnA+bRyT7mPEeZ8a5?=
 =?iso-8859-1?Q?2jVhLPJyR6bICvo3muvIdr0xtwYZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?081cccbuPhog6eXl1CqXztumPZ2yOc8d4KI6Rrwl5iYD90sJZlKjVjqHHi?=
 =?iso-8859-1?Q?aeGFk/zjjdER8Dwu7NvX7pZKbqzA/m0OgGqUxUDpqy+ep/Qa0BoeijHHkc?=
 =?iso-8859-1?Q?NgjNGRHS0ppUvZrMGs5uoxkalnBSOqMSJoobrOhA6iEWYqUK+chu/xlSDr?=
 =?iso-8859-1?Q?jVtJBKy4tBfFhOc5dRlffAarUEeAKYnWEjhZrDSQwPfiZY08fVcbZYvUV7?=
 =?iso-8859-1?Q?vEYqw5KIvp2V1xXRyBbYhgcvZjcCTPs80VhiNQbN4CtcZj+kmZnIgGa5k+?=
 =?iso-8859-1?Q?8eNdiCCLkvhLalBj7rZCQzvTaIRyPYyy8H6khcnCnowbHWmtAA7L2zoqxu?=
 =?iso-8859-1?Q?bETLnmYbAuVF7UcTmhhxZYqFxuHNzZQbK006RDyKuLbr+S/jW7Pc6zm/rq?=
 =?iso-8859-1?Q?uTraKNf0AZld8yckhmpdW9WpO3/SfCHW9EATEx3zjAR/p7qEQjs948CZVy?=
 =?iso-8859-1?Q?HtNt9kDL7UhJv17nYEu+hoN9Mu7tGgDrzZ0SfsLUdBDzbNr5y+ZSVM9I0i?=
 =?iso-8859-1?Q?8nwIZ3HTNZYpgaD6FR2W2JhVNZgHkb18Pt5Myh0WgP7zMmqkA95vkFblsu?=
 =?iso-8859-1?Q?8TIPlhIPZtW1lV1HXwWtIfr40779IpPhQreu20z3DpiqJvxjCBSi273vW3?=
 =?iso-8859-1?Q?0DEvKvSzDvOqH3cO0gP/2E0ewpNHRJjg5VmEzxF7bmMzr0aGulGG/sdlFW?=
 =?iso-8859-1?Q?w8WXXNF5sXlP843npQk2LR/B2d83QC9DsNSGMdKUz4DS3QgAu3q4SiEHnA?=
 =?iso-8859-1?Q?vUK3dJgT6VEpEQ/IZwhic9rYkrG4MPFRdCo9ZaEMx5PlYC/08/gPNAPgWA?=
 =?iso-8859-1?Q?df1Bhqge4O3IUh9bMJqjVpugnnwLvjv2UsbPA3JauDqBTamK3Rwrromdb7?=
 =?iso-8859-1?Q?7OkoFg4nqOF1Xz/0ntaGyXYwNZTpdbojw1kGhhRCJ92wRFrAGMIN+pSd1O?=
 =?iso-8859-1?Q?8EmRPb07SI37Kz3iAQy6ubTgc2ZY2PSlcjLqEK1Hqy+4AHVupU1MY6hEXY?=
 =?iso-8859-1?Q?iKmlgBZ6GwNjhj4VulaiSzFk1vFFda5ojNBGuPcFP78q7wDeC8NjZOHKkh?=
 =?iso-8859-1?Q?9P800oZFi2HeUNJkmZEQ1Pn7W5zJZF+4zlUCA6Grdy0R4spJZo8fb1x4Dy?=
 =?iso-8859-1?Q?1xLeuh1uo46tncV3jmISIvY7KWD06oz0Cj71B8mEDAAXEwysWXI1aeDMZq?=
 =?iso-8859-1?Q?gsZSd8kJ552oRQ1rD4Q6Xn5X0CaoY1ZdXovGiS0omwIt6Tc0xVrkNiGgn7?=
 =?iso-8859-1?Q?yA4wBiawsklY6ZHcKY5taGE0BCxvLsZizYyRTbpBhjn/2k/NX2lb7RVxuo?=
 =?iso-8859-1?Q?8l0WOsBTDiC+JOufA1aRW/REPMbezwz+nYs12pK3r10s532VNrOrIe/LYA?=
 =?iso-8859-1?Q?C+ATEPhOmu3tz1tYmEtwyfqgcSDlIchlbTk2v3wO9v2EQR9rHkoKWVEyE0?=
 =?iso-8859-1?Q?igFsg3wumgAwByfGqdJeAC4LcySDdwbv9HkQ9diY/RzKsDvYNy6ZWNEILI?=
 =?iso-8859-1?Q?HLkVnX5MzWxA0fo6n3K0JwoG/8cMl9faMwgchEVueB/OOMcZmtmS99yEE9?=
 =?iso-8859-1?Q?xpeEWQ329oh8G8KMv1G0ZrSu0N+7W5eLCf6oVWWnC5SdKdLpt4XwaFxLF9?=
 =?iso-8859-1?Q?O20JS1dAHmZx0FaJq71acrNHJEC3n/mcf3RrXuzAb1d1dnpeXKli2Ebw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b18a60-6c12-497a-1f97-08de30e7ee44
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 14:43:02.5956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGBxBQS0qscjKndqVQjy6hZaD+X5/EKYOx5v7LCITxbUioCndiKIP/hLcH+SGT21JU9FKCSLzJDwA6yBOs6xcsOF65YPODINi/lnZFAV3VA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14536

Hi Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 01 December 2025 14:16
> Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
>=20
> Hello Biju,
>=20
> On Mon, Dec 01, 2025 at 11:09:50AM +0000, Biju Das wrote:
> > > -----Original Message-----
> > > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > > Sent: 30 November 2025 08:39
> > > Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume
> > > support
> > >
> > > On Tue, Sep 23, 2025 at 03:45:10PM +0100, Biju wrote:
> > > > +static int rzg2l_gpt_suspend(struct device *dev) {
> > > > +	struct pwm_chip *chip =3D dev_get_drvdata(dev);
> > > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > > +	unsigned int i;
> > > > +
> > > > +	for (i =3D 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
> > > > +		if (!rzg2l_gpt->channel_enable_count[i])
> > > > +			continue;
> > > > +
> > > > +		rzg2l_gpt->hw_cache[i].gtpr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_=
GTPR(i));
> > > > +		rzg2l_gpt->hw_cache[i].gtccr[0] =3D rzg2l_gpt_read(rzg2l_gpt, RZ=
G2L_GTCCR(i, 0));
> > > > +		rzg2l_gpt->hw_cache[i].gtccr[1] =3D rzg2l_gpt_read(rzg2l_gpt, RZ=
G2L_GTCCR(i, 1));
> > > > +		rzg2l_gpt->hw_cache[i].gtcr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_=
GTCR(i));
> > > > +		rzg2l_gpt->hw_cache[i].gtior =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L=
_GTIOR(i));
> > > > +	}
> > > > +
> > > > +	clk_disable_unprepare(rzg2l_gpt->clk);
> > > > +	clk_disable_unprepare(rzg2l_gpt->bus_clk);
> > > > +	reset_control_assert(rzg2l_gpt->rst_s);
> > > > +	reset_control_assert(rzg2l_gpt->rst);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int rzg2l_gpt_resume(struct device *dev) {
> > > > +	struct pwm_chip *chip =3D dev_get_drvdata(dev);
> > > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > > +	unsigned int i;
> > > > +	int ret;
> > > > +
> > > > +	ret =3D reset_control_deassert(rzg2l_gpt->rst);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret =3D reset_control_deassert(rzg2l_gpt->rst_s);
> > > > +	if (ret)
> > > > +		goto fail_reset;
> > > > +
> > > > +	ret =3D clk_prepare_enable(rzg2l_gpt->bus_clk);
> > > > +	if (ret)
> > > > +		goto fail_reset_all;
> > > > +
> > > > +	ret =3D clk_prepare_enable(rzg2l_gpt->clk);
> > > > +	if (ret)
> > > > +		goto fail_bus_clk;
> > > > +
> > > > +	for (i =3D 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
> > > > +		if (!rzg2l_gpt->channel_enable_count[i])
> > > > +			continue;
> > > > +
> > > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(i), rzg2l_gpt->hw_cache[i]=
.gtpr);
> > > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 0), rzg2l_gpt->hw_cach=
e[i].gtccr[0]);
> > > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 1), rzg2l_gpt->hw_cach=
e[i].gtccr[1]);
> > > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCR(i), rzg2l_gpt->hw_cache[i]=
.gtcr);
> > > > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTIOR(i), rzg2l_gpt->hw_cache[i=
].gtior);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +fail_bus_clk:
> > > > +	clk_disable_unprepare(rzg2l_gpt->bus_clk);
> > > > +fail_reset_all:
> > > > +	reset_control_assert(rzg2l_gpt->rst_s);
> > > > +fail_reset:
> > > > +	reset_control_assert(rzg2l_gpt->rst);
> > > > +	return ret;
> > >
> > > I wonder what happens if these calls in the error path fail. I think
> > > the correct way would be to track the actual state to handle the
> > > state on the next invokation for .resume() properly. But note that
> > > suspend/resume is a somewhat blind spot for me, so I'm unsure here.
> > > (And I'm aware that most resume callbacks don't cope cleanly here.)
> >
> > In str case, there is no power on the system during suspend and exit
> > is, SoC reset followed by restoring registers from DDR. So, it does not=
 matter for the suspend path.
> >
> > In the resume case, If the calls to error path fail, then device won't =
work.
>=20
> I'm not sure you understand my concern. IFAIUI a device that fails to res=
ume stays suspended from the
> POV of the kernel. When in this state the resume is tried again at a late=
r point in time you get
> inconsistencies if the first reset was already deasserted from the previo=
us resume run (because
> reset_control_assert() failed in the resume callback's error path).

I have simulated a possible error condition in driver by adding a hack.

Unlike probe(), .resume() never retries.

For the first time: I got the pwm resume error [2]
For the second time: I got clk related warnings, but device enter into
			   suspend mode and on resume I got pwm resume error [3]


[1]
        ret =3D reset_control_deassert(rzg2l_gpt->rst);
+       ret =3D -ETIMEDOUT;

[2]
root@smarc-rzg3e:~# /pwm-pm-test.sh

### Executing ST[   37.482149] PM: suspend entry (deep)
R ###
[   37.487322] Filesystems sync: 0.000 seconds
[   37.494478] Freezing user space processes
[   37.499067] Freezing user space processes completed (elapsed 0.004 secon=
ds)
[   37.506607] OOM killer disabled.
[   37.509906] Freezing remaining freezable tasks
[   37.596288] Freezing remaining freezable tasks completed (elapsed 0.081 =
seconds)
[   37.603859] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
NOTICE:  BL2: v2.10.5(release):2.10.5/rz_soc_dev-329-gb288fa6dd
NOTICE:  BL2: Built : 12:27:28, Nov 28 2025
NOTICE:  BL2: SYS_LSI_MODE: 0x13e06
NOTICE:  BL2: SYS_LSI_DEVID: 0x8679447
NOTICE:  BL2: SYS_LSI_PRR: 0x0
NOTICE:  BL2: Booting BL31
[   37.683454] renesas-gbeth 15c30000.ethernet end0: Link is Down
[   37.697777] Disabling non-boot CPUs ...
[   37.702482] psci: CPU3 killed (polled 4 ms)
[   37.711313] psci: CPU2 killed (polled 0 ms)
[   37.717615] psci: CPU1 killed (polled 4 ms)
[   37.720440] Enabling non-boot CPUs ...
[   37.720650] Detected VIPT I-cache on CPU1
[   37.720697] GICv3: CPU1: found redistributor 100 region 0:0x000000001496=
0000
[   37.720734] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[   37.721614] CPU1 is up
[   37.721712] Detected VIPT I-cache on CPU2
[   37.721733] GICv3: CPU2: found redistributor 200 region 0:0x000000001498=
0000
[   37.721754] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[   37.722381] CPU2 is up
[   37.722475] Detected VIPT I-cache on CPU3
[   37.722496] GICv3: CPU3: found redistributor 300 region 0:0x00000000149a=
0000
[   37.722517] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[   37.723239] CPU3 is up
[   37.726063] pwm-rzg2l-gpt 13010000.pwm: PM: dpm_run_callback(): rzg2l_gp=
t_resume [pwm_rzg2l_gpt] returns -110
[   37.726090] pwm-rzg2l-gpt 13010000.pwm: PM: failed to resume: error -110
[   37.741357] dwmac4: Master AXI performs any burst length
[   37.741390] renesas-gbeth 15c30000.ethernet end0: No Safety Features sup=
port found
[   37.741431] renesas-gbeth 15c30000.ethernet end0: IEEE 1588-2008 Advance=
d Timestamp supported
[   37.741499] renesas-gbeth 15c30000.ethernet end0: configuring for phy/rg=
mii-id link mode
[   37.758478] dwmac4: Master AXI performs any burst length
[   37.758505] renesas-gbeth 15c40000.ethernet end1: No Safety Features sup=
port found
[   37.758536] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advance=
d Timestamp supported
[   37.758598] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rg=
mii-id link mode
[   37.805425] usb usb1: root hub lost power or was reset
[   37.805433] usb usb2: root hub lost power or was reset
[   38.084992] OOM killer enabled.
[   38.088129] Restarting tasks: Starting
[   38.092613] Restarting tasks: Done
[   38.096111] random: crng reseeded on system resumption
[   38.101412] PM: suspend exit

[   40.382923] renesas-gbeth 15c30000.ethernet end0: Link is Up - 1Gbps/Ful=
l - flow control rx/tx
root@smarc-rzg3e:~#

[3]

root@smarc-rzg3e:~# /pwm-pm-test.sh
16
pwmchip0

### Executing ST[   47.450128] PM: suspend entry (deep)
R ###
[   47.455333] Filesystems sync: 0.000 seconds
[   47.460719] Freezing user space processes
[   47.466805] Freezing user space processes completed (elapsed 0.006 secon=
ds)
[   47.473786] OOM killer disabled.
[   47.477008] Freezing remaining freezable tasks
[   47.482814] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[   47.490228] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
NOTICE:  BL2: v2.10.5(release):2.10.5/rz_soc_dev-329-gb288fa6dd
NOTICE:  BL2: Built : 12:27:28, Nov 28 2025
NOTICE:  BL2: SYS_LSI_MODE: 0x13e06
NOTICE:  BL2: SYS_LSI_DEVID: 0x8679447
NOTICE:  BL2: SYS_LSI_PRR: 0x0
NOTICE:  BL2: Booting BL31
[   47.559556] renesas-gbeth 15c30000.ethernet end0: Link is Down
[   47.561796] ------------[ cut here ]------------
[   47.561822] gpt_0_pclk_sfr already disabled
[   47.562021] WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0xa4/0xa=
c, CPU#3: sh/396
[   47.562109] Modules linked in: bluetooth sha256 ecdh_generic cfg80211 ec=
c rfkill panfrost drm_shmem_helper gpu_sched spi_rpc_if drm_kms_helper pwm_=
rzg2l_gpt rtc_isl1208 phy_rzg3e_usb3 rcar_canfd renesas_rpc_if can_dev fuse=
 drm backlight ipv6
[   47.562463] CPU: 3 UID: 0 PID: 396 Comm: sh Not tainted 6.18.0-rc7-next-=
20251201-g6e9da3a50130-dirty #108 PREEMPT
[   47.562512] Hardware name: Renesas SMARC EVK version 2 based on r9a09g04=
7e57 (DT)
[   47.562535] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   47.562576] pc : clk_core_disable+0xa4/0xac
[   47.562625] lr : clk_core_disable+0xa4/0xac
[   47.562669] sp : ffff800083a83a90
[   47.562688] x29: ffff800083a83a90 x28: ffff0000c9160000 x27: ffff8000826=
a5d50
[   47.562760] x26: ffff80008280bf28 x25: 0000000000000002 x24: ffff80007a9=
cf480
[   47.562828] x23: 0000000000000000 x22: ffff0000c08ee890 x21: 00000000000=
00002
[   47.562896] x20: ffff0000c0138200 x19: ffff0000c0138200 x18: 00000000000=
00030
[   47.562963] x17: ffff0000c4933280 x16: 0000000000000ffb x15: 00000000000=
000ba
[   47.563030] x14: fffffffffffc86df x13: 0a64656c62617369 x12: ffff8000822=
e6c48
[   47.563098] x11: 0000000000000058 x10: 0000000000000018 x9 : ffff8000822=
e6c48
[   47.563164] x8 : 00000000000001eb x7 : ffff80008233ec48 x6 : ffff8000823=
3ec48
[   47.563231] x5 : 0000000000000001 x4 : 0000000000000000 x3 : 00000000fff=
fffff
[   47.563296] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c91=
60000
[   47.563362] Call trace:
[   47.563381]  clk_core_disable+0xa4/0xac (P)
[   47.563439]  clk_disable+0x30/0x4c
[   47.563495]  rzg2l_gpt_suspend+0x100/0x140 [pwm_rzg2l_gpt]
[   47.563561]  device_suspend+0x140/0x3c8
[   47.563608]  dpm_suspend+0x1ac/0x2a4
[   47.563652]  dpm_suspend_start+0x54/0x70
[   47.563696]  suspend_devices_and_enter+0x1d4/0x590
[   47.563746]  pm_suspend+0x194/0x1c0
[   47.563789]  state_store+0x80/0xf4
[   47.563829]  kobj_attr_store+0x18/0x34
[   47.563875]  sysfs_kf_write+0x7c/0x94
[   47.563933]  kernfs_fop_write_iter+0x130/0x200
[   47.563986]  vfs_write+0x244/0x36c
[   47.564045]  ksys_write+0x70/0x108
[   47.564101]  __arm64_sys_write+0x1c/0x30
[   47.564160]  invoke_syscall+0x48/0x104
[   47.564205]  el0_svc_common.constprop.0+0xc0/0xe0
[   47.564250]  do_el0_svc+0x1c/0x28
[   47.564290]  el0_svc+0x34/0x108
[   47.564345]  el0t_64_sync_handler+0xa0/0xf0
[   47.564401]  el0t_64_sync+0x198/0x19c
[   47.564446] ---[ end trace 0000000000000000 ]---
[   47.564476] ------------[ cut here ]------------
[   47.564492] gpt_0_pclk_sfr already disabled
[   47.564680] WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0xa4/0xa=
c, CPU#3: sh/396
[   47.564748] Modules linked in: bluetooth sha256 ecdh_generic cfg80211 ec=
c rfkill panfrost drm_shmem_helper gpu_sched spi_rpc_if drm_kms_helper pwm_=
rzg2l_gpt rtc_isl1208 phy_rzg3e_usb3 rcar_canfd renesas_rpc_if can_dev fuse=
 drm backlight ipv6
[   47.565088] CPU: 3 UID: 0 PID: 396 Comm: sh Tainted: G        W         =
  6.18.0-rc7-next-20251201-g6e9da3a50130-dirty #108 PREEMPT
[   47.565142] Tainted: [W]=3DWARN
[   47.565159] Hardware name: Renesas SMARC EVK version 2 based on r9a09g04=
7e57 (DT)
[   47.565180] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   47.565219] pc : clk_core_disable+0xa4/0xac
[   47.565264] lr : clk_core_disable+0xa4/0xac
[   47.565307] sp : ffff800083a83a90
[   47.565325] x29: ffff800083a83a90 x28: ffff0000c9160000 x27: ffff8000826=
a5d50
[   47.565397] x26: ffff80008280bf28 x25: 0000000000000002 x24: ffff80007a9=
cf480
[   47.565465] x23: 0000000000000000 x22: ffff0000c08ee890 x21: 00000000000=
00002
[   47.565533] x20: ffff0000c0138200 x19: ffff0000c0138200 x18: 00000000000=
00030
[   47.565600] x17: ffff0000c4933280 x16: 0000000000000ffb x15: 00000000000=
000ba
[   47.565667] x14: fffffffffffc90d7 x13: 0a64656c62617369 x12: ffff8000822=
e6c48
[   47.565735] x11: 0000000000000058 x10: 0000000000000018 x9 : ffff8000822=
e6c48
[   47.565803] x8 : 0000000000000216 x7 : ffff80008233ec48 x6 : ffff8000823=
3ec48
[   47.565869] x5 : 0000000000000001 x4 : 0000000000000000 x3 : 00000000fff=
fffff
[   47.565933] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c91=
60000
[   47.565999] Call trace:
[   47.566015]  clk_core_disable+0xa4/0xac (P)
[   47.566071]  clk_disable+0x30/0x4c
[   47.566126]  rzg2l_gpt_suspend+0x114/0x140 [pwm_rzg2l_gpt]
[   47.566183]  device_suspend+0x140/0x3c8
[   47.566228]  dpm_suspend+0x1ac/0x2a4
[   47.566272]  dpm_suspend_start+0x54/0x70
[   47.566317]  suspend_devices_and_enter+0x1d4/0x590
[   47.566363]  pm_suspend+0x194/0x1c0
[   47.566406]  state_store+0x80/0xf4
[   47.566446]  kobj_attr_store+0x18/0x34
[   47.566490]  sysfs_kf_write+0x7c/0x94
[   47.566544]  kernfs_fop_write_iter+0x130/0x200
[   47.566597]  vfs_write+0x244/0x36c
[   47.566654]  ksys_write+0x70/0x108
[   47.566710]  __arm64_sys_write+0x1c/0x30
[   47.566769]  invoke_syscall+0x48/0x104
[   47.566811]  el0_svc_common.constprop.0+0xc0/0xe0
[   47.566855]  do_el0_svc+0x1c/0x28
[   47.566895]  el0_svc+0x34/0x108
[   47.566948]  el0t_64_sync_handler+0xa0/0xf0
[   47.567004]  el0t_64_sync+0x198/0x19c
[   47.567048] ---[ end trace 0000000000000000 ]---
[   47.579777] Disabling non-boot CPUs ...
[   47.584685] psci: CPU3 killed (polled 0 ms)
[   47.590621] psci: CPU2 killed (polled 0 ms)
[   47.596917] psci: CPU1 killed (polled 0 ms)
[   47.599391] Enabling non-boot CPUs ...
[   47.599597] Detected VIPT I-cache on CPU1
[   47.599643] GICv3: CPU1: found redistributor 100 region 0:0x000000001496=
0000
[   47.599680] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[   47.600536] CPU1 is up
[   47.600632] Detected VIPT I-cache on CPU2
[   47.600653] GICv3: CPU2: found redistributor 200 region 0:0x000000001498=
0000
[   47.600675] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[   47.601231] CPU2 is up
[   47.601328] Detected VIPT I-cache on CPU3
[   47.601349] GICv3: CPU3: found redistributor 300 region 0:0x00000000149a=
0000
[   47.601370] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[   47.602191] CPU3 is up
[   47.604890] pwm-rzg2l-gpt 13010000.pwm: PM: dpm_run_callback(): rzg2l_gp=
t_resume [pwm_rzg2l_gpt] returns -110
[   47.604917] pwm-rzg2l-gpt 13010000.pwm: PM: failed to resume: error -110
[   47.629303] dwmac4: Master AXI performs any burst length
[   47.629336] renesas-gbeth 15c30000.ethernet end0: No Safety Features sup=
port found
[   47.629377] renesas-gbeth 15c30000.ethernet end0: IEEE 1588-2008 Advance=
d Timestamp supported
[   47.629445] renesas-gbeth 15c30000.ethernet end0: configuring for phy/rg=
mii-id link mode
[   47.646424] dwmac4: Master AXI performs any burst length
[   47.646452] renesas-gbeth 15c40000.ethernet end1: No Safety Features sup=
port found
[   47.646484] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advance=
d Timestamp supported
[   47.646545] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rg=
mii-id link mode
[   47.693377] usb usb1: root hub lost power or was reset
[   47.693385] usb usb2: root hub lost power or was reset
[   48.444830] OOM killer enabled.
[   48.447970] Restarting tasks: Starting
[   48.452416] Restarting tasks: Done
[   48.455897] random: crng reseeded on system resumption
[   48.461168] PM: suspend exit

[   50.414488] renesas-gbeth 15c30000.ethernet end0: Link is Up - 1Gbps/Ful=
l - flow control rx/tx

root@smarc-rzg3e:~#

