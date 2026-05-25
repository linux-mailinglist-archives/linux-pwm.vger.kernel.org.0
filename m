Return-Path: <linux-pwm+bounces-9098-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFC7K+jSE2q/GQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9098-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 06:41:12 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F4A5C5B65
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 06:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 933BD3001597
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 04:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF5730E828;
	Mon, 25 May 2026 04:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B1fEXM9o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242A2F7445;
	Mon, 25 May 2026 04:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779684066; cv=fail; b=TG8Ejkv39WyM/7IDxHNKEy3I4xH/rjOz0wJp/21vZ25jpDb9raoCHNLqvB6VmKTQTuqSJ8uZD1SbJHlwRKjWD/v9nr7C6O1EHl9MnZ9fQG2mwrJ7fHkanMZAcf5Ob09vnD0Zma8n+gor6JeufGGqYdtzJq05aSUloglSmrtjw5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779684066; c=relaxed/simple;
	bh=dasP7u8oPzy/GLs9S4rl7KrV/HfU2diHeRI4wUYcvJ8=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=p5pqXuMhBUMHarIQt8DiUL4mwJDxNcDI9grmzxMW1ImPtC8/Nonfet5mfKb5hOrsYER6Lkec3eCvw5q6Sb7S50TeDkXj9dSxg9ExqloGYdAro3JZxHhmijVInAiDQycRCXBoQMvhNWlYmmm69r9a+fbf/kYazZrVFI6G03EkHKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B1fEXM9o; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIdnPThz9cWjU24FoPEt6cH6ikzzbun7808uKuDJCxibv89VGd2v2Y0yUkGLlc5f9onMOL658bys1aWPxfsSY2R2IN0GVT5Rhc20byV04FZiwNKUHP3Mpvp5JPhxtj2TAjQ7pIs0On+eHCyw+z61n99c7wDCnNMaB+Hq65rRkeALZ+s6IL+nHGTWJRRAhAnUVyAH4uYQDfhEkUUvKrAy0moxZe2YIvmz9wV5gPRD4DsjSa3a6mFQ1wPWmI8vV2qfYS022vYBb1nz46Glr6gNMnmMl3LptcoXO8RPqjamWXoGVobH/bCdGExDuOHyGR/BdFb/9aE5jIyRTUGPPPm5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dasP7u8oPzy/GLs9S4rl7KrV/HfU2diHeRI4wUYcvJ8=;
 b=HMDv0Hynj3FEXhGWpAos5iU7s1UaElBuIS8tNPP1c43uIaiefy2ZneplvOsm0Rc//yKmd+S6KhMbPDbAj372aem66xgAjHaz+WYz337F7MxYLvzIh43x0tWaTl6ebbWG6FiRxDQeLKLdNF71JuODU5+iCLFE2ETEQAMdB7/ZjpeU/UlHsAQzGiLTbqzvSI0Tmum89aeTTrHALTk82jJzKaA29ybLI2Zl0YyZ8MFCRM+ht0wWEOs5DPoQEbPgSZaMjW2G2xx2eaWtW0/uLoj1U1T5JQ9C0e63uan18lJnnmsCytKN/uQfAU+6K1ecsNdSGdWTjsuZWfGGaXX5AzLxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dasP7u8oPzy/GLs9S4rl7KrV/HfU2diHeRI4wUYcvJ8=;
 b=B1fEXM9oxTrGJc4+alKg3ERRgf6Fqb1QW26An2Jc/AxF2CW0ejBuBMANlYQjgk3/RvVaRm6gvMjsc7KUC6GHLLB3DlZe9dUW10i5sk9ogTt93fnQVbsZ8CaT7XRqyB6a/GKegIVDZaJcrszyTpeiyOJFWIWTNV5q/TynI4lBI/03BXR7aRsaWBd4lkPhZ6MxzsdXeyZVvrl8JEg1RexhEhoCg5HIYZEJ4+8SQGCD6vlpBmRyyiuJ9pRJMDnrfbdl1RScH90j/Bn56RVlxNqWB/BpME358JOBxTXaaOpnc6STxWRFzaxKxZ601LLbJTkvUKNV5fRwGcdBAYVi7kGW+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA1PR12MB999251.namprd12.prod.outlook.com (2603:10b6:806:4dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:02 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 13:40:58 +0900
Message-Id: <DIRHCHIRC9Q2.3IE1IVVFR47Z5@nvidia.com>
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
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 20/27] gpu: nova-core: separate driver type from
 driver data
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-21-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-21-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0259.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::7) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA1PR12MB999251:EE_
X-MS-Office365-Filtering-Correlation-Id: adfbc5bc-1f7c-4fa4-591e-08deba17d2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020|4143699003|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	TAhJk31PKtpYMBerdCQwbYsxVq3UX2Ki1bcF1IhTPKKC6e426mGGRQf+pqATXMOpChwhXGe2ZymIimCMwSOYhGY4L6ibMksoyx33HPT2RXI7LdeS2TE9lLmdTBnCnKULGhWcciL+l4NB79yKXKmTkvS+ttffyce/pv9vhKXtAHBsiEefzvnjsWKgMvw2gnMnj9DRb+pYaX95RftboA9NQrhDdCh4CqGW7P2IzWpTKyiNPCl9SxQgaSc/JVHPVO7jOsw7gZTWOb3wGxCmBjWOU5c3vTs/29q1NIXvgvqbViSkDM1BPh6xBt7TcV5O8GcNSlav8HSEKu8iPgxpIcwklFjx3pl70SZgeRupMIDXjVYQ+0XVlhod8MBDxoTf4o92pXbyy2RWCVC2KYaj6qdtLCRQapgQBEKNIwAZ/qrz56vK4bIRUIPuAysyffCs6skdNqhbh/IgN3tAIRGQxRTUV2/sWoyNRyS1WJZct6tudK2C3Ez+A0Pr+EslsN5jw2qKJxJg2eUDnShS3ktN8aOWh1Jy20N5mvo8zWWkG61JDli9wPFQqz40SzuU4CGuA2fagARaXABhlWgqKoeeP5en2XoS6kUtIBMOIsjUizo5cHDsBMpmCmjmCCvWjmRbfHVQap9SFUhfgqEJCg8xfAvC7iKbr83uhbC96XKmFuicx230uDufdW6hurNOWEtiN4wNAOje5iE2AgQjO15MHQtzhpd6aTmnGVFdlEUE3AHwHmo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(4143699003)(56012099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1gxZzlJMWRSWHhmN1NjVHNUYjRvRmxsZjZ5eGVMV1VIMmNEdUNqYnVSQUEr?=
 =?utf-8?B?bVJDQlBVU01vK0JBN1BFZ2xxWXUxRUdkYzJhbGRqMEp0Z2x2N1dBQXh3ZkpH?=
 =?utf-8?B?TWxRdjdLWVpUWGp0VXU1b2VRUkJya2NYb3kyS3NjeHFiR2RpVFVvZDhLWFo4?=
 =?utf-8?B?YjVxTGpqZ0QwZW4rTjQxUFdkKzNBRE5uK0g5SlZHMHBpWWJZeVVOd1gvb0dC?=
 =?utf-8?B?Wi9YUjZ1dDRjSVFXa0J0UlYrV2VPeWs5MzdtRmJtNkdPWjRPTXZ6L3pnWVMz?=
 =?utf-8?B?c2MyN1pKSmJEMDFxUzRNRVJRbS8rUERDVDZLZHhtdEZ6SVRJS042anZjNWhi?=
 =?utf-8?B?V3BFRHNOaTBMM0hrWmljSWN0MVRZMDF6OHdSRzNSQWdTMGhkL2tKalprT1Zi?=
 =?utf-8?B?SjBXVFc1MThhTUgrbHdiK1dwU2hNSHltR1htcVVWTnNlQmZhL3BESm5JN3M4?=
 =?utf-8?B?QkFnb3Y2dFduYjE1WGZWYkQzdDBFYnl2a3BSck9jRldScTBSUW5IMzl3TWJ3?=
 =?utf-8?B?TVE3ejdiNmdJUFNIUVB0YzV5dXNwekF3TnowU3RnenJILzFqUWpkQTE0d29X?=
 =?utf-8?B?TDcveFExWDh3dlZBMDBGd0FXbG8yVUh3amV0QzlxNmxsQnZDWEFTc05IeW9W?=
 =?utf-8?B?UUt2OFZBUjFncXhOWTRxWjZMTUF3V2RxVW5keXc2dDF0Tzh3SDRNdW1BNU1k?=
 =?utf-8?B?dkVVNHkxSnJINENCSkRHT2FJUHZjMXBaekpKU3gvbXpxMDdxR081WUpURity?=
 =?utf-8?B?Y0taVFlINXhMak5pQjd1QjJUQTBwM0s3YUl0TkhrYWFLVFFIWFJjYk5DZCt5?=
 =?utf-8?B?UjhVRGdkTGsrUHRWSTR1WnhKb1JtMm5uTTI2UkUrWDBZUHgrckIwVExLQURV?=
 =?utf-8?B?bm1wZ1prNzV2aE9ibDRUcU5QVUo3ZFVoKzJEb0dqMkhQWm1ucEJIRC9QUmhV?=
 =?utf-8?B?TG9oY0NyT1dkak9QV0VSM1dzN0NUcFpOTko2TWlkNGRZTjJLWVVWcWdTMjB1?=
 =?utf-8?B?ZWRtazlzUkJuRDk0T3R0c0RiUU9MU2ZwNUZjNERUTmxHMUF4N2FqUm5DZG9G?=
 =?utf-8?B?b0NNL3B4b1hLUVdsaFZ2cFVBVndPam43MnlvelRncktDTWR0MHZscEdLem0r?=
 =?utf-8?B?U0U2NFM2YnluRTI4K01TY2RyRFJXNlExSExQbFpDMTZyYVQydEIrL2VLaGxF?=
 =?utf-8?B?SXpKb1NMMlZZREkza1YyeC9XSk1lMVNwQVd1Rm4rS1ZhTWNYVTNvcldJcVRE?=
 =?utf-8?B?RTBLcXQzUnZLYUJGZCtVbUx3T1hNSVR2SjlhZzRpZk9FVUVzSUpYcXhBZ01w?=
 =?utf-8?B?RWh4U1cxUnhmb0hpS2p2cVBxcHJsc2I0SWpsY2FhMjZ1WlZkbDR0elltWlJI?=
 =?utf-8?B?TEhFdklHWXo3Y1EyUU45SkJVb1BGVFZHK0wvMUppaXlPcTFuRU1OZmtBMkJO?=
 =?utf-8?B?TkhPR1ZkY0V1V2t5cmNFaGdTRGtpcS9rMEF5bnduNVNQRnFqQWVmQk1OVmFH?=
 =?utf-8?B?Rkxjb2d6ek0wVTNqNEFuSTlwUTNOckhJV0NEMjJmelFOY2RWRm5nMnY1UDIz?=
 =?utf-8?B?TWxDVUJDUmMwTlF2Z1JJV1VLOGhnb2phd2liSHVGRHBRQXdzOHplWWZYUXpX?=
 =?utf-8?B?WUxqcVVMWjljb0Iyc3oxS2RSSmNWeEdPQUx6cFBRcXVkbndlQWhXaDZwRHM5?=
 =?utf-8?B?czFTdEVud3BaR3FUdmsxTGRVeC9pYzB0OXFCN1BGaWJNNTZ3WFBOM0hJZE9X?=
 =?utf-8?B?a2pMZmtlYzdmdGF1NTJxak5xdVgvclRvV2IrZnE3WXlMalhtc09HTmV5Z3R5?=
 =?utf-8?B?VEZoVlc2ZEhuNzQrbEdYem11c2U5SE82NnFBQlR6Vk9nYVkwZkp3eVhFMG9z?=
 =?utf-8?B?am9wQjExOTR3c0hBRzJyaWF2ekJCcUptY2gzOVBFWE5UaUREYXp3MzhWY09Q?=
 =?utf-8?B?RFllN0thVjAyZ05VNGh0YmdtNVY2aVBSK2Y4UTBGN3h3L0x4Y1hSMEkxRmd6?=
 =?utf-8?B?M0VrWWlLcUNreFN1WlNEazNha0lTLzZya0Y1bXhOb3JEcElDQ0JUVG92bmhF?=
 =?utf-8?B?ejBtNGFTRHJuK2tHdEFwYlZhOUtsRndrMHBhRW1adnpxZCtPZ3I4cVhBUVdh?=
 =?utf-8?B?TS9sakJwdnpHalhCMTVXTEZKdE95V2dKOWRpSnhzVDczRGhxL00ySndMRzdt?=
 =?utf-8?B?TUtDSEN4TWY0S1VEVVRzN2UyL2txbjFuc1lxM2Y5clB5YXN6MFZSYUMrd3dT?=
 =?utf-8?B?RkFuUzM3OWFPZlNzUitLa1BoYzJGZnBEcEYyZGJUdjZRaFFETlJyWjdOWlhC?=
 =?utf-8?B?Um1GLzZkUkpsbEtnejBzbDlLMWhwU0ZCa2ZnMHMxSWp3bFFxcXpGalhWUTlH?=
 =?utf-8?Q?JT+ZAIDXcANM33gci/+l0OTvZOnLQYlS4Rgnke0VJVnVS?=
X-MS-Exchange-AntiSpam-MessageData-1: dxakbIFrnbpwsg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adfbc5bc-1f7c-4fa4-591e-08deba17d2f3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 04:41:02.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DemN9qmauxH3aYl0XPoo/Hk6bT8Jo5053HBLiF4vBW1PoW4wVnP+9+M5GiMHUUFW4ev3BZq9/navJBwr+F/BaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999251
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9098-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A4F4A5C5B65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
> Introduce NovaCoreDriver as the driver type implementing pci::Driver,
> keeping NovaCore as the per-device data type. This prepares for making
> NovaCore lifetime-parameterized once auxiliary::Registration requires a
> lifetime for the binding scope.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

