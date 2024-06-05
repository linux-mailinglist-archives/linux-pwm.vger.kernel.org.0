Return-Path: <linux-pwm+bounces-2353-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AB78FD135
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 16:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AB6EB255CB
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E625828DDF;
	Wed,  5 Jun 2024 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Qg5IDSxM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11010000.outbound.protection.outlook.com [52.101.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8193D23D7;
	Wed,  5 Jun 2024 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599201; cv=fail; b=uNgYsy/eRoRmz3yDFUuZqjSUsxis17UZJdqFn7ByaGpWhfLwZ0W5LNPrrNNeaa3ixkRKvYQq+Eh7pMqfnhpQgx7DSQo/UKU4uiFKnGxXQsHdh4ugPB9QMgnHvvDBGXfHiEpG0Prm8U3W+XslYy8y+4PDxlHLcDO7luw7wHa/zXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599201; c=relaxed/simple;
	bh=6rjEX3DBWK8CnphrGy978eUbOG240uvrZt7EcJltwSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UWWBPLi4mvfwERhlyTMEsS18N5hr3dsZKFuerieH58AtVsgNYAAWrj3SDrbB5b2xBkUg5t8CBxolop/OHlP8w3ASz5+85VkdhAajZ0Kq0955lzJGG2pYJsrhfIqwgF5wZtsb3KYDmVqc+TpZIKcVl05goHcPVv3sdWfOqrU6xKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Qg5IDSxM; arc=fail smtp.client-ip=52.101.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbVCcrBTNGGa4AWC0Udd509XPirNFuIwyy9sp9kz20v37ZK8sBIzB8Jncxh1avy7i6CPsTO/+HLDfqkYWFYUwVPBy5wJJ6hGMH3yEv8YCcAAolsgayBs2m83TQsVqBKZ4bvdMcOGNyvxl5wHr74jzBCmWE1UMEab00nBqZGKuGA7a5Td5plqQPts64QM9+Pko5+U0xuW7V37EQM286de7dXP7Q6KyE/7AxR9eDdC0sxi8VDnp9sqlaIpMQDmatvahw71k/VEy82YKh97agwLZwp3PvyZD8WJFaphekD+zwmxrFni497+AoDFwobu65Rp1S9iGCkIFByO9HQ2HglGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQgg7+Cz5xRL3y0e/52ONZSL1PzknJQCXplWclQyf+Q=;
 b=bzD9etryO4Vnb7Bwz2C5hBZWrYkf2JQUlMdsieWdQwEbgoBpYk7YnBi73oCulbNsQ4zCfehZqfNSedcq4Z+1aAMc47kUA9zDzUeoL1q68dv76KMHQTkxMPlWjTrHjXR8J1xm92rmHzHo8wyFd7kkW1YHe6+xpJXCmNxdhn/4SFfBN8FrpcoQWJNL91iWhMo42sj50g1uMGWGSptVO9++bo3v02PmM2iFiKj9hyDQs+pzZRaRZjVk3ELdypFcCWJ3IAofdOV8z1X+FU0PSYalOgtTnX9WAZgyhWpCL9+NcwEhKUxPX1vZv+mx87GFnyIC/zztfaB9z+FrUD8Qlmjw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQgg7+Cz5xRL3y0e/52ONZSL1PzknJQCXplWclQyf+Q=;
 b=Qg5IDSxMKOzvp72qHzMFDlRmENze92++iFboomxySs+oOZEeu1rQBrVDJQe0tbmQnHkx9qWPPQTfYfHODAv1GZ7f1YlpcEL0mYlp6HdE/D1y+73THqb339oVHYKFw7yAPTe7DWey8v+BMLs7HGSiSPPggoqqeQZOdl1900iGDcY=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYCPR01MB6772.jpnprd01.prod.outlook.com (2603:1096:400:b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Wed, 5 Jun
 2024 14:53:12 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 14:53:11 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v19 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v19 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHaduYn16v+zacEeU2GxZ7ljgKlZbFudvgAgEtDgKA=
Date: Wed, 5 Jun 2024 14:53:11 +0000
Message-ID:
 <TYCPR01MB113321144DE4E9F0D75F8308B86F92@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20240315143558.221340-1-biju.das.jz@bp.renesas.com>
 <20240315143558.221340-4-biju.das.jz@bp.renesas.com>
 <xy7qcimczmqyzk2zvysr3mdkzl3m54cjvh2pxx4d42dc7atyvs@itbq2jr4ghmo>
In-Reply-To: <xy7qcimczmqyzk2zvysr3mdkzl3m54cjvh2pxx4d42dc7atyvs@itbq2jr4ghmo>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYCPR01MB6772:EE_
x-ms-office365-filtering-correlation-id: f26c11a6-4283-4205-37c8-08dc856f38b2
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?0R8plIF6DtfH2cDyt13aU0sUYDeoJDmwTg/1GP5g6YKyW6Or5x2qImuDZJ?=
 =?iso-8859-1?Q?xYjtRZOytiWKjxgfzbW0aVWh/6oIwjqoazV1SfP487edHw1GtHC/6MowdE?=
 =?iso-8859-1?Q?dW5PaLmvEbot2mYjOjWbTOoCA7LzYqiAEkQhX3wHQy4C+oVY3iecfkRfXn?=
 =?iso-8859-1?Q?vDPeiG2TK21NgPQyhwUqPHovmqq+KTR1wDCATIxJyqa8O3DYq/aaIYwNaA?=
 =?iso-8859-1?Q?mEcpot67yChygsj12xD/JwKXQSsr0zcHL6RsC26/I0RDt0HC7TWs0jRHGp?=
 =?iso-8859-1?Q?+4jXwIFuXZ3FsBpTYP0/Zijkj4jNPl4n2ESTcmbm9rhFiAm8EMBC8wQfna?=
 =?iso-8859-1?Q?eRiCuAVsiC8b1YD8Psyx9w87s0B+Gq2kuSOUmpJ/CsvFAdfeaym+0v5/a7?=
 =?iso-8859-1?Q?V7Od9yXyJ54BETv7RUPPr3eZyjebsIiWtr14NkjesIJORPqNn8fdE7B1e0?=
 =?iso-8859-1?Q?fAH50eesYVffKkvlxTf4GnUPkj0wZbA9Fhhga0OwqDA8ewVy914njdutxw?=
 =?iso-8859-1?Q?HHYStOhoPqD8JsDXNOeFKTwk8KxKFMwE0yYuxoUDFtshwA/5j+QMIU+ShL?=
 =?iso-8859-1?Q?9ct8ROZBOc2oCn7rcvTuwCZPpR5ekHTemKU1gAh+yP92+wMvVhp279Ov9v?=
 =?iso-8859-1?Q?MHwWDUBAx1bPcFhlSEGEADEjoWqTjZARTSvs3GFSij84vCv0rP26Qcf9wZ?=
 =?iso-8859-1?Q?UWe2UZ84pUQsL+CRfYj4LCEjhuQQbcBDd46X/tCmxxUtHpzSi4AIA5tT3Y?=
 =?iso-8859-1?Q?DUWugfsgvvZh9fhHFyVAATikgK4N/uKdIsY2VEZeuVzuvIUXXhnoGO17Xk?=
 =?iso-8859-1?Q?RmC9VmpUhOoRi8AbwUBtKtafwoNcxijPzRTYRAmCLOiHrOmkZksyB1xKmG?=
 =?iso-8859-1?Q?doep821Y9WgqaJP3Hh8fawUNP2o21Mkkw71g6oXII9wZcvtP5WcIiobf6X?=
 =?iso-8859-1?Q?A99u9JallONLkbn12MW976SFvM6DFGGSutFxubm393xy+Fi5xOu2qyV7FJ?=
 =?iso-8859-1?Q?ZolEShZr7mWgl+a0XCNVWJpkfni6wc1OzDVuUy5Tc154OIccO2IvqDIOz0?=
 =?iso-8859-1?Q?gSQ1R0qbiYhFlPGXKK0XNuyIxG4zuYFKuULaeMhcrL+AgPm4mvZJzpKCOc?=
 =?iso-8859-1?Q?VvFA23tP9N6Fjjmj7VsQrmh1c3T2DZC+lI91Y2tDIxITZLcA6+nwrCQOV+?=
 =?iso-8859-1?Q?Vkapn7dBG/QES4GGGiBh3jTkx+tP53CysFIBLeo66v8iQcN+QGacwU0pec?=
 =?iso-8859-1?Q?/rTaLt7S/DxwZaognKWV+FhFDT9DvHj83qpNzC87TU2EirjIvNu5lQI1b3?=
 =?iso-8859-1?Q?CsGoXH5jYjvNRYr13DBR4ea9lTiEWPLG/+NXcRNhlIoLmbq2fKeVmCLQAE?=
 =?iso-8859-1?Q?bv3yTt3VrJZr332OcYlOPSpfZdwg6UrZbZtWBX9feQRTF9J6XM/z0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qlKLYOOUGN5KkyKkOURcLhmswJcB8Uqb132EcWgMgyfDjzBuCnnLsM2vdX?=
 =?iso-8859-1?Q?Lsr/GF2D5tgWiYUHVaeEnPHFBLR5T87llBCVLeVq9kOrgh3QsKqRGMsZdH?=
 =?iso-8859-1?Q?sdEb7YnwWRvaAmSFwlWAwXpxHM75ZJqDguSsxS0sSVdCsdDsqdvaq+/Z88?=
 =?iso-8859-1?Q?j7CPdAuv12eXgijtKWJefF28K5lunhC35HV1QcbjWJmmzKKJIzPRHKMPFW?=
 =?iso-8859-1?Q?UFfK1Rg+ocGiJJwhxRHecCawAmGIVcY5cCJ/X92tL0YvheH6NmUugyH2D2?=
 =?iso-8859-1?Q?dL19NbkmfCWr4J7tR1iba+5CdkEKEXR0852Xs5gv/EEXbBwoqkkkVfPWFG?=
 =?iso-8859-1?Q?NgXFfN40pBOi5VtPyWIqDFBmwOuQhSTLR7ngEhPeEud3a+2pX5SeLZFwC9?=
 =?iso-8859-1?Q?sfmAy8/dhCQDQvv8hMxbOjJDx4Q8Qi4a8j3zTP8JaqQqG5bo/38Auj9I3l?=
 =?iso-8859-1?Q?RhCUcxWY7OZ6nKr1h93cUsVBCpsln2/24FI/ntbj0sxWu14x1wK96vJcna?=
 =?iso-8859-1?Q?6X3jnFRrE7nsjAF78A04vzCQqBEdumZMuDg+XzPGQ9JqzU9iqlQgo3Mkjq?=
 =?iso-8859-1?Q?79KpIV8lk2uBHgEgyia+SlUq+QIv+W45GhIhc7cs1oVNlj3uU4trdoAfy4?=
 =?iso-8859-1?Q?duM6ZamfUVi4aMRAwBj+k+rkd5YhSlPcLbhaKlJFVA48xi02ejyCN3K8WX?=
 =?iso-8859-1?Q?PzBoJKM6I7kUuPbwJ4g1Rfd/F44cgiiUyIan5uvuaX/07CRDN5EYaAE2ld?=
 =?iso-8859-1?Q?xWYuKsaqH/0AfAspoH5puQUbNlSomI3BkMSdK86BwTirZ4fui1Ajs+JzuB?=
 =?iso-8859-1?Q?TYKpQR+oPBJ61zKYMyhE5wF8rOgpTpsklZwLGH9VT+DE4N1dYV++t+v1S3?=
 =?iso-8859-1?Q?WMW6j+/MklJUmvNrHFewd0LHMo8EOsjv1edP2aMk0f08e5dKSqOVA6rGjm?=
 =?iso-8859-1?Q?lLjXg42K1ftJJ8R1k1CkhvPDhm1aVqVQZww2fI/zrTLLo4UrgluxAX+9/b?=
 =?iso-8859-1?Q?tru0+MTVvikxodwaKjVljp5V61bNweuOKJvTmbqxTI+RxZ04v7/X5UNCN5?=
 =?iso-8859-1?Q?7zStxSprIWZcQDZLLT+lMLdVUzZ9mJDhxUcWNxbM7Ys0gslGrV+ll1kd3s?=
 =?iso-8859-1?Q?Hwm0bsGyc5djKVxDOzo9GEIsnu7k9WoQr+mz4RbxZxYihnP7KylVrYO61O?=
 =?iso-8859-1?Q?9L58nI5idchfmyMCTY8rWpJp0hFex4o/oOMv4+bwRD5L+upLO/sDChZYWV?=
 =?iso-8859-1?Q?PJLcuE8iDSa2TpsZ7Otfnl2oVbxLV1eIYZFP1XSXECLRn4a9L4LQ0m7Gjn?=
 =?iso-8859-1?Q?8F0OapLzT8nUYC16/0T6mxayUeKklzlcWx4MArJdtf7JpCoosISKFgFFNx?=
 =?iso-8859-1?Q?Qa+B4loPogYQjtvLYc2YTPd0B35THN89OERClmOKcTcawOk8vAUGJKxlyE?=
 =?iso-8859-1?Q?5gZGWFLHEp8s0ujqDnOT4/df/n2U3FQOe3VrZjtsf9M/w1Ux7r25smojON?=
 =?iso-8859-1?Q?ZBrwx9Z9wBk7xvEK1biW7TzozTBCGsA5p184ymjfyQtRBIsBuKJLi9HV/W?=
 =?iso-8859-1?Q?eUd7vLMOqjR9KfHIreHNL3su6tQYLhWfLqatEtocmM8gL+77eA9BDS1iVh?=
 =?iso-8859-1?Q?dP0cDboyf7/ts33Qv5opcIZyi+ZFOHskuDXoM/9fyExgv6gEaERlDQzA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f26c11a6-4283-4205-37c8-08dc856f38b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 14:53:11.8465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcS9P9E9BLCB7UbiCivscIzejZaElfsT3SmoRZEqiBzPVS7399KkW14UfL5bxt2JKSPLnbZ0cSnGaoOcXNi5Iu6DMX20WEEvStedk+hYqog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6772

Hello Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Thursday, April 18, 2024 6:04 PM
> Subject: Re: [PATCH v19 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello Biju,
>=20
> thanks for your patience. I'm quite behind on my review tasks.
>=20
> On Fri, Mar 15, 2024 at 02:35:57PM +0000, Biju Das wrote:
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c=20
> > b/drivers/pwm/pwm-rzg2l-gpt.c new file mode 100644 index=20
> > 000000000000..8c88f5d536fc
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -0,0 +1,542 @@
> > [...]
> > +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *rzg2l_gpt,
> > +			    struct pwm_device *pwm)
> > +{
> > +	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > +	u32 val =3D RZG2L_GTIOR_GTIOx(sub_ch) | RZG2L_GTIOR_OxE(sub_ch);
> > +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> > +
> > +	/* Enable pin output */
> > +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR, val,
> > +			 RZG2L_GTIOR_GTIOx_OUT_HI_END_TOGGLE_CMP_MATCH(sub_ch));
>=20
> That doesn't need protection by the lock?

OK, will add this inside lock, similar for below disable case.

>=20
> > +	mutex_lock(&rzg2l_gpt->lock);
> > +	if (!rzg2l_gpt->enable_count[ch])
> > +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, 0,=20
> > +RZG2L_GTCR_CST);
> > +
> > +	rzg2l_gpt->enable_count[ch]++;
> > +	mutex_unlock(&rzg2l_gpt->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
> > +			      struct pwm_device *pwm)
> > +{
> > +	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> > +
> > +	/* Disable pin output */
> > +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,=20
> > +RZG2L_GTIOR_OxE(sub_ch), 0);
> > +
> > +	/* Stop count, Output low on GTIOCx pin when counting stops */
> > +	mutex_lock(&rzg2l_gpt->lock);
> > +	/* Don't decrement, if ch_en_bits is set by the probe */
> > +	if (!test_bit(pwm->hwpwm, rzg2l_gpt->ch_en_bits))
> > +		rzg2l_gpt->enable_count[ch]--;
>=20
> I don't get the reason why this is skipped if ch_en_bits is set.

During testing I found a issue, where disable is called and its value
is going negative. I will remove this check, increment enable_count in prob=
e()
for bootloader enabling pwm case.

>=20
> > +	if (!rzg2l_gpt->enable_count[ch])
> > +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST,=20
> > +0);
> > +
> > +	mutex_unlock(&rzg2l_gpt->lock);
> > +
> > +	/*
> > +	 * Probe() set these bits, if pwm is enabled by bootloader. In such
> > +	 * case, clearing the bits will avoid errors during unbind.
> > +	 */
> > +	if (test_bit(pwm->hwpwm, rzg2l_gpt->ch_en_bits))
> > +		clear_bit(pwm->hwpwm, rzg2l_gpt->ch_en_bits); }

