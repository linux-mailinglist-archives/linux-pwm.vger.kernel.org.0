Return-Path: <linux-pwm+bounces-8965-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OWVBhYqC2pAEAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8965-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:02:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB1856F7C2
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BCA43072887
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981AE288C08;
	Mon, 18 May 2026 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dIIqHo2V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012006.outbound.protection.outlook.com [40.107.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496CD282F00;
	Mon, 18 May 2026 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116140; cv=fail; b=sTb9A8x457JHYThNZ2TyY0sBSDkd4I5R4hBvZeYi3x0v5umAfLwbzWtZJqobkwPRRyFm3HJiiE0D5tVKq2HIirrmdduWTp6xJB2GeDb1Rd6anLbI1yVBNeDLkhb+G1tUHWaCvJqfYs3o+vk01yd+au8Utc1azjztTjS9Wecrj+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116140; c=relaxed/simple;
	bh=lH6hedU/H2IOx1vw8q32rm9CLcN1HAthAx3w/4dIUv0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=fPxPujYW2ECSPBhuPce6rp8KFrR7dbyroDbr5O9pGhX5NcrOmctZc/VG6ylMEf1FnAkKO/imYWxL9GiusabZPYgnRRXu5/B/3aEJjRIbJiNQ2D1zhtemXBpNyjlbjw/fNNeLgM/MNVblGoFN0//ZHMlwW7z2L8r0Bey5tm9bgfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dIIqHo2V; arc=fail smtp.client-ip=40.107.200.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weUuIsPN4SnCO8puvYfdq05fmL6TUCUyxBPJdnWi77KqvRzJBO9iEzn0/K5sYSMEul6ij5VpKGcitnNi0ozt2vwNArC75m3kI2YMZJ4LuEM5qRRbILnmjpTESKg0iNlSRMZMfIzXHktzv7UQTxKqFAkt7juShruG8axSjhAnzK7cSGaS19If9UAEYBcZBVIYY43MIGnp1tU8IbWjt7uF8MhxVK3HJbpMhRs1gUwBqcg4VtfLIlVLOrnkxcwIMsdQGK1ByXfgUZkNNc8+mdMHFyBn2qhcZ7kKpKEVREGNezy77QAMuWwm1wgcl04C0IB8JEtf15qsIKtOjmWtath/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lH6hedU/H2IOx1vw8q32rm9CLcN1HAthAx3w/4dIUv0=;
 b=hP++NCJkQ1xWueo08zqdnLfpPZdDkJ8P4oQlidEbkZOhHrWM07DxrOnrEAhKPnmBA1zcZs38R+x+s5FGFpKbFuuCPCy4R2RDsS8YgUOdLhViMJ/2TJ3e2xzMcF9aadY2RzXwsirtnPbsIjyV0lTDZRpb6zWhsFzbkcz6wV03dyufESGQ2L4qB/MV5LyViNLvm1JPIk8kbWMtnqAnn6v0D7CBeowiGH0kn4fmNHjUEKwjcDQgWgqPzg7Fr6R7aoy2KUzsM0wz0wLMn8S3naJjh1MiQclJXdpzbreGxEUiFGTzUDLh8EqokibvxC14ziM3tADsJ1Gk6BhRK8q4qGxcrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH6hedU/H2IOx1vw8q32rm9CLcN1HAthAx3w/4dIUv0=;
 b=dIIqHo2V9KxThRIvW4KHm8RLg+YuiZpBqdEcsjbACR/eJLo8cO/icfBJQKKJgX5Eqios8anW//u2IG6gIXRLEBfWa9Uu96tpJUEH11bdmHO6hXM7YD9kivXNFhSpID967nW6LW65kj6i4noTd4btrAn1fgZGMRqH/eG3YKCsa+PWeyvSY6X1RIZOunjp71MSIv7k9CCY0keI45eEDkV3rwVwcGXl7hT17nEcxPcU9RHzu17QgYZACp1CBf6kFc4c4wNWuq7hiQa0N+hl8HvD/7DZIt3PFWB3eagnthO+buHY7n58fDloaW79iT30BxvpAKuE6BAFKKjx0NLvGBmpdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH1PPF12253E83C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::606) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 14:55:29 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:55:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 23:55:22 +0900
Message-Id: <DILW13F30IR6.2VYUDF0GDK2ZS@nvidia.com>
Subject: Re: [PATCH v3 11/27] rust: platform: make Driver trait
 lifetime-parameterized
From: "Alexandre Courbot" <acourbot@nvidia.com>
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
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-12-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-12-dakr@kernel.org>
X-ClientProxiedBy: TY1PR01CA0192.jpnprd01.prod.outlook.com (2603:1096:403::22)
 To CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH1PPF12253E83C:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a2bcc3-de2b-4e48-45d8-08deb4ed7e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7416014|22082099003|18002099003|11063799003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	7/AN8z/cLmuEw3Ke1dVJuE2LmJ8tjut45Qv0gwV8HZJk53VAp2L6fKwD9URg8z19I/64LWkkMccODiqmQuJ3ZQ5z3VlWtr5k5GCe0AJ6uZvgBKs0j47eFjcujQE8qSBPmsGcUGKW+Ia9KBEsSJfqadcrAbWdd1k+RwM2PloXVBpuZM5TIaSOVt+f9I+yQcZ0pehP3tWk8+XltUrI9BqMmxGmg974JIsfeG9d29UvkVuMEl27Tojyml9/2CnosGHWRRzHKvGVKwFbEnnvSVwVG8ozadixSELTgr7vi7wSMfkVj6xjyasY3tUId8d+o2xu0Ke8ooeWkQ8W8avjB/O8jAsOEwZ/Ihqt3peh/oJoV6ejFKjeMTl66GpLeK4rAMToLWHoLJc5ud8XLZqJ+2UsPLEPtfVQFR1mhtYM5p8JpWJcyjEeL+HFtCeqe/r4HmNAJatuUdlYGcm21nTQlNn7PVOaZeTLld2J4PEOXSyhTvCKXHWleKnCwyVTy32vRbAbr26FeCj1ON8rqSKS60idImFilGY43LICqzNvLmJVgEcPznyzGctdh6fuS22yYVYDHTGurtUQLcvvWr0IGN94zPlDfuEuiLvQ942H4VzbMrKoENsPtyAhM0RxuFPMMJOjndxzvbVULZ6n4GtcN5xiymFqV+gE0fJ+a7E+aypWDcCfoKmkmaP7HO/4JIUhEKmw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014)(22082099003)(18002099003)(11063799003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk03MTEycXRTdTdOaEw3Z3pSd3pIeDZmR2dZZFd5YTBXem90dkJCUjBuVEhu?=
 =?utf-8?B?L1dXZnpxUDhWeTUza1JiYVI3aGZKa3JkNWIvL2s2d1ExOHRrQ3lZd25YT2dY?=
 =?utf-8?B?OGRrbW52VzJidU9aaHVQOEc5NnMrMkNETHgzTloyUjA3Z2xScnVERElwZi9q?=
 =?utf-8?B?cUJQYmt5NHpPYU9xOHJYLzFnTHpLM25ObVI4bmo5YU5FbmMwcU01QThlYjQ0?=
 =?utf-8?B?UDkxMjBwYkJua1Bpa09FL1p4VVF5ZXpmb2VFUjg0L0VzcHQwNXpjOGp5U0lX?=
 =?utf-8?B?bXNpSVdhRzB5amJCb3VxUXVrMk9rV3NDSVFZZCsvYkQ1cm1MWUZkWkpNWXdx?=
 =?utf-8?B?ajZYc0ZXL1pIRmxnc0RHTFRodVgyZDYrcjM1OTNnUXJsOHpZcDNVRHJFME9U?=
 =?utf-8?B?M2kyZDdpZFVOeXZNdUhXQTRQZzZ3VE03LzZwRXVpZ3VEMS9QTWtHZHZ3NURk?=
 =?utf-8?B?QWFmVUMwSG1WNnZaWjhIR1lOMEd6a0dyUmJqdXRYTkowRjFMTkhTQ1B6ZGlw?=
 =?utf-8?B?RzhFbHUvSlEvek5CVVpTUFJrd3BQcklKbTYwd043bm4zeHdpZFJ0Uy96dEd2?=
 =?utf-8?B?YWp3UWNMUG1wcW9iTkMycFlqd3UySmhFMlVlWXROaSt0MnJsQVVjSU05eFhj?=
 =?utf-8?B?Nk1abXlOckZzakFOZVg5TSsvN2JYMkxGWXQzVXFQUFI4TkdxS2E0TWVWVHJh?=
 =?utf-8?B?VnNUWDd0STZUL3ZpSEdQOGVHRy96Tkp3Y25GVTVKQ0RhOWd4UC9CVkw4WGIx?=
 =?utf-8?B?enZTWFhnTjRzeHJEUTJTQ2ZFaDJENVR5eVFDRWl3S01YaUVJS1dJcTk1V1VE?=
 =?utf-8?B?bmo5WnVWaXdFSFo3blhPZS9ZSTVQVDZLSUcvSUQySFM1dnRBQ0s1eUphdFJk?=
 =?utf-8?B?a3NTamdCQVc5U3dMTzJrVk53WENiRXRVRWo1NVNOMzJNYm1obFBIdk5ZQUp6?=
 =?utf-8?B?NlhNVVZGV2tKd2FQS1hvL1lneVlBUkZJT1RHaFVjL2ZYMGEvT3lKWnBhSUE0?=
 =?utf-8?B?S2tTeFBDVnhwUFgxMi9XQ2toVTE4TGlnTTcrNUhmWm05YnE4ZG5odGhHb3dn?=
 =?utf-8?B?cGtaWXlKc2F4dVVGL2tUNUNWOEFUaG54dzMzVEVhaTd6SGMwZnV0b21FNTJw?=
 =?utf-8?B?REN3TmZvcHphU3BQYUFRTzlLd1B3czVZK0p5VWtKWmlQVzYvcTBnQnFVU1VY?=
 =?utf-8?B?eVZrUFhiR2ozRFc2SGpwTmQxNkZpNlA4eFdjT0tudEs0ZFkxUVBzNm5nL1Rq?=
 =?utf-8?B?QmVIRTFvSTdJVmI1ZVB6OTEzaEtNZ0hJQlZ1OVgybG9JMVQ5aEtaV011T0Vz?=
 =?utf-8?B?enpIdE91bUc4ckZDMktuUERvTjd1SCtVNGx2SFpxaFVTanFHa3Q1VTJwZ1BN?=
 =?utf-8?B?K3JZRW10TjZ2dS9uWklNUWxiSGdjUHptSEc2TGNhU245bUFSZEVsWFUxQzBO?=
 =?utf-8?B?OWtGZDg2L0F2cDZOQU51d0VnRFl5bmJXT1BiVVdMdlVTM256dUZYc0ExeUE0?=
 =?utf-8?B?aUx2M3dIS28zeXJaUjlaYXM1cHFmakZVZHZ4ZWFONHlPUFlWMTVpbXlXV29T?=
 =?utf-8?B?QzdDSlViNDc1dnkzQmZ1QTZnWThPZU4zWnhKN3h3b01zMlFtQnZ6V0t3c3cr?=
 =?utf-8?B?YzB2dWRCQkx5aXpCZjYxV1ZXSGk0ZGZwbzVKekEyWi9IZVVGUm1SaGtnL0dQ?=
 =?utf-8?B?d2liK1dRRjQ2LzFySjliUjY4aG1zNU9wNE81MnZzdFZjeGM1V2JQaFhpRkg1?=
 =?utf-8?B?UGVGbWluUmt5bVdsNm42TStYc2VGV1pLeEhKTTk0VHNRdTJLMWYvNzVvQ0Rz?=
 =?utf-8?B?NG1uM3U2L0ZHYUdGNEpPcTdpOUlMVFd4dGJVWTdDMTVFcVBSbG1jdUN0Nzkr?=
 =?utf-8?B?TUQ5c1cyOFRUNXEwUXZaUkk1SnkrOEtUSVBRNEs2S2FGTEdwYnh1QW9naExk?=
 =?utf-8?B?NExxdUwzQTBROWI2MEJJTWFqQWRnemtiWkt3QmdKMU1jOE4zc1NMWEhTSU1B?=
 =?utf-8?B?RmpJOVA4N1doVzFVTk1zVXA1dy9XWXBUNUZUSmVYcDJ6K0V2aEpYWnh4Qno4?=
 =?utf-8?B?REVUK1I2bzJnYVZ2UEl0MjJzWTJIdG05RlZuT1J4QkJwWWJaYW9scllHUGtY?=
 =?utf-8?B?UENRcXZxQW81SVVuVnFyWDRzcmlmWU1odG9lbVJmc3I2aThaSXZVZnB6aExB?=
 =?utf-8?B?Tm43STUyS3l2bGVCWURSYzFlUHllUmpLYjV0S0E0aFA5SU9ISzU1N2YrOEJT?=
 =?utf-8?B?UThvamEzNEZZaUIrdjhESUh0cXFUU2VLTlNDVzFGc3hRbTRCK2RyQVdWMFRO?=
 =?utf-8?B?eWFKcVA3bHNoNmVjK3owcFlJdGNsSmpUblJHWit3SjAyMlkwVVlldFJuU3h4?=
 =?utf-8?Q?Blxg8U64md30M7r1KBR2BPCw0WBwXH0kvQbUTmmYhCaji?=
X-MS-Exchange-AntiSpam-MessageData-1: WZ+GVvcCSgmhsA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a2bcc3-de2b-4e48-45d8-08deb4ed7e80
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:55:25.7490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWwGVtCgPEBQvpeuyUtFk/T7co+0YzuRnsIHtJXG00sw6L6uXv8Byb6775UZhza+ZnNaCM5EobeUmO4K+v72gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF12253E83C
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8965-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: ABB1856F7C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:00 AM JST, Danilo Krummrich wrote:
> Add a 'bound lifetime to the associated Data, changing type Data to type
> Data<'bound>.
>
> This allows the driver's bus device private data to capture the device /
> driver bound lifetime; device resources can be stored directly by
> reference rather than requiring Devres.
>
> The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
> on the methods themselves; avoiding a global lifetime on the trait impl.
>
> Existing drivers set type Data<'bound> =3D Self, preserving the current
> behavior.
>
> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

