Return-Path: <linux-pwm+bounces-9171-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEqVBX3wFmrsxgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9171-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:24:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA6E5E4E3D
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5BB7303F987
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D840DFC5;
	Wed, 27 May 2026 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="FvsPyUKG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020089.outbound.protection.outlook.com [52.101.195.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB97409601;
	Wed, 27 May 2026 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888178; cv=fail; b=OLhloPQoqD8WiIt8zIloX5YoKTTSN/xq/b1aK6N41xYgpdkmSDcu+kWMpWFS2ClweW7t5yK7U+6w40ejjv69WB1UoixvsS/MVK34+NFye2/R4LFAW4B7LosBGfWSgOAD07p5/9WD2cVvEeA+Ah1mR3CBGy+7CH5YBun1yXqrnpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888178; c=relaxed/simple;
	bh=gQaGLJ0M9AIY/0T8y5tyTJXLPRzS7sYCj/Rn1kDsaoU=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=CtVq88m/GHyr56EMBUDAlSEct2lcVLRSeb8UK+oMamUNJ+CV2SGgvTyx11mn671Y44v+lcbkgxiWzv1LEYqrhgnxgP2mT88GyAxU2kYFlQHQVGrSED+vz1R4u5EQjOHI64igwsrpwJc3G2YKCszO/o39m689TQh1X+CH85lltGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FvsPyUKG; arc=fail smtp.client-ip=52.101.195.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlMzkrl7IjWEVFTOFLCi9JrNnjtGqxV18i2JGKXUD+Ewpomh+ap1MSazpUIX81kNyxxbqbwqZfTO2bT+n9/p1/v1o2Z7cJQ3BtaGUdKwZmtV/JrPSbq4rnpZRqUWzIJ2Eus0Rrd6Glvp1PKfUajojH+UM8ENMj5fb/comrenZBs5xVBkVMCMKCB7y7mOxT5mU2UJEz7FTD+y+92xfWTQ5bpBeMEDQfcSw1ZkPbcCaM1f35fi6pu1LMD7SeHDF1GILfdV2bmHFMZrSKOOZiSntjTtBKwpzM+no270VelZ7Bqo15hCz2gGH/HJnAT9M7O3m9gWWDxJVZwGsq1+jz2wDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clCOL2blGi1xeZM7DrjuQoHfU+kjz7939SXkGGv32aw=;
 b=V16FLWUCxQv1N4VH/NJ0v640s7CiB+e4p1hWRxv2n2WBqUbwkvptiKJhVcW+bJ6FQ+e13Xnmd/GHAWrEmIme35rXnhAvA37ycl9a6/o6ZQe2t1C5cE8dUExvvvtKo7BjOPGcij4BWjWupA6H/nUTCFsk4IXMHCPO801pRG0evXWQgHx+9On2rJ1wxnW7oogw5ykpFwQcVUtSFm/ZdeU02ZlYpxBJ3NFugoPt+FvKl6nRqpkKK7AmpbyESaxMm2ei6Oc8eifPp+iZTTnsK/P5uZI1OoXM2FlGBFNcAEoVRAeOkJeTdk4uD0Dtx/pms97O33hF0VpfQcS4DjQo3vad/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clCOL2blGi1xeZM7DrjuQoHfU+kjz7939SXkGGv32aw=;
 b=FvsPyUKG8JKQmScUwCxN8R/b5X1c4oTOTSGbuSWfcrnt/L70cQVsH8NmZgiHKCAUA8EdB7HKAxNtQggIHJ991EP44/AOW3DmJ12ABy77ThzZYK7D05ArF71HU9WAF+IO2fj9Jtg/IDdE+f7mU+cigNph7hQVNck0lwkLbg70Dn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB2208.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 13:22:54 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:22:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 14:22:53 +0100
Message-Id: <DITHP6SJILME.JN1FF6EEXM1P@garyguo.net>
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
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v5 15/24] rust: usb: make Driver trait
 lifetime-parameterized
