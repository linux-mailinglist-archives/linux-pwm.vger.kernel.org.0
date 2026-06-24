Return-Path: <linux-pwm+bounces-9361-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2U82OO7rO2qifQgAu9opvQ
	(envelope-from <linux-pwm+bounces-9361-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 16:38:38 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D76976BF330
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 16:38:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=nqVJeOyi;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9361-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9361-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EAA0302FA3C
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ABA3CAA3A;
	Wed, 24 Jun 2026 14:37:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806F3CA49D;
	Wed, 24 Jun 2026 14:37:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311852; cv=fail; b=R4wqEIvqsIQlhG4KWQhWj0N0+oTcULzbtTT4UDbW9SuNgrU0ViyspB8/NybiRKiDi0P6dE8+2CkfDBzw+Qn9lidWtiq8qkDPLKWh+rncFs9cYeM0y4cS8cE4xmRl+kgcVWZ9Nja/MtYOYlq3ndwOlnLCq5qq207NhjhgpRUk4Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311852; c=relaxed/simple;
	bh=jHrWph5jC3Znt5pZe3tKT2R90fIpAl5Qa1oqRB9HHiY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=FItBJT9lAxYIHUfBrA4dSWBZ0eq58cxLoso9DVb1Wq5mw0KCLL83TceluxaIQjZUaCyLlBUqK7Hnm3cL/OWpk176zYjL2HOavZQjCSq0UleW6umL9rVA3+0iO3mkCreRXS7bXKlKhPiAuFIMRBDLZSMkMLWtBgWQswzNARdOqBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nqVJeOyi; arc=fail smtp.client-ip=52.101.53.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS15h7kH7QZ7Z/DKLP1v/qtqwBElUknw5eCApbS76cuNr6qzIxBm5bnkaiL6mz4ibp/GvogV89HApfbtZzIV8ldZYhXLlPDC9H+l3fVyEPg004GBnUiXwxy5H/+gB1h8AKDERzvwhIGDWG/psUBDzvA54yp04GIKZSyqWuAYEI0ejeEMem56X0Wi+kcNGlyKhzNO55BlRuvwAIyctKlBgqzMsDZgA/CI3PzhZKnsd34jstosuNRBmd/d4mEABYgybQ6WBA0M5BEvXjRxinHioZfE+gWOxInhRywbsxUZZyw3PH2PRnihWnEtXPK3HUp96uE7bvD/Px187HiDK+fF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKdumspuygYXVLwHwMpa70utUOHXlvLR8SuGYLuuTxE=;
 b=sVksYEpGnhsdpbPLf8VlHE8dHSw5bp+0poRWLl5s7uFgr2qoeVAVuc/K+kEtTSqfE5g/d8k+3X5sUySdlS7KMch+LiI71ooBcHp+vq1tnOZzoy+XGGhKukKs6K+YCJ9iEGoMilRaSYl1O7/kAoY9k9cSlVQFsVj/FstcUGEn6N/6iAGia+Gk0GdnfVds6W5gekczFeg8VNapgXzVyRsFu+dh8H8ufn6bpCZQDicvRlKOpusC+BdtHpidmSNE7HLqQhJgJN1rAMcG+EMZJ7rUvmfmUdZ7AjiQLm0CjzyoEs4WjGkpxBMas438nxZFnjhHI9ItWyKyKqfLTyOnJqbn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKdumspuygYXVLwHwMpa70utUOHXlvLR8SuGYLuuTxE=;
 b=nqVJeOyiJbSDW5HLAOuJyLMgHuKTTFswZGs9nBkStMDUb98Feehut6OavsvhHOY1qwi5ITcUuLTBUWf5xmRo2Dk34xCIHVDr1LoMW6Prf9Fq8cX+3rrTHcEih67rs8BPClEyFFQBxGMIn5x1KYXf0OUTpyDTUNvFqnu5Saq4qj7oID2B/wGYafCfxnqXJ+MMFhbHmuiroY0dVWGXpFSZkjuCPBvoVE78ZSSbDLcbuY5pZ7n507s/HQ57Ob5pobsdqq8t3gqFBYl/67+tQYW0dG754/dHq7FOyHLvkptDk0F+XtRxZQwqJXejXW+wEb5dkpxSgGdXJrzC3OEES10hmA==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 14:37:22 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 14:37:22 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 23:37:18 +0900
Message-Id: <DJHCTF7HPDW4.2N3NCSD35MKXN@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <ecourtney@nvidia.com>, <m.wilczynski@samsung.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] rust: auxiliary: sample: demonstrate ForLt with
 invariant Mutex type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-5-dakr@kernel.org>
