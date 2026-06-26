Return-Path: <linux-pwm+bounces-9409-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NQb1EwORPmqPIAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9409-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:47:31 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E62BD6CE1A4
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:47:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=bwW3Zn0t;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9409-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9409-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A948D302CF3B
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE4D3FADF2;
	Fri, 26 Jun 2026 14:45:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022142.outbound.protection.outlook.com [52.101.101.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040C30C154;
	Fri, 26 Jun 2026 14:45:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485140; cv=fail; b=P4Lf2UIPNiu1Kwr46YO3LCMmAPQHpnln33rOmkgrT6jBFzHrajCb7hXq7i59WbTWyeJoD5ShfzzvAVHJTXLgggI6yOKmIaydKf3AGf2N3z94es4txASiFmKY/iN8V1QtCUJDBIJ3MnFUw92oOVo8jSrto4/ISf+ntx+SaKGkc0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485140; c=relaxed/simple;
	bh=CTJ0FRTVpIoU2MK6DVR94hQ+dUnZxI61PzqvBi3bLls=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Oy0kiuceBIQnY2Ondxl9GHXLhAOsPTmvdJUEQRP1gVSO4th6yIFeHJYSehjIq0aolY/Lhay/LouSAaBWvjKIKQL9tdrw78uuPTIPbvBcUNubdO1jC4qkUd9MSGRWcQq5G1MqC+3uimB/v1hDJmtZKOSEQHukpsXW27tsSE1qwtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=bwW3Zn0t; arc=fail smtp.client-ip=52.101.101.142
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lna558ac1ZEajRIvzWQTulymkiPw91+5Oc3AjHX3Q+4AVYdkn0iNyp9kO/idWJzurWnpBiTzMIWAq/oGQXiOi39jXztU0nbFo4H8eS7O4whSsjNrgYp+FxQBs8LfrrjPL6jXGmxkLSTdk6uE25mW6epQP9sDACPnR8p2qEB0vN7bhOSVPminRh+h1vj0VQCNsMlr3pobcJ7oZYWe9tJsXGVSGdsy+kR1P1L1AodXD1sNhOnXp5XQgMZ4yNgHQ1r2+Wn6rCOphWzgsgxq1UcYHaQsRxTFygrYodp8Qw4q/15AhwBDGr/iQcJJQtRY9c/MUx3Bu9ba4By0MIlE6mvNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWzoamq2VCP8CZhrW6Md2wiHsUp0eQ/UjV0bAZY72nY=;
 b=IXz+WdpTs9jw8jkf++DKYfK4AJaoy0E8rAQ1VZ8zud+w66EoCJya/x/XFdwn1rOhKUIvCYCV1yiNXznsdDD7+hylkYRP0YvfO8Vs8lZv0CA1cedzUZZDrl2mf8EjHNJXDk7nkL/QH7dNlYyj7S2kaO3hBhItwJm8UTZR8v3xXpXSP1BuBYcowcTeSCgnQfTALnSpMRFKqBDoSnwfhyHV7/geUI3mmsWzw9s9VSmj0aLPIfCyXc9NTYbixOgA4YpSQkJrCOHo3Z7cKg2TvxVh+q+jDIvu0qtNCc1pIVpxCrGjHuLy3PvYegSQGy3+o8RjWfzTPIzCZAgnZer9Po2Q1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWzoamq2VCP8CZhrW6Md2wiHsUp0eQ/UjV0bAZY72nY=;
 b=bwW3Zn0t3QekSNr5xTKO7ZRD9q443mfIshOH05/TpkjjdtXholxfegBNvQnUdISQmfybM3EDc0PGhVMIJi+R5Kuf5tA4nWK1lSVDk4telGrkH6rwiz/h+nHL+7Tr5An80ia4pxSi0RYpliHhGuPYzZsUenaYD7UcmoySehD0lK8=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2694.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:21 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:21 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:13 +0100
Subject: [PATCH v5 09/20] rust: io: use view types instead of addresses for
 `Io`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-9-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=31490;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=CTJ0FRTVpIoU2MK6DVR94hQ+dUnZxI61PzqvBi3bLls=;
 b=LcbM1FB2dFi+Tk2CtBd9qv7s60yQ390gsFNwrKALc6LIvjxjD7Do9COQBJ3R+ZRVYKoOiKpMX
 zHl5f7phYY3DVyxcQXTpCGzkyqVakscTp4fN+mQM1LHpuS/1hT34s2q
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
X-MS-Office365-Filtering-Correlation-Id: cfbbfbc4-ba23-47cb-dae9-08ded3918c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|921020|18002099003|5023799004|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	/eVD6XhIZNA/JiyXbIK4ATEsKzu1PpbtUr1ztYSAzrSocBAGp1kG/JRAiNY9lcggi13X/bO+4LpYOc2WrvOEB4lSRY97ZDj0ObVgOevrEr+fvo3BZEtDye7IwcXKlv1lWqBKZq/t0odpfptRJ6nldEP19On8Xzu1rOO7De5Ipb65uMYHmqSNUzQw09tfIIb7ZhOU4/elVa6W0spQO1Pc7UgSsy0MuuFfb535BS/ODyds6oM+kWGfETB75qbnraM86KQglybou2c7cGf7dgo4+IIG6SqRJ1wZ77reYCiDv7BFCB0tsSOXl2VyNzsbsMZ8e+Qd0d3BBTe3s8GK/Vx1CQx8drR/bSUcYElHLHPWtS6XcyHSTWUz+NeTEGVCoJ7DzDnmnOZzq80eHQaqrpf0DhjO6gH7YiKk/uzwBy+tlTbsjKwejt1yJ/EndO29ZgNWlinoz5hRcBn7hJIdJB3/viZE80uOxbzYXcvf+tKavOZsr3ObLZxoSprzfh8BSdSb+peWeMoKI49Fl3jDw3l+ibuXixpgjmtxF4kthPsxaTydvOLhHnhQD274obxKXjfZWx2siuasNyq/cyfioe/KSPqPDuOdnGZThXKq5W9lGnTk2x2pS17+uaIv+R6tJg1V8xGsXVpJkGJn2RaboX404BlwjI7UydQUBHg4VMdNaTV2WbyCIOp4IMJIZCw917psphcc/j5FH4tXkbWcQmpdCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(921020)(18002099003)(5023799004)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eloxOGdPeWplbXQ5WnBhNlo3M2tKbHZkemd0TXkyOHJBSkMrWS9yRHc3aHVW?=
 =?utf-8?B?SW1JR3gyTmVzVUpMaHBLVStRRVd0UVZISytJUXV5eXpmeVdaWFV4Wkx5RTF2?=
 =?utf-8?B?YVdja2wxL1ZiZ3M2aXFRYWhGUWxjeW1pT0pERVZzSG9xaFBIUytnNmdaQkVM?=
 =?utf-8?B?UUU3Sm80OFZ6Y3E1RUoxRkZQaG9xbmt6RFVWRVdBU1h5SHIrTTRtTlkvaloy?=
 =?utf-8?B?VUVCdm5hSUNZR254aitGMUl0YmRNRjBpR29hQUtQZERyenhLMXkzMWxTeE43?=
 =?utf-8?B?OGszbnRHTXkyL3dvQ3pGREFnTmdWejBMZzhVZ3hieWk2cDJHQTM3K3JSWWZ3?=
 =?utf-8?B?REl1QnlhdGZ0N2ZySkdIanBsMDVNRWJITUZ6UFBkeDNWTFRDb2JuWmt3czcv?=
 =?utf-8?B?bGQvMHd1NjRRSkxBZ2JSSjhseVZTbGp4eFF5R2ZmY3V3TmZPdmw1NkJHTlZj?=
 =?utf-8?B?SUlKaHI5cnpoMDR3MEJQNGdkeXR4VTkvMzA0TmF3czJqZTJoTFd1SkNPdjl5?=
 =?utf-8?B?VWVSamNyTlNpTWFpNDE3cGJtbzVnL1ZPZGpvUytENWhqTGtoaHdsaXlUeGoy?=
 =?utf-8?B?VkQrWUpHOVRYUkFVNkE4L3JnamZaQ09iZEZxUm1CL3BtcEozR3R0T0l0eHpy?=
 =?utf-8?B?eE9CZGRNTjVRaERyRi9HbHF5TzYvTG12ZVlPOStrNWRvRndJY2o5TCtmWEF5?=
 =?utf-8?B?TEllVEkrd0o0OHpVTU52NkRTNXU0c2ZwamhvRjRwL25sRGZ0YXdjYzZXSDI0?=
 =?utf-8?B?ZHBMS1BiUExGVkZOeVgyM3RSN2ZpUmFRMHdCQ1JKQXhJdDkrOW5CV0dKdUxN?=
 =?utf-8?B?NEYwWlh5VHZlVmlqWmV6SExmUnJWYkV4MzQ5MjhYa2dNK3c4eWp2ZGVVQ3ZK?=
 =?utf-8?B?NERmMDBVRjhpa1dpZ1Zka1dNdFRLd1ZBNHBxRExBOTVzdjRwSFptT09ueFdW?=
 =?utf-8?B?LzNsd0FJY2FVSEhmUzlUUFBOanE5djgxVTg3TnJNaUFsRnBvMGNuMnNONFFT?=
 =?utf-8?B?NkJyblJIci94RGdlbXBZVElobjh6REZKdXJ4b1hDb21iWWlxNE94QkZGVEl4?=
 =?utf-8?B?Zzdmb3dqNy9QV3RIeUVIWFB4SzFOcWJYOFpjUEhoK0NZc0NRdU12blM3c0xx?=
 =?utf-8?B?SUEyMkNNZXBMaHZwaG9BUVFSdm9qb0NNU2tjOFhHRFZsWjFNV1F2K21nRTlK?=
 =?utf-8?B?Vzdpa3h1QXZYVm5KM0l6RVhma3VLejdwRnJVSzNSMktMTG1wZU50Unp5TFlp?=
 =?utf-8?B?V3EzTm0zbDVXUnNGNkp4Ukxoc1ZtT0NjWU13ZTZBVWJxdlRtUlpuVkdvajQz?=
 =?utf-8?B?SzJsRTJHTXRMSjViSnhEQzkxNmpQK0NVcmhNb3RrRzA5OW9zdXRtYkdYeGdq?=
 =?utf-8?B?TC9TSUpaNGY5dVc1bW1nckJEWDROSEV0ZUNoTmwray9OWkRha1ljdi85dUNV?=
 =?utf-8?B?byt1cFRBZ1F4dkM2NUVmT0dwejRwSW9zcWJleTJoQ3paNEhVZTF3QWtPMitT?=
 =?utf-8?B?VW5NSGFnb0QwWHdIZ2R6MFVSS09OM3cwSERmVHRnaE5hWXlFZVpnWjRIMVBJ?=
 =?utf-8?B?ZldIMC9aTEp3c0RJK00wMmw3Z3piWXpGaGZiNWRPbmJFbFN6ZXZSSDVpb3ds?=
 =?utf-8?B?ZWwzSjVYTXRlRkFORFdST01MMXZkN28yV3NIamYvZTFQMXF5dUhtUkRWNlE4?=
 =?utf-8?B?eFRQSGh6VDMvR2FRYXB4SE1xdUdSdEVMdFpTN3oxdkhheU44RmpjNGZUVU16?=
 =?utf-8?B?bkltK3RKdHFiaG5RSTlIeUM3VjBTTmxLZDM3UFZHSDhSM05zcjVybldseVlQ?=
 =?utf-8?B?dW40UkFNWHA2Q1M4MWludlpnRlJrOSt6SUZIdStIUzdSeDRNRnpvTDdpR0Fo?=
 =?utf-8?B?blQ3ODhtZC9lMGdPeGE2TklRay9NTmx2S2NsTTBDSnhpQVcyM2RSdnFLbnNk?=
 =?utf-8?B?MyswNjJpd205OGNKcC8vTjhSbkNqM1RJZkRYL09NbEdjbUF2amJWRGxIUlly?=
 =?utf-8?B?NUtXKy9OOUhMN3RIdElRckt3U3ZSMkhtY2FYckEyUXJHMHoyZHJ0cnlkMERy?=
 =?utf-8?B?SEZrQmNCZjFxSUVNZ0dnTkZqZlc0VEdQNUM3MUhNVEhHQ2pyOFM2Z04rbFov?=
 =?utf-8?B?eXNsMTM1bTlyTmg0Y3ZaZ1RSMWY5T3E3U1drNkVsS1B2RHFtNGQ1RUVHR3p6?=
 =?utf-8?B?QitwSmFWZ0trQ3FyU0V0ZG1WOHU1UjZHVWR0cTdkYytGTTg4dWdGcWpQMy9M?=
 =?utf-8?B?Z3h5YkNxb0pDWnliZEcxWUh4OFpSLzVoeGJzZEtzbThNOFU1TkFubURlU2ZS?=
 =?utf-8?B?TE5JQU9Qa3FTMDFwRk90ZVR3VlorRHpoRnpQWm1hNERxN2UyamFLZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbbfbc4-ba23-47cb-dae9-08ded3918c9e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:21.6996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRdf29cZWfGtPHfyTGVndmMkuXgGAEVBHqUcY/XfDTMjKBsUaKODWtpNkPSA4LkS2lKQMh53Y6SvWItgujUHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2694
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9409-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,io.rs:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E62BD6CE1A4

Currently, `io_read` and `io_write` methods require the exact type of `Io`
plus an address. This means that they need to be monomorphized for each
different `Io` instance. This also means that multiple I/O implementors for
the same I/O kind needs to duplicate implementation (e.g. `Mmio` and
`MmioOwned`).

Create a new `IoBackend` trait and define these operations on it instead.
The operations are just going to receive a view type and operate on them.
This has the additional advantage that the invariants can be moved from the
trait (and guaranteed via `unsafe`) to type invariants on the canonical
view types of the backends, so `io_read` and `io_write` can be safe.

Note that view type is needed; addresses are insufficient in this
design, as they do not carry sufficient information. For example,
`ConfigSpace` needs `&pci::Device` in addition to the address.

`io_addr_assert` and `io_addr` are renamed to `io_view*` to reflect
that they operate on views now, and make them standalone functions so
they cannot be used by users to cast types outside io.rs.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs     | 382 ++++++++++++++++++++++++++------------------------
 rust/kernel/pci/io.rs |  70 +++++----
 2 files changed, 246 insertions(+), 206 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 8110b49aa430..67b8c62f3771 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -243,6 +243,81 @@ const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> bool {
     }
 }
 
