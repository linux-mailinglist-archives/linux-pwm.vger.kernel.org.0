Return-Path: <linux-pwm+bounces-8729-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLSONtz272mFMwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8729-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 01:53:00 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DDC47BF68
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 01:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 435793014C7D
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 23:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8793B7747;
	Mon, 27 Apr 2026 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="x1gtluw0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022077.outbound.protection.outlook.com [52.101.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC052765E2;
	Mon, 27 Apr 2026 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333977; cv=fail; b=Q4QoyxyA8faA7RGXYbwMOaEzWmbjYGKZk7cprjwr2CEEu1dcFSTRWJ4n9hlKWpMM3xfwe2YPNevxXurFT3o3VotgRaLnfwdWJTcQnQ0PlWl1gdS9xMVwvjDwWog7x/HLOmchUOPjfOt4l1kxyg+6LoO5XjZsZS0jpPszFZ71nxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333977; c=relaxed/simple;
	bh=d1A9gXacyJE0fL4Mb1Vtjun/LFbnypXOwMig7CpfdGE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=RCPtDxQCAt/FizX5n1eKe9g6brCkGz4c6yrcG9ND/EmA7V6susIyOFn6T29gXSE1gEkyiVfVsYgTMQPQN6IYnp4UyiOhqupanL/Uif/vL+0ZtL9K7PDFa5HIDH5Tl0B6Zc4Lkp0H19cq2PmfJX35fGQazZWeFEaqpg/x4FdlOo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=x1gtluw0; arc=fail smtp.client-ip=52.101.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=md2Fheib67yI1YmFWPywIC3Q+fwnp60eJBJJmO/p7CKR+TZ+JInw3B+yClH723hkqC4nod+XOtANKUMwjRF0+C3+/S0iLRYw8GlV0TzzAOj7nvjgmRVlvjq1J+xxIg6/ZqJoXkyzhVH5ftopGzR2EaWkyPY0si9a0xySq8DQSqm1PsIO1DnKc38Vf4Y0tVya5Pu6aYGydcdDFs28C6zLvNGXFeDocu/PuILEtyZZF7iCNZ/tHcMEzh+O2xh2EA48P7b4MT+1rZBTStBgPMDg5959jWtfx4Gv5igxqgyYaRszwAtu8gTxtapfAvdKJR3A1fo5tjc0zCPAN6vGLWDaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IhncgU3AcNMXgmtiPUDpX2MFFdkxxX+foBruly68HM=;
 b=tracFmUE1dwT7Tyc1QKWZ14Cyn2lpTSFuS9wKK7Ul2t1V7osgCbjZt3BqoQ8rM5+9L3u7Owi6aOq1zr5pcpUPUV1hb0MpnL3g2dYqk1U/xhXi6gU/ZL34H+8owMgkBOfPsAzsIZ6tnsObBIglURlUP/HZYm0XBqlS/KifwwcZBxa+wVP5cmVfkTkkt5UL22uiAvwM3BgeoEPFM+A1PdHEyqwtcqjXuaDYitvF2c9NU7qjS3Iw0RZ2VXjUZPI4dfkLh995+vRJ6MRAnmQlmFLzHv0R6rG1KroGAesMElCZQVHFI1gxo2URoYOoWsIb/NhSBM/oe8AFx2DZ5UbV1eeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IhncgU3AcNMXgmtiPUDpX2MFFdkxxX+foBruly68HM=;
 b=x1gtluw0s8G1TOltmlIbcDfZeR07Vv4VES2jHWAY4oZvUSh50whw0csTd1jI+sKbnuPNCvydeY+6JjN2Rd5l5wR/IZSNLSq+sf/YymRM///HQq9A/tZAgjp6dNgrnrXQwpYVqIuegd6XCQjfDb0RzqruODYSMnKsGVGBLib44rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOAP265MB9000.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:498::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 23:52:51 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 23:52:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 00:52:50 +0100
