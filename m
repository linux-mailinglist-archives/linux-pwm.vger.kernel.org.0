Return-Path: <linux-pwm+bounces-5555-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F705A918E1
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 12:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC3DA7A69AB
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15267226548;
	Thu, 17 Apr 2025 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="r22T2tTw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010010.outbound.protection.outlook.com [52.101.229.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D91898FB;
	Thu, 17 Apr 2025 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884756; cv=fail; b=jEoI8Ug1RN/lNJCp2oYbOJBNY66L3bht/iA+8IAlCrO8TAXewESddOE29F7ItzpkLmNJH986Wy8LktkxKB2LeZYYvtNGXGyfJZjioIN5ZSC9wlaFhJJ4g3IR9wH+MFWEP/+1v2m5/j9UiBt8STT4Ruez45l6u+1/7xjdmDrU5lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884756; c=relaxed/simple;
	bh=PXg7k+jYe2f51okBnHO0cujUv+BiU9KnponSdHvXzuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YnIQ05tGYXjIrhqMctDR/XewHpBsW3z/oNSSq/t2DESdmJBAEku22ujPoLLFqXV2zeMpTUls0EUVjSa+WTcw0Wb7ipnxBCdhasMXuvguIVyuwQzvVIui8nPOmFJRRCNMktrNneI9PDH86nxzr+wJPO+xPQDMC1QpUetAVYOFtrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=r22T2tTw; arc=fail smtp.client-ip=52.101.229.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MySKBJjYd0/ZFFJVS9pMzEJXShkOnf20FmJeOK6bSm/IK6mF3gBEXhAd+VgjABOxfOUTngiVNuPF6D6cQd73upST2d8rPmDoCeciCzRP9fML0wGHJP3mqzr2IBByqV6QaQWyss8V7pyuhWkzINUgJZ0NRAwKYqA7d5t7Z3FLKMfgT9MGXjej/KtIvNGsqSAN+GMLaUFy+cAZnf5O3MjpckulifQydTH78jTThWi9fOjAuwT6bV76vPSNHMbeZBL0B5y91vrB69y1rKcnWyMXwxpTz2Fi1ukCJeHgNHq51d4FUMJ/Ed1RxpTrzRdkYDmcOSd3xgRl96Wbibvew/s6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNbxkTx8k/YWZGE12a8bmMo0knNN0VP6bs76sttogHQ=;
 b=H6Cc0+VIxOPFNbbuZKf1wSDU9jorNztVIBy3keffTz/8GZy3ruh7Wad1iwm0RVFBXVB+aBULLGZTrmK+tbk8sJAGHrQP4kY+Htcqw9lkhXBAthCW39A6FEHRJNkAxAsKpm4RdGDe0dY2Mmfmqv9Bv6Iz+h4RHvMhZHb2oQevmb9OT3AqzTQibKfVrNnNcncdj0Ad0u+5TZmMDbLPKaW9YQxg8YZFcnO5jNG1OgtiIz71NjaHzl7Mjgg1ZsSKhatZr/J4wtswMm7PYgoYAuuI7WsWfrDp2VJxb53k+aY1dmr4ozRt5wp/tC2up7VpZHqMgTCjnJ1pziHJ0Arw46/VBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNbxkTx8k/YWZGE12a8bmMo0knNN0VP6bs76sttogHQ=;
 b=r22T2tTwg0aq7B0U+eUPQqLfhblfNZ/eZkkFD7sT1SIN7VlW/vTc0JUkguMW7ITxCmdKX1tfbbMEpTIUFYRmJpd6SuwRK9gzSawV3KdJhIfyFbLWDUdDR+qsQ8+zk3Rshk/H4iAlrI1GuA9tcP70nXc5PnD5aufLdNOAI1L3/Qk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB10133.jpnprd01.prod.outlook.com (2603:1096:400:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Thu, 17 Apr
 2025 10:12:24 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 10:12:23 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v24 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v24 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHbiF0ju9HFDRXMF0ylJR+BM7pea7On67mAgAAFMbA=
Date: Thu, 17 Apr 2025 10:12:23 +0000
Message-ID:
 <TY3PR01MB11346AECF1C793EDDE9D0F4D886BC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250226144531.176819-1-biju.das.jz@bp.renesas.com>
 <20250226144531.176819-4-biju.das.jz@bp.renesas.com>
 <wapp2p55vrdpgwy7dpnrbxallcdu4yvk6a3nqimbyb565crqg2@7ljkanddwmjz>
In-Reply-To: <wapp2p55vrdpgwy7dpnrbxallcdu4yvk6a3nqimbyb565crqg2@7ljkanddwmjz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB10133:EE_
x-ms-office365-filtering-correlation-id: d5c6b1f2-45da-49f7-c9ce-08dd7d9858a6
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?HoSu+CffVGuXbcKNk3GqcOmt82gH/DLZZEg51otUvLvhIuzG088JBL70i4?=
 =?iso-8859-1?Q?vNc0BBTDJBmgpd9RpFvtTSX4fcbnCoXqcYMlPaEXHpIQO8VyRt/TvwNnOA?=
 =?iso-8859-1?Q?ZjiMdAuQv+eMjlRKCeBOdnHbUfVkKisgOhGIEll4mMtbwS6lCP04Ctfs+I?=
 =?iso-8859-1?Q?M4LYrn42Vawyv7Z4Foxfc4VTO6hcwm/Kh1F4Ousx/1uYJzZz3t1mNoKyYZ?=
 =?iso-8859-1?Q?0FHsBJAbWUwI6Ha2d8wT7+Ef10kS77Drmn2PqjCUXMPaB/bUQl24cRA0U0?=
 =?iso-8859-1?Q?c+XIwFsigxNijrndw5G4fF6S0zk3QsacrGxFQdvIvzgqTPnPKU34TQvP5c?=
 =?iso-8859-1?Q?etaFelYRCrs2QHsmmxxk1PKiyvckydO+6ye8/8yJ1xQWD2a17B0M0mS6QW?=
 =?iso-8859-1?Q?z3IU7ddFY6B01kHlGxNhR5MOLtjQ4v5C2Wx8+It0/gMZZu02FYO7VhoVyS?=
 =?iso-8859-1?Q?p+Fp1NlFCIuRQo20u+hBYVqNfN0SlyciOTV/rCZ3mQn2hDyD//EtwEH0zY?=
 =?iso-8859-1?Q?tVONx5xd4mxdMcpOpo+/Gur52F1/lzFKwUVLRjWWfw8xnv/VgnDfn8AwM/?=
 =?iso-8859-1?Q?KhkPu6kUaErHXH9qi/1/8drFujvjOCPlLrVCKXsmbHN0fLMk3gIZQ7w5dy?=
 =?iso-8859-1?Q?S28nQ1noz/6M64tJh9Q9SIP+mB6W+Z6YhzvWjf75YtYBASEpeNtcnniUuC?=
 =?iso-8859-1?Q?6F5acUX7KOg7qqLTsvGubKzzkT2kNeIl9Qn4SY4yk+fv7G9Iv5FJNxnfmL?=
 =?iso-8859-1?Q?i7Yj5iDu/Xzslf6orNLCjCR1KRpLbjH9Dv3Bkj7wovnFRsaj6e7TKgHCQT?=
 =?iso-8859-1?Q?IZfaO/Iv6lrPN/PASFdzJlHB/Sya//5FyTrjBETJ6b6AE18dyLppBX6EM4?=
 =?iso-8859-1?Q?Cf+bJUcbWR+/QZET0uQIt2b6iQg9bfTHh4rdEhcnyl4IE+6bnBtyGUmXiG?=
 =?iso-8859-1?Q?sGCBLadUtvOtP1XVoGFGtYCk5emtGyvGHy3jmibBWdvxMpBaxJ7VLnHI4z?=
 =?iso-8859-1?Q?6v/tV+ZL3+6lBp0TvP8DF+f67eBlkAEwaIK6LIMwjvpWOUrbm8VgJJWkEQ?=
 =?iso-8859-1?Q?+FqdiLFIz/rB70TAUsgRkAWMSDjOakn66HgrZsHxI97C7nIbW5A50XuDJT?=
 =?iso-8859-1?Q?lAr+WBvvnG7f+u4qaj3NizKhdQm9UifKNQ/csj/UyQT1o3V+YkGh0dJymg?=
 =?iso-8859-1?Q?YgeqIUiQHbLUaLPI7hxiGLwzWxDhUWy9UKtb0f2iGDSmw9woi7p7xdaU1+?=
 =?iso-8859-1?Q?RJ1HylMGHKJxbfyqKXSnOr887HCNuagXIBvmRbXjupJST8uoI2Ve+WFWkC?=
 =?iso-8859-1?Q?KIOkftb9DIWtzRKbvBM/0NLAjxE2RrIK1tIGvi5kpHq2lTri3stcYXIneZ?=
 =?iso-8859-1?Q?/ZkNnONFjdaiigQuIZEZlFR7iWAEwRzTaL0xz394UpA0acEgSit9Mlrl+T?=
 =?iso-8859-1?Q?sECWLksTDYvdPNCCFQ8+rwWn0w1CCDGccUhhKl+qHwbHpxFh5TEnIISmUT?=
 =?iso-8859-1?Q?zevN5aePjvVAfZF8DTib4BxP6I6ZjY83cChYi8n3YrPfRIfbZUwP+aeEBG?=
 =?iso-8859-1?Q?ZpQVsNU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?a2VuF0phCQwloTWOs8BfTWZQW48GYsEtck3fO/EwvUaZzm1TcucNZgljAz?=
 =?iso-8859-1?Q?DcC5vj42vYzuhfH5/G96Qrzs7lzsXMLV9QxikOCBuV/R8tvzboWxdOAeua?=
 =?iso-8859-1?Q?RWeWt7ZtjMCAUzKd892WwlIYOJaAS7TPR7tWHDgOzoQ2aoXKRQ7Xi4gpjk?=
 =?iso-8859-1?Q?QKmq598sF5TVYbeIjX/KhUJqp7CarwshdhyMeHZ9UNeXkgS5tH6t+qJXpP?=
 =?iso-8859-1?Q?1oqGN2/Q4u4Gra4TRV+U3g0/OufjRpA02ABaHTyupcWLHYlhzOoY0BAD3Z?=
 =?iso-8859-1?Q?2A0a2mGFLd2xG6Czr9RkHwS1JkjUXJd+BSRRkbtxRMUdak+qnKcbQnVV8W?=
 =?iso-8859-1?Q?W5zQX4z0Haojl7IvMwCUAmpvpB//HR0WYq7ZGieNK/6YzJlLuHVX9k4YPk?=
 =?iso-8859-1?Q?si44gMKXpKJJw3ibV3LV0gIiPSew+ChvO54fiy7EwP8lfUdLRum2/aYuAg?=
 =?iso-8859-1?Q?acJddsMl/92jgBkX+TIUTpS4RXgyS4M9o1t4uNrs8F5TW+PvwAl+dBmnGX?=
 =?iso-8859-1?Q?CInt6xR+XQ29yK3R0mr5ZnNLJn78o21R1lrtPFz7/1XSRcj0cF9GTTd+Qy?=
 =?iso-8859-1?Q?DtWVcK6CsEpOKDGNUmU7QuNWYrHfVVJ7dUC2ACd+yQwBz38eQrJJzOgi+U?=
 =?iso-8859-1?Q?7vwJ1Ed+8mUry8qnHN9OYswr74SRaHMxF7e1u5K4/GkEwLkbJ3+Ya7koGp?=
 =?iso-8859-1?Q?W2O64YIi+WpI6BGKxmlUO7cH6iBjqGoEm5iP3XMKxMXNGQowcyhYpJrTrc?=
 =?iso-8859-1?Q?Um5sNgT9tFqMKOEJiQSjdQgioGJFrMX1NHjCZ8cnAHTHXAVez5w4uOc9PK?=
 =?iso-8859-1?Q?o59hVziKR/ERLM/QmQ9N9qEzE64CQJ2eS98rKYKwfSF3w+SBsNoojAC7Lj?=
 =?iso-8859-1?Q?VK10SIb7NG6n/CnmCmhf3eQSs9gfq2cfJc1n4pTVu+b03tavkCFGzKLpjM?=
 =?iso-8859-1?Q?klLLsyoAt2YGMTmDT7e2YK8Rg0afxVPGpFox1uXE3T9yjgnMV/snFNs97e?=
 =?iso-8859-1?Q?wfriNJs7m6Bna8Rc0IDGvNZPVn787714SbXx49DiXPCszPQrmE6X5ojscR?=
 =?iso-8859-1?Q?6eVFNIcSRPawp51BMtbl3bl4oFqYaNl7Enbgbeo6leTfVBzXkGkCt3AMcS?=
 =?iso-8859-1?Q?SsqGDNKlQ1zmTyblq7sEuyWKScEJ7rjK0XFd+cd6I2vC5/NDM3EJOYI0Gy?=
 =?iso-8859-1?Q?k6/6onDjCG5ZxuESVYnbvJdJ7eArUdZqqXqC3TE7ua+f43upDE6JHQsZ7k?=
 =?iso-8859-1?Q?Mse6enEX7iSOKJip8bI7NkZ11AJ7Q8IHJ0nXbaDab0Bc8Pe5zYGlm2KE1k?=
 =?iso-8859-1?Q?rZIv1I+/yioNnyxhH3la5MlBWECYcURAQDCYr8QOo7ZCua+DF4BeN5gW5K?=
 =?iso-8859-1?Q?lv8szD2VpOK5s5WDqUew+0MjBzw9TdhqlkXMBrWrXNSfdMq1mxlVkz3ym3?=
 =?iso-8859-1?Q?YzLiXxvTeVCJIcZgskNNMu0IZjZxJWp2oM9it2AfgbYFVrOIt0jF622LgZ?=
 =?iso-8859-1?Q?Jf88Kx03FciY+T7mr0/cd2SkoZHhp0yE261X+Sa7greMQaR1hK0R5inY5+?=
 =?iso-8859-1?Q?b5ldwcVEoMLp2DsG37PLBHdsT+ooPVg2nZNXCLThTt567MS44OjQ8Q9R5C?=
 =?iso-8859-1?Q?js91dEYFmonQQMIOqr+WdK72kEY4aBUDvF28BBY0vWHnbg5Jrs7ILx+Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c6b1f2-45da-49f7-c9ce-08dd7d9858a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 10:12:23.2239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEdaPxX/8OzsmChS40w0TkBXPhwpQakyxHTr52F9lxDeogMmVeR1578Cx+hMBerFXukhqDEbahhM5mkd5nXO5D6ZGj6+gyt1cxJ/ObiGxbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10133

Hi Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 17 April 2025 10:51
> Subject: Re: [PATCH v24 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello Biju,
>=20
> On Wed, Feb 26, 2025 at 02:45:22PM +0000, Biju Das wrote:
> > RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit
> > timer (GPT32E). It supports the following functions
> >  * 32 bits x 8 channels
> >  * Up-counting or down-counting (saw waves) or up/down-counting
> >    (triangle waves) for each counter.
> >  * Clock sources independently selectable for each channel
> >  * Two I/O pins per channel
> >  * Two output compare/input capture registers per channel
> >  * For the two output compare/input capture registers of each channel,
> >    four registers are provided as buffer registers and are capable of
> >    operating as comparison registers when buffering is not in use.
> >  * In output compare operation, buffer switching can be at crests or
> >    troughs, enabling the generation of laterally asymmetric PWM wavefor=
ms.
> >  * Registers for setting up frame cycles in each channel (with capabili=
ty
> >    for generating interrupts at overflow or underflow)
> >  * Generation of dead times in PWM operation
> >  * Synchronous starting, stopping and clearing counters for arbitrary
> >    channels
> >  * Starting, stopping, clearing and up/down counters in response to inp=
ut
> >    level comparison
> >  * Starting, clearing, stopping and up/down counters in response to a
> >    maximum of four external triggers
> >  * Output pin disable function by dead time error and detected
> >    short-circuits between output pins
> >  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
> >  * Enables the noise filter for input capture and external trigger
> >    operation
>=20
> I now finally looked over this patch and I'm ok with it. So I will apply =
patches 1 and 3 to
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fo=
r-next
>=20
> for now. Note this doesn't mean 2 and 4 are bad, just I didn't find the t=
ime yet to look into these.
>=20
> I will send a patch on top of this for a low-hanging improvement.

Thank you.

Cheers,
Biju

=20

