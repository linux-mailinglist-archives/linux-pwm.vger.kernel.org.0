Return-Path: <linux-pwm+bounces-9414-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c1GxH9GRPmrEIAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9414-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:50:57 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEBF6CE22C
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:50:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=FPkNh4ca;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9414-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9414-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16A3230E9B76
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1912B3FD159;
	Fri, 26 Jun 2026 14:45:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020077.outbound.protection.outlook.com [52.101.195.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296CB3FBB5A;
	Fri, 26 Jun 2026 14:45:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485147; cv=fail; b=bWJ3am9KQweklGifl1oJ1Ae+IfzYkT3st1Ig+19VWRS0Y/ifHoxDOQMTOvb948XmwEzRUFsHBQ/cJEYETTYctdarVfEUMoYLe+kd2uyqUSgOdR85H23UFy6ve5YjjXb7Fp3ysX1auQ+VIH+5xdqgSjSzkZKKp0Az+RH4SFaUQCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485147; c=relaxed/simple;
	bh=mJHCR4r5VXB1GWzKVWNS7gm/0MLNoE6DH8BPQW866J8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NPxELlA0IazAeHXxYBvBCt8VlY6MJvY3i96aDtEVOe9WQ3nVGPOY3EBZPK1lpAwifWM180t/wZLJgiETr2cqHDJI+DelrUsatHqCFq3RltQmuwBaTeLVdfVWgTuFIp4/rYEW+5DodvVuHQ5eL4RWWAsg24lnREUHcl4oGdMFnWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FPkNh4ca; arc=fail smtp.client-ip=52.101.195.77
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLbyHlCKtZLc2M9QdrDSP9a7v+wSqLCyQQgh8TIKCDVIvE3vgzwa/mQC1qSO3nywEfWy2qaJvjWEA5bVSepe9jkmXtngOx1q5QvNS++Q5hjArVqg/feQQ8M0Ixi6TW3shYxWAyNB4iro7IXATMX3xhzB236pkiurj6srj+xOur4OXEyt6d2gggYNHwGDJ0OIgED0xI5HhN88s56g2DxtAC84tsuuXURHN/HNZTBQqx4T5LlGeNII5ZzSQKC0MuB6RV+p2bwYfxXtZrq0vzdrwDynbz80ElASRaODLjmmxJ5KQiBeKYXhBAuGCWGqF2i7PPyV6j/otV/r/EuDEWGwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GYfeCL1vcP7b/80s97P05/yaKN4CE2PVWQBlpuVbHE=;
 b=pp9/efkZTMjhyzpuKBUT86oZfuOUs72ue4WzCtJPubdff4gwYaa8DjmVOSJ8RW11VUEW6eV1dFCuCV94BlTKV7BCjnAvAFdithqwxtcw4kJln7VFa0Jbzqr6CoR2ExKqskaBm4CfPcICSKrKugu2LB7VJwlibuesZZW/RFLjbA8kUZZXwLOuBhGSCOdZ5SRkxABN7mDtAszpMIyavEbJrZ8hyDZFIuAE+gpuEArhQlUoBeNSTVpl09bAK3fT3sYPMmlVDDbGbORjtPg0G9fURLSiKdi4n6jT30Qk5dyijQvqIgC/EYaoONu/UrAr5rYMYlPg3OvsQP/v4EG6vfQ+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GYfeCL1vcP7b/80s97P05/yaKN4CE2PVWQBlpuVbHE=;
 b=FPkNh4caNDgtDqMOS6Q/J+Ar/eUd7uPlxtxIaluSDW3Tf6y53bKLaWi9a3LL2V3weN1mTQAhQHYc5DCd4szbRykJr0VNAXuRwkVahiYaWyShaIcDlqgbZM82/SxqcbBYmU/r+ZuR88dJOJ4sSrp7sWf2v8F8N8t6b2HRS/hW+Kk=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2694.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:24 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:24 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:18 +0100
Subject: [PATCH v5 14/20] rust: io: add I/O backend for system memory with
 volatile access
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-14-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, 
 Laura Nao <laura.nao@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=5302;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=8W9y9DrpwlwnkHeO/rH/iGKPpeFRxr3aT64tjmYoGsU=;
 b=vyKljdPZLudlhSYkvLZp4CduRkmebsPy++TgZ4wLKiBLPyw6VO/m41GobfMcjD0lzPS5EffAK
 /eojQSvl4IYCzi378hE4QsUJnNMhNtGt21/PnCVRv7LHs4b3xnUehqr
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2694:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d2ecc5-8e11-48b0-9a7c-08ded3918e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|921020|18002099003|5023799004|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	zdEuxhjQ0eRx2HudU2YmrkgS6caYQ+ywm1f4CiunL352gzn/3+kApfNU86UpVSiufWPZ1+REZNHXM9zS5RvC8orIT44sbhf2ZplFzUkwxYGvR2mqcmBmIdlUCJfakJrMpowFtNaByhF5lsDjASng7xWeR5YVepeDTWenBvCim914xkyHBrhEMjCk+SubBjR+W3DR00MZhgQur9u8ayo8hkcHwBaLKJ6Hi8P+fU9kXyhebeT/SJxpl6swbbl/zXs+1c9X1mfhBqK7+2fdh86hwPdlRv/nAVL+CFRZa+6LuXkVHAht8wPnuPs6OnZpNCOYT5gSASm9wfDNH2zDrp2axxf2djOhLjkt0Qj5cRAomotkaZvnkOgBwUo89QWhvTtLsKVRe1/S8WIO+i31XmFgvTylQ792bLy9vCZUUmV5AFhaiOJkUA0/ykmihUiL1qXLk/94d+INCdwnkkj1JMgozYDMnrzjtyNdkkJ7S30rs7NZcuD5bUoOkkIofWayYfOB0elFpp8oZVH7nj2j2iUszVkid6rln6rkDNoSk3aj8QoAIX1Cg39ThASb9c6OOqvt2n3RJuGlGoBVwTI9JnVsJr597bdWDXL7u6SfUXOxXOO6vRTAW8KcP/cEK00y6JvTs7H8AbLTu1yBapH2pQVKnaiGIESk/bvphy1Hkw9GF4QckpU1tsAK3XZxNWX48cruXkjRq4JLipJKueQ+1jXfTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(921020)(18002099003)(5023799004)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVEzYVZJeFJ2bE9YNkZCMlBOOE1sQ0xTZHpWNlFsTkU1WmdHcnZPRGcvUFpy?=
 =?utf-8?B?ZzQxVkVsUjB6SkNVZDM3L3ZMa2ptdWE3eWUwZHJacWE4OUxxQndSWVVGcldH?=
 =?utf-8?B?UVFhWnk0a05BSjNobWQ2RlVKdm5KbEtuRkdabFVBTHVYaE1xQXNTV0hyNFEw?=
 =?utf-8?B?L1hlSVp6M0d4eUp5SC8xQ2Rxc1liTXl1Y3pRSms2OVIvdXpKdlNDMERjNVIw?=
 =?utf-8?B?VGtvVERobzlmZTVqZnVFMnhTekVrSmxKWXRwb2ljWFNvSjRMSG1FN1dRczA3?=
 =?utf-8?B?bVJJY1FvbEJNVWZ4d2VEVWFOTmxiRHdlTGphSTRhYXoyUzhoRm56cFB4L2VW?=
 =?utf-8?B?OUNtZGE3MEltOWM4U0JlV3YwMThkWjlUdnp4dkxpZ2xUUHdHRklqWlBKcUZr?=
 =?utf-8?B?aTVORk55a1EvOFc5NzhMSTJ4QTNmK2QyN0NCSVh0UDlRZlhDcFZaYU93NTU5?=
 =?utf-8?B?Q3FZZHNPUUg0UkM0VmkxRXlXMUZ3WSswOXVvSG0yWWw2LzdGN2Z0MDNFcm51?=
 =?utf-8?B?Wld5Nm55OGFGRHprNWxHN3ZzYmhvdml3d3dGNzZXai9KdFRLc3krYVRONXN2?=
 =?utf-8?B?cW9JTWJLQzRuS0g5OW11RWNVWW9JVTNYbGo3M1h4bWFpcEFtd1VMK0VnejJr?=
 =?utf-8?B?ZGFoZk9ab29EN25JYWxzSm9ybXhnaFNJMFJWNGpvb0xrVTkrQ1F4aERKVEg5?=
 =?utf-8?B?b1ptMDRUbFlHbmVVY1U5eEcrL0crVDlCbXduZ2M0MlNzdWtraTk4V1I2QmZa?=
 =?utf-8?B?Y3NTQVdoVlZ0aDd5RXk0NUVMQUxraEVEMkQ1cXhsUFQrTWF5ZEpqd2ZpTHVJ?=
 =?utf-8?B?UnRwOTlLUkYvZnExd0VwMDVKOFVlNWI3TVZ4UFpqMnV1bXk2anJEQjhocWhs?=
 =?utf-8?B?OEtFR2VGSEdiU21FMkFsM1ZrTDl3MHczemRScWhEKzNrYVN4eUs4TTJYcHk4?=
 =?utf-8?B?dDZTY2QxUnZNbUEyVzBsa1dPMmVqdVR4OVF2KysyQzJ5Z0Z6ZGJPcGVSNXdt?=
 =?utf-8?B?d0pkcDh6VGp6WTNhQWtRb1EzNUhDNUNVZG9sNWJ3YTRsZXhZL21SczlaZGQ0?=
 =?utf-8?B?cy94VjJUY20rWnlSTHFzZDdkVS9iVGRsLzBHZENxUzJOK3BrQ09lYUNJSzZD?=
 =?utf-8?B?cDNqVVZ2L0sreGlrWThGTm52Q3Y4cUJnRFRQSG5BOG01VjhLczZrNCtoTzFO?=
 =?utf-8?B?ZzR4NU1UMWFsZ25UOFBBRitNekY5eTd1RlR6dUFWU3VDaWQvbkowdERMNTFm?=
 =?utf-8?B?VEloaXBHRmIwZDA1OHZxQkVpeGlDVjhDWG5Eby92cVorL250bVVoN1RxYng1?=
 =?utf-8?B?d2pka1FuUWxzanJGSVRaZWhKUFdud3l1bzdlcDRsL3NmWmIxL0tPVDY4NERN?=
 =?utf-8?B?aUl6VExGTDJ0VTNIQ3o2a01MOUxJM3B0dCtKQW1FNG13eEJMdTViT1lqWXFj?=
 =?utf-8?B?SzAxL2xXRkw3NW5hSVVpSm9Da0VQTkNLajZmSFhSald6Vmh5V2hPS3grdTBZ?=
 =?utf-8?B?ZlE5cHNCUll2cCtBekJLZ3NDaTVCZm51cVMvQlpJUzFMaXd1NURSQVVNQnNB?=
 =?utf-8?B?YmZRbll3a2lwcENuV0liaHkxWGlQeTJhTDE4YnRiZnRTSklocVovSDB0Y2hy?=
 =?utf-8?B?SEd6U2NsZGJoelB2TlgrWmJVTTBiczJpcWgxc2RYVXR4bjFBZ1VkQnp2TzRY?=
 =?utf-8?B?bkEvQmVFNXNZb0tCS3Fycm1FVlNkR1M0cGk2K21vMjZQK0FWY0UxTkxSNDMw?=
 =?utf-8?B?RC9SS0VLclVpWmcyRXVMZlV1cm5PQktpb1FkdHNySVZVL2R3UTJWeTh6Ulhu?=
 =?utf-8?B?MDJna0l3OWRLQkNhVDR6MVlwcndIaUhPelpOY2NncThEZ2FRUmE4b1NkUVY0?=
 =?utf-8?B?R25OTG4yVncxNG93WFB6YkVjUTQxQUNyVDd3OFhtZU1mcC8yWDRFdnFvbFFu?=
 =?utf-8?B?MHRtZlFvakFFcGd2UkplMDBzMG1IdCttSFc4N3dzV1EydTEybTNpUmdLTHBx?=
 =?utf-8?B?Z1ZjV0V5TEFhYTFZZnBMNE9JM1ZjMmlaS0lvczFROThCdUp3ZzQvMldqNUdh?=
 =?utf-8?B?UGlLQjJobVVkVnFBQlBzOXQ2U21tcGsvWVd0Rjc4L0k4VTdRelJaRlMyRWRp?=
 =?utf-8?B?a0UzKzlCV0s5T0p0ZnFWRUlTVE9GZm5VSjJSU1YwbnVrQXJEOUJZcnlRNlc5?=
 =?utf-8?B?UW0yblZRVUNHYWpVQ283QXF0eDRjOHFXNmZWSkMrdjFoeFdxaFhSVWdydGZD?=
 =?utf-8?B?WTBiblk3R05ZcnBjR2dWNmtsTnNJTHlab21oZkFiaDFNa3E0OU5RQVpzeFA5?=
 =?utf-8?B?MHM2MjJtRkhmNTc3MmhEbnA0cE94bVpEWEdueDVJc3BXTjNUTG45QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d2ecc5-8e11-48b0-9a7c-08ded3918e1c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:24.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ENygNhqZ7N5P4jBVGlbmLSb5r9Obw48dH36/2UDwcfpphGkoX2FG5wF3+76N1NQnAcnxagYW6wa/fb7V1PVcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2694
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9414-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:laura.nao@collabora.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,collabora.com:email,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDEBF6CE22C

From: Laura Nao <laura.nao@collabora.com>

Add `SysMem`, an `Io` trait implementation for kernel virtual address
ranges. It uses volatile accessors to provide safe access to shared
memory that may be concurrently accessed by external hardware. Implement
`IoCapable` for `u8`, `u16`, `u32`, and `u64` (for 64-bit system).

This can be used for instead of `Coherent` for cases where a different
layer takes care of mapping the system memory to the device (e.g. dma-buf
or GPUVM).

Signed-off-by: Laura Nao <laura.nao@collabora.com>
[ Rebased and adapted on top of I/O rework. - Gary ]
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 96962498af77..5c06785facea 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1034,6 +1034,128 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_relaxed);
 
