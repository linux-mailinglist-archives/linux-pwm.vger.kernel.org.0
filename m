Return-Path: <linux-pwm+bounces-9531-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JjpeKjTMR2rqfQAAu9opvQ
	(envelope-from <linux-pwm+bounces-9531-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 16:50:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B23703998
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 16:50:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Rztp5fgD;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9531-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9531-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E733301B4F1
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD63F4828;
	Fri,  3 Jul 2026 14:43:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E93F58E8;
	Fri,  3 Jul 2026 14:43:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089833; cv=fail; b=pAa4lw+K3zLSEvlFf5LHf3WIPsIjof+ugdiDQvQa67ZDv9B3k1c7dxuNDeimg5lWEyX0LVUcbRzF5rZol6ZB0KuPonaubvZKrIp29LeaM/Oq63WukS4uCf5kOVeFIyhUCR5BmdbSl1pvVAlRP9rslNEtgQX0YmiraWQ4+fv9/og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089833; c=relaxed/simple;
	bh=6quzM/9mjNpVTa8ewytydTIz9JcmSj7I6ienU7O9X3c=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Xgf3tBWSyv+oqK4fXT74HFaBLPOgSAHfZQGssYQUzDWhesXcRPk93SxpqCmw6cKCUkPIs+uSahUnUc9SiKvdgxh5BBHAXWk9h02iT6dngPm9gn9scMfiNM5i0A+2yvMbCo9gJQgqhrXn+XTO20ydlyHpHF1EONUaFmW3/lW0XHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rztp5fgD; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RX9ocP5oT1HdnF50BfaskH3F846ulVbJa9CfPdYw+uHLC9L2QulE6KfgQGgH/hT3j7RQc77LauG7tM+fwwT9AV8+flVpLvoDDrcNY41tVn0YA1sHDFviTbnNIFec2MFrwK4SX0fHEW1qdbuxfswktuzJjt1KXZJES0Et6V43wBbot9AJ9+apG8byGnhdNNZz7pdbYtfhNns3SGuOhL8JqSteyFbH0cumdNZJ4F8crnkUE4hip5PasLT/AqBSD9SUlpEUQPw/3eJQck/qPIzHpu5LRYZ6kRvQq/vRHae0+IX0nXTtIwRMhW0mAbtznlIjSi6JNfOZ7YV+rE0dX7bJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TD9GWoeXmwCwVr26wCC1DxWbXjK2/GynljNNGEdI6vk=;
 b=kMfud4w7wOINLklEBOg19djllzsrDyxp6et7X625TX5diR58VaSqpO+nUmQ2sLNKd0H4QlCX35h5Ib3112FI/u14/kPx8YpGOA8mJWDY2mroZeb6bl/On5WDo7zbKYZGnDhCW5Wx7JHnEfwlYF154d2kcFQROHVfJ+KO9dLdpwRwP6svLD8p7abw9/Bs5sWXqxSNAc2nAH5Vmj/Nz7URwynm3zQ2ASP+WUdjmVPSR/t1LufJS7D8unbKmcjD07Usj0sR9+u3yEC6Vey92PjERq9DrX+1PSeADA782qooOpbhh4+EHa6uLKKd0qmvxm91nfsNWxY7hUek1sTqdXx2lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD9GWoeXmwCwVr26wCC1DxWbXjK2/GynljNNGEdI6vk=;
 b=Rztp5fgDQfCgVJNI8Zlt35ANNSzlE5gWRviRG5xAX5HNzc+DCSc6CyENe0sxwYn3FEA1JdVsaGuc5t82CCaWyERvj+mvfcJQFzCTrmrOLqbbNcaNtGO2IJafixqA49YwWAral5zrq+QaSgm5XEwKk6dx+qckJ2qeR7MYv52cpxgXtU+39GYoiEabqS5wOTfel466QnaxZYygGuXGUwTMn2BFqIK39mqE8cdPyvbFi6t+0Ty704CJUp3H4Dth3D2m1DLBfxum4W9YDZuxUxfBTEIVd5EOoK32vsPTBq8s5UoIqAQWMLbQ3f/anElhWW2/R2/ULpAkIEd7Oor7ygaHOA==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 14:43:44 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 14:43:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 23:43:40 +0900
Message-Id: <DJP0L78R82FA.2BKU318YFFFR4@nvidia.com>
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
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 16/20] rust: io: add `read_val` and `write_val`
 functions on `Io`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-16-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-16-d0961471ae50@garyguo.net>
