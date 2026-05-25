Return-Path: <linux-pwm+bounces-9118-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAfrBepUFGp2MgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9118-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 15:55:54 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5285CB643
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 15:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79EF1300C25C
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B52385D86;
	Mon, 25 May 2026 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bu/t0uS2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4392AD2C;
	Mon, 25 May 2026 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717350; cv=fail; b=skgTVNOsvOfLCDee5jk4ITWLcT8npKZ48WBODu31LHSEcojRopRHPawkkaukHBti4Ur1dgnoWulewIcwUJj45yD0hPNJynS9vrZ8WWTc+1tCdXmOkvw+UmXDm9p64z7NkDNf4v5aUeuUJxeXG1RS8/NWfsnkeiVdtF2YHcg0bBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717350; c=relaxed/simple;
	bh=suuPw4XpfuOUbEoXDBFAqfRoUgheSUOJoNYrxWJgk7Q=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=EoTP7OpWJ7VxqS5JBQfNIxN5svDDJImCk6oFr3mxsTxmoQBfClB035w+t7xIJExoU397oRFuDmPSt/THIDiU7T3i3cc/yGfTUCG97jVec0p1NfQKIeA2Gmj++GmjH3gMm9v8qTjTb+uXbnh1LsIwcT5/WScPebsQP7VUM2dAnN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bu/t0uS2; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDk1Tnpfrb2/j31i2hULCbT0HAktSvhsIgWyUqEAy/1qGuQhISZDuMxwwyB1ZkjKCNBWpXJuGzgfTl8kWbFjHmML2RHi2fLStk9bTeUFLCz115tqaFOBjWcQH46AKbD4D7ZRtgxk5ykQa8l+y6h8UeWHpiM9y/9PINLQt2Qw720JSWmQBFsA8dnG1xUWRi8XuICiOETeijB2iZwp6BjQ6WBSEjcbsruSYxHxiUhVquskn/8yGm8U+OpQREcp0iyfb/cARIi0O92RfzwaBIWUaoqwDssuRaihY4LAitJmmi4Y+dYPYTX+u1gtmZCJ+dNK953RpyvcF/y0pi5lgQBo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suuPw4XpfuOUbEoXDBFAqfRoUgheSUOJoNYrxWJgk7Q=;
 b=ZpqIh4Wzpqn+YzUEJRxRwNkICq5XBSRWNMDDakp7ZtU8I1J7DT2COSHKyJqF+8QtjUZsyYDvnjT2X8wg8U6br1tMCJgoQA5uXowu8WvyA4FJrSfj3IE9kcOpR0InPYlbQqbQz+FwxeQjx1+Z3zyDIuQCU21lZc9dNWBw0VOpSBvdBvqDjv0oicf30TqStHdQYJmfvxWHOq7oHC9rWSn7iJFRzNArAkSy/C3Js3JzPGmN9EUZfGMqgFqYaVVBnqm0k6MsCggb1QPchrcBml+9uSyddgWvulM2Zs3FoeAwEc4oM4KIv7/UDkZXkpDnFElqxN0iJDAKN6xyCow98QhK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suuPw4XpfuOUbEoXDBFAqfRoUgheSUOJoNYrxWJgk7Q=;
 b=bu/t0uS2evehnsnT/XnLVOwDkys4nQ8Hp4BxkmVuk4Y6+02TyRkRd3RnCkW4Yck67b4NJeNWPUK5Fhvij1NAyefwvKZ9HynpFIOe4Byr3x+yFHVhviZMBbi99KUOhqitNor1Hf3QZcDAC48BjBI/OGVFgQRmTzoX1WbDdx+CchbCMbTAC0hHVNE0AeuLoJYQvZaQLJ41kzyIhvPBvrot0AZIKEGPmZENLxK7LDIZhDMccpTztJSe9D6pHrnuLtuueJfCJOGXjRWbK2loszXq98bVRoIHe5P1ZgrfIV87PsyAdlvEY+PHm7a7+F1if0ypzz/gU+viXVqeaxxa/XROfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:55:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 13:55:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 22:55:42 +0900
