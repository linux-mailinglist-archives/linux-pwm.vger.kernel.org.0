Return-Path: <linux-pwm+bounces-9501-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bkpKMb2HRGp/wQoAu9opvQ
	(envelope-from <linux-pwm+bounces-9501-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:21:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0596E96E3
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:21:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=c1dtITWU;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9501-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9501-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56CFE3010F13
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 03:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0135E36605F;
	Wed,  1 Jul 2026 03:21:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECD533ADB2;
	Wed,  1 Jul 2026 03:21:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876085; cv=fail; b=W/pV5NBKJU6jYInIgbYx8I8jEAcdKZk3zmuEpx0bIDRaLjIGUtfIVXJ649afPLPQqoY9ZYxhFMhTZoiTLkXeFAuKsm7IPYDflKm/xrJC6cm+XXUBe3aEk1heVoDBlg4mVzRqfFNFYVrS4EUkOL/SBWBm/Oa4Fae53g0r/DEMZGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876085; c=relaxed/simple;
	bh=VzyqMFf6O9BrlG3Ib92xYJXWrzUIbwO/jToiV02FEqE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CfzuYmUEZ7flYMxE25VzfOFPBBolIM8G4UoptOAtEHq1LGznU3UV0f/wpAGapsEA0sHqwjicUCCeXEHjUoMt5u/cTWYYAaKbqAZ4Aq39dQML6i+hUeATbA16z0L5FbaYvfSqbdgnB8J4ljNh7mUDOzriCx5K5B/yzkq8NYhDMjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c1dtITWU; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mq8MIvhHqzcykwiRPFzWoN0iUBsmhWv1GZ2MQm8PBesVWbWOw/oDiwz/an5Dy+to+Pp+cHqdAWso95a55bkUMuuwsSaONO/zaljbnBe4aXuAtpubVeHECQWhlrBzkXVldRmZSnxQ/jSV1tLx/yckPK8Yp6h8ORaaRj4aMUWTc67WxHgZW44IJ5AQA/pPD/Obj3p+O13nELcrEf7ypW80yhb9HM+2m7KL3oTR7wRxr+QcN5+P3AO5Elu5Dqgs/08LwR19x4nQYhPb9OUVPQdfqCX2T/7wDLK2GreJL/mD/m9hFX4zBxtILwFZ0OihEhWt5qS3IivXxya5nnAPsAyW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWcXECxGWmw1CDrGiXT4ZpzbL8ZC8ida9v+shFn++x8=;
 b=alDxjYrB9my0rhkLuwasK1ATB676HPHUYYm+abnmexWSzbK8+V1OD5097YOi6c2DkKdFOMZOMDJPqikbBtjwobal0f8GwOQ6i/DuDpmDrolYNN6vKAzp5Klr3ETMQNhGdIMK8BS25YHq/GtVpejeufMuxknGV9jSshF9wRL3+irawc1FuV3SO1z6fAFGP9vqiUmHAFEqy0O1565pEDwVWqR+E8ZPnjUKuo1v07taqkIhtz2IkV7/BLdJF35Qs4PLO98gupWY8xgcQgvC8/xQbMyGpChtiHCtS4UY+G9c8LLmOWno+USuurL7SB6A0oY93B59cN8+rFCJbXh2cfn0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWcXECxGWmw1CDrGiXT4ZpzbL8ZC8ida9v+shFn++x8=;
 b=c1dtITWUbi6Sp5VNucSM6GTjVxHCjNf+tGc5RdMZtcVLxvCa9GM7T/U8EJInlVM4XOos7BKvVpaADHDNfjpsq/AXIZafBMSDQdX3899lPpQF/z2vxGRhWSmuOLg6x1mUHxTd6UhW3hVhyf5Mndk91vykbBJhjshVxdPbUN8eHOWBjT8xNNd46wlex4KDRW0Cgka9nKXQ7J/OO+O1fPSHUqZRnmblL53QiaXqlxHBI8EkhG5AVWhyCZQPQWyJfI3tA78MAYtQHHTwjKddYBbweYhAA7K3uwdV+JbgOHinzQiLIIiuGM9XXtOuRXJZArthZXN+eXNUgSzuL8v4Pnpgcg==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 03:21:17 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 03:21:17 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 01 Jul 2026 12:20:34 +0900
Subject: [PATCH v6 5/7] pwm: tegra: Parametrize duty and scale field widths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-t264-pwm-v6-5-2718f61f411f@nvidia.com>
References: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
In-Reply-To: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0082.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::6) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc354be-8346-4417-597c-08ded71fd06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10070799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VoqFL0TM4knJXRZ5PDKWFFfi3+RIlPbNmv5HEO++BxSOIO8GH6YcarsH09C6S6nAmdQkhhQrXk2+Ya0vK7LwOnH5PnhCSVoUSDgm6oNt15HTbE1nGUiwskAchE+RNQKba4gpyxCn5o5HdsWc9+jytt0hz4j8i4FgtApnwYV1mWwvnNE1BzujxLpW3FRLmVtjCJ6cexJyTQwLgv0mOQyLat0uDhbuTqvRa8jzbUbS2Y4tdQsnZz22q8JqcuK4nyh1uAa3uYWhmVgB7dSlgowyze9dgKh6QleP3EssZvoFNw1CU2FkF2a8sEeaonC/AlXompfQvpP0v3v32r0856btN7g1VrHAeYc0E8EKPuM3fn+f7seCtOt2O0jSF+LLiK+vcN2jx1dC7E3uGZQzoGCtfGAZXnXaxBeDoiKrfw219lJydK7r/YHAiEsUk3WmPV5Z6Ev8ir6YjxhXLtbfD+Tt3fqxZaGXD5zeW1XS0EhCIOAOCFDkvJGfRsAVRWCudQshc2UX8zt0oAQpkwcxiG2vrtclG0xfEJf9Z50VK0GB1kgHh2lYp/dDM7mduya5VZkuEmC0cHc1fvW2TXPP45kCRMneayAKeQcjPVb67fsFJdWnFH73NM8uX3DntlMB7Jb0jJNMGyISEfaUKAj8EIkMc3+hL+6vPLELEs/J2iWm7Q0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0pqZ2VITDJFa3RaMnBVb0Q3NWxvNTFiam1rZndmUGRKbCsvbVJmd1hLQklV?=
 =?utf-8?B?d2UrTlE4WXc2VjlvVWFkZy9wbU12dG44WkFQZk5TRWlnM2w3K0VhekpmVllm?=
 =?utf-8?B?ZndNNmtiMHR5R202TlIzOTFCNHBwZWNabTF5N3ZHVHd0dGVyblYwWThVS0gx?=
 =?utf-8?B?am5MRFJTZUFFYzlwWk9jS2dDeWYvcy9TRE9LWlNWbTFjL1o5bTU0czAvSUd1?=
 =?utf-8?B?ZFpWWHFnMkdiTHZCL21IYm92ZjJKUW5vYStJYmE2VHBtMGhySE45SmdEb0F6?=
 =?utf-8?B?YStNOVdzZW9ZY0drVlNxU3B3VE00ZGwrMlpBZEVZQTEwZ3VvMG5TWXpUa3gr?=
 =?utf-8?B?WTNEM0ZXN0RUN3NMY2JQaXRYKzJadFpKaTdqT2phT1dVblFHSDQvVmVwSWR5?=
 =?utf-8?B?dFRQTVpZWE5RbGpKbTVCUnI3WEhiNzRyeE5SL2xFMXF0c3RIQXVRVmgxWEpU?=
 =?utf-8?B?eHdGNkJvYkx5bENKZGNMQkx4aTdTSGVhWHIzOVZKb1BtZVFTZVRiYjVjU0t4?=
 =?utf-8?B?dTUvYVBmd2NSUkkzQkt5dVc1VTdiZmZ6ZGFVTFdWa0RhZUZqUWVleUtrbnda?=
 =?utf-8?B?TVpzVUtvOXZBQzYvb1hOS0NXV2x2UlpzbC8yQTV2VllHUUM5UjRjVWFGZW1Q?=
 =?utf-8?B?RmQ3YmE5dVQ1QVU0aGczMk9XcGJEKzFKZ1BVUGdZdlE3ekNGcWI0UFVFeG0w?=
 =?utf-8?B?TmFpQjVnZ1hIRVhpM2FPVUU2WWRyUFZ0SVNjY2pyY3ZMbDhTaHZWVnh6WkYw?=
 =?utf-8?B?UkJJT1lDRlUyZWF3UnBOWkxBUUo1MWJmV3VLTytLN2doWVlSbFNOZ3JCa2t5?=
 =?utf-8?B?cnZZeS8wVnllaURyeTNxVjR5N1VrMk5GWGVJR1Z2ejcvdzFENjFDN2Y0Sldh?=
 =?utf-8?B?ZWRkTlZDcGVybkhtNlR3V3ZQS29OOWtkTERBanhMU3h5VkJhY01BZkk5YU5s?=
 =?utf-8?B?bFFSYzZONjA0VmdCbnp1MENXQW0xM0ZDaDJzWVJwWU9uRTZESDFFQXFmWFJX?=
 =?utf-8?B?Nyttc0dWaG51OGwyT2twcVlNd0s0VHhuOEQxWjlvS1V3U1lPVGpoYUdLN3BH?=
 =?utf-8?B?T3pxclg0MFBJK2kxTU5sMjAwUnIxREovUEk0cXV0Q2xtUEljeTJsT1ZKMkx0?=
 =?utf-8?B?Z1pqRVYxMmdJcmtHS1d1djVZWVVrQ2ZSV3VxTjRJWGhDa090OVpnVTQ3TU1v?=
 =?utf-8?B?SmhzN1FZdHk5ZDJxeUNaM1dOM1hFZmlFaGR0VHlsaFZsOVkzeDlHYkI0T0t6?=
 =?utf-8?B?YmRRZGsrQjZJc2l3M0o5REFPVmxsUFFUSGM4UlBLTkcySEF3QW5LUzJiUUVz?=
 =?utf-8?B?OTNuK3FYYkU5MGU4RFU1bUxxQWUvbVpHSm9PRFdTUVNCaFpuUGYrZ3c1NmQ0?=
 =?utf-8?B?a3MxWmZMTXI1NndnTFF4MGRZWk1JYlZVdlA4SVJIeXBIUmE2TEdzd2UyWUZ2?=
 =?utf-8?B?M1NlZkEvd3NqNXZOQ0xMakY2TTI4QktmSURHMXM1NjlBUVlaSUJmMm1WN1pv?=
 =?utf-8?B?NUE4MGQ5TUcwc3ZxNzg1QklLWEpCWWNsbjlQUDRaRm0vMmovenk0MmxYdXBN?=
 =?utf-8?B?MHZsSEoyc0tNcWpUbzdKQnBlWG1uUTdKUDhyK3V0VzZWNGxZUFhXSEJMeTBh?=
 =?utf-8?B?eDl2UEpGNG1JclBKbHI5T01meFNKVWF3VjYrMEE2alhuVUV6Y1lQS1NhNmxG?=
 =?utf-8?B?bk45UWNEUTNBUGlKbDJUaDlyaFQ1dUhLY2h4RHcvVThkTGkwU2VrdlZRWS9B?=
 =?utf-8?B?MmdFWU8rNTlWdGtscEFmaVlCaGNkWEYvRXRWVnYyUTJvRXlYTXhMNDJjRkZ3?=
 =?utf-8?B?SkQ4R1g1cG9lR0tzaXJ0SDJhZWpqbklZWGZOY3huTWU3U0VJeE1ZQVJOZ09j?=
 =?utf-8?B?aHJLVmNsWFgxWWRtNmtmaDl2TS9NUWdISkVyLzBFYm1pSmh2eEtwUXlwNlEz?=
 =?utf-8?B?RUo0N1pPM0ZYcTk1V1NnTjZHQTVnU1R0eUhHWE4vSWx0RzlSWDR3Z2ZGKzJ4?=
 =?utf-8?B?RTlMcHVuY01wS2ZSNUtJMUVaaEtLTmdUWGx3WFV2WWR4WC9McjViVmlPVHpK?=
 =?utf-8?B?MDNDU0U3OXRGM1g3STROZmVURTMySTZxL2FTMUc2U2xjdG1NRkdsZmhMSmZp?=
 =?utf-8?B?Z1YyeVNtM1NjUitZNG9RRHczMGRIUE5RYnJUTnNhK0o1ZEMwSkQ0K3Q2SXpL?=
 =?utf-8?B?bDFWdlZRd1hzT2xkbFJEdnl3ZHZEemt1MUxDYjNjRE1HOXo5UjdIZlBSd3pw?=
 =?utf-8?B?Rmd6Sll4R3hsZGJRb0Rld0h1d0VYSUNIcGVQM0RKRjExcnR2VWFhOFNZKzdL?=
 =?utf-8?B?Y21JVzl5SmFpRXNHSi91QWE1ZTNIS3QwOGthSUdrekNBYjhQNVVtV0YvM3Ra?=
 =?utf-8?Q?Nger7zGs7nhIVY7rHGVfwtRXxyEiLFj6bWyYilcpDklCQ?=
