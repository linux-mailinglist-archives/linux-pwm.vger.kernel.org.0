Return-Path: <linux-pwm+bounces-3487-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC81E991637
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 12:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBF7283EAD
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC61AF9FE;
	Sat,  5 Oct 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UHVDr5qE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011043.outbound.protection.outlook.com [40.107.74.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC0231C87;
	Sat,  5 Oct 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728125472; cv=fail; b=ijdQjGBAMilHEpq4VBrVCSzAYXqL02UdtCtcYcXJ/XiTtgO4Nh0B6Q8DO74M67dBTHsQuplJ9d44ZIvrsFwpDbiuO7pELYxfftBOF8yaNPbQMyv0Zp4P6V+BMgT3C7ycz1qTKbx4bUILOng+qGPKB8+UauZaSy1UUmHWMrmAZNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728125472; c=relaxed/simple;
	bh=hyUoYVE5XpkWMd5XT26jY/8fu1loSNC/g4u8Ch/sRDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dIipMIwsWs4lPAsTd7O/+YwE8U4DwGLJ9Hnom1YLRzWAwueA0rvQ7X8ipTAONLtIqY38sBHCH9fHJKbxogNyQItsqCqA7zdaeytAtBu8pLnTRheVT2LHmUFmK0kd4Md3ahaKptY+hWyEgCXuf4n49Xf1eMnf+RVkC3p2tbtU5Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=UHVDr5qE; arc=fail smtp.client-ip=40.107.74.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoZdPdJ4Yh4iWh9x9CH/wERuDOcphcwK/57qnOL9ApOARuvoub6MmnRtyW0KwWmWeiTU9HArkDANSirx/wxYZLoOAUjAHQPLBSeZ3wqsiHX9wED+fJPLIowNOf2N8MXu6dlUE4KhIDI2wAXAPfDvHl/KvhIcmrXZAVFIsaw0EWLFpmRqX7s67HHJYB00tIZoiUzD82gppm5Q3i5S7GlYvH5OMyTnTS/Dkm8HWab7MM1/Je1DjtgAlIsQQn53GGd7c8bSqb0pg8uSKrhVl7GpZFPxxII43xRjSyJyS3GhGlKyJhPZ6SdBIjlXEhHF/WidEib3RzrlXujaU4+xdPeTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcIcCssbNfJ72eAYZyFB4P8Y0YvcGWWNAOSD4QhIkAY=;
 b=rVB0JKLKgkTzXW93zSAdJCCPWewxJsTwJbCH5N8h1f+UFhpcvSwmGLRtjG8l/J5dakc0FeOs3fDz8bw8MObn3/EM/pr8QqPvMHluv2zXpEn82TDyjrB3Bq7s1Ysk8atIgtA9aQa4J0XTasNNiCk0J/xghsYN6wxc2lFOMC185mlDrZW6xOgiyBtjDrk8/DxWk/bYckFFgcICJNfT4OqoAGtZvkeQx4msF2bOD5up+gdkOLfLqf2ic/IIJh0bguYztmIBHv3n0MKn+NtYHUHx8tGyumRTcPiZrRKoQL/mJ2Sn86qJHnoeJJF1TwLwJDFFfuPrLzJBS24hyirPdoxK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcIcCssbNfJ72eAYZyFB4P8Y0YvcGWWNAOSD4QhIkAY=;
 b=UHVDr5qEGxPvwF3yc5VJ/Z7p4XfpPnvTx4iZWPrJAG+MIcd3kDOFfz1IxYtPRZ+Uaqc3Z4VguTZ6TsutrcsXzOzaOSNEGTWXjBLlvToy3HUXXwppWw+Sbnu19nUfHZgtXc1dws+0i4N9++s+a0ZRXb5IzuwEXpGZy5eeofwlukw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11851.jpnprd01.prod.outlook.com (2603:1096:400:3dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sat, 5 Oct
 2024 10:51:03 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 10:50:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHa6ZU4yCrTG4vERkWCKtT81J70kbJo7ssAgA3CQuCAADLRAIAAAuRwgAFtp0A=
Date: Sat, 5 Oct 2024 10:50:56 +0000
Message-ID:
 <TY3PR01MB113463CD49C37B05B3D5D5E8286732@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240808131626.87748-1-biju.das.jz@bp.renesas.com>
 <20240808131626.87748-4-biju.das.jz@bp.renesas.com>
 <slpywmbmamr4kw4jg2vyydheop44ioladvvm52aocnojgjkcsy@3eoztwsej5mn>
 <TYCPR01MB113320CDF49DB0564A958241A86722@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <thfymed6o42wcascazgpvgq6zcqrjxloz3nt5h2pwypqgs4fra@zeyh36lcphia>
 <TYCPR01MB11332D536A0F4F2CA375924F086722@TYCPR01MB11332.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB11332D536A0F4F2CA375924F086722@TYCPR01MB11332.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11851:EE_
x-ms-office365-filtering-correlation-id: f18ea3f2-f709-4314-8ad4-08dce52b9726
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?h5sSG7pWm/WZiDRxr+pz1qc+SB0QUJFrwK049JXRYt5uSsKyj962NEM+EN?=
 =?iso-8859-1?Q?PEMTd0C7y1bMScC0VcfgmvBfQm93fFEX0MFQlb8CWOYfvB4wigV7QJjAX1?=
 =?iso-8859-1?Q?fEO4HzO7RZ/8C/PARxfAk+oF/68lSP6SRzfs1Kj6Mmbr5mn3zr4u/t+oii?=
 =?iso-8859-1?Q?6AbdENgVQHbFOxnSTuuF6vFNZS+j8TtiQN8MHxuFKNdWJdj9StaF47tf5B?=
 =?iso-8859-1?Q?WItSB82nKE00D6BWyIlm6T6/Timk8daGBBOWZKdWIAGGV1Ze6N2fDbZ6P1?=
 =?iso-8859-1?Q?PMke0BSpNrvG8ARx24iD70GpGHc+qqHB54p3f/rAg2iKVxzlLIh1BvgVA9?=
 =?iso-8859-1?Q?3WHsoZiVJI21N0jV64MLy07zL6XCsz5lcbI7lxGDJow38Pbdjw/wNkYTLy?=
 =?iso-8859-1?Q?WPFMdJdTBppttSNRNMy4YVt/kLQv3sul7vJ61RfL5JizzZleoVS/sHVU9g?=
 =?iso-8859-1?Q?/+aPjvPsT+WAh7Zsp+gIQys9UX34lfDMs0Kz3nspQdhb/PMtXPZ5CHqKRt?=
 =?iso-8859-1?Q?8sLtZJHso5dxHAhFawjyFIydz1aUsvCRkvxowVwE0W2WFdOQ/j98HkBhuQ?=
 =?iso-8859-1?Q?P00jgi7SA5WnTfbxWPZRF2Ki3107Ga/w3mavm2fnK6A0iuoA9MX+7V872/?=
 =?iso-8859-1?Q?Q1WhFMwWtYYwrIz8LrpYRz+BT1Go58RWqrnV8H9nFfcNc8E+F+S6JOAXtc?=
 =?iso-8859-1?Q?YAtkwvX+FI6hz63dVrz1ylyFkEXc5hk1nLSzn0+1owH4j36I8tnBLUjNOQ?=
 =?iso-8859-1?Q?v1D+iq8bUnVRSONtCRAdp8Dbq6Nw6McuvOvnou3Z4gbUcp834exytUZcH/?=
 =?iso-8859-1?Q?qsR8m02VOsWvWjg7RXQiZgfxre/CcdwpGnL8hT66IHilEwXgZcT0gfAhU+?=
 =?iso-8859-1?Q?p03G8Or2e4EWjck3iJoa/5YcsRKeawMewX/eBMzReVtFsJG7ma7BNGTWwE?=
 =?iso-8859-1?Q?iodJlo6Qh4yhBfVbeMY89eMMd9rzTcxhuk96h7DKtANQvvoe6dsOosMF9w?=
 =?iso-8859-1?Q?DS6RVyiUvZJdKmijpUCkk1EeSCrHjs62vaKJe/q+Lid3PEcZVW5OWKoOpP?=
 =?iso-8859-1?Q?tWydULHCOf6/N/MFtmsw5QywuyAaJ9ttl5fSm+rL17s0lUyVJ2hzWCTXHD?=
 =?iso-8859-1?Q?+zVp/D62eEAn5ee+zgM8C+lfZdyVkBcDGClehdMptHkCcVosJo8V1mxazx?=
 =?iso-8859-1?Q?tSu+YJs8vUvky35B4qnnNTKks3k/If+9CgjDadzTkK9cgLQoB+eUQ53zx4?=
 =?iso-8859-1?Q?PsUd08QmLdbWHo9aMtD1oQpk4mhB2wYcjiCkAyMy34834rN2dWdYFn4NoT?=
 =?iso-8859-1?Q?TVyW2tjf/WxBipjzshqpZbODNvODDK4mo0h6b49eTsRHErQ+uqzui2QvQS?=
 =?iso-8859-1?Q?ODslPU86FU5fVwGb6rmMQNUiIieCe31A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6iW+O1zILtGFi11yYO4KfBNiz69EHGYIn6XHLIpFMXyTM5fdTrVZfVkidV?=
 =?iso-8859-1?Q?Ix043V6qkk5s3BbOfgALifdSLsJMshMCPcuibYduHTS7hb/AVg+b+0AsUS?=
 =?iso-8859-1?Q?6/A+04Jd/JZtGeDf63zq6UFEsp33rcaOF6olc4CRKsPQHeXao9hzLSsjqF?=
 =?iso-8859-1?Q?KGWYTLl/sKSB/W6Wvs/tHFoEeeK8Q8cNObfAN+HV+qdrB/DTR2gl4xyDSw?=
 =?iso-8859-1?Q?2ZGTu+RoYV/iyp7O+H2RmIIuHCVlBvFfgD8ig9vNaJF/eaH6xGysIFSQ16?=
 =?iso-8859-1?Q?Q5Tgbij1NjKSpeenGrbf0SG4bARsPGQ96MAwQIS5rWFogxO6se9Zwf+ygn?=
 =?iso-8859-1?Q?CHzw+ZQ9PcxvJsNSFSmpkzD2Cf3r4yhbvOfWqimNAhO5AJ7h7Cv0kbRwZM?=
 =?iso-8859-1?Q?gyc2xqZX+lVcyWWVgkS+jQeJHhLkgf+Z8jBIIXg1Ym0tNZcxid0HqiawJw?=
 =?iso-8859-1?Q?t6DGc1poDj0v1bzs4jdC+AuzBd0rLeAHljy5EZRPj08Ew1eIuxznG6z8cG?=
 =?iso-8859-1?Q?yI8KCHtLZtiypMlGVJVSx482DDCI4aTOyYdNug/2fTcX1hR99ObH88S4Sc?=
 =?iso-8859-1?Q?bAMmghTr7B0B7kjSa2VyM5eVeQhFgwNfJthaLbk3i4sgBHSAiKeRs1DLEF?=
 =?iso-8859-1?Q?U8qYku25tK6lNQnrvGvT11qFnS1Swj90+2bTg0s8icsmSexx6NezN5WlHw?=
 =?iso-8859-1?Q?GiVOltf4SchAqZWrJ66EyXUPvDFrK39on431/zDBcNPoWrVTvUkxOgW3F7?=
 =?iso-8859-1?Q?DGnn13oogEcH5EC/syWOn0g/1AGdJtHkjjVdHbX7vaFi5q9ducduxDMmbh?=
 =?iso-8859-1?Q?DRoyJmEmsXrEteqLmi+XmVrrqFG5XAz4EESoHdhcLMUdc4wTK7+kp8bsYl?=
 =?iso-8859-1?Q?9n/rrkoZiZ8AFiZ+02k5zJvTXjl2FpY6WL6myjCaMTD9hS1y4wltXPxU2P?=
 =?iso-8859-1?Q?KYIZoypxX0XnY7cWKGpmfgD00YnvaMHmu8K2hcMsybD6yG/1B/oM8RwiOD?=
 =?iso-8859-1?Q?D5hLddRABQBPD0Ub/y3DJPzOs0ZhDMtwxVutQMqrOIMSKvK8/60tKJ7feI?=
 =?iso-8859-1?Q?ASsvyzqUmADdU9eV5qkEndFHmyfgYNfHSCP0S9DWX+0agNuaxrWM2Jggo5?=
 =?iso-8859-1?Q?41wazzBgft645EWRQRDBmtv5bz0y30qZrQzhyf7psQTcGwywK2iC4Qzi3t?=
 =?iso-8859-1?Q?ZndGMQgbVCwzVKbBXkFoHIwVQsP6nBiw+bjrLtXy9vqN2boPP30OAKRtj6?=
 =?iso-8859-1?Q?nClFPBvoRCAEy5l7F5Bx4zMMXHgC6Brzwxu4qWnbKX/OTWJSwLut5lHYuY?=
 =?iso-8859-1?Q?LCIguITHW7sWWc73PJaefs/VYP6OZezEGdawdNN/wVeO6sFWZqbrxkIG4J?=
 =?iso-8859-1?Q?4e+qDB82II7IVumuMRtnIzWt16KsLEoLCmNPs03t8OtT7sCb/P0WKlx1kJ?=
 =?iso-8859-1?Q?zaCK9yzOLQ6vj/xoBNPQy8nho1KYS/OJO+PJ69nHWkIZ0OqZcPQhgdyBut?=
 =?iso-8859-1?Q?VGXp5BMKPZhCH9UwS/G20cFtQv+CLD51vPv+RJjqAW+p+QWoQLvYOxODwt?=
 =?iso-8859-1?Q?HAFCqp6fwPm4qqOLYN8WFedS2L8PrJ2oBkC1NOyOY8ruLO6fdLsLC5UqqR?=
 =?iso-8859-1?Q?Km9GGPpcDUUgMVlKUjynQpGAmiPI7/u5ab/mai4YWCj+uCXzACMn3Ljg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f18ea3f2-f709-4314-8ad4-08dce52b9726
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2024 10:50:56.1519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rhQ+gMBwr2uIO623vULrY3dxPilMZnySo9OdFuiMGEb1PYGAZ+TM1Pyqws7nWzNq+fJCagdi6dz+Ysp0ti3mY+13yDPzkV9YGE9HjnSgnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11851

Hi Uwe,

> -----Original Message-----
> From: Biju Das
> Sent: Friday, October 4, 2024 2:48 PM
> Subject: RE: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hi Uwe,
>=20
> Thanks for the feedback.
>=20
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > Sent: Friday, October 4, 2024 1:47 PM
> > Subject: Re: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
> >
> > Hello Biju,
> >
> > On Fri, Oct 04, 2024 at 09:53:08AM +0000, Biju Das wrote:
> > > On Wed, Sep 25, Uwe Kleine-K=F6nig wrote:
> > > > On Thu, Aug 08, 2024 at 02:16:19PM +0100, Biju Das wrote:
> > > > > +static int rzg2l_gpt_request(struct pwm_chip *chip, struct
> > > > > +pwm_device
> > > > > +*pwm) {
> > > > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > > > +	u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > > > > +
> > > > > +	mutex_lock(&rzg2l_gpt->lock);
> > > > > +	rzg2l_gpt->user_count[ch]++;
> > > > > +	mutex_unlock(&rzg2l_gpt->lock);
> > > >
> > > > Please consider using guard(mutex)(&rzg2l_gpt->lock);
> > >
> > > Agreed. expect rzg2l_gpt_apply() as it will cause deadlock as
> > > rzg2l_gpt_enable acquires same lock.
> >
> > Note there is scoped_guard() if you don't want to hold the lock for
> > the whole function but only for a block. Regarding rzg2l_gpt_apply()
> > calling
> > rzg2l_gpt_enable(): It might make sense to shift the semantic of
> > rzg2l_gpt_enable() to expect the caller to hold the lock already. This
> > way you won't release the lock just to allow a called function to
> > retake it. This is usually also safer, consider someone manages to grab=
 the lock in between.
>=20
> OK, will remove the lock from rzg2l_gpt_enable().
>=20
> >
> > > > > +	 * clearing the flag will avoid errors during unbind.
> > > > > +	 */
> > > > > +	if (enabled && rzg2l_gpt->bootloader_enabled_channels[pwm->hwpw=
m])
> > > > > +		rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D false;
> > > >
> > > > Hmm, not 100% sure, but I think if rzg2l_gpt_config() below fails, =
cleaning this flag is wrong.
> > > >
> > > > Does rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D=3D true
> > > > imply enabled =3D=3D true? If so, the if condition can be simplifie=
d
> > > > to just the right hand side of the &&. Then even an unconditional
> > > > assignment works, because
> > > >
> > > > 	rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D false;
> > > >
> > > > is a nop if the flag is already false.
> > >
> > > I am planning to drop "bootloader_enabled_channels" based on your
> > > comment in probe() which simplifies the driver.
> >
> > If by saying "drop" you mean that you remove
> > bootloader_enabled_channels completely from the driver, that is the wro=
ng conclusion.
>=20
> "bootloader_enabled_channels" is added mainly for avoiding PM unbalance f=
or bind() followed by
> Unbind(). By adding devm_clock_enabled() to make clk_get_rate() well-defi=
ned, the clock will be always
> on and there is no need for PM run time calls.
>=20
> Am I miss anything here??


Just to add,

previously,=20
a) For bootloader enabled channel case: Clock is ON till linux takes contro=
l in .apply().
b)For bootloader disabled case: Clock is OFF and turned on during enable().

Now, after introducing devm_clock_enabled():
a) For bootloader enabled channel case: Clock is ON and will stay ON till u=
nbind/remove().
b) For bootloader disabled case: Clock is on during probe and will stay ON =
till unbind/remove().

Cheers,
Biju