X-ClientProxiedBy: OS3P286CA0117.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f7::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e2fb27-8278-49e6-68c1-08ded9117b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|23010399003|366016|11063799006|4143699003|5023799004|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	n/vJEkVw3mEw6uIbNcruCR8BNiJhVwhc7zh10WB1gUbDYzXcusiIizCPUYH1Hnk3zfbHBh6nPSengBCHnTDpbGmjDMkE7VKpR43P8JOP0jjzkZGSO4lI1BXxi8580YpCXtBGQZpPZe/3q78BnPR8WUVnCgEXDyddVXFCMR3sgPYL1HmJNuwU+u96UxKS3zezwFsXW754ExQQ2QQNLoEeSOndTEdBKL5YbEJ1qDR1FGyL6hxmFLcabB7MPNwbRE/gw5KvfoCbJv70CsGQtjKniGa6mYlL1rZ5WqF3I/afOOMhXyYLH+X2yIFR80ZaBR9lWUMxYLMau0iVcyv2KT98BIQYUpEVUk97OtOiFPMHnU6TK+8SBuN1Tpf1RlV8tJFps3MX6Ib684eyRFPRAeC8UAQJd7Z/Rfy8kLDVLOR4xtgXDFpCCl8hpmWzslG5KpJzTQT7vZtD/bgdC+g4bLCPOcYhsutcE+dvu1zZiXD0vujRN62ONirHIcrMtguvH5BKv8T5vBf9L14QAnUj95GK6u+LRyKRlSFaAKmXRXZtQJoj6HjfBRp0IK/TumhNJ1sMEiS49rP/lXsvPU6xBD/MdS3/9rPncU2upOZV77EIGCHz7Da6Ue/3MMZrJCmHVTsKOmm6ds51s9HYqbjSeZkfbY0/Ct6oeJIVj6YpJviChG8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(23010399003)(366016)(11063799006)(4143699003)(5023799004)(3023799007)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S09wMzFJSGxITi83VDFiODhDek1HOFpOUlhQQWRhZlFzcHl0T1BVQjdMbHFW?=
 =?utf-8?B?elRsVUgyOE9UVGtoaE1Zc1VXbGozS2E3a2lKdEtqUlNVbFRCMkxvVDBEZlJw?=
 =?utf-8?B?ZTRrS2tmd3B6T1hGRXJacTFXVjBTOWFwQ20xcVNXQ2ZUY3BtaUJua1Z6ODIr?=
 =?utf-8?B?cDJCZzljOTZ3eGk4Rzk5Z0kzVU0rZ1lFRnRSZDFaTnc3bUhEZlVYMnlrZ0E1?=
 =?utf-8?B?VTJWVFowYUJvWkhQcGEzaFBnaURlMWUyVHpsZmllSlRkSGE2OGNPSENDT0tr?=
 =?utf-8?B?dFU5RmdxK3d6WFRia0w2cXFlRWdLc3BXc1hsL1JDQWpONTdXOVhTdDFXVzBy?=
 =?utf-8?B?V1VZcjZlUGNqUlNuSFlhRFhhS2NYUjMxVUxNQVM1VjE0clVKTzVJamdmZFpC?=
 =?utf-8?B?bHk5QXJWc0xVRW5TS2R3RGlwZFo1ZTlmVmN0eHhxRmQrdGRRTEU3L3hGdDZq?=
 =?utf-8?B?Zkd1SzEzMWgzM3VXVDd4RmFLSEdxbXdIa3VnN3p6L3VMQ01heXFVUzk5TlV2?=
 =?utf-8?B?WGprY1lSNWNzWDd1d3RIMnV3ZnZIWU5mM1lINEY5d0xjZ1p1aVNWSjVYdzVF?=
 =?utf-8?B?Zzk0REh1d1N3VkR0VG1ENVFFaktkY25URVM1L1k1dUNPYnBUS041bThYWnZl?=
 =?utf-8?B?K1dEUlRrclBKL21BNW1PRURyK2lmZW5yMlpERnZFdDM0LzlvejZ1UEp0NjFh?=
 =?utf-8?B?bS91RVVaOC9CWGFBRmdWY3J3bWQyQ0FsT2Fadnc0UDZZRFJYbWxLaFFmQTA1?=
 =?utf-8?B?RHozL2E1cmdOVlNUeGkzNGV0Ums1Sy9XRXBjY2VSZkxCc1ZLcWI5WEhZUm8v?=
 =?utf-8?B?L2JIZFpuRVhCZ01Zakh4OExQTVRNVWRwUDdsdWVhZkFVTDBnQkVRYnlKc3Ir?=
 =?utf-8?B?eWFvSSs3Qk5qazdMVkMrS0p5bXJIYnZkanozN2pCdjE0aVRwRXFmc3pHc2Rx?=
 =?utf-8?B?RHdXMjZSQVo3Zk9aTjJBeEEzV3I1QW51dVpuN1FlYzhieEQ5OVAvT1dBbjBi?=
 =?utf-8?B?cjJqckhyYzlIQWcvcWYzbEoxYnBLT1AwWGxXbmxsSGZsNUVTMFh3OXhFdWQ2?=
 =?utf-8?B?WjR2bEYveVl2TmNheVBlVk5ZRG5IR1VpSVhuWWI5RE9yRXNlYWs3cmcvTGJ0?=
 =?utf-8?B?L0NzM1VsY1RpdmVZdVc3aGRKUUhNRVhrNUhMYk9sWC83VGh6VUFXVUI1Vnc4?=
 =?utf-8?B?Q0ZEZVpqZUtJNFdhUDFGMlMwcFU4SXFqQjNpUFU1dUZ4eno5RVg2WXVSUnMw?=
 =?utf-8?B?d294N3Vhd1pIUVNlSGRzMjB1L3FpWHBBK3ZHREJ6OHV5UGFyQVdiZ0VGY2R4?=
 =?utf-8?B?KzlCNkVOU3g2TFVRM0RiZ0Q3UWlTUVgraXUyQmN5Tms3M0ppTlM2RWNLd1Ex?=
 =?utf-8?B?dHQyU3o4R0lWVUhXNUVxN3dqemxtSm9sK2taeUhYRXp1Ujg4bGRVUy94cGhL?=
 =?utf-8?B?TWNRUW1jUDk1eDhwTjJjdlk0NTlTSCsrNi9iS0VjeklnbGx1WFNreVE3RE1r?=
 =?utf-8?B?bFdBR2g0WU00WHJBdENwVk1pVTFBV1NMaW1DTk1ZV2pnSlNxeXRDbUZBdHE1?=
 =?utf-8?B?eVR6RDZEaDZ6RG5DVWF3NjMzV21oYzBuNUNUK000NXdiRVY3cm9JQnBaWVRS?=
 =?utf-8?B?amtpSkhjZTQ5SnBsb2RWak9leDdBODV1cFFwaldSaVJhRU83d0hQSVp0bnBN?=
 =?utf-8?B?dTdtV0VQVkdZWVVPOUhFNVhpUkNRMWtIdndaTEN5eDBHbWkwRENMVUhUS1VN?=
 =?utf-8?B?YnVZcng3QVBDb1RoOEZpalRVaGppb1d0bVptdWJGZGhLSFRrNWhPaGY4UStw?=
 =?utf-8?B?REdaQkRsNk53QU9zL2o0clBzam9rMXVMV1greG8ra2pmM1RYblpDL1d0R21I?=
 =?utf-8?B?ZThBV1NKRXhwaGxIMW1TNUNZUDhObGYrTjZPbVpkZSsycm5GdmV2WUk2eW5x?=
 =?utf-8?B?bTZUMlJwRjV2aUFMYy9Fd2xYMmRuUFQ0SXZhTXJDMUdWSVRTaXVpdE5QblVr?=
 =?utf-8?B?UGo1TjMzbkljcGlBV2pvSE52RW00RWQ5U25IendGa1Vtem5MTXplN2RMRG5a?=
 =?utf-8?B?SHRQOWRFOHp3Tm9Nb3JxYXNNTnh1dk8yMDFPS0dYZ0EzOXQ5LzF1cHVFTzBJ?=
 =?utf-8?B?VzVZS0xIeUZhUStUNmNHNXpnenRZNXpGRnIwK0JudWZ3bzZTNjdXMkhJSGZn?=
 =?utf-8?B?MkplUWdoc3hQRXc4TFB2M0huemJkK016aDNYNFNLU0dtWWwrNFg0eXBQNjB4?=
 =?utf-8?B?NTZZb29DM0xVem40c3NnSHVtY0lsd0pHZmhndUtQMlBqckdaR2xKTm9DMVRM?=
 =?utf-8?B?RUJTRHZFYktLTnFPaGZ2UC9QcmVJQnJvYjFZWGpiNzNyYS9FYzhnZWREdmY5?=
 =?utf-8?Q?m1MUoHzwbmI9lvPW/MyKptaxOU+tBYLXt5a21SMnWKVYR?=