Message-Id: <DI4CB68NZI8P.3RA6M7P8XRII4@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 06/24] rust: pci: implement Sync for Device<Bound>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>
X-Mailer: aerc 0.21.0
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-7-dakr@kernel.org>
In-Reply-To: <20260427221155.2144848-7-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0682.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOAP265MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 32522f74-195d-44d5-aba5-08dea4b817ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|366016|1800799024|921020|22082099003|18002099003|56012099003|11006099003;
X-Microsoft-Antispam-Message-Info:
	jO9YDYLCpAR5AItHJhS6j87pvkzn51hAUCMIIg6aaUXiXBh4x6MaBKFCipMXFuEj3PpY41l2/KhB9CG7cffwuWB2HYBXH5NAWbfxYxwBbjARAeDLhKpKC/uh5Y41LUYz40sbSTZRQoa3isG+wigKBY0v0bIDsUUF3tM/HhRy2jvIisRIupoDhSE0LYbBx6NlnLkfxkne0icxqhwLeCtsAM0s51pwjhBqSZvxc9VYLokSg0A6PQ5pde6AxwFSaOtvouXF1tswx0ib/rzSNe/4jI2FkJCIcT2gpe3wrF1WQnOP7YXF4LNRZrv1WhrWYQHY/Z+2x5oYJzq0Sed8uhxPKbK7Z+vTqnGq+dSZpSgNdq1lOxWjM1cP56zmyuMVxtNU1vjU0MRWqvuERA8SYKQ/fzbOI2bmO3LS8z780mjSnsezno4Aq35E3J8eLUqcDC6Kt0NM+4Fvz/d1BkQwd9bHX+HxhJy7cikIDkh0yHE43HEWvlc/qIYZDXgx8AlsLoryq2wylaruvuA/aJ3HSmvOV4hefOMiun7mGhTvHcwoiVQ7f9LJ4W+Drbaa9jKdejZHTlqynqbCS1P3gmXCPulqyoVwYWcnDj1mBOH18ajr9Eei9sb4KzkRbwVh+QmEqeLzuFxhUe5VZC4flvemlAJHhsv9inS2rDHB16fXNvFj/ig4F2IbFaVGY3XD2pD4GUs8fP+E+pnfIQ+MueRPUYrtuKtSeFVHWFA9jkQkWNc+k28ry8Uj49pcqTv6+A2KWBMb+kqjUKOM5rdm/9kSzVy0mw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(366016)(1800799024)(921020)(22082099003)(18002099003)(56012099003)(11006099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUlEZDhkYXVxRCtycHFUNFFaSEdoRXVEdHB6ZDZzelFhNTVtdW82dVlHNEVC?=
 =?utf-8?B?OVVXUVpINXdSTjVyMFczSVpEZkhDaEZiRE9QTHBlNUdtWFZLNUowY1ZTbHhD?=
 =?utf-8?B?RnlyWk9jd2RwejRzWURjOEZsVHNHS3Z0Zm1xTERUZUd6VklNUGxjM294QURv?=
 =?utf-8?B?VjAvQld0cFBwUEN4ODJnK2pGVVdxQTRIZXQ2WGdWVkxXeGRvanE5ZnhNWnRJ?=
 =?utf-8?B?alJhV3pCMzJGYi9kSUpUNVVhOGtUa2d4LzJ6azZMSnRyZWt2MHNndGVnQXR3?=
 =?utf-8?B?L3FlZEpjQWVrSVB5T20vOU1PRHd5Wjg1SHhLZWJ1ZWhGby9qUFhkc2t1SXJu?=
 =?utf-8?B?NWxaVURkTG5qY0d1QkFKamVYRTV6cUptWGd3ZXJ0K3hoWGVVOTdJeEtSZ2hG?=
 =?utf-8?B?cXRFK3FOdmpzZFFkV2lNMWxCMDcrc0kxNkllRk9sUWJUa0F6OXprYUJxNzhW?=
 =?utf-8?B?d3VzdjM4RHZSaXFKNmloMFpnSTN3OERpVHlRc3Y0Z1djcDBLOHcvSm5JQVRQ?=
 =?utf-8?B?a0xLMEQrZ09oQXF4UlB5dm1sdzNoVEVqbU5iNEtmckhIWWoyUkJYbWRtTDhQ?=
 =?utf-8?B?aXJNam95YTF0N0RxMjFQTTd1LzZMalcrL0E3VmcxMEtreFdMNUFlRHZVQ2I4?=
 =?utf-8?B?NmhBZTBheWN2Z0VrT2ZDOWlWdmw5ZFArRDZSY3RWejhDWjczMTJOQjhEUlhS?=
 =?utf-8?B?RXp2ZTNLenpKeGRzNk8wVHlBMjZ3RUhHZ2IxM2U5WllLWCsybkZ6UDdFNENh?=
 =?utf-8?B?cHVQN2FSZUJpVjh6bVo0dG4xL01aWDBZdkF1cEg2akZBOGxkeUNtOGE2a0E0?=
 =?utf-8?B?QTBkaUhHNHVaRzFhT3N5N28yUkhBTVZhSVAybWNrYU1uTmRGWHoxa29VSGha?=
 =?utf-8?B?N0I1Y0h3Q215RmxpRWtraWxKRjFyaG00ZVRRWndlb3VzYW5Bc3NZZzFpUENV?=
 =?utf-8?B?YUJHQzY1aU9MaXJaaXY2K09ocDEybFdVeU1nK1hMY3p3Y3BVNlBLY2pOTnlS?=
 =?utf-8?B?ejZnVEh5MG1sNUlIVGU4ZlR2OFljZFVwa1psR2thNkQ0c0k5ejIvWnFjMXRN?=
 =?utf-8?B?VEgyQ3RTTWV0cDB6YXpwNm5JTDg1U3R1RHZlb2ZGYnBiaFZPaGRRTnhzcncv?=
 =?utf-8?B?OFVnV0d5QndjaytWZjVOQjlFVlR2ay84d0xJdGw2N1k4SXlMWnkveUtWV3p5?=
 =?utf-8?B?WmRkZVR3M0JHZmtXRGJ2aklWaDl1OHFpM3NISjgxOGo0MFRPRFo0N1FWZ1FW?=
 =?utf-8?B?cGVFYmlCNlZwdWRjZGNzeGpDZEozYWJ3ZVIwZEZKNlFyVEpPNU1qQTNjVkla?=
 =?utf-8?B?Q2JJcTk2SGtpbjYvenhNNmV3VUZhcFVTS0JyTlhRTDNjazJDbkVSKzZtK0F3?=
 =?utf-8?B?c0t3UlNGbU50UVFBMWZmY0pySU1RZnF5bEt5M0ZJcTBXUVFnSnkzOU41TkN1?=
 =?utf-8?B?Q2VyMXhyeVVmZG9DS3RoODRVam5nODFyNGZNYlJxby8rVnhFQko2cE54QUpk?=
 =?utf-8?B?aWIyWVR3aUljbmd1VlN6V0hGVDhvdjVheDFjNnlPcHFYdUovYW5JYUdzYXN0?=
 =?utf-8?B?QlJLZHBiQWZYdHpObXVnRnV4VnNDdTB1Rm4zdVEyeW5GdUNFQ2h3SW5QTlNO?=
 =?utf-8?B?UzlMbDVRZ1ZnYzFUTmUzdUFDSXBLdnBjaklpVU05RkVuaWprUVI0NGVmOG85?=
 =?utf-8?B?RGVVYVRKR0wyd1FKQWNpVmhrNHBsY2pjU3RLMzVQYlU4RXZoWmZaem01WHJX?=
 =?utf-8?B?Ykh1aEhQbm0xK1l2azBNSTRHSnZHRmNONjhTRG5Pbk05VkRYNW8wRUo3Mksv?=
 =?utf-8?B?SG56U1Uza29RaHVPN1ZXV2NQR0k1Z2JuNmFBVzMzTEQwdFVqcWt5SnJqejk3?=
 =?utf-8?B?eC9LSWlOWHZPNGdQRkJlWG5Tb2N3aUtXYTN4V3dFZCtlVmw0ZERkeUc5dHZX?=
 =?utf-8?B?czJOOXVTZUF4eGg5MVZiVE02SFE5VU9rMG9wY0xVNS9janRXYVFrTjlFSzlB?=
 =?utf-8?B?RGhTT1JXNCt4aXAwTjdzQTY5RE9vVGdUd05GVk8xVE80algvV2tZaXFZaVlI?=
 =?utf-8?B?dUJLYnQ4ZjE5YS9XYTVIQXF4V1ZZTWJnMEMzTnQzblcyS1dZeWQ0TktGdnZx?=
 =?utf-8?B?S0Z0NXBLcjB5aU9Md00rVjZPS25tSDd6Y0VEVEZ0WW1kZWtFWkV0T0ppTHRa?=
 =?utf-8?B?bW9YZjRWd3U3MzFWMVZjek5ydXRpa09HR0NKb3JuSitpUFBIZXlpTnpLTFVJ?=
 =?utf-8?B?bVN4Nlk1YTJNSXJHSlRvSUJhN3NsWTd3UWZEWWZzUHUreVZzUDFhZHBZVml4?=
 =?utf-8?B?aElwa2hXSXVOcnpUb1NscFFiMUg3SGQ1bUZKbUFQQlBHcEFhaVJJZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 32522f74-195d-44d5-aba5-08dea4b817ba
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 23:52:51.2830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uwze1aeEGIz7oMwCeSd6mAqMnsJsPaDxKAu1n94MyyEaSjtf2jYYXjY8mpqeG7aBdXKZtGpe6Dg3x7xiGmACKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB9000
X-Rspamd-Queue-Id: 51DDC47BF68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8729-lists,linux-pwm=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,garyguo.net:dkim,garyguo.net:mid]

On Mon Apr 27, 2026 at 11:11 PM BST, Danilo Krummrich wrote:
> Implement Sync for Device<Bound> in addition to Device<Normal>. The
> underlying struct pci_dev is the same; Bound is a zero-sized type-state
> marker that does not affect thread safety.
>
> This is needed for pci::Bar to hold &'a Device<Bound> (required for
> Bar::into_devres()) while remaining Send.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/pci.rs | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index fe5148f41d8b..6f82f2e6c74f 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -526,3 +526,7 @@ unsafe impl Send for Device {}
>  // SAFETY: `Device` can be shared among threads because all methods of `=
Device`
>  // (i.e. `Device<Normal>) are thread safe.
>  unsafe impl Sync for Device {}
> +
> +// SAFETY: Same as `Device<Normal>` -- the underlying `struct pci_dev` i=
s the same;
> +// `Bound` is a zero-sized type-state marker that does not affect thread=
 safety.
> +unsafe impl Sync for Device<device::Bound> {}

Given that you're now implementing for two ctx marker types, it might worth=
 changing
the existing one to spell out the `Normal` explicitly (also saves you from
having to spell it out in the comment).

It might also make sense to write a comment to say that why it's not the ca=
se
for `Device<Core>`.

Best,
Gary

