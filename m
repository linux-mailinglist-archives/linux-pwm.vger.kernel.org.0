Return-Path: <linux-pwm+bounces-9502-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yEc4EKGIRGoIwgoAu9opvQ
	(envelope-from <linux-pwm+bounces-9502-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:25:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 902136E974A
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:25:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=AAlHeJ4f;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9502-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9502-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17F330F8639
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 03:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E536683D;
	Wed,  1 Jul 2026 03:21:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F63C365A03;
	Wed,  1 Jul 2026 03:21:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876087; cv=fail; b=A3FmQ+Jqm+4RGr22pHN9BnLIeLSxA5x/DrVmNZE4MN1Ur739UR/fszRR/J4TYovoNS+cdkJjl5jPJFokf7O4K1pZb8zbrUrDQ8vdTbTrdthLiK/ySg6f8X6SJDXzpZ95plB7ayzlRPpWkxzf8/s66JcCgqfa4nN9U1dPdfagbI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876087; c=relaxed/simple;
	bh=1/PgDqMJuHTUaDi+psvm3f7fHsWwovSjNVx/0i7Hr54=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c7RCEYzQbAnVMuUu6GUEA64N9hH8+gIl5ggCqNtdZwtO/HGC5w6HHHTIHiQduAzNFhw2iHSszI1BcDFSrdBzzYsheqpj/fKxhTofk+vqI9WXl02D4UK9NHQDfTsldQtsAE9VdUgVfE9P1EMu/F32LAqwyH5+TzXggNfGyEZ1ZYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AAlHeJ4f; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCmct1qz0v/XGJmpbjl0vJoEYBwSKyzMyy5vi8BW6tZieyq8wCiKvJgimUm9lvO93cGcBvXH6MJ+DUWNZ+NBXSuAcFLYSnU3epoPoxr7nQuXdQgsz3Ih/nAfz5JStma5Jr72/uovUadtcNQF0XNseVdFrlXPi9VKO48XNIJduu+jSiIL8JkFS35Km2lSFZzRKwB65E/dSgvXc8GEsnsYlrCbi3uCnITe2VnHnT6NV374yWTtTEBpOooNzYaN8VXwDCws/pCxQDsp2LsxU8zohil9cQ51ij26co3BniDhjw9D0iqny5I6+eDey7bYuyJuJQMYRykwlyFFGPKCqEiGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXSTlMaRpuu86oq1Bp9o0C0c3HkBPrSaoeX1nAQPyfs=;
 b=daasfY8hGeSQvegACOyIWCFWGjPKLYFuHpJx7T9HOGI0nTeN/1YKAx1p9BGEtwITi7obQ5bNvSJG/79f/FQGMwQydLLF24DTNOdqHk6Y2jvO+LfarMmem0qurimJCkc9WYPJDbZ4lQP1tWJVGUb+fwh+AvSCEeKYb2K148IMV+A0hZ3PEHofeYKZ5E/HO5JQ4CPD4VNa+3lAeS3hpTDloTl7Qh0kTuxtzNRJhLu5FUXGkZcuTHAb5uYz156TD+wGS3tZnq4iCvGTQN7R8vBtUuTYAtK0N3lW5JN3IpMiYdqp57AjXCjnMaaZXTWTor0LXK4pxC7F/zRT5SjgoC0waQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXSTlMaRpuu86oq1Bp9o0C0c3HkBPrSaoeX1nAQPyfs=;
 b=AAlHeJ4fKFmNLq9G1pZLO1c2rlmdl3qMJy5ZGpP+D0lTJ5zIFiFUhsztMMp0V0hpcL/piVPEt2Qgw4jxHA5ahDiOFbaIrV6+WTx2isMru5cVCmpUudsKjQW51DkIf03v6t+MWVKAimAGtCnBhoOB5N3D3NKFDFivHuCqz1F8YcQf9n/N12CKEWp9tvBXdlknnugAFN/SQU6Cww11AvV1lSh/yWrcxTsFdbeJx+Nuy/WbefD7YTfNsTbPabQ+CssbFutXFasBOiQ2xwhzI4eJ0BDS/GrLLIx4CZkA3eaIDEdTuN9Ir9rUDUx9dE/2STwp3UZQh0u2lQ5Y8Fmlp1OARg==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 03:21:21 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 03:21:21 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 01 Jul 2026 12:20:35 +0900
Subject: [PATCH v6 6/7] pwm: tegra: Add support for Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-t264-pwm-v6-6-2718f61f411f@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0283.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::11) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b6d61c-3cb9-4caa-4031-08ded71fd2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10070799003|11063799006|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8Fed8UdFB2NSAnicAbJiAeHZNGME4V9Ln6YmvqSokBviz6QPSUBi4aipJ4RhkTbUz/zOO8KN8ZCofHfjM8S3C84ZDXCeJI2EbW01Rdkz6HU91kQEVzJn6L4ZvnP0uvPlh+TE3qOZV9CEShFsvtIEVSBsNo5zvj/6ArUnozV9z+3Jw3YqdpowCY+TktPl22OWM0r1dUCUfHmb429R3eq3Ki0dpH/yNMjDwe2/4rqXQsZ8MhZzW6oTLZH2dqqcXINc7sVjaDIlPNkHC+moDE/DlmnKfGF55fvEyErcte88F/tJTqVaVxirvH9/2xc3z+J5wB3sO50BxixzXSRlKjGyEHsbOnHIwBTKKm3B65JxpaI9ADcyDPVyp8N3heCZSwXdfR9QB+XvIn1cH5h3B3vjEwc4+GWJMfqlZaUOPs0keRpgyumtXlXfCmTekeqRxrvMfkODtLPr2SVN9xaGwXsBMcHwNSvBpunmnUYhEMkgR7S4cR4JeQt/fSKlUiy/4d44r/+Tyw7u7cFm1OyvopLKkJaQroEo6435TIjesVRdTFA/JrwzEjladPvUHBpJjtypKJvhjKTdR61RZCeCvZZdWK2kbulQCeMBqQtZEtFBCHNhQo6p0IR30i7Xp1xc6Wb/a/7wV9FyEkdi0LjPDqVL4cLUGLlSInq+05c08fNhHfQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW13UFh6Y3VTYUZmTlkyQVFoTHlXNkM3SnZkbkliN2JPNWh0a3hrbXhHRGZW?=
 =?utf-8?B?Mi9JbS90VDdPRlljeklWZThlVHUyZFczdnRjYXVlNTV6MnpiV2xOa1JLMjZp?=
 =?utf-8?B?bHNScnBlRGs1ck92OG11Q0VzTFI1MytOc2dXYXJHWTZRS2lLTWkzZEd0VFlX?=
 =?utf-8?B?OVFuYmFPeXQxQ3VsOHZ4bVhxcWpaUmZSTi8wanpDTkFLRGtnZE9tU0F2bkVW?=
 =?utf-8?B?dlBrYWxuRzQ2T0ZXUEpvYTdiZVZiNXlVOTdIRFNwM2VlVXlSZC9HQUdHUHQx?=
 =?utf-8?B?R1VxZUd2ODBoOS9qZW84UjcrbVhSZVhvTkExWVVZZ1hPN0ZBYXhxa3puVVVH?=
 =?utf-8?B?YjVZZEdhUTNyd0JrOG0xNU9Xdy8yaVhQRWVycnhCekV3dVB5ekRYTE1XV2Iy?=
 =?utf-8?B?LzFDMFNDQUJhdUNKamhIQXh5ZkNZOWY3QmpGY1ZycGZDSTdqazJhVWhKWTlH?=
 =?utf-8?B?cGR3dmQ5dkViSFEvMVNUdUthcVE1ZklKOFJRdXlrRVdPdDJCNDhEU3o0MmxU?=
 =?utf-8?B?UmRYbmdCajBJemdrNWZtTlVhc2pmM0YwK2RBejJRd1JMUy81bWlSQ2hleXpN?=
 =?utf-8?B?ZDdUb3B2bGtmemxrNUNuMGtPRlpFb0lpMnErVXh3SjREV0NOOTFRTzl5alln?=
 =?utf-8?B?cGhLTTBlVnVhY3h6STNnajB4RUtHZnhXVWY1dFpmWFBaQ1N1K3lRTVAzQVgy?=
 =?utf-8?B?NElWV3RpZFJMQUJnQndRN2lrR2l5emRsQS9rRUhMSnk3d2Z1N21VV2k5YzZj?=
 =?utf-8?B?dHJxMFg5MXcwUlJlY2sySElsK1gwRWd6ajRaclJjUVo4eWVGb0tXamx4NHIx?=
 =?utf-8?B?dnpmNW45RldLUTBwTjFubnhiZ1JKMGpnaWVHZmpTdVJwaU1YYmMrVEczNzNV?=
 =?utf-8?B?Q0RlREppUzBrcG45ZHRZQmxDSmZONWQ4TTJMR3pYakRBMy9ka0FuaDhnWkd6?=
 =?utf-8?B?VG5RVERNT2NSc0xDaFo0MzIyQVJpOCt4QVVzbVQ4cEk2MlZ1bS9EeWk2aWN3?=
 =?utf-8?B?KzVEeHZZbWhSYnE5WmRvUzFMdHVkYUY1bFdnMGRLbzhZeVBCR3NMRktncldx?=
 =?utf-8?B?S2F4cWx3V1ZnUEkzajg0TS9JcVphWGRnM0FXNUN3aHUxWGNpSTBCWUFXc0Jh?=
 =?utf-8?B?NG9oRjVWNGdtZXVxSnpULytrYlgyNndoSGJGT2JhUitLeWtZK2R5VGs3N0lp?=
 =?utf-8?B?K3BEL0pCdGhhZnlKdVI1N0I1NjBYQnBpblRtT3lQOHYwN01WNFNTVDcyTVN5?=
 =?utf-8?B?VWVjUFFhQzJUY2t0bVVzeVZvZCs5TUhUdUtSdUxhU095QWV6aUlXOU54QU8w?=
 =?utf-8?B?eCtTaHpSWUkvaVhXTmQ0VWRaSTVXYlFSWmR1VUxZbkJUMi9wWjkwVHlzMWpE?=
 =?utf-8?B?K0Jhd3pvNXJQQUxPQ0htR0RkUmJOVHBWUkRKMU44ZXZ1ZE84WHhVMys1STg3?=
 =?utf-8?B?MWhxQzZ1ek91YlF3aHBLY0UvUzdEbHE2YUZMQk5MNHlmanNQaHdDaHJGbnoy?=
 =?utf-8?B?Z2Nha0M0VWxnMWlFaDlyUk9nTDljS3dlaW1vM1BJdlY0aDZWZnowK21DVFJm?=
 =?utf-8?B?SllzaXQwTnM2TTQwSlUxcUY1cXY0c3d1ODdTWTd5SGpYcEZkQlBPblZlTVQz?=
 =?utf-8?B?ZnlMMGNkakplcWxFbzRyVXYwZGdMUkV2czU3MzU4ZHJtL3lWNHo5Sndya0t4?=
 =?utf-8?B?R0p2RUpqV0djcEFETDlmOFJIQVhTeTJiSG9Wakh5Nk56ZWV6K3IwVGxZZlRl?=
 =?utf-8?B?eDNRTGkyQjZiWmdmY2VrclRoampsaDdLcnNpOGxIR2d5cXVUbkVPdDZWaTRw?=
 =?utf-8?B?cWlRbmtzNm9IN2tzOFRTYWZhMEJCaUZwNytpQjlXYXVuYTRBTHN5NFp0bWox?=
 =?utf-8?B?M2JPOUlaWUYyK1lZbnhLY0lETlpYRkpiZkYrMnVhdXJGeHJNWTgxR1NvUkNT?=
 =?utf-8?B?K1lDMmVGZnRVb1VuMFpxZUNaSkdFL0tJMHdKMDdxRnJjMVRsUzAxdWorNVJw?=
 =?utf-8?B?VEQrMWlwcEJhWUxVY2VWbGJyWkdhVHN3bVpoczl6OHNjVHVxYVJvK283bWZG?=
 =?utf-8?B?UG96K1BXbVdaQ1NHbXE4UlhJdE1VaFB5SjNJcURXdkRhK1cwYitjcFVsVlJq?=
 =?utf-8?B?THZ1UGc3eGhCZ1NoNmI0RnVrMmhYWEsxcUhNU0Zrc281a3hVd1dnZTNVZno2?=
 =?utf-8?B?UWc3ZTZ5ZVVkMlVnb1JMZmhJL2kva3A0Q1lVcnU4VE5GWGRLSHNjRHIrdTVv?=
 =?utf-8?B?ZDJHVXIyaHdLRHhhSzlCdURMMnFscmdvVHlWeS9zN0JyQWU0UFN3RDNEaWdv?=
 =?utf-8?B?ZU5uRTBmUERlamFwc3lrd2UwYmFwK24rbFliT2w4dnBmRmJzaitnTXIzdFZV?=
 =?utf-8?Q?1K/nyy0cWYvDVNJv7CTPkoLMDY0a2jvPptzaxe59iriST?=
