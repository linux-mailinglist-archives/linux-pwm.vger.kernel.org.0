Return-Path: <linux-pwm+bounces-9412-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oB2+MqGRPmq6IAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9412-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:50:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9316CE20B
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:50:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=oeX581q6;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9412-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9412-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAD8030DDAAE
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B463F9F48;
	Fri, 26 Jun 2026 14:45:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022126.outbound.protection.outlook.com [52.101.96.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3573FB043;
	Fri, 26 Jun 2026 14:45:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485145; cv=fail; b=g8f+oeayt8zISClcmyg8lWXRVRhFYtSyxzbiqCmCOLzAf/A6mRB0GurqYm/LgCUerWoMvDb6CtNKRbSckpyJWoFZu0g/0gPTZcSN98pEjEwBAvscypt5vBjXs5yt5wuyrERT5N0IRBCzPP4lgqUrBmOR9iUN+jNfMLl9A2WsDUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485145; c=relaxed/simple;
	bh=LOyGxhLng0tj4Y3qGUkWVravL0ywPNNKQ6wesWpBkmg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gYW6t8hCipiahQfT9MMguZB/zV4mA1IvRjGowoUa2JxkTT6WRU8LRTB0hzTjKa9WlOjy9j66awVCcvjKqa7Il3q/rw3y5DSMM4AzmqXz/QdJOVSWh/0oKmyVGDjYCF1c+mdCtfC2N4rcsZDRvC7sFld6YZSfPbg2hw3oL1ctkLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oeX581q6; arc=fail smtp.client-ip=52.101.96.126
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r03bDkkZQvoXmy8j0/K7my223y8B5xPC4bz4oG8bVPAQGY9ZnTrC1n51vDWP3gHo92i11cgrpmbKYqIYOqcF8V4fcGW+OTfhJV3XfroRSoOLKJipG8AFeRBaXE9+CFN0/sE+erXgvPj5v8nVerQUcFfqL+TMIe3aaaeHW4MboX3ncJpAdhMEWVeUpflXBU2QCN3I+md5BezmVE3vVbNEMvUAsqFYB4VX35qN3ziUx0PT7YiCikQ5wiiVOWd+Fs9GS07q7XTJU98u99F6pPg9pyiCaUgynY/loNCbjPqgoNmw3Z92BuziLqln90MpKe8HTBHrB/F82DIYSWLzDKFV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZE4CnpeKmr0v1GlhGmzTjNpu+GmkJzjFLR2h4I7rJs=;
 b=CJOPOa6omwQwSxPlr67dxL3uskfRk6pm7HGMRC1KFv6S6A9FcOfW6sYDSWGDV2gZJeuURv8XZ5rsMoLDT0UEY9ZPpjHdFd/o8fEienOwtz3pLs1CHiI55yBodfIE/wMDC4dq6CdPoZXfKNYw9C1U3HYJIM9bJA9FnDmWRXhDw9Zdnyni3xJ4Ydqg9CravVe+HxSZpcXHqKGvM0cSslCm3BCy271IdBJygg4E7KBHvXgF4QXAVBYJnyMvujUbomW/YMV/p5aVqqlksHW+pY+HAYbfgl5qug8FRC9dmKlEAdhy3r85wdeVDVkPAX/1lAoXprWVtHnQCcf/wa9vX5jlCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZE4CnpeKmr0v1GlhGmzTjNpu+GmkJzjFLR2h4I7rJs=;
 b=oeX581q69jlruRKa0CUT5fnji/0Gj/Fg0NyL2haVDeKmpcuP703a5F28/IIMgG8TDeKDOZKlTiCqFCUfqAN3L4XKsLDLER/8WVqDYz9A7wxGJwKl54wb6N5FdXs4ESfaO8c/iVK9ERk3Fwz5RnSDnsvo01SB2zsgJmEpa2fZafw=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2694.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:22 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:22 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:15 +0100
Subject: [PATCH v5 11/20] rust: io: remove `MmioOwned`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-11-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=8853;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=LOyGxhLng0tj4Y3qGUkWVravL0ywPNNKQ6wesWpBkmg=;
 b=1EDz5uMw7WQVVIq2lFY6Qk8tDF6hJ0enoLL6Y723IRq5Oig/hyfmU6E7XIL0ICvmZBQkfyfnw
 E48afDbT9R5AuBVAY/LJtv/f8fCipo42CUr/x17axMiGl17nh7ehReK
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
X-MS-Office365-Filtering-Correlation-Id: a9fa84d7-231c-48e9-a220-08ded3918d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|921020|18002099003|5023799004|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	vtdKrmYAdzoEXjoiNltq+Wzac5hdNteBeGbnMCO+tuzuZD6JDprYMq8WIBRAQDCTHHfNiZJNAH13GdOSOId9zDDvmwklA761lhTZCQZxTvp6jL8xaLQLrH1a8IbGKi6msV/VxhhoaPExeoUvDPwsV6XqqNqWpneDhxmHR1JXTAReQRKQ3/lo6CVe616B59tHC11DuqUaqaMCiEM4vJ72E1FL21NEDaqxvZEB859KdyIlTR+p+Fs4aRuM+WJf+6rpl3Ew0OIEDeenP8dGykjs90f2zwoaTlYulJVuQM3Fg4CiJYdTpRfxnwgArlaQOJw/7f3em0SWhu8kEi+k8GLp6YkdiNO80oiAqBXG+B+pY53Zt2bOjimYViHe6+78LTFRqVwb4VTQQYztfk05kjsQhz2gN17TnUiRRMuG0h1AGEbZKBZvuau85Wt4WUGwxmVqOvKOrxnon/6SvnKK5dF95mCLc/jiwdpst0cKTGcmIfbXU2oRkdAwKcEtIOaWuFHLIGcpb5E+mzUaYFJoz3skIdWOl667VDCKD7XP7eyguSJcZaLIrd1JNLSw62SoehY0Dlb4Kam89b/Enh0v6Hy/KjIkAM3FTRNGfFe7eJ1pEv850JeAId5wdBzn9kkPP3RARY8hLIh7vGIsnnThhxNZHkM5WaQw1mOriWvLpGDsZ8Yrt7yh/sKLHZ5mZv3+e3Y2k/5GWujchTa+VpQkNbBxew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(921020)(18002099003)(5023799004)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVJHOVNvVjlXWVBzYkg5Rnp5c1FMd2sybm9OZS9Xd2JBSXc5anRaVGhkNmo2?=
 =?utf-8?B?aWlmakxETzZiWmdYd0lucEJySlpxTXdtREQzbG5URHVOSTVkWHB6aTFrSFpW?=
 =?utf-8?B?MXFjWFhnMG1aaEpPbXI2RnRkNnJwaWwyVm14RmlGTG9rZGZ2ZU82NGNOeUdH?=
 =?utf-8?B?b3p3ZHl3MkdaVXFvYVVnVVlyYWJvMHFHUkIwckYwbUxBa1FITlBNTjhYdDBj?=
 =?utf-8?B?SWs0WU1raW5LbTg1VlhLZFRWcFFBRzVlSHNzYVNrYm1yTlNoQWIrOWFMNXpO?=
 =?utf-8?B?SjAvWFJlK242djJnVTdoUHpQak9yTHdaRjdDaWczZE1CVDBrQkxHMmlOck4v?=
 =?utf-8?B?UkZxK3JCVVVrNUVhanE4UFNMazUvWitlNEdsWVNBcC9xUU1IWng4OUJOS1NL?=
 =?utf-8?B?UE1jdzFSWk9oeFY2TXJVVmloY2UzSjFEM2JETGN1b0d1ZlhERzcxSFZId3hS?=
 =?utf-8?B?MWpwVjN0YmxJcVVFdkxWS0hpV2QwbHdrOHk4Y2U2a2l6cERVa2pIcWxjcm5i?=
 =?utf-8?B?MTR2ZGJYZ0dUajh2ZEJZQW9ycEgwajROd1kwdzNXakl5RGY4TjBiRndkQVUx?=
 =?utf-8?B?UHVnV2M0aUlndWRxanBUOHowM05YdGR6UmFPR0pMSWpwZnM3enZyT0w5dnQr?=
 =?utf-8?B?cUpGMURtMzBmQlNzSmZEZytsZUFJNC83bTk5YlJjdEtqekNNMExGK054QTRN?=
 =?utf-8?B?Um9FbnlpVis1Z21nTFVEMkJadjV6VzRqSzdUMXZlRmVrUk80WXJkNDdjblZW?=
 =?utf-8?B?TzZBYXNOOHRNSXN4UGRScE44bDBVeldFdjczSnVIVWFZdVcvR0s5Q1hDM0R1?=
 =?utf-8?B?OEJoZVZ1bXpVdTNVejk0WVlTcC9kWmNLRUtZWGwySVNQNDBuN2xoVnJGaVZ4?=
 =?utf-8?B?N1NwczJVdWJrU1h4QU9Ld3FJOU5qaGt0c2hMc3JEZG5lZWlXMG12UDd5aEtS?=
 =?utf-8?B?NE9LeklyWThlSmdBL2dYSG91N2N3bDBDSG15WnBYRnpkdm1lUllVYTlOZWhI?=
 =?utf-8?B?VjZCemNJRTJBL0hYNGJFTUlSdFRnVzIzZWNKZHNaU3ZURlV0b1JtZHFwMVl6?=
 =?utf-8?B?VjEvVGpxZDEwL1R4cEpBdkpoRjdac1hGdjQ3WTNtVWlBbXVxYUFZVXZoM3JI?=
 =?utf-8?B?T0I4ZnNpaHRxRnQzSndGTzZnTmNqWGZLNTRVMk1aMEFDTUZJK1RGM2JsWE0v?=
 =?utf-8?B?Sy9SMzZoUTNIODI0UE1uRngzWExNSGVYSklxY0xyQlRTdi9YMmR1VUhsVGJV?=
 =?utf-8?B?cGJEbEd0cGdtQ0ROL1dScURsYkw1MjhVcExXby8yZmhnR1ZmKzltL2V0RDVD?=
 =?utf-8?B?bGI1dzgzZ2JZUGdKTUI0eVFBZzZ1U1lZemRWNWJxR05XdDNkT24rc3k2NE4z?=
 =?utf-8?B?anE4OUMzazhlbHExQjI2bWtCdmtKVUExblV3VGxsd3A1K2ZCa0R1bUE2bi85?=
 =?utf-8?B?Y1VydndHd09xWmFNT3hPWHRJdjVYMm9hYWV1ZjVZL25JamhXQVhyeHFET1Ar?=
 =?utf-8?B?RThLc0JBRGk2U2JBMGFtNGJIMFI0OXRWN3R3QjFQVDVCZUdIR3lhUnlIb1Vi?=
 =?utf-8?B?a2k2aE9Sd1I0YlM1STNIM1ZGa3JNdXRNWHBWK1F2RGRDaHU0d1BKVkFDb1Bv?=
 =?utf-8?B?MjRLQWs2Zmk2dGh0LzBRY21RNnVjcHkyK0FUUUtQYmNYZ29aQitVOXFxNlp5?=
 =?utf-8?B?cXUyb1RDOFR6TTVrb0VpWUl5RVYrVWQ3WE80cmhOcHRwL0t0VmdmTW1wL25l?=
 =?utf-8?B?TFlldXZRbklMSnVNeWQ1a1dZMVp2VThGa3RzYzYwT0x4WStsWHA3TmxUMmx6?=
 =?utf-8?B?cDZCR09DWnRyb1U5V2d4a2toeG9mTEptKzBpc3gydW1samc3aHpvcE51d0l2?=
 =?utf-8?B?clAvK3ZwRGNuOFk2ajVyOElQdzcwWTUxSnRXeGd1a1hSVldJQWgvMzlpMXR2?=
 =?utf-8?B?KzVOcTl0TkIrZndTOU42d0xJSUhEMEs1VmxyNjkyNElWbkFwZmxKak5NQThY?=
 =?utf-8?B?TFZTUzlCQ1BmQnlmZm9BUGoraTY1NkFsQVVuV0E4NllSc21HV0dKODQxa2hy?=
 =?utf-8?B?QnoweFJPSDNML1BQclo0ZVFyU2p4NVNneTJjSXJOcjBua1FmenpiOTh1ZkZT?=
 =?utf-8?B?bEt5dDVxbTY3UjlHSE1FTUcxcWp2aTNzY0hydzhyNXkxTHBRNm9hS1pvbTRt?=
 =?utf-8?B?QU9OUUp6WEk0UlhvdHc2Q1VPZVo1c1lLOWtDTnRLNFJYZ2JCQ1hyczM4WVA1?=
 =?utf-8?B?VXNxY2lMTWdSSDJ5ZnRvb2xUaU1lQkNzb0dzL01YZGFIS1RxZ1UzSkk0bndP?=
 =?utf-8?B?K2Nja0dLbU5TeXhxOUJ6YjlaTloyNDdNVjZZSVJPbDRWRHVkYVRYdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fa84d7-231c-48e9-a220-08ded3918d37
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:22.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: od4kWknbbYF9p43ZGgTvglS8Mgds6lZTiasaZfVBQB9+OMfi3p3c2EUrkvVqWb3QZ0c5KcPQD1RcHQ5pkcWu7w==
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9412-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,self.io:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E9316CE20B

`Io` trait is now very easy to implement. Thus, implement it on `Bar` and
`IoMem` directly and remove the `MmioOwned` struct.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |  12 +++---
 rust/kernel/io.rs     | 103 +-------------------------------------------------
 rust/kernel/io/mem.rs |  26 +++++++------
 rust/kernel/pci/io.rs |  16 ++++----
 4 files changed, 32 insertions(+), 125 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index aed0c994fd30..3545ffc5345d 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,8 +68,9 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
-///         MmioOwned,
+///         Mmio,
 ///         MmioRaw,
+///         MmioBackend,
 ///         PhysAddr,
 ///         Region, //
 ///     },
@@ -104,12 +105,13 @@ struct Inner<T> {
 ///     }
 /// }
 ///
-/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = MmioOwned<SIZE>;
+/// impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<SIZE> {
+///    type Backend = MmioBackend;
+///    type Target = Region<SIZE>;
 ///
-///    fn deref(&self) -> &Self::Target {
+///    fn as_view(self) -> Mmio<'a, Region<SIZE>> {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { MmioOwned::from_raw(&self.0) }
+///         unsafe { Mmio::from_raw(self.0) }
 ///    }
 /// }
 /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 67b8c62f3771..adafd273920f 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -98,8 +98,8 @@ fn size(p: *const Self) -> usize {
 /// the represented MMIO region does exist or is properly mapped.
 ///
 /// Instead, the bus specific MMIO implementation must convert this raw representation into an
-/// `MmioOwned` instance providing the actual memory accessors. Only by the conversion into an
-/// `MmioOwned` structure any guarantees are given.
+/// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
+/// structure any guarantees are given.
 pub struct MmioRaw<T: ?Sized> {
     /// Pointer is in I/O address space.
     ///
@@ -156,80 +156,6 @@ pub fn size(&self) -> usize {
     }
 }
 
-/// IO-mapped memory region.
-///
-/// The creator (usually a subsystem / bus such as PCI) is responsible for creating the
-/// mapping, performing an additional region request etc.
-///
-/// # Invariant
-///
-/// `addr` is the start and `maxsize` the length of valid I/O mapped memory region of size
-/// `maxsize`.
-///
-/// # Examples
-///
-/// ```no_run
-/// use kernel::{
-///     bindings,
-///     ffi::c_void,
-///     io::{
-///         Io,
-///         MmioOwned,
-///         MmioRaw,
-///         PhysAddr,
-///         Region,
-///     },
-/// };
-/// use core::ops::Deref;
-///
-/// // See also `pci::Bar` for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
-///
-/// impl<const SIZE: usize> IoMem<SIZE> {
-///     /// # Safety
-///     ///
-///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that is mappable into the CPUs
-///     /// virtual address space.
-///     unsafe fn new(paddr: usize) -> Result<Self>{
-///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
-///         // valid for `ioremap`.
-///         let addr = unsafe { bindings::ioremap(paddr as PhysAddr, SIZE) };
-///         if addr.is_null() {
-///             return Err(ENOMEM);
-///         }
-///
-///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
-///     }
-/// }
-///
-/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
-///     fn drop(&mut self) {
-///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
-///     }
-/// }
-///
-/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = MmioOwned<SIZE>;
-///
-///    fn deref(&self) -> &Self::Target {
-///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { MmioOwned::from_raw(&self.0) }
-///    }
-/// }
-///
-///# fn no_run() -> Result<(), Error> {
-/// // SAFETY: Invalid usage for example purposes.
-/// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
-/// iomem.write32(0x42, 0x0);
-/// assert!(iomem.try_write32(0x42, 0x0).is_ok());
-/// assert!(iomem.try_write32(0x42, 0x4).is_err());
-/// # Ok(())
-/// # }
-/// ```
-#[repr(transparent)]
-pub struct MmioOwned<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
-
 /// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
 ///
@@ -957,31 +883,6 @@ fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, value: $ty) {
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(MmioBackend, u64, readq, writeq);
 
-impl<'a, const SIZE: usize> Io<'a> for &'a MmioOwned<SIZE> {
-    type Backend = MmioBackend;
-    type Target = Region<SIZE>;
-
-    #[inline]
-    fn as_view(self) -> Mmio<'a, Self::Target> {
-        // SAFETY: `Mmio` has same invariant as `MmioOwned`
-        unsafe { Mmio::from_raw(self.0) }
-    }
-}
-
-impl<const SIZE: usize> MmioOwned<SIZE> {
-    /// Converts an `MmioRaw` into an `MmioOwned` instance, providing the accessors to the MMIO
-    /// mapping.
-    ///
-    /// # Safety
-    ///
-    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
-    /// `maxsize`.
-    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
-        // SAFETY: `MmioOwned` is a transparent wrapper around `MmioRaw`.
-        unsafe { &*core::ptr::from_ref(raw).cast() }
-    }
-}
-
 /// [`Mmio`] but using relaxed accessors.
 ///
 /// This type provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 8f6c257c5b8e..d9b3189d09b4 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -2,8 +2,6 @@
 
 //! Generic memory-mapped IO.
 
