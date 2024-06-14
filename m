Return-Path: <linux-pwm+bounces-2474-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3477909035
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 18:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B5D28A150
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D289017B511;
	Fri, 14 Jun 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="jp0jDz13"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2089.outbound.protection.outlook.com [40.107.113.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B4171E71;
	Fri, 14 Jun 2024 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382412; cv=fail; b=bD1qK4HUa1c+iq6HqeFLARhSOS95v2iSNGgRFrKiMbYiHJhbEZPzL0kDT2IlFLCSyzRSaECckcQCqa2ZvphFr2WWq6/tRC65wKAIBTyVgY2bI5ayznrVKsixdnqR+If3zxtsZ4KtRAdy7a8XdZ9Pw8bS60QNTjZqTW1Youpi/zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382412; c=relaxed/simple;
	bh=i1AfrtAl6yZEB/hzfQowfs+Nd/QInJ26D67QA0GReEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hAEt0EqPq92ml2Z2c0cmkMozaBMWO9eQ1g47QNZPkFw2kHLN8IKx4YhCCz9ycDJOg8doCdrx0PlN5LbDA5zmXQLsOiQIafCVx/wstZ2chHA/rrQ+5UUlQQ8rR8V+Eo2s6wqMXJ2qEbichSZ/VfLLyhib4ZP8YRqAnrfDNPjevOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=jp0jDz13; arc=fail smtp.client-ip=40.107.113.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7xztEopJ4lBRhNJ3ppV8PEfg2O5tySumU2W8HIrJYOMNuHrKfJharqcQgf/ST17Luwxkbb3WqlcxFEjtNzgv75WMvFw0fV3VqWFPQw2AEZ4x6jvlw3EwPEQCGSmCgFwwtf2eo6ddRT2OfT2GLpYwFKuHNwOXBbeqmCOOMlMq3x9hKzI5ks7uRDsMg8HyLdggBL3CxAAAjNK1fXJDUTdYq5g4EzQDauVaPyLVJ/S/OHm/yF3+bJ264w7cuyxNxGiJt2H9l+St+aJmrZj8r5PTsC0TZ3Ec4Ig+7ZL7otPYWBvWnZM5xiDrWIuUG6PR6I0WV6IptYXFdtR4m6MTN2hpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB19vgcw4g19tgi/m2JK8pF5U5HMx4tA5cdM7BMWpW4=;
 b=apJfg/iUKXiUM4eBpd61F+xMqKYs0+5IK+ivCoRMaxcx4+guPu9987hTCl8Fr1EATlijMDKjXVdI5zMvXRGuVZSAvqJBbhiztgroDLWPL/M0le69uj/lDom24Cl1MN4bU1glqJN2YHnZw330vkFSSiiaq0c1ci+bqWBQ+jX6HO5RDQBVKdEp38azPWF6+dV/pVUw1iDtQS/l0XdDRSrOwanNLtQhv3EdJkSlKcxmejQV8a3yiqBw64j93hVh2Q3yXo1HUEDEypvGftFlLcdaiQRqUB3J1mgyAUUdMIEDswz41KOTOMRPgxtD9BInGpBmwvA0oArWl2cUJZ+P+e8+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB19vgcw4g19tgi/m2JK8pF5U5HMx4tA5cdM7BMWpW4=;
 b=jp0jDz13vt+TfHavlL4RI5aVtN44KZRDCk7jgBnpPHd1TBthKwtK6k1L+lpqmz2hnSO0VLF46i2HZK9AJ0uvjSziOGmrgNr6TGrJzY3pcHozO52Bb4Aze8lcWJ30jhdf4naow7g7xPzNs7M5SiRVM9TgeawJ8qanGfANGWuW6+M=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSRPR01MB12029.jpnprd01.prod.outlook.com (2603:1096:604:22e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 14 Jun
 2024 16:26:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7677.026; Fri, 14 Jun 2024
 16:26:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] pwm: Fix namespace error
Thread-Topic: [PATCH] pwm: Fix namespace error
Thread-Index: AQHavm1Mj/YQW2ZevUi6CAyrGAK6j7HHYlGAgAAEBNCAAAWZgIAABavQ
Date: Fri, 14 Jun 2024 16:26:41 +0000
Message-ID:
 <TY3PR01MB1134653D1808E014B45D8FB5D86C22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240614151233.398463-1-biju.das.jz@bp.renesas.com>
 <ld5tegce2dpiehqg2offdyrazew2l2vkq3unm3fe3l74lyufg4@vnebm7soytym>
 <TY3PR01MB113466693077CD17D73AE7D4086C22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <jyoiieidwucmjxad2hoy5l2s725x3ffx2fyzrsqvlgku2mdgbi@h3i4ryqpx6ej>
In-Reply-To: <jyoiieidwucmjxad2hoy5l2s725x3ffx2fyzrsqvlgku2mdgbi@h3i4ryqpx6ej>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSRPR01MB12029:EE_
x-ms-office365-filtering-correlation-id: b039b554-727a-45a2-380f-08dc8c8ec5d3
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?p259Evv4ocK6/RCm4nL9uI4fGmJ1X0ZVD+dq1eXuWMzVCvI7ysL2gv7UpV?=
 =?iso-8859-1?Q?N1VtPbz/BaoyImObyOZ3IIjZIlHQKkZOs5+PDvpemA0oirtLa5cZI2uU/H?=
 =?iso-8859-1?Q?e6FWynZUdBhReyusEtlAcyhzhfSsLTVyVcIA0gFFzdHmQC/4ZqtzA/yPW9?=
 =?iso-8859-1?Q?IfoUXexGs4FSpGqWYhgApRPGuWKXI4ekMjHxkCDBHEQ0gjl5tQBTy0ZiPF?=
 =?iso-8859-1?Q?DykWQl7wuTKWZmMErNcbKoQxcTKrvbRaF/YFVN8/uBLFozACHQaf+St9/t?=
 =?iso-8859-1?Q?uOy7kAiAKL2SOCKHgYPcffWFlUjneBKybI2eQ7PJ2NNY/SVjq3BbM79Iq2?=
 =?iso-8859-1?Q?0/jQxYq50WdVJSzTQEzjAeIsvxLVe+TLbu3nRgze7OrnvdviY3uD93dMXE?=
 =?iso-8859-1?Q?DAGaR1rIjLlL98pccTrRIu0BNOIe1fFYm8SIDeshFzhimN4F2AZfrEQCMb?=
 =?iso-8859-1?Q?9BEDWUhDYeCaN9214oKFvYNSAUQzBzsi3etTR4bfRkhsD0aueDQVV4/CBU?=
 =?iso-8859-1?Q?oTzrtTqxSc8ME5gMdPv1tX6E/tt+WLacyl/lLs0SNs2OE2vxzi8F35i13i?=
 =?iso-8859-1?Q?2rA4BlI3Hj6CF8vTulmtF6R6k6PUqGb/B24FanvM+6QRL6/pxPvu7K7E6N?=
 =?iso-8859-1?Q?1OQhpHRarovpgEr7gDrJAyZiPXriZJq30YLgdQR+UBe7BDRrgCeEJVvwTq?=
 =?iso-8859-1?Q?0PhuujHYmRjIgHm7QE8F18B54pmIIKp8G26nTDG41fQhzKFOZnMWm8TU5k?=
 =?iso-8859-1?Q?zylVOQdCSGwPVfa/pIeVJ0moXdIk0bozbGx4CXlNBo/RvD6WAzIBd2gMpz?=
 =?iso-8859-1?Q?HqSZxT5zGBPN3u2JrBCL+Sx0gwU/Qxq2AnN4pfBFbzvGsjCuTyQ+ixN2A4?=
 =?iso-8859-1?Q?Odg2OWATH9A5ZT0dJGEUrvLwWTWjsyIXMtUGVeitmDzgzL3I4pvSCWhXrN?=
 =?iso-8859-1?Q?ynfNn0iGo3IMK8yLbdKV7BI9nR7jmzpuEhQilHx+lCHL01L1VXI6FUZGjX?=
 =?iso-8859-1?Q?qEQQaA6iGQDm1UKhmbMagWUyG+zv+6VeUKlEjQrtaSTq1bhB1lflad8nRd?=
 =?iso-8859-1?Q?N62uAdhOayi0FLVNv4GECMt5sg7aFxWvIu7wM1oB97I32AGhqNdb3jDz7+?=
 =?iso-8859-1?Q?SsW2P4yNiLQHITCr2Y4j/E3zDNgH/QIG87CIsouGHdbuY7xCFtrNwWpnfx?=
 =?iso-8859-1?Q?yzWnOso/35PzGDDRcgEEtbzAE0Mk/+JdnfRisD5fFbRMYveSwIJFh51i9e?=
 =?iso-8859-1?Q?Uyh6VrL4PI9xt1a6WE1JEkTEVASFSDH5Kowv2vWFZJk5tGvr4INJqG1vra?=
 =?iso-8859-1?Q?jsLr4sm430QysLCS1beRaSqYrF4Pq4dj+0/u2h25aXC14ZjsKvs7UgoUUI?=
 =?iso-8859-1?Q?u9KPqHBEPvHtPFxK1wR8bTSKfrIo7gxjjj4mINw2o1AAoZQwpeeKM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6iR8pVBimOASvj9apVZJVi56UDNU5sx1fvvP+vupWlKKsfqjSwg+Np7nV0?=
 =?iso-8859-1?Q?XhG3unRniLC5YXsMpGf2/qk3zdqVetszkMdSxDf8KbFNUc1UxyMIc+Ocyx?=
 =?iso-8859-1?Q?UbNk4CgMW4oNifdvD3J99artHv/TqhL+Z0ooH71Le8wokX63ACX44rjve4?=
 =?iso-8859-1?Q?KVM5RwqLq1dCf0OZjR9swdVRtl5onBsjWBASDXo8xZz22yRyIHzBmaNt2e?=
 =?iso-8859-1?Q?XPW9QNGIPXX/+6Ys2IyNeZPgE1KCTixy1/xEVT0uOV6hObiWeH6cyEtobn?=
 =?iso-8859-1?Q?bvK5tXFiai6JJbGClYEKmPFcycMjR/Kb0w7nPpVJWtZdUexxefgsvdaIir?=
 =?iso-8859-1?Q?qRkqnViYQH51Ht2GkFXltIPnH6FDTo3zNsbIfHEyDgefiAmDKSIkObT3FH?=
 =?iso-8859-1?Q?+vQsnr/ge1pZ94bOUrH+ehwWUZJKsgMRLWY/5+Wp+9VSc0VmfklUn9a7k+?=
 =?iso-8859-1?Q?OPsIBBuuei+E3B5UMbCKHUsOGdofi2tSlI1sXcrQV3BWEfchaiu2zb8TVf?=
 =?iso-8859-1?Q?MatSBpyQTCQKxeAoyoA9UMcXiTyUwZdBZSlglIXA2Lk06FgNs1YVMPgbww?=
 =?iso-8859-1?Q?Arc54KylMc8nzQA+mBbHhsDWqD6bZhospcc3GsK5O9xr/PmAw331jFkzEj?=
 =?iso-8859-1?Q?r/7eLaBk67rEQOBPO2pOx9G3QWt8N2Q6mOENMbVoy1Nsn1Ip2diMeFabhK?=
 =?iso-8859-1?Q?u/X7UOIpJJTImMYGf3YvZISx0kCYm8hrukDFIjldE1C4+CsrmUMyanOwRt?=
 =?iso-8859-1?Q?V2amZaTP8U/6zd1tEgC0flJTzWD854N7NY4V5HxhqMJvoTyYF4HvhbX3o/?=
 =?iso-8859-1?Q?j6HjezM8mPaaGC2nN1YRdXB2iY4/SHU3CV8PbNrghqUzMVcIBTZzIS9+p+?=
 =?iso-8859-1?Q?ISFGMsDtpQUZ1c8yXMNYibPwFd+T4UnXyi/jwq3lnEOlgXQxn62uXeO7k/?=
 =?iso-8859-1?Q?cU6m+fU2NXetYWKNcQbjcX/h+LnGdmmkdVTTgkEpvrNEK4VgLLUia5FJkq?=
 =?iso-8859-1?Q?v8bqnvO6xxXScuNvuI0VEf1MLweqxqP2cXKKlwnF0lkicABOLZdXss6+xP?=
 =?iso-8859-1?Q?J1+q7CeUx79AjV7bcyMLEYoDdKhradIgJmk8EFAEzOkwyboAwCaA9eFRcV?=
 =?iso-8859-1?Q?HrGx3bbMsEv+IlfodHV5d32eqq6MS8swuMjDfBAhS/hqqkdjxevn4AWBl7?=
 =?iso-8859-1?Q?PQMPjWyCdkC36vj0oRK6fd1zgr87ira/thP4b7dW8eQ2Dcq254Tn4oJOZo?=
 =?iso-8859-1?Q?pFpvSu76naenBkAZuyV+ezUDgRzw+Yfut8pqUcjA+A1sYuZSTfw8ehChn9?=
 =?iso-8859-1?Q?o0uXEkJZATLysRw2RvVZuc0QZ7S6xOpgoIF4dqWCb0GTJ1I12gpNP5q8Rj?=
 =?iso-8859-1?Q?5WwkRZfQXqlGm4hUwOfc13q7LUMq7D2BmUG2VmDUpe6yc15AuQjcbNCgsl?=
 =?iso-8859-1?Q?fP22hwSqDysPeKji2kXMf8/uATmQT/7ErRRZbDtbx/AJfawQ5JF18JNy8V?=
 =?iso-8859-1?Q?y6AkR+v6i6skJiHmsQ4RqMQVy1gM4eJte6Kl8j1uaR4AFRZ+2Rem+vvQlj?=
 =?iso-8859-1?Q?Q4Su6dhezydoBOmvEhWRx4QhdIwA3AopwZn8cMfylxp05OfzD/EpK8U+jh?=
 =?iso-8859-1?Q?C4631U7DdDJUwoXZvSc7wNzcpVjrX1vapxiWUJeRQ/drgQhDP0GPNrfw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b039b554-727a-45a2-380f-08dc8c8ec5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 16:26:41.1405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sC/NMQ6gePB8o2aqbyZYuoZkMBUzeeOGU+A9SIzFH1VBcPEIQr3gO0NQIFcQVWFW48x2Fr8vxSjV8IWFuyd1YokWlGNwsO/AsfdYccw7OFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB12029

Hi Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Sent: Friday, June 14, 2024 5:03 PM
> Subject: Re: [PATCH] pwm: Fix namespace error
>=20
> Hello,
>=20
> On Fri, Jun 14, 2024 at 03:44:27PM +0000, Biju Das wrote:
> > > -----Original Message-----
> > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > > Subject: Re: [PATCH] pwm: Fix namespace error
> > >
> > > On Fri, Jun 14, 2024 at 04:12:33PM +0100, Biju Das wrote:
> > > > Fix namespace error due to typo by replacing USB_STORAGE->PWM.
> > > >
> > > > Fixes: aeb9cedc87a2 ("pwm: Make use of a symbol namespace for the
> > > > core")
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > I found that issue locally, too, but obviously failed to squash this
> > > change into the commit. How embarrassing.
> >
> > Yes, It make sense to squash the commit before it lands to linus tree.
>=20
> I squashed your patch into mine now and added:
>=20
> 	Thanks to Biju Das for pointing out a cut'n'paste failure in my
> 	initial patch.
>=20
> to the commit log.

>=20
> Is this ok for you? If not, keeping the fix separate would be ok for me, =
too.

Yes, It is ok, if you just squash the patch.

I don't mind, if you remove "Thanks to Biju Das for pointing out a cut'n'pa=
ste failure in my
initial patch." as you already found the issue locally.

Cheers,
biju

