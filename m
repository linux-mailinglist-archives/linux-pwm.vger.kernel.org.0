Return-Path: <linux-pwm+bounces-9115-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOMkLGVBFGo3LQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9115-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 14:32:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDB75CA8DF
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 14:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 747EC301CC41
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 12:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A9F382294;
	Mon, 25 May 2026 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mBhvq2H1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5A381AE6;
	Mon, 25 May 2026 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712321; cv=fail; b=O5OGIONArS5go4rjZSLaYlTgIoKVR3M2Coh3w6YE/gvLbKBGghjVGTnbRNLUeXZfBrru11xlfDTSniY9p94VnAtGxBsRLEnBz7RPai/C0w8Pa6wgmsWY6Q3a6m5CQvkA/94xYoSZLZDZtMch7r8z71RREhHdnPg9Lyc2SaDJuSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712321; c=relaxed/simple;
	bh=6IWG2vvi4P/RboeWscBIgbE+nufcSOckFJYlogRw6Bs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=IzE+H3ZC5lEePaB4yEH6o2qbcC2fMFOJZNXIm0l0jqYHeMvRFPwR8mj5lGh+TLh7OHRV4dzsMd2Rn9wTPrKKMw3xVwRFKByZ2W6le8hCjFcD9T6B9JGwr3fpMcbFkEpPntqbgMVyw6zmyjsDpl9FLrAUjs0hobRRprXyXmxK2bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mBhvq2H1; arc=fail smtp.client-ip=40.107.209.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dn4BeU7KiQgKHEmISgaVkRMXWs+8jY+0ierYLNaj8ZlRKfI1fLAJvl9Et8ULxQ0epZDyVAPLH3rlnmObsZwbpFge4Pdi3JSiSMllJULn+yEhBkM3B0Q+tmDooX0gFxc+SxKbdNdBu4miLaP+wkLn+AIbaPz50LX7khy2IwywGV1i4/hOIGFuU4tz/Ycfbz7h49AgPRR7dEVoKoNACHTxgoVj0eE8XjOZDrlctgvswjEvmDHEWgjV7pAMpg92dxaQxmUqWIx+EhcHRX5Y2OZzuDH7lJ+US4ZsOeQRDqtNtzYrSdHKtpHSNBvwe+EIWmoLZmHo+1FvlP52zXpB5HCyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+6pJtLglxHJ1LvUkb6gF8o43/tNRawXxQ0RKYh+YAs=;
 b=cZ0ykZ+X+D3duhhs8sLI0WkJ5QBBm4wIazfnC6ZVU0DyH7odH/dyMMe+mbp5VkNAvh5tjwV7RFnZif1UGGGKtdgEwl7vfX2YWQ1ISI89RyLjTgqCtpPo1/mItt43MKydiDZHuajnMgTJUASDko4Ct6Ykfxk5K/L6wsfIG2qc0+AvW95b+H1Hk1+8Gc4O9vRy9Uf2YUcQO/cL+xwiTraL21dsjQtIQHxgI/BIeqHtC+5IBufLf4HCNy6il/qDXQRaCjjpA7143sFYx6+Rg0cQujyZvKMOHO1NEYj5xazUHUACta3ZYFASgB0aufdib93JIKBfm3jNmX11vG2dKN2mGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+6pJtLglxHJ1LvUkb6gF8o43/tNRawXxQ0RKYh+YAs=;
 b=mBhvq2H1rpnsni8aphsRDLalLz5VuFyPWgMVbeXsLBuRUjmgOIqXSV++w6ioIhv0JmonBnYxoqRJ9Yr2ZQLzgK9HNI+l857q1Zh47TZJSRkH8bk0Kcn5z/yrDpvK65WvsqA88uJx9jrlI4KdJEcErzdNijEHirDMPClYU/HKEnuU6y5g+NJ9C+pVo3KnvxMraqO9qb89Rw+47zUuTlf/NE565Fp1cIOulsTSN2pZ9FSE8LDj+raztUDWqeZ+eJDF9CsrennCV7kHk/aA0NlL+mB4tbMkBgv0U7LR411wu4oFtl1MOGKuFUzgNl/KQ4/JRIC+24ye1usuHTgAJS60yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 12:31:54 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 12:31:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 21:31:50 +0900