+/// Returns a view for a given `offset`, performing compile-time bound checks.
+// Always inline to optimize out error path of `build_assert`.
+#[inline(always)]
+fn io_view_assert<'a, IO: Io<'a>, U>(
+    this: IO,
+    offset: usize,
+) -> <IO::Backend as IoBackend>::View<'a, U> {
+    // We cannot check alignment with `offset_valid` using `ptr.addr()`. So set 0 for it and
+    // ensure alignment by checking that the alignment of `U` is smaller or equal to the
+    // alignment of `IO::Target`.
+    const_assert!(Alignment::of::<U>().as_usize() <= IO::Target::MIN_ALIGN.as_usize());
+    build_assert!(offset_valid::<U>(0, offset, IO::Target::MIN_SIZE));
+
+    let view = this.as_view();
+    let ptr = IO::Backend::as_ptr(view);
+    let projected_ptr = ptr.cast::<U>().wrapping_byte_add(offset);
+    // SAFETY: `offset_valid` checks for size and alignment and therefore `projected_ptr` is a
+    // valid projection.
+    unsafe { IO::Backend::project_view(view, projected_ptr) }
+}
+
+/// Returns a view for a given `offset`, performing runtime bound checks.
+#[inline]
+fn io_view<'a, IO: Io<'a>, U>(
+    this: IO,
+    offset: usize,
+) -> Result<<IO::Backend as IoBackend>::View<'a, U>> {
+    let view = this.as_view();
+    let ptr = IO::Backend::as_ptr(view);
+
+    if !offset_valid::<U>(ptr.addr(), offset, KnownSize::size(ptr)) {
+        return Err(EINVAL);
+    }
+
+    let projected_ptr = ptr.cast::<U>().wrapping_byte_add(offset);
+    // SAFETY: `offset_valid` checks for size and alignment and therefore `projected_ptr` is a
+    // valid projection.
+    Ok(unsafe { IO::Backend::project_view(view, projected_ptr) })
+}
+
+/// I/O backends.
+///
+/// This is an abstract representation to be implemented by arbitrary I/O
+/// backends (e.g. MMIO, PCI config space, etc.).
+///
+/// The base trait only defines the projection operations; which I/O methods are available depends
+/// on which [`IoCapable<T>`] traits are implemented for the type. For example, for MMIO regions,
+/// all widths (u8, u16, u32, and u64 on 64-bit systems) are typically supported. For PCI
+/// configuration space, u8, u16, and u32 are supported but u64 is not.
+///
+/// This trait is separate from the `Io` trait as multiple different I/O types may share the same
+/// operation.
+pub trait IoBackend {
+    /// View type for this I/O backend.
+    type View<'a, T: ?Sized + KnownSize>: Io<'a, Backend = Self, Target = T>;
+
+    /// Convert a `view` to a raw pointer for projection.
+    ///
+    /// The returned pointer is private implementation detail of the backend; it is likely not
+    /// valid. It should be used for projection only.
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T;
+
+    /// Project `view` to its subregion indicated by `ptr`.
+    ///
+    /// If input `view` is valid, returned view must also be valid.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a projection of `Self::as_ptr(view)`.
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U>;
+}
+
 /// Trait indicating that an I/O backend supports operations of a certain type and providing an
 /// implementation for these operations.
 ///
