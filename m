Return-Path: <linux-pwm+bounces-9420-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PcQhEJGSPmoCIQkAu9opvQ
	(envelope-from <linux-pwm+bounces-9420-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:54:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CE96CE2AE
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:54:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=ZgxpmRg0;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9420-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9420-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63E78311782A
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916BD3FE37D;
	Fri, 26 Jun 2026 14:45:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021075.outbound.protection.outlook.com [52.101.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E2D3FCB05;
	Fri, 26 Jun 2026 14:45:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485156; cv=fail; b=UrLZkAu48pc2w/17CtVcipwjnkuIq2DxGY3hr1mIZD+vO4aBGroYpA8phumLx69evdg+NO3IfMuxY5PTPXAmk8HGZZpFP/kzdA0V/N0o5vl5SWI01w/Ftv/V/Aj5UI89YgfmaiJn18B0fiq//o0bteapUb2DuD40ilo0mzchS2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485156; c=relaxed/simple;
	bh=um6cTW9AX/ZfgyDuPqM0KWFysy6fm/Z3QMYdK6hsSXw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=epFnBSt1RB5/1+zFgRDtwZFxmSFqiXOKB4Z3tJNuGGu1rhV87RW+7VqKR9EEFvYgwj1zrXkM8ORiKiJjyc7NVjDR9H8t7ibBexAMvtddx9JfaNTvVTuEAa0DWB23ourLAOYixVIGs300Rtaelc5B5vuPPTHDDflpO1JrOgmn5fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZgxpmRg0; arc=fail smtp.client-ip=52.101.100.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM7ysP7Rydxt6osR1oCuw/z4P5pQbnlYecvqW+EBGy7EW7LYJiw+7mePXtIHwcyyZuDnDrw/+TwGaZ3YG4cvZLbqRh2U9lNOeD12G4qW0VzoTZ4nZydd4MJJhHJ0j1zYLeMJcMBSclkDW/sCqQctvaVbP+6XZXmIFlzuGWfxG+bFSTnH14+rF2lHHpYOWMPYRmmKyjlmi6Jdo8Ur4kWBLuZGDYBxLDMytN4mHy8Bf/HYxlK0ELLDTwvZkf4gIybQKLQaS9m0t1jA31TLSS42nuqIGpA8q2X6gULrkmqjNfrUAZAXzRDu+Y9Xjsy/noke2+AeGSZOvxi9OlVvREK97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9wQ15I+NBRD+S+qojXgJPVcWlu9LaUPUdTo0T5SEhY=;
 b=YQ+220HWn7T8ASNOd885YfW5S680c9j0RZ7OZSNXbdEbVgW4+twAbuJc9koe5z+AcVQHJSbcuojrtU9/TxXsg9c68ogtaoeJT6KgS09CkmsLNOQ7qIWqaXc7I3YOhQsT7UZ5LkdH0ya2O4/MZZjgQtuYX29cA1qYFcnH9dBccM2IgRFGi5LPo4p1XJDVVexcrFvbohnDCYuDk25XzOn/MEm9xCOjlCLSC0nzgOg6PZTcf/4pFHTu3AJ5ZKp2qynLcgvbIX8tNjDJXkKapk8OfCl1lbCHv5GUynEElz4Rt3KRQXMqHyjVu4YC3njQjTiHQfnvRoEOluQ3zhNoXUVMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9wQ15I+NBRD+S+qojXgJPVcWlu9LaUPUdTo0T5SEhY=;
 b=ZgxpmRg0e1bCRX0Oo/scDyw5TsjPpey6KluWZqCWxx64bL4+3WKyrYaCXj21esTLNQDkQcDn5ebzI/1VeDmcHcJbPDntHAmj3gAzR38AsHPKQsLebpWpSPskOS4KV2Nkbq1DiCceKyJQJJwuVrrD2FatMrHS9Ac9JLIjNtDYmDg=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7248.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:20 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:20 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:11 +0100
Subject: [PATCH v5 07/20] rust: io: implement `Mmio` as view type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-7-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=16251;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=um6cTW9AX/ZfgyDuPqM0KWFysy6fm/Z3QMYdK6hsSXw=;
 b=62yeWoQxrRrr3S1+JQ/YnNTd43j/Ocpama3E8HprvDW+iS9Z6jNzbenrX7joQ9N7BJssjvSw5
 NQVGolTzBW/Ch3GUgj0erkgrUHJ+i4uPzj3SmRXJ6hC9fCyhCq4Xlk8
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 806816a6-1688-4380-9678-08ded3918c05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|23010399003|366016|7416014|18002099003|22082099003|921020|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	B3O51/N66DIhwihGSdx9vu7YWgBaivQTtdpbcGl7dqs718G+1qC68UDfRIAmxFNDMKQAWEXRcNGO3MTFtS0n8JQMpvg1lACBF5hMYQPu4hHlASFCdWRkSvkxCKCVROxD7j+XNC1b8qZtbUlYF8l54/zGM0AjaQMpurwNdZGeNLWNcOQd4dDRFMGngBXSuSXOqwjOpez3BTIEqIIQPS60EyA6ZnSN7oYocg6rvIzUO0aonzIE6Aa1+mJe+LxKzOEWTNxBRHuUd4aBlWHKhKQsrOhcq7q9BJS6qYa3puqz/dqyZIpX69a1YFj1uc4Au788pMefoylRmN+67Z2UnZKVREYIm/fnYumbDJ6gWsOf7zcvnfyUFQepHoChfc2t1DkfWizP8/MlCO8as1zxIlmwaegb9JFBbFL/az0YfHaQ/2A3A4G65yIFtWABgtAx3JXtdLLwBnv8bqjX2DpH2bY+Na+uF9FTLSWsLHow/LI6JrEFygW4jIiIpBZBaHPgAR+9boGVeu6vaUG6NbN2QgeCYCVpDUY7NWhnZFmLmayZEXnvQNPs97JqrZMjbgGZ4NawDv7VJLR5RaKJiUX17yk3ZXfYAhFvWCsWtVF1IVSDJ6AaFI3yf2ZnNar9JJtvkk6G+o3bzdW2hATrCgAujjwijBc9jCcT43apLRkMdcHAX5JnVEnG4uzkV6WcsHSl3SKPt8Uv6SYTz8bTTfOIRULsgg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(7416014)(18002099003)(22082099003)(921020)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXRqSTBVTlp3VTlwcGN1RTFSRHFJekFFTTI3TUowM3ByU2lrTDBMck1lQUZM?=
 =?utf-8?B?QkdKTXg4dzZ6elJLTW9WNEJTcDc3WDlmNkw2UUV3cHJZWWhQUmUzK2ZjVTdG?=
 =?utf-8?B?OXZzSWlLVWV2dXBwSTZHa1ZNaW1XS1k2anB6aXNYdjM3dC9IamhlbzNBcnhr?=
 =?utf-8?B?dzdibGxlSjhQWUxEd2s0ZGtjSWxOOWs5TW1yVG84WVhmUlRhejJIZ2xKNVVi?=
 =?utf-8?B?Y056Z1FYMTUwbkMyUUV4ZXFqeGhyV2pwWU5qU3JBNUsrUitWZ1dWNDQ0ZVV5?=
 =?utf-8?B?alRmVUNXZy9VdHpUWU5vK1dEKzRhS0JxTTA1SmZYUjJ5MHZFN213b2Y5L1Jt?=
 =?utf-8?B?czFWbUxpOGVJK2dHVkc5S2M4UmxoanpPM1A3TWQzWXNET1MvWVRwblN6Z1Vs?=
 =?utf-8?B?bHpBMWlmNTlDbVpsSlRWemNjSnpqYnRZWVZNQ0dJZ0VHQm1uYnlUaGc5NEJC?=
 =?utf-8?B?cVV4MGc3ZGNsNVZhanI3MHJoZzN2SUs5Tzdad09KalBLUUw2ZjdaSk9DV1pI?=
 =?utf-8?B?U0h0M2F4QjBZQi84a2hoU05pYzF4VzhpaHZBakhjUkhrR1k3bjVTek9PcS90?=
 =?utf-8?B?S3FGSDRrdG9ySnYvSVVRT2IxaWFtOWVlcnFLUEtyNVBsWmNtbExVdW1qb3Jv?=
 =?utf-8?B?TFVEWUUzQW9JbFo4UmhRbmxaUVFHUGtnMlpibE9YVUczdnJLRkJBeFptTFFm?=
 =?utf-8?B?MXBibk1JR0QyeUErbHZSdC9kNVZDT21CQkQ3ZUlzb1pjQlBwcGg2cFpqRGk0?=
 =?utf-8?B?RFk2OUhqcjR1NC9VRWFuc3R2SE5kOURDVDFxVWEwdUYybGlvY0RRR28yQXhh?=
 =?utf-8?B?Q3lPbnM4Q1R1Zk9Vc3JHUnM0VEdTN08xckdKZWc5S2hDci9DM29XRWVRL0Rz?=
 =?utf-8?B?ZDNwREEzVWJqWkZaN1dEVDRIclVsdVlHSEhOa2ovLy9BL2J6dUhNd2g0cmdO?=
 =?utf-8?B?ckQrRzU3Y1BoblhjL1pYMi9oU00rR0Z5aUswdHZXKzN5dlUrM0QvalRwbThN?=
 =?utf-8?B?L1hsaktUZ1VNY2VhaFg1TlhXVUNVcnlibCt3R1MydjY2RjZZSGpYWWZoazZu?=
 =?utf-8?B?VnNNVHFWWlBEUUQ3RTRtakxqWUxGV1pIQktRdXU1OUVCaGZCOU04Rk01TzY0?=
 =?utf-8?B?aWw4VnJTYnpSd2JQQnh1ODltTUlpRS83VXkyeHE1OHZkQksyODVtRnZHRWpK?=
 =?utf-8?B?c1ZPMjlRRnZLOGo3TGptdytxOXFJek00VnNjZlUzT01TZDhnUWxYb2lhUGNn?=
 =?utf-8?B?QmIxb3BqSCtuQWNmbGo3aVg3T3pFT0w0Y3Bka3JyQ3p3QzI2K0Y4Yll3UDI1?=
 =?utf-8?B?VWlGZC9jL3l5RUhJTmhxaTBudkJ0dllpdlRzQmZWZ0paem51cm84dzFhcURL?=
 =?utf-8?B?RTUyRlJsNHFFMC9kQURBMGo0TVlQYkNtUnowKzRReEQ2M3NHekgzQUxXVysv?=
 =?utf-8?B?a2pyN0ZYNG9GbWpldmN1dG1UZTFCVEFlR245MDErNEJOMzFTSFB3bDZSVUhE?=
 =?utf-8?B?blc2YkVsb1grRGhQb3E2SkhKN3hrbk56OEpQYWNESFozVGlZSmszQjkxUE9v?=
 =?utf-8?B?MWtLV0FxRm9reDd3b2tnY0xEd3B5aFFPdVhlbzFDcjk5b3BoaiszU0QwOTQv?=
 =?utf-8?B?dk81Zmc1WGJnWXU4dVJLTEphUU95M3pUdFhyK3FlU09ybGsxNC90b0tLSXpQ?=
 =?utf-8?B?dlZpdDNqYUJPb2ZFMk9mL2cyRFdSM0htbmVhVkhwN3ZFRnhEc2FBRmVqQWJS?=
 =?utf-8?B?SDVsdlhPV0orNCtWRHdaM25zOEIvdStkWkE4S0IxMUZTRFJLVlg3VWRKUU1F?=
 =?utf-8?B?WThXNUhxbFBHeEV2enJkbllzTVNwcnI1NnVLMEJYVTFFVXAwR1BvcFMrL3J3?=
 =?utf-8?B?aUZXMXp4aWYycE9qcHk2TFpjS0h3OHdubW1Deks2MWMwZnpQUHlpU0tkTHox?=
 =?utf-8?B?YWJ2ejJPS1FPeDVwbS8yRUZGTFVlZ3pDS01KL1RycDlXVWFudmFlM2E4d2x4?=
 =?utf-8?B?MlJpMkhBanMzd3RRU1JtVytSclNPT0o0Y2VOSFFCSVpMZ0pHV256YUFrQjh3?=
 =?utf-8?B?OTJJUkNPVWt4cERRUnl2Y0FmbG1KQzZjc29JOFd4UkVPc2VIeVMvVXdwOXZG?=
 =?utf-8?B?R2xzM2pZNEpmR2VzRDJEcU91TGZtMWkzM3ZSaWNORUVyVmdRQy9wTHRCeFc3?=
 =?utf-8?B?UUdkeE1LT2REZ1BNRUsvU0ZReGViMHhPS0U1YWNvbFN6QzUwUG1KYWVwNFBs?=
 =?utf-8?B?bDlYVmNpeXlhL1ZCZHVzQmVQVDgwa3FqdTI5anhQTkFadEJuM0NwNHM4djNL?=
 =?utf-8?B?YWxzWFhXTER1Ulhhdk1scnNwRy81OHhHR1FqM1dkTlJpWjUwSDBDZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 806816a6-1688-4380-9678-08ded3918c05
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:20.6760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUxh6Ryhk9SvZG5FznFsW8qXNC+GpFwvezZJocXkBstWnBhXnpb8OGDQUJSLVqtMeDtqsc/XZVD+ellC/q2W8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7248
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
	TAGGED_FROM(0.00)[bounces-9420-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5CE96CE2AE

Implement `Mmio` as view type and convert `RelaxedMmio` to view type as
well. I/O implementations of `MmioOwned` are changed to delegate to the
`Mmio` view type.

All existing users of `MmioOwned` in the documentation which do not
actually reflect the owning semantics is converted.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs          | 176 ++++++++++++++++++++++++++++++++++-----------
 rust/kernel/io/poll.rs     |  10 +--
 rust/kernel/io/register.rs |  24 +++----
 3 files changed, 153 insertions(+), 57 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index f93be7f78069..8110b49aa430 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -4,6 +4,10 @@
 //!
 //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
 
+use core::{
+    marker::PhantomData, //
+};
+
 use crate::{
     bindings,
     prelude::*,
@@ -537,10 +541,11 @@ fn write64(self, value: u64, offset: usize)
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_reads(io: &MmioOwned) -> Result {
+    /// fn do_reads(io: Mmio<'_, Region>) -> Result {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.try_read(0x10)?;
     ///
@@ -571,10 +576,11 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_writes(io: &MmioOwned) -> Result {
+    /// fn do_writes(io: Mmio<'_, Region>) -> Result {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.try_write(0x10, 1u32)?;
     ///
@@ -609,7 +615,8 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
     /// register! {
@@ -625,7 +632,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &MmioOwned) -> Result {
+    /// fn do_write_reg(io: Mmio<'_, Region>) -> Result {
     ///
     ///     io.try_write_reg(VERSION::new(1, 0))
     /// }
@@ -654,10 +661,11 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_update(io: &MmioOwned<0x1000>) -> Result {
+    /// fn do_update(io: Mmio<'_, Region<0x1000>>) -> Result {
     ///     io.try_update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -691,10 +699,11 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_reads(io: &MmioOwned<0x1000>) {
+    /// fn do_reads(io: Mmio<'_, Region<0x1000>>) {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.read(0x10);
     ///
@@ -723,10 +732,11 @@ fn read<T, L>(self, location: L) -> T
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_writes(io: &MmioOwned<0x1000>) {
+    /// fn do_writes(io: Mmio<'_, Region<0x1000>>) {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.write(0x10, 1u32);
     ///
@@ -757,7 +767,8 @@ fn write<T, L>(self, location: L, value: T)
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
     /// register! {
@@ -773,7 +784,7 @@ fn write<T, L>(self, location: L, value: T)
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &MmioOwned<0x1000>) {
+    /// fn do_write_reg(io: Mmio<'_, Region<0x1000>>) {
     ///     io.write_reg(VERSION::new(1, 0));
     /// }
     /// ```
@@ -801,10 +812,11 @@ fn write_reg<T, L, V>(self, value: V)
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_update(io: &MmioOwned<0x1000>) {
+    /// fn do_update(io: Mmio<'_, Region<0x1000>>) {
     ///     io.update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -828,16 +840,72 @@ fn update<T, L, F>(self, location: L, f: F)
     }
 }
 
+/// A view of memory-mapped I/O region.
+///
+/// # Invariant
+///
+/// `ptr` points to a valid and aligned memory-mapped I/O region for the duration lifetime `'a`.
+pub struct Mmio<'a, T: ?Sized> {
+    ptr: *mut T,
+    phantom: PhantomData<&'a ()>,
+}
+
+impl<T: ?Sized> Copy for Mmio<'_, T> {}
+impl<T: ?Sized> Clone for Mmio<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<'a, T: ?Sized> Mmio<'a, T> {
+    /// Create a `Mmio`, providing the accessors to the MMIO mapping.
+    ///
+    /// # Safety
+    ///
+    /// `raw` represents a valid and aligned memory-mapped I/O region while `'a` is alive.
+    #[inline]
+    pub unsafe fn from_raw(raw: MmioRaw<T>) -> Self {
+        // INVARIANT: Per safety requirement.
+        Self {
+            ptr: raw.ptr,
+            phantom: PhantomData,
+        }
+    }
+}
+
+// SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Send for Mmio<'_, T> {}
+
+// SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Sync for Mmio<'_, T> {}
+
+impl<T: ?Sized + KnownSize> Io for Mmio<'_, T> {
+    type Target = T;
+
+    #[inline]
+    fn addr(self) -> usize {
+        self.ptr.addr()
+    }
+
+    #[inline]
+    fn maxsize(self) -> usize {
+        KnownSize::size(self.ptr)
+    }
+}
+
 /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
         $(#[$attr])*
-        impl<const SIZE: usize> IoCapable<$ty> for &$mmio<SIZE> {
+        impl<T: ?Sized> IoCapable<$ty> for $mmio<'_, T> {
+            #[inline]
             unsafe fn io_read(self, address: usize) -> $ty {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$read_fn(address as *const c_void) }
             }
 
+            #[inline]
             unsafe fn io_write(self, value: $ty, address: usize) {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$write_fn(value, address as *mut c_void) }
@@ -847,17 +915,12 @@ unsafe fn io_write(self, value: $ty, address: usize) {
 }
 
 // MMIO regions support 8, 16, and 32-bit accesses.
-impl_mmio_io_capable!(MmioOwned, u8, readb, writeb);
-impl_mmio_io_capable!(MmioOwned, u16, readw, writew);
-impl_mmio_io_capable!(MmioOwned, u32, readl, writel);
+impl_mmio_io_capable!(Mmio, u8, readb, writeb);
+impl_mmio_io_capable!(Mmio, u16, readw, writew);
+impl_mmio_io_capable!(Mmio, u32, readl, writel);
 // MMIO regions on 64-bit systems also support 64-bit accesses.
-impl_mmio_io_capable!(
-    MmioOwned,
-    #[cfg(CONFIG_64BIT)]
-    u64,
-    readq,
-    writeq
-);
+#[cfg(CONFIG_64BIT)]
+impl_mmio_io_capable!(Mmio, u64, readq, writeq);
 
 impl<'a, const SIZE: usize> Io for &'a MmioOwned<SIZE> {
     type Target = Region<SIZE>;
@@ -875,6 +938,23 @@ fn maxsize(self) -> usize {
     }
 }
 
+impl<'a, const SIZE: usize, T> IoCapable<T> for &'a MmioOwned<SIZE>
+where
+    Mmio<'a, Region<SIZE>>: IoCapable<T>,
+{
+    #[inline]
+    unsafe fn io_read(self, address: usize) -> T {
+        // SAFETY: Per safety requirement.
+        unsafe { self.as_view().io_read(address) }
+    }
+
+    #[inline]
+    unsafe fn io_write(self, value: T, address: usize) {
+        // SAFETY: Per safety requirement.
+        unsafe { self.as_view().io_write(value, address) }
+    }
+}
+
 impl<const SIZE: usize> MmioOwned<SIZE> {
     /// Converts an `MmioRaw` into an `MmioOwned` instance, providing the accessors to the MMIO
     /// mapping.
@@ -887,19 +967,33 @@ pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
         // SAFETY: `MmioOwned` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
+
+    /// Return a view that covers the full region.
+    #[inline]
+    pub fn as_view(&self) -> Mmio<'_, Region<SIZE>> {
+        // SAFETY: `Mmio` has same invariant as `MmioOwned`.
+        unsafe { Mmio::from_raw(self.0) }
+    }
 }
 
-/// [`MmioOwned`] wrapper using relaxed accessors.
+/// [`Mmio`] but using relaxed accessors.
 ///
 /// This type provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of
 /// the regular ones.
 ///
-/// See [`MmioOwned::relaxed`] for a usage example.
-#[repr(transparent)]
-pub struct RelaxedMmio<const SIZE: usize = 0>(MmioOwned<SIZE>);
+/// See [`Mmio::relaxed`] for a usage example.
+pub struct RelaxedMmio<'a, T: ?Sized>(Mmio<'a, T>);
 
-impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
-    type Target = Region<SIZE>;
+impl<T: ?Sized> Copy for RelaxedMmio<'_, T> {}
+impl<T: ?Sized> Clone for RelaxedMmio<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<T: ?Sized + KnownSize> Io for RelaxedMmio<'_, T> {
+    type Target = T;
 
     #[inline]
     fn addr(self) -> usize {
@@ -912,8 +1006,8 @@ fn maxsize(self) -> usize {
     }
 }
 
-impl<const SIZE: usize> MmioOwned<SIZE> {
-    /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
+impl<'a, T: ?Sized> Mmio<'a, T> {
+    /// Returns a [`RelaxedMmio`] that performs relaxed I/O operations.
     ///
     /// Relaxed accessors do not provide ordering guarantees with respect to DMA or memory accesses
     /// and can be used when such ordering is not required.
@@ -923,20 +1017,20 @@ impl<const SIZE: usize> MmioOwned<SIZE> {
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     ///     RelaxedMmio,
     /// };
     ///
-    /// fn do_io(io: &MmioOwned<0x100>) {
+    /// fn do_io(io: Mmio<'_, Region<0x100>>) {
     ///     // The access is performed using `readl_relaxed` instead of `readl`.
     ///     let v = io.relaxed().read32(0x10);
     /// }
     ///
     /// ```
-    pub fn relaxed(&self) -> &RelaxedMmio<SIZE> {
-        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `MmioOwned`, so `MmioOwned<SIZE>`
-        // and `RelaxedMmio<SIZE>` have identical layout.
-        unsafe { core::mem::transmute(self) }
+    #[inline]
+    pub fn relaxed(self) -> RelaxedMmio<'a, T> {
+        RelaxedMmio(self)
     }
 }
 
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index 79828a8006b5..d75f2fcf46f2 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -47,14 +47,15 @@
 /// ```no_run
 /// use kernel::io::{
 ///     Io,
-///     MmioOwned,
+///     Mmio,
+///     Region,
 ///     poll::read_poll_timeout, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: Mmio<'_, Region<SIZE>>) -> Result {
 ///     read_poll_timeout(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
@@ -134,14 +135,15 @@ pub fn read_poll_timeout<Op, Cond, T>(
 /// ```no_run
 /// use kernel::io::{
 ///     Io,
-///     MmioOwned,
+///     Mmio,
+///     Region,
 ///     poll::read_poll_timeout_atomic, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: Mmio<'_, Region<SIZE>>) -> Result {
 ///     read_poll_timeout_atomic(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 43284d9fba96..80e638a892d7 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -58,7 +58,7 @@
 //!     },
 //!     num::Bounded,
 //! };
-//! # use kernel::io::MmioOwned;
+//! # use kernel::io::{Mmio, Region};
 //! # register! {
 //! #     pub BOOT_0(u32) @ 0x00000100 {
 //! #         15:8 vendor_id;
@@ -66,7 +66,7 @@
 //! #         3:0 minor_revision;
 //! #     }
 //! # }
-//! # fn test(io: &MmioOwned<0x1000>) {
+//! # fn test(io: Mmio<'_, Region<0x1000>>) {
 //! # fn obtain_vendor_id() -> u8 { 0xff }
 //!
 //! // Read from the register's defined offset (0x100).
@@ -446,7 +446,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 ///
 /// register! {
 ///     FIXED_REG(u32) @ 0x100 {
@@ -455,7 +455,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &MmioOwned<0x1000>) {
+/// # fn test(io: Mmio<'_, Region<0x1000>>) {
 /// let val = io.read(FIXED_REG);
 ///
 /// // Write from an already-existing value.
@@ -559,7 +559,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 ///
 /// // Type used to identify the base.
 /// pub struct CpuCtlBase;
@@ -584,7 +584,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: MmioOwned<0x1000>) {
+/// # fn test(io: Mmio<'_, Region<0x1000>>) {
 /// // Read the status of `Cpu0`.
 /// let cpu0_started = io.read(CPU_CTL::of::<Cpu0>());
 ///
@@ -601,7 +601,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: MmioOwned<0x1000>) {
+/// # fn test2(io: Mmio<'_, Region<0x1000>>) {
 /// // Start the aliased `CPU0`, leaving its other fields untouched.
 /// io.update(CPU_CTL_ALIAS::of::<Cpu0>(), |r| r.with_alias_start(true));
 /// # }
@@ -638,7 +638,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -651,7 +651,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &MmioOwned<0x1000>)
+/// # fn test(io: Mmio<'_, Region<0x1000>>)
 /// #     -> Result<(), Error>{
 /// // Read scratch register 0, i.e. I/O address `0x80`.
 /// let scratch_0 = io.read(SCRATCH::at(0)).value();
@@ -724,7 +724,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -752,7 +752,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &MmioOwned<0x1000>) -> Result<(), Error> {
+/// # fn test(io: Mmio<'_, Region<0x1000>>) -> Result<(), Error> {
 /// // Read scratch register 0 of CPU0.
 /// let scratch = io.read(CPU_SCRATCH::of::<Cpu0>().at(0));
 ///
@@ -794,7 +794,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: &MmioOwned<0x1000>) -> Result<(), Error> {
+/// # fn test2(io: Mmio<'_, Region<0x1000>>) -> Result<(), Error> {
 /// let cpu0_status = io.read(CPU_FIRMWARE_STATUS::of::<Cpu0>()).status();
 /// # Ok(())
 /// # }

-- 
2.54.0


