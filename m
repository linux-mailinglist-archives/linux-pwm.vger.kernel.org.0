Return-Path: <linux-pwm+bounces-1258-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D269384F619
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Feb 2024 14:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587901F22C61
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Feb 2024 13:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B1538388;
	Fri,  9 Feb 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kU9XCSbZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2062.outbound.protection.outlook.com [40.107.113.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0BD2E652;
	Fri,  9 Feb 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485955; cv=fail; b=YeDF73htvHJhCBfpbf2NMuHr1ceqCNgghnFLiSc2KmfEi/NWHuiu5T7cs08U+xcm6L7sHTI2kIjEDEwLpH/A34F5tUcRM7V93RuxOccQ4k6glTBsC41jEZUBxvcfefq3inTM7m5J+WFiwDW/V8f3Zj/S5Ycotay+TzqFO36F0u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485955; c=relaxed/simple;
	bh=bFvFtAN6JAJTY+HH3LAPd69GVPzFCACrZECNuc+lR48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H5/ojJZW1Kca3wXYbKVSQCgM/f6Geqzfp3JWMdL7C13WYvCiXPWmqpA+22g14FWfNiWTvLyvK1GP08Su3HZUHLYGE1lWLa1MbJtRrRCe2/jUqvTJlkxrvjSwqjmhc/LHJGK/GL8zz2K1kZE66vmaeudoihVCOP9kADN46EzTNok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=kU9XCSbZ; arc=fail smtp.client-ip=40.107.113.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co6rBJD0oXxIVqFSlCucza2diY6GOyvk6oyqZ+mBABd5ocWb4L4sLHvkyKNbGkN09SmLkAcnvcE+E4W872MuIItcZfbEVNw0toW8ni4Y2w/IgczM2rrnrpdIQYTrI12uKrN7EBcBEtTF3aBKmOUrgGwvIN04wDYly00IUwAFpGNax+GtYg7h6YQ3eaaLDFQHtJeYjaV1Tfl1LkuiAcyrkarOCf/ZGEfuKcvhRy0sF7ePHSiIqrmcUlqeHtiWjJu5+ISdX45BBHHtOZE8tRUcPv5z54x+2OPkYNAQcHsdas1sB7bnqY2ztx4/09yFnBtrY05PY/cWt28al8otl5mj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzB1T4lzhNJJ1lI9ohlnKyONP2L29pag3usSkoR6M3o=;
 b=ThczNFT46J2ybEswUhzP6JSHGhCtFuYWdT3C8ZLKnUJ5JOzlG2cpHHjVECoy7I/hPky9RUwH6gRj8T6kj1EOYlQwCzk6oGMO20vMKwjcbxeDduOnMdbDU7VpEqfmqgzvXJl9Oq4aiy1kcuxEXwFbzMKyfSej67nlKXnsZo0taU3ZPI/ZrEA5IEgqOwz4KDcZkezsomy/GKfQJa9SH2330n8dEsf32B+5QXs/mtwfay3oeIbeVrFc5ZpmmrMUtuEF/DIyTwLJMw/ZOyjVitmjAC3qaEkDaEU9ualGbN7DFxo5rmSYFoz63sunMB+PwoYvhpYpfsXhO2vioUhoehmheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzB1T4lzhNJJ1lI9ohlnKyONP2L29pag3usSkoR6M3o=;
 b=kU9XCSbZQYquLnKz5Ci1tux3ch2lZw0AjnVpc7hgDPv6czsrRPCbQ5n5TjctdwmXU10PcODJJeuvl2Y2HEijYNXw+5eOTcjYO8uQPXyBT7cLgkvtpIDJqStKSY/cr2xWKsgAuWv2RL000oqIyZE9DYa2tRSTt0PzOo/uwbqVzS0=
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 (2603:1096:400:366::13) by OSZPR01MB8529.jpnprd01.prod.outlook.com
 (2603:1096:604:18a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.43; Fri, 9 Feb
 2024 13:39:08 +0000
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::30fc:68c0:95df:41e9]) by TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::30fc:68c0:95df:41e9%3]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 13:39:08 +0000
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
 AQHaG6VjO3tWbpjOM0KBvyBIicGE/LCcr38AgAGHJgCAAD55gIAAsVCggABh/ACAAACWkIAHckBwgAA/rwCAWz9yAA==
