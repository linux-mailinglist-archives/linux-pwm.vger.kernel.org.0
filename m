Return-Path: <linux-pwm+bounces-5987-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2CAAB7940
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 00:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FE61BA09F1
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 22:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC81DFF8;
	Wed, 14 May 2025 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="XGpiIORY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011056.outbound.protection.outlook.com [40.107.74.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46D819;
	Wed, 14 May 2025 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747263374; cv=fail; b=W92slvoJPJRGfxO1oPa06f1HX/Mp2BhbThwiYC5UJGF8YE29yF67RIyqD5p1HXzQN8kXvwezu1XiZbEzfmHGZfaUXsFgz69jW7NAsgdR/AhXwcMsgdNfOtyGwV7CDe8Hme+iKn566ydfOmssTAmKodJKfRs22F52bY+7/bIkQeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747263374; c=relaxed/simple;
	bh=wWfa75ATXpxQXJketlMZ59qhLcjZtCsFDvXHmGoRsXg=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=EML0t/5eNLHiFZrCjh0OhmA4TVKkAHmpggyg5MKUevOJf6XXWrC7T/KobeLLts7EaoNH1+OnpK8vWEZBn/QFHkh7lq5tOLAfwI0gWa2lVGzVSlHICttWM3cW1G2nGzMo7L938gj74yYel6B992KqJx4RKO5SWcZZEULbwp+zqnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=XGpiIORY; arc=fail smtp.client-ip=40.107.74.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4MGFGdWlVeyi+Djs10u5PO0mPKRiIHld+jB3k0PdYFL0vmoMrz12b3sbpKeLzQazZm73j8cuFmhzB81zkKmMGXW+U2XKqaD0cF7+zITl+CtzxF6WPP1thvUcwpRt1BgQEe0QUquBSEQQk57+VQdP93m/TP9kjqr42zPSZ5j7X8MpnLhLGnA/cMnqkcJ6R9BUM2QbIBw77pbU1JkwKWuMkqoVu4SFgHHvHB0erKu+IKiL/XHRo3Dlk7vM0j0vvesMlWYY2OpwnrFIDQfbsUKdJPzMF0jIS1JKAPyZs+4iHSE5x16iTQxWlMVzZK9gzbjQlrvhoJWreotCDe48SiFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWfa75ATXpxQXJketlMZ59qhLcjZtCsFDvXHmGoRsXg=;
 b=bIuhfWGAO7hyGtLq+A475w6ixaYcTnhEOH6x8izsmFaDr2ty4h/4iQgvvfQpjGs0z/FN96Y4WSFEF1k+R7iDH7VyFf27ZcmBdEe/eXRHt64ZBfHNAP/OvMAFsxPtjXFQjPjatwfh1DGlSvSqQumduPQYEemXPc15zn6+iOoMQJPwvkIjU1lyEFfeHmNV2yG4KGgg7osg/y9i8PpC9rfdEJT1MM/mmaBZ6SuLQCex3DYVCWoaE80Kslu1dJrE4AGc551sA0PcY1KX2P/GOJZY2gYhAb8bOXxh7KZPVudfYlmTBfO1Z6m69sDCQTFNeM19YyzCS6BScCQxX5t68tkXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWfa75ATXpxQXJketlMZ59qhLcjZtCsFDvXHmGoRsXg=;
 b=XGpiIORYXsWLo87ygug+r2MqYAqvZaH8jozwCmeNdIX3jsBKp2/ojW2H5GQiNBWymAmAOYbtaHUYqVTpthgWpH7pFb8sBBZdIVJSj0mb45VLPYZxXcnhCrjYqneVUiHwlOKZpL50mXEgORCLffmkJUzeUb9Ug2/qvvda0kIOAdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY4PR01MB13092.jpnprd01.prod.outlook.com
 (2603:1096:405:1df::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 22:56:07 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%6]) with mapi id 15.20.8722.031; Wed, 14 May 2025
 22:56:07 +0000
Message-ID: <87y0uyu7i1.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>,
	linux-pwm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v4] pwm: tidyup PWM menu for Renesas
In-Reply-To: <wytdfpewvcesc6racyrpa4cya7wku6dc65edz7oma7penqrqqq@2g54gyprttxt>
References: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>
	<62gkja5ysv47yos2hcurluudxwvl54uv4ih7pjnmnjrzuik6cs@a5oxhyyy6vsm>
	<CAMuHMdUvR8rp2PaFLsyQ6ZWLqw7OskP-ZwVjRC=AARhK8g-iYQ@mail.gmail.com>
	<wytdfpewvcesc6racyrpa4cya7wku6dc65edz7oma7penqrqqq@2g54gyprttxt>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 14 May 2025 22:56:07 +0000
