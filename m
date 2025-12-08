Return-Path: <linux-pwm+bounces-7776-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B98BCACE84
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Dec 2025 11:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22A85303A0B0
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Dec 2025 10:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B433E311966;
	Mon,  8 Dec 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="LHR2LUf5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011033.outbound.protection.outlook.com [40.107.74.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378703101DA;
	Mon,  8 Dec 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765190582; cv=fail; b=lCP8QKgv3JAuuks7hpxSKq6chu2IrboOGGIXZV+U5s/y3UjVtqeLzNyJ1DKV0thHM5T5mfkK/VXW3A21lBAUee20zTUIIbymQEbC813MP5i0gYLN0BepJp/HJTnE/8lY92SGr+PsZzSEEcoplG74F3CuBMVSVZwtK0YOU7x8kCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765190582; c=relaxed/simple;
	bh=gZ3tomXEAgJTWibW6uOGIbKkfNbaVd+lW7MqiX2SHxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BbBbpb2Fu5PaJEAofdUH0THKeli1QynmLDJGWA44fiuN4Z828noBVNi2vESF24rp8CexZnJPkxoTLd57YlfoudhZXL8ZzE4XZ9Ffp0we7duncrwOMckqhIyqRrT0UpYMitcOIwdD6qtjQI3CCvohzKLPi6qk1OBR6GI+MDdhz3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=LHR2LUf5; arc=fail smtp.client-ip=40.107.74.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Afh9h6f90b//5oFw0lQl1Yc/guaBMcKW8bQacAOTakAns/G6mBNHfPpcccKgKtEVHOQ6CHBY7sqiNotM53yO63qLpCTmBsPteHoucGpqazPfYOsS3TIcMgGx/mtILT7T/4fvq4aBgTOGuUMx6lK/N/nNiKpzdh0LzWHr0ze5I3LnoOuQvk1gtX5msXuLzTLVzLMXy/UAkGWx0Hce2C3NQt553AFpQTJrGIE5g9Wz12YvX8Vqds5nGI0H8pUOQTWaXuqJ3p81d3FbDTsZ/27QkXEI+BFqImhpDfBmdyYFRKvkI+9pQQs8qW60gSPEy9no+x2SxPFQR8VRgFooHRSPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u81eqSe7UkpJuyl68IgVh2j4v+Xq6vfs2S0vqwQ4KDA=;
 b=U36VOSEr/Kq9K3dZ+vEEEmeBZjkxvAPDyiN0DvRFQwIhVHQMHNBhZUmTIXlH74Z15Fv2ecfFWcUETvxCsc5sL5irb8gS6/zKwT5ycabfzvlqtXaiTLaYFBnBcu2clqQlbohrQawg2O3mhQLp4Gr50sp2k8pASXnXk4BUvKfs8wT4JDBbqKHMM3I1lLQ5hLRDs9yPb3ZuflG2A6VTXgacNmF3FlaM6lbvC71YOZ0EHNETgi84Uo6xOHXDGW9k6z20g0cOS+anMGfyRneJF1Uym3o8+DeWCx5xBFkp5eXYlfyyH/LZd/gddTn5KvjDqNAxu8L4rGj4qPw6oWmhiFRuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u81eqSe7UkpJuyl68IgVh2j4v+Xq6vfs2S0vqwQ4KDA=;
 b=LHR2LUf5x4T1A0VdjKUqfvdbuyqZw+irCgB8ssNuKpbDoebqjEQMyrsjewLXJn/XIAprz9cDCBKJhg2pDvUkSpeKN//eKz5hInQDMeqH53o1uyf30ybmevm1wuwVGc94FWkKu5CcEBys2A0EqiKA3Oi6b+9zf4AOAGq2FJoSdI8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB13018.jpnprd01.prod.outlook.com (2603:1096:405:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Mon, 8 Dec
 2025 10:42:55 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9412.005; Mon, 8 Dec 2025
 10:42:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
Thread-Topic: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
Thread-Index: AQHcLJi5Wq0nvzczj0CSEUAgjJVVOrULUGQAgAyzZoA=
Date: Mon, 8 Dec 2025 10:42:55 +0000
Message-ID:
 <TY3PR01MB11346774C4D6D95C27057158986A2A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-7-biju.das.jz@bp.renesas.com>
 <wah57av7ypb42zcaosx7n64j6qmmcq5ylhgnde2brbiy6o7sun@7rqkr6ke3g5k>