Date: Fri, 9 Feb 2024 13:39:08 +0000
Message-ID:
 <TYVPR01MB11279298D880FA94B31219865864B2@TYVPR01MB11279.jpnprd01.prod.outlook.com>
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
In-Reply-To: <20231213114004.cuei66hi3jmcpocj@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11279:EE_|OSZPR01MB8529:EE_
x-ms-office365-filtering-correlation-id: 713f3b3d-510a-4c69-2744-08dc29747ded
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Md6VdyAhddTjIAwWwLwLpDDB8Ib+86u5oxovm+OLGCds0itKzG72znDaEph6kN6jUVHcH7QXuQtqfN53zQlO9I28N3DZ77YU3ufTo8JlTeE4aWClbZC12STRp8+MJ8q80xUyi/VriWuErsyB9RWZr2rMhc9JR6BSvegTUy59kl4AT5HQG4gbu906ePbRpobywNuB9Zx7TVoWU3ZgUyu2kLnGdRcZeZSMBgJhUiEBI8umLgzx1eXQhwcfthYgQl3G6KMOpgFvkjqeFo5pPPqvLsTqfZZ8Cc6YVzgcnN+/RFPE+OpSLYl5dWVnieSI2xm97FKKhI6kAB7whGN1iHIFMSrW0ibHLi+bWBrtoxsSzZVi6t+jyGUyjrDJtf6q0FKB5e7e/UbWjo9Jotps8KrgkRn6QoZCjcvPX0vU0hBRpMI/ubX9lnYhmX8FVL6ocFghQ7RYW4GvUVRGE9PhyeovXIIzA678ZU5lx9ut3IdZ8QxfnTOBBzJbcERvYVgFNjnqQvrtUR+Mv8NsaBN2T4HuyHI8LVzrjNMhu0Ta2+MFgUM1g9Cd6HigTwbT5ec8hea7ldJ6Kie/AuI0rcA+miB9ePBQEbsLs4RUHmJb34TCBFQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11279.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6506007)(7696005)(71200400001)(66556008)(54906003)(66946007)(66446008)(66476007)(64756008)(6916009)(316002)(53546011)(478600001)(76116006)(83380400001)(66574015)(9686003)(26005)(107886003)(2906002)(966005)(8936002)(8676002)(4326008)(5660300002)(86362001)(52536014)(38100700002)(122000001)(33656002)(38070700009)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/LMUnlugGYyjgxcw+LgUN7XbvFbpI0CQaNU1AY+6gaHbCoH0ERr8nNLJRX?=
 =?iso-8859-1?Q?mwOdvCyCG/rPtG49vMuZXEvnavjsz8eAZajNSAEBsCJ96Sj/BBKSnMmWmW?=
 =?iso-8859-1?Q?chAUJ3zMHyiWd0VoDxmOG2Id5HCUVtQRNJcPpYJ0Eu50Z3CUzHGrGQdBpb?=
 =?iso-8859-1?Q?C+/m8ANK6Zmn6w43Cv612mUpkx3oxKpPbcsb0PmuprqXDx/wDoP+a+85sN?=
 =?iso-8859-1?Q?4vy44ATBJC65KNOGkQBU6bOecix3WlHjYCnW/Z5Mbmg/gPhn8p56Qw2195?=
 =?iso-8859-1?Q?RjrT/OCf9SzwFF6SGHHkX7IKlQMcTIiY6FQBy8JCs4wN1ZiFEYH7Y0V2DC?=
 =?iso-8859-1?Q?bsHK06IsVs+Yn7IZVHQBzFR6F7VjtBPXrr2a47qIGbhFri6hk1bkRBdbFH?=
 =?iso-8859-1?Q?JX6CqhURsVrwClniVqgxGIsBKzEg9a+Z0AM0+HD9TFgPxe8/mbZ0RK2iMn?=
 =?iso-8859-1?Q?T6U7FZrSaZZN5LoOwVJAzAHPno+ivO5Ne+VNtTrg+CkE0oJApcdFAggbME?=
 =?iso-8859-1?Q?8wz037dpeBdcztHzMY6lE/nq2yGHYCmCUzZ8g56eZil7Aq25yz/4dvsEPY?=
 =?iso-8859-1?Q?gGRr/85MklrHcpl+hvFyTRg7bTKQBZijHPJ8rzF63E8gOON98/iv3AeZOx?=
 =?iso-8859-1?Q?VCk3unwuOcw6hXtzeU29UNeT3rYkF/wztHg60uCccqOz/9S1rb4w3Oi39N?=
 =?iso-8859-1?Q?sCl3leE05iqKHdNPjlhhgQ7zB56IRkc7xbQJoqD7DfIrojoiQAhNOFPQXr?=
 =?iso-8859-1?Q?ttKWEmGBO4x1PLIySJEiv8kvBuJ6CW3o8FqR3at1hTVT7aZQjjfiJDIssM?=
 =?iso-8859-1?Q?mKRdHNAx2X/lvWWu5YRZ9vGC1+8T555oqRggRT2AvMERtmgDwlpHFwPowU?=
 =?iso-8859-1?Q?o5/YB6fdIYzj/5tngndJPhyhcFfQUjElqd5W4OYYg6isprkrvsCvNSdK5Q?=
 =?iso-8859-1?Q?jdGA057fbJKRB27PEknTpAJYy9xgEx+LryJSQknD0Fmm5HVo4auWOnmFpm?=
 =?iso-8859-1?Q?2xEf4tbSzjxEGWAf0B2LP+A7SMdqZxKWr9/id+WzmCA23qw5zPtBesN+kP?=
 =?iso-8859-1?Q?4G1JLwWuZKG/2aMUEI5advHhXNzZd6rvORV2p21InwR6AWDwKrh3/gIW6Y?=
 =?iso-8859-1?Q?Atotp/CF0Zf6BarEhjrxN6nHY8RtJsbDz0/yDtirkMmzMKL2xZyZ21TMhx?=
 =?iso-8859-1?Q?dl+Oy6zKY3TVzhYnw2OcRNSrd2A8nSXc2bi3WFwVmrMzuFBw0PkRklcVy8?=
 =?iso-8859-1?Q?zCAY8/wSczODlyt6QQUvvWTr0Wq9ux6PgtzrfjdpZR2qgw9zm73KSCcu6+?=
 =?iso-8859-1?Q?XBUuZXEHTcJc4PL0z6l5U0H2yFewKucvDRMevbVsbq6HvibxDGtnAft3pJ?=
 =?iso-8859-1?Q?rerKgWPfuX0rXOHZaVMFFnBCZBJFUltM7YogqzGnZMQw9yYodlbnfH99pB?=
 =?iso-8859-1?Q?zU+tU/tcOzYKymdG21moRbf4NlZ63kteBW+H5ujUIkZ5jm3CmPRejgDZMy?=
 =?iso-8859-1?Q?yeH8F+u4rBWIADPWfaCK/wRqpUkMaYmhG5PzT2ht9KR5lA3nsgSW6LjJNv?=
 =?iso-8859-1?Q?vWfGow5qwchLf4yD5RvLbHvma008pPN8ZHUNBGYoe5Pz6P3Bxk1nJskGOO?=
 =?iso-8859-1?Q?TT0UtQnjbPFOyaRNRuIA9DUjRr6Njf/sDtPPHwtK01BTNclw9BjKj7hA?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11279.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713f3b3d-510a-4c69-2744-08dc29747ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 13:39:08.5035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXiifVgVkqFzOzaQtGM7pU0AzfkTrZ2DhP98REspdRDc/rUfZeOEOAGbhvW6Gz8qh1LB3eruc954yhaJqWuLiv/I6fa21z9Z9vtaiz3lbug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8529