Message-Id: <DIRT57ZG8YYC.26ZY5M6PWWQXN@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
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
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v4 19/27] samples: rust: rust_driver_pci: use HRT
 lifetime for Bar
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-20-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-20-dakr@kernel.org>
X-ClientProxiedBy: TY4P286CA0078.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfa504d-ffbd-48e8-e03e-08deba655165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|11063799006|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Y5Il0AaELh6rUV2w1zGKzrwNa/Qe2OlTLz/mzELHx8f6woBXmnXBy3mrTvYuMppCZ6fdD07YnlwwvD6+o6PLh+uSvJz3gCqKBKmXuw1BHnMxu3fbOVKWMepez+iRQ1au9CBM+R3ik8Ss8RlC9LplpCk6bBaUJZc2GNuu+vq5pTdu/zcUHPjHpRABnj2g8RVvIFJEZ/jo8bPFBnq2MUOzGsXxO84jl+/++oR6xkDpqYTdD8NGnAkwqYhkzEcskarssvCje+IISAsHwiKYySeY2do3iQMs1dcFvdnCCwjOOhxFBvN7fpzit+fHYkxNJ4FgVk7Ah6HpgnfjYW7ZLUBqDBja49RMvfj/amg4JOzaMEZnaBv9lhMfRqiXOqF2dqxzVEL2uchWnC8q1sErk0kFpW1O3HSGD+g5KdOAjE6gLMcA6UP2lIt8eziWNE+lsR/QAa2AUl45QceSAn0ZCZRh1BYl17KQPH6sbaL9XH3o3DYyfVKPcgum/T+iBbDjoPQ1z+js/2eBYoy2SswkLnFucCMz7UmdESVmme8c3rM71p/VmjJ8zntsxZatWKHP3JZa7hKV0L0ujAbkc5HUG8/Qp9/AOFFjXF25ovPWyPv+3SBTlwCaw/f0htnwKkpGEq0wUF6r+iN7Xvvuurz8CfcdFevRwMZgcOByf2YwEAMhciyoGjzSNt1SasC1JQulk+D/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(11063799006)(4143699003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW54SmNkdm9XRjVEblllYUhBVUNWeWY0cnArQk0yQnZWTnlhTGZlRHFPeGNF?=
 =?utf-8?B?RStudXZ3K2YvRGN0N0Q5SS9MTTJ3OU1wVkxZZlJUR2ZzMzl4NnpJMEx0M3Bz?=
 =?utf-8?B?K1JkaThmNnBUR1VaTktyN1JyeUJPYlZ0UUl3MmtjcHh1Z3NCRlBJeXkrOVV0?=
 =?utf-8?B?VHVORTFYQnV3ZjM3cEs5c3VlVTB2WEpmSDgxMFNKejJmbnEvaDJYRHl0d1Zl?=
 =?utf-8?B?WElyaG9FTjgxMWxwZWswektLblB6WmJjK0ZqVnVHRU9xemtyNGVEck94QjFr?=
 =?utf-8?B?SEJNbldYSUFMdndFL0kwdnBEZTlUR1RGMERsTS9FNjRtbnRBSnlRSEpXUWdq?=
 =?utf-8?B?MUE1ODVDaVhnZ1FNSXZzUjdYcTU0eU16UEdhZlhBWnE1YkEwRFM0MEdDR29H?=
 =?utf-8?B?NHV6emR5L2RkbzJVWFJyOUYzZWhjS1paTkZzU3hGYlFxeXBNek5adVZ0WnVz?=
 =?utf-8?B?TFltbWN1eTMzdFBwNk1TUzdzejhqUWdJRGpyMmFPclI3SW5JdlhYaUU5N25C?=
 =?utf-8?B?Tzh4UjcyTTNnNWY4d01vRUVFZWxZVlFYTHpzQmZkejFYaW95dEh5eHNzYjN4?=
 =?utf-8?B?LzMyTTZsMnRQQ3lQK0NZQUxrcVh4QnhCUUM3Szl3VFpkaVg2ZlZJdDJJZjRB?=
 =?utf-8?B?Q0dZa25EYldtWlA1R1dpcjByL00yN0NuOXlJV0swNGtERWVKTWsvVHJncWpx?=
 =?utf-8?B?STFGQ3VGUXIrVElaL1B5RUV3YU0rK3NuSTZGS3c1aUlCd3VMYUU3Q01xUE5a?=
 =?utf-8?B?TGZKUFFYWmZBTzJLaVFBbktjM2tFSDFwdzQ2K1hsNG9VcGkrcXpjZSs3MWR5?=
 =?utf-8?B?c3JtbFRYUU9EYzk3TTBkSXB3YjlIcXBnTzNjek1udjlxQWtTRDhlWk96U1cz?=
 =?utf-8?B?TTI0bnlDUW5Vc0FPdG9SWUFCWTBzRjV6NHp6TzI4UXAyRWJ3dlQyUGtvZlhN?=
 =?utf-8?B?YkJ4WGw4SmZPNktEc2JLS0JnVXBNVVplcGRUbDkxVUxKNHU3bitIS0l0SHBr?=
 =?utf-8?B?ZEJFTERXdzZDNmZCL1NaM0Zkd3hsa2p5b2Z0ZllkTHh3S25nb3E4a1ZuMEtr?=
 =?utf-8?B?cUlQUHQzT0laUkNFdFBzVk1Hci9MUUZoazQwQ09TczVOR1lNU05mdExQWnZh?=
 =?utf-8?B?Szh2emdVenEvbTkrVDZ2bWVVMzlib2I5ZWU0ZkR1WlB4Mlo3ajFmajlncW9B?=
 =?utf-8?B?bHRRS1R6YjY3bCtkMUZ6eURxZ3pjYlZTM2lzTUo0am16Qk12d1N6MHlnYitB?=
 =?utf-8?B?dUM5Qk1hVVJsaWJwYkUvaTk1VnN3YnM0WFlRRk5NOVg3N2dOYnNtdFRISEtS?=
 =?utf-8?B?WjJUdENUV2ZSUW1lYnl6eHR6TnY0Ylg3a1RTcHhVNFNnNm1jb2I1TmEwSlJv?=
 =?utf-8?B?OTcvVFpWOVkxZ1UwRnFYSkIwM2lYSnRld3J0RlNmZjU0Z1pYTWlUYUloRE4z?=
 =?utf-8?B?NS9odkl5L2E3TkVoTlRDSFl5clRlN0VBTVNkV0tBeCtZQlFObUd5Tm9yQWsv?=
 =?utf-8?B?YmUyV0FDeWtIRG04dkpVZFYwSFluYjVuOEV6ZkE3TTJQUTRmRW5tbklvc0NM?=
 =?utf-8?B?QkplQnNYQWZXc0hhWWpwL0FsaHFYTGpReWRlVVZpM0RNdmNnWG9xbnVWUWh4?=
 =?utf-8?B?ZGtxT1dYQTNZQ1VMd0dRbk5tVllKaFcrek9DRzhvV3ZJTHV5M1RTaWI4bmJF?=
 =?utf-8?B?cVhrRHZVNUVxaHdPTVFZa0I4VDM2R1AyVnR4ZkJWUW8zeXZHWHJVSG1sYUV1?=
 =?utf-8?B?QmNqR2tqNFB2RWg5b1pET0VoaEVQVUpBZXE3VXZBZmJ4YUxOU2phQXY4UlQ3?=
 =?utf-8?B?YVJtdmNWVnk3ZGRYUDJjenk3TTB0a3JNZEsvVTR5U2xBNzl4Y0Z1aHJKTDgr?=
 =?utf-8?B?Wm9LdEovejl6Q09nSHZJYWFvQ2pMS1FBZS80S05WQU1tVFl5b2FnbU42Wk84?=
 =?utf-8?B?V2dPUzI1WXJFdGxyWHZVMVg1TW9reUVxRi8wRm9mMkVDMUl3RG1NZVEyWTRZ?=
 =?utf-8?B?VFRxMldDK3Awd2xIOVJkeERtN3U0UDdqM2t0UlZtUzBBQXQwWTBNY1puZVE4?=
 =?utf-8?B?aEhQdktOREpKUUttSnBqYUovMFF4ZXgwRVB3akU3Y3ZUcXdVQUc0S0dvU2pX?=
 =?utf-8?B?MUREU1BBVzhNUjY1ajBsRTZUSk1mRlFEcWZSK3dna3FZL1FzQlJZMzlRbEhV?=
 =?utf-8?B?NWNpZDI4dVcyNlN2QU5zcGNseGJJVWg1aTJyS0VxQmRiZzJWdWRtbHY3YjdH?=
 =?utf-8?B?Q2lYZklDN01hRGpMSzlHSTNzVzhYMVcxWm5YUzhLQWJvcS9WblhIbWFNSlNz?=
 =?utf-8?B?WGxvWDErZmMxKzhGVkpueDlRbTlsY1VZMUhOQ1pKRjRzVjBMSEkxd0RTN1px?=
 =?utf-8?Q?xZmtGwIa5fuJ/mrRNSp3WDoc+epIo/b67ZEoTti7IzaLq?=
X-MS-Exchange-AntiSpam-MessageData-1: dLL+DCowVD5S5A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfa504d-ffbd-48e8-e03e-08deba655165
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:55:45.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hm1HA+GR5FmCRRBVFzroymPHieezzMjSBVzG+F8b9BcCq/gKFEZDLCpYaxThGfAFleWb49ql3c88kFcGlsBl4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
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
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9118-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org,nvidia.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6E5285CB643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
> Convert the sample driver to SampleDriver<'bound>, taking advantage of
> the lifetime-parameterized Driver trait.
>
> The driver struct holds &'bound pci::Device directly instead of
> ARef<pci::Device>, and pci::Bar<'bound> directly instead of
> Devres<pci::Bar>. This removes PinnedDrop, pin_init_scope, and runtime
> revocation checks on BAR access.
>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

