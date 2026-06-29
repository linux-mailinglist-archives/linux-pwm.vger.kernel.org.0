Return-Path: <linux-pwm+bounces-9473-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9N8PAU1qQmq36gkAu9opvQ
	(envelope-from <linux-pwm+bounces-9473-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:51:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D65C6DA8D7
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:51:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=XDmMDCQC;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9473-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9473-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 993F030CBEDB
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D0405845;
	Mon, 29 Jun 2026 12:41:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020084.outbound.protection.outlook.com [52.101.196.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72D3FFF8E;
	Mon, 29 Jun 2026 12:41:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736893; cv=fail; b=XORUx50xEOJ1J32akYCiiYAY5RrIzvjkjLixFnEYLQvxdKwOWyy8j8q28kMmRmug2IouJm+KZxJp3ct9Rl4j31zI2ARZa/74sjwlQbBlgZEIps9dKXyjh1kbHOkQ/fEL4kp8KW09kLte9hSzNulnPNM1PJSsW0BbmWKpaqJpfFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736893; c=relaxed/simple;
	bh=LDYYTVUp+R/1yfTxR5yae1AUWBO/WnHWcue8BMxLq00=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=cj30aa1OJctDo1bn5VpeUv3h3vB7bxPZGR0nm9ZEmXA1AxKgZ23woj2p7JvB8Whd0SxvcHzyz9lDN7XZbGwt1Fvi+WsN4N2J/LdObOLtcRYmfsOfPew+5i541rWgGxy6TUjzpwUgH6PcXtSGwiShgtlFVtcG1bFqaLf0m1QFGUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=XDmMDCQC; arc=fail smtp.client-ip=52.101.196.84
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blEWDuLWsVAANWIznPsWEBD02+Mf2K5l03e4YKtmvy1OFuJWoJ6KVQLmtDXPJ1aJBhTfz8wkFQLG9f/bkUn7gbXJ3f3o9CMnqTHJm1cxd3z+6GKSjak9s1z44r1Wbgpinj4zs+F6m4ah/ywN19m0FbObW4LcPaR1gbfetQ8AtY70b2CrG0zFtk6C1NH5rwehV6naXk/+zr8vx/phsDWKKWkYg8vMl4c3PR4WH/Ia5yqggRpYL7/962eeQzfg9165pgyO1q7JTV5ifallm5d+pppzMAx+4VGSbuppOW3MmRrS1mDVgns2QQ67QXiCcn962epxLLdGWExTgq3gxqfjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vliDejBhmFLgEJKSBy1bIstOMBmAcE7Fy81DTJxfL74=;
 b=MYundaLZS1vtExkL+7vGFfQb7rK9XOUBpftPoZf9xJ5XBemI2XNLAQM6znQBVw/U0duVx6Bmtr9ZZsQFnA5NhHxNCOjpOqYm7izM/TT/7cY8VbX9Lyzh3DfxM4bpuVSX1N4rMCgLWnwND4tHKot72V/tvn2I4cus2Of/DxtBWo3XQI6zYOroqey18kptCjUjpmlgE4sHmYhVUhN5ltkbz66QrLETXRv+op6agqnOgYoGWew5gKbevPVcA+MY5gUG97wD46ITpLzWtKBLgjIUuNYjOMPL4zA4aYVw5ZNmHuXZE1k7uYJDvSlgumQHnqWGwboUdnRF0omhw/rNCiSLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vliDejBhmFLgEJKSBy1bIstOMBmAcE7Fy81DTJxfL74=;
 b=XDmMDCQCBTgjBmB7qX5z3CTo3uFtCTFuEEEsSAkczt30JIDKgBO12aXk2hkevQip06ivPC93B8mFrNwdVxjpTE54kBCRMWlVOBCXxKryIPoTFN47IAu5FcrocTdoGzj+/ngenhldBtFYJ11WxZGLOqzlOldblz1iLXS5IuztdoU=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB5932.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:29d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:41:29 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:41:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 13:41:28 +0100
Message-Id: <DJLJHGBA8ZGJ.2LBSFEZ5A72VL@garyguo.net>
Subject: Re: [PATCH v2 00/12] rust: driver: use pointers instead of indices
 for ID info
From: "Gary Guo" <gary@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <iweiny@kernel.org>, "Leon
 Romanovsky" <leon@kernel.org>, "Len Brown" <lenb@kernel.org>, "Igor
 Korotin" <igor.korotin@linux.dev>, "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 "Drew Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu
 Wei" <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-usb@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260629-id_info-v2-0-95a18280fe30@garyguo.net>
In-Reply-To: <20260629-id_info-v2-0-95a18280fe30@garyguo.net>
X-ClientProxiedBy: LO3P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: d0428ac3-862d-4ed6-4d28-08ded5dbbdc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|10070799003|376014|6133799003|56012099006|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	GXPChxqk5kPloF3jde4sbirbhTs23B+Q5bYyoMfs+Rej4RmoTSezWPvRqcR++O0+Ql6GvvjgqB9QEHCiIv9iXNEQqv69PYsJawzhb8n7jwnmocbMrsnBBGgbpRnduWi+q7+CE0e7bVmKp+/McdSn7Ci9YEpLThWvijS7NZ9G6Jm5M6CWeY9QUaCLSi/AKvLQLEObMq5VtWTY4R1PfoiD+cbOcKaRSUVXv8aPZuO/UoJWsuot1arAzK0yWKkL+EIcrhMEKU/pVbLU8pZ3UkHZ+PzA+FqseYpOC0Rm+v6MHXEYwrMa7+M6tIetNvc5ZVYFCvK0lyPfZNOl5j8TA2ROyTwZMjxU4APcldXlEx/oEwvTfZ1JiQz7SJGpm+Qon23H43r6rPeOWGTnz7hFI2/nw9ad9xmtEcm5mFJ98BP4WXioQRE+u8dDFt2Bctgb3oK4A4lHKZmXXosBg/Y9TiYiGUrmVEqwZ1JNJBfhA0F0CDxeu++HjHVOcPcWkaeKMZmkahcdTHmWAh+oing8Vq/jVfKCAKaDm89Z2BIP0lPXcnuSbiIh2lcQBuo3jn090OZhs6FRTwBfupR7yqMit4J1pftzmrPSp7G8Gn3nNDQO/zakFvFzIJVOsoxNKjxaQexcET56xev8Wirk/qzSb4qvsazlA9L0bZ8xS6LZR99Juwc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(10070799003)(376014)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGdsVW1TMzRzWnd3dVdKTzJnY3ljUlI1M3ByUk1wdndZQlpJbkhueW5FNEs4?=
 =?utf-8?B?M3ZhYUNaMHlYVEZmYTlrT3YvclJLS0gwY0krb0FRWE9GZ0hXUWNEM1hHZk15?=
 =?utf-8?B?QjdoNzRYZGV4SHNzWCtzQ0dwcmJyN3BJQ0tIVlFwdG9iWWNQSXI5cmhzQ1BC?=
 =?utf-8?B?SlppYWNqR0REYlZhYWRQci9BWmRHeTFpZGpJMXNpeGNDbEoyYitQZUlDVW9H?=
 =?utf-8?B?QVFKdHdSR1F2N1doemp3cms2dFVteVcwM0R2S3BFRFlGcFEyZWdNaEFxZm5i?=
 =?utf-8?B?Z0NEbmF2U2Jubkx6MjVSazNabXBaU2NWQlAvWml0anhoY0RqbEdaMThaVk4x?=
 =?utf-8?B?bnlqcmdmdXJMcDAzMnNHSExReUYrdVpySmhrN3hxZTVGYzBSNVhwN1R5TVVh?=
 =?utf-8?B?SjdLUGx0ejNad1Q3dUtleUhETlhsVm5KVW50ZG1rTlN5LytnVzFpUXlHc0RM?=
 =?utf-8?B?SmlBTGUyczZJYis3TFVLcmZTaWpUWG5FYzdWZ0FWNjhZM1Rab3AxWWJaSnNo?=
 =?utf-8?B?TGNCbnJEVlFnSzhaMFVMeVFHNUsyOURoWDc0WEFSRjFqdW1zRThyL2hTRTZm?=
 =?utf-8?B?T1luVTRCcXdnTFpRZ0VkSVdFQ2oyTlAyeUpMb2c4ZGVBaVhWVmlOYlBzaXgv?=
 =?utf-8?B?NXQvZnI4R2NCeHRvZ2NQaVMvRlJSRWRuR1VKVzhBRjd2L1RnN0dVVnREbUdS?=
 =?utf-8?B?UUprdmJOMTMxUXZZNDBvc0sxM3F0UklURkVleWtYRzlaTDFkK0htWTZZZ0NL?=
 =?utf-8?B?WGZlZXV6UjVjQ2c4Nm9ITWsvMEVkdW8xT0ZUakhSaDhKdEF5S3Z5QmhQTG9z?=
 =?utf-8?B?cnJaUHBpbi80YnBWTDNsV0hKdldUU09FVjFmL2pNYm96cHRLYWJsQ210N2Jw?=
 =?utf-8?B?dCtKelBZbm50alA5Q1NlWXZUdkpWaGRNeGFRTEtqUFhyWFdqRlRVTUJLMnhC?=
 =?utf-8?B?cmJzekt0L1gwaSt4UisyUmY4NkF0aENLL1lEZXhWZE1MT2NZM2tUQmtBU3ZK?=
 =?utf-8?B?dVpwN1ZNZjNXME8rZ2JSQ1ZPVFhDbkNyQWs2WmRnaysySDRlTytTemdTdEhW?=
 =?utf-8?B?dmRxZ2VZTEZ6Q280WW5EODdTTndWTm5NTDBwK3I3enVtVU9iQTdGT2JCRUxa?=
 =?utf-8?B?YnVYdVZRaVlwMUlHSnpxYmlaN2pWTEtLQ2xuNDU4QnFUb0RHRWRCU2Rha1hX?=
 =?utf-8?B?QTNtRW9TcURIbGJ0OUpJTWJGTUp0dnZvR0JrSjFqQzB5SmVMdURyTklxYS9x?=
 =?utf-8?B?WFFKbEZObGQ4bEVtZ3ZTM29hRkdNVUxVbldCclpBUTFnN2JOZFBIdWNxZ0Mv?=
 =?utf-8?B?c3NYTE92M01VbU4rSW0xNXhkV1RDN002VUtBOUpZRXp6Zk96TzErU0RCZFJy?=
 =?utf-8?B?WDNnZ25KcU5LcVFnWFo2UW9xaFNIUjBURWJkanBLaTNPTmUwMTFXVFczRzhH?=
 =?utf-8?B?RXBNbzNZRk9xaGZ3R2FYMHVlSmtjV2d6ZmpLendrbkhxNHQ0R1NmaHpOM2o1?=
 =?utf-8?B?Q2F1ekNGdWhDUzRwTWxCUnZWODJSTVdUNHZpMHczOFRNdWJtR0kxdkJKdUZx?=
 =?utf-8?B?bXFTMWN3TDNZbHhKSXRmcEV6Qkl5emt3TU9yTGlZZkVrT3hMcWYzdlFIeVN1?=
 =?utf-8?B?RWU3YXFqY1JLbHZIUmlxRGJ6OVRrV0Y0bngrWjBBMXlpdEJ3SFRubGE3WVZY?=
 =?utf-8?B?VndKZWlGS1hralZpMWRGb2xJbTNSVWVmWU1lbU5VRTN6MjhNR0tQSWJMMmkz?=
 =?utf-8?B?Z28rZTFHaEZqMGJQK3UraGRrZkdzZXpFSy9oWmRlbm0zZFZwOXJlaU15WUcy?=
 =?utf-8?B?MXdyTU1VTm85L3Jsc001YlB2dkMwNXR2YzkvRm5YbEpXbG1jNlE0bkU1RVN1?=
 =?utf-8?B?Rzc3ek0rUGsya0EySlNJajljZTY5dEVKWXZSVWtncjBFU3R0bW9ZcUJNcWxq?=
 =?utf-8?B?VDdxM1lEeVd0K2szb3M4M2dhN3BBWmJ3VFRIL3hZY2pmMzE0ckQ2OFBYNkZW?=
 =?utf-8?B?RWZZSXBicXNOblBhSXlNYVhCL1RGcjhKN1hsSHIyYXZUZytMcnczVDNLWlhN?=
 =?utf-8?B?WVIvVFg2QTl5MEliaUxZSm50R0NBVmtUOTNMTDV2ZXBBMjY4RkNzVXA4TlFP?=
 =?utf-8?B?d2NUZ1Q3Y1ZJb0w3eEF1Tk9TM3kvSWZBL2dmQ0VjcVltWFA4aStMZ0Z5aFI1?=
 =?utf-8?B?bUpqTE5ZcjhpM09nZ09Qd3c0WWFZaGlvQmQzMklIWlFRQTdtbWxtaUdPK0Qz?=
 =?utf-8?B?cFdFNTI4bXhMS0R2WWpnaENZdUxZbUN2bkRIVm03MzJEd2x5OThHd3d4Rk9K?=
 =?utf-8?B?SnJ6OGtmZzdTL2YySmd1M2NzelRHeGNjUWVjL0hHdWJ5MjZMWnZmUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d0428ac3-862d-4ed6-4d28-08ded5dbbdc1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:41:29.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2/Ds9cDeCcAKKu6U05PToYFVFUDvnsBxAcyd7O1gnIP1sJ1jFwxDLGOtAOZzdycFSpNDgF2shMPIuIcDxPJDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB5932
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9473-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[garyguo.net,linuxfoundation.org,kernel.org,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,gmail.com,ffwll.ch,arm.com,intel.com,linux.dev,linaro.org,samsung.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fujita.tomonori@gmail.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:david.m.ertman@intel.com,m:iweiny@kernel.org,m:leon@kernel.org,m:lenb@kernel.org,m:igor.korotin@linux.dev,m:robh@kernel.org,m:saravanak@kernel.org,m:viresh.kumar@linaro.org,m:m.wilczynski@samsung.com,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pci@vg
 er.kernel.org,m:linux-acpi@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:linux-usb@vger.kernel.org,m:fujitatomonori@gmail.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D65C6DA8D7

On Mon Jun 29, 2026 at 1:38 PM BST, Gary Guo wrote:
> Most C drivers use a pointer (and cast to kernel_ulong_t) for driver_data
> fields in device_id. Rust code currently does not do this, but rather use
> indices. These indices then needs to be translated to `&IdInfo` separatel=
y
> and this is by a side table.
>
> This leads to open-coded ACPI/OF handling in driver.rs, which is not
> desirable. Convert the code to use pointers (or rather, static references=
)
> instead.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> Changes in v2:
> - Change USB to take `Option<&IdInfo>` in addition to PCI due to ability =
to
>   dynamically add IDs.
> - Mention dyn IDs and driver_override in safety comments and justify why
>   they're correct.
> - Link to v1: https://patch.msgid.link/20260618-id_info-v1-0-96af1e559ef9=
@garyguo.net

Oops, this cover letter is sent by mistake. Please see the 11-patch series.

Best,
Gary

