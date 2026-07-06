Return-Path: <linux-pwm+bounces-9603-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wzBnJJykS2qKXgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9603-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:50:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 280D0710C76
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:50:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=Q2kTwKXO;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9603-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9603-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41D653062CC4
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3791B436BFF;
	Mon,  6 Jul 2026 12:44:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022091.outbound.protection.outlook.com [52.101.101.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA7433BB1;
	Mon,  6 Jul 2026 12:44:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341889; cv=fail; b=rQt7gOAuEnlwSNQLs/yx71gI4zxMOEc6VuxrTrwydt+kTG+ZxGei8lv7WqICAmGKRq4DbAeP4ly6A+iDleHzgBPXTBLRVbPX9uBvLsM9z5y7WW6ITapITmQ5lzCJN7IvAK8HIrhxGcFnqsgfLL8LnyRFLdIg06XDHvSDI712MLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341889; c=relaxed/simple;
	bh=iuUeO26ZkAqr/0gNyHWhANyroy7Ni3LlQ8Cf56MUbEA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RNy7sXB9yKJH3cfbUxbaQL9mZ+lOJZa2aOMz/5I+hgBHUQ1P9HSV4xlS144j/9+PqP6dpICH1GBTofIbKu/VCewS6kW/39QigpPMBDS8dH7vqirHWPNXq6gydEJHmBLwocv9X2wFb/mFMNxBWdCvb3tX5b2Rod4wYXXCaGl1Bic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Q2kTwKXO; arc=fail smtp.client-ip=52.101.101.91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M36wUErHDtIHTXOdAx00PWrU58Sut6GF95CBMfDMHuHGw8bqPucDNJS0a7nXuiR/9dFWuyJSd5TohPCDf4j63YKMr9/QjiBMzwc8OkfgZ8z67bD/NYOW3B79PnQTCv6rTJHuS3LCcmm8BrV1i7t6MQ05a9lwRju401DZgZ/WPUokHGRiqDySBXAMQtDbHRKH6NULI13QJqGzcFgfnG5t0ysdoZ7PSoWGFKSwVvh7tVViK86X5kaJzptb9wD8G09RS02CmMCnLDkI5/GEmyrqHG3my6q5l3P9EHEIkShMqUL/hB3NIgzKnvCJR0vQU1th8C4Ximybq44ieyhCBDcCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUyW2drMKEzUMIH8zFzt2TpbpYmjYxANtK55crlYnqs=;
 b=fv7VbCQgWnNRIKtPLWZfoqS7DYsIEHDTQDJedmCmfi8bMZjME/AHIqwqA397FLkj/ELp4vgWnAeSRThqt3O0D1Y/4ynAaQ/KHJcTkkzyH/NRaeyvqMd/pOgIPGbuEizBNMVgesRw5iFRyuCGv9N4i4rbQql1p11WEgqgmtpRK8svtXYuQ4Md6esjuZeqQdrChNjIP3fpfDzRyCmMtAOHUyevrim0uBp1rI59b1/WACnzezV2HFUYyiFJhXzblyumEyIeIAh/XzWB/w+/ah4vBWRkMCqoMNKz09NvHYEuuzPBwbgcb+k2h8bEUrPZWKSXWRFcjWRsu1fYU4GrWhgA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUyW2drMKEzUMIH8zFzt2TpbpYmjYxANtK55crlYnqs=;
 b=Q2kTwKXOpjfMI14O2KX2zqRVv+sgBXHB2gJhbCad5J1SEox2e1Osw9TeLL/hPHwCjA2z9gdq+N7wlCl52HkSxPYNJwn6oDKqx0bpA+FKfm4hNcQLCysyVD2GKZsosytjNc+YdZN7vB9loP12/GeP81z2ralQBJ1XPzpJmjuBbuo=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:30 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:30 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:26 +0100
Subject: [PATCH v6 13/20] rust: io: add projection macro and methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-13-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
In-Reply-To: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=5819;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=iuUeO26ZkAqr/0gNyHWhANyroy7Ni3LlQ8Cf56MUbEA=;
 b=+FX6Pp0mpXzpkifXFgAgNK03P+dWRS8Zv1nyUVRO2VexbjpqhVIo1VRPYTUUZ17d4VrYlIVIE
 LHMs9RBf84qAyK09htItjq4P8Q/9A0BO4OJFy394oSeScyVTlG8Z7EH
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: fff4ab70-7ef4-410c-e46a-08dedb5c52b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|5023799004|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	J5xg+/UZNPoq7431DvNmqh7KibkojJDYnFCvlIrQ7/rnR3JU05PzenVm7nrZvwwHtC37kaQAU324PhelUaxxocTABW92lY85ZIGrIVZrda3O435fmSATzWde3dpGrnQTL5hM9W9oDL45MNHHqFdiJEHdrh8FqVkENVG09RpaxoRev7QysMxVikn2zJjgvaw4iAVsZIyekZ6d27RRo1Vm0NpEoNQt3eSAapHKoj9t54enFGp6wwOV5qiv1DZZSIFc5RFkRetstag0PbZTF0MjTCM+zXqN2SD5KNSQ7xuDaxUqouWvAxmiZaP8hj+uldZfFtdsZITHETcUDCZgyJaiCa/Wubd1GZCcA4VdOwwaCZcYoS1UCYfjDfilKhG0EZlBEFM0cYpmDxXoYKHLzSqueh3vyEe6y+RE6wKq6FJj/XvlaS32TeOUibtLtW5kje3xlqQbL9Nbd0taYS++r3vLO++O4eTT0BNuaGF5VSRBFhoq+gGWvBJbYjC54s0EYjREJvXNDiLJC5VHh6xHx5uGv2GQRciksVSVd3BNn7Kk/HgjOi6ZRwVCiRqkqAtM7xIDRORrf8z1bs8jXQgWa3uplwzw1kI5uoZPj+rnpgGg2LA4NaXlhqV8rt0hdhsReZANtFL6f6fEAogtXYTA/kY+nDavQRP3n6fSsh9Mmt9iQ6mJ9NYodHYNEvdd/abrTAVEB+h+jsuRITPkr58mxbIRww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(5023799004)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1RwM2xPYXhGWjhyWFgrRDljQmg2aFZiNUU2b2ZpbnJzRENZclEvWkdHaTN3?=
 =?utf-8?B?Tnlkd3ZXQ3V2V1BkM3BGRC9EMDQzSVhiY2NzaURGTEl5S1h6dVpMekxZOUJw?=
 =?utf-8?B?OFc4SURoS1l6amJtL1JlNnJ3TzdDelBRdEFrTTM0RGpMRUhTMTNEL215bUpj?=
 =?utf-8?B?VlZIYXc3aFVBcTY0Z3dsWC9ERzh1ZUlHZzRHT1EwYzhwbjJ3dWViQm5HVGxQ?=
 =?utf-8?B?MVJSZi9HWCtYYzVZa255dm1kNUJqZk44UzZweTBBaFJlNmhTVnRqOFZJUGEr?=
 =?utf-8?B?a1dFbk1Cc3k2bzNnZitPMUZQTXFqUFRidlVXZVBTajB1ODhuSHdrUDZqT2tK?=
 =?utf-8?B?R09qUkZGcTQvMEU0SEMxeGpQMnNqNFpTQkhFVzRRc2pHRkcxZ043dHBlMDE2?=
 =?utf-8?B?VnZpaDFUNTBKandLRm5Xdlo2V0NWd0R1eFRzdW53eUxaVG50SWIwMFVUcWRM?=
 =?utf-8?B?ekRNRDF5c3dvK05lSW5ydzRLZ21uZzNPYTZzM244TDlIZ1FpMmdmdzN4RHVT?=
 =?utf-8?B?YnRtVjlZOEFsRzhCbDFESmFVQXRYS2dmdml4Zjg4NDRHTDZQYmdyTjJMSnpM?=
 =?utf-8?B?WWtuZ0VTaTlrUlFkdmlXdmE0bHhmRVMxY01iQWk3TzltUCtISUJZOFAwSDVi?=
 =?utf-8?B?b0lDdTB3cUpqWXQweExGSzdtTGlMOEFjemVCV1gvQmhkQTZVeWRCZmpSdjNu?=
 =?utf-8?B?bnRUMU5qbHBSczhaRHl2R0wrYk11VkpybnFxc0JOYjRLSFdNUmM1T25uN3E1?=
 =?utf-8?B?cUliRGR3ckVpTjB3YlZLSjhoS2dhSjRQSWdaWHRKdHNzbEVEWlBhaWh1azZW?=
 =?utf-8?B?U1ZDZXlTcTViNkdiaTBzZDFnc3RkRG9MTmE5eGRhc1pSYTNwQTd4ZzZUaVhL?=
 =?utf-8?B?aEo0RHdPay9MaDlMTVFWcVByMlVkNWp0RXQ5bEErbnVJWXU0QVdmQjFqZmdu?=
 =?utf-8?B?QUQralp5MTJXUS9IcTB0OFVOVmJuRmRyTE1URDlMZ1NCMm55V3Yxa3BGdjQ5?=
 =?utf-8?B?WXNjNDBGSHRZYWRFWFdYUkR4M1NXa090NW5henFwY2M0UmwyYS9mYUFjck12?=
 =?utf-8?B?M01EbzcrdVo2T2NGNE1mOXp4VkxCRDBocWhFM3pkd1RiNVRpQStISkNVNWNH?=
 =?utf-8?B?NE1kdENCaTcrQWdVVEJ5SnFrVEgySEMrRlNERkJlNUg5aXEwYUxJWkJST24x?=
 =?utf-8?B?S3JWekF1RTJLNFRzUFJmSm1MMSs4cUloa01zQWh1YjBCekFPR004ODE1QUdt?=
 =?utf-8?B?NEFJZTFPcFM1L0ZjekVxdU1OakFKY1JrWEJ4a3lQUTFOZWdXM281YTBocDho?=
 =?utf-8?B?K1htQWFJNkZmUWNxMFIwLytXQkZtaFRsYVNzRVd0R2tOQXV5Z0RRRWcwSWRE?=
 =?utf-8?B?am10Ri90NWdIaUZVUncxZ3RVVWE5YWtvS3hBQWIwUmZXVDNzckhMUUp0Z0ZC?=
 =?utf-8?B?RmcyYXdCL0dsd0Z0d09ydTNESTVnOTBUWVBhTWhVMkRNMVd4cmJnK0ZpTnN5?=
 =?utf-8?B?WTIrY0pzMml3SW5PWGgwMTNjVW5teTJNeWhlaWlYMmYwdUs3eXhQRk8wZ1dl?=
 =?utf-8?B?TWxjRWIxRHFIeU1tM3o1RFhzak1ndFNsSTNwSlRxK1NZamFEeXdmcnlhK2hI?=
 =?utf-8?B?dkZZdjF6bStJWUhmZGNnNzVXNGNXVXVzd0pKQWVFV0lUTFdjRmZ4NHp4ZDdq?=
 =?utf-8?B?RSs5cGFmbTBLT3kvQnNaczBYQzN6eUZlQVg4VU5vREJwWEdPSk1xZlNVQU00?=
 =?utf-8?B?RVpDUHhRQUNWejhkeXdRdDlWUzN5RXo1b1E5MUJrU0VMU2FCa3BFNENRSkhO?=
 =?utf-8?B?dk8xdzZJcUxDUEFHL3NZTjZnMlgvSTJQODZuTy81MExxS0Z6amNQNTN1M2Jh?=
 =?utf-8?B?L1Y4cHlPK3dEeTUxblBndVVWQ3NJWDk3T2h2NUgwUFRCRjNoZklNSWFadzdE?=
 =?utf-8?B?TVpQcW84OG83OXhHV1BRbFArOFdJVjA2eE80bXBIVmZvYWF5SkhseWN5S2Zr?=
 =?utf-8?B?TVVDamZ6R0hXQ2tTNE1saEJCZUNKbG9QeHJSQW9zeThZZjNpb0tkOVM1czg0?=
 =?utf-8?B?bU0zdkgwVy9RTWtRbDhZcmFJYTh4WFBWQlNhWXk5R0VyOVpwQ1hGbldzbXJk?=
 =?utf-8?B?SXkvRHN3WDZPQ1NvRGtjQkNPVG5ldkg3TXo1NnRqYTgwb3pYSzB0dnZtRFNO?=
 =?utf-8?B?VHc2S1JVYXFvdzZ6OHRYTkJ6bTNuRmE3MWljNG84cmMwbEc0VExNUk91RmRL?=
 =?utf-8?B?YU9ueEl2STdUdE1PQ0RLSnRXd284dnZLRVdFbmF6VXRQWGZuMGx2N2VyYis0?=
 =?utf-8?B?L205SVp3cWVSVGgrQUgwN1F2VUV2OGdjWjF6QUNOTjQ1bHFzT0RQQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fff4ab70-7ef4-410c-e46a-08dedb5c52b2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:30.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzwTDTS0gV3JLLr00blZ8QtxhtHJLgcgiblpXlrVgLgfSdc93A1UiKMVwjZfsGqaW1FgpvNySpOG3jz6vRDU8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9603-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 280D0710C76

Add an `io_project!()` macro to allow projection from `Io` to a subview of
it, using the pointer projection mechanism to perform compile-time checks.

For cases where type-casting is required, the `try_cast()` function may be
used where the size and alignment checks are performed at runtime.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index ab970e8b2e78..62643b23e904 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -49,6 +49,7 @@
 /// - Size of the region is at least as large as the `SIZE` generic parameter.
 /// - Size of the region is multiple of 4.
 #[repr(C, align(4))]
+#[derive(FromBytes)]
 pub struct Region<const SIZE: usize = 0> {
     inner: [u8],
 }
@@ -90,6 +91,19 @@ fn size(p: *const Self) -> usize {
     }
 }
 
