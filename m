Return-Path: <linux-pwm+bounces-8435-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCgpO20uy2n8EQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8435-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:16:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E6B363658
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 954343026AA9
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 02:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499E5366DA5;
	Tue, 31 Mar 2026 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iA1sMG1r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208F367F2E;
	Tue, 31 Mar 2026 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923187; cv=fail; b=bhCyELfcWNpihir+cc98dHxhZgEyJGuOFa5pP5htRSU5ECN9o+Iwk8+T10CyF6ahvTWzDCRY6TH2U8nF9TmBWFH8zEXM6TCMNTtd5gIhgCUU0pXPgSm7pTq81ggJ8rJIY3LqYFhFnIYR0BPQuTj4ZWuOeVZXsAxrII6xHYRxmNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923187; c=relaxed/simple;
	bh=97cs0BldpwMRZZ5VgVfzjCB4kvLz17mVWd9LccAZWq0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dcP51Kw2+aTNwFMIhgYfWFsK/kFPME+C2M+COMBa7t093GxLG8MCJl4bW5o0fQnE11cbm8hF0jSu6yN4whEVXSIk+CpK443HLQMgsp56TkedfcKKt8vFl9x21afykwF5kxIScrtMFEQL2LV0HNQlOD4tjEUxUlYpKYQqtBnZIZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iA1sMG1r; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rh51qmGYxlkDu9tQp92RS/gDGI5rzQPixex3+sq4ZqWgzzh4DsV4tosPRq/d3G4p+GnoAQljy8kVy3SVgbx8P/oi6ngRf/OgPNfbBqZ+C7Sevwn4+oGnXlnqSciHMWajt8qWwsJtPOHZR1gBgDtWHj2KtKbIuY7pj3V96Sn+IXlTFcnL6QK8Q6RaZcv3cT5yag8afbQhFf4NS9HdVZvSheuKVUmMi4WTn/OU9OJ1dArrYJsg+HqWfqsxkRJeWLXQ2kDi3RuM9pkadm6SJih9XwkB6bv3uT3Domf9bSJfo8hh9bk5W8J3kEBsAN/pWT0DXzsccxO+aZI+qGlVsQMxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ITbnE+EK7BwRi1mY+Xlbmebj2HNsHhVD8L26tDSRP8=;
 b=Xdei/Q2y+YQ8GpOalNixB5M+gKAxrm2dvC8k15bldS5HhYCpctM9sOfwStnpC5QyR1soYth0l7ReAU+vIfOll7whjEW+Xef8QV0UCrE1lXUej1koFkKWwPfX3n6FlmmwJ0tu4r6NDNtpUZnyqeBSIO5G3Irn+SjqPJm1uNFFSxfWDEwI1KBN/+WLnZJFMuiFoFuGVGtm4ZyRGZmQvcVlqNwCG8TNPd6E59JzOENCia22ag5ZT9OrIXaBVkwTj+QtE2z3h9984nzxxzaSA43qNNsEqHWHQvK69KyN04PxK//qkBl8O/OHiDl3ZeyRVkwCd8ttCpC1PyjRCKeGVPKQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ITbnE+EK7BwRi1mY+Xlbmebj2HNsHhVD8L26tDSRP8=;
 b=iA1sMG1rjvXGSeSuW8os3k71JHJaoAV70K2W5HK6ofZJYoH8U2vgKjobTVI4/QQqcp3n1nED7lB8abJyG2tQf+bdyzOWMsSJRYK8gzgdtUScedtb1slRElClKDpQXeznSeTxMmUbxH/JEyoMch1wZxakrGNTPU3hH+Fpl2Khgy0bm/BKOm1C292QmkLCwUHqqGcAJM4Zxke9pjRrAIBenZNnhAqMYflfQxHH9zhUv+jYvZucPQJDj4tpeZIoTKJ33+gxPw83t42mu3kmnGmhzBqdiNPvx319bQWNH4zV/9KctddMd6aIOqgLu+y1A/RJD6dLgT1IRooovFL4bFNH7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 02:12:59 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 02:12:59 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 31 Mar 2026 11:12:18 +0900
