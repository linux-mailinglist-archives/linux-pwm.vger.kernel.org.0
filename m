Return-Path: <linux-pwm+bounces-2652-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F64391EA0D
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 23:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1157B20F98
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 21:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F31C171644;
	Mon,  1 Jul 2024 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LEGJAd6+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67132170855
	for <linux-pwm@vger.kernel.org>; Mon,  1 Jul 2024 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868475; cv=fail; b=er9/GGkxSoWaPDH4geJmlW9urNOwuKXgQDYyEcPhsTXVwQ065EtQTUVKx3GNCCYul0Zrm0tY/XRdRnDAtPKlIjW9nRQHQHLcsyzVN5TpY8B3MiqffcjHRXgrXnojqYSWz666AKZeqqhRF5cB7q1mDhE4vAJlzhlUv8bdg00oaO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868475; c=relaxed/simple;
	bh=oLKEu54gFQmp2hBXDKEk3gcU4KViRlj9pXsm/mhJ434=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rca7A/yChmbHJ34GzAF+/UEpDlVMUnfqXP9CDaAIhAkM8XZ7EazEGXVAkbSjsjnonKdL1fp902zf/HDYuom3/hyq6n3gS2DM/5mbxayEaUXhARXc2N4b2yeB5TQ2SIvjRdGzT4MV1iWKFQPLTaih6s5lU8EoUWVtVhUOvXegTWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LEGJAd6+; arc=fail smtp.client-ip=40.107.247.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7J9ufOFbbM89Qb+7Rswy7Q7vd9uF4lIhCAooxbsuTCazhElSEY7SUObUe9O+5nYK8gVlcUUa8Lx+gsJXAmAxwUh/lmAZWqvKz0rzikHubDJuU/mnOXlL4M/PpLGHATNUCFEoFC7FYZ8zmSI/DVnM+WS9x786yOswywO0cxOc9TxfdCKSahq4VcLvdyIRujTwReuON8UIqjj2z8T+CsDpT2GdprY08owiTp5E9xeyYbFZtkhg2JwxdPRlTWOvkVvCbcM8tYStUVOOL80xYbUqR98VPAk+BagQmh6oYU1hINPYpXzFoJXcrHCrfEQprITarduwY5CUCbQAFw4VdVI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GywXmLD10wLUHJnAVHm7g02slbZb9lVIGqWohpQAdIY=;
 b=M8ntmD2FJ6h7B/roqE0RLnItK5xtQ6NoNH8DE3R6vCEHSIKEJsxdpzVwBSWp3KAhGsqgBhagm7J+X90wdcuJmaQw/utAjXzuNCvqns9AHS1VzfsOAj0LYO/dWFWOs0e3zsKjiBqf0ktJu8CYmiTJIGUxDHv9DlD8s+NlsSaJDl7HQD9AuFrTRH6ble/x+wi+WTGklE6K9ImISOyztzfO3EIrvKNZ0rk12+iqGuhhPmlXxnLaNLGIG0cNC4DCDLJgHpZuySurIWk3ak4zo4/vCHYgZXJhFOz+QMiLK271Qj/7nwEGwSoHcOosdmm3stTZVSPQEY/rS1s26s1a8W2Cpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GywXmLD10wLUHJnAVHm7g02slbZb9lVIGqWohpQAdIY=;
 b=LEGJAd6+GxIuf1sdtd7eeeRa07ubwj7xbMcY7cWnQPDDJ8F3ixLLcgoX8UNmxPTypclh2OWyazDV5u6eIjJniCeM2DGiXrI6RLVyhSnNyFqVtJ0z8XUTkYdgRk9Kjw2DUKverg1zyUfICiE8UhsmdRsJEjDXb3thg8/oyY4ye5w=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GVXPR04MB10972.eurprd04.prod.outlook.com (2603:10a6:150:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Mon, 1 Jul
 2024 21:14:28 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%2]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 21:14:28 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] pwm: imx-tpm: Enable pinctrl setting for sleep state
