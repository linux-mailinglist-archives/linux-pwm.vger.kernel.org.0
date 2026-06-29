Return-Path: <linux-pwm+bounces-9457-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IoM4BHsnQmou1AkAu9opvQ
	(envelope-from <linux-pwm+bounces-9457-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 10:06:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F496D749D
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 10:06:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9457-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9457-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75BA73168D53
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 07:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248493DCDBF;
	Mon, 29 Jun 2026 07:45:20 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2138.outbound.protection.partner.outlook.cn [139.219.17.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A53D905F;
	Mon, 29 Jun 2026 07:45:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719119; cv=fail; b=nnqDugxQgojlZfcc0EK97gcTsN0iJYyP2Ud4iw3akPJ3BEsrKHBqgav3ZAR7svaKY5ZiOOOZPT+TIQDQjU00GiVfBzlrqmwzUvYoJM//V2ksY+xEfU5nkUVP+y1dJbHBzV+rYk/198wzmpC0H8LQlp9QVqGcJ7I1mXFhO1RxbNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719119; c=relaxed/simple;
	bh=INX3l8g9eEOWtIJr0gucljJJhwccaQZ4GJIhnnUSel8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cUCoAaiAl8XjM+PaJi2KmUK8gR6ZRIoqi4zWHbGFQcAejeXzwlWgywSPZZ0F0sN0ValNjkL9AP5yC/LeGR8RRiqShVbT0aOhPTlI2VqUtuQzH4P/XzCwLSKy/98/6l2NFJW9wir3Jq4IORfIuntR2ldaoARjgmtAtO60JjPp2Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.138
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnEdndAvh8U6sgLlTxDZEVq8mRvWv75xWZuHL3FwkIoAjVPaZcdJbeBehCz6jOZQtT96O9GyYL7dCnAziYwgOpTETfLcvSFeoi0sUj0WGIC6IU8F1HMZ2rGOoeQdMbFZ1itWY6RZDAYkKllYsEVFzPjl9Hlmt9ZS0w1FMa7jSF+bVGDTVdqtOGtTATF1PhxQc5vMcvxV2xgzsTegzFnN/chWNCt+cUtdjeO+5URzKWyLgWhWCID6QtpclUfK2fGrg5OFNYbJH8wtjt6qHBvpzWx5+uHH97kMli2fFCPPYf5i022H0A7+HAEo3VV5ay+LAJoUuA+6aFQnvM5Fm83Eew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEBoUnmkAlAqhavEz/RdJAnjV8hQJTGrF4zmjVwzNOQ=;
 b=J0LIG00Z1g6zmO/jDqvcolbXsL3ph6t0e/Ur/qxyCCc5Mhu6aeGGkxcxBVexTJ4rNVSFaKSm/px5EtMgXhSNT3dHDaopUTAcL9hPo8wbhpDVVKHopG0FM8CGHzqQAj1MsXlwg3dI7U7bg7wJXTd3OVf2Xd07BcW6fqwgQgg23GJ1Wqd7Dn+xI0fcuLHKACDbDfFMA8K1e1BWCAAYNV8OpkAajC7G/rN5BOTFTYRwd5qRWa5gRmCLMDq+1toMBpZ27iIgq7ci6fYN1b6e75/WfL6dEnMmObJRTPKyxF0elHBEWWJ3VZye2n5h9gNbyvyoB18Rfn9n/GA3THYUzdjVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1299.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::9) by ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Mon, 29 Jun
 2026 02:09:25 +0000
Received: from ZQ4PR01MB1299.CHNPR01.prod.partner.outlook.cn
 ([fe80::9284:55ac:8499:dfc2]) by
 ZQ4PR01MB1299.CHNPR01.prod.partner.outlook.cn ([fe80::9284:55ac:8499:dfc2%4])
 with mapi id 15.21.0113.020; Mon, 29 Jun 2026 02:09:25 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v19 1/3] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
Thread-Topic: [PATCH v19 1/3] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
Thread-Index: AQHc/N/BbYwhFywv1U+0WhLg7DD1frY/zFoAgBUSgjA=
Date: Mon, 29 Jun 2026 02:09:25 +0000
Message-ID:
 <ZQ4PR01MB1299D0EB20EE30602AD13A2BE6E82@ZQ4PR01MB1299.CHNPR01.prod.partner.outlook.cn>
References: <20260615155759.129210-1-hal.feng@starfivetech.com>
 <20260615155759.129210-2-hal.feng@starfivetech.com>
 <20260615-crescent-equation-d948fcc46cd1@spud>
