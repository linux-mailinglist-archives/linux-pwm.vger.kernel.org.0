Return-Path: <linux-pwm+bounces-9418-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E3E8AFeSPmryIAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9418-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:53:11 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 662686CE28D
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:53:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=yEVvVJ4l;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9418-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9418-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1187310B9C5
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24CB3FF1DC;
	Fri, 26 Jun 2026 14:45:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020077.outbound.protection.outlook.com [52.101.195.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02803FD126;
	Fri, 26 Jun 2026 14:45:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485153; cv=fail; b=W5MnYSttR/+c9WF9oKqcoNlc4Q/Kae1E4ZAbGKV4Y0LgZaaPYh4fHV7Jp2v7j0QrijXeqhyKUrBcXzJVempGDtYFit4KOXhiscCAuJ/ico4sKVwnkKlbfxfbHU9/IY/k9gwGXsFCQDJzf7ZDZS1oAWMHrtuYgR3u7zsC8x4SDhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485153; c=relaxed/simple;
	bh=TRVxPZ8iNx0tOJX72PKwskiRkYFtvIOxgwtHZ046qs8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XlXXUMCWFLHxcIc2MjIMdimkHu/tG/lZCPIlHS7+lyVb4SlE3Gvfx7vybnAtRcn55ddAYtxVqKNhOt76Uush5xsneZ7yGtMvihxos2h6yvYCWoCT757dBivwdwUzRBSC0rycYp8t7UioB/7ySo4+0yo4sjx42guAT2t6x0LvNLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=yEVvVJ4l; arc=fail smtp.client-ip=52.101.195.77
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAN6NySduNcch5n9IQFv8ac9jQJG3t4gSnLCVJP3jI0fInITBXbUMtZjlMkNoYx+tHmhjMISy5YtzXQdr4qlDNvf5EDpWS7o7jeG15Dz1ynl7R5dvhj9mCy3uLkk/rNLx/LNvbQMz3j3PzTmmMrN7hDRVOnLy4WfkLmMSxsanMJTG0n7r2jn3U/kviKgcXXYkJsV4u/03rtMzC3bflvCrY6JazckFHf05Kn4Unv4byCIU1O/llxhVEtUGifTfEVswbNhAF66XlTpaOFs2IzSeJHlA0bO9Plm4Ge3FYo9ywqSq6ADWr0vL+zh/kgb9z0rnio3ZHavca8GgcrHfWvlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rjHkhkXNJi4IPwpx92VjlfyP30YcMvmNyPMmOOkpD8=;
 b=P73V4sr9GrsjmFPj8syOhOu6AjWONC0TePCmWNmuQrIcfDaQ7uBkKaAmSiEfhzJN2Mb27YbOk9NvxevBq/56yDEPGHv83wFsEXoLqEqDEb6En7FgPZM6iDvwlBV5hHRDW9DKvdUMB7+0imsVUL//TBPZyODDXQA9lSFpKKhFTKyn/nyulE5ZsjYyBMRnkJzIZ6Wz3PxqnBwOPiSqDWqQEacBo2c9L37fv7pBjvzrJzZ4FikCZ5WSwDy/Aa00j5hPLm0o+XoH9XssmghZG0g8Qeva5aXV33i3D36cvBTGK7YLG6K3EfPrFoP8DRUlWVH8SbpQRWjOJH1qD3zJIX0m6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rjHkhkXNJi4IPwpx92VjlfyP30YcMvmNyPMmOOkpD8=;
 b=yEVvVJ4l/cP56nhq/3TnRue45cLA3mTWAdfsxv/OBJvXxFmkVSSFPU6ObzqFcLiB9T8wo/Rmax+w/zWPB+mw2E893DEsvAsjQx8o9BgTs8T4QTtdr5DVHoqR91o840WgK61wDJUqe0eVlmd7RUNklPb5aXi+7/849lQnDn18v0k=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2694.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:25 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:25 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:20 +0100
Subject: [PATCH v5 16/20] rust: io: add `read_val` and `write_val`
 functions on `Io`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-16-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=4952;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=TRVxPZ8iNx0tOJX72PKwskiRkYFtvIOxgwtHZ046qs8=;
 b=xOVX+8u89/V5v9t5fKrB+iN/pOlEqTS3MrPqb8OnUyIHkI82cn/Ojhn4uUMGWe58qh8iCbAmr
 78gFtwTIKLiCs1pKg2JyyeRBzgYUOffVOtw4LqAOElsiLAnwIrj9mNR
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2694:EE_
X-MS-Office365-Filtering-Correlation-Id: ce99e214-a377-420a-ca56-08ded3918eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|921020|3023799007|18002099003|5023799004|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kL1UqCTu1mb3ZGYnCiNyrzqpHyhdbk1J3Xenjh2GpmVPay8cXO841Sv3OTGyn4SXbBnOjBnDmNtO56ZvrXc0sIO/gYuX0jZSt2Uk8JvL+d9YKaZsIzHHmBdep6r/cVp0Xg9DhxsJLxqqMpREFgWNhvP3eX4+coZE4BFmtUticDHCJpdbhuELB03IaC5iZwwAZAAh1jRQFLyJMsArjKtSHDPjHwNYzR6pqp0rlYl3sKUZtkJzIypYksaPZf6e3Pf4/ZI6HrZxhw3kJKtNIByF7b6sqq5+cNAblrCFuAw9+AEZLXuI6poj5Il0kIaVU4gMQxjrqEfZ4GBjsLY1L7mFp6qcbB73SGxAKHS91ikJH7Khil/JyfeLZ6d9n3xh+bt6yqL3terAXDkYXkPnRLuxRhUrPlq9LjmENWHpQGepMhNifzqSYjN9Uxl2euV3+KJ6DydJ1qZgoEiJDy5vW56eWEGr9v9/d/tjMldn2nLq9s0746z8n4vVqEqaVSO2BiY604wVGbVDbEzLg0eHMEXTnAd0hbNPM0uZ5P/4zNPm3s4CrbQ4I8HBxXjwU6GAcDtNRPOWtbhkgtR/LEsUkKFmrzK/+z0woAfYiaQZuhZFqIKzkZWRDJ/CSmWUAPJYt4c+Dw2TuuOVJg1Xhmsf5JgZq8OsCIG3DC4a+2sLQRChaTCLc3pNMWH7or/NSs2f/91dxsCJpuBLAMpstLL2fjip4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(921020)(3023799007)(18002099003)(5023799004)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0hFMGQ3U01qYWxNeHkxczlQT2g2RFEydW9lSkJObStNd3RiQ25jdkVITmNY?=
 =?utf-8?B?UTRCck8xR2V3T3ZZaWh1cTlpRE5kaDBGN0VEVzVLbTBWbndZVlM5RjYvczAx?=
 =?utf-8?B?OHAyUkxENERkWkxmdkZhRXJydWsvWmVRQUpnQUppN0hySGVqVXRiaXJNdmtF?=
 =?utf-8?B?TVVPWjBqZDJJNVRyYXlWeHFvcEVuUTdHZU1oRTNxcVI2VnJESkt1aXdTajJ3?=
 =?utf-8?B?M2tkZnB1bmYvUHJhYnkrUFBJakpCaHFaRWZPVVljM2dUYVI2L01VWkhEaVhE?=
 =?utf-8?B?TmZCZXlkby9GMEM4eHFYUmJkMUlDdmh4NC9ybWFEc2Vnem5xektDUGVuRFQy?=
 =?utf-8?B?RTNMSFRwMURPSEx6aGxXaGVxbmdnTGFVaC9zTXNZQ014QndZSUpvSDE1cEFm?=
 =?utf-8?B?WGxKT3gwSlZkOTZnT1BmQUtwcHZFN0h3d3hkZ1JzTVlBN3dUVU5qQTRxTXpL?=
 =?utf-8?B?bVd2dWFlcjByUzVaaHNwWElNbEkwK0lEbDAvUUhIaVgwOVc0UnQvL0hjWDhR?=
 =?utf-8?B?NlpNM21ndktCZ3lkZ20xcVBIRTQrNWt2TUxkaU55Ylk0anNKSUdGUThnMk90?=
 =?utf-8?B?STRocWoxcDFBOWRCK0hWcjEzbFl6SStxNzZZdDRGeTVEU2NFa3RpdG1QcVFh?=
 =?utf-8?B?VnE0N0pKd1duOU9nV3BnVVVteGdCYWMzS2hlYzF6QnQ3ODZXSkRRUThhc2JF?=
 =?utf-8?B?bGE5UFFZdnEzYWFoRFpvZ1RFanpPZVlZVDRBZWIzWkM3aUkwNXg1dVIxY1gx?=
 =?utf-8?B?S01TYjFTZDhSWTJZWHpzVDllaE9mbkw1eVlPYVNUYjNlcjBlZ2hJcVoxcXNU?=
 =?utf-8?B?WGp4VEpsT0hnajd3NXgwOTA4Sk1hV2hkVWJJR0RINlNOU0NXb2toUlQ5THlR?=
 =?utf-8?B?ZllzYUpBa0dUdzFadEFqU1loU2cyWUtVTUVyNnBCS3dQTHloYkNBREVtZTlB?=
 =?utf-8?B?UC9XT29ETDcyRFV2V2tUREttNFVrK2VTblZDSHRtTFF1Rk16QzNiNlNnNjV5?=
 =?utf-8?B?c05wM21EaXlEKzRXMlp5azI0UDBCdWF6MWJzK2lMemJycE5ldDBES1NaMllx?=
 =?utf-8?B?WkY5R1ZGUDNSaDk3VWt0VnRNNVM2eVhiYUdLTWZNYzk2OTRiZTVPWHluMjQ4?=
 =?utf-8?B?Rkx2Nk9RSlNvUFZNM0NzSGtSWWVyMWdBZGNUcVU3aEIzV0xkZmswS1UreXdk?=
 =?utf-8?B?cTd6UTZ3cXA5SVIrY2VXL2VBYjhKaHZGeXJDcEVuS3Vvb2tlcmF0c0JhOXpa?=
 =?utf-8?B?cjRJRFlhdEMycjZxRUplWkRXMDF6U000UjFyUTN5Wlo3UnBMY2JkMm1sVFk5?=
 =?utf-8?B?QmlMUU41a09TZmRaRUwyUStKdTM1b0UyanZhUVo0YjR2REpBeFA4RE96Q0xr?=
 =?utf-8?B?SEhxVjFVbE5WVlhQVTcvUWFuc0YvRFlLUEQzN0FSaURwM2duZFAydWo3eGh4?=
 =?utf-8?B?cE5JckNSMWh5S3kwVVd2c0RnS0lvdXBMYUI4Zks3NVV2di91a3cwbTYyZFUw?=
 =?utf-8?B?R1BaT1lyYjNPbnhEbk5RQUJtdmZ0cnBIR1hSdmxhMys3RzBqRlUyeW9BNUg1?=
 =?utf-8?B?WWY2N1drUUxuNXJlY3YwUW5lckdyODlvYU0rSExYaUVDYXFmdXdlcXpYTmRH?=
 =?utf-8?B?ajFTK3F5RFl4Yk5Mb0F0VGYxVW1ORmZzMnpVcGFxdHVrcTRXd0czZG9Ia2t0?=
 =?utf-8?B?WkEvL1BqNjBrcjZ2Z0ZiNmJYekQ2VXN4Y3RRczBtUTFyM2N5emhzclB5d3BG?=
 =?utf-8?B?WG5GNkwrdXJ5N09Sc1BraEZEaGRTMnN4dmJYZU1SeHU5SnVUbHRlWDVnblEy?=
 =?utf-8?B?Q1B4bSt0Wko4WTk1VmtXWmhQRnowTXlwRGYrZmhPVkdOU2trWURzUk5TZWh6?=
 =?utf-8?B?MFZFeXNiV3dLajN3Q3dsblZPd1czL25xUlBaWkFySmNaNmtzZEZFa21iRy9x?=
 =?utf-8?B?czJFVm5zNmJyRmF3ME9rU0V5NWxqazlBTk1UYkw2YUgzNDArMGtjTHZFc3Yx?=
 =?utf-8?B?aGp1ZHNjbzNYb0p0VUlvWkhXTDAxYzFxUTZXWW5NL3dLNGttdDYvak9NRDVw?=
 =?utf-8?B?N0NmZUVDYk5sbW5FTzd0R2VDeXUyQi9uSFF5YkhnbHhqNTdubUIwOTlTdkVU?=
 =?utf-8?B?TzZrSXlTVFY1ZndhZVJudTRNOWlHUmpYd1BpdGR2dEZpN3NYVXJTODVtSWxr?=
 =?utf-8?B?U0RFTEFGUUxhVE9LSjZScGNhZGFuM0h0dm9xTmpqbmV3MXpYS1FSaVJGQlMv?=
 =?utf-8?B?U2lFTUlIM2xPZFhMQkNwMEZXak1zaHVVNXkrdFkwdDgrMDU5R1RhTGdsb3E3?=
 =?utf-8?B?YkhWdUZHbURoR0hrYjFhaXhaTEdkVlhwZXB6QmlBQUVYeWJqSURVQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ce99e214-a377-420a-ca56-08ded3918eb0
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:25.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJQKw+tsjmv+FriF9+GtFACzLA61FQDTRzLM4A1/KraR9wqwDT7zJaRcIDwsHL8QS4uHQhCBk/PMiriWfMGtyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2694
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9418-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 662686CE28D

Provide `read_val` and `write_val` that allow I/O views to be accessed when
they're narrowed down to just views of primitives.

This is used to provide `io_read!` and `io_write!` macros, which are
generalized version of current `dma_read!` and `dma_write!` macro that work
for all types that implement `Io`.

Note though `io_read!` and `io_write!` only works if backend implements
`IoCapable` for the type; which is typically only implemented for
atomically accessible primitives. `dma_read!` and `dma_write!` currently
supports them via `read_volatile` and `write_volatile`; this can be
undesirable for aggregates as LLVM may turn them to multiple instructions
to access parts and re-assemble, even if they could be combined to a single
instruction. Thus, `io_read!()` and `io_write!()` does not fully replace
`dma_read!()` and `dma_write!()` in this scenario. The ability to
read/write aggregates (when atomicity is of no concern) is better served
with copying primitives (e.g. memcpy_{from,to}io).

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 5c06785facea..aa82736253ac 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -393,6 +393,50 @@ fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a, U>>
         Ok(unsafe { Self::Backend::project_view(view, ptr.cast()) })
     }
 
