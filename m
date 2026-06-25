Return-Path: <linux-pwm+bounces-9388-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R8IpKmg9PWrUzwgAu9opvQ
	(envelope-from <linux-pwm+bounces-9388-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 16:38:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E643F6C6BAA
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 16:38:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=qFc3oCu2;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9388-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9388-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B5AD3062634
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89213DE427;
	Thu, 25 Jun 2026 14:31:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022109.outbound.protection.outlook.com [52.101.96.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB03D8107;
	Thu, 25 Jun 2026 14:31:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397896; cv=fail; b=kSoaVY314fXdHYWEtdfykw36pUdiG047NgG1Bb7BJa4UqMQmh7gf8F+xATCT/gBw9R9gK3IVEyfix2Wc7vtjUv5LOOn50//ins5rP2UWecsFAQ60n52y/K4ZsIuU+2qVxQOk+xFS/TeKl+reDaZ1EH2Kb0eZGPIuTnvOvEpemm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397896; c=relaxed/simple;
	bh=tRSygZ8QKnOSXNCRVoLyooYD6BYoEWQQbaXPPZq+rc0=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=hdYsirjKzlofNryQriwYqFYApDdRNSn4TXMB0UdUdc4t/dRxnBH8VOzBUGvVlgwBlwet9UskuJ5EzajSvl7vCoTig4vT+Wgw62pQr+2GGwAyLsKaa/UYo65oaUj+S2Z09eXXT7lnWMicSxKjXYs/WpzFtZFhG8q629EiFR2BgSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=qFc3oCu2; arc=fail smtp.client-ip=52.101.96.109
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJ/sCsURMHFHNGSKRMRC1UU0OwGB11hLBkOXDEbhokT3mUW5KfBPGbrCEreOr4rzsoVx07deBfrz1GjU7azyxdbIJ/kUh4Gs6mnyeUWQVdJXWSiPuy5o4WGoRuvAts6s9mqfyYIwzLuC2rMSv97NvLptYoOB+k3TF5RwtauBC1oXprhWXI8H5VJeASYHBzmb9+qk8sEWMrFL6xfVkYAXFogSXVxkP0ctI8G6LNcHkXRol2R1ZjG8vdEzwCzFeLNR3H7iuX/hvAc6eW35ttC4wfJ2ErsI4o4j18/Iv1IVAfGFq/d9U/ypxMQ59ThDftNctF0ckZQEsBBLcOLFYSzjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4cKQWsb2grxb7B0k9Obt1pLRdNlrrpOkIkUkF7Hwc4=;
 b=r2OKIwYa+odExamXV0HzAGkGzklrD/6wUOeHqWAqeNIcQUgk1PJfusvW8Pr8iryiJHzxPL8EV9quTHystQkUTVVdvhIUrF2Hshe7anZuVzbseV5yhyh4WStKpS78oTbHcJySB152A8icD7s0XFkLsRydYOGMxXyhNSboiXQ5SDHt0/n2fApHJPRbWkpWliqFHCwa6p/pCZASEkZv52ASM7PZHcD3AocMAC1ocGFlrkK6kUg3iFYbaLWYmx6oleaw/qpVnXa2WnZnwfQ48HPT+kGxbGmNW02Yv2Op5ItAN1dzAh3gY6HkeOjond9ay4JPVdPzt1LNrHHJAyf20LTWFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4cKQWsb2grxb7B0k9Obt1pLRdNlrrpOkIkUkF7Hwc4=;
 b=qFc3oCu2ncW56fRDtaOgSYjDBom9D0kxiosQ183z5ztImc22IhAxNoKgsEMa7VHZjVxJmc1SHi0jUivJAU43DFi+OrOpXX3XnLD8yi1C00NkyDG/9jbaA1q9nMC6FJe1P0iJGkedCVuEYIpS/jPRHz5zNEqwHsILM9nkoTE4d9c=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7200.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:344::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 14:31:31 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 14:31:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 15:31:30 +0100
Message-Id: <DJI7BIXM00EX.1QA63RTRJAC4T@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <m.wilczynski@samsung.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] rust: devres: add DevresLt for ForLt-aware
 device resource access
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-6-dakr@kernel.org>
In-Reply-To: <20260618230834.812007-6-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0048.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6f792d-3c31-4b22-a7fa-08ded2c67321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|1800799024|376014|366016|921020|6133799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G2OjPSOG5xPt6ay9E3n6oXSGQhD6O6XAMs1WOlz1+jLSYg0C+RY2A477PBowHvoPiMvBHl46p/QUHnv4ClXdS//L8t8CZ3JVW6CH6MY6e8IVOYShcDeSjPQLKzNFSs+Pzz5EX2eo1wuvpsF+3sQLiJsHGUCIS8bDK0JsFq3tdxOV08W7npQMLKDJgxfOzhOfso5POqNXlYTUGiQumPx12dXx9JITJ0HpP9auvw/0FnhJyGtWpMh1qxUNA7I/VUJnkn8D0iw0tZu9CXiBXhWzvIijyB9JGpGB6TTT0ACd1B6AciaXecAq+Bz/qcyyCBBKMpd+N4npev3O5mF2tFIauleclnie8+eJlkD8QlGNx1lqSlPDLQZ7BMbflEYytq97VQ5cJU0fBo43S/VwwFlHzNV34pDqs1182pVM1loX1Fb1SI/Pt7xaoVjKQvjytnJhY9sstW5drOTmQ3gLiBPkhU/M48bv5Ly/uSTYpmOBt6aRjn0XM+R6+wf5Vo0NVepQJTzQE3QNTQ+gIpqywCE7eYkGQVD9oyqFaePDD9DOqqp2RvW7Z6+26LHjrnabmmNs02K8Y2S7rGmPHztJ7HmZooxOm2QZAzoN1i4WQNk7DOCMNhztUrC9R/Foa0rhbcMbUBujnydWE58ST07fhKnShuPLKvNXzwd2YOrG08zZgsbVlbOOo0EehJT8CZAM1FabRzJr+/0pJLzJGLdfWgke2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(1800799024)(376014)(366016)(921020)(6133799003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?em9SVjJVZEJyOWZKSGVTZi9LTU9BV1AyUDAvYkNPaDQ1Y2paZE41WEl0WVQ1?=
 =?utf-8?B?QklqSlc3TmFaUVlzR0l0cmgvSGc3YzcxSS9XUUVOZ05xbFEreEJ1NWtFNjhF?=
 =?utf-8?B?YWtiQVZlL0dpOGQvOFRNUGRWSmszc2IzcXJ3aFlIaUh2bnFoY0k0V2lyQmNJ?=
 =?utf-8?B?SitNdXRqOXRZQnVZeTVoZlk3K0RvNVFGVUkrUnB2L3p4Wmc4OTNmRVVqTlhZ?=
 =?utf-8?B?WkpYQ1RtVmVBdDNvSDBqZVlrdWtsbGxrQkJJUXNaZXdScVJVY1lCUUNQcXIx?=
 =?utf-8?B?L29CbnFkbkxwNXkwWnM2UVlCZmN4S05ZcjZWd2ZnendaWmxuZjVSQkVKM2U4?=
 =?utf-8?B?RHZQaW5RcjhaZklQemo4OWI0UUVtV3FUT00yK01MNzVIOGRJQk9IM0c1bXpj?=
 =?utf-8?B?dVRSMFEvYkVNZk9ZS3piY3MvYmZQbWF4UG00QTllYzlMckZ5TEw4eHpqR2l1?=
 =?utf-8?B?dGJrN3RMOTFvcG5LUUVaejFpWWJoT0NOdC9taitnMjBoUzJqcStqQXBLb3My?=
 =?utf-8?B?SkpNRHVVL25vYnROWW00UnRCcDYzWElXRFlpWkpWb0F1cmpyTlYyeVlhUDlR?=
 =?utf-8?B?R3NWWVN1aTRneXNuN0wzVlFjazNReUc4TUpxL3J1NkJMZ1VNY0pGcEEzYlJn?=
 =?utf-8?B?SnF6MlB2b1BXNGllcCtzTlJXenVXQml1NGNPb0xrcFNlM2lITndWc2JDZDVZ?=
 =?utf-8?B?RzZZY2FCU1ZheVYvNkhaNjIyMThGYkdRcmE0ZDVxQWZyYzNkZEl3WGtwaGRG?=
 =?utf-8?B?NHgvdUZjbThDS1NrRVhNUUZLNFljU1hyWDBIYysvdkFaSkZXdWdidDFUYTNM?=
 =?utf-8?B?UHppSmpnbHVPalVoTm9McEp4UzBlRi9OamxaS1NSSXNmRExML1JJUE9DcVIv?=
 =?utf-8?B?OElsNkJ4QUxPVEpDNDNLZEp3M3gwZW5hQ0UrcHVxbEIzY3R1T01pMzdTdndN?=
 =?utf-8?B?NDhlTnN4OWFCblE5YzFsdVM0Sk5LK2o4RDlBZlpUSi96MVlBSGhOK0JiQnNh?=
 =?utf-8?B?SHJOWG1iTHJCZFl1SVliMDZ4Vld4a0lJUEYwQTczMlFXRGZpOGoyb3VmUi9s?=
 =?utf-8?B?RDNkUTl4NlFSa2drVGowZFZSTXFxVDFpbVBNa2d0cnBtM216UWF3SFJDTjN1?=
 =?utf-8?B?M3QwVk52UEtiRFJCcG1NZFprTEdvQlptU3hwMEhmZWlkSElBYmdscDkwYVZL?=
 =?utf-8?B?QUgyVmN4VmhRSFh6RVpsYm1DTW5WTEw4T1NadFlFcmRabmx0VVIzYWZkZmtX?=
 =?utf-8?B?c0dYOWtVajNlK0UzeHBpYzI3aU4yTWp3U3VaYThtNW94TW1XMlJRNVBwbGFx?=
 =?utf-8?B?MkN1UUJYNXlIQkFtY3d1U2tCYVF0WjVHUzJaczk2cWlBNGNUQ1FhekhnZHJx?=
 =?utf-8?B?SkpHSXBVck0yMUtZZnh0SjlQK0xNc0JacWx5c1Y3T2ExOHM5OGxEOEVibnBF?=
 =?utf-8?B?czBJcFNnYVFlY3JXZU9oOUo0MVZUcXlSbUM5OXhzS3hNZFVpZWdIb01kMlov?=
 =?utf-8?B?R1ZPVllrTHZHa25DWXAvY2hGdmVjY3dRRUh5YjVjcS9FTEltSnlQY1BWZHMx?=
 =?utf-8?B?aEVIbXE5YWJkaWlUUldlQUFuL1c5Q2I0WllMQnJXa0d1Q2pJYXh1N3lubXBI?=
 =?utf-8?B?M2h3eTJEaXhaSFZSNXdVVjV4SjRISGt1eHBVYUttMUszdVVMSlhxTXBTcWU2?=
 =?utf-8?B?YnhvSXZEWk5QbjRxM0ZMcVRVVHNTZWdxWTA1L2xuTkZsYXpOdFlGN0plcjBK?=
 =?utf-8?B?VWtIOFpScU1MRlMxcVYycjR0RDBBQjlXUWYycFpzdW1CTFJQeTVLLzVBMWFF?=
 =?utf-8?B?YktIeDZyc0huVUdvcm5ER2RHMjlPYzhJVnZyWmg0TjZZSTZxK0ducXNBTkIx?=
 =?utf-8?B?UEUzeTFHSkI0QlBLZld3L1E4empjSjFNQ3lyTFZ5WDdkR2xMN1dxcGlBNmN4?=
 =?utf-8?B?ckxzRGlBU08rcXNRZHRlb2liNG5BQW5uZ3VobnMvM0oyZUo3RGFzdldFekpR?=
 =?utf-8?B?eEplK1VmZTU5Ym1NaHNRSFBQam1RVFg0YWtkYW53YUJyT05oTE5YUnJlR0dK?=
 =?utf-8?B?ejJzcXFLNTNYZEZhU2ppOTlWOVFjd21lYlJqRVkyaUloSDhnMDc1NjQyNXVQ?=
 =?utf-8?B?MXdGWCszRnVJY09Yczh6NzErOVM4ZjdybmdBWktjOEVBbEJQM2d3RHJHYXhK?=
 =?utf-8?B?OWpiOGRoSFlCanZMNEl4U1NoRlEwbE5ZWXJ3MENhcDM1MnRCVTRpb2V0ZDR3?=
 =?utf-8?B?TzkrOEdtZ0VlSlA2aHlKcDU4bXpIUXN4VFVuMG5jVHQ2QzBoNXJ2ek01VDEv?=
 =?utf-8?B?elJGUGR3UTVTMmsybEczTGdtTGRYUHA1TlZ4alAwVklWSTU4NnVsdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6f792d-3c31-4b22-a7fa-08ded2c67321
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:31:31.1214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVyEmA998hH6U/n/Lhq9FGgUfk3j/Y8GthRVX75YT2z9zn6z2FY72Lm7UlMr5kgL9ockpDPHUgtgAJr1ex6NXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7200
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9388-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:acourbot@nvidia.com,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E643F6C6BAA

On Fri Jun 19, 2026 at 12:08 AM BST, Danilo Krummrich wrote:
> Devres<T> stores resources as T and returns &'a T from access(). For
> lifetime-parameterized types like Bar<'a, SIZE> that are transmuted to
> 'static for storage, this exposes the synthetic 'static lifetime to
> callers -- any method on the stored type that returns a reference with
> its lifetime parameter would yield a &'static reference, which is
> unsound.
>
> Add DevresLt<F: ForLt>, a thin wrapper around Devres<F::Of<'static>>
> that shortens the stored 'static lifetime to the caller's borrow
> lifetime in all access methods.
>
> DevresLt::new() is unsafe because the caller must guarantee that the
> data remains valid for the device's full bound scope; the internal
> transmute from F::Of<'a> to F::Of<'static> would otherwise allow
> use-after-free.
>
> Two access patterns are provided:
>
> - CovariantForLt types get direct-reference accessors (access,
>   try_access) that return shortened references via
>   CovariantForLt::cast_ref.
>
> - Plain ForLt types use closure-based accessors (access_with,
>   try_access_with) whose universally quantified lifetime prevents
>   callers from smuggling in concrete short-lived references.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/devres.rs | 100 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 11ce500e9b76..e11deff3e1be 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -24,6 +24,8 @@
>          Arc, //
>      },
>      types::{
> +        CovariantForLt,
> +        ForLt,
>          ForeignOwnable,
>          Opaque, //
>      },
> @@ -365,6 +367,104 @@ fn drop(&mut self) {
>      }
>  }
> =20
> +/// Guard returned by [`DevresLt::try_access`].
> +///
> +/// Dereferences to `F::Of<'a>`, shortening the lifetime of the stored d=
ata to the guard's borrow
> +/// lifetime.
> +pub struct DevresGuard<'a, F: CovariantForLt>(RevocableGuard<'a, F::Of<'=
static>>);
> +
> +impl<'a, F: CovariantForLt> core::ops::Deref for DevresGuard<'a, F> {
> +    type Target =3D F::Of<'a>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        F::cast_ref(&*self.0)
> +    }
> +}
> +
> +/// Device-managed resource with [`ForLt`](trait@ForLt)-aware access.
> +///
> +/// `DevresLt` wraps [`Devres`] and shortens the stored `'static` lifeti=
me to the caller's borrow
> +/// lifetime in all access methods.
> +///
> +/// Types that implement [`trait@CovariantForLt`] get direct-reference a=
ccessors ([`Self::access`],
> +/// [`Self::try_access`]). Plain [`ForLt`](trait@ForLt) types use closur=
e-based accessors
> +/// ([`Self::access_with`], [`Self::try_access_with`]).
> +pub struct DevresLt<F: ForLt>(Devres<F::Of<'static>>)
> +where
> +    F::Of<'static>: Send;

This bound looks weird. I know this is to satisfy `Devres`'s bound, but I t=
hink
this should actually read:

    for<'a> F::Of<'a>: Send

Best,
Gary

> +
> +impl<F: ForLt> DevresLt<F>
> +where
> +    F::Of<'static>: Send,
> +{
> +    /// Creates a new [`DevresLt`] instance of the given `data`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The data must remain valid for the device's full bound scope. [`=
DevresLt`] allows
> +    /// access until the device is unbound, which may outlast `'a`.
> +    pub unsafe fn new<'a, E>(
> +        dev: &'a Device<Bound>,
> +        data: impl PinInit<F::Of<'a>, E>,
> +    ) -> Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        // SAFETY: The caller guarantees the data is valid for the devic=
e's full bound scope.
> +        // Lifetimes do not affect layout, so F::Of<'a> and F::Of<'stati=
c> have identical
> +        // representation; casting the slot pointer is sound.
> +        let data =3D unsafe {
> +            pin_init::pin_init_from_closure::<F::Of<'static>, E>(move |s=
lot| {
> +                data.__pinned_init(slot.cast())
> +            })
> +        };
> +
> +        Ok(Self(Devres::new(dev, data)?))
> +    }
> +
> +    /// Return a reference of the [`Device`] this [`DevresLt`] instance =
has been created with.
> +    pub fn device(&self) -> &Device {
> +        self.0.device()
> +    }
> +
> +    /// Obtain `&F::Of<'_>`, bypassing the [`Revocable`], through a clos=
ure.
> +    ///
> +    /// This method works like [`DevresLt::access`](DevresLt::access) bu=
t accepts any
> +    /// [`trait@ForLt`] type, not just [`trait@CovariantForLt`].
> +    pub fn access_with<R, G>(&self, dev: &Device<Bound>, f: G) -> Result=
<R>
> +    where
> +        G: for<'a> FnOnce(&F::Of<'a>) -> R,
> +    {
> +        self.0.access(dev).map(f)
> +    }
> +
> +    /// [`DevresLt`] accessor for [`Revocable::try_access_with`].
> +    pub fn try_access_with<R, G>(&self, f: G) -> Option<R>
> +    where
> +        G: for<'a> FnOnce(&F::Of<'a>) -> R,
> +    {
> +        self.0.data().try_access_with(f)
> +    }
> +}
> +
> +impl<F: CovariantForLt> DevresLt<F>
> +where
> +    F::Of<'static>: Send,
> +{
> +    /// Obtain `&'a F::Of<'a>`, bypassing the [`Revocable`].
> +    ///
> +    /// This method works like [`Devres::access`], but shortens the retu=
rned reference's lifetime
> +    /// from `'static` to `'a` via [`CovariantForLt::cast_ref`].
> +    pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a F:=
:Of<'a>> {
> +        self.0.access(dev).map(F::cast_ref)
> +    }
> +
> +    /// [`DevresLt`] accessor for [`Revocable::try_access`].
> +    pub fn try_access(&self) -> Option<DevresGuard<'_, F>> {
> +        self.0.data().try_access().map(DevresGuard)
> +    }
> +}
> +
>  /// Consume `data` and [`Drop::drop`] `data` once `dev` is unbound.
>  fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
>  where