Message-Id: <DIRRD0MA3NFR.1DFWYY2ZLLZHQ@nvidia.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 21/27] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-22-dakr@kernel.org>
 <DIQ696JK4WV0.2HOQ57L342S77@kernel.org>
In-Reply-To: <DIQ696JK4WV0.2HOQ57L342S77@kernel.org>
X-ClientProxiedBy: DS1PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:8:458::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b03e3f3-e30a-4b47-513f-08deba599a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|18002099003|56012099003|22082099003|921020|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	9OhHGsmlbrVqpxYfbsxYzEahE1KANameJxJ2EyoqeB0Wje/Bo1kRFrwKERIaOL2A15M/5lRFUs6Q1W6pddvGJSKhKDUvnOigsJ2l10sS06/7Z6109oEx2Ynvx6UbYdvGjq5LGq3Hjp0a+JJTkQsGfvQIwcrCiCk5rsjR7sR+Gh8vHpnyB6mghLbf2cIGy8tyGhD9LcgMgqnZXJH/bbIYcAshHk9cuDDkBNLyJ/ZOFwBeidoY3KUrYU+XNHn40/w32nBgtY4fZwXDSAS/ANWqJ6oSOVM+KArIzROMAwLbORKjGuZlCngFWqsjJbxLOWh2llvIA4M2Y1G9NsiNeND1XJD94e+m4qux+hYFv1dyNn7O/E81n4GyNoy72cwA52d6gjk0ABZXRNou0kkzyrDuagW33VFM0pGyZG7qPjytBRSq80G0XKByrTOFEMmuXixOyb/VMIqakY1DXtQaYhBtBnWXSqLyd4iEBaihoc4FYJzb6oTGk6VYBv3OSdkOXH1hbfRWQ4FkhJtezWEbylBtNmNog1m8vck87jvQXlzrfR4NlgdfNFzM5w6niGeWNxP2mWyVDFYFTWpiLNXutI30R5O8gV4AgONt6Dc0CktO8YCunqyiG71sPi9zWcrUDk1cOPInyg4i2bX5+mdyxpzbtOTDsLANVEANWDmtw/EJ3QODIALhH4Y0hHksvzVMTW8g0IHAqDTmMENkxEV16ihpYno+pxKvUBmXd8TjpW6lh/8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(18002099003)(56012099003)(22082099003)(921020)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk5yMXpaYTR1RHoveEVVQ2d5YklVV2tmZHk4MkM4WXR3SFR5VGxzbzJFbU1T?=
 =?utf-8?B?SDJTSi94YXh1dUhlQkpROFdScFdjVTNOSDdDem9OZEVYUHRPRGdTWmtweVNm?=
 =?utf-8?B?eTlDNE9ZcGFaUDJWVWRlS1NENC9RRmZPcDU4WUNPVmY2aVlUc2lGckYrNGR0?=
 =?utf-8?B?b2lJajZQeDZjVTFML2xDT29SK1FLc2FpRlcyOG1wdExOeGJLNzNVZVJVdWZW?=
 =?utf-8?B?dlFsUi8xUlNaQ3ZCWEZld2p0N3ZCSjZIUDlhOEhtRFVvUDd4cU9jNkZxOWVB?=
 =?utf-8?B?ZWNDS3crY2xHcHFQendkWGN6b0dPU0VDOUlMdFpYMjV3aEZFYXdKVnlLVzl4?=
 =?utf-8?B?UlQzb3phYW1hUGVUTW5aYVhPMTVkVnBQUVk5N0ZhMm5qY0VQRm5wRHdyUGJs?=
 =?utf-8?B?c3Rzc0xEWk5RbUVOM3YzbW9xMU96SGNJaTdWWnIzbGhVd3Q5NkdPOFhUbEFl?=
 =?utf-8?B?RWVxbUZrWG5nOVhFY1ArTWIyV1N0dmQ1YnRnbFhrMUMwb1l6MkhRd21pMUtM?=
 =?utf-8?B?MmUyYnZiY2xWNGl4aWhRNnkyTDVrc1N1VzRNRTlJMGFpRlBVN1YyQjFKR28y?=
 =?utf-8?B?ck5RVlNjVVN2UDZYUlhEcWxObHlVL05FSElDa29lV1U4SXZtRTVLOGtLR0pV?=
 =?utf-8?B?RW9vbllCa1lEeHdZby9FQzg5MzJibTNLcmMxU0FkSlJwSkFrendqZTMwL0V4?=
 =?utf-8?B?VUx3bDhVNVZrM05PMkxORzZ6dzRQdGVhYU1tWm1PYzNadVh0S2JhOTViSXhU?=
 =?utf-8?B?b0swSHhsQ3BFYnNxSXZnQ3FLK0lYNFFHYUt2ZVRGcGFlMXo3VXYxck95VEl5?=
 =?utf-8?B?cFVWditrVXNzK09JOFc1VENiMXEwQnBtdXJVOVZhL3BJajJXT3YvRmppa0RI?=
 =?utf-8?B?Mk1xUVgvWk5jZk1Zd1JkbWVOU2owaVJCRGFWSDQ3TVlVOFV6NmRCVVh4VndF?=
 =?utf-8?B?MFhMZU5zNEJ6UVU5NldSejNiWUhkeHJkNjg0Z3dOck9kL0YzVGZJbnd0dVRN?=
 =?utf-8?B?MitiKy9DSTcrODNYdEc2VVpFMVh4RXFPREREUXlKdnFQdDZ4bVVFdlpoWEw1?=
 =?utf-8?B?MVg5c1kyTlRpbDJsV3BqeGt0OUZ3cnNDekxkaHg2N2praTRuaU5yNyswdlF3?=
 =?utf-8?B?UllsNCtHYlVTUXp2QWlPNmNxUS9WaXlGQnVqYnljMVd5MkVCZXg4eHVOalp1?=
 =?utf-8?B?b3VaQmtsblhHS1FQNlJSbEtYTjNsQ2cyWlNFYW52K2VGNnpNTEJEcWdjWXpt?=
 =?utf-8?B?emdRNFVqcytkZVFIcURpd0NleWFWRmhQbktublBJdWpDU3RTWE1POGtwOFYy?=
 =?utf-8?B?eUdzc3gwOTFYQVE4WTI0a05ISnI0cEViUUNOdEVQbHM3RzNISVR6bUxrakVI?=
 =?utf-8?B?cTF4bXFsNlE3N2E5ZzBTSlJGdFNkNUFPRW5VNk1uaWc4MkdabVZvclB3T1R4?=
 =?utf-8?B?UnFQUnFOT0tXUmhibWJNM0s2ZkVOVThVT0pSRTVKT0hiU3JpcDNDRDNsNnc4?=
 =?utf-8?B?T3U4L29LOFFMWklscnFjcWlCOEVvNzNrL3NLOGtVbksxZWRrZlEyakplUVU0?=
 =?utf-8?B?cEtFMlRGMnlwZnBndm1iZ3JkeFdlQitGRlFJM3ByYzFwNjh2VDZjTnZTR3p2?=
 =?utf-8?B?NmRUbnF3dXdPcERNZEE0aTROK3FBQ1lrcVNXYlJzWmxqclZEbHdkaE1VWkdq?=
 =?utf-8?B?VUZQTUU1ZGpSNElSMnQ2VHNLWTBqWlRKYUpCU2tlb2IxZE5aYVBCSUNJZnMy?=
 =?utf-8?B?ck55c3RhUUFBaW94K1FFWlEvNEVZM09QQlpsTzZKT0VWeXBDNTRZMlpzUkJK?=
 =?utf-8?B?WDFXL01ZWmMwR1duVmN6eW5lMVlLRnBudThpeXNjWnh1QjI1c3M5T3dyYUpH?=
 =?utf-8?B?MWdadDlyR3E4ZzhJaVR0TlB5cHd3OG1aLzExc3ZmQk9rR2RlZkpPbVR4L0RM?=
 =?utf-8?B?NlhyNk0yb0M4QTZpcUxVS0hGbE16Zncrdm1iQ3pGeFphclN1QXMzSGc3WDdl?=
 =?utf-8?B?WnJYT3ROdEVXQ01vdGpEbkRUMTZ3YUdQS1F2RHcrMU5tbjJURkFVWDlIcnZY?=
 =?utf-8?B?cDg1M3kzOGdYSE9rTnJiM2kyS3ZqRG5NT3A5ZmpBYWZraU1kbGVHdk90aWdY?=
 =?utf-8?B?cE9CKzJCb01nR2xBZFVVWHMrQWh6N2FjQ3BadTRvVm5Ubmc0YXh1NVVsU0pC?=
 =?utf-8?B?YmhubFFERUlETmxpN2JCNytaSk1YMjZWTEoxV2xGYnFML3hlQ3pldGRnSm52?=
 =?utf-8?B?R2hlSlo0RW1PWXZrWm56YnN0UVRiY3FxS2h6MWR2ZUZlYkhDbzBndVJJZFA1?=
 =?utf-8?B?aS9taTlLUUMzc05CQVJnUG5QSHEzem8xMTBUYzJUWDlRT2IzWXk4aS9WamVx?=
 =?utf-8?Q?g38q4Z3XnnJqsiYjsswokD6HKjqUdDRq91fML7LMVKefy?=
