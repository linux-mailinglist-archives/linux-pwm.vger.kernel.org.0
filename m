Return-Path: <linux-pwm+bounces-7175-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80242B359E1
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Aug 2025 12:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4340D2A527B
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Aug 2025 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A0322754;
	Tue, 26 Aug 2025 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nXq42VF+";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="g96L9wik"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177182F7456;
	Tue, 26 Aug 2025 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203175; cv=fail; b=GlTLEfm7C9Rfz8WaEmLC06PlAFdJxNHEbkU3jQ9Okvhk0rSAxO06DROFoM3SVEMZSZjmN69HZBrt1jhepXrPIjRrWQij0a3gbaE+66X/5HGQ8iB4dvEpBE91VxM40FtISUWlFPegCi0E3bkGT29KLBxdkjLSgtFvwkqZTBtB8/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203175; c=relaxed/simple;
	bh=r1LHKqliOV8LlXpRX8x4A9SCY1pDvRRcn/+LPpE+Tsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inIKZdaA7frkaM3DOJ3E2zU6j+p+xQ+gPyKDCOxKwYuYrC1Ql8wcLQNE0T5niTVTMVP06EVeSCy3OFJRTOseppQVZVX2k6KK3lWXgG/qlM5BlEbg8GcS6trKVQOXYlW1P5a744kYXXdLYCz8WqtaSTYOQnU4k2vC+OrVw/z4TX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nXq42VF+; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=g96L9wik; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57PLiOgN102372;
	Tue, 26 Aug 2025 05:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=7j6NiZ87MhJVFSoZEq
	ucv+8uWsibohAGaifnPdzC8Rs=; b=nXq42VF+ftPBanB8C4oAW+zPjAnNBwyDbv
	YsOcIbVZ+pWzPH93ocs7E2mIAOTl7dnrN6X76xsEt9bjmJVP925KYixFJHxj9JUg
	RDeqfefQkXWGc6AuFbVsSuqHl1oiuIPZZ1/bTpwGKlcsLDaa2nuWFOBIFQdGuSzp
	4e1qLIh7F+WqyC3Ob1Jjqlrdt8LwlkRJhrc+pYKsYHpUPChhRIssEVh8QfgmkJaC
	WV8tvWzaiNm7LzaUhcEGEXSFfa2c5UFbhDv2p+FMyVjG6x2QLAFggmIx371yvAVh
	Ygpf54HHP876jS3Jf2dXG5Hq+Ko589r6d/Pb+YzmE9IT1wGsZk8g==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48qb20n7kw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 05:12:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yomfuvBKygZhuEdTJpvmd8N9PHrgXnkaXdY8vlDFwLylpj0pD5GDIz4I5QOAnGfA0ExEdK+xJljA/A8TX+pnoIrWe9qKBMJYH1aqewRf/5WW1wp1W1yd1CG4lchIfN7H6ULKL5IJzOWilVIEkKYYMvYiS+0/jfvEosecbMmMRuRKhLcO5fULmLGVnSXsQB8dzpjqewApO60qXMT9d4bS1J6o9VspNx4QaiU7CGXCGCoUJ0p8Jm9I8SB0mXOa5YPURrbS1D/hrdivxCYU1ddgWezUun2ZpqW/Jg5bfcCZqdZ58VuZCDCqVR/mmfvnFaA2dFdYAYDWHLPlZ2t6uXo42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j6NiZ87MhJVFSoZEqucv+8uWsibohAGaifnPdzC8Rs=;
 b=xIxM4xizFjrvYXGv5NZ/QZAqnxM1A3oI5l/WJy1EUu7MRgxx9UuY2omfClhQAZ2j+vXUWnAUeMzRysQ4uVsU3+g/lHzmlKBL4dz3I+M6N0DZZB4u4dZzVUiaBeBob6tYFnktX466MJdzsMkAOxIYbfWLgwqONo+0PWrYDv1ZtY8zovI1GUmu2jYRxkghvbraWQycKnJ/GHTXpYtTJiEUa/rbvqx33i0Tdo2ltXV3mPVPp05zWaSbPinkmxhUhig8HYPFtvZ30tYaRmMia3ylUT9fpEWpe7dfD4+j4eeKBCwCPmnlV7kVblxEL+/PauT9sQ+yGX6/eVnO/66GVqQYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j6NiZ87MhJVFSoZEqucv+8uWsibohAGaifnPdzC8Rs=;
 b=g96L9wikTOshZoNUJ0CPke0WOWtGYj0Ne5K2u1PYzp2uDwuzvcnp4O9NqB68TYu9jh60EIRWmvT0CjyIXimvoGeJ69KiS1DcoC8ZAUhp3lO9TGwq/ifQt6jClvIe2kxlFJo2cliWaILy7Jk9+V+I28L5pw7EGCFfUDvk61i5mpw=