+    /// Read a value from I/O.
+    ///
+    /// This only works for primitives supported by the I/O backend.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_read_val(mmio: Mmio<'_, u32>) {
+    /// // let mmio: Mmio<'_, u32>;
+    /// let val: u32 = mmio.read_val();
+    /// # }
+    /// ```
+    #[inline]
+    fn read_val(self) -> Self::Target
+    where
+        Self::Backend: IoCapable<Self::Target>,
+        Self::Target: Sized,
+    {
+        Self::Backend::io_read(self.as_view())
+    }
+
+    /// Write a value to I/O.
+    ///
+    /// This only works for primitives supported by the I/O backend.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_write_val(mmio: Mmio<'_, u32>) {
+    /// // let mmio: Mmio<'_, u32>;
+    /// mmio.write_val(1u32);
+    /// # }
+    /// ```
+    #[inline]
+    fn write_val(self, value: Self::Target)
+    where
+        Self::Backend: IoCapable<Self::Target>,
+        Self::Target: Sized,
+    {
+        Self::Backend::io_write(self.as_view(), value)
+    }
+
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
     fn try_read8(self, offset: usize) -> Result<u8>
@@ -1225,3 +1269,63 @@ macro_rules! io_project {
 }
 #[doc(inline)]
 pub use crate::io_project;
