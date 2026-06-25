Return-Path: <linux-pwm+bounces-9386-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hf5oCRM7PWqpzggAu9opvQ
	(envelope-from <linux-pwm+bounces-9386-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 16:28:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E2A6C6A21
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 16:28:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=ra2emgcz;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9386-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9386-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62B4A305ED1C
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7DC37C0FA;
	Thu, 25 Jun 2026 14:25:17 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022122.outbound.protection.outlook.com [52.101.96.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074637BE89;
	Thu, 25 Jun 2026 14:25:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397517; cv=fail; b=VdU3u8VhpxuvCEnb3ygn9vQLeCxtuyBPjuDd4HvXDuy/5MSHgzXtsO0PJoZbmJt1l9h19j4OU8XWO+5aoc/vNbS1WkNmcPuGZdGDBcYCVTO7kt5jUm42lid+lfsIVmMXXNI2BlLY67iCrCOxSuzZPif1DjszqQtxsWurzSgC3q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397517; c=relaxed/simple;
	bh=GABB4jdySqVAI5bzU3LtVYnehnzBMQGA/JwdxUW486c=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=FMe5rJbE6ikVKegTmgPvN6nYZl53htzKXks6MD2M8htuKtpy6zOyswlN+R427b0IMvShyE1gNvnSUKy2/5aHrtf/r9fHXKy4UrFWN+ze4XIjMS2j7MFylUm0pxGsS8khki5ZRVbDN9+6heouLbHqLooi5czOu8wYU1YDrf+rqcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ra2emgcz; arc=fail smtp.client-ip=52.101.96.122
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJmaZiD/x/MoLOuu3z543Z7H9Taz1gweuSwl+4y1wyzPuP0T4NF/z/6lniid3cMRlyPnTwNrp68tc8kdStlIUsOWUjT+e5tJUJIhIRtDv4xtU1pLcBUodrnAyZeOugRUy6Tbco/FuEHWHz5TuK7AZNzzQYK0kwt9d1nxhURSspI8M45quyR3tLa8lVrQX7vkcPnollVA/q3VqKyD6iSG29kTPnJfxzwN33L+DDPilZGPeO/Q5/fJSEBAD0XV/ZTSGeGrwcublfuuerI++5f4ei/gCnf92M9gVnXRMlh48DX2PrNb0+Y5l/nzWmoVrw+i/FMF0a+52M+sU3bfxhxcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fom2k2LUeiEkJAyVEJibELlUx2IASz00ax4g9qp8UKQ=;
 b=aJNq+fqeXpWAAe8Tu+aruo2hWfcUMygE2nyGo884moauiX/NiT5az/q330ECC7ojpOlEvDR+VpasVdvfgTwJnyb5fSl++COOan4nILBNJcaFD3Qi84+SxsngYpyt8vu3Wor/vUpptDLThOMt5+W+hlWPegfB4N/3PeVS4wZfTG6RYaHVC0i6NqouejXgdDHMiQbf65ouE65IP5Bo9HUJx4iWKcsPYt50HG/R3a//I2BRc3Nhe1D6EDrummqhDVkFQdvA4eHTtI9agBnDXkBf8kuiuoeh4I1r3ZE8VuJL444NKwouwE7qKM8OZntfzubmv1xVFJzvV9hNVMG0Jf+5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fom2k2LUeiEkJAyVEJibELlUx2IASz00ax4g9qp8UKQ=;
 b=ra2emgczemxsMX3WuPSeq/PHC8bTB8zMZreAIc/U4cSX2e3KDVmaWTT2At7tmSG8A0owiLv3w2cRjF4pWUTNhl1hsf/Ax6Mo4LwsdBzXl1QipNueVIyeof9cCW3Ck73SUMg3KkN0R5xrEXCCJUhJay6WTV6LSV9u+7EtS+SNVVs=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB9099.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 14:25:12 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 14:25:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 15:25:10 +0100
Message-Id: <DJI76OHFA8P2.1VDZIM80SRLOS@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] rust: auxiliary: add registration_data_with()
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
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-4-dakr@kernel.org>
In-Reply-To: <20260618230834.812007-4-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d90d72c-71ac-413e-6724-08ded2c590cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|10070799003|376014|7416014|4143699003|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sDrCVb4pQcvS7wgEMF6nkiW07nhExmijR7MMdW1UWnQFIjTTP3jtAXROzTSg3gWi0PYJIIOsBRYb8tzhw7ZyiZhr0kVyEzWjW6Yzc7kQEBYnByOZcjP83ln98CIA+H9GsYnOnhWvzC+Cj6MNaMmPnHERAzEtvz2qliUaAFSOqNFfXkAOFWcCK0XKtCR6KqiAdy3ghNSgD5TedqOIApxGuxuBQRjVnngLskJx3URvfVwvNOVbvkMUq0H8uQP9EaKbPn7RWWSpgs1Uzi6ecZMrdk5HBPNYb0H4G0x8t2oj56nUn1palTSGzE+BI/POTZ1UWHK1k5XMoE8fW5MfRf0T3HbZ5MUMNsy8ABMEMY9UxF5f17/S35j5l9tNajOfyYgikbZjM1E4fxuFqEdlr5h5NAv29DZLLxi6fL4JddMsyaqbAx7OWGNIJcJwy6lFlqso85LC8vnrPyY3lv9jegevbI0B0LR4D2v8dmKjGmNhAwmufL8KqresZa3N2u46sl9IIgpKu9vXnE7PDuG0WgDDHB5HIPtVPl69eSHkih8TwjlzfSMUNhjtlpI8UZ3ShrURoBFfAWiVs6o8GOtpLWzlXZPr/jbEtGjcR1d33gubOeF2Kukl/N45chT7cv5wXSEQrO7OXbzGUMYx13kaqK7LJ7glxGudClX+fn5j2OEu1olU7TICf0UDm6gd+jfeMQQAseVjerAqt6sKG2rkjzi4mA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(376014)(7416014)(4143699003)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVRMdjk4OFpjUkhmTE80MnJjcG4xWXI4aTBLVkNsdWtrN1dzbHJMZFltRkFy?=
 =?utf-8?B?NTc5VEFLMW9kdTRKMm9zSWljNGgwOFlZaFM5UFl5QmxuN3F2M2pRU2MyQ0hY?=
 =?utf-8?B?RHJjQUJudTRnMG1weTdkMm5GMlA1RUNjSllwWVNqby9lZlMxMDZLbjhST1R0?=
 =?utf-8?B?bHNBeGsyTHk0cU9SYjFmSE11OGF4ZjRrVWJGQi9NUGRnNGVwenFtRHRiTGVJ?=
 =?utf-8?B?TUpTN0IwUGZzNGhQd211WHNVSGxpeDNJdlBrTXVQc3lkTWN5b24vdG52dThv?=
 =?utf-8?B?MXMyYm52b2JUdWI0emtQNFlhSzNvR0h0ZTM4dmRRZTJpSWhTOXVxWUxyMStZ?=
 =?utf-8?B?ejh4aFFTZVBKelVpenFzUkRja0JOMWlPa3VoVVdYeitkQlJsUzdxditCZUwv?=
 =?utf-8?B?YU9wVjlNM1dBSXRUeDVzQWFwcWFwZTFxdHNjVUFQdmU2cjFuUkt2NTFVK2Zl?=
 =?utf-8?B?d2lrMjk4eUhYbFV5MkcvbVpWQkVKWGJCWEh2OXZKbnFmam5SSHNZUUNpRzY4?=
 =?utf-8?B?dUEwZWdEM2hOWVkvdHNaR3NEeXFJb1B5Z1Jyd3V2cElrNXdGN3ZJUHB3VGhu?=
 =?utf-8?B?NVhQQ3I1N3QxVGNsME5MeGJOdWN0RHVXeU1aSWsycjJabVFVVERpRDBvekZw?=
 =?utf-8?B?dXdEbzZrOTBHOVA4TiszaXNQTlEyY0hyeDd4L3lqSnRBbmJ3aVpGaTZUUGYw?=
 =?utf-8?B?dFNlaG03d1A3SDllSXJ5Q2lqbVVzd1BYekdpMWdRNlRHTUhlNkZ1ZlZqNHBp?=
 =?utf-8?B?bHpudHpKWXdZYnhpZkVWcTR2bHU0RlJZYlVYOFVPQ0tGWm1Qc1FDMkpFRm5R?=
 =?utf-8?B?NTV3aFkxOHR6V1RjU29nMUF4NW1EYVhHUGR2T2tNOEN0Y2owT3RZUGFKVzg5?=
 =?utf-8?B?c3NkN1d5aDhlbWw2bFFoNSt0TG9qZkw2aTBCU3NNUWc0Mys1ajY5WjFqalRM?=
 =?utf-8?B?YVV3U21KTExFZWVmNWh5cUV4REluTUx3dmlTczdjRDNKNnhIRlRBT3NWdzc4?=
 =?utf-8?B?Sk5MMFdVSlI2aFJFeDJOMURZVEF4TGNMMXdzaHNQYWRvNW1JcDh6OEt2WEcr?=
 =?utf-8?B?bzF4eUJoSzFEYWJHcCtxNzZlaVIxRjVMNEdiay9EMGVJdTZNNGNGYlE3Q2Z0?=
 =?utf-8?B?ejVGVEMvZVpoVjZyUHh5SlZsOEpKMSsvM3VtMTIyclJxU3ZFeFQwN1FRZXdC?=
 =?utf-8?B?UzM3TG9MaFlSemNOTERzZzJGTm5GUXV1VDBuSTdsbVRHVmtvdWNSZ1pkUlE5?=
 =?utf-8?B?STBnTklDeXh0cnQ5a3pGbGlRSGhQdzBBc21OZFNpcjl0Y0J4UzJ1QU9JVDk1?=
 =?utf-8?B?VE1iWnJvOVFacDZ2c2RBejVMQ0hKK0RON3pyVWVQanVWVTBsYmtEZnQ0bmht?=
 =?utf-8?B?U3FLdks1Q2FnM1QzNnM3R0hIRHB2Yk9qNEhVZ2FWRWwweHUzd0s5U2F3MTdZ?=
 =?utf-8?B?bjFPc3FwTkJSZDRjZGxzMW1OQk1qbkZoOWdBb0hOZi82SkxPTjNsdmwyNGw1?=
 =?utf-8?B?WTNlb3NJN0pFaWMyM3FSMnA4RnhsdTNML0FQUW1UenNBQ0FmV2c0YUVrdUN1?=
 =?utf-8?B?cWM2ZUpvNDRyMmNpdzlHR0o0bEhaZ0NHeUFJQjlKcnhFcVhDTWh0WjltQjN5?=
 =?utf-8?B?eEcyWXhhTGg1eThzSGRhQzYrMHBUdmFaUTZXUDBvVkUvZ2doK1VkUi83Z05W?=
 =?utf-8?B?bnJ4d2UzRnBhVW8vNDNpUFppMDQ5bTFIQk1JbXJCZ0NHbms2RlNJVUcxV25X?=
 =?utf-8?B?TXU0eW1tazQxby82ZHV4U2xGYkIrWVJqR2djMDF3Mm1RQTh4bERib0pzdTdC?=
 =?utf-8?B?dUkrVGVCRzBHUUM5d2E4Z05USFlTQlc4aDVXYXFBSEZMcGF3aWpTZU5KN1M3?=
 =?utf-8?B?cjN2VTBkVTNaSGdOWm1KM3lGcS9tOFNTRGJJSlVIMGt2OXlJRExkZWthYnVM?=
 =?utf-8?B?UlFxZ3JkSXJzbmRNcFNJWEt5NS9HeUV4eFVNK0YwQzJtWXQweHFDc1RuZHFG?=
 =?utf-8?B?eElWQ2xVMUIxMVN0RW0zTFJ6anc3NU5STisxZTdRVVhQLzhMVjFXQkhyN1pN?=
 =?utf-8?B?Vit4N1dhSGRvdXJJSFhMMmhkeXFSaktLeFpFZDd3S3NRb0lsZDV5aGtnRlFT?=
 =?utf-8?B?dm5iQ2EyK2FBcnpUWjJQMzFidVQ2WDBrSHp3Z01Ja2xkWXhrMDdndjZzdDVP?=
 =?utf-8?B?S0c0SDRzUmc2TXpCaCtxWGlFV0M3MXF2Z3RGeHBJa3ZBVm9FZXMzS0FZc1dE?=
 =?utf-8?B?aFo2N0duMDhXczBpT000TThBcFpta2dWU0FUMHE3cER0RTJDQmZuNEd6VzlZ?=
 =?utf-8?B?WkJCb2xQcDdxQXl3Z0lJem9ReklZMmZoUkthNzIyclBGTkVOdGtzUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d90d72c-71ac-413e-6724-08ded2c590cd
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:25:11.3926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMRzVZUwHyWP0S3ZYVErOxAr/BAOE0+VnTMk+ISFniSx1KxBX8ptY/9khs1g6przxtK0h37RMCMSckj/SMR43g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB9099
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9386-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4E2A6C6A21

On Fri Jun 19, 2026 at 12:08 AM BST, Danilo Krummrich wrote:
> Add registration_data_with() taking a for<'a> closure that receives
> Pin<&'a F::Of<'a>>, which works with any ForLt type. Taking a for<'a>
> closure rather than returning a direct reference prevents callers from
> choosing a concrete lifetime for the data, which is required for
> soundness with non-covariant ForLt types.
>=20
> Extract the common null-check, TypeId-check and KBox-borrow logic into a
> private registration_data_pinned() helper shared by both
> registration_data_with() and the existing registration_data().
>=20
> Relax Registration's bound from CovariantForLt to ForLt so that
> non-covariant types can be registered.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/auxiliary.rs | 91 ++++++++++++++++++++++++++++------------
>  1 file changed, 65 insertions(+), 26 deletions(-)


