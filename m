Return-Path: <linux-pwm+bounces-9233-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YJ8JK+kYIGoDvwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9233-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 14:07:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC56637515
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 14:07:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=tYybUmeo;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9233-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9233-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 160EF30BECBE
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2026 11:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE67477992;
	Wed,  3 Jun 2026 11:59:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022113.outbound.protection.outlook.com [52.101.96.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AED5472798;
	Wed,  3 Jun 2026 11:59:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487959; cv=fail; b=mHEi3LCjPCQjOnZyhB7Rnr+9Ft9xlDHm4PZn5UJ4QgOVJDhMq/nLfwFYreXbBk/zkuaLlwGpjTNNrjwbscMT44OXffbgaWak/Q7VM2AAj5/WyIbJgD8U5vxgT0qlMChzH5yJazoPMF7buK7fLD1UsIuIGu7W8aae/loamLND3ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487959; c=relaxed/simple;
	bh=9qsT6JxDc+a8BVzL6aVEKRNLGH21HbVIexHg895+GeM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=edZFOkIJqaHfagQGIH9sUCTscSgMPOZzaRXB3jp8/Zp1lNIpdmOcQ3KMNjCUDfaPYOrXc9/dKjzR+Tq6k/CnfypZV3aueqfK1LBcdnzHW/5BcUSmzWuo5QR2dpUFon/RnIEoFXLhpMnrFUjeQuZc7eABIw4ZLpEQun6mKzi2QRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=tYybUmeo; arc=fail smtp.client-ip=52.101.96.113
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTlornADj/B4sZ4O8VXwaVhNSzGhmuwJh4OeTALMNL9Ft3ZUufVUU8kgQQMneHiJASpByzChk25mdH3BEn29xTc2O4paaTlKWllZQJ48mmJxLcgR+l6uKme440iYBoOS0EyS4/dY+LbeI2H6uPiwUM7ZjWdDG7h7jFwNKAGjCG2m1W1iQFJ/wtoyq/xYwvZSg7pZS5f6dApcjrRz4FH66z18FgXEiLUBOKGxJc0tVu8yVOc+vBsFe2zOvmiaOg1h9qoHKlsC6KmAgQp5dPStfeJloJEdWQcsAMLZN5mCXOLL9dYSuarCPkeTunWD1CDcR53uyncAJsIXvrcUDZZ+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXyS9w8lBT6t5YDLirSKdxBYSkdaflIZh4/tW0mcOdQ=;
 b=BBKqM7Y2TgsFBB1oBcCZMkqA7gz7r6GPDz+Z02zRCRMVbzMzcgZTiXsUXIjIuDvgKE54ZreXW7B24K9uSTlrLPOf3lvc5buQ3zqmlJvqeNVh8NMGzefowUkMak0pey/JnFa9qdyt4DRcbuQVlaZ4dgfqwiIpukxwWlvFDvqyvTj1ETwmWnosz1hzGhCYFva5XNa5f2x9THzqZpGYd/3fYCTJ3ZlCXmm8mKsMhdCdkIA0V6g3cEA0k32n+/srwYxDfc+4iTrrqo0GqnbTdFs7eKR9d0MwD5dakpoKehMnYMp16Lq0r6OmVV59eZqYDrOZ46HJiHHXxOYNbXv+jLdu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXyS9w8lBT6t5YDLirSKdxBYSkdaflIZh4/tW0mcOdQ=;
 b=tYybUmeo7YzdR6rxRBZrfaMiQUbF2ZMNozu3s1A48UpAQNIVRPMTwhBNShSL/NX/m+vgVYcERiAyP4h7T2prXWoCwCzIoqO9fU5Hl1tu8jW5B7z8ULfL83r4XeUHGmceYvMaITjfpLPrVnYNFLosTBldkCvMY6jWY+UZvBNwMOE=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7703.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 11:59:13 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:59:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 12:59:13 +0100
Message-Id: <DIZEAXX05BMZ.Z6FPWIH8XP92@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] rust: types: rename ForLt to CovariantForLt
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
References: <20260603011020.2073650-1-dakr@kernel.org>
 <20260603011020.2073650-2-dakr@kernel.org>