In-Reply-To: <20260615-crescent-equation-d948fcc46cd1@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1299:EE_|ZQ4PR01MB1202:EE_
x-ms-office365-filtering-correlation-id: bf25ee96-9daf-4277-20b9-08ded5837184
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|18002099003|22082099003|38070700021|3023799007|56012099006|4143699003;
x-microsoft-antispam-message-info:
 mw9bMNSVrOb3vCRqCaV2mwhXXM+0A+EjE1xqrmIQdLxlSkHER1/UsIELOCZWQS/Q2SJU0w/M+ScavcnTVyz2Bv8eBMgE+ILBNlD/I0q/qOFGNQSf84gnwgdTddcNGbU1iuqMZVej/O61MYAoP0Zwxex6qfQz+J0GxZDzlYvBKFDTmJBavktsWPlnE5Vse6qiEuZpmP3BnrXHOG79AyObu32zAfTgG6agBgyduL7FjrQ66jZPBhdGMXiRyQFjMjaoUL34/m02RwBvxlskEQP8zswJF/r5tQSGn4rxHNTvIuqXhO4Nqg3spPkqbuzeAwqDCnHu+jcuwvHS7dyFbvJpYCEtOhwm6FpHQBhrxVPeYaXJ2w23eX/C9JNkM9fsWndDoXGOuE8GjjTa1d49V2/8m/sVLJEclGrKPSQqTA8Sl2mOuaK3tQl7dTO8nstAIoo2veOtR74Tw8dDvpxuwbCXE9MD3fNl+gCVtqGhKUetM8jU01p+Z4YcZWjfbZvEWwDLmmSRAJa7uBHXlGNgwCiDZcjXrNXOX6SS2lXlannciwZ6K3uBYOe8MNAgTqae1oj9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1299.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(3023799007)(56012099006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LXyYL4ojFS3EokgCZrVJUbsNiqYxwur42EDCOBFBBrXIMlOvL0CGguWk41?=
 =?iso-8859-1?Q?uMI6MYB74ZjrC7rNO7BPw8nwcCIHdJhpnyUjMLkNpsKdbXB7kiJWat72jK?=
 =?iso-8859-1?Q?NPVBEaGJQuB/8AtcAonZ3hoePbwALvL2gtN4G++x/ZJAKVYfyu77WMyQbK?=
 =?iso-8859-1?Q?qW/7RAxu5cQumZuMX0YrVkJbsQ9nCtNWDCVasygCg6ziDBDk3fQfJ3PRiw?=
 =?iso-8859-1?Q?taDbq/AcX6UV2pgtM/H19SBRw7MTTKCADAxRMXokVXlR8vMmZ/7vFlGxZg?=
 =?iso-8859-1?Q?tdR5NLT/g6niPnZUOPyGRJUuMf7zgiRxkedfiBxYxJj531rpgIZrtSW5Ie?=
 =?iso-8859-1?Q?ywj8jHqzJnG7yIH09MGgVvyFqZ7a919DHC6oFKCrpyO/Hm/3OpS4SBP+0D?=
 =?iso-8859-1?Q?drbq81JrINnKFsTxpL+TTNQTKeG+B50WZhNOcka3jUdUHy1gvhAJmMjnRD?=
 =?iso-8859-1?Q?XF2tYaXC7Hj4/so2B2PUR/bozbs2CT+47c6MgNWXq879Qd2FXmtuMMgeLx?=
 =?iso-8859-1?Q?C/9yF80m1Qiet2qiy3ThgIS5xpvHIF+Vjs+37KUMvtk5chYP5NCyzFA0s+?=
 =?iso-8859-1?Q?psnzqhp5Xr9heAsvw2ZJc2EB5bx7D3Ejyc34lctotlhpa+Nn4njktDyfjG?=
 =?iso-8859-1?Q?Klp1swghJEm0wkIvMk1a3oM5s21Hqj22lnEJpkJOKylqdULQqDlosujRWe?=
 =?iso-8859-1?Q?iBDVuO+FAGgLdbyOcI2hNHj08HEQMkHBd2t4ZWZ1Q25NwwpFi5+9t17cv+?=
 =?iso-8859-1?Q?EQ1umVKXlcb1oVAuS7HLhbKVuuxe0fN4ERaWEh7rNwEefJuIVEHl+ZUb8w?=
 =?iso-8859-1?Q?BwIsUE3+dUoT6Ug3Q+98wiP3Kk5Vay2IyTZkwW/v0YFr7TjR55xwLaUouF?=
 =?iso-8859-1?Q?FytLHNlxgpBsKgOlybw2TALbxhu35kXFX99YPtEZdCMDHmu2XwRkCmuRTL?=
 =?iso-8859-1?Q?+1xeRSCOi35AgM/2p6s5TJgG2crNBngcflTOvp9wb8F8TQwUZAHHsMJbdF?=
 =?iso-8859-1?Q?UAmOE2pOGhAKNd34M4aCA47GElQLLEDHcCahJMwQQ5CuSNpuy+eFifew1q?=
 =?iso-8859-1?Q?jhiqaFK0OjNIbfWw/jlIv1ZfRu8P7cTJC3d0U8cVggeYtDeeNP+b331oHb?=
 =?iso-8859-1?Q?upAwJcUOyireBuTcx3QNMFgVsuY0uJxP4M/UY96eFAvnP/ZVmjMigFBjTX?=
 =?iso-8859-1?Q?Q/yq0LFd+2tQ+lbbnr+M38AH6iB0pXGKL5cDQGrlw7nkmdaCRauv6lOTw+?=
 =?iso-8859-1?Q?Ne5yJ7aaO6solweApY9386hWm9fee/cgA2HEXX5Mqdy3FaCXsf35WuVGbv?=
 =?iso-8859-1?Q?cCswZHQVj8+zfQYi8Y2XVy0oQ0Z7pgWCCOu6DeL6ZJRRu8eDENkjIag7Bd?=
 =?iso-8859-1?Q?RhkfwlaLEDddezTBTN3zsuZzfBCQ4MYbMN0rQrBG2fkQxs6qpNkGww36Dv?=
 =?iso-8859-1?Q?hwpY46cYpnTfFuSoWyVH/4U9dx+LOIV+KC///Vvyj83vA53/Z9u1tlAV6u?=
 =?iso-8859-1?Q?WTfi6N+BjqV20xg3nKkncB/nOgZDA8N9x7so3aLhWiiXBMj1wttcHYamUB?=
 =?iso-8859-1?Q?lL2QDHpTKtnTgbGoYgbDiLnrR7ssYZdKba8HfNxu2x7aLecpUxr/H6OrUf?=
 =?iso-8859-1?Q?j+ZtBpM10x7Gh+vznRRW94JGF5XbuQx8Je6REOZt2Kem24eq5rjlMEDBT8?=
 =?iso-8859-1?Q?BMRTQW6Y05A0/cXB3MLhh/WlWJhi3txJ2yGpYxHJgS4OllBgMqwya7h4r/?=
 =?iso-8859-1?Q?EFg9AsJlPpvm43xaL9nVoRk2hxZuy8dl2rm3cNgGfUOAyQUh3i9GFb3X+H?=
 =?iso-8859-1?Q?aJIzvbmj4A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1299.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: bf25ee96-9daf-4277-20b9-08ded5837184
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 02:09:25.4756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIJuPEbVH0Nrs7EDhXAsmx3FvLrvowcAcihcrF1+FZDgS/Wam2nWbuN15PZfA64VbKIMAiAcBP3RfxNri7c/6mDGjNZsg2Cl2ytbcu+ugw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1202
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9457-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:conor@kernel.org,m:ukleinek@kernel.org,m:p.zabel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:emil.renner.berthing@canonical.com,m:palmer@dabbelt.com,m:pjw@kernel.org,m:aou@eecs.berkeley.edu,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,starfivetech.com:from_mime,starfivetech.com:email,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39F496D749D

> On 26.06.16 00:22, Conor Dooley wrote:
> On Mon, Jun 15, 2026 at 11:57:57PM +0800, Hal Feng wrote:
> > Remove the jh8100 compatible since the JH8100 SoC has been canceled
> > and will not be released. Add the jhb100 compatible to replace it.
>=20
> > Use a oneOf construct to support the single-string opencores,pwm-v1
> > compatible.
>=20
> No thanks. Simple as this IP might be, I still want soc-specific compatib=
les to be a
> requirement.
> pw-bot: changes-requested

Okay, will update accordingly. Thanks for your review.

Best regards,
Hal

>=20
> >
> > Change the register size in examples to 0x10, since an OpenCores PTC
> > IP has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.
> >
> > I will maintain this pwm module in place of William.
> >
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  .../devicetree/bindings/pwm/opencores,pwm.yaml   | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> > b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> > index 52a59d245cdb..5f05606a2d3d 100644
> > --- a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: OpenCores PWM controller
> >
> >  maintainers:
> > -  - William Qiu <william.qiu@starfivetech.com>
> > +  - Hal Feng <hal.feng@starfivetech.com>
> >
> >  description:
> >    The OpenCores PTC ip core contains a PWM controller. When operating
> > in PWM @@ -19,12 +19,14 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    items:
> > -      - enum:
> > -          - starfive,jh7100-pwm
> > -          - starfive,jh7110-pwm
> > -          - starfive,jh8100-pwm
> > +    oneOf:
> >        - const: opencores,pwm-v1
> > +      - items:
> > +        - enum:
> > +            - starfive,jh7100-pwm
> > +            - starfive,jh7110-pwm
> > +            - starfive,jhb100-pwm
> > +        - const: opencores,pwm-v1
> >
> >    reg:
> >      maxItems: 1
> > @@ -49,7 +51,7 @@ examples:
> >    - |
> >      pwm@12490000 {
> >          compatible =3D "starfive,jh7110-pwm", "opencores,pwm-v1";
> > -        reg =3D <0x12490000 0x10000>;
> > +        reg =3D <0x12490000 0x10>;
> >          clocks =3D <&clkgen 181>;
> >          resets =3D <&rstgen 109>;
> >          #pwm-cells =3D <3>;
> > --
> > 2.43.2
> >