Thread-Topic: [PATCH] pwm: imx-tpm: Enable pinctrl setting for sleep state
Thread-Index: AQHay/uobE4WbqgwCkGjhy8d5UrNbQ==
Date: Mon, 1 Jul 2024 21:14:28 +0000
Message-ID:
 <PAXPR04MB9185061E57C305C17D59C66C89D32@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20240514200534.73847-1-shenwei.wang@nxp.com>
 <ewrvieusxer74yi7dlp55sfgy4n7u3o56ytrfqijkurapy77wi@f4hgxlamr2cx>
In-Reply-To: <ewrvieusxer74yi7dlp55sfgy4n7u3o56ytrfqijkurapy77wi@f4hgxlamr2cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|GVXPR04MB10972:EE_
x-ms-office365-filtering-correlation-id: 2384ed81-b80d-4e6f-c1fd-08dc9a12caf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?gdaRrJsTXoKBrJny/p0G9+YWnuAtrZkyaKqWdu22UQWRjmihVtzq4YAjtH?=
 =?iso-8859-1?Q?jkE7wLmesKVFyAuADz+0qR3IrDZR0tk/XNgK0euD3WqFaKuhpbaLnH/PaE?=
 =?iso-8859-1?Q?1zMm1EEC/+UidKU76bEMUK6TSL68H0bHRX8E6IesUXju6Hk/q6dU5mzaz0?=
 =?iso-8859-1?Q?KNYOVNj5FmoaHmaLiBM9j88C6WDx4sCOPIg6aYnuadDceEcyPN4/vwXEpN?=
 =?iso-8859-1?Q?fOwKQM6V6k/rztoVw5/8EpOhAe2Wr6ySi0zBJ4CqSPgN9Ypp70HyJAFb3J?=
 =?iso-8859-1?Q?g2MJ6aorGhtjkjFyj8tzOktucEAdCze/BJVD0FmqZ04WISB61qYpqj0mBS?=
 =?iso-8859-1?Q?rr7F9tYsE6EM/NfVIiwYT+oHW2vSCZ8olD/2dauGIh8N1gzzjAy1rCqN7u?=
 =?iso-8859-1?Q?Jk9WxiC46gKx/++zXxyHCXHrW6G1cAGO33mtWm78sPvKl+NzmjPvGeTmCL?=
 =?iso-8859-1?Q?1Uo9IQwzdda3fmSPyIyMUQGi92eGDf/F7pgjXeGo9hfWIVViDsfYS/VABg?=
 =?iso-8859-1?Q?t9IHh9lBEghVKQ1FVGIlRPKH/XSv0+LQqI+v7VXn9k0gtBoSP0cwj96GO5?=
 =?iso-8859-1?Q?3WVvzCErtaE2avtE1td28+B6DJbCm6UFpjLbzqYU3Uqy+81UM/S2CMZQxc?=
 =?iso-8859-1?Q?o6b0zesITzGFbvlOBHhwOUD4lO35T6P0W83LLAf6eEjNjHq3tXCQJ87xth?=
 =?iso-8859-1?Q?Oa5Z8QtVwzss8uOmFZQoe09QWlLiybntw+DNm606ZmMA/30dnH/QjlMI1/?=
 =?iso-8859-1?Q?dK67LKNfbeYm/xlHYjIPqwdsM37xIvppficyoftOGJurOalBaddOjltx4/?=
 =?iso-8859-1?Q?Xu6/YMPgXwtqdcBI7qr64WzzfmsXQo//HIDEnnfP6dmqEMDK2A/Iecp20b?=
 =?iso-8859-1?Q?ub6dOumNc+uTiEXpbNFftHyY2Kh1x3K7e4TLgqsQEBjYgEa45HFRXnadaF?=
 =?iso-8859-1?Q?tLUNmT6TIydUMTOFH2Ity9tzHgri64vBBUgcTeTnkV2RhJUypfQmgS6KJz?=
 =?iso-8859-1?Q?DRXe70C0zG1W5ZgFSYmwyhLpRo8lXeBy4l45OAI0Pwl3EXdfhTnc2d1QoW?=
 =?iso-8859-1?Q?a+bpRJQQEAJQ7PDiOT5/i+uBEX/qdidsN0Paq8j/CKV5DcvIXwIgXcXwot?=
 =?iso-8859-1?Q?WHZ76VL0CpTAb/VEn9h91W0jG64f7NoTs5JPv9I52RQnatiG+3c+WG4Uqn?=
 =?iso-8859-1?Q?gGq6PSvQlMR3exZgjCBPBSTJbCuaApMhdpLHmjsEdAuuXqPWHQ/NwLrDB+?=
 =?iso-8859-1?Q?dqi75aAjfZVNCWJ/vA9lsJSUfa2dtDcSa01T+mQ0EI+IrG2Yf9pmOZwja0?=
 =?iso-8859-1?Q?NgZ0FeVvabGFzdtJUw1K/08yiFGbAg1SgxrJoNNSOdD+iFt8i+qwlUr41g?=
 =?iso-8859-1?Q?raEBhkffOQvGMifVR3I0M5x+6/QHlJ5+8FvGxTxlRqWZTdwjEbN1LlqcgV?=
 =?iso-8859-1?Q?LOPOq8A4fIPvx0uy7ULpfaeOuKBnuF8aHE6M1g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OzH1WNcBDjpjzKxZH3j4Pj1z9e+mtQUC94wRf16adr2Hu7q6m+oVZsIUl1?=
 =?iso-8859-1?Q?/U5fTD29L0jBRZxoTZWlwFg1OIgwyD3qTLDHQIZoD0OvtxBaGx5JX0yw61?=
 =?iso-8859-1?Q?DOQOmaOeHJavwEr7C0/MRATSVmjt4HEwZ8pGrRDo6j7tM7hXRwywKWjXuO?=
 =?iso-8859-1?Q?th/Cac2q09q+DZq2oJOJl/3wr2QJ3FA8Oj2Zd83o1C1eaBKFKckdkpCaXH?=
 =?iso-8859-1?Q?nOqaWNPSDm+R0sH775He7pgqfuY8GT/OP5A5emgjXH1YYwc8R90EP1D7Vq?=
 =?iso-8859-1?Q?9QEQshAmxdmMcQjMLwvb1cdwq9dUQdgsPxqNVTWfaQcqGjpVWKSzGlByjK?=
 =?iso-8859-1?Q?jiO6jR9zXTwyqHQOpYXSkkTiy8pNSxYqudp9wTUNcBN2jgiO3Na+DHFmqL?=
 =?iso-8859-1?Q?IVqIHxr6BAdY6RAuKjzexAcLIZo8Jq2FwXGBUnoB3FFmzCTKdHHIA403t3?=
 =?iso-8859-1?Q?4NUxB9oC4ArLWF5Jnev17jY71tLcaEeiKLSC95m7yl8vVkhlMIMVIZYTCs?=
 =?iso-8859-1?Q?akAZXIRYLZHhDOmir3lvEuIiME32YYKj2d5yQzr9QNUC0EY705UYbPhWe3?=
 =?iso-8859-1?Q?PBmK2M9HBB/FcPf4tNEDBF3rEyLuuIEVNNBcmsu1QxdEH8E6PsyGzn51w1?=
 =?iso-8859-1?Q?Y3uBReOnIJ2zxvcoD63DviQY3gdmz1OnWJbcMxBYiaMnbpJtKdSDsNmj44?=
 =?iso-8859-1?Q?ohKIhZcMDqKw5mViJSHRZssk8wNytXI3WkmEIgRIEFGK+/2MJh7hzn7Vdl?=
 =?iso-8859-1?Q?gFclGECsU74gSdLXV6YJ/R4Xi7oN6NgyIi/HvbjlBkN8vL6PgetCtUYtXP?=
 =?iso-8859-1?Q?8iurCwrx4TbdgAlQgalBl14p29pKruxsfOZGIGPHTklpVY12OnIqHbNVUx?=
 =?iso-8859-1?Q?S6VQURJxuOhokyZ8z/7VdRvlt0mLZU9UZAx+R1AkDkn6JOpXsSDVYLZqjH?=
 =?iso-8859-1?Q?4QQFLF6JK+ZKF+LV5mN43qoi+m63F+uvencaqeyh1+UqfgbiGWh3AAI7iN?=
 =?iso-8859-1?Q?GRTK1nEwqsqiVTDQ25DFMv8X6jPVkWv2lBuo8MmyL5EouDqorHg5lc6EAd?=
 =?iso-8859-1?Q?iuc2SdGwr01Scb1CSB9/miAL1aVVTs7zJe6a3kz+1NR+/tUuLU+kXyfxmG?=
 =?iso-8859-1?Q?u7WJ6ZbGzP6/VCXfQ99E1N/nsUeusHVpb9ZLMz/Suc9zhyiSE3fLT37XDl?=
 =?iso-8859-1?Q?xdkWOeR3l2vWzMDkQw0Ch+Snc+5hvq9v5ziy4NcYg/B6+8wFztq8c3AP2K?=
 =?iso-8859-1?Q?77NTbw1Lgt8m0tYxx+EeZ/JI3iou9E7aXKtxaifRMSY5LyErNwLTD9O3M7?=
 =?iso-8859-1?Q?pb80zbz5NWg1uIB6neHmodu7pkGkjrES7PGKTGCWc5Xv5cOUchxbZzZtVp?=
 =?iso-8859-1?Q?Ytp8495hNC/zIY2tioor5DpdLoNQV0XsKQIwnIh73qd5CldoVN8u+1fQFp?=
 =?iso-8859-1?Q?3yK77aGZVmHtTM6yBM8nfBydHSmgZEX5xG8wPkEEEk0Ul732vIPph8J3Hi?=
 =?iso-8859-1?Q?Gqo8U8V/gYuHprC4wNw6vOSqqjgXyT/kxlwjbP8PnPpX1kxxibrL/NTktS?=
 =?iso-8859-1?Q?0njZetzG6PiFU0mK/WA1fTevYbdWjxEJtNPEU9cjgvJOlWVU8pqU8es7HW?=
 =?iso-8859-1?Q?XI+7WEgfgnUe5T3yvFzmd0GbAIUMDLaW/y?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2384ed81-b80d-4e6f-c1fd-08dc9a12caf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 21:14:28.4652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQQyOpTxSnkSmZAbvkAfUAmOibtbj57qJ61ADmHouTFzAoCUpv8UB7E+eVMd66cHq5BwJpOXQ1OuIw+Q5isQ2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10972



> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Sent: Monday, July 1, 2024 3:46 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; linux-
> pwm@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH] pwm: imx-tpm: Enable pinctrl setting for sleep=
 state
>=20
> Hello,
>=20
> On Tue, May 14, 2024 at 03:05:34PM -0500, Shenwei Wang wrote:
> > Apply the pinctrl setting of sleep state when system enters suspend
> > state.
> > Restore to the default pinctrl setting when system resumes.
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > ---
> >  drivers/pwm/pwm-imx-tpm.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> > index c50ddbac43c8..19245790c67c 100644
> > --- a/drivers/pwm/pwm-imx-tpm.c
> > +++ b/drivers/pwm/pwm-imx-tpm.c
> > @@ -393,7 +393,7 @@ static int pwm_imx_tpm_suspend(struct device
> *dev)
> >
> >  	clk_disable_unprepare(tpm->clk);
> >
> > -	return 0;
> > +	return pinctrl_pm_select_sleep_state(dev);
> >  }
> >
> >  static int pwm_imx_tpm_resume(struct device *dev) @@ -401,6 +401,10
> > @@ static int pwm_imx_tpm_resume(struct device *dev)
> >  	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
> >  	int ret =3D 0;
> >
> > +	ret =3D pinctrl_pm_select_default_state(dev);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret =3D clk_prepare_enable(tpm->clk);
> >  	if (ret)
> >  		dev_err(dev, "failed to prepare or enable clock: %d\n", ret);
>=20
> If .resume() failed (consider clk_prepare_enable() failing), and the resu=
me is
> retried later: Is there an unexpected (though maybe
> harmless) imbalance because pinctrl_pm_select_default_state() isn't undon=
e
> in .resume()'s error path?
>=20

If we need to take care the imbalance of pinctrl states in the error path i=
n .resume
function, should I also take care of the imbalance of clk states in the err=
or path in .suspend function?

Thank you for the review!
Shenwei

> Best regards
> Uwe

