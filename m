Return-Path: <linux-pwm+bounces-9503-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V+dzEsqIRGoOwgoAu9opvQ
	(envelope-from <linux-pwm+bounces-9503-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:26:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 929D16E9766
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:26:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=iENXAWsX;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9503-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9503-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 974A131114F6
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 03:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70325367B79;
	Wed,  1 Jul 2026 03:21:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012011.outbound.protection.outlook.com [40.93.195.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D82367284;
	Wed,  1 Jul 2026 03:21:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876090; cv=fail; b=FLOqcCA1krSJGni1B8STMrJWd3IT5My+zhdWnU97i2eVA2VyQIjmY7OgrB4aQnBVetc5mmRfQmTfTT18F3C6mRflW4CsC4NPHwuL/gPj5IYgni7k/R5gzD/NqHo4TeAybxFlkeLDJMqnBKSi8v4O6lcz/bAf2hvIAdH6k1kRzjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876090; c=relaxed/simple;
	bh=GpUTB17lwmVLkDn/mHi5sTAIlEq7jD9P7wnKsIMooQQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H5G/hRowuTN4xXvMELCCHyGvcuTlhBxzN48wL9i3OKJCnLw1sFTcOm2e5OoGOkiNG0XP6GUq6rLBvwGdS1/eqp6BKtz7+h57KeuqeQ/pgUV1XzHrmBIfuLMKOrEC+NC/RSUucNUt9g1vYah56AfuIAnq7piRz8AF27VVNe0nlBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iENXAWsX; arc=fail smtp.client-ip=40.93.195.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EG/4Cbi/dt26qGINW90J8Rr8bi1r6JDKGVPIRnPOtZqDJ4tNblatfGeunhrAoRLanQoezLqge/vPE17NectO4lP2RgYL2y4HCKpdXGSgZgJTYx3GJ64MY2iyAtkB/N0mJbendkfUAvX3wOvNc96hguHgGnPiWQr/aizG+nKm6+U7+FWCa8QjpDmf5fjJd4092fI1cDZ03rrKtp+XTiBLDm9EUKRtbpJ0RcSj06NMnEwcw5qD6cbarJJNbl3L9bn3A8QrwuKYNeQ3+QcggnLG9k9yxCcXJE/6zJgxIw/kotrNEW+C3CGLI/4aneGPORlCOk8WpzKhEqc3dzhm4UtfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa36zEqvTe36NIQZb7URe+gbrOPdAo7i6QOABKuvSQc=;
 b=cymyQFiDiw+EKHpaWKnwwc+NIJnZvrDHjMTrUi6tCYMOs6tS7tn6yVFTM1iNi6r/Crruc/9Pr+xeveOdNoAblLcBf5Uk0E0Cz7rl9Y56cDdKQpsr8UtWaHidwYmnIhtB0VD4y8CC6y+lObBeu26fFoRLO40upuisULW9ItghRxyYm9SmMwzBprVsFqNkDA72lmPG7RdLy57+gSjpXdQOTvPqeqOneBhm8Bk0foh3/EXCXqF4ZNfBF9uDYrMvicLSA+hYIB6yuMMNR6XSRw5+GeHLm7lbZPbxb0QO1lefF5a/ZmeX3L9h6O6UigSF7Pp4z1xT6Uwe0ICb4g+usoHNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa36zEqvTe36NIQZb7URe+gbrOPdAo7i6QOABKuvSQc=;
 b=iENXAWsXqoMF4eNrViHGNS3AbHJF7J4OHWX18R9HMQ3lC1XHUQ1c+SmBEnXGYOFKqC82eu0jo0ZJFrdLLok8yoM4Mx+qWfDvSf05gfghd7NWifQrJAmHzZ35yYww/+l7vq+sOLwS5hD91fD/COZGuzTw7qEGUrljleeA3BwTQBEUaTgIb+UoCttVQW83pJidg1J0zXpQl7jHrAZNm/GBdddlogYo+Txp8xr/QNEIGs/J3+C1ckYAKBlqIFxVGSNlR+iNOKOBdxhx+uKPvoH35Y8/sZitDXWzsxxzGYNf1XqVAyzheYeVWnSPe4lpvCEPN3HgFNd18UJmYmBkP+5Ivw==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 03:21:24 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 03:21:24 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 01 Jul 2026 12:20:36 +0900
Subject: [PATCH v6 7/7] arm64: tegra: Add PWM controllers on Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-t264-pwm-v6-7-2718f61f411f@nvidia.com>
References: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
In-Reply-To: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
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
X-ClientProxiedBy: TY6PR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 496b8195-de17-4296-a262-08ded71fd4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10070799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tU9wXXLwRyBxCXFzXxYbM+EAaXzr3hqGtYMeUKPeuHOb6mrLB1kCU9FtceIAg4dc93FC2deuqoSKOd31pvf3zalIKRAxymJFPCO4o1Osb4DAcAW27lw8m++qa4ckbHuS0+m/ml9kwTQgTBKlEHd0bQpFOJs8CxqCy4VU3AfQriWI+hL/xgMC7X4QrrLaLUoHHC9DDDv6i8jeqqFMK2SLzsweJ2PG6OIfPTPsVf9YetrdMWVRaekublcka4wI8UpLQBLe3djRPX9NXq5BUhQ7TUudhwFOoIEgDdFcbiT799yWm++PynfRRVkwjvQCFzjhyom9qe5MmC4Tpun0T91/tTSUKQ6hZLRVLie5eSoWChpkYXiMbY4L7M71+Y6LAKRKKuM3LtH9rXoB2J/U0+ZO9ewYJ5Ucw/syMCIqaHFX1pSjUey3rHCbaJlgSyMrvfT+Ck2CcI90Vpk2OfZtuXARn5VYpqPcfTyafy8obmjWVdZT/ajlgL15j31aaZczvHyFTFOROQn52dZT/jOnavijsexd39sS3odfdd1jIcuIHCYeVbniWpfsj6urdYxnaP9pkVtlL4habVr9SuE90iD6IL3QHIqFaIeN31ajLBVDMNIm92SHnep+g3VM4+tes5cI2GtDmpZrnWtncvy9OCMctg2kxM00N1nhb84+XNNB0/w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2t4L2tWYjVNaGgrQVd4NDU0MWViRzdlcEYxYlRPQVVxam5DdHlrbE9xRDBp?=
 =?utf-8?B?MGczMFFqOGJuNG5QaUJaSmVnM3VLUFNQcEdXRERZRThubVlSdnNweDgwRXN3?=
 =?utf-8?B?dUZpWUxEbXFxSGpDKzl3MjdWak9IblJUK0pPRmpGVFpVRHhEWDdjdi9TNzdZ?=
 =?utf-8?B?ZFpnREJZQ0UwMzduUW93MXB2SGNLQjhRSWl0aTlDUGhXQ0daK202RE9BalA5?=
 =?utf-8?B?VjVCSlNsVXBhRlFxTUJFUE05TFI5S1ZxMi9oWSswM3RLSjlHSE42RkRlWHJV?=
 =?utf-8?B?L3c5RmNDb3dGTDVHQXpOS0lPb0g4dVREbVRxTExOTExPWm5HYTdJUVJLaW5U?=
 =?utf-8?B?TkU1TEpBZ3l0enVLeDI4ZkN1MFJ5MzlPMmZUWGtYSnhmL0FVV1o2VEJaTjBv?=
 =?utf-8?B?aVhObFdYbk8wSUNXTTJ0aWVFMnc1cGZBSU1HdXVVUjJ0MElmRG5pYVM4bnlv?=
 =?utf-8?B?dmIyTTJTUlRoZFRXaG1RU0ZVTUVTMi9Od1B4RFBIaEtEdlZCODBhVEgyZDV6?=
 =?utf-8?B?MUlyc0hzbGhtNGlSVWx6SjVIaFNOYnVBNTdqUTA3ZExLV09yY3BqNjF3Wkl6?=
 =?utf-8?B?Rm9tVVJubjB1RVRuTXBWTWF1eEgwMGZNbGtGa0V2ajdnNnVGYS9JVkMzY3dD?=
 =?utf-8?B?ZDRTSmU4Z0xCbEJ4cW1nNGVHOTJsWTUrWHRpTU5LbEZNa09TU01nMXlDb2ZD?=
 =?utf-8?B?dk90dlMxQzhzSDliMXNQT2IzTXhwbWtYdnUvNE5mNjBxb1VneHhlZk1XK3NR?=
 =?utf-8?B?YTNNampzQmI3QU5FVjZKQTJwdkZNRjJTcWV0dkMraFByaGU2b3hUck40VUV2?=
 =?utf-8?B?blBIS0puRTN2cjR6M3AwM2pSeUtNYkgwZUZYOFp4NHBzVkRiTlcwc3lpTTZz?=
 =?utf-8?B?RFpuYzl6S05xMjlnZXFhOE5PUkFDWmZMM1dMSEd2UGpTN0VLUVlTWlZhbWpt?=
 =?utf-8?B?a3ozMUNQSldiYjFTMXJmT2ZjLzhJYTZWM1dsUzkyOExYQzFIdGZMdWlCZThS?=
 =?utf-8?B?NS9mLzhraHhRVS9WTXZYL2xlQkFoZDN0VkNDb2pialdBekdFSm1uU2hvcDZU?=
 =?utf-8?B?TlA3WnRla1IxNGVaNG5UTVFGQk9TZmlneERRdkZwcStKUWE1UGhOZkh5d3A4?=
 =?utf-8?B?S2owME1KUExDL1AxaWZ6UkdwanE5Q1BwN0p2Q1NyUkRMU1FvTnI2NTBZN2FW?=
 =?utf-8?B?NEp4VFgza2NreDZteUFFWXI2eTJwOVFrTG1HR0UvSmRDVVV3b2lBTForRHIy?=
 =?utf-8?B?Z05WRytaZGhMRktZMmpuODI0TEZsWmdWVHRTMXlVTkJZT0w2YmhSc0ViVkxo?=
 =?utf-8?B?bzFXRmtxVXpKclQ0Qyt3SFB5dm5ITmNvaFNFQWRzZ20zNVVuQ2s5TW94bXcw?=
 =?utf-8?B?Y2d2QXhESzRnRjBwaEtQbExJNCtEdkF5QVZSZU8yTUQrQVdPYWE2R2ZlaWpq?=
 =?utf-8?B?UFVwQy9GQU4xc3h3ZkJ6ZVcrL1BMd1RMQVgwRkNzL2w4MERjdy81VDRKRytI?=
 =?utf-8?B?N0x2WS9oOHFFQ1p4MERPSEk2RG1hekxqNUp5WCtNbWFId2NWbEJ3bzIzRm5k?=
 =?utf-8?B?ak00UXgvN1RpZHRSaHVYOGN5STljUWUrUWx5VmJlbVF3Qml2NnQzV3ZVTWxZ?=
 =?utf-8?B?UUZKZ3RaL3NlbjQ0dXlTWGNQNkxiekdrYjlwZnk0WWc5Rkp5ejVvenkyRmFZ?=
 =?utf-8?B?ZkdJVGZQa1JpTFdUVEhQbEdtV2U3MW1wMVNJMjNrc2dObFJ3UHJ5TkRMajI0?=
 =?utf-8?B?eVZDNmdTNTZjbTV3eGoxUjZOUDFVRDNDYlhqSmxsUyswVGxHSG5XNWlnQVQ0?=
 =?utf-8?B?NUdFUFRKSTJ2eHQ3YWwrTXAvOXVCZmkveEdxL1pXR3JZZDV6QUU2eW5HTzlv?=
 =?utf-8?B?OVMvUmNBRFBIalFtRytxUWR0ZGRPeU9neHF1bnlFbVNTQ3JrdC9NZEdxOE4r?=
 =?utf-8?B?RlYyU2QvZHcrMWQ5R1RXMUE2NGcwVEdQWllnWi9wRE1MSzBNYWRNQkVua1Y1?=
 =?utf-8?B?UWhGd0FWTE9BTld2RFRKQ1lkVThMNlIyZC9GN1pVSWNJMVRxT0V3MU43ZU9r?=
 =?utf-8?B?cjZ6akRDU1huS1d5OTRQTXFtRFpraUozR0ZKcTJLc0tldHBpNGhnK1hkSXdB?=
 =?utf-8?B?Vm1renZLMDZLN3Z1T3N0RTV6WGtLaElvNndvRGFUeDVyZEdWa093THhCVlhW?=
 =?utf-8?B?OG1idFE1UjJtVVJmQVozVHNJMmwvMGlmZlJlVzQ4MFhwUFQwWjUvUnlvbkFD?=
 =?utf-8?B?MkNPa1Y1TU9pNlVtS3lzNkRma3dFbm11TDlpN245eWwxWklWMGFZRmt4MG1h?=
 =?utf-8?B?RE11WnhEOE45Z0NxUUlNU09Lam5BZXQ5M2hPNnA5NmFMbGpCblVjcktnSCtl?=
 =?utf-8?Q?yAipctQe3K7QlddDLi4t1hAFNYwJKn9Y3pMwwFqgyte/2?=
X-MS-Exchange-AntiSpam-MessageData-1: PD0qgrO7ohArkA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496b8195-de17-4296-a262-08ded71fd4b9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:21:24.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81YodGHgAfh3r7rcN9mZQ7vyxGOUgbtzJmis2eCAyTxki33V3JTYBMaBC6xdeDhXWOOIS2eLmTYT7Ce2CXmLSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9503-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@gmail.com,m:ukleinek@kernel.org,m:jonathanh@nvidia.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:treding@nvidia.com,m:mperttunen@nvidia.com,m:thierryreding@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 929D16E9766

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
index 06d8357bdf52..4d2921d6936a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3380,6 +3380,18 @@ i2c3: i2c@c610000 {
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


