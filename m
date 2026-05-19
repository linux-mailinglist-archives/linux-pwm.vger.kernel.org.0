Return-Path: <linux-pwm+bounces-9023-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDT0CHGGDGo1iwUAu9opvQ
	(envelope-from <linux-pwm+bounces-9023-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 17:49:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C1698581B95
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 17:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A39AF3040BBB
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA27408017;
	Tue, 19 May 2026 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="YZO5qgVg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022123.outbound.protection.outlook.com [52.101.101.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9234C33ADA7;
	Tue, 19 May 2026 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205705; cv=fail; b=AtD2zkXadoveNLP/tUC2M3qTMM5nF3VGO5T11So6cF4eObQuKzr6RZyTvA8eIJ3z3DJ77V5xzAgkGwey4T/JmzHykQakB7ovZSPXyMxR7JOOQV9aP3rlo+V9azRKeqU3sCqmTqCfl6cC5yFYXolLldErqRnInwaFZrBMR103FKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205705; c=relaxed/simple;
	bh=0U+bE0GH80QNa3QmCjlE1/NR5gN3L5OJqWl0IEqtBoM=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=ZWjuWB54RR5sOnkwmRZLGkW0PKUY7OlOa4hIYJhRdJwhF5POPP2g6IMEGdCkSxhspsM7ocezjWNCzM7i0vErskEncmnlLSe0Ar2uilVgfcC/bxSxdF9xWXsBVBduJ5QYl8ONfdpUjTM4t4/icgZlOh0LsndOcWkjFVdtnz0eFsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=YZO5qgVg; arc=fail smtp.client-ip=52.101.101.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRpwW0PCxwh20hRlzwFLuyb9z/GyFUyOMJvos+65Nex/3gj5XHE+NmTpXr2SadRe/v1Qp9gGD2R0lGYxpRLBw9gPJjsM8B6G0kExDSrwcI/edGuhV6DGnPrbzg2CxYN1uEBahz3QZnlpS9QBlOWOgt8IzwCsHC99YfTgjVBFJnzGhLfdS8Y/eTFe6tjABe1ey7P3PshdSY+M43YVyomKLjsiczJtIgvDTBHza1P0GJKe5KAiOu+LCudCSFCUb3B9DURI43R7bbszBYH5j3tEncr5IV/VfXHR/DdVof3KnTnK4ivjOeUhZmPXFKqAGi8hYDCK4f7OeuOTadCE6vqHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWUpNM7isxXKoTib7UuSwPZ6InS/Xn57Xzna6dhmB1I=;
 b=vpNd+9yzPPYkjjKPFQVHu/Dr3/7czcgLVQ/cR9PHumt3E1h/PAM3/FyJuw25E+kz/cA7KDODO623dw5xYFrZ7Qrisnl5sAx1gt+xHyvkh8Y2U7SDpR3XjmVZ1EPnnqnDTMdm/rsz2sqDMAABFpWogqzESaLNqoAuolAnQgDx3FNLYTkXTxq59thr38Q1rGW7jJAqZgleoJE7ChgeEsrlqIraZruoo2sAuBOA/1l8x3ApAYVTeeYyO/jrfZIqxvvt19vFwcwElTtQkpy3VuCAj0tHD1tP0IxiVe9CeSXQsbMUHxiuCHMmsFDE/EbCWeUt4s/B+hvBN4A+I6krIEkYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWUpNM7isxXKoTib7UuSwPZ6InS/Xn57Xzna6dhmB1I=;
 b=YZO5qgVgeV0vuIXrNPpSCJUlkkBKOGHAtZOahQ+Qy420B7V58v0iczWs3nt2yNjixQ9V+sjNoo5D2IPqIUfFsGmxRX5YKFDwqj31iP6INcvQe4dJiJhv2vb7EtVD81i5oOioNJAFA7ehebrxW+LdRp2OJ2vOK2V+zL3Gzk6p2Ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB7106.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 15:48:20 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 15:48:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 16:48:19 +0100
Message-Id: <DIMRS6NPT1VN.3BHXH00SPJAVI@garyguo.net>
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
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 18/27] samples: rust: rust_driver_auxiliary: showcase
 lifetime-bound registration data