X-Mailer: aerc 0.21.0
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-16-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-16-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0129.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB2208:EE_
X-MS-Office365-Filtering-Correlation-Id: 4827525f-1f61-4b35-2d69-08debbf30f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	Ovqnxx9jix2RW97Uf0U0YHWFHghnM86An4Fxo0C5s1FIXC/8tGxBbi/+Qj1o+wpwh4HjW6TBvEoEf3r3rfpfaIrBOy5C+aLyIb/NTcfWd7H5nd9zDhmj+Um1alzIELMudEjBDH2pbD61G7Ka4f54td8TZ3rTHeQiPdox+dPwmvoCV9ZwSprHDPPfmLw1TCjBtp+zIL093qoipw+tGR5vnY32YHFyckXs3s1MJRJsENEZbPNver/VwI+lptDrcQdFM6T42ty9cQmRjx9TYtoSH8ZlnLK2+7tpmad32D2Le1mEq4bl0HrQjcZgPxtN2vOA3FrAQGSQKEIX08xwYZgSR2+vH2KePuRtp+lCugXRXWcMaPNuvYiqhf8Zda8dpAZD0fZbJEoiNPfAALGpkvwJPYcnCqv4HzU1gnDQBK1HqRIM/UaEWxkc2jBBfhZz91qCxeSLYMJaFHXH+DwCN1Av4HyWL+Z7Qhw5cobY1v5QofFYT2WVxpVx7H/8PCXvQ7Atln3HdoyhjMMMIRp97Sxki7M6ICGX/pwY0OooYqPDG+SBzmkBkK8Tnzc52Y9o6uRbw/S1OltAr+znr6xEuteEcwHpLFJ/6CTdNpLDzps8Vj8tgKmfKOnqUIHmKkcUN4IwbM3B1g86YKuctlOK/LsNuEWwxQBB1C3IkLNEEgjHBcWPJY5EhGa7Bl6EHhjoYox/bnM4xExmZvw2Jutreo1B2o7QnhAemHFijxmAS/s2+GQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHk0US9mQmdqUGFTMlFuWkwvdXlLQkM2azZ1VWJFQXRvOGVwOEVIOWVta25s?=
 =?utf-8?B?VDhyUFBUT0J2cXFZb08rUmxKL09iT1ZFTGx1ZHkwYVAxRVBWTUNUSmRBYmtO?=
 =?utf-8?B?TFBGY1poZ3R3SGNXU0Z1L0RLemF2eWRodFA0UmZNamhES1FyOUxSWmFjTWhM?=
 =?utf-8?B?UCtDbGRacmxsNFF1V3ZjZ000RWFDSXlNQXBCWWM3cFkvUDlKWllUZjNuZm9W?=
 =?utf-8?B?SWpDY0JUcENVZnYwWk1SLzdkNjVFOXJVUk81RW9nYVROSjFFY0I4OHpSWU4z?=
 =?utf-8?B?T1RiWSs4QnBqYmhjOVZ2SG54YXJiOC9QcFl3K00zK0c4YVl3UG1ZLzdjbWtV?=
 =?utf-8?B?RFFFZ3FlMzNqRWp5VjFjck1zcE9JcjhZcmVSakhWRk5CWkhTZitXTXB2OG41?=
 =?utf-8?B?RWt0M24rS2k2U2hldXkzQ1E4Y1NWc09YMWJBVmdkUis4bVJ5OTE3RDhBZU9x?=
 =?utf-8?B?OGNxQ2xUR1k1c3Q0Um9hZytxbGswdG5wMTlVdVdzV2RrWk1Pc1VsVXAxWDVn?=
 =?utf-8?B?Q1hDU1B4WUhsKy8xc0wxRTdMSWlvMy9aa0g4UnNyRklLdDhIZmlhamN1akpB?=
 =?utf-8?B?anhTN3B5NGdrbmFBSktHN0I5ejFuRVhsUlpCZHlrNFlIQlJWSlZzWkRST3VQ?=
 =?utf-8?B?czg1T0d4WHloQ1RaNVNtc0RuVjZaaW9ZYytTL0ZXalBNOFI3WlVaaVFjaEd1?=
 =?utf-8?B?SGU1b1RzRFFxUy9aNFVCalcwN2NQc3Z4UE9FY1J0QitVdzZwRTkvL2M4cmR5?=
 =?utf-8?B?VGxzTGdqT0xncEVhc1ZjOEJubVMvaDN5bXRya0Q4ZDh0WTc2TjdYV2NjWGFV?=
 =?utf-8?B?bHdpTzdqNitPNXVxb3JOVHRFUExZU0ZCaHU1cGxUZStYZ0drVjR5TktkV0JU?=
 =?utf-8?B?eVFRanpHS2M1YWxiNmk4UE43Rzd0Q09QRUo4cS9sYjNkaEtwN01QcXFVOE9n?=
 =?utf-8?B?QU5pUGFTd2dFeU4wK0RjbUNTanpVQjEvV1RkUU5vb0FwZ1hWSENZcTdLRG9p?=
 =?utf-8?B?dzZQNVAvcGhMYjRmRXZPMkowUlF1bk9MSWNTb2hCTXVoQmY2WExSbmVnYnJS?=
 =?utf-8?B?aDI0d0NQellKU0hZK1JNaWt3NkNicUx0cmc5aHJzdGpPbDlXZnByK21mcm5z?=
 =?utf-8?B?cWFQaTZkeDgyWWp5dG96ZEFmdXNEczhjQXd3ak1CbFVudC9NMkhKUTVRS043?=
 =?utf-8?B?MnZheDNjVXhUMmRWRDk0a2NKMnFHaEFjbFlUWW5MQmswSEs4LzlnS2V3ak91?=
 =?utf-8?B?NDQ1dWROaEpURHA4V1BhaVJjSTB2TmlucWFzZTVDM0FRM0U2QUhOVUg0djUy?=
 =?utf-8?B?SGhPZFA1b2RKYVdObHlZR2hwcm52YTZxWGtLaTNHM2RMdFRaQzI1YnQxYkp1?=
 =?utf-8?B?bVdFVkJOd1QrYWphajhycnFHV0UzaHZCZC94ZnBXZzZjaFN3eElINVo5QnYy?=
 =?utf-8?B?S0NTUm5GbWxNMGZ6SGdFWDliSkpxVzh4eFk2ZUQyTXBjRDZ6dk5vVDN1VWx3?=
 =?utf-8?B?a2tUV09NakFrL0N1NFhDOVR6cHo4c3l6SDlINTk3ay9ZR2Z2SGNXTE5PaTFz?=
 =?utf-8?B?MHRXakdQK1RYdHZ6VEs1a0RrMVBSVlRYNzFYbnZ0cU1EL1kzK0Vkdm1sV2tY?=
 =?utf-8?B?VWp3N2RlenVwd2ZIaVA0L2Zob05PS3hQYlM1L2gvS3M3MmRJNmpuYUR3TU5k?=
 =?utf-8?B?R2Q0ZzNkOGluR1daTnhwV2tkN014SUtFMFBZYTI3WVViSXN5RE9DeGxwRi95?=
 =?utf-8?B?OEdoL1RCVlpTNnhGb1prZkhCY0hJVUdNbGw0ZytUdUt6KzN2eWxOYXc1aEpO?=
 =?utf-8?B?TVh3UXQ5Z3pJNk0zUkJBN2J4RDByTHFRL0F5UFFybnMvSXRkS21yZTNvM1dr?=
 =?utf-8?B?OHAxazVEWi9Cc25hWUh1SDBzN0pYQllxMnFTTFhiZG0wNTB1V1RmWkhKd2cy?=
 =?utf-8?B?b0dObmRGRUpCYmFyeEdoemdHTzdHYUdnNlB1VVZMOS9wMTdDN0VES1prQmh6?=
 =?utf-8?B?anA1VGJNK1YxNW9KQTJjaVZwYUltb215a1VuaE91TEhyQ3hvYzhKNUVmTVRt?=
 =?utf-8?B?UEo3Qm00WWlBdGhTdWdOQTJ5bldUWlVJZEppSU0xaDdZNnI2bktLR2ljOEFI?=
 =?utf-8?B?Y0MrOUJmL042ZGdQZDhzRS9rb1VBNXNyL2ZVdWlCZTJncHk3OGNod0V5bCs1?=
 =?utf-8?B?NXRCTHFtS2RrRVBLY2VsR3JneDJINWhDYUVXcjlkVnBxeXVDWExCdFhSWXhW?=
 =?utf-8?B?dFI2Nnk2bjlvbVhhRUhVcDNyT0JTOG5kN1Q5NkxJR1pRL1ppSC9QZkZRQ3Zp?=
 =?utf-8?B?MS8vOHJxN1JLZUxWK1N2amxhTWlPbFV4dTRhaUxPYWZlOFZRNUx0Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4827525f-1f61-4b35-2d69-08debbf30f4e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:22:54.2508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIRJV27Hgs/bAcgV5cTlSD2w5t9WGyDCBV6X4hMNIBw3ekcm5quveovX6rKFbNUafmNZkA9twWOrxFbdeSQ/+w==
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
	TAGGED_FROM(0.00)[bounces-9171-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AFA6E5E4E3D
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
> The probe() and disconnect() callbacks thus gain a 'bound lifetime
> parameter on the methods themselves; avoiding a global lifetime on the
> trait impl.
>=20
> Existing drivers set type Data<'bound> =3D Self, preserving the current
> behavior.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/usb.rs              | 37 ++++++++++++++++++++-------------
>  samples/rust/rust_driver_usb.rs | 12 +++++------
>  2 files changed, 28 insertions(+), 21 deletions(-)


