Return-Path: <linux-pwm+bounces-455-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717E580A11E
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 11:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F0C1C20AE4
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0AB18E20;
	Fri,  8 Dec 2023 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="GYYlO0el"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2135.outbound.protection.outlook.com [40.107.113.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654631703;
	Fri,  8 Dec 2023 02:34:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce/tZCSHkxCgUjMu3FHm+ZOyfVtzKxXoSGggL6LE0RSUwiU/Kiifk1dwdq43nWXVTHNbbtiGC1plPmbJF6YAfE6Diw7Df04DxHW7b+tTRNYbkUangLoZwr4ZD64ewzFlDsNS6Nfq2zPK1fSOnZYCNXtDeFk1G224L7SvQczdVHPabYzSOqs6MacYu7fuX7tnT+Eg7a6IjKvneP11oe1lUtF45pXUqhxmjn7eZlRJHJnFGE1uVJNvViaMhIDb1ijn/WmArBEhYx4gKzpWOZgznHi0fQ41S/Mz3ZImaHDhEmVBm1JJf8M7I1Yn36DARfJLkUWivDxaU0WllMWkejDhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chALO1wNfY7ctj+8UxUWq0bP+7Zm4I5YDuJ4/2IlOCA=;
 b=gQm9u7JbEhse/mC/A02jresnmpKUJxzMCiiafd7ed1bieqxOezF6lAc8cAt5JrBcBBtvRgCxM0LaHeB6Vj2bGNfnuA/jSJ6bOsjFNY2XLvCh3ON9gzKDOHqWAKndEGuwnuj4emdEigfdqP5vgDxVKcllpHE9w4UPtfQKSUZ1RKW8UCLv+O+UpinUP3I0A1bnmOJU47Of5AmAYEKMoTVFbyZhKNxB5vwPcVep0Mq1yRXsSyGaovW0nR7k6oO26CJ71UNPxowohpWwC9F0Xy6+t7vXRSN67aQ/vnJE1SFSDWZQX89mOjzeXQnMv0SK8ySRUUGxebWH39u9tCWRlpgT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chALO1wNfY7ctj+8UxUWq0bP+7Zm4I5YDuJ4/2IlOCA=;
 b=GYYlO0elUk8aQKCccCyTiEAMWFXKOUsxOy193xVv/E9drp7PwZCf8HDFEvKFDLpqBlTc9y3J90cvZe5qshNg7BUgUtaDXvHg0/KgWLqnOovRbFM6EP2Qd5FF0d826RrmGDxihNBdlhBnNO44YjIYSYGyvInVFLlXFh7FQX9feU0=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TY3PR01MB11796.jpnprd01.prod.outlook.com
 (2603:1096:400:370::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Fri, 8 Dec
 2023 10:34:55 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48%4]) with mapi id 15.20.7091.017; Fri, 8 Dec 2023
 10:34:55 +0000
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
Thread-Index: AQHaG6VjO3tWbpjOM0KBvyBIicGE/LCcr38AgAGHJgCAAD55gIAAsVCg
Date: Fri, 8 Dec 2023 10:34:55 +0000
Message-ID:
 <TYCPR01MB11269C233892B6E3002622C3B868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231120113307.80710-1-biju.das.jz@bp.renesas.com>
 <20231120113307.80710-4-biju.das.jz@bp.renesas.com>
 <20231206183824.g6dc5ib2dfb7um7n@pengutronix.de>
 <TYCPR01MB1126952E843AC08DB732C18A5868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20231207214159.i5347ikpbt2ihznr@pengutronix.de>
