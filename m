Return-Path: <linux-pwm+bounces-7665-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D063DC7DE9E
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 10:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EC974E035B
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234F2206B1;
	Sun, 23 Nov 2025 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Wsp7S2Zb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010001.outbound.protection.outlook.com [52.101.229.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F45686347;
	Sun, 23 Nov 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763889482; cv=fail; b=af9zIYTsMcb9UhULOljuq74Sl9HnmO4iXh4R4FsazJjNi1XsCngUyi2xONCEMIsUirRWTY1tR6p/ndVQdNxQbxO4gPPIMWkFrQCmXf0yVMsZBRmiblcffr/kpQFW/DLmv9tMikF60+wd7BFqZxPt7ofwKVCGULU7GCGiuiEsk0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763889482; c=relaxed/simple;
	bh=AISagg4PE6BOUS7e86t93f1OwW1eRJF6WzHHk8mVOHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sX7+JAPU8Ya68P6z6qhHKMvpFE2Ew8wWQVhUlKD+xB+HK57UtalGAlENluHIkTBWYEPXHbhncCxDC0Of16Lc+kpyx5pW2Hy06KFdyDvFLmXY49z0OuIRSx3/BTh+gFCKn4Qsxvv5QOyrHl4TKqB4VIUFAmjZmWXcnNtXfriG3iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Wsp7S2Zb; arc=fail smtp.client-ip=52.101.229.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT8LxJf+KeFMMuDTb5iU4piPpQ7hJq0P8dy2BzESMRZQG1hxPotiv7OsxRkF+BfiouQAyA63JtqlawsQTFuBVUOMZn6Aqx7Sdvn/ztz9tqX1T6auAo3TfIjEJpfAoUYl5020lsYcGNMRq7ZesSN1HxGHPu9DkERPn0Vj7e6TfJnv/VvIEqTy1VNHrIKsmHi56B0lsJKzsRlExjbxNTnN0hWCVFVakLd0bm30erq8m5APglFQdVpx2X22YTtZNWqey5urOFTP9iODV2YtR6I0bTXlXviV7t8Ks4vwdOjqZsYJq2SqvaN1DLeAAkAzoE0NnjONe4VAktKRElfi8CS2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KyU/Ut/sUR5QNqHkq8wnVkB+nK91rnesm75/kUIvcs=;
 b=FaS2JY0tvE2b7vDQnVUmjytwWu1PnhmXzNOoEBjngFFvhNA+xd5Rj9N4gwXvE+R4YpwSaeXQQnAiFb+mD04dc41DhSvdQnzRuFq5Nh1WKPw2dvnOVPhaD9HmFB4vKVObGMDONQQzRkCRWhoYGRjvGd+Xrvy9+P0/IXwa+KdkhQJ9wo8MqFhWlu5yWUttTWB90fFzaAcW6qSCxrY6vamO+cwGZQ3ZJTzD1nbKPVYR2dBu3tbuCSM/jERmAnJaIxkSI6Cr2wQ0+t42ek6xpbWEesLKD8VIHfy0krl9gUR0QmcBXiVR7GHu8bM0EORw/KZ+B6FLzVNMUsieN558duWzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KyU/Ut/sUR5QNqHkq8wnVkB+nK91rnesm75/kUIvcs=;
 b=Wsp7S2Zb8ydbRd6WGJOjmpSVBGrIEjf9nI4Xb+PynziMT7thIJWcU89ni18+krCbS4yW/MN/zcF6J+FedilEZdFWZbDPrfuPZzfuuUMjidehqxvrBBy5WSyezU42oOCms1nruo8+K5w2VOXlgfwnxizghKJhKNN9aume4yA0tp4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8399.jpnprd01.prod.outlook.com (2603:1096:604:192::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.6; Sun, 23 Nov
 2025 09:17:56 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9366.007; Sun, 23 Nov 2025
 09:17:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: kernel test robot <lkp@intel.com>, biju.das.au <biju.das.au@gmail.com>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Prabhakar Mahadev
 Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [DO NOT APPLY PATCH v8 14/15] pinctrl: renesas: rzg2l-poeg:
 output-disable request from GPT on dead time error
Thread-Topic: [DO NOT APPLY PATCH v8 14/15] pinctrl: renesas: rzg2l-poeg:
 output-disable request from GPT on dead time error
Thread-Index: AQHcWwElHf1lr0i+u06Xej1sFEoojLT/0CmAgAAta+A=
Date: Sun, 23 Nov 2025 09:17:56 +0000
Message-ID:
 <TY3PR01MB113460F91E01D30F4F6E9F96D86D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251121160842.371922-15-biju.das.jz@bp.renesas.com>
 <202511231456.D6amN8I5-lkp@intel.com>
In-Reply-To: <202511231456.D6amN8I5-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8399:EE_
x-ms-office365-filtering-correlation-id: e489a65d-7034-4cd1-4322-08de2a713041
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?uxs330Ns/JlETVT6pa0LxVnWVgAcStSevFlPVqK5iURPVpVi7mRN/PYGLx?=
 =?iso-8859-1?Q?VUCg0RCxDEqF+grZTYhIvJpjTwFCx9FLaGqIKL7TkvSxTNJkHEVJJ9693/?=
 =?iso-8859-1?Q?Bs7lhw2s8kojoV3AqgrIqS6eNiX/5sziuE/Xq+1uSiSl7fntvwZVyPtY/W?=
 =?iso-8859-1?Q?i3NnBSlEzA70hQwRyaF9YhUtBGXeEVry4mso0omil99y4MbGqOfVNy7H7s?=
 =?iso-8859-1?Q?8yIsxz+M1tD6EZgaF0X7oPopHFsKFeqD7UDo5sq/FJM6P6ZbGboX7oNOvy?=
 =?iso-8859-1?Q?VlgFQ1MXUxBZfs7YjjsI0JwwwAe/UI4tYNaj4l4TcfnQ+bawLs3d8mtsA2?=
 =?iso-8859-1?Q?stwXNjMHyGLY7gj3bmTuHUWINqw0aNLkxouBSQAaRNsWRAuZ/aLf2qqiWm?=
 =?iso-8859-1?Q?etQ65Qu5gdO7Ekbayai8ICQOx6e2Ak4br9gU1ezHCDLzQMFfSBqLBK2GWK?=
 =?iso-8859-1?Q?QYr+iOKmxfV5irsDFwnKrbN4aKTOiIQ1M6a7uSy540xtZ6eXllt7lLmK76?=
 =?iso-8859-1?Q?fLb/ljFjyXipOvKoXlVzWSXlJKThFmUKK7Wrb5JC6K08XR1m21TcgkuSju?=
 =?iso-8859-1?Q?7QQZJbJDTY3vYHZs5HB9PMUYzDc3JDqvYY+C63V1ZwRj0nG3F93fmCoAqY?=
 =?iso-8859-1?Q?OXQkQDElBxZewIiwJooLyDpTV4Ov1zQzSN1PLFcASC9mqFbPRf8SFipMCt?=
 =?iso-8859-1?Q?gFS9x7mqbwxgCVsxhY9/VeLylDAxYSbI31dS7wdppKshwHXw/VQutPm69t?=
 =?iso-8859-1?Q?Ua4mtgw1Bel+M0YX1QSnh1veqpUEqkLZ2BAK2gf6/DJ6NeqoY4V+C6VcIY?=
 =?iso-8859-1?Q?JiKN31T+20csngWMMGdxgFz/WfOkY5YyWdwvkLaHs35WBfgeXMo3+jkMfG?=
 =?iso-8859-1?Q?5GFM2qk+dLZIQHMA2B9Uy0fTD/iZFbnhGsZfnM21+QAqbEsXD1xyhofPcJ?=
 =?iso-8859-1?Q?mThQPJ2jPn/QfD/OwsVPEm1QQMxDHymJBG04WRm8DJsThdx88iRXC7fF6q?=
 =?iso-8859-1?Q?jhQH+FUSgi/bnu0/6uD72oTlGke9lB8K50T2tiOn2NOzePgejAQAgOaTal?=
 =?iso-8859-1?Q?fvKw7006P1YUafaoxQDWkRhC8eeuw8Rncz/JLHgmqUb8kH7bU5lGm24Hd5?=
 =?iso-8859-1?Q?68ColkOnNZsDNE0TaXiUpTMrX4mcl933fJX+MNerdwBt6c+mfbQqCZ3Olw?=
 =?iso-8859-1?Q?J2JoQpcavxFCr404e4vm4O8ni92iTsimaRFqKWvGVmkrt5x6di1dzVqR2O?=
 =?iso-8859-1?Q?37wTfVXEIxLS8/Ftjg3c4j4cL9eOBPyTd1q9NxvkTfOxyRwhCBTmPRy8gC?=
 =?iso-8859-1?Q?T0YxTN63jFO+Zg9R5zrrRQd+lF13WSFw+a9AZhMsSp6vVKdeKQuJpKrp/K?=
 =?iso-8859-1?Q?ZYqxzBr90fSU7KKCSYwSt5EYZNoHfu02NC5444jkC6+N2eCi3xGPLGRpBw?=
 =?iso-8859-1?Q?L2Hvk0wQvu2NUjYtboaNZ3jTZx8XOLBxBdGxG78vdr3ptoNuA7hxYjWgxn?=
 =?iso-8859-1?Q?KwLO0QEfj0nF28ZHvBWmKy5iaRbSj8vaSJHGU/TsZZK8aD33BaF7GCfJRX?=
 =?iso-8859-1?Q?2V/XcFRGj2kWt7QRsXHTTGVS9AdI4M56VW8QKcF2kXhcaZ1bfw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wnxOygFWuDl8+yb3yqoYjikMLGF0+K5NKl1n2vz+eRgrdn2I5eWeGsyMnL?=
 =?iso-8859-1?Q?J0fl2zBT+qtIfE7HcQFOjnkw6ZhaVTjdhQVv10OKZ9He+bRLy9mPQ1Sj47?=
 =?iso-8859-1?Q?kUMSZL0vaQZaSX+au2t4c11aHWxswRuOxSLcq+rchahrflPsdLa8Yp0hFZ?=
 =?iso-8859-1?Q?bMCTL3/0IjJ8ZUwCKtGg29muelBcY9+7bzdBcy3uNocUe6m/ZDO7iZ0Mhr?=
 =?iso-8859-1?Q?wDpQwOlw4PwIdyy8Nd5Hp6LUIJnqOGFYrWk5t/0Wp/X8E9v3tbWmQXUR/P?=
 =?iso-8859-1?Q?tbjLPNmVN4HMF5CaEHvs277v2Te2yGrds7vv0gQOBu268s6MC+m2RbpOLj?=
 =?iso-8859-1?Q?eZhlPxR0E6LzE1lWBGRRZAzsqUgJPxGydKU9bh1PG+11qfOF00aXEfz/zK?=
 =?iso-8859-1?Q?M7aV03gkuX1PzTFMKNtW2dHPgwB1c7uarpagyu0yTsA/WmBHfun3T0XN1h?=
 =?iso-8859-1?Q?sBCaEymh8o+NNK0QR4pdZcazGVKoqGghjM4nlwge+FSRznDlpDoR6hTsAR?=
 =?iso-8859-1?Q?sHAED8N95/c6NaaPDAOb5gDI7IFoFgBhEpN8sB9eTUwq8P/G+c9uHS+qvK?=
 =?iso-8859-1?Q?nM/JtXZ60jzaWxMtcYS76/GJaUvMgmXARfAY7+cJn/5Ga4OP9lrxESi9OM?=
 =?iso-8859-1?Q?Xk3qDY/ooWAYqWoF5OhbCpIzp+mz0JnUOy/nJntc1ZyOQMRAdBX9DKO5PN?=
 =?iso-8859-1?Q?b8Siq8MP9ekBDHJsGEA/i5ZqEux349OJwArOEOEUwGFtdV7yYhJi1KKkFR?=
 =?iso-8859-1?Q?76+uVKdtwC/T7dDRSAWr+dlvE4tK1NQtr74a5Vj8SZWm5qmqcsXfnQZAEt?=
 =?iso-8859-1?Q?gPzccXaFr3goicy+kC7Ku7KBtuhWBEMdDCBj4G2cLf9DJqPOF1oewIDE70?=
 =?iso-8859-1?Q?B+xVVcKQAjkfCPypN50wkikNJFeK7xuXfUTE2UR+YT8g2vc+GWQAf/sIZB?=
 =?iso-8859-1?Q?vbZlmxha0CymzHU8fNtHRNhuclCk8ZN3xpvDTLmDmuEqS4tEiOF3KRUlux?=
 =?iso-8859-1?Q?O/y15DnlIa3aVL4vxNLUo8h2r9mWTBLmTyWLBdKWlwqTsgDjYDXRJ82Z5t?=
 =?iso-8859-1?Q?4pLO1lEkHtJvNwEarj0ODCG7nd2ASv/uzDRn3p6PYZB/8is9WlOlC/hr3K?=
 =?iso-8859-1?Q?HltXkFkYt2SKH6xicJ/xhWtimdmIHWNujFrvNcUUDTEMnoHAu+1gr6/15p?=
 =?iso-8859-1?Q?lh4O+xF+toJTGIZfgCpt7dk346XCrsSfOci8y0rklMBahe0WtWPJYskcaP?=
 =?iso-8859-1?Q?r5uXQvx/viehVlD0pWJfpUqulWaRZDx00r+fUFCezpnovIw9hrMTsy7Ugd?=
 =?iso-8859-1?Q?7zZTIH2MZck14ycyQGiJGlIi1p+4eP4ihUdbM3ftOPMKgnigmdrw+Lxec5?=
 =?iso-8859-1?Q?Zun1TuYNNVDYVMDFYmLBwSIBUeqS22Ngacr7SHtJ+WE6byueAqbe9CNxOZ?=
 =?iso-8859-1?Q?jXFI96YyC7qUfuv1qofa+4tjQVHE26IO9MxTJm5Lx07muNl3o1UAHxZAC+?=
 =?iso-8859-1?Q?n6f8Z/iuy3uvq+lVlhLFDbiJmRuciXeGe1004WPnnorJKLR7r/Qe4MNgbP?=
 =?iso-8859-1?Q?R2bPyE2bB1HC3PxQQK27KwZhUYj3yWW5WEYj16eRgztPXn70cQb2ej4BCV?=
 =?iso-8859-1?Q?Kq5soTStg91GQFQroh7l/MqIISTALplhYsYmsYoZ4ectIHZObqjHRwrA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e489a65d-7034-4cd1-4322-08de2a713041
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2025 09:17:56.2394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCcxBs5zuiPRREn9OS1AMeb2FokJ9InoLVtDxJsbvXDLsmaBlgC1HnWTXhqlyQHrGk54rfvfbL6ewtSnK3JvhhsziZ4gDfyIYlEX6z04YEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8399

Hi All,

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: 23 November 2025 06:34
> Subject: Re: [DO NOT APPLY PATCH v8 14/15] pinctrl: renesas: rzg2l-poeg: =
output-disable request from
> GPT on dead time error
>=20
> Hi Biju,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on geert-renesas-drivers/renesas-pinctrl]
> [also build test ERROR on linusw-pinctrl/devel linusw-pinctrl/for-next ge=
ert-renesas-devel/next
> linus/master v6.18-rc6 next-20251121] [If your patch is applied to the wr=
ong git tree, kindly drop us
> a note.
> And when submitting patch, we suggest to use '--base' as documented in ht=
tps://git-scm.com/docs/git-
> format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Biju/dt-bindings-p=
wm-rzg2l-gpt-Document-
> renesas-poegs-property/20251122-001415
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-dri=
vers.git renesas-pinctrl
> patch link:    https://lore.kernel.org/r/20251121160842.371922-15-biju.da=
s.jz%40bp.renesas.com
> patch subject: [DO NOT APPLY PATCH v8 14/15] pinctrl: renesas: rzg2l-poeg=
: output-disable request from
> GPT on dead time error
> config: loongarch-randconfig-002-20251123 (https://download.01.org/0day-
> ci/archive/20251123/202511231456.D6amN8I5-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project
> 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-
> ci/archive/20251123/202511231456.D6amN8I5-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of the same
> patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202511231456.D6amN8I5-lkp@intel.
> | com/
>=20
> All errors (new ones prefixed by >>):
>=20
> >> drivers/pinctrl/renesas/poeg/rzg2l-poeg.c:97:3: error: call to
> >> undeclared function 'rzg2l_gpt_poeg_disable_req_deadtime_error'; ISO
> >> C99 and later do not support implicit function declarations
> >> [-Wimplicit-function-declaration]
>       97 |                 rzg2l_gpt_poeg_disable_req_deadtime_error(chip=
->gpt_dev, chip->index,
> true);
>          |                 ^
>    drivers/pinctrl/renesas/poeg/rzg2l-poeg.c:97:3: note: did you mean
> 'rzg2l_gpt_poeg_disable_req_deadtime_err'?
>    include/linux/pwm/rzg2l-gpt.h:38:19: note: 'rzg2l_gpt_poeg_disable_req=
_deadtime_err' declared here
>       38 | static inline int rzg2l_gpt_poeg_disable_req_deadtime_err(void=
 *gpt_device, u8 grp, bool

Will fix the inline function as rzg2l_gpt_poeg_disable_req_deadtime_error.

Cheers,
Biju

> on)
>          |                   ^
>    1 error generated.
>=20
>=20
> vim +/rzg2l_gpt_poeg_disable_req_deadtime_error +97 drivers/pinctrl/renes=
as/poeg/rzg2l-poeg.c
>=20
>     87
>     88	static void rzg2l_poeg_config_irq(struct rzg2l_poeg_chip *chip)
>     89	{
>     90		if (test_bit(RZG2L_GPT_OABHF, chip->gpt_irq))
>     91			rzg2l_gpt_poeg_disable_req_both_high(chip->gpt_dev, chip->index,=
 true);
>     92
>     93		if (test_bit(RZG2L_GPT_OABLF, chip->gpt_irq))
>     94			rzg2l_gpt_poeg_disable_req_both_low(chip->gpt_dev, chip->index, =
true);
>     95
>     96		if (test_bit(RZG2L_GPT_DTEF, chip->gpt_irq))
>   > 97			rzg2l_gpt_poeg_disable_req_deadtime_error(chip->gpt_dev, chip->i=
ndex, true);
>     98	}
>     99
>=20