Subject: [PATCH v4 6/7] pwm: tegra: Add support for Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260331-t264-pwm-v4-6-c041659677cf@nvidia.com>
References: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
In-Reply-To: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::11) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc0f7d1-404a-4861-7686-08de8ecb0783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MkjoDx7rrNJPMetr1Vu3UZLic/ocP5Qq1aO/q2Gtqf4ynuu9q9P9nMEhbR/tZZznn9hiFxvjWjDvcwZEGdtHTgvcn9aazWsWEAdUB5LlqTDfRYlnMfFqiJrHeUiTqvaqWr/Ok0HlgD7hxSg9gOvLAh7/yoq1HKL3Yb8qwOSRKEsbMZdUXdip2UigN1CVP5j/At2GBeikUz8R7Ubw35bzi/ocCkcUpBUmYR6qUUF3IbKRU6MO/o33n32G9aoB7pGjbuXhVdRcXumOBogorDPMmsb6icgd5UQeNrgNWSN8apO0x33N3Q8r1S9mQP9z3LkZ8/ZHCu9R/61XIs59wZoVJbjI2M9GgMQvSjn9YUDFzsqRhtYd+vq5Q/HF0H8CmwuAPO6xcaGK8d+tGnEd4zIod2uXnxx7vzvFX6YswzAqiGK7csrNLNxMDlmmGPojcwuyX6PNDxSoLKPrFUloUkwZu5z2zT1FYrRmKEkOt7DuKN0HlANib0LAzhE1LUUzjBLTmqM/Fi8wUskZsDNWJSJ1vB5W38geLSYRJ+kVHNhzxlUNnAFWHASvfX3hXZYiMj+IFDLprAzmMZGWkHwC++ofd4FRJ0NbUmu8tynvReidPXV+8e4nWHIFvurMIwxEHkx78Q8y1SMWmEuyZBG2gww7VH0qgjFMD84zzLN80B07tQ2haeUVL1rpQiw0lxQ17bj+Kl79aRmz/mnDlRcQI1phV4sef80pivuacx9HW3tkwNw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUxud282dmxtSDFnMmFnSmV5VGlibWd4Y2NGWXRhd210bEZ4SXo0UGkrRWV0?=
 =?utf-8?B?SjFpYWlIWjdjTU4rKzEvNXRXT2Q4VXh3cm5rSjF4L2UxNEhEUVRva2JTcUpH?=
 =?utf-8?B?bUYxdWpydEJoSUozTDIrWlBwcFNlcXhXRzhNV0h1WlRVekNhdXFudkRHeFV3?=
 =?utf-8?B?N1VaeHR6azkrNHNBMS9UR3hrd2h1bVk0bndhSHNtQ3E1SU54K1JHQURjR2lh?=
 =?utf-8?B?WTN6S3FzYkQ1SmZENlN0NWJpK044ci95UWN0NVM1djN5ZDlyeFhkMmZmM2Np?=
 =?utf-8?B?T2NidGdYdHNMbHRHUW1aTDkvcUI1VURlTk9rMjliMUVFUERkS1d5aW5sbkhV?=
 =?utf-8?B?K0ovYWt3aHNjb1hBVjVJdDVsbWE1VHR5cnFiQ3IyTHhwem5pRVFJLzNuVWgw?=
 =?utf-8?B?T01zWEJNbmtnbGFpSy8rMWhQbUFTTkxmVUI0Rjl3aHUzRE9tcFVaeDlHUTRv?=
 =?utf-8?B?RDFYYTA4aVZ0U0t3TW90cVFmRmRGMHYvQnlGcGF1QkkrZEk3WXVRNE40d0xD?=
 =?utf-8?B?aDV2TWpRZ1FWZndjb3psd0tKSWhLbWhVMzBFOUxxMWdjN2RGZm1RbUczSDNw?=
 =?utf-8?B?WmwxM2pONFEzZEh4Z1hTUnh0L1NMTjNoQUVYUW05U1BhTjlsSVoyUm5YdVla?=
 =?utf-8?B?dVdlZGdJU0x4MVBTZ2szM3lVTTNVb1lQdVBGUVV2TjdPL041ZTBQSHpsSC9Y?=
 =?utf-8?B?dzFKUmtOUUd2UXQrWTlQNVNMVzNzN1ZReVFTUGt3d0cwOUtsQUZMZFhMRU4z?=
 =?utf-8?B?NmlMQzNNcXlZR2EvbTlqWjVIZVRLWHdVQnVBTkU1NmI5cUphOU94ZDV3Z3pK?=
 =?utf-8?B?UndyeU5rNkl5U0F6ZGZPaXp6dVVidG9sRDA3RWJaUTNMMm50SGgrSXo3UGg3?=
 =?utf-8?B?aG1uNGoraUpFYVJwVG56clY4MjJyNVpYUXNVdHAvOVppS05HZElQOFhGbjZQ?=
 =?utf-8?B?NGtYd0ZoeGRhaTNLR29yK1hvYVdUWnZzUFcyQ2owOUE5Ry9wZnJYVDFkSC9L?=
 =?utf-8?B?ZXorbXduaElncmxidnI0NHZubVNXaGkwRzVxNTBCcVlWb2FXTHBZRHBKVVRw?=
 =?utf-8?B?c3hISGRwcE83ZmFOOWtQMlBFQm80Qnl0Nnh1eDFxRHg3d3RXU3RmQXB0Qy80?=
 =?utf-8?B?WEk5Wm01UHdUcGpxTms3aDNBcFNVaEVHYnJ4MWEyVmNKSm0vTUcxQll0VkN1?=
 =?utf-8?B?YnBHcHVyeUtTQ0g2R045N2k4WDZ5aVNLUi9YZUh6SGRVL29NbmdocDgyY2JR?=
 =?utf-8?B?aktiNHpDQVluMkFUanFhR3ZqVjg2ZzZJQ2FaZy9jbmlEZ3NqVDlVejJqeS9R?=
 =?utf-8?B?clpiWjNrSmNBenJ5M0NLZXU3T0JuWm1xdUZkTEtMbUl0QjNYaytoRzdJcnlN?=
 =?utf-8?B?OENJeUJ2YWdRZ0tXR3RiTFlIS1BLaHNPNVEzeGdTcFBwNTQ4N3hJcDNyZzhY?=
 =?utf-8?B?aUlFemxKSHQydEZGWXUwNldoQkFLM3N1RExzZlJPbGM2TVd1Umd3Vnhxazh6?=
 =?utf-8?B?S2Q2RlRZT290bjJ4RHdXQUhxbm5sM3UrMkhBRjFQcEJoakg3eCtydk9lS0Rv?=
 =?utf-8?B?SFJyd1lCOXN4VnVMR0NrZVFxaXMxQUc1emNuNThRY2I1d2JmWGJUZDYxbThi?=
 =?utf-8?B?ZTBrcFNwZDQwL1V0dUI0Q0hZcFUvU3U3ZmhjQzQ2cWEzcWtTUm9sby9VdU5q?=
 =?utf-8?B?ZElMbEJPdTk1ZG5CazV4NUVmSEJLUVMyTThvbTk2WlRQZGZiNG55SUZiU29k?=
 =?utf-8?B?TTVCWGpGR0lGV2I4SUZJT0Z4eFRmUFFENmRESW95S1l2bHhZa25jT2l3K3E3?=
 =?utf-8?B?QVpKbjR4dFEvQS8ySWlUQmxSMWR4bzM4YUZPdE9tTkkwMWl4WXMybWFJMmVK?=
 =?utf-8?B?Yngvb210MkRIaENNU0hFNFExWnYzSnFyc2lqcmFqUDFYMWlqSEp3akVtMG04?=
 =?utf-8?B?QzVpQ2dPZU9DWFZQVWFjdnRnYjVSTGYvT2JQaEhSc1A1bjRYck5iUm1NTU04?=
 =?utf-8?B?U0lsNjRXOFY4YmlGM1EyY0JwSTBVMUEreWdTbzRNQzBOOXNUcUovVis2ZDZ0?=
 =?utf-8?B?aFVpOVFJNzZ0elpzdGpTR0xUcGtkK2I4N09leUVvU1g4M2NuYXJ4enppYUZN?=
 =?utf-8?B?anUxWnlESVVsRDMvQnZGaUZReHBOZ3hSTEIveXNtS2gyeGpnRHoza1NRVkcx?=
 =?utf-8?B?RWpFdDA0OW5wMDJzWG9hK21zRWYrbVVPWTVVYnExWC90Rm9iQzFlVFFKQVcz?=
 =?utf-8?B?Y28vMVJmdnlaLzNFaDNkVlE2d3F4cjNzWERHSUlyY2hBZ0tGQjFkL3Z6Z08z?=
 =?utf-8?B?Wm5vTE5iTHQ2azdaN2F2QlhJc3FzYnh6bDFGVWI1MWd4OWNmRy9ZdlN5czl3?=
 =?utf-8?Q?ryEF9MB8fn9r/G65vkTpaS4aXwRq/0hZcJXz0kCS8JVfV?=
