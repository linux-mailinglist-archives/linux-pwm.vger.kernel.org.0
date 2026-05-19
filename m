Return-Path: <linux-pwm+bounces-8990-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F9CKkIKDGo5UQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8990-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 08:59:14 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 242A95787FA
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 08:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 002A0301906A
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 06:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C145B3A6B77;
	Tue, 19 May 2026 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZKCSc4kY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693923A5E90;
	Tue, 19 May 2026 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173539; cv=fail; b=pSwTrC007ggW8Nf175E+hqvJoCSh8LkX53qJCgzTBm56zDwSpoyoROAX1JCltjfXK+A64xiPd5GNEC7MoPiFK4rlHjFr0F9Ym0eoWhrmDDJhpsZvI1tek00Qs4LRaezMXAmYzz9Fb4E9HXMuWqpp1Uy7Uu1zOEERQ6+jEeSdF0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173539; c=relaxed/simple;
	bh=lUJ+Msjzsz8Ni9suKFZtcx18Y4ZbNpU3uFBRIEw3zzg=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=tsgg5Hgc0fCckDxBhVMKc3V0ZUhh/a3qVrdZX/Q6F7GqwvJZpDjjwgbWwNFjyR9nmvkPn0D1YZ9oJGZR67rO3UHSd0ReCCTs3pl2xQlZPelkSoFQxIrrKgAUwV9ue6ygihsYbc977HN36cNRo6q7gnf0lYZXClBLGSnP/RxGPaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZKCSc4kY; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5rggoL1iUAbyzs2c5qi3+gbFcdt+W9YOdePmCCIQNHLIGSMqBBv715Dp6Cnp4ZVZ6ryv7G5eJddK9PkZ3IiFb80Zg7KwTDvsBJAMjEUGUhpcpovv7oiogwvlfFsEXJKQJAiecA87l25ZfdizxAHUmbB9H4te93MXkvUDLtPtF8uTwSOym0jTLNAKorpRadSySKiBeQgaa98FdCJQPfigF9n7aG6X46eW98ik+RUBqlpWfA1yWqvioFD844SRvlS3pCHuDZaH1W/IljxiwGr/204jZpR31xJvJtL5rXfVtzSFU88ctpp/D6qWqFLx6Ds5AMQ17I7MXh9GUIDNuxGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUJ+Msjzsz8Ni9suKFZtcx18Y4ZbNpU3uFBRIEw3zzg=;
 b=cLnVTNExthqdt03B7QsgDFp6OldImU7I0B6k5ixNnhcQfnzr5uJBDnWBcuA1eVY+OzVmSHYYWRmz5KGzEgRjCJQ9+PZvbKRya3NlcnrziQCIexH87obr1oWUPeZDKEYgNanZVwCzLMdT3ViisWt6dZ48WBuRRkAnSyGge4cDzIRiP+evU2tdd422HlKIdd/Bn3pMzNBk9/TYHBIKiaoXFFQncDal4+bTBDPu11GInjIZwWvEaAiIhFB/1QuSk0cz0er18XMyPOynEERmW5QfRCy2PMMAPOQKwKAhmPgg+EyH8k+oW+pJ4Wd4UQQKMfaGsI2l4uaCih7rjoyANpQqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUJ+Msjzsz8Ni9suKFZtcx18Y4ZbNpU3uFBRIEw3zzg=;
 b=ZKCSc4kYD4/1AoNYV4xxXYzIAPirXnC2lZvvIrYlOHnTwxiGiBlcFZB9wYjGQEgvCuZdTCpk2YJBy1c6oE3/BzTr77wFvi7m4HcC7A1LUSLyhaDeIZLsLJTlfvFEiRe/KLFQRPvhvwUdZybKaJ1WUftNM9e+8vYaDsjD6LOe6yAf7y1dSwI3X0N6bfAEfHlEF6yYiUiK0K1hquOkAe5PwH8ElV81VyUGzxEm5CIN/RcNWyrJrbwQZ9qEhmVL8Hf3IiZDHmZeqLunh6hCJBcPjJ+3PNaO64/X33W+fT9RmQXP+PRT5Gtx1Pf08ZTHoNUQbJqPbro+sdyzIphHCoXvSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.21; Tue, 19 May 2026 06:52:09 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:52:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 15:52:05 +0900