In-Reply-To: <wah57av7ypb42zcaosx7n64j6qmmcq5ylhgnde2brbiy6o7sun@7rqkr6ke3g5k>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB13018:EE_
x-ms-office365-filtering-correlation-id: 9f98b1f9-8d91-454a-87cb-08de36468bb2
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rkYXBxWVdpv0bbK20lIruJET/Ig2OjeSmS1Pl9ez7IScGATRAZaMgMihfU?=
 =?iso-8859-1?Q?ocE/swxfPM2J1Gs5n7Xq/fGB4suymoeJUG2rk2cl0EpuvE5QGDMCeGabS1?=
 =?iso-8859-1?Q?8rH8CB1Xs9fnAiDuts1zIOS/hSwPaCVvdNc5QTrfSVa61ksyZtozltHgz8?=
 =?iso-8859-1?Q?Cgo5iebKqWtK9L8ij3Pr5b9QgBeNjCtojw8hqYAureLMybitsIfYgY2i5d?=
 =?iso-8859-1?Q?Ryp6HdtapAFsCzKp962KU0hK359yymB6MliXFujGgYJDzsCAkM1a3hXzqi?=
 =?iso-8859-1?Q?nvCaeCGm/FKwflqhoe2UbAF3xWo1oSJcxOW/Muj2KapnSLYUzJGCVlw0i+?=
 =?iso-8859-1?Q?XfNBDF4nXd2Qhb+Y6F9pss0/HUS7Y/Ro6POUyjOZbTJgsUUg/lGCSev4OH?=
 =?iso-8859-1?Q?QmoQtMHzbnrl0Gn7dNiQLU7d6pfZd7QTZ6xeBaYHgtA22qJ3vvwekpLO69?=
 =?iso-8859-1?Q?Sbdq1Qm+iqIVEqu88DGfOV5PxQ5IsdepeFOVr4RQW8QmaeSywaONZtt09h?=
 =?iso-8859-1?Q?YdXhkafsd4IyDdjBcCdG6fia3TA60VV1wi2FIsrcVfm0idIyYO3x0P32/B?=
 =?iso-8859-1?Q?0ehkjwV6oQxmomFY0uEtbAySHolC/HF5T18WX5hj42BM7H5ZIi0y+h3dfQ?=
 =?iso-8859-1?Q?FLHHdTEddAaHj45rz0zF5sR+qfyGGsViNTpzorjS0hSXMjZuHD+I6SQ5yb?=
 =?iso-8859-1?Q?T3GV6ni8s/QHec4b6leGBcmeifEAJrsSxxDj1F1H90Vz8b4tJhwgTMae0p?=
 =?iso-8859-1?Q?KSPc1Yy9HTouCOOrm1OvS59Z418rs56BlmySxtVlZws6ORkErwNVyK/iwR?=
 =?iso-8859-1?Q?z9BwhDPC0+wP+KukvuhHZUVH+DCMxTKT90xyFqUvgarwCRdflIgTtYFDSm?=
 =?iso-8859-1?Q?g5ny+8esibRjhVE6knzcdxWo3bM5r1zo481csCCxw0HC2fqEyhMf3lFdjW?=
 =?iso-8859-1?Q?wG8YzyUgwhFSX1mNGNtC14x63yVL2JvA3OyxaFvUu7jcGtQ26o06C+SSly?=
 =?iso-8859-1?Q?+r9wSISeX4N1NtNr0K9trBB7iNydfjTx1XGiD5tAFd8y4FpaY8nIPdT5hY?=
 =?iso-8859-1?Q?S27hzfVXNU9P3iV8uSd1ZS52ml9/YtdgTOWC6MKwEYkJgx58v6eUo81Dz1?=
 =?iso-8859-1?Q?GdTiAOdvVvbFqTVHpd+6hyv/3HbIYxIrQRdCYQO6Na0eAhiHhRwVn0bMES?=
 =?iso-8859-1?Q?QzAEy6NurbQuXmiW+5ZJsHpS9qx213LGB/viMEYxqThoSI+GmfwRbZF0+y?=
 =?iso-8859-1?Q?AHqPauwLKf0lzfyx7jgIMsUCmAap2OJTbTCQMNUIXgvfCUANS2czzQxJxC?=
 =?iso-8859-1?Q?wPAiju1KAbNMWHNDz+snCbs87uyyE3uYQDAPX8ch6EnTHDG/qOtXhoVxyZ?=
 =?iso-8859-1?Q?REY6ixn2jiOKgWQaNfeLUVsp5gcd/fyfd8ovEKrMR6Y6d5EMbw5Htuggii?=
 =?iso-8859-1?Q?//SgKmQwD9m9T0a0Nn35guyhQysFcL4fXcxbPxtL8lM961Mrt6dglxwPSb?=
 =?iso-8859-1?Q?Ab7GC73Ng8gHQD5T/M/w2n4QAYwgRBnffDvxM6cvanW3WpXNiM49w2Zep9?=
 =?iso-8859-1?Q?UYX5excj7yywUs6bn1mkbOzMbte8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?j/va8OcsDmRRkeH2kxRr9paDkb9BynfYkzr/vZ+aXzA5ov4jA9CAle0b9E?=
 =?iso-8859-1?Q?bakp59gbPNbjQYWQe9rxMjQAsNyApdPR00rn+svN79aoAK41aMP+OuVeBd?=
 =?iso-8859-1?Q?yKFn4EJUZC6edlhlnVv3O8nWNZkqmyV1hvOpGbtSkjLd3tqdPRRJx+PyRq?=
 =?iso-8859-1?Q?LNRlPxVpiAgMz8Z2slkyaG1AV/9gLTgMz3PRTHs12gddkVIOSxvNiFOHfR?=
 =?iso-8859-1?Q?KWCc4s9rRd6sPChs2xiLzIfyo2sD0nh35IHrVIc2ck5Nrg8vbTOYUhL0Oi?=
 =?iso-8859-1?Q?4lntWMEgDnuFZ8kWZjtXf7uuiX8f9Ww5ENgul9TrkEEMUk987Xfr4x1pLH?=
 =?iso-8859-1?Q?Qa/ec4cjr8/0WMJYS2jODOOdh/CW+HzSVCuLGwv0Gtb0VAJqmP4RHVBXf2?=
 =?iso-8859-1?Q?PgpqfrT9XtTFjpOU622CJ9MsIGXFqJy09XflweEfoL/7hAfBgJf79u1zzU?=
 =?iso-8859-1?Q?ihVOfPhc2TEygh4VUKRd5K9WLe+JKpZQPC3xf8H3aJZaaEy83gSC8G/jP7?=
 =?iso-8859-1?Q?toSqrMagibaAQwYaFQGiQ7SFbIw8LauSgYgYUipSxQOPnpU4/nRdct3lMz?=
 =?iso-8859-1?Q?JmZFDtssJ+S+R2/U7O8ZgS3oB+50+t7HJDEp4HvgWj9qdi9PUD9EbeCAm4?=
 =?iso-8859-1?Q?UgIbIbPGGPVvgvn2yzl66sTa2Nz+S7gZr5p5UPBwO270xt1hkIcwZRXcZ7?=
 =?iso-8859-1?Q?1uOhgdyIvMFdS+ZlzzBm/0eA23Mqj4Du5FH/70IfafImPPRV89KqZksdRQ?=
 =?iso-8859-1?Q?aiTDkPMqDZgIxESDKRnWaJGxYGpyqiFjY/SZkHuDPfdlsCNcQD0C1tWxUc?=
 =?iso-8859-1?Q?0wKQVShfv0TjSOHIxCbgk9ovhBD505h+xxD+k4mOjZeHkmM6yb0g19AhYI?=
 =?iso-8859-1?Q?QmZez0XEQP6oJxaaWP2CK8iUx0Sfjmv4UHgHfcJ7XHYiwZgRBsly6nsVlO?=
 =?iso-8859-1?Q?OnbSrqV1Ryj5RW6uYueDan0LFWkW1ouKEVJCKFRV9crK3wRvoGUiXX3CJ9?=
 =?iso-8859-1?Q?lUomNDRBBF9j0V57ZQFnbyvnZ4VcgIDBY5Ks+lSeJk6tpCYYyMqGqEgEFj?=
 =?iso-8859-1?Q?3A8Y4H23tzmzb8k2yWd0xRofa/hlxzur8kR7q1VwAhnEfXI6QjgUCb9Ow4?=
 =?iso-8859-1?Q?pYFiCy3UnxBbMwwCvK4bE1On30Ei+D2BV20Q9xerxXOtyjHb+HVgAMEUct?=
 =?iso-8859-1?Q?dtIjbrXwFGe7MktIVuqoSXsB6Bz0BXfg9wLEs484m5XC7zZJTqY10pyrXo?=
 =?iso-8859-1?Q?T6US1Jy+ssfofE0+mtYSL10OGA4axkgvk3QtmSeAXr9PanyG02wogtIHDU?=
 =?iso-8859-1?Q?kveWwv/VdE81yWFUXQgoFg0NNVd6iZBeAqJUwor89nk2yvYjCb/DrkaP6P?=
 =?iso-8859-1?Q?SfBuhTGLPeqfXUqKmx4hJPsG26oi5AtnJo3JX6pywnTK0dPf5boSZ/qIkw?=
 =?iso-8859-1?Q?pZUYjHzooHktCNfnZg7kWF9HRvTu/HtLAqbjSLTS6a2W3z/ykxwSqOavpo?=
 =?iso-8859-1?Q?4/ibIKYnAqJYhm5RQogLGsH00WE8pnM/eKjMybndQGGdYys/d5apT1kn8r?=
 =?iso-8859-1?Q?Gn7FlhB1ZuIpquzq1w0wOgiyq3ki1hIVTKI2oBn01p11naH9OMsm3MdXaI?=
 =?iso-8859-1?Q?4Al1hWhqGmzLn5s5+V/8zNqKtnhxa8Nt7elkPbt2FG8zYO9ZLaLF+YXQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f98b1f9-8d91-454a-87cb-08de36468bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 10:42:55.2465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: as+uqW/AG+nNDkX/T+taqMeeMKIyKyGOTYbemlkvRNQeaGFt9viwhSqg/HB+vrlWNnVIRkNLwJ6HucjLH/WR0NlSak93/N16/YwibVAwXb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13018

