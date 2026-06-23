Return-Path: <linux-pwm+bounces-9354-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XUjtDhuLOmrm/QcAu9opvQ
	(envelope-from <linux-pwm+bounces-9354-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 15:33:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3727C6B7782
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 15:33:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=RjgZKdYP;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9354-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9354-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 306913010CE3
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441A42D46B3;
	Tue, 23 Jun 2026 13:33:09 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE39379EEA;
	Tue, 23 Jun 2026 13:33:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221589; cv=fail; b=Rq1U7VVFt+Tq3KpEQ5kfqAagSS/yOWk01a33aBAEN+9frJiwqcm9/SmBi+SG7lLFTsxRv796ekSs6oJsCj88AFDxChJb/3b/t51Am8HPN6V6v1tt23exKsEH4LFRkTmkSDCVMEZX9oemiaCRX5VR2dwbZl+kJH2B+Yamt3ovo5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221589; c=relaxed/simple;
	bh=InVJSOROEXKfRvqmRqCGPEk+Yc4oAiEKsqPY0EweFuY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=gQJfOORSsmKEYsfI0jOWXw9KhgTD7T+y7fe/pvvfop4RWvTu0ZlbBcWlNVP9snBRfp8ZefGeSMdbheF9kraxDLjNLa8aNPNLfi0clXMkgVwsDm2QvKHj7TKZn1W5zM/z8SqPzYaE1yopvjAMwQF8Qx1yj8EmcaFE6GwAuJ8cz/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RjgZKdYP; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXKcyAT6Vqriy0/E0OdIL76jStZrKJSDso97pVo9OXgPHksCJBoAVLUPj8nnH5PRSR4Ry967lfgOKtrttiQ9UMWqLSQpv51PJVTR6dUseXjWumnfDVDlYcMq/m+24Wl8w5sVfmRywH3QplkX7Tmx7QwBtY7Xh8mIv4w4nm7kihULKI2az140bwZaibWK2c42S3qpur6/VzxNu6kYl438p44OXKWTLHK1eMTjyWs9vdVe9wv43iIJ0lxhI+LRn0YaC3foEPyzOMZVPLqywApfZbgQ49h2H2e6SOvFoyH4a2DKT1ri8HINsVNP3+VTRyTpi6ocxcgdy7wbz0+PsOYm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InVJSOROEXKfRvqmRqCGPEk+Yc4oAiEKsqPY0EweFuY=;
 b=aehnSOqP01nyq69b7Ko3jtrPJw5FCP529c4ZmILWWgNcAD/KIie60tt38voP8zejFTWRDxETNvp6gl2hOm2UXsXFyEO9a82qoIpt97PDGs8ImlsdSzhYbKCnyzEHVRmbj2KB8QcFMvHp66CN2QdskWT16DaUZME5xzGwUIfapG49vAmMY3CjW58PDd9N/55j7FuTnxr9CQCJxq9LiCQwiukzX4Q80jKqWzg7b2VK8F1aozZt1n65nkE9ASjIJLSQlJbXLmW0jFYFODaOwYPj+mrjslzQDmSZeYZPvLiU3l7XB9PaSTMfTF8mgFjGKDOCV236Lv0eqSpTOOizh6dvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InVJSOROEXKfRvqmRqCGPEk+Yc4oAiEKsqPY0EweFuY=;
 b=RjgZKdYPZ33sE1G5Fzk6YoQhAwHMCnl+a4EK+QtUv6UpXtxT5qNbujS6zi3gGYNz25pff4hVyGvBkOqainuxoAHk2u+n4SdskqPA9J2l67nZI+WuttKMawelLNAoHVM8Bug3g2/jq8NMnDicly4fh8UAXUF2T6ZJrOEJLi/A7sa73ADBAGYhQ+aBw8mZG0/Go6mpvw1ggeWyj9wEX4YkDnKTWliaSxZX1lopEIE9Fltcc9k0Km/7IqrMde3eJEpvkdLTnb565nuCH3V73mluWVRDdFYXEjn3WhLb3lLzT6Wrf7sSJjjqXQYDuOXBGv4oshAb8tC0a5VhqjNOhjG2Jg==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 13:32:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 13:32:58 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 22:32:54 +0900
Message-Id: <DJGGTKMZA1MI.14TQ75ZLVGT3L@nvidia.com>
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
Subject: Re: [PATCH v3 1/7] rust: types: rename ForLt to CovariantForLt
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-2-dakr@kernel.org>
In-Reply-To: <20260618230834.812007-2-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0162.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6c4584-cebc-4be9-ef17-08ded12bf085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|23010399003|376014|7416014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	LIx3qCNrUtmHJt5I+ejN8npganRgDhw8C6s/fte2GwtpGg0NPUzgnVx7n62pYllCXw5lbrhV4DJ56+1nmo6gvJpk64aCpNxqUordpqF59A/mxOUiMH+6ti6x8QfU2wo4Ftj5zl+j1LHMDIuuZM55AdSmd+tqD1cRxc2t+fZqr0kPxXe8t8LhzYy22M5Gzvf7+pbyg2Cnax4DIBXr5ELnj9IeGcB/ALFMDsfTVdK/Pogj0JOMMtA4PpxOZVLdUCpAiiNzVrajiJ4CYZq8qxuudw072gNxtbuqi//fA3G/z/ORCAnezf+LS9tsOUn74bR1IoYVEXMJ6uFnDNbnGTt+5uoMpqxlsunRzup8OWCtrWr5FQ5FRPoHUvXzddDA7xT7a0aRXWDj34NAPMFX6pq1gDZGE1HkZqSVWk/KjC/nBzCD+Cuw85T9J1k1iFRiU1g6nc+LpiN4ao3hJALS26zB9yx/OMH3TzjRBF9NyDfHEYntV0e3beV+EVBKT9aIL+uh+cWqF77qCpkFEfOuCrQoKaYoZbJV82e3dBQ5p3GE6bMm6PCVG/QCxuf7q8P3TxlKGfU5zL33lxLFU5u3oTNUT1cJW7PggM8u8Wl5PfApUDaIt6tsXcpJF5EF2b41cmJXqSYGIYWdEKFKyFOnqoOdToMU2PUYjhcMyWKMjq1A7y4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1J6Vzgvc3J2WFpFUHR6WW9tRXV5dTNMMDJoVm9kRjJWVVgvVEdzTlJ0UlZZ?=
 =?utf-8?B?STVlWG1vUHdZRHd6K2l6azRQTG52M3h2bU5xQzB4NnM3b2JmR1NubmRaRDJQ?=
 =?utf-8?B?SFg0YUttcVJDTXJ6ZWRONTRLd2lMNUYrYlBxOTdRMm42WkRzK0lWMVJSeUs4?=
 =?utf-8?B?Q1poTGwxUElqa3ltN1ZpYitlN08rWXZQNlJuMU0xTGY3SEtibXhHbC9pOHQ4?=
 =?utf-8?B?RVVCWjllTGdMNGlGM3lOZTVMdWFQUW1ENHVybWx4Z0hkTkFOOStmMWF0dWs0?=
 =?utf-8?B?NjhBNnM1SG1hc0ZLa0VhMGdhU0dQNkxoRVpadUp1N0JaV1ZUbFdjZGtIWWNo?=
 =?utf-8?B?ZnFESHVFb0dOUWhqYXU4dm1zdXZJekJ1K3BmNnJvVmJ1bTlla1hTYzgwSG1V?=
 =?utf-8?B?Z2lMM21yY1JKTHg5NlorTWg3M2FVV1V4RTRmMWJwcXY4WElsR3E3bTk0c29q?=
 =?utf-8?B?Y1VCd3R3dFZMU09ieW4zZGdGdGtBU1Q5aFF2eFNUMjU3Y0tXb0hUaDBmNXJH?=
 =?utf-8?B?TGY1eWVteFAwZ1Y4OGpyZm1GWlh5L3UrOG1MbmIvRUtOd3pSUEE3L2hRRjZu?=
 =?utf-8?B?MnN0ZGFHR0Q1Umc4dFA5Tzd3TTgvWC9wcEw0NmROMWJvVnhZeVd6dnNqK1hw?=
 =?utf-8?B?QjBINmFWaVVTQkxVY2FhUHkvZDQ3QzJKSlNhLzRFanQxMkV5M1RBVXZkRlFs?=
 =?utf-8?B?RHpka2F4US9GdnlINGdQVE9PNVdlSGtoeWp0WVVrVU5WZ3kxdEt6VUZhYTRa?=
 =?utf-8?B?Q0J1UHJGMlF6RllrZWJ4dCtHbVVCNGc5Ym5MaTkyV09GWnNjTjdNUzJZRzla?=
 =?utf-8?B?V1dYdVN0L1ZEV0gzY29wQkJ0djBHK1VBWlNQWFNEd0pZaFhVbTNBV1hFR3Zy?=
 =?utf-8?B?M0VaL2ZlbkQyZ3hWRkJwaEsvWloxbUlxNEw3dUxuZXZuOGMyZXhBUUNaRVM2?=
 =?utf-8?B?c1RUSlM3Z3NwbC9YcG83RCsrV2NkOE1GWHg4dXZFMFFWdVZ2OGw2ZTJXMERw?=
 =?utf-8?B?RlAzRVdKZnp4aEQxVnVOSjJpT0lsS1JNZHhYNFAvb1N1Wm81WWlTQXlTWFlY?=
 =?utf-8?B?djlxSjdaUnorOFU2YmhQeFdpb2Z5MFBRK1BjZFhGMURUVE5GZ0ExS0lBcUZW?=
 =?utf-8?B?QUJCWDI3YmNJdzBUNS92MXVHZ0xFanVLRW9POGpUeW5FMDh5NHJZbkZHY3lQ?=
 =?utf-8?B?eDk0Rk43WitqTldqakltQ3ljQXpNWWRqWk12UUY3bUs4ZzdGYUVrcG9tS2ox?=
 =?utf-8?B?TmlYVWJOV3lHcEY1NGU0ZUNEdm1SQTlZVzhzSnY3aUQvN3RMSzFWWWQ1RFBp?=
 =?utf-8?B?ZzdWZG1HT3B3Z0dLUkI4bDhHRXJRdTlNdFl0QTJ1NmZRMW5qZHZnNlM2MVlC?=
 =?utf-8?B?di93anFLSHVEcTI0V2c0RkZDYWxOVCtYUGxhYVNSQ2ZSVEVrQWlUMDlrT3hR?=
 =?utf-8?B?Yy95c2dCYnZQOFlWN0ZyUGpuNzhLa0hEWlA5K2s0dkxvc3ZkajdoTDVFWjlW?=
 =?utf-8?B?RXJEZlhyOXBWNHF3UWUwRE9Pa3ZmcjVqeWMzNGp1NlJQd0d4ZVo1cGxva0U2?=
 =?utf-8?B?WmgwSVFubHlRdHFkZmtOYW8wTHNUaVVrbjlnNmpIL3BlZW1vZVUyNWxBWG51?=
 =?utf-8?B?a1lyUkY4dUNLMkRxaGxid2V6QW9BaGU1WWFwZUpFa1hBalhLMlFycEpDa21N?=
 =?utf-8?B?dm1ta3JXMTV5bG1NZnp5aTd4dkFkQXYyaS9sRTNaNFFNYlNxeFVDN3lvUGgz?=
 =?utf-8?B?M0Z2RGRQTE5hRndPdDZ2cTR5ZHdPYXQ2ZDRrRmtyampyZGs3bkRKWTJLS0x5?=
 =?utf-8?B?dTFWV1FYRXREOWVaTzJZdytwTitDcjA2WTVXYmNTQmFBYWtvdmcvNkVGNUxX?=
 =?utf-8?B?V3IxRVM0SGZzRExEYTdDaWY3UmgwUXplWStsSUlxaUMzL1ZIVGlBWDR3VURu?=
 =?utf-8?B?a3A1YldPaFNVS29rcXR0QjQydnNFbWM0QzhvSDBiTDN5RnVMbGRQVVVIUzRM?=
 =?utf-8?B?TnV1ZURxVFdrdXdFVllTUndNWFNVWXcvMG9RbU1qMFVsRVZLR3NLL0xzTCtO?=
 =?utf-8?B?SE1tWkNWTjlHTUNqdWhzbVVrOW1UYkd1V3JXa0JwQ2FCWmpZclZrTkdTZ1lK?=
 =?utf-8?B?a2UxL2E2aVF4WExJSEwwSHBNQ2ZmWlRhbEVZNktmNmVQc29HaTNPcWErWjlU?=
 =?utf-8?B?bzlVWm1BTS9YZFB2ZWZWLzl0UEk5S2QxaGJwb2g4NnM0OW9xb05MNXVEbHo2?=
 =?utf-8?B?YklEeHROOVlrRjBRWUdXUzQ2eUFJemphRGtWSHZLekFRYSs2Tm5BUEhRUmhq?=
 =?utf-8?B?SVRqNGxiNEc2SW9WeHJaaGJ5NFd5THAvT05mL29ZNC9xNjMySHhSTDQzYlVs?=
 =?utf-8?Q?Z0vocKUlykzmi3+ujwcReywE1lY0GEWjjjeVctKtXP+NQ?=
X-MS-Exchange-AntiSpam-MessageData-1: R8x1wvhIgLC6fg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6c4584-cebc-4be9-ef17-08ded12bf085
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:32:58.6652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/K6Llb32U7DtxLAGmXw4cehI7dWZHwMtlIN/ppbinU5ReGgdBNUHS0A8JmUndvQtx+vvGnmtlBB089FO8P2Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8773
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9354-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3727C6B7782

On Fri Jun 19, 2026 at 8:08 AM JST, Danilo Krummrich wrote:
> Rename ForLt to CovariantForLt to prepare for the introduction of a new
> ForLt base trait that does not require covariance.
>
> The existing ForLt trait requires covariance, which enables the safe
> cast_ref() method. This rename preserves the same semantics under a more
> precise name, making room for a weaker ForLt trait in a subsequent
> commit.
>
> No functional change.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

With the Sashiko comment addressed,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

(I am also looking at the rest of the series, as well as its DRM
follow-up, but need to let my brain soak into them some more to grok all
the details)

