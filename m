Return-Path: <linux-pwm+bounces-9005-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CyiEZtQDGqTewUAu9opvQ
	(envelope-from <linux-pwm+bounces-9005-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:59:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B557E2F4
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B334304BB95
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AA2352020;
	Tue, 19 May 2026 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="XVVsmSWj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020108.outbound.protection.outlook.com [52.101.196.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772F635202A;
	Tue, 19 May 2026 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191289; cv=fail; b=D8UDEBPn5Bbrpfq6DPuS9vTXnGULsMfJg79k17kIdGtoiionsqhhb0L5Ar6vCOCQmBiuPYTNK3qu0O5NTRQp0dL6txdcw8zppuc6V7CSNjwhmm10qzhqLt6i1clcx9g/2gLli+stjShA2tQJbDxhaQUH8noWt1for6QODrJXzuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191289; c=relaxed/simple;
	bh=Y6T5lL8JTzdJeb4fj4D6r7tvvGz5qf4M+xdIRqyR2hw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=aeht0LcFHhUbXbb2IHGPeezgO06MkXivsXsROfqjuO79eoP9NCpM863fw8rAMEd1z642D2DMSf2NCD3Nfn0B7yOUgWyASEYFY68USveDQHjsQqmyMYby6YuiPpLNllCKnNWxhqSaDDfqKJq/bl6nB2SMdy4HngSOKlc2yrfTCAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=XVVsmSWj; arc=fail smtp.client-ip=52.101.196.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgLHGOGQTXw638e5hv77DeNbXCfgl/z6v/zV6LcHXXCFs8EtUNlB3Q6BLjuryTYOIxZhzn07Dv6G6opclo9qG/jOLt/9KSGyuFO/JRisdIUrhW4hgSsVswntp/Lm5NDBno5VKfwLoSmVK0ykHx7I3TkGnivoQG+ntpdP12vK9DjUX5voh2e8OkiVNhHx/tBZiYDP3Evbo+ygrVjxdnU6jAo4jNCSCS0DQzNYjJGKMoUlhLi/BGnKbp41r9H6aY25qlrd4O07TpnR2AAZnucCFb1ZX/YLX8QN3uvSjFziFSjlMmTMRyq2WD/ZejviJjtZLojRxtNTCHnI2E0nDrW25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6T5lL8JTzdJeb4fj4D6r7tvvGz5qf4M+xdIRqyR2hw=;
 b=bvggFx3T5uKK+0fKbH757F84jFvkQeW9PPiNT0bXz7ZiYVDUjjanzOkbxfmc6M/PDKoqjlLRufRVZzUN8GaVfTEh2USLdPkMaptAGqLB7JOcQN1ogdP1LFIrJdR++1IcLCn5vMlNbtbz0p6389rGTknTU7yipGO/bRXQiGL5X9hh2RnpDz5hqs3HLgMv3Bgpkvo3QHaDDeTntHaEcTd+1+tfqPJjpQ203uP4Ntj5n+Os2IeJgDZRxd3t13aMUzOey2KdJ6i/Fzz1fik65TmYDCQzf51xb5htm8ng1JP62eArYA4T3W+rlK60vbE68xXbTtpuyo5vbj0vG67p+2oY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6T5lL8JTzdJeb4fj4D6r7tvvGz5qf4M+xdIRqyR2hw=;
 b=XVVsmSWjq0gk7cazCFI+Pk8BEw3Ia6O4yaX1Ete8Udp74NwYmDNts3+6yD6ggrMAIH1loJ34wTiFVxdFFFsPYEvCagxd9tFGSVW/wUe2rKjt7BYkw2XEmTpWDcuN0/Hv7R/UUu3uAmoPgvqirse3MIfVupL60OBGYdU9knvMgPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB6297.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 11:48:01 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 11:48:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 12:48:00 +0100
Message-Id: <DIMMO6Q6WKOY.1DKWK8IBAP0W9@garyguo.net>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <igor.korotin@linux.dev>, <daniel.almeida@collabora.com>,
 <pcolberg@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pm@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 10/27] rust: pci: make Driver trait
 lifetime-parameterized
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-11-dakr@kernel.org>
 <DIMDU2XL6PKO.RUXA0XPFT94R@nvidia.com>
 <DIML7T3R6BXP.2WSFVG2VY63LP@kernel.org>
