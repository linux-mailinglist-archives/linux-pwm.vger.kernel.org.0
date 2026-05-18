Return-Path: <linux-pwm+bounces-8973-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NNKBe8zC2qgEgUAu9opvQ
	(envelope-from <linux-pwm+bounces-8973-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:44:47 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFEF57039B
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37DFD301485B
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7CD44E043;
	Mon, 18 May 2026 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fDHE2FE/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020113.outbound.protection.outlook.com [52.101.195.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BA6404895;
	Mon, 18 May 2026 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118593; cv=fail; b=cu29/kQVQfhXRge4i7rk4Iw+jB2UtH1IwsdldJJWbz8AiuUD9R/RMkk4JY2QO/jI+Wo9yGVXsodr1gXmvCEKUHB1I/V1i65hmkhhdwsXI7/PhYdzmLLQz5Ih15zStuy4khAxz85qWsSBc88ttceWhgX4zOBf7VOn0TnrHOsQYVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118593; c=relaxed/simple;
	bh=1w3xUmt5BMsvfa7uNNjdzaKMELub5UKM4YU/jVPh098=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=X94bbcBO0EW2znX9Dwyp2PRbIq+Ze1wLCUotlBYXqA+SyC3fw8ZwBPwMX0BGkh2iUYnLiOzn3t5hyTxtkuAPFFTHShqfEmC7j4AiZ9yjc1xrZhDQPViPTqja868yA0jVWkY8MbgA48Pp4Plky5RnYGkH/tcRt9qh9JDhrXjC9ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fDHE2FE/; arc=fail smtp.client-ip=52.101.195.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUfrwGu6VEkUB+ZaTm1Ur3Ai3qapwMBk5z6FZCMiIea4kkoMKMAvY30kAjQp6ODNWyKzLz8I5BuLp2BXL90sr6svGYzxNr8E2ZkMVRBFyY7gJC49zSUHIDcUoWaBYfwv/KvD5Y5sK4SFDeZ0cEpIezqgCcnoAGNwPOqBEWyS1irvWxYh2l76h4TLK/S8lE3JCXIbaHWz2FxStgXv0R8gobLlRZfCxuwAV+6HoQnvfOLfS1nv8Dyx51358JhVNCKcbcYPZ51O9GOaCXIjHKgRmXR3KPNjBvjJLG2gpgSo9qFc+DyHqrQKZ+eOrv5g932edAqk3+Qg4UMF483Jv5b1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKjHB2QFXvYJWMAN4WnidWEgvW0Vy/z5udusgQgh0P4=;
 b=IeudAWgcEhuL4OJwEv9rwrYgcF9bwiR1SZJekXr5jmK7qaT2I8IonPe7kLFrNfbswoPP1356kQNe8lhrO0I6DSFsbO1jG/ZGAFHayNyEuZT8mGGCik8W/zxnf2LipDpf3IAiM/CZvLarwuJwp1ntVJq21B3qUL8BeAZrcGA9a55xea5YoGfdbGTYgXrjC1V8eLTkG5Rhjm0IfkVgjYHtvv+F3bxnk24kBkVyIHoDrmgJ3m+PVvJTa96grRB2jUTz5NDCv2N1DPfXuH3w2LDy37kuT2rWGORaCw9TQPdlRtvByYoSkQmVcIdZlDEJqKtR6esFuq59FUCBp7Hyx/lORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKjHB2QFXvYJWMAN4WnidWEgvW0Vy/z5udusgQgh0P4=;
 b=fDHE2FE/dL1jZFvIYqh9Ef4JosNBId+RisvPTnAnFytxSFZbs5pcJ8M3JtPTAXwRz9biqgEHgnwvqbSLkvDw56IRCj2Abx1M27oToGW94/yaJwRWUMH2GN4N5WPDMjz+9tOf+FQ+uboJVEfjBcqIdWunPPxXVQcuyURdvO4FPCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5727.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 15:36:25 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 15:36:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 16:36:24 +0100
Message-Id: <DILWWIPKW00V.2W06IJU4ET4AX@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 10/27] rust: pci: make Driver trait
 lifetime-parameterized
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
 <20260517000149.3226762-11-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-11-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0242.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6d3ecc-6cd7-418f-9c25-08deb4f338b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|921020|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	p9Wg8zWzvz9N3FFTYDEG82QSxJ6iA5FaVBVvETMRJiT56ve+QsFvB2+UR9hznZmgo97DpUGyq1lR9VRgfayUKdcSXQlt8zszac7MHLbTdJLKxdD7vwCWLRp3RmDc0M2dEO1//+8xJ5s6EPVmdO4dKl/HpaEMjsw6Bok4cQhr+NHaSI+GXEJb8fBP1L9eZoLrKFMUYjEuWzt9F3iYi6MkrtzbMIxkid9B+Ap1X932DR8eXDNnGAUV4Gb7fTS7DR2R7HJs2P0znE0KbYGZXog6ftAEOxTEUEaqaz5XmOGaMhyM2YlTIsvNv6MRblTUbPUTi0bWkf6CE/UlKDDHRKRNHKgLGuIi/7OWzwE4B/3Y/r6K8aHE0TicBjMEt01IhBcPhgZKDhds+6XU9c/DBbdD0iXox809F8EXJZFeKuBQ8WFBtaFNrdkoezkVrshV6tN7qHBcXYmZOH6/RH8gJTuOaDD8LUoYI2YgA+vXSYZjVq1uD8PiADeLNu8jPW8eGxFy8QL8fbI6z9AxuoUzMp760auf5vinGP+HgdPEUnNdwFA0Krpo/66JPOIrWRroNvQobfFvaQ/+3naBAKIIbD2FiW78Gmg/as9i3yHIw2/p70KGUPsERZbV4Kcbl38rDa3pQb5ACWqcbYj1XfR/5LHhjw4rKSnn0NGb5yU+RQwgq1hfrp92M3u4bi6dXqnTN2YaZJPgUWSX/ti1Bh8xkAie1xxDXP3ySJrqRNedBO0O2uA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDVIZmowWnNHRDVZOXlPZFdJbzY4dkJ6anNQVEgxeUt5YWhDc0lEdFRuTTNn?=
 =?utf-8?B?UDk3aVdOYkxnQW9RRzlybm1CbDZtL2FSK2VTaFRCV01lZVN1bDVvSThoeVNU?=
 =?utf-8?B?UHptRVFwRGx1NjZhcjNGYWdadUlFMnVUNEk3NEtkWElVMmppS2ZKL1RxVjYz?=
 =?utf-8?B?RGpHNGM4UGVqVWxjOUdBLzNmdWVaM0xFWXpNNjVOTUIzQ0ZGM0NIVTZuR1lF?=
 =?utf-8?B?N2k0NHRTb3pjaTdBSmtWbTF3K01nL0krZnptWWo0Z0RDOFlnbVdXbnBUK0R6?=
 =?utf-8?B?YTU1UE9kekhvbnBhTE1Ja3BvMEF6Y0owTjZaRkNYUmxsUFZkUDF5QjZrdWVN?=
 =?utf-8?B?OUZuQVNHallVYUQvODhDbHdVUHFTaldSK2R2WFB4akVaN3ZhWFBMeU02TjU3?=
 =?utf-8?B?dHRmMzdPcVhZNk5SVGRJQlM1Y3FBMlRneWJydjcwNjhSK2w2NFVRRk5hMEsr?=
 =?utf-8?B?TG5RMWRZSDlvNzBXVU0vaHIvS3NIU2xsbGkvek0xZ05hV1BuM29QcmFEZXA2?=
 =?utf-8?B?dVFMOGswRzkvVmJjMkQyU1NDMi8zby9wLzdjek50RTFUbUk3b3ltbFFZODNo?=
 =?utf-8?B?c0dJUzN0Rk1pUlRTSlpqR21qeGtWVENPWm9CN2tpWXVqRWVhNW04bUttZk5S?=
 =?utf-8?B?cmJPOXVjbEY5YkMyWHI2NmRybGtpNERqSlhQZkRzeTZxSkxZZmpYSElmMlVK?=
 =?utf-8?B?WnBMcE83Tkx6SDJMVjU0Z2d6dlJxdnV4RXBOYjRudVBGV1drOGtOenZqZG5R?=
 =?utf-8?B?YXpONnl1SXkrYnZyYmhocGFBQXRIVmp4VjhXbmcxd0RyMFZXOC9kbDJxZEg4?=
 =?utf-8?B?di9iNEdZUzA5a2RtUGhJTExPNFRrNlh4TEN3cUZkU1pSKzJFelV0QWgvcFc2?=
 =?utf-8?B?WVJEWmhTRGRVV3V3djlMZ3VYVXlGeUZRemtsTGM1N2gxWVgwdUpGZ1dWYzlI?=
 =?utf-8?B?T3FsTmg2cThHay9hTTNVQzFMOTZvVGNiZVYvQmZ2REpRUFRXK2JIZDZQMzc2?=
 =?utf-8?B?UmFNbDJzUWNQL2VTT1B1N0ZXMTRkVTJVc08yWE16eUZ6azhJOFh4a0NDYm14?=
 =?utf-8?B?czlUWVR4UmJGWEdlZUxoWVZSZGNiU3JQYm42M25KdmdzaHRtWW1XemNPUmVN?=
 =?utf-8?B?R3NnZUxGSkdFaXZERldFTnFxbUVKcXdmekRsczAzUGlIQm1XcWFjL2xuWnQz?=
 =?utf-8?B?LzUwYzFWZjlJRFltNG5BZGlYTlY1U0h6VFhON0hYYkEzQlZWN0JBQms3VFJY?=
 =?utf-8?B?enEzcDVQZWloNzBvSjJpTXJTNHNUOFdzYVRHWTNra1d2VnRxeXBWVlBFSGlL?=
 =?utf-8?B?bUsvRkVhTkNhTldXemxPT01Gd2o3TlBFdHFaYzduVGhQWDdnS2g2Tzhlc0Rt?=
 =?utf-8?B?bWZTQjJDeEljYWhnMDBTWkZ1cE1RQjEvQjU2L2FlOGgyUlVhUzVaUERFMlF5?=
 =?utf-8?B?cFlCQjNGTlBzQjduOVVCaks3T2p0V3kySFRNVDl5RllVRE55dFQyWlZOc3Uv?=
 =?utf-8?B?THpwUnZxbGg3N083cXIwQ0NHZU1jVGdVMGZyelgya0txeUpydW9odUxxakpK?=
 =?utf-8?B?WTFVUWorZGg4V0d6anVaajlmY3Z4WlUxRm5vVXlxcXhISDU1NHR5SDAxcEhv?=
 =?utf-8?B?ZlFabmhoSlIrT1kzYUw0dlRKbnV2OWRxcThrRngrTExGTzBZMk5MSmw2cjNn?=
 =?utf-8?B?dlBleGx4YW1pWGdueExtbldSalcxUHBBUlNHREkyVW5RQVF1RVdaYVk1YzZh?=
 =?utf-8?B?VGJjdjZuTTY0TVJYL3BUa0hiWU5HMzFyZHhJWUJwMEgxMlozc1Avc1VpbEwz?=
 =?utf-8?B?bHRtaUhhR1lOcTNjaTlqejNOODg4ZjdVSGJHS3poMHp5SHFYaXBIODZsL0kx?=
 =?utf-8?B?Rld6Um9lWHBZZjBFUHVTNzNWNFQzSXpHK3o3OXdDT2pLL2xOOEFyaEQ3SERh?=
 =?utf-8?B?b0EwdGx2dmRaU2poMitkVkg2aThqaVJlS3dLdk8wUlNMcmhvdHNqU0p3V0k2?=
 =?utf-8?B?ajJxZnRnL1N0Vk5TMWJFdFlSc3AyMmxSTEpnTlhVZlJUZEVPRW5hcU9teUxu?=
 =?utf-8?B?eGRGcVpxeDlWaURCMWNMREx4dk9JL01DMitKUkFzSWt5Z2MvSlRuR0UxbEpP?=
 =?utf-8?B?TzBpaDcyYWtUK1FzcmZzNWludkJJOE1tZWpqdGJodGtzWXhvbklhTFdQRlJ2?=
 =?utf-8?B?bVBzemVIZ3J0TnBVMmpPSWhBbzgvWjVqTzdtTjlUSzlnUU9sbUhXcFpqWVlI?=
 =?utf-8?B?c1J3VnNMMi8rSEFSME1CUlhGNDZaV0tDZHRlNm94T0Ztc1R0dnlqbndQWlFn?=
 =?utf-8?B?UzRvb2IwN0FyWEo2bG1Td1JFcm9jYlp1QThZWVhRVS9kTlNvVG8rZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6d3ecc-6cd7-418f-9c25-08deb4f338b2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 15:36:25.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dn7yaXToYNZ0qmSafDxCP7A+OqRGlsEAULtEHcgjP/QBlVbZ096P8o7FDI+xqjrywHDpRdJ7sHEnupAQ+8lQVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5727
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8973-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9EFEF57039B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 1:00 AM BST, Danilo Krummrich wrote:
> Add a 'bound lifetime to the associated Data, changing type Data to type
> Data<'bound>.
>
> This allows the driver's bus device private data to capture the device /
> driver bound lifetime; device resources can be stored directly by
> reference rather than requiring Devres.
>
> The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
> on the methods themselves; avoiding a global lifetime on the trait impl.
>
> Existing drivers set type Data<'bound> =3D Self, preserving the current
> behavior.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/driver.rs       |  9 ++++++---
>  rust/kernel/pci.rs                    | 24 +++++++++++++-----------
>  samples/rust/rust_dma.rs              |  7 +++++--
>  samples/rust/rust_driver_auxiliary.rs |  7 +++++--
>  samples/rust/rust_driver_pci.rs       |  7 +++++--
>  5 files changed, 34 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 699e27046c93..fe4eafe1ebf0 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -74,10 +74,13 @@ pub(crate) struct NovaCore {
> =20
>  impl pci::Driver for NovaCore {
>      type IdInfo =3D ();
> -    type Data =3D Self;
> +    type Data<'bound> =3D Self;
>      const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
> =20
> -    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl Pin=
Init<Self, Error> {
> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<Core>,

This is technically incorrect, as the `Device<Core>` only lives as long as =
the
callback. Having `'bound` would be incorrect.

This can either be addressed via

    pdev: &pci::Device<Core>, pdev_bound: &'bound pci::Device<Bound>, ...

or perhaps by adding a lifetime to `Core<'_>`

    pdev: &'bound pci::Device<Core<'_>>,

Best,
Gary

> +        _info: &'bound Self::IdInfo,
> +    ) -> impl PinInit<Self, Error> + 'bound {
>          pin_init::pin_init_scope(move || {
>              dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
> =20
> @@ -109,7 +112,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdIn=
fo) -> impl PinInit<Self, E
>          })
>      }
> =20
> -    fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
> +    fn unbind<'bound>(pdev: &'bound pci::Device<Core>, this: Pin<&'bound=
 Self>) {
>          this.gpu.unbind(pdev.as_ref());
>      }
>  }
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index c06ac3fb2a64..8060861199d4 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -64,7 +64,7 @@
>  // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `=
struct device_driver`.
>  unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
>      type DriverType =3D bindings::pci_driver;
> -    type DriverData<'bound> =3D T::Data;
> +    type DriverData<'bound> =3D T::Data<'bound>;
>      const DEVICE_DRIVER_OFFSET: usize =3D core::mem::offset_of!(Self::Dr=
iverType, driver);
>  }
> =20
> @@ -130,7 +130,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pc=
i_dev) {
>          // SAFETY: `remove_callback` is only ever called after a success=
ful call to
>          // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
>          // and stored a `Pin<KBox<T::Data>>`.
> -        let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data>() =
};
> +        let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };
> =20
>          T::unbind(pdev, data);
>      }
> @@ -279,13 +279,13 @@ macro_rules! pci_device_table {
>  ///
>  /// impl pci::Driver for MyDriver {
>  ///     type IdInfo =3D ();
> -///     type Data =3D Self;
> +///     type Data<'bound> =3D Self;
>  ///     const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
>  ///
> -///     fn probe(
> -///         _pdev: &pci::Device<Core>,
> -///         _id_info: &Self::IdInfo,
> -///     ) -> impl PinInit<Self, Error> {
> +///     fn probe<'bound>(
> +///         _pdev: &'bound pci::Device<Core>,
> +///         _id_info: &'bound Self::IdInfo,
> +///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
>  ///         Err(ENODEV)
>  ///     }
>  /// }
> @@ -302,7 +302,7 @@ pub trait Driver: Send {
>      type IdInfo: 'static;
> =20
>      /// The type of the driver's bus device private data.
> -    type Data;
> +    type Data<'bound>: 'bound;
> =20
>      /// The table of device ids supported by the driver.
>      const ID_TABLE: IdTable<Self::IdInfo>;
> @@ -311,8 +311,10 @@ pub trait Driver: Send {
>      ///
>      /// Called when a new pci device is added or discovered. Implementer=
s should
>      /// attempt to initialize the device here.
> -    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
> -        -> impl PinInit<Self::Data, Error>;
> +    fn probe<'bound>(
> +        dev: &'bound Device<device::Core>,
> +        id_info: &'bound Self::IdInfo,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
> =20
>      /// PCI driver unbind.
>      ///
> @@ -324,7 +326,7 @@ fn probe(dev: &Device<device::Core>, id_info: &Self::=
IdInfo)
>      /// operations to gracefully tear down the device.
>      ///
>      /// Otherwise, release operations for driver resources should be per=
formed in `Drop`.
> -    fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
> +    fn unbind<'bound>(dev: &'bound Device<device::Core>, this: Pin<&'bou=
nd Self::Data<'bound>>) {
>          let _ =3D (dev, this);
>      }
>  }
> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index e583c6b8390a..943655a85ec6 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -58,10 +58,13 @@ unsafe impl kernel::transmute::FromBytes for MyStruct=
 {}
> =20
>  impl pci::Driver for DmaSampleDriver {
>      type IdInfo =3D ();
> -    type Data =3D Self;
> +    type Data<'bound> =3D Self;
>      const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
> =20
> -    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl Pin=
Init<Self, Error> {
> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<Core>,
> +        _info: &'bound Self::IdInfo,
> +    ) -> impl PinInit<Self, Error> + 'bound {
>          pin_init::pin_init_scope(move || {
>              dev_info!(pdev, "Probe DMA test driver.\n");
> =20
> diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_dr=
iver_auxiliary.rs
> index 61d5bf2e8c0d..2f57912fe87f 100644
> --- a/samples/rust/rust_driver_auxiliary.rs
> +++ b/samples/rust/rust_driver_auxiliary.rs
> @@ -66,11 +66,14 @@ struct ParentDriver {
> =20
>  impl pci::Driver for ParentDriver {
>      type IdInfo =3D ();
> -    type Data =3D Self;
> +    type Data<'bound> =3D Self;
> =20
>      const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
> =20
> -    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl Pin=
Init<Self, Error> {
> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<Core>,
> +        _info: &'bound Self::IdInfo,
> +    ) -> impl PinInit<Self, Error> + 'bound {
>          Ok(Self {
>              _reg0: auxiliary::Registration::new(
>                  pdev.as_ref(),
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
> index f43c6a660b39..30b9311812f3 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -140,11 +140,14 @@ fn config_space(pdev: &pci::Device<Bound>) {
> =20
>  impl pci::Driver for SampleDriver {
>      type IdInfo =3D TestIndex;
> -    type Data =3D Self;
> +    type Data<'bound> =3D Self;
> =20
>      const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
> =20
> -    fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinI=
nit<Self, Error> {
> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<Core>,
> +        info: &'bound Self::IdInfo,
> +    ) -> impl PinInit<Self, Error> + 'bound {
>          pin_init::pin_init_scope(move || {
>              let vendor =3D pdev.vendor_id();
>              dev_dbg!(