X-MS-Exchange-AntiSpam-MessageData-1: DRODavraaIReWw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc354be-8346-4417-597c-08ded71fd06b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:21:17.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flhH2obrzpKqZjDZ6f9gugEM5F/wOi7jjyN5wMxwN0QSpW66aR4ViyFCC5bZN0wdY6yrc+KVAHsp0UJzMSQp2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9501-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@gmail.com,m:ukleinek@kernel.org,m:jonathanh@nvidia.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:yiweiw@nvidia.com,m:mperttunen@nvidia.com,m:thierryreding@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF0596E96E3

Tegra264 has wider fields for the duty and scale register fields.
Parameterize the scale field width. The depth value becomes
disconnected from the duty field width, so define it separately
and remove the duty field width definition.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 55a3e8657013..ad75e4ee3410 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -52,15 +52,17 @@
 #include <soc/tegra/common.h>
 
 #define TEGRA_PWM_ENABLE	(1 << 31)
-#define TEGRA_PWM_DUTY_WIDTH	8
 #define TEGRA_PWM_DUTY_SHIFT	16
-#define TEGRA_PWM_SCALE_WIDTH	13
 #define TEGRA_PWM_SCALE_SHIFT	0
 
 #define TEGRA_PWM_CSR_0	0
 
+#define TEGRA_PWM_DEPTH	256
+
 struct tegra_pwm_soc {
 	unsigned int num_channels;
+
+	unsigned int scale_width;
 };
 
 struct tegra_pwm_chip {
@@ -105,22 +107,22 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/*
 	 * Convert from duty_ns / period_ns to a fixed number of duty ticks
-	 * per (1 << TEGRA_PWM_DUTY_WIDTH) cycles and make sure to round to the
+	 * per TEGRA_PWM_DEPTH cycles and make sure to round to the
 	 * nearest integer during division.
 	 */
-	c *= (1 << TEGRA_PWM_DUTY_WIDTH);
+	c *= TEGRA_PWM_DEPTH;
 	c = DIV_ROUND_CLOSEST_ULL(c, period_ns);
 
 	val = (u32)c << TEGRA_PWM_DUTY_SHIFT;
 
 	/*
-	 *  min period = max clock limit >> TEGRA_PWM_DUTY_WIDTH
+	 *  min period = max clock limit / TEGRA_PWM_DEPTH
 	 */
 	if (period_ns < pc->min_period_ns)
 		return -EINVAL;
 
 	/*
-	 * Compute the prescaler value for which (1 << TEGRA_PWM_DUTY_WIDTH)
+	 * Compute the prescaler value for which TEGRA_PWM_DEPTH
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 *
 	 * num_channels: If single instance of PWM controller has multiple
@@ -134,7 +136,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (pc->soc->num_channels == 1) {
 		/*
-		 * Rate is multiplied with 2^TEGRA_PWM_DUTY_WIDTH so that it matches
+		 * Rate is multiplied with TEGRA_PWM_DEPTH so that it matches
 		 * with the maximum possible rate that the controller can
 		 * provide. Any further lower value can be derived by setting
 		 * PFM bits[0:12].
@@ -144,7 +146,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		 * source clock rate as required_clk_rate, PWM controller will
 		 * be able to configure the requested period.
 		 */
-		required_clk_rate = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC << TEGRA_PWM_DUTY_WIDTH,
+		required_clk_rate = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * TEGRA_PWM_DEPTH,
 						     period_ns);
 
 		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
