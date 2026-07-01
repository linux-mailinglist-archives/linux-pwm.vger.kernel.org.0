Return-Path: <linux-pwm+bounces-9497-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id blrQHdOHRGqSwQoAu9opvQ
	(envelope-from <linux-pwm+bounces-9497-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:21:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E55396E96F3
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:21:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=pLzCNzSI;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9497-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9497-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 041ED301B716
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 03:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AA535A38C;
	Wed,  1 Jul 2026 03:21:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2D3382C9;
	Wed,  1 Jul 2026 03:21:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876070; cv=fail; b=SBR9Q5gREf7wvLpxfAfsNd2sShaM9OewhFHu/xFv9JwmMBzNL7nTJmy/6k/7hoXvGwEtvCHawwTymZoOzHQTFk6C1Po0fGtQJUDMEsnXBlgO1V7FKiu/OCm7u5/QQLQ4S6K2l/9207uHPFvh9HH6wLO0Bz2LYQElMJk+Ugca0c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876070; c=relaxed/simple;
	bh=drQbcWRvFfGOTo/046NejrND/wD0lWVdRL5CxwyMzJM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H/BmpZmCk2/siDPkTdOlIpRzYg2byYO/KrAj4d892gPSO34UeCMuFozk/o2NskYAYqeL2aziusQFjrIv5xM4wfvtf2eSyL/qemV8QFRAOkszDMD5KfIscus5GR0H/fJMLlkh3kpXwdLzs7WfoFEyj830MT3lVi06e+cFSZ3fuGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pLzCNzSI; arc=fail smtp.client-ip=52.101.46.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vK75g0obQt6s9u+pD5QuK0spiz1UbDEW+XlJ4RGhcy7anTpa1KMewAuCtnfolkmlz5tWz0s8GSVyINsGj3YwBmL/wsLTKf8ry+GKpyzwIJFlaMRD0p3bAhF2XqOh9RP3MggUrLlKkdbiI9xAcgCevz1PqeRuwRThq31vDpCt+f4uG0n3YJjQiXZHWQ0yovQUv+fCEdjK4LQ0bfoQysu78zAxK2sZw3412ZwaCWI/4tAkoDj36BN26VGHZfnIvMz2RLMPTXD8pBsEVQXdoPksAvBjdK2FbDYqoJVkoxfodU9+aOuatgIW36vuPCv741rkGfnEs7Q6WeAEw2kSrTemJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeXOmS98gHrjrPVSYQloZdWXQMz1sWVQHrHgY4Tptxc=;
 b=s3E5AquBk3oAwUmwhGSQsGgnjxwygCxXsM44SYwjK874YUg1KMAlF1x+KEm7tAgSTOXqJtAcG4tS2P9KJFtpn7welKlAdnaJAW98Qmi7bwu2Bk+yrKjCnJWpZhYLnZGb2SUuR//s5G+7IIcmwpg8Q8/vqzh8NwL8dlq2RRSP4B/Ey62xbzwVTm4KNPXWbgyxtaqbqvJU5fXJRb1u87qMx7m1cKvPJpxYHDPlrGTnM/jMsV3wGKBd2XcdV0r08QeqEKq2YDSz8WXXyvm9YPZwY0P0eEniMDmu5uuUff14N4HMxSxlxKwDAdpRS/io3Tw0q25PTq/AMSMABgkkc77shA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeXOmS98gHrjrPVSYQloZdWXQMz1sWVQHrHgY4Tptxc=;
 b=pLzCNzSI+vAlrLbxHd4QS3EN326yUMHKzqbCEqWRDPvmWj6JdAHafBUhKMDIZhxY1QbKYyXz+jRdFcCaEy8jhsGdNzXn36EjqCg5lrQb99Gp4O2ANMm/w4M9WxkpaISFaATSZjNrpmLk2PFc2LOQUMESKmfMI44AjakUEwu3crm3n6M9FSUcjfwkMzrZdIwfzSTHDnNLpoPYSUbzMmbVawkQX5YzDCiMSuj2usp/TEbUnxgTDTD8DdkxFoyhmo1MpstlPc17+yiwNiWxKjHFYq8yvWmBrGPrfACoe4aHyjg5l3cpgT+1Wdhuy8cUy3nUQKcVZ2AE1DnyVo0UNXArSg==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 03:21:03 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 03:21:02 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 01 Jul 2026 12:20:30 +0900
Subject: [PATCH v6 1/7] dt-bindings: pwm: Document Tegra264 controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-t264-pwm-v6-1-2718f61f411f@nvidia.com>
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
X-ClientProxiedBy: TY6PR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a4a02f-8e1c-4ffb-26ab-08ded71fc7ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10070799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nZRehBm0VYEDdCvFSH8yNpwPMkfdx74+gh+fFxOfdab5eWCNeIbU+pVzyGxRc9WJXlmNHOULGjuNeG3OMkZ+9bcd+VwzDVQMet4bHiserkBw3BTtQuFzUydR5vppyCgaA/uzhUuawzin5OQfVhhcvww5lzaTdramVeAu9gjIAB2oioRZPCrqVjh0YjsYS+rdXFSzeeg36SIf0GkmYJ/4oFjDPlcZu11FD00LfolHiPaHXJmTx0W2RZkkJk1ACrNy3AZSHRT2uWL1epMHEMYYZ2iReIOtWjvg3O4BQiNSRVEmH9CxmOnBbq+d8bh//28s7JtdwhzitEeZzkv+QZqRwfd7D3c+5Q9SDZmn+HZDWx9fy7lJrKaC/3FJMxQNjhnrKdaUYBvc0VbO380NJ77WFX+rPo2/9Coe0dTDAkzJc26h1jXxTrKw36rnV7bh1Y0M/Qa1oi5WX97WuB5ahcn7SgBAzH/p3vDzrpSg7RKMK6OsBh7HCAnzMpK0+CFKWRaZ503YQlYKe/LxoT964upVQS9LLGhWLO30ZsdoyiqZrB9dYuORP/bUfxxl2Mw2aD5QNNjb6jLoh83JDLLe/PWISTOiurxpuLYSiGOMCESNTz4snpXt+BIBWl+TWHHYy6QcXHX9cuzyrSbHO2ZJQ+aCAMUydvt/A6x3OFBzEfl1GTc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzdrclVrM0ZsNXV1SjBrM0FLbkJweE1POG9wcmVKeDMrYmFMRzB4TnlxSUt0?=
 =?utf-8?B?aW56cDVnd1ViWHBySGoxODNpWUpTTTN1amVpVCtaWGY4QzUvSnBNaUJZQnZh?=
 =?utf-8?B?ekp4VEx2N20vTHI4UTFERGdLRXBPUHJKbGlGeWQ3Wmt0U1ErR0JVTmIzd3NU?=
 =?utf-8?B?aDdwRHJrMEk4UlBJQnlvL3MxRk83SEJUanRGSXFsaFVGUXJTTmlqQUI1UEZp?=
 =?utf-8?B?ZEMwVW1pcnpQVlRoUEFjVk5yY2xWVlBqNWpFS0p0SlpGaVhQT0hPVytjZUx4?=
 =?utf-8?B?RnR4S25teld5TThmaTZWK3lhdFYrYzNGMUJPYW42cnphWmhSeFc1ZmY2MEEr?=
 =?utf-8?B?cWZtdURZbXJGSndWRk52L2dpR3Rja2JDZGRWNTgrMTJiYnJyMXFSall5U2tY?=
 =?utf-8?B?NmV5NTVHd01QMHlyeDNSUTZPbktPcGpqbFhUR3pOQ2xjRmVoMjd5dGplRkRH?=
 =?utf-8?B?VENjZnMyZzEzOWtlaExqdDg2YlNvSE50Z1haVFFGT2ZZUFBLUkRRNmN6ckkv?=
 =?utf-8?B?NDVSV2FET1o5QlROKzJBeVN1eFFJNmRDaWJ5dCtBK2twenlGQUhhVmxMVjZT?=
 =?utf-8?B?OFpDaHFlbVpzMXBLbTZ6MzkxaDZlM0xJVDk3SWQzR2kyZ3VTNW9SSjNNTEEy?=
 =?utf-8?B?SnNrdktzUmluVjJPc2VGSmdzczBrUkk5NC9RUG1sNU8wRXFFaVZlSWpQZXRx?=
 =?utf-8?B?anhHbmpXWk9BWFRIbVFSMnNMZ3d3Y0ZUYUtxbnFlN2dWYUljQmVuVy9icndq?=
 =?utf-8?B?SThETnF4ZlU1dW5qYWNEVEFSUS81MGpSUkRWRWpIRStMM3o2UlRvaEExcE9B?=
 =?utf-8?B?VmhwckExQXVRR2RpR2tTK1JYYW9EbkMvVFhnRG5jMUkwaFZRNFgydm5ObWhB?=
 =?utf-8?B?OGc1QVJuTzRmNUhIRGl2Mlk2T1lkKy9NQ1BqMlgrWldtTW91bFdCT21iVG9D?=
 =?utf-8?B?b0ZpWFoycmp3WHpEdFp3VUtOSmsvelFYbmNLRCtaZXRoUG5HTUpzWDJWZFQx?=
 =?utf-8?B?N3Q3b1lQNVNzK3poaXNBalljSmdSWEVUNExsUitqdmJPYkwybEhWYzZ3c1dm?=
 =?utf-8?B?bTh6QnptM0hZL2hHbmozZjliT2JxQ09ORGZwSU8zVUlpanJZNXFQdXZuOUgw?=
 =?utf-8?B?bEl3b0tGWk02WkJOT0s5QmZUdDZHcCtDVkh3bHFkeWVoM2Z0THFpUjcyYlRv?=
 =?utf-8?B?TGZJSHNxdzhkN21HblIyZ3NqYU5vVlNYYndZV1Q1b1ZDVmFXZEVxdE5LM29C?=
 =?utf-8?B?RVZkVnBkejhwcDhWczdOY3Vxc2dKR3VCazVmZXdSRE10UEFSVUVja2gvWlY1?=
 =?utf-8?B?VE8weXJKQis0Uk02MTErL3d5V1krV1BSSEFkaHd0VXVYbmc0bitPLzdDSXVY?=
 =?utf-8?B?RUl0dUpRVkt0THJzVVEwVWJoOHd5THNmNWIwUHFJcUhqM0tuOFExRWhyQTJV?=
 =?utf-8?B?UDJKOHgvOFd4TDhweDFuT09TOGdZamQvSDFMWnF4dnRUbXJsWTRNcnNWOXBZ?=
 =?utf-8?B?UG9aVmRDQk1CQWR1RDhBY0ViRTNYN1VYaDFHZXhUV01IUFVJSXBzdU0zQW85?=
 =?utf-8?B?dFdyaGljaXN2KzFaaWx1b2Y2RmxVOFp4TDRvU3pEbUY5ZFIrTkF6ek54QlVF?=
 =?utf-8?B?dDFDVDZha3F2MHhsL2t2bXZNc045Tk1CQ2V4NE5hSE50MThiQ1RPN2pqckIy?=
 =?utf-8?B?eE1PVEdxQkJRYWhvbWZaYjVYV1p3VVJrSCtHQVBDVmxtYzFMMFgyelVmenVn?=
 =?utf-8?B?Znl6UGt3d0lRV1VFblBVNnhVd2s1OW9DekF6RXRGcjl3eWxBNE9WUjhzU0xq?=
 =?utf-8?B?MW5jQ0szZ0g0Mi9pTmNWOEF1YTFjdzZqVVZZRzcrUStLY1pERjFoWkgxTkpT?=
 =?utf-8?B?cmNUZ21TWGgrb1E0b3RoeFBxdmhDT01hdm9yeVJGNG1qSXgxOXNZZ0wxSkEx?=
 =?utf-8?B?ZUd0T2FsOEVwQSsxRjVXY09CbytQRlhUSk5taVJpMVZ2RnFSRDE4eThaMWIy?=
 =?utf-8?B?VksyRmtDcEhjNHMzTXNxT3I2UVhjRUFKNlBJanR1TnJXWmRRbDdRYUlNUG1C?=
 =?utf-8?B?WEhOamdtR0tiWXBCa3J4QlZDVlY0N0w1MEkwYmQ4bEFBZm9tOUw2UDlvWWpZ?=
 =?utf-8?B?YU0xaTRqOXFreTBGWndUVHFQbzVaOWFGUmNMa1NSZzlMMXEwcERaODZ5Rno0?=
 =?utf-8?B?dDVnT0NXNTZ6bW0rTHpBb2FvNjROQjR4Z3N6M3JZaVJ5cUV4WWhTbmRGeXZm?=
 =?utf-8?B?S0RlSmpWelZEeVBtbUZMeU40YzI3amVEdlgrcDNTVC9tdDlHSWNhYTFuMEpm?=
 =?utf-8?B?QUx3RE9XbXlKcU1UVFRWVGpibWhHamlqZ0JIYTRtUHFsMm85aTZEWFMvYkYz?=
 =?utf-8?Q?Jxyek9Vkd2TeEykqyEFf4CqY0+dl6B+EuyJ8EHAoWi87l?=
X-MS-Exchange-AntiSpam-MessageData-1: nrJ+T19zvxrkEQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a4a02f-8e1c-4ffb-26ab-08ded71fc7ba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:21:02.9101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMLdNBlVuS6IgotbR22hNZistQ8LfiTUPwggaMSmQvlLDvPNL7RtQOZ3xJhpVJwbGSGx44NP1n6WsJsHLAhwqA==
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
	TAGGED_FROM(0.00)[bounces-9497-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E55396E96F3

From: Thierry Reding <treding@nvidia.com>

Add a new compatible string for the PWM controller found on Tegra264.
The controller is similar to earlier generations but not compatible
with them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
[mperttunen: Drop extra Tegra194 compatible string]
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
index 41cea4979132..cb2f36e7b5d6 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
@@ -16,6 +16,7 @@ properties:
       - enum:
           - nvidia,tegra20-pwm
           - nvidia,tegra186-pwm
+          - nvidia,tegra264-pwm
 
       - items:
           - enum:

-- 
2.53.0


