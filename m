Return-Path: <linux-pwm+bounces-3452-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25C99004B
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 11:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517FAB26298
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D81C148FF5;
	Fri,  4 Oct 2024 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="EsHdz+DB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010010.outbound.protection.outlook.com [52.101.228.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B5C148856;
	Fri,  4 Oct 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035596; cv=fail; b=T0vPHajQcFMkuJGojIDXiQz9v+HGAj/OntnVL03ceCNNl/oUZGQcEeYoWyo47t7MzvNbzaljYBL0qFy8vUi3jJUXe5Q/XL6W953weYqo+yGK3MqcCR74AzDHsB6sSRXpju0jkhuNLLw4i8ou9ly2IFkbJh3++3M3IwlhkAAM3ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035596; c=relaxed/simple;
	bh=WPaXCY1s0I/PotX+1sTMwUcQbn/SZIX/WdZD3JXTFmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sM3acZvrFmf7BLi/wiHGgb3LDYxbcOfCKn5gTlPzmbPupENs3lfVN9Wmd9FjnWRvDPhorRYnPZU/ISSxuhdybfCXQLWADg++Pmr75FS1DUyGg9M74J8nLTlHiY2ck0Bt3dRztOSCu/Vj1794BOdu+T+x99XlBjTT3LYSiNh2lMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=EsHdz+DB; arc=fail smtp.client-ip=52.101.228.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpYyRL2Ra1s6ayUc/uJ6WL2C2x8undCCX60MnvbcyhjZpTx43EWhUcFgJ477XeNCmf4o/HuciE+JJUIzFXt3vb5jjesmamPTf93AaaJhz3Cb0HxRN3Q5qeIt1QhWnBxYLFghK2o9qLctC1A1RwFbJcw2g6NsBrfjQICAcYG5lruhODkNaDP+tSOZs8Eu7biwSPYizy2GzdhD9vPqsp4jnYWhtfzPgofCs9sGGJ1RkzgGDEZwkMY6F0xW3W1EMHl1bny30VRvvLG73AjWC0yu/b9GS22zwkVqCeLpzUjipGsNDYTQkXnrwSl+0JAcInDWcqvdPNZ293aPqPbh5KjF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93XsQ4jGTffUTywQMVZz5Yx0hoIhgeVnCrDpucNEJu0=;
 b=p0I3BWRR6Mv22Pu85Ymu9fdwqcCwxiNd++wwcQsFYzDruScvpb5g5A6pm3KP3JVwHWgX7v7ZJQXLa7iRhgNG9h/mWGAj0KVW298a75UKYJh5XRQM9YONc4aEPk9JpctWW52uf2r19YjmTjbt2fjWG/Nb+wZP1cdrzH6S2u5h8eqwQNXHi/hdfG0Vo2Y6pHOPOZENAoEn65+DAFy7brzAO1Bbv3MXw1pBCrtDv3gtLw0NbRcHroAHJ/zG1C4CqZDKDy14NJ2XBgggpb9e4GLgl4JnRfyySMEez0VmkPHdHhB0e78UF51D+Q6+hMNX6i8Bv3QEjGZa6eHiRSn9zRdOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93XsQ4jGTffUTywQMVZz5Yx0hoIhgeVnCrDpucNEJu0=;
 b=EsHdz+DBUwxjpy2TMYvI8+rbXkpeBaOzb5Eqd1Zl16SMW6O1MZWVmvQx4PkXE2SL1E08sk+zSgS9daTWfkOySKdXKvNl8ZQVkA5YrQsQQO7G+f7APA4n+Cuu2UJVfNGQ9wBcKWUcv420yGziz1h0kblE9Z9457GdehDa8hJF5s4=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by OSZPR01MB6565.jpnprd01.prod.outlook.com (2603:1096:604:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 09:53:09 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479%7]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 09:53:09 +0000
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
Thread-Index: AQHa6ZU4yCrTG4vERkWCKtT81J70kbJo7ssAgA3CQuA=
Date: Fri, 4 Oct 2024 09:53:08 +0000
Message-ID:
 <TYCPR01MB113320CDF49DB0564A958241A86722@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20240808131626.87748-1-biju.das.jz@bp.renesas.com>
 <20240808131626.87748-4-biju.das.jz@bp.renesas.com>
 <slpywmbmamr4kw4jg2vyydheop44ioladvvm52aocnojgjkcsy@3eoztwsej5mn>