In-Reply-To: <20260603011020.2073650-2-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0106.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: b76667f5-0de6-4c0a-5611-08dec16787d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|6133799003|22082099003|4143699003|5023799004|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	OV+OElU/+mxYNEbAwvf8Ihao12vNf3hLDU33OkUmTK5CkE3Qbexgp5LztTf4IusqJ4FQr9kGmLbKXQpT2a0yRpPYAO4EeBABvpJhvGHelS5z1A3kW85FfEc8wM4d5kwdeqaSmbMWR1ejTNeRyOZzgCldtLCa/Tg6xtAMTQpA0m/gVI+pNVpO7cpH8o3/4EmV1NaBLUHSzeEkyrSGS+Kjg7tn+6KNgfTc+BCXHHFmwuffkoNvsimd8Dm6TDR/+HgeYVbJLkpEG43laAvdv9GwDmmlXP2uxlclrYb/y7s11AwypM3ZI0eS1jruXfzGynn/ddj+0Jczz77rLhrxOZxX9D1ru0JjyU6xAjZwkOIn2PmQti31u/KZUGamfql0JzFT/Eb936qx06mn55A1Km+tr5gtPRdI3ESVs9ewSSnYpPGs6Zjw5xpqJKFMR6mRzuWQ+LBJ5rx9bRCVEQVeegadFQF0aDFei2sL5ohEQWUuyJcUQ1X6RmHowQsrnOLlYTv7VUFW+RABNeB+QkpZSW5JHAo6RvhiciDrVc29v/fCjcL9X/tzOtDmPXQZhuN4Pg1vQuDksUmcDp+AN8cL4MiVrfv2XUsjwiznSTm5S5oIMaTrxllTm/H3qzBDrkiI+3cF050v9dj++XO3hvtYJwoWeHos139a+/bpnHqUsB7Ao+mVlUPydRTUIvc6EKNHJ+6Y03E6H86xEdeT72ljley5yDVoTJCWUUdrbvuJ3kLCi44=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(6133799003)(22082099003)(4143699003)(5023799004)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVJSb1BlMmRoN1F0L2M4dmx0SVBXYXp2dUJ1RE0zR0tackxZb3lWeXlTVzBn?=
 =?utf-8?B?d1UrdittdFBDVnEwWGg3U2xiQUVxSlBJdzBkdFBnRjRsaXRtMlNWVXdEVEZW?=
 =?utf-8?B?Wjd4MnBxYS9KcWNYeExsMmxPbDJlWjZxb3dScFdTQTFOLzYzNFdxdGtzZmF2?=
 =?utf-8?B?N1Z4emUyTlhzaCtPMHdieTFUK09saTNpZUgwRlhKenZqdzhvOEtMVVlua0xz?=
 =?utf-8?B?RlZiTW1qdURuWWJkMVkrRUgyR1BmaloyUUFrRDNzMGllZmhVb1UrRnFVWHZ4?=
 =?utf-8?B?ZjViVCtlYVlId2kvcE50TXlVQTIzUS8vVTViTFhnNEtacWNxd3Q1dURpZDg2?=
 =?utf-8?B?amZ6SE9kbUI0cHRJQmFOQlZ4MmNRSGVIUGFSU3lUeGFLcHJpbFF6cnl2SVNW?=
 =?utf-8?B?bkNoNmZXYmh4RW5NV2o2ZmV5SGVEWjY0dW5jYlpkMVdZdUhBTmZBM3V0ZFpV?=
 =?utf-8?B?ME9vbmtOem0wditUa2lLWFFtZ1Y0d1htNVVyQjJndzA5VGxHM2hESVpJOWpB?=
 =?utf-8?B?ZnFyTUUwT0pGSE1NWStDaXpNdXc1K0cxNXM4VjBOMVVEeFhSMWUvV1QzRXlM?=
 =?utf-8?B?bDFaNC8rdzhzNnlSaHNQT1JzbmVOUUlkaWJ6UjVtOGNhZkszbUxKQ2tBazJq?=
 =?utf-8?B?VXNlVGZGYWs0bjhBTFVRQmtBM0NhRklnd2Q0YUxIdmx1RFA4d0REUW4xbGl6?=
 =?utf-8?B?ZkVsSlVKNDRwYkVRTnQzU3NEcDhrRXlDL2pZUERYakVSZS9iOVVHQkd6UkI2?=
 =?utf-8?B?dFZ2OFZvMHRHZkhrMWg0VEttZzJIcUJNR0UwdWxxbnl5OXkxbFVQeXNzdXlk?=
 =?utf-8?B?WWVSb0FIK0QwS2IyaGhNdWxndzR1TmZzSG1ZS1ErMHkxQmVrTmFnd2tDN3hm?=
 =?utf-8?B?ZGVoRWhTaEhUYlR4aHc1alQvMjRMU3VYTHBHLzJ6blFxWGVsTFMxZ2ZVb2tC?=
 =?utf-8?B?VUhONVVXM2RmdDFQOXRvcG1NaXJpendzZVFKRmJGS2RLYWhsT2ZkT0V5WEZR?=
 =?utf-8?B?Tzg4QjlxNXZ5NGI3SGVzWjd1OW5hWTV1eTdSTjJtR051d2xTUTZGVG9UMHRK?=
 =?utf-8?B?bFJWR2hXeTltREU4UllBejZlcFVRWUZQQUFDNzVNQlJhNHlsSitoRlVtR3N6?=
 =?utf-8?B?M0pDS2N1TWp6WFQzMWxMaXBnYW1GUXE0QWdLQlVHbkF1VEZsZzBUNXV1RlBi?=
 =?utf-8?B?WVdKbUZEK0JnNHNLV2tTclJwTWczbXQza2dOMGlxTE16a2NSemozSFEwVjkv?=
 =?utf-8?B?RHU0UUw2OFM1NVhGZEhSbWk2a3F2S1RHbjdxZStrQkhkOFNqdnVUcnREUHU4?=
 =?utf-8?B?bnhYTmU5T1dCZXc5WkxVWGFRSVIxWllaMGEyYndJbXl0VGk2Mzk3RENPemc3?=
 =?utf-8?B?bTVqc0ltaDIyL1NhVHdjcmNqNWxiNGdwTmFzK1FCcDVKb0NkVHA3NjhXakRV?=
 =?utf-8?B?Sm9taUJ2STAxY2h5OUY2ZzlmVmg2TGlOZzdSN1pYVFhaNWpBRFFzNlNtUERW?=
 =?utf-8?B?eVRVaFp3QndXNy8yNm83a05Fajl6dytjcTM4N1dUV0Z0SVMzMTBwOXpqaGRo?=
 =?utf-8?B?WmpkcVhML1BDTnZ4U2dkZ3BkcFdqbnl1UW9ZK2dGSG1FeFUxUXJYbSsxeDhK?=
 =?utf-8?B?Q3preUR5SkVHd2Z5cm9PbVkxUzBSK3lFSE9nVVJLOWFYZVhKaVN3clJySGYw?=
 =?utf-8?B?MUdDaEs0U052RE5uNmNSL25Qcm9sVEhINmRZL0loVkhPTnpyS1J3alg4VFJM?=
 =?utf-8?B?ckMvOUYxM2FXRGRFN0xzenY0VVFUSWl0ZlZkUHFVM2NZYmZXZExEdU9pb3FL?=
 =?utf-8?B?Z0tBVWhGdTV4VWlsOERuY0lVRUxqQ2UvSVFoOFpiSmRYMExFblQ0aTY1SDN2?=
 =?utf-8?B?dkFTSnVHaFp0RkNwMGFGYU5kSloxYitCdk5GemRDN0RrRS83eGM0NEhQY2lF?=
 =?utf-8?B?SGUrQnJwN0hSUUhIRENGaWwydmxFSnVMQk1QemVtZ2ZRVnBIU3hvZGVVL3RE?=
 =?utf-8?B?cExFSmRPeUxuK2RhTWxOTnpSenhreDFuOEt4MWZCcTB1bW9SSDBUbk1IUXBC?=
 =?utf-8?B?SjBoRUdYTklKb2hxeFpsMWR3a1J2QzBaTnVoZjRQaTFyOUJES2N5RjVNQWhk?=
 =?utf-8?B?YTNDa3ZJTVRsRDF3NXlMMlg2dU9ENnNiSm1DU0s0akJtM21WdTAwTklqSjdI?=
 =?utf-8?B?QXY5bnA1RVRHQVFML0szb1FKaGtZblJxZXEvWFZXekRWanQxY1NNWFFHdUww?=
 =?utf-8?B?STVmMXVJM05ycXB3enNjcWdJWm0zNFNiejZQWFFVdHZycXpFZU01cEtiU3B0?=
 =?utf-8?B?NnlvTmJETVhZY1N4K3hEdnB2RTAwQ3pGMHBCd0o4UUovWnEydnl3QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b76667f5-0de6-4c0a-5611-08dec16787d9
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 11:59:13.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FmksgNjab6tPMvcReJQEp2b+mkKXmi7g0w/dcCiwOpJWWu83TkmB1mXsU0OkrPJZHMdlJxOVIA77M44uagzfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7703
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9233-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:from_mime,garyguo.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EC56637515

