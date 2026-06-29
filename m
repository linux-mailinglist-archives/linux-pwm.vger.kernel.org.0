Return-Path: <linux-pwm+bounces-9467-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pYz3EkxuQmoB7AkAu9opvQ
	(envelope-from <linux-pwm+bounces-9467-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:08:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B071D6DAC96
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:08:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b="yyz/PU4l";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9467-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9467-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2A9B30C3C6F
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF9A4071E4;
	Mon, 29 Jun 2026 12:39:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020122.outbound.protection.outlook.com [52.101.196.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA336390209;
	Mon, 29 Jun 2026 12:39:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736791; cv=fail; b=QVfY/4dAem1RLKsaqTBEuglCE6Rc2D0hQqBopwe0+azPgAsg15eBVxLJ156aLhvv93C3driHDjBt36aAEAvLvi/mPuvA0Ynee5Z5SygVi4IXZH/Y7+BW5ldBNU+PmvXO4+DQ9aapiWHbjvq7Bkkh9feyMNREOCYp1FBjOl5Lriw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736791; c=relaxed/simple;
	bh=94x1O4HxKsoPKOLm7uWBT+HZHDbp/uUOwGwZO67jScE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EgidI+4G3/n75BxhCyr4JoRD8yztIwxXvSK4XjoAVgHOxhb3xH/qYlieBLsK+BEmVq0HVWz74aiSFTHwtxEa8pzldy5suPhqPiIjA+6STSCV7/QzeSayMVIFdhpW8CamfNpmDcIBvU4IhUifBeei0hKKC3nvA8TL8HJmSUzEI9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=yyz/PU4l; arc=fail smtp.client-ip=52.101.196.122
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHFGqI2GcaKmisrjl7vGZwvqacw91XyGPBBufLhbsWkJ04UCPtTVh17BNTmKY9EiNQ+DW7l1pWpNLDT/xAeaasS4abRt/9RVQSfpwKkjKKrTIDyyX0uHGCBA3X94VSW9LKdOirr1RrtFRjoNTxkYOubl+M1+Z8MbRd3FEdGMqDcZgHQolVUS5FV+mdzKlL1kzY5/br1LKO22zjc8g3cUyJ7EYQ2fwa5ZntcFLJvWxDDpK6UP3ycJrYgi2OoteHtDmxhVSW8VupT2CtBpuFfVg6NS11WMpK9XCIKnSu6mJzHO1B53ZB3THpaqCcR39nyn5l1ncT0ctyaf3NBpCsQ+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6L0D4MRDsHLl3Ar1NZKYzJ4fW37yj3gVztpQIVKWOJk=;
 b=aqTgzsTpIs31zNyhGmBA0VP0w6KqhUpoxU0F81qYWH1/RIWmhS1MkPVoo2vGahFTG1Oc0fkuR27IN1PEVIe8Po3iuR8J/P/OcKFXGZmvieI11ODePGlJeteF1JIW3H/o7KVb/WbDLH1qcsSZNFlx3ryt2+vKNPom/vEFDVlhqPCubizATgAP8JKlxt2Er2WBvNrbg3D4regGQf+aO33AOJPJcdf1DLco1mzAIMiq+gx7rIAHvOxbg4eQ4fQBvsvm7FxltruOPexnbsRZVOBu9tVu4LMqlKLHByj7hCv5he7u/vTWD4TsXi9mTrBaBDZDPrAoGl3PznvGfMKAhrjCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6L0D4MRDsHLl3Ar1NZKYzJ4fW37yj3gVztpQIVKWOJk=;
 b=yyz/PU4lFNSN9uJgsiAF/wzHOG+BZjcG9UUuRARAAo4SV9KwFhb2XV3Nkb2x41c7SlGVR1wKaAI692kQ4s/BdOHWfZsgsAQRKAceEQh+G/JwVs88dKnkJvhMK1SJCEgaLp8f0R0KTfBBtPtmjfxy9JV4O0F3QQfhdkiEzel4EPg=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7414.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:39:43 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:39:43 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 29 Jun 2026 13:39:39 +0100
Subject: [PATCH v2 05/11] rust: net/phy: remove expansion from doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-id_info-v2-5-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
In-Reply-To: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Dave Ertman <david.m.ertman@intel.com>, 
 Ira Weiny <iweiny@kernel.org>, Leon Romanovsky <leon@kernel.org>, 
 Len Brown <lenb@kernel.org>, Igor Korotin <igor.korotin@linux.dev>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782736778; l=2400;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=94x1O4HxKsoPKOLm7uWBT+HZHDbp/uUOwGwZO67jScE=;
 b=S11xqjgnid/jjOg0ag4hMIqK/lMtiNoWM0+S0FW0vOxlsmbRX8M/qafkSluJAiSdcluGpxd/s
 gRYBU5kDHnyAmTnevxk4V21HBAJNVbzsv7FR+ylUiur+Ll12HGQZGL2
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: aab86369-19ee-47bc-0a89-08ded5db7e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|10070799003|921020|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jr63mDeULJP9A2y1iA9xjy5HPeb9JExtl6zfFjqDOUQ/VhG9qKmItOmIXRQTbAKST6rwLbAY9GMVBKKWK8wup3DilG+PX0VyIGKjCMyu+BQbM30RQqujXbbGEdJPDqVdSn6WEiDOGrmY5tqsSqAWXZwUXpCSBs0+EAba5U1VMnPBOsQ24C1K3z2l1ceTk6yeE/NC1kJO0+1puXfFU7IjHiTZe2MCBoH00msdi7Ln/cdVDPbKgk9i8iHFr5zY8Yo94DOx86hk6JseaBz9kvIRnqMYJbUTOljT55SMR8yoj/sfphSPyjWSuGOP4E2Co+DMVYOfFGmcyBwisjVq1tgx+neiNydt088P1Kn/1wkloycDYTaRFqWfe/zEXIFYCnJKcIRvqiF/4mJNKiNB53OcjP45XHm4+fZwz3AiAGk4CB323LCD1MAqV3ndGNrX0Feh5x89YN33mBl8yBOTY/oI1PPofzoA2/pwfj3AXyVqqghiiZQwKuIRYqCsMNeqIBXuOBPGsRiwgy2d718QQLUoxhVn5nAZGkENSlSC0QvnbLVatxPCsyhm+ah3QGXMDHrC2P6dRzM/ZWo2YjVtXskK5kLJmdU+XlHinBLvUQmC9VbepW/q24gFwSsSkF4HoCzef93si0EyEamdyVqEcqRWlxWPBnXUSfp/OIAqh61a5UG7seZqhYBKlP8R4HP6rX1vagMz8GZFAN75trZZgdU8Tw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(10070799003)(921020)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUZEcE85NndEU2JCWmZYNmxiUG55Y2R1NUVMS1M0K0FPNng0Z2x5Q1phdTB6?=
 =?utf-8?B?c2pxOEFBRGQ4T3Rsa0duRTBseGxaRlUzSWRiaHlUdlBDb2loR25VWXNrcGs3?=
 =?utf-8?B?MG5ybVJtK1hKRG9PQlhrQzBaY1RsUDZ6QnViUkRYZWhiQU9aRXR4ODFjTjBZ?=
 =?utf-8?B?dURGSDQ4VUZZRjV2dUlQT2ZtTElEb2dyYlZBcThoTU4xZVM0cGxaTDIrYlRI?=
 =?utf-8?B?WEIxbEp0S25oOVNCNm5GWlhBY0dUazgxVmdiYU91MWVrZ3JJS2p5T1JxN0w4?=
 =?utf-8?B?Vk1ySGRJYWxIRkFaUVhkVjZVOUw2VG9ha2VaaU5kVG5YQW1qVlVKMnpZdWJi?=
 =?utf-8?B?cG1vQjNGVjN4T3BsOEpkU0pKNmNlemp5ZGpCcnhEbXdNVERQVm1WTUhjNEZL?=
 =?utf-8?B?WFdQODFxdmlKMTAvQUd4VlB5SzlveEhrQklJV3lQL1o0RXVRUEVPWGIweFZF?=
 =?utf-8?B?djlGYjlYa3daSTYxWGRiNllHUTZzYVZPa1dPTFBiSlJ1SldpSkpoVDdHUlRM?=
 =?utf-8?B?eWRsS3poamZlTEtEemR4SGlqQjJuRFpFaHEzMnp6NEYybFI1MmFjS1FiTE81?=
 =?utf-8?B?OGlZVndWRUdyNHdBS1liTG5BN1JJWGpHMmxBeUR4YUN0UklhOFVieSt4b2p2?=
 =?utf-8?B?Ulp2SjEwV0pUVFpQbWx3a0hQTDU0SExhUW9UQlJXU0lwZUE2dklOZ2xvMkFp?=
 =?utf-8?B?dmdKSnBnMHdoSE0wd0hGZjlpMjVaZWRVWjE2M2ZxOXFUSms1cjk2Qit0Y0Uw?=
 =?utf-8?B?bnRrTi9hVDlVcHZCd1pQNElyQ0JUWVNzRkJiMGR0Znl2WmN0WFl3UGFRK0pX?=
 =?utf-8?B?bnBuT09XNXZlNzh6ZmVmMmI0aTRtdFNmcXMvdjkxejRZbzVvZ1RsckNxWG5p?=
 =?utf-8?B?ekxlUnBuY0xncENyOWdzQm9MTFJsQzdQK1ltVmNvUk1rU1EwWitnOXBmMTQx?=
 =?utf-8?B?bHJPaGgrK2RxTnNzTThXS1lqMFNaMzU1Nzh2dHg0bHlBdkh5TUJERTFGaTF1?=
 =?utf-8?B?QkxhVDhJQ0IzRnJEQVk3WWkwMVFhemwvTnJua3hENlBURUI5blV3OC8xZ2JE?=
 =?utf-8?B?VjVwZDBZRDc1TDA1R2NsV2RsekRzU1VrYlYyYTNOekRvSjJHaUpITGNPVDI4?=
 =?utf-8?B?STQ5SG5tdDFlY0MzSmFSOCs0TUJTVFVJeW9XRnBjN1dBWjdGaXdqVTVRSXRI?=
 =?utf-8?B?MnZCMVN5QUhBWXJaNVl3Vkc1VnR6eTY0OTAwaFN6WG9IYTRSVTIrVm5FWnMw?=
 =?utf-8?B?ZDRtOUYyVWZGYjEyME9SWXU0TUtFUFN5ajVZZUFHZkpMc1l0QWt3Nis3dHNI?=
 =?utf-8?B?bHVuN0ptWDh1MVU5RVBrMHlvSlZ1T2Zxa0xIcUVvb2phMWVxNDA3WTN3U3Np?=
 =?utf-8?B?Z08zQ3VtTnAvRy9rUUZPWUNwQ3JJQ1F2Z3Rab0hmdEhRSmpKdkt3R2NUdVdC?=
 =?utf-8?B?dWE2dExpWUJnTDc5dllBN21QbTVPQzd3WkQveFVCQjFMbXYvdU84STdvUVdR?=
 =?utf-8?B?ZGEwYzFzdU5teU5aN2F2Rk9FWmozMXI2SS83YTJyQUtQVTNYdGdKbEVTWnBr?=
 =?utf-8?B?a0lOU1gwbmlqd1l2d2lXQ0JBdFJBZE9vZDRqanpVOEZXUEhRN3cxN3FiUnlG?=
 =?utf-8?B?cnQybm9tQUNCbWlxb3huMGdKN1MrdmNPNVVxRkEwVjlvNUtHd3YyT2VoY0Vz?=
 =?utf-8?B?Y3ZoemUrUlVUcTJlLy9ZaFp6Vjh3L29YMVErRERMQUlSWDFtWVRVWlUxaFRl?=
 =?utf-8?B?TUhNWDVtM3FsMUhHdjRCZ0lFOTR5OEJNbCtQdGIwcDdIZTR3TUcyMDBRdldI?=
 =?utf-8?B?cDdqUXBCQVBvSk9VbkpFMVNBcWxnZHRvbUJDLzhWbzgrUlNWREp0bHRaUWpP?=
 =?utf-8?B?bElHam1Ka0lSVEVVZmNKV1YxQ2l3V1A5T2IxYjFwdlplY2ZWUFdJYXVIT2RV?=
 =?utf-8?B?ZDJWNk55dWt0bE0yd21LK1F5VnFsZW5CYUE5dE9PSll1Yy9vZVV1OXhqcW1L?=
 =?utf-8?B?VHJBL0o0Z1dabktsUzdKMkxrbnBRbU5YZlBkUm9qRWdrOUNGU0tDUzBsRSsv?=
 =?utf-8?B?WHQrY1N1dEZnSUxVWkVZZkNKb2tNb0pVTVZqOU9rd0I2SzZaWmxBTXRDK1pF?=
 =?utf-8?B?Y29vL1l0eS9qc1hwMG1Nc2pvS1owUExaS1o3RW91bkx0eG5ZYnJZUzJ3eUZW?=
 =?utf-8?B?RmtmK1poRlJUbm40Q0RjbmJTZlJJQnd5dGRXQnRpbjYzcFpHVEI4OEt2VjVJ?=
 =?utf-8?B?ejBNVnpGdlZONGJwcVFEY2RVM0V4d2JBSnRmUDdBZHNEQzF1c2c1enpEbWNJ?=
 =?utf-8?B?YjlWb1h3eHc5ZzE4SFVhbWxVcTI0MjkxRFBEaHdhdUNYc0pnSzhCQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: aab86369-19ee-47bc-0a89-08ded5db7e95
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:39:43.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WEeD9ObUG3ZkofvTdNm3I2L++O1Dud6ts5xqqLS5MbwsVfNvdTvrYALePbUe4zN8sCnQy0b5WL+zoFZKyDWzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7414
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9467-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,gmail.com,ffwll.ch,arm.com,intel.com,linux.dev,linaro.org,samsung.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fujita.tomonori@gmail.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:david.m.ertman@intel.com,m:iweiny@kernel.org,m:leon@kernel.org,m:lenb@kernel.org,m:igor.korotin@linux.dev,m:robh@kernel.org,m:saravanak@kernel.org,m:viresh.kumar@linaro.org,m:m.wilczynski@samsung.com,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pci@vger.kernel.org,m:lin
 ux-acpi@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:linux-usb@vger.kernel.org,m:gary@garyguo.net,m:fujitatomonori@gmail.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B071D6DAC96

The expansion serves little purpose and it can easily diverge.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/net/phy.rs | 56 --------------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 2868e3a9e02c..965ecca7d55f 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -800,62 +800,6 @@ const fn as_int(&self) -> u32 {
 /// }
 /// # }
 /// ```
-///
-/// This expands to the following code:
-///
-/// ```ignore
-/// use kernel::net::phy::{self, DeviceId};
-/// use kernel::prelude::*;
-///
-/// struct Module {
-///     _reg: ::kernel::net::phy::Registration,
-/// }
-///
-/// module! {
-///     type: Module,
-///     name: "rust_sample_phy",
-///     authors: ["Rust for Linux Contributors"],
-///     description: "Rust sample PHYs driver",
-///     license: "GPL",
-/// }
-///
-/// struct PhySample;
-///
-/// #[vtable]
-/// impl phy::Driver for PhySample {
-///     const NAME: &'static CStr = c"PhySample";
-///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
-/// }
-///
-/// const _: () = {
-///     static mut DRIVERS: [::kernel::net::phy::DriverVTable; 1] =
-///         [::kernel::net::phy::create_phy_driver::<PhySample>()];
-///
-///     impl ::kernel::Module for Module {
-///         fn init(module: &'static ::kernel::ThisModule) -> Result<Self> {
-///             let drivers = unsafe { &mut DRIVERS };
-///             let mut reg = ::kernel::net::phy::Registration::register(
-///                 module,
-///                 ::core::pin::Pin::static_mut(drivers),
-///             )?;
-///             Ok(Module { _reg: reg })
-///         }
-///     }
-/// };
-///
-/// const N: usize = 1;
-///
-/// const TABLE: ::kernel::device_id::IdArray<::kernel::net::phy::DeviceId, (), N> =
-///     ::kernel::device_id::IdArray::new_without_index([
-///         ::kernel::net::phy::DeviceId(
-///             ::kernel::bindings::mdio_device_id {
-///                 phy_id: 0x00000001,
-///                 phy_id_mask: 0xffffffff,
-///             }),
-///     ]);
-///
-/// ::kernel::module_device_table!("mdio", phydev, TABLE);
-/// ```
 #[macro_export]
 macro_rules! module_phy_driver {
     (@replace_expr $_t:tt $sub:expr) => {$sub};

-- 
2.54.0