In-Reply-To: <20231207214159.i5347ikpbt2ihznr@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TY3PR01MB11796:EE_
x-ms-office365-filtering-correlation-id: 6e7c94b1-6e66-4d62-991e-08dbf7d95196
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HzHMjiC7rNm8ekpX4pDkz0VdrCCJt6WWmZAnO5kxPA4+FmznICWuRgVA3/XUZi4XUL7uvLHD6h0CjH6e+/3SLWl/wVLN2AMrSkDoVY7L0keSB6FPCOfw75uHTd58Y5WlGDaThT/kc+0IMl5yKd5rm/oV9O+/dd7Wc4mgp9c+bCcBSYFtye9/Y+WaMgWc01fSAfwq/AMvoa1pSVDeJkbYpdKnrS/TxLoBDnfWoryZOzsMGChNyqIPvHqZq8nVhMpQ2tQv7iIWawGp2BqIGbUXwP72M4lZ8b2ZgzkjI1qA8IC9ASdwb1c1ait4BChvlti7PjHtKzfJVxt9dBRjmXRGMJSUJQQri3nP1NTDPBR+hEvTrwlVf8te89/1kQ4UoBPBT8lFDI97j98QXLIBD5gIE1C4fSkYTxCs+J0NdjzyCnZt8nhLsAxXUUd0VO1fltMXGwpgKFRtdNTYehIO9zAKQ2/J8VCqk2seTQYgxNc9jvfheGMiQ5Hg99srRBAX/16xHe7MK84UhPyjcKcX1P6vml+JpJTuc7ayCDJqzpD/SfG0e2sZAZQC5Cmtq6+YUsMjuwjOeO9v8ZXLXYQ1PevhXG6acvVXk2gVMnM7tNa1EE8ZRLxY0rR8Z6Jeov7eM3bY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(7696005)(107886003)(76116006)(9686003)(66574015)(26005)(83380400001)(478600001)(66446008)(6916009)(54906003)(66476007)(316002)(64756008)(66946007)(66556008)(38070700009)(6506007)(53546011)(5660300002)(71200400001)(33656002)(38100700002)(55016003)(122000001)(2906002)(52536014)(41300700001)(8936002)(8676002)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cv8xg62ulKsLENXp2Stepjf3hJqGnovy/TNKJ/GYRi1RthNiJYV/ktXXfp?=
 =?iso-8859-1?Q?Pr3golv0/H9y/9QgmkFx48fy02U4zpuDQoORBOxnm0O+/YlXKxAPn/ZH0n?=
 =?iso-8859-1?Q?MR8UEOjDNDAZ8eHfU+K7AYO/qM9T/+XCQA69pG2pdpf2e5BWBa6qyf2vPm?=
 =?iso-8859-1?Q?ckgJhpdgTRTa2/UG5DxutR6QASiuXK6v1+x4Wwl0t0EPTD1cXMz9mJKn/V?=
 =?iso-8859-1?Q?EGXeBoMYDSglE5Pu49h4+STgrDOnTqhQ+Hdc2bXhRTXJfY4iYcNaMFUAnT?=
 =?iso-8859-1?Q?39cg+60dR33B2Pyszo9hqfx7vOGQ3JQYfK4+84uXluWatT9AmVcBi2hnI7?=
 =?iso-8859-1?Q?9Qa66lDr2KAs0Ga4RUJGBKHJtaUiKcASib730Gr5+GoOENaGXyn/Ttq7Vi?=
 =?iso-8859-1?Q?ivyJEsrO2qcNGrLsb2o0GVbJGMAc22gcdVUN9L5mQ+w9rlrkpLkEuI4/pc?=
 =?iso-8859-1?Q?KHWcRFy4X7K+U5mh497h255TzeKZCAvC2rJtYwZfPuePXsnsxhra5bEXr/?=
 =?iso-8859-1?Q?jeCZE5fPNC+EJ6ngnvNmlc01lfWRrNxubLvUD56FLx0M25Fj8DGsLv7wZW?=
 =?iso-8859-1?Q?m2H8tb1lgF2puM+vTXhnI48Ffsj9EjjCo7iN4dngcaVtifCkkC0gqdmNbR?=
 =?iso-8859-1?Q?QZtpgFBVc0ocVdy8pZk+o8/OOsXFsiSvJyId2wnXJIxANfe2Z720fk+jaO?=
 =?iso-8859-1?Q?6TD4v/zXK7MRAL0u7eWyQlyHi+6I1zK0oAr2pTbkMrHV7fbkqTTyw46SEu?=
 =?iso-8859-1?Q?AXPyTibYACmZhPPaOiyGHLMzrfXVfHs3Va+3G3lqmC5dkvrWKjD5oA/7eb?=
 =?iso-8859-1?Q?WlvegdOv2vSl4qCB4WBOKZ1B2Rwp5++nRrHB+wfVQHdoS6wZOVWte78j79?=
 =?iso-8859-1?Q?f2Gi2PUdMHWvtJAGPESGTfi6e585B5yURYDpfpKRQE4xtZeniFZzb20v4X?=
 =?iso-8859-1?Q?giudL+mA1m+A6tkrbViHs5WFg7vlg6lj2b0G2A3djmpmv2L9Zz9zt0oS54?=
 =?iso-8859-1?Q?dYjIvCicd/7AnO7Uz+MYTChYW8JjItkSwd38m16c3RzymltvtgQhoFsJJZ?=
 =?iso-8859-1?Q?CyhharxEoom6/XIdvuEhE43+jvkgSaDtQ6YmZSnBqcz85VrtQHMkX+sWi1?=
 =?iso-8859-1?Q?f2S7tqw+qg8zDa0/D7JobLXj8IRRWNR2tPpxhWsJOCF0TTinZewyZS+e6y?=
 =?iso-8859-1?Q?PhqNfFzRwybenXCvbbPQAd9RCYZfiiWDgkw2nSfrbvDHGM7SkaA5oVqDXF?=
 =?iso-8859-1?Q?mfi53Hi8fllIB6OjCNLqpX72AYoYVztoKh2XLq2fLILWQ3laSxIVwuZI0u?=
 =?iso-8859-1?Q?kWLdzO1scFKkP9gw6DRntpqaQD9gpiLnx4lkBFW56dYmVORQb8JIHuz2fN?=
 =?iso-8859-1?Q?rW2F74tPbt8wpGEY1qfRFyZOsxLa0J1o+pnI0set56fURYBXgSJZMnbCbK?=
 =?iso-8859-1?Q?SHDUv28gcHM+MR7kk0l/+RyuckZ/d5NqjsD15TmSCFH9z6VXcxeCdJ1+qZ?=
 =?iso-8859-1?Q?wPFvr8YKs89lG9bXwNehuB578SMHOhnVAY/taF6ECnAGDOhWQHMwYNxdMZ?=
 =?iso-8859-1?Q?FwC8/wkHXOcjFbUhPxkijaA8QqXrModkL19loEdwLdD4UWr1JOkaQi8QrF?=
 =?iso-8859-1?Q?CJ/b5pikygFW5/hEEXgYbgFxrBdi/F+iP6UX7C96INlkkE1J7N0bHhUw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7c94b1-6e66-4d62-991e-08dbf7d95196
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 10:34:55.1217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPBiipUlWU9sEMn0dbJ79b8Ea0T9bqGO27DtbssoRmXHIQxdOGmvcFx7PQzcGH4zsznG7vARDzjcB7kyB986QUrK6uOiWcar16lk+FkGlG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11796