X-MS-Exchange-AntiSpam-MessageData-1: jvcLV7DcvW9pYRQHyw7e/DW0hyK24kEvsbg=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc0f7d1-404a-4861-7686-08de8ecb0783
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:12:59.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ls6Qg/6SA9FdeyFuwUT2aeOiCVybb0iD8nt7rHhE38mgSZayvrbnq1ujTKUM5r5dFEiroh9z/VzQqGSscgrpAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8435-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50E6B363658
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tegra264 changes the register layout to accommodate wider fields
for duty and scale, and adds configurable depth which will be
supported in a later patch.

Add SoC data and update top comment to describe register layout
in more detail.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 75 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index d7968521fbfd..c9d30724e339 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -7,22 +7,60 @@
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
+ * The PWM clock frequency is divided by DEPTH = (1 + CSR_1.DEPTH) before subdividing it
+ * based on the programmable frequency division value to generate the required frequency
+ * for PWM output. DEPTH is fixed to 256 before Tegra264. The maximum output frequency
+ * that can be achieved is (max rate of source clock) / DEPTH.
+ * e.g. if source clock rate is 408 MHz, and DEPTH = 256, maximum output frequency can be:
+ * 408 MHz / 256 ~= 1.6 MHz.
+ * This 1.6 MHz frequency can further be divided using SCALE value in PWM.
  *
  * Limitations:
  * -	When PWM is disabled, the output is driven to inactive.
@@ -56,6 +94,7 @@
 #define PWM_SCALE_SHIFT	0
 
 #define PWM_CSR_0	0
+#define PWM_CSR_1	4
 
 #define PWM_DEPTH	256
 
@@ -418,10 +457,18 @@ static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.scale_width = 13,
 };
 
+static const struct tegra_pwm_soc tegra264_pwm_soc = {
+	.num_channels = 1,
+	.enable_reg = PWM_CSR_1,
+	.duty_width = 16,
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


