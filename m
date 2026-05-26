Return-Path: <linux-pwm+bounces-9158-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GviNCU0FWqPTgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9158-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 07:48:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A9F5D0F3F
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 07:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3869430143C1
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 05:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615E63BB129;
	Tue, 26 May 2026 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CL+fQ+Bp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BC29D264;
	Tue, 26 May 2026 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779774499; cv=fail; b=CuJQEqlq7Ri1OghU+c2eWwvoBfwLnm898WXy0Cr8Kx/ilChpM4cmEdo63NzyGuqoyc/eT5LWpdLUVmTccumKNQik+hnImp7rrWeI9gnOrje93xPFQTEwF+ZyzJMxW3OYIxKCDOKwXnMNQgFIZDw0Mu1mO5dto2sczYsJqQ/RV7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779774499; c=relaxed/simple;
	bh=gaGhEBgnO7Xo5n6Nty3gtRgo3LwETWX9IPTIPtfLQWg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=aFM2uQE/z07uWDoDiYD9+HhWMoGD1BtAErDT+kNisIiowVIGjm67YcQK6Ht0WoYMWFnq3NMGDU2XMgsYZrUUI2cvUFGwv2ZECZG1LuSAqVvuSRArSJ+6KZ4nJSRtHdyYurzOf4LevVsgjwsyO7JMLDD1mjjy0XAV83qP22id+ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CL+fQ+Bp; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6xggtZJxlppsrJ/2nfPnWLiXS6PsrKSKjCL2qGw7iAc1depdDqWDTwlVFLwwuwRoqQ5eicthHz4s0WAqUHOieOA3z1Lr2NV3vejmfzzF3bl6lkO0iJIPA6JDgILJPgIWK2UNPrzMWSeNEbqSoPDPSYy+0TDnOLmM6AwJW8QAuuqHzjU7jerUGWSvPYccu8WACTZMFN9o0+YSE8WF0zbtv9c5NQi2SKLbGykZQiy0N3YO6PUfsBfOVxQ5B7xJnX/ix8uEOJdthWwLkIbVVBSB2K/JnfPTiEwPneHEl6RmD6miTLZ+Mtfb7s2F43+P4h1tDhdeg/tT6abo0zyiMS/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaGhEBgnO7Xo5n6Nty3gtRgo3LwETWX9IPTIPtfLQWg=;
 b=Tvhcr1nf2lXtDi1/yljbMmJl82j1BLrk00khYSrOSsuU6hudRYjPly5pDfw1FKrlAzteVaPRKW9UYdOQVvqpuOA4fsPtrfuL8qJbdr6ickynILxcKz5S1b8d1gpWHecPQQKtWcvi0Q5kHBFWNgquYt2S86brwWvqu325vnM3xQvYYJCf2+BMRp1xUjr0KcrXJ4fR3G8LvgFDvKSNTOf/L879r0z5Kda9zufcE8QvBHjIWTGh4s1pOrAUY+DIaY+q7EJAiW1Rh4Wi9+unIHrpwdROSHSI9VpfvUOFtDy4u+PaMw9rKDtQWpJkWa3Xyz7w6raX3i69IueX1+oigSKZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaGhEBgnO7Xo5n6Nty3gtRgo3LwETWX9IPTIPtfLQWg=;
 b=CL+fQ+Bpo81/O/Vcp6HNhVU6bl7GMbGOkFTqD9Fx82g3kOHRjJemYp3MXznAUdST69oxOteAoXwwWvwvpsO6ZHVQNuYE+mzEESv0BtJ9f75j0dbZJHhTjKqqKRwluA2AyExAropzss004GlmXJb9TiKf4wbSCm5IbLmEcoCwmqgPtfwczmjK561Jh0s8zQDAnVt1u8FLngrnaU23WkiGdMhV0tzLde+r/Y+J4G5KPmKNnAKUdr3se+6E0/vCy+1xjkutkdakJhoduLAjq4i+mkQZ8aDIgzZ+St3BbmXvXqrVhxxshyhd/T+SkO1pcxFmLS5kwm1sKijBmiXSxeGXyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 05:48:13 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 05:48:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 14:48:01 +0900
Message-Id: <DISDEDNTJTAM.34F0G4ZRHG37@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH REF v4 24/27] gpu: nova-core: use lifetime for Bar
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-25-dakr@kernel.org>
 <DIS8RFZO6IF6.OMCDPD24RSXN@nvidia.com>