X-MS-Exchange-AntiSpam-MessageData-1: Zdfk7wh1+yJYYQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b03e3f3-e30a-4b47-513f-08deba599a62
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 12:31:54.2006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iatyMe2Ku7Uz9JA/L/jLWhTW2UQrYMl2zzAWpGs9deZkz80LYhpmr/hltlqs1B/EdCDOV6uO8QxWy6Tto11/fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9115-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecourtney@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1CDB75CA8DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 24, 2026 at 12:46 AM JST, Danilo Krummrich wrote:
> On Fri May 22, 2026 at 1:34 AM CEST, Danilo Krummrich wrote:
>> [ Handle macro_rules! invocations in the ForLt! proc macro's covariance
>>   and WF checks.
>>
>>   Proc macros cannot expand macro_rules! invocations, so the
>>   syn::Visit-based has_lifetime() and replace_lifetime() helpers cannot
>>   inspect types hidden behind macro calls. This caused the covariance
>>   proof to be silently skipped and lifetime substitution to fail for
>>   such types.
>>
>>   Add an explicit Type::Macro arm to Prover::prove to conservatively
>>   require a compiler-assisted covariance proof. Detect macro-containing
>>   types with has_macro() and use a WithLt trait projection for lifetime
>>   substitution instead of AST-level replacement. - Danilo ]
>
> I was made aware by Gary that WFness is not actually being checked, which=
 is why
> the static expansion was needed in the first place.
>
> Thus macros will remain unsupported (even covariant macros are rejected),=
 yet we
> can improve the error message by adding the following diff on top of the
> previous v3 patch.
>
> diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
> index df2027789713..75d0ce450bf0 100644
> --- a/rust/macros/for_lt.rs
> +++ b/rust/macros/for_lt.rs
> @@ -107,6 +107,12 @@ fn visit_lifetime(&mut self, lifetime: &Lifetime) {
>                      self.1 =3D true;
>                  }
>              }
> +
> +            // Macro invocations are opaque; conservatively assume they =
may
> +            // reference the lifetime.
> +            fn visit_macro(&mut self, _: &syn::Macro) {
> +                self.1 =3D true;
> +            }
>          }
>
>          let mut visitor =3D HasLifetime(lt, false);

With this change,

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

I think also this implementation considers &'a mut dyn Trait to be
covariant in 'a which isn't the case in general IIUC, but I can't see
any way it could cause an issue currently.

