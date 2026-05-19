Return-Path: <linux-pwm+bounces-9016-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML/yIjNgDGpvggUAu9opvQ
	(envelope-from <linux-pwm+bounces-9016-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 15:05:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A60857F490
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 15:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BFF43004608
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7D4E3777;
	Tue, 19 May 2026 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="nmhl4RIf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022093.outbound.protection.outlook.com [52.101.101.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7044C042E;
	Tue, 19 May 2026 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195714; cv=fail; b=t/ei9ftOPlnbjGOpHDj2rzok57b6iXdmbsCqYujHZ+2PSAGL/fa4v4S9hcrJIOQYcaoIKqYddqcQRVTkhF0iyqYTy0EdWan+gBgwFEpIg/9MtDRyYKl1xID/VyR885dZ6fp0nUyC3juzod224Ltd0nryjK9EX1bw7ubTOfifo/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195714; c=relaxed/simple;
	bh=80FhujbtpiB/iQRhdeZfUeL3YtHXniIIVIpue+uUqGA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=hcn/1Mav57wXHkxpQN9grDJbJyJKlNaWLLyqwHRlB1R5YQlN1bxf0CleNX6ksNcuvGARjI3r2CdX2GlHrkC8ZwwDo76I8/Oej+RpyXbyR91QzwIE2/XVAOWDNVJd8T5F9M6GUH5IdWSDBgCpQ6le5ooQeidWQbKM3seCfP15QVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=nmhl4RIf; arc=fail smtp.client-ip=52.101.101.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQ9DqOSVwtZp91U8FPSYpqL3l9kSHmc84sMRjXbXKm9JCiJ0s0S0PnxMbR6qOP0CsCsmy8mdAor7pPFBjUryLsvEkj//TUmduHs7ZRj+mF3ckCgb7fdVmD9sA8TyCiSsKqI3C1hF57r5M+9j9Qr1qP0kxDFRJB40LYmbIjmXIqEktq4Fe6zQNlI4i6QGBYrXyOQkuFiZvYzKTlk5flLuJcMygskATb6L/F9hEXGAAQxPwiviuZCYiaXj9stNc4eLkP3JU9k1I8Sdtilz0irYxU7aLTM6XvoKKtD8qH2LY4IJCRRuOd23+5FYB+uO1c37RDvgmXmgR8w1Y9251JpNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+vcgrKLQye5xwnJq0ABNlJ+3GUWdjHxHSwbiipUnV0=;
 b=VJr51oMsOvueAjvLD58nQmdMPkaN6OcLSULwnWoY4m/Ur/a3V/EJkta/V2UsKZaM2Y4WD+wiix2iemvkthk05kDmme7gc6497WM661ybqUT1mUhyyn1jP97vUGiScDbT9iWvM9HBOn90+M6zzOPBMcCc0IdUoq7+kplP2dTvuQJ9V+fM0+Y5ryGyK4bRxzpFnWTo9a2Cv+cvc9QcRkKeZ+4XYV841inlCUPAsyvffLrDAtz1Fyc8sCeUBUp5uTwVuxL2r1Ssak32Lx2/1uZPUeCBYgOgGv4eAka/g4NVF2oi+S2fC/krexd4gTl6Xi1iITv+4AJ71XssAXQT+mFkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+vcgrKLQye5xwnJq0ABNlJ+3GUWdjHxHSwbiipUnV0=;
 b=nmhl4RIf6XgT2vZWHn6EZXGdOxIUp6ihwH+N+xASzy3q8bd6RlFfzmtQE/S4V485A4nz56EqHGacpGnT0aaoUR9OAQyiI7ooanfO/+5B2o1pLi4mLNj3/gMIB/V1Ky6jEavqMHhkemchxDQFcUzDKJ4ShKN961KMyNED93m9qMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB1961.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 13:01:49 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 13:01:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 14:01:48 +0100
Message-Id: <DIMO8OYXYPX9.29EJ9V0839G3K@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 05/27] rust: pci: implement Sync for Device<Bound>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-6-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-6-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0122.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB1961:EE_
X-MS-Office365-Filtering-Correlation-Id: 6118e75b-7070-461a-0205-08deb5a6ca39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003|921020|4143699003;
X-Microsoft-Antispam-Message-Info:
	XIqsRtFlWBb3t+6esWIkuUKQmGlRSGqrirMEu3orx1B2PpjVKv9dSQGyUUanxj49bqQv+Tk0wuyHaXj4Kw0ozdMfJsHAcXqaXhlPi1tkn3AlNIo16k39iqnlMr2jemrCun4f4CIjomgNJAeffzVjtdbWQqO+Ts7zfWU2cOgthAGxaEI4BD6Ejj1t6is/de6sdM9iVFKxKEyoVj1NEdP9mrDCV1imin6YcjIG5SYm6JqJNuyNp/GQLrY61fWtQ49+HFVWDW0cm86dN2c/fsXC+jQlDga3tXP+esz8sMECs1uAHs1YfsHMjwNTgADYnyimHS2vX2uzaeYZyiIXHZYWsFHwl41/s56bCu1sjkil0+bQ+uaA+KwvdC5Av+9t6ZoUwJu5KgDwNs7JbDFAulg5I0r643uxDqwRX2n4i1EcsrWy/a0lh+Q07+VyhMk4SRfeU1xg6cZPQorXJ896ZTdBI80HAx7UMahTAMRaxwsfLxOn6uMZzBN0nkQ/6IybFOLWvukrP15Xs9Et3tEZozfIughlMrjLhJVg/d6w9cLenybhOYTZY78ouy7WqwFSURX5JhASJYRE9shKrmcM3uICbBz+/yzuM93lYsLdawGjASJFWnag1E+46eR7Y8rcJe1yxDWMPBmEuKUmEzyU4tVIPKD4HS1TA2WCbSMBD6Aw6AhGKjgm5Leq2KfWRMFowEg1G47l9OnZCcqRVK89oUp9V+fk1yhljaf8C1vnr7WFLgk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(921020)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3hTZkh3NjZtZWs3aTNIU2taTGhkOERwUU1QZVFobWsxR1AwdGlZWFd4SkVt?=
 =?utf-8?B?a2xkclFTVDhrTjBTRm5jc0xoR3QwTTQ4LzFNWGNtc2swcGVrWG5iU3F1MGM1?=
 =?utf-8?B?OEl2cUZoeHZDcmM0MHZuU3lrakYzVVJCZXBKdWRnTkRwMnVYT0tBN00yUHNy?=
 =?utf-8?B?ZUdDb09SeVhiV0VQSFRWWjJMc0ZFN0FjZit1UnpHS3FRa0xEaWU1ekdyNmtE?=
 =?utf-8?B?OVRFUTFNY0VUQUJFQThNYkVUQ3V3SHNmN1p2eEtoQUVxdEVGeGVweUVNVUlM?=
 =?utf-8?B?RXQzYVRuQ090dnlSMk1QblU2ZUcva2xib3JIM3A3N1VJZGU2YVFib3JwdEE2?=
 =?utf-8?B?c1ZoTHRySVZxeHJmUFdpSzFVdkpJZ09xOTFrNFlaMWw0YlQ2QkVYVktEL1lu?=
 =?utf-8?B?dVJ6UVdtVVFyY0NwVWJvc3ZyVmdmdU94ODdkR3E0WXNKTUJNL1dkaDRFWkNM?=
 =?utf-8?B?Vk8zaGFoRWhRbnZxallDT0VTUXVjRWFVbkRDaVJLcXNkZWJjQ3N6a0FsYUE2?=
 =?utf-8?B?T3UyYjMra25FbnJkb0hiYzVaK1I2VkE5SFdvYzQzVEUzOVdqYnRCOWFaWWpQ?=
 =?utf-8?B?UG84cXV5bUxKd0lDTXNPd3pEeWtHcXF3bTliTEVFMVV6VVVYa3F5WUUvUDFK?=
 =?utf-8?B?azFvWVozb0xqYmhpY2Rtb2x4aWpSOUZkUXUwQVc5U2pxSEJOMXA1UWwrU3li?=
 =?utf-8?B?TTdYYktMeVIySTNLU0I2S2kzcFlqdGtmZU5vb2VhSkFNV1htZmZtUVFKS2pj?=
 =?utf-8?B?ZzJ6eU0rVU5KcVNXYjAwRGl0SE90ajY1RG1QcitPZmFOL0hiSC9FZkVXNDNW?=
 =?utf-8?B?Q000OHVaWUh2T0VjUHlnRldVVkQ1RmthQ3BqRFFpM3NzZS9FZmhqQXpMM0NW?=
 =?utf-8?B?TmJCRkN2YWNCSkZTbzArOHJrU1ZQS3hJUXV4VERWUEhrSDRFTSs1YnV3aVU4?=
 =?utf-8?B?bDdjWCt2aU9ad0lUcHdEUSs4ekhTUmd0SVZPNWJEek1NY2R6cEU0c1g3N212?=
 =?utf-8?B?eXVNS3J6a0xoV0lTVk5rTndEankwM0pwT0F0K2pLalRHeFhMY0oxSEVmM2xP?=
 =?utf-8?B?MXQ0VkdpVnRqeGoxSERmNHhmRlcxSnIrVU5sY1UrSU5JbmdDdGswNUxrTTRt?=
 =?utf-8?B?cmxPSVJSYW1ISnR1M0o5dGFubkpOOG8vM0JDdHlaZzRlTVdRWEhPb1JWTGt3?=
 =?utf-8?B?Z1l4YWltSFNpczg5TkRQZHlZSTBvTUR0bXA0UjhHNzNiSjRNLzhsQjYvZ3hV?=
 =?utf-8?B?R090K1Mwa3JTVzEvV2Z5SkZwSXFSQW1GMG9oTnJaRzJ4WVd2V1h3U3NJaFBm?=
 =?utf-8?B?OFI3OEJ5UlRHclI5YTNoc3JWd3J0MWVhK1JvbWZ6QUNKbm1KbmVnL1dSRExF?=
 =?utf-8?B?Z3V6ZTdFRTlwc2k3RWdoNTQwbmhkekVjSjgrY0IrNjhLYXdJdTdQZHZxcllM?=
 =?utf-8?B?NHl6aVZrRENhQVJiOXorN3YwNHhueUV4Zk9OSDlQMHJLNyt6MEh1alh3dCtI?=
 =?utf-8?B?T2N0a3VzNzdyVSs5MFdyOE1TTHNZREdWZzBLVFBzeFVKTVFGbm1BYmtnWVQ2?=
 =?utf-8?B?K1lkcUdyRGNYd2M3eVhiZE14TzdWTXRZUG9hRTM2NHNxZm14aTFsVWJzbnI4?=
 =?utf-8?B?Q0JCVHZQNHBLWGNIblhCRmM0Vm1JTFl3T0ZkcVRGUFFCZko0OHhOVzRRSGNw?=
 =?utf-8?B?QmlmRzJyMkZqMW8wbGFDNlRudFliNTBmRC9vd2FGaGFnNHlseVdlQVFGMy9D?=
 =?utf-8?B?MFh2a1ZLdy8wSUFtTGpGRW1IaFNNZm9WQnJaT3BCcGxxRUllTVRzQy9hNUR0?=
 =?utf-8?B?eWh0L1hEWFl4Nzc1UUdoZ3ZmTGVxVCt4eGdOSzc2UmIwaGpEZjZGVzc0VWhu?=
 =?utf-8?B?MkVMVTZvd3RRVE1JTjJMY3hXY2twNVJuNWdmZXBBRnRVN1FzZndBMGxFVG5E?=
 =?utf-8?B?dDhBUW1JY2tldzVNUUpDK3NYajRCTFZXTUJCdEJyWExqSk9iVkRxeVRiMlZY?=
 =?utf-8?B?Qm9qbTBlQjBzWXRvaEtibENBZkVXbkZXSXQwaThwN2h0a2oxMnBtL1NhRjEy?=
 =?utf-8?B?ZU1sa3ZqdEluQWZDNlo2RHZUVXVTbDBIaktmNTZuR3JDQlNITTEzVi9nRTQ3?=
 =?utf-8?B?UldhOGhJQWNmT2NtbzhCeXZDcTM1dlB2Y05WYzhvdUlaZE1oZzhtdWdQYTE1?=
 =?utf-8?B?UjFpajNDM2JkWUY0T0U0OThlQ3Z5Q2lLSFRhUnlueHVzbHlLU3hubXZSSk9j?=
 =?utf-8?B?ZVM3ZVFHWE9lc3A5MVJhNDIxN212NjAzOHNidU5ITm55Q203eE1GT1o0WkxL?=
 =?utf-8?B?MjZ0Mk9IZ25BYWRuaVZYWFhBNWJFeW13c3h5c1ZEdnhuT09OQTJxdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6118e75b-7070-461a-0205-08deb5a6ca39
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:01:49.5954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4A9J+dPTdRqCEFljsXOhjjsVrEWENXtFVpcdzcw5vOeVFZSBjITwxvJdr0luhuWQHLunG9RvNntm1iI7wRdag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1961
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9016-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9A60857F490
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 1:00 AM BST, Danilo Krummrich wrote:
> Implement Sync for Device<Bound> in addition to Device<Normal>.
>=20
> Device<Bound> uses the same underlying struct pci_dev as Device<Normal>;
> Bound is a zero-sized type-state marker that does not affect thread
> safety.
>=20
> This is needed for drivers to store &'bound pci::Device<Bound> in their
> private data while remaining Send.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/pci.rs | 4 ++++
>  1 file changed, 4 insertions(+)


