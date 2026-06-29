Return-Path: <linux-pwm+bounces-9464-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OZV0IxluQmro6wkAu9opvQ
	(envelope-from <linux-pwm+bounces-9464-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:07:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 009D56DAC3F
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:07:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=iEqpYhwL;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9464-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9464-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 578A431F0055
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F98404BF3;
	Mon, 29 Jun 2026 12:39:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020122.outbound.protection.outlook.com [52.101.196.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F303403AE5;
	Mon, 29 Jun 2026 12:39:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736789; cv=fail; b=BJ48KuSga3rXJFMlJHrSENoYDBLLKQ5EVf59aQ0zXCrSorC4cKKlBPjpNnAuMTp7mb1d/UWbNn4oCKVZIn/ksRhCkTR/xnJ1w9qVYsDsrDfz6XxIOBK66ZVeTT8eF4HflWrksi6BEygQj/OtO3Z/JthuPCqrU1TcgjPVCgayxDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736789; c=relaxed/simple;
	bh=EaiIK7mJUxsKKAaPSJP5dSMBvLBsngcCBY7JKZZlemw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hH+NAGup3/GRiLNiFAJKM1KLN+wl5LDbTGc1eXBJ00r+iwJ0QGp5DGpyQB+8hDem5g2ay6Nl19vPpJbgq3Sa+dJDA381OR1HMeVSk57vVARMRvrX+SIrUyLy+QQuw4H5hhzyYIe45wqImcSl4vJUTQaxHd9QNduNSWUMFvrVaWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=iEqpYhwL; arc=fail smtp.client-ip=52.101.196.122
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj6fuMeF/0ul/OULnokpEMrS1ZXibxvfN3J+94bFbAT0lTYlCBco2j/LOaJo23rQAwsLI2HPapdUHCJZ3/EPXhde0667LfPDS2OGjNYUzd93lo4qt9zLOBLppB6WEFzMPWFei7AmylkrrvFW5SwE62OTvtR+Uy+tzDAVo618CDbHMNAg1khW7wL3tf6P6y5g/nAw1pmT0Z94bEhrCTlxph9eiEBI7lhZXdThDWm7h+LmaSD6fXy4UQKkdsCna0NrMz4ZAxHArRsxRMIBv/DJo//9IvYLMolA48BCOWX9rCMu51hwVqg24w9AOv+bXEzsJKKsy6O+uKx1CojC1cZ3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/zVxBWtCknBlZRaTTNkYFsiBZhtA2stuzb7apCX1Jc=;
 b=DvgH42Zt0wP6AWIj1EFjnc9llPDQRv5lvvFWomq81+qKDCDSE+8XwCLePC7dkFIGL8O9zV6stWN20U1oJj2vXxcZ1/L1rnEx5WKF48HCXZM3IfxuEUNXRLnABjTM4g1iYhzpx5giweV8C6/IAKKko6rtpZKjlKXa2Zrm3GvYNJ9H6+QuHhYHFm5QGc3DA3IokF45LLcMuW+yhn8j/knzTwyOJmFcHekHiNCdQZnurx8Q2G2P5GD9z3HrP/GwPuuQK3Utdvv2x/7enKmaE0HdirBNCKM10qFyfA7KeY9W+PShZQZu/XTg/Swmp9WNSsYZ/Jhbp/Y9CghF0mCHlwFnug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/zVxBWtCknBlZRaTTNkYFsiBZhtA2stuzb7apCX1Jc=;
 b=iEqpYhwLtf5f+siAGieSH+gJRwClG+uAw8bpy+N8dx+GbFgRPrdKZh1mV1/6O3uE3hsVRuR4g01SYcOWCLgONyxYe6lfxSjVcaP4UusHZ5ax0hhBC+g8sUPJwkd6ffCsUr7bW6sxP8iX0ESNVa5W1xJbnUK8xfP8d/QK3f3tlxw=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7414.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:39:42 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:39:42 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 29 Jun 2026 13:39:38 +0100
Subject: [PATCH v2 04/11] rust: usb: use `Option<&IdInfo>` for device ID
 info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-id_info-v2-4-56fccbe9c5ef@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782736778; l=2545;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=EaiIK7mJUxsKKAaPSJP5dSMBvLBsngcCBY7JKZZlemw=;
 b=NYq+Hy8DAqTYaN19le6JV4pYNc+T1whjdViasW5wkNsC/C5zPDMKKKCL7u0oGTB96a0i7a8gs
 nZUXzIK6SseC1Xd1uj3TC5xU+G8sYcg6ZW+zbCIXeGggl/9MZSwMS1G
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
X-MS-Office365-Filtering-Correlation-Id: 52838ce3-7a14-4778-f29d-08ded5db7e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|10070799003|6133799003|921020|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	31Exp6v2FJGMW13CG5uwXnIb+vKLO011pWspCzkeWtMqWtmT9owdxJQ9dyjcLpNr+BB13FUpjGMWWkyQCAq/KRug8A2NZet7Ze0+0835vKNN6OVGVCoizh7Zgk6JxE55BygD0ysQbLBfQE7lTIpC3afdD5aPkPKwIdZ0LTDONZrdtO5dHB7t2j4+ErNd+rZX1jhbFcu9JNep/nB3lidnRd4+QlPca1YCmnXCv84ZM5SG65HDYmQ7dMY0eJNXmMhYuZVxgJsoTLHPBgYNYAT675kmHj85pYWA1V0nkF9vDsv0W0fGhJxjCprw87IHBjP654C+jot4BCMWTXZ2V308lTFOOUrhp3KO8qTkCt8/h48pi5h5j9Teuuersdl8e6FFSjKw2rrmrpd51j1B1x77eKTnckHoUdROZ6xdMCZ68i2pjix8FSUwTw7u7uFCriBnkCVlZkHOndQBkEugJ8K7SEFdbmzh+GxERSCrw9NFSDrjbGWjo/Q0HmIvMtMyUy6TBjNZglVgotMK2N6fjIFp0spsJC8CJGVEQkYuDPuHmb+4a+dN8aaPnaSm1NePF2qYtgLCSUkC8bmePGK8OJej6DfkX2kBRRcvi1yXYTIL6X6TZk2BAjw0Abz6xfb0ANiaX6ZPI0XMBB2WpO7ZGaqbxLisUOHoBTPgqPhkxlOAw2GuOz3ADY4jJOHrLLv3xwbhefDM9WccdyyD8PCNiEQSUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(10070799003)(6133799003)(921020)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVROQmlBdnFoNldRc2FzSSs5WkFkVWdKTnRkK2EzbEIxYldGVG5DL3RUYVZl?=
 =?utf-8?B?bE9ycFdlVXo3aWlMcG0vaUNNbzc1VC9BTWNNMUxmYUQ5ZzRSNURaNFFQTXJt?=
 =?utf-8?B?dlZpRGtZWFNyelRwV1d0U2wyMzZmdUpuN0lnbmh0SkJvWEJjdGd3MlZ2bncr?=
 =?utf-8?B?V2xzQ1NLOXViQmk2SDhXbFJuWlpoQ2dmc0JyV3Y4am9hSGJLeElBRFpUSDIx?=
 =?utf-8?B?MWplVFM4SnJoeUdxZWtReGtsQnR3Q0t5ZHdrSjJieDFtU295Ly9PSERMYUZM?=
 =?utf-8?B?c1dkVU81WEVwMGxtU21pU3pZUzhTRk0wVGdRRG5jRThzVlBINEFDcE52UWpC?=
 =?utf-8?B?aUFpbzRObit5bThobXRaQ3BocHdQaDFkUjhEKysvUy9mdlVqVlo0ZVFjV1JV?=
 =?utf-8?B?RWJxaXAxb2kwQzZXdHZFM2s2RHkxRmJlNzRJKzhuSzJ0MEM0ZEROK2hOWHQ0?=
 =?utf-8?B?Qm1PVGJvd01tRXlPVWdTbUdyKzFEWG5uMjljaHZ0eU5rL1B3Z1h3ZG1qcEtI?=
 =?utf-8?B?ek56eVdaYlFEbmNUTHg1MU0yaVpBeXZwOXdERlhDRmJxUzU0OWlGR2o5dEpE?=
 =?utf-8?B?aWxuWmwvRFVPeXhITDhLYWxvdXpaSjRybVZXT3lubkNNdkxMMmJtUmk3OGd4?=
 =?utf-8?B?a2xsWWlaR1pqMEFrRGVEdXNOaHRreHVta2grVTQ0M3ZOTW5uUWJBekxTbi9X?=
 =?utf-8?B?NkI5Skx0eXhyalFBdFFlYklrV29UeHQ4UjJBcHZFR0lnMUxybFBOY0FneTJk?=
 =?utf-8?B?Q01tN1F2WkhYaTFBNklZYlh2TGliWW5teGlmZkpSOGQ2bk43ZHhhSEo1cHdR?=
 =?utf-8?B?dVN1WjFJRy9aMmtFRGZrK3NLanBhRmVvbFlrY01DcnVqajRtZk5JdUQ4Q3Rp?=
 =?utf-8?B?R2JHT0tvYjlkTEhrMTNZaEtWOHBCek9ady9VMkNVNFVxMUxNMHFrUTBjak45?=
 =?utf-8?B?TUU3RTM0bGVGNHR5cWYxaGVVN1d0U09lci92WWZHNy9FRE82UXRXQlhhTnR3?=
 =?utf-8?B?YXhoLzd1eFV6SWFnaUQzeHVOdlFLeVp2cmNuejZQQXBHM0M5dGRVNVFqYmxM?=
 =?utf-8?B?Z3A3MnN1V1kzdmo4cjhTa1B3YThkcEdwNDFqNkx0OVFmVndZaU1OSHR2aDkv?=
 =?utf-8?B?TEVwc3VLQmxPR0JiTURGS1hKRDFNZ2lFVDRqOEwwcm5KWnBLa2F4MEFXK2Yw?=
 =?utf-8?B?ZExoemxLQ21VWnpnMDQ2ZEl3Snd4SWZHa0xjRm9oSVFjc1EvUHJCdG5jRHhK?=
 =?utf-8?B?YldEZnBOTm91SlUrMU82UlYzK2UvaWdSYkhDc1g5VU9CcWw3WW1TQkMzN3k3?=
 =?utf-8?B?aWEzbE5UUVUwUWwxOXVUQXpkMGhaL1ZoOHlhTXZ2R2ZwYnFKTHVnNmJwdWhD?=
 =?utf-8?B?Uy9Oc0taSm5LY3Vjby9oQVhuS05rS0hWeEx6U25qcTBzRzRZSmhXdzRod1Ir?=
 =?utf-8?B?UE5ZNzNaMk1IN2ZjV2lFbUdJOEpHK1JPMXlzSjRuUTBIa0FNeTRjbHhuRm5O?=
 =?utf-8?B?MnlBLytzWkdraXlibFRxT01LSmdGZzl5SWNMUlVnazNheUJJdDFhUStTc2VK?=
 =?utf-8?B?eHdlT3BwQkJUeXFCckcvcUM4eHh1OWpZSzZyVkVFblF2ek9CamwxL2RtNVlN?=
 =?utf-8?B?Y1ZXRFpxRVBSMEppaGhIdzlwMy9JVE5xSndycER3WXVPNmI2Q1pvZDVDc0tJ?=
 =?utf-8?B?U0x1K0xGUE1aU0xYWjAvNlJlVWhYYk5xOXdPYXByODNsNndBeG9XVUZ2ZWRw?=
 =?utf-8?B?MnF4S2p4ZzJCd3h6VkVlcW1rckN3S2Y1R1c3M1pSL3lvUUJ0VlhGdlp4K0Nq?=
 =?utf-8?B?MzBRVFpvbyt4TDNET2Q2Rkd3SHRXVnZBd25GWUEzMWx3ZG55WExOZVBQbFU5?=
 =?utf-8?B?Qk5IaEJialIyQnFwOHo0eGMwWXNRK2ozZ21LM0JDeUlsMHQvMUNQcHZWQU9i?=
 =?utf-8?B?ajJYaW5UTkVoUW9FRzBGWkRSV3NLS3J5TE95cmRtVnc4OWdySDJveHpPdnRR?=
 =?utf-8?B?SFJJbmlNaEpHSGkxVXBEV2U4MkJkSStGUWU4R3RzWjQ1OFBVTG50czJYSUVr?=
 =?utf-8?B?c1cvSDhoT0tuQ25EUU9EN0xncm0vaTM4RVRsb0hMK3Z6QTFadkdBMFpodlRQ?=
 =?utf-8?B?RnNNVS9KbTZaMFZ0Z0xNZjErMVFyTSt4ZzJiUDY0Zm43S3ZzaVlWMmRrNVZv?=
 =?utf-8?B?cDJZZzFrU1FjcVlxRXl5N3Fod1pSLytCeGY0REFMQ2t3UFh3dENQVjgwY094?=
 =?utf-8?B?VnZ4WG5mckZRdThCeUtHOWtPZHZuWUwwL0hvRFowZjJHanlxMGtVL0pDQjFl?=
 =?utf-8?B?S2JpcVNaUWhuNENYRVlPWmcvUDdpRklzNFFxeDFZbVVHQTBtVmxDUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 52838ce3-7a14-4778-f29d-08ded5db7e21
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:39:42.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftkeTZWtieU789burGU2WFredB4mejJIp0tm6NmkvcqKyVNuQYjC2U/UczoVm52Tgn1E0YrFaqS2oRYmdAFBAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7414
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
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9464-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 009D56DAC3F

It is possible that ID without driver_data will be passed to the driver,
e.g. `new_id` is used to dynamically create a new ID without data.
Therefore, the driver must be able to handle the case where `driver_data`
is 0. Thus, update the `probe` functions to get `Option`.

The current code cannot tell if the info does not exist or is the first
entry; however this will be achievable once the code is updated to use a
`&'static IdInfo` pointer instead of indices.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/usb.rs              | 6 +++---
 samples/rust/rust_driver_usb.rs | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 7aff0c82d0af..6750a49e466b 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -90,7 +90,7 @@ extern "C" fn probe_callback(
             let id = unsafe { &*id.cast::<DeviceId>() };
 
             let info = T::ID_TABLE.info(id.index());
-            let data = T::probe(intf, id, info);
+            let data = T::probe(intf, id, Some(info));
 
             let dev: &device::Device<device::CoreInternal<'_>> = intf.as_ref();
             dev.set_drvdata(data)?;
@@ -293,7 +293,7 @@ macro_rules! usb_device_table {
 ///     fn probe<'bound>(
 ///         _interface: &'bound usb::Interface<Core<'_>>,
 ///         _id: &usb::DeviceId,
-///         _info: &'bound Self::IdInfo,
+///         _info: Option<&'bound Self::IdInfo>,
 ///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
@@ -322,7 +322,7 @@ pub trait Driver {
     fn probe<'bound>(
         interface: &'bound Interface<device::Core<'_>>,
         id: &DeviceId,
-        id_info: &'bound Self::IdInfo,
+        id_info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// USB driver disconnect.
diff --git a/samples/rust/rust_driver_usb.rs b/samples/rust/rust_driver_usb.rs
index 02bd5085f9bc..176ef625ed75 100644
--- a/samples/rust/rust_driver_usb.rs
+++ b/samples/rust/rust_driver_usb.rs
@@ -32,7 +32,7 @@ impl usb::Driver for SampleDriver {
     fn probe<'bound>(
         intf: &'bound usb::Interface<Core<'_>>,
         _id: &usb::DeviceId,
-        _info: &'bound Self::IdInfo,
+        _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self, Error> + 'bound {
         let dev: &device::Device<Core<'_>> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample probed\n");

-- 
2.54.0


