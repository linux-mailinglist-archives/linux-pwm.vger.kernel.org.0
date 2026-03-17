Return-Path: <linux-pwm+bounces-8291-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLUODoHduWlHOgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8291-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2026 00:02:25 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB3A2B3639
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2026 00:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A0463091C95
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 23:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C72367F28;
	Tue, 17 Mar 2026 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="QAtcGhtV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010055.outbound.protection.outlook.com [52.101.229.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8121C8634;
	Tue, 17 Mar 2026 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788541; cv=fail; b=e+m7HojlY2TJWgyOS9paLeeaNpGu8p6l8tN6hRomACTsgkyH+HlynobxjXSbsFGjyW4Hr8DaVGCBtI37JnrMaNnWMYIaF9DdhQu247BO19PvwBAFFaLEnAkYFqKLurm/SNVB3s7+mjLNTlAC+zdUdWBRFhmk/F+9TCYyhsxPQ4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788541; c=relaxed/simple;
	bh=dzzroiBI1m/FQqNe8jAbV7XTblbNCYFvv2z+Yh39uT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KTSarf0SJDX5/xHEN6StWrj0GGrZ/Ik3Z0nOpRgloKkG/STGfxZkZjhwo1hHvsV99h1ykJR0JXbyfYOnWtqG/YSuvrAzAKEo3ufQJoG/ARdHLO0SV0ZXfaWP6kdQhfCZmStzxOtVY1aG7pR5gy81L6chLcZYZjabpjjLTpb+syU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=QAtcGhtV; arc=fail smtp.client-ip=52.101.229.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4zaKDV+IWb+cOwCsf+h0rDhxFyQ1KtW3LKFl6ZFJ+6DK2/ng0/j0+oLPbKsQ9et/g34rAjmL4P2PqSwSvD5GkUk14ov35Bnl/2s8NK8SIBeF5qDZzYG1LtiMbYkahISxAKcEd3E2mPs1UBcyZvvABjZKhe2qALAYNM+jPObLwGu2hMnCT4+LvgXUvxPRUytxQlv+Qx0CMx0/Qaf3EuQgq+sJCVBFDVr9H/Q745P1RZteBA2W2jPn9mOvdLVpR+Gez+NGPu/JNEyKIuyGiTdnd6MaC0EuS02GTV//YViaKKO4qIt/tbQfijQbMTaucNvDBrnjKrEYOxzRsbe+PXQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39ZBaR2DKfmFE1KCq29B8ZSlZKRvyjla+hfWeoiFIYY=;
 b=Mm5XAkTX1H/vMfsZLfoGxMT2lHdspYcuYdbvFmRw8XFjv6sB3wKz9ZoPwpsnySwleCjV2lPD1bROd31A3q5uqymU5bEwNu5+qmU4Fr7jab3q64ynUprOHm8ndN9tIE6fb/vFgY4mq5xDc6eEylwe8MZjeu7D7/Vjf2GWhfQITlVRZvQY76VvmyXHWQ3uNnNoXKbCzTgJF7NRzfZ5/cmFX3KAhcV7ahUdp4dr7aDmvnLyo7ojFrV5TxH0dwKqENK/DH68yfiY9wtVoN9St/Fb7SiT0WYtH+ppPadidzD4dt7ih5XHYDteVpRiHvchrqKnmaJmTNKfL49i/5P4g2SfnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39ZBaR2DKfmFE1KCq29B8ZSlZKRvyjla+hfWeoiFIYY=;
 b=QAtcGhtVLCsyG4+8iDbdwSKGwNmTTgUni0D2UwYK6vPYf/TLxnjoOdlk4i/gIUy8pO8v1qO9H9A9uVrsCdLGjq+BmGNuD6cLeQfOsCNVG6XWja9dzbBgKo5W29G239zQsaS63HLsV7NB9MZmNCyHngQ12eJ5zhQPWdS6cWCc0aw=