In-Reply-To: <slpywmbmamr4kw4jg2vyydheop44ioladvvm52aocnojgjkcsy@3eoztwsej5mn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|OSZPR01MB6565:EE_
x-ms-office365-filtering-correlation-id: 76048272-ba9b-495c-4eec-08dce45a5a18
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XbHyzRnxAUxsCUuZGgJKOSq6cJgMvb6Klb2ZmUIBq/8TQTjpEKJh3tDIJO?=
 =?iso-8859-1?Q?VbX15PLRfOqLvLHk1FAWuGoq9FzUeOmjidvo4+qAiOKMundGv56dQFsGwK?=
 =?iso-8859-1?Q?MRjF5SH8JitoDXImjdm3t7l5rnIWGMGF3hxmyqdk/P4VX58s1Hk4CdmfS0?=
 =?iso-8859-1?Q?L234RmSg10U7Up0H/6d6gsOFtJwLl6kCdlTGV46rHJYF94xJFBndYP8umf?=
 =?iso-8859-1?Q?4prUJ2ZtnSADPI9IS0hMuacsCUyVBmpF8TUErNOxRra5zjCiNJjc3Y5Ulu?=
 =?iso-8859-1?Q?UV6vJ6yzDp8TsrSU8pSQ2YXm4dcJC5S/1yI7PMGAUqo2APRglRys3aimPj?=
 =?iso-8859-1?Q?hY7Isz+eoopr2OUIJWuRtgyc8vhsqzpkseAYWOUmtM0UaRXijZHBaKmhLD?=
 =?iso-8859-1?Q?idmhVx1ENi0kSC5RcrRLGtcwzrawo+yiisZqcaviEywTVQRxtJ5nR7z7RQ?=
 =?iso-8859-1?Q?wIps1mzB3Sh3xC/bhZkloi2sxhckUZgmFFCVpjidStVt2oLuGhbnFNX9Hq?=
 =?iso-8859-1?Q?6vOdu39coC0LgQPQbG9s0AO/wRRV1cDppE4b2Mppc1xn/QtAs8qqBVSSvC?=
 =?iso-8859-1?Q?7ecK1xtDB+81LokMYlR2HSSe2OfRFatlCZ0DumjGzkGjDo7D2j6MYmsagm?=
 =?iso-8859-1?Q?uEKoJUkNjxJrJ6yuT31ejexfQ70LqHxCGuv81yxsRri1OeUu+KdrynMW0y?=
 =?iso-8859-1?Q?qBk9r70JGraebUOhx2Z6dtSiK92mh1ejj3SwZo2flo0d6RBKmh91iOTSOW?=
 =?iso-8859-1?Q?c9l0Q2JBaAH2pr+hBYc7mVX1sMXhZMB51rJIBW+fAVT++X5J+9VF4LdYhw?=
 =?iso-8859-1?Q?WjEaY2O43a6L1aDjw72qhOVBcufwyP3JFOeXJZ6YUhcfccndguvRV+4OiW?=
 =?iso-8859-1?Q?muNI13MEjqSUtBaeR8DM8duO2H33bE3QCf7yVmdbpdl3Z7Xy1sk2/G3PB7?=
 =?iso-8859-1?Q?FQn4UUuOjBWsTt/fxl0CFcqANQrzgBHRDDSNHqioakRJmJOaLxN4ppFlmo?=
 =?iso-8859-1?Q?fvPm6my+91+Lfr3jbvu8RTpU79kcNpOtSCFoFULSiONhycPN0BL4h3F/uH?=
 =?iso-8859-1?Q?VdJWFe6am9j872iN0zQgXzZrolgwsguOm7U1brB0flPRihnYlSEeZm9K2R?=
 =?iso-8859-1?Q?NMwIRwKQSXTAKSM4OU0/DM1WjlXnvi9eePEP4Fx9gLMKOXV26wDzWgpOba?=
 =?iso-8859-1?Q?Q8dErypNIn+ICQ40BlTwp/0+XJO4Cq12ik1GQq9QfA0Q5fsIpxfd14bBfl?=
 =?iso-8859-1?Q?PFd/xMNqAiBr32ZJuzJTf3Q+cXfAWf9XkXrofMcuXNLGh0PqedmULp47el?=
 =?iso-8859-1?Q?uZF8pyha9n16ZnKa+y6japNl/BLXvSmfzgiZAmSObNbYP6FaIS9rY2bFU+?=
 =?iso-8859-1?Q?JPl7EX9OaaQNeXErz0925NQaRmv0NXnw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hTTtwMJirci+WwgHw5HdM9sgJd5pN0uW+CMUSuqmbIWJ2pHgcz9uxForqA?=
 =?iso-8859-1?Q?HMt9r88MsVh9othx9wJm3ElJ7rzdJJ56VHv5haxmjhrYjRUGL6kwtJqGb5?=
 =?iso-8859-1?Q?eSWhF9SWREzXmlNCyH4vC3zlbtdgQmp1c+v89L0d63jhZnzAyYH6PdDSUP?=
 =?iso-8859-1?Q?XjTrzvSqrRBdfHmWbiVdk+6zxVrmeEYI8NLK4hxTLhRLeeXLXoxfMUUnwI?=
 =?iso-8859-1?Q?nSdAJjWHc5yQUWyhAdyNt2ESm+VdUlxG/PuK4MHX5iURw9TpmurY3akg33?=
 =?iso-8859-1?Q?18KbrDAJaRdBr120+nv5Fu3d5gqEYUM+h+3IWSbIABTLElvAR75KOxJiBl?=
 =?iso-8859-1?Q?wAIbdh2U8r1scERdVlBO1PNo898HAV6VaeLF4Q+ya0Qn029H5I+h5gb/kL?=
 =?iso-8859-1?Q?ROd/js+rAV9B8q/1LlrLs8JF5Jc9QRVcC9LZYx3lWWO4864+TUGhoB8vZY?=
 =?iso-8859-1?Q?7/S1EysqjSKo0uh7as1qjKxG/QgvktHR4gJ1JJZ1X2npEBxY6i9EufYVu5?=
 =?iso-8859-1?Q?/T82ANGrPJEiWh9kD1JqOt0s7TDS1+0AZBpnQ5LMyQDr71iX3NqIR3v1jP?=
 =?iso-8859-1?Q?1kgvbaM/cuxfm/hIOEdYXy9a1ZV9Cj2CZvT8p8ZMoUxp5YIeNZyJK9apOV?=
 =?iso-8859-1?Q?/sRTs0vZhJxurn3l2r5CTOA/MU+2rDhSEF/3RE3uf2Wgd/KGTm9a+zABNL?=
 =?iso-8859-1?Q?twy3iQh2iJOQAJUxvTXYm0gswuSTFXit2IM0OrlPBGJZMNrA9aZS2eSrz/?=
 =?iso-8859-1?Q?8twv6QCXNsiLtBvIUmU7mDLYn2tb6fZlu91LmR4Doz8OHChlOiFPdiVWlp?=
 =?iso-8859-1?Q?N4usIGDAi9oy8CvDFEUTULzvcmCxpNjrxdxCRHBTE0RP8o4aY4LzuOeWvO?=
 =?iso-8859-1?Q?HF3dVQQz6O4u4HdTMa3T7f4vih3NM+uFtn8ENy1+2EQSe1kHwJBNQt1ykl?=
 =?iso-8859-1?Q?IGFayYyJNICFjJwsSWUnD4MPOxR35QZq3ziP20/vjLGdbGVW67s6K1Wtls?=
 =?iso-8859-1?Q?4W356b4PR8ti9FMDXSLPzraAch1BxMDZHmDSQGLDEzL01HDW0HwbFLZCdw?=
 =?iso-8859-1?Q?fItPbe+CLM9glbtPx8ZTWTJvXpcyBAM7SgvRaRfs6X0osT91hBSAHJA8Gl?=
 =?iso-8859-1?Q?Axv1+9hxSxh/ovRCj82SB0xhbRHl4tQeBgeC/C2XnnEnwZzZgLSQsXtNb5?=
 =?iso-8859-1?Q?lBmjqzBVBFbSGCAV9BMjEPzfdUx0y5g546jM9U3fFQvFG64XrSzJzV2eyr?=
 =?iso-8859-1?Q?b67PpvMqZKZ1BZ90qVMzFCJZCqg94c6bdJMqRSMI6Jy5jHC5atiRFE1qJb?=
 =?iso-8859-1?Q?Td3LLgNRi58PG2a60YmpOVqV+z+s8U/6k9NbZneOSzO7BIK9hf6b47DevG?=
 =?iso-8859-1?Q?oIHh6ykQISr6GoMS2tt5p12znUWKa/oc+1PA7na9h/f11ClNliZFFsd4u5?=
 =?iso-8859-1?Q?q+8dLWHBwjXo/OOqE2jygVqBiHCeG4yXTm5QQ2Om2oYX1+M02RITZSjNUK?=
 =?iso-8859-1?Q?eKrZjeUuEtXxfLomUayTOX+4vE27JGj1wc702UTsKFpfhzqSssvJrCIgNG?=
 =?iso-8859-1?Q?+VgyEcBxBPl6f/5iR4pxdMLWJBHsQBYZRzWtI6rijEMd4KsofeG++95kKo?=
 =?iso-8859-1?Q?cD96xUEbreC7yQscHF0D8CLtYSUJ/HD1HXt7S5s0+HwPxf3QbXyV8NsQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76048272-ba9b-495c-4eec-08dce45a5a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 09:53:08.9319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYi8eDK7Coywj4Pl0rxUE+Dd6ZAjRrSWo5/Uq9k4aKtSJ6HQvKmIct33AkkWglE7aQmBSYQbhvlSjRuYRYtRkdpnU2ufj+3hpL6wk/jMQDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6565

