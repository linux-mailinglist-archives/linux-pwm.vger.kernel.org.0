Return-Path: <linux-pwm+bounces-8363-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPfuL7e4w2litgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8363-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:28:07 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C2C322F25
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF8D2312824E
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1B63B7769;
	Wed, 25 Mar 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OEgQWO1a"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD693B6C19;
	Wed, 25 Mar 2026 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433896; cv=fail; b=NK4UwLcGQD4EJ/Lag+IDrnIPs0os9ZBGv8XPCqD+00KnyGXhDYZ/R52UpZoN2iy0Tfik6GKAipvGLG9g1rGUCGmKSxReVTcMixhDJjU3wDHy8EOy2tEsMOz5ZZYQmkFVKRD10sAJNxjTl9Cq+ERL2aD8gLsOtbxnd52B1BKllho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433896; c=relaxed/simple;
	bh=/Ta0Axt7KJjBrFu00qLjZJNsY3MmjgJ0zry7Jm+m/dw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=R0qJj4+ipJngJAjFRirjtpbwZ7VJ/O/Q3nZAMU6if2qNuf/pjWm9p6ggpgUE3Z2oDOM12tzO3+H85hdnbIqhCNhRNaS67c4Qu345Wk73uXNO1mwnThN6C0qqGQtrOgMPvtgw8hNitVNEY5jivICFIRAQkpJXBj9a91uCygdu8cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OEgQWO1a; arc=fail smtp.client-ip=40.93.198.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q51d8zYraiMzq9vljkTSu8R2tM/Lywc3SI+SzP46XRBqSkVs0O3GT7mtCooLY6d5u0slY0JVQjinOrTjUG+y0P2raZoq/T1ypzNCYsPdu3cIryisTzok/POjSWQmBBzl+UBx7XlwdS0sAsK8lYfElsfuxGP32xE+qgDeNxszhapJ3YjsM7ybiFNXcd62/aEK7RvH0YAdx+JjD9gUbmH9bvBFratr/Va5T5ypaN/n2+oZFMXMFztbcrJBYTfbfPuCZ5maQ1gFHPz/b6GLoHr8LqC7oDAY9KStX9zRTfT8uEhUfhPsxBOnNTFFXMZdK6iWmGKAikyGhURiFE3cjcH2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lI5vCtTJRWEYYBs6iFamPe8E0USN1Uctqb9jRn6Rgs=;
 b=pNvvJx1FldCzgytQFhJf2oDUpmYKcjXMOmLIVqI6PfPwWdgvHgAdEKx2Ac4ttu7Db/yV9taqP0jSsUPo9v2BuwIMEUa60zUHMzaDrckd6V1A0VFmAYtWbmN+/RtP2cjD8gngGOW5UefCF68QAGS1ufITXcTf85Mrj63mxBV/c6Uyv275tCbURoyXQPiSxKRxi7E4zHVC8uWk6v6Yx4xU0oBOyhUe+CW54J5K6vWK/LEjtUXVUqGW/tp2DeYIDiQU5EVxWfGTrt4tdx8GVwj36Z5+lj389xjtAwBLpKkZkaiAyin8o9ZpRvyBD9PirAwUREd42loB12BuflgV5n3FIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lI5vCtTJRWEYYBs6iFamPe8E0USN1Uctqb9jRn6Rgs=;
 b=OEgQWO1adOUq4q1CYzu+jnc4X1MfdnkWGeKcgh25oZ+d3GwApAZ355nNbrurdX9ggchnk8E+UVf5YVEfsqmbDV4BXJ7EAtWpsQHiBzHAaxdaiPRR8jTbF54amC+gFrgYssFW+u0St3C7sxJNyJ24bV7duAif0SrZfWtWflTRjFhWpcGvDsyqIah2EK0ytFiFLmS/vit8PRfno5xLtxg2O5YumFsy95uNwtti92pvuxPP+EcpUtZupiQG38UPF7eLppWberZgFFg8rE2ev4yFoNlIcEmWPLGmzUZfER+CyDl8iGUQBA9zWXat5KqrZIZ6S+hJdvf3He9r4f+6SBbOSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:18:05 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 10:18:04 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 25 Mar 2026 19:17:04 +0900
