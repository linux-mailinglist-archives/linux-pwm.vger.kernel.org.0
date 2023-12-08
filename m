Return-Path: <linux-pwm+bounces-459-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C07980A52A
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 15:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C2D1F20F52
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC0C1DDD8;
	Fri,  8 Dec 2023 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="hK24Ujqq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2121.outbound.protection.outlook.com [40.107.114.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E8310F1;
	Fri,  8 Dec 2023 06:11:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+VEb1I06fCwu2fgnlYWrRIignEI3UHn0yj4OVLv84wWeI4ZQ4MNJ34NLlF+tUhpPOxGPZQRFUrt4eRXs2cMsRg6jIhQdSb/DoTrt0qxlXXvFcuyH1OreHchvH8YfQn+rSuRSn1e6RkW6H+4Ub39erNbVlzFwC98OTc0BRzbl/jmCOa8zm1aPrwXKkd3/7aSIqvYsRjWswLPvkkhFgEQdAEZFd6ud3BX+OiowGYwm3diarufA/U1nnA8Q7jhSJ6U8v01oiRh4ceLrqSRDpvfx5YMNWGviZixBgyyFw7WrDbWqcKSWtqcUQV7pKwsPntvREvrhLK2FRsZKnoGvZmBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCbJEg2GCTsx9owIsJXyii3NZPaeNon6lPdWyHVLcdc=;
 b=lpAgN+OkormN/bBpEJ6HM05uoahQmAIIQTgEV7pbEN0HnDrFsNAMRFQD6oriecv7/41b94rBO9hZaSn+GBA+zCgVLGMgVqRt+GxUrAn1TzvurETq8Yl4BW8bDJHLINz4l50Q1W0UhldYvMVD/XULPdi8dNZMhzJgII43PpXrlDKPjm4n4Dq4Y5G+SzA8FDDheMn30nC1kiZyafaPy0thzjpwk05PNB4oxo9DaVFowdFaR2Eg5Tx5jiHLIDQElH1zfgUlfwpSD4SgjjL0Nj8sz9GdFxBBqdVhSXfpE81LGBrl9Cgd9piKuakst1JIy9Ars5KT+PIeO0073phVFJSHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCbJEg2GCTsx9owIsJXyii3NZPaeNon6lPdWyHVLcdc=;
 b=hK24Ujqq+xmyJ6gOesXC26IflhSDvZjUxojrn8d0dlX4CkCTuavdSu2JJswOqENFMADbnOrA5ylbPr7XtqbejZIk43LUxJt7lg7VBfmU5VlYXgRcCXGZAgekxcT7/qLV6nhK51HVxoowxxy/6vUNXLY5Lyd7lEi0YJO9nxlHvhk=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYBPR01MB5327.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.17; Fri, 8 Dec
 2023 14:11:52 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48%4]) with mapi id 15.20.7091.017; Fri, 8 Dec 2023
 14:11:51 +0000
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
 AQHaG6VjO3tWbpjOM0KBvyBIicGE/LCcr38AgAGHJgCAAD55gIAAsVCggABh/ACAAACWkA==
Date: Fri, 8 Dec 2023 14:11:51 +0000
Message-ID:
 <TYCPR01MB11269900EF62D8CA3E906DBAC868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231120113307.80710-1-biju.das.jz@bp.renesas.com>
 <20231120113307.80710-4-biju.das.jz@bp.renesas.com>
 <20231206183824.g6dc5ib2dfb7um7n@pengutronix.de>
 <TYCPR01MB1126952E843AC08DB732C18A5868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20231207214159.i5347ikpbt2ihznr@pengutronix.de>
 <TYCPR01MB11269C233892B6E3002622C3B868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20231208140718.laekt3jlsmwvzc7x@pengutronix.de>