Received: from SA9PR13CA0140.namprd13.prod.outlook.com (2603:10b6:806:27::25)
 by CO1PR19MB5208.namprd19.prod.outlook.com (2603:10b6:303:f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 10:12:24 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:27:cafe::1e) by SA9PR13CA0140.outlook.office365.com
 (2603:10b6:806:27::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via Frontend Transport; Tue,
 26 Aug 2025 10:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Tue, 26 Aug 2025 10:12:22 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id DC93B406547;
	Tue, 26 Aug 2025 10:12:20 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id CA44382024A;
	Tue, 26 Aug 2025 10:12:20 +0000 (UTC)
Date: Tue, 26 Aug 2025 11:12:19 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
        linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 4/6] gpio: wm8994: don't print out global GPIO numbers in
 debugfs callbacks
Message-ID: <aK2Ig9ka9WoKt/+z@opensource.cirrus.com>
References: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
 <20250826-gpio-dbg-show-base-v1-4-7f27cd7f2256@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-gpio-dbg-show-base-v1-4-7f27cd7f2256@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CO1PR19MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: 21be6382-55db-42f5-1206-08dde4890c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LXMxgSV8RW8ghbkSvrGntUHL2IsNBPUIsBhWSMR3SxBVJC5d3lMTaBpqeqgh?=
 =?us-ascii?Q?pqWAkk2qWqgOZIBCzc8ki6ny/FiAnsVTsOCiZVGA8fRq19VqbXKuKcoq9q/9?=
 =?us-ascii?Q?FuOunAGyNEywCyuNawc65kQ2PHVdaGYZoYjA+r/kJO4YlYvbkrcY7nkrSlED?=
 =?us-ascii?Q?LTY61jFhb5PTPQsLxoaS9n8NwoM7EsqOaVZToZ0eKhSJBAEIDv89TwtgGYsu?=
 =?us-ascii?Q?wVXgvIXEEYecjs6qABwIfoNKVOke7Fnvns4mLB9GrSBZP7lmmevxLh7ekybq?=
 =?us-ascii?Q?zCG5C2/AgHBiG0XKNR+0giRyjklNG+my8XCn3aA8Unoq2rMoDJTreT8ILgHj?=
 =?us-ascii?Q?1dYAn3dkqJaworhTot/cm01Dx3C5he2ATlle/wFwfBQ/2FpupKk7/MBzeYXA?=
 =?us-ascii?Q?DdR16sE6OLqlNE3sO9tJzrQrZbtGbgquGs+8ucREvRCeF67B/WsuSjhC3yW5?=
 =?us-ascii?Q?LxCX5ygs3NFFuxSRCf1EfHWtmbrd6STtm8dAWZVQkhRyi81RPWqIm70n9ATP?=
 =?us-ascii?Q?A7Efn8BoOj1JZxx2jK1zvyz74Kn7PU1yexyEY5yqW51kbVuHjMsL4ZCBAp0e?=
 =?us-ascii?Q?QY4GMswvlMmcQ+QqnEx7NhdND1YUliM34ZgX1Y0gcBVwVMLyKuOaouuHHMBq?=
 =?us-ascii?Q?iKT578U52YFmV8m7j/e4CmKg0skuBNjVjN6EZZ37a4xnXZdS7bi0SgkWrUgi?=
 =?us-ascii?Q?B1DQQIRHweC/pFhTt1KdARqGAHwMWa2h1K/KNEAuD1sC61Ubpkjn90MFBHuT?=
 =?us-ascii?Q?oM9JbD3Ke8YpvDDLS4M7bqBG4bU6ShbzVD8T6uFjYMpooCIEbaXXt3ZMBy3B?=
 =?us-ascii?Q?EauPJKhWpQrmdcQWLRtDLWWADGCXc9/SbwUpWFjLOYyTnY0ga92/zrMOkDwV?=
 =?us-ascii?Q?RwzV856n0kXbR8tVz0RtkLL1BdHVmkYAdMLtUVnpyyjjaLs7Y2M2IU5FZYHH?=
 =?us-ascii?Q?zriM5D9MidV2YA4i516D2el0qELOhKSQ7MKLz3wEfSKsLSd1WYUqHdo9rw/C?=
 =?us-ascii?Q?oBrd62ALK2pRqyuniqbFA0zbdY6XLUK3OsnH2/2spTfi6YwfSFgLmbZsVMfC?=
 =?us-ascii?Q?OYkVKIthxbiLBM4z65LMXp8YpuUtcJwBWZ0+DX8njczmWgG5qzGRE+71YBfo?=
 =?us-ascii?Q?XIkR73txomAl4qrhsGMx7vfWUZGTeGsW9WGHCycWAnjp+Eose4cMX5dvvv+C?=
 =?us-ascii?Q?vWfmQsw9JTH14osPLXRa71Tj0EE9CmYKjUIMBJy3VnzjbJupXr6tPQD9hMnH?=
 =?us-ascii?Q?Oim/B5zJdNuSEPMTfVgT3xXEKjYrw7M8mkXiYFyQWpXpw6TiE7MbC9Unv2Ez?=
 =?us-ascii?Q?Qe/ybqJgrDUelV5hZlk7LJE1VdJlSMl/qD8v2aqtHLCHa/NheLgpiItri+oq?=
 =?us-ascii?Q?4CuXSgBvjgFtdm6cZx6tqy9oPgo9R/9+It/Cmd3HT3IQpIe3rQvOGE9nf8km?=
 =?us-ascii?Q?KnJVmqU/olzeGjr9seuamiQvLH7IprqVxenIdulCyPuXaHDJXsGY5LeVWy+N?=
 =?us-ascii?Q?pOej2uHDIdC8smKIO+ytB9KyWtkhLG/bEm7h?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 10:12:22.4398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21be6382-55db-42f5-1206-08dde4890c77
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5208
X-Authority-Analysis: v=2.4 cv=GbkXnRXL c=1 sm=1 tr=0 ts=68ad888d cx=c_pps
 a=pn3uJ1cN8NZYWFnaW73RRg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=KKAkSRfTAAAA:8 a=w1d2syhTAAAA:8
 a=CykeHtdoX445U1M9gU8A:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA5MCBTYWx0ZWRfX6UPSLbcvTMS0
 aKF3Z9oeh0qbezuLClEYbvChHAP3unywgZpwy/o2OQlBf/zTU5I7PptPq4Lqa3HBKz9EJJ/0I9x
 I4FU7h5ZUJvCPEvx6UjmQSeWYdEFtv9elHJpOw34HzFfw2GJsdCHyWOeK2t+aCrlpfEspuMfe3D
 sfYZgVpFovBogwnWdKigQJC8JaMgE9OH1JKO5wb/TPe+ua9IZn9j6J1Dhv9DIay1iIkLmCKl9GM
 FkbQcyqx529rfz6eEdVzqtgvHC+eOzBYMKwd1pqQU4Qh+KqjAuNJZM40mD10CjgxmW+tr4CogdC
 TBZcLb/ENuVeoTcQaemOeP1j7S4sV/zNJbRQNfkggh3zpUMaboS/r08NhYAspI=
X-Proofpoint-ORIG-GUID: _yge_8CebFJoXnDmvdYHJSQRCk2kty17
X-Proofpoint-GUID: _yge_8CebFJoXnDmvdYHJSQRCk2kty17
X-Proofpoint-Spam-Reason: safe

On Tue, Aug 26, 2025 at 11:54:38AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> In order to further limit the number of references to the GPIO base
> number stored in struct gpio_chip, replace the global GPIO numbers in
> the output of debugfs callbacks by hardware offsets.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