@@ -251,22 +326,12 @@ const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> bool {
 /// For example, a PCI configuration space may implement `IoCapable<u8>`, `IoCapable<u16>`,
 /// and `IoCapable<u32>`, but not `IoCapable<u64>`, while an MMIO region on a 64-bit
 /// system might implement all four.
-pub trait IoCapable<T> {
-    /// Performs an I/O read of type `T` at `address` and returns the result.
-    ///
-    /// # Safety
-    ///
-    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
-    /// - `address` must be aligned.
-    unsafe fn io_read(self, address: usize) -> T;
+pub trait IoCapable<T>: IoBackend {
+    /// Performs an I/O read of type `T` at `view` and returns the result.
+    fn io_read<'a>(view: Self::View<'a, T>) -> T;
 
-    /// Performs an I/O write of `value` at `address`.
-    ///
-    /// # Safety
-    ///
-    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
-    /// - `address` must be aligned.
-    unsafe fn io_write(self, value: T, address: usize);
+    /// Performs an I/O write of `value` at `view`.
+    fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }
 
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
@@ -318,66 +383,30 @@ fn offset(self) -> usize {
 /// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
 /// can perform I/O operations on regions of memory.
 ///
-/// This is an abstract representation to be implemented by arbitrary I/O
-/// backends (e.g. MMIO, PCI config space, etc.).
-///
 /// The [`Io`] trait provides:
-/// - Base address and size information
+/// - Method to convert into [`IoBackend::View`].
 /// - Helper methods for offset validation and address calculation
 /// - Fallible (runtime checked) accessors for different data widths
 ///
-/// Which I/O methods are available depends on which [`IoCapable<T>`] traits
-/// are implemented for the type.
+/// Which I/O methods are available depends on the associated [`IoBackend`] implementation.
 ///
 /// This should be implemented on cheaply copyable handles, such as references or view types.
-///
-/// # Examples
-///
-/// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
-/// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
-pub trait Io: Copy {
+pub trait Io<'a>: Copy {
+    /// Type that defines all I/O operations.
+    type Backend: IoBackend;
+
     /// Type of this I/O region. For untyped regions, [`Region`] can be used.
     type Target: ?Sized + KnownSize;
 
-    /// Returns the base address of this mapping.
-    fn addr(self) -> usize;
-
-    /// Returns the maximum size of this mapping.
-    fn maxsize(self) -> usize;
-
-    /// Returns the absolute I/O address for a given `offset`,
-    /// performing compile-time bound checks.
-    // Always inline to optimize out error path of `build_assert`.
-    #[inline(always)]
-    fn io_addr_assert<U>(self, offset: usize) -> usize {
-        // We cannot check alignment with `offset_valid` using `self.addr()`. So set 0 for it and
-        // ensure alignment by checking that the alignment of `U` is smaller or equal to the
-        // alignment of `Self::Target`.
-        const_assert!(Alignment::of::<U>().as_usize() <= Self::Target::MIN_ALIGN.as_usize());
-        build_assert!(offset_valid::<U>(0, offset, Self::Target::MIN_SIZE));
-
-        self.addr() + offset
-    }
-
-    /// Returns the absolute I/O address for a given `offset`,
-    /// performing runtime bound checks.
-    #[inline]
-    fn io_addr<U>(self, offset: usize) -> Result<usize> {
-        if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
-            return Err(EINVAL);
-        }
-
-        // Probably no need to check, since the safety requirements of `Self::new` guarantee that
-        // this can't overflow.
-        self.addr().checked_add(offset).ok_or(EINVAL)
-    }
+    /// Return a view that covers the full region.
+    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target>;
 
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
     fn try_read8(self, offset: usize) -> Result<u8>
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self: IoCapable<u8>,
+        Self::Backend: IoCapable<u8>,
     {
         self.try_read(offset)
     }
@@ -387,7 +416,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
     fn try_read16(self, offset: usize) -> Result<u16>
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self: IoCapable<u16>,
+        Self::Backend: IoCapable<u16>,
     {
         self.try_read(offset)
     }
@@ -397,7 +426,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
     fn try_read32(self, offset: usize) -> Result<u32>
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self: IoCapable<u32>,
+        Self::Backend: IoCapable<u32>,
     {
         self.try_read(offset)
     }
@@ -407,7 +436,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
     fn try_read64(self, offset: usize) -> Result<u64>
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self: IoCapable<u64>,
+        Self::Backend: IoCapable<u64>,
     {
         self.try_read(offset)
     }
@@ -417,7 +446,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
     fn try_write8(self, value: u8, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self: IoCapable<u8>,
+        Self::Backend: IoCapable<u8>,
     {
         self.try_write(offset, value)
     }
@@ -427,7 +456,7 @@ fn try_write8(self, value: u8, offset: usize) -> Result
     fn try_write16(self, value: u16, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self: IoCapable<u16>,
+        Self::Backend: IoCapable<u16>,
     {
         self.try_write(offset, value)
     }
@@ -437,7 +466,7 @@ fn try_write16(self, value: u16, offset: usize) -> Result
     fn try_write32(self, value: u32, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self: IoCapable<u32>,
+        Self::Backend: IoCapable<u32>,
     {
         self.try_write(offset, value)
     }
@@ -447,7 +476,7 @@ fn try_write32(self, value: u32, offset: usize) -> Result
     fn try_write64(self, value: u64, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self: IoCapable<u64>,
+        Self::Backend: IoCapable<u64>,
     {
         self.try_write(offset, value)
     }
@@ -457,7 +486,7 @@ fn try_write64(self, value: u64, offset: usize) -> Result
     fn read8(self, offset: usize) -> u8
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self: IoCapable<u8>,
+        Self::Backend: IoCapable<u8>,
     {
         self.read(offset)
     }
@@ -467,7 +496,7 @@ fn read8(self, offset: usize) -> u8
     fn read16(self, offset: usize) -> u16
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self: IoCapable<u16>,
+        Self::Backend: IoCapable<u16>,
     {
         self.read(offset)
     }
@@ -477,7 +506,7 @@ fn read16(self, offset: usize) -> u16
     fn read32(self, offset: usize) -> u32
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self: IoCapable<u32>,
+        Self::Backend: IoCapable<u32>,
     {
         self.read(offset)
     }
@@ -487,7 +516,7 @@ fn read32(self, offset: usize) -> u32
     fn read64(self, offset: usize) -> u64
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self: IoCapable<u64>,
+        Self::Backend: IoCapable<u64>,
     {
         self.read(offset)
     }
@@ -497,7 +526,7 @@ fn read64(self, offset: usize) -> u64
     fn write8(self, value: u8, offset: usize)
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self: IoCapable<u8>,
+        Self::Backend: IoCapable<u8>,
     {
         self.write(offset, value)
     }
@@ -507,7 +536,7 @@ fn write8(self, value: u8, offset: usize)
     fn write16(self, value: u16, offset: usize)
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self: IoCapable<u16>,
+        Self::Backend: IoCapable<u16>,
     {
         self.write(offset, value)
     }
@@ -517,7 +546,7 @@ fn write16(self, value: u16, offset: usize)
     fn write32(self, value: u32, offset: usize)
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self: IoCapable<u32>,
+        Self::Backend: IoCapable<u32>,
     {
         self.write(offset, value)
     }
@@ -527,7 +556,7 @@ fn write32(self, value: u32, offset: usize)
     fn write64(self, value: u64, offset: usize)
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self: IoCapable<u64>,
+        Self::Backend: IoCapable<u64>,
     {
         self.write(offset, value)
     }
@@ -559,12 +588,10 @@ fn write64(self, value: u64, offset: usize)
     fn try_read<T, L>(self, location: L) -> Result<T>
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
-        let address = self.io_addr::<L::IoType>(location.offset())?;
-
-        // SAFETY: `address` has been validated by `io_addr`.
-        Ok(unsafe { self.io_read(address) }.into())
+        let view = io_view::<Self, L::IoType>(self, location.offset())?;
+        Ok(Self::Backend::io_read(view).into())
     }
 
     /// Generic fallible write with runtime bounds check.
@@ -594,14 +621,11 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     fn try_write<T, L>(self, location: L, value: T) -> Result
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
-        let address = self.io_addr::<L::IoType>(location.offset())?;
+        let view = io_view::<Self, L::IoType>(self, location.offset())?;
         let io_value = value.into();
-
-        // SAFETY: `address` has been validated by `io_addr`.
-        unsafe { self.io_write(io_value, address) }
-
+        Self::Backend::io_write(view, io_value);
         Ok(())
     }
 
@@ -642,7 +666,7 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -675,17 +699,14 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
-        let address = self.io_addr::<L::IoType>(location.offset())?;
+        let view = io_view::<Self, L::IoType>(self, location.offset())?;
 
-        // SAFETY: `address` has been validated by `io_addr`.
-        let value: T = unsafe { self.io_read(address) }.into();
+        let value: T = Self::Backend::io_read(view).into();
         let io_value = f(value).into();
-
-        // SAFETY: `address` has been validated by `io_addr`.
-        unsafe { self.io_write(io_value, address) }
+        Self::Backend::io_write(view, io_value);
 
         Ok(())
     }
@@ -715,12 +736,10 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     fn read<T, L>(self, location: L) -> T
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
-        let address = self.io_addr_assert::<L::IoType>(location.offset());
-
-        // SAFETY: `address` has been validated by `io_addr_assert`.
-        unsafe { self.io_read(address) }.into()
+        let view = io_view_assert::<Self, L::IoType>(self, location.offset());
+        Self::Backend::io_read(view).into()
     }
 
     /// Generic infallible write with compile-time bounds check.
@@ -748,13 +767,11 @@ fn read<T, L>(self, location: L) -> T
     fn write<T, L>(self, location: L, value: T)
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
-        let address = self.io_addr_assert::<L::IoType>(location.offset());
+        let view = io_view_assert::<Self, L::IoType>(self, location.offset());
         let io_value = value.into();
-
-        // SAFETY: `address` has been validated by `io_addr_assert`.
-        unsafe { self.io_write(io_value, address) }
+        Self::Backend::io_write(view, io_value);
     }
 
     /// Generic infallible write of a fully-located register value.
@@ -793,7 +810,7 @@ fn write_reg<T, L, V>(self, value: V)
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -826,17 +843,13 @@ fn write_reg<T, L, V>(self, value: V)
     fn update<T, L, F>(self, location: L, f: F)
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
-        let address = self.io_addr_assert::<L::IoType>(location.offset());
-
-        // SAFETY: `address` has been validated by `io_addr_assert`.
-        let value: T = unsafe { self.io_read(address) }.into();
+        let view = io_view_assert::<Self, L::IoType>(self, location.offset());
+        let value: T = Self::Backend::io_read(view).into();
         let io_value = f(value).into();
-
-        // SAFETY: `address` has been validated by `io_addr_assert`.
-        unsafe { self.io_write(io_value, address) }
+        Self::Backend::io_write(view, io_value);
     }
 }
 