On Wed Jun 3, 2026 at 2:10 AM BST, Danilo Krummrich wrote:
> Rename ForLt to CovariantForLt to prepare for the introduction of a new
> ForLt base trait that does not require covariance.
>
> The existing ForLt trait requires covariance, which enables the safe
> cast_ref() method. This rename preserves the same semantics under a more
> precise name, making room for a weaker ForLt trait in a subsequent
> commit.
>
> No functional change.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/driver.rs       |  4 +-
>  rust/kernel/auxiliary.rs              | 23 +++++-----
>  rust/kernel/types.rs                  |  2 +-
>  rust/kernel/types/for_lt.rs           | 61 ++++++++++++++-------------
>  rust/macros/for_lt.rs                 |  4 +-
>  rust/macros/lib.rs                    | 11 +++--
>  samples/rust/rust_driver_auxiliary.rs |  8 ++--
>  7 files changed, 57 insertions(+), 56 deletions(-)
>
> diff --git a/rust/kernel/types/for_lt.rs b/rust/kernel/types/for_lt.rs
> index d44323c28e8d..ef510ab6c092 100644
> --- a/rust/kernel/types/for_lt.rs
> +++ b/rust/kernel/types/for_lt.rs
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: Apache-2.0 OR MIT
> =20
> -//! Provide implementation and test of the `ForLt` trait and macro.
> +//! Provide implementation and test of the `CovariantForLt` trait and ma=
cro.
>  //!
> -//! This module is hidden and user should just use `ForLt!` directly.
> +//! This module is hidden and user should just use `CovariantForLt!` dir=
ectly.
> =20
>  use core::marker::PhantomData;
> =20
> @@ -15,38 +15,39 @@
>  ///
>  /// # Macro
>  ///
> -/// It is not recommended to implement this trait directly. `ForLt!` mac=
ro is provided to obtain a
> -/// type that implements this trait.
> +/// It is not recommended to implement this trait directly. `CovariantFo=
rLt!` macro is provided to
> +/// obtain a type that implements this trait.
>  ///
>  /// The full syntax is
>  ///
>  /// ```
> -/// # use kernel::types::ForLt;
> -/// # fn expect_lt<F: ForLt>() {}
> +/// # use kernel::types::CovariantForLt;
> +/// # fn expect_lt<F: CovariantForLt>() {}
>  /// # struct TypeThatUse<'a>(&'a ());
>  /// # expect_lt::<
> -/// ForLt!(for<'a> TypeThatUse<'a>)
> +/// CovariantForLt!(for<'a> TypeThatUse<'a>)
>  /// # >();
>  /// ```
>  ///
> -/// which gives a type so that `<ForLt!(for<'a> TypeThatUse<'a>) as ForL=
t>::Of<'b>`
> +/// which gives a type so that
> +/// `<CovariantForLt!(for<'a> TypeThatUse<'a>) as CovariantForLt>::Of<'b=
>`
>  /// is `TypeThatUse<'b>`.
>  ///
>  /// You may also use a short-hand syntax which works similar to lifetime=
 elision.
