Return-Path: <linux-pwm+bounces-9032-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMUfGx6ADWosyAUAu9opvQ
	(envelope-from <linux-pwm+bounces-9032-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2026 11:34:22 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D80CB58AD79
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2026 11:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E5A6300E166
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2026 09:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0893C5DBE;
	Wed, 20 May 2026 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SxcSqpdP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022131.outbound.protection.outlook.com [52.101.96.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45C3A4F51;
	Wed, 20 May 2026 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779269652; cv=fail; b=bZMaryHcTKfFD1oUBNb6/PuDeEpOetyzLCSnS1qrlyGbPKwTa/nZpfnaYdwif82Oq6qKYFWYrDxhnoUuogDJakm54ARcezK6p6tVETSLQJlKhB/7fwy9JXMx2euGAwFhTgZIgoLnwTqUlEUaWKKvSeQOxZJrcbgleWduxU11G/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779269652; c=relaxed/simple;
	bh=1SZc4MsHZUB2+8hgr9+2XRvygdt9G/Vd1ZsbsE7Cqt8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Qd2HL8Kr72BQT2oYyy7HenmNo/fxXaRmDSKTpQXGq3U0xv6P4ttN1WqAydUz18eq47nPw0469RlHIh9iJUsnLMSw5sTAECGQNUshVMa6AYgPMVFDc4jXUZygxNSeKVEbYIlLdIwYZviaHP1EBEcXQmZBl9UbsSSkas6/1lFXHS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SxcSqpdP; arc=fail smtp.client-ip=52.101.96.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpADTVA74BEL3eu9bacwgSrJjIy6OEguFEyzL6EJQ9eTlJJvMX0PXj+3RSHPiwB+EoZ4sLdKvJ/IUbeNouOrWGFskKKHNTKv+Se7JqaKqTSZBx0Cf97W68/C96U8pMD4PT5VT8ky2xb0kSz8meax7oRkNjzi0u5/Avi01gg5L3kpbzZPP0iuSNaFwtpc5JeTRvUQxO5Hl6go8m2H31kdtf83lyaOxTVUtFfAwuQS0X9ShryooApzI34dEzcd0PFkndKYjEeZFUNt9W3vK5RbkoFQ1iQ8snm3V3RWL+xTKmQk/EMzc+oIgEZZsZjbH6jpHWlet78vZRz74ArBgmQpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLGcgB8nBpYfFOUPbPBvDqqhdb2KEo5KI2QMkoeuniA=;
 b=zHWduLrPepC4u0vtFLcX+ZR2bfbO9/TqGTin8HM4sBsf3oU39iGz7yIT3pfy68i/Cf4LlrKP8iO2aoPVpv+1ywEpC740Lj07kQsvpJvDNjgMxjzCgldsVzJNV9cQOg1NoiR5tvUcrgTRXp0qWVS12+4x9Wl6x3LidluNv6gaT2NSu8JCTiT2/YSfPzBXqB5XGU/3N2COoRLLrwHrPB+bbYuxee0LsHIDA/LQO92jm5q6AT8etefKacft+s0SP95gDpRWhw1FGEMlJljd0XFuSF83nRqvpdTY/sQ8Ni3It1eRAJZAKzU5P6JmpX48vsxIPvzzzcD+Zh3Fjx1/yHiYCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLGcgB8nBpYfFOUPbPBvDqqhdb2KEo5KI2QMkoeuniA=;
 b=SxcSqpdP/WzEBBSBwVMTI/YQYfQPlXF5mC9H1BELmHfrTAwcY3oMGPryrr5v5aex5mMqCd7O7LVLL+iRhvoePXIn6KaRX3I20M1CVxH9Zlio9BM19d1Zla1S+AZTIH5ZRkdQwUzNLUPloL6V1p1kKO3CI4i/usctaubVtrlkFXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO0P265MB6962.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:34:06 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 09:34:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 10:34:05 +0100
Message-Id: <DINEG6ZL6D2Y.239EMAC9FOLWU@garyguo.net>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 17/27] rust: auxiliary: generalize Registration over
 ForLt
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-18-dakr@kernel.org>
 <DIMSZMCNTRA0.29WGE6IL25A6Q@garyguo.net>
 <DIN2Y5PNWGVO.EOA9SQPOFYX2@kernel.org>
In-Reply-To: <DIN2Y5PNWGVO.EOA9SQPOFYX2@kernel.org>
X-ClientProxiedBy: LO2P265CA0456.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::36) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO0P265MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7847a1-b809-4f45-271c-08deb652f000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bA9WX60J4RtWPChaIAPWiEoJtiLWeO/xM4WLMppPnBBUA4Fn88P3ZYIO67S72rXlCRp2YO7eNDMDemM0Vtj7zbjehsbNF6PylzfbOrNOItfvH2RjNeJrxB4Q4X2qyjBcZEueur0zlFkvhKgzQ8VxbXdllqJ8gVyDYjwLkXc0ntllX/PKxPCY/rfdPWu1oZw+m0Vf1vpruFD3nrhE/+H1OQDJ9bH9hKN96u4sr9qHpm2Vudvy8e6uodM0DhAhLSZC6C4FB0yTGPhZ97LMYHwYPnQtddD7fodD72xvK27+fhtyOKF4k0UwMR6v/ejOpxbOJLeRiOmPfMEi86w9VPjOTacd5JyjEWUGjHl+LAfrXgQmWfGlQiqURaV2KUctbT/Q3UD3vbkP5/por/OWc3r/+p+/cIyyGW0PznE/A0Tps3+QG0ldLt4jev3XhPFtioRuTirPCyBsYGbEEniIZWgCgdXDLEFPFBtt/+FS5r9ws/SDRM2Vi2arn2x4nJZg/IfLRvfxMn/Fm5zn/+6vZhp0gdKWKWVb6/g0667ZARbU+RTOYhQ213/stU4EEqoGnid48yT7vZGeu1bIBtMDqb5V5hn7o7h9UeuchLJOu+WC/7ARf/9JVSxqUnICxDDNORS6w1vZkSgZCPpubFH23nuKwRTIv3oxhVqcuB8VAjRMxAu59k3zn8u79vXTs0c1QLpq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(4143699003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1lLam4zcGFYZUlyRTdPaUdEUFZWcFRtVzZrZDRUdHJUZVJvZlFDcjlqQVh5?=
 =?utf-8?B?QVkzRnNoc21qNTNtYjRkVTFVVHpIQzlvM2Eyd096UXE4WDJZb3dScElLRXlG?=
 =?utf-8?B?ak92VGRhait3VFcxOTVuT01jWnBqT0o2Q3hESEFIcmw5M0R0M2xpL1VGK1dv?=
 =?utf-8?B?UHVaZGFXVkVFbkpERDJzODhrN1ZlNXZjd0w1Y0pjWU5GZEE3TnRhaDM0SEVo?=
 =?utf-8?B?NmNWZm4rTVNCTno2L0ZXU3ZTcnBsMHQ0MkRTdHZKNkJWcmZ4Njhxd1grUjBE?=
 =?utf-8?B?eFpQR2tQc2ZCWTFPRDQweXBvZlFsbHRGdExKYkpSWUoxSmd0UVFubTZ6cmho?=
 =?utf-8?B?TzZpSVkxcnYxSkFpNzdCUVk5ZGxOUVIrZFJiSVl4dm1scCtwSStwZXcxdW9D?=
 =?utf-8?B?a0pza0tQYy80RUJXTW9BelRnaFNWYnE3M1VDK1RYVUt1bW5TQjNvVWlwMGFX?=
 =?utf-8?B?QVc1OGNxQ1pLMXVuV3JaT3VOL3JtV2gzdnJDc0pUb0lzdkdNUEhwQUpCWmlU?=
 =?utf-8?B?cFBrcExkdTVpQm11cWtnZ0FtVHhWNGlJUGtuNDBKOVAyc2ViQ1lTOTFuTThK?=
 =?utf-8?B?Nnd5cTJxSzl3ci9FeXpYb2w5aTBYV21mRlArUU5nYlpGcmlhVm1ZZWdSZWxw?=
 =?utf-8?B?THJIQk1IOTVibngvSlppMFNYV0k5TVYxWWtwV0NjOCt0b3ZwaUV3UE1FT0Zs?=
 =?utf-8?B?cTNMRTBmTzNFeStiOHRNQ1FtUEloK3pBUTRMRWtINmFnM2FCeUFyUmNGbklL?=
 =?utf-8?B?aUV3R01sZmY1U3d1TWNOUmgzNG9lYlk4dlRDYjBGQmdqcHpRMFdZYTFpWmg1?=
 =?utf-8?B?SWlJK1RGQVU0WnVDZDNEN0FFbVU1UDdBbzdJU1lRYlRCSGJjY3pHcTl1ZEU2?=
 =?utf-8?B?c0Z1NzBpN1ZrcmZibW9UeTZUSFc5ZW1hUGh3am9iODRJSnFrdkI1MFozeE15?=
 =?utf-8?B?Ync4RXRyMWozZ2srS3c3Mk8wdVJTOEd3NTg2a3Iwdzlzci85Z3diV0FjcG9X?=
 =?utf-8?B?RzdaSzYwdmVldVlVMDJMYnBORk1GNjFkV1FBTGx2ZGhCTmhmQkJ3L3g4eEZX?=
 =?utf-8?B?LzBZaS9MekRBbkJIQVZoTzRqWmFZZTd4NkpzQUlYNnY5YkVmaklVUmFlWVRa?=
 =?utf-8?B?d25oWjIwSGVmTnV6VERUQW44T0RXa1gwY0wzV2tONFM0SWVFakx5Y0l4bUtx?=
 =?utf-8?B?ZGRyWDRybEUrNThRQysvRUpMbUlXOEl0c0hpOVFlelZTa1RPcTgxcTR1cVVG?=
 =?utf-8?B?RE8wem1CSTl4ejFEWGtHejhuVjIzQk1Uc0duUFdKZlNZeFVhSFpUNVJ2UDBo?=
 =?utf-8?B?aXROQXpXcFc4ZVBIcjhXd2Y3WVlHellJbzBhb0RlZzl5ak1Bd0xLR0MyQ0xU?=
 =?utf-8?B?M05nWENjSmt3eEdndEpINE5rMUNCbFd2ODRtckUrRDZrM0pUQjNqNmswQUhz?=
 =?utf-8?B?U3dFT0JFamV1ajdNZ0tDVGdJMHFlK0dONDYvMjZLL0x2RzM1ZDcvOUhLM0Ex?=
 =?utf-8?B?Z2U0a0lRQ3lHTmpIZUVoYU1TUVp2SVJlMEdaMWZEMVp0SVJrd04wenlpb1lp?=
 =?utf-8?B?N2RqNjFZbjhrazhsWnJsUmxQMC9tcDlqaGEzY2pBRGREL0JFVjNWSFZkcEpr?=
 =?utf-8?B?ZXY4aW9FMVJtbm9xV2VoaU1uaWZ3ZTMvSVpMaE9jVjdReVF2TEZrUkkySzFR?=
 =?utf-8?B?NENONWxrQnkybXVSSy9qQzhvMnNyU24wbDZQaU1FWWN6VWhWRjhxVnNtSnBu?=
 =?utf-8?B?WWZKRVhMZi82TXlJbmdpemlvNFZmNUZOTk52Y0wzSXB2UDhQRUw1Z0krZUMv?=
 =?utf-8?B?TDQ0VVd2R1FwQTQxdDRLTENKU3JoVGhIdnBBTW9pN09xaXBBbGRsWmJFN3pX?=
 =?utf-8?B?U2syb3lpVGNVcmVRV3JQZjFhS2xGL0VZc0FNV28xTnBiR0N1SXdWQis4NGd1?=
 =?utf-8?B?eEVORUVtZ1dyTmlqUS9Ib1c3SjlsTVlzUHFnays0K2FKam9zK1Q5Q3JDRC9O?=
 =?utf-8?B?ZzY2eHREQmZWaVVIdjBTaHQrTk9SYmE0YitNQittWnFWTHU1Q0JkR3FGQUdk?=
 =?utf-8?B?cXl1NDUyYzlkUitaZ2J2WDdCZGtTYW1WS2F2MnpNbEE4TEQwbCtzaHFxVFY2?=
 =?utf-8?B?aTNlZzF1VEo3amJkY2dXTEN3UFlERXpXQTRzRlEvQW5yYWtoU2F6dnAyM3U5?=
 =?utf-8?B?NGRDR3hKd1NIaHRiMlc0OUdRM1M1d1FWNzZESGJYb09ZMDZwUnBQd2k3VHNn?=
 =?utf-8?B?RzVvZWhWQzNHUlJISzNNSzFBQzlSNStFVTdUNVlaUTlXT2tNa0lrRjBoYWQw?=
 =?utf-8?B?SkV2eWJORGVKU0p5OTZVWElDWmJ6b0VxUFNVd2pvWWVQdU5sajEvdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7847a1-b809-4f45-271c-08deb652f000
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:34:06.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IGzCMP1aXvzAn5V+384ZJAeVTBOp5/IUXG4zApM9J7oB29oP2nHuZ80hImyqSoTSmuexerbBtalBH5Ady9TZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6962
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9032-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: D80CB58AD79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed May 20, 2026 at 1:33 AM BST, Danilo Krummrich wrote:
> On Tue May 19, 2026 at 6:45 PM CEST, Gary Guo wrote:
>> On Sun May 17, 2026 at 1:01 AM BST, Danilo Krummrich wrote:
>>> +    pub fn new<'bound, E>(
>>> +        parent: &'bound device::Device<device::Bound>,
>>>          name: &CStr,
>>>          id: u32,
>>>          modname: &CStr,
>>> -        data: impl PinInit<T, E>,
>>> +        data: impl PinInit<F::Of<'bound>, E>,
>>>      ) -> Result<Devres<Self>>
>>
>> I think this is unsound for the reason that I gave in another email
>> https://lore.kernel.org/rust-for-linux/DIMSJVKTYX6D.AEN6OPPC2898@garyguo=
.net/.
>
> Indeed, this has to be fixed. I looked into the options brought up in the=
 linked
