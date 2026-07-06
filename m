Return-Path: <linux-pwm+bounces-9594-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ccXyOrqjS2pSXgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9594-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:46:50 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8740710BED
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:46:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b="i/XCLZrD";
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9594-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9594-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18121302333B
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EDA430306;
	Mon,  6 Jul 2026 12:44:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022076.outbound.protection.outlook.com [52.101.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB2F42F707;
	Mon,  6 Jul 2026 12:44:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341878; cv=fail; b=dKtMYsRqzKNynI3+5IazkMaoEzSpk0iA6dRtOv59NyYfUjVeSKmqg6clw1iftXpfcBfy5EKlcOud1YBriFHIb/4kko2O31MzelSBucM5wG7OCa6nNXdDRhsBhe3okoKMcBNivuRUS5WD6pwUX/nO4hgKBY15CXe2xPwld1U84wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341878; c=relaxed/simple;
	bh=zcL64dOq1S6g74TzRD847SfGyQa8u6SPIOVdRrKD3hg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gIWG8108ZgPG9lGFIOkWQtpIi7dDOBGWtcZLdvymaK2WqKGu8batKDBO6s+Moi5Vek22o/4LVfsVPkbnO0rdTEcC1SUFmpN/cBZgFhEqTFKz28yTIkruJ0vhJe8yT1njHaSJbpXmyyaf/fLnhYrApYP1wuywI1YwfWdzlsIFZXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=i/XCLZrD; arc=fail smtp.client-ip=52.101.96.76
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGDxZ52q69hrSo8un+UmdcLPNll5O5R1HEr0f0HG+C+WarXqhReCD/K/pkF0aSLw0RqUVbV4Fo0hwOMf2SvEZ1FnFo2Fp5otp5yVGCUIr9gMs3ORo5yCWTz38VTQySZRjaPhZcBTnHigydUf2MiPRfWrdiMz3WnIZhgBBp/cC67fRjUI12N6OeOXtKBbrUaBWt+7+TVh7lUTOyibMnYCPcDNChJKDEQQkF76h0CLA0aOY9YNcvkG/Yzyv4EYWLUxLAUQinvCPdpwcrgzKTyAscG8Hb10gqXt2XroD8bwdh3zDzapMDJcny8c7tzhJvjSB+jIYkNt0y3hZ5SS8dUMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrGyTXT4lLNycWakX13m0EN+saSRVjAARnFVmHOrwg0=;
 b=MfOTpFRw/6y4YRrthZYku3Rq+OD3+Re4PeaxqirNjbcLAtfyPC1QeSs3TUz87lUtwds2BZ2ulD0sDtv4tha5WwKiTbbzYivqY95TaxBhqEcBtq3O3RVI2WuTD0XuqBmRaqpbPvnKQTXIizWaMH8h0B07ogM6TKII1UL252up2qOs1Edszj/MkDN1cU/5bhvUqJqk5CoXO4GXJEri3CsrJUwuQ+IP4QZxs+CJ5n/es/CproeQ2UDWYV9ceRqAkQOQmQwolTNwbAuTLmQqSzGkFllebfukpiJLUhNWKZd+V4PflDmAkIAwD4HEsDRDDsdoLgkUQCGf6EVYXymSXAa5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrGyTXT4lLNycWakX13m0EN+saSRVjAARnFVmHOrwg0=;
 b=i/XCLZrD8Dk1mip/fv8u9olGsBgnrh2YmFYGE6w/mshAiz1tddC3fIrURit2UgCcBfpeh/CupJpkJvvFjre/NR+x0QD1FXnGjEaao/pVaLlzqb5SBZHiXF5V6vMZYjOEj38fwneQAldrNycIOU56WbUOnGPh92HW1V0nrcGXRd0=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:26 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:26 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:18 +0100
Subject: [PATCH v6 05/20] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-5-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=7882;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=zcL64dOq1S6g74TzRD847SfGyQa8u6SPIOVdRrKD3hg=;
 b=RVOpqT28TmR01wBo+Rjjz8g8gzoOxMzGJkpijPUiBqkrAz47sQicLqkuGzFBJfK5Hu9ZzelRg
 aHJwHAsTEM3AKZugfO4yUSfYFSX+rbPCtp3bvmjX4y8o1ONzZ7+jTWi
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
X-MS-Office365-Filtering-Correlation-Id: 0e5e14c7-b50b-4413-2fca-08dedb5c508f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	N//t6+WcWWPSISVwl7+MlA66tnwOgXgwuwIwD3XbzwH5fVSd45px7wabJDGzlYQrAqGVbR920gSLaAEmkkq8JFGqqQFy18aJo5FGBo45caM2rePkOnlr7JuytOHR2u3HAXbnJtOzkyt4YOw5VIsYQqG7yhc6jTNUSyOO/HlLGm0+9fYp9x9KGJWhlgmupsbZswolbz7rrZQBONAEQjl48DPi4jBA5fXvY+x+1Ni78AN8pPD0hpQbgiZVDe+KV2dBs7yJUXunu4u3K2gMFZ0s4PfXZbA/rmlRlxyZqV9Zv7kXYWGz9WbwEJq3Xq++WOBxPFsv8t8v5cQreCd+4G2MtCH3s/rgjeBANnzyVIUVFn/4iYCrGVJHk6r7hjxpOCSKJqQsCCTeoWFwbLkcPT8goNYGnktLmddyY/teG+CkL4NY3aMXBHTOsGv/O6KgFoRheP5de9T7iBIQoIiKdRfwcIb/jt6qN2wRTJGGELlt9Qhg31y4YDnwjD+kGzCYPRzd9+KIfZsW7OHzzPlfkjMBGQzmHdZXFBfml7fUT8wPbtddqxHmViO3CoJPgTjfvCqeL3h7mnppcRWYA9IRGW9qd9Jk9+d+5u3OYgc1pcBW/8KMUjixxz2qPMSd5XfizNVbXP8TM50GGnRqeEWlbznHRyr/nI+/5o1fU/bR+BzsBulq5GkVdOFUSvUMeoozcEw9iHRuYGpCpF+kqcYnJwdeVw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWtzSUwzemYrcFNMWVhibllwaTFkRUVyVXF2cFFpYWxjQ0prbFZhK0t1aUNz?=
 =?utf-8?B?MVJGaGd2ZTZKSVVid3dZY2Y4dE9uSkVrL3VNbWg3VTVTbW44dnlOY3RJbDNZ?=
 =?utf-8?B?T2lOdC9mYkxuSVJUa3AyN0Z5RUJIOUJCd29Cem5KVllobndvdEEyempaQSt1?=
 =?utf-8?B?bkN2Q1RYRFNVVWowNSt6WGo2UmFzOHFUa3JDUWorbDdZSHMzZmFuKzB1bWRH?=
 =?utf-8?B?UmJqcVJPYTgvcFYrRDBXeGlpVEJpK3A5eERKN1JwLytaclFPclRkVjFhaGcy?=
 =?utf-8?B?M1NQWDlORVVnWFZpMXdMZDZ6VWFDeWo2QTBFQldDMldPR2I4bVdmcjFYaE5F?=
 =?utf-8?B?bzhKS1ZTRXBsR2puMW8rS2pLejZUNjcxcjJiT0wrM1J4VVlXTm5QUjA5UlBp?=
 =?utf-8?B?V0d3WGtIVldlWnBnK0EwV1ZUdzNENUJIbU1wM0JlbzVndnd6TThXY2JicEE4?=
 =?utf-8?B?TWMxSXlWaXY0ZittRU1mMjI0VGxhbFRSWE9zeEgwelhMaDZua1R3UGxxU2xl?=
 =?utf-8?B?N1pMemppdThkMkNUR1hGa3FGWEppcmFaVUpqRE9VVU5aRVd0aE9qMjVtcExm?=
 =?utf-8?B?cnhVM3N3M3VUcENkM3NVWkJHazZ2d0dtMlU4Mnc5b2Fpbk9oTlVQbjVlRnQv?=
 =?utf-8?B?WllnQk53TVh3YjBEQmVrRTVmbXFaRUZUdHM2TUdsQ2lzYUpnYldMNlBTdy80?=
 =?utf-8?B?SGNCVjJza1RjL1NiVUU5Q1hiOUZTUDd0MGVKS2k2UWlBSzRHYjNBUE8xd1hF?=
 =?utf-8?B?T1lCeW53d0ttTnNnZjYzbWpPeGRKZTMzVW8wRU4va1NIZ3hIbS9GK1ZvcGtw?=
 =?utf-8?B?Qlo5QTBUWkFhdHRrZWJPa3UvYXQwbVZCblZxNXJuWjZ4S0ljNW1laU54QitF?=
 =?utf-8?B?Y3I5T3poa2tVT25NcEdTbXhKc1ZEeFFrTWg5YUoyMlh0ZmRuYisxanljSTZC?=
 =?utf-8?B?eVhpYlBxRUl4bm80dkhOT1g0eDBmSXhENElTT3k0TCs1QkpOakYwbVRLOURl?=
 =?utf-8?B?RlRxM05zdUV6Q0U1NEd1NW1WUGljbTNDTG56akpkZ0dNNDV3YStkaHJZMGNP?=
 =?utf-8?B?a3d0ZmF0MG9JZno0Y0Q3OFdMSEZ1eDN3MjBKdFpyVzdCM0d6em1JV0VSZFFx?=
 =?utf-8?B?UzFrS1FpZ2h2R1l4cnZjZWEwZnJCeWp1NVcvMTdQTkhrSnJSUjJCSjZUTXgw?=
 =?utf-8?B?UGYzdGFod1VEekxzcUc2MkJ5UmJhY0FxY2tVSEdUQWdSVXF2VE9ZbXlwWnpm?=
 =?utf-8?B?M2t5eVZUdjZIOG1xOXNjby9la3VzQnJyc2dGSERIWW4rd0tjRFRvVkdXMmVV?=
 =?utf-8?B?aTFBRzZkTUMvbnl2YTY2dnlma01Iak01Qnc4WVdsSFUrVTlXU0Y2N2JLc3hv?=
 =?utf-8?B?UDQ5VlMwTkdJdWRvVkpET0RtUEJycEwvTUJ2Q2duc3VZTWtUWDRFR3htS0dV?=
 =?utf-8?B?dDJ5dEtKcHdMdEdpUVNjNnM1bzU4NGdnUkFSa0psWWtRa0FwbWlMbk91ZFlX?=
 =?utf-8?B?eFVUT0VPQnBEU0pKOE95NmFmTENCMWsyN24rZnF0SkFDS1dqWEJpNUp6WW5o?=
 =?utf-8?B?ZHIxaXQ3Wk5GR3l4aFdEdzdOR2VSdmhFM0RmL1pXSnJIckd5N3gzN2hqaEVN?=
 =?utf-8?B?ZHVSMmxWaVJYN3dlN3kyakF4NVcvNVhkTDNrWjl5U2FGUjdFRUsvQUtxNlJz?=
 =?utf-8?B?SEl1eUZmWElKdys2Zyt5Qml3WU9nMy9WUnZQNjNWZ2VRdUNCbitqU3B1c2U2?=
 =?utf-8?B?WHJhMGVHMkNyREU0NWNuTDV5YklVaTZBSHBBbkdudHZRay9RZmplTUJrWEhr?=
 =?utf-8?B?Tm5qT0NCMlU3d3RNWEZOZVZaMmlZYUN4UlhhZHdocURTS0FtMlVTRERBVGdx?=
 =?utf-8?B?MGNvN25UWVJwU0Faem1obThhM0dDN0dvS1YxbC9SaW1sZDNsOUVsWi9NUk9V?=
 =?utf-8?B?OE5ZRThYWkNoRHVEU285aXB0Zmw0UFVYSHJuZEdLYTRsM1F6b2pMWkpZZzly?=
 =?utf-8?B?SXFmRmFZSkY5MlVtemVhaFFSVWQwZ3I0cUVHN2VSWUNQSG1wUVN6TGJUa3Ri?=
 =?utf-8?B?dHpNaWFqNDRXR1NHOXJ3Q3ZoalNlcG1EU0pKb2pWNXBuR2RRUEhrVVpmT3Rt?=
 =?utf-8?B?UVU5QkgvYld4VUdWcVZxNTJXbzR0bVVmSjc3UHo3VjFIWTAyKzllcDZVdHFm?=
 =?utf-8?B?TmluUnRRbGJ2c2ZnbEQ1Nk15emtTUE5FSkQ4N1BpQzBZOFBKWThIVjJwajBH?=
 =?utf-8?B?OFUrZ20vNmE2cEJUcHBKR1JxUCtWYmg2Y3E2YUpRMWRKcWdYbDlTQmYzdUtO?=
 =?utf-8?B?NkVxZDdiMGQwUURQVVE5ZDFyR0lqWDZ2RG5EVlpFQmVOcmVvMmpMZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5e14c7-b50b-4413-2fca-08dedb5c508f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:26.9050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9EegUvLEthVpemgD+Rs8LE6VEusuOKSDZOd4dRZYXdVbiWc/nOqPxXvErOgPVlf+SsLFrwshqQJDosuNCHOEA==
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
	TAGGED_FROM(0.00)[bounces-9594-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8740710BED

Conceptually, `MmioRaw` is just `__iomem *`, so it should work for any
types. Update the existing use case where it represents a region of
compile-time known minimum size and run-time known actual size to use the
dynamic-sized type `Region<SIZE>` instead. Rename `maxsize` method to
reflect that it is the actual size (not a bound) of the region.

Implement `Clone` and `Copy` manually, which cannot be derived due to the
generic parameter. The use of raw pointers also cause the `Send` and `Sync`
auto trait implementation to be lost, so add them back by manual
implementation.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |  7 +++---
 rust/kernel/io.rs     | 67 +++++++++++++++++++++++++++++++++++++--------------
 rust/kernel/io/mem.rs |  5 ++--
 rust/kernel/pci/io.rs |  4 +--
 4 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index ed30ccc6e68e..d0c677fd7932 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -70,14 +70,15 @@ struct Inner<T> {
 ///         Io,
 ///         Mmio,
 ///         MmioRaw,
-///         PhysAddr, //
+///         PhysAddr,
+///         Region, //
 ///     },
 ///     prelude::*,
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -92,7 +93,7 @@ struct Inner<T> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 9f060dd29182..12be266d7ed7 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -88,37 +88,67 @@ fn size(p: *const Self) -> usize {
 
 /// Raw representation of an MMIO region.
 ///
+/// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
+///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
 /// the represented MMIO region does exist or is properly mapped.
 ///
 /// Instead, the bus specific MMIO implementation must convert this raw representation into an
 /// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
 /// structure any guarantees are given.
-pub struct MmioRaw<const SIZE: usize = 0> {
-    addr: usize,
-    maxsize: usize,
+pub struct MmioRaw<T: ?Sized> {
+    /// Pointer is in I/O address space.
+    ///
+    /// The provenance does not matter, only the address and metadata do.
+    ptr: *mut T,
 }
 
-impl<const SIZE: usize> MmioRaw<SIZE> {
-    /// Returns a new `MmioRaw` instance on success, an error otherwise.
-    pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
-        if maxsize < SIZE {
-            return Err(EINVAL);
+impl<T: ?Sized> Copy for MmioRaw<T> {}
+impl<T: ?Sized> Clone for MmioRaw<T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+// SAFETY: `MmioRaw` is just an address, so is thread-safe.
+unsafe impl<T: ?Sized> Send for MmioRaw<T> {}
+// SAFETY: `MmioRaw` is just an address, so is thread-safe.
+unsafe impl<T: ?Sized> Sync for MmioRaw<T> {}
+
+impl<T> MmioRaw<T> {
+    /// Create a `MmioRaw` from address.
+    #[inline]
+    pub fn new(addr: usize) -> Self {
+        Self {
+            ptr: core::ptr::without_provenance_mut(addr),
         }
+    }
+}
 
-        Ok(Self { addr, maxsize })
+impl<const SIZE: usize> MmioRaw<Region<SIZE>> {
+    /// Create a `MmioRaw` representing a I/O region with given size.
+    ///
+    /// The size is checked against the minimum size specified via const generics.
+    #[inline]
+    pub fn new_region(addr: usize, size: usize) -> Result<Self> {
+        Ok(Self {
+            ptr: Region::ptr_try_from_raw_parts_mut(core::ptr::without_provenance_mut(addr), size)?,
+        })
     }
+}
 
+impl<T: ?Sized + KnownSize> MmioRaw<T> {
     /// Returns the base address of the MMIO region.
     #[inline]
     pub fn addr(&self) -> usize {
-        self.addr
+        self.ptr.addr()
     }
 
-    /// Returns the maximum size of the MMIO region.
+    /// Returns the size of the MMIO region.
     #[inline]
-    pub fn maxsize(&self) -> usize {
-        self.maxsize
+    pub fn size(&self) -> usize {
+        KnownSize::size(self.ptr)
     }
 }
 
@@ -143,12 +173,13 @@ pub fn maxsize(&self) -> usize {
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr,
+///         Region,
 ///     },
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also `pci::Bar` for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -163,7 +194,7 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -193,7 +224,7 @@ pub fn maxsize(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
+pub struct Mmio<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
 
 /// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
@@ -840,7 +871,7 @@ fn addr(self) -> usize {
     /// Returns the maximum size of this mapping.
     #[inline]
     fn maxsize(self) -> usize {
-        self.0.maxsize()
+        self.0.size()
     }
 }
 
@@ -851,7 +882,7 @@ impl<const SIZE: usize> Mmio<SIZE> {
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
     /// `maxsize`.
-    pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
+    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
         // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index fc2a3e24f8d5..9e15bc8fde78 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -229,7 +229,7 @@ fn deref(&self) -> &Self::Target {
 /// start of the I/O memory mapped region.
 pub struct IoMem<'a, const SIZE: usize = 0> {
     dev: &'a Device<Bound>,
-    io: MmioRaw<SIZE>,
+    io: MmioRaw<super::Region<SIZE>>,
 }
 
 impl<'a, const SIZE: usize> IoMem<'a, SIZE> {
@@ -264,8 +264,7 @@ fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = MmioRaw::new(addr as usize, size)?;
-
+        let io = MmioRaw::new_region(addr as usize, size)?;
         Ok(IoMem { dev, io })
     }
 
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 505305cd9b86..42f840d64a6f 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -139,7 +139,7 @@ fn maxsize(self) -> usize {
 /// memory mapped PCI BAR and its size.
 pub struct Bar<'a, const SIZE: usize = 0> {
     pdev: &'a Device<device::Bound>,
-    io: MmioRaw<SIZE>,
+    io: MmioRaw<crate::io::Region<SIZE>>,
     num: i32,
 }
 
@@ -179,7 +179,7 @@ pub(super) fn new(
             return Err(ENOMEM);
         }
 
-        let io = match MmioRaw::new(ioptr, len as usize) {
+        let io = match MmioRaw::new_region(ioptr, len as usize) {
             Ok(io) => io,
             Err(err) => {
                 // SAFETY:

-- 
2.54.0