In-Reply-To: <20231208140718.laekt3jlsmwvzc7x@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYBPR01MB5327:EE_
x-ms-office365-filtering-correlation-id: effabe89-3d8a-401c-0210-08dbf7f7a016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lXh6wtSGhSi776QZv0J801apGF6yZB1ctnD/bVB/luBTZpw4CQtXziR5nTPpImvHph0DoNmN+TiBqTSKWCcirlQf0Oh1SgKYhDrUod8Yqh4+nM4DzL+2egLU2397/qSXw8OcZczCLNOdqsz/ElQp3S8pvidXJogbOVyGhNrd89515PEf6bPqUI3QArgQC7npBxDr6df1DeKCC+oGOF8/6jK6kYUq0v8DQ7VgWdCufzZHzi05CLinIW80dI0t/UujFiwgVVS0IxA0mmsiIVtb9D1vV9w6aEu4OB+jKT2DuuNV7tL5aNbRT985nkiAvp0Emt9kn2pf0SZ0fCQIS6zwUq8QJLJXA27kxvcYVMhuxDP/fyuvLLZ2122HpPtyAoEM2Cbbg6wXn16rKae5xwFlopmGYOiZcCGtKP0a8JYmMBtAdIZdEIGi3SEftRIx81ogwGNBnSzXSegqdB/9c3geH7UnWx4AAPkEBZPAe3vAPrRk1qP4QqzSlxSmMcVIx5LLFDoO/qTftn4Kl9b3LdVOGfYtzZXPsZAavyP72ztRw9MLm+GGsLsOu4mulvrbz2oeX/AigWyOX2C80Bajr/2t3KcG+mvExbRKI4u32TCns7Qd6ngZEMQxGzUtwALeLWShIcqsSeg7dd84IWJ6a0WwtQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(122000001)(86362001)(38100700002)(38070700009)(41300700001)(83380400001)(8936002)(8676002)(4326008)(478600001)(71200400001)(52536014)(76116006)(966005)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(6916009)(26005)(316002)(107886003)(66574015)(53546011)(5660300002)(2906002)(33656002)(9686003)(6506007)(55016003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GVwhcmfXmRmEE3gM1+jX9SNm2+SHz3S3hLYhADSSb6siYHUlJkhqS272+O?=
 =?iso-8859-1?Q?0ydQ8RfH0uyZQ3IwU95JK9F4D0uypAsYU6h2tuqzSqqghBcydF3kA2MHtJ?=
 =?iso-8859-1?Q?Bnhs68gome8d4DftYLrm/gc/OadBtMzvGrp7YABj87pBS8RBpIJKZLQr5S?=
 =?iso-8859-1?Q?ByqHBtFgfW0bJIgAHveCvUZQ/hvRW7Vvi0u+fg3SLDrSFst1TV5jybnZ57?=
 =?iso-8859-1?Q?HyWQyZ0ociM0/SeLr2qDe1NVjLk3ptrHIGjkVYUT+8LKWhSShXcADHaLgr?=
 =?iso-8859-1?Q?C+KyKK6S87p6qA8igSZWHZZpM6CkliTTxeviKcop3URECxS4xFSJMK4sla?=
 =?iso-8859-1?Q?t4zI47fRzHWgiurStfaCvdToCacCLC68BSh7kMFPg2GSSz+ddk5yx4kZVV?=
 =?iso-8859-1?Q?DzsbnoYqAqlhVgdqu+ChlbuTbE1FLXR79yOi4zKEFRHzMCn1iLmOollzdB?=
 =?iso-8859-1?Q?0UR92g8sLpnYjnCziIL0RGryci+svpVn6EBDlO6NDZ3SUgCUyy+mPa5wNW?=
 =?iso-8859-1?Q?Ebw0G+ZbCbkGQQ+/lWK6XNENLkuukzwZaAn80nwTiY8W/mt5Y70VaCe5pS?=
 =?iso-8859-1?Q?zz500Lo08cb9Lddq0b/juIxzygmb3ORHUetYVbcL6Cwd3VHv3wLItdjKF2?=
 =?iso-8859-1?Q?pCNa7PGblGj9qHQ8BfxUzWijqjq0NzdRqH0AVC00Vh838gFcQ876OVlwCX?=
 =?iso-8859-1?Q?fOHOCNnd14HoQIiykhh6C4QDN5Sm652edlH8ZbB1P3bsqXV1tGJMRVLOh9?=
 =?iso-8859-1?Q?xIT9eAh5ORQ0TBo4QM3tehX887Lpz4mtruEU5xjtd7wN827D74Zi7BYJYo?=
 =?iso-8859-1?Q?UOddR87Bg+jvSDZHDyhtmcqWu9F2RIrULLSwLyAES3/6Rom54ORRfQjHwB?=
 =?iso-8859-1?Q?WryXiRAhtT9vrpR5vop4ZQU1I+BSQ+UGZILenk9Uapoko+f3NOujHHFoeR?=
 =?iso-8859-1?Q?mm/+g7CvMfwn//vWksTbWh6+3ZXIZ8CdSVCWzcv63h8AmZRbx8xfdQQvKm?=
 =?iso-8859-1?Q?VH7QxVExtaJRUo2YY5vng/PK3oq7FnR+sjUyVqgy4lkB71l72GsrfUyqYO?=
 =?iso-8859-1?Q?McYF7kQV3iXWC4Z3EaiyOrjtesLBQIoHnvrERerQeNq8X5SUnH/07xvtjX?=
 =?iso-8859-1?Q?PO4gOsNLWWaUaDb+UQMpNnA7EIkdhPFhL2UviRj2zW29fCLyojDpUtpRlF?=
 =?iso-8859-1?Q?mA7f9/MJjnEuGYfCrTiTWWjM51nbWGi50RhxoKQbWEzBYhmstD0WZdtlSd?=
 =?iso-8859-1?Q?ZBbRvgF7xmi1OVpeZ3HfAYtX3k9GKTC5YtZ8Gt17o7GqsRUU4QnsTG6/+D?=
 =?iso-8859-1?Q?65+V5iJnewRbDBiyklDe5E5+IASke7rB0BZDuDPmeiSEOvImVILFN7+3aO?=
 =?iso-8859-1?Q?Tyd/10MRkJCaPOu24aMOzO4qzYcSSX6DcIRBMA6UO9M/8gA7WLc8abylk8?=
 =?iso-8859-1?Q?cbpnZnsVgPwR45zY7Hi+OIJdbsOK1w/sMCZ0GFnF9V1w59GHkUTIHSG9YC?=
 =?iso-8859-1?Q?5Vz25DML6cDwj/WN/GRL3rUp/r34rZ+S/yIQ/B5E4oMhFiWlvhP8l1qhaC?=
 =?iso-8859-1?Q?Zj8PFoZjDvpIPNtAzaqf/Wyw3c5p+QCO7+DEDo1mVXS8Hhq5FQ1Iwobhxm?=
 =?iso-8859-1?Q?kxkQE6mJqquRd3wLUfcmsKPkDigW8yXQmnIIgDR6j5fUHRw+5u9zyp0g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: effabe89-3d8a-401c-0210-08dbf7f7a016
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 14:11:51.7635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+bVOdJMS9iaRkb1QIxUUsUYCVfEuRTzpZFyGFm0Eg2+BIgzshij+GpgLM5jfN6VCe6VU4SB8hWL2dyL3ElbU/NE5f8AfCCxgU9ntVzBAMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5327

Hi Uwe Kleine-K=F6nig,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Friday, December 8, 2023 2:07 PM
> Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello Biju,
>=20
> On Fri, Dec 08, 2023 at 10:34:55AM +0000, Biju Das wrote:
> > > -----Original Message-----
> > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Sent: Thursday, December 7, 2023 9:42 PM
> > > Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> > >
> > > Hello Biju,
> > >
> > > On Thu, Dec 07, 2023 at 06:26:44PM +0000, Biju Das wrote:
> > > > ######[  304.213944] pwm-rzg2l-gpt 10048000.pwm: .apply is not
> > > > idempotent (ena=3D1 pol=3D0 5500000000000/43980352512000) -> (ena=
=3D1
> > > > pol=3D0
> > > > 5500000000000/43980239923200)
> > > > 	 High setting##
> > > > 	[  304.230854] pwm-rzg2l-gpt 10048000.pwm: .apply is not
> > > > idempotent
> > > > (ena=3D1 pol=3D0 23980465100800/43980352512000) -> (ena=3D1 pol=3D0
> > > > 23980465100800/43980239923200)
> > >
> > > Have you tried to understand that? What is the clk rate when this
> happens?
> > > You're not suggesting that mul_u64_u64_div_u64 is wrong, are you?
> >
> > mul_u64_u64_div_u64() works for certain values. But for very high
> > values we are losing precision and is giving unexpected values.
>=20
> Can you reduce the problem to a bogus result of mul_u64_u64_div_u64()?
> I'd be very surprised if the problem was mul_u64_u64_div_u64() and not ho=
w
> it's used in your pwm driver.

When I looked last time, it drops precision here[1]. I will recheck again.
On RZ/G2L family devices, the PWM rate is 100MHz.

[1]
https://elixir.bootlin.com/linux/v6.7-rc4/source/lib/math/div64.c#L214

Cheers,
Biju