> reply, i.e. the "new type" approach and the "closure" approach. And after
> playing around with both of them, I'm not really satisfied with either of=
 those.
>
> The "new type" one is simple and works, but has the disadvantage that, we=
ll, we
> need a new type and update all callsites where we would ever want to crea=
te
> registrations (mainly probe though).
>
> The "closure" one on the other hand creates a little bit of an odd API an=
d by
> its nature does not allow to move pre-existing resources into the closure=
, which
> is a major limitation (maybe there is some way, but if so I didn't find i=
t).
>
> I instead went with something else: Currently we return a
> Devres<auxiliary::Registration<_>>. However, since we're moving to lifeti=
mes
> anyway, we can just return an auxiliary::Registration<'bound, _> instead,=
 which
> makes the return type invariant over 'bound, which makes the problem go a=
way
> naturally.
>
> Please find the diff below for reference.
>
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 5acece8e369a..c784426b8092 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -12,7 +12,7 @@
>          RawDeviceId,
>          RawDeviceIdIndex, //
>      },
> -    devres::Devres,
> +
>      driver,
>      error::{
>          from_result,
> @@ -408,12 +408,12 @@ struct RegistrationData<T> {
>  /// `self.adev` always holds a valid pointer to an initialized and regis=
tered
>  /// [`struct auxiliary_device`] whose `registration_data_rust` field poi=
nts to a
>  /// valid `Pin<KBox<RegistrationData<F::Of<'static>>>>`.
> -pub struct Registration<F: ForLt + 'static> {
> +pub struct Registration<'bound, F: ForLt + 'static> {
>      adev: NonNull<bindings::auxiliary_device>,
> -    _data: PhantomData<F>,
> +    _phantom: PhantomData<(fn(&'bound ()) -> &'bound (), F)>,

The type itself may be invariant over the lifetime, but it would still acce=
pt a
shorter lifetime (which again, is a case where I think having 'bound become=
s a
factor for confusion).

You can still pass in a shortened lifetime to `Registration::new` and then =
leak
a registration (yes, Leakpocalypse strikes again), so the invariance here i=
sn't
actually serving purpose.

    fn bad_fn(dev: &device::Device<device::Bound>, buf: &[u8]) {
        forget(Box::pin_init(Registration::new(dev, c"foo", 0, c"bar", buf)=
))
    }

Best,
Gary

>  }
> =20
> -impl<F: ForLt> Registration<F>
> +impl<'bound, F: ForLt> Registration<'bound, F>
>  where
>      for<'a> F::Of<'a>: Send + Sync,
>  {
> @@ -421,13 +421,13 @@ impl<F: ForLt> Registration<F>
>      ///
>      /// The `data` is owned by the registration and can be accessed thro=
ugh the auxiliary device
>      /// via [`Device::registration_data()`].
> -    pub fn new<'bound, E>(
> +    pub fn new<E>(
>          parent: &'bound device::Device<device::Bound>,
>          name: &CStr,
>          id: u32,
>          modname: &CStr,
>          data: impl PinInit<F::Of<'bound>, E>,
> -    ) -> Result<Devres<Self>>
> +    ) -> Result<Self>
>      where
>          Error: From<E>,
>      {
> @@ -439,8 +439,10 @@ pub fn new<'bound, E>(
>              GFP_KERNEL,
>          )?;
> =20
> -        // SAFETY: Lifetimes are erased and do not affect layout, so Reg=
istrationData<F::Of<'bound>>
> -        // and RegistrationData<F::Of<'static>> have identical represent=
ation.
> +        // SAFETY: `'bound` is invariant (via `Registration`'s `PhantomD=
ata`), guaranteeing it
> +        // represents the full binding scope. Lifetimes do not affect la=
yout, so
> +        // RegistrationData<F::Of<'bound>> and RegistrationData<F::Of<'s=
tatic>> have identical
> +        // representation.
>          let data: Pin<KBox<RegistrationData<F::Of<'static>>>> =3D
>              unsafe { core::mem::transmute(data) };
> =20
> @@ -487,18 +489,16 @@ pub fn new<'bound, E>(
> =20
>          // INVARIANT: The device will remain registered until `auxiliary=
_device_delete()` is
>          // called, which happens in `Self::drop()`.
> -        let reg =3D Self {
> +        Ok(Self {
>              // SAFETY: `adev` is guaranteed to be non-null, since the `K=
Box` was allocated
>              // successfully.
>              adev: unsafe { NonNull::new_unchecked(adev) },
> -            _data: PhantomData,
> -        };
> -
> -        Devres::new::<core::convert::Infallible>(parent, reg)
> +            _phantom: PhantomData,
> +        })
>      }
>  }
> =20
> -impl<F: ForLt> Drop for Registration<F> {
> +impl<F: ForLt> Drop for Registration<'_, F> {
>      fn drop(&mut self) {
>          // SAFETY: By the type invariant of `Self`, `self.adev.as_ptr()`=
 is a valid registered
>          // `struct auxiliary_device`.
> @@ -520,7 +520,7 @@ fn drop(&mut self) {
>  }
> =20
>  // SAFETY: A `Registration` of a `struct auxiliary_device` can be releas=
ed from any thread.
> -unsafe impl<F: ForLt> Send for Registration<F> where for<'a> F::Of<'a>: =
Send {}
> +unsafe impl<F: ForLt> Send for Registration<'_, F> where for<'a> F::Of<'=
a>: Send {}
> =20
>  // SAFETY: `Registration` does not expose any methods or fields that nee=
d synchronization.
> -unsafe impl<F: ForLt> Sync for Registration<F> where for<'a> F::Of<'a>: =
Send {}
> +unsafe impl<F: ForLt> Sync for Registration<'_, F> where for<'a> F::Of<'=
a>: Send {}
> diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_dr=
iver_auxiliary.rs
> index 84d18bbfafc5..efb4d97b416b 100644
> --- a/samples/rust/rust_driver_auxiliary.rs
> +++ b/samples/rust/rust_driver_auxiliary.rs
> @@ -10,7 +10,6 @@
>          Bound,
>          Core, //
>      },
> -    devres::Devres,
>      driver,
>      pci,
>      prelude::*,
> @@ -58,29 +57,29 @@ struct Data<'bound> {
>  }
> =20
>  #[allow(clippy::type_complexity)]
> -struct ParentDriver {
> -    _reg0: Devres<auxiliary::Registration<ForLt!(Data<'_>)>>,
> -    _reg1: Devres<auxiliary::Registration<ForLt!(Data<'_>)>>,
> +struct ParentDriver<'bound> {
> +    _reg0: auxiliary::Registration<'bound, ForLt!(Data<'_>)>,
> +    _reg1: auxiliary::Registration<'bound, ForLt!(Data<'_>)>,
>  }
> =20
>  kernel::pci_device_table!(
>      PCI_TABLE,
>      MODULE_PCI_TABLE,
> -    <ParentDriver as pci::Driver>::IdInfo,
> +    <ParentDriver<'_> as pci::Driver>::IdInfo,
>      [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
>  );
> =20
> -impl pci::Driver for ParentDriver {
> +impl pci::Driver for ParentDriver<'_> {
>      type IdInfo =3D ();
> -    type Data<'bound> =3D Self;
> +    type Data<'bound> =3D ParentDriver<'bound>;
> =20
>      const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
> =20
>      fn probe<'bound>(
>          pdev: &'bound pci::Device<Core>,
>          _info: &'bound Self::IdInfo,
> -    ) -> impl PinInit<Self, Error> + 'bound {
> -        Ok(Self {
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +        Ok(ParentDriver {
>              _reg0: auxiliary::Registration::new(
>                  pdev.as_ref(),
>                  AUXILIARY_NAME,
> @@ -105,7 +104,7 @@ fn probe<'bound>(
>      }
>  }
> =20
> -impl ParentDriver {
> +impl ParentDriver<'_> {
>      fn connect(adev: &auxiliary::Device<Bound>) -> Result {
>          let data =3D adev.registration_data::<ForLt!(Data<'_>)>()?;
>          let pdev =3D data.parent;
> @@ -131,7 +130,7 @@ fn connect(adev: &auxiliary::Device<Bound>) -> Result=
 {
>  #[pin_data]
>  struct SampleModule {
>      #[pin]
> -    _pci_driver: driver::Registration<pci::Adapter<ParentDriver>>,
> +    _pci_driver: driver::Registration<pci::Adapter<ParentDriver<'static>=
>>,
>      #[pin]
>      _aux_driver: driver::Registration<auxiliary::Adapter<AuxiliaryDriver=
>>,
>  }


