Return-Path: <linux-pwm+bounces-8988-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGeFHfIIDGo5UQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8988-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 08:53:38 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A65786B4
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 08:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FE2730B9677
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 06:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3924239657D;
	Tue, 19 May 2026 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vlg2HpiB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DC031B83B;
	Tue, 19 May 2026 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172871; cv=fail; b=TsxXWrHk05X2ZG1a26X6qxM3yF73HsPBk3W2XNHX4WB+BZ/SSHT97qm9xy+/UL4Yk78uEIcSQLwRRfIgw9+kFouCRcEQXNM0nWyZZR8i2Tiap8vzhrbGnY7NQ8WpkHYRcJYd4UtxEJA5GIG58T6OPWvrSfXMiwHWrPK0ChcY7MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172871; c=relaxed/simple;
	bh=dsFlAKbZEFhDZODbUg31USdJ39HEtqdG+fvpbS+AeSg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=mv1rdqB8HS6uOQokfFDrRUzlaRtAbDCDOMH5fBk5HZICOz/kkFs8KW3raIVuhXaDAUlTfR6H3LAxlz7WFGLpQCN31WaoLoL7KfO382DyHC4uMf6nmLx/+cAfVbgpAnkhBXCYWN+ikL/5meby/QBRuOGcP5w+R7ZH5p5NTz9ZM7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vlg2HpiB; arc=fail smtp.client-ip=52.101.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyMtJK8mTluWXsft2bmN903LAatt+mb7poWiS3k6jU0xTmj49Xxxxj3saW7vQVDQG/a1b36qSbQXRJjebmw6h6AZDzEvZna77fmVTzWE0DM2A8SrqQxbIbL/+hcSftJBPe+h5xcUL2xodWd91457UYUoGVdJcRdpR2QBdySe32J/nHB9+9TO4MytQEBM6OOSQChMFvebMo07KYPBYCRyTNYR1Vgukpt13DcVrVMVdrJjg2w0+z0WBRfStHLIyEih1GbGNx3UpdVI0xRof3J6NvFVgqtnk3gVqQL8DMEz5+TDuyuh7wNoAsKWBbBReqWXfWGovNnC7hLTmXMMXOv7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsFlAKbZEFhDZODbUg31USdJ39HEtqdG+fvpbS+AeSg=;
 b=MXCMXTuD3CNgXcOlSxsYzmlSi6zhAawdGk4g9RAqVchHuX5/00jvvCHD+ys1LD44Nzg7lpxDIneTi+uaYElxnLFie4Uhh880uvtxOJU1ESKyOH7og9bprDiHWv2BhZp6g+oTvjws356SowHkT+a3aHzelQ8NfnovZolNftynuqf5uv41C3w3WTFPmUy2e8IxSkx7O7jR+3j6X6ckOS46q0LRhchIrFV5sjszWl4D4wsTWgyJr8CciFunZX99lrHv2goH4RLQyA/Qny+YaKS0AdkMbJx2zZYSos+AMU0lkKTedS4fprnmZjX2h3SwVcwCWHK5qVfjeujpNoEQDjgJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsFlAKbZEFhDZODbUg31USdJ39HEtqdG+fvpbS+AeSg=;
 b=Vlg2HpiB5GOmtFCTrXgffSIqUYsHq/7KtjHgLa0Y27Ijt/Jt7g+n928k/I8QBQDT67sMx6HfCH4e2nIsBKecxv5vm5GR+vjTOhAmEtqMdH9OaymYlZn4t+Tx8OE24ao5vya/FvMCcTlH/F12/H2XNABGdk1PGPXWttJM1FrJsg/mdiv+iafCwA/yml4OM7j8jUKrjcl4u5sPQteyUFP+tm/r26mp8wkLONVgMZPHd7NkyfUgsnKNC3VNxxxfzCpNimTrmfGfGCun4XdoR7xsvfxVhE/MRCdyCl6cYHAfMPiVzZY3Opw1AkOd2tHlQ6juh11IpJE1vUc6ZVET88+j7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 06:41:06 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:41:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 15:41:01 +0900