Hi Uwe Kleine-K=F6nig,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Thursday, December 7, 2023 9:42 PM
> Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello Biju,
>=20
> On Thu, Dec 07, 2023 at 06:26:44PM +0000, Biju Das wrote:
> > > -----Original Message-----
> > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Sent: Wednesday, December 6, 2023 6:38 PM
> > > Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT On Mon,
> > > Nov 20, 2023 at 11:33:06AM +0000, Biju Das wrote:
> > > > +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip
> > > > +*rzg2l_gpt,
> > > > +u32 val, u8 prescale) {
> > > > +	u64 retval;
> > > > +	u64 tmp;
> > > > +
> > > > +	tmp =3D NSEC_PER_SEC * (u64)val;
> > > > +	/*
> > > > +	 * To avoid losing precision for smaller period/duty cycle
> values
> > > > +	 * ((2^32 * 10^9 << 2) < 2^64), do not process the rounded
> values.
> > > > +	 */
> > > > +	if (prescale < 2)
> > > > +		retval =3D DIV64_U64_ROUND_UP(tmp << (2 * prescale),
> rzg2l_gpt-
> > > >rate);
> > > > +	else
> > > > +		retval =3D DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate) << (2
> *
> > > > +prescale);
> > >
> > > Maybe introduce a mul_u64_u64_div64_roundup (similar to
> > > mul_u64_u64_div64) to also be exact for prescale >=3D 2?
> >
> > mul_u64_u64_div_u64()has a bug already and we are losing precision with
> very high values.
> > See the output with CONFIG_PWM_DEBUG enabled[1]. So we cannot reuse
> > mul_u64_u64_div64() for roundup operation.
> >
> > Maybe we need to come with 128bit operations for
> mul_u64_u64_div64_roundup().
> > Do you have any specific algorithm in mind for doing
> mul_u64_u64_div64_roundup()?
> >
> > Fabrizio already developed an algorithm for 128 bit operation, I could
> > reuse once it hits the mainline.
> >
> > [1]
> > ######[  304.213944] pwm-rzg2l-gpt 10048000.pwm: .apply is not
> idempotent (ena=3D1 pol=3D0 5500000000000/43980352512000) -> (ena=3D1 pol=
=3D0
> 5500000000000/43980239923200)
> > 	 High setting##
> > 	[  304.230854] pwm-rzg2l-gpt 10048000.pwm: .apply is not idempotent
> > (ena=3D1 pol=3D0 23980465100800/43980352512000) -> (ena=3D1 pol=3D0
> > 23980465100800/43980239923200)
>=20
> Have you tried to understand that? What is the clk rate when this happens=
?
> You're not suggesting that mul_u64_u64_div_u64 is wrong, are you?

mul_u64_u64_div_u64() works for certain values. But for very high values we=
 are losing precision
and is giving unexpected values.

See
[1] test program
[2] with mul_u64_u32_div()
[3] with mul_u64_u64_div_u64