+/// I/O Backend for system memory.
+pub struct SysMemBackend;
+
+impl IoBackend for SysMemBackend {
+    type View<'a, T: ?Sized + KnownSize> = SysMem<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        view.ptr
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        _view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // INVARIANT: Per safety requirement, `ptr` is projection from `view`, so it is also a valid
+        // kernel accessible memory region.
+        SysMem {
+            ptr,
+            phantom: PhantomData,
+        }
+    }
+}
+
+/// Implements [`IoCapable`] on `SysMemBackend` for `$ty` using `read_volatile` and
+/// `write_volatile`.
+macro_rules! impl_sysmem_io_capable {
+    ($ty:ty) => {
+        impl IoCapable<$ty> for SysMemBackend {
+            #[inline]
+            fn io_read(view: SysMem<'_, $ty>) -> $ty {
+                // SAFETY:
+                // - Per type invariant, `ptr` is valid and aligned.
+                // - Using read_volatile() here so that race with hardware is well-defined.
+                // - Using read_volatile() here is not sound if it races with other CPU per Rust
+                //   rules, but this is allowed per LKMM.
+                // - The macro is only used on primitives so all bit patterns are valid.
+                unsafe { view.ptr.read_volatile() }
+            }
+
+            #[inline]
+            fn io_write(view: SysMem<'_, $ty>, value: $ty) {
+                // SAFETY:
+                // - Per type invariant, `ptr` is valid and aligned.
+                // - Using write_volatile() here so that race with hardware is well-defined.
+                // - Using write_volatile() here is not sound if it races with other CPU per Rust
+                //   rules, but this is allowed per LKMM.
+                unsafe { view.ptr.write_volatile(value) }
+            }
+        }
+    };
+}
+
+impl_sysmem_io_capable!(u8);
+impl_sysmem_io_capable!(u16);
+impl_sysmem_io_capable!(u32);
+#[cfg(CONFIG_64BIT)]
+impl_sysmem_io_capable!(u64);
+
+/// System memory region.
+///
+/// Provides `Io` trait implementation for kernel virtual address ranges,
+/// using volatile read/write to safely access shared memory that may be
+/// concurrently accessed by external hardware.
+///
+/// # Invariants
+///
+/// `self.ptr.addr() .. self.ptr.addr() + KnownSize::size(self.ptr)` is valid and aligned kernel
+/// accessible memory region for the lifetime `'a`.
+pub struct SysMem<'a, T: ?Sized> {
+    ptr: *mut T,
+    phantom: PhantomData<&'a ()>,
+}
+
+impl<T: ?Sized> Copy for SysMem<'_, T> {}
+impl<T: ?Sized> Clone for SysMem<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+// SAFETY: `SysMem<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Send for SysMem<'_, T> {}
+
+// SAFETY: `SysMem<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Sync for SysMem<'_, T> {}
+
+impl<'a, T: ?Sized> SysMem<'a, T> {
+    /// Create a `SysMem` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr.addr() .. ptr.addr() + KnownSize::size(ptr)` must be valid and aligned kernel
+    /// accessible memory region for the lifetime `'a`.
+    #[inline]
+    pub unsafe fn new(ptr: *mut T) -> Self {
+        // INVARIANT: Per safety requirement.
+        Self {
+            ptr,
+            phantom: PhantomData,
+        }
+    }
+
+    /// Obtain the raw pointer to the memory.
+    #[inline]
+    pub fn as_ptr(self) -> *mut T {
+        self.ptr
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for SysMem<'a, T> {
+    type Backend = SysMemBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target> {
+        self
+    }
+}
+
 // This helper turns associated functions to methods so it can be invoked in macro.
 // Used by `io_project!()` only.
 #[doc(hidden)]

-- 
2.54.0


