Return-Path: <linux-pwm+bounces-9578-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NvCiFBiKSmoIEgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9578-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 18:45:12 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F29870A9B2
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 18:45:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=lnX6bjPk;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9578-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9578-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 079B6300614F
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFAD3002B3;
	Sun,  5 Jul 2026 16:45:09 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021095.outbound.protection.outlook.com [52.101.95.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF72FE071;
	Sun,  5 Jul 2026 16:45:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269909; cv=fail; b=Q+HMmyCybR610Gw6/VexDtSUGh+MQM3D4qgq9kw3BEP+C9XE24F5CUnRq0/9hsDPofJSxZGOkB2t2n2oKsjix3ApH2yqEC4zLd8lwZEvKANGdQun3SaRPflFoaIkqoeobRFNPVXVlYCF0ojNyI7APGftkgGzDxFkAgKQAAz5SzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269909; c=relaxed/simple;
	bh=rqGf6nJ0fEVcmtr4+GEUj1i5pIF7PGqQcnrus6yaoB8=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=cbylde8n0yBBOiNfFzwdmqBJp5mShvmSLpCD0xo8SdOiL5Xpiqh5yH2hRww5GQz7ha4X2ePqDBclt3kacWLe1e3k9qfAiCQ97G3fFPzZdBTgKT4pIbz0ygnC4w04SN5juuJ1hQhXs3eCYjlnAO/u3BWlQayTv06ays2qAFVToOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=lnX6bjPk; arc=fail smtp.client-ip=52.101.95.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whg7R14qc0jI9T+oCz2muwPeNL7v/Baetutg9ZPrnMhCtsUd7CXWWuTywpNqK0axmwrckESU9Nd9Ecnz54CV3qOgDucOMpUvg/zc7Hp8QGwXaX0kdcXQnbiQUUJAoCHS1kAm5KZNHl4iLdu0sGUjkgym1V+mSAWhIGbsp2RivChRRcV21oLMBQq2pjouNKG8uYRD2JQkUIG7yVJpmixJd4VcKvp3Mzlei860+2cBf2FkRO2XbJemYV3kC0KYOyUlpeX0QxLrjwM3gwkue9xD3UTOLjiJ8vXt/Nq+7A1cl7qtbF1IsdGb7iU3NR4FEE8JgRp6NqBUjzuc2UuOjB7G8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8Sdi+Mjyw7Bgzq7oGaLUd1mt6x4rF27k9S4N9IJzSQ=;
 b=NESekU8p4q0hLsBp2JfXVuB8T2iW3MivC8xD/x7495dd1nnHZPeYUUWZjcEwOIPPZLLOWHKp1wTzb4QBEulb+Ep+/zDkTcjlnTq0u8l0XbZJzZOwE5U6BbPCpycvHk568xHnvfAKO4q9+6zcBog5RWWE1DH5nAO6mw4AnPFQfhYlft0n1jyZwU4KQlUc5UypZseEyiVeSOMZ3LUcm/lpTQjoAFm6E/6iQy5kYrY4Ex2Je3HvZ51h+F5Dq47vrquLqn7EXb2Y+Gy8hYTzarPuj92IAy/vXH0YWqYLgWGs2IkgkQX0ION4LiwviHwn90Ln0JM7H9j3viFxY6dk1MYdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8Sdi+Mjyw7Bgzq7oGaLUd1mt6x4rF27k9S4N9IJzSQ=;
 b=lnX6bjPkLyV5fTFbtwD5/dXfYCxW1CWWi/DvaOOKZjunvRLxnwoxIL0gp0Hw1PXXgaeoVA4HIcTtgDieN6sk7P97HO781iSoOocEup9GcqNuSl+D+AvBuQpqIIexUbNa7zuu9C8jYr7xun+Kl4E3JN7Bw61jm3GEDS3GBfS1f/I=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7479.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:41b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Sun, 5 Jul
 2026 16:45:04 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Sun, 5 Jul 2026
 16:45:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 17:45:03 +0100
Message-Id: <DJQSF84B204K.3KVYKIRG35SY3@garyguo.net>
Subject: Re: [PATCH v5 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-2-d0961471ae50@garyguo.net>
 <DJOLKP1V1IDU.1GWHOHBG9CS7@nvidia.com>
 <DJOXUW6ODKCI.1GLNDU00TDJWU@garyguo.net>
 <DJOYL5QPEM76.1N99BVDVHB8VS@nvidia.com>
 <DJOZFG9XDNYV.1Z0BXKIODDTAF@garyguo.net>
 <DJQOWA2VOJ3G.2YGSYJGK7HPBJ@nvidia.com>
In-Reply-To: <DJQOWA2VOJ3G.2YGSYJGK7HPBJ@nvidia.com>
X-ClientProxiedBy: LO4P265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::22) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 861e1c19-e0af-477e-4c92-08dedab4c35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|10070799003|1800799024|366016|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EZ77z2F866ilvDrW9Tb9xCYy5y9eZJiaHJcXN7lsQWVejHg+zcxoCl1Z+D+HsB9FfoWKY2YlKj3Vf4JHnCfY4tCATFVG1LfLTxzGUm9svcrvW4CxF7BmSUwRtHD+dDXv8WXLfUaRfziwrCrGyDZjHPg9PzsHGxjjYilRVjxDk1EKudFa9bnexaudF/bCBM0ltktiH/lkpZyNmmP8yiSbmjTF+my+d/Z0j0z/ddDZ2s+67APwlUHhPXed5grXbCNqQOK+h/UFpqsGNlxkxVxd/C3IzlYMFKCG8BSOI55XqzwDLwzmUI1BxP+guwwyVYWOIDrn2iwioTRgxBOB3kTKeHZSF1nV5BQrzmDl534zNqUD3PbQwQV4nenYCQLGW0CXIuR5MhlCVJPrpGK9mu5ltYwbftCRXL2MQSFHHsY9QciOqW6B8g2ofHrTV+9xX/tMGKFLhkddk2uNCxvS+8nWrZZ2vH9eZg7paoBPaM4lv/spUwC/IlDj/z3P7nDJ2oIXUXU1RiDEpFr1sAVXkdtARBneMXn0jaskISZ/R3Y69WFlbq4eN075fiSNXxXHS0ZFWlr89CpDQf5A4PX1ZiCg04Qy3zwqBas0WaXxWAutyng=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(10070799003)(1800799024)(366016)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlZwcUxQTEtaN1M2Q1pqK00weStRMWk5TXE2OEJNcjlhSjhQc3BRb0x1Nzlt?=
 =?utf-8?B?WkdnVWREOURzT2tXeUNTV2hjTDJmZ2VYaWFtSFptVG9rZ3JJWGQ1Q3FFdWlR?=
 =?utf-8?B?NlBVZ3ZhU2c2ZGI2SWdMQ2VrRnV5MVRPTE5MK2JDdGNTd2JtZ2RpQTZzVWZ3?=
 =?utf-8?B?T2JPYWtXN2JCWFlJQlB1akNDU2x0amF0STZLOVIxTlNUeTRCZXAra0NPK1Yx?=
 =?utf-8?B?TDczYm0vM0syNkp5eTJSdFBQb2lDSlpCa2FMRFR2aE9CakhVQXdmb2krZUlX?=
 =?utf-8?B?U3FQVDVrY2RPYUtvUEFRcVUyZ2NuNVV1OEpqZjgrYXJqYWh6NzVja0hlTnoy?=
 =?utf-8?B?cERyTlhBYlF3M0dubWFNUWZLaHlXRWIxZWFpdmJlQU9lYVhpakhkVUJDU3ZZ?=
 =?utf-8?B?ZU12KzMzV0dZRUg1d01ETXE1VW0xaVdFdXpKcVcyc0dvakd3T0FtZ1ZEODNz?=
 =?utf-8?B?Zm5JTDZGendPT29XWjdsY0RhYWVWSWxla29aN1Z6MlRiQjNsd1REMC9ES252?=
 =?utf-8?B?Y1hzdDU2bmJkM0xQNGd5bHdKMk5Ld2pKeXRZVU5TM2pHelV2LytmS1k3S3BT?=
 =?utf-8?B?dmgwajdVVThsUFlQZU1pS3dOSE1Va0NYWHBQTXRIdGdiZklqcnE0bEVUWGVI?=
 =?utf-8?B?SEtWUUJRdStBRXdMTHJXblRxRFQ0bEdMRWNTTklWUjF3MHpMbFU0VURnTVRE?=
 =?utf-8?B?WTZ0K0pwK053ZmFVYnNzVkdDdERJa3diRW5pRlMrd05lWGhUNGVZRFRWcGp6?=
 =?utf-8?B?VWtVSCtNcEdlS3VuU2lIZWRXdlYvanBHUVZWVENQTmU2bkVJc21IbkxXQUMx?=
 =?utf-8?B?QzBCQzBJZ2pDYzhlOGtqMW5ldTZ0bjFHODhHN2psczh1WFpVMlpiSUUxMTlq?=
 =?utf-8?B?cVFtbWlaSjZ4b2c1NWVPVUlPRVIwdm1kenpjTDhwd1lvNDRza2pkc0kzajBT?=
 =?utf-8?B?MFo5VktxQlJLOUQrdjFPbFFGZU9xRUN4aC9xUTdCSzc0ckZuN3NnQy9qZktm?=
 =?utf-8?B?RXZCZWRuRGxvbWtkT2NLMVhhR1JOdHBHclJMVUxRdUd4a1llclRZeTFmMkFa?=
 =?utf-8?B?VU9IUkNhcC8zc2kyRjk3ZW53aXMveTE5NDZFQkEramdscTBvMDlnK05vMm1K?=
 =?utf-8?B?dExRQnRlKzlaRDFlWVR3cGphZVF1dTJwcmZaZ29OK3RCV2YxWkp0TWlsOEpG?=
 =?utf-8?B?YzlYZWMyUW1GTW5qUW41cWJrdjFZVjBTM1UydXFuM1RkNU94czBlTmd4Y1h3?=
 =?utf-8?B?VWhTdDlmVHFkNEluY2RXZXRvaWV1M0daaGhpZTVtWjVkL1p0OEtxa3gzQVAw?=
 =?utf-8?B?VTczSUp1V2Q0VlBpNmp6ZDNJVGVvS052cUc1Nk5tZGUxOGoxSUh4eEJjNkQ4?=
 =?utf-8?B?NEFOcnhUZkUrZkozVk03dnpxRnI3UHV1ZFI4bTNrMWovYXZ2cGtHSmplS1RI?=
 =?utf-8?B?anBjOE9NTTNIZUhwaXBqdWlGMGZmTEIwbEE0cjdTQjNzVU1vS2dRQmsyOVQ2?=
 =?utf-8?B?eEttU1pMMlp3aGVQOUtja1AxY3ppSjFMWkRuT2Z0TzdPRVVxMENPOGJHOVhn?=
 =?utf-8?B?RXdqdE83ZkdqaVRzWS9JV1V3Z3phaGxTVXZQTTFIYitwa1hGYzJWOXV2L09S?=
 =?utf-8?B?bHV2YklwZ3NIOXplbXlMUTlVb3NyeDliak1IcDdiaWx1a00yR0J4ZEdIQ1Bm?=
 =?utf-8?B?ZEVuS2NKK2VMamVLMWw2dWQ4Ui9HL3Z2a01VMmJ4Q2ZYWVBhd3gxbTFLdlU2?=
 =?utf-8?B?TXhMS2hLS1g2TjhoS2cwdEpDeG55UDlzVjFwS3ZYamNabWlJMjN3ekFuTUZI?=
 =?utf-8?B?RFhiZGhyRDUwQ2k4OUFyK3h6aTYxdExnUmZtelJqQXpib0FiRTBHSnFGanVy?=
 =?utf-8?B?eXJmdWR3c2lyU2lUejhUS21QRlhrMG84YmlpY1JaSFBiWE10SktQT2djL1lR?=
 =?utf-8?B?ZVRncVNkVy95MzRpaC8wK1RkY0h3R1FVcGxBYjhLUVd4SG1yaUJKN3BvZ3JI?=
 =?utf-8?B?Z0Q4TFFDZGJ2c1ZSWURZR3lsdFIvTm1JLzlIRGlQWUtTNDh5aE00d3dhL1Jo?=
 =?utf-8?B?cm9xTVRSdmhkVmJVNXh6c05UQ1ZDa0JtdmRBd0dNQXhlcjV6Z2pkWUZURHlC?=
 =?utf-8?B?cFQ0ZEY4UWRiTmRBQmVhR3M3NDB6Ung0ZW9VZ3RFWXdCTkNvalJOMTJuY0Mw?=
 =?utf-8?B?S0ljSjBURHVpS2JiVmFHZWFkaVJjYk5GaEttUEdHQnpjZ3Y5aG9icVdxOTJw?=
 =?utf-8?B?eXJTaGZjVHRwVU45WG9IQlJ5QXdiWlZHQjdyZlpRbk1ZSTVOVjdsdzdMSFRK?=
 =?utf-8?B?U1Q4Ui9zMnRSRlF6SzVMQ3VsY29rZW9oRUNNeGtzTmFYYVpQaG9GUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 861e1c19-e0af-477e-4c92-08dedab4c35c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 16:45:04.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywR9br1V2Xz9CUURa2iMCr85snfXtjcROvkxKwqcvMRJRNgSV2ez9+ocyOOee+nRyWZELXQ8zsgs7niRSgMMlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7479
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
	TAGGED_FROM(0.00)[bounces-9578-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_RECIPIENTS(0.00)[m:acourbot@nvidia.com,m:gary@garyguo.net,m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F29870A9B2

On Sun Jul 5, 2026 at 2:59 PM BST, Alexandre Courbot wrote:
> On Fri Jul 3, 2026 at 10:49 PM JST, Gary Guo wrote:
>> On Fri Jul 3, 2026 at 2:09 PM BST, Alexandre Courbot wrote:
>>> On Fri Jul 3, 2026 at 9:35 PM JST, Gary Guo wrote:
>>>> On Fri Jul 3, 2026 at 3:57 AM BST, Alexandre Courbot wrote:
>>>>> On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
>>>>> <...>
>>>>>> @@ -309,7 +312,11 @@ pub trait Io {
>>>>>>      // Always inline to optimize out error path of `build_assert`.
>>>>>>      #[inline(always)]
>>>>>>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
>>>>>> -        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_S=
IZE));
>>>>>> +        // We cannot check alignment with `offset_valid` using `sel=
f.addr()`. So set 0 for it and
>>>>>> +        // ensure alignment by checking that the alignment of `U` i=
s smaller or equal to the
>>>>>> +        // alignment of `Self::Target`.
>>>>>> +        const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Ta=
rget::MIN_ALIGN.as_usize());
>>>>>
>>>>> With `Region::MIN_ALIGN` being `4`, my understanding is that this wil=
l
>>>>> make `read64` and other infallible 64-bit accessors unusable on untyp=
ed
>>>>> I/O regions?
>>>>
>>>> That's correct.
>>>
>>> Isn't that a limitation we may want to eventually address? The fallible
>>> accessors are still usable, but it seems arbitrary that the non-fallibl=
e
>>> ones stop at 32 bits...
>>
>> It'd probably be solved by having typed regions. 32-bit is the most comm=
on
>> alignment for I/O memory, so that's chosen.
>>
>> None of the existing Rust drivers require 64-bit accessors yet.
>
> Mmm I'd like to see whether we can't make it work for untyped regions as
> well, but since we don't have many users (nor do we expect many to come
> I guess) this can be a follow-up.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

See https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/top=
ic/Generic.20I.2FO.20backends/near/601402429

However, I'd prefer we eventually use typed regions.

Best,
Gary

