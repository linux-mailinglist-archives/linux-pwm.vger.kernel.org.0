Return-Path: <linux-pwm+bounces-9365-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O7LJI7T2O2rYgggAu9opvQ
	(envelope-from <linux-pwm+bounces-9365-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 17:24:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 014276BF9D7
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 17:24:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=SHy36zd9;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9365-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9365-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B628B3130BD1
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD703D8131;
	Wed, 24 Jun 2026 15:14:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020085.outbound.protection.outlook.com [52.101.195.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777643D9DCE;
	Wed, 24 Jun 2026 15:13:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314042; cv=fail; b=YOdxxt7W+Q/qo6QtynBtlT1ktA2Be4mAL+UUDce+TARg3vHhLFbZIkioPFmHcxnKJfZPJJ2bUhhIELcflAE2MVlWT2hoUCnBkh0qq5BPB/Fqrj4TlLVnLwi2J9AcF3s/7XdSpntlbdrH099hxBhykWD4mIcQvpAaoA3OI/9C2aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314042; c=relaxed/simple;
	bh=5MtZjUGbRSFc+LueHUmPguHFurnVCwjDfphjDjFoTks=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=pnh1Awe1/OoyqovYGZOJha4BIj9sLhgkJAYPgqOJcTcF5JtB1J9wLc4qJHUVEAFZsSaba21+6FFB+kkaOzAJDGCzxbNLzSxBHp5ARyKtF14bd0kCZR+SAHIESNT//IRILupz8V0GLC5adZkEQgioS1l3hJtI/e/ZvLGkCAIDB+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SHy36zd9; arc=fail smtp.client-ip=52.101.195.85
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSOZ/kplYNon7DZGYVTDEUGgu/3awyQ9iz3jn0Lh2CnlznKSsUYd10ZXpRjnyUSelnUxCYJazLn6Q6xNXlJs2IlEeUtmzAyPHBJ2lasYHUauLShMYJKg4U3YOn1zr6e3Nbj+R0uxPKdxdbIvFCL7Jc9sJJv7X6jeMkb+h84VB+0323tmB2taARLkNBgm/0yK39PO6XrNqDJOr1VNvwkOFVgVcW7j0zrocLadVu/e63LM0sdO6rTcks56izWLxoD7AtDyQ/0bdP4k/cqJwxaZPeOmwuMXMu8xBsgGODB6AqCOV6Y3GS5ajtSN6Purf8F9GqpXVkZzv54WB3ImhjbjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jYUGdsgmwsDZF+R6lnqpRqdkmXCTlLXqajGnCC+zqc=;
 b=AKA4qkDpExzH5MJlbjXQ3AzqMFnn9JVltlKyRMFMQFF3MHsyFFlBJc09O/rOQlB+x8DDNe3QWgDNUKNkMPuPL5PedRSoIGqauqhnVY9yEMOPphxuPY3Qe08V8cbAI0Z+IYm6BqQsCYWqRkYj3m+rlAnCXn5AjNx/mcAI40xpw8FFxlcxEraQV+mFhl//6NxYHFucH88FeunWraCjNvs7n0IlnffUexfrzabS68zFHuu1Z1CO7waZPt0b3Wjl0jOpdRRIwSi7ropu3HRKNumQN3SwLuTrnXbOfpRhBqsvJzN60BY1SVjAwBSouiydIdgW2rXI9kxPH1puxPs98JWrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jYUGdsgmwsDZF+R6lnqpRqdkmXCTlLXqajGnCC+zqc=;
 b=SHy36zd9+Btz6POh5WjYj2Ky86u2YnQ26lUnldGPwXLF/iHrPoHOnOpSQ2yRUQWTK7xFL0HPTT/Oto9nRqIvZhGJ8wPOuqjEoOkUTYzFPIOvhQhc0hOZQscx5X9aJMLrHkFJwxvN0QnfRxE8GOuhoSjW3PCjQ5zKrha9x4AfB60=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7771.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 15:13:52 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 15:13:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 16:13:52 +0100
Message-Id: <DJHDLEX2WPCI.N1EY89Q8JVCN@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] rust: types: rename ForLt to CovariantForLt
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <m.wilczynski@samsung.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-2-dakr@kernel.org>
In-Reply-To: <20260618230834.812007-2-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0141.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d727e74-b584-4eca-e58a-08ded20333a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|7416014|376014|366016|4143699003|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ELTUThHcj5N5S29m2ANkvYJlitaImKFRpTcJaZnYabDnL6rWs7lbeED6okU024LPMO1MGT7UOKK1IVJUtEGmB+Sh0mJeaBHEvou3wax2cpYiri1vdBPBR/cHCArssrGxrAfubf5YMgoiRUgIKQwMMlz+BuWYBWTtsUTDJNhkgGoPXQr5L1LPiAPvaPKI41NLyafYTcFx3miPSXDEetGxnaftsMzr/1DfRfKBgYEt1ipHQ6DIGgi50Zqdp+4yhhF5yY3ubpkE2dkVRVYA53fV2sgztMx8bfXCFO06l6yGJdjcYkhSrVaJGms2gyDy9QdMP+2tsRSKb8rN20XFNa9hgMpx9Tnzs8/of9RgvrBJMY9o1nZ/H8ebpJQMQfuWq9ANjVzfiHZzwuiauttLvKrazCzdK1NOx2d6afNBY+NpmgvZj2kT2AT8U1qKuy5A3rrsv5mRidg7XTKLtFXD3ZVQgpr9gDef1B3ymcidtOnuj6go2b3db3/6TOYTp6tXEOdpGq99hfUIbm0MoHekOA98KQ5cuiO+MtTGVdjbnejSWbNDkVn3OPGOHHvms+MTAPWKhgA7Ew9vza9YexJZJ7uHYqZ09exIsmyRlSuWZltO83cHNcoLqh7ClfqflKX6w8Rupwy4peBqSFU5+xA+igzwAl/KyWoRSqBtCqWQZBi1koJgfKeuEScHN3MrMg9xbbiPm6rVCfa7U3c2Go+uZBhw4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(7416014)(376014)(366016)(4143699003)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T24rT0dDaVM2NjZrRjBaU1M0QkpLbkt5bFRCbDUvbFJUQ2pkQ0xVeGpZVG96?=
 =?utf-8?B?SWxyU00wTEtPYjluZHhIUEtKQlV3TjRIM3VVczJ2OWFLeU83Ynd6YWJWVjF3?=
 =?utf-8?B?TDlwWWZDU2s0TytSNENlR0RFbk5NOUpsNkpmWExMczdIYjFlMjA1bjk5SXUw?=
 =?utf-8?B?cjBnWEkxdWQxWE9TN0cwNlVkQXhmUTlWQTBrNTd5YTlIWWUyMVVYWGpBV2d4?=
 =?utf-8?B?REhVMGVDL2tKS0ZJb05YZUU5b0lIVEludUFGbXZUOFozMTN3dFZKM2ExcU5z?=
 =?utf-8?B?djZWMmVSNE5aY1lwNlY5SnBGcndqZVpha241RHFzK0dtMGlYTm5YNHJ2TURP?=
 =?utf-8?B?TVdnN2o0T040S1VCcTZlTmh4aTFqQ3ZMc3ZHVUlhODVnSFZ0UnJucTVnWkly?=
 =?utf-8?B?N05DdDZiQm9kQjRHeHd6dXlkSzhUSFhLZ1BIU0c2QTBLd3U4TDNBVHcrNXdz?=
 =?utf-8?B?Q0lHaGF5QkQ3ckt3dEc2ODYzRUl6Vjl3WVBMWDBiM3U1ck1XVlMvZkE1TmpJ?=
 =?utf-8?B?Mzh0OTJYNzRLcm1kV2p0MXh1NXk3cWNGbENQUWRFbE82a01sbWRKN1ppRndZ?=
 =?utf-8?B?STkzelpCWUdQK3Z4MVBucG1VblJzTVRhMTlQMXNJNHB4ZDJzUVlMYWZHZHJQ?=
 =?utf-8?B?bVlKU3NuSit0WGtPOHc1dXI2aHBCSE01d3FSS2hRcUNVaWRCR0FwQkhoRU9I?=
 =?utf-8?B?Wkc4L3NCaGV4SU9GQkVaZTdKd2g5cUo0M2pKOCtMS1EzOTY0RWxVaXZZUDdD?=
 =?utf-8?B?ZGdIa0YwM2ZxbXdtSG4vWU9ueVVvS0grMTNHQVRUSkFUbjFWZGJITUQ4K21v?=
 =?utf-8?B?bHdyTy9mUnZpdHlPbkZScHZYVlNiVmhJcFpmQWxvZ2FUWklKNldEMS9qWVNO?=
 =?utf-8?B?K3lqTWRhL0tQZ2RWMkxNcXBuVEF0V05sR2RmemphbG5hbkRPY0N2dWNjYXdS?=
 =?utf-8?B?bFlLWDU4aDlQKy9Jd0Rnd3hXdDNidUJDNW9wbWFOUG8zeFRmblBpQnJqc1lF?=
 =?utf-8?B?VGxHV3RSQ3NETWpFbVBJcmZoQ2Y4dFRCS0dsZXBLMVlGT010NndvdkYrQ0ZS?=
 =?utf-8?B?eUNBNnQ4R3UrNmF2SnR4OENyWnB0V21XbmkrOGlUYjJ3cFpLVHNQY2RJRXhJ?=
 =?utf-8?B?dFRDTW40VE9OVythVjZvWGI3T3puVDFTUWZNSzRqZkdGTUlVOVVpMmpLV2c5?=
 =?utf-8?B?cWUyanRFbk9IMWdQdHI0YnFFYm9TWXFYeWh2N0xNaDZSVmxLc2VsWllzSk1k?=
 =?utf-8?B?bkFGdmFZOEt3RjlQZXg2YVcyTlJHZE1JdUU1L2VxWE1VUWtvZEV4QS9pczFZ?=
 =?utf-8?B?QUdKYUN4ZDlZVEpWMG9HQ1U0WmpwQmZkMmFCVVU2UmRkOExjYzE0RG5Pdkdk?=
 =?utf-8?B?R01ja3p1RVF6SDU4T2lNUE9Ta2R1QVMwZlRWbUhBQzJiakdJYUtmK0lURDFp?=
 =?utf-8?B?Snd5ckQzaDAraTRnckF3MlZMMnVvUHFhTExoNEp6Wk5BNnhLb0Z0VEQvNG1n?=
 =?utf-8?B?V3NodDVRUUtUS2ZQaG1hVlByM2tOdjFuOGljb0hVZGZERjJUeWxod2dxQ1ps?=
 =?utf-8?B?OWNGRTJ2NTY5Q3FxMDl6T0VnWkI0WUdDMUhjSGhCWFEwZGlBcVJUQXV4Vzlw?=
 =?utf-8?B?blg4Mm9pcW5zSVBrYnQ3SUpnQkhVYTlSdThWK3BRTmdNRW1ibmdHZHVvV3po?=
 =?utf-8?B?R3VzakNhZkhsdjlYRzRKeWR3R1MxTnBTdzNVLzBqSXFFdmF4LzdDV0ZLVmov?=
 =?utf-8?B?NFNIRjVTRjBoU0FZNEM1VkZTMFRndFE5dWF2dERTVFg2bWNya05COWlrY0Rj?=
 =?utf-8?B?SVFYNExyaW1qUEl4dVlLV1FHK2d1NHMrdExDcjRDdVB1UmpCS1oydzZJbHNt?=
 =?utf-8?B?dUs4aHBMeGNJbEVWK0NwMHlLU2ovZHlOOTRKL1ViOFdZNWFwTzQ3SjNibUIw?=
 =?utf-8?B?MXFTRVlkQm1UQkxRcHEzYlg2THlacHZXbTh0TWRwMlV6S25BTHpGZDRKSkd0?=
 =?utf-8?B?U0JiWmwrR2NTMnBYRnlrNzZZVXZVYTJsR09ZMS8zVWVsdXFycmZISUZsWFoy?=
 =?utf-8?B?SVQ1M21zdGNRb005RXMrMW5HclRHUzZtRkYydmhpWG5CQ3dzK0psOFJLOXh3?=
 =?utf-8?B?alRWb2JCRlgxSXVuSTFaWUloMnl0Y1h3Mi90S2h1VkoxQTFvR1ZBcE1IU3RZ?=
 =?utf-8?B?SCs3K0poUGhpVVZGK1ZZZjUycGZia2RJWkVsaFRjSjlXVjZsUGh6RlZjY1dt?=
 =?utf-8?B?eVZpS2g3Ymt4c0U4b05GSFYvRGQ1MXZDNzBndzg4c093bkZqU29wcDlQZjQw?=
 =?utf-8?B?RUZWbXFuSTE1NnlqeFBQeXN4THhJWTZaSnNrcXgvc1liWEVnY3U5Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d727e74-b584-4eca-e58a-08ded20333a8
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:13:52.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZQ+//fO5B1dBTRs2DQm/YY2mQo+49gIg1lcakBJUkvgrQp7HkbHTcpf+abwayrDPegyjjj1y5jWcSkaF8xbsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7771
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9365-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:dakr@kernel.org,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:acourbot@nvidia.com,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 014276BF9D7

On Fri Jun 19, 2026 at 12:08 AM BST, Danilo Krummrich wrote:
> Rename ForLt to CovariantForLt to prepare for the introduction of a new
> ForLt base trait that does not require covariance.
>=20
> The existing ForLt trait requires covariance, which enables the safe
> cast_ref() method. This rename preserves the same semantics under a more
> precise name, making room for a weaker ForLt trait in a subsequent
> commit.
>=20
> No functional change.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/driver.rs       |  4 +-
>  rust/kernel/auxiliary.rs              | 23 +++++------
>  rust/kernel/types.rs                  |  2 +-
>  rust/kernel/types/for_lt.rs           | 57 ++++++++++++++-------------
>  rust/macros/for_lt.rs                 |  2 +-
>  rust/macros/lib.rs                    | 11 +++---
>  samples/rust/rust_driver_auxiliary.rs |  8 ++--
>  7 files changed, 54 insertions(+), 53 deletions(-)