@@ -166,9 +168,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		pc->clk_rate = clk_get_rate(pc->clk);
 	}
 
-	/* Consider precision in TEGRA_PWM_SCALE_WIDTH rate calculation */
+	/* Consider precision in scale_width rate calculation */
 	rate = mul_u64_u64_div_u64(pc->clk_rate, period_ns,
-				   (u64)NSEC_PER_SEC << TEGRA_PWM_DUTY_WIDTH);
+				   (u64)NSEC_PER_SEC * TEGRA_PWM_DEPTH);
 
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
@@ -184,7 +186,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Make sure that the rate will fit in the register's frequency
 	 * divider field.
 	 */
-	if (rate >> TEGRA_PWM_SCALE_WIDTH)
+	if (rate >> pc->soc->scale_width)
 		return -EINVAL;
 
 	val |= rate << TEGRA_PWM_SCALE_SHIFT;
@@ -316,7 +318,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	 * so that PWM period can be calculated more accurately.
 	 */
 	pc->clk_rate = clk_get_rate(pc->clk);
-	if (pc->clk_rate < (1 << TEGRA_PWM_DUTY_WIDTH)) {
+	if (pc->clk_rate < TEGRA_PWM_DEPTH) {
 		dev_err(&pdev->dev, "clock maximum frequency out of range\n");
 		ret = -ERANGE;
 		goto put_pm;
@@ -324,7 +326,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	/* Set minimum limit of PWM period for the IP */
 	pc->min_period_ns =
-	    (NSEC_PER_SEC / (pc->clk_rate >> TEGRA_PWM_DUTY_WIDTH)) + 1;
+	    (NSEC_PER_SEC / (pc->clk_rate / TEGRA_PWM_DEPTH)) + 1;
 
 	pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
 	if (IS_ERR(pc->rst)) {
@@ -403,10 +405,12 @@ static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
+	.scale_width = 13,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
+	.scale_width = 13,
 };
 
 static const struct of_device_id tegra_pwm_of_match[] = {

-- 
2.53.0


