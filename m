Return-Path: <linux-pwm+bounces-9481-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2fwJOHIgQ2rJRQoAu9opvQ
	(envelope-from <linux-pwm+bounces-9481-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 03:48:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 121116DFA36
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 03:48:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9481-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9481-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2743300A602
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 01:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC442472AF;
	Tue, 30 Jun 2026 01:48:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2138.outbound.protection.partner.outlook.cn [139.219.17.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA9642AA6;
	Tue, 30 Jun 2026 01:48:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784111; cv=fail; b=IvWgHamUyv936K7zWMbbyg5QAR9ux+bF6YIRkobgMTbwxv/dObh7AxD2WYm/U8dgkdMmkBA7glTbi4shMAYHRWcUv34jzQOsdexGKgGVo6wH6WOe/OS59zt2ubH8QpHGupLrNrX4BLQBxdG6YhaCwH14KQ++SWyat+rhrJIxHDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784111; c=relaxed/simple;
	bh=1i9vhJmoiXiN458GCN4qCWZXw8IPhFsZ2L7FnCbdndI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SFITD030EwDrHAne2v5lvMJ/BlpxqnNTIjqhnJ4pnJD5jPx8nFCXmRfB/Fcm/r4z9Ih39f29TpeNRmELDMOLw4fjfUsLlRjAP2XLSm3jt1CO/WvfPp4K6rNdULiQOy/RQldqBarahyGBWVp9xdpZqt/I94vIYfJPCpOUqVFr4zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.138
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asrFfjegy9FYOG13fQWCSjOUsRzr8sygjLjGH1SuPdUDz2Ej5VLr7qDMjSBx1RZBf87M6ytjjZFS0ij+ZFmoDYFlwo5FxY4XtR+tdpURmLDbkU1s4epA3voCKrgyGS66yqWPXLEPrkuJO7gaR2PqjwwMKTKyQWbk3mREk4NJUPjbAx4wbCcVbBJxDz2oBtyfVEJkFNV9lw1icbnv6gm818T/Z34hwovz5Ba31XBs0tHaJ+tTVbYzDRQ1vM9l3MSZDZMjCenyTCgRVr2YSBpPnJsZYA4mxmjfCZcQKMjhGMTO1BB/zqjQwrBupnedlbGFVQ3OZo5/sSpRnPhme1hjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyHuYuLqGhUQzsn64XVkUDH30C2p4b5zZo9rojaFqvs=;
 b=GiBJDeTyfIMkVN0d8Hn//CbhcilP0SN9q5eZDwR8MVnf6Q8uRZ4SD7z2s54ZfBg6DWVw3+LkZ87DZdxCYQ2bkYYS4NdSOrMQnw0wdz/QYnZvab8fhEu1k1ZZJ8R/ws9lixTAPaqJApr6ehcn6JrlVyV5wq+9uRm+KS6pOM0r5f9rg1Mm8s/L6Tw4ZWxn0BESxVAU+ZQkIGiiZYB/EJ9/Lpn3ENbWaQ42gqLACEFsdeq1Q67v5hcPrhOkxrvTnt7rSg/wzI+Xh9rV5Ew9TwWTFfP9dg6dLkIRZeFoNvvkYmYKvVlS+SWLJtaB1sFdxg7LOUFOPC6gJrab93yBZ6+7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Tue, 30 Jun
 2026 01:15:10 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0139.024; Tue, 30 Jun 2026 01:15:10 +0000
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
Subject: Re: [PATCH v20 1/3] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
Thread-Topic: [PATCH v20 1/3] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
Thread-Index: AQHdB5GS0UsRnwRSuU6o4dGjBcd/KbZVoM+AgACr1rA=
Date: Tue, 30 Jun 2026 01:15:09 +0000
Message-ID:
 <ZQ2PR01MB130775F6E674F6074A6E2CA9E6F72@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20260629063601.63917-1-hal.feng@starfivetech.com>
 <20260629063601.63917-2-hal.feng@starfivetech.com>
 <20260629-unedited-tarmac-b6eaaaced8fc@spud>
In-Reply-To: <20260629-unedited-tarmac-b6eaaaced8fc@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
x-ms-office365-filtering-correlation-id: fbe9158d-7b2a-41b5-7ceb-08ded6450779
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|3023799007|56012099006|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 OY7Vft++lAczGFEs4Km8Co9ISFGqS0G1ekatVZAR9qf7L0bjrI3UC0OsGirYaiAgyAvtSXUq1RhGa6thAL3oFvNK+BPOKjbmREs5w+L44QrBt/3JrF+P1kyoT58mi3N8XbdeohLWcB36c5HoGz+WrpbHUXSucrf12s6AZYtgcZNDXv9aIUjcFvcygGlkzWgPC/6aIVeoV8DqBy9QZg7xz/sU9z2sm/B69ntz9p4VXNg/tj8z2oD/fXyLrYSAiVnG6hVD6W8OLNfMFlXfIN1uGpRJuaSjFgAXuOoZT8kpvrR/rBXv7Nm3x1UgSle8VPZqdF8Kz2azjTu9hxqxVwB11gHN7S8P4L3ID2yj2Mv386/oEzLk3dQNVvBKADpCGyr6LS/Ah/n2y44eLoQROty5TOGUnT5Lb6tDzJpSYr6vAxA7PBKNM+lcHRvR9qiyrEa1/7WUEeSdA8WvEj2jF8+KwaY1z3rzKJpvldIi+cvmqoVql2d2KLM4u2eagBrf3lt1tNizGj768eolf9J9AiGrPCNjEs3htvio8vE7HxpX/kkoaNoKpfea+tl7c2+3xFRG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(3023799007)(56012099006)(4143699003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?J8miDtnPMSzZDV4W3LZxVYSN4a+92SIxoWLXX06xiFbWoE/T0caQx23+Ts?=
 =?iso-8859-1?Q?X0fnLlG5XNWV0fVoLgkkjVqzhcPGuEk8PV+EjsBeCNCdk5MfQ149Q+clt4?=
 =?iso-8859-1?Q?0mXvPLZqIrhWsTBvnw5PH3DcJSsjl2J27JAiFIIzHrROAFDWnwI0UnNxvK?=
 =?iso-8859-1?Q?aVDI9NwwgUsmxgh9M95j27y/fRznxRUOfqY06wymitXvHCOM/uZeFiBC5V?=
 =?iso-8859-1?Q?RZtz8Ixh9hsDoiePeTq8DTgntCL8QnvMOP+OHdLGk99BvMb3Z60M03/gW1?=
 =?iso-8859-1?Q?xsF/w4PvKIFGVc/Eegpajg5bW/IyddWMzvAnZO10T/YIHEpuv+Tqtr58VS?=
 =?iso-8859-1?Q?MTSwkJkxosF9ild6Asygb7Dot74w5wbmv0iQGa/6QkZar+xO71HlkuGKcQ?=
 =?iso-8859-1?Q?nJzzP2Keb+iRb+dAwiVGfZdNc2n/FwfAUCjIawFR3i4em/mTiqE2n0u9j8?=
 =?iso-8859-1?Q?MTTr5R9Ns5fjEqw4NpLdOwZytheqh00VPpwL1CqQX83f3cxuEt9Ec4fXMi?=
 =?iso-8859-1?Q?QcNzlmt0Z2qxgYsjYZ8LMXcsSyUVMUkW+lUfulD+EqL8WMoyBHElgYdHqZ?=
 =?iso-8859-1?Q?0BoJp6Y4sXsM1T4PM3FLGLGlxZ5HCOwV35b+ZvoF3KCIlsEINUCAIijkGY?=
 =?iso-8859-1?Q?M3bMdQw/Rg+Y5j1J2YHxMmACFSLgORORt0had8YXtyemwbtmj00pLqJqS/?=
 =?iso-8859-1?Q?DnCI6U7ZaMdGdPD8uozJxxehQa87Tm1B1rBUoEX/eR3u544AXqV1IVppOl?=
 =?iso-8859-1?Q?aIl8ovB1rE61gBRvJ7fq53O1ARxizfjwT8d/boDUsx0w5vB63anGTqW5/c?=
 =?iso-8859-1?Q?Dbmq1Qek0Iy/dd+om54ounXxWXEm5V1anfxDSoFlBHPt2/CSNYuPgVBes3?=
 =?iso-8859-1?Q?Zkmg41ngcczJl5AndlEJdsJTF6FHDZXBPPLzl/jrlWrsI9qrr/geasFDfA?=
 =?iso-8859-1?Q?Y/WxYjlRauYfvfs5iQyFBZPbXUr+MOnEavRWXA+Qi9ameJ5cVJrX4fnAcG?=
 =?iso-8859-1?Q?Jd1diWwArfCBNuj73d1kSDkPhGYLx9hmlTfyfDC9xwSQEOfOB5Q3pViW3J?=
 =?iso-8859-1?Q?1jN4pd07+6nNsiQ9JMnGTPZa9z4X4xnM9s7BlTMejGOwbRdd5CtZvz6HRn?=
 =?iso-8859-1?Q?xmhSmilsyrkD5oMppQznz4XUml5z9k2423h+mGyCRkjv2n4eo5sBoVB9F0?=
 =?iso-8859-1?Q?pnJDnpJL9sESdPCnctwIa0GVMxTMxaWxCiBCbw7hNa7zfX2fyoE8hRTgVA?=
 =?iso-8859-1?Q?kxZDK4zmGAWTUZXgdXJvRg5tJFpiG2+ktX6ETLDCVOV+8IGyeS2xWKmk/F?=
 =?iso-8859-1?Q?EImX+opaWyuJf2anQLGmytireDLpa/KBd3yAI6j9msdnuz8tYK3IvC0g/Y?=
 =?iso-8859-1?Q?YQokumQfHvhBUvjaZguLIsDRZdhudbG425pgN05cwKnBeRfsrQbGCL+ntZ?=
 =?iso-8859-1?Q?aWOWKJhAEW8duKUvm+K5B2Q+8Y8fsHzN5CGXYN6TCH/dSYssy1EGTspIZh?=
 =?iso-8859-1?Q?Vxzjim7iK3m/h6CyGctNl7NeMeLAVB71IPKP3c94XuCxYaHIjHdYG1BKYl?=
 =?iso-8859-1?Q?Z4Tx+j32WVDIVawMlaGJXvjWph/snBrpNbRVhStQSrjTA1CY8E38VrAjnY?=
 =?iso-8859-1?Q?aPcReYjN+FfkbtAF6SSFirDTzMsZxltzsgPip1X/iZhrYdmu9qVPG1XzCm?=
 =?iso-8859-1?Q?NiGBgHc6KCbDwSzUFwVJw0f9IxztwefMZh9fihIVyBP/cfkQn6YUAYmFg6?=
 =?iso-8859-1?Q?znJ79hA6Dy2vb4MRmlF5HgMsETCPG951ruGM5xUgmSNnZmMuAnCLBkhgbL?=
 =?iso-8859-1?Q?OyJqO7+GNw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe9158d-7b2a-41b5-7ceb-08ded6450779
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 01:15:09.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiROHd/orjY+W/kAR+WSgUwS0w9UK4vPSvLHcLd1kCQ2m5LATGmKX3ooCXlN3Fj3T1LbvGuZVpFpJc3Oan0SYx8iJAt5OdcYey36ftZ6NR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9481-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:conor@kernel.org,m:ukleinek@kernel.org,m:p.zabel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:emil.renner.berthing@canonical.com,m:palmer@dabbelt.com,m:pjw@kernel.org,m:aou@eecs.berkeley.edu,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 121116DFA36

> On 26.06.29 23:00, Conor Dooley wrote:
> On Mon, Jun 29, 2026 at 02:35:59PM +0800, Hal Feng wrote:
> > Remove the jh8100 compatible since the JH8100 SoC has been canceled
> > and will not be released. Add the jhb100 compatible to replace it.
> >
> > Change the register size in examples to 0x10, since an OpenCores PTC
> > IP has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.
>=20
> Actually, please also add a fixes tag to the original commit adding the b=
inding.

OK. Will add it in the next version. Thanks.

Best regards,
Hal

>=20
> Cheers,
> Conor.
>=20
> >
> > I will maintain this pwm module in place of William.
> >
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/opencores,pwm.yaml | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> > b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> > index 52a59d245cdb..42c5d2b6326d 100644
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
> > in PWM @@ -23,7 +23,7 @@ properties:
> >        - enum:
> >            - starfive,jh7100-pwm
> >            - starfive,jh7110-pwm
> > -          - starfive,jh8100-pwm
> > +          - starfive,jhb100-pwm
> >        - const: opencores,pwm-v1
> >
> >    reg:
> > @@ -49,7 +49,7 @@ examples:
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

