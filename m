Return-Path: <linux-pwm+bounces-9421-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jb7SE92SPmoiIQkAu9opvQ
	(envelope-from <linux-pwm+bounces-9421-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:55:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AF66CE2F3
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:55:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b="Io86/pTj";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9421-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9421-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B643F3124B80
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A594014A0;
	Fri, 26 Jun 2026 14:46:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022126.outbound.protection.outlook.com [52.101.96.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1C3FE652;
	Fri, 26 Jun 2026 14:45:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485160; cv=fail; b=VycpTXJ6xjYVgFuxfXiGzVdFPgP9RrbOqSnNLtVrHnmhSzdueSvPz6/8hVMqY0KIG8QCTCor3yfELGvhEwJonqHBGYDzxHOtM6FABffCF+BS6poG5Fn6BTtrzG1nkAFb5oAhYZHdX+Ike+AOXrd3cuR79sE44Q7miuClHK5vWok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485160; c=relaxed/simple;
	bh=jwpOL+8onvWtIguzV59vIP2zyg5diaxn32RlHDnn1Gg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IkwCf+7a/I23iYVsAhYz9IJL2x4gNSEDkwiaS6RC1kuXNbIMt95RVjz44mWnNmfc8KINMA+/K1XtiQRCXm3NO3k7EX1bP1UB6kskrEQqq43zPL0Z53YE9hxaNslXqfu8Szw1x/DIvkf4C7W3+U6vnANcnJ402CUUY+vOg6HXa7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Io86/pTj; arc=fail smtp.client-ip=52.101.96.126
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mE9RIt0cLWSrshrsb1xDisUN6yyQsWUEQJzoYb9+c6rvgVu0QceYNur5i2wnWFH3xdxca1vx1GFQztsYJIKvUAyyApnBN8Bxb/5qKFBVCI4/u7MNcnObeyVx1NDWCxVEVmEgPjs+TqCP7KVlyTDtip7FbNQCxfw5/7UWMAadTQc2hHy0V335+mREfkgJkuBG3KJsm1NB+LnJai9FU49PtjuyAhuhlAIoxcFBgij8tL7Zg2fB0RriDeCBe8e+4a4kgtGXJf/89Q2Hsn/Sx+fQyAVXnZyN4YZnjxxQriBIBKnmpYgf50Ktda0kD4lxtxLAk3fWYDr/LXeM+4SQoqTRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCVwIbTNS4Ld6i4HIC/5quYTYSjv320ziVokMa2TFXw=;
 b=r5TTEo5wQjGYpqQOOob4hD80Ug2m6hsqJNiCb3EAqceZwktU+M+m/BUEVyvcXE2m/DDUyR4dbmCpf5pdgnpvWoRthC0JHmTIW9MJaLM2D9WIjqs1XvlW5oPOVcMLiJo9Mf2TvXxevLh02K/4jN42i2zjdjft84QjsEO//dc4D1gHtOZZ7mita0T39P1J9RVhkwfrqDW3IlbN/2gmWhjWSlzHx+mPQtTiudky4rB2wSD9DzDB5+I+m/559WqG1CKE5icFUwnRxaEetwsmFQUDnqSp5HSt9/N7d6YV1dEhwKnFLJM2NgU1TDbwOIFpW/BkizVDqzL5gSVd54FXOKFwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCVwIbTNS4Ld6i4HIC/5quYTYSjv320ziVokMa2TFXw=;
 b=Io86/pTj5rWF1lg/P48LXKaZvNnJ3cOJorkhfKNwan6lnlElQEvZIfVNvbxTM2ymi4Zo3CvWveIeePAjCIYn9s01bkXZCGaJX9rU6hW8DFwcLJw+R69j2HsnVPy/c9pbazoUw3rN+Fnuh5pfEXVlkAquIS908wZ44obxzBsvXKo=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2694.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:26 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:26 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:22 +0100
Subject: [PATCH v5 18/20] rust: dma: drop `dma_read!` and `dma_write!` API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-18-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=8864;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=jwpOL+8onvWtIguzV59vIP2zyg5diaxn32RlHDnn1Gg=;
 b=TNYnSkEzDZ7tS7m790JwqEFLPWxmH2o8DQX6yZP4k0gQKAYdQ2Jwv+GcUPBP2MfEDrMp5zT3o
 l7fNqK2njSoArOZJoTsVANcRRMErxTRBbdu3Ag2ht6MvuWGavXvMHvE
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
X-MS-Office365-Filtering-Correlation-Id: 75d90eb6-77ec-4c3b-c13e-08ded3918f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|921020|3023799007|18002099003|5023799004|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	TdbxkQkDE1gsqHuzUeQUhKihoW1DOVQ7bOIfc2yHdZDGjoHKmmOGVairJPqvzs3tYa7lcR3Ex/aBSUKkHmPBTDHpRbdhsQcFIE59ggUheFwtbQd9wvpX16O5hXhBJzDIp0tU/O0kIsDiGB7C9E0ej95JuwlLQvXBLcFIPS8j5BWhj2v7JYDfrEZLt3YrfqgOPaF0rhGrpnAUX2b/oT/gMX9flb/nYvfZTcSmGcPrY+SQzu7lrPRFIaZevHxem2wE9X8cXmfBmMEmxxqjIxDVwWnpCOdVHAbMZ+LDMJYF0HFuJoXL0bUZDueElItMRNtSqOAOO1+nlaZck1QZl8ZJSIhmJhjKxzDaKlp788lksRxsTq6gg8tDBkBZbd4c+VU0gJMUoFyJ7BHU1v/f9rJOjPpVdu73F+AH9nTACwzHFCj6BN+V3cIFK21vS/6ZqfYNdtpLWR38mxa/uR8ZtEa3R4DU/bVniKyWmyrOog2TPFLjBAolPe5J6OrtAazj/CJIhOdFZ9hV7J2G8ekWjayQUjgmJATpRgEwvsbrSlw7kMAsqP7JQtZdKOOCD7W+shOrdtzHcfSNPIDpmbr7IIMWSSTfLnvM315VSZMmuVik4jGC4+YoayoZTmV1GODm5/dK6i/vDCZ1TWoJs+C44NE4QGZeC4ngVC24XEuKWd/txdT5ZGXUgI3sO711LzZiW/M8A25ctCrkWvGBZkUWC/JlkQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(921020)(3023799007)(18002099003)(5023799004)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUVlc0dMY0dQWE40SFhtZTArcVpxWnlpTCtkNE90Yzh3T2lxV0p4OU8rWS8r?=
 =?utf-8?B?YnZzY29IbXVRYWVibW9LMTVyaFFrZ3dsRG9TZ1U0RE9rT0dVYU5OV0xta1kv?=
 =?utf-8?B?aTZPdFpIaWdpTTdLeWRTMGxZOXNObVNpd0RKZVhjOTdoVDBhbzJwMUEzeVRt?=
 =?utf-8?B?a2FXYTdaeFNiaWFwYWw0MXV3MjdhL1ZrV0NPOHBac2NiTk5pYUVSK3VBR2ND?=
 =?utf-8?B?RU1wenkvb1pXc29SdUpaRFpvSGxaamRCVytEdzhBeTk2VG9UblZXbTBCUlVq?=
 =?utf-8?B?MEhHZVRMakNlU25WeFNlcVYvWXQ5RkFuNlpaS003WG9zeDkxMHVpbHJHU0pr?=
 =?utf-8?B?NXlmSy8yNUFTSlRpSzY2WlExMlF0NlV6aTFVRzB3RDZLY3F5bDNFdThqckhy?=
 =?utf-8?B?eDRadjVPZHR3NFZwcnIyMytNakk3aGtENUYxUUZ3N3pYK1NyeGtBWjd6eWV2?=
 =?utf-8?B?Z1g2NWVuWEFzTTRsbHkrOGJKRlJNZHdBdmtIaSsrYjVTMzFYeFNTU0Fxclp5?=
 =?utf-8?B?L1RPcTVoNmdZdGZtdDdRaTM0aGU5STNBWDVUQmF6d2t1THlYNi9VRndxYlMw?=
 =?utf-8?B?RnpBejFCeVNNMm5UaWtvc29DWlc4VXNjV3BLeHFLNG40RDZYSEhqejB1UlEr?=
 =?utf-8?B?WEdDaTJEblFndFlhMWFlMktZeHovenFOcGkyL3ZDcGtXNEFhc2VubHdiV0dx?=
 =?utf-8?B?MGw2ZG0rYkwwV2RKbUVUaWRSd1RydnhPZ0tET1dYUUhFdzJpdXBuUEJMb3E5?=
 =?utf-8?B?NkpONG5RK09neFZrZmtxTW00RWsrTkpIemJrR2FBbHV3U0VZMHRZOXl2bDhF?=
 =?utf-8?B?QVBELy9EVDFTK080NkE3c1NyalNkSkI4R3h0T05YVzgwZmVjZUN1WHRkSUFo?=
 =?utf-8?B?QlRRcnN5S3lpQTYvMFpUUDhYaytFem83WjdiVjFuRVkvTm5FK25MUHdQbFNW?=
 =?utf-8?B?ZGg1YzEzcEovRmJRVXB1WmE4OUpvRFpKbXlaQnlVRDFDUDZZMlRXRG5DQnVv?=
 =?utf-8?B?cVVMUFFUTVA1S3EzMlhXcjNtOE1iRTViL1lsZXlVbzJaODZkekZtSzBocVdL?=
 =?utf-8?B?U1lTb1NMS3RjN3lDOXdZMFhqSmdnOHlKblFsU2hwU1JtUDlPUjVFS0JEYmFj?=
 =?utf-8?B?cjFjd0h4cG1pdWZubHNlT29jaHZrbWNPSWs4MUU2ZWlsR1V2SkplS0tlRDhv?=
 =?utf-8?B?ZG5RZWJvTkZQTzRKMzU4cDAwUmFmMFpucU5IN1lCODJDKzVOVHd0MG9IdHFq?=
 =?utf-8?B?Y2l2enlsQkpCZ1J0TGE3VEhGZDJ2TnpmeWtlekwybWM2dStTMHZmZWRPMzRw?=
 =?utf-8?B?T25GTmk5aTNWVlV2alNLN21iOEZMRldXeTFYZFYzSnBkWmw2SFEwQW5EdVJu?=
 =?utf-8?B?NTRmelRvNVBFMmwyMW90WnFOR0NiTUhJTzF2aEY0eFU4SnNmWUhnbmlCVU42?=
 =?utf-8?B?S1JsM2x2dkdnY2lIMHlmazJOa2dhY0psTTc0NEtYcFN3bk53anpCRS9RQi9u?=
 =?utf-8?B?UmlTMWJ4dTF2QUZ2dXZRc25LR3RGc2dDblh3TytlSTNXdmU3N3dSNHhTaDZx?=
 =?utf-8?B?cjVSUGpjYW0zM2xWczg4MGo3dVc4aHBFRDlReWUrQVpjUGJsQ1NXZnVQVjYy?=
 =?utf-8?B?WktaT282VjU2MU5oR3FqbVBIWXZFZ1FTT2I1bG5zeFkxZXBZR1Myb0g2WlB3?=
 =?utf-8?B?c2pKRXlTckU2Vk5jUm5VRTAvaTJlS2JqWjFsUXU4RndZM3BEdTVZZUNneUtL?=
 =?utf-8?B?RzJJbk1VTzJxdW9leEJtVkxOSDRPTXB6QmFYQkY0dnlnMEJnUjB4cHJZOFRH?=
 =?utf-8?B?N2R4U1hMTUZ1Z093aWlBNXA1ZWgrZDdpTlQvVlZrZDVCV3pwSytyTERVWWs1?=
 =?utf-8?B?VHIwN0FkL0xLY0JDOTkvSkRYRnQzcmprQ2hmd1gvM0RvKys1d050OVJSY0dN?=
 =?utf-8?B?L3J1UkttYkVicm80Q1JSdm5LRE1Xd1VPclNrTnFrdXpJaHQwTzJmZ0VZZmZG?=
 =?utf-8?B?MlE2MGR0SWM0ZmN6eFFBNkNKWWptazFveXdyQUJoRnZPbThUSk1OQlpvTFVT?=
 =?utf-8?B?Mkp3UHpSTHVrQ2lRZG9yRjZvOWw2Q09SVHdZZERaME42dmRGSG16THc4azVh?=
 =?utf-8?B?MUgwQjFkRlNDcXA4Wi9zWXR0MTc1VWdoMjJmMC9jbkJkWUNZTUl0emF1MFFq?=
 =?utf-8?B?TGk0V2pRNkE0VTZIaURBZU1uRUI3ME5nL1RDUEhGWkdGRFl3Z2ZlZFEzYWdG?=
 =?utf-8?B?S2o4MjM1d0JSS3JlOE44aGVUUkdmUVdjTnd6SnUwekpzeG1RdzZIcjhHRnVi?=
 =?utf-8?B?OWZ1bWdNb3doNlZOa2xQbmRwK0wweTdIZ2s2YkQxMklWbUd1THlzZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d90eb6-77ec-4c3b-c13e-08ded3918f4d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:26.1801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTNLIHZlUpeOmoJDHIju/k7i1xGEm9aWPVX0Q5QABgVSVu+O8UO+Q58XMv696FjOZggWJPjm42cYlm1/EE3hmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2694
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9421-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6AF66CE2F3

The primitive read/write use case is covered by the `io_read!` and
`io_write!` macro. The non-primitive use case was finicky; they should
either be achieved using `CoherentBox` or `as_ref()/as_mut()` to assert the
lack of concurrent access, or should be using memcpy-like APIs to express
the non-atomic and tearable nature.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs       | 128 -----------------------------------------------
 samples/rust/rust_dma.rs |  13 ++---
 2 files changed, 7 insertions(+), 134 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index ab6504910e4f..0ff4cce8e809 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -661,52 +661,6 @@ pub unsafe fn as_mut(&self) -> &mut T {
         // SAFETY: per safety requirement.
         unsafe { &mut *self.as_mut_ptr() }
     }
-
-    /// Reads the value of `field` and ensures that its type is [`FromBytes`].
-    ///
-    /// # Safety
-    ///
-    /// This must be called from the [`dma_read`] macro which ensures that the `field` pointer is
-    /// validated beforehand.
-    ///
-    /// Public but hidden since it should only be used from [`dma_read`] macro.
-    #[doc(hidden)]
-    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
-        // SAFETY:
-        // - By the safety requirements field is valid.
-        // - Using read_volatile() here is not sound as per the usual rules, the usage here is
-        // a special exception with the following notes in place. When dealing with a potential
-        // race from a hardware or code outside kernel (e.g. user-space program), we need that
-        // read on a valid memory is not UB. Currently read_volatile() is used for this, and the
-        // rationale behind is that it should generate the same code as READ_ONCE() which the
-        // kernel already relies on to avoid UB on data races. Note that the usage of
-        // read_volatile() is limited to this particular case, it cannot be used to prevent
-        // the UB caused by racing between two kernel functions nor do they provide atomicity.
-        unsafe { field.read_volatile() }
-    }
-
-    /// Writes a value to `field` and ensures that its type is [`AsBytes`].
-    ///
-    /// # Safety
-    ///
-    /// This must be called from the [`dma_write`] macro which ensures that the `field` pointer is
-    /// validated beforehand.
-    ///
-    /// Public but hidden since it should only be used from [`dma_write`] macro.
-    #[doc(hidden)]
-    pub unsafe fn field_write<F: AsBytes>(&self, field: *mut F, val: F) {
-        // SAFETY:
-        // - By the safety requirements field is valid.
-        // - Using write_volatile() here is not sound as per the usual rules, the usage here is
-        // a special exception with the following notes in place. When dealing with a potential
-        // race from a hardware or code outside kernel (e.g. user-space program), we need that
-        // write on a valid memory is not UB. Currently write_volatile() is used for this, and the
-        // rationale behind is that it should generate the same code as WRITE_ONCE() which the
-        // kernel already relies on to avoid UB on data races. Note that the usage of
-        // write_volatile() is limited to this particular case, it cannot be used to prevent
-        // the UB caused by racing between two kernel functions nor do they provide atomicity.
-        unsafe { field.write_volatile(val) }
-    }
 }
 
 impl<T: AsBytes + FromBytes> Coherent<T> {
@@ -1265,85 +1219,3 @@ fn as_view(self) -> CoherentView<'a, Self::Target> {
         }
     }
 }