Message-Id: <DIMGDLV6IHVG.3U6XI7I0DAG22@nvidia.com>
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
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 18/27] samples: rust: rust_driver_auxiliary: showcase
 lifetime-bound registration data
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-19-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-19-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0308.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ead26d-6b8a-4713-329f-08deb5732558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7416014|921020|22082099003|56012099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	Ycd9DO+zOoiAVjkFbIR7OU6gW99pqMz89/6Shy5RCKMqtB9Gt+jT3pwWeKRQLg+OIz/yfoEnsWbGzUy64Pm7lw13SdjxWw+lZlc8+GGaRiqUvzENlA0t1kiZO/LvP6xpwK9sEjONMj5aawEThz/041cRLFp+oQe7grUAgpY5FHFxW2jwLd5vCy3rmsHTUWkUW0a0pP3DfnmSUswcoHEcxvicp0EVoFMxWZsov7SeoBxOMwNJ/qfWdiImomyRGgb4FTx5PV96dhNwnr5KAasnJwgFv9dfrpRQ1FjPbdm6cUUqxsuKSktQNZyNojM8NzUZavjQIXDs6nEWwzfC9kLfHdIzdouGm0zsqK7dLVebm4gDPei/LSAwY/xgl6MIMKBO2dFbnXNjMfniHc9kT3s1uYWan1PR/TkRfR4NT6/kKwYYYJ7EbUi/YLY5OaRPN+6tI28YfldMAnSDqtfFIujR0/WJpvFN635VsbEwhQFB6WUFxRaRpJBzwyZAoS3KxPO6DvtCJ+KRidT8Vr+L2QR5dc+N6YEJFU1O2bXNJhWNguShVsnQPDgrJKCtwv809mJzO86tHCW50fIqLKs9DWzpkZhYmmfZPpkh/YFu4JvbvkMJ6bw0SlewNS6BSetojUpaDvuJ1gt04NBhqypPOStt5ZHg0WejZv05jbdTL5uIeOTimhZrNHKn7RKEk2juz7zsnFwtae6D1V1CElxGA1CapsOReCjYkHSY2kWMG12nUEI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7416014)(921020)(22082099003)(56012099003)(18002099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3ovNkZyaUJJbmNlZ1h5Vi85OE5MZVJvSTNSMWVNVlNSZ3BGaGo4ZWMxVG5M?=
 =?utf-8?B?Q1BxNFB3SllnTVFzYVpEdlMzLzJOa0lEenVQODBzM28xdEFLSWlJbkFHT1JB?=
 =?utf-8?B?d2kxYTNKNDFHZGQzMk91OXJYTDJ5MEZReGE1R0J1WmxTT1Bna0NWQ0dUb2pV?=
 =?utf-8?B?clIzSlRxQVNiRkFTRjZzamlWNTJ3cUUxbmlrbkFER25QK0hHcENoRS9tdHpx?=
 =?utf-8?B?T2ZNTmZpUjN2V1JFRUJYMjhxVnRpTTRkRk92WVJycUJFSHpuRkN2TjFOYkJi?=
 =?utf-8?B?emRwT2FOaHVMSkpWc1FUQTlZY3VRckh6L2h3UnA1ZTRkVU5wYlNEUXYwcFZP?=
 =?utf-8?B?c1VNZVdSSVFtc2E0MjNBbUxOcm05aWNrem9hMzNmSGRvbzdjTWpVZ2tsZ0VJ?=
 =?utf-8?B?SjdPeFBzQzA4blJTM3ZyT3lrTVp6QVJkSVZQVFNsK0ZML3VNZEYvYVh2RFBa?=
 =?utf-8?B?c1RDN28rZlJsbno2cDg2dWVETU5Ya2JyaVdhWHdYaGV4Z3d2RytmWTR5clo5?=
 =?utf-8?B?UmxWVXprM2hpOFVDZ0VvRlZUcU5mS0Q3N3kybjdiNDZoVHI5T1VpQTdwUnBn?=
 =?utf-8?B?TnZ3U3BFeHY5cHBnT3B4QkJjRVRSSS9MM0FvbkpESnArdmNkcFN4TlpPVWNJ?=
 =?utf-8?B?REpYM293MjBwak5YYnhmUjBhU3FNcFJ3Y29GeU5ZMEp2SFpPRVp5b0ZjNWdS?=
 =?utf-8?B?TVA1bjE1aUlXYStOaGRKVHNIVEd3QlRqSXMxWXFyek5Kajk4TS8zQjRmbVBo?=
 =?utf-8?B?SHM4NDgrSnEwT05tSzFUOWc5ZENlaTFXS1U3NjZwL0ZOL1RBMkVpQlMwZXky?=
 =?utf-8?B?V3h5RUZlRExOOG10Yzdyb3Jwb2RyZDV4aXZmdWZBSnIvNTRoTDFHWmlGUHZh?=
 =?utf-8?B?UTVHWmxLZ1UrMUpJQ3lydkNMR0dJRTYvZzYvZFFwVDlma3lxQkx0Vmt2S1ZV?=
 =?utf-8?B?Wmx0d09zdW5WMGhtTzBNUjhYR2NFYStlOHIzYkxSRW9qT0IvaitsdUhPeVJZ?=
 =?utf-8?B?YzN0eHNqcE1lT3VEMXNRTGtFVm5TaW1vVW1sVTdJbWpLVzg1VWJPNmN1Ukc4?=
 =?utf-8?B?ajRvK29Lc1ViemF1VU8vR1ByM1MzemUxTnhudFpXUGdQNU5sNi9vdWN6TS9R?=
 =?utf-8?B?UCtsV2N6dGdXdFZHWjlUeXJtUkM2cjA0c2JvanVLQUd2VkZGSnhWU1I5ZXVK?=
 =?utf-8?B?bVk4L0xuT04vQzRVMFk5ZnEwSWdkY0FhVm12aVFKZ3VTN1dUUjZUK29OUjZo?=
 =?utf-8?B?bjArL054UFNMTVpiOVBSQ3ZTTlFORWlMZkpyWm9LUDYzTVI4TDBVbVJrelVr?=
 =?utf-8?B?MHkwdFl5a0hLN2pudzAxTTh1ZEQyRUhWZHQzR3p1d3hZWHdLVjVMUlF1eUdY?=
 =?utf-8?B?NXQ3USs4UWFOSEFOYVZCN25sdU9CSDU2cmhjZUJOVml0V0F0WDZjak9SazhD?=
 =?utf-8?B?UklZNGYrOHBCbzFsdjdGOXVqUzhWNzVSRUFxc2tiRzQyT1o0RWdnT1p5VW4z?=
 =?utf-8?B?cW5leXdqbUxESnJBWjBIZkV1SzFTSzVxK1ExbVJkUzlUemdqbXhGQ2I5NjF5?=
 =?utf-8?B?ODc0ZGhmeDN4bFJYOFJ3U0dKeEI3QVpDT2pRa1hPeTNOd2lYdzNQSGh5TVli?=
 =?utf-8?B?OVNXYjhGT3F4U205S1BDaWhaZDE4VUR4THZSL3NISzlmclZRN0duN3hOZFVp?=
 =?utf-8?B?VkJjeDhsV0YvazE4cVdkc0JNcFc5TjhyYUVtK2VGNmptYnVWTlhXQVFUWTFr?=
 =?utf-8?B?VDJCUDkrV21peXNWZHBGMnBDbnBZcUZuREU4N0hDS3BrZzFiTGlSZy9RTUNa?=
 =?utf-8?B?QnFOakgwU0dCYzhXWDVGSUJzSWtMUkVJbkpCUDdzQ045ZzdtT2hQSUo4VWFu?=
 =?utf-8?B?bVVkaW10UjlVZmdJa0RCTDRWcEZVVFhDQW9kNExiZmcwVFNHNXdvbVNoc0NY?=
 =?utf-8?B?THFxcm1RL0FiM1RLMWVTZnp0N25jWDBZZ0FRTmEwSUR5RmxzelhYeDFrN3ZB?=
 =?utf-8?B?ZU4rN0tlNDlVdDFsYXloTWZ1MlAwM2Z4OHhtQ0grMFd4RXhPYXBOeHc0a1Nk?=
 =?utf-8?B?V01YNlBWNWpqL2RpblRnbUdzaTR4cDMrNTVXeUk3L3JhQWltamNlNitoaUlS?=
 =?utf-8?B?T3pveXIwOG95WVRHa3VCK3A2RmY1WGFiYzVPclNEMHBUd3BDblJIbnUvK3FF?=
 =?utf-8?B?RXpDVnQ2bERZbkF6UFB6akk2ZlR1V2srcHkxSXVybnN5Ri9wTnVMMlRLa1RL?=
 =?utf-8?B?YjJzWXA4eEdJUEhJYlRrbmY3NUI2K3hpK0NvVVhYbmFVYnpHUHp1WlpMZDJy?=
 =?utf-8?B?NzM4REJvdzdvaHdPVDVVSzFoWlREaXR3ZVIyVEtNNzJjcnhXY2w4cEozSjdh?=
 =?utf-8?Q?v70ZjY9lmJ/pRywhL/0Ef5pfLNaO5IIjz4mmmsu+6CY2E?=
X-MS-Exchange-AntiSpam-MessageData-1: jfYpFK90rOGOyw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ead26d-6b8a-4713-329f-08deb5732558
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:52:08.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uh6IZiZC0C7N5RYl3UwI+gM0Ai5ei2rD7wAAG14u6xSvnb1TuI0mPZiXtJNiCA92QbmTLVKOss1msAkax0g87g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8990-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 242A95787FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
> Make the Data struct lifetime-parameterized, storing a reference to the
> parent pci::Device<Bound>. This demonstrates that registration data can
> hold device resources tied to the parent driver's lifetime.
>
> In connect(), retrieve the parent PCI device from the registration data
> rather than casting through adev.parent().
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

