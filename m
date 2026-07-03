Return-Path: <linux-pwm+bounces-9522-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BC6RJdOfR2rqcQAAu9opvQ
	(envelope-from <linux-pwm+bounces-9522-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 13:41:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB096701F16
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 13:41:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=rXJgqJZx;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9522-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9522-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17AC4300D87B
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 11:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDC53B9D98;
	Fri,  3 Jul 2026 11:37:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E31638E8A0;
	Fri,  3 Jul 2026 11:37:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078670; cv=fail; b=hEa8gR44DaX2cXzI72N/mLsRve2V/US4ZiE1uSgDqYd0fM4E0cypyYHjgfXy/SACEJA4j7zHjNSut43Upzxc/vjLSnLBO28Y8wLsKv0SJNcNvXw6LKjoLshiEaD91SUnFBRXwAUwjEJa3zVzqKas4ndPJNd6MITW0Gu0I4umW7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078670; c=relaxed/simple;
	bh=rnc/sru4zFTg28C0RzDQsgWED+27oFUakh3KVrL+zgA=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=PIYHJt+le6xCecCAj2KSqnW6gKDUvmSROXxCwHk9wxm9c+5ZWxA++HCJD+p5A/fWDir4S5Q7qHb9ymYEp8jYegZ8d0uXLnEk0uv4FmPnRE1aAH0P50B/w2Sg2XosGdo7PVxYFqiJAeTBv1zTsJ+knrVIKxzH+ty8ERKPQcgsoiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rXJgqJZx; arc=fail smtp.client-ip=52.101.43.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gl+euFfa+0gbyDQXBGh+3Fuuay3LtltxKIFkBl6kCzO9wIIhzka2RhGogahdvZOfrVqNKFUKhOuKKF5wD6bkscORsYz2ALsx3GdehAZ8IZGA4z8+6+0eTKmJx6M6rxyXwsjwKcZCSHOR7lDqqEq5H86bHIEDwMqIAKYLGG2ac5oFBLzchbPmhB/IBzxiiUZlxwYuw42oGhjnszc/NiThAxbrpQcxupy6+OEJXRX0XPuQOkvYlsAlZ2ItRoc75x8imPQ14eUPcGUIrVy7/8VSNuEuveUy/D4f5/awzyDzjW2cxPjpbvuXwPuSU8hUJj7SG84f5cNttCkAyITSza7Pqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAQF4F2b5VsFSYa7DIV7vmyWh5Rug0I7p74nDic7vFE=;
 b=yWQU+e44OQainn2JSBbFkwi46NHbs7SAl5XG7zzTZQ8CHiY9PDT+J8Y/JLlzjJiIyzpQR32+ysixGLu1Ah7KgvAMRV+t92gL7ZoC74xvE/g8fkR+eZB9SO/xvAguKCERxDT/nb+gdNSJv12nw633gDqsu0btTNJNdqoY8h+r9DYPhCvusM0O7ZZQocCnXApt+yso6M+sAA+Hp2khq1eaAnGGeXngJYxB6LtjLGXgtn/9s06Vw1O+H8ICNpEBYlszoHlVyNgaZP6530wF0GQ05NeBRZXzguDZemoF/s6SKtezvDYTolNe1J2lj3vfQgGXZ72HLV++Hrq4osGszU2Mdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAQF4F2b5VsFSYa7DIV7vmyWh5Rug0I7p74nDic7vFE=;
 b=rXJgqJZx6/nwGRqVFzgAsJfjs93QZu7No4xsFzlfNRbPdyuV07Yxg3vbb5Y0rP7mTIQL4Ds4aOooVPfMTQmCWJZ2OkIqm8AG7h0MQfBayqIWxV2ftX78RQNsze27FWCZWFCe/CRQyRSZc0m0pxpU+aMwpmrMTiveZbzJXfJB93PHXefMeLvhcSkK8Ix9TbAOebQIked4Zx58j9Y/uKl4Pi4wGvcfMKQfFJrJ3avLFTKSJQLiwI1KmBSAiPPieZDCWeXp/d3Dhq2Ye+Jy7hRJ+bnq3N28FaiADFA/WraYPfbj3HBgvqYr7/0C0aCdf/yQEn0MnnWQy7L112mupYTQng==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY3PR12MB9556.namprd12.prod.outlook.com (2603:10b6:930:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 11:37:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 11:37:45 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 20:37:41 +0900
Message-Id: <DJOWMSPZW5D1.3DV2KKPXYXNYS@nvidia.com>
Subject: Re: [PATCH v5 14/20] rust: io: add I/O backend for system memory
 with volatile access
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, "Laura Nao" <laura.nao@collabora.com>
Content-Transfer-Encoding: quoted-printable
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-14-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-14-d0961471ae50@garyguo.net>
X-ClientProxiedBy: TYCP301CA0064.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY3PR12MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2ee731-5324-4988-5711-08ded8f7800b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|6133799003|56012099006|11063799006|4143699003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BKwwO4hDUnJ0k+SWrfAWF8F81Uxjsw7suMxvJVNBfrml1YNf8Y18DUL3ivjYHW6pC21Lpzas+gaTg4+Y+jIif3e73J+mi7iYfvClspo++Sav670xjVPRVlQ3RT+Yax3tEcHRQEB90CaJ9TM6np+dRyoUx7I6Y6EBO3tdrXMPiKoGAvfpdjJoZEqBbh19gUpSKlbreHhl1WpwRBPOUUO3nAOWrt39GFP5iVwlvs9XAHAuenNK8hNUM3XoX4Yh6EVKsLNvwGfD/CAHZ0CyqZ/mcByrla4Z/WMpKL1OpsZbO+0iJRdGyGOcaN5Gy5N4bgimt+q7hM38DymluqXitbdIm6Mhwqxfm2pkEbNkckivma8+KUybxQYy0txIRhWgQN+HAxUUZosrocPJ8n/1wl++9KMPmhBV+jAB3WB6+3xpY97W2uiURCvsI67cTzVlX2siNrgxReVUEp7YD14Z1G0we2G4QwYl+GOjv8zXvtJ6dihsQesjqf2Nh9SX/ToZSfQqOecRi5jwbPE/Jp7Osdg3y+gwXio9YtEjVGeE5b6deWM4HSj786rbsVOXhNN4zg/c0n9eeF2g6FhYPFAMU2TYoIJUwrXcwONh2NapU7hzU6jOdHlGNfA8dFO/oXtSVNBQ9zBYo+o5J1UTy2girMv2tmLHwch2R8KXP11uuNEstB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bllScVRFcDgzc2x6TFU1OWhhb1hwa1NXWTNuYkduREdMdVUrWUFsR0EwSjU5?=
 =?utf-8?B?ZEh3SnltVDROZzlzenVQVG1vOEU0d2ZRTG4yclhOcWxER3AwWFpCbyttL1hm?=
 =?utf-8?B?NXVrM3FaOVBZRDJJUmp1RDJacnJUTGJkUkNGejFKZ2VOYXRoQ1JtWFlvR2Vt?=
 =?utf-8?B?RVdMTzh2OHFsbFE1QTFUQWlZTVlya3BzK3JOaUhFWDdCdmJaTG54eXBIeHhi?=
 =?utf-8?B?YW4wWDJDSXI3ZmV3SDBta2VlMkJnQzdXL2l6M0svRlEwNU92TTRqbThIZjZK?=
 =?utf-8?B?WFlJelMydGhXRWxmSzVBSUpybVZKQS9SeE45N3dsVmk2WnRiS3QybnlpM3A0?=
 =?utf-8?B?ZXlQWm94VE9uaE5wWEs1REtQMWFqOXlWMDlnUGx5MzdtdHJBbE5aTEtBUFQ2?=
 =?utf-8?B?K3U1T2dEVEp4dFVEU3VsbFl6SjY0UG9NdW40bVFrbXJCa3ZHdVlnNWkyaC9x?=
 =?utf-8?B?YXluMFF1Yy8zeStJM1dPZzdjTExOYWxHVGYvWnRKYklncnZqWWV4UFkrNTlV?=
 =?utf-8?B?aGkzT0R4dHIvc1Z1SEF5TmpFUXl3cHRGK3ZrQjJYeEUrdjFaa25EQXJGSkkz?=
 =?utf-8?B?R1ozNW9mb2dZVVJHa3pJRXI1SWlhZEcxM01KajRuMHVnVXA1UUtwYzNqK1R6?=
 =?utf-8?B?NkxiNFR2NU9ZOHF6WFR6R1hxa3ByTzQ4TnF4c0NJZEdkVml5MGR5TmdWVXM2?=
 =?utf-8?B?dmJsM3BUWHpmSXNHM1M1QXBZbzFqZUlWeEZYY041S0Ntd2VKTWFScHczR3pu?=
 =?utf-8?B?bkZOVjdBUjU1VlY3d0Y5c0ptRSsybnZkanJIS2dCQXA0Wnp3VVp0S0V0MTRT?=
 =?utf-8?B?cG9rM0Y0ZHRuN3plR3RRcUtITlNIYlFWaXA4RDMrL0ZBZkZmcGdlZ29vZzRG?=
 =?utf-8?B?QnlHQ3p5bkRCQit5V2pTelZHQUlGbkxqeXNTNDY4L0JKK21Zd3lMNDFLbTQ0?=
 =?utf-8?B?RFJaU2J3bzR2ZVl0akpKb3k0Qll3eXlDTjkxelp0WXBQVVdVTGtvNm1oSHZD?=
 =?utf-8?B?MHczMjVoUlVJMzY2QWZkbTNOeG9VWHN4c0t0Q05TR3dqSVBwRkFEMVcrK1hN?=
 =?utf-8?B?Snl0anpUUEFGWllEbGM4eE83NUJ5c3h6K0d5dGNIT3lHUXJVVUtWSzlpRG1L?=
 =?utf-8?B?TFBZL1NhUXlKZUlTcFNmY3ZoempsUFhBUmhXakZFTUdmdHBlL0ZUY2hVcGlj?=
 =?utf-8?B?S01QNUd2a29mbUx1aEMvaHVmN2ZIVUt0UmF2OFZCTHBzdUVsVEQ5aTVCL0ZU?=
 =?utf-8?B?Mk1jL2VVRS96a1hUa1drK3FmTTRiTE5nYWlZV0pxSmFWdHcxZWMzNmNOM3NP?=
 =?utf-8?B?aWk3aUFoNGR5K1JxWGsvME04MGRoUk5hbk5yWlRBcmpEZGlkQzB5Zk5GUUI3?=
 =?utf-8?B?RlZYcEV2RWVXTW82ZC84bVZ1aEFIOW1tNnNEMVRNVHJnckUxVjZBY3cvSXk3?=
 =?utf-8?B?UXE5NVFSaVkySFdSYllLY1AwMnVBZFZkakpqb1B3amZRYTkzS3UrRjZsRXNw?=
 =?utf-8?B?VkhZY1ZMTWcrV1JyNldaWk1qOUdIQU5FTHJuM3RYVkw4V04yMDhpUjhLVTVK?=
 =?utf-8?B?Z3dQWkRENm5iZzgxWE11ZjFtdm9VM0VsWWVZMlVCOEhTNVJsNE84bWZ1ek9u?=
 =?utf-8?B?WTFlWXNVM3pmUC9PaS9QVjYyM0xGRko0VmpGcVVtZWpaeU9WYmtoZFlwSlBh?=
 =?utf-8?B?b1VXMTVIUEZxVlgvc1dkUHdLTUZZaVNxVUhnVUJOMFVJdnpxMFF4UXZCQlkz?=
 =?utf-8?B?Rlh6dlRWd2VkWXFpTlE0ZWRkamwvaDJnTTl5MXZBQjNvQXBvcGRhbjdCU3pv?=
 =?utf-8?B?RnNqRlkwcmZUOXNSQTVlU3dVMThWTDk2RTVrc1AvVGdnZ3J0VzRMZk5uWWZ0?=
 =?utf-8?B?eW1MbTlDUThHMk5mc1FTbjg3TmJEK0ZKTU5xdkk2ZFlkZysxR2s1M3JjTmJq?=
 =?utf-8?B?WEVrUDVvc3lWWkZuZGtpVUNQSHNJenV2MVRXMWN6VXd0YjBzdU1wYlRuN3Vq?=
 =?utf-8?B?Z1dqRlo5dkpHUWpobjFkQ0hlUExVL08zSmZPc3NxZEUvUW9NMkdRb09qb3lQ?=
 =?utf-8?B?RFoyTUkyME1KUU41RlVnSEtDaUQyWEFtSi9NekFkR3FuV1U0VXcwa0pFMmRu?=
 =?utf-8?B?K3NWUi9DRmtlb3VMUXNVVFpGQkF0eTM2dFl1LzI2aUhWcVRncXZGaUpDVnZV?=
 =?utf-8?B?T21Sa0h6UjJsNDdPUnVqRU1OTm5jRGZBMDdGTG5vQzFmSyt0T3lQZDFZdEtX?=
 =?utf-8?B?a04wc2lLTHVvL21KM2k3TW1SVjFOZkhmS3pNNno5amR1UTdXajRtdEtSSEto?=
 =?utf-8?B?dHJlaU9TMmtZdnhURFEyWHhycnRBZi9hUVVMdWhNNHNBbzQzbzl6YitOS2Jy?=
 =?utf-8?Q?T/PFllzIs9wu1OHUIE3sMsWd17LMb98sTfgwG9wvXoXlG?=
X-MS-Exchange-AntiSpam-MessageData-1: jh43dAGuh3VfcQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2ee731-5324-4988-5711-08ded8f7800b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:37:45.2550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DL6X0m12LOTVquUWqL7vv5emuHBdDgRDrFHZvbdPtz/JRD3r8RmS6mWc/xt3tdqOp8xJ19hWXhYlebjti/+NfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9556
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9522-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:laura.nao@collabora.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,collabora.com:email,garyguo.net:email,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB096701F16

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> From: Laura Nao <laura.nao@collabora.com>
>
> Add `SysMem`, an `Io` trait implementation for kernel virtual address
> ranges. It uses volatile accessors to provide safe access to shared
> memory that may be concurrently accessed by external hardware. Implement
> `IoCapable` for `u8`, `u16`, `u32`, and `u64` (for 64-bit system).
>
> This can be used for instead of `Coherent` for cases where a different

typo: "can be used instead of".

> layer takes care of mapping the system memory to the device (e.g. dma-buf
> or GPUVM).
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> [ Rebased and adapted on top of I/O rework. - Gary ]
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io.rs | 122 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 122 insertions(+)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 96962498af77..5c06785facea 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -1034,6 +1034,128 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
>  #[cfg(CONFIG_64BIT)]
>  impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_rel=
axed);
> =20
> +/// I/O Backend for system memory.
> +pub struct SysMemBackend;
> +
> +impl IoBackend for SysMemBackend {
> +    type View<'a, T: ?Sized + KnownSize> =3D SysMem<'a, T>;
> +
> +    #[inline]
> +    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mu=
t T {
> +        view.ptr
> +    }
> +
> +    #[inline]
> +    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownS=
ize>(
> +        _view: Self::View<'a, T>,
> +        ptr: *mut U,
> +    ) -> Self::View<'a, U> {
> +        // INVARIANT: Per safety requirement, `ptr` is projection from `=
view`, so it is also a valid
> +        // kernel accessible memory region.
> +        SysMem {
> +            ptr,
> +            phantom: PhantomData,
> +        }
> +    }
> +}
> +
> +/// Implements [`IoCapable`] on `SysMemBackend` for `$ty` using `read_vo=
latile` and
> +/// `write_volatile`.
> +macro_rules! impl_sysmem_io_capable {
> +    ($ty:ty) =3D> {
> +        impl IoCapable<$ty> for SysMemBackend {
> +            #[inline]
> +            fn io_read(view: SysMem<'_, $ty>) -> $ty {
> +                // SAFETY:
> +                // - Per type invariant, `ptr` is valid and aligned.
> +                // - Using read_volatile() here so that race with hardwa=
re is well-defined.
> +                // - Using read_volatile() here is not sound if it races=
 with other CPU per Rust
> +                //   rules, but this is allowed per LKMM.
> +                // - The macro is only used on primitives so all bit pat=
terns are valid.
> +                unsafe { view.ptr.read_volatile() }
> +            }
> +
> +            #[inline]
> +            fn io_write(view: SysMem<'_, $ty>, value: $ty) {
> +                // SAFETY:
> +                // - Per type invariant, `ptr` is valid and aligned.
> +                // - Using write_volatile() here so that race with hardw=
are is well-defined.
> +                // - Using write_volatile() here is not sound if it race=
s with other CPU per Rust
> +                //   rules, but this is allowed per LKMM.
> +                unsafe { view.ptr.write_volatile(value) }
> +            }
> +        }
> +    };
> +}
> +
> +impl_sysmem_io_capable!(u8);
> +impl_sysmem_io_capable!(u16);
> +impl_sysmem_io_capable!(u32);
> +#[cfg(CONFIG_64BIT)]
> +impl_sysmem_io_capable!(u64);
> +
> +/// System memory region.

Maybe "A view of a system memory region" for consistency with the other
view types.

Follow-up idea: `SysMem` and `IoSysMap` could maybe be moved into their
own module to de-clutter `io.rs` a bit.

> +///
> +/// Provides `Io` trait implementation for kernel virtual address ranges=
,
> +/// using volatile read/write to safely access shared memory that may be
> +/// concurrently accessed by external hardware.
> +///
> +/// # Invariants
> +///
> +/// `self.ptr.addr() .. self.ptr.addr() + KnownSize::size(self.ptr)` is =
valid and aligned kernel
> +/// accessible memory region for the lifetime `'a`.
> +pub struct SysMem<'a, T: ?Sized> {
> +    ptr: *mut T,
> +    phantom: PhantomData<&'a ()>,
> +}
> +
> +impl<T: ?Sized> Copy for SysMem<'_, T> {}
> +impl<T: ?Sized> Clone for SysMem<'_, T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +// SAFETY: `SysMem<'_, T>` is conceptually `&T` but in I/O memory.

IIUC `SysMem` is not I/O memory. :)

> +unsafe impl<T: ?Sized + Sync> Send for SysMem<'_, T> {}
> +
> +// SAFETY: `SysMem<'_, T>` is conceptually `&T` but in I/O memory.

Same here.

With these considered,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