@@ -880,78 +893,78 @@ unsafe impl<T: ?Sized + Sync> Send for Mmio<'_, T> {}
 // SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
 unsafe impl<T: ?Sized + Sync> Sync for Mmio<'_, T> {}
 
-impl<T: ?Sized + KnownSize> Io for Mmio<'_, T> {
+impl<'a, T: ?Sized + KnownSize> Io<'a> for Mmio<'a, T> {
+    type Backend = MmioBackend;
     type Target = T;
 
     #[inline]
-    fn addr(self) -> usize {
-        self.ptr.addr()
+    fn as_view(self) -> Mmio<'a, T> {
+        self
     }
+}
+
+/// I/O Backend for memory-mapped I/O.
+pub struct MmioBackend;
+
+impl IoBackend for MmioBackend {
+    type View<'a, T: ?Sized + KnownSize> = Mmio<'a, T>;
 
     #[inline]
-    fn maxsize(self) -> usize {
-        KnownSize::size(self.ptr)
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        view.ptr
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        _view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // INVARIANT: Per safety requirement, `ptr` is projection from `view`, so it is also a valid
+        // memory-mapped I/O region.
+        Mmio {
+            ptr,
+            phantom: PhantomData,
+        }
     }
 }
 
-/// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
+/// Implements [`IoCapable`] on `$backend` for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_mmio_io_capable {
-    ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
-        $(#[$attr])*
-        impl<T: ?Sized> IoCapable<$ty> for $mmio<'_, T> {
+    ($backend: ident, $ty:ty, $read_fn:ident, $write_fn:ident) => {
+        impl IoCapable<$ty> for $backend {
             #[inline]
-            unsafe fn io_read(self, address: usize) -> $ty {
-                // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
-                unsafe { bindings::$read_fn(address as *const c_void) }
+            fn io_read(view: <$backend as IoBackend>::View<'_, $ty>) -> $ty {
+                // SAFETY: `$backend::as_ptr(view)` is a valid pointer for MMIO operations for both
+                // `MmioBackend` and `RelaxedMmioBackend`.
+                unsafe { bindings::$read_fn($backend::as_ptr(view).cast_const().cast()) }
             }
 
             #[inline]
-            unsafe fn io_write(self, value: $ty, address: usize) {
-                // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
-                unsafe { bindings::$write_fn(value, address as *mut c_void) }
+            fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, value: $ty) {
+                // SAFETY: `$backend::as_ptr(view)` is a valid pointer for MMIO operations for both
+                // `MmioBackend` and `RelaxedMmioBackend`.
+                unsafe { bindings::$write_fn(value, $backend::as_ptr(view).cast()) }
             }
         }
     };
 }
 
 // MMIO regions support 8, 16, and 32-bit accesses.
-impl_mmio_io_capable!(Mmio, u8, readb, writeb);
-impl_mmio_io_capable!(Mmio, u16, readw, writew);
-impl_mmio_io_capable!(Mmio, u32, readl, writel);
+impl_mmio_io_capable!(MmioBackend, u8, readb, writeb);
+impl_mmio_io_capable!(MmioBackend, u16, readw, writew);
+impl_mmio_io_capable!(MmioBackend, u32, readl, writel);
 // MMIO regions on 64-bit systems also support 64-bit accesses.
 #[cfg(CONFIG_64BIT)]
-impl_mmio_io_capable!(Mmio, u64, readq, writeq);
+impl_mmio_io_capable!(MmioBackend, u64, readq, writeq);
 
-impl<'a, const SIZE: usize> Io for &'a MmioOwned<SIZE> {
+impl<'a, const SIZE: usize> Io<'a> for &'a MmioOwned<SIZE> {
+    type Backend = MmioBackend;
     type Target = Region<SIZE>;
 
-    /// Returns the base address of this mapping.
     #[inline]
-    fn addr(self) -> usize {
-        self.0.addr()
-    }
-
-    /// Returns the maximum size of this mapping.
-    #[inline]
-    fn maxsize(self) -> usize {
-        self.0.size()
-    }
-}
-
-impl<'a, const SIZE: usize, T> IoCapable<T> for &'a MmioOwned<SIZE>
-where
-    Mmio<'a, Region<SIZE>>: IoCapable<T>,
-{
-    #[inline]
-    unsafe fn io_read(self, address: usize) -> T {
-        // SAFETY: Per safety requirement.
-        unsafe { self.as_view().io_read(address) }
-    }
-
-    #[inline]
-    unsafe fn io_write(self, value: T, address: usize) {
-        // SAFETY: Per safety requirement.
-        unsafe { self.as_view().io_write(value, address) }
+    fn as_view(self) -> Mmio<'a, Self::Target> {
+        // SAFETY: `Mmio` has same invariant as `MmioOwned`
+        unsafe { Mmio::from_raw(self.0) }
     }
 }
 
@@ -967,13 +980,6 @@ pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
         // SAFETY: `MmioOwned` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
-
-    /// Return a view that covers the full region.
-    #[inline]
-    pub fn as_view(&self) -> Mmio<'_, Region<SIZE>> {
-        // SAFETY: `Mmio` has same invariant as `MmioOwned`.
-        unsafe { Mmio::from_raw(self.0) }
-    }
 }
 
 /// [`Mmio`] but using relaxed accessors.