[1]
test_prescale_1024() {
	echo "prescale 1024"
	echo "###### Low setting##"
	echo ${IO_1} > /sys/class/pwm/$PWMCHIP/export
	echo 10995116288000 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/period
	echo  6995116277760 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/duty_cycle
	echo 1 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/enable
	dumpgptreg
=09
	echo "###### Medium setting 11000 sec =3D 3hours ##"
	echo 11000000000000 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/period
	echo  5500000000000 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/duty_cycle
	dumpgptreg
=09
	echo "###### High setting##"
	echo 43980465100800 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/period
	echo 23980465100800 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/duty_cycle
	dumpgptreg
	echo 0 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/duty_cycle
	echo 10 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/period
	echo 0 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/enable
	echo ${IO_1} > /sys/class/pwm/$PWMCHIP/unexport
}

[2]
root@smarc-rzv2l:~# /pwm.sh
prescale 1024
###### Low setting##
Read at address  0x10048464 (0xffffa114c464): 0x40000001
Read at address  0x1004844C (0xffff8f06d44c): 0x28B78918
Read at address  0x1004842C (0xffffbf46e42c): 0x05000001
###### Medium setting 11000 sec =3D 3hours ##
Read at address  0x10048464 (0xffffb3491464): 0x400746FE
Read at address  0x1004844C (0xffffb0bbd44c): 0x2003A37F
Read at address  0x1004842C (0xffff86b2d42c): 0x05000001
###### High setting##
Read at address  0x10048464 (0xffffad78f464): 0xFFFFFFFF
Read at address  0x1004844C (0xffff8499344c): 0x8B95AD77
Read at address  0x1004842C (0xffffba33e42c): 0x05000001
[  502.409228] test end
root@smarc-rzv2l:~#

[3]
root@smarc-rzv2l:~# /pwm.sh
prescale 1024
###### Low setting##
Read at address  0x10048464 (0xffffb283e464): 0x40000001
Read at address  0x1004844C (0xffff8156044c): 0x28B78918
Read at address  0x1004842C (0xffffaf54242c): 0x05000001
###### Medium setting 11000 sec =3D 3hours ##
Read at address  0x10048464 (0xffff86d71464): 0x400746FE
Read at address  0x1004844C (0xffff8179244c): 0x2003A37F
Read at address  0x1004842C (0xffff8a58442c): 0x05000001
[ 1167.749392] pwm-rzg2l-gpt 10048000.pwm: .apply is not idempotent (ena=3D=
1 pol=3D0 5500000000000/43980352512000) -> (ena=3D1 pol=3D0 5500000000000/4=
3980239923200)
###### High setting##
[ 1167.765592] pwm-rzg2l-gpt 10048000.pwm: .apply is not idempotent (ena=3D=
1 pol=3D0 23980465100800/43980352512000) -> (ena=3D1 pol=3D0 23980465100800=
/43980239923200)
Read at address  0x10048464 (0xffff987cc464): 0xFFFFAA19
Read at address  0x1004844C (0xffff8fedd44c): 0x8B95AD77
Read at address  0x1004842C (0xffffb124642c): 0x05000001
[ 1169.949153] test end
root@smarc-rzv2l:~#


>=20
> > > With prescale <=3D 5 and rzg2l_gpt->rate >=3D 1024 this shouldn't wor=
k
> > > just fine.
>=20
> I meant here "this should work just fine", I guess you understood that
> right.

Got it.

>=20
> > Practically this is not possible. Yes, from theoretical point,
> > rate=3D1kHz compared to the practical case, 100MHz won't work.
> >
> > For the practical case, the current logic is fine. If we need to
> > achieve theoretical example like you mentioned then we need to have
> > mul_u64_u64_div64_roundup().
>=20
> That shouldn't be so hard to implement.

You need to implement 128-bit operation to support mul_u64_u64_div64_roundu=
p().
Otherwise, we will lose precision and get unexpected results.

For that you need to produce an algorithm and then implement the algorithm
and testing various 32/64/128 build systems?



>=20
> > > > +	rzg2l_gpt->max_val =3D mul_u64_u64_div_u64(U32_MAX,
> NSEC_PER_SEC,
> > > > +						 rzg2l_gpt->rate) *
> RZG2L_MAX_SCALE_FACTOR;
> > >
> > > Is it clear that this won't overflow?
>=20
> U32_MAX * NSEC_PER_SEC doesn't even overflow an u64, so using a plain
> u64 division would be more efficient.

OK.

>=20
> You'd get a smaller rounding error with:

>=20
> 	rzg2l_gpt->max_val =3D mul_u64_u64_div_u64((u64)U32_MAX *
> NSEC_PER_SEC, RZG2L_MAX_SCALE_FACTOR, rzg2l_gpt->rate);
>=20

I agree. With above logic, it will overflow and due to precision
adjustment there will be rounding error.=20

2^32 * 10^9 * 1024 =3D 4,398,046,511,104,000,000,000 > 2^64.

Cheers,
Biju