+
+/// Read from I/O memory.
+///
+/// The syntax is of form `io_read!(io, proj)` where `io` is an expression to a type that
+/// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!).
+///
+/// # Examples
+///
+/// ```
+/// struct MyStruct { field: u32, }
+///
+/// # fn test(mmio: kernel::io::Mmio<'_, [MyStruct]>) -> Result {
+/// // let mmio: Mmio<'_, [MyStruct]>;
+/// let field: u32 = kernel::io::io_read!(mmio, [try: 2].field);
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+#[doc(hidden)]
+macro_rules! io_read {
+    ($io:expr, $($proj:tt)*) => {
+        $crate::io::Io::read_val($crate::io_project!($io, $($proj)*))
+    };
+}
+#[doc(inline)]
+pub use crate::io_read;
+
+/// Writes to I/O memory.
+///
+/// The syntax is of form `io_write!(io, proj, val)` where `io` is an expression to a type that
+/// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!),
+/// and `val` is the value to be written to the projected location.
+///
+/// # Examples
+///
+/// ```
+/// struct MyStruct { field: u32, }
+///
+/// # fn test(mmio: kernel::io::Mmio<'_, [MyStruct]>) -> Result {
+/// // let mmio: Mmio<'_, [MyStruct]>;
+/// kernel::io::io_write!(mmio, [try: 2].field, 10);
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+#[doc(hidden)]
+macro_rules! io_write {
+    (@parse [$io:expr] [$($proj:tt)*] [, $val:expr]) => {
+        $crate::io::Io::write_val($crate::io_project!($io, $($proj)*), $val)
+    };
+    (@parse [$io:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [$($proj)* .$field] [$($rest)*])
+    };
+    (@parse [$io:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [$($proj)* [$flavor: $index]] [$($rest)*])
+    };
+    ($io:expr, $($rest:tt)*) => {
+        $crate::io_write!(@parse [$io] [] [$($rest)*])
+    };
+}
+#[doc(inline)]
+pub use crate::io_write;

-- 
2.54.0