Hi Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Sent: Wednesday, September 25, 2024 4:39 PM
> Subject: Re: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello Biju,
>=20
> just a few minor issues left---see below ...
>=20
> On Thu, Aug 08, 2024 at 02:16:19PM +0100, Biju Das wrote:
> > +static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device
> > +*pwm) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > +
> > +	mutex_lock(&rzg2l_gpt->lock);
> > +	rzg2l_gpt->user_count[ch]++;
> > +	mutex_unlock(&rzg2l_gpt->lock);
>=20
> Please consider using guard(mutex)(&rzg2l_gpt->lock);

Agreed. expect rzg2l_gpt_apply() as it will cause
deadlock as rzg2l_gpt_enable acquires same lock.


>=20
> > +
> > +	return 0;
> > +}
> > +
> > [...]
> > +static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8
> > +prescale) {
> > +	return min_t(u64, (period_or_duty_cycle + (1 << (2 * prescale)) - 1) =
>> (2 * prescale),
> > +		     U32_MAX);
> > +}
>=20
> Hmm, why does this round up? This is used during .apply() and converts a =
nanosecond value to a
> register value. This should be rounded down. What am I missing? (Maybe a =
code comment with an
> explanation :-)

I agree, this must be round down. Will use DIV_ROUND_DOWN_ULL() like other =
PWM drivers.

