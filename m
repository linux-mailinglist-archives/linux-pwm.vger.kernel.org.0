Return-Path: <linux-pwm+bounces-9596-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YmOmNe6jS2pjXgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9596-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:47:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7289C710C1F
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:47:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=Mh4yebiY;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9596-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9596-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 362413025AD1
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357374314A7;
	Mon,  6 Jul 2026 12:44:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021114.outbound.protection.outlook.com [52.101.95.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1B1430CD5;
	Mon,  6 Jul 2026 12:44:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341881; cv=fail; b=XiqMt/rp4YItptvYiP9t9mUwsRzsO08OidxgiQfQ0jmj+5DrJ4GQyJQDa29q7qQlQgsOlr0nrWiHD5alSXyJu8XgxfG46XXM3QR2fMXoUGjD+q/cW4lrvIpE9AqSTLKTOsCDp+Zt5S/3W1ep0yPCmVjEiwMfoOQvog7SELiz5gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341881; c=relaxed/simple;
	bh=F5bGCqFkVx5u0fZSyaG/xN6wOWqT7osen1PoYUXenCc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UlA+s6T0MWae7Ls2gfj0Y2RMNJqz3qTet6LJ+B5V8+XgtO389jIWrzwzJHv68wkoMNCPnW3uVmcSCpwu4qj945IYHYw16KA4XP7ILsQdAmcECBTXKhva3C5wKT8PdY5+3qNacUt3S89Gwe7DE1Vl3PXtilziV6lhcAcjc52jqrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Mh4yebiY; arc=fail smtp.client-ip=52.101.95.114
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKJdzU3x3rpDE85LZIYJoydeNP1o438S34pQ0urghFz/6UnD7r4dvTH2EzY5PG0Xe/lXOcRjuYl+CTR1cQBfPB+ydyrY7u01DkhOWnPB/NBD/8LND4L3j7HDYFpL3+zSq2eBtwwgilsolYDExUuAzKI4ocvNR2UFer0Z6FyQREPNMcoWxkRnEQdPSOr5RhqrNBiUSyJpvPkLDGzY8PaFwU4xcTU6DZFYdcN48W4Ex64vOumOPSUgzNyUvLK4O/bjbGIce0b66OmUHzBJbtHFANtaEf0n67vnEzSOaLObdmSmDxCTfg6o8AqAGTeMJEyYhUaJDY324sZazEOEBa3v5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mexKlJxPHt69pUM8edn80nNxxWqmpkg22miiWh9UYI=;
 b=CVTSFhPjpvT9QpmQW9OA1QNhv0rt4ltsgqbJo7sldNAD3PrQssEdynkrW0gcGURdtKa+RCAju84glgB3SJYRRARjin2Nm1SqHD0+IDVNZQofYv5IkIyQuZiqShoPZ5yzzSQJ4SSyIsU2HVw4mr/gg7ieVEmg9ffQyCwtkkMQOA9h518huXoMVgN3OiUEf0VO9fqII545lq3C0JOBcMy3vXi29bjeeq4ZriTiokO6F8p/CQqdfR+44Q+DldC2oqbraMcw4rxdYhaLcDK1BKh8nkRDOVjFPL0bBckNk/+nct1nAtG3P6FwLm4vn4+fO/kjgfBV50sWAMj4jmrbSVpSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mexKlJxPHt69pUM8edn80nNxxWqmpkg22miiWh9UYI=;
 b=Mh4yebiYB6l9BsQcUOkuTO5+JjDa5g5GqLxkcT1L0fJrUvJK4GaCV+NSENshNlQOSVhbLNL7f8k7lBaqoIK8beOq/K/u6eNkFiVzjr3oriy98LxPSHmQMEPHG3rVXX7ae2Vmify+Q6sSeFJLoRCofCOi2yrG4HcS2dszzwu1z98=
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
Date: Mon, 06 Jul 2026 13:44:17 +0100
Subject: [PATCH v6 04/20] rust: io: implement `Io` on reference types
 instead
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-4-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=16372;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=F5bGCqFkVx5u0fZSyaG/xN6wOWqT7osen1PoYUXenCc=;
 b=YD+3k30uCSSZ4blIJWfRKpTJFnYiHrYRnJv7zhVATGUSGfnriSEUMprAQ3tyF/AQtSvHKjH7w
 zqeJwVjE+FyAkqnVX6dt0d0evNNfdtDEuq6tsdSqFjwRtiA9WA6szX0
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
X-MS-Office365-Filtering-Correlation-Id: dff11e40-bb54-4525-51ce-08dedb5c5049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|5023799004|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	CADHAevmwL7U014Ru8OWKPTm31M+J+5bZd7uiYPrZTbUO1Mtw4PQY/LNodxEGpK07eRwEb77xmQ+nFhUJum8xQlFLhe0NEePOpB2zg8+i7KUVX6QMjgfF5lk62RiaBlSpH/UBeYZyJHKAmuT2dryOvhaZRYCjWTwNa2reHlce+gsR0/+A7PuVYP9pwaqgiPpB0pIw+pXqveMyn0j4s0aMt6k/FP025RAKPi5+t36vPG9LJc28mjrfcrtWUEudY5uNMp5WMUyCheffypcpqG216pOb8TxbHu/gSBqCE+gkTdnIDlKx4q6R4mxlmoq55URRqHDfuHDqAGvHsxgZQlPvBmF+LL1cWbFYRCLEWRun/h6/CCzahxAmZhxAQUl//yfBLjvmufmOSp7q4vSkuTzfufz8hwrlm8FSqE5owpIsrvg1GFM/CXI1YkRqm+pkYdtZBI52zysak4lhYLjheJtg+UeSnQDBn2mzQY4Tub95It/gcICs2b/vswmwes1pgKDraKL3QO8bEOGxJl4r3raXyn79+N/a+nQAyNgcrg9rMjTd9xTiTV4GXmuEV4wDvYpb5D8WNhugpH84Lc5iF743S9OAjQwojzHmGAJg+98gXIZmgTYYbo/5RFotLHhtupxkt8vv8F4+KVL0UlTl7dSFVdZkD4OE7Gqv9UWMZ8mVyUyv4wwyai3S1MDKzETfPabELe4bFrgA+Rf5ifTKjOxiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(5023799004)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHUxWUErNXp6WjVXbVo2RTZmdFBpMWVYcjVia3FEL3IrQWdqQi8vejNHcGJn?=
 =?utf-8?B?L09LRDVjL3piVlJOa1FTYWpXNTlvNFB6blNpTCtnVWdRaUJrRjR5dnQ2Tm9R?=
 =?utf-8?B?T2dWMGJ4SURRZFJhRGZ3NDI5bzFra3gxZXlkelVSWmRkRytjQm5YV3piMFM1?=
 =?utf-8?B?cm1Fa0daY1R5aG9IaE9ac1VjcG1QaEFzVVRZRHNvZHRsQ2k2NW1JNG05VC93?=
 =?utf-8?B?bERqdUVSTGd4aGNiVlBhODlNTnFwazdVMWZKcEViM2RBS3E3VE4zVHVSWmZD?=
 =?utf-8?B?b3BrRkFyd3BVVVBPNGdBcnNYc3gxeW01Rk5ud2xsMFpSU0I5cjJaZ0RSamp2?=
 =?utf-8?B?V3lLVlVkSGNDN2x5U0haYVFWNWwvcGJaSiswNElpenhRQURmSDhWMGJpTkl2?=
 =?utf-8?B?eXg0MDRQT2Jta2ZmMXArLzBCS3djSm10RysyRVEvNWFvQ0owS0drSlNVeXJE?=
 =?utf-8?B?aWNwMEdOL25hbmN5cDJsNW5GLzZnM01UWFNrWUlVWG5yMkVZRlpHVG00U01I?=
 =?utf-8?B?YjVieFN0QXBUSTg3RitKekl1ejRiN1JwU1NrZGYzeEJsUjBZSkxDVHdwdHB0?=
 =?utf-8?B?N1ZzbTJIcUlkYzBvL3ZYSlh4NTdWc3dvaWl1bXBxbDV0TW9LQ0h6N3hxVDV0?=
 =?utf-8?B?b2h1OHlQL0FjNllYWkJQa0tPVnQ4cGl3OGNyTWNUUTZvRHZxN2d6Z2xxYWtW?=
 =?utf-8?B?L1RuTE1QWHN1dU41a0xuemJNdXUrY2ZBT2J0VnFFTzBzZnp0eTUvVEhiRnBR?=
 =?utf-8?B?MDc0Z1JuL1RDRmJzalR1ZnJFRE5jVEFyd1FuRmpCOHZLQ1VMd2QwOTRVY0pO?=
 =?utf-8?B?bWpiSmgrSTQzekE0bnkwa2d2SFV1NXhMRlgwNGNXVVE1UDlySWNzdkVpVU1W?=
 =?utf-8?B?b0lLdUNrdnpNeE8rMEd1UERCN2Q4Tk4zUFgxcmUvMjhSMUNLeU8xSUMveEs4?=
 =?utf-8?B?ZG9aNE5ObitmbDZhdmdhZFVhQUpLN05pWEtuRzRON1lXd3VHaFl1QTVvUDVV?=
 =?utf-8?B?R21jemVEMXFLTVJ2L1JBRGtlTlBOZ1dIbWRXL3NmaW45SEN5WEdEc3Ntc0FP?=
 =?utf-8?B?eVl2Tlk1bzMvL2lPeXN3MFZ2NkwzNGx2U2lZc0VRTGRPZHMwU05qcVNmRURC?=
 =?utf-8?B?eDF1MU9zdHBuTEhhV05FeDNtQzRhYnZiNHFmWVlzYm1LbGlUTmM0NEd0UExy?=
 =?utf-8?B?Y2gzS2o3RnFEM2huQ20yM3BiWDdjWEVHa1o2STJSZHQ5NU50a2dlVXVBeVJE?=
 =?utf-8?B?NmVsU3l4RVN2d2E2N25uSERXNlpNb01XaHBNaDR5ZzZpazVWZjU4NVBjY3Nj?=
 =?utf-8?B?R0FGY1A3UzdiM3R2Q2FGUFM3YnBoTTBGWXdUQ3ZuSFRGN2NyRHdrUWxtNTNo?=
 =?utf-8?B?VUtZY2d5TGNUeHV5SlM3aXY2VVYyWmdRcDR4QmMxRXJydjNJRUNRckN6VkJW?=
 =?utf-8?B?VmM3K1NEVEd4UnI5YVM2Q253U1dMd2V1bjl3aGNJaUk4NzdZZFN2TlBKNHUv?=
 =?utf-8?B?a2tvSTFZRWw1TUE1TmpxUDh4UEJwdEdVZFV2QUx4WURzKzlHWmRIYVYzQ3A5?=
 =?utf-8?B?dzdTSGcvbTV4QXEzQk1BSFpEUm1zL21JNzhtNHlmQ2c0UWd0ZGxVMW5pOENo?=
 =?utf-8?B?aHB1WHpuRHh0WEhRMnJudzl3SXBHZWZnYkFxSEhxZ2YvZXliL2FwNGdOS2NS?=
 =?utf-8?B?dGxacXk4blZsOXQrWWpuRzV3azRiNDE1QU9CVTZEV2lkck42RWZFNHdISDlR?=
 =?utf-8?B?eDdQM1Z6WFpxYUkzL1VNYTk3VUg0UFprMjBkQ1l5MjlvYURJVnFTajYyb1Ew?=
 =?utf-8?B?TFFZcVBCVGVCcWljT05FR2N3dW94Z1gyMVBkRGtYME5hd0hLdU1PSUh4R2h6?=
 =?utf-8?B?Um9vRGN0Z3J4WVp6dkhtUDVtL3hNUGZrWFpBUGFsS0ZJQVI1RTNHRW5NKzdk?=
 =?utf-8?B?cG1xcDhVZEVrZTMrZ3VFVDhETXNibHgzK3ZjUU43a3Z2OVp0Y2FQMmVFQkpI?=
 =?utf-8?B?eVFkV3p0bGdLTUorVFBmdVNNS2RpQmRoOFpGSUVzYmNUaHpVWWxrVjFQdXN6?=
 =?utf-8?B?TFFsckdDdHdoZG9KOHJEd3dBcmZCQzFrSXE4eUtoTUJYclcxckl6MmVsYmUr?=
 =?utf-8?B?eXhsa3M1RjN6VnBYblZVWTduTCtSMHNUN3dTTlJWY0xTRVZTVXdBeE9ZTHFu?=
 =?utf-8?B?Q3RkTUxDdUN4TkJHUWVPTGZ4L0ZvUld4Qm9ndjlYaWVacE4vRXBvZFVJRUxS?=
 =?utf-8?B?TFFaYVI3bER2ZGpxc0FaYm14aGF6TlJmTEVUTHNjbkZLMCtSVFJNanRHOUFl?=
 =?utf-8?B?N2UwbjJWWEtMTlhYVDZHclpQTHBFREg5ejVTUkdML3hQRUp1UWx5UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dff11e40-bb54-4525-51ce-08dedb5c5049
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:26.4491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfiLHI8SxUxjksFV4PucrswAWTqr3i/SyNU7/2y3j1VrKKf6sU+9oh3lA9lgbmEkV9v0mBh14YJXGlbfjwkDOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
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
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9596-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7289C710C1F

Currently, `Io` is implemented on owned I/O objects (e.g. `Bar`). This is
going to change with I/O projections, as then `Io` needs to work both for
owned objects and views of them. Views are themselves reference-like
(however they obviously cannot be references, because they belong to a
different address space).

To facilitate the change, change `Io` to be implemented on reference types
for the owned I/O objects, and make methods take `self` instead of `&self`.
When I/O views are implemented, we can then naturally implement `Io` for
these objects.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs     | 82 ++++++++++++++++++++++++++-------------------------
 rust/kernel/pci/io.rs | 12 ++++----
 2 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 87141eb07056..9f060dd29182 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -223,7 +223,7 @@ pub trait IoCapable<T> {
     ///
     /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
     /// - `address` must be aligned.
-    unsafe fn io_read(&self, address: usize) -> T;
+    unsafe fn io_read(self, address: usize) -> T;
 
     /// Performs an I/O write of `value` at `address`.
     ///
@@ -231,7 +231,7 @@ pub trait IoCapable<T> {
     ///
     /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
     /// - `address` must be aligned.
-    unsafe fn io_write(&self, value: T, address: usize);
+    unsafe fn io_write(self, value: T, address: usize);
 }
 
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
@@ -294,25 +294,27 @@ fn offset(self) -> usize {
 /// Which I/O methods are available depends on which [`IoCapable<T>`] traits
 /// are implemented for the type.
 ///
+/// This should be implemented on cheaply copyable handles, such as references or view types.
+///
 /// # Examples
 ///
 /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
 /// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
-pub trait Io {
+pub trait Io: Copy {
     /// Type of this I/O region. For untyped regions, [`Region`] can be used.
     type Target: ?Sized + KnownSize;
 
     /// Returns the base address of this mapping.
-    fn addr(&self) -> usize;
+    fn addr(self) -> usize;
 
     /// Returns the maximum size of this mapping.
-    fn maxsize(&self) -> usize;
+    fn maxsize(self) -> usize;
 
     /// Returns the absolute I/O address for a given `offset`,
     /// performing compile-time bound checks.
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
-    fn io_addr_assert<U>(&self, offset: usize) -> usize {
+    fn io_addr_assert<U>(self, offset: usize) -> usize {
         // We cannot check alignment with `offset_valid` using `self.addr()`. So set 0 for it and
         // ensure alignment by checking that the alignment of `U` is smaller or equal to the
         // alignment of `Self::Target`.
@@ -325,7 +327,7 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
     /// Returns the absolute I/O address for a given `offset`,
     /// performing runtime bound checks.
     #[inline]
-    fn io_addr<U>(&self, offset: usize) -> Result<usize> {
+    fn io_addr<U>(self, offset: usize) -> Result<usize> {
         if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
             return Err(EINVAL);
         }
@@ -337,7 +339,7 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
 
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read8(&self, offset: usize) -> Result<u8>
+    fn try_read8(self, offset: usize) -> Result<u8>
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -347,7 +349,7 @@ fn try_read8(&self, offset: usize) -> Result<u8>
 
     /// Fallible 16-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read16(&self, offset: usize) -> Result<u16>
+    fn try_read16(self, offset: usize) -> Result<u16>
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -357,7 +359,7 @@ fn try_read16(&self, offset: usize) -> Result<u16>
 
     /// Fallible 32-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read32(&self, offset: usize) -> Result<u32>
+    fn try_read32(self, offset: usize) -> Result<u32>
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -367,7 +369,7 @@ fn try_read32(&self, offset: usize) -> Result<u32>
 
     /// Fallible 64-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read64(&self, offset: usize) -> Result<u64>
+    fn try_read64(self, offset: usize) -> Result<u64>
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -377,7 +379,7 @@ fn try_read64(&self, offset: usize) -> Result<u64>
 
     /// Fallible 8-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write8(&self, value: u8, offset: usize) -> Result
+    fn try_write8(self, value: u8, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -387,7 +389,7 @@ fn try_write8(&self, value: u8, offset: usize) -> Result
 
     /// Fallible 16-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write16(&self, value: u16, offset: usize) -> Result
+    fn try_write16(self, value: u16, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -397,7 +399,7 @@ fn try_write16(&self, value: u16, offset: usize) -> Result
 
     /// Fallible 32-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write32(&self, value: u32, offset: usize) -> Result
+    fn try_write32(self, value: u32, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -407,7 +409,7 @@ fn try_write32(&self, value: u32, offset: usize) -> Result
 
     /// Fallible 64-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write64(&self, value: u64, offset: usize) -> Result
+    fn try_write64(self, value: u64, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -417,7 +419,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
 
     /// Infallible 8-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read8(&self, offset: usize) -> u8
+    fn read8(self, offset: usize) -> u8
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -427,7 +429,7 @@ fn read8(&self, offset: usize) -> u8
 
     /// Infallible 16-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read16(&self, offset: usize) -> u16
+    fn read16(self, offset: usize) -> u16
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -437,7 +439,7 @@ fn read16(&self, offset: usize) -> u16
 
     /// Infallible 32-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read32(&self, offset: usize) -> u32
+    fn read32(self, offset: usize) -> u32
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -447,7 +449,7 @@ fn read32(&self, offset: usize) -> u32
 
     /// Infallible 64-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read64(&self, offset: usize) -> u64
+    fn read64(self, offset: usize) -> u64
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -457,7 +459,7 @@ fn read64(&self, offset: usize) -> u64
 
     /// Infallible 8-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write8(&self, value: u8, offset: usize)
+    fn write8(self, value: u8, offset: usize)
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -467,7 +469,7 @@ fn write8(&self, value: u8, offset: usize)
 
     /// Infallible 16-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write16(&self, value: u16, offset: usize)
+    fn write16(self, value: u16, offset: usize)
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -477,7 +479,7 @@ fn write16(&self, value: u16, offset: usize)
 
     /// Infallible 32-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write32(&self, value: u32, offset: usize)
+    fn write32(self, value: u32, offset: usize)
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -487,7 +489,7 @@ fn write32(&self, value: u32, offset: usize)
 
     /// Infallible 64-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write64(&self, value: u64, offset: usize)
+    fn write64(self, value: u64, offset: usize)
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -518,7 +520,7 @@ fn write64(&self, value: u64, offset: usize)
     /// }
     /// ```
     #[inline(always)]
-    fn try_read<T, L>(&self, location: L) -> Result<T>
+    fn try_read<T, L>(self, location: L) -> Result<T>
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -552,7 +554,7 @@ fn try_read<T, L>(&self, location: L) -> Result<T>
     /// }
     /// ```
     #[inline(always)]
-    fn try_write<T, L>(&self, location: L, value: T) -> Result
+    fn try_write<T, L>(self, location: L, value: T) -> Result
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -598,7 +600,7 @@ fn try_write<T, L>(&self, location: L, value: T) -> Result
     /// }
     /// ```
     #[inline(always)]
-    fn try_write_reg<T, L, V>(&self, value: V) -> Result
+    fn try_write_reg<T, L, V>(self, value: V) -> Result
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
@@ -631,7 +633,7 @@ fn try_write_reg<T, L, V>(&self, value: V) -> Result
     /// }
     /// ```
     #[inline(always)]
-    fn try_update<T, L, F>(&self, location: L, f: F) -> Result
+    fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -670,7 +672,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     /// }
     /// ```
     #[inline(always)]
-    fn read<T, L>(&self, location: L) -> T
+    fn read<T, L>(self, location: L) -> T
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -702,7 +704,7 @@ fn read<T, L>(&self, location: L) -> T
     /// }
     /// ```
     #[inline(always)]
-    fn write<T, L>(&self, location: L, value: T)
+    fn write<T, L>(self, location: L, value: T)
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -745,7 +747,7 @@ fn write<T, L>(&self, location: L, value: T)
     /// }
     /// ```
     #[inline(always)]
-    fn write_reg<T, L, V>(&self, value: V)
+    fn write_reg<T, L, V>(self, value: V)
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
@@ -778,7 +780,7 @@ fn write_reg<T, L, V>(&self, value: V)
     /// }
     /// ```
     #[inline(always)]
-    fn update<T, L, F>(&self, location: L, f: F)
+    fn update<T, L, F>(self, location: L, f: F)
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -799,13 +801,13 @@ fn update<T, L, F>(&self, location: L, f: F)
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
         $(#[$attr])*
-        impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
-            unsafe fn io_read(&self, address: usize) -> $ty {
+        impl<const SIZE: usize> IoCapable<$ty> for &$mmio<SIZE> {
+            unsafe fn io_read(self, address: usize) -> $ty {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$read_fn(address as *const c_void) }
             }
 
-            unsafe fn io_write(&self, value: $ty, address: usize) {
+            unsafe fn io_write(self, value: $ty, address: usize) {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$write_fn(value, address as *mut c_void) }
             }
@@ -826,18 +828,18 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
     writeq
 );
 
-impl<const SIZE: usize> Io for Mmio<SIZE> {
+impl<'a, const SIZE: usize> Io for &'a Mmio<SIZE> {
     type Target = Region<SIZE>;
 
     /// Returns the base address of this mapping.
     #[inline]
-    fn addr(&self) -> usize {
+    fn addr(self) -> usize {
         self.0.addr()
     }
 
     /// Returns the maximum size of this mapping.
     #[inline]
-    fn maxsize(&self) -> usize {
+    fn maxsize(self) -> usize {
         self.0.maxsize()
     }
 }
@@ -864,16 +866,16 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
 #[repr(transparent)]
 pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
 
-impl<const SIZE: usize> Io for RelaxedMmio<SIZE> {
+impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
     type Target = Region<SIZE>;
 
     #[inline]
-    fn addr(&self) -> usize {
+    fn addr(self) -> usize {
         self.0.addr()
     }
 
     #[inline]
-    fn maxsize(&self) -> usize {
+    fn maxsize(self) -> usize {
         self.0.maxsize()
     }
 }
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index b4996aa059d8..505305cd9b86 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -79,8 +79,8 @@ pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind = Extended> {
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
-            unsafe fn io_read(&self, address: usize) -> $ty {
+        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for &ConfigSpace<'a, S> {
+            unsafe fn io_read(self, address: usize) -> $ty {
                 let mut val: $ty = 0;
 
                 // Return value from C function is ignored in infallible accessors.
@@ -94,7 +94,7 @@ unsafe fn io_read(&self, address: usize) -> $ty {
                 val
             }
 
-            unsafe fn io_write(&self, value: $ty, address: usize) {
+            unsafe fn io_write(self, value: $ty, address: usize) {
                 // Return value from C function is ignored in infallible accessors.
                 let _ret =
                     // SAFETY: By the type invariant `self.pdev` is a valid address.
@@ -112,18 +112,18 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, S: ?Sized + ConfigSpaceKind> Io for ConfigSpace<'a, S> {
+impl<'a, S: ?Sized + ConfigSpaceKind> Io for &ConfigSpace<'a, S> {
     type Target = S;
 
     /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
-    fn addr(&self) -> usize {
+    fn addr(self) -> usize {
         0
     }
 
     /// Returns the maximum size of the configuration space.
     #[inline]
-    fn maxsize(&self) -> usize {
+    fn maxsize(self) -> usize {
         self.pdev.cfg_size().into_raw()
     }
 }

-- 
2.54.0


