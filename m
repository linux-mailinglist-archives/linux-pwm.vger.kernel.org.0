Return-Path: <linux-pwm+bounces-9236-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H4AeNtkrIGqUyAAAu9opvQ
	(envelope-from <linux-pwm+bounces-9236-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 15:27:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BA763809C
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 15:27:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bp.renesas.com header.s=selector1 header.b=lK7a6r9r;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9236-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9236-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=renesas.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED8F23090888
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2026 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0B0480DD5;
	Wed,  3 Jun 2026 13:12:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0186480354;
	Wed,  3 Jun 2026 13:12:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492347; cv=fail; b=H4xaU41teD9+d2BJgkWTpZAzX2fhu/cWACCkWQBDQxUTj0MK59VFi/8L9wT6TzTdgv7B8UXcxqDAd0VqsGCnvb5C3bkzgFqLbX8WZROxuDH/wUnTYt287YjVy1is9889hknn+wVWlhvQra+KgMBKWyTG0gk5RVgxvvu4QsAtrSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492347; c=relaxed/simple;
	bh=o9dXTsbtqTlRTOr9Yc0jN1kFGClYXLzz5ORPV+8dAA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EpOvJiASiKci9FKn1F/USx6VUWgemjV5gHFFIYt15M8wn4LIcBCHbRZklNotfFOQJSdljh4bl3rYGzn+MIStSEDx9a8yAzF/O42s7MvtgV5edC1q8j6NAWbLtUouyWfO8Aeh00Jw5vj+i5Z2Jjw8TgvazBAH9ef4U6Y1VbQ5Tig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=lK7a6r9r; arc=fail smtp.client-ip=52.101.229.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUumuV+N/o067gdGg/s8OXGazsF4XvSTYwNPfg0pxeZlPDsisr24CERQyzUBV5RowJW9tnPuD6n3osyIRfxb7bAxg3+xsDAHiHZlvfFJGk6qvwwU1mX8HiT9N0TB3JUwMrHBi00+GXnxWnE4gMXxOLsF2NKQHkUfX3aEadO2urkY7K5hnDuiv53YRF/vvaZodf65K+DzrBnSXJ1gbzPFgPAkUTywc8S+PDnnq5U+gGlhABqKURaC9rEhE1V+N/lTFUxTa+Zwj/gf5vUz93UAFpzEGUa2rcYLRkAzXOEeYoQTWu2dJwkz1ReL1sW9qGtgR71NtQARY2345sDcbVHiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyHz1xxz2dKf0g/yjNELE+2s1CEAe1k2WkEHbnWjOjc=;
 b=gI7jl7c3IoySbvltp+RprC14NICNocxixnXvnBX9fvJSoh58wXIl8u+9iyQSDWabjC23I4FkwdFsJR6MBKhzyIfcgJ/6eSG/Twnui902KevaIwqbylgEmw9EwAY4utzf+zoC+rPoqe+gYGNxxWfI/KWK09K3XJroTIer8q7wIG7vT5PvfJC6HdBqNzmZCSfh+ykpewOAMLkVf+5wZeUOZj9ZyqFadL0JhIbKRYj9/wukw/Lt+e0dLyLbAlRhdOLELsx0ELYW3vXxTp9gLzBlxwCUDtxJdhPfxvksHbE8mFCgvyEWkNs8OPADSIQyd1oBTJR/OefDY8vv/Ohgsurpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyHz1xxz2dKf0g/yjNELE+2s1CEAe1k2WkEHbnWjOjc=;
 b=lK7a6r9rTc36xQqUE453+JNHrJgaWJrhnqE4iVAPSqZymkxB7uxla5bgf2Zd4TZQbnbs53xS1Qk7VRMKWn4J3ov7uQ2AkE2bjmDEqGW5vOiPBM4ce0NHXeQ+OUYd9VmvMSrpeFmIdhNXc9tnG3lznuesRpHcCcLgue5X9DuJNCw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB16258.jpnprd01.prod.outlook.com (2603:1096:604:3f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 13:12:23 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 13:12:20 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	biju.das.au <biju.das.au@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbacks
Thread-Topic: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbacks
Thread-Index: AQHc0LKQvlxtyV3slUeJAFuTBfcm3LXoPECAgAD3bICABLoNcIAkrWwAgBp4RzA=
Date: Wed, 3 Jun 2026 13:12:20 +0000
Message-ID:
 <TY3PR01MB113467B67CF05D80A5EE7E35D86132@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260420104332.153640-5-biju.das.jz@bp.renesas.com>
 <TYRPR01MB156193428AFA2FE631556EEDA852F2@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <aec2GeV_aP6rOtFg@monoceros>
 <TY3PR01MB11346D2A5AD3D030E806594CF862B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <agnynFUowrOA6oqH@monoceros>
In-Reply-To: <agnynFUowrOA6oqH@monoceros>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB16258:EE_
x-ms-office365-filtering-correlation-id: d74e5855-4735-4530-2eca-08dec171be6e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info:
 qbjyH/lzrDVrt7BWztFVbqxshwUs1zn1yCcZmTFvrDSsuWy6Zxw8MLoPINUFP1endnEyyseZseiMopEZuEPzkSdc7gISk95iMfgkyyIEIXCY1yaAu9ZQ9BKCMNz3NBZHXMBQQlMWFMU9aZFSXVyA+BwRlQGM0YdpjjSbina38WZjH3dEgc0LXe5uEqyx+pOP1hWK5EAI1Hk8mdrlsfbGAnQx5BTa6CkS0rUxMO5y9VCjoYeW0v5sKDvAtR3TaAZjqERzqyhihabcjTBvQ9cWAjFiAtN9+t8aCVPyRIO5xVKbrKdxXh0o4pdTkdypo3bhL+Z2jmVuYkhDJPE/TUQJaN7pDhmgvfZWMqBAkZumDasaulfm1BWx+R8Hcsg8LMOu66SEYKVhPooe3r7DdtXCUfeYA1AK/a019twuvOqZHTu01NdncYdiSmeAOzwOqFaMzbn2J/MKo+kEalQ0OWZl779P6MvrzQ4gNsdQtAduZ7xzZMpMnTQaeStFdBxyZaFFfU724SQAg/uAE6hZ/an9i1H+AvmfFOhDKxleEv6/6oIGe1/KUGbJwNowmZKbqHdNIlI7iIRC2dWGqFvH2AfBWuIwvy9k4eOxLMC8n+DGWQUrXfwf757VANud+jVxZaO2WdmMAau+ZXUfjRpbQ6pmeBn/Un3BQcGaj6AjvgsvTc8+k0bkrMj7vhxAA+wrenmxZ+1F1cK6/y3HaxuKFVh6gN4He5Tz/FZVIveP7fVoxLq5c19tJlgttwJ+PGv96glL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FT0FEVkwaGWcAUrcrszVDz/dHtpbIJ12kctLYqKHK5yM1NE0I+0V5ARKfK?=
 =?iso-8859-1?Q?naXkBBOd4nnOcllQbOq0PYIAtk+TnpmjQBHXHkBrLpFHyoTr8d17lQgq5o?=
 =?iso-8859-1?Q?PM62vurMdlLPm86+dDInunx2uem5xhpP2LLLnIfZvSuEj7u3xdTYzpZNeO?=
 =?iso-8859-1?Q?SmTZZUbuzBQGZqfvtMCyK0Eq2aRsNgMpKKL/iqXqtKVJxZEGu272MKDPOd?=
 =?iso-8859-1?Q?2uwGHXILpH4HGnCd3011hxXsCdpVeHUw+nLXg9+c0rn44nnkgIICpWjoIh?=
 =?iso-8859-1?Q?1iKUt91qNKb0uwcecc6tRkx+bijMcGV/1LmSI/My7cvIg372tpVMi76osY?=
 =?iso-8859-1?Q?X3WgS0ke6oXPKlbdMz5PrZGdBhxNnCkvd6mEKwNT8tPWDWp7OGrIsiW588?=
 =?iso-8859-1?Q?ZoGNHxjLzd809xd/JuX40LW14VLGxHsqPyEpo5EEwBzenz7w70xrxdn6JR?=
 =?iso-8859-1?Q?NcjLimdzrdQ3vg+BQvmSVWcCEna1XXlG+5Rdene7o4IzQx4CtW8ZWgdMto?=
 =?iso-8859-1?Q?mPMZ1AiUdcOrSJZwDG1g4Hm0576p43LCJrhDd0m/y8E9K6va7ZIygzmYo+?=
 =?iso-8859-1?Q?XYelcE77P6HeQeGwIiBmoohZjzhgKKZ1vYeSTslo8PKTNw0G+RV5a5zSR5?=
 =?iso-8859-1?Q?S9PIEwE27kbp6lDt51SZ2uUgLOh/3/4z1/lN6SfOGEgSewtcciNsIDuQC5?=
 =?iso-8859-1?Q?+XQaGbpf3pA9Uca6Q5lsL04Dpuf/ysnyBFVb9EPte4lmjt/atCJLWFCdM9?=
 =?iso-8859-1?Q?lVjeGSunTn+8VzVJ+RozRPvbJhmvpoJDXWXPSKdw8btsjmJU2/ty8y0gn6?=
 =?iso-8859-1?Q?fH9EIDelXceUVGEiAzkwGVPPproBm6UASmgXMgSIy9817Lho7hgYMFCO9s?=
 =?iso-8859-1?Q?is+dHNptDPEdvfZBS3WIcbBAtxEGiRIpxR9Ic2IECqOhnVGdKyr04RhRrF?=
 =?iso-8859-1?Q?G8x7tft4wEPhlhs4m0RdzOdEoPK9NXR+qBZYyFxfY8tCzRpepgW70kszEx?=
 =?iso-8859-1?Q?RGInwAauCjCJmL7hDTM4GG0MYXSTnS8AZWJaEP3UgLpbf8rqAkD48AGtqn?=
 =?iso-8859-1?Q?HWWFDq2+LzNqO6yI+RQM48iYmtQareTOgnaXhgqUxTGgkCEOA+E8GkMvUP?=
 =?iso-8859-1?Q?3CeOqwjGn/8WeIvVD8ox9+tfOHXMIONSU076W/cn8MCrkdxWJUZscYb2vO?=
 =?iso-8859-1?Q?hRYMl5vFWxIiSuEhSirGBcqnVM57VUV44M86h9jJMusX2bkVarAXkK507g?=
 =?iso-8859-1?Q?W1Cve+UFTJDUPtXU1M8RnZ5nWSfTo683wy1tGwEeraedF5u3ocpNlIWt68?=
 =?iso-8859-1?Q?eQ4C9ntFjsgn0zPobEFERwUJYw6rdcVRfJxm7pphBs5/aOR7cbmvlDYw0E?=
 =?iso-8859-1?Q?KgMFK1IcxZR6PHsFGfUfIxRwne9jPt9xYdNuz4Q/gsyNNS6kIfck7EBbgg?=
 =?iso-8859-1?Q?0lgz/9WizDBfDmYTJ3zxbz8yBzLKXwfWzMb4+hNdUgHA43BDOt7stySIhl?=
 =?iso-8859-1?Q?9J296v1uC6RjLKMIovqySOlI3dOtnQJdYIBC4ghIrdVFXvjjvZBiGE3nyg?=
 =?iso-8859-1?Q?o1eORUNVQYwR0vWy0Ba0kgoHX25I3jVKR5ZhIZfdl08p9ThEemKvuLL2GZ?=
 =?iso-8859-1?Q?DpDA/1E/tHk+6aiuFwvHrBWLE1myfgahhm6R9kPG0MqnVXqr78s/F6bF4+?=
 =?iso-8859-1?Q?PUURRdGixUsyIpDATllYPeHYFlFeOj2BAQlFXl65KrQO4LV55ws3c1/qJt?=
 =?iso-8859-1?Q?LRJ3CuUNsU1624SLJASX6G3yJsibplZ19X28LUseXbRlTzKQ07UFmkaFNg?=
 =?iso-8859-1?Q?rd1SMnPNrw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d74e5855-4735-4530-2eca-08dec171be6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 13:12:20.2903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3igGYSPM4a+0JOS0GCajtKOREuL/nsMReWCMGnEA0FvSh5qycBNtdfF85ZDN6vtZBSk3T2piqVJ2qZ7Kq2vDP2NHcklBFTC2int5eEQr7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16258
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9236-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:cosmin-gabriel.tanislav.xa@renesas.com,m:biju.das.au@gmail.com,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:geert+renesas@glider.be,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:linux-renesas-soc@vger.kernel.org,m:bijudasau@gmail.com,m:geert@glider.be,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[biju.das.jz@bp.renesas.com,linux-pwm@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[renesas.com,gmail.com,vger.kernel.org,glider.be,bp.renesas.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:from_mime,bp.renesas.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32BA763809C

Hello Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 17 May 2026 17:58
> Subject: Re: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbacks
>=20
> Hello Biju,
>=20
> On Fri, Apr 24, 2026 at 09:01:51AM +0000, Biju Das wrote:
> > > -----Original Message-----
> > > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > > Sent: 21 April 2026 09:41
> > > Subject: Re: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform
> > > callbacks
> > >
> > > On Mon, Apr 20, 2026 at 05:55:07PM +0000, Cosmin-Gabriel Tanislav wro=
te:
> > > > > @@ -291,21 +286,26 @@ static int rzg2l_gpt_config(struct pwm_chip=
 *chip, struct pwm_device
> *pwm,
> > > > >  	if (rzg2l_gpt->channel_request_count[ch] > 1) {
> > > > >  		u8 sibling_ch =3D rzg2l_gpt_sibling(pwm->hwpwm);
> > > > >
> > > > > -		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
> > > > > +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch, NULL)) {
> > > > >  			if (period_ticks < rzg2l_gpt->period_ticks[ch])
> > > > > -				return -EBUSY;
> > > > > +				is_small_second_period =3D true;
> > > > >
> > > > >  			period_ticks =3D rzg2l_gpt->period_ticks[ch];
> > > > >  		}
> > > > >  	}
> > > > >
> > > > > -	prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> > > > > -	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> > > > > +	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> > > > > +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescal=
e);
> > > > > +	wfhw->gtpr =3D pv;
> > > > > +	wfhw->gtccr =3D 0;
> > > > > +	if (is_small_second_period)
> > > > > +		return 1;
> > > > >
> > > > > -	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt=
->rate_khz, USEC_PER_SEC);
> > > > > -	if (duty_ticks > period_ticks)
> > > > > -		duty_ticks =3D period_ticks;
> > > > > -	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
> > > > > +	duty_ticks =3D mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gp=
t->rate_khz, USEC_PER_SEC);
> > > > > +	if (duty_ticks > RZG2L_MAX_TICKS)
> > > > > +		duty_ticks =3D RZG2L_MAX_TICKS;
> > > >
> > > > I know this change from > period_ticks to > RZG2L_MAX_TICKS has
> > > > been suggested by you, Uwe, but is this correct if period_ticks
> > > > was set to a smaller value in the earlier sibling channel condition=
?
> > >
> > > Indeed this is irritating. I assume I missed that and take the blame =
for the wrong suggestions.
> > > Depending on how hardware copes with such a configuration it might
> > > be ok to keep the code as is, but a comment would be justified in thi=
s case.
> >
> > Please confirm
> >
> >  /*
> >   * duty_ticks were clampled to match either period_ticks of this
>=20
> I think it's "clamped"
>=20
> >   * channel or an active sibling channel's period_ticks.
> >   */
> > if (duty_ticks > period_ticks)
> > 	duty_ticks =3D period_ticks;
>=20
> I think the comment is not needed in this case. (I only wanted a comment =
if the comparison against
> RZG2L_MAX_TICKS was kept.)

OK will drop the comment.

>=20
> > > > >  	/*
> > > > >  	 * GPT counter is shared by multiple channels, we cache the
> > > > > period ticks @@ -314,6 +314,61 @@ static int
> > > > > rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device
> > > *pwm,
> > > > >  	 */
> > > > >  	rzg2l_gpt->period_ticks[ch] =3D period_ticks;
> > > > >
> > > >
> > > > This should be part of rzg2l_gpt_write_waveform().
> >
> > Also, if we move this to rzg2l_gpt_write_waveform() there is a
> > rounding error possible as we need to use hardware register to
> > calculate rzg2l_gpt->period_ticks[ch].
> >
> > Can you please confirm, is it ok for you?
>=20
> I don't understand that. Why is there a rounding error possible? The rele=
vant thing here is that a
> call to the two rounding callbacks is not supposed to change internal sta=
te of the driver or even the
> hardware.

OK, will move assigning rzg2l_gpt->period_ticks[ch] =3D period_ticks;
to rzg2l_gpt_write_waveform().

Cheers,
Biju

