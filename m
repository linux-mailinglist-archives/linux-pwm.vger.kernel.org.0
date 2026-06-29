Return-Path: <linux-pwm+bounces-9477-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jzwvBH+AQmrI8gkAu9opvQ
	(envelope-from <linux-pwm+bounces-9477-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 16:26:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 595FB6DC021
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 16:26:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=fgLKUYkE;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9477-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9477-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CAFF31558DD
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAD9413D74;
	Mon, 29 Jun 2026 14:15:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021078.outbound.protection.outlook.com [52.101.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90E41167C;
	Mon, 29 Jun 2026 14:15:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742541; cv=fail; b=rMqjM0LQAduT+knTGki4LCaRC8tcprXuLE1jG263lsae7u21lsmzyp4P459obnbirNcSx+lnx4yTbR8Xnzbmdb2Grq/KA5Y2UESjvhIJj/xZUCzulcpQ05OmIT8jjZhW/K93PTFndUs8RU3l8myR/Dq8YIXaTmRiKutFRF7hsi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742541; c=relaxed/simple;
	bh=hYg2yXEzJkyz8Dmsr/GLSbevrFcbqjmapEbmDIzOebA=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=CJ3YEKH7aAvCEa++pAXfVidf7kcis4C5r6Gu9e0xKLrcnIcVxOe1VuVxj5gJoCqC0tkj6qPSEXMy+ChkrnFYEUbMUdPuPR90JmAdOFtyqHZOtn8GN8vRoIzKNRih9XPLWZG6vPHT+WNF92fX741JnEkjA3KeODQUSHNDv/r67jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fgLKUYkE; arc=fail smtp.client-ip=52.101.95.78
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvZUo8RACGD99Y9LDfZezOyTWi13LnxoMwWebqJbolXms1cGt+ey8YSAsAthVfzCQfioV/l64G/D8GIq27+LNlxNRZ8v+/A9aXrI6bQJi9PpbEwxUNX2b4Q9I1axRIsdCt/S+icXrAMca5ytBv6LshaXiD0cQhmqatP3Yh8nQnNFVLDX15Gx4/VZerMonVhd2Zf2KvvT1H+e7e4gB5o6MffSgGxFPG7kqouu82YDMygD+yP0hkB5WWXkE+vcovOhKqxcu3MVoJjO8NMTAi0+GBUtqpiF8SyEInJal5K+B8hOuM749osL/NYgfphjpcjEP7O5axJdti3Epl5fx2hwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8/xDh5oAuNdq/nZ76azreETRKHc+Rr3sqq+XGf9XxQ=;
 b=i1ovo3lCQcgxDo2E/WjQ0G19tOwYWqsTXzebsr6LbnRLNhv89fCMCRbWvLjHYWZR4z5KqxzymCZ7mkTeN1dLVunm0YfhtIBss5Bb2yyAjeS6p7zG9vwiyA2eXVA3HoW4x5uBZYcXyDqabWTun3UIw2NsMRGyYxyMklsi4xksXf4G6eb0KZGyhzYowpp5s/aC9U5c59EIkTB3VjjBS4NRuuqb+gfM4alAnpytMOm49qsRKsRw8wjoCca5A0NmsdxiMfGh8AukELuJ0APLP4l7d3xhlI7tcg0fqvOCOLACit0Z3eSjmtDhpbUOExqhOv2FjtlIyIbQNJawx9cW2Fl/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8/xDh5oAuNdq/nZ76azreETRKHc+Rr3sqq+XGf9XxQ=;
 b=fgLKUYkET7jyO66g7+HJhLoI4t8t7H4NbuwcTF6kpoVbexLdKm9Oyw6njXb5TNBxuTui9U9LsycFuuSPARxbYsi1VvekbQbNvtO/aGKxHPGayS8BXS7Py6k7zyrQ9Wgl2Nkejhn1UdUP68Sqt54UEIvwVln5VKhsqQwWATs0VSQ=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB2411.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:15:35 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:15:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 15:15:34 +0100
Message-Id: <DJLLHI7FIYM0.2YB1QJ6TB8R6T@garyguo.net>
Subject: Re: [PATCH v5 00/20] rust: I/O type generalization and projection
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, "Laura Nao" <laura.nao@collabora.com>
X-Mailer: aerc 0.21.0
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <DJL2T5XDC53F.3C2QC5L1V2H6@kernel.org>
In-Reply-To: <DJL2T5XDC53F.3C2QC5L1V2H6@kernel.org>
X-ClientProxiedBy: LO4P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB2411:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f55c1db-d02f-449f-493c-08ded5e8e317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|56012099006|4143699003|22082099003|18002099003|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	IDXR2RlyEHt9YWL4qmsogoqXj6PkN7cxUkZdXlzuFAhmjFApNWvxIuPhnTiXrS81u41WIX+sUYHx200ge7gx8nT03tdtbJ0V4jZvLgCsnrfa0BDxciPmA5hGw2sVOxpQ9o3jTFFSm8JvMjbQEaSTbezR0L+NvwKA3xu9ZQCrkB4K1D6GsW19okvuJGQlM3EUg7xBLZShjt6PpCV6apuRhZDFlsh9AUIE6QEygMhtQkxzrx1i9hccVuh2tD2DhnUDfui3p9lpYftG6OcDSoT7Vc75k4+iFkHBGsa9GBSlcrQHQA8gxCVNpkUNoMoMd97h9wCsArhlSmvVMPU+hpT6+NGxJx+MFfkGIXxyx2alxJfjmeq9jpmpIvzYtDk5nFtMNOs3rT1ef4tkOGTQK21xDsksnYdsL79NsC55OUbLN5s3iYFkwYakvLT+fbB+w+uhJ1E/J6Y1hzotEJF/V2ohpt20xuzQSi/1V0YYvsmV2H0xga2GdMdJawgGb1RoLxVJwceyAKbdkW7RKa7n89KZZfSOnxbDFV2fASvJ4yF9ozhEd6jfcmevGshPkbR29F3LucA2cR377mOoAbsjGlzPyppYflHoKXCv14sfuFmXtT2JAvfcHm96UDEwtixAgaqI5wpmaXV29wVhXmvvhGU4tx86xu5zEkQLxq6IAX8aIJw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(56012099006)(4143699003)(22082099003)(18002099003)(5023799004)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2lUclM1cTFqUVVmZ0xpK3B6bmR5aHp1NWxsdGxCYW16cDZYcnl0VE1OYVBq?=
 =?utf-8?B?WXI3SEp4WXgvVGIxQ3MvTnl1TUpRYVkrSmhKN2dteWh1U0NvRlNEWStnNVBs?=
 =?utf-8?B?akdyZlpJSDJILzRFeDhKTWhwWlpvVjNmazFvbzFMVXliRlhkWG1CaUZEc3dm?=
 =?utf-8?B?N2JQcDhGeFcvU1NHVzEvT3B6RnVXOFBXdGRYUWw1NjQvTlV0WUlxeUZqWWhk?=
 =?utf-8?B?bEY1enN5QVpXZFZCdzlhQ0JhVUhoUFRhRGtIZEhudjVIWE0yaTYvVnc2VTJB?=
 =?utf-8?B?N0UwbXJHeXZ2WFJBUEVBRG45RmpJTVUwQ2JKYWM1WHRtelVaRHZBZmFDVFhJ?=
 =?utf-8?B?NnpFUThiVkZ5eUJYUlR0YkNwSHZ4OUs3MlZiVm5TUC8xakxMOU1IQjRXZGlz?=
 =?utf-8?B?RVkyWUVlV00rNUZCTzlLMk9UdTJnWnlBMW5vMEZKeTNySG1EK1FnS0oyendj?=
 =?utf-8?B?MFlJSHNYSFNSemhKQ2dENytJUWhkaVpXdHRDWFZKYmhTZXdqNFBRcDFGdGY0?=
 =?utf-8?B?WE1oWkdmeldsTWZMaUNmTXpSKzRIRDJNOGxSaEV4UHFoQW16RVBwcUt4S0Nv?=
 =?utf-8?B?aXpHc0RpZldyMUNwdHZKR2U4WDhGaTJtZThtRDVSSjZsYnp0U1U1VTNvRW1y?=
 =?utf-8?B?ZzBDY2FLMVJ5M2VQemgxL0xtaGV6cVBVV1REYVpTMHVPUVF0RXNQb3hUa3BX?=
 =?utf-8?B?OUJTdmNqakd2NlVTYVRtY3E5Q0hWQzk4WUlLdUNhK0U1L0dvMEI5SmI5Mzdx?=
 =?utf-8?B?RGtJOE5IVHRBVHZiVS9vSnMweW5HTEJJdW5UczQzckxsQ2hOMnV5V3h2RFJJ?=
 =?utf-8?B?K09CL1lJS3lXVjlJZzIwNzJucTF6b2xOaDVENm5BOVUwdHAzU3VPMGxCYlFC?=
 =?utf-8?B?ZXFoa292blU2NUg1WnB5ZHA2M2NLaEN6bFdTTVhubTFNOWZvTEMyTlhXSG9E?=
 =?utf-8?B?Zjd2STF5TlROSTFqaG5iSVBHR1YzYjd4R1Qwcmd0UU9sNWY3UyswOEtDTENq?=
 =?utf-8?B?ZWlmY1ZGb3NabEljakFjcGc1WnFwTk12NU13eEMyMU1hbk1HVW90NnNYcTJB?=
 =?utf-8?B?T3V4T0xmRVpLam9xdVk4bGgyaFhpcFhmeFpoSXcrbXJnY1dCaGZyNzY0bUhW?=
 =?utf-8?B?aGxWVmZkczAvdzZTSFRyZjlKeW9QQTFRaEdKWmVxRVJ4QWVQdmFjamhYdHZS?=
 =?utf-8?B?YmRCcCtnYkJYMiswR2RFbjFib0V2YjdzVHlPeTc1Vi9lZWFiMW1ZQWJ3a1Br?=
 =?utf-8?B?NWhaNCtwckhTTFMzSUZkeGhVK0Z5LzV0MnIrdHR3ZDcvaVVGUHZ5aWpuOGdv?=
 =?utf-8?B?ZDdnUEJxc0s1eGF5dHVrdzlhblZ2cGlLYTJCZlFlV0E2MkxxTUN2WHdNL05N?=
 =?utf-8?B?dWE2R2ZJclQ5K09nL084TWV0QjJVWUhRSml4bWxZc2JlL2ovOTNoMmlqd3pL?=
 =?utf-8?B?bWt4eC9hRW13a2N5Q0VYdkJGOEdHUlh2bGQ2cC9sS3BvcUVtNUk5UkMveGJ1?=
 =?utf-8?B?MERqOEt0eHAycmtqZmtzR1M5Zks1Z3M1R0xpREQ3YzNaTFZDMWxFTzE1TE8r?=
 =?utf-8?B?c0FyUzlLOHVPbFpPSUNTeUozMEhXT3Zrd0lCQnNKS3lZdDgzUlFMeUVKZDZu?=
 =?utf-8?B?UFhPTXJmZUhRQWF6ZTI3L3JRWVQvQmNzbHlOaVZQc05qdWppeXBTYnIyNFJu?=
 =?utf-8?B?Q2dISlBleW1kNTM2SDhDRUxMYjRDREtxVG9pTE1tUjF5WFBvNnhUYW44Zk50?=
 =?utf-8?B?WXBhWit5WTNrN3lkTGRpeHJZczNvWW1OUWVIMEdvVVNZWFAxRWVGMUNOUkNm?=
 =?utf-8?B?ZzBsMWxJSzBVbmdsK2xJQ21mUkNNMFFkQ1ZVNGpYVWl1RTlHNm96OUZSZk5L?=
 =?utf-8?B?UTZsRTRVcEZmdjRocktMakc3UWFaUi9UTkt5V3RpVHc2TkE5b1BRUS9VcDBZ?=
 =?utf-8?B?K2l6RTZVTmpybEVZWHNVUnhDLy9wVWhaajFoVml4bVhVMzhBT3BOQ2ppSWN4?=
 =?utf-8?B?SENoRzBrVm9NWitmY2daQS9Rd0tqelBTR0N3SVg1M2FXSXFlVDJUZmVKODVZ?=
 =?utf-8?B?NzFaa0l1R3QzTG1HRFJnRW51YzhFNUZiZzVEU0FZZzdRSXJGcHk2eE5LbXpi?=
 =?utf-8?B?SGM5aDRnSC81Qnh1S0RncHErcCtZemZCaVBmQkVQbnFid0lMM1g2U29BeWlz?=
 =?utf-8?B?U1I3NlJlYVU1aW5FZFlnOElCY2xYbFhFNjhSWWQ1WlpLUDJ2R0RsWXBUUmQv?=
 =?utf-8?B?ZDRpdlE2K2hCd21rNGduMWpjWmFWTTk1YWVpMWNIRmRMUDFPcUZJcmZjQi9j?=
 =?utf-8?B?Q0NQeGlTNzJScGM0WFVXTzBFamxwUzYyVmI0RmlBMEpiU3BsbGpLdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f55c1db-d02f-449f-493c-08ded5e8e317
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:15:35.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XP9lJAuc55Y9ge3nriqs+gKOrop1n30g6kIrtl5sxdyT1Zd3XqOaTbMqtVKkHQK4+eXUuYUvEoIQPxgi7GU/LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2411
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9477-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:gary@garyguo.net,m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:laura.nao@collabora.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 595FB6DC021

On Mon Jun 29, 2026 at 12:37 AM BST, Danilo Krummrich wrote:
> On Fri Jun 26, 2026 at 4:45 PM CEST, Gary Guo wrote:
>> This series presents a major rework of I/O types, as a summary:
>
> There are two minor rustdoc warnings:
>
> 	warning: unresolved link to `include/linux/iosys-map.h`
> 	    --> rust/kernel/io.rs:1456:7
> 	     |
> 	1456 | /// [`include/linux/iosys-map.h`] in C.
> 	     |       ^^^^^^^^^^^^^^^^^^^^^^^^^ no item named `include/linux/iosy=
s-map.h` in scope
> 	     |
> 	     =3D help: to escape `[` and `]` characters, add '\' before them lik=
e `\[` or `\]`
> 	     =3D note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default

Hmm, this looks like a false positive introduced in new version of rustdoc.
I didn't get this with rustdoc 1.85, but do get it in latest rustc, however=
 the
generated link is correct despite the warning.

This pattern is used by other code, I'm unsure why it doesn't trigger there=
.
Anyhow, the following diff seems to be able to work around the issue.

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 0c5f53dd0939..5f2f3cafb0a2 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1453,12 +1453,10 @@ fn as_view(self) -> <Self::Backend as IoBackend>::V=
iew<'a, Self::Target> {
 ///
 /// This can be used when a piece of logic may wish to handle both MMIO or=
 system memory but does
 /// not want or cannot be generic over I/O backends. This serves a similar=
 purpose to
-/// [`include/linux/iosys-map.h`] in C.
+/// [`include/linux/iosys-map.h`](srctree/include/linux/iosys-map.h) in C.
 ///
 /// This type can be used like any other types that implements [`Io`]; thi=
s also include
 /// [`io_project!`], [`io_read!`], [`io_write!`].
-///
-/// [`include/linux/iosys-map.h`](srctree/include/linux/iosys-map.h)
 pub enum IoSysMap<'a, T: ?Sized> {
     /// The view is I/O memory.
     Io(Mmio<'a, T>),

> =09
> 	warning: unresolved link to `View`
> 	    --> rust/kernel/io.rs:1620:74
> 	     |
> 	1620 | /// In addition to projecting from [`Io`], you may also project f=
rom a [`View`] of an [`Io`].
> 	     |                                                                  =
        ^^^^ no item named `View` in scope
> 	     |
> 	     =3D help: to escape `[` and `]` characters, add '\' before them lik=
e `\[` or `\]`

Oops, this is a stray comment from earlier version that I didn't remove. Th=
is whole line can be
removed.

> =09
> 	warning: 2 warnings emitted
>
>> Gary Guo (19):
>>       rust: io: add dynamically-sized `Region` type
>>       rust: io: add missing safety requirement in `IoCapable` methods
>>       rust: io: restrict untyped IO access and `register!` to `Region`
>>       rust: io: implement `Io` on reference types instead
>>       rust: io: generalize `MmioRaw` to pointer to arbitrary type
>>       rust: io: rename `Mmio` to `MmioOwned`
>>       rust: io: implement `Mmio` as view type
>>       rust: pci: io: make `ConfigSpace` a view
>>       rust: io: use view types instead of addresses for `Io`
>>       pwm: th1520: remove unnecessary `deref`
>>       rust: io: remove `MmioOwned`
>>       rust: io: move `Io` methods to extension trait
>>       rust: io: add projection macro and methods
>>       rust: io: implement a view type for `Coherent`
>>       rust: io: add `read_val` and `write_val` functions on `Io`
>>       gpu: nova-core: use I/O projection for cleaner encapsulation
>>       rust: dma: drop `dma_read!` and `dma_write!` API
>>       rust: io: add copying methods
>>       rust: io: implement `IoSysMap`
>>
>> Laura Nao (1):
>>       rust: io: add I/O backend for system memory with volatile access
>
> For sharing with the drm-rust tree:
>
> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index 3ee19ef6264e..6868b5d80ab7 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs
> @@ -29,9 +29,10 @@
>          to_result, //
>      },
>      io::{
> -        Io,
> -        IoCapable,
> -        IoKnownSize, //
> +        IoBase,
> +        Region,
> +        SysMem,
> +        SysMemBackend, //
>      },
>      prelude::*,
>      scatterlist,
> @@ -467,6 +468,28 @@ pub fn owner(&self) -> &Object<D, C> {
>      }
>  }
>
> +impl<'a, D, R, C, const SIZE: usize> IoBase<'a> for &'a VMap<D, R, C, SI=
ZE>
> +where
> +    D: DriverObject,
> +    C: DeviceContext,
> +    R: Deref<Target =3D Object<D, C>>,
> +{
> +    type Backend =3D SysMemBackend;
> +    type Target =3D Region<SIZE>;
> +
> +    #[inline]
> +    fn as_view(self) -> SysMem<'a, Region<SIZE>> {
> +        let ptr =3D Region::ptr_from_raw_parts_mut(self.addr.cast(), sel=
f.owner.size());
> +
> +        // SAFETY: Per type invariants of `VMap`:
> +        // - `addr .. addr + owner.size()` is a valid kernel accessible =
memory region.
> +        // - `addr` is page-aligned, which satisfies `Region`'s 4-byte a=
lignment requirement.
> +        // - The memory remains valid until this `VMap` is dropped; sinc=
e `self` is `&'a VMap`,
> +        //   the borrow prevents the `VMap` from being dropped for the l=
ifetime `'a`.
> +        unsafe { SysMem::new(ptr) }
> +    }
> +}
> +
>  impl<D, R, C, const SIZE: usize> Drop for VMap<D, R, C, SIZE>
>  where
>      D: DriverObject,
> @@ -508,69 +531,6 @@ unsafe impl<D, R, C, const SIZE: usize> Sync for VMa=
p<D, R, C, SIZE>
>  {
>  }
>
> -impl<D, R, C, const SIZE: usize> Io for VMap<D, R, C, SIZE>
> -where
> -    D: DriverObject,
> -    C: DeviceContext,
> -    R: Deref<Target =3D Object<D, C>>,
> -{
> -    #[inline]
> -    fn addr(&self) -> usize {
> -        self.addr as usize
> -    }
> -
> -    #[inline]
> -    fn maxsize(&self) -> usize {
> -        self.owner.size()
> -    }
> -}
> -
> -impl<D, R, C, const SIZE: usize> IoKnownSize for VMap<D, R, C, SIZE>
> -where
> -    D: DriverObject,
> -    C: DeviceContext,
> -    R: Deref<Target =3D Object<D, C>>,
> -{
> -    const MIN_SIZE: usize =3D SIZE;
> -}
> -
> -macro_rules! impl_vmap_io_capable {
> -    ($ty:ty) =3D> {
> -        impl<D, R, C, const SIZE: usize> IoCapable<$ty> for VMap<D, R, C=
, SIZE>
> -        where
> -            D: DriverObject,
> -            C: DeviceContext,
> -            R: Deref<Target =3D Object<D, C>>,
> -        {
> -            #[inline]
> -            unsafe fn io_read(&self, address: usize) -> $ty {
> -                let ptr =3D address as *mut $ty;
> -
> -                // SAFETY: The safety contract of `io_read` guarantees t=
hat address is a valid
> -                // address within the bounds of `Self` of at least the s=
ize of $ty, and is properly
> -                // aligned.
> -                unsafe { ptr::read_volatile(ptr) }
> -            }
> -
> -            #[inline]
> -            unsafe fn io_write(&self, value: $ty, address: usize) {
> -                let ptr =3D address as *mut $ty;
> -
> -                // SAFETY: The safety contract of `io_write` guarantees =
that address is a valid
> -                // address within the bounds of `Self` of at least the s=
ize of $ty, and is properly
> -                // aligned.
> -                unsafe { ptr::write_volatile(ptr, value) }
> -            }
> -        }
> -    };
> -}
> -
> -impl_vmap_io_capable!(u8);
> -impl_vmap_io_capable!(u16);
> -impl_vmap_io_capable!(u32);
> -#[cfg(CONFIG_64BIT)]
> -impl_vmap_io_capable!(u64);
> -
>  /// A reference to a GEM object that is known to have a mapped [`SGTable=
`].
>  ///
>  /// This is used by the Rust bindings with [`Devres`] in order to ensure=
 that mappings for SGTables
> @@ -638,6 +598,7 @@ mod tests {
>              UnregisteredDevice, //
>          },
>          faux,
> +        io::Io,
>          page::PAGE_SIZE, //
>      };
>
> @@ -714,7 +675,7 @@ fn compile_time_vmap_sizes() -> Result {
>          assert!(ptr::eq(vmap.owner(), obj.deref()));
>
>          // Verify the max size matches the actual object size

The comment can be updated as well. Other than that, it looks correct to me=
.

Best,
Gary

> -        assert_eq!(vmap.maxsize(), PAGE_SIZE);
> +        assert_eq!(vmap.size(), PAGE_SIZE);
>
>          // Make sure creating a vmap that's too large fails
>          assert!(obj.vmap::<{ PAGE_SIZE + 200 }>().is_err());