>  /// The macro also accepts types that do not involve a lifetime at all.
>  ///
>  /// ```
> -/// # use kernel::types::ForLt;
> -/// # fn expect_lt<F: ForLt>() {}
> +/// # use kernel::types::CovariantForLt;
> +/// # fn expect_lt<F: CovariantForLt>() {}
>  /// # struct TypeThatUse<'a>(&'a ());
>  /// # expect_lt::<
> -/// ForLt!(TypeThatUse<'_>) // Equivalent to `ForLt!(for<'a> TypeThatUse=
<'a>)`.
> +/// CovariantForLt!(TypeThatUse<'_>) // Equivalent to `CovariantForLt!(f=
or<'a> TypeThatUse<'a>)`.
>  /// # >();
>  /// # expect_lt::<
> -/// ForLt!(&u32) // Equivalent to `ForLt!(for<'a> &'a u32)`.
> +/// CovariantForLt!(&u32) // Equivalent to `CovariantForLt!(for<'a> &'a =
u32)`.
>  /// # >();
>  /// # expect_lt::<
> -/// ForLt!(u32) // Equivalent to `ForLt!(for<'a> u32)`.
> +/// CovariantForLt!(u32) // Equivalent to `CovariantForLt!(for<'a> u32)`=
.
>  /// # >();
>  /// ```
>  ///
> @@ -55,10 +56,10 @@
>  /// it.
>  ///
>  /// ```ignore,compile_fail
> -/// # use kernel::types::ForLt;
> -/// # fn expect_lt<F: ForLt>() {}
> +/// # use kernel::types::CovariantForLt;
> +/// # fn expect_lt<F: CovariantForLt>() {}
>  /// # expect_lt::<
> -/// ForLt!(fn(&u32)) // Contravariant, will fail compilation.
> +/// CovariantForLt!(fn(&u32)) // Contravariant, will fail compilation.
>  /// # >();
>  /// ```
>  ///
> @@ -67,23 +68,23 @@
>  /// the generic parameter but is in a separate item.
>  ///
>  /// ```
> -/// # use kernel::types::ForLt;
> -/// fn expect_lt<F: ForLt>() {}
> +/// # use kernel::types::CovariantForLt;
> +/// fn expect_lt<F: CovariantForLt>() {}
>  /// # #[allow(clippy::unnecessary_safety_comment, reason =3D "false posi=
tive")]
>  /// fn generic_fn<T: 'static>() {
>  ///     // Syntactically proven by the macro
> -///     expect_lt::<ForLt!(&T)>();
> +///     expect_lt::<CovariantForLt!(&T)>();
>  ///     // Syntactically proven by the macro
> -///     expect_lt::<ForLt!(&KBox<T>)>();
> +///     expect_lt::<CovariantForLt!(&KBox<T>)>();
>  ///     // Cannot be syntactically proven, need to check covariance of `=
KBox`
> -///     // expect_lt::<ForLt!(&KBox<&T>)>();
> +///     // expect_lt::<CovariantForLt!(&KBox<&T>)>();
>  /// }
>  /// ```
>  ///
>  /// # Safety
>  ///
>  /// `Self::Of<'a>` must be covariant over the lifetime `'a`.
> -pub unsafe trait ForLt {
> +pub unsafe trait CovariantForLt {
>      /// The type parameterized by the lifetime.
>      type Of<'a>: 'a;
> =20
> @@ -94,11 +95,11 @@ fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r =
Self::Of<'long>) -> &'r Sel
>          unsafe { core::mem::transmute(long) }
>      }
>  }
> -pub use macros::ForLt;
> +pub use macros::CovariantForLt;
> =20
> -/// This is intended to be an "unsafe-to-refer-to" type.
> +/// Helper type for the `CovariantForLt!` macro.
>  ///
> -/// Must only be used by the `ForLt!` macro.
> +/// Must only be used by the `CovariantForLt!` macro.
>  ///
>  /// `T` is the magic `dyn for<'a> WithLt<'a, TypeThatUse<'a>>` generated=
 by macro.
>  ///
> @@ -107,16 +108,16 @@ fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'=
r Self::Of<'long>) -> &'r Sel
>  /// `N` is to provide the macro a place to emit arbitrary items, in case=
 it needs to prove
>  /// additional properties.
>  #[doc(hidden)]
> -pub struct UnsafeForLtImpl<T: ?Sized, WF, const N: usize>(PhantomData<(W=
F, T)>);
> +pub struct CovariantForLtImpl<T: ?Sized, WF, const N: usize>(PhantomData=
<(WF, T)>);

I think I prefer this name to be stayed the same (so it has the "Unsafe" in=
 it
and is not too long).

You can actually use this same helper type for both `ForLt!` and
`CovariantForLt!` later in patch 2, by using different `N` based on whether
covariance check has been conducted. So

impl<T: ?Sized + for<'a> WithLt<'a>, WF, const N: usize> ForLt for UnsafeFo=
rLtImpl<T, WF, N> {
    type Of<'a> =3D <T as WithLt<'a>>::Of;
}

impl<T: ?Sized + for<'a> WithLt<'a>, WF> CovariantForLt for UnsafeForLtImpl=
<T, WF, 1> {}

Best,
Gary

> =20
> -// This is a helper trait for implementation `ForLt` to be able to use H=
RTB.
> +// This is a helper trait for implementation `CovariantForLt` to be able=
 to use HRTB.
>  #[doc(hidden)]
>  pub trait WithLt<'a> {
>      type Of: 'a;
>  }
> =20
> -// SAFETY: In `ForLt!` macro, a covariance proof is generated when namin=
g `UnsafeForLtImpl`
> -// and it will fail to evaluate if the type is not covariant.
> -unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF> ForLt for UnsafeForLtImp=
l<T, WF, 0> {
> +// SAFETY: In `CovariantForLt!` macro, a covariance proof is generated w=
hen naming
> +// `CovariantForLtImpl` and it will fail to evaluate if the type is not =
covariant.
> +unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF> CovariantForLt for Covar=
iantForLtImpl<T, WF, 0> {
>      type Of<'a> =3D <T as WithLt<'a>>::Of;
>  }
> diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
> index 364d4113cd10..3cb094d00548 100644
> --- a/rust/macros/for_lt.rs
> +++ b/rust/macros/for_lt.rs
> @@ -176,7 +176,7 @@ fn prove(&mut self, ty: &'a Type) {
>      }
>  }
> =20
> -pub(crate) fn for_lt(input: HigherRankedType) -> TokenStream {
> +pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
>      let (ty, lifetime) =3D match input {
>          HigherRankedType::Explicit { lifetime, ty, .. } =3D> (ty, lifeti=
me),
>          HigherRankedType::Implicit { ty } =3D> {
> @@ -235,7 +235,7 @@ fn #cov_proof_name<'__short, '__long: '__short>(
>      );
> =20
>      quote!(
> -        ::kernel::types::for_lt::UnsafeForLtImpl::<
> +        ::kernel::types::for_lt::CovariantForLtImpl::<
>              dyn for<#lifetime> ::kernel::types::for_lt::WithLt<#lifetime=
, Of =3D #ty>,
>              #ty_static,
>              {
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 4a48fabbc268..2167cb270928 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -491,14 +491,13 @@ pub fn kunit_tests(attr: TokenStream, input: TokenS=
tream) -> TokenStream {
>          .into()
>  }
> =20
> -/// Obtain a type that implements [`ForLt`] for the given higher-ranked =
type.
> +/// Obtain a type that implements [`CovariantForLt`] for the given highe=
r-ranked type.
>  ///
> -/// Please refer to the documentation of the [`ForLt`] trait.
> +/// Please refer to the documentation of the [`CovariantForLt`] trait.
>  ///
> -/// [`ForLt`]: trait.ForLt.html
> +/// [`CovariantForLt`]: trait.CovariantForLt.html
>  #[proc_macro]
> -// The macro shares the name with the trait.
>  #[allow(non_snake_case)]
> -pub fn ForLt(input: TokenStream) -> TokenStream {
> -    for_lt::for_lt(parse_macro_input!(input)).into()
> +pub fn CovariantForLt(input: TokenStream) -> TokenStream {
> +    for_lt::covariant_for_lt(parse_macro_input!(input)).into()
>  }
> diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_dr=
iver_auxiliary.rs
> index 2c1351040e45..92ee6a6d348e 100644
> --- a/samples/rust/rust_driver_auxiliary.rs
> +++ b/samples/rust/rust_driver_auxiliary.rs
> @@ -13,7 +13,7 @@
>      driver,
>      pci,
>      prelude::*,
> -    types::ForLt,
> +    types::CovariantForLt,
>      InPlaceModule, //
>  };
> =20
> @@ -60,8 +60,8 @@ struct Data<'bound> {
> =20
>  #[allow(clippy::type_complexity)]
>  struct ParentData<'bound> {
> -    _reg0: auxiliary::Registration<'bound, ForLt!(Data<'_>)>,
> -    _reg1: auxiliary::Registration<'bound, ForLt!(Data<'_>)>,
> +    _reg0: auxiliary::Registration<'bound, CovariantForLt!(Data<'_>)>,
> +    _reg1: auxiliary::Registration<'bound, CovariantForLt!(Data<'_>)>,
>  }
> =20
>  kernel::pci_device_table!(
> @@ -115,7 +115,7 @@ fn probe<'bound>(
> =20
>  impl ParentDriver {
>      fn connect(adev: &auxiliary::Device<Bound>) -> Result {
> -        let data =3D adev.registration_data::<ForLt!(Data<'_>)>()?;
> +        let data =3D adev.registration_data::<CovariantForLt!(Data<'_>)>=
()?;
>          let pdev =3D data.parent;
> =20
>          dev_info!(



