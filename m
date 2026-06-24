Return-Path: <linux-pwm+bounces-9366-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tFEBMLD1O2o4gggAu9opvQ
	(envelope-from <linux-pwm+bounces-9366-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 17:20:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 459826BF92C
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 17:20:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b="gx/qBGvU";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9366-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9366-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC793300E150
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 15:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5663D9DA2;
	Wed, 24 Jun 2026 15:20:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021098.outbound.protection.outlook.com [52.101.95.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1ED3BBFB6;
	Wed, 24 Jun 2026 15:20:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314414; cv=fail; b=tClcWEjtcV+Sij3RoDcs0ZM6rsWzhvrdqKYiPwcf6qsCnJ021sQmLvMjG95yJeZ1zJsunBbaCBVkmOapF4bgmyP01lah24aiL1qQhdH5eZUxZVDmKplTnriZ1zwtuAWgAKH9PVz8m0jQ7kpL5NlRKufORYQgowEV5CDNm4eky10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314414; c=relaxed/simple;
	bh=Dx48sCOIeEjqKJjcrrJ6DsMcmjD+jH3EaguOGpRi0nk=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=WvCUQIsnBPEOdvhcHjwxwzqwDsVXAFDN4EQvY5Pug0sAMpUs47ZXIlSd8Du+uau6QfwYmSlKCmYtclrGCwry4avohFWv1Ao4P5GwNvz+aDmKhzXaWkWmH40li2yjNUUF1z/AW+IUKbxjuDJxsrEwFHiaaAVxlyCU76UL/cnpEyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=gx/qBGvU; arc=fail smtp.client-ip=52.101.95.98
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bb/wZaDVkLfzgFLkrw4eAe/jbbDKicQey9eHX4YFLE8OBaKIWPzEofZZ7clczSWjEnBIyod3U1BN9yhQ61PWYI2MS+h7/P9uqTy67DFQOEhecllpi7G0wOBExQK8Z0Kplt+efy2msdvjBVLlK3G/FCUi35kyzOZKrH/TxwN0AqHMtFqCHhPh9LvpH3GA82ZDdTQclH90UoTrhvQYRtO/lg5D09k34c+WNuHH0myhx/MWx7bMe77R14TNHrio4St8IC8svFRHcWOUaaFJTjGgC3lxlDp2tIpcv/4r0/TbrBnHl82ETbCJXS3WWFGQFB0XWjQbdsZVIpT3dbLwwLLBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCoYQiqkZfZzH44wEnYPeuGbEmBt7NgPy/jp4tF8hVA=;
 b=FVAX9rtA/qPn0zjvRN4Td6pDlptReOvkt/Rgpcp8qADDRVWYSWHEUG1jZeSxZxj+XalQM8BP1puRB74KFC3WIQma5AielFAZbJMs0VswdXQ+DIHU+eR4MIVbmWxOdfVxshnQs2ZybmGWT1B4ei8ohkAl1sZQDpxTczb7Sw2v6JF2Gow+JHkchyQXszVy7630H/YSAcrju4IXPcvAeVC1FMIsyWhR6js4F5OE454yCDLee8oS1azXDsewrgf2IoTj7t5zkZhAEBQroz3soDyGyfS5WVVsZzx7IArdk+II13KED4DOwI05zEKFK43GmVEkxRGHXg+745tjghVOMyxiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCoYQiqkZfZzH44wEnYPeuGbEmBt7NgPy/jp4tF8hVA=;
 b=gx/qBGvUgZDCEDNbdlfn87XzQllYzR0KsQjcCJDNQ4oJT4ouJPV3WHLylX0UQB0yBqqBMTNuABlbiP2sAEvIy066gcZkIsLwe+NCALCiWGIJVOlOYPW4RMvZ8klnTY8dmHK9u9a2ydIUsCJ6ndGb0N56yQZpzarQRstpSZSuuek=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB6476.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 15:20:09 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 15:20:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 16:20:08 +0100
Message-Id: <DJHDQ7X94BXR.2XYSWSK79USDB@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
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
Subject: Re: [PATCH v3 2/7] rust: types: introduce ForLt base trait for
 CovariantForLt
X-Mailer: aerc 0.21.0
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-3-dakr@kernel.org>
In-Reply-To: <20260618230834.812007-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0331.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc07a11-6909-46ae-53a3-08ded2041415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|10070799003|366016|18002099003|22082099003|6133799003|921020|56012099006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	84EU6Q6JjoUx8oyzB1oyP3j0CpLFYTl80S7Wz1Je0QnwGepj7qnRqR/pMDMu2s978I9t9Sp7JLH1rFitBhuTqnG3achDMLV+88s2C8XY2++8cZ/g4EOK5/KTmqe7ssjRXvGIUxvsypKMp21zT0DCivZWppH2sWBB2GxC0Gl7nQzpXRohTCxAyj/G7RP18SsoDALGnEMi3GekqAbncYuhZKU8CLF4sxEpFgTrMkXsFsJTAWlQAkpAfPUuQ/5DmA8xICCgZTcq3SopToIJ6eRXMPQbFbwBPqeZk2vmEt+4dFSv1ef2KT03k/YrXURVEmx5/jRaPdHLiF9mAd89ZxdJpkTX4rZpD0V/o+M2zwCn58BJzx2AOZcvmdx2XfYUFK+rBP7oGZBMndQ4PSDagBqJfxkGF5v0SD+v+A+BGHpuXt3sBu0vT/bnIkDvMisBgitIT/mWQNkYbi+lxRfIjDTSeea2GBh0OgX7mDuyLZ/uUNtfv276U1+S6jVnHqLCh0rBBLgJQk8uvGypapOxeAU4zf0HJauQKUxSY1+7l6dSRGXpps32FDQIw+wSLxfXpZfueVqGYIaD0b1SB6dHS3RMELAzyrGFuym1MDP5UitByZK8Y+W1Wb6eKKkdCTMNyLcmz2E1QG2hnRdEvx+VQ73qyV0/g5ytAqkBtJrO6dLSkRnoU01MhOe/Fh+v08fL9KAlHhGquQdznstRiWAvzwqG2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(6133799003)(921020)(56012099006)(4143699003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWZSN2N4dExLR01SNmpYcG1IK2ZzZGtEYUFKaWhxbHExRTNyR0ZvRS93bnJC?=
 =?utf-8?B?SGJjUkFyYlFBbXlmSGpMdjQxSEZTVk9yc3RYWFR4NEgzd1l3M0Mxam5MZ3I5?=
 =?utf-8?B?S1BRclBsdU9YeHRsMXpidVBDK01YVlFWYWFYcTBZOVZNNjdoVEU0Zk5mcStS?=
 =?utf-8?B?c0tETE0rMW1jZUNNazFXN21MaUJwcGp0UlY3S0dJcHU1emtuQXNtK2VRVi82?=
 =?utf-8?B?L083b1VqVk5lSWc1KzB5ODJYS20yL21FQjdVNGF5eTB2ZkliMmJESFAreXRC?=
 =?utf-8?B?cGJOK2dkN1dJRE0zZU5BM1B5MEVXQlpQenJHMHZyS1MxeE91VjZqOEV3SlNs?=
 =?utf-8?B?MmlSbTBMcEEwcG5Wc1k1ZmFJbGwxSTFxMEdjU1RJUGR4bXpEblprV0hXWlFj?=
 =?utf-8?B?czZJazRRWjZ0clFKWFZ0TW53T0NoYWlqN2kyM3BKTjl1WVNMckVsbHcrZ1I3?=
 =?utf-8?B?NDlDVnlBNnNEMFNVZDYxZGZnekNCM2ZlQUo3WnpHcjM0dUxuaHJUMnVWNXlt?=
 =?utf-8?B?NUE1VDdnRW8wSFVpN3VmZFhaT3liRVV6cndwbG96MUp3THNPQkhxanBjZjFp?=
 =?utf-8?B?Vzk1d1REUElWb3h6czNkNHk5QkVvSVh2clduN1g1RWdlTDE3c3RSa1RIZnVF?=
 =?utf-8?B?V0pVdkpGNDVhWVJPblRQSE5DbnpPdG9ENnZabkp6UHFSQzlPV1U4cW13NE50?=
 =?utf-8?B?RUlVN3FPa0x6Sk1IS2ZWY1p2SFhkc3JSNHhtakkrNTdrNG02eWN0ejBYMUt6?=
 =?utf-8?B?UjlFYTRGLzJFNzlIMkN0WWlESldoeFdEa1NYUStKNXFZS3pUR2J5NjBkaFhI?=
 =?utf-8?B?YWt0ZU9QdExtZnZ1cG9zMEI5ZlJORlZZek9mZEFGYmpUVitPa3hqUjA3RFJu?=
 =?utf-8?B?UHVMYlJDOThiNU5UZWpMOFlGTFBSYkJpQlhMRXRJOCt0cEVROUhlUEpOSXF2?=
 =?utf-8?B?TlplTHBXalhUWXR2clJwUEFMR0Q0SzNMMDBZK1VhR0h3TkpCT0xNM1VpL01q?=
 =?utf-8?B?ekZPcFJZY0tCMjN1NTJnTGh6UmZvVE8zQUFhb2laNVFWUERkN0dvK3I4S3Bq?=
 =?utf-8?B?OS9yV2JsTXczTlBGaGpOck1tWVp4MkJGbE1iY09xRlhEYWxBaWNaQ0h4UThv?=
 =?utf-8?B?a2JVZlJlNHh6a1dTekgrYkk0RzkrRW9aNlBXNXc2SExydHdKZlN3S3R1aUhL?=
 =?utf-8?B?aEw2OGFQd25wWmk5YUNBTjVSTHhpZlRKWU1vdHdWL0ptTDhBWE5WUlFnSXM4?=
 =?utf-8?B?Q0hGRlhYMEhmWm13VHQ0ZncvSUxmMlR3M3EwNXRSR05NSUpJRUhLVC9pQ25E?=
 =?utf-8?B?bHJVRUY4OVpzYWpRNFJsTTlXYVBvRStzc0VwZ0lXMldqbXhHUjc3Y3p5RG9H?=
 =?utf-8?B?aFpDbElyUWMxbGtNZm5iQTU5Z2Q4YXVMeWQvdmFFcGNXeTNqdk9zbVB2SGYx?=
 =?utf-8?B?WFpvTE42VHhuT1lQeUhlV2xzbGJWRnBaZDBPaU56QWYvUmd6aXptSUhNNzFM?=
 =?utf-8?B?NG5LWVdtNUsxSEV3b21KL1F2aWRzL0FqeTJJRG1UYTJjeXIwbDZPdnpVWXFh?=
 =?utf-8?B?QlNEaDhLeXBEV0dZL2x0Nk01ZXJFWTZBdEJWWEFUZElmRTZVR3M3RjBkaTJ4?=
 =?utf-8?B?ZmllNHNPdDR5ei9hcXZzV2xTUUZpOTF0aFlCYS9vUkh3aGtYVmd3aDZ0Smc1?=
 =?utf-8?B?NDNvM2ZIa1hDTTB0MTc0bEptaWlDeGEzcmRGaHZ2VmtCWjJTSDFLNnRZRFIx?=
 =?utf-8?B?b1cwVnVweVJXQnRGdU9BSFRRbGM2LzN3OVduN3AweTNQK0tJZHpSY2UxQUg4?=
 =?utf-8?B?VzRaYUNCQW5HVHhCR1lHVTZNc1BHL0MwcU9haDRsSnhseVdQS0c5TTZ5b3hO?=
 =?utf-8?B?RDlQZmhSbFVYb1p5QTZuWkx5SFNiV29iRVJOY2FsN256cXkycEx5V25xTWhn?=
 =?utf-8?B?dzdKVGZmZFBady81dEd0amFYZUpOL3p3OXg0TVZYbVVJNEVGWGRZenNLMytl?=
 =?utf-8?B?cm55ZlJxNkpIYnlVek9zSFQ5RnB0ZCtWM2FYVVhjWEMwMHNWRmRnbDF4SFZY?=
 =?utf-8?B?Vjg0Wk1USjFRbCs4S1ZoN3BGSllYNDBwazZhVmxjclozWlZqaVRVVitRajdm?=
 =?utf-8?B?OFZYaFZEY3lNTUJ1d3dmd1VwT2pibGgwZ2ZqVzB4SjdFU3JYeExYa3V1SkQw?=
 =?utf-8?B?NDd6bEttdS8wM0R0S3YrREFVNmRtc1hCbVNoWGp4Z2RERlgwek5TTDhoZGN5?=
 =?utf-8?B?MHJLT2tYTlBzR3ZweHEvWE1RZ3F0WUhuRlFTODFPMTRWeWUrNzlPcjBRNVJW?=
 =?utf-8?B?THBMd0FHMGZoNUtJNU9GTWFvRkNCaUR4WHp5TXUzcnlieGJoRWVQUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc07a11-6909-46ae-53a3-08ded2041415
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:20:09.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z80bL53yR99oPAAL0AePucF7auXoOjELhTsLiUCLOQDcdOBC/9l689AHIISwwJUfnl2k3SyCXwnNXTLComs5Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6476
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9366-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 459826BF92C

On Fri Jun 19, 2026 at 12:08 AM BST, Danilo Krummrich wrote:
> Add a new ForLt trait as a base for CovariantForLt:
>
>   - ForLt (non-unsafe): represents a type generic over a lifetime, with
>     no covariance guarantee.
>
>   - CovariantForLt (unsafe): becomes a subtrait of ForLt that
>     additionally proves the type is covariant over its lifetime
>     parameter, providing a safe cast_ref() method.
>
> This split allows non-covariant types (e.g. types behind a Mutex) to
> implement ForLt and participate in DevresLt / registration data patterns
> that use HRTB closures for sound access, without requiring a covariance
> proof that would fail to compile.
>
> Both macros share the UnsafeForLtImpl helper type, distinguished by
> a const generic N: ForLt! emits N =3D 0 (no covariance proof),
> CovariantForLt! emits N =3D 1 (with compile-time covariance proof).
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/types.rs        |  1 +
>  rust/kernel/types/for_lt.rs | 72 +++++++++++++++++++++++++++++--------
>  rust/macros/for_lt.rs       | 53 +++++++++++++++++++++------
>  rust/macros/lib.rs          | 19 +++++++++-
>  4 files changed, 118 insertions(+), 27 deletions(-)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index cbe6907042d3..c1ed05d1046c 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -14,6 +14,7 @@
>  #[doc(hidden)]
>  pub mod for_lt;
>  pub use for_lt::CovariantForLt;
> +pub use for_lt::ForLt;
> =20
>  /// Used to transfer ownership to and from foreign (non-Rust) languages.
>  ///
> diff --git a/rust/kernel/types/for_lt.rs b/rust/kernel/types/for_lt.rs
> index a11f7509633c..0b53494080b7 100644
> --- a/rust/kernel/types/for_lt.rs
> +++ b/rust/kernel/types/for_lt.rs
> @@ -1,17 +1,59 @@
>  // SPDX-License-Identifier: Apache-2.0 OR MIT
> =20
> -//! Provide implementation and test of the `CovariantForLt` trait and ma=
cro.
> +//! Provide implementation and test of the `ForLt` and `CovariantForLt` =
traits and macros.
>  //!
> -//! This module is hidden and user should just use `CovariantForLt!` dir=
ectly.
> +//! This module is hidden and users should just use `ForLt!` / `Covarian=
tForLt!` directly.
> =20
>  use core::marker::PhantomData;
> =20
>  /// Representation of types generic over a lifetime.
>  ///
> -/// The type must be covariant over the generic lifetime, i.e. the lifet=
ime parameter
> -/// can be soundly shortened.
> +/// # Macro
> +///
> +/// It is not recommended to implement this trait directly. `ForLt!` mac=
ro is provided to obtain a
> +/// type that implements this trait.
>  ///
> -/// The lifetime involved must be covariant.
> +/// The full syntax is
> +///
> +/// ```
> +/// # use kernel::types::ForLt;
> +/// # fn expect_lt<F: ForLt>() {}
> +/// # struct TypeThatUse<'a>(&'a ());
> +/// # expect_lt::<
> +/// ForLt!(for<'a> TypeThatUse<'a>)
> +/// # >();
> +/// ```
> +///
> +/// which gives a type so that `<ForLt!(for<'a> TypeThatUse<'a>) as ForL=
t>::Of<'b>`
> +/// is `TypeThatUse<'b>`.
> +///
> +/// You may also use a short-hand syntax which works similar to lifetime=
 elision.
> +/// The macro also accepts types that do not involve a lifetime at all.
> +///
> +/// ```
> +/// # use kernel::types::ForLt;
> +/// # fn expect_lt<F: ForLt>() {}
> +/// # struct TypeThatUse<'a>(&'a ());
> +/// # expect_lt::<
> +/// ForLt!(TypeThatUse<'_>) // Equivalent to `ForLt!(for<'a> TypeThatUse=
<'a>)`.
> +/// # >();
> +/// # expect_lt::<
> +/// ForLt!(&u32) // Equivalent to `ForLt!(for<'a> &'a u32)`.
> +/// # >();
> +/// # expect_lt::<
> +/// ForLt!(u32) // Equivalent to `ForLt!(for<'a> u32)`.
> +/// # >();
> +/// ```
> +pub trait ForLt {
> +    /// The type parameterized by the lifetime.
> +    type Of<'a>: 'a;
> +}
> +pub use macros::ForLt;
> +
> +/// [`trait@ForLt`] subtrait for types that are covariant over their lif=
etime parameter.
> +///
> +/// Provides a safe [`cast_ref`](CovariantForLt::cast_ref) method for ty=
pes that are proven to be
> +/// covariant. The `CovariantForLt!` macro syntax is the same as `ForLt!=
`.
>  ///
>  /// # Macro
>  ///
> @@ -84,10 +126,7 @@
>  /// # Safety
>  ///
>  /// `Self::Of<'a>` must be covariant over the lifetime `'a`.
> -pub unsafe trait CovariantForLt {
> -    /// The type parameterized by the lifetime.
> -    type Of<'a>: 'a;
> -
> +pub unsafe trait CovariantForLt: ForLt {
>      /// Cast a reference to a shorter lifetime.
>      #[inline(always)]
>      fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r Self::Of<'long>=
) -> &'r Self::Of<'short> {
> @@ -99,25 +138,28 @@ fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r=
 Self::Of<'long>) -> &'r Sel
> =20
>  /// This is intended to be an "unsafe-to-refer-to" type.
>  ///
> -/// Must only be used by the `CovariantForLt!` macro.
> +/// Must only be used by the `ForLt!` / `CovariantForLt!` macros.
>  ///
>  /// `T` is the magic `dyn for<'a> WithLt<'a, TypeThatUse<'a>>` generated=
 by macro.
>  ///
>  /// `WF` is a type that the macro can use to assert some specific type i=
s well-formed.
>  ///
>  /// `N` is to provide the macro a place to emit arbitrary items, in case=
 it needs to prove
> -/// additional properties.
> +/// additional properties. `ForLt!` emits `N =3D 0`; `CovariantForLt!` e=
mits `N =3D 1` after a
> +/// covariance proof.
>  #[doc(hidden)]
>  pub struct UnsafeForLtImpl<T: ?Sized, WF, const N: usize>(PhantomData<(W=
F, T)>);
> =20
> -// This is a helper trait for implementation `CovariantForLt` to be able=
 to use HRTB.
> +// This is a helper trait for implementation of `ForLt` / `CovariantForL=
t` to be able to use HRTB.
>  #[doc(hidden)]
>  pub trait WithLt<'a> {
>      type Of: 'a;
>  }
> =20
> -// SAFETY: In `CovariantForLt!` macro, a covariance proof is generated w=
hen naming
> -// `UnsafeForLtImpl` and it will fail to evaluate if the type is not cov=
ariant.
> -unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF> CovariantForLt for Unsaf=
eForLtImpl<T, WF, 0> {
> +impl<T: ?Sized + for<'a> WithLt<'a>, WF, const N: usize> ForLt for Unsaf=
eForLtImpl<T, WF, N> {
>      type Of<'a> =3D <T as WithLt<'a>>::Of;
>  }
> +
> +// SAFETY: In `CovariantForLt!` macro, a covariance proof is generated i=
n the `N` const generic
> +// and it will fail to evaluate if the type is not covariant. Only `N =
=3D 1` gets this impl.
> +unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF> CovariantForLt for Unsaf=
eForLtImpl<T, WF, 1> {}
> diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
> index e1233701d6cc..d5f728a464ca 100644
> --- a/rust/macros/for_lt.rs
> +++ b/rust/macros/for_lt.rs
> @@ -176,8 +176,10 @@ fn prove(&mut self, ty: &'a Type) {
>      }
>  }
> =20
> -pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
> -    let (ty, lifetime) =3D match input {
> +/// Resolve the higher-ranked type into a concrete `(ty, lifetime)` pair=
, expanding elided
> +/// lifetimes as needed. Shared by both `for_lt` and `covariant_for_lt`.
> +fn resolve_hrt(input: HigherRankedType) -> (Type, Lifetime) {
> +    match input {
>          HigherRankedType::Explicit { lifetime, ty, .. } =3D> (ty, lifeti=
me),
>          HigherRankedType::Implicit { ty } =3D> {
>              // If there's no explicit `for<'a>` binder, inject a synthet=
ic `'__elided` lifetime
> @@ -188,7 +190,42 @@ pub(crate) fn covariant_for_lt(input: HigherRankedTy=
pe) -> TokenStream {
>              };
>              (ty.expand_elided_lifetime(&lifetime), lifetime)
>          }
> -    };
> +    }
> +}
> +
> +/// Produce the `'static`-substituted type for the WF check. Shared by b=
oth macros.
> +fn ty_static(ty: &Type, lifetime: &Lifetime) -> Type {
> +    ty.replace_lifetime(
> +        lifetime,
> +        &Lifetime {
> +            apostrophe: Span::mixed_site(),
> +            ident: format_ident!("static"),
> +        },
> +    )
> +}
> +
> +pub(crate) fn for_lt(input: HigherRankedType) -> TokenStream {
> +    let (ty, lifetime) =3D resolve_hrt(input);
> +
> +    // Make sure that the type is wellformed when substituting lifetime =
with `'static`.
> +    //
> +    // Currently the Rust compiler doesn't check this, see the `ProveWf`=
 documentation in
> +    // `covariant_for_lt` below.
> +    //
> +    // We prefer to use this way of proving WF-ness as it can work when =
generics are involved.
> +    let ty_static =3D ty_static(&ty, &lifetime);
> +
> +    quote!(
> +        ::kernel::types::for_lt::UnsafeForLtImpl::<
> +            dyn for<#lifetime> ::kernel::types::for_lt::WithLt<#lifetime=
, Of =3D #ty>,
> +            #ty_static,
> +            0,
> +        >

This is still unsound, as I mentioned in the last version that the prover m=
ust
be kept.

`'static` helps with a specific case where it ensures that `ForLt!(for<'a> =
&'a T)`
requiress `T: 'static`, but when another lifetime (that is not 'static is
involved) the prover is still needed.

A very simple case

    fn test_for_lt<'a>(x: &'a ()) {
        let _: ForLt!(for<'b> &'a &'b ());
    }

this needs to fail the build because 'a and 'b are unrelated (otherwise fro=
m the
type you would be able to obtain `'b: 'a` from nowhere).

Best,
Gary

> +    )
> +}
> +
> +pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
> +    let (ty, lifetime) =3D resolve_hrt(input);
> =20
>      let mut prover =3D Prover(&lifetime, Vec::new());
>      prover.prove(&ty);
> @@ -226,13 +263,7 @@ fn #cov_proof_name<'__short, '__long: '__short>(
>      // Currently the Rust compiler doesn't check this, see the above `Pr=
oveWf` documentation.
>      //
>      // We prefer to use this way of proving WF-ness as it can work when =
generics are involved.
> -    let ty_static =3D ty.replace_lifetime(
> -        &lifetime,
> -        &Lifetime {
> -            apostrophe: Span::mixed_site(),
> -            ident: format_ident!("static"),
> -        },
> -    );
> +    let ty_static =3D ty_static(&ty, &lifetime);
> =20
>      quote!(
>          ::kernel::types::for_lt::UnsafeForLtImpl::<
> @@ -241,7 +272,7 @@ fn #cov_proof_name<'__short, '__long: '__short>(
>              {
>                  #(#proof)*
> =20
> -                0
> +                1
>              }
>          >
>      )
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 2167cb270928..e970769609f3 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -491,11 +491,28 @@ pub fn kunit_tests(attr: TokenStream, input: TokenS=
tream) -> TokenStream {
>          .into()
>  }
> =20
> -/// Obtain a type that implements [`CovariantForLt`] for the given highe=
r-ranked type.
> +/// Obtain a type that implements [`ForLt`] for the given higher-ranked =
type.
> +///
> +/// Please refer to the documentation of the [`ForLt`] trait.
> +///
> +/// [`ForLt`]: trait.ForLt.html
> +#[proc_macro]
> +#[allow(non_snake_case)]
> +pub fn ForLt(input: TokenStream) -> TokenStream {
> +    for_lt::for_lt(parse_macro_input!(input)).into()
> +}
> +
> +/// Obtain a type that implements [`CovariantForLt`] (and [`ForLt`]) for=
 the given higher-ranked
> +/// type.
> +///
> +/// Unlike [`ForLt!`], this macro additionally proves that the type is c=
ovariant over the lifetime,
> +/// providing a safe [`CovariantForLt::cast_ref`] method.
>  ///
>  /// Please refer to the documentation of the [`CovariantForLt`] trait.
>  ///
>  /// [`CovariantForLt`]: trait.CovariantForLt.html
> +/// [`CovariantForLt::cast_ref`]: trait.CovariantForLt.html#method.cast_=
ref
> +/// [`ForLt`]: trait.ForLt.html
>  #[proc_macro]
>  #[allow(non_snake_case)]
>  pub fn CovariantForLt(input: TokenStream) -> TokenStream {