X-ClientProxiedBy: TYCP301CA0047.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::11) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY4PR01MB13092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffe6980-583b-4d9d-646a-08dd933a82ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4pLDxghoDAgNhLcS4CEwGmP3cfqorzgUzFmnlvHn9QmugX7rqV7NSVC6P+ts?=
 =?us-ascii?Q?dMjEivpj2oc3tpGHA2S4rDtupa3H5yAOUWrQncSA2GjOyZ2NqpLD+1AiuTpv?=
 =?us-ascii?Q?xPMIxXd68icL3+Mpi1lXBqwX213WO6X4Bwxz0TsYoIpFsiLfgLLQfbzBSrZL?=
 =?us-ascii?Q?0UbmNuqd8jCwal0ae2AlVvdxjpxdS4+dMT/dedD1lJMSicHnkdLYooRI3g+B?=
 =?us-ascii?Q?6EJKW2ocu63kEv2qJCHWxwOOnFO0p2BYHhZQk2T57KGUzCpx+CxJAP1/w9xB?=
 =?us-ascii?Q?dAnSigpQI/4Z0kV8zaXl7g7FcsjHIkI+cEGTsn9+1clnC1QiTRJPibOngFn8?=
 =?us-ascii?Q?0YDuYvUTW7Ue1b2kenmbyFKycmUOkULFZKYO1i77fQUsq9z44D1LGmu5Ed+n?=
 =?us-ascii?Q?WYKQTr523hLwzGXW1nVGRBuAofzuUEfQpwtfnIry9qN0yhZNyRpujAWXdC+Y?=
 =?us-ascii?Q?7raTaw6IfVEdj0rjmOuI041V0Qv7YCYcrYVQ8Um5H5hFZAK50vlApDnHNWqG?=
 =?us-ascii?Q?uj4b4Any+AAvVaL7DFFd1Im0oGUQLBFuSAWIa49HQBE09+Ph+Xq03TShDEbb?=
 =?us-ascii?Q?G62EdkW78powg/Mh0T1YLe+crwiZfoFAdweNOzrzNpYxdHwWlWjpNwIVf7NO?=
 =?us-ascii?Q?2IJtZ37iLa0grjCzdIOe+XgnPMemEg8zfAz1jukrEazyDhQqw4kgzM8gBr8q?=
 =?us-ascii?Q?lnQsJNuQ6vTYUcPaYmQtyyawq6TOJvrK48RyQdF7KooYeBQs5a4dZvZtLvkI?=
 =?us-ascii?Q?tP46AibbOtItVW1RExf7BDA9+ZkF/B1CUkitqOn6N6mwGLwk64rLVCTO+rRG?=
 =?us-ascii?Q?Mn/tzLI6EWS2m2yncVP8a3bC+bDe7lkjNWQzIYaXhSyXRhvKTA8cjh1bfI05?=
 =?us-ascii?Q?o/NfOotEG7/QW9dAW3VmbSt0hRASQkoAD84r9qYpYVjbHrlqoqdmE2lhIpMQ?=
 =?us-ascii?Q?iVHTpMM4iQz0NnxT7b8TJZWXfwF3tAryMOOjkaeHwe9vY8RHuO8qujFtv/d0?=
 =?us-ascii?Q?cT/Prb9nEvlFviy3EaVxNmtENmvPgCN+8AMNTKHraRs7Nbdvy+SbYK8bLcJh?=
 =?us-ascii?Q?YdBmCTmQW7K9pOh50kbpsmgRXNfF1lJuKlDGpqJkjIUUeWo5x5ssxWn+62Rg?=
 =?us-ascii?Q?iEKKu+cKAj/unWrTCRIhgjLleCVXLs0+lecxLvelrGdg1svGgfs3XPAQ7Yjn?=
 =?us-ascii?Q?vQsLUeAypxE5cnPgy0xZBn+UG9TaZe9cvY6zUa/6N7aKoykCCY4T8sdaF7yt?=
 =?us-ascii?Q?3UY6hf6/xMSjW8zrBWL3v/rj7Iko6twHHAXeRnX5tZp+WhDCzZW2Wia4bc4r?=
 =?us-ascii?Q?okqEPe6Xyh1xL5OO274XTiH91J77N0fpkS3twMc7lkYjUJ2s94sWAoc8bp7A?=
 =?us-ascii?Q?rUVwobhbDv9H4DxM89GlY/teAXhyhBB426p2wMf6iCIBJixDSxw93cBYMblY?=
 =?us-ascii?Q?YFsxYVsdvZdjrxIExsjTonCjG1ycvYfeASA/Gmv7/h8v5jT8mYpKUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p8UzKGk4TmMW7EYIfGInN0+D186B/HHo6shsY/NZyfX1QuvlQwXRi+00egL5?=
 =?us-ascii?Q?N8DlU0uf7zxaS6dX7Fg8Fz4jLTZtB7h9SduVajN3GJSyss6lJVFj/hUk3utk?=
 =?us-ascii?Q?MXIraSPqWBrQIFuwB90TwRRBudM74L7vju3syt3LPzvzQeSkxhZcF0dYOYnL?=
 =?us-ascii?Q?PXihkjJr/LuAFZb+RhCEeBvXw6RaEyHX+mofQ5oywh+ga3bBa/k+0HAZHDo7?=
 =?us-ascii?Q?84FfjAOIbbTHXSG28tIsnmgzQ1PWO65y39rJPTfkT/6d0MHEQ7D1L9Hl35j3?=
 =?us-ascii?Q?wp2sc+5p5d1QCpdvFWHPih1xDO0n1VJ1BM7w7Q2iPwUKHKCI2IaGq1mo1yi9?=
 =?us-ascii?Q?U3kSO82x8e/p/vN2mFp9uvcjqtqEb2tsXp9GPImyyKyuBXD3c6Zc9FX3fhJ0?=
 =?us-ascii?Q?wjTW9OEKcyrsPYl8JnnhEunF/W/yhzsMN2qINszfWQLbBP6A5VoNwfudq+AB?=
 =?us-ascii?Q?OUxvCos6BnG8ETXHyTNoQyIVj6OHYI+oYyejh0LWOmzmKSbYJPniQ2IyCdm1?=
 =?us-ascii?Q?EhAHp6PUgA/gwf1P7fXX9GWG4wY+DIX1HXVW1mt5436GKhsaOug8o6r/Ng5w?=
 =?us-ascii?Q?AoGE+wkpjc+MdtZlDudQ4Tda1TzlyyDPUjwMq9YH5CzZt9iE8RrlPqxubcYN?=
 =?us-ascii?Q?4qirbUUD+yydv2v4hg++XbkhIOArGdkn70A5kJMkWCu6tXi3NS97kRqc6zDq?=
 =?us-ascii?Q?IdDj7CSgYYvFY+8RQ8/wM+oBz3Yt6GzkAwC0/sCBiIfGioxsECBrNF/4nQYg?=
 =?us-ascii?Q?5TDrvPD4yoB480H51giJMeCgdb91iEePQgmwmJmQm2GGFWwBTpNTCr2BxrsC?=
 =?us-ascii?Q?HasZ5hMNoHupNaieTMdpANw0atsUUgaqRemsS7nLl1k7K4A4r4JLaJE1rPuH?=
 =?us-ascii?Q?hvF8mqAf/GyzujGkjieuQbQK6jQC0NLHOoFhhVtwwTIzxJJqGp9FtxTOgcD/?=
 =?us-ascii?Q?hUeiLiIWe0o4ha0rSyh5PPiEPZh9IMvCNmPI7I2exJAh5DGSgOoRHwo7JuCo?=
 =?us-ascii?Q?+5Gy7ToVX+Jx0DfB3InN+Xe3MAWvL3AMXiO36mfoMgsLpStrhL2Ncb3LZnV3?=
 =?us-ascii?Q?z2W89rODETm8B5zsTUL3IkEN7lvJG0FjXlEua6AntqFPdI9v3PSIVjFZUtLn?=
 =?us-ascii?Q?qnkZJ6dLpxvnQjqiWJYZbjVw/lj6tNjV96eLdhJxpfceRucZu6fD1fXS6pl4?=
 =?us-ascii?Q?zlx/mz2KSAjv/JuzoBvUPdugYAhwKvLIMwVG2S4YkZlgbWaZiVnRvVSNIRH2?=
 =?us-ascii?Q?UK6JHZ5E5RqL5OEgtidJO1eIT71XaJyykk6DUhrqGDzRXUTGQ+be1+ipr8jr?=
 =?us-ascii?Q?I3DtQhMqL4TCgyaGYiScKJ3TB9zwfoHULLYMjUsg7/pFTr38F2Nx2xqxztoy?=
 =?us-ascii?Q?B1rmTUKNzmAQIZZFQOSJ3GVCe8ExGpe0N9fvlB0dsFFotdtv77iIfFxXvpQX?=
 =?us-ascii?Q?kc4hffv/tvJc9X9ihelb9g9cxg0mjb/EUdWzH3a/v2oE8MlJFh1XzzPhkdA9?=
 =?us-ascii?Q?EiyeJsb0PyG+9YPfn+PS6hzBATnOvy2mdJqqeYt3HXX5bY6MH2Hg1Glo1c4c?=
 =?us-ascii?Q?VLCAk1sTMOIedAWZPPG6iZfI+4CzJvwtWgN0aN7YJF2rRXP0EzX+koI8+t2f?=
 =?us-ascii?Q?l0lLLaqJTMrDcdgjpt3PKwM=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffe6980-583b-4d9d-646a-08dd933a82ff
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 22:56:07.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vn+XGZYWvR3t1SkIdPKwBgAxQAEZ1pBIEqm9hSgUHQnjXMjOA1dYEMn22cib6rvU+Ap9EhNeRo6SEstPCbaApXFTBUUT9jfeApXOlQ0pQosHPzuIB3mzVwCSEtj1d/bd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13092


Hi Geert

> > However, renaming config symbols always comes with its own set of
> > pains: users must notice and adapt when updating their own configs,
> > and I do have to manage the non-upstream renesas_defconfig, too.
> > What about dropping the rename part? The symbols that currently lack
> > a RENESAS-prefix do have fairly unique family prefixes.
(snip)
> I agreed with Geert off-list that merging
> renesas-arm-defconfig-for-v6.16-tag2 into the pwm tree and apply the
> patch is fine for him.

It seems the patch was applied (?)

If so, I have a plan to post patch for renesas_defconfig to update
symbols. I'm thinking I will post it after next merge window,
but please let me know if I can post it immediately.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

