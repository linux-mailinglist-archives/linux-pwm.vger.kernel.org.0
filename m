Return-Path: <linux-pwm+bounces-8755-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCrPOOw+82kGywEAu9opvQ
	(envelope-from <linux-pwm+bounces-8755-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 13:37:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A184A23DA
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 13:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 632CF30356E4
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 11:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F73E024C;
	Thu, 30 Apr 2026 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mewDGSZl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30F73E5EC1;
	Thu, 30 Apr 2026 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777548926; cv=fail; b=Ghte+AB3TKN/j4LuJA6NZ6X//qHysPhLUhRl57ivdCaB6J8xXcTVlgqKvSjotllMkeFa2oJKbUeLuRSnxlfjLJYWX4oNGocmpl8TDwLSR7Cfq6qYDTpDqTxYYZluSZi2ZISpITC+mSUtqKqpaSGRVcBys2GzvfqeLL66aH29ZxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777548926; c=relaxed/simple;
	bh=jlM417uB4Y685ka7rUIYAteyU5jo23XaJgZNk9WdG5U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=t7lq5zdRWgGHh3skw7COOXK7+bkpsHvm1CJpKQA9qabDIpvDy9Zi+fhLiww6TAy7AUNAFHJDgPOfHi3lCA+oovvmwa9LWfgQBxkB80GpmpNoUJ+ffM7ktgEjk93WV//+H/eDnU13PhSRZFxiJmx2Dfu+jj1gDGYoKUkapL9oi6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mewDGSZl; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTO/cXmWx0n4IKH3AeIQYeE6nxmO8l7RSQJtFTXWe/p9N8eNcC+auUgY4O8ChuSHHORd7vTinqs5TEIMjZGwzHdaKDMug9Hp01Gs+Jz94evnoPWyPFkPRfAesLpnOFSq8MBgBfCtj3hIiXp5+63toBR1KLrImPsiHWiIG53UAh9mweNjXfUWBmXK8hX2fzTMNMYpv827BeOnIMylqbJQxKGcsbktYpJk0G+/BvIOusGoE+WdrJ2wbAwpbNSNajFGJ9gO4tloalXOegIo4Yaq6vnXtiTEl7Xm3RunIIQUP2R1Oo77XN/c2+l8RGXDaO+b6fPal/fudVcGluHEMkEkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGR+pgZuqSMxtoJt/ELViCmVYkmDlwFezP9s7An5obE=;
 b=iLNpGQLWBHPSMzHZLQpv0J9QyAoByc+VlX587lGzuHKcdAK6QYXHVGE2aHUfCGpuPFifYU8GcI/A3fmC0NIkcBWc15i3PkUOaxtexhnTlYBvUYIh6EsPByDp7ScH5x5A1FrirJzJXqtaKjcGEpdnj9836qDGokOp8/0jUzIIffe/xn9AcM+BRiGa2e07AKlaNlaAyMvj1KZaLOHqLDutGWrGgECfr3UX5gPWRjbqnZ5yq/BDYOUig2uiQoMReYqjsliiy8KKwKCQgFbMNoi0z5b6Bkg7Iyx81/WuhUsBObMgFBa4oT37+DdZWK6mjCAcUZg/U61xlMe7gARxhuxQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGR+pgZuqSMxtoJt/ELViCmVYkmDlwFezP9s7An5obE=;
 b=mewDGSZlbB01OfIc6xxQChiR73NiyQIMidW4iZUmxqh/HOsHH4oYtoHXbsitH7Y+lBxOdnOqRxfn0hEVb8vnKxO52pYCrTII0ej9qhLGPOptIrsQX3uVaUHUmI10N6XEJjuuDjaTggbPWRUNyPtWfdPQGPlkvewLgN6Z1zGYjtIojcqyK8pT0yoE/S9mNkmzNhxhk6+9hO16YJElQGqdFrCB9Y9pKkGYnQf6Y3KNq7bT8ZjekiGEzSrQR7TAbaH0IUgR862gNnsOuiHmE5rLBFzL99K7CWJhkCMMr2BTiGYMqJEo9Sclo0Br0KrII6UXDLWjYc8dXol4dGH0/TlPUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:35:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Thu, 30 Apr 2026
 11:35:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 20:35:06 +0900
Message-Id: <DI6GHYH4LC4V.2JXRHZWLEJ8L2@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20260427221155.2144848-1-dakr@kernel.org>
 <afMdfs0segrRBx34@google.com>
In-Reply-To: <afMdfs0segrRBx34@google.com>
X-ClientProxiedBy: TY4P286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 034c2e85-c686-4782-3fe7-08dea6ac8906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gxM/bfbMlWx6PzM7Tc8wGbr7MrfF6JTUzGHmB7X6WPybwzpVLGdSrLcNbojgkTlP9nk5l2N4KIy9grSQAl5+Oc29mx8mBMjWqWGR7Lxqunw0R2ZZ8YhVam1ZJaNk7qwCvjoN599k1MQTRZ4Lm5B+NiLbnwKFU7Vb2gu/ciZn0gCA+0cMDPX5DunDSu5j8xoC2rTmu+jKnIiWJVC0GgEV/zAOJy+pXsES0TgVnkzEMxUrdmGazpF14dhbM907FGIcTrLzK1wtdOWN/parHdK+05zh2V7QLAZnDYGlcLzrnZgglZh8ETzjuYbIwzydVPdWQXzki9EdJPCnlQWWypW9eZVzddXY+OXuVzD515DVLQD9hv0e37xDTgnmEnyd8jOZ3FNLgAFMXecoiGe0xFbN4znj4/ykUdFNGY+ZVijV8upTBbS5U/1x4UowUJp0RRO3iMkfGTwRA76IeuIOcaYNmn4sk5Wh2MZQh/SVVNTxXK3FbbwAzdpEIKmPB6nlABAr0C4Ee/ZZa/TJkf6GaMgVidT35Km7EFkWYtq84eVz0RjrPNJ66OJ3u5A+fnlAJkzTO2ITpf2KlTeabstEwylVo+gnHeEwBTY/Am40Ey5xHgqkUi1tdVCwCmopSQKIIM0zZMsE+dFFrhMkdQy/UjSnqe5i15Mjsr/ok57AM8l2EAmNWIu+ch3LaPNnIxbnarCKUPnd19f+lvVrltsBq1WQES7XhoNbunsI8J4l/KPZr6U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGU5cFVwWW1MUTdSQTlVMUE2MVRSK3J0YW1saGVsSmlJV1Q3OWNkUndVUjNl?=
 =?utf-8?B?eUpuVlVsZ2M1T280RE9sUTBxeTBYTnBscFpvKzBndVBZYm9VYUlzZVJ1Nk1u?=
 =?utf-8?B?VXdpRHBrSnUzTWJQVDdVY2JpbklITzZXdWpnTHZnekdOTzR6N2ZNbGx0OUxZ?=
 =?utf-8?B?aC9XczJmNnU0VzAwaDFKWWVNSXpVbUYrV0pENkU3T0FtUVJCMnk0bHJhQzFY?=
 =?utf-8?B?Vk52em13b0pOR3RndE5VVy9UUjZQWTUrSG5KdTN0WVpCb3FoWU9udzE1d0Fs?=
 =?utf-8?B?RkRjVE1zcjMxM3Qrc3BYTi9wVFc0azlBYXlLeWU5aWR2TlFMRTFnQkxXRS9V?=
 =?utf-8?B?MHQ1VmNnMW9xU3g0QmFDVXM1Z2RhSWU5QUFUbUJmWk1UdVVlQ2lESVpubko4?=
 =?utf-8?B?Wm15OXBVVjRYYWEvNVkxeWd3RzF0Q0dTMTVlM0p1L3RUM1h0ZkFKd3VGeStM?=
 =?utf-8?B?dys0WjUrVzd6Rk9QRXlaeUg0Kys3Yk5oMEJkWWRVNUhzOTJRMFVKRmN5bVpv?=
 =?utf-8?B?WlFhN0RHNEd2YlBBeWxTVE5HY08wMGErdityb0k1ckl6OCtVczRBN0JrcFZY?=
 =?utf-8?B?eFJhS2VmNjlBZ0Jja0g3aUxBVUM5dkJ1ZTJtSjN2U2s3RGxta3NjSlJZNEU0?=
 =?utf-8?B?WjZNY2pnTWpxRFZFUGhDbzBjQ1N6dTRMa1E0ek4xbSsyVDZLRHkwRmlIZGh1?=
 =?utf-8?B?bzM2cjd5OWZ2amljaVdrMlQrWStVQTNlRWhyS1MycTRHeGxDdS9WMkVRVW9h?=
 =?utf-8?B?UWd2TEJrb1NrdUMvdUJBZS85c1JyMkpFOXQyclUyN1BucFVxMUdVeTZEamp0?=
 =?utf-8?B?bWZZdmtwUXZMNitPQllBTDFPVXgrNTVNdDBYcncwZVkvYWI2cXUxZzdPRzky?=
 =?utf-8?B?azdxNXl2Rm9hc2NaTGRzUTlZZERoYVlMSTBBZUl4TDUrVG9HNkJ5bDFVYkp1?=
 =?utf-8?B?U1dhdXhxR3ZYT1F2K211MWJ3TldreHNGUE9sc0cvZ0dTTUVSMlNTNHNVckQ4?=
 =?utf-8?B?akNmSlBic1dwK1VJSnN3UGZ5TDFyYlgrRm1pWEJodmdSSFRyZTJsNkk2SFBU?=
 =?utf-8?B?WmdndXFrYkoySVZjSHN6S1BtVGt1R0srNnFaQ0xCbGdjZStnbGpIYTlCd2t4?=
 =?utf-8?B?S1pMZlhpNEhUZ25Fd0dJZVdFdUpGLzJEM3BjY0pjR2Npa0FSYmxiUE5hZlNn?=
 =?utf-8?B?NWh6Zmszb09FRFZrNDVzN3lMUEt0MHF1NHhPOHdSQ0RXRkw3UUlzenRVNm81?=
 =?utf-8?B?UDROcTFGVXdid05Kbm51c1dxQnVhd3A3TUxqTzNlYkZGQU1HSmYzQWc3UzZn?=
 =?utf-8?B?SGRZdFJSdWwyWlhIS3JzeWM2cDFDdGQveEM0ejQvWVdoQmpkZ1hYUjZqV2FY?=
 =?utf-8?B?aXhYb0lKZWM4ZW4rVVlCLzdFSGF3TnRZL0NNUHRMVkQ2WHZnY0ZUclB1RGlO?=
 =?utf-8?B?U2ZwM1JqMm04cnVIY3lLS2RMTlI4SmFSaUgyWS9icFBhcThBNkhFV0RmTkVC?=
 =?utf-8?B?OHh1emJ6OE9ZMEJpUm1Wckpxdkh6a0I5MkxDVzVRMzlwZ2tTR0Q5RWNBRlFm?=
 =?utf-8?B?bHBaYlBGM1hnaVlvZWRVOGVuSTE4cWJKeEswTE13Qm0rejE1YXJHYWlTT3lQ?=
 =?utf-8?B?dS8xUEZWV2FuOGdBeHoxVWVaMUNhcHB3RjlpT28yMTlqTXEveTdLdVc2UWM0?=
 =?utf-8?B?Mkl0ZXgzNm93Um40R3lwVW5RNkZMMnpWT1ZFbkpiR3gyVGVEM0MwMGpiVElW?=
 =?utf-8?B?L1ZxbG1ibWNScXd1aE5jTVNUeG9OWGxRa3V5VmwyOXFpLzNCVHVFclRSN2FN?=
 =?utf-8?B?VmsweWllYmhCWHVOZ3dJNG1PcndJdy95dVgrcUpOTURwUGxwaERlUHd6VFdv?=
 =?utf-8?B?cFR4dzE3VnBqeWZBbytib0llMXl6Q2J5Y2dabVkrakwzbm8wcVBCbzJrd1Ba?=
 =?utf-8?B?dERNMTNEMUtOak5LOEJ4V1RYWkV6TFJMdFlKR21WbzhLTmU5MjZ1RjYxRjZw?=
 =?utf-8?B?RDVxM1MrR2ROSEV2a2N6RFNHbWhIYm5MYlI0RWozUm5TN0VNRk9NNUtWa3d3?=
 =?utf-8?B?VVpsdlFVOXowTWJBZEprcW5BK09hbUpoMk9aTUFmY1RNeVd1VWVaM2dIclhi?=
 =?utf-8?B?bCtoWUpGcVZ6blFvZm96M1VTL2RrNXdEMlVnZmF0VW93bFd6R051L0E4NERR?=
 =?utf-8?B?bFlsSTN2cXdsaUZUOWFHS3N6Smxtd2RQL1pJSk5yZ1RJQkx0TXZRTjVDRjBE?=
 =?utf-8?B?YW5VWUszc1J1TkFxUEFHc3ZJRmc4cjJEQlBuYURmbVd1ZTMwY2lIdTJhQXd2?=
 =?utf-8?B?b3ZodlZsbXJrcUF1U0x2a2lISkUvV0ZieFdsQ3dIeksxQzZmMW8vS1Nydy8z?=
 =?utf-8?Q?9GY+0B/pkhHuXYYys8BfKeCgzO43mC66sPyJXeTyHE2fv?=
X-MS-Exchange-AntiSpam-MessageData-1: S5TbD9j2zNBw7g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034c2e85-c686-4782-3fe7-08dea6ac8906
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:35:09.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bGRyL5RJ+Dq1HPJhxJ1ec8mQX0AI4Zn1Cks/Gm0bH9wDvr7HkpzXNVSzhCw95VA/mZUm4McvVq59r355Vc+6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
X-Rspamd-Queue-Id: 92A184A23DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8755-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,intel.com,linaro.org,samsung.com,google.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]

On Thu Apr 30, 2026 at 6:14 PM JST, Alice Ryhl wrote:
> Super cool to see this!
>
> On Tue, Apr 28, 2026 at 12:10:58AM +0200, Danilo Krummrich wrote:
>> Before:
>>=20
>> 	struct MyDriver {
>> 	    pdev: ARef<pci::Device>,
>> 	    bar: Devres<pci::Bar<BAR_SIZE>>,
>> 	}
>>=20
>> 	let io =3D self.bar.access(dev)?;
>> 	io.read32(OFFSET);
>>=20
>> After:
>>=20
>> 	struct MyDriver<'a> {
>> 	    pdev: &'a pci::Device,
>> 	    bar: pci::Bar<'a, BAR_SIZE>,
>> 	}
>>=20
>> 	self.bar.read32(OFFSET);
>
> I think we should establish a convention for how to name the lifetime
> early. Using just the generic name 'a is probably not ideal.
>
> How about using 'dev for lifetimes that correspond to the lifetime of
> the device being bound?

Good idea, it's not obvious what this lifetime covers at first sight.
I'd even hammer it a bit more in the documentation as it is quite an
essential point.

