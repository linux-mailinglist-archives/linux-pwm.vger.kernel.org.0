Return-Path: <linux-pwm+bounces-9460-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n6OjEE9qQmq66gkAu9opvQ
	(envelope-from <linux-pwm+bounces-9460-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:51:27 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A66126DA8DF
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:51:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=Fx6A6qKP;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9460-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9460-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E2B43021655
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8ED3BB673;
	Mon, 29 Jun 2026 12:39:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021107.outbound.protection.outlook.com [52.101.95.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA2E308F39;
	Mon, 29 Jun 2026 12:39:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736746; cv=fail; b=sK77dCDiHUIcHHMknmye0bkh6ggI51IQxMJucgx5VVo3hKjYLviRrzDn/zQtNx3Hb4af6wyp8IhKCy6cEMEuPicSIm5tQgAi4iBUCyUwUJdBNjrniicaVhPeSlPL3ROBHfuF+TtxnNnFnNBh/G5id1MTk11SBJ0KlsS7IN9/ReA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736746; c=relaxed/simple;
	bh=eyxRcI5pMFmQoykWy6RhrZ/SVJPpuEjZLdiYAMfjHpI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=eY/JsbNbWLy25brHUtu09YRSJGxIGS5IlV/Rv7ZjrjvNswYNQg1gFLuPtCVBs9ZZfTYxsx0hRSIHwps7Znq5k+xtJSGfMngU9G4DQegBOTzVWGX5lBUbN6Mlll/n/Jzf13L8k4ZmvlIoxoM/lWMD6D5PlN34ZcrPuZwKpFtDX9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Fx6A6qKP; arc=fail smtp.client-ip=52.101.95.107
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZJWGxfIn2TIlQkFiPsRK9fKW1nvy+MXf4XkhitMZQQQ6pDoqj9QNGp6JS11sBC/4/ys5K2H9KUvifffCTfxcNaFNPjfwGIJHn1Yn2v9k7yOwB+jvCtQNAlB3tHg9ZVgZE/4R+x3Qs117bF7+C1KO95Zd/Q4F+Xcpb+9HTVr7yilX3TOw1Em1tu0Bq0Yyqkj0XGo04L/wZgavm11PnKMTMZakUsTeqlDKNlH+J1yb3o7YDMjxiOoo8ojnTIYOcPUC3OylKbI/CIKNWEGCA4UUPZTAV81ZyA7E5TBmbd/MBqrE8DcbsrSgd8BYF1MltASbT8eQ83N5mubz/+itmLJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jva0V0eHXTbPEJadCm0HprsX7icBHYUu5vvJz0jfINo=;
 b=s+ovlkIh6XpEE8Gs5Cg+NxGchrpZwDItO9yZ74nH8WiaRKgxTfk8Pg/7WNZmEBhvfkpncyFyGW0xBuUeK4EKX7tqTi3M1ZwrptUqMWgalUQ4AFLSHVE5kx5QPvcyDjhP7QCfW0SGqfAELOjBOvYrkKO7aXSmdvCtxg0Tq/qtWZknDjI7S5TLFwFhpNo+r5fKzeu98RGIKDevS+iHxo5MUOmtQ/08VrjGGqiCIo1SIqETe360TlCeTvvH5vbg7lec0cGaXImrqwOUQUz9h5aArOm6n3wMyQEBF7eNA4aZnqYFhrtPcMeDE7qzrvIlhr8OYIiGOF0vmRBmrlPEQ1h+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jva0V0eHXTbPEJadCm0HprsX7icBHYUu5vvJz0jfINo=;
 b=Fx6A6qKPLKd2lseMpAP4x5ty+rB+mpr4VBpdfdMXC6Iz4BlHzANRW6fEzAS8YwPHLTqAYFefvjJMxYSVl287ivsN0WPZGKT+5+4q5kKOu7WhcQ2AneKOSj5UWJGzD7YEy2rUtc0tt6AnuCJQM2XVq8arGU8fxFOJ0/w85MC2/Eo=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3419.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:169::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:39:00 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:39:00 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v2 00/12] rust: driver: use pointers instead of indices for
 ID info
Date: Mon, 29 Jun 2026 13:38:45 +0100
Message-Id: <20260629-id_info-v2-0-95a18280fe30@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFVnQmoC/z2NwQ6CMBAFf4Xs2RpapYIn/8MQU8sW1kNL2kIkp
 P9uwehxknnzVgjoCQNcixU8zhTI2QziUIAelO2RUZcZRClkKbnI+CBrHBMn1Op8EVp3NWR79Gj
 ovZfu7ZfD9Hyhjtt8MwYK0fllv5r55v2q9b86c1ayRirDsaoaNM2tV37pJ3e0GKFNKX0ANymuF
 bIAAAA=
X-Change-ID: 20260612-id_info-23eca472ccd8
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Dave Ertman <david.m.ertman@intel.com>, 
 Ira Weiny <iweiny@kernel.org>, Leon Romanovsky <leon@kernel.org>, 
 Len Brown <lenb@kernel.org>, Igor Korotin <igor.korotin@linux.dev>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782736739; l=3211;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=eyxRcI5pMFmQoykWy6RhrZ/SVJPpuEjZLdiYAMfjHpI=;
 b=VL0CMJz4NUNtBgITBpeHOPVvHqccqaKfYjuipo2GbdgPfjC1TKyq/AvafSDZXfrLB+uF2oxir
 Cb2+QiQm0zzBxWjLJKwa3gWmmy+VQ/Xzq3F6eIxiVLVVbsT3/y1n2zO
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0250.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB3419:EE_
X-MS-Office365-Filtering-Correlation-Id: 6133f5bc-61fe-40c0-b59b-08ded5db64c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|3023799007|6133799003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	0bztWGdmR+JnpVmYf3If8z7x9ENWak2y5rvN4VVULL+3MirqR/g3DO4zTWOHELMhhzXZHRYeBL412k4MdeZkGbymkygXu0/c6epY+Mtj+mVD/cmviHHOSyIM0G+ir/xCRzXVtqs30apQb93qVfcIuAmrZ/0nUSYX+cF7hUIiSQFJUEi1js9uVDaC5ZVXeX32257cFbmaor/cmuzGwVWQtjq4Z9p+DVOGuuKVwvDuPA/43j9yR23MbBCVe7R9ObXb5rkv7GBvP2DNfY7XPOTXLeor6Oysj+XS15MQU3xCExJvbmggmQa+n7ioNAuEpTEmqcaDPs5YOUEdrszymzIUx4ykzobhSSUAJBJayw6QhrmK9OK1UPgSd77LVqwBTJ06o9xx22zz8JWaesYX6+x7qAwXoBD0aJWZjakxuDloMY5wrSy/Mvm7oT2IZnjAqPXz3YV/AB+AvY03IU9LSkEvHd+TXrCHjMz186vQcBatniEkBv50ba0vqIXAgBWO3M+IWsTaa9jgP1du45Z0+GRmMkkfF9epFi45QZeouV4ZvCIdUn38VDNIX5wd7o6n78H0cafWWDZ7xOPUHMDd1uXXleqqOCj2uxoT1TxWrO26EOR0QmbzxHZTRVeTW3Pn+8WwPd7tJjJHqhf/oNFqgYNp3hd314AtXsX8lETvGaxziCQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnVqOWJKS3AyMldST0twWUNVOWNUNE1Xamh5bVJnZVlrSENJU05DcHI4UjJo?=
 =?utf-8?B?bnhOSWExNHUvRnkzc2ZiRk15WG50aW1BNk1sSldyd3Y3WTNiZUNEajVqRFFl?=
 =?utf-8?B?V05NeUtacWlPZmNXVDVENnJTQ0JQNk1yS0tsVVY2VVJacFNuQUorS0JNRW9y?=
 =?utf-8?B?bUQwSjNYV2tFekZDV3ZWVmpOOWh1QWJHN1hoWFNORFhGYnVTT2tSL29RQ1M2?=
 =?utf-8?B?Wm8vR0V6cnlGMVk4VkwrK1ZvZlNoTFhGVkpNRGhHRXY0eXFnR2tXbktVdjRp?=
 =?utf-8?B?SmpzQ0RLSnQ2VU96S0x3VUY1bGVzT3Y3NCtHL2lvdW9wbkdtSEdsZzBqUkd0?=
 =?utf-8?B?OGFzTTlJeG5yWUJBUTVuWUFOTmg2aGIxZDFYTzhlM0RjcjByS1pFVHFxS2Ro?=
 =?utf-8?B?ZXV2ZURRN2Z2azl1Y3JiL1YrSndPLzUzNmRlVUlCSW1tQVNqeStoZENEcGlF?=
 =?utf-8?B?eFRYd1Zlc29xKzBsQ0MzL2pVbGIzT2padFZXbWpsN0QvcHBWMXpDMDNNdGo1?=
 =?utf-8?B?VE0wL3dDNno4L20zRjlLL29YSFB4TDc1SWFLWHByYjh5amFnT0pRek1ocWNL?=
 =?utf-8?B?YTVPZXBFeE1xbGFScEswMFdrQnBqWUNoQ1ZaajdGUmpIZ3VjVzQ0MGlRdUli?=
 =?utf-8?B?VFJpdWFhay8vc21WNUNCeHRyTEVyeGp6STJjMlJZWG05Y3g4MXdIaXpwS2d0?=
 =?utf-8?B?TGtFeGJzT3RhOGN3VVgxZFlhY0xnZi9FZnRiK1F6UGxaVjFWdnYvSkExQTV2?=
 =?utf-8?B?NWpmSGFWVTl3YWxPd3VLdklBWVZ1TUVhbjl1RG1WOC8rSmFSOVJjT09CRHlP?=
 =?utf-8?B?dkVGNmFtYlNHR29NN0Q4MXJYbEhYVXd1Wlk0VEpYQkMyT0J5RkI0ZmsrSDIz?=
 =?utf-8?B?WnZhMmN2YVc3SU9hTUVaTWFCOW8vN3RrMlVwNXNjNmt0andJWjBKOWphV3oy?=
 =?utf-8?B?R1JHOGlKMXdMUk9sY2dlZWJlSjVrR1FPb0J0WWRYbXVJbnZZWkpUNzZyMjQx?=
 =?utf-8?B?KzBMendTek1BNVRTR3FlMThUVk1VZkNDSkk1K05xMkk5WTRPZ1VvdHNnNktm?=
 =?utf-8?B?aTlvclByMElQN29kWUtvQWhSZnNINUlJOVUzZ0ZTb1pEemp6Q2pyb1VRQlM5?=
 =?utf-8?B?a204c3ZmQTA5dnlqWlZBc0VkTUlKTmlBOGxHL1g0UDZLT2tCamhKaUJvZWt2?=
 =?utf-8?B?QXdNcjlXNWVOZ1RpcnAzcWFhekxCemZrU1ZYZHo0OGZyNC95TXFHcnNTNEti?=
 =?utf-8?B?QUtIdlpiOGNpVm5BTmIreGtZV0dCblRJVzYzVXl1cUZmVjArVklaclFSSkYy?=
 =?utf-8?B?Q2xOTTk1UG9vM25aK0kxTEo1Vmk0VWFXeTJsWHhuWUczdG9DWFdFZzFDZ05W?=
 =?utf-8?B?R2xXd0FqMXRrcGNpeXArTktpdCtSQ3ZTNDR5dk1LYVZueEcvQkpiYWpaQUJz?=
 =?utf-8?B?TkxPWHFtWG15YzV2T2tjUUdJRnBHT1c5NTlSVUo3UTZ1b29EaFpHMGVFb0Nl?=
 =?utf-8?B?QlV0ajhtaldvQ2NUakEzUStpb0QvRmxhenphdDB5R1hzeXQ4Z0ZsVUdVb0ZK?=
 =?utf-8?B?WDZWTkZkUVBSSU4xcG1BeVFMOUlOK1FsdnpESnoxeDh1dlZ0elJkMTdRN1NG?=
 =?utf-8?B?bnkxYldXTWNadE5XWWNFUmtyUnlGY3BxY3hibEdDY0w5bmltVHpxSHVMZXJC?=
 =?utf-8?B?ZWRwYTE4Q1BzWXZPV25ic3ZNZ0djOS81NVlwdXk5N3A4U1JGbzYwMlpQMURz?=
 =?utf-8?B?ZjFtZmRzZGFlZGozckZmcis3aVBQWTArT09Rc09tVlRNZ0hBL0NUS2Z5MytK?=
 =?utf-8?B?V2drOU8wOGt0bks0TWlmTUljdmZHWUQzWnBSTUZJWmZnQUJsMzVIS3BEdlpv?=
 =?utf-8?B?aGhxZ0h0enNDZnNuQUkvckcwWS9xcEZ6dy9kVmxycjZjNEk5UGJjc2dLODJx?=
 =?utf-8?B?Qm5aMllRUzUzZ0YrWXh3S1ZiZkVVT3gxWGV2Rm1Fa1FrSXVLK29VejZWU1JK?=
 =?utf-8?B?a00xazdIK2VoUlNMVW5Ca0xYTTBwUWxhL2ozRkNuUVRiMWRLOG5RbXpoYWJi?=
 =?utf-8?B?MlFMRUxvMy9hbVMyQnlTT2FCT2lBTkRucjBSUWN4K2hTUFplcTBXSGJIdUln?=
 =?utf-8?B?TmVBMitRYlo2Z0tjQUppeGN1ZkNJOVJ0SGVwaC9YUnA4SW1XS2dsY24zdGlo?=
 =?utf-8?B?ZllHekdZTEZxU2doRWF4UGpKRFlYRTEzMDBJMlF1NzRiWVhSQ3pidEVkbHBw?=
 =?utf-8?B?MWRxRjc4Y2JaMzJKZlIza08wVjkxZE5HTStSS1NhOXdFekFTV1hzOWl6eWo4?=
 =?utf-8?B?RW5KKy9ONnljWkh5WWprbTE1d1ZkTVAzbzc4RjZmcHE5MGJGSklQdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6133f5bc-61fe-40c0-b59b-08ded5db64c3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:38:59.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ea0KyofB5JIBqGazUo2lWyvcD9OrjZsiWr0vabvk682soIfHOKXFkxTngclOBzKsXKYpVhIvg8Msmn25fHlQXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3419
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
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9460-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,gmail.com,ffwll.ch,arm.com,intel.com,linux.dev,linaro.org,samsung.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fujita.tomonori@gmail.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:david.m.ertman@intel.com,m:iweiny@kernel.org,m:leon@kernel.org,m:lenb@kernel.org,m:igor.korotin@linux.dev,m:robh@kernel.org,m:saravanak@kernel.org,m:viresh.kumar@linaro.org,m:m.wilczynski@samsung.com,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pci@vger.kernel.org,m:lin
 ux-acpi@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:linux-usb@vger.kernel.org,m:gary@garyguo.net,m:fujitatomonori@gmail.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A66126DA8DF

Most C drivers use a pointer (and cast to kernel_ulong_t) for driver_data
fields in device_id. Rust code currently does not do this, but rather use
indices. These indices then needs to be translated to `&IdInfo` separately
and this is by a side table.

This leads to open-coded ACPI/OF handling in driver.rs, which is not
desirable. Convert the code to use pointers (or rather, static references)
instead.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Changes in v2:
- Change USB to take `Option<&IdInfo>` in addition to PCI due to ability to
  dynamically add IDs.
- Mention dyn IDs and driver_override in safety comments and justify why
  they're correct.
- Link to v1: https://patch.msgid.link/20260618-id_info-v1-0-96af1e559ef9@garyguo.net

---
Gary Guo (12):
      rust: driver: remove `IdTable::id`
      rust: driver: simplify `IdArray::new_without_index`
      rust: pci: use `Option<&IdInfo>` for device ID info
      rust: usb: use `Option<&IdInfo>` for device ID info
      rust: net/phy: remove expansion from doc
      rust: driver: centralize device ID handling
      rust: driver: remove `$module_table_name` from `module_device_table`
      rust: driver: store pointers in `DeviceId`
      rust: driver: remove open-coded matching logic
      rust: driver: remove duplicate ID table
      RFC: rust: driver: support map-like syntax for ID table
      pci: fix UAF when probe runs concurrent to dyn ID removal

 MAINTAINERS                           |   1 -
 drivers/acpi/bus.c                    |   6 +-
 drivers/cpufreq/rcpufreq_dt.rs        |   1 -
 drivers/gpu/drm/nova/driver.rs        |   1 -
 drivers/gpu/drm/tyr/driver.rs         |   1 -
 drivers/gpu/nova-core/driver.rs       |   3 +-
 drivers/pci/pci-driver.c              |  64 +++++------
 drivers/pwm/pwm_th1520.rs             |   1 -
 include/acpi/acpi_bus.h               |  11 --
 rust/helpers/acpi.c                   |  16 ---
 rust/helpers/helpers.c                |   1 -
 rust/kernel/acpi.rs                   |  14 +--
 rust/kernel/auxiliary.rs              |  18 +--
 rust/kernel/device_id.rs              | 207 +++++++++++++++++++---------------
 rust/kernel/driver.rs                 | 137 ++--------------------
 rust/kernel/i2c.rs                    |  26 ++---
 rust/kernel/net/phy.rs                |  66 +----------
 rust/kernel/of.rs                     |  14 +--
 rust/kernel/pci.rs                    |  25 ++--
 rust/kernel/platform.rs               |   5 +-
 rust/kernel/usb.rs                    |  24 ++--
 samples/rust/rust_debugfs.rs          |   1 -
 samples/rust/rust_dma.rs              |   3 +-
 samples/rust/rust_driver_auxiliary.rs |   4 +-
 samples/rust/rust_driver_i2c.rs       |   3 -
 samples/rust/rust_driver_pci.rs       |  11 +-
 samples/rust/rust_driver_platform.rs  |   2 -
 samples/rust/rust_driver_usb.rs       |   3 +-
 samples/rust/rust_i2c_client.rs       |   2 -
 samples/rust/rust_soc.rs              |   2 -
 30 files changed, 209 insertions(+), 464 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260612-id_info-23eca472ccd8

Best regards,
--  
Gary Guo <gary@garyguo.net>