-use core::ops::Deref;
-
 use crate::{
     device::{
         Bound,
@@ -16,7 +14,9 @@
             Region,
             Resource, //
         },
-        MmioOwned,
+        Io,
+        Mmio,
+        MmioBackend,
         MmioRaw, //
     },
     prelude::*,
@@ -210,11 +210,13 @@ pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
     }
 }
 
-impl<const SIZE: usize> Deref for ExclusiveIoMem<'_, SIZE> {
-    type Target = MmioOwned<SIZE>;
+impl<'a, const SIZE: usize> Io<'a> for &'a ExclusiveIoMem<'_, SIZE> {
+    type Backend = MmioBackend;
+    type Target = super::Region<SIZE>;
 
-    fn deref(&self) -> &Self::Target {
-        &self.iomem
+    #[inline]
+    fn as_view(self) -> Mmio<'a, Self::Target> {
+        self.iomem.as_view()
     }
 }
 
@@ -290,11 +292,13 @@ fn drop(&mut self) {
     }
 }
 
-impl<const SIZE: usize> Deref for IoMem<'_, SIZE> {
-    type Target = MmioOwned<SIZE>;
+impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<'_, SIZE> {
+    type Backend = MmioBackend;
+    type Target = super::Region<SIZE>;
 
-    fn deref(&self) -> &Self::Target {
+    #[inline]
+    fn as_view(self) -> Mmio<'a, Self::Target> {
         // SAFETY: Safe as by the invariant of `IoMem`.
-        unsafe { MmioOwned::from_raw(&self.io) }
+        unsafe { Mmio::from_raw(self.io) }
     }
 }
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index e67c1e3694fb..4be33ecb4192 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -11,16 +11,14 @@
         Io,
         IoBackend,
         IoCapable,
-        MmioOwned,
+        Mmio,
+        MmioBackend,
         MmioRaw,
         Region, //
     },
     prelude::*,
     ptr::KnownSize, //
 };
-use core::{
-    ops::Deref, //
-};
 
 /// Represents the size of a PCI configuration space.
 ///
@@ -269,12 +267,14 @@ fn drop(&mut self) {
     }
 }
 
-impl<const SIZE: usize> Deref for Bar<'_, SIZE> {
-    type Target = MmioOwned<SIZE>;
+impl<'a, const SIZE: usize> Io<'a> for &'a Bar<'_, SIZE> {
+    type Backend = MmioBackend;
+    type Target = crate::io::Region<SIZE>;
 
-    fn deref(&self) -> &Self::Target {
+    #[inline]
+    fn as_view(self) -> Mmio<'a, Self::Target> {
         // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
-        unsafe { MmioOwned::from_raw(&self.io) }
+        unsafe { Mmio::from_raw(self.io) }
     }
 }
 

-- 
2.54.0