X-MS-Exchange-AntiSpam-MessageData-1: 5HsEASvkOG2glw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b6d61c-3cb9-4caa-4031-08ded71fd2a6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:21:21.3495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npI/NHy7AmLRsCoh5x/3Mk0DgqamwHNq6a31CJN9SHB+/YVF2bB3WHQK8ybx4ZxOtZg6lFHUb7RlTiB8gIBVVw==
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
	TAGGED_FROM(0.00)[bounces-9502-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pengutronix.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 902136E974A

Tegra264 changes the register layout to accommodate wider fields
for duty and scale, and adds configurable depth which will be
supported in a later patch. The enable bit also moves from CSR_0
to a separate CSR_1 register.

To support the new enable register location, introduce an
enable_reg field in struct tegra_pwm_soc that identifies which
register contains the PWM_ENABLE bit. tegra_pwm_enable() and
tegra_pwm_disable() read/write this field accordingly, and
tegra_pwm_config() skips OR-ing PWM_ENABLE into its CSR_0 write
on SoCs where the enable bit is not in CSR_0.

Update the top comment to describe the register layout in more
detail.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 91 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 72 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index ad75e4ee3410..5cdbe120ba2d 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -7,22 +7,61 @@
  * Copyright (c) 2010-2020, NVIDIA Corporation.
  * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer@pengutronix.de>
  *
- * Overview of Tegra Pulse Width Modulator Register:
- * 1. 13-bit: Frequency division (SCALE)
- * 2. 8-bit : Pulse division (DUTY)
- * 3. 1-bit : Enable bit
+ * Overview of Tegra Pulse Width Modulator Register
+ * CSR_0 of Tegra20, Tegra186, and Tegra194:
+ * +-------+-------+-----------------------------------------------------------+
+ * | Bit   | Field | Description                                               |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 31    | ENB   | Enable Pulse width modulator.                             |
+ * |       |       | 0 = DISABLE, 1 = ENABLE.                                  |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 30:16 | PWM_0 | Pulse width that needs to be programmed.                  |
+ * |       |       | 0 = Always low.                                           |
+ * |       |       | 1 = 1 / 256 pulse high.                                   |
+ * |       |       | 2 = 2 / 256 pulse high.                                   |
+ * |       |       | N = N / 256 pulse high.                                   |
+ * |       |       | Only 8 bits are usable [23:16].                           |
+ * |       |       | Bit[24] can be programmed to 1 to achieve 100% duty       |
+ * |       |       | cycle. In this case the other bits [23:16] are set to     |
+ * |       |       | don’t care.                                               |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 12:0  | PFM_0 | Frequency divider that needs to be programmed, also known |
+ * |       |       | as SCALE. Division by (1 + PFM_0).                        |
+ * +-------+-------+-----------------------------------------------------------+
  *
- * The PWM clock frequency is divided by 256 before subdividing it based
- * on the programmable frequency division value to generate the required
- * frequency for PWM output. The maximum output frequency that can be
- * achieved is (max rate of source clock) / 256.
- * e.g. if source clock rate is 408 MHz, maximum output frequency can be:
- * 408 MHz/256 = 1.6 MHz.
- * This 1.6 MHz frequency can further be divided using SCALE value in PWM.
+ * CSR_0 of Tegra264:
+ * +-------+-------+-----------------------------------------------------------+
+ * | Bit   | Field | Description                                               |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 31:16 | PWM_0 | Pulse width that needs to be programmed.                  |
+ * |       |       | 0 = Always low.                                           |
+ * |       |       | 1 = 1 / (1 + CSR_1.DEPTH) pulse high.                     |
+ * |       |       | 2 = 2 / (1 + CSR_1.DEPTH) pulse high.                     |
+ * |       |       | N = N / (1 + CSR_1.DEPTH) pulse high.                     |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 15:0  | PFM_0 | Frequency divider that needs to be programmed, also known |
+ * |       |       | as SCALE. Division by (1 + PFM_0).                        |
+ * +-------+-------+-----------------------------------------------------------+
+ *
+ * CSR_1 of Tegra264:
+ * +-------+-------+-----------------------------------------------------------+
+ * | Bit   | Field | Description                                               |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 31    | ENB   | Enable Pulse width modulator.                             |
+ * |       |       | 0 = DISABLE, 1 = ENABLE.                                  |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 30:15 | DEPTH | Depth for pulse width modulator. This controls the pulse  |
+ * |       |       | time generated. Division by (1 + CSR_1.DEPTH).            |
+ * +-------+-------+-----------------------------------------------------------+
  *
- * PWM pulse width: 8 bits are usable [23:16] for varying pulse width.
- * To achieve 100% duty cycle, program Bit [24] of this register to
- * 1’b1. In which case the other bits [23:16] are set to don't care.
+ * The PWM clock frequency is divided by DEPTH = (1 + CSR_1.DEPTH) before
+ * subdividing it based on the programmable frequency division value to
+ * generate the required frequency for PWM output. DEPTH is fixed to 256
+ * before Tegra264. The maximum output frequency that can be achieved is
+ * (max rate of source clock) / DEPTH.
+ * e.g. if source clock rate is 408 MHz, and DEPTH = 256, maximum output
+ * frequency can be: 408 MHz / 256 ~= 1.6 MHz.
+ * This 1.6 MHz frequency can further be divided using SCALE value in PWM.
  *
  * Limitations:
  * -	When PWM is disabled, the output is driven to inactive.
@@ -56,11 +95,13 @@
 #define TEGRA_PWM_SCALE_SHIFT	0
 
 #define TEGRA_PWM_CSR_0	0
+#define TEGRA_PWM_CSR_1	4
 
 #define TEGRA_PWM_DEPTH	256
 
 struct tegra_pwm_soc {
 	unsigned int num_channels;
+	unsigned int enable_reg;
 
 	unsigned int scale_width;
 };
@@ -199,8 +240,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		err = pm_runtime_resume_and_get(pwmchip_parent(chip));
 		if (err)
 			return err;
-	} else
+	} else if (pc->soc->enable_reg == TEGRA_PWM_CSR_0) {
 		val |= TEGRA_PWM_ENABLE;
+	}
 
 	tegra_pwm_writel(pwm, TEGRA_PWM_CSR_0, val);
 
