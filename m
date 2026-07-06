Return-Path: <linux-pwm+bounces-9592-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mgt7ABitS2p0YQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9592-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 15:26:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 477FC7113EE
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 15:26:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=xkh9tr5g;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9592-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9592-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF3634D7AEF
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7561430317;
	Mon,  6 Jul 2026 12:44:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022091.outbound.protection.outlook.com [52.101.101.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1239D3DA;
	Mon,  6 Jul 2026 12:44:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341876; cv=fail; b=GBG3wvy5m9doKRPhmdOSupxjBKobxl8LAlMfKGyBTQU22OPwulgd3c3Rtao05Tq+aY0hnLL2trvsbY7rRPxyopRALIgZSiNxoJaPSruXBHTgIQ8EjR7aF7tvl+GvonzrEhQKRdGBwcohYMRq++cLNyxEz/ePeV+RhPZMTG/i0e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341876; c=relaxed/simple;
	bh=/+9QBq5wqQ+7DhXCrGUf2ay6ae8udBlXQBpQbA9Stt0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r0BByNXrdroIf03wbnrJbM3TBty3ppjB8zuGgxpcQHFgf7RYReYiQF1whfFA9wNIKf+FKEo8j5lflZI6Te4V7DSN1h/9wmOKes8oQL1VnBubrw7UbrSd+wUFA0SZYVBykp8KI7AEe2a4vDT0wRFNhdieLCv93HnOCPbfm+eaGvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xkh9tr5g; arc=fail smtp.client-ip=52.101.101.91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jywKM1UwQu/KSGie8NEi4t0kUUCuYEPsbm2Od8I4fJJbOBzlCN7AyumsrQAdkHUhJUGFJ6GVGQVxsHiJT1yQPfHjDEu11r+++L1bK17DJ6a+TgRq8udW6tA/Qk/bQi6vvOEme3Mcmydx8az1lF3qCldBvJiTwGWVNfj1aePyYbmddJz4qcHiBlcGR7uiREza/WdKC7hGF/QE2nSDI9dCIJISMgg5kDW89cpwg6UW/XWihLlZIVdIemaV1E5gFMDiZEZxlnTA8022q4eMTrpowXsjkbHk4Q0uOtBnlbwq/Nt7YnKbctXcQq049lg5fumwnphGtnOOh+DLKjXXfFknMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBdutDk0Ahu+/UoShsn2anWeFRUCisQ59/bVWLbrbY8=;
 b=Mh1oUTQ8ZmIutXrB9urE1Kiq/ogTF1tDn22CE5afCYmPsuq7CoBG5ykc165YWJv89H+GZ1vzB9LCoyeVkvA/MMwJbI0DtEbb6BJj9wybtEqREWTdCToQwytRLcAOgEqNVXK93vavV7SxLB4ubgM6B3E8mtHaNffTARs68Zle4wv279U3W15uENWBX8UFSNW9cECeLOwXJ2BfLUkVEAFifm70Qtdch9JvOvhTInMLOEtdrvv7wIYdqAXzJOVG1Rhv/1smQyogPFejb0jutVUaYTmTuC8YREMR0hcJTGQ7uGBEBw60wy9IJ4JIpBq1fc3UswvuZ4eawbvn3+AFuRNyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBdutDk0Ahu+/UoShsn2anWeFRUCisQ59/bVWLbrbY8=;
 b=xkh9tr5guqcHIE0zEj2DttdvTw2ybdeuyG9yl6JA6sW0zsQO5L7T2Ah9StUHwkgG+Y7X8VofeP9XMFhFN+Y8nCL/CuIK/pD/YW/6vK665J4DF7nhzJ/VY/twwFo7Zjr+St/PEE6kq0pZU4akiDUz8kP4U5gNfQ8GoXpufjVbttE=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:25 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:25 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:14 +0100
Subject: [PATCH v6 01/20] rust: io: add dynamically-sized `Region` type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-1-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=17177;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=/+9QBq5wqQ+7DhXCrGUf2ay6ae8udBlXQBpQbA9Stt0=;
 b=FJiyTxVBOny8khpduXoCnC/XMbwZp4appESeOpNXrBpQtYerkFxbsPNHgHVSCo/18OSyw1suW
 USuVmsFoEidBRAaIjAK5ZyMC3m+dxppdMYv5SAKc9XKO91YrGTy1/cl
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
X-MS-Office365-Filtering-Correlation-Id: 3c296902-2478-4bdc-d73c-08dedb5c4f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|5023799004|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	lkaMOYJnzOYJbWNlRft9nOjD88TMR5nMDxCsNxtUjsL/E/+tA0rHIHZAgS8/8oepkmfy+LKURaWSVEq1cVCak+Mpo9YcFmQZc1495gbB9S3EgdU9fkVad/85US7nKxRDSpbiwhI5JAA0DkJLmuUUoYt+5YsxfdU10CFx0QYcFkZjxrvQuLqlzAkAyxBZRN+jf37U6+YGTOOznU+sDcdPxEHtoe8TgdObXs8efCSZu0UXSq+QRMlEogU3/cLmfZFpHwU06apdWm1LwnArXF1bXxQlgufQjMFP4dM136x0re0OEBlLQtsCVwokoVXSDGFD1Nk32fN1vw54Y1z5BnKSNdLMevo/XZXEBNWo00kKJ+Ek4ELSmwmhKZjZdB70iIoGA7H5AWQOYTst9BskxEu+1dkfamksj5WX7JlcRLinzF9j8ffybw7XkS1duu7W74oqLKliX/7YS6UZyYLrQqyCG/2mQW+Xm8VxmP9xz6977kd/cxAzH8RSmm5UYM7jv4Q3H1iMc/FbovkKLEwEu304iVBtC7Lx/XilMIxTSb3QosnLXt93re4EQ/2HNjBDDoQFxgwafA2M95t4BvtAsFfDXSfJK6PVALKQ6zhfHwUdhFlEsrELylkhjEhW3b54Uv2987fS5dk8QsexQy0QOMleCKA6K1EF+ByJYjU4ULDZQjgqmnFPDnU8RBztle/OtgPBBNS6qvyVJseu9ld7oDmXxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(5023799004)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajNBdE5jR2cwMnk3cFNsWmRJOENxVFVWVW5mSFB2UFdKNEdCTjA5Zmlta3lz?=
 =?utf-8?B?V2w4Y2tOMENBVXorNUtuTXczR0hVcUV4V0w0TUtSazdLMURmZit3ZUxJdFFR?=
 =?utf-8?B?cno0S1Joa1I1bUFqRDc3UWtxY2hoQXdEVTQyYWVxaXd5bDRFSlJ6VHRESlFS?=
 =?utf-8?B?T3kxeFMzQ1dSQWI5b2FUaGxCbE9FR1E4cnlxUExTVzdmUFl0WCtRRkpPQUFN?=
 =?utf-8?B?MmxkUUxUS2xXUHRySDBVZDF3TnNuZjRRY2JITUUxdktoN1BRYnUyaE9CcVhC?=
 =?utf-8?B?c2J2SXNFUHlORkJkZkJKZFJjeFBTanhpdk0wMEVyd3BlVDUzcmZLR1JjWm41?=
 =?utf-8?B?bnJ2eGQ3Nmkzb1FkVkNpME1FQ0hRNGRCcVR2QUFRQWZzUmFCOG1aVUI2Y0NR?=
 =?utf-8?B?Z0NyOUxNdVYveGZQaW5WYlYxYTlKcmg2Rkt0Rzd0K2kyOHVmdFNFWU9UQkpV?=
 =?utf-8?B?R3B2WTdBM3BJYVZDa25nQWdHRkVQendGUFdCOU9kWko1RmhSR1pnejYrUlQx?=
 =?utf-8?B?K1VEZFV2UUdBeCs1SUFqeWZMUnpqK280SkhMeGtaM1BaS2pmbE4yUkVRS0M2?=
 =?utf-8?B?UjFtZVUzcFMxWDRGMEplVHp2QVFyRDZCSFd4T09ndWQ4b2tUTHFISFBlTTZU?=
 =?utf-8?B?cldqTnFNemJIM1ZNQm8xZ2FyRXV1czRjeU1xQ3NTLzdtUDZoczM0MEorQkpp?=
 =?utf-8?B?VjI3T29CRjBhbldZTS9saVBkMkRPcUVKeFdLdHVXUFpjV3dxRHZhaHBXQm05?=
 =?utf-8?B?a3BMN0xObWlFSlVsM2NFNnhicVhXZmdIUTlZaDJOUlFFeWdlV1VqVXdLZ2hV?=
 =?utf-8?B?UUk1c0JwbFJFYXhGWWZoVEVJSExLeTlEQzhiVmNiT2xuUXZCWi9vZm9QL0ZB?=
 =?utf-8?B?OHJWZG5HRkhpZ3puc1Zya3hyaDJHcGUyN1JVSlJJMG9ybHV1MmlIckdHaCs2?=
 =?utf-8?B?OHJ0V0ZxTTNOTXo1QzZyMllWWm9jYmxEODV0TVFMblJweXdHZjI4Z3V0UHlw?=
 =?utf-8?B?QnhzOGJpSDhtUTRSdGxoQklBQWh5aGxGaE1qbWNvN0c3VVB3Sk9nUmRzSGFS?=
 =?utf-8?B?djV0OFVFNnQ0ZnkwQStmdzlCWTZCL2FZa28xTXJiQTdDeUEzZDZ4NFpxYzZ4?=
 =?utf-8?B?d01oM0Q5cDdkZkMyQkh3ZWQwZzg4U3lRdjBmaUtzR2ZBaG1MdHZkczZnSEtr?=
 =?utf-8?B?VGpqNStyZmpzMlhXM1BWRkY5Q0wyTE5wRnJqZm91WU9DQlp3UVBrUS9zc00z?=
 =?utf-8?B?OWVLZWNzK2xoVkQ4RHM3Z2g2dC84YnJ4T09YR3hrS1hZTTRheDdBSnJNNjVF?=
 =?utf-8?B?SDdWdURaWnVRRnpRRE1sV0Jvdk1BZGtXbmsrcE9oU0l4aWpEVE16NHhmdjZ6?=
 =?utf-8?B?SldyNjB6SWs4d2Q3K21WSC9PUzF5QlUzQXUxak1rZk5McnBseEtuZ0lyWHl3?=
 =?utf-8?B?WlFVdmo1M1V5cFlhOXFnb2pWYXVBMDJ5UkFSR3ptR3cxd0tFa0FCc1lyalF0?=
 =?utf-8?B?NFJmckswWUUrK3d4UCtXWS9WekpnUHpzbmFNZ0NRM2syY29qN0crVk4vSCty?=
 =?utf-8?B?QkIyTW5RNkNaTWpEaHZrR2FYaUdZU3E4RzgyT3FmWjNFaU9Rc0p0azBTaEt0?=
 =?utf-8?B?U1dEbS9xeHpReDFmaWo3Q3NSMTNQMkpyZ2NzM1l5dzd4aEx3aml1QW82bEJ2?=
 =?utf-8?B?RUxBdS9wMjZEcWVRNHVMVjFIdzlpejJtM2JtUzlyNDZoa1pWZ3JpdXh4WDYr?=
 =?utf-8?B?TE9mbUs3WlNjdkN0aVczcHZObytFOUpHeWFOdENjc0FrYmVJL3lrWW4ydFpv?=
 =?utf-8?B?RHdlWU81OEI4WUFmYlVjQmN3dXJEZGswUDNVdElNZ1RrRE1sYWpSN1dEajl5?=
 =?utf-8?B?NjRWcmQzaThrNFlxT1JocS9JNHozMHFzR1RqTnBOVkZUQWN0YTE2aTBGNVIr?=
 =?utf-8?B?dVJnN0JCck5lQXBRYzZGaWNvNTd2RDFGakZPSGorMGpPMEJXcXR3UmhkczE0?=
 =?utf-8?B?TFVPbUNQbkVlL3JVQytLRmpPd0JSbnlYaWJzdWU3S0pJOGU5N3JOQU1DUkNI?=
 =?utf-8?B?VlV1THhZK3R2SVBacUdaZXdBMlk0RXRnMVQya2h5QTMzdlVrS3FTWFM4bFNS?=
 =?utf-8?B?Syt4NldJbFFXelYvZEFyTHhZUC9uNUJrbGtZT3dBNXFXZXV1b1I2K04rWERi?=
 =?utf-8?B?S3NpN2c3OTU2T1hZQXBqMG5xVFhiczk5dVUrNTZraUdMa0J5ZmlMNjU5Y1JC?=
 =?utf-8?B?NkQzMzlhZjBiZ29BRXc0L1ZCeWhHd09EejVuWGpGVDRzcU16eHJRUlNEaWhq?=
 =?utf-8?B?NGZyMXlzcTd6endvODBqUy9hZDVLVE1VaXlFaXlVemVTN2d4Zk9jZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c296902-2478-4bdc-d73c-08dedb5c4f62
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:24.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VODjXbRAMwxl7n2KEQU4RJ5MBtxY4vL/oco1omf63DoChmPQ1VsuhgagQkWARpevb4wd1pSbpKTDXStQVtBWYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9592-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 477FC7113EE

Currently many I/O related structs carry a `SIZE` parameter to denote the
minimum size of the I/O region, while they also carry a field indicating
the actual size. Proliferation of the pattern creates a lot of duplicated
code, and makes it hard to create typed views of I/O.

Introduce a `Region` type that carries the `SIZE` parameter. It is a
wrapper of `[u8]`, which makes it dynamically sized with a metadata of
`usize`. This way, pointers to `Region` naturally carry size information.
This type is required to be 4-byte aligned.

Expose the minimum size information via `MIN_SIZE` constant of the
`KnownSize` trait. Similarly, expose the minimum alignment information via
`KnownSize::MIN_ALIGN`.

With these changes, it is possible to add an associated type to `Io` trait
to represent the type of I/O region. For untyped regions, this is the newly
added `Region` type. Remove `IoKnownSize` as it is no longer necessary. Use
the same mechanism to indicate minimum size of PCI config spaces.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |   6 +--
 rust/kernel/io.rs     | 129 +++++++++++++++++++++++++++++++++-----------------
 rust/kernel/lib.rs    |   3 ++
 rust/kernel/pci.rs    |   1 -
 rust/kernel/pci/io.rs |  40 +++++++---------
 rust/kernel/ptr.rs    |  12 +++++
 6 files changed, 117 insertions(+), 74 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 11ce500e9b76..ed30ccc6e68e 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,7 +68,6 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
-///         IoKnownSize,
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr, //
@@ -297,10 +296,7 @@ pub fn device(&self) -> &Device {
     /// use kernel::{
     ///     device::Core,
     ///     devres::Devres,
-    ///     io::{
-    ///         Io,
-    ///         IoKnownSize, //
-    ///     },
+    ///     io::Io,
     ///     pci, //
     /// };
     ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index fcc7678fd9e3..d1c5f0121994 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -6,7 +6,11 @@
 
 use crate::{
     bindings,
-    prelude::*, //
+    prelude::*,
+    ptr::{
+        Alignment,
+        KnownSize, //
+    }, //
 };
 
 pub mod mem;
@@ -31,6 +35,57 @@
 /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
 pub type ResourceSize = bindings::resource_size_t;
 
+/// Untyped I/O region.
+///
+/// This type can be used when an I/O region without known type information has a compile-time known
+/// minimum size (and a runtime known actual size).
+///
+/// # Invariants
+///
+/// - Size of the region is at least as large as the `SIZE` generic parameter.
+/// - Size of the region is multiple of 4.
+#[repr(C, align(4))]
+pub struct Region<const SIZE: usize = 0> {
+    inner: [u8],
+}
+
+impl<const SIZE: usize> Region<SIZE> {
+    /// Create a raw mutable pointer from given base address and size.
+    ///
+    /// `size` should be at least as large as the minimum size `SIZE`, and `base` and `size` should
+    /// be 4-byte aligned to uphold the type invariant.
+    ///
+    /// Just like other methods on raw pointers, it is not unsafe to create a raw pointer
+    /// that does not uphold the type invariants. However such pointers are not valid.
+    #[inline]
+    pub fn ptr_from_raw_parts_mut(base: *mut u8, size: usize) -> *mut Self {
+        core::ptr::slice_from_raw_parts_mut(base, size) as *mut Region<SIZE>
+    }
+
+    /// Create a raw mutable pointer from given base address and size.
+    ///
+    /// The alignment of `base` is checked, and `size` is checked against the minimum size specified
+    /// via const generics.
+    #[inline]
+    pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Result<*mut Self> {
+        if size < SIZE || base.align_offset(4) != 0 || !size.is_multiple_of(4) {
+            return Err(EINVAL);
+        }
+
+        Ok(Self::ptr_from_raw_parts_mut(base, size))
+    }
+}
+
+impl<const SIZE: usize> KnownSize for Region<SIZE> {
+    const MIN_SIZE: usize = SIZE;
+    const MIN_ALIGN: Alignment = Alignment::new::<4>();
+
+    #[inline(always)]
+    fn size(p: *const Self) -> usize {
+        (p as *const [u8]).len()
+    }
+}
+
 /// Raw representation of an MMIO region.
 ///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
@@ -85,7 +140,6 @@ pub fn maxsize(&self) -> usize {
 ///     ffi::c_void,
 ///     io::{
 ///         Io,
-///         IoKnownSize,
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr,
@@ -241,12 +295,25 @@ fn offset(self) -> usize {
 /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
 /// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
 pub trait Io {
+    /// Type of this I/O region. For untyped regions, [`Region`] can be used.
+    type Target: ?Sized + KnownSize;
+
     /// Returns the base address of this mapping.
     fn addr(&self) -> usize;
 
     /// Returns the maximum size of this mapping.
     fn maxsize(&self) -> usize;
 
+    /// Returns the absolute I/O address for a given `offset`,
+    /// performing compile-time bound checks.
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
+    fn io_addr_assert<U>(&self, offset: usize) -> usize {
+        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE));
+
+        self.addr() + offset
+    }
+
     /// Returns the absolute I/O address for a given `offset`,
     /// performing runtime bound checks.
     #[inline]
@@ -336,7 +403,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(&self, offset: usize) -> u8
     where
-        Self: IoKnownSize + IoCapable<u8>,
+        Self: IoCapable<u8>,
     {
         self.read(offset)
     }
@@ -345,7 +412,7 @@ fn read8(&self, offset: usize) -> u8
     #[inline(always)]
     fn read16(&self, offset: usize) -> u16
     where
-        Self: IoKnownSize + IoCapable<u16>,
+        Self: IoCapable<u16>,
     {
         self.read(offset)
     }
@@ -354,7 +421,7 @@ fn read16(&self, offset: usize) -> u16
     #[inline(always)]
     fn read32(&self, offset: usize) -> u32
     where
-        Self: IoKnownSize + IoCapable<u32>,
+        Self: IoCapable<u32>,
     {
         self.read(offset)
     }
@@ -363,7 +430,7 @@ fn read32(&self, offset: usize) -> u32
     #[inline(always)]
     fn read64(&self, offset: usize) -> u64
     where
-        Self: IoKnownSize + IoCapable<u64>,
+        Self: IoCapable<u64>,
     {
         self.read(offset)
     }
@@ -372,7 +439,7 @@ fn read64(&self, offset: usize) -> u64
     #[inline(always)]
     fn write8(&self, value: u8, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u8>,
+        Self: IoCapable<u8>,
     {
         self.write(offset, value)
     }
@@ -381,7 +448,7 @@ fn write8(&self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(&self, value: u16, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u16>,
+        Self: IoCapable<u16>,
     {
         self.write(offset, value)
     }
@@ -390,7 +457,7 @@ fn write16(&self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(&self, value: u32, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u32>,
+        Self: IoCapable<u32>,
     {
         self.write(offset, value)
     }
@@ -399,7 +466,7 @@ fn write32(&self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(&self, value: u64, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u64>,
+        Self: IoCapable<u64>,
     {
         self.write(offset, value)
     }
@@ -582,7 +649,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     fn read<T, L>(&self, location: L) -> T
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
 
@@ -614,7 +681,7 @@ fn read<T, L>(&self, location: L) -> T
     fn write<T, L>(&self, location: L, value: T)
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
         let io_value = value.into();
@@ -658,7 +725,7 @@ fn write_reg<T, L, V>(&self, value: V)
     where
         L: IoLoc<T>,
         V: LocatedRegister<Location = L, Value = T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -690,7 +757,7 @@ fn write_reg<T, L, V>(&self, value: V)
     fn update<T, L, F>(&self, location: L, f: F)
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType> + Sized,
+        Self: IoCapable<L::IoType> + Sized,
         F: FnOnce(T) -> T,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -704,28 +771,6 @@ fn update<T, L, F>(&self, location: L, f: F)
     }
 }
 
-/// Trait for types with a known size at compile time.
-///
-/// This trait is implemented by I/O backends that have a compile-time known size,
-/// enabling the use of infallible I/O accessors with compile-time bounds checking.
-///
-/// Types implementing this trait can use the infallible methods in [`Io`] trait
-/// (e.g., `read8`, `write32`), which require `Self: IoKnownSize` bound.
-pub trait IoKnownSize: Io {
-    /// Minimum usable size of this region.
-    const MIN_SIZE: usize;
-
-    /// Returns the absolute I/O address for a given `offset`,
-    /// performing compile-time bound checks.
-    // Always inline to optimize out error path of `build_assert`.
-    #[inline(always)]
-    fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
-
-        self.addr() + offset
-    }
-}
-
 /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
@@ -758,6 +803,8 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 );
 
 impl<const SIZE: usize> Io for Mmio<SIZE> {
+    type Target = Region<SIZE>;
+
     /// Returns the base address of this mapping.
     #[inline]
     fn addr(&self) -> usize {
@@ -771,10 +818,6 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
-    const MIN_SIZE: usize = SIZE;
-}
-
 impl<const SIZE: usize> Mmio<SIZE> {
     /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
     ///
@@ -798,6 +841,8 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
 pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
 
 impl<const SIZE: usize> Io for RelaxedMmio<SIZE> {
+    type Target = Region<SIZE>;
+
     #[inline]
     fn addr(&self) -> usize {
         self.0.addr()
@@ -809,10 +854,6 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<const SIZE: usize> IoKnownSize for RelaxedMmio<SIZE> {
-    const MIN_SIZE: usize = SIZE;
-}
-
 impl<const SIZE: usize> Mmio<SIZE> {
     /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
     ///
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9512af7156df..68f4d9a3425d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -16,6 +16,9 @@
 // Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
 // the unstable features in use.
 //
+// Stable since Rust 1.87.0.
+#![feature(unsigned_is_multiple_of)]
+//
 // Stable since Rust 1.89.0.
 #![feature(generic_arg_infer)]
 //
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..c6d6bd8f251d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -43,7 +43,6 @@
 pub use self::io::{
     Bar,
     ConfigSpace,
-    ConfigSpaceKind,
     ConfigSpaceSize,
     Extended,
     Normal, //
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 0461e01aaa20..b4996aa059d8 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -10,11 +10,12 @@
     io::{
         Io,
         IoCapable,
-        IoKnownSize,
         Mmio,
-        MmioRaw, //
+        MmioRaw,
+        Region, //
     },
-    prelude::*, //
+    prelude::*,
+    ptr::KnownSize, //
 };
 use core::{
     marker::PhantomData,
@@ -46,28 +47,21 @@ pub const fn into_raw(self) -> usize {
     }
 }
 
-/// Marker type for normal (256-byte) PCI configuration space.
-pub struct Normal;
+/// Alias for normal (256-byte) PCI configuration space.
+pub type Normal = Region<256>;
 
-/// Marker type for extended (4096-byte) PCIe configuration space.
-pub struct Extended;
+/// Alias for extended (4096-byte) PCIe configuration space.
+pub type Extended = Region<4096>;
 
 /// Trait for PCI configuration space size markers.
 ///
 /// This trait is implemented by [`Normal`] and [`Extended`] to provide
 /// compile-time knowledge of the configuration space size.
-pub trait ConfigSpaceKind {
-    /// The size of this configuration space in bytes.
-    const SIZE: usize;
-}
+pub trait ConfigSpaceKind: KnownSize {}
 
-impl ConfigSpaceKind for Normal {
-    const SIZE: usize = 256;
-}
+impl ConfigSpaceKind for Normal {}
 
-impl ConfigSpaceKind for Extended {
-    const SIZE: usize = 4096;
-}
+impl ConfigSpaceKind for Extended {}
 
 /// The PCI configuration space of a device.
 ///
@@ -77,7 +71,7 @@ impl ConfigSpaceKind for Extended {
 /// The generic parameter `S` indicates the maximum size of the configuration space.
 /// Use [`Normal`] for 256-byte legacy configuration space or [`Extended`] for
 /// 4096-byte PCIe extended configuration space (default).
-pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
+pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind = Extended> {
     pub(crate) pdev: &'a Device<device::Bound>,
     _marker: PhantomData<S>,
 }
@@ -85,7 +79,7 @@ pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, S: ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
+        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
             unsafe fn io_read(&self, address: usize) -> $ty {
                 let mut val: $ty = 0;
 
@@ -118,7 +112,9 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
+impl<'a, S: ?Sized + ConfigSpaceKind> Io for ConfigSpace<'a, S> {
+    type Target = S;
+
     /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
     fn addr(&self) -> usize {
@@ -132,10 +128,6 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
-    const MIN_SIZE: usize = S::SIZE;
-}
-
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// I/O backend assumes that the device is little-endian and will automatically
diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 3f3e529e9f58..82acb531b17b 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -235,11 +235,20 @@ fn align_up(self, alignment: Alignment) -> Option<Self> {
 ///
 /// This is a generalization of [`size_of`] that works for dynamically sized types.
 pub trait KnownSize {
+    /// Minimum size of this type known at compile-time.
+    const MIN_SIZE: usize;
+
+    /// Minimum alignment of this type known at compile-time.
+    const MIN_ALIGN: Alignment;
+
     /// Get the size of an object of this type in bytes, with the metadata of the given pointer.
     fn size(p: *const Self) -> usize;
 }
 
 impl<T> KnownSize for T {
+    const MIN_SIZE: usize = size_of::<T>();
+    const MIN_ALIGN: Alignment = Alignment::of::<T>();
+
     #[inline(always)]
     fn size(_: *const Self) -> usize {
         size_of::<T>()
@@ -247,6 +256,9 @@ fn size(_: *const Self) -> usize {
 }
 
 impl<T> KnownSize for [T] {
+    const MIN_SIZE: usize = 0;
+    const MIN_ALIGN: Alignment = Alignment::of::<T>();
+
     #[inline(always)]
     fn size(p: *const Self) -> usize {
         p.len() * size_of::<T>()

-- 
2.54.0