@@ -992,17 +998,34 @@ fn clone(&self) -> Self {
     }
 }
 
-impl<T: ?Sized + KnownSize> Io for RelaxedMmio<'_, T> {
-    type Target = T;
+/// I/O Backend for memory-mapped I/O, with relaxed access semantics.
+pub struct RelaxedMmioBackend;
+
+impl IoBackend for RelaxedMmioBackend {
+    type View<'a, T: ?Sized + KnownSize> = RelaxedMmio<'a, T>;
 
     #[inline]
-    fn addr(self) -> usize {
-        self.0.addr()
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        MmioBackend::as_ptr(view.0)
     }
 
     #[inline]
-    fn maxsize(self) -> usize {
-        self.0.maxsize()
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // SAFETY: Per safety requirement.
+        RelaxedMmio(unsafe { MmioBackend::project_view(view.0, ptr) })
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> Io<'a> for RelaxedMmio<'a, T> {
+    type Backend = RelaxedMmioBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> RelaxedMmio<'a, T> {
+        self
     }
 }
 
@@ -1035,14 +1058,9 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
 }
 
 // MMIO regions support 8, 16, and 32-bit accesses.
-impl_mmio_io_capable!(RelaxedMmio, u8, readb_relaxed, writeb_relaxed);
-impl_mmio_io_capable!(RelaxedMmio, u16, readw_relaxed, writew_relaxed);
-impl_mmio_io_capable!(RelaxedMmio, u32, readl_relaxed, writel_relaxed);
+impl_mmio_io_capable!(RelaxedMmioBackend, u8, readb_relaxed, writeb_relaxed);
+impl_mmio_io_capable!(RelaxedMmioBackend, u16, readw_relaxed, writew_relaxed);
+impl_mmio_io_capable!(RelaxedMmioBackend, u32, readl_relaxed, writel_relaxed);
 // MMIO regions on 64-bit systems also support 64-bit accesses.