Hi Uwe Kleine-K=F6nig,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 30 November 2025 08:39
> Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
>=20
> On Tue, Sep 23, 2025 at 03:45:10PM +0100, Biju wrote:
> > +static int rzg2l_gpt_suspend(struct device *dev) {
> > +	struct pwm_chip *chip =3D dev_get_drvdata(dev);
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
> > +		if (!rzg2l_gpt->channel_enable_count[i])
> > +			continue;
> > +
> > +		rzg2l_gpt->hw_cache[i].gtpr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR=
(i));
> > +		rzg2l_gpt->hw_cache[i].gtccr[0] =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_=
GTCCR(i, 0));
> > +		rzg2l_gpt->hw_cache[i].gtccr[1] =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_=
GTCCR(i, 1));
> > +		rzg2l_gpt->hw_cache[i].gtcr =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR=
(i));
> > +		rzg2l_gpt->hw_cache[i].gtior =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTI=
OR(i));
> > +	}
> > +
> > +	clk_disable_unprepare(rzg2l_gpt->clk);
> > +	clk_disable_unprepare(rzg2l_gpt->bus_clk);
> > +	reset_control_assert(rzg2l_gpt->rst_s);
> > +	reset_control_assert(rzg2l_gpt->rst);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rzg2l_gpt_resume(struct device *dev) {
> > +	struct pwm_chip *chip =3D dev_get_drvdata(dev);
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	ret =3D reset_control_deassert(rzg2l_gpt->rst);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D reset_control_deassert(rzg2l_gpt->rst_s);
> > +	if (ret)
> > +		goto fail_reset;
> > +
> > +	ret =3D clk_prepare_enable(rzg2l_gpt->bus_clk);
> > +	if (ret)
> > +		goto fail_reset_all;
> > +
> > +	ret =3D clk_prepare_enable(rzg2l_gpt->clk);
> > +	if (ret)
> > +		goto fail_bus_clk;
> > +
> > +	for (i =3D 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
> > +		if (!rzg2l_gpt->channel_enable_count[i])
> > +			continue;
> > +
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(i), rzg2l_gpt->hw_cache[i].gtp=
r);
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 0), rzg2l_gpt->hw_cache[i]=
.gtccr[0]);
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 1), rzg2l_gpt->hw_cache[i]=
.gtccr[1]);
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCR(i), rzg2l_gpt->hw_cache[i].gtc=
r);
> > +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTIOR(i), rzg2l_gpt->hw_cache[i].gt=
ior);
> > +	}
> > +
> > +	return 0;
> > +fail_bus_clk:
> > +	clk_disable_unprepare(rzg2l_gpt->bus_clk);
> > +fail_reset_all:
> > +	reset_control_assert(rzg2l_gpt->rst_s);
> > +fail_reset:
> > +	reset_control_assert(rzg2l_gpt->rst);
> > +	return ret;
>=20
> I wonder what happens if these calls in the error path fail. I think the =
correct way would be to track
> the actual state to handle the state on the next invokation for .resume()=
 properly. But note that
> suspend/resume is a somewhat blind spot for me, so I'm unsure here. (And =
I'm aware that most resume
> callbacks don't cope cleanly here.)

One of your concerns is addressed here[1]. In case of reset_assert failure(=
) we sets the register
bit back to deassert and vice versa to make it operational in case of suspe=
nd failure and
power saving mode in case of resume failure.

If the calls in error path for resume fails, it is set to operational state=
.

[1]
https://lore.kernel.org/all/20251208101356.101379-1-biju.das.jz@bp.renesas.=
com/

Cheers,
Biju

