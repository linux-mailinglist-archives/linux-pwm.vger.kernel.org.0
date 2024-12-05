Return-Path: <linux-pwm+bounces-4250-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C8A9E5155
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 10:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36C118802D7
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 09:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AF01D5AC6;
	Thu,  5 Dec 2024 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Io3J9h9t"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011062.outbound.protection.outlook.com [40.107.74.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE418E028;
	Thu,  5 Dec 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390987; cv=fail; b=C3BSFrtbfdH23YPMWngHIxrR3bDdNEoe46zpE5rhTSG5bJBKaoprQ/c44q/odpOecOiNRIQl64r0D83HUCZNUwsXvASMjVkg2U1T66hjaR24vasCbnsjqUatos1WAuXxT2vGmNF8l9e2XoDP53S56U03eOGIGWcp3mY+cqQh+io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390987; c=relaxed/simple;
	bh=z2oPgVcsAR4gZtf7SL79Xnj1dZF7qo2r6zq8KUxLM2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vFn6A8YzH0tMstXifcNVVuT3UwjXqAB2uQStKR+3QgPsR7AqhL6j2qGKX6P2r3qP0V/qAWcY/sLNwMxPRGfmHqMFsP1ALoCbX3czNSouGONdevejOIjWTJmzy0M3NCrO5SSr6EeXkH3WRDLIlJwIorjqjQA/ebk4eTM1LxXnjoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Io3J9h9t; arc=fail smtp.client-ip=40.107.74.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrNnlR+tY2Yy1GRzFBBerQGYFS2WjtEjv6ZGCPicw5bc/x46kmkw+qObpfPM+NKnbqqoqoNpVhZnwsClTeEu83IBG/VogMMn31h2nbOCK5MWxXEcxS7CsI6f3OQCo2d8ZiHovIeCqG4NlZ+nS7QYGLqUjuYk0mHrw0k4PREKwInckd0f6b+avR5+xQm4DwzzignMgrAzxqkpNM+uv5Xs+bt6fjN4BtBgmkbWMadd4iQcdoh8p7t//0VNWMXqe+2sk7qMUwEZquOs+aJBqP8Q/SePKfYkZnFSauME6rGcpCBZwjyipyOTu5MxptTPZQTcOe8IP0cyO8NPFLrc9JYanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2oPgVcsAR4gZtf7SL79Xnj1dZF7qo2r6zq8KUxLM2k=;
 b=b8k4V76GVnkW5e+AxvvoCgT5tt+aVS1wf0yjLoYJ2N75278Gfu8ZxqRDjrTtogTY9b2KuQAcs4eydr0PJpKJZebU7cJ35jv/lR1knAg4IESKUEDfk/dI8lRw+m0guhvuHy1eH5CGHVzFIVF66Rd/MJClMNR5ZNYfHt7hg1FHGvZGQhXsZnWJ9Peu9duUMWXLKAWxpig3LLE2YiOxQfvLJn8QWW0tpllcp5hQOET9biNpXAnzj6uKkJ23+5y1lS/+deGkgVfaaljX7IpdGbRG6t+edzXYdY4lugrLUuGrgus/sNDlrL8OOGXrN8ZFdLoJDvEPj/H69xPcW062kJ1Rqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2oPgVcsAR4gZtf7SL79Xnj1dZF7qo2r6zq8KUxLM2k=;
 b=Io3J9h9tKJ6+BX6J5sSzzdWRVnPK1ud6UxuOWm/d/PyBknXj83k07H0z7UZThu8JMxLtwKNwUEUvMixq/nv6DurL+e+U7983ZDZQqyV3B85xAOZWGexIC9ZmHsDYBcggKnrO6I97Com7G5oOwwW7tAXj/WI2BuHwwtm8GWBl2no=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11729.jpnprd01.prod.outlook.com (2603:1096:604:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Thu, 5 Dec
 2024 09:29:35 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8207.014; Thu, 5 Dec 2024
 09:29:35 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHbIV3QCLVSX2/XSk+pOZR0ZimyzrLORWwAgAhm5eCAAPAoAIAADXnA
Date: Thu, 5 Dec 2024 09:29:35 +0000
Message-ID:
 <TY3PR01MB11346E660F70645F04F67F67686302@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241018130049.138775-1-biju.das.jz@bp.renesas.com>
 <20241018130049.138775-4-biju.das.jz@bp.renesas.com>
 <slgs56imb3u6fv35bo2hl4moa77nnhrtcygi4womtuzs2mcipt@ylcvacvhsgcl>
 <TY3PR01MB11346421B5C0C4A193F70C3A586372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <phr4mtucfmyuhaywspzpxwqvwmklwcgsljcc5dvzbft44kengw@65axncbiotf7>
In-Reply-To: <phr4mtucfmyuhaywspzpxwqvwmklwcgsljcc5dvzbft44kengw@65axncbiotf7>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11729:EE_
x-ms-office365-filtering-correlation-id: a47acd1c-0db2-419b-7a63-08dd150f5532
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?p244tXAAQ1T/rM6ipwa2c/clZDF32xTjfSfEaMPW0iPcqFv1eUhGR8r1Lb?=
 =?iso-8859-1?Q?dQFlpu8VAtalI0hZ6NijuicNhl+UWKQWFc3gGcZo0RQfamBllxNvxt3PwY?=
 =?iso-8859-1?Q?LTFDWQqPeaRFyJGO5AkgSu+2ekg1erPWFHOOQzYWfCg/rgTEfnEOWvurnL?=
 =?iso-8859-1?Q?Jvu/xmGFaIMtutQoLCymqOddBvQJhxTiVFPcy7tXMlQuoiW5ESsNUbTsSN?=
 =?iso-8859-1?Q?fX2rhgy60sdr69HaVzphXrCN3LDcX8Wu1CydZE1VVDUHnRpGTaUqTuuqge?=
 =?iso-8859-1?Q?+qw4txlwrQPx8ylcgB4RPM09D5IdZrHttr5L3foBoepgL6DAZ2R1PuRqG8?=
 =?iso-8859-1?Q?fPTIxdfELVlEQjGgyPCTSnHSoc4u16GPDi7qK6G/VAAygqYQVxnK82XwZR?=
 =?iso-8859-1?Q?5qwvt0w8HjCyB9km7izkQSvKWZQTmaWlX8eJNJsyABdGIqdqDZYUllROt7?=
 =?iso-8859-1?Q?2F09254iqT2e7ZgA71Ip5/mdyKgO8NUpgeCcBTWZ3PR+ag7eEZtYpGd28l?=
 =?iso-8859-1?Q?58nmOMS+BIk022tQdw/IzcnYGBw8LlNXG40aJA7m7Z5Xeg2W1K1kTi5xA6?=
 =?iso-8859-1?Q?vhqYJP+4tPqb320Bpi3tJRGVcQaHLUB0vG5iAaVO3cN3KsBA/EnD0+4C+h?=
 =?iso-8859-1?Q?zJQZsjzXaUcX1RtJoSbPIZX/ZixQ8yZlpYytQJdMI/YNr2Ob4Ij6//JWs3?=
 =?iso-8859-1?Q?upGf0fwZb6itMTt99PvISuirOt11LdYiIdOch7Jr8UG96pZFpoGpQJ+YBN?=
 =?iso-8859-1?Q?WVjF1Ji73YpfY/0JmLuh4JrQdpaEx2AR0iKabNvKYbDbsszL3jIT8g+xgi?=
 =?iso-8859-1?Q?sgkhMSgxLNDVF5f3no3FDCM5jGyTGeIyI/u4whKHjqrI3re/Mg+r7o4bdl?=
 =?iso-8859-1?Q?yib1u3TOm8vMEdbg+8rb9Ac6lwLY7WCH9YtIZZjJ2ulNdPk+M4lDkvsuti?=
 =?iso-8859-1?Q?fR3CLZLolJMMt47ZNfat5A8wvjxFLko4zlIW20MAWdesAosMymWnrHiT4I?=
 =?iso-8859-1?Q?3sIRNzFeWS/ROxejOch1ins2S3X0Wgn/+MvXKNjW6S9jhl7SS2qZA0wQcv?=
 =?iso-8859-1?Q?8aMuLTVJc0vwivagM7ZwTGMLrnxWMrHq3pNanxTI0P5Bmh07rV0mstSXid?=
 =?iso-8859-1?Q?aK6uHom4uDU0ugCx/nUz0bRZ1N4q2jJJ5qYlhN5FnKwnbf2A51C7/9KVfw?=
 =?iso-8859-1?Q?t8YWsNVoXNJ1CMRjqwhzTGqUfidbgp+ur3fk01a8ldpjRUVjQpTJaaRjql?=
 =?iso-8859-1?Q?V4jJEVcV7uPyG/i55Vh8bkPd2HSlNWWIlVeuVIGcEvTCb9cCKYHYTo2RJR?=
 =?iso-8859-1?Q?TnzdYY0CpZJd38ZNaGofwZpzoh4lYO5+uPk/hHzn0l8WbcC2ViLqqvl8cU?=
 =?iso-8859-1?Q?K4H8eumX+4T1iF5YEBzfj9WRdWw4CMB911IqXIoB9emM6FHXXPtUDKu4sb?=
 =?iso-8859-1?Q?6OuSlqYXYVwZo9Wkc68UNJxRyLiU9nbnRHXkdA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5khxwU7AxHoOHwroqOpJc0kkfTZCX+TDuQaQXVM4/WusAvvSdMeIN2NIN9?=
 =?iso-8859-1?Q?QGNQS4P2l8zh/PR8p9QxU2U1RvEt8LyI9U/h5Er2pFX6o3caiH6zEOjWNN?=
 =?iso-8859-1?Q?Tvwt6DnLI/MmAhWBsTwn5p2MzqjcE6cUeaRCmDGTiUurYwNYAal1HYvmEi?=
 =?iso-8859-1?Q?frZYO4AvLNjj4OKVq/0TyOAucbr5QIkmFRZ0kSzXcE4OUvr3cJvDcTfYnx?=
 =?iso-8859-1?Q?/BM3H5vYNtYDucu1f99iJllGtaCDCXE88gmQa3qW+pEQ9YBvyJJiPmLkDi?=
 =?iso-8859-1?Q?SqStrVIFtSZMz2fNA9oiSMyW2tyPADntd2wXrPsCxJnBM5unz24knLSItA?=
 =?iso-8859-1?Q?WrgAeiCC2jGKnd0N1cIjPCzTam8TqMUFQOAKpP54woBWUJxYYlzukERd2r?=
 =?iso-8859-1?Q?YkV+ISTRy3sw0l+B81eiN90QQkz0HhrH1QYfKRHbRsJGt4N/LbAeQg053+?=
 =?iso-8859-1?Q?bLovHXSKfkZU8SEe3SD37muDD68YMy9YJPnljmtDWIH7W0CbaSfcrJjyRX?=
 =?iso-8859-1?Q?jEaV0aww80kf3OcbutojFC+lAdbI2Csp1p/xJjUnyg0Ssmzf78YvmyvEj2?=
 =?iso-8859-1?Q?hF4M3muApNr9rXSu2rvdPX7JhAgY/3PnlJq9MkO1j/1XaMN7czdsPR4YaJ?=
 =?iso-8859-1?Q?FdTSBIpGcuDSygbKx6Ywkrqu98X5dB0FMHTtTU7vEjE4xz6kthyQ4GYcZF?=
 =?iso-8859-1?Q?CCiPYCXIH6sGHHR7JyaASkx5kdxv0EzTdlw60GnQY7LJG5vQsuIYPiOirX?=
 =?iso-8859-1?Q?8rTDLs3Kpcl1gEf0ytrLkz1GglLCk6ENg7tke8E5pCcevnBw6/L7R78pXv?=
 =?iso-8859-1?Q?SuFR5up7+8LjRmRkqhVh69kVI5d4nxxkLOn9SQGu2tPtnhq6J3SMdnxg2P?=
 =?iso-8859-1?Q?16GVez3a/eVr9HWPFT1MsZ/aMUKXag5fPiDJB3p81OvBs57PBuKzTMNFdw?=
 =?iso-8859-1?Q?7T1GVoDMzmL/Bym6CJPEkKeJyIv0Z9EdfBE/wBVQEI8LeLL85/DJ3OK7fa?=
 =?iso-8859-1?Q?OeKgKfun1J8kOPC1UW+CPrTDL26hyrQQzrAThswxrbop+AiSwcoW+K6GIY?=
 =?iso-8859-1?Q?C0o/CBI2jbJmyfWqlSFHny978n0HN3riec8qFoaK88s+SSBGn77SnVPI3c?=
 =?iso-8859-1?Q?1InoL657MBlGVfvaGbcxUhCpnf08y7nMlcsqwPoHPueOf73jc5EvHmKlk/?=
 =?iso-8859-1?Q?Shll5XzIK0dX19cISOjG3lMY2V7YoerR+go3GD3V0J6Mvwfm9ZijGSbiot?=
 =?iso-8859-1?Q?ZFa8e48ifMtMxgKGPnoW/SRFrI2nnrH5y5elDRkvuyBR67ee24MrdmMLdt?=
 =?iso-8859-1?Q?OMhuc367ueS2L5l1Zg1iB/MjIfk641ZhrsLDgLfdiEeGJqd5JJGpN833Yy?=
 =?iso-8859-1?Q?wm3UybGsm/SKz8B5EbuialDiV0tW0bHXiN5v0vqRiF1uhVLS0jri3JJ66Q?=
 =?iso-8859-1?Q?ohGvb2KgqpLjtO6tVevN8NvBJoypWunwv+Vhn4dEJKv0KvLFAnv6s1at29?=
 =?iso-8859-1?Q?TO0Ib6iEY1yT0ZIT0h8Pu1MnPWH3hMtAcSTaKb0tkHljSnOGexbmUU1XnT?=
 =?iso-8859-1?Q?HFPIfGLy2TnEQiRnZNF2THr2T8vFzsLFG60rAicJzDVn1NhHlYZNs0A/BX?=
 =?iso-8859-1?Q?yxPkvTVbFdcOVce2X2VCbw2S+HxfldJ8j/zrF999Znph8JSJkr591lbg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a47acd1c-0db2-419b-7a63-08dd150f5532
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 09:29:35.4329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cf3NtOkfy9dvunfEY4OjvPh9EjH9Po4ZeVeeLu1Z5oqymNDvZHJPqo2MWXaxo+3dQ3e/FVmqCEsw6L6g354NcTanLGcP+XdLy99dxaIljFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11729

Hi Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 05 December 2024 08:28
> Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello Biju,
>=20
> > According to me, we should not allow updating periods for second enable=
d channel.
>=20
> Not entirely sure you mean the right thing here. If IO A operates at 5ns =
and IO B is requested to
> set .period =3D 5 ms, every operation that also changes A is out-of-bound=
s. So your options are only:
> Use the 5ns, or return an error. The latter is hard for consumers because=
 it's unclear what to do
> then.


I guess, these 2 IO's mostly used in switching circuits. So, can't we retur=
n error, if period of IO_A !=3D IO_B?
Then the user know the mistake and he will configure with proper values??

For eg:

Case 1:
IO_A=3D 5msec, IO_B=3D5nsec

Here IO_B has faster switching(MHz) compared to IO_A (kHZ),
So, by allowing IO_A to operate at IO_B frequency, we are doing
Some incorrect operation for IO_A.

Case 2:
IO_A=3D 5nsec, IO_B=3D5msec

Here we are returning error, that is ok.


Cheers,
Biju