In-Reply-To: <20260618230834.812007-5-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0314.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e1bfa9-95f7-45da-b6cb-08ded1fe1a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	EZXNRlvo9vU5l9OlNn5l0AGtpjRt+5kCH79mxVSBCKtxEkEho9tBVeIx8kt7r4byJcT0i/Rc5T+wmIb/KGpftWMvpUHr6D87fZ2K6u44F7kZQFOlDackzG0BY5W5YFjs5pkUcicLtRAskWZDDBoH2ouVymhstSrd9YxB7CIgOUc/OaaXqknNq8679o9OlR8/oMlr9oU369vraQKcW8zFOB/AWWE5G44C58ovg7iSO6rSbk/Ad6xbXfETqiyZbUfkLdM7XIuLPA10hfmzn6hN4ZEeMfaObCS+zaNtpiGPH12gaoqZ7GrIYurMBVdP7T0JX0snxjJ6N5/Y+9h3DTETHJrGZFffN62btKXDEf+uTWvjF8Sar9SUnetTGYAXxrRGZ5u7yz8rEnv3xc+FfZeEGBWJ5diwAoLDC9/4wfFW4vQv8XMLf/Cb16WLtqTwKb4IGeA3ZTtq5HGo6Ob7INP+OLG3skZYnFYwulXYNemuipM6yuyUVlnKUmlaFStaRdzYisC3IJfvzsLkSM83TYFd6D1mP4EGRqlkVfEV784c+wVUwpccsrU1tgnF2geopcsKSbOZG0p4bpT6SHCoEAapQRhPWsMXYkz8JvAVkUziFb2nQ/UBdLLxJO8wDNAV2iunyDph+CPLfaXYM/qCGrhr32JYR03GvNCNJ45v/fyKdrQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEJRVjNWUDgwS01WZExBZkFZQ0w3WUREcDZHUzlKN1BhYUwydWRXa25jWWs5?=
 =?utf-8?B?L3p0Q2JWRmw0S3lMR1lUMG9RMWhWVWRsUm1WbjFFWjZiWG1lbVNGRkhSd2VY?=
 =?utf-8?B?U0lpd1dCMGswbjhaTVY2MFJxcURZWHJjREFJeUdVZmsvSXdLUndDWXU2MlhE?=
 =?utf-8?B?NGpXTi9VYlVEQ095VEJvTFRoZlZMU1Z6WC8ySTc3SUhPbHY2RTFHTUZObTZ6?=
 =?utf-8?B?RkR4YUpnYXhpUXlnNDBrSXh4b1luaVZEVDY4T1JvYndGR3V1Qm9zZ2I3dFIv?=
 =?utf-8?B?L3lxeU0wMmxWZlJjUXVldnorQlc2SVMweWowL24waVFMeXMvRXFaeWxLMDRu?=
 =?utf-8?B?bTZqUUxLSGp0UUVkdlUzRzNVbXE2L0xWSjFNRWRPMzRkK3RPUzdxaThRTW9I?=
 =?utf-8?B?Y2Ewc2RsTEg4aWEyaHVBZHNrWVhMQkt5KzRYTG9ubllZdjB5SVg4TFJldVkz?=
 =?utf-8?B?VDZlZlczV2dBQWVwRUF4ckJrSnJlaHFlUTl4R25lS05iYUtEN05YUkF1Nmlv?=
 =?utf-8?B?djhxbU5TN1VzSkdMNUxMVTgwRWlSbGkvTmROR1JjNEZ1OHR5VGQyazBZVjdE?=
 =?utf-8?B?WEVlWGVvbS9CUElPRmZTa2lGZjFNQzRLS2hERXRZdmpmdjREcU9iKy9hVThZ?=
 =?utf-8?B?eDdFZ1IxSGxKZjdaUFFGTFluZVdoTXA3bWpydjVhd0JnKzZ6bjJnTHMrd21I?=
 =?utf-8?B?QkZvR0JEZGRubE9pSHovejduR2RaVzRBcW1WdFVSNGFERS9pcUN4Uis0a3ZI?=
 =?utf-8?B?b3NHVGdHb3N1UlZUbGkraDdQWk5qRll2a2ZhT1ByZUdmRVNWWUhERmQyQ3lj?=
 =?utf-8?B?TUlxQ2c0czR0M2ticHl3bXpZQ2d2dEpZcDVGZnZSaE9aTk5mVFJKa2Y4RHhk?=
 =?utf-8?B?Z1NHdVFxOVhpdENVNjRMVjBNNDBINmRBQWpacWpMZlZ6M2xWNGNtbGNZWE04?=
 =?utf-8?B?a1dpTVIyd0dBK2l4dTZodDdvMkxQSHQ1dmFqa3dYV1lSeEhTQnRrSThLYjZv?=
 =?utf-8?B?U3dsK2xyWHppU1RPOWRTc25rTkVvVExHN0NlWUpqQWhNSFFWM21BZWlhU1BP?=
 =?utf-8?B?VzI0YXlhdGE4QmhzRFdsd2tGN0dkd2dHWmxveU04VFhadERUaEc5STNyRml6?=
 =?utf-8?B?RXlVbFJob0FVWGJEQ1NzczA1RTRkSkZzc1NIT0J1ajhoeisrb0xpRGtBOEU3?=
 =?utf-8?B?Zzhsd2lBeUtqcDR5WVNXQzBybHpiOHVFV2RjKzRFV1JQV2YxeHhSb01VTGtp?=
 =?utf-8?B?U3duSWdDcGJIN1p3ZUswSHcwSHpDaENIR2VuZ2RJcys1anozNnZwdjJoazgz?=
 =?utf-8?B?THhnRG01UHFPMnR5c3ZJaTJ2TysrMUVnNWZBNVc1czRiUG5yR0owU091QWdy?=
 =?utf-8?B?VWJhN0tzTTJJWkJ4OG1oUGh3RXpEOUlDNXAxNVpMMG9CY29yMCtIZGZXa1Y3?=
 =?utf-8?B?MnpieXZmbStSK25OSnpxaUpQaWJSK1NSUGZOVVpZVE84NnZkT3lEUjJwYytk?=
 =?utf-8?B?T2ZkcDRTWEZCUEdDSml1aVR5VU1CWGEzK25JVm1laDZYR0NYVlE2dlgvUmI3?=
 =?utf-8?B?WjBURWI5UStjK0dSVlhVQXdxckRsSUVGRFE5eFFsbUlqalJpeC9IcGpWVUsw?=
 =?utf-8?B?Vjh5dXFnS05aM3lFZE81eGd4K0hlNWM2aDY1UTN4WVFPa25kQ0JTL0FPWUo0?=
 =?utf-8?B?d0dnVWJQMnFyMzNWdHBncmxmcnYraDM1QXVQWXhVeUc3QmpITE40YUJFRkpu?=
 =?utf-8?B?KzlGQjlpcGFiMmx1MVJMbVdzY1dkdkdBV2pZWmgyVllFZWlNQ0p4cDN1UWk0?=
 =?utf-8?B?emhOcXFQZ1lKQ1V3My9RTTJERmF4enpnNG9YSURRMFdWOXM2TllFQmRHdUxU?=
 =?utf-8?B?TytpSWtrZjlmbXFEcVZpYnMwRk91V3RaZFBENHFxTEQzOFVpaU54akhsVEl5?=
 =?utf-8?B?QUgwQjJPWjhoRXlLckE4b21hdXJrdU1LWnRBaVFoT0NhZ0JLZlR4NTlpSW01?=
 =?utf-8?B?MGJFNU0veUlock1hVzRUR3NSa0VWcG16MUx5OFJjWmNFUVRuV2FpQlBpSHB1?=
 =?utf-8?B?a09sT1d2RmtmMEpKOThMZUdSYzZ2aGZJY2JicmV5Q1NGU2xLekhlWDZDZERV?=
 =?utf-8?B?aFp3L29hYnN1RUxlSGhYU0xmUE8rVVduRkVrTS9Lc1Rud0RxVTJNKzNVeHlZ?=
 =?utf-8?B?bnBxaXpFWU0yM3FWTjBKZ0JoT1U5YmZ2am1MVXNVaWJrV3VTUVR6SFA5UDdI?=
 =?utf-8?B?djEwQXNBTnNjU3B3d2gvRmdnOUtUOHVUdVMxd0hpNUwyemNRYUhKbnVNZTRp?=
 =?utf-8?B?R1l1Ujl6SVJnc0RzUGthYW1GTHJQakdReVcwVk5UQnNvOXhGWEVrZ041RDlO?=
 =?utf-8?Q?WjnDMxNJ/cngvxowk1PxcWrlu8VP2RliIQLhnK1U5kJMD?=
X-MS-Exchange-AntiSpam-MessageData-1: ywGEd0yuTqZkew==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e1bfa9-95f7-45da-b6cb-08ded1fe1a14
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:37:22.3832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULoHcAjSydWdO4DUCDVgCuDjeZhh19/1tyfwyZnV674mGIKdSe54PaBXSTbdTnSi2zYqq/n9J/0ENH0cJncUDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9361-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:dakr@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D76976BF330

On Fri Jun 19, 2026 at 8:08 AM JST, Danilo Krummrich wrote:
> Extend the auxiliary driver sample to demonstrate both access patterns:
>
>   - registration_data() with CovariantForLt!(Data<'_>) for the covariant
>     data type that holds a plain &'bound reference.
>
>   - registration_data_with() with ForLt!(MutexData<'_>) for an invariant
>     data type that wraps a Mutex<&'bound Device>. Since Mutex<T> is
>     invariant over T, MutexData cannot implement CovariantForLt and must
>     use the closure-based accessor.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