+// SAFETY:
+// - Values read from I/O are always treated as initialized.
+// - Per type invariant the size is multiple of 4 and the type is 4-byte aligned, so it is padding
+//   free.
+//
+// This cannot be derived as `derive(IntoBytes)` as the padding free property comes from type
+// invariant which the macro does not know.
+unsafe impl<const SIZE: usize> IntoBytes for Region<SIZE> {
+    #[inline]
+    #[allow(unused)] // Rust 1.87+ stops requiring this and will emit unused warnings.
+    fn only_derive_is_allowed_to_implement_this_trait() {}
+}
+
 /// Raw representation of an MMIO region.
 ///
 /// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
@@ -339,6 +353,51 @@ fn size(self) -> usize {
         KnownSize::size(Self::Backend::as_ptr(self.as_view()))
     }
 
+    /// Try to convert into a different typed I/O view.
+    ///
+    /// A runtime check is performed to ensure that the target type is of same or smaller size to
+    /// current type, and the current view is properly aligned for the target type. Returns
+    /// `Err(EINVAL)` if the runtime check fails.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::io::{
+    ///     io_project,
+    ///     Mmio,
+    ///     Io,
+    ///     Region,
+    /// };
+    /// #[derive(FromBytes, IntoBytes)]
+    /// #[repr(C)]
+    /// struct MyStruct { field: u32, }
+    ///
+    /// # fn test(mmio: &Mmio<'_, Region>) -> Result {
+    /// // let mmio: Mmio<'_, Region>;
+    /// let whole: Mmio<'_, MyStruct> = mmio.try_cast()?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    #[inline]
+    fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a, U>>
+    where
+        Self::Target: FromBytes + IntoBytes,
+        U: FromBytes + IntoBytes,
+    {
+        let view = self.as_view();
+        let ptr = Self::Backend::as_ptr(view);
+
+        if size_of::<U>() > KnownSize::size(ptr) {
+            return Err(EINVAL);
+        }
+
+        if ptr.addr() % align_of::<U>() != 0 {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: We have checked bounds and alignment, so this is a valid projection.
+        Ok(unsafe { Self::Backend::project_view(view, ptr.cast()) })
+    }
+
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
     fn try_read8(self, offset: usize) -> Result<u8>
@@ -979,3 +1038,72 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
 // MMIO regions on 64-bit systems also support 64-bit accesses.
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_relaxed);
+
+// This helper turns associated functions to methods so it can be invoked in macro.
+// Used by `io_project!()` only.
+#[doc(hidden)]
+#[derive(Clone, Copy)]
+pub struct ProjectHelper<T>(pub T);
+
+impl<'a, T> ProjectHelper<T>
+where
+    T: Io<'a, Backend: IoBackend<View<'a, T::Target> = T>>,
+{
+    // These helper methods must not have symbols present in the binary to avoid confusion.
+    #[inline(always)]
+    pub fn as_ptr(self) -> *mut T::Target {
+        T::Backend::as_ptr(self.0)
+    }
+
+    /// # Safety
+    ///
+    /// Same as `IoBackend::project_view`
+    #[inline(always)]
+    pub unsafe fn project_view<U: ?Sized + KnownSize>(
+        self,
+        ptr: *mut U,
+    ) -> <T::Backend as IoBackend>::View<'a, U> {
+        // SAFETY: Per safety requirement.
+        unsafe { T::Backend::project_view::<T::Target, _>(self.0, ptr) }
+    }
+}
+
+/// Project an I/O type to a subview of it.
+///
+/// The syntax is of form `io_project!(io, proj)` where `io` is an expression to a type that
+/// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!).
+///
+/// # Examples
+///
+/// ```
+/// use kernel::io::{
+///     io_project,
+///     Mmio,
+/// };
+/// #[repr(C)]
+/// struct MyStruct { field: u32, }
+///
+/// # fn test(mmio: Mmio<'_, [MyStruct]>) -> Result {
+/// // let mmio: Mmio<[MyStruct]>;
+/// let field: Mmio<'_, u32> = io_project!(mmio, [try: 1].field);
+/// let whole: Mmio<'_, MyStruct> = io_project!(mmio, [try: 2]);
+/// let nested: Mmio<'_, u32> = io_project!(whole, .field);
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+#[doc(hidden)]
+macro_rules! io_project {
+    ($io:expr, $($proj:tt)*) => {{
+        #[allow(unused)]
+        use $crate::io::IoBase as _;
+        let view = $crate::io::ProjectHelper($io.as_view());
+        let ptr = $crate::ptr::project!(
+            mut view.as_ptr(), $($proj)*
+        );
+        #[allow(unused_unsafe)]
+        // SAFETY: `ptr` is a projection.
+        unsafe { view.project_view(ptr) }
+    }};
+}
+#[doc(inline)]
+pub use crate::io_project;

-- 
2.54.0