I will move this in apply.

> > +
> > +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip=20
> > +*rzg2l_gpt,
> > +u32 val, u8 prescale) {
> > +	u64 tmp;
> > +
>=20
> 	/* This cannot overflow because ... */

[1] < [2]

The max calculated value is
[1] 2^32 * 2^10 * 10^6 =3D 4,398,046,511,104,000,000

[2] 2^64               =3D18,446,744,073,709,551,616

I haven't add this as a comment, as it is clear that calculated value is < =
2 ^64.
If it is NSEC_PER_SEC, then it will overflow.
Basically to avoid overflow. we scaled down by 1000
for all calculation as rate is multiple of 10^6.

Please let me know, do I need to comment this?

>=20
> > +	tmp =3D (u64)val << (2 * prescale);
> > +	tmp *=3D USEC_PER_SEC;
> > +
> > +	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz); }
> > +
> > [...]
> > +static int rzg2l_gpt_probe(struct platform_device *pdev) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt;
> > +	struct device *dev =3D &pdev->dev;
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
> > +	rzg2l_gpt->rstc =3D devm_reset_control_get_exclusive(dev, NULL);
> > +	if (IS_ERR(rzg2l_gpt->rstc))
> > +		return dev_err_probe(dev, PTR_ERR(rzg2l_gpt->rstc),
> > +				     "get reset failed\n");
> > +
> > +	clk =3D devm_clk_get(dev, NULL);
> > +	if (IS_ERR(clk))
> > +		return dev_err_probe(dev, PTR_ERR(clk), "cannot get clock\n");
> > +
> > +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "cannot deassert reset=20
> > +control\n");
> > +
> > +	pm_runtime_enable(dev);
> > +	ret =3D pm_runtime_resume_and_get(dev);
> > +	if (ret)
> > +		goto err_reset;
> > +
> > +	ret =3D devm_clk_rate_exclusive_get(dev, clk);
> > +	if (ret)
> > +		goto err_pm_put;
> > +
> > +	rate =3D clk_get_rate(clk);
> > +	if (!rate) {
> > +		ret =3D dev_err_probe(dev, -EINVAL, "gpt clk rate is 0");
> > +		goto err_pm_put;
> > +	}
> > +
> > +	/*
> > +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> > +	 * period and duty cycle.
> > +	 */
> > +	if (rate > NSEC_PER_SEC) {
> > +		ret =3D dev_err_probe(dev, -EINVAL, "gpt clk rate is > 1GHz");
> > +		goto err_pm_put;
> > +	}
> > +
> > +	/*
> > +	 * Rate is in MHz and is always integer for peripheral clk
> > +	 * 2^32 * 2^10 (prescalar) * 10^6 (rate_khz) < 2^64
> > +	 * So make sure rate is multiple of 1000.
> > +	 */
> > +	rzg2l_gpt->rate_khz =3D rate / KILO;
> > +	if (rzg2l_gpt->rate_khz * KILO !=3D rate) {
> > +		ret =3D dev_err_probe(dev, -EINVAL, "rate is not multiple of 1000");
> > +		goto err_pm_put;
> > +	}
> > +
> > +	rzg2l_gpt->max_val =3D div64_u64((u64)U32_MAX * USEC_PER_SEC,
> > +				       rzg2l_gpt->rate_khz) * RZG2L_MAX_SCALE_FACTOR;
> > +
> > +	/*
> > +	 *  We need to keep the clock on, in case the bootloader has enabled =
the
> > +	 *  PWM and is running during probe().
> > +	 */
> > +	for (i =3D 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> > +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i)) {
> > +			set_bit(i, rzg2l_gpt->ch_en_bits);
>=20
> The tracking of which channels were enabled by the bootloader is more=20
> extensive than that of other drivers. (That's good from a correctness poi=
nt of view.) I consider doing something like:
>=20
> 	for (i =3D 0; i < npwm; ++i) {
> 		pwm =3D &chip->pwm[i];
>=20
> 		pwm->state =3D { 0, };
>=20
> 		ret =3D chip->ops->get_state(chip, pwm, &state);
> 		if (!ret && state->enabled)
> 			chip->ops->apply(chip, pwm, &state);
> 	}
>=20
> (with some more error checking) in pwmchip_register(). That should get=20
> the usage count's right, but would (maybe?) conflict with your=20
> handling here. Anyhow, that's orthogonal to this patch for now (and=20
> needs some more thoughs. For example it might not be a good idea to=20
> call
> .get_state() and .apply() without request before. Also it might not=20
> work for chips that cannot be disabled in hardware).
>=20
> Back to your patch: Maybe call .ch_en_bits=20
> .bootloader_enabled_channels instead? Also I think this could be=20
> simplified (but not entirely sure I grabbed all the details, so take=20
> this with a grain of
> salt):
>=20
>  - In .probe() set .bootloader_enabled_channels[i] if pwm#i is enabled an=
d
>    ensure it stays on.
>=20
>  - In .apply() replace the code that is supposed to enable the HW by:
>=20
> 	if (...->bootloader_enabled_channels[i]) {
> 		/*
> 		 * it's already be on. Instead of reenabling in hardware
> 		 * just take over from the bootloader
> 		 */
> 		...->bootloader_enabled_channels[i] =3D 0;
> 	} else {
> 		enable_hw();
> 		... get pm_runtime reference etc.
> 	}
>=20
>  - in .remove():
>=20
>  	for (i =3D 0; i < npwm; ++i) {
> 		if (...->bootloader_enabled_channels[i]) {
>=20
> 			... drop pm_runtime reference, but don't disable HW
>=20
> 		}
> 	}
>=20
> Does that make sense? Did I miss anything?