X-Mailer: aerc 0.21.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-19-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-19-dakr@kernel.org>
X-ClientProxiedBy: LO4P302CA0006.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 55851b44-38a6-4204-6a42-08deb5be0d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|22082099003|18002099003|56012099003|921020|4143699003;
X-Microsoft-Antispam-Message-Info:
	TLnXgxONmda0WJH3qIUlNo+VVH6jafTaqeptpIYNaFHvuaU0jTPYL7MKC8JVFNLGq545DZ+wIZ5XC88/sGd1gfBRgwP3dmNMa4zmp4kILC1ePFoNo7I23MHK4fYCKXi0IDGg/xBoGzKU8Rw03Esk59YW/8dKEWAYjN9wjmmRh7HUUTR4T0MkMnTsPzb24EeyGE1slnGOIyuwMirzkS5WEMCb3NA4eNjvY6iYTLTk7O4U5lW36A2e7+EZ1DqDygCw8vlRFF1k0dy4IUhi8t7bYUcHhikjRDoj7prw8Uz9KEuETIMTVQWQauQdT/+KBAWngk2qIfLMPbd5fNvxcnQqdnynbs7ux6VAafuxFq9ldTrmIr+HTNry5TIBPc8fMQO5zCXRLb/dPhrxa/1+sTJz98uY5IJUMZ2Gt5dJUAQl1xUPDTmgYUerK092u12kZykb5Dqp9oGtcsqmLHn/VB+zvs8+rm4Q/f6EJmlrVkJlQ8aE5L8N4F8A+IJE8B5LgL89TpvC0vesAzz68ZZRd4ZoUuJzFAb7DdU6y6MUJghvyffw0uQ+CJomE+mzpoDO121nCghon2fBaeOggQp6W/Vo/Vv/3pSu/6gpS2uj4F4JKzMhtRIoQ/qcAdZdj0f35zNohUXTL3NGm+6ALU8wjPK2ojZeGH/Xph0P0hR8udDFmh9992WYIm7/nQeNisQDpXM1AzfvRFsCPUW0CKq1XrD6YLhAXZ2OdoYpu2ylDm4FbaA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(22082099003)(18002099003)(56012099003)(921020)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0pKZjlDbGhmMmZnbUdjbHVEZkJRc29tU3BoRUVoalhienpYTHI1MTBPUnNP?=
 =?utf-8?B?cCtTeUNUZ2kyWEhmWkxyWit1Z0k5QlFHYlo0ZXhjRWFDS21uZzhCaFE2YTNh?=
 =?utf-8?B?SWtmWTdLSmtjVlF6VytNdjJMc2laV3huTmJuL3BibHE3L25WQ3dLbUM5Mm1M?=
 =?utf-8?B?OE0veDVRUzhqTTBTRGhLRVhhZEs0R0tEa3Fod09GcWl5cHNzOWJoaUtUa0JV?=
 =?utf-8?B?U0NoTG9JRlJGTlBDTWJxUituMHcrRUJNb3hUSHNyU0VvYnlDbmFidWsrZ2ly?=
 =?utf-8?B?eWlhSEZ0RjByVk9kbkUyamY0SG9FN3VBdVRUeDJDUFlKakliSzhORE1FR0d1?=
 =?utf-8?B?UXBIaWVnNjM5NDl1MG9qU0lEeUJiRjNBUkpoOTgyWlB2Mitoa3NNK0lueS9j?=
 =?utf-8?B?dHhsZTNRUVhUOHo1T0tFbnBTZyttVkxtckRRYU1jZjFtSkFXWmZQYnJSSFEx?=
 =?utf-8?B?TUlFZWRBQVRiSnNJUm13bXFZOFA5RkdpRGhBM3lwbEN0emJwQ2FhR2hOOUlo?=
 =?utf-8?B?bkNEQ0hMeTFLUXIrOEIzd09RK0Y2Tzh1bEsxMUpJSU4rM2FqSFVDRy9jOEtZ?=
 =?utf-8?B?cnlTTklLeUorbnFnL1VtalhSc0xRbEJaVHZTQkJ0emZMSTA3UGczT0YrcGVv?=
 =?utf-8?B?WWVWeHNaMDgvaVdWdlI1ZW1YVFkzaEV4Z0lyMThOSnoxVHErNThjdmdUWmNi?=
 =?utf-8?B?VjV6cC82S2E4a2Z2d3VjSzFqNkZ0YW1hT2Z1UWNNTTNtNjBSeS9aVU4zaGNw?=
 =?utf-8?B?WDk5ZGZscWZpakVuOFZzaS9COWhlRUkrV1FtcXk5QXMxUGJEMzdVSHBUSlNM?=
 =?utf-8?B?c3dKZHY2dW4wdlUxd0dQNmkrSnUya2g2WjBsZFo4eENmQi91MXYxRGU0MlBI?=
 =?utf-8?B?b0M3UDM0Nm0yV1NnU0UvbU5aQVRDNEZVaFVMMmh5OFJEWXl4Rzc4QjJTZk1k?=
 =?utf-8?B?cVA1QlhQbWpZb21BVDVTVytjQmt6Q2VXTGszRXVrcGhmQWRXYmNkQ3k2TTJG?=
 =?utf-8?B?RGo2ajVDU3p4b2FlT3UxN0lBRERUb25ZcXVOSFdpZURrNDRiaWU2UDhWUEZh?=
 =?utf-8?B?WjlYOFUySWh1VjJBaGJsMUp3TU9pNzRtdlJBcW5ueFNLQ2h2aHJsQWZHZ09w?=
 =?utf-8?B?N2pQSEZPTE53UEw3cmJEbE14ZFhFMHRHSHBqdWlua2FSVW5CMkw4QmNZUG5P?=
 =?utf-8?B?VjJod1UvaEpqQ09Ka0dBNzhsR0lZOXJMcXhhdnhVL3FWVGpWYmY5WmNsV3BG?=
 =?utf-8?B?NnlIWUg0MjQxbWIwU2dGOTlaVG5xV0NkeCtxRWZRN255bDlwQ09ucWJsckpH?=
 =?utf-8?B?UmN3SkhMc09TRGhHaGRKNmlicmt0UVNHMWlsT0JBeHk3eHlCS0NmN2M3cmJ0?=
 =?utf-8?B?ZC9Vb1EwR3kxVGk1cVJVYVYyNkpub2R0TGk3MEJDcEF0QVd5T2hIejN6ZURJ?=
 =?utf-8?B?Q29pbSthSm55cFkxcDdpTjZxYkhpOEZ2M3FRbmNqcm5nVFpGc2cweWoxUVB2?=
 =?utf-8?B?NUVzbUp4blJDMzIzeUlZZWlaK0d1L3dBN0wvRkpybFFTcWwxdmlDNVphejBD?=
 =?utf-8?B?UkRwYW5tNFNTN2Y0aklZUHF6YWxDaURnNEEyaHV6WGpxaXZZbmx4eE5LTlBt?=
 =?utf-8?B?dkhlTWJFdDF0eWlpRTJzbVl6WXNCMCtxNUpYM0dGTHlJWDJCSkJoUUx5L3ZF?=
 =?utf-8?B?TW03YW9EOUxHMnhIc0UrelhBTGNUNHF6czAxS1hoRktDNTkvb3phMDRyL3Br?=
 =?utf-8?B?SXdHSUZSR056bklwUUNJZmxPQkNKWm9ha0J2SGhSQnJYclFkRzNVQ01IUElP?=
 =?utf-8?B?WlV0alB3OHhMYk1qZzU0R1BLd2h1OHk3MVRHTnBFMU10dVZVSERmY0RGTDBZ?=
 =?utf-8?B?WWk2SGFKUCtzOXQxOTFiSThrMld5OElEMHROUE5WaGRhLytZdlYzcG5TMkZP?=
 =?utf-8?B?ZFVoKzZoY3c0dDQ4OVRkcmJJOW1uR1BDdEp2U0E0c0hVa1Y0SFN0NU9GQ1Jl?=
 =?utf-8?B?TW9yeXZFLzZ1S1lBYkxCWUZDM01qTG1oditLNWtCaVRoM3V1cHNDTDhVdUxW?=
 =?utf-8?B?a0Z6WU5Pb2cwQ05QS01iUDFxRThiTzYwNzBhQjRsU2VIRkx0OVYvRXJHRmtr?=
 =?utf-8?B?YVRhY056YzNtMm8xWS96L3BUNjN4dUlVUlNaUlgrK2lBUkM1ZnNQWVkzZGZY?=
 =?utf-8?B?bGlNeVVKb1RiV1h6eFFWMWVISWhNamcyNjlPUXdEZlhaMlF6aEJST01IbWh0?=
 =?utf-8?B?OVZncjN5L0xmQnk1UGxWaTBFWklLQzJtTXJ3UWNCbE5ESmcxVWVmSzlERFVF?=
 =?utf-8?B?SFBuTVRsWXZhL2EzaGtubjEwbGJaZVplcVZrYkt5Uy9mQXN5d1RuUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 55851b44-38a6-4204-6a42-08deb5be0d0c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:48:20.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOx5HxDHDPe/UVF51/IDZDABq7NPyv9n7j+yeNLExQ+awgE75Ijj8Mfgaz0ZvzE6BrhW/2iSfvtljCKnsl8RCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7106
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9023-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C1698581B95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 1:01 AM BST, Danilo Krummrich wrote:
> Make the Data struct lifetime-parameterized, storing a reference to the
> parent pci::Device<Bound>. This demonstrates that registration data can
> hold device resources tied to the parent driver's lifetime.
>=20
> In connect(), retrieve the parent PCI device from the registration data
> rather than casting through adev.parent().
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  samples/rust/rust_driver_auxiliary.rs | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)