Message-Id: <DIMG559H0HC0.3HNDWA79F7Z62@nvidia.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 21/27] samples: rust: rust_driver_pci: use HRT
 lifetime for Bar
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
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-22-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-22-dakr@kernel.org>
X-ClientProxiedBy: TYCPR01CA0204.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7352bf-7d65-414d-4d40-08deb5719a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|921020|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	tjR5RtI7vhPD98HQipE6TFqoXgk5Y4oXTKYCE/Ru+sBrVrAxsR2/zYOcN0kZZMejK4e6zwFoXzg3p/GS7o6nSQNqlQFrshBDwPNklT6kLvUp5W0Fc70khZhmI8jV964gBXdEVuRIqO9I3udkiex6jVLyyaZRh85fFrEgg6xDcI0YmA6qhac5IZ06mT+NR3dvvwtNzTMzjmRFIQ7EOSPFkFlLm6pfFlzujeWVqSAIYgm5HpQPQ9UFJ7A6JlGBIvTh9srhvifJBKUmSVrYFBNNS4SgIWuZ3cno0vu2NDfabhIY8VWzCl0FEQu3U1O0wYTVYXH6tJKHdnbpJGWlS4uek/hBX2uK9cCqQbUkCRJOzWaC5O+rr586UsaRg3bAnsCOuCG+AdK5glc0LxhLMLGewJsjY+fh2MwfMGX9DNKMhXzti1cXeljQr3MI/WR+/ygUpeXByyfktQ8w5g/+50PIy2Xp6McECoD4hnjVeJEtSS9tqHCazsxI0Zzt03NtNGzLwPvcK6wH2wRyGj6rHekOjNwwFO7+IGrrLtGGa9fFPWsLfe1wt2qzsY9jXF5ChLRhiRX4bozRk58HrQk7/3St1c1zU7ajfZcAo/r5yQNYnRmWVThsyzBfDlXks0TIhk+M77NgfP8X8RsUa9+uIKVOb0n7KDEU9+lU6aHEyu4KWEXMN/GBZjGZvf1VKw6EZjrhb8LSSzi4tmvQ22+AkeJE3bDXsnXcanECCT678w6u4EU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(921020)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnpIUE9VNFkvb3UrNGNZSitHeXFjMXhBcXhwS2hVQjV3U1REL2RMRnBMZ1Ew?=
 =?utf-8?B?UmtiMGRPZ2krOVZveS9tMlFSRkRCMVVVcXl6Qzg3ZUxwNFliMTNTNTVwbldw?=
 =?utf-8?B?cVYwTENVa2pBdzJla1JCMStldlcxNVcyZEFqdlBZREV5Q0ZZREV2Z3Fpbjds?=
 =?utf-8?B?eks3WUtqcTA3SDVGY0tYQ2tJWEhFa3QrVVlWUTVJUmhIMEgwdnFsalVhYzFT?=
 =?utf-8?B?dlJKYklBZm9yUTFWckN3NDkxM0xMY2Q2aHBoY3YvNXhnQUdvQmM0UnB6MnY5?=
 =?utf-8?B?czJIU2pSMGhSN1VqVk9ZeUJYZ2d4dUJ3WG50bk1Ca01MZ2RsOHd0VklEcTlO?=
 =?utf-8?B?cGsvdE9DcnNNcDJwZDFmOFNhVFYvalQxc1FCZko2UlFqa1VqT0hYN3hXUStS?=
 =?utf-8?B?V0tPcURBUkh6Y3YySWlPMUVaVVFsM0lCUStSWjBSV0RuQlJRUU5nVTVLZlZq?=
 =?utf-8?B?c2pNaDJsUzhiUGpteE84L0U3bm9qZlh5aXlZTnpwREsvQWllQkNUdDl6a0sx?=
 =?utf-8?B?UWFVNHpYR2tVNTN6c2M2MmFhMUF0SkpWNkRDUGFHUHZtd1lhYyt6REdDQVR0?=
 =?utf-8?B?OU1WbTlsLzZyYnRYU1pzYVU5V2x1aDY1VWtYYkV1WUV1Z2JKY3Z0QktwQ1lw?=
 =?utf-8?B?S1RPYi9rM1EvYjVtWDA5U2pMdUd0VGhKYlFvTUlNV1FCemVzYjV5bmh4dHM2?=
 =?utf-8?B?bEZKSjNkcHVCTmtHaXprYVFtZ1JTcDJyMWxMZzJTOVFzMm81TXUvTVZRaHo4?=
 =?utf-8?B?b0gyc3krUDJNQTZOUGRVWDc3SC9XMWliSzNaOXdzVHJGcEM5UUlyTFVzK0to?=
 =?utf-8?B?VDF0Y3d4cW5LV21hZzRjQUdrRm05M2NaTTdIbUxFekEzaG83NVFtRGhLVlIv?=
 =?utf-8?B?Ni9ON1J0RlJUQ0xENUxQUWw2Z01zQUtRNmxsS0JZbXk2WVJ4dzR3eGovc254?=
 =?utf-8?B?dUwzVXdBN3RIRHp1ZlZ3TjlncmJDTU5kWHc1TDZiM21CaFRqQTdIU2QxR2cr?=
 =?utf-8?B?Vmo0TEVQeVNTVGthWTdBWjVTNWxDMk1PMDdoVi9VNGhUU1hoeXNiYVlVd1FG?=
 =?utf-8?B?eEQvOXRnYU9Bd0YrYU1PSmc4OExKelp6cEo5TlRQWFhnT2toZ29yRzVKWGZW?=
 =?utf-8?B?WnVleFowSDlQakYxcVFCaHc0R3hLT3YwR0RLT21EazNMYk5YbC9KcjBYWXAy?=
 =?utf-8?B?UFdFbzAwQTYwNzZjWkNMK2w0RnpkZ3M3M21PdStUa21scVJLY0xwNXlIYjMw?=
 =?utf-8?B?U25YaFQrRWsrKzB5L2htWEY5ZlNlS0UvWGh4T3NVRVpRQ3BPNktYVitEcWwr?=
 =?utf-8?B?QjFuRE14d2FORUlrVkwxakFQMEt6SkNKRTFwZHIxSUdxekFsUVNFTlVpdWMz?=
 =?utf-8?B?OHVidnRmajY4TVExR3hwRkZBZTdoc1hSVEw0WHRoNHdSbC9tY1cyYnprZ0JB?=
 =?utf-8?B?aHRnZzZoYlVVd1JiOFVVUFpTSDdtdW1UT3NZWnFrdGZ5MHdwWHR4b1UzOWRE?=
 =?utf-8?B?OVRwVGpmOU1mVDBWVDZCRTFva3RYVmZwQ0trTDU2NkQwRjBLQXA1RUQzLzBK?=
 =?utf-8?B?bERRb0J5ZVVTUzluZjhyTzlxVFdNMFlSUVlxWG5mUHBvR3ZIYUY0RnUrUXBW?=
 =?utf-8?B?QlpuLzQvWTJZbnU5WTJPak53TlZmZk0vQm5uSkFKZ0p0QW9EVlo1UFJFK3M3?=
 =?utf-8?B?L3UwMHlFMUY4UlpRczR2RkNqZExrU3B6cjB5MDRQcU1kTEtJNlgvcC9qOWNT?=
 =?utf-8?B?bHVTNm1GRjhVekZtUWxaNmoxcjdZbVNyckN2T21xUHRJRHc4eEVsK2NKOUxE?=
 =?utf-8?B?NWcyRzN4T2xSV1ZEaGtyTEtGbkdJdGpObnplVkN4dmltK3IxYVA0UG9GaDE0?=
 =?utf-8?B?cEtVUENzaXUvY2x3YkpPZVhhVDIzdWU2eDJDcVM1NUpEODJwTk9HQ0R2S2Uw?=
 =?utf-8?B?LzJsRHJLcW83YWd5Qm9pclRoZldDMWR5V1lucXB3SHJSZTJIS3VMenJKeU16?=
 =?utf-8?B?V1hIU2V1cGhEN04zMmx5NG1oVkUyVGpTbDMzSU1uZTRBTS9TeU5GMHlWL1Bh?=
 =?utf-8?B?V2h6T3JtMnpQUm16VEFVS1B1bmZYcnl1N1pwbXFoRGJRWmpxZUJCdk5IMVY5?=
 =?utf-8?B?LzIwWDVqdFFGbFZmZVhUaHVVOEM2YitxL0NBL3REQnRxZmh2Q1N6VnZtMnVB?=
 =?utf-8?B?SlUyYkVNb3pibHBscmVKUXQyQ0swZjZkUnBhaTVlcGQ3d2V6VnRjNmdHTmF5?=
 =?utf-8?B?eVU2N3AvYjdDRzFaWUt0eXdyUkN1WFZBK0c5blB0cUhLdzdsR1Rid0haK2JF?=
 =?utf-8?B?bktiNmVOcmY0eDJwaTR3UW15NFhRMWZoUnkwUjd1NUhUQnhPSXJDQVBVclNO?=
 =?utf-8?Q?ZBgdRQKHbRQ/RqXL+4BFvfEU3Oj1+BwSMgE6Mx7huU+ek?=
X-MS-Exchange-AntiSpam-MessageData-1: RD0yQLcsceQ88Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7352bf-7d65-414d-4d40-08deb5719a4e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:41:05.9721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTcWquOktK25/T/ZdXB7xaGNENe8LqLaonhfO9Z64uexEvDVrLMALtnLdOF3I7oSBh8d3E+mbcwx2ej3zHLQkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8988-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecourtney@nvidia.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 8B1A65786B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
> Convert the sample driver to SampleDriver<'bound>, taking advantage of
> the lifetime-parameterized Driver trait.
>
> The driver struct holds &'bound pci::Device directly instead of
> ARef<pci::Device>, and pci::Bar<'bound> directly instead of
> Devres<pci::Bar>. This removes PinnedDrop, pin_init_scope, and runtime
> revocation checks on BAR access.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