-
-/// Reads a field of an item from an allocated region of structs.
-///
-/// The syntax is of the form `kernel::dma_read!(dma, proj)` where `dma` is an expression evaluating
-/// to a [`Coherent`] and `proj` is a [projection specification](kernel::ptr::project!).
-///
-/// # Examples
-///
-/// ```
-/// use kernel::device::Device;
-/// use kernel::dma::{attrs::*, Coherent};
-///
-/// struct MyStruct { field: u32, }
-///
-/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
-/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
-/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
-/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
-///
-/// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
-/// let whole = kernel::dma_read!(alloc, [try: 2]);
-/// let field = kernel::dma_read!(alloc, [panic: 1].field);
-/// # Ok::<(), Error>(()) }
-/// ```
-#[macro_export]
-macro_rules! dma_read {
-    ($dma:expr, $($proj:tt)*) => {{
-        let dma = &$dma;
-        let ptr = $crate::ptr::project!(
-            $crate::dma::Coherent::as_ptr(dma), $($proj)*
-        );
-        // SAFETY: The pointer created by the projection is within the DMA region.
-        unsafe { $crate::dma::Coherent::field_read(dma, ptr) }
-    }};
-}
-
-/// Writes to a field of an item from an allocated region of structs.
-///
-/// The syntax is of the form `kernel::dma_write!(dma, proj, val)` where `dma` is an expression
-/// evaluating to a [`Coherent`], `proj` is a
-/// [projection specification](kernel::ptr::project!), and `val` is the value to be written to the
-/// projected location.
-///
-/// # Examples
-///
-/// ```
-/// use kernel::device::Device;
-/// use kernel::dma::{attrs::*, Coherent};
-///
-/// struct MyStruct { member: u32, }
-///
-/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
-/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
-/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
-/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
-///
-/// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
-/// kernel::dma_write!(alloc, [try: 2].member, 0xf);
-/// kernel::dma_write!(alloc, [panic: 1], MyStruct { member: 0xf });
-/// # Ok::<(), Error>(()) }
-/// ```
-#[macro_export]
-macro_rules! dma_write {
-    (@parse [$dma:expr] [$($proj:tt)*] [, $val:expr]) => {{
-        let dma = &$dma;
-        let ptr = $crate::ptr::project!(
-            mut $crate::dma::Coherent::as_mut_ptr(dma), $($proj)*
-        );
-        let val = $val;
-        // SAFETY: The pointer created by the projection is within the DMA region.
-        unsafe { $crate::dma::Coherent::field_write(dma, ptr, val) }
-    }};
-    (@parse [$dma:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) => {
-        $crate::dma_write!(@parse [$dma] [$($proj)* .$field] [$($rest)*])
-    };
-    (@parse [$dma:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
-        $crate::dma_write!(@parse [$dma] [$($proj)* [$flavor: $index]] [$($rest)*])
-    };
-    ($dma:expr, $($rest:tt)*) => {
-        $crate::dma_write!(@parse [$dma] [] [$($rest)*])
-    };
-}
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 5046b4628d0e..6727c441658a 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -12,6 +12,7 @@
         Device,
         DmaMask, //
     },
+    io::io_read,
     page, pci,
     prelude::*,
     scatterlist::{Owned, SGTable},
@@ -73,11 +74,11 @@ fn probe<'bound>(
             // SAFETY: There are no concurrent calls to DMA allocation and mapping primitives.
             unsafe { pdev.dma_set_mask_and_coherent(mask)? };
 
-            let ca: Coherent<[MyStruct]> =
-                Coherent::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
+            let mut ca: CoherentBox<[MyStruct]> =
+                CoherentBox::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                kernel::dma_write!(ca, [try: i], MyStruct::new(value.0, value.1));
+                ca.init_at(i, MyStruct::new(value.0, value.1))?;
             }
 
             let size = 4 * page::PAGE_SIZE;
@@ -87,7 +88,7 @@ fn probe<'bound>(
 
             Ok(try_pin_init!(Self {
                 pdev: pdev.into(),
-                ca,
+                ca: ca.into(),
                 sgt <- sgt,
             }))
         })
@@ -97,8 +98,8 @@ fn probe<'bound>(
 impl DmaSampleDriver {
     fn check_dma(&self) {
         for (i, value) in TEST_VALUES.into_iter().enumerate() {
-            let val0 = kernel::dma_read!(self.ca, [panic: i].h);
-            let val1 = kernel::dma_read!(self.ca, [panic: i].b);
+            let val0 = io_read!(self.ca, [panic: i].h);
+            let val1 = io_read!(self.ca, [panic: i].b);
 
             assert_eq!(val0, value.0);
             assert_eq!(val1, value.1);

-- 
2.54.0


