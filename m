Return-Path: <linux-pwm+bounces-9170-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP6bCFTwFmpcxwcAu9opvQ
	(envelope-from <linux-pwm+bounces-9170-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:23:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2195E4E00
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38D4A3037F5D
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89FC40F8D0;
	Wed, 27 May 2026 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="uBozm6ni"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020088.outbound.protection.outlook.com [52.101.196.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74440C5C9;
	Wed, 27 May 2026 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888158; cv=fail; b=BHAxylWPtPraWyVb0tT2IdwqB3JRDEwTfSFGS+ZBrnV7wM7WG+h0GLnA6egxaZctQgkoSXgHLGWSca8phoDSdtNP2nCFQ7T13FHOaIl/BQ6IJHPZDP4FBNvfWiopYjGsCECTT74faTj6rWwuQUeLjmd9gaYOQhM45L7HrMLpnoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888158; c=relaxed/simple;
	bh=fdYA1mPcVhKlWWavZpsk2ENEIrSMaVn9ojXK2XydXL0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=fH+7cYVwYS+IQaIiJsOB3zrG7Wu7eq98hD8yEm+x60KenvKxOvhwwDxEqwidtR2hh9ys1Mxa+kIoBACJTkG7K2o5iOe7xtcBm8Y1tF5vZj+bJfja37Sdava3VHj3FLMabJATDjxdZk0kShFUCtvD8v+YKyGcOzgaheZW4hxO+M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=uBozm6ni; arc=fail smtp.client-ip=52.101.196.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIO3BsnQueuQX7jVC5xKFD7hyihE23l2sjBXYwt9DK0PqkgnK9Gw6fpUNLu1vBP27719fHtWw/JOFdlmHXTRN6V5ga+bSeJ8XiEh6SETqD9+p/SSzZOx461+ZmEZcYFo0OErdibUjeWMIx0VVY/oA6iHsGgS5VZyAvkxuIAKGhMQDpLTMpB6yvas3A595JrxhP4U4BWELsDwcyPONT6RZ0umhz6yqw2H/ppyfzkrzBF9lhuiqShYJJktNM8bkIIfZ4asRWIWdytkPHJn5Q8mOa/6eVSNEiYLCrJ1jE9NZVxfwkUP7d+Fph1sxe+gpSPsV03FGfbKLM5+dWFfrGzsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3OJeDzPSHoxcmHK/Tnx8Z177zM/41Kk96C9ST9A1II=;
 b=KrB27uMAzoJSWIOlJflLjs7KQNHrbdAcZzrxT4+wzQWYIODQ4L0xVjlQsMlZkuvkm6eVeC6HPSHKM2D7KwJSiUYQIN5C7vkZoOtDXbgonhE1iwahI+aIrgDxN3smIg8vhRClnOjxDrxrTxkAvrDwgfCSEJPtMYaCYPGDrqsMA3LK9ZHa13AEY/xrMwkuZHFonvQRwvVBcgwKXvnIvZ6Y3aY3w8rOZHtBg8+TMp/4otjhrpu4flEH1nohquPzG3TjLnCP60IjYo6EpNvELC+tSzpxc6SvahCwczuz4tEEGaKxP1ms19/G1VeMlq4RyU9IlMv3NwjKCEQiVSzbA7mv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3OJeDzPSHoxcmHK/Tnx8Z177zM/41Kk96C9ST9A1II=;
 b=uBozm6ni4tPwDIyj6N7kcNsFGm+5fvBPhrMUZi1JUyU4v0z3oQrkK2SG47vVnKT1rUSIqMaYXErIBV9pQY+FCvxndNDoWFX8AXUAKCtWIzLldFO49sHxWTV37OHWStFikSlHw2qFwoZD/S71HgznWnZ7z1zhxNyzC1LFBsuUlsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB2208.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 13:22:34 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:22:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 14:22:34 +0100
Message-Id: <DITHOXX5S3Y1.MB3TTAD1DIYX@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 14/24] rust: auxiliary: make Driver trait
 lifetime-parameterized
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-15-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-15-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0409.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB2208:EE_
X-MS-Office365-Filtering-Correlation-Id: f423a401-0ca7-4313-2dc9-08debbf303b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	euHCO+PDI5eeDC/EjP3cevJt63m/V35fGIjvFVlg8yY+nEQuomg5/2YwWr7d3i8ithLyMIw2AJhiwtPibm2Izj0T0z29uzV7mNzBhXPtkz1a86RM77a2oYgm+vAr10euoxdOLaVnSvWWvgyOl15AqduH/x4whyz3sWn2avTKHEuuXCIEdHnbQgwL/aWAgUhuaOSaFLvDOWZkRJoHdS/V6n6q7ZYBm9UXjcieg6T5O+XE7CgBdA32eznL7QXZNHRPtiyojKgS/SqQKNKYYYxGQUD1F7DCvTCjeZllutWx7NZJmHgKYjXVct3LyJ96m0basMldOPspBJl6RzVxfj3d18CjWg6JbccxgZj79GnltjAwtNkrWXpJlHec1UsnRixgmHUBdkHX9r1n/jfwmpRqQ7kuvR6QRxyjMuRuOruYFj5MIFmpDTElwwcyEOY34k1xCiOLjb+ikJm2mGumoYwmDoxJrw0QhxGGWlfU/uSx7d1RXCzQwlre8+7WpReNJtAywNgHokTOqWW+6A3ATr9xqH932Sp6nBBPGN5o5ciZwZ+aTIKL4DCYgWXfrQEj2PLEs2c199aqrkGA+qvjqcgXC0SwGiYRA0QhDfm8VO0Mt3gdJZbV8wZc9R4+IsDliO48O0xUGW6Z8Oq1KuJ3HH5WGpYizjAWLZ0K3v2/guX9jNITZseSVrL1WI2VOKHA2Z+CgyvXyCosQEGyr7rWLoXEZtY/CAY5YphFf0ByxLUk5Io=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2hZYUFvbDRTbkNpNFcvS1kzZ0NFNzJKd2hldFBCTE9BOHJlVnBKZCsxdUhS?=
 =?utf-8?B?bnJMenhYdlRLYjNkd0o5VHVRcUdNVndaNENuR0RpbGxaMWV6R1ZMRklyS1F0?=
 =?utf-8?B?eEhEemtwMTNoaUtqcS9ZNVFoS1Vlcyt1KzNnL3R6aFJuQ0l4L1NDOStpRGVt?=
 =?utf-8?B?RTRKbHhZckNYenpqSUdIMktpSjlKeU1GTk9EZTFFT01YcHczdTR5TGNURnpX?=
 =?utf-8?B?cGtmeFhIaTJEZitPa0J5cU93SUlhTUx6Wk1EeVJTWE02L3V2WkVqc21XNEh1?=
 =?utf-8?B?RmhuYUJCVTFHTklrTmE5LzhBYklkc0Nzd1ZpM3BEeWlpQTA1bEhUUndTZGpy?=
 =?utf-8?B?bmpkb1JrTXZWNFFmMjFSVDBwQ3orUVdFTkhCT3NxOU93eVY5ZVZJTkVteUgx?=
 =?utf-8?B?Mk04dWZtM2pUSDVta2NqM0dEb3FYMFpJK0UyM1lWRTBEUkZDYVJxeUhod0Zv?=
 =?utf-8?B?VVRCelhwUnFFK3MyNmxEVVd1Mzk5YW5KNEYzWTJpZ1RvOE5zOUxKbFgySW1G?=
 =?utf-8?B?QmdCc1JuUmVtcG5oWlpTNFQxclZqd09hS3hGS2ZHTEtXUXBNcVhRSis5RjhV?=
 =?utf-8?B?THoxZmJXcE8vYVBCRW1ZNTRFeFIyWEZwRjB0THh0eUJVRzlEemx4SjBzQTFs?=
 =?utf-8?B?WDVyZ0ZLSERpS1VuallFcDlOSmx2bVlyRGtIUlk5d05sa1BqSHQ5K2tuSm5P?=
 =?utf-8?B?RjhoNHNhajgyOGo4cG5uaU5hU0QrSHF5TEU5d3FobUxwMjM5L0pFRnZRVEdu?=
 =?utf-8?B?WE5DWE95cXJ4WnB2V3lzdlR6SFFTa21UMzVCZzFFUlMxU1R1SHQ3eC8yRW55?=
 =?utf-8?B?ZVMwelFnZ0dhcUgzQVVDR2NvUU4rNSt3ZGpiOGduNlA2bVV3K3dYd0lZbDFW?=
 =?utf-8?B?aDZHa3B2dk1KL1RzeDF2Z0pCZUEzYTE5eVZvemI1U0xYYnpwZERuU1VvazNk?=
 =?utf-8?B?Q0w3T2M4NlhhZ0pZSWtqRFFZZFI3d1VhTFpTV2h6ajJjRmUvUit1dlk5TDJt?=
 =?utf-8?B?SGpjMjNGaVc3aHpocVpXcjlDWmNlVWt5UEcwUGcyUnVuZUpsYzFWSmVyZml2?=
 =?utf-8?B?anJCaHV5emlSVG40cjc2SWk4NzlmeDd3VHRadlNtak1DUjZlb0EremNiSmxG?=
 =?utf-8?B?eWRzT3RkS3VKRFIvNDlBeUNkeXA5YzFlNFJtWS9GK2R2UFh5c2hXd1JkaHhE?=
 =?utf-8?B?aFA4WTZlZm5aQ1FXYzNGS0JRV1FtY2YwV29sa3RMQlpyOVlRNHRNcFBjQkVy?=
 =?utf-8?B?SC9tREx4YmI0anEwTGh6Nkp0OG5Vc1dXMTVPZE5Ba3ZIczNYbFZ1VEhPU1hG?=
 =?utf-8?B?WDd6bWZ0VDVHSm0rV0xYWmZlM3I4ZnZET20xdDAwZGt2U09pZElSNW43V0U0?=
 =?utf-8?B?YUYycmMveUxPaTIzRysxK0w0d0tCZXI3RFhmbjZ3Qkx2K3pUK1JpV2xXNnZu?=
 =?utf-8?B?SjVUSHVlTEVmNWQ0T3lSa2orUUwyQW5SRWQ5LzRxamFhcjJHWm5BellNd0k2?=
 =?utf-8?B?My9sQUN5TGhRdEU2MmJHaG56UThuczU5VGtJMUZwV2ZSTzhSTmJabG01L0Qz?=
 =?utf-8?B?a09qQ3ZLUjd0d1Biam1FdElBTlgySEY3RnJMNHVvY211eFJ4Mnh5dURXOUg0?=
 =?utf-8?B?OHZlYW1mUW5CNkFHSjliZ0JFbzlna1VHbXdJTFpNU1NBcC9LMkhVVmo1OW16?=
 =?utf-8?B?aDV5SytjSXl5TTNQZ3BEdW1TVnlBZFpIM2dCSkdVZjNQODJId2ZJWlRITGRk?=
 =?utf-8?B?NGlnSkRiZU1uTFQvWGVoYzI0Vjg1L0FxMEhFWU5aTGFyTTNOUW1JTlhVcDM1?=
 =?utf-8?B?WjhvT1dZYmVmWXdTeGhqOU4yL094aGlKbnF0NEtMWmRpV2ZnbDFmV3ZrOXRw?=
 =?utf-8?B?NSsxaTRReGN2TXk5UTRpc1I5eUFBNmdISHQ5SGJhZFVHeDJ2NVRDZ3VRR0M1?=
 =?utf-8?B?REZtd1Y4TEpKQUVjT3oxZ2ZsWDZtVVo4Sy83d0l6elF3UGcyclVuZUV5ek9j?=
 =?utf-8?B?UHpraW5GVHpUeW94WlNoVSs0Zks1YlVwd3o3RGxBSEtoejc0RGpyOG8xbUFm?=
 =?utf-8?B?R0RZNUtEWll3SE1TTFQzMElYcEV5Tm1oWnU5K3dUblBIVVFKd3E1cHFIZ0Rt?=
 =?utf-8?B?ZGxOdmRPWEREZ1BKN2VKekkwTlJ4N0NYN0F5QktXbDFZOEs3SExGT2JWaXlH?=
 =?utf-8?B?aXFka2dNbXNqR0hNMStyUGhVOEZLYVc3Uy92cWZPMG1YdHlNc0RUQ1Jwb0RL?=
 =?utf-8?B?YVY1bTVyTVlySno3T2dVcE0wc3hCYktxUnAxcmJVVjYvZ0Yxd2dhVU9HcGY2?=
 =?utf-8?B?NGdTMm1nb0RtdU1RSUZ4YWNqRENFdGxoRlB5MFdEcUxocGlMN2ordz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f423a401-0ca7-4313-2dc9-08debbf303b7
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:22:34.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNywt8WKrhyp73s07Ii/3RuPUVhTv4MHDNTNlcC/hLZ2UZi71gqnK195csUaiXFs/+kCxTmMzgncy3qYYIZVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2208
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9170-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BA2195E4E00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 9:21 PM BST, Danilo Krummrich wrote:
> Add a 'bound lifetime to the associated Data, changing type Data to type
> Data<'bound>.
>=20
> This allows the driver's bus device private data to capture the device /
> driver bound lifetime; device resources can be stored directly by
> reference rather than requiring Devres.
>=20
> The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
> on the methods themselves; avoiding a global lifetime on the trait impl.
>=20
> Existing drivers set type Data<'bound> =3D Self, preserving the current
> behavior.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/drm/nova/driver.rs        | 10 +++++-----
>  rust/kernel/auxiliary.rs              | 18 +++++++++---------
>  samples/rust/rust_driver_auxiliary.rs | 10 +++++-----
>  3 files changed, 19 insertions(+), 19 deletions(-)


