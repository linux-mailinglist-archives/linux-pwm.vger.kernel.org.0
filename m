Return-Path: <linux-pwm+bounces-8631-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNDONA9b4mn65AAAu9opvQ
	(envelope-from <linux-pwm+bounces-8631-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 18:08:47 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5612041CEDD
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 18:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEC913068D7D
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 16:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C6F314A95;
	Fri, 17 Apr 2026 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="QYW0QhEq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010049.outbound.protection.outlook.com [52.101.228.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34209257423;
	Fri, 17 Apr 2026 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442041; cv=fail; b=Tzvq5wbvRjxBTL6GZ3Rh/sxYn6yvi+9+jjOL2Nj7H5c/9yJxwtoxmgWBKFGvDpOkq1jrh4NBSDdbRS96YqGp8bUafednCyK75EZ7+33SP5mz0inCtUM9Ty4dzRYGgPLqmrHcS06y5p22KWH6fv2TTaNio38i6VyuskpdJAljxrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442041; c=relaxed/simple;
	bh=8Oe109SH3ahGCZDdQnqzdlh3L6Fep3YzrqQH6dpUTKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JPH97OXIi++pMcbnJUKDoTvucKM7wJXFihcq374/cZVFKMbRB6IfCodAxF4tSQANc+MixUTVEWh1W44kV7cnuAwkA497nLoT06BR9+2Iss736BqCceAW+nZQkPE0tzUconlw+lIyCRcghv1AxejbIDnngLbFiO+5TyWceZW4Fwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=QYW0QhEq; arc=fail smtp.client-ip=52.101.228.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sN3coS8sEzXi93pGgjaIqduMH94hGRG+otAY8PmvWgQ+6P73wwEX8s3Q7D2U5nzQVkP+AvzpZoSwSMNEaa3ioxhpd+u3h5gYXjYPiMdYMMRbY8BJtAvavg3tOlCD8zoTRHYw7ev7gF862+IHihTryeeqK7/m0hqHAb73K7/bH0uDQcyJTKh+jlcnM13hTk2pgzf7zasySSTRzdrx3TbCKZdj4w3dXkHfl1+vC1uv/1ixOIZQ2/gc3lrnDH+PC0MdFKTHfuzWzs8pk6dW4yjm9TodxgujZ0TzLquuZQZqhCgurTLwuPdOhUV1s10pOIjRs3wJKBfG+eoqkhWTzYsI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Oe109SH3ahGCZDdQnqzdlh3L6Fep3YzrqQH6dpUTKA=;
 b=SpUsC3ekh1KpjgCMwDjmjgu3WrQKZkcQjdVtox7Towu5SSPemg76KCoIuq+TOOsybKY0kEnAxyLALc9gmjC2UOYeGh/f3OqtpsFrdUBP1Bv7Y/A7hAHf9LoL3/9ztRyPvnbZDGtYsmpjq0L4aTadjCir9+1O+zKctvUsGTVPw5+xgMOn+0m2NJkQqvuy6kLB1fK9axSFtzIgGrEr4myu+Kerju3+KKRTrlp7G6D0ZfMl/YUA0qg/xxzKHzRbcs81DT95Py6lnHQKM5YkpQSfeDukfcCiQ4PbXcPKwl0YRq9c4fYFMY2PlMvxRsuWKqF6L8C97GLuo2SKrsT/cQDtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Oe109SH3ahGCZDdQnqzdlh3L6Fep3YzrqQH6dpUTKA=;
 b=QYW0QhEq7xQI3zCYG+S9R2g7qw5VS7bJw33HJLvZypVuIaB9NQL7Eq8oLMFRW+OnXU3vw5jJw+NRYFrkYsS+bckPZ84d1EnrJo/zUUmAbA+wAHaQkaIZROl8NSBlQWHwMnQg4gimK1pmuHO/ujWQUe0B6wm44HAE+WV1b5jsMlE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB13063.jpnprd01.prod.outlook.com (2603:1096:604:32d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 16:07:16 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 16:07:15 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij
	<linus.walleij@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	magnus.damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v8 00/15] Add RZ/G2L POEG support
Thread-Topic: [PATCH v8 00/15] Add RZ/G2L POEG support
Thread-Index: AQHcWwEhnVWMwbMGjEyEA/7VAmE5eLXkSb2AgAAH7RA=
Date: Fri, 17 Apr 2026 16:07:15 +0000
Message-ID:
 <TY3PR01MB1134647D998E423EC868C234986202@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
 <aeJS4gjplQ8KNIhb@monoceros>
In-Reply-To: <aeJS4gjplQ8KNIhb@monoceros>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB13063:EE_
x-ms-office365-filtering-correlation-id: 2beff42b-06b7-4281-7157-08de9c9b6470
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|18096099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 eCejNcqwLrO9CEx3HK8rkj2lYmQ3tjPAxnGF/ayHVT8blsBxSflacbyQGpd1z6nQ6kbHrjyMJAcHh4SUBnAh8Mx5afomAPh7xKO5FrnTL3+ztGSZMXC27s5ac/oNZ7L14A1SV3AY8FdDwd+MvK7dJlpcU3rH7cqwqbW1sPcqG4XTcEsUwsuaSzvXkPcjy0KZSNvGPpFu//TH4h0iKtzQBdGwdklsap8HFnhp9XWW5QfDAHceiVIt7lh9koB+QRV+FNyoptxY4cZpVLtH+GAM6o8x/gTLYfaBNgPTLeLd8pUIemfJjLVpI6K+18w1IDcE1iNyaYyfbLf8DGWvB+kzL4wbXM0mBltt+a+3mlmUrQ1noWlonyDx18TG+b5Q0jfGsPlgokm04nu6keCGfmyEmPR79P73hSrJfMTqY+zUYVu9Utb/bvhgJAZf9nZVMfQbJ7bo3EKk++yYtmHWKRC9mxYMINDdDLj3jGAqTVgEneqw5gEL7dlGGCCe2c5saWxpDaDzZNAxMOdvjfv1vyQHSxDVoEtOBBcazPy2AawhJeyrjzj3VfSEk+eqBZdMOblhDRXtGBkMj46wQV0xhk/uyqAl6hOamHF6YKf12McGiGkklZIr6nWp/QBTb7kKpixRAH+zSC+W+2p9lqL7akoUflKi22YvxH1IWtJjWQI6Wqy+XK+1/5WymfA4t38K5o55chMUhxAKvoCjM4Y4Wvhji+bCdIWu769X6O16bWQtcknkWXpFMQSqyZ+EkDeyZ7zTqly7pPGbXazOVUzyi7u60xJzQaN6ufGVDzzeqrf2mRE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(18096099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mWSgAKMS/hYWaLG5BCz6e9u7aIiAXHuU7HqbwmrpeleyWmkgO0hnTqX9Pd?=
 =?iso-8859-1?Q?T/KwsBxp0708SHzvirhzH1WvRkWEXg2lpmOj+bta/7aIhf9TqgFh8EXoDx?=
 =?iso-8859-1?Q?dH/ljjU6pBfivogDqqN/XcEbF2WnbflyZE08Sze6cM6/CGeiLhM4uxSQbF?=
 =?iso-8859-1?Q?jxtCzFxaUEWnd9sgMMNXbZ6L0N0o6nC2GAOCKFGntIzPth9/FOqejQc2RW?=
 =?iso-8859-1?Q?O81xqDuLAk45VFIOLwR8qd8dHP90Erxfbvwx3fctKRBZcUDdezs99QpRqF?=
 =?iso-8859-1?Q?JLzmaey2K+18tN5uBzxx1wscAW1YGdwJv/Lp3a/Zgst/2OfutXP0/qfMzu?=
 =?iso-8859-1?Q?pb9A42virXZpZmXFXTZjo8Ve6EPe819MghWlN1Mfqf2zMo2BRtw6fTtD2z?=
 =?iso-8859-1?Q?lGKm6+3iuUzRsvM6h54vVprZQP//j5KZdx27oSMZHm8rUPr6qmLyo1S9yU?=
 =?iso-8859-1?Q?DdvyzugF//eLjUxtWX9ZPC9ypDJPLggCocDiB3PKLnk80TgOz/MRrKk6FI?=
 =?iso-8859-1?Q?Tq9vJjZJGNmnTI15FXgFlBGepQTMPl7zAmH2zlBTBeCHV+uroNSrQDOCL0?=
 =?iso-8859-1?Q?DfYHjT2mTnhKeNBHT49E5h7t9OvADJ9Mf8AsfffLxczZQcd4j5ernCt+uc?=
 =?iso-8859-1?Q?ldTJOXfu+aCpR0R/WEj1/YIWvI5ibW/DcSboUHPuAXOTCkmnvQj5bkxDP9?=
 =?iso-8859-1?Q?9WV8HG6k3Y4P6LNdD+5Umsf00Hc3DRdoj7D5RQuVmv6COUk/0en5w3ASz5?=
 =?iso-8859-1?Q?6nYba/kxmoLQ3UH6rs3cZuI8Tyy10NL5ZMoB9BvPYhPp5NQuETghlTUNqB?=
 =?iso-8859-1?Q?1oWmUiWpyP3S4azsw9BbuePLMTYBys1CKPll81vG+ZpMJzp9to+vjhkMdt?=
 =?iso-8859-1?Q?q2ZsgFuKdupjHwqyyQQghpWrvvahj/306V4GyYt6B5iCsFiBIkGKIjZyQo?=
 =?iso-8859-1?Q?iP01xP4Cwi8XZSP5c8nfIVOf4TLNsL//x6jMLYNvWwa3IbCbTK0xfPZFvd?=
 =?iso-8859-1?Q?NchYg5Zql7vwfpGHcunHzIMe2HYPjd1+gB2Pa80ddcnXolOk78f0ulzO/h?=
 =?iso-8859-1?Q?hdPWgPNW84gABpOGbIow8gTdfeqmOONZqu4t8q5ksWf1NdButJR25cxK3v?=
 =?iso-8859-1?Q?ZHWhUSjWV5hd4ZuukUP21G/TkinTljF2K9IwjofJaQo0nywuTSrG4ktS4F?=
 =?iso-8859-1?Q?wp7YifGyWTJejXa0sa6tpM3Ci8EiZTGJpqKMT4Q+SSLy2q5fhdFbkn8y5e?=
 =?iso-8859-1?Q?pKA2FiwVAtvFEH6YtohnGF8WyGBwzw6eCiwiP2okHg0i0soEGE6G/UzJWV?=
 =?iso-8859-1?Q?PJYNr6C9K1OkUJBJoAzURVQuUArdp12E3F2Qog1cHokVv/WwlQB9UoFQkI?=
 =?iso-8859-1?Q?HffEO6HWlTIxAq0txoL+N7aGIbScBsiU9UxiKUPI/5fumq+C7xJEFiNaR+?=
 =?iso-8859-1?Q?1juckRTwgIeXgDbTxbYuNcBSfKInOaRtQwoppoNn3V9bmlnwnx/U77cvrn?=
 =?iso-8859-1?Q?pVlsOamgTKxYiaT4KHdsxK0PIS+NsOKVFw4dmeWlTJCBXrRGU68A2B5q/s?=
 =?iso-8859-1?Q?K7GrkgpXHvc6zlScgaoLVLO7Aju4pGq3TxXDGWmQXuDd5FHCgzUJSxKF9M?=
 =?iso-8859-1?Q?/SyUJ9/XjExHPpp0RKM5Wlp/IK/jvrdY5mImdiUuyyW3YHRVXzaWm2xqkN?=
 =?iso-8859-1?Q?tdehktL6JlbZAnQV0fUpLr//9E9yvE7vrV0cwjNKTaHrDZNdZ/Kamuo0hB?=
 =?iso-8859-1?Q?Uy+3lL28hcbYdpTWxZnikdGOClp3K5HIfVXRFpA8B8OGF3jIcJkXQhAu7J?=
 =?iso-8859-1?Q?UXA3kv6WqQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2beff42b-06b7-4281-7157-08de9c9b6470
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 16:07:15.1740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThE2WIO26KrmNSAkXhFfaGj6fTnDe9Dkl0C3av/Egu7snmQvVgJcBL+eWhlmmgNIcpsvQx9iRAC0jnXcTM8AUwpED+RTOiDsankUUmEoij4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13063
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8631-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[glider.be,linaro.org,pengutronix.de,gmail.com,vger.kernel.org,bp.renesas.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5612041CEDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 17 April 2026 16:36
> Subject: Re: [PATCH v8 00/15] Add RZ/G2L POEG support
>=20
> Hello Biju,
>=20
> there are currently two series by you open touching the same driver (this=
 series and "[PATCH v4 0/9]
> Add RZ/G3E GPT support"). Would you please make it easier for me and crea=
te a single series containing
> everything that you still want to get in? (Or if one of the series became=
 irrelevant, that would also
> be actable for me.)

OK, will create a single series for PWM specific patches to make it easier.

Cheers,
Biju