Hi Uwe,

Thanks for the feedback

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Wednesday, December 13, 2023 11:40 AM
> Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
>=20
> On Wed, Dec 13, 2023 at 09:06:56AM +0000, Biju Das wrote:
> > Hi Uwe,
> >
> > > -----Original Message-----
> > > From: Biju Das
> > > Sent: Friday, December 8, 2023 2:12 PM
> > > Subject: RE: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> > >
> > > Hi Uwe Kleine-K=F6nig,
> > >
> > > > -----Original Message-----
> > > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > Sent: Friday, December 8, 2023 2:07 PM
> > > > Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> > > >
> > > > Hello Biju,
> > > >
> > > > On Fri, Dec 08, 2023 at 10:34:55AM +0000, Biju Das wrote:
> > > > > > -----Original Message-----
> > > > > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > > > Sent: Thursday, December 7, 2023 9:42 PM
> > > > > > Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> > > > > >
> > > > > > Hello Biju,
> > > > > >
> > > > > > On Thu, Dec 07, 2023 at 06:26:44PM +0000, Biju Das wrote:
> > > > > > > ######[  304.213944] pwm-rzg2l-gpt 10048000.pwm: .apply is
> > > > > > > not idempotent (ena=3D1 pol=3D0 5500000000000/43980352512000)=
 ->