Received: from TYYPR01MB15615.jpnprd01.prod.outlook.com
 (2603:1096:405:291::13) by OS9PR01MB12167.jpnprd01.prod.outlook.com
 (2603:1096:604:2e5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 23:02:15 +0000
Received: from TYYPR01MB15615.jpnprd01.prod.outlook.com
 ([fe80::d8aa:d4b:55a1:2948]) by TYYPR01MB15615.jpnprd01.prod.outlook.com
 ([fe80::d8aa:d4b:55a1:2948%7]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 23:02:12 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: Biju Das <biju.das.jz@bp.renesas.com>, William Breathitt Gray
	<wbg@kernel.org>, Lee Jones <lee@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
Thread-Topic: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
Thread-Index: AQHckeNxm+l5nvVDhECE0kd9r0GiYLWhc7cAgAAuuBCAD+SBUIABMXYAgACMt/A=
Date: Tue, 17 Mar 2026 23:02:12 +0000
Message-ID:
 <TYYPR01MB15615FA52860D81F04E42F2C48541A@TYYPR01MB15615.jpnprd01.prod.outlook.com>
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <aaqTVDQa7xn70bR_@monoceros>
 <TYRPR01MB156191C8E77BDA44AE23A7D4F857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <abkX1ssLhkGxryfM@monoceros>
In-Reply-To: <abkX1ssLhkGxryfM@monoceros>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15615:EE_|OS9PR01MB12167:EE_
x-ms-office365-filtering-correlation-id: a563d3f6-a608-4b5e-d6f3-08de847939af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 RBdenGucKofbikrOjMOOVITVBv3t0TcmGyjnYxEDtMc5cTYgPNemrJqDPyxZ4SCJzeLe3Gt2ItxClLNaPCKNib87tZW4HGVxW+CxDj2LHHw7gSx0bNSNj6hV3SRo33+afcZhQBEbzWerbeiSmgXIPGjb9Im/+COix+OhiJgCTSA71M4zcT7HRBK/90Akilpu1FaQXSNDssBzkpo1sVJe41EHBmiHPjz/C4KzFuZf3Hi40pdMr3fHdEpbRdOT2T3y0RSdtI0r8V0S4UGv+C+kjxK6rZjm731o9IVJr2AOeSGaFg6ZOWGWB7Q/RfCwLy53Pv1EOqf4e8kyTsCI0ipj+wvoY4ePJWCfUC5RvN9POMst0eCFxOJwHBr5eVK2XJF9D+IgSjkKUER8dh62jILNBjnL3qpwYZDwyCl6IOjNYyNxRtZoYo9V1v0AuL08W1wrwwQFWyg3hOBb8NWe2hAb2lew0zueywPvlo6nKLctQEdaG/dSF6/CoVQalNVBUlWrAx1stkzACjv9k7miFxYqJKgvDXIAVoAsHKavKPkpCwhS/8NLBJ/dgx+pUmtEdqkSuSD3n7AwtUJ9VeO7DTA7yayfX7IX6BtK25iTGAfTCHGAGtbjXXmMX5Eu4ug60t+BNSS19wtrxNgLHYfGRNPWskAgRn1uC/qDjuBVKN9oj0uAdp/0Mcj/fkc3VbskqaBvXCzyQSO35yDOeRGTZltYnRAc01Z6MFT7ZAfu6rhbNKCzSWyX9uEcie8s3XDK7eltJhMRIn9RoDVN3HqpmR9bWfaJtJyfaUUN5RPupLZ3/X4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15615.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rMBgm5NDuD61fZl25jz3hL8WrTvduQrooG/5bujK8tro7pxSFyOQRwBlfI?=
 =?iso-8859-1?Q?WRQX0JN1KECKXEpFTod2gUhb8tyWrxHHD1wuKOmQ//QieIeNmIQLYlS7EI?=
 =?iso-8859-1?Q?J9cOuk2/ir/DBSHQWlhYgIDkxhPwQCNC4OR5IC5hdaVUW3+WheDui+TfOk?=
 =?iso-8859-1?Q?CT7yNPEAVsPbeMqzAWA8snfIJQnYH0BM+vcYY7yJWNJ+lFa71+5weZPFp9?=
 =?iso-8859-1?Q?xG0oASWJkk5wJuK29O8gsYjdHtC5M001leB5S05r8gluXA1ix47SnsCLgj?=
 =?iso-8859-1?Q?+sOXPkJLGolijYI44lve1stvcdKTdF+PkZJtK7gU7diXpKiS85zF35Mxri?=
 =?iso-8859-1?Q?zjXajm7gQVykM4E6wvTWLZpq0eHVPAL3R18Y5qFANTBCH94XEi505xhhrN?=
 =?iso-8859-1?Q?AJJdredAehTAUtwAvXb01J/NXv0uWZbwXPtzV4qFgkCvkAF9N6TBlroAFE?=
 =?iso-8859-1?Q?i3ISBP6j07euneHzXG1xW35DqfHbJ6wH8+gtVOUoDOGBBwEYzHAS52T0u6?=
 =?iso-8859-1?Q?cVz4PreFVFSoJyjsOa5eiCVd1aa6ihfN63vli6igi+baLfzRIk+m1rq2vo?=
 =?iso-8859-1?Q?vEZgSFolMv0S96x44XzHFm7Nu31hXY81QKIf2GBvxHSaq79iB09lpgjg5g?=
 =?iso-8859-1?Q?Xw+LkQua2xLuJBEjqbCz0luo5cr/V54MkBaSKm8VC5+HVYv9AtxDfls3CU?=
 =?iso-8859-1?Q?W+l3UOuENh6pTp65/tU9NrLPBcoIQhWbvitrm3v5EPBz8bL6cvwOssXZ8w?=
 =?iso-8859-1?Q?SoNeaj3iLi2JFfjD1KChqo4nTvtpJVX6EWYzbbuLM0/NnL2kTQ3OEsf3D6?=
 =?iso-8859-1?Q?0apOZWNFL33/RFurFKnw5ZhqFKpbZNpioJbSwEKiF+36dr6kmJKC345uE1?=
 =?iso-8859-1?Q?foLy01s3JyQ6LWeClDcYAyrNNN3IvBqsXyIi2/JYJ4gJcyIrEYkVSZkMq3?=
 =?iso-8859-1?Q?ntPItz65nUPignLmgn7lHkRgzYethH7giIvQ/ytXFjFKwWyHYCO9kosHmp?=
 =?iso-8859-1?Q?rdOSq7HUtr2h4Iwd+rgaZnOTJ6pr2GW7ArRaG0um+30RNqkqtPgWvaAoz8?=
 =?iso-8859-1?Q?xkfZ6rqzrwX9Ty7BFHvcZGjsauKWAxYTdF7+QQazwmeHeRxtlSvJsPaGKU?=
 =?iso-8859-1?Q?ziOe5GJT1zzsWj4HCQUrd5wfaw1oTcIkeIGZrgHK79D5cnp/wnxPUzrYbD?=
 =?iso-8859-1?Q?QYUs1Zgj9xOWwztF2OhsU5psb3NiqPtqLd/lAanYAdoy2z1rRckJSO4Bjv?=
 =?iso-8859-1?Q?drMKGZOU/H2YrMXn3bWBMKpDn+wv+sa3q964w/YL5W335L/HsvON7LqoS0?=
 =?iso-8859-1?Q?kNMGOwNxLz0aIB+Acvfd5wQNZEnbMEuxQCk2neEullEbeiTfo4ZfoEu44c?=
 =?iso-8859-1?Q?10nnJCyQXaG2L/Ou6lnxeDcjFjYSw1xOczjrfc6skeVD2kUJuUapJL0kjN?=
 =?iso-8859-1?Q?/5F0aMnyrwuUPkruLVDnmjYrGqNNv8Jifc8S7D7obUB60USdcF6nxwvo8j?=
 =?iso-8859-1?Q?TWhXxeh1fEDHjM/ESHdT+pUXpCpWT8Jp9LgjfR41J4C06s5VgflOYhATBN?=
 =?iso-8859-1?Q?SLZdTl8vPuayW8Q8hOisIokEaOe26nkkYuoNyVNgDGcdz8K7SALD+gLOag?=
 =?iso-8859-1?Q?mAEyU4QqcZ+DOdmzg/CvCdE/hYx/XGjxETv0RUkFH5reG3fmb/kpq6MseW?=
 =?iso-8859-1?Q?MZVvmTnzGJAn+CnIGbI4MS8RrDAQsYoguq4LJpGD1JMhDxfxAm/EMwjwUh?=
 =?iso-8859-1?Q?PV8RdEmiJxqsof/33ExzQys7n4OFeYsug2ci0smYMeZ9gbBG3g6w6hPRvY?=
 =?iso-8859-1?Q?y0smqeEzpt4zDlIqDIYwXZVuCT98aAIfz285k8+tKuRSfstKuqsl?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15615.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a563d3f6-a608-4b5e-d6f3-08de847939af
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 23:02:12.6467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fdsJUb1yfuTWvmpDFXRrQmzf9nrd8pFtV4BYLjPJbXtSXVnsvtonbwgMiBtyfURQ75wNNJUkT//m0PwURnftfMEXX/d6/WDPhpp2oc4vGgXPTN0auitCTNZL7kkTlqt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12167
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8291-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[renesas.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cosmin-gabriel.tanislav.xa@renesas.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,TYYPR01MB15615.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: BBB3A2B3639
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: Tuesday, March 17, 2026 11:12 AM
>=20
> Hello,
>=20
> On Mon, Mar 16, 2026 at 03:49:35PM +0000, Cosmin-Gabriel Tanislav wrote:
> > What do you think about this setup for mapping from PWM to HW?
> >
> > #define RZ_MTU3_PWM_IO(ch, secondary) \
> > 	(((ch) << 1) | (secondary))
> >
> > #define RZ_MTU3_PWM_1_IO(ch) \
> > 	RZ_MTU3_PWM_IO(ch, 0)
> >
> > #define RZ_MTU3_PWM_2_IO(ch) \
> > 	RZ_MTU3_PWM_IO(ch, 0), \
> > 	RZ_MTU3_PWM_IO(ch, 1)
> >
> > static const u8 rz_mtu3_pwm_io_map[] =3D {
> > 	RZ_MTU3_PWM_2_IO(0), /* MTU0 */
> > 	RZ_MTU3_PWM_1_IO(1), /* MTU1 */
> > 	RZ_MTU3_PWM_1_IO(2), /* MTU2 */
> > 	RZ_MTU3_PWM_2_IO(3), /* MTU3 */
> > 	RZ_MTU3_PWM_2_IO(4), /* MTU4 */
> > 	RZ_MTU3_PWM_2_IO(5), /* MTU6 */
> > 	RZ_MTU3_PWM_2_IO(6), /* MTU7 */
> > };
> > static_assert(ARRAY_SIZE(rz_mtu3_pwm_io_map) =3D=3D RZ_MTU3_MAX_PWM_CHA=
NNELS);
>=20
> I think the RZ_MTU3_PWM_1_IO and RZ_MTU3_PWM_2_IO macros are a bit too
> magic and would use
>=20
> static const u8 rz_mtu3_pwm_io_map[] =3D {
> 	RZ_MTU3_PWM_IO(0, 0),
> 	RZ_MTU3_PWM_IO(0, 1),
> 	RZ_MTU3_PWM_IO(1, 0),
> 	RZ_MTU3_PWM_IO(2, 0),
> 	RZ_MTU3_PWM_IO(3, 0),
> 	RZ_MTU3_PWM_IO(3, 1),
> 	RZ_MTU3_PWM_IO(4, 0),
> 	RZ_MTU3_PWM_IO(4, 1),
> 	RZ_MTU3_PWM_IO(5, 0),
> 	RZ_MTU3_PWM_IO(5, 1),
> 	RZ_MTU3_PWM_IO(6, 0),
> 	RZ_MTU3_PWM_IO(6, 1),
> };
>=20

Sure, I'll remove the extra macros.

> and then maybe just:
>=20
> #define RZ_MTU3_NUM_PWM_CHANNELS ARRAY_SIZE(rz_mtu3_pwm_io_map)
>=20

Good idea, I'll change to this.

> instead of the static_assert. But I guess this is mostly subjective and
> I won't try to convince you of my approach if you prefer your
> suggestion.
>=20

...

>=20
> > static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > 			      const struct pwm_state *state)
> > {
> > 	...
> >
> > 	u32 enable_count;
> >
> > 	...
> >
> > 	/*
> > 	 * Account for the case where one IO is already enabled and this call
> > 	 * enables the second one, to prevent the prescale from being changed.
> > 	 * If this PWM is currently disabled it will be enabled by this call,
> > 	 * so include it in the enable count. If it is already enabled, it has
> > 	 * already been accounted for.
> > 	 */
> > 	enable_count =3D rz_mtu3_pwm->enable_count[ch] + (pwm->state.enabled ?=
 0 : 1);
> >
> > 	...
> >
> > 	if (enable_count > 1) {
> > 		if (rz_mtu3_pwm->prescale[ch] > prescale)
> > 			return -EBUSY;
> >
> > 		prescale =3D rz_mtu3_pwm->prescale[ch];
> > 	}
> >
> > Please let me know what you think so we can proceed with the work
> > internally.
>=20
> I'd prefer the `rz_mtu3_pwm->enable_count[ch] + (pwm->state.enabled ? 0 :=
 1);`
> variant. I understand that this is also the variant you prefer, so
> that's great, but I wouldn't stop you using the sibling option.
>=20

I realized the check could be simplified quite a bit while achieving
the same outcome.

	if (rz_mtu3_pwm->enable_count[ch] > pwm->state.enabled) {
		...
	}

2 > 1 -> true, prescale gets checked when updating one of the IOs if
both are enabled

1 > 0 -> true, prescale gets checked when enabling the second IO

1 > 1 -> false, prescale is not checked when updating a single enabled
IO

0 > 0 -> false, prescale is not checked when enabling the first IO

2 > 0 and 0 > 1 -> impossible since enable_count is always in sync
with PWM state

> You can gain some extra points for not using pwm->state. This is a relic
> from the legacy pwm abstraction and doesn't make much sense with the
> waveform callbacks.=20

I can switch from enable_count to an enable_mask in a later commit, and
that will allow us to both get rid of PWM state access entirely and also
make the sibling check more obvious, by doing something like:

	if (rz_mtu3_pwm->enable_mask[ch] & ~BIT(rz_mtu3_hwpwm_io(pwm->hwpwm))) {
		...
	}

Which would read like "is any other IO enabled?". If yes, don't touch
prescale.

But for the scope of these fixes we need to keep accessing PWM state as I
would like them to be backported to stable.

enable_mask must remain per-HW channel because it makes the enable /
disable checks simpler.

If this sounds good to you, I will proceed with all of these changes.

Thank you.


