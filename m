Return-Path: <linux-pwm+bounces-9198-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EgbN9n/GGpApggAu9opvQ
	(envelope-from <linux-pwm+bounces-9198-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:54:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0555FC88E
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA86831C0FB9
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 02:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC48369D55;
	Fri, 29 May 2026 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nJUAVUf9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F239368D67;
	Fri, 29 May 2026 02:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022898; cv=fail; b=oOvDtA9FzQg+wLwUIW58tMJ5RTdn/iJp++eI6eAPE64nkxEebiHVFJ6G2bz56METrLFubQYCT1L2UJfSLN/NJg6S4aku1QgQmviG2ecxI0DRquo6rTyLfifl+HAzg6fiNWR/53DzgL9pMvdEorQha6Tra+LxhcJkntRU/r1JoVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022898; c=relaxed/simple;
	bh=0EF+ZcaNd3B1LD/E0YNl4SMipcptYoge6aO1ddWd1ts=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dRxEnerUTQEwBOC40c89YQVv9xDGCFBA5teFN08n3B1OaBc32ixzhl5wNUUImgos+SGCHSY6FaJsx6mioLvOfkRBht9t7qVY71je+h5c3+H8jouWcJo4bBCyd8qA4eH+oCrt8SVapj0RYh8pt4u+8HtSfNYrU1a8SHc+Gppg7Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nJUAVUf9; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3WZ1qYsnISB21rjOFnF3swfbpLqCCCd7+tReET8n0q93jqqsIhW1gN+P9qNZTK4OppKJCtjHmSA0SaivJJ2LAwD0LTdQgPVnLo08VuS6eTWMLQFqbdtmVb7sImJ04EQAJPFGPWMOjOVqjDo9HptwSHHlxE4vQvv8iZIgYHGkZXft9OoJgWUoRga5ZiJu5xOBQTpN0i6XGMe6DsrNOMqpAsMAhVtiPVhDXr4tQoDZMVkMEXtNCrrL5SZpBqCfrSwIKOBkYmWNpik3+kQo50bfQ5UO85WW/LjN6LPr7LXP3hLCpZvy8VAscciLpXBI5LPPeS0vcI5zQjxtfEdRfLODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TpoaQkpiv/22Ip+E+/1aaoVXd5foA29FNuoKDa+Zzo=;
 b=VwZfZqG9HGCIBLPHXisL+c5UoFXz01My1Hdo5cM2vOD7b6yTdJXnQXj6Yi99VATtlEHdAESZGI9E9z6rIyYqq0D6Aw7p3fZ5sfEDVotvz0f+Xg0wmtVhSkWMib3GtQKwmcX1xmDwSUDnu3h74VE+gaHiykilu+jIJLgmFH7MJaF8rN8G71Duyvlgg49T2IbocNuslql42d7YfS77KtxDgqU8eQWxoQQg6jnEL8Y9W0kEtGR4z1LoLXQREGipd6udr1Ta+x2esDW43KtGhGj+LNNSBqv1n2D7AQi+1CayfUaczh63uFtxEkM2M09ALBWC240OBrEQNS+Ygz5xzaDSOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TpoaQkpiv/22Ip+E+/1aaoVXd5foA29FNuoKDa+Zzo=;
 b=nJUAVUf9qjlHBZhmBNE1H3htEiJMFMWBzWZFw5NUBmCDiVBgCklZ70TqWt7A4qohcCDX1l+ULhYP1KcfMZpBVzo6K2EuilU5hMBd/fj8NYwWDd5YbBkdTilIbZ+qiz4NT7B93TAkHvp5livW3dl8izGqXO0wxNYdaUBf/iDFGPH4BoLCbKVGMoTsZ97wN/69SZH2T+fT/2YKlpuIeYVI/g43PMJmIq6frcvqSjAmBYWjQAmWPBLcdZn3YrdM8wG2NaDZPKrRZWKoPH2WJf85xbPH7YHYMv+5oWtVcn2gMdhU5eL3BHbNJqyP7LXut/EppuLoOcN7pS+2rgkaFpaEAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 02:48:11 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 02:48:09 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 29 May 2026 11:47:28 +0900
Subject: [PATCH v5 7/7] arm64: tegra: Add PWM controllers on Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-t264-pwm-v5-7-7bf9e405a96a@nvidia.com>
References: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
In-Reply-To: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0079.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: afa448ae-a006-4367-0669-08debd2cb7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	81CNHiUf3RZZ4aYD9/wP+aBkDWkkG7aMZrjBdGGTvaPmPXiqtBNuuNQnC7vym/LbN2+luVe2vi8RUNqs/jKcGrYZ2S32d9afTHT4s8jGZ3pNjaoUlh5UUbMUijMo6a/j7/1xPn7jtVzYhXSzpkm+GRTxjjuLYnRKD85aQiqGnuboFP1XELtYRvaCAmV+doRMAtES/zWqTLM1m3k9/qSIJ+pGOvuCJ9KSiZQuzuEd8toZNthk04NhCv/gM4Kx6Zbd14kzD1P6IkpzDrfCOt23jYWRBumNpc7Vp6d+fm2iI8X+HKLTXCLakt4d3hVFAUtxlBmZR20mTGIT/OXjpoInzc89e2f6rhIIVJK/INaA2pn3x3RsSsOhWGFZsOtCBHE6YEfCyDwAA/AVDWg9H7/MZKZQu1PzHr5c5SOBfQQ/tultk4KZCN9fznUZw1VdsTBxl2TuSGUQ8aK9y1I6cQ7LuLOqhrvKj9vx1DaNiBsQLA3QvXhJH++usR9GlzcuT7IADC0yqEn8WoXlqdm4IibHwFjeVD3KNXndHp7TwFYwOaLw8yXgZiT5A0YT7nDvFQZ4E+zZzbIxxzgDNCbdTqgS3FrQKB4KWXsKbljJDbcolldHsbvSM5Wnm9qo3SIUXVzNi6VmPeYZg6xF/7BX/SAA1/xxQszpMPyP7b1tpu0Yhfc8OFtXhVun0LtkM3eQLXLr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWVwUURGbkNlNUhtMWpJQzFDeUxrVjd1QWE3bnVyZlNrYy9jM0h2WFZKdlhH?=
 =?utf-8?B?azJwSi81QTZLKzQ5MWdCMndKSThmcFJRRG9xV3pybGhvMmIzUHpoWXhSZWtn?=
 =?utf-8?B?RVdxTDBKRUxHUERHeXgrOVAwL2lwMmRKcVNlbGQ3b2lEN3JkeWh2cG85NTN4?=
 =?utf-8?B?N3VzS3liaGh1THpDekxHUFJadmQ0SnV0MWRvQjJuaW1EV2lWVUdDaWlJWUs0?=
 =?utf-8?B?endCbHJGV3N1L213NmhaZ0wxTFRGeXZsTUhIcE5qZW5VUHFMS2V5MXZIblNj?=
 =?utf-8?B?cEJnSUtiQ3d6c00rNGV3RGprczhqVmo4Y0RiMkNUcE5jYnZvWlpQR1pSTi9K?=
 =?utf-8?B?cDlTTjNVUmpJcEhXNFFGK3ZXV1RQY3g4UlZqblVDWmNkMS9KemlJUHpMQ1h1?=
 =?utf-8?B?N1Q0b2JBZlBadllFaWZmOWUyMFY3cHFVdjZ3LzdrV3BsQlhKelZzZWRRaXNn?=
 =?utf-8?B?T3dzS0lkMDhRRk5IWkpQM0hYK2lqRld0MlJzQUk1emZmc3hQU0ovWnlGcDRl?=
 =?utf-8?B?aUgvcTZYclIvZ002UDdyQTcraXBRbjczSUNhK3ZablloUjdWSEJFMy9QV3ov?=
 =?utf-8?B?SDV4THk2NzJ3dEhtd3UzUmQ1Z20wbW1PQzJTWkdOMFdJdTlqZDVJcytFaUhJ?=
 =?utf-8?B?S00wRFlTaG9TVXIxQ0htUXdJRXJKNXY1eXR4SHgvRzZCdGtzeHBNcEhQbXpt?=
 =?utf-8?B?T0k3RytZQ2dHOXh3Q3MzaWdOYUh2aEZNTXlHVzdxcHZpS3ZhQnhxRXhsbjZN?=
 =?utf-8?B?eGwwL0dhN1gxZnQzZ3lpalk3MUNKK0hZRmpiWTVETEJUanFZU1BRMCsrcGtk?=
 =?utf-8?B?ci8zR20yMmx4anc2S2xtaVMySTI3TWZTc2Z0QmdrMUQxRUpZSVBCcW9ndzVV?=
 =?utf-8?B?R0RiUVdJR09xTFNiRkxzNk05TjdmMWxmZ3dHOHNRZS84bEkwMzhNWFN6OEFP?=
 =?utf-8?B?bko4TmpDdGI2c2M1eTFXMElKOEM2aXVyWDdyWUFhSDZJVll6M0dEbTZRZmhZ?=
 =?utf-8?B?TnVnbjdDeloxa0ZLWTlKWUpuUmREVXZLOUJHYUF2VGg2ekMrZ0VVeTV0SzBW?=
 =?utf-8?B?Q3VXRlJ5L1ZLT3JrdWVsem9jM2prbmIyL3gyVENrM2Q2MlRLSFE1KzlhUkd0?=
 =?utf-8?B?L2JLdnZtTDFXUjlFbmdqdkY4bm5kU1JMcGg3S09HTGRnYVA3eldkRy9nYStH?=
 =?utf-8?B?TEZMd3RtZTU5UVVUOFR5QjJxbE1FbDlabDV1MDZxdEVOdzhxZ0VteEs1Q1U5?=
 =?utf-8?B?bzZwNjZBb3NtNFhxQVpucHpJZGlwNFZtRlYwZ3p0OTRyMlhYblVoaGZHSCtp?=
 =?utf-8?B?TTBOOFBBUlUvUDVuNmN5VHJqTVp3U01LbjViSklCckRtMGU5dTg0Y0N6K0x1?=
 =?utf-8?B?NmtuSHM5Y1FlK0wvTElVS2s0SzFpczF4dmtoOFg4Z0JieS9RUVduTEJYdFR3?=
 =?utf-8?B?dFF1bzc2QjRKSVlyMVpJWjBObFliTEhPbVpscEVacUMzMTFGRkpzcGNTbVBE?=
 =?utf-8?B?eUt1bWt1UEZWUEpsVWR3MGZQOXJjZCtyMGp6bHBtaFdXZ3pHRGhCeHlxMGVu?=
 =?utf-8?B?V203UnQzT0lyci9BOVgwUSs4dmlXSlVSRUJYQjZuamswVzVhZVFJWHJuNWVW?=
 =?utf-8?B?OGduVmg5SnRYQ1NNUWNjd2xqSHYvVGIvUGRMOVlLSTRkU2lrZSs4R21xNjAr?=
 =?utf-8?B?S3dxUDZHdmhCWW9Jald5Ti8vM1h4Vko4elBKVmNHUDJCUExWSDNYUysvL2J4?=
 =?utf-8?B?aXNld24vQjkwSmxTMEhOeEVsRjF0MCt6QjhDNDR5b0Q5SHI0VDZCU3dLdHUx?=
 =?utf-8?B?U2dKTDA5MUp4clU5M0p6RVltZmNwemh3TEs2SVF5SWZvcnpCWENZUFFtcDRu?=
 =?utf-8?B?bGNjNEhURzI1Nmxobmk2Z2FlamNxYmxxcExRQXhFbFpZTW9jRzU1VVo2LzZ5?=
 =?utf-8?B?eHJBalkvM3U3UlhMUVZpczhTTFNiYXlZSVdYTHVuS2dydVhZLzNoT2Y1OFhS?=
 =?utf-8?B?NUM2cnhRc2dHOG1SbFBhZVh0SXZKVVBQUmtUbjNXZSs1ZjkzMlJPeTJ1RGw0?=
 =?utf-8?B?NDFKVGhRK3RjNlczYVF2VFpGVzJnU0lXMGZFQmxZWmFEQW5nemdURGQ2dHRE?=
 =?utf-8?B?VzVCYUNmMW0wUjBoOThlNTJHOUFQVHF5Rnl4aytKOWY0UTRBU05SdlpGdDh2?=
 =?utf-8?B?OUlpMk9Tc2V4bks5SkVGd2JHblR6dHlKdmVlNHFSV2JHU3JJUFBLYzZaUkVC?=
 =?utf-8?B?ekZLRGJ6UWpqbGdwdkFCNi9MZ0RwTnEweVpoQWhSL0ZKWnR5OWFXL3M5MkV0?=
 =?utf-8?B?SWNCdW5JaTFZMTIyV01ZanZJa1NLaFppcjNnaiswZEJxZjhNMGVjaHRxTnk4?=
 =?utf-8?Q?O52C7KAW49OZ74r+PMl5qKxm4oYvIXMluO6dTVpslqtYs?=
X-MS-Exchange-AntiSpam-MessageData-1: bMnt8fLsX51hRQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa448ae-a006-4367-0669-08debd2cb7c7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 02:48:09.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNqStpiKjB4B2w5sQnlyiL6ZTsVtZQbweSGacI7GvUx7X3bxhO4enCbabI6qyHsC3/qR/mSkwti+Udx5Q1hsJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-9198-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5D0555FC88E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thierry Reding <treding@nvidia.com>

Tegra264 has a number of PWM controllers that are similar but
incompatible with those found on earlier chips.

Signed-off-by: Thierry Reding <treding@nvidia.com>
[mperttunen: Adjust commit message]
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 72 ++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 2d8e7e37830f..d08adb60ade4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3336,6 +3336,18 @@ i2c3: i2c@c610000 {
 			status = "disabled";
 		};
 
+		pwm4: pwm@c6a0000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc6a0000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM4>;
+			resets = <&bpmp TEGRA264_RESET_PWM4>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
 		pmc: pmc@c800000 {
 			compatible = "nvidia,tegra264-pmc";
 			reg = <0x0 0x0c800000 0x0 0x100000>,
@@ -3631,6 +3643,66 @@ i2c16: i2c@c430000 {
 			status = "disabled";
 		};
 
+		pwm2: pwm@c5e0000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc5e0000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM2>;
+			resets = <&bpmp TEGRA264_RESET_PWM2>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
+		pwm3: pwm@c5f0000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc5f0000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM3>;
+			resets = <&bpmp TEGRA264_RESET_PWM3>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
+		pwm5: pwm@c600000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc600000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM5>;
+			resets = <&bpmp TEGRA264_RESET_PWM5>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
+		pwm9: pwm@c610000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc610000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM9>;
+			resets = <&bpmp TEGRA264_RESET_PWM9>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
+		pwm10: pwm@c620000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc620000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM10>;
+			resets = <&bpmp TEGRA264_RESET_PWM10>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
 		i2c0: i2c@c630000 {
 			compatible = "nvidia,tegra264-i2c";
 			reg = <0x00 0x0c630000 0x0 0x10000>;

-- 
2.53.0