I agree, it is cleaner now. Will send v20, if you are ok with it.

On the probe()
-                       set_bit(i, rzg2l_gpt->ch_en_bits);
+                       u8 ch =3D RZG2L_GET_CH(i);
+
+                       rzg2l_gpt->bootloader_enabled_channels[i] =3D 1;
+                       rzg2l_gpt->enable_count[ch]++;

On Apply()
        if (!state->enabled) {
                if (enabled) {
+                       /*
+                        * Probe() sets bootloader_enabled_channels. In suc=
h case,
+                        * clearing the flag will avoid errors during unbin=
d.
+                        */
+                       if (rzg2l_gpt->bootloader_enabled_channels[pwm->hwp=
wm])
+                               rzg2l_gpt->bootloader_enabled_channels[pwm-=
>hwpwm] =3D 0;
+
                        rzg2l_gpt_disable(rzg2l_gpt, pwm);
                        pm_runtime_put_sync(pwmchip_parent(chip));
                }
@@ -366,10 +363,18 @@ static int rzg2l_gpt_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
                return 0;
        }
=20
-       if (!enabled) {
-               ret =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
-               if (ret)
-                       return ret;
+       if (rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm]) {
+               /*
+                * it's already be on. Instead of reenabling in hardware
+                * just take over from the bootloader
+                */
+               rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D 0;
+       } else {
+               if (!enabled) {
+                       ret =3D pm_runtime_resume_and_get(pwmchip_parent(ch=
ip));
+                       if (ret)
+                               return ret;
+               }
        }

- .remove

@@ -410,8 +415,8 @@ static void rzg2l_gpt_reset_assert_pm_disable(void *dat=
a)
         * count. Before apply, if there is unbind/remove callback we need =
to
         * decrement the PM usage count.
         */
-       for (i =3D 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
-               if (test_bit(i, rzg2l_gpt->ch_en_bits))
+       for (i =3D 0; i < chip->npwm; i++) {
+               if (rzg2l_gpt->bootloader_enabled_channels[i])

Cheers,
Biju