Subject: [PATCH v2 6/7] pwm: tegra: Add support for Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260325-t264-pwm-v2-6-998d885984b3@nvidia.com>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
In-Reply-To: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TP0P295CA0055.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::11) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f1a4c2-6f10-4d36-c3d9-08de8a57cd6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	onqOAKvLSEv07S6hsFDCjx9rYesmUWjJTlpgxduQkrKcX+KENAmB08xWaRWfNuNuOpyiD8qyJ9wN05hU6bNXmuRy33rTKoj80byVPX+MZq6V1UYDoczlfVZUGtWAuoHp67Oj3qFLmg7jk0kuVUrARzAyreVgyVUwLaa+DOBiN6oy7a1YgItv5pYAI73vizEStswyfD7LW4GiJv5FLvbsMjOByySxE1aoslWeYJD8KS/Wqpb7t5HyvxAlilZSE9If/gWdIlYhPW5qiUZedS9SVbGPKfhweYXdpmKLeXuMNrhJo9atb8AI4tSlvlXD7y3EXb5kSIkRMhgusYVAnHf/gi9mPJ+0WLH4vt/PqQICwPiFG6cIQ+LIN+AwpoPxK+HLyCdd3+cKW8U7WxBGOS0HNx0CY9csmGucXLT0fL4TUyctTToogijMj5I/Vn7fvW6MdRp8aTsEuM0DakIcM/4UjH0DOzf0NvmP7PXb6HeLVmX+EfU6LFjs08okPX026B3X5XAuozWXLSxomgXHQQR+Ci3uqA7Eq1ukWuW5mBell/y66F5rF17XZhHugHj4fGQD1Hyz841DZ/MytualWh1cfO2sWQCNwc3nC6jPcvIJ/jXWZgUw6L/dOOHBijbCcz6UT/6zKxeDvmdQaXpMGY8xMMz1BBCHjTIkCQYdTcqseRHn1dRRT+72Hk/yC/yVKfNTI1Hqw0/d/hGmgyZx8Y+kdSkgLIJgBzGnWPk2PUtxHho=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2tndy9LamczOHcyY1VrK3pzT1JJWlVJbE15UjljR0o4cmVJS1VCTnRROEsw?=
 =?utf-8?B?SEVFd1oyYzh0QW5Va1hjeUk0dENmSDE0VnRiZWtxUEhJdTNOMzkwbVUzbHF3?=
 =?utf-8?B?V3Y2NHJkZmdOc2pkc2p6TGJOL0I1TFRCNlZJWGJNdmUrUVRMdXFhVTBwMGc4?=
 =?utf-8?B?akZHb01zRngrSVA3YlErTFljbUV5WWFaQm9WY1ZaODdvRjdhbm9kWlZweDhC?=
 =?utf-8?B?cTFaQmdjUy9Nck5tUEJRaGZ6TGZQdUxJd2pMejJITkNQY3I2SWJDRzhjd1Q2?=
 =?utf-8?B?cEQzaDdtY1EyNytGTFgyc0tBbGNqeW9WS3JXQmJ1QkZvd1pLblpmMW11N005?=
 =?utf-8?B?d1hnK1MrbVdybEdhN3FVaG5zTnlEaDhrZjYxZDNHdXhMT1plcXZ0R0pOMnE5?=
 =?utf-8?B?RE9GbnBxUVJlNlAyMC85Uit3UVFUYVFmTHBrWW1ObkdqRFl5MWVtOHBYb3Iv?=
 =?utf-8?B?YmJwQkt3Qk5INEZSQjJCN09qakRNRVpvMytMeFExcWhkZEJnTm5Kb1JGbUJ3?=
 =?utf-8?B?YVJqWmcvUHd3S1g5N3dYS05rWGYzSEFyUndhZmRiU2J1c0U2bFMrZTIxcnV5?=
 =?utf-8?B?NDdNVDFxa1lJczJDQzVMb1U1N1pLUnhkQ2pEd3UwTnlKYWczMWdKMWFlMmVG?=
 =?utf-8?B?aE5LckNydVF1OEJNU3BCdVBwc3Q0azE3Y3JRTkk4bkpLOGpaemZuZGdiMi9l?=
 =?utf-8?B?eUpHejZMY21Ib0s0WnRvZE9mRFRhMnRLMGNtVWpvUll4d0prdFhzNkI5SUlx?=
 =?utf-8?B?UGVFbWdzSE1qbWRDOUx1UkorWU12eEZCSDFsWm1MK1NFSGsvRlYrLytzZ1pX?=
 =?utf-8?B?RHlUaU1kWWpRL21BaXprQWovYmJUNkEvbDFzTTNzcWFvSlF1UXJZZDU3eVRJ?=
 =?utf-8?B?N1JYRDZNRGF2dUtNNUw5cXVkcFZvcmlvb05kY05lUVdDSTB4NEl5WXk1THhs?=
 =?utf-8?B?T0FVYlg5ZXlCQ2NVTDU5R2JpT2w1b2dtYW9abzdxNVc1cXZTak4xZWtRdCtE?=
 =?utf-8?B?RDVtT2MyWXJuVFZucXcrODJ5V2xzZnFMalg0ZmNHdTBLQjhlSTRWWGtvWVA0?=
 =?utf-8?B?MTlkaWgwODFnT0VGNkdBRFJidjY1aDc4R012RTl1N0xOQ3gvMzlPZ3ZpZGZM?=
 =?utf-8?B?Z09xQlhzSGtxczIxQmM0aTl1OWFYVTVtSXZ5bURXWXlCQWtmOHgvQ2l3cnJw?=
 =?utf-8?B?R2dHb1V2UStmODBBamMwSHJZODZydCtDZjN2Rkh4T09XME94aEtsVWNFNjJ6?=
 =?utf-8?B?dUlmZGtPMXVUVzdJZ1BSNXo4aUxCMkt5d3hrWTVFamlRVjhON1VWY2pmckR6?=
 =?utf-8?B?NlMwR1cwdWhSaFZPM2pCNkF6MmdSR3IxSWpZUm40aGhnam5vdktpV3dDaXN4?=
 =?utf-8?B?ekI2WWJvb0IzdklvZmIyMjhqQ3RGcGhRK0xhdG9aUWpBMEVGcThvZm1yVmYx?=
 =?utf-8?B?V0gzckx3aDc0dFJRTTZReFVTWHBXUC9rNzFpZWh3QmsxbkwxNitwUGQ1cUVa?=
 =?utf-8?B?dEtRV1gyUjFjdlg2MWNUU21xVUkrSk95KzJTZkplYmxpNkNMV1kxcXpRUEFs?=
 =?utf-8?B?Vmg2YVNkT1gzeUNnTVVYcXJSbWRpeExtdjJsTlBLQWZmWVp5Ti84VWF6NVNE?=
 =?utf-8?B?cDdxSitWbWpxQ1oxUVVDbTEvVWRtWXpvbzlEOUxFbjIwZnhXWnBxV2xjZFhw?=
 =?utf-8?B?MWlIL0FpaE4zb0ZlNjB1VldNYzlKNjVuNVVkd2o0emMvQVE2ZXFXOWxPZllx?=
 =?utf-8?B?ZnBJYXFKZ29Hb3Z6NnMrRUdsYnozKy9MZUZyQ1NUNDJ2TFp2aFd3V2RtZVVy?=
 =?utf-8?B?SjlRTVlHOHVGUnZ2QlIvTndWenFDRGp5b3ZBZk5iSXVaNkxydE5RSllXTVpG?=
 =?utf-8?B?MUcvWDI5UzFsWjFVbWhtcmMrQkFXLzBnWnRmblhaNHBnb0crRVNuV2VPcEVC?=
 =?utf-8?B?UURyaDByTFFlcFcyWUhTcFF1L3BkWjFYSi9kS3RNQzh2Q1VJdlBJOXBrUTAw?=
 =?utf-8?B?UnBIRFFzUTdMQnF3akFaR2EvR2VNY0VwM3NsWkM3eTJ2RXJkaENvazgwU2d5?=
 =?utf-8?B?dXFscXFoNXNvWkxxMEtVWmxCQnFxdEFJOGtqRFZZbmtCOExsM3UvOFljSGxH?=
 =?utf-8?B?ME1IVHJzQXlzYTdXRjdCU1hjbmtISERDL2xETVV6V2ZnNUxPU21PcncvRU1N?=
 =?utf-8?B?OUFxWU1VbEJuUFQ5WGJ0dmhmdFM4anFNQTE0OTJ4ZmVSUWJmTWtlTytaQ24y?=
 =?utf-8?B?VGNXQW1NZkZpa2podTVFRU5Pa0dCVS9jKzRkMHh6TERZenZuTVRVQlJtM3pW?=
 =?utf-8?B?WHRPMWFadnROdjRFL2FSYzJ0M1NyeTN0WXZ4YWl2QjdBMnV5NXNHUmRYdG1Y?=
 =?utf-8?Q?kczQCdQHRCcW0Q2Lfp/K8f2BAHsgDGLQND4iATJk8uBJU?=
X-MS-Exchange-AntiSpam-MessageData-1: lkdbCdBo/NDBGjEcLlH87i0tqGu3qQ57XrM=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f1a4c2-6f10-4d36-c3d9-08de8a57cd6a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:18:04.8425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuRxXa5IhzMO9EkRlx4UjFwleAgtbhTuLiAAJVhAnTq62qvl+JVXXFz8pon3Ns5fvI3nqs2TVUUrmFWmgPFK+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8363-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 64C2C322F25
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
index 857301baad51..c1e8a804d783 100644
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