@@ -215,6 +257,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	int rc = 0;
 	u32 val;
 
@@ -222,20 +265,21 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (rc)
 		return rc;
 
-	val = tegra_pwm_readl(pwm, TEGRA_PWM_CSR_0);
+	val = tegra_pwm_readl(pwm, pc->soc->enable_reg);
 	val |= TEGRA_PWM_ENABLE;
-	tegra_pwm_writel(pwm, TEGRA_PWM_CSR_0, val);
+	tegra_pwm_writel(pwm, pc->soc->enable_reg, val);
 
 	return 0;
 }
 
 static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	u32 val;
 
-	val = tegra_pwm_readl(pwm, TEGRA_PWM_CSR_0);
+	val = tegra_pwm_readl(pwm, pc->soc->enable_reg);
 	val &= ~TEGRA_PWM_ENABLE;
-	tegra_pwm_writel(pwm, TEGRA_PWM_CSR_0, val);
+	tegra_pwm_writel(pwm, pc->soc->enable_reg, val);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }
@@ -405,18 +449,27 @@ static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
+	.enable_reg = TEGRA_PWM_CSR_0,
 	.scale_width = 13,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
+	.enable_reg = TEGRA_PWM_CSR_0,
 	.scale_width = 13,
 };
 
+static const struct tegra_pwm_soc tegra264_pwm_soc = {
+	.num_channels = 1,
+	.enable_reg = TEGRA_PWM_CSR_1,
+	.scale_width = 16,
+};
+
 static const struct of_device_id tegra_pwm_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pwm", .data = &tegra20_pwm_soc },
 	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
 	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra186_pwm_soc },
+	{ .compatible = "nvidia,tegra264-pwm", .data = &tegra264_pwm_soc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);

-- 
2.53.0