> > > > > > > (ena=3D1
> > > > > > > pol=3D0
> > > > > > > 5500000000000/43980239923200)
> > > > > > > 	 High setting##
> > > > > > > 	[  304.230854] pwm-rzg2l-gpt 10048000.pwm: .apply is not
> > > > > > > idempotent
> > > > > > > (ena=3D1 pol=3D0 23980465100800/43980352512000) -> (ena=3D1 p=
ol=3D0
> > > > > > > 23980465100800/43980239923200)
> > > > > >
> > > > > > Have you tried to understand that? What is the clk rate when
> > > > > > this
> > > > happens?
> > > > > > You're not suggesting that mul_u64_u64_div_u64 is wrong, are
> you?
> > > > >
> > > > > mul_u64_u64_div_u64() works for certain values. But for very
> > > > > high values we are losing precision and is giving unexpected
> values.
> > > >
> > > > Can you reduce the problem to a bogus result of
> mul_u64_u64_div_u64()?
> > > > I'd be very surprised if the problem was mul_u64_u64_div_u64() and
> > > > not how it's used in your pwm driver.
> > >
> > > When I looked last time, it drops precision here[1]. I will recheck
> again.
> > > On RZ/G2L family devices, the PWM rate is 100MHz.
> > >
> >  [1]
> > https://elixir.bootlin.com/linux/v6.7-rc4/source/lib/math/div64.c#L214
> >
> >
> > Please find the bug details in mul_u64_u64_div_u64() compared to
> > mul_u64_u32_div()
> >
> > Theoretical calculation:
> >
> > Period =3D 43980465100800 nsec
> > Duty_cycle =3D 23980465100800 nsec
> > PWM rate =3D 100MHz
> >
> > period_cycles(tmp) =3D 43980465100800 * (100 * 10 ^ 6) / (10 ^ 9) =3D
> > 4398046510080 prescale =3D ((43980465100800 >> 32) >=3D 256) =3D 5
> > period_cycles =3D min (round_up(4398046510080,( 1 << (2 * 5 )), U32_MAX=
)
> > =3D min (4295162607, U32_MAX) =3D U32_MAX =3D 0xFFFFFFFF duty_cycles =
=3D min
> > (2398046510080, ,( 1 << (2 * 5 )), U32_MAX) =3D  min (2341842295,
> > U32_MAX) =3D 0x8B95AD77
> >
> >
> > with mul_u64_u64_div_u64 (ARM64):
> > [   54.551612] ##### period_cycles_norm=3D43980465100800
> > [   54.305923] ##### period_cycles_tmp=3D4398035251080 ---> This is the
> bug.
>=20
> It took me a while to read from your mail that
>=20
> 	mul_u64_u64_div_u64(43980465100800, 100000000, 1000000000)
>=20
> yields 4398035251080 on your machine (which isn't the exact result).
>=20
> I came to the same conclusion, damn, I thought mul_u64_u64_div_u64() was
> exact. I wonder if it's worth to improve that. One fun fact is that while
> mul_u64_u64_div_u64(43980465100800, 100000000, 1000000000) yields
> 4398035251080 (which is off by 11259000), swapping the parameters (and
> thus using mul_u64_u64_div_u64(100000000, 43980465100800, 1000000000))
> yields 4398046510080 which is the exact result.
>=20
> So this exact issue can be improved by:
>=20
> diff --git a/lib/math/div64.c b/lib/math/div64.c index
> 55a81782e271..9523c3cd37f7 100644
> --- a/lib/math/div64.c
> +++ b/lib/math/div64.c
> @@ -188,6 +188,9 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
>  	u64 res =3D 0, div, rem;
>  	int shift;
>=20
> +	if (a > b)
> +		return mul_u64_u64_div_u64(b, a, c);
> +
>  	/* can a * b overflow ? */
>  	if (ilog2(a) + ilog2(b) > 62) {
>  		/*
>=20
> but the issue stays in principle. I'll think about that for a while.

OK, I found a way to fix this issue

static inline u64 rzg2l_gpt_mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c=
)
{
	u64 retval;

	if (a > b)
		retval =3D mul_u64_u64_div_u64(b, a, c / 2);
	else
		retval =3D mul_u64_u64_div_u64(a, b, c / 2);

	return DIV64_U64_ROUND_UP(retval, 2);
}

In my case divisor is multiple of 2 as it is clk frequency.

a =3D 43980465100800, b=3D 100000000, c =3D 1000000000, expected result aft=
er rounding up =3D 4398046510080

with using above api,

43980465100800 * 100000000 / 500000000 =3D 8796093020160. roundup (87960930=
20160, 2) =3D 4398046510080

I am planning to send v18 with these changes.

Please let me know if you have any comments.

Cheers,
Biju