>=20
> > [...]
> > +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> > +			   const struct pwm_state *state)
> > +{
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	bool enabled =3D pwm->state.enabled;
> > +	int ret;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Probe() sets bootloader_enabled_channels. In such case,
>=20
> .probe() ?
>=20
> > +	 * clearing the flag will avoid errors during unbind.
> > +	 */
> > +	if (enabled && rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm])
> > +		rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D false;
>=20
> Hmm, not 100% sure, but I think if rzg2l_gpt_config() below fails, cleani=
ng this flag is wrong.
>=20
> Does rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D=3D true imply=
 enabled =3D=3D true? If so, the if
> condition can be simplified to just the right hand side of the &&. Then e=
ven an unconditional
> assignment works, because
>=20
> 	rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D false;
>=20
> is a nop if the flag is already false.

I am planning to drop "bootloader_enabled_channels" based on your comment i=
n probe()
which simplifies the driver.

>=20
> > +	if (!state->enabled) {
> > +		if (enabled) {
> > +			rzg2l_gpt_disable(rzg2l_gpt, pwm);
> > +			pm_runtime_put_sync(pwmchip_parent(chip));
> > +		}
> > +
> > +		return 0;
> > +	}
> > +
> > +	if (!enabled) {
> > +		ret =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	mutex_lock(&rzg2l_gpt->lock);
> > +	ret =3D rzg2l_gpt_config(chip, pwm, state);
> > +	mutex_unlock(&rzg2l_gpt->lock);
> > +	if (!ret && !enabled)
> > +		ret =3D rzg2l_gpt_enable(rzg2l_gpt, pwm);
> > +
> > +	return ret;
> > +}
> > +
> > [...]
> > +
> > +static int rzg2l_gpt_probe(struct platform_device *pdev) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct reset_control *rstc;
> > +	struct pwm_chip *chip;
> > +	unsigned long rate;
> > +	struct clk *clk;
> > +	int ret;
> > +	u32 i;
> > +
> > +	chip =3D devm_pwmchip_alloc(dev, RZG2L_MAX_PWM_CHANNELS, sizeof(*rzg2=
l_gpt));
> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> > +	rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +
> > +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(rzg2l_gpt->mmio))
> > +		return PTR_ERR(rzg2l_gpt->mmio);
> > +
> > +	rstc =3D devm_reset_control_get_exclusive(dev, NULL);
> > +	if (IS_ERR(rstc))
> > +		return dev_err_probe(dev, PTR_ERR(rstc), "get reset failed\n");
> > +
> > +	clk =3D devm_clk_get(dev, NULL);
>=20
> Please use devm_clk_get_enabled() here. Otherwise the result of
> clk_get_rate() isn't well-defined.

Agreed. This will make the driver simpler like other PWM drivers and no
more PM runtime functionalities needed for PWM as the clock is always on.

Cheers,
Biju