In-Reply-To: <DIML7T3R6BXP.2WSFVG2VY63LP@kernel.org>
X-ClientProxiedBy: LO4P123CA0064.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd3acbb-0da3-441e-87f6-08deb59c7acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ceE7NKAcVgaQP39bnGp9erNm9XtMn4qliEw5BZr18LaVZRHlk7SPj2H9/O/6lTfuEm/mDfZwdNfsTn6unC70gnkT1srSZSzWO+rFWUPhketob3AgvhoxWiQuhlDDvlOrPVBRa7EOWNVBvPpRk7JdPkt70Nb1Ez6UVhFdcmi9TA2Na8bjxo48ENIwE1L45fJGwPrIQYOPCVKOU3tpJrFmXJZbXWrNLiJbExFOrb18muL4g+XTcZtby4sIWNXGBFQaQa7DQXOduVPDiim5Ov0DdAtQGA38SsAt4Pov3NDcDjUwUue60Ma8X5ve6wvBN0SjLv/JP0+5MfZ8N5ymhTieUHNeqrrqqNw2bYQQdYptoeQ8Bi19rxU5cjOPoCrV6Y772/ef9MxK2r4XGuVzfIfVlfmSZAzo+oEtkVNSjsGJ84fw0/4fHjLOk8RgDtiyZAKazC57j7E1fRJtCt5gixno9jKQG64LngmRNTv7B81LDDJt9mBmi75yq1L/D50/6rCu7iCImjuUaFVOcOcsONBU8kzeQXcI4gG3OJFq0+DxYiCaWekWcQ1rnPY3GQr08QQLpGrozcWBGAq97FGc+qm8TSP0r8VuGI9BMucSSQC80+wzhbbU2f4STOxED+kFPRxTG8aXmQWQCuk4a6ioTawWEYHw1TdSDORaUnLUsOEQ0lxm4yxxiXmrhrUO1Kj8SBYV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEViU3E1R0RMUjBtYXlEanFMN1BvajgvZ3dBaFdBUkljZzc2TTVZd0RkMm1q?=
 =?utf-8?B?QWp5SWlBaEU5Z0dOQzFNc3hNd2lLVmtNVndtamF6dUNQbURXVE00VDRzb1RM?=
 =?utf-8?B?S2lpbklBaFo3ZHI2eGphc21WV2hXSVdDYVd6bjY5RTN6OWlPN3RHK2NvRC9u?=
 =?utf-8?B?Yy9EclpvL0RoU0FpOFljRFlQR3NyS3pZOWFDRHZSSitySmk4WFlMMVhSRzhF?=
 =?utf-8?B?RXZpZUVOa0l6UGt4VVBsY2lWRE1zaWMzK3lyWVpIR1BPeG1aK3QxNk5ZSWJB?=
 =?utf-8?B?aVpNMjEvMEFVbVZDb0p4b0NNVHJsbk1zbHJESG56dGRFdGIra0tqMk9RVFVO?=
 =?utf-8?B?b1VHeUJtc3ljclJybm1BdEpVeXNQV1l4ck42SCtNU0lwNUY4U3N4dVcvZFFX?=
 =?utf-8?B?NlBmT0taNEJqK0NuY0tlcFZUUlFKK2kzSDdNNmszWmUzNkZYby9IUjN5aGVI?=
 =?utf-8?B?cE85UmdWR0t4NnJXMS91NUxvelRFVExjRTNnN01Hazc0aDFMc1BpT1RVV0ZY?=
 =?utf-8?B?ZFRTdmRqTlIzdDl5RXZtQlk4S0t4NFJGd0k2VDkrTFpvZVZuNDV2aDZBQUU4?=
 =?utf-8?B?VzlOb1lSMXdaUUR5cEZvZDNEOEJKdEN1M21Ma2NCcUFSL2NrenN6R003WHN2?=
 =?utf-8?B?UEU4UHJuQzA4MnR4VERHZDVBanpFcXpkbHN5RlAzZVlpaGU1SGd6ZnRza2tr?=
 =?utf-8?B?dzdFcXVhSGVONjg4aFA2Tml5aGxxSmtDanZoQ0JHU3llTm56ZUU2ZWc2aWlF?=
 =?utf-8?B?dEsxNGxBSTlyS09pMTNYYU1xWS85RWUzVllSRlQ3RVhSK2dXdWpYd3BVc3R2?=
 =?utf-8?B?VWx5MlFLb0JnUThmVlNjSHFaYVZNWjZPVzh2WVBxSThLdHNHemFJQUNETko0?=
 =?utf-8?B?NWl1dkc1MkdiQ0U5MlV0UmZ3TmlCSUtHeTFBMEFQa05TTjZKQjZualN3Tklw?=
 =?utf-8?B?cysySHhrN3Z1SUlVcVNwM3NhWFNydDRFMW1CZFg1T3NSRStuOUM5Q3lpSzJm?=
 =?utf-8?B?OGVXWkJONlhDRHBoVFBOcmJ3NTN4Mk1oRlMxS3lHL3JhNnNmQnYwUCthdW9v?=
 =?utf-8?B?cVVXeENXcEFrd0NoSGV6VS83bGNacVcvY2xQbk5ieDNia1ZiQzNWVFpaQUgy?=
 =?utf-8?B?cGRxcmJQdUIxOVpCU09aL09oazN3aDVQRVREUnRQWlJXRkpJMG02NkZrQ0xF?=
 =?utf-8?B?cUNpcVhqdnFwMExpMU94cEpYTkwxOTdWaEVHaXlzS01RaDZOak1lb0pxTWQr?=
 =?utf-8?B?eU9RTDUzeUpDQU5rcFI5ekVmK0tPYTNOUnp1T3lvQUJGM3NIc3dXY2VTU2N1?=
 =?utf-8?B?Zm9ENSt5T2JsUDNraGlKOFZrOUFzczRVejhUUElaMGpBbFJ3ZVg5YW9ka3FM?=
 =?utf-8?B?Q1pOZDY0TWFTR2pSeVVvSFpnYzd5MktSSnY4SFhsZFl5Qy9MSmdqeEU5Zk9P?=
 =?utf-8?B?aWZ1ZUFZUEhlMU1La2lLVW5lN0p6NHB6RThHTEZDcFJIS24wQmMwUUw0czRE?=
 =?utf-8?B?WlpTV3JNNWdFc3Njdlcxd1pML0dGNllxMnFQNlNGVE5ObDlydS90UDR4aS9N?=
 =?utf-8?B?bHlXWXI5VUU0VG1UdGxpSzlha1VwVFJseXkvVkg2Tmt3WGRaQUdzWG84dnpL?=
 =?utf-8?B?VnVCYXpkQUxqc25pZi9SYTZpMEVBa0FRakRDRXdnMHdlbHl0MXJGcjZGbmVh?=
 =?utf-8?B?eU1saFVnalJnemx6bGFQNVNOdkpzd3ltWVNseGZPRFBpeHhlMDBIenRzVzRS?=
 =?utf-8?B?TExoem85Tk00ZEhNQlBYclBlYmI3RDNGeTVkelErdG1SaTk4YWRicENzL3h4?=
 =?utf-8?B?alFZRjlaUUNySEc0U2dwU3E5VTBYRUovSXFhQWNuQjFIaGVpN216WlhmS3Zl?=
 =?utf-8?B?dnpDc0dnbVlXS1ppdGlwcTlPY3BpNmFydk51dnRIOHVkREN0RVRxbWhWRVR0?=
 =?utf-8?B?amc3RWVJWUdML1dpd3BoMXphaWZQakxLaXBPY1pVY1BWYzRhSFIrZVdlbGhC?=
 =?utf-8?B?RmFmUm9SaVRvS0JEL0ZHVnJBVDVIMEVQMFYrbFdla1lkKzQ2UVNqaExyQm5V?=
 =?utf-8?B?WktnVDJxeHByTEtCNGxHKzN5WnVKLzJZR3crcHljaW52NkZlbjRxL2tHeHdr?=
 =?utf-8?B?M3A1WVk3ckE2cWFGUm12blM3RE85alVHTGwyems1elFoNGptWWZtZ0pwVnBh?=
 =?utf-8?B?ZW1IV0NtZzF0NTRsSGFhSXo0VFdIaEUzQ2krY2d2UjEvZFRMZlVHUmF5UmdZ?=
 =?utf-8?B?bDlveFN3VGg4MXJrb3hoNUJ5S20yaDFBcDBEK0RPSm9IMm5IL2pUL3Ewd1Rn?=
 =?utf-8?B?b2Z2aHFEWmJvOEVPMnZZclRtbUZOaXRnU29vSHIvM09KKzYvRjVMdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd3acbb-0da3-441e-87f6-08deb59c7acf
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:48:01.4048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziz1OKOstm45iUbpul9eid+u3jW4Cz9DrMcNfmUNr8uGxLyAGorehzOPWBv3EtTW1a3JiDTP+e5eqnXSMucHng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6297
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9005-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4A1B557E2F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 19, 2026 at 11:39 AM BST, Danilo Krummrich wrote:
> On Tue May 19, 2026 at 6:52 AM CEST, Eliot Courtney wrote:
>> Is this really sound without a covariance proof? For example, with this
>> version you could stash a Cell<Option<&'bound pci::Device<Bound>> (even
>> with Gary's suggested Core<'_> change) and then observe that reference
>> on Drop of Data, which seems unsound to me.
>
> The Core<'_> change seems unrelated, Core is not Sync, so you can't store=
 it in
> the first place.
>
> Otherwise, I don't see how one can exploit this. The formal invariance of
> Cell<Option<&'bound pci::Device<Bound>> is not practically exploitable be=
cause
> the framework controls what lifetimes are available and everything reacha=
ble
> through 'bound outlives the data; something that is shorter lived than 'b=
ound
> can't be stored either.

The current code is problematic as the `unbind` callback have
`Pin<&'bound Self::Data<'bound>>`. I think we've discussed this last week a=
nd
the conclusion is that this isn't sound, and the callback should have
`Pin<&Self::Data<'bound>>` instead (the outer lifetime should be
callback-scoped)`. Did you forget to make the change?

>
> Bringing back ForLt for this reason seems undesirable, as it has a real d=
esign
> cost.

If we have the `#[variance_check]` macro (like I mentioned in another threa=
d),
we could use that to check instead, but it'll still be unsound if lifetime =
of
driver data escapes to devres due to destruction order.

Best,
Gary