X-MS-Exchange-AntiSpam-MessageData-1: ME4hlNe2UAsKWQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e2fb27-8278-49e6-68c1-08ded9117b86
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:43:44.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7Cr5CJuTzi1+yj21qaKNQjipM4rbGxEh5wckkLoRmhMJ+mo8ZR7W/eCHS6kR6pDcYZwGsY1mC0IgXVJax/oUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9531-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,garyguo.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20B23703998

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> Provide `read_val` and `write_val` that allow I/O views to be accessed wh=
en
> they're narrowed down to just views of primitives.
>
> This is used to provide `io_read!` and `io_write!` macros, which are
> generalized version of current `dma_read!` and `dma_write!` macro that wo=
rk
> for all types that implement `Io`.
>
> Note though `io_read!` and `io_write!` only works if backend implements
> `IoCapable` for the type; which is typically only implemented for
> atomically accessible primitives. `dma_read!` and `dma_write!` currently
> supports them via `read_volatile` and `write_volatile`; this can be
> undesirable for aggregates as LLVM may turn them to multiple instructions
> to access parts and re-assemble, even if they could be combined to a sing=
le
> instruction. Thus, `io_read!()` and `io_write!()` does not fully replace
> `dma_read!()` and `dma_write!()` in this scenario. The ability to
> read/write aggregates (when atomicity is of no concern) is better served
> with copying primitives (e.g. memcpy_{from,to}io).
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

<...>
> @@ -1225,3 +1269,63 @@ macro_rules! io_project {
>  }
>  #[doc(inline)]
>  pub use crate::io_project;
> +
> +/// Read from I/O memory.
> +///
> +/// The syntax is of form `io_read!(io, proj)` where `io` is an expressi=
on to a type that
> +/// implements [`Io`] and `proj` is a [projection specification](kernel:=
:ptr::project!).
> +///
> +/// # Examples
> +///
> +/// ```
> +/// struct MyStruct { field: u32, }

Same as patch 13, maybe this should be `#[repr(C)]` to give the good
example to readers.

(same for the other example below)

