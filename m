Return-Path: <linux-pwm+bounces-2844-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1807F933E6E
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 16:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F87AB226A5
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F75181310;
	Wed, 17 Jul 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gJ6oDZIY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013012.outbound.protection.outlook.com [52.101.67.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E248811CA1;
	Wed, 17 Jul 2024 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226564; cv=fail; b=u82b0ubx6k9dv2rJldlyflNBCNyYzDwpAHIQEdv/fjNG+EVsery4x5TCl8NwTJdn8vD350oOPjUi6Go18XYWTy0isMjCY0e/jctFqhuBbnjW9JRo31HKUbGb5m6xZ5jNJN9/dHn7GiZ3hxqNCx8TZmkEfehQ6UxGWX8CddAqEiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226564; c=relaxed/simple;
	bh=jxVZQd6K0mFG3wMZF4MZufpXPTBagVQqSq0xHsdD64U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rGrsYdjmSxFNrBkos9BBMhoolPRwZA7BCkpEXpQFm2RUgdugn12RC/lu5ZUQDoEXFtEAACMiaBzSJFJ2rDw7sdMdmfhEn9yo5sPFy7T8n3Wh9BYORZImQD7NsrFvmOhMEMVHJjU8i86BnQ6gfRaqs+9Hv3bVbN5u5bfOGw8pP+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gJ6oDZIY reason="signature verification failed"; arc=fail smtp.client-ip=52.101.67.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbhXSbsrk2LMpStUr9RUXJebXv1edwGNCdrqQYgDS3IGPiF8tiNA/A0Z9BdK15F2sVZ/S0DLb7+ZASLowD1J8Xm7lHMCXN/DAqB/5jUo/1LneYa7lucckNL5lRn85ape+e8m/+WPRnnhT0nlae1YvXF8OdXKrsluJQJvchc61h88Kaj4oS7De8U6BcSnziljxUINRW5g5vKWChHdxgjAAxerpVh3O6AhUovRErB+9T1LAMBW0+7wLzFcpzUaze6e0lD1MB7Tt0iPluKYR7vAeFNbOcOeA86UmepdxyYDTjxxY/RbUXknPaf3fYye2k+X2wjKZTlA/vMBP9zAADzsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsMiSh4/vUTv4ynap2iPmG5gFV2sWaTXvhYnpdal6hM=;
 b=QNd6SLNlXGHCzR6z8vNsvi+DTEXPihvMPhFJg9iXAnHkrGbeur6Duy/Lizr0uT6PO+6ul3rID814JXCNSjrMlbLoyePmnM8hcz4bhsGFbAsotukMMBrJNyHJ0FEedCd9QsrDEQoZMIU4NuCs0DavVX9XrMREiPgxB2avH2+/HWohYr0Ill8tukgGedOsFG1tk3hQZ8nO3dK41y4EdRXbTGKZD+eL2yqE7Jy/d6OAebSMeoJ+E24IBGlRPT5qzUchlhZqSJY1pYv14YJXCBcKgRynPuNhyfx20edVcjpRrbzfiwuKTuHuemSLIJFACX0ZJ+rWioPPI0aa4WL/2H9zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsMiSh4/vUTv4ynap2iPmG5gFV2sWaTXvhYnpdal6hM=;
 b=gJ6oDZIYf1+sJELsRbZAJY4If1mwwm5iZ2rFyaxUvBqwgHJ09z0YqMvUDAEEmA2n5i4/6aA0nFWKKAU+IdPWQBjKBhVt1121NV4cQ5g9aqI62anwkqiBaAaPVWKjLQzP6r9dtOJNlV0a08WHnk5jdNURkpbcwd2GU241aVfjrdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7559.eurprd04.prod.outlook.com (2603:10a6:20b:295::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 14:29:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 14:29:18 +0000
Date: Wed, 17 Jul 2024 10:29:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Clark Wang <xiaoning.wang@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
	Jindong Yue <jindong.yue@nxp.com>
Subject: Re: [PATCH 4/6] pwm: adp5585: add adp5585 PWM support
Message-ID: <ZpfVNHQQaJvdnB+B@lizhi-Precision-Tower-5810>
References: <20240716-adi-v1-0-79c0122986e7@nxp.com>
 <20240716-adi-v1-4-79c0122986e7@nxp.com>
 <u7xii4lfvjk6gbpmq7qtqckoznddiyno7xsaa74ufuxwdob532@wxuawwiwjpgm>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <u7xii4lfvjk6gbpmq7qtqckoznddiyno7xsaa74ufuxwdob532@wxuawwiwjpgm>
X-ClientProxiedBy: BYAPR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 765e2576-0701-4b47-0421-08dca66cd79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?S+o2FMWodwBbUdbp+98Od58BzlDLorFGNv9k+7XvEcp/4DH+2tlexFXhgg?=
 =?iso-8859-1?Q?rzm+mUaFnXWO8Cc30PdiqKyxEFZSgpSgJw0qb+lVIVuPSZVvB1rYWXM5TO?=
 =?iso-8859-1?Q?8o079vmXIC0o6Z6n1PIXMbB6EYY5SpuvZaHUr7k+kaMsZ3QUP54kmMxLuE?=
 =?iso-8859-1?Q?8rrJNaWFegDznfuSF7ft7/VeNwRKQ8Jwx348xGk3MieTA4yuXgzIj9AVqz?=
 =?iso-8859-1?Q?DSWiimGpyZLLkz9KOCtUxcYBkNyIJhlyDm3urnpawIOdoyv7AjQ6Hh2myA?=
 =?iso-8859-1?Q?cs9Ryqlpf5ldNvmkBI4+6qFD0DdeABKZhggUEQR76MR1cF6O7+bIs90oY9?=
 =?iso-8859-1?Q?dF4VIdW4dhqh3hOh6+JuOwMy/9xReHAUcFYLbSNjPN/hMSepkoL5amL3P0?=
 =?iso-8859-1?Q?TzlIoXOxPdAoZfyi9Slse7iKJlfdHgUsbW66T4GiE7J4M8PvWZKI5SbDuD?=
 =?iso-8859-1?Q?EbhcmURlZCgABYKqABUn4fUCYaQmT9BG7qJ3qxJGuX3ZJGJ5lGo6vzWqxW?=
 =?iso-8859-1?Q?Uv7ee0FPOp/iiKXF82BYUkG4bWFU/knG4lGn7Y59pBK6mpVDIa9Y6AsCgw?=
 =?iso-8859-1?Q?zkyjH4lzLuxf8z9DhcC5sID2MmdOFDhQegG4NUYrtkCUhhV0ml64++9Nts?=
 =?iso-8859-1?Q?hUutBPO1/jlzJwjxj0MZ4Fvd6DBvFKY3BmHv7kxLFPwwo46eNxqotNhF9i?=
 =?iso-8859-1?Q?Fo1SQGMm4YwTyT6j5rYYZV1Usz2Kf+NTlAGtoHWoZqhBimtv9HbdRRduOW?=
 =?iso-8859-1?Q?XOr2tJidjaK03D5c7V4yon8MPdsyBz7SY5i+Gm6SDjxEwpi6lYTwKVSTV3?=
 =?iso-8859-1?Q?JTuqhkMaQHjrgMnHs0572XobkZ9GwrVxvojup2TLsu6bWTlSnrTN6kfol0?=
 =?iso-8859-1?Q?TAAu7mfaTovAAoeKILRbrA62+suvMs5JnIcsfyM8n9Ksx8jYDXvdFrGc5i?=
 =?iso-8859-1?Q?2Hq1gY6MB1TP0+CfW/6sZu0Ax3Tyxcb66rJsFylb5Daz3EIOqYO7YaoR3Q?=
 =?iso-8859-1?Q?8ohhTXbrdlVyXeLyUmErcJoMSuHzhnin3JWfEVrf5ZRc6JJ3VII6hInDsm?=
 =?iso-8859-1?Q?nw0j0I8IDVmgyukBPHSRt06w9FC4Z9WdhcGq3OKmrxmchXqOzi61xYU9a9?=
 =?iso-8859-1?Q?8wjUs7O1bNSPO15ivPudodyBV4w3GokmjuIcSsCp2LrwfQ2m4Pnl8PVExh?=
 =?iso-8859-1?Q?X0/lzSgHL34mAO438L13y72S46r/dihjqiligKaBUi/+J+bMg2hESzGssk?=
 =?iso-8859-1?Q?55cRIs/Ybp3TWYbzVdYSWReJh/kgn3B41v4utrpjB8jwWCIkW8mDV5uGEF?=
 =?iso-8859-1?Q?F4/bejqGyifKJ2cerc9CGybkZEWfF0tbt4vJfzbtIfMOLovp4M9pnUnJU1?=
 =?iso-8859-1?Q?JrN6GyE0P4rsPvRkAM6aeo6e3MsfPws4jiv6Dg3knhDkGAGm8IMGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?qIjZe4Oisa9odDDYNtfENt1hmQFQR8itB6489Le7BXE6JEonAIs1UP2bkF?=
 =?iso-8859-1?Q?/3uY4W0LGjrO9UYLTbxwyevjd2WE5P8H+x6KTV0Vxn6sQjeLzaXGCS1ntD?=
 =?iso-8859-1?Q?xHVGu2BxYAisbltA8+1NpEcQeqfuEUrkQzSAiLdw7k0k/id3fp2a38Gu+g?=
 =?iso-8859-1?Q?6s7Ih3B+4pGwud+/FjjHA5NYOm1Xu+E3UpA/VJ8nVP8k9KUu1pyxiFzuIA?=
 =?iso-8859-1?Q?8d3dcICgnxYB9o7eEb2WzGtEdxzhNQn+jw140VIf3Ak2q3webgiSJJxRjg?=
 =?iso-8859-1?Q?11beTW3/raaSkSi5S9Mwu/F6h/yBGKeYtE65BYqaCg0bJJJ6+02vYHba/E?=
 =?iso-8859-1?Q?CR9o8ewhBVKvRdRYAfM7wItNm7mixRhu+croItdsAIRx+BiJEVxmTVLRph?=
 =?iso-8859-1?Q?D/qBMUPKy/cQpC1rhi4F/iSqTxiDKcyWbVThvqvR/T2pOm0VXbiB0jT7Ek?=
 =?iso-8859-1?Q?a9CZrtnm/A/LEfDhS3X7V6Z/iKSk8t6Rr9eKczGxbk13X18XrBOmuiiAP4?=
 =?iso-8859-1?Q?XqLxpFGMlyRGZ47+mui2Y3Lvaa85JxXzlaOR3XH9VVcxx0A2vwrBgHslBg?=
 =?iso-8859-1?Q?lmDG8An7JXXvVmwJoY3tvTHJooyuqiOfGIqfM8lJiJvAVUie9oAtnNQGln?=
 =?iso-8859-1?Q?jywu9C1hmCbOjVAkkkm+0+bAuVSNYWK0Sd17BKd+Rcur6tJds0lCJjPG6X?=
 =?iso-8859-1?Q?A64ek0Sw1D1C83WyR55n7XhM4DqjpGJghp3sP2BBYdUb9GdsxJTK29LiaH?=
 =?iso-8859-1?Q?WQwDGYmhMoL+dR51jEsBXCtgxIiicxov/GAIenmDsSnrbCNKlxoFBGYGXj?=
 =?iso-8859-1?Q?NTTnyAactI4TA08NHmCqstNZ07lLw2zeem9/s0RZCbZbuctgb2G+ZEGt3O?=
 =?iso-8859-1?Q?xkU0Kjj7V1Fz+zVL44fMVbjXH0zNn2PKOQeDZ8kF2YUgC2bXdJ1x9ZJzSC?=
 =?iso-8859-1?Q?4iBRRvIXN0dlhSVaIWksWf/aIX+L96aqzYKgt5EBWdE/M+505emQ9rRUrT?=
 =?iso-8859-1?Q?We288YJrvjf4hwAhX5Xv+rtH+Gnio1pp2QRiM2lr49iTZVzuzUuTEZuo94?=
 =?iso-8859-1?Q?hmcZ63xobwQHd054YXk1sqIWI3EV+Z3MnEHpG/+D87x3QQgebYNr7ejdj3?=
 =?iso-8859-1?Q?RVzE25qOFokfykgNDt7PxbrtRO8R/q4hxjtJsrXR3O9MZb068VJsosGoI4?=
 =?iso-8859-1?Q?smI7077AP9TQSw3pHSgtcmInrPlwL+Da/y4ja3SVcHmj85PPDkfTCPxNMt?=
 =?iso-8859-1?Q?MtCRx9I35uKI162mXftjGH7PDGP0Nx7gm3YLKfNNafvKNCXwF/jEqhIsjU?=
 =?iso-8859-1?Q?gHG+C3C8sHJLVj62HS5vDSZsPPTKsdAk6PZuNtJFX/SMJnHBN0baJkWT0e?=
 =?iso-8859-1?Q?5/Uw0gUFO9nmjmQqccOFh0DpSx+jPjrmOe+DprC7Q+fMB19oTcnn6v3Al3?=
 =?iso-8859-1?Q?VtGhxSLLiuNm0/sbjmbj0/qddsfJvvtEWoCqcFbJ4kSQ4l0deKTZC926gW?=
 =?iso-8859-1?Q?r6noAQu+s5QQl8SjSrQElmZ1la+fOWkKKpzbz1ku9gSo7hYzmCGoV0LpOu?=
 =?iso-8859-1?Q?LpxW5VRPk7RY2lxAMzpwoeD+8YFDMySGxH3wlWj2Bq3nBpEarUgfb3mYro?=
 =?iso-8859-1?Q?C2mCSk6w+5X8U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765e2576-0701-4b47-0421-08dca66cd79a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 14:29:18.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzP0tNJPeeAUtdYvdNNLMbBZqM201e8xgp8S8jglEfucgtc5hXKeOSjonsHiRWxQQkAkKbDimFxwlLhJi1gIEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7559

On Wed, Jul 17, 2024 at 11:04:50AM +0200, Uwe Kleine-König wrote:
> Hello Clark,
> 
> On Tue, Jul 16, 2024 at 03:28:27PM -0400, Frank Li wrote:
> > From: Clark Wang <xiaoning.wang@nxp.com>
> > 
> > Add PWM function support for MFD adp5585.
> > 
> > Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pwm/Kconfig       |   8 ++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-adp5585.c | 215 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 224 insertions(+)
> > 
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 3e53838990f5b..baaadf877b9c6 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -38,6 +38,14 @@ config PWM_DEBUG
> >  	  It is expected to introduce some runtime overhead and diagnostic
> >  	  output to the kernel log, so only enable while working on a driver.
> >  
> > +config PWM_ADP5585
> > +	tristate "ADP5585 PWM support"
> > +	depends on MFD_ADP5585
> > +	help
> > +	  This option enables support for on-chip PWM found
> > +	  on Analog Devices ADP5585.
> > +
> > +
> >  config PWM_AB8500
> >  	tristate "AB8500 PWM support"
> >  	depends on AB8500_CORE && ARCH_U8500
> 
> alphabetic ordering (by config symbol) please.

Thank you for you review. I just found someone already submit similar patch

https://lore.kernel.org/linux-gpio/20240608141633.2562-5-laurent.pinchart@ideasonboard.com/

Let's wait for laurent. If he is busy, I can rework base on the above one.

Frank

> 
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 0be4f3e6dd432..161131a261e94 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -2,6 +2,7 @@
> >  obj-$(CONFIG_PWM)		+= core.o
> >  obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
> >  obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
> > +obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
> >  obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
> >  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
> >  obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
> 
> alphabetic ordering please.
> 
> > diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> > new file mode 100644
> > index 0000000000000..f578d24df5c74
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-adp5585.c
> > @@ -0,0 +1,215 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * PWM driver for Analog Devices ADP5585 MFD
> > + *
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/mfd/adp5585.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/slab.h>
> > +#include <linux/time.h>
> > +
> > +#define ADP5585_PWM_CHAN_NUM		1
> 
> This is only used once. I'd prefer to pass the 1 verbatim to
> pwmchip_alloc.
> 
> > +#define ADP5585_PWM_FASTEST_PERIOD_NS	2000
> > +#define ADP5585_PWM_SLOWEST_PERIOD_NS	131070000
> 
> Funny number. I wonder where this comes from.
> 
> > +struct adp5585_pwm_chip {
> > +	struct device *parent;
> > +	struct mutex lock;
> > +	u8 pin_config_val;
> > +};
> > +
> > +static inline struct adp5585_pwm_chip *
> > +to_adp5585_pwm_chip(struct pwm_chip *chip)
> > +{
> > +	return pwmchip_get_drvdata(chip);
> > +}
> > +
> > +static int adp5585_pwm_reg_read(struct adp5585_pwm_chip *adp5585_pwm, u8 reg, u8 *val)
> > +{
> > +	struct adp5585_dev *adp5585  = dev_get_drvdata(adp5585_pwm->parent);
> 
> s/  / /;
> ditto below in adp5585_pwm_reg_write().
> 
> > +
> > +	return adp5585->read_reg(adp5585, reg, val);
> > +}
> > +
> > +static int adp5585_pwm_reg_write(struct adp5585_pwm_chip *adp5585_pwm, u8 reg, u8 val)
> > +{
> > +	struct adp5585_dev *adp5585  = dev_get_drvdata(adp5585_pwm->parent);
> > +
> > +	return adp5585->write_reg(adp5585, reg, val);
> > +}
> > +
> > +static int pwm_adp5585_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				 struct pwm_state *state)
> > +{
> > +	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
> > +	u32 on, off;
> > +	u8 temp;
> > +
> > +	/* get period */
> > +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_OFFT_LOW, &temp);
> > +	off = temp;
> > +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_OFFT_HIGH, &temp);
> > +	off |= temp << 8;
> > +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_ONT_LOW, &temp);
> > +	on = temp;
> > +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_ONT_HIGH, &temp);
> > +	on |= temp << 8;
> > +	state->period = (on + off) * NSEC_PER_USEC;
> > +
> > +	state->duty_cycle = on;
> > +	state->polarity = PWM_POLARITY_NORMAL;
> > +
> > +	/* get channel status */
> > +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_CFG, &temp);
> > +	state->enabled = temp & ADP5585_PWM_CFG_EN;
> > +
> > +	return 0;
> > +}
> > +
> > +static int pwm_adp5585_apply(struct pwm_chip *chip,
> > +			     struct pwm_device *pwm,
> > +			     const struct pwm_state *state)
> > +{
> > +	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
> > +	u32 on, off;
> > +	u8 enabled;
> > +	int ret;
> > +
> > +	if (state->period > ADP5585_PWM_SLOWEST_PERIOD_NS ||
> > +	    state->period < ADP5585_PWM_FASTEST_PERIOD_NS)
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&adp5585_pwm->lock);
> 
> What does this protect? You're allowed (and expected) to assume that the
> consumer serializes calls to .apply() for a single pwm_device. Given
> that you have npwm=1 I think this lock can be dropped.
> 
> > +	/* set on/off cycle*/
> > +	on = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, NSEC_PER_USEC);
> > +	off = DIV_ROUND_CLOSEST_ULL((state->period - state->duty_cycle), NSEC_PER_USEC);
> 
> Please enable PWM_DEBUG your tests and make sure it doesn't produce
> warnings. (Hint: round_closest is wrong)
> 
> > +	ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_OFFT_LOW, off & ADP5585_REG_MASK);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_OFFT_HIGH,
> > +				    (off >> 8) & ADP5585_REG_MASK);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_ONT_LOW, on & ADP5585_REG_MASK);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_ONT_HIGH,
> > +				    (on >> 8) & ADP5585_REG_MASK);
> > +	if (ret)
> > +		return ret;
> 
> How does the hardware behave in between these register writes? Can it
> happen that an intermediate state is visible on the output pin? (E.g.
> because off is already written but on is still the old value. Or even
> off is only partly written after the first byte write.)
> 
> Please document this behaviour in a paragraph at the top of the driver
> in the same way as many other PWM drivers do it. The details should be
> extractable by
> 
> 	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c
> 
> > +
> > +	/* enable PWM and set to continuous PWM mode*/
> 
> Missing space before comment ending delimiter
> 
> > +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_CFG, &enabled);
> > +	if (state->enabled)
> > +		ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_CFG, ADP5585_PWM_CFG_EN);
> > +	else
> > +		ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_CFG, 0);
> > +
> > +	return ret;
> > +}
> > +
> > +static int pwm_adp5585_request(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
> > +	u8 reg_cfg;
> > +	int ret;
> > +
> > +	guard(mutex)(&adp5585_pwm->lock);
> > +
> > +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PIN_CONFIG_C, &adp5585_pwm->pin_config_val);
> > +	reg_cfg = adp5585_pwm->pin_config_val & ~ADP5585_PIN_CONFIG_R3_MASK;
> > +	reg_cfg |= ADP5585_PIN_CONFIG_R3_PWM;
> > +	ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PIN_CONFIG_C, reg_cfg);
> 
> ret is only written to here, ditto for &adp5585_pwm->pin_config_val.
> 
> > +
> > +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_GENERAL_CFG, &adp5585_pwm->pin_config_val);
> > +	reg_cfg |= ADP5585_GENERAL_CFG_OSC_EN;
> > +	ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_GENERAL_CFG, reg_cfg);
> 
> Please add a comment about what is happening here. I assume this sets up
> pinmuxing and enabled the oscillator. I wonder if it is sensible to do
> the latter only in .apply() iff state->enabled = true.
> 
> > +
> > +	return ret;
> > +}
> > +
> > +static void pwm_adp5585_free(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
> > +	u8 reg_cfg;
> > +
> > +	guard(mutex)(&adp5585_pwm->lock);
> > +
> > +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PIN_CONFIG_C, &reg_cfg);
> > +	reg_cfg &= ~ADP5585_PIN_CONFIG_R3_MASK;
> > +	reg_cfg |= adp5585_pwm->pin_config_val & ADP5585_PIN_CONFIG_R3_MASK;
> > +	adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PIN_CONFIG_C, reg_cfg);
> 
> It would be consequent to clear ADP5585_GENERAL_CFG_OSC_EN in this
> function given that it's set in .request().
> 
> > +}
> > +
> > +static const struct pwm_ops adp5585_pwm_ops = {
> > +	.request = pwm_adp5585_request,
> > +	.free = pwm_adp5585_free,
> > +	.get_state = pwm_adp5585_get_state,
> > +	.apply = pwm_adp5585_apply,
> > +};
> > +
> > +static int adp5585_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct adp5585_pwm_chip *adp5585_pwm;
> > +	struct pwm_chip *chip;
> > +	unsigned int npwm = ADP5585_PWM_CHAN_NUM;
> > +	int ret;
> > +
> > +	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*adp5585_pwm));
> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> 
> Error message using dev_err_probe() please.
> 
> > +
> > +	adp5585_pwm = to_adp5585_pwm_chip(chip);
> > +	adp5585_pwm->parent = pdev->dev.parent;
> > +
> > +	platform_set_drvdata(pdev, adp5585_pwm);
> > +
> > +	chip->ops = &adp5585_pwm_ops;
> > +	mutex_init(&adp5585_pwm->lock);
> > +
> > +	ret = devm_pwmchip_add(&pdev->dev, chip);
> > +	if (ret)
> > +		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
> 
> Please use dev_err_probe().
> 
> > +
> > +	return ret;
> > +}
> > +
> > +static void adp5585_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct pwm_chip *chip = platform_get_drvdata(pdev);
> > +
> > +	pwmchip_remove(chip);
> 
> Did you test this? I'd expect this to explode.
> 
> > +}
> > +
> > +static const struct of_device_id adp5585_pwm_of_match[] = {
> > +	{.compatible = "adp5585-pwm", },
> 
> Missing space after the opening brace.
> 
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, adp5585_pwm_of_match);
> > +
> > +static struct platform_driver adp5585_pwm_driver = {
> > +	.driver	= {
> > +		.name	= "adp5585-pwm",
> > +		.of_match_table = adp5585_pwm_of_match,
> > +	},
> > +	.probe		= adp5585_pwm_probe,
> > +	.remove		= adp5585_pwm_remove,
> > +};
> > +module_platform_driver(adp5585_pwm_driver);
> > +
> > +MODULE_AUTHOR("Xiaoning Wang <xiaoning.wang@nxp.com>");
> 
> The email address matches one of the S-o-b lines, the name however is
> different. Is this by mistake?
> 
> > +MODULE_DESCRIPTION("ADP5585 PWM Driver");
> > +MODULE_LICENSE("GPL");



