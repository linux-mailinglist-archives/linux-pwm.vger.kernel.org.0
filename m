Return-Path: <linux-pwm+bounces-9235-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZNPOOUkdIGpRwAAAu9opvQ
	(envelope-from <linux-pwm+bounces-9235-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 14:25:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1681263778E
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 14:25:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=HxNvRGkE;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9235-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9235-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 005E53067B63
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2026 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A55046AF2D;
	Wed,  3 Jun 2026 12:05:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020120.outbound.protection.outlook.com [52.101.196.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435843DA55;
	Wed,  3 Jun 2026 12:05:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488357; cv=fail; b=bReY1gpwqPu8reCM5XxBPI8jqO0F0BTUq3BxKIqD7Sd9KhR2OhIa9pqlUs4kCivoWVKbDRSLDaLXeRM/Akg0Z/b9xz/cYrfYbWQJuzay2gOgVb9+O/ksyotXfAftByvanyClwNiC4TfZNljzwgTaRnmWUeUmFSV1hpDoMwfSoDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488357; c=relaxed/simple;
	bh=uzihlwfRwPj7VuZa2N2cZWg3WKhVH10Wa4z8oNxCu7U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=f76n1Zgy0MVvnexdt7vpU1dFlSqxnKpSR2ZDlXuwxm/7+5g1tB/iVLesnDobw+fUaIzUs1iSj/6os9FERbo3U1xWQRhfq9oldKEH/HvGxpXaYwe5kk+H5OU9nIyQFNjQs0clpr12O5SR1fC0gl7M3JOPTSsaIlZ/4mfclrK9A/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=HxNvRGkE; arc=fail smtp.client-ip=52.101.196.120
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNQhPhPw69ghJqTeMflM+LpLRGpoJ7LW0+aAPBsmeL1+gHbsORKUUgtUlJC9B22zYiyyf7DAxlKIvgmXN8VTYUm+NH0sAZyKcP6R1VH4SCqq4sNuIQ7GNyXSGWpKY7oLC68d8bkVyjfmoY6hdS/D927IkNywxAfOfljwIDCm0W6Lb74zkU9ArIh8qxAuhZmAeVB2CvmLxMaNjVyGNF3lVInzn1wVLx0YwSAiHvTcuFPmWkkQxQIb5NVX2XzNDkUGdyfBq37fWZICfyVWuKNRveLgnYXjMeavVpBgK5lv9AA4L8aWkimk157QYrW5wVNVQZOKSubpjp3sohuY4tWvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WuB2yhn5r5KUd+0rQRstQKEruwydO6FmBKt1a0gjcY=;
 b=sSCOCiNzNtMglMil07miHzezKsTnHjMw7gLDxMWu6MKsV21YIJbJ5Apq3oAMMph26dUxrjE0Ajt1CZNz0kxUpV8dJ1NUOUbUjRjbA4xM4yl0+XBzl9Owl+nMyhQredObbXw6qQs5M0fukzuvC7gve8rd7zOatGPbMEWsZgEeBnD9aca0nnNWmKprlY1kiy39rJyTUnqMZlzi3XGvO000yAXzV+cjQnFD2PX7SX0MBP7F73/CLaMKjBI4RqRqdU4+L/oYv/v2cX/poDfUUbufSRQLMPA52wd8NyoadPFTwqOLGz2dax2e3/ssBSJVJ+KVd/vdPS25KylKyKf9ocJK+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WuB2yhn5r5KUd+0rQRstQKEruwydO6FmBKt1a0gjcY=;
 b=HxNvRGkEEZi+636pTqO6SBWORy/p93isxwrCNUvSPVeGYTgPo+yiWeaXoVMZ2CWijT9uF6Nf8GLOBdU1xOnkqXA/bDIdfyOnQKbICEpUXBa2sgwXmCcSX7gDZBbw7mc7CztCoQL4JMAhe/hKHV4GK+RGNFJgUgGcANvIfL32CZU=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5205.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:254::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 12:05:53 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 12:05:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 13:05:45 +0100
Message-Id: <DIZEFXX93XUI.38M3E0EM9VN89@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] rust: auxiliary: add registration_data_with()
 for ForLt types
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
 <20260603011020.2073650-4-dakr@kernel.org>
In-Reply-To: <20260603011020.2073650-4-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0622.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eaeeeda-d24a-4572-73c7-08dec168716d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|6133799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pN2NTQse2jcc84JRBr0QSRsgTvL7y/g7vZEkRkZRxWtQV9JmLKj8yeb3pCVCgtMheBTL4p7lvprAkQ4YjgEh0UrxUYjagmtvl9XbDUlaHm8OB7FQNeIfrpX6SrhSX/JYutwGu+ubAjP4nxSGucEvg9C2iNBcgBTVasUUvXDdW9HqPsRT1Wx/gu0Av/ok6KrhgY2RU5zaitN8ovpEfUjp15VPwRCXZcyvZtTtYbC81lRKsf61GFv0iAjtqPzvpLUaafjxFSr6UCFzh95rzezPc6u1m9DowU7YKgEGauBHXJlpXuN/LvTlevVucwbkRInkrgcazTs85kSS8r0rUbHRMg5APYxEIj1YPcWj+8IF2YTnoUTNKwCI9KawdihAhuP9g/oa7sla8vZw/iJRscbvGICp4vQ/kFn0T+dmdmB1EGpjsqUlza1cT91jLphxMcjDAuMQl5nUpl0+BvFIHTYptb7T0PdaXw811R0FV2Xsa8sNcK+AquRn3buHDWsp8OHSS+BO5Za2rZ7Mbh7KEBbrYm0HZ/aYLZPoZ1tCAPFLY3Td59reCJ0+6Pexesjcr6dHQu/s5bOnGpoHsnHrBvNEQ4meNzEEllNs+s+X34sYG62Cm6VJn1vFMeVUeFWh1wJRYvwxZjtV4ZTrn9pTUgDOT23KvEQjj2tr3O+rrlYDHYiAja+D46CjzoGoLVT7U34/03pIe4Clhk6hqn4SgK7+z2dUX5XOzaoKOVL20Xgf61w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(6133799003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmJkVHZNQXpZMXpUaUNCZnRqdUtsV3daeElQellTVHhybVB1d29HUHdzOWV2?=
 =?utf-8?B?Ulo5UzJqY1pKQ20zZk03TGV5Y2N5Q1JDTWVyb3dCNGVGaVlrNXZBSFFpdXRO?=
 =?utf-8?B?eUN5alRRMzBqbTZBQWw4ZThnNlh2T294WVNsemlWbWhZcEJ6MW9tczFtTWd6?=
 =?utf-8?B?YWdvSmtFdEhra0R1ZUtXOVhCUnBoZjMvWGp4eVQ5V1NGMEM4aEJpWlJHNThN?=
 =?utf-8?B?aE5sZld1VVFBbndJYmJFUUdDTGV6NFdWcDJZOEZnVkNvK1o5d1ZsSWtMNUNK?=
 =?utf-8?B?d2dVNkpwakgzWE1uRFBwbXd3SS9nMWd1d3R1bDQ0YUZub0w5MzhORnNlMFlz?=
 =?utf-8?B?UVNjUTBnYVVkamNZL005bVBEWURBQ29Kb3pRNm5CTXBsUzJYOHM3NDZ0Y2Zt?=
 =?utf-8?B?dUcxZHpVZSsrOTZFOHRwOGl3STkzV291a0Iwb093VWlZQzR4ZC83MmZSWVBV?=
 =?utf-8?B?WHY4OEVSNkVhQ0tsOUl0YUlyQ0MzUitiY3kwV3FnMDhENTk1Y09GSnFQUytU?=
 =?utf-8?B?QWNaMVg2VjFJL3VqZXVRZmNnM0RvSEZIU3U2ZXhZa2dySWJFSWRLSUJjempU?=
 =?utf-8?B?U0EyTVlkcVFtaEFmVFNYdmJaQ1RBRS9xdndiOGxiU2VPUkU1bnBSOU13KzJk?=
 =?utf-8?B?NGxhOGFwWGxLczBIOGRpbnpjbUVRbENNcElHeURWcVNidzU4VytyeWxsL2Y0?=
 =?utf-8?B?SXE2OGZmVmhxL1p5NG1iUWZzbW9PTFRIdFhIS0xtbndDd0FER00xb3BaRjAy?=
 =?utf-8?B?N3BYWS9odkdnYzg1ZDhtd2l5Z0dIb2ppL0JSZm5HcUlYK3BseXZKNi9Dbnpj?=
 =?utf-8?B?dW9QWlpjWTNuVEdCUlAxYUxYYTNvbE5WTDhKVlAzUmpKRm43bzdCUzF4dVJr?=
 =?utf-8?B?UjgvWjE2ZmxTYWhKWHhvcjBudE1xUTBHQ2dQcWlndytmZnVwL1g5bCtKL09w?=
 =?utf-8?B?ZnI5K2F2eEdTTnBkdGtzVE8vR3lBaVFJMDZKb01FOElpcUFGcUl0QkJ0Nkh4?=
 =?utf-8?B?cHBiak1MMThENFZGL3NRWlMzVFJCQXpER1dBT3JJRmc4VTRWUDZyWkErM3V1?=
 =?utf-8?B?TDhmaTk4d1FvT29OdXE3cU5pTEQwYzhpNXZqcENkL2lLdU9nN3FiMGxqZHBv?=
 =?utf-8?B?aW5yb0E2KzF0SmlKSlNvTlRjTmJzWnhiZHo2UCtRckZ1ME8yS3E3RU1FUGdI?=
 =?utf-8?B?SVJ1MUJsZldPOFJmSWplcGpteXZNSTN6eldMc1pia0dObmJBRm8ybWh5ekhx?=
 =?utf-8?B?V05yNHR4K0hzUUxUdW05aUxCeVdMVUhoeEk5VnpzQXVieUNROVJiOG5PUEt1?=
 =?utf-8?B?YTlNblVKV0JNb2hGVS9OeS90QnhoUUdrWVVlTVRpbVh1bWFKbXBBOUViNSsx?=
 =?utf-8?B?ejk0ZXVneEJpMXFwY0pjU1QrZXoyUjVWTUREZzZIdi9WSGdDZnM0R2NvZEV4?=
 =?utf-8?B?L3ZJQ0NNOTh3RGIvOS9mWkdyMDZLWHlVL2xlbXNQVWRmdmJYVWkxQ1JMb0l1?=
 =?utf-8?B?TU5vY2FVMTFGV09NZHZ6eG13VS9uYWhqQS9qLzZ3L3F1MmxyMzh2TzBMTkVm?=
 =?utf-8?B?VU8zWGRyQWc2UllDOXJsaVZwM2xaWEVIWjd3ZEo4Wkgzb0hnZ0ZpVVA0SDI0?=
 =?utf-8?B?dUpCMmc5alBBRklTUHg2WWtlb1Zvb1dLNWNPbFpkZE55dGVHYWZCQmc5VVR6?=
 =?utf-8?B?SVc5MFA5Z1REbDI4cmZjdFZkSE5YbHZORnRKSCtSYUdNdFUzTGp2M296bXB6?=
 =?utf-8?B?TGZuSmVYcjEzclY5Rkg1Yjg0RUhJdmZCRkpBdTJxTjdNbndSMHE0aG5vcGhL?=
 =?utf-8?B?Tml6OUNtU0pxRFNaZ3VCUDhZaWx5WmR3TEEzNTFma1REWHRUSnNaNzN1Tkhm?=
 =?utf-8?B?V0szS1ZudEl1ZlpzU3Q5VzJIb0VyS3FLUW93U1VtYXQrYTBKc1V2ZnVlY1Vp?=
 =?utf-8?B?akRIbmp5TmxBaVY5b3FPVUcyUzVYVzg2NVhNc1UyRC9aTjN1b0Z6QW9BdHBh?=
 =?utf-8?B?VjY3L2dvNlZUaXJkYWY0dVlERmt2YXBiWmE4cWdiNHY1em5YK0JlK1hWb2Mz?=
 =?utf-8?B?UXhJM1ZFMis2T0tWbFdlL1NXbUdSYkRERm1Kc3JaZHBacFhmVEJ2aWlDdWtB?=
 =?utf-8?B?aHNReG0yN1hBUXkyMU1VTERFT2dQb1ZhT0RFNFZyUHRJRUVQY3BTcjNSdG42?=
 =?utf-8?B?QzF1L0ZvUmE5WGs3eTdpdHkya3FPdXJRU1dHV1hGTUtKQk0zSXFTbVRvMWVS?=
 =?utf-8?B?QkdmRVMwZzlPWU0zKzlpNy85cWhIMTA2NDR2RTB1NnJZL3pEMFREQVF0Nldu?=
 =?utf-8?B?VVFJbjJSdDEzUkFMTkhFazJFQ1RpNEhHeXJESHZ0M1htbm4za3Zmdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eaeeeda-d24a-4572-73c7-08dec168716d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 12:05:45.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BUSqTPA+g1p5js3eG72zFEZboAlnGUu3ddtpS5/4b+OcwitD7MnMjhaQcaiSM66GwSM0Hj3XoQ7i3/78i0QfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5205
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9235-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,garyguo.net:mid,garyguo.net:from_mime,garyguo.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1681263778E

On Wed Jun 3, 2026 at 2:10 AM BST, Danilo Krummrich wrote:
> Add registration_data_with() taking a for<'a> closure that receives
> Pin<&'a F::Of<'a>>, which works with any ForLt type. Taking a for<'a>
> closure rather than returning a direct reference prevents callers from
> choosing a concrete lifetime for the data, which is required for
> soundness with non-covariant ForLt types.
>
> Extract the common null-check, TypeId-check and KBox-borrow logic into a
> private registration_data_pinned() helper shared by both
> registration_data_with() and the existing registration_data().
>
> Relax Registration's bound from CovariantForLt to ForLt so that
> non-covariant types can be registered.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/auxiliary.rs | 89 ++++++++++++++++++++++++++++++----------
>  1 file changed, 68 insertions(+), 21 deletions(-)
>
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 40a0af74a8e5..81549a3e347e 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -21,6 +21,7 @@
>      prelude::*,
>      types::{
>          CovariantForLt,
> +        ForLt,
>          ForeignOwnable,
>          Opaque, //
>      },
> @@ -270,18 +271,15 @@ pub fn parent(&self) -> &device::Device<device::Bou=
nd> {
>          unsafe { parent.as_bound() }
>      }
> =20
> -    /// Returns a pinned reference to the registration data set by the r=
egistering (parent) driver.
> +    /// Returns the stored registration data as a pinned `'static` refer=
ence.
>      ///
> -    /// `F` is the [`CovariantForLt`](trait@CovariantForLt) encoding of =
the data type. The returned
> -    /// reference has its lifetime shortened from `'static` to `&self`'s=
 borrow lifetime via
> -    /// [`CovariantForLt::cast_ref`].
> +    /// Performs null and [`TypeId`] checks, then borrows the stored [`K=
Box`].
>      ///
> -    /// Returns [`EINVAL`] if `F` does not match the type used by the pa=
rent driver when calling
> -    /// [`Registration::new()`].
> +    /// # Safety
>      ///
> -    /// Returns [`ENOENT`] if no registration data has been set, e.g. wh=
en the device was
> -    /// registered by a C driver.
> -    pub fn registration_data<F: CovariantForLt + 'static>(&self) -> Resu=
lt<Pin<&F::Of<'_>>> {
> +    /// The returned `'static` lifetime was transmuted from the device's=
 bound lifetime during
> +    /// registration. Callers must shorten it before exposing it.
> +    unsafe fn registration_data_pinned<F: ForLt + 'static>(&self) -> Res=
ult<Pin<&F::Of<'static>>> {
>          // SAFETY: By the type invariant, `self.as_raw()` is a valid `st=
ruct auxiliary_device`.
>          let ptr =3D unsafe { (*self.as_raw()).registration_data_rust };
>          if ptr.is_null() {
> @@ -306,10 +304,58 @@ pub fn registration_data<F: CovariantForLt + 'stati=
c>(&self) -> Result<Pin<&F::O
>          let wrapper =3D unsafe { Pin::<KBox<RegistrationData<F::Of<'stat=
ic>>>>::borrow(ptr) };
> =20
>          // SAFETY: `data` is a structurally pinned field of `Registratio=
nData`.
> -        let pinned: Pin<&F::Of<'_>> =3D unsafe { wrapper.map_unchecked(|=
w| &w.data) };
> +        Ok(unsafe { wrapper.map_unchecked(|w| &w.data) })
> +    }
> +
> +    /// Access the registration data set by the registering (parent) dri=
ver through a closure.
> +    ///
> +    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. The=
 closure receives a pinned
> +    /// reference to the registration data.
> +    ///
> +    /// For covariant types that implement [`trait@CovariantForLt`], pre=
fer
> +    /// [`registration_data`](Self::registration_data) which returns a d=
irect reference.
> +    ///
> +    /// Returns [`EINVAL`] if `F` does not match the type used by the pa=
rent driver when calling
> +    /// [`Registration::new()`].
> +    ///
> +    /// Returns [`ENOENT`] if no registration data has been set, e.g. wh=
en the device was
> +    /// registered by a C driver.
> +    pub fn registration_data_with<F: ForLt + 'static, R>(
> +        &self,
> +        f: impl for<'a> FnOnce(Pin<&'a F::Of<'a>>) -> R,
> +    ) -> Result<R> {
> +        // SAFETY: The HRTB closure prevents the caller from smuggling i=
n references with a
> +        // concrete short lifetime, making the round-trip from `'static`=
 sound regardless of
> +        // variance.
> +        let pinned =3D unsafe { self.registration_data_pinned::<F>()? };
> +
> +        // SAFETY: See above; the closure's HRTB makes the round-trip so=
und.
> +        let short =3D unsafe { F::cast_ref_unchecked(pinned.get_ref()) }=
;

This shouldn't be necessary, you can just directly call `f`.

Best,
Gary

> +
> +        // SAFETY: The data was pinned before the lifetime was shortened=
; pinning is
> +        // orthogonal to lifetimes.
> +        Ok(f(unsafe { Pin::new_unchecked(short) }))
> +    }
> =20
> -        // SAFETY: The data was pinned when stored; `cast_ref` only shor=
tens
> -        // the lifetime, so the pinning guarantee is preserved.
> +    /// Returns a pinned reference to the registration data set by the r=
egistering (parent) driver.
> +    ///
> +    /// This method is only available when `F` implements [`trait@Covari=
antForLt`], which guarantees
> +    /// safe lifetime shortening via [`CovariantForLt::cast_ref`].
> +    ///
> +    /// For non-covariant types, use the closure-based [`Self::registrat=
ion_data_with`].
> +    ///
> +    /// Returns [`EINVAL`] if `F` does not match the type used by the pa=
rent driver when calling
> +    /// [`Registration::new()`].
> +    ///
> +    /// Returns [`ENOENT`] if no registration data has been set, e.g. wh=
en the device was
> +    /// registered by a C driver.
> +    pub fn registration_data<F: CovariantForLt + 'static>(&self) -> Resu=
lt<Pin<&F::Of<'_>>> {
> +        // SAFETY: CovariantForLt guarantees covariance, so cast_ref saf=
ely shortens the
> +        // `'static` lifetime.
> +        let pinned =3D unsafe { self.registration_data_pinned::<F>()? };
> +
> +        // SAFETY: The data was pinned before the lifetime was shortened=
; pinning is orthogonal
> +        // to lifetimes.
>          Ok(unsafe { Pin::new_unchecked(F::cast_ref(pinned.get_ref())) })
>      }
>  }
> @@ -399,22 +445,23 @@ struct RegistrationData<T> {
>  /// This type represents the registration of a [`struct auxiliary_device=
`]. When its parent device
>  /// is unbound, the corresponding auxiliary device will be unregistered =
from the system.
>  ///
> -/// The type parameter `F` is a [`CovariantForLt`](trait@CovariantForLt)=
 encoding of the
> -/// registration data type. For non-lifetime-parameterized types, use
> -/// [`CovariantForLt!(T)`](macro@CovariantForLt).
> -/// The data can be accessed by the auxiliary driver through [`Device::r=
egistration_data()`].
> +/// The type parameter `F` is a [`ForLt`](trait@ForLt) encoding of the r=
egistration
> +/// data type. For non-lifetime-parameterized types, use [`ForLt!(T)`](m=
acro@ForLt).
> +///
> +/// The data can be accessed by the auxiliary driver through [`Device::r=
egistration_data()`] and
> +/// [`Device::registration_data_with()`].
>  ///
>  /// # Invariants
>  ///
>  /// `self.adev` always holds a valid pointer to an initialized and regis=
tered
>  /// [`struct auxiliary_device`] whose `registration_data_rust` field poi=
nts to a
>  /// valid `Pin<KBox<RegistrationData<F::Of<'static>>>>`.
> -pub struct Registration<'a, F: CovariantForLt + 'static> {
> +pub struct Registration<'a, F: ForLt + 'static> {
>      adev: NonNull<bindings::auxiliary_device>,
>      _phantom: PhantomData<F::Of<'a>>,
>  }
> =20
> -impl<'a, F: CovariantForLt> Registration<'a, F>
> +impl<'a, F: ForLt> Registration<'a, F>
>  where
>      for<'b> F::Of<'b>: Send + Sync,
>  {
> @@ -526,7 +573,7 @@ pub fn new<E>(
>      }
>  }
> =20
> -impl<F: CovariantForLt> Drop for Registration<'_, F> {
> +impl<F: ForLt> Drop for Registration<'_, F> {
>      fn drop(&mut self) {
>          // SAFETY: By the type invariant of `Self`, `self.adev.as_ptr()`=
 is a valid registered
>          // `struct auxiliary_device`.
> @@ -548,7 +595,7 @@ fn drop(&mut self) {
>  }
> =20
>  // SAFETY: A `Registration` of a `struct auxiliary_device` can be releas=
ed from any thread.
> -unsafe impl<F: CovariantForLt> Send for Registration<'_, F> where for<'a=
> F::Of<'a>: Send {}
> +unsafe impl<F: ForLt> Send for Registration<'_, F> where for<'a> F::Of<'=
a>: Send {}
> =20
>  // SAFETY: `Registration` does not expose any methods or fields that nee=
d synchronization.
> -unsafe impl<F: CovariantForLt> Sync for Registration<'_, F> where for<'a=
> F::Of<'a>: Send {}
> +unsafe impl<F: ForLt> Sync for Registration<'_, F> where for<'a> F::Of<'=
a>: Send {}