In-Reply-To: <DIS8RFZO6IF6.OMCDPD24RSXN@nvidia.com>
X-ClientProxiedBy: TYWP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::8) To BY5PR12MB3986.namprd12.prod.outlook.com
 (2603:10b6:a03:195::27)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2f3c84-a2b7-4c69-93df-08debaea5eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|10070799003|366016|18002099003|11063799006|4143699003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bX85PBywj+hQ868Du3ngLrH0cK/CUTpUne/4J+OcOM+KkLmRrY5bMf01Lwr3s0kAJYFYrcHBQa2NZ8mn5/iUKOibaI3ufUDS9Wj8lwOseZNvSBcuKEzztgx6FQeIGzdE+9P6nEkjL+ouhxT28LdN50szZMFMZPZi7vOPdNAqsNJxLUl8FXJ75TCxxuYPIM5JdZjrOwk27sS28PXXZWW/uXEdaP7BeVK9vVWVETJx7h2QfZSMPGlWUSUHS6VfvJ8trIXc0ntU8NJW7BSgvjcYwRRXqHKgjL4n6pqEAlL+lxnJIg88hpIqyV0Ym4DKg8eqFkwAbziGbecgnAr9M24+qBBwvqfi8SoMdYXK99JvfIOaWbJJ++yeDHiyxkvMNmIOW7NGt+n+JSHeuZU4K2Svm2fQi6oVaWW1OsH3ks6R8Pta3QF2kkbkjghdz8vovKs67hlPhdZF7TaqdCPcpmLibmeALhYTl2W65d6N3bMCo+s3e7RhDxY/icFleyUUDWIj4dkc1xTAojV88gB7xE5ww/V0rKNIEtzGECzn0kyUQjx2qgMmKC/Dl5iyLBN4yx7fuzGaPNx1HlJbSvQT2L4cz2E001fX6jLjhI/p9oQbSZzTxSlhaNUG19MbcUvBCOg+EG7GWAyYlGE5jWKaNg9vxUJPODd1c7KPoSoZPa6NoHx05nX356ebdiN8XetHuqbw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(10070799003)(366016)(18002099003)(11063799006)(4143699003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGFUVlFrVWdKNFpYUHJQdTAvM3lua3JGay83WndhemRURlF5eGExaHdVNFJS?=
 =?utf-8?B?aTgzWGplU2YvTHU5UjlmeWdRSE84aG4xVkt5NU1uZHA2Uk9rUUlkTEs0anRy?=
 =?utf-8?B?bFFiR3BUc1RIYjV0STdOQ3RuUnNLd1NkVHdYd1FqQ01DRytHYVNZN1ZHa1pL?=
 =?utf-8?B?MjcxbkJOd1ltM2NHZW4rY2hMOGpNV0xrRDFwa0FmRFJ3S0xUQW9YTzdVNHRZ?=
 =?utf-8?B?VEJxTmYzQWRON0F2N09JQU0xY25sSjlYVytRWm1WVE5PSERBM3JoR1d1TSt4?=
 =?utf-8?B?RDNuc0l2cFRVQXBaMG1pZ2V6TUU2MmsrMFZCZnVONGFjTytielk1Q3VnWWtz?=
 =?utf-8?B?OTRTQnN2aGdEVlQ5V1NwMmU1VHlJcEJCNUJ4MThBeEVBTi9rUmJ1d1dkMU9K?=
 =?utf-8?B?bjVRTmhNdEYrMzRnMVlDc1QwY3dyKyszTDZWeVVNRVY4UGhPbVVxQnlqWm1i?=
 =?utf-8?B?RGxPV1hMV3dZeEVlWWtnckkvSDJCd3dTS0lHMVBwS01jOHRZSnpqQm15cnNG?=
 =?utf-8?B?UlNQajhyS3lNTUNnbmFhZmtSNVNnZjFWZGtsUHJsMWt5VE5yK0tkQU41TTY1?=
 =?utf-8?B?ZGg5TXZsUEJrVHpQUTVrdjgrOEpxZy9GaEdkS1Z3UlJaOENNVTU4ZEFOcUoz?=
 =?utf-8?B?Wm96WkdRbW5PUlFSTFk3S2drdzZ0Tm1Wa3Vsc256dEZid2ZmWGlNSUVLRVk3?=
 =?utf-8?B?ZTZ6d1NqQTFuSzFIcGNWQ292Yk5aTzNpRkVzVnVza0YxM21EUFZYM1FhVjdX?=
 =?utf-8?B?eitjeExscW9pbkFoSXdRNmJKUzJzWklmRk9HOU43K2RBZ1dmWlRka2RyTERB?=
 =?utf-8?B?V0dYU3ZIdTcxUzUxMmY5RzZiWlNuZ25CRVJLR2VvNzdyTmpZdkdONUY2c2hU?=
 =?utf-8?B?US8wZFp4UTJQUkJWUUZTU240N21jQjRUMnZWRVpla1RyZEo5SGQ0Z0hHc2dm?=
 =?utf-8?B?SCtoQ2NtMFg2TmlJK3ZvQkMvM2ZaQzhvQWY2MUJZZWdoa1VhTXZ4bVFmWWEw?=
 =?utf-8?B?L1dRcWk0NG0rRThxeFN4OFM2cXg2KzYzT28zZU5KblJ1R2YxWVpScThHZVFS?=
 =?utf-8?B?bDhCUndhRGFaaHpORk11aGtySFRjSEdiR2pid1Z2allHVE5XOHV0TVU4alRx?=
 =?utf-8?B?TEl1cnA0TFZGQ3B4cmtmQmFNT3cxVjl0MzJEN2hpRXM3R2c4bmh4SmlsY1cy?=
 =?utf-8?B?WlRhQTR0cExQRXR4NGJqbmFBUVppVlFmSDVGVUFUeS9GYmlKT0ViTWxkWjJn?=
 =?utf-8?B?L255QnVmT2xPUUVsRVI2TE1jamU0SmcyQ1BMMWViK3dWYWRtUlNTMnBQamVk?=
 =?utf-8?B?a0NlUEFqM0FvTW9FWm50aUViQk52OHBMRmFHZkw4dnE4S2dFeG9Wd2NGWncx?=
 =?utf-8?B?cFErQWllREZVMWpvK3B3OFhaZUpKbVFZdEpxbk90aGowQ3QzWU8rK2UvR2JF?=
 =?utf-8?B?Y2lJS3dXZ2toREJmNlJRL1RZZEFTejZoWDZ5Z3hqNWF3TWFrcjJmcTdIRmx3?=
 =?utf-8?B?K3NWUjBrMjFMWTMwYWFNU0dQRXhZN0F0NEJIelRUZ1dleC9xNnlDZHZrWUV6?=
 =?utf-8?B?UEpIcWlUUXY3aDV3UDBER0xCUUc4TldYUm4vNVkzSEFNU2hIN3pnRXNaZjZu?=
 =?utf-8?B?amxLVEpQcEFnelp1Qk1CNm9VZFR6VWN3RlRNSmdUb0Zob3ZuU3pRQjNLL3NW?=
 =?utf-8?B?WTM0eXk1UjJKbkFSdXFSR3h3STBkWDFrRE1Hb3ZWOXJjUE9WL0xRQUZxL1px?=
 =?utf-8?B?R0dBK3NlME9haGNxb09rZlc5ZXljcm5pZWxubGVyQWg1REZrZWdFbnkwOC94?=
 =?utf-8?B?SFZjbVRrVW5FZVArUGZaYkhaSTJ4V1lCZjVqYWZlTFJUekxIaFFzUG83VWt0?=
 =?utf-8?B?QmZRanlsVm1LUWw5WFlXM3hHeFJ3UlNkQUtoWmFEMnlzSXJCT1VFRnBLWUZI?=
 =?utf-8?B?ZHk5K0xBM0ZkSlgveTZnWWJKQUNsSzdFYnNEQVhuamZEcDF0emxSY0xUV1Nq?=
 =?utf-8?B?SWxZWk52akRZbEp1QXhWRDdQQndEVXAvdWNuYUFVZy9BWTAvdW5Db0dWaTBE?=
 =?utf-8?B?QzFhWnc2NFp5TG54OTR1bzFhUGZKQzFCTmZnZndXZi9MdjFya2pVK2ZMQ3RI?=
 =?utf-8?B?Q21IMkV0RXFhRFNxeHFuK2JJcUl0T1V4SHFHUHBFdlhxNjJrTUZKOWlReGtU?=
 =?utf-8?B?NEFyTXpWV1daRG1oQlVNUlh0UUdGaEN6eVF2RElYaXVBQVNIMXNrWW05UUlw?=
 =?utf-8?B?dnhUbzI2QTBOMjM2cEwyc0R1L3NMUFVHZklhMkJZMEpqTkF1OXA1SkVoc00x?=
 =?utf-8?B?ajlkT3AwUnlVdUZqa1J3VmRBanhzN1J4MkZzZ3hvVVFPYkt6eFg5eTlRTWda?=
 =?utf-8?Q?hepK4QQKUXy7WTkXg1cqcDvicCdF5vltqJKWNIDKx/xeH?=
X-MS-Exchange-AntiSpam-MessageData-1: CBWZVf9zLcksWg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2f3c84-a2b7-4c69-93df-08debaea5eeb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 05:48:12.8009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEL1ea1Nj/VQWrHa+IssFshmfsmXkpoLME4IyZ/Ou8nXcPT3vLpXR4d2C8bVf/ap7iRLBdQW2A4YCY1XxiXyPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9158-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 55A9F5D0F3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 26, 2026 at 11:10 AM JST, Alexandre Courbot wrote:
> On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
>> Take advantage of the lifetime-parameterized pci::Bar<'bound> to hold
>> the BAR mapping directly in NovaCore<'bound>, and pass a borrowed
>> reference to Gpu<'bound>.
>>
>> This eliminates the Arc<Devres<Bar0>> indirection, removes runtime
>> revocation checks for BAR access, and simplifies Gpu::unbind().
>>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> I see that this patch is not in v5 (and it is marked `REF` here), do you
> intend to push it soon? Knowing that would be useful to understand which
> base to use for work that depends on HRT.

Just noticed your "gpu: nova: adopt driver lifetime
infrastructure" series. Sorry for the noise.

