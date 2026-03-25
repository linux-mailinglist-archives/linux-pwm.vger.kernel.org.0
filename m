Return-Path: <linux-pwm+bounces-8368-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPxpHILpw2lvugQAu9opvQ
	(envelope-from <linux-pwm+bounces-8368-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 14:56:18 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A931E326391
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 14:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33C733108AD5
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 13:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCB83DA7FB;
	Wed, 25 Mar 2026 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="p7CNbKW8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011041.outbound.protection.outlook.com [52.101.125.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E123B612;
	Wed, 25 Mar 2026 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774445088; cv=fail; b=rv1sJWzacqgkBviiiIB0r+KA/fomE/XU7qUkSzX0r795I91r3wgKKnVJkSux2JewsnYABg1svA55mH1/70TXMCArnIzg4WipvbWsoZLjIspv/OMNBvuEMV6ScngdX1OijZkgFUzTcj5jTlkXLsixI7MNfU93l9f2VgvJ3YROMMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774445088; c=relaxed/simple;
	bh=UrARRqdIpHugyLFlkgXSeaDSgI0XE6zr7Q+rOKSeDWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eoedvlqilDtNdKUBthKzurZMaooV0GVorzs5GdUGMQpF9tSGZrnqwuEXHAV+kHEnjXXv98xG7BV7FuQLEzBF05OJCSPyHfc6DY+uqFkETLFMbJ46DNKWAB2+V3wiwIzxlYXn+t65BesGalycU/K/zMG0A+ITxHTTW24D32ugGp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=p7CNbKW8; arc=fail smtp.client-ip=52.101.125.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j95IivfK/DHwv0n696uDcUUKVneJbMx/TnzgoVR7MIropYssZ7bsD1YlU8cn5JX648erOekm0/nk0FI/X6lrasY0LxjGq5v/VM840HFBatm25nYUM0HG6SolQgAeCjoSVET50UlWltp2kVIJe34YrEy9OSYcJ9QtnSl/W2myHkCzXCCDpEcamFcX30rtgEp5z2uqm2CoLOUh29NSkqDBq/uknYcAEF+m7qvdvsChS1jiMJaqoeEodeRP9rWw/fTZ3kxm3xPeHEfEyz5N7YcyFfc0Yq3G49+dwJqLrLMFhZshnVIwk8DswKP8r6Bo2SuAI56hxPZR66JXZzkBR6ATFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzgQwQKSDWuEXBbTjlnuX4CDkii5p9E5LHX5EYSk4ao=;
 b=TVyoKILFwtFGkFYZkIFtzUPGksVRsGubS5ACJTSy33cFt8uexkRLFOr3MXTFaSEkoQX8nR+vM046tTJpZGOMESOKHA8OSjsnC9woI6VYqq+240GjSPL61FaWaR9qYyjj9s8EpKtrvqhcUyfllB3pDVYz7Ueid7yM5dHOf+afLKEBR2LRpVqGYUR+Evr4WqO8t5IUS76OwbsMC3a50kfbZLxFaSS4jzQXzq8TixQXuigTZRrCDmfwharaKMC43vMBTaCZDBiLNTDyrWaNOeOoq4ASBCMos56p7AyWu1XYjHn7BwVeXvjlH4B96A/YcTD2G/PkFGY269N79Fmmtrb0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzgQwQKSDWuEXBbTjlnuX4CDkii5p9E5LHX5EYSk4ao=;
 b=p7CNbKW8lw04lJNofx3lf3/OdGTB+GGnQKcIRS+a48z9Swy8orkpIPAf28XcUK3Is9vvV77no1+zhxnpWtLmqzVwCl3030alVfbVvYPVlvpqO7DBcSjICvFXCo000ZO8b28haJzoqLGIK05ikJBXfaQiezLQBZHDkT96QNbRVpA=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TY4PR01MB12748.jpnprd01.prod.outlook.com
 (2603:1096:405:1ea::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 13:24:41 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 13:24:40 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>, Biju Das
	<biju.das.jz@bp.renesas.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: timer: renesas,rz-mtu3: Use #pwm-cells = <3>
Thread-Topic: [PATCH] dt-bindings: timer: renesas,rz-mtu3: Use #pwm-cells =
 <3>
Thread-Index: AQHcvEqlan+ixJQ7D0WSZ1JkvkuZj7W/POEg
Date: Wed, 25 Mar 2026 13:24:40 +0000
Message-ID:
 <TYRPR01MB1561945B6057A2ABFCF25C6788549A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20250527205823.377785-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20250527205823.377785-2-u.kleine-koenig@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TY4PR01MB12748:EE_
x-ms-office365-filtering-correlation-id: ea156c0e-1b18-4858-6e79-08de8a71ded9
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 1t+WkyMHpC0jtoBiy1v03/zxYE2x9i9f59/bIIeN0PUEU8h8CstMHuA4smLSROrCS+YFcOnN3dflLbMGuyxrnhtBm3kxMr94/VjNAawP6gTEfXhLaH4T36PeJuh3+EAbv33xb/lI5QfqOpLk6SOepV1w+v+gN2oP3WQ5wXgz3rnL+0V3lxMoRf8gL+3AKEUuwUQw7iHekXc4ZrU/3UEwHYfsOdJFhsh30sUw3rVZrs+wkWIOTxstgVIPH585ZPcxLCsVzNL9Z/ukbRGeCXNI1Z1CVrKyBhoEgRpcWAWpTuPy3vgA3wkn46oHvvN2q0CKdHRdlsVY/Yo87qLclVI9sxoG1kQsYy/MuSn4PNcFgCYSvyIns9FkJ8w/NXVdZcKKwZJkmYp5uFiByC0GhKknJdZKdw4Zd0kgrJ6DB7wnm+CYn/gzvlyV8NEJHDJTTIp5LQRP0RDajZznukxLFbCHVLiUdyMgdup/l5MmDOa6RuoMpGJU9MiyVzjzN1MIo1Fo7jW3kVJr0vv7Bc6FJqxDcwhr6zBQK2G3GxDaFvE4Hk1/bY29vYNMPuQJRU9qEJwrpukRqVRY5jwvb5JY7JokvPFl0b80byaCVXTr224ra1zgHjVMxiK7x6ZgI68rQOeF5iz7cw4x0kZ8EDRBd/ZyOxNHxOYZXVQxmTlWt/nNAcRx13eFR3RYP7i1vw7OpFgGtzzv2na/geu9EcEZ+PvwwTwWmmvByU352CN9IBL1p0P+03KSXd3Sx070uyZU1p4ulXBqUEbzlJdxNisOmduWtJ4elPiV5PyLlNabizzhrfM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SjvRmeJL30MXQqUjws0ReXcJG4UMeM5mxascvv72nfGfu2fOql09WvrDGN?=
 =?iso-8859-1?Q?S2N71JZQHzBtMsUW7Mb9dqTIxKEX2aXTkPrijsskr/ksllqrrr0uh3Ozip?=
 =?iso-8859-1?Q?Os61HpoOFRc2VIMcvz0kdsoI0tb4I050gfP1f7LFABqHbKcWckFGZCVM80?=
 =?iso-8859-1?Q?q3ma5/41Hy1Qa5OUqfFFrQLzVf+EtAQOjQnLwN70PzW9hz5AnCEWC5Fvom?=
 =?iso-8859-1?Q?SSBDqZ844UpBJMidplES1ilUYK9DDs1yMwkJwxJVBXQvR6xZ7Yy25adeey?=
 =?iso-8859-1?Q?KoGgLY3SfUPWJhDeobw3xfQ0A64WPsKOT60/Ng5RGJldmT14ff3QFWdzUX?=
 =?iso-8859-1?Q?H7LmrdP0VXEnf+acXIiBce7qt/thjJnbiYnl7CbXxuqe98pIInDUMt9YqA?=
 =?iso-8859-1?Q?ke/SBkHZ6yqNEm3gMQjTT7hWR0HWW26lhO8pSOiQEuEnUtGp42240IuSj/?=
 =?iso-8859-1?Q?p2t0RnOLvHtMWFv9xanyzeNXOZbHS9MJ+MROV1851OZEhWbnFbexE9R2Cj?=
 =?iso-8859-1?Q?rt9NW3P5SUNI/8Xo3QAXtKoLJxONh7lFHWB4g/aMR7scOMQmrMw3sAWhZG?=
 =?iso-8859-1?Q?LhwjLFRaGKoiNCniyC5Y0KUBpt+onSQWTjPXLIxChW8tUMmrBC9dCUIhxb?=
 =?iso-8859-1?Q?PHnhSYGQG6X2UwqUE/FJT0fSC5wNYSlIIuWVZo/V2rTpyJo80VJi2UmNjb?=
 =?iso-8859-1?Q?Bq4BU1pe4jQa/+uV8ZVn8ckEo+3t4r5expKoctVS9fgtlc7c5P0TaGamBP?=
 =?iso-8859-1?Q?XbhqGg3DBIyzVD989ymvabjpJHgupEtR/dxwG4a0Dnz9ga5tw3IvJbIenj?=
 =?iso-8859-1?Q?h/iLEDQF0mdsbarB/g293pptMly7DGGy/w0fG5b2KnhnJPL9uzZ31fSpnw?=
 =?iso-8859-1?Q?yIPv6v0Wf64Boj1j+c4UQaMP8ntVCe/Q+QeNJYJjDT3KDuK9SUmRLPLRfg?=
 =?iso-8859-1?Q?7mbSwGS0anfPDsAxpyzguhS3uka4YSu8TMjQFZzPzVkohDWw9ZYmvElQD1?=
 =?iso-8859-1?Q?xrkbGmC94l8hRK3cQTKjfdr2Sh5Qo2zwK0+GxqNiVXPVjy6oxjSV08Z0SI?=
 =?iso-8859-1?Q?OQf1BTqF8wMCU6Tp0AtAPGUJ+WrbFbbJ4qvLyKDZQGkt9JNdkA5pyJCxfR?=
 =?iso-8859-1?Q?wrR3fQnXopfHgADY8+PBGH0UHuYXDObfVIiJgpwJdr+sx1K80pv2R3DWRo?=
 =?iso-8859-1?Q?7myAb4pu83zu3kahKWDgC/2ELMymSkvXp0b6Nbu3Av2LjYXatr9nqN7SAp?=
 =?iso-8859-1?Q?ftsMVii3uD9yw4FyB4Ui0ky4MxLRtq2ZVsDE1zuG9MSaE6c22zZLiJr010?=
 =?iso-8859-1?Q?A9+uQkcxNHkZThy11iwgNMDMTyfvIg2xEavehIanvA/x25VXOaEjDw41+f?=
 =?iso-8859-1?Q?31snPxs+zp9sRSIJErwVnpJC0DCG3Z5Lhtxb7pQH5JJOAP00433kxp75AD?=
 =?iso-8859-1?Q?sPixwXpnUXyiBFh9YOqNeakQ7YVh+HL5JNx3bWhhRRWP4pque1btTuy0qh?=
 =?iso-8859-1?Q?cJ5ewausEPYE0Ths2hvaG+o8TvzYihU28mHhu21yCWt2q7cFNQ5worqxVa?=
 =?iso-8859-1?Q?d+kyvO0KdJGMYEjCi9g48dlmjTf61bkVRUMa+WMUjhSTbcTDGRRFyIja2t?=
 =?iso-8859-1?Q?VqSoJjF0W2Gn2OgjMuPieJreZrqRbpzMHs7B6j2b8pUzL77pGfh0fEVZUB?=
 =?iso-8859-1?Q?2f+m4SXslRN5l9b9p4oyhxmWOfq4QmEq8hhUfUsJYd+gKTmV7UhcksZqai?=
 =?iso-8859-1?Q?UUu8RZe3YsQtk9h+3mmLKrhzKEiXjO3/Xw6DuBG/Kqw9yCqFnHkQ0dFKod?=
 =?iso-8859-1?Q?P+98pipFLmewOy7bI9IbQejnulqOQsWYDdPCkYEYcVEDTMULnfwo?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea156c0e-1b18-4858-6e79-08de8a71ded9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 13:24:40.7674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRrJNcC//Q4w07tUQeguK7CL6LNoc368RiZLcR3Za0Ia1enEC/n6B935tvseyseQwEz3EZUvrt/m3Fmy35Xvfoijg6bwY9AMzgoDGN01pAbsCrEmqVS8AFwiGDardjca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12748
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8368-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cosmin-gabriel.tanislav.xa@renesas.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,TYRPR01MB15619.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: A931E326391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Sent: Tuesday, May 27, 2025 11:58 PM
>=20
> With the goal to unify all PWM bindings to use #pwm-cells =3D <3> update
> the renesas,rz-mtu3 binding accordingly. Keep <2> documented as a
> deprecated value at least until the in-tree device trees are fixed
> accordingly.
>=20

Hello Uwe, Rob, Krzysztof.

Sorry for replying to an old patch, but the context is relevant to my
question.

I'm working on adding MTU3 support for a new platform, Renesas RZ/T2H.

From this patch, it is clear that new platforms should use
#pwm-cells =3D <3>; as <2> is deprecated.

What I would like to clarify is whether existing platforms are also
expected to be migrated from #pwm-cells =3D <2> to #pwm-cells =3D <3>.

My understanding is that changing the provider to #pwm-cells =3D <3> would
break existing consumers that still specify only two cells in their PWM
specifiers, since those references would then fail the checks inside
of_phandle_iterator_next().

There are no existing consumers in-tree, but there might be out-of-tree
ones that depend on #pwm-cells =3D <2>;.

If we're okay with the ABI breakage I can proceed with the changes for
existing platforms too.

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  .../devicetree/bindings/timer/renesas,rz-mtu3.yaml         | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> index 3931054b42fb..3ad10c5b66ba 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> @@ -221,7 +221,10 @@ properties:
>      maxItems: 1
>=20
>    "#pwm-cells":
> -    const: 2
> +    oneOf:
> +      - const: 2
> +        deprecated: true
> +      - const: 3
>=20
>  required:
>    - compatible
> @@ -299,5 +302,5 @@ examples:
>        clocks =3D <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
>        power-domains =3D <&cpg>;
>        resets =3D <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
> -      #pwm-cells =3D <2>;
> +      #pwm-cells =3D <3>;
>      };
>=20
> base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
> --
> 2.47.2
>=20