-impl_mmio_io_capable!(
-    RelaxedMmio,
-    #[cfg(CONFIG_64BIT)]
-    u64,
-    readq_relaxed,
-    writeq_relaxed
-);
+#[cfg(CONFIG_64BIT)]
+impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_relaxed);
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 89f4bb483a7f..e67c1e3694fb 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -9,6 +9,7 @@
     devres::Devres,
     io::{
         Io,
+        IoBackend,
         IoCapable,
         MmioOwned,
         MmioRaw,
@@ -84,32 +85,57 @@ unsafe impl<T: ?Sized + Sync> Send for ConfigSpace<'_, T> {}
 // SAFETY: `ConfigSpace<'_, T>` is conceptually `&T` but in I/O memory.
 unsafe impl<T: ?Sized + Sync> Sync for ConfigSpace<'_, T> {}
 
+/// I/O Backend for PCI configuration space.
+pub struct ConfigSpaceBackend;
+
+impl IoBackend for ConfigSpaceBackend {
+    type View<'a, T: ?Sized + KnownSize> = ConfigSpace<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: ConfigSpace<'a, T>) -> *mut T {
+        view.ptr
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // INVARIANT: Per safety requirement.
+        ConfigSpace {
+            pdev: view.pdev,
+            ptr,
+        }
+    }
+}
+
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, T: ?Sized> IoCapable<$ty> for ConfigSpace<'a, T> {
-            unsafe fn io_read(self, address: usize) -> $ty {
+        impl IoCapable<$ty> for ConfigSpaceBackend {
+            fn io_read(view: ConfigSpace<'_, $ty>) -> $ty {
+                // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
+                // signed offset parameter. PCI configuration space size is at most 4096 bytes,
+                // so the value always fits within `i32` without truncation or sign change.
+                let addr = view.ptr.addr() as i32;
+
                 let mut val: $ty = 0;
 
                 // Return value from C function is ignored in infallible accessors.
-                let _ret =
-                    // SAFETY: By the type invariant `self.pdev` is a valid address.
-                    // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
-                    // signed offset parameter. PCI configuration space size is at most 4096 bytes,
-                    // so the value always fits within `i32` without truncation or sign change.
-                    unsafe { bindings::$read_fn(self.pdev.as_raw(), address as i32, &mut val) };
-
+                // SAFETY: By the type invariant `pdev` is a valid address.
+                let _ = unsafe { bindings::$read_fn(view.pdev.as_raw(), addr, &mut val) };
                 val
             }
 
-            unsafe fn io_write(self, value: $ty, address: usize) {
+            fn io_write(view: ConfigSpace<'_, $ty>, value: $ty) {
+                // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
+                // signed offset parameter. PCI configuration space size is at most 4096 bytes,
+                // so the value always fits within `i32` without truncation or sign change.
+                let addr = view.ptr.addr() as i32;
+
                 // Return value from C function is ignored in infallible accessors.
-                let _ret =
-                    // SAFETY: By the type invariant `self.pdev` is a valid address.
-                    // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
-                    // signed offset parameter. PCI configuration space size is at most 4096 bytes,
-                    // so the value always fits within `i32` without truncation or sign change.
-                    unsafe { bindings::$write_fn(self.pdev.as_raw(), address as i32, value) };
+                // SAFETY: By the type invariant `pdev` is a valid address.
+                let _ = unsafe { bindings::$write_fn(view.pdev.as_raw(), addr, value) };
             }
         }
     };
@@ -120,17 +146,13 @@ unsafe fn io_write(self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, T: ?Sized + KnownSize> Io for ConfigSpace<'a, T> {
+impl<'a, T: ?Sized + KnownSize> Io<'a> for ConfigSpace<'a, T> {
+    type Backend = ConfigSpaceBackend;
     type Target = T;
 
     #[inline]
-    fn addr(self) -> usize {
-        self.ptr.addr()
-    }
-
-    #[inline]
-    fn maxsize(self) -> usize {
-        KnownSize::size(self.ptr)
+    fn as_view(self) -> ConfigSpace<'a, T> {
+        self
     }
 }
 

-- 
2.54.0


