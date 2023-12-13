Return-Path: <linux-pwm+bounces-551-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B97810CFC
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Dec 2023 10:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E03A1F21080
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Dec 2023 09:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE51B1EB47;
	Wed, 13 Dec 2023 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="JK10+ua9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2129.outbound.protection.outlook.com [40.107.113.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D76AB;
	Wed, 13 Dec 2023 01:07:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EE5Co4r/cuxgUS7zXXHbp+ZIj26Jjvgre0kcflkOPrk1htI7tLbRNPkNzBaHWK06ejDXatHzZIyytBIii/6Ovk1b7B3nhFAstUboxPn5EZdK0ovdLZXbKXZ+S/1FGgdrYSSnVMgKAKDzHLZ0NSzWC9/W89g62KFuFbJKIMzaLT7YNpuJERdKh15DUnS7GrSopFqroNgvqfUQLpNSq0351b9Ok1uEBToNtsFg0zCiNl6tN4O1DvHKJ5FA3BcA7PAFS0MF9uof9iUhKS6dbGd4j01eTdlcPCa5EErn+6/3/6ws8MLVYYTIwApFY5HfE6Qre6Oxiu5Ll+4cXcRkjjDaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfkd096BvdoeaQDWYYkgCZGSa21Ikuejs2CMvqbq8Ds=;
 b=Xm4N3k19ObCU+YXLXdYZL3xrAioxB4wAJE6AcVC9bGlsuY4Y0UcujznZtDXhfgTM07h3S3clKQ7j1XvyVNXxGtJlrN0DVBX5qpnbCZxzBk903mDTq8j6eI472ar4EBPlfSdGNq9ym9sNAN3E1HdaWelB4+oaL522FFjSEeL0xv1yP+65xOrCWFIsofpf2TThuABCsIEAVWQNQDP65r9lZh5hpbutN93SCvwzzwzk0CPaaYmdd/iX+9m8LFMZdXW2sB6JetMom8vg5lV3463vny885scL8/ib7VNGm6Vmic9UndiS+qqLswIMNLLg+UNosuKxuuzbB/AIZFHhfi6kdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfkd096BvdoeaQDWYYkgCZGSa21Ikuejs2CMvqbq8Ds=;
 b=JK10+ua9uiqth0cHmAXSfQTQHhC0fQD42e9Vtvrt5NdGevV/90CD7FrH2k2+Xkuc6C14Oowk3q5hKMB6Z1YqhudLpZD9RG3bUsbb3UH0i2C7WjTxWgi9fFEEhuBr+cJbwwj6iBx5TffcQxgtXEuc9sFDj8bajOpqFhsQy/iu6Sg=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYVPR01MB11260.jpnprd01.prod.outlook.com
 (2603:1096:400:36c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:06:58 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:06:57 +0000
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
 AQHaG6VjO3tWbpjOM0KBvyBIicGE/LCcr38AgAGHJgCAAD55gIAAsVCggABh/ACAAACWkIAHckBw
Date: Wed, 13 Dec 2023 09:06:56 +0000
Message-ID:
 <TYCPR01MB1126992DD51F714AEDADF0A4F868DA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231120113307.80710-1-biju.das.jz@bp.renesas.com>
 <20231120113307.80710-4-biju.das.jz@bp.renesas.com>
 <20231206183824.g6dc5ib2dfb7um7n@pengutronix.de>
 <TYCPR01MB1126952E843AC08DB732C18A5868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20231207214159.i5347ikpbt2ihznr@pengutronix.de>
 <TYCPR01MB11269C233892B6E3002622C3B868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20231208140718.laekt3jlsmwvzc7x@pengutronix.de>
 <TYCPR01MB11269900EF62D8CA3E906DBAC868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB11269900EF62D8CA3E906DBAC868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYVPR01MB11260:EE_
x-ms-office365-filtering-correlation-id: 835ae257-e197-4b70-211d-08dbfbbadb9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WUr88V3ckEMkkSgApwmJI15/3lPCK/qRI/G2KXrufa1+Qo4NdzxuGAWMFgfAZvlfwvr9vylhzY16TP9PbreXXp27Y5Q1+5wcKkJTq2C+qbOWtyOamSNCy8ROoWZXiWACLAeHZbCEh2YKaZeKXjDkmiec0zu6ZJ4cE/h/KMY6/CFOGrLsOsf2mZvlFqfrny9o9WsXDo3BBV6CmqXtxOHJ2sG1oYg3PGVo4vCGo/8O66IlR/UMou4157nTmp+ppK8kBB6XJts4xAjJkV6+LRUNtIl8Bk7vpCNiRxnb/1DpE6KTYBbPUNa3Iuf4k3Y+SoFBDW06K4hjhwKg3t1cADS4Xyx1MRvIpr0UmNkhdGnq92SS35j7ZyZtOnWZaXfciD/WRGT+Bl08OOmlPt5JOjNn+iM/n4h5AzjrjSNNJv+ja1dzS9NKIG2D4p91+f3qenvg7c4sjsQFJe7WNopjsqfvpoD1Bs0k3KabZOtQ1QfQz0GeZXzvY/Ktt6kw1mWclcIGoSnwtnFk6frM0WCC4dm9mm5EkUSReY33tO2Bz06ez1u0rwVWhzu0i4iMUDpeMsxy4QPpQS4nged6oXsDo7LsvslJopawfeNSTEwx1RYe4MY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(52536014)(86362001)(38070700009)(5660300002)(2906002)(33656002)(83380400001)(66574015)(66556008)(122000001)(66946007)(76116006)(71200400001)(7696005)(53546011)(6506007)(966005)(478600001)(107886003)(26005)(55016003)(9686003)(66476007)(66446008)(38100700002)(8676002)(8936002)(4326008)(6916009)(64756008)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?APijd4lM6v1r1SwRPvq47IdedZbIu22YFnWOS7wLu12jP5pcFYcP4MV9pc?=
 =?iso-8859-1?Q?UQqe/I8kVfcBLuhIW+Lm3Svl/SLG+Nnm8lrYPd158nEzpDI1AOjcglSJHV?=
 =?iso-8859-1?Q?YV/Wesq6nU8C3Ra7rG2RpxDDgTqjYzg9WV5PXzbbbB6uuwVMZIclmcXp/n?=
 =?iso-8859-1?Q?oH9+pk+QtgrqnQzTA/S8/uEqrpYExxTbQCG3+lPFkUPiQ+A4ECcxEDYmyE?=
 =?iso-8859-1?Q?2zTflkP5H7CJBPy4DH5s0TJ2vpekmAVSv3d/6hbdTL5sBQ/vPDqzIXAobj?=
 =?iso-8859-1?Q?658CI5TE0jzuZM9J/Bm8CHdgKCC5uZU2fXP3C5VTizsUQSX1wvCifoWTQS?=
 =?iso-8859-1?Q?0Kn7kn2NqWhaIx8EPPru+LTVfUBXdCbqDL/jdDH0pH3JuHh1uw0C0q2cIi?=
 =?iso-8859-1?Q?xlXCP+vh79gsX3oR+CmPmLrDnPQJgfE0roz7t0SWjcmsEeZb9JglMdosya?=
 =?iso-8859-1?Q?GYF4wCqzteGZiUm8vconthYwO5wVKN+1Jc6Oujv8Ifizzzw0wAVZ5nkTxw?=
 =?iso-8859-1?Q?TnWU8t1Q47638XcapEeckNcZAebx7wuH/ijq0B8/wOl7ao8igoh/F2wbuH?=
 =?iso-8859-1?Q?CpoPXSApmmuuz3lVGTarjoNBySXzTArsQDgZ4eTViuNSTX1UN1rEWWthgU?=
 =?iso-8859-1?Q?OXX/Vu/nY1aWPxTSvWtn9oUOxYJGBJAnxV6Xjjr/JnLRQriCpf9LekfyyT?=
 =?iso-8859-1?Q?gn8KN/W/z66Fh+EAMjKhpLvnPz75zVUP8YlBEhFtH9vlVpNdwO93upmsDP?=
 =?iso-8859-1?Q?Imp7L0ODymPfMusXqp2GwSpxmtDwxWiqD0sbB54Dvqr5/P3dK5MWTUtyr2?=
 =?iso-8859-1?Q?EAP/XnHfq8RviTzJo/tA6GyqQQYYbLqJW0zXIAaCTzFcRh6D2easucdfF6?=
 =?iso-8859-1?Q?wC33R7R2TssoncXfA+/tUxTqIcyzCIJHM9oMNMg6Jh0H0c7naa2a//qAJ4?=
 =?iso-8859-1?Q?t5laBha8Q5yo7Ks16ROv2iPFmOPsOidLHWgfBGqfY/b0H4xFqxqQzxa5Hk?=
 =?iso-8859-1?Q?SiR1BrKFg6ZW96A+9FcCjDothDdxxLaOTePQUuvei3WxshRCtnwT83BHRM?=
 =?iso-8859-1?Q?H4jQ6ocv2gymuJo7BotmfANpU5dK4jY+IhfHDjQ/Vo5d3cY1r2usyqOyTF?=
 =?iso-8859-1?Q?x53p+ms6Ff58PcXKX4UPZTt3ODUOS94QAOC1plyqcUP2JRlm3g2+m6Qzp9?=
 =?iso-8859-1?Q?Ip2TAexZR6F+B9uvgfC3WpGTAMm4/ATYgGvVnbIeCnEvTfeKS0X2LQ3FIi?=
 =?iso-8859-1?Q?nz+YEYFARfiUZWNvC427io32Ycwhm2U0b7QpWJY8RCA4JomBWOzaiVOm0d?=
 =?iso-8859-1?Q?JtEG1XX6xHyf1ct0rAh+IHZP2aXZmOh7h6SEw+xBkBUgsNQfwcgkU+ZuMz?=
 =?iso-8859-1?Q?uvTgzZoLdvw4vwuPheBVP4cQd6izPPHStUqkthPUBKNOXdObtrbatLOtqt?=
 =?iso-8859-1?Q?4I/yjEk8iK9n5DdSdxBhk3qXDimXpkcf/yQmUedXcjqeP/gMjpcERHdVwm?=
 =?iso-8859-1?Q?dSfnaq3CABxuk4z5eGpk+V0Zvy59nmFm+PzQ/HSBQvAu9WA1VLjyFNp3YW?=
 =?iso-8859-1?Q?7ziuE4ytLPlHngIcH0Y7bYt+YKkucjKFlWJZM6PW4rhXtPvddE/qepKJHT?=
 =?iso-8859-1?Q?i+36ufD9FeFgpLK31/8E3M5cnv8FP5TJH2npNQJiFUW88+70rjLJ0mnA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 835ae257-e197-4b70-211d-08dbfbbadb9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 09:06:56.9488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEV58gFHyMaswpuOsbgHTgQj0QCm2ISn7DzQYQ6eqlJUvbbBEjkeurcupzlHdvNy9nrWWjYNT7p2hPnMLDTKvfVLXoX5VBbDvakyJuoh4yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11260

Hi Uwe,

> -----Original Message-----
> From: Biju Das
> Sent: Friday, December 8, 2023 2:12 PM
> Subject: RE: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hi Uwe Kleine-K=F6nig,
>=20
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Sent: Friday, December 8, 2023 2:07 PM
> > Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> >
> > Hello Biju,
> >
> > On Fri, Dec 08, 2023 at 10:34:55AM +0000, Biju Das wrote:
> > > > -----Original Message-----
> > > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > Sent: Thursday, December 7, 2023 9:42 PM
> > > > Subject: Re: [PATCH v17 3/4] pwm: Add support for RZ/G2L GPT
> > > >
> > > > Hello Biju,
> > > >
> > > > On Thu, Dec 07, 2023 at 06:26:44PM +0000, Biju Das wrote:
> > > > > ######[  304.213944] pwm-rzg2l-gpt 10048000.pwm: .apply is not
> > > > > idempotent (ena=3D1 pol=3D0 5500000000000/43980352512000) -> (ena=
=3D1
> > > > > pol=3D0
> > > > > 5500000000000/43980239923200)
> > > > > 	 High setting##
> > > > > 	[  304.230854] pwm-rzg2l-gpt 10048000.pwm: .apply is not
> > > > > idempotent
> > > > > (ena=3D1 pol=3D0 23980465100800/43980352512000) -> (ena=3D1 pol=
=3D0
> > > > > 23980465100800/43980239923200)
> > > >
> > > > Have you tried to understand that? What is the clk rate when this
> > happens?
> > > > You're not suggesting that mul_u64_u64_div_u64 is wrong, are you?
> > >
> > > mul_u64_u64_div_u64() works for certain values. But for very high
> > > values we are losing precision and is giving unexpected values.
> >
> > Can you reduce the problem to a bogus result of mul_u64_u64_div_u64()?
> > I'd be very surprised if the problem was mul_u64_u64_div_u64() and not
> > how it's used in your pwm driver.
>=20
> When I looked last time, it drops precision here[1]. I will recheck again=
.
> On RZ/G2L family devices, the PWM rate is 100MHz.
>=20
 [1]
https://elixir.bootlin.com/linux/v6.7-rc4/source/lib/math/div64.c#L214


Please find the bug details in mul_u64_u64_div_u64() compared to mul_u64_u3=
2_div()

Theoretical calculation:

Period =3D 43980465100800 nsec
Duty_cycle =3D 23980465100800 nsec
PWM rate =3D 100MHz

period_cycles(tmp) =3D 43980465100800 * (100 * 10 ^ 6) / (10 ^ 9) =3D 43980=
46510080
prescale =3D ((43980465100800 >> 32) >=3D 256) =3D 5
period_cycles =3D min (round_up(4398046510080,( 1 << (2 * 5 )), U32_MAX) =
=3D min (4295162607, U32_MAX) =3D U32_MAX =3D 0xFFFFFFFF
duty_cycles =3D min (2398046510080, ,( 1 << (2 * 5 )), U32_MAX) =3D  min (2=
341842295, U32_MAX) =3D 0x8B95AD77


with mul_u64_u64_div_u64 (ARM64):
[   54.551612] ##### period_cycles_norm=3D43980465100800
[   54.305923] ##### period_cycles_tmp=3D4398035251080 ---> This is the bug=
.
[   54.311828] ##### pv=3Dffffd50c
[   54.386047] ##### duty_cycles_tmp=3D2398046510080
[   54.390903] ##### dc=3D8b95ad77
[   54.395574] ##### period_cycles_norm=3D43980352512000
[   54.398715] ##### period_cycles_tmp=3D4398023992229
[   54.403717] ##### pv=3Dffffaa19
[   54.408594] ##### duty_cycles_norm=3D23980465100800
[   54.411673] ##### duty_cycles_tmp=3D2398046510080
[   54.416557] ##### dc=3D8b95ad77

with mul_u64_u32_div(ARM64):

[   46.725909] ##### period_cycles_norm=3D43980465100800
[   46.732468] ##### period_cycles_tmp=3D4398046510080
[   46.740484] ##### pv=3Dffffffff
[   46.748457] ##### duty_cycles_norm=3D23980465100800
[   46.751510] ##### duty_cycles_tmp=3D2398046510080
[   46.760462] ##### dc=3D8b95ad77
[   46.765256] ##### period_cycles_norm=3D43980465100800
[   46.768282] ##### period_cycles_tmp=3D4398046510080
[   46.776590] ##### pv=3Dffffffff
[   46.782762] ##### duty_cycles_norm=3D23980465100800
[   46.802617] ##### dc=3D8b95ad77

Cheers,
Biju




