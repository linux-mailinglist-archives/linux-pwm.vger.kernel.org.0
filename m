Return-Path: <linux-pwm+bounces-9591-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uQJUGSm5S2rmZAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9591-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 16:18:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A640D711DA4
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 16:18:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=bJikDlio;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9591-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9591-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D819334A064A
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205434302FB;
	Mon,  6 Jul 2026 12:44:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022076.outbound.protection.outlook.com [52.101.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38FF42E8F2;
	Mon,  6 Jul 2026 12:44:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341875; cv=fail; b=FrFl9gktr0KlMxToRFAYz/DgL5R71RqxePPTJFVSskSySgf6/fFpJeuSahNxILLs2c2Zhew962ZzVbqHiZ6hiHr5bqp8bDeBAv3ySuO6rwl5SoARvO8WgPARLpPlWAwZZfc9kcG2GE03ZfpwIvfCVuSZmwZQg6lhvQGyI4urwXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341875; c=relaxed/simple;
	bh=IjuHOk447qUxa66qt1SAe8P0bpbDHum38emAb4AXhxo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=W6m2pJ/xAeHoID2UV7+h9RYYpeuGI4YhgluMOnqPs5uzIKk22h1RuNAAOelDKVzPTO6+LEsc/h1fAPaonaAtVoNEFwPjWinYLu5wGexRHyF8fLZea+oN1zDvTfpf2BSMgH0rxpMbBEsSAiMwEE3M+UkFPJ7Qj6ErSJNHnFxQxk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=bJikDlio; arc=fail smtp.client-ip=52.101.96.76
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hjer5La4R+BBd5R67rm/Xvws97fBV6neVmm5qRxJABBXT7h+d99sRQPHx83MnViWHv2HJZZQ+g6cL9RJdleeJF+zuTWSlzOUaPKdLLdDVzN78Oo8vflWgRSTLn3XRpepGGodkZGfiaRLYsjOyYjNI+ERu4erSSzsp7r9Cb60bved45JRkeyreLW4bX+jhTnILxI6ldv4O203lfliUSfCT4ahptUXhcMeLKEnIsM0ZOEU1dtN0LWn7rLdCyc4PsZvP7VWz9VbYD8LrwtQX80ngAOBDXZ8R4h9d99o9TZ9iWSqkTE04d3DpMvxhzPICzG9XDRx4NcAwQQUnYPIxws//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbQp2obf8M8yWKvJM6cBo2dlStnGsrRCRMLwjrMySc8=;
 b=FgjqdNnar0lFqOV36DtEwTA+ZWxiPYix8PzVxyg4HwbGq+qlRi4dziAoCliQYwlmYGUD5bNWEKjYsTUOO3GJI4ePan5E/mFBou5QEQWZYvBmyvVzOdmfTBHSm3VySE2BKZeS5vWFMA3H4vVJqVu3aEMu8/l/+hvu50Wadmuf7rxMjsB2ByvEW6IhHqCPeXcd+eGPJ3+33Sd4IYWdAbUHhjjyE7gUyW5UMdmoIFYk8AWPvb+OIKOVx6xf4qf85U6r6VNSaI+CUFLii603Uhp07NnxdlfWBR2bpIK4iw2bLpMiKO+VcgMyPMmMbMtBKFgO2Sd9geJhGy/wbcWffiqIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbQp2obf8M8yWKvJM6cBo2dlStnGsrRCRMLwjrMySc8=;
 b=bJikDlioqEGZ4IaQOJALI32jz7S1vu3HEnYZ3AabH9Fs4odxUyPrWC5ax3uQNbXjwF+S+ibsBWfGBgr+u7dKeY4kWrEixMvO+wPdBuumnL/ERoz5slJjQo5aEFela/PQbIjnrwEK9OVwHJtNvwVW019GmDcEqG7Otlu32q3tRP4=
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
Date: Mon, 06 Jul 2026 13:44:16 +0100
Subject: [PATCH v6 03/20] rust: io: restrict untyped IO access and
 `register!` to `Region`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-3-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=13409;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=IjuHOk447qUxa66qt1SAe8P0bpbDHum38emAb4AXhxo=;
 b=kXIqblDaukSrKM4vnHpvltlpYt6oYse68BcZ43A5q+uglJHwy8S0a3BxJS1UY/vn3RProEr4J
 psqZDq6KX6VAesdBuEvoJcpAR+nbeIbCh0IBGP6sw6/deBz0v6BnFdU
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
X-MS-Office365-Filtering-Correlation-Id: 7b1e6578-622f-40c3-9eec-08dedb5c5000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|5023799004|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	P/2h6Ey0fN8M3A05eBt8rfIY/lefA5GKJRmSECo/8lPLsJiDElhtjGYTjA1rSyfxECCBzOkYFWT3PGT61elE7NtqWO7Av68VN3rY5JDz+nzkU9+zPuAqj26rZMnrIBAU3B4H8nqcK2os6+PYFL+Y/KG9UxYIueyitackZ81SEZYFBn5rFrQXREXZC3cYxjDOxyrCAxxYFUw52XGtpxKgMn+FIM2JEToh6xroxVFsDt9W6XruX1GgmGBC5WPissm9cVIsJ/USjhfx2rmKBG/3OUR00xCxyb1PA0ESexbv/eFV5ofwQHinW6mSJxMwqLH7f+XfIqvMjtcuH9OCoAPn7StC0ah7E+H+jjQVt2/Gx+nWUPrMkYnfyDQx8HI7xB6apsszb47sx4bfKVW9YX9zGwDpBnJkrhFFCCECgmPgBLex2t2LWPqBTQJfeoiNkoYTBe1zZBHXp3Ww1/FMOlj+HiVzVkP91dM0oncKGE/8NvsdZgQV0Enj97BEvMpTx7xPHSqUVxDzgtxOtELVgT2G9AQRYBswaXvNgQu2WkU1DsOoAIR7XcxsxtwUx4czuhpvkwN06kLGUW+2KEZmYRFcBBszympVGfOGihGSaIxNbUmpN4Xskbze8RPxIGVLRCjBznArHkVUxLRwbtA3QEL27jFQzUYLW+7GTK0VX+IWHCZHNvNIci0b63ThSFgPqhrNrQ/Bd7Te9icCi0nfSe5puA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(5023799004)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1FKUkdKTHlEaFl3RnpXSElBcTdKbWN2RFdzQWtwL2ozQVpaOCtia1RNWGR5?=
 =?utf-8?B?aTJDUVh4eXBTd1ZlQzdWcnZsWk9uUkRwREg3WjRGVUh3NzlxMjFhZnJmaUxk?=
 =?utf-8?B?T1lFTkhSeGl4cWFJb2VRWjJhMUEwbDlqcGZhMUJUTnhrZG9XYW9LYThaT0Jh?=
 =?utf-8?B?a2ZGK0VSZ3dxMHdEVjIzdWhxanBoUlZYMWRWejc2bWpRTTg1dFU3R2pjTGJu?=
 =?utf-8?B?UHg3T2gvTDU5a1piSkM2eWcyUjNBaC9oeW5FcUhpTC9Gb0JwWG9YR1BSZlNz?=
 =?utf-8?B?YUt5eGYwRWxyb1RIZU5kcjhROGlZNDhqaFBaT3NPS0plbjNZNFRNUjFtcnAr?=
 =?utf-8?B?Z25PV2tWY3o0S3VPRlVSYlB2aUtZQ2M0ZFppcmtGY2M3UW1IbkZ3UXhBQ255?=
 =?utf-8?B?UEFaQWg4LzUraTRJUlpJSFJkNGhsN0NNS2RHRzlyUW1PK29DVFV1V05ZbXlH?=
 =?utf-8?B?YXBzZXl1VDZFZE10SDdaaUxXampKZ0dXa25PeEw2REFBODRnSi9veXN1WE12?=
 =?utf-8?B?OUNYU2hQMHErQWlXb2Z5eWNScjkzR2k5bGlPTEM0RWxjaFNoTlJ3azZFOEhm?=
 =?utf-8?B?SzhhT0dQMzVqc2c0Vzgzajcwb28yV09LNStFVzdTNGFnZUVUeVl3OE5veEZT?=
 =?utf-8?B?TngyTFZqNmcwOFZheVFUeVdXdkVRN09Edk5jK08yRjlmMFI3UjBCeEFubXE5?=
 =?utf-8?B?ZjZ2WUVRNTk5RlE3cjFhYUEwTG9IMDdNczNlVGZvK085MlNCejJUNWc4NGhy?=
 =?utf-8?B?UlFNT0dpZ0dDdzV6K05UYW9wRURVYkJPV1Vsb1UvSVJEUDg0TnNjNEhCU1lr?=
 =?utf-8?B?MUhJYmMyMmoxcEtzOVErTkJZd044TjNsSTZJL0NxYzhnNnpsUEdFdnE4T3RO?=
 =?utf-8?B?aUhFWlZxWFFOK0hQZ2RsRkNNakxLMVl1KzV3YWJYOG5qSmJhWnJyVTJXNDJ1?=
 =?utf-8?B?TFAwbExnU1NsWXdidGxJdjcwTElMQ2Q3ZGQ1QnluUThBWVI5MTJ5WXNRb2p5?=
 =?utf-8?B?cGFIOCs1dFVSWTAzOEhSWWFITHpwWE4wUzdyWDdoNFdKR2RZRG15UFlkUWJl?=
 =?utf-8?B?RHJHWCszZTJ1SjRyUlpyYVRZRHJvcCs5NmVFOEdOSmpHNzd5T3BuV3RrY0RG?=
 =?utf-8?B?M2ZjUE1pUW9HK3g2UExnOHJSNnY5Vml6N3AybllRUlZ4dzZ3UHl0RjZFMzA4?=
 =?utf-8?B?dUdVNHcyc3c4UXZTR2V0ZllLcFhJTnVscDB5MVBlY21SMEVVSHJHSHZZRFFQ?=
 =?utf-8?B?QUxpK1gxc3lpTEtVbTZCOGtzeTNFbWFhYVZEZVE0ZjRPcEl5TVY3SGxZRHdx?=
 =?utf-8?B?L3NnSUt6ZUNPOFJla1RXWmY5cXFoYnpoMUx3a0p0bU1EdnZTMWk2dkJ2dWVv?=
 =?utf-8?B?YndkMjl0QWhNWThDc05WelZMc1MyWlVWVEV6UjlKU2NJYWJmejFKdllnUTNq?=
 =?utf-8?B?VmtJR3k5STNwYzVrVUw4K29mWUlVNndOSlU4alJvSlAyU2VFRWwxY28xQkJT?=
 =?utf-8?B?RW84NnM3TEJHdFd4RjUwdEJhaWhpQTE5NFgvclNpQkxlTC90dVJyL0lWd1VT?=
 =?utf-8?B?Q3M0OEtuNGc4YUlvdFltTC9hY2cxQSt0Q3lmekRRN3hhNDB3azRMdmpjWTRR?=
 =?utf-8?B?WVlFZ2R3Yi9VbE90MzZYeEVvMjNNbTQyYzVVN2FZeHVJcEVCNGtPTnFkS1dL?=
 =?utf-8?B?WXpSREp4TStnWkpNUXB1VDBwR1NtWlVGQmg0S1JCRjl6U3puc3BXUStOV0Vi?=
 =?utf-8?B?TlN6V3R6VzFNaVN1am5WaU1QRHg3RFFLQTBua2xpRzJQUC9yVko1YXNDVENz?=
 =?utf-8?B?TmFYRVJtdXYxUHhBc1ZqckFXYWVCSVdvNVp3NW1kWElTVU01M1RBR1ZvbHZX?=
 =?utf-8?B?V3FJMUVvazlMcXFwcTMreDY3cFZOWlFHc1VOdkZBeGMrWEViK2J3S1ZaS25h?=
 =?utf-8?B?VWlrZ0dyQTZDU1pOaEhITENOQUwrS21VNjl0dEsvMjMzNERCOVRZSnF0VXUz?=
 =?utf-8?B?WHREZDh2RTB5RW9XK3ZFY0xyUEJQdFc0WlFzQ203ZlNxTFMrRVE0VXZ5czVs?=
 =?utf-8?B?cVRzWjVVcFQ4UnRxQmxGa2JWOVlPdGwwUEZXSGVic0RvdEdQMVJrZm1ZTnFq?=
 =?utf-8?B?RFhDZkJkT1lDQjV4UHhQRExrNC9kUXA1ZGViQU1qVXZRZGFWaUlSdy9kaFZJ?=
 =?utf-8?B?c2xNenN5b0lGZjF0MTkrdUtkc1puMUFRU1lNeHB6WDZxNHB2VWduWnhoY1R1?=
 =?utf-8?B?bmtscHBNQUR0Zzk1eUYrNmxiVEI4dTRPeG0vN3E4NGpCdmd5aTFlZWxlblRU?=
 =?utf-8?B?VWIvbDhURmplaUd6djdtdEg5NmtNcEVKTVY5amNtbVZQU1F5MGtnUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1e6578-622f-40c3-9eec-08dedb5c5000
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:25.9922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Vp2dqi3F/l/RdVPvHDWzNrL0pWQ1EPVB+hf3zeMJFHmvBmnSpOzz4AxyDdsKowJ4o/SdycgloHLnt+mxka+lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
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
	TAGGED_FROM(0.00)[bounces-9591-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A640D711DA4

Currently the `Io` trait exposes a bunch of untyped IO accesses, but if the
`Io` region itself is typed, then it might be weird to have

    let io: Mmio<u32> = /* ... */;
    io.read8(1);

while not unsound, it is surely strange. Thus, restrict the untyped methods
and also the register macro to `Region` type only.

Implement it by adding a generic type to `IoLoc` indicating allowed base
types. This also paves the way to add typed register blocks in the future;
for example, we could use this mechanism to block driver A's `register!()`
generated macro from being used on driver B's MMIO. The same mechanism
could be used for relative IO registers. These are future opportunities,
and for now restrict everything to require `IoLoc<Region<SIZE>, _>`.

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Link: https://lore.kernel.org/rust-for-linux/DHLB3RO3OSF5.2R7F27U99BKLN@nvidia.com/
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs          | 49 +++++++++++++++++++++++++++++++---------------
 rust/kernel/io/register.rs | 20 ++++++++++---------
 2 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d821ee48ed31..87141eb07056 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -243,15 +243,16 @@ pub trait IoCapable<T> {
 /// (for primitive types like [`u32`]) and typed ones (like those generated by the [`register!`]
 /// macro).
 ///
-/// An `IoLoc<T>` carries three pieces of information:
+/// An `IoLoc<Base, T>` carries the following pieces of information:
 ///
+/// - The valid `Base` to operate on. For most registers, this should be [`Region`].
 /// - The offset to access (returned by [`IoLoc::offset`]),
 /// - The width of the access (determined by [`IoLoc::IoType`]),
 /// - The type `T` in which the raw data is returned or provided.
 ///
 /// `T` and `IoLoc::IoType` may differ: for instance, a typed register has `T` = the register type
 /// with its bitfields, and `IoType` = its backing primitive (e.g. `u32`).
-pub trait IoLoc<T> {
+pub trait IoLoc<Base: ?Sized, T> {
     /// Size ([`u8`], [`u16`], etc) of the I/O performed on the returned [`offset`](IoLoc::offset).
     type IoType: Into<T> + From<T>;
 
@@ -259,12 +260,12 @@ pub trait IoLoc<T> {
     fn offset(self) -> usize;
 }
 
-/// Implements [`IoLoc<$ty>`] for [`usize`], allowing [`usize`] to be used as a parameter of
-/// [`Io::read`] and [`Io::write`].
+/// Implements [`IoLoc<Region<SIZE>, $ty>`] for [`usize`], allowing [`usize`] to be used as a
+/// parameter of [`Io::read`] and [`Io::write`].
 macro_rules! impl_usize_ioloc {
     ($($ty:ty),*) => {
         $(
-            impl IoLoc<$ty> for usize {
+            impl<const SIZE: usize> IoLoc<Region<SIZE>, $ty> for usize {
                 type IoType = $ty;
 
                 #[inline(always)]
@@ -338,6 +339,7 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
     #[inline(always)]
     fn try_read8(&self, offset: usize) -> Result<u8>
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.try_read(offset)
@@ -347,6 +349,7 @@ fn try_read8(&self, offset: usize) -> Result<u8>
     #[inline(always)]
     fn try_read16(&self, offset: usize) -> Result<u16>
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.try_read(offset)
@@ -356,6 +359,7 @@ fn try_read16(&self, offset: usize) -> Result<u16>
     #[inline(always)]
     fn try_read32(&self, offset: usize) -> Result<u32>
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.try_read(offset)
@@ -365,6 +369,7 @@ fn try_read32(&self, offset: usize) -> Result<u32>
     #[inline(always)]
     fn try_read64(&self, offset: usize) -> Result<u64>
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.try_read(offset)
@@ -374,6 +379,7 @@ fn try_read64(&self, offset: usize) -> Result<u64>
     #[inline(always)]
     fn try_write8(&self, value: u8, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.try_write(offset, value)
@@ -383,6 +389,7 @@ fn try_write8(&self, value: u8, offset: usize) -> Result
     #[inline(always)]
     fn try_write16(&self, value: u16, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.try_write(offset, value)
@@ -392,6 +399,7 @@ fn try_write16(&self, value: u16, offset: usize) -> Result
     #[inline(always)]
     fn try_write32(&self, value: u32, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.try_write(offset, value)
@@ -401,6 +409,7 @@ fn try_write32(&self, value: u32, offset: usize) -> Result
     #[inline(always)]
     fn try_write64(&self, value: u64, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.try_write(offset, value)
@@ -410,6 +419,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(&self, offset: usize) -> u8
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.read(offset)
@@ -419,6 +429,7 @@ fn read8(&self, offset: usize) -> u8
     #[inline(always)]
     fn read16(&self, offset: usize) -> u16
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.read(offset)
@@ -428,6 +439,7 @@ fn read16(&self, offset: usize) -> u16
     #[inline(always)]
     fn read32(&self, offset: usize) -> u32
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.read(offset)
@@ -437,6 +449,7 @@ fn read32(&self, offset: usize) -> u32
     #[inline(always)]
     fn read64(&self, offset: usize) -> u64
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.read(offset)
@@ -446,6 +459,7 @@ fn read64(&self, offset: usize) -> u64
     #[inline(always)]
     fn write8(&self, value: u8, offset: usize)
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.write(offset, value)
@@ -455,6 +469,7 @@ fn write8(&self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(&self, value: u16, offset: usize)
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.write(offset, value)
@@ -464,6 +479,7 @@ fn write16(&self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(&self, value: u32, offset: usize)
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.write(offset, value)
@@ -473,6 +489,7 @@ fn write32(&self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(&self, value: u64, offset: usize)
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.write(offset, value)
@@ -503,7 +520,7 @@ fn write64(&self, value: u64, offset: usize)
     #[inline(always)]
     fn try_read<T, L>(&self, location: L) -> Result<T>
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr::<L::IoType>(location.offset())?;
@@ -537,7 +554,7 @@ fn try_read<T, L>(&self, location: L) -> Result<T>
     #[inline(always)]
     fn try_write<T, L>(&self, location: L, value: T) -> Result
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr::<L::IoType>(location.offset())?;
@@ -583,8 +600,8 @@ fn try_write<T, L>(&self, location: L, value: T) -> Result
     #[inline(always)]
     fn try_write_reg<T, L, V>(&self, value: V) -> Result
     where
-        L: IoLoc<T>,
-        V: LocatedRegister<Location = L, Value = T>,
+        L: IoLoc<Self::Target, T>,
+        V: LocatedRegister<Self::Target, Location = L, Value = T>,
         Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
@@ -616,7 +633,7 @@ fn try_write_reg<T, L, V>(&self, value: V) -> Result
     #[inline(always)]
     fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
@@ -655,7 +672,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     #[inline(always)]
     fn read<T, L>(&self, location: L) -> T
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -687,7 +704,7 @@ fn read<T, L>(&self, location: L) -> T
     #[inline(always)]
     fn write<T, L>(&self, location: L, value: T)
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -730,8 +747,8 @@ fn write<T, L>(&self, location: L, value: T)
     #[inline(always)]
     fn write_reg<T, L, V>(&self, value: V)
     where
-        L: IoLoc<T>,
-        V: LocatedRegister<Location = L, Value = T>,
+        L: IoLoc<Self::Target, T>,
+        V: LocatedRegister<Self::Target, Location = L, Value = T>,
         Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
@@ -763,8 +780,8 @@ fn write_reg<T, L, V>(&self, value: V)
     #[inline(always)]
     fn update<T, L, F>(&self, location: L, f: F)
     where
-        L: IoLoc<T>,
-        Self: IoCapable<L::IoType> + Sized,
+        L: IoLoc<Self::Target, T>,
+        Self: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 66449377a0b7..1159e5168ef9 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -113,6 +113,8 @@
     io::IoLoc, //
 };
 
+use super::Region;
+
 /// Trait implemented by all registers.
 pub trait Register: Sized {
     /// Backing primitive type of the register.
@@ -129,7 +131,7 @@ pub trait FixedRegister: Register {}
 
 /// Allows `()` to be used as the `location` parameter of [`Io::write`](super::Io::write) when
 /// passing a [`FixedRegister`] value.
-impl<T> IoLoc<T> for ()
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for ()
 where
     T: FixedRegister,
 {
@@ -143,7 +145,7 @@ fn offset(self) -> usize {
 
 /// A [`FixedRegister`] carries its location in its type. Thus `FixedRegister` values can be used
 /// as an [`IoLoc`].
-impl<T> IoLoc<T> for T
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for T
 where
     T: FixedRegister,
 {
@@ -168,7 +170,7 @@ pub const fn new() -> Self {
     }
 }
 
-impl<T> IoLoc<T> for FixedRegisterLoc<T>
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for FixedRegisterLoc<T>
 where
     T: FixedRegister,
 {
@@ -239,7 +241,7 @@ const fn offset(self) -> usize {
     }
 }
 
-impl<T, B> IoLoc<T> for RelativeRegisterLoc<T, B>
+impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterLoc<T, B>
 where
     T: RelativeRegister,
     B: RegisterBase<T::BaseFamily> + ?Sized,
@@ -283,7 +285,7 @@ pub fn try_new(idx: usize) -> Option<Self> {
     }
 }
 
-impl<T> IoLoc<T> for RegisterArrayLoc<T>
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for RegisterArrayLoc<T>
 where
     T: RegisterArray,
 {
@@ -370,7 +372,7 @@ pub fn try_at(self, idx: usize) -> Option<RelativeRegisterArrayLoc<T, B>> {
     }
 }
 
-impl<T, B> IoLoc<T> for RelativeRegisterArrayLoc<T, B>
+impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterArrayLoc<T, B>
 where
     T: RelativeRegisterArray,
     B: RegisterBase<T::BaseFamily> + ?Sized,
@@ -387,18 +389,18 @@ fn offset(self) -> usize {
 /// which to write it.
 ///
 /// Implementors can be used with [`Io::write_reg`](super::Io::write_reg).
-pub trait LocatedRegister {
+pub trait LocatedRegister<Base: ?Sized> {
     /// Register value to write.
     type Value: Register;
     /// Full location information at which to write the value.
-    type Location: IoLoc<Self::Value>;
+    type Location: IoLoc<Base, Self::Value>;
 
     /// Consumes `self` and returns a `(location, value)` tuple describing a valid I/O write
     /// operation.
     fn into_io_op(self) -> (Self::Location, Self::Value);
 }
 
-impl<T> LocatedRegister for T
+impl<const SIZE: usize, T> LocatedRegister<Region<SIZE>> for T
 where
     T: FixedRegister,
 {

-- 
2.54.0


