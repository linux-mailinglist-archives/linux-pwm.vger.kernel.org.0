Return-Path: <linux-pwm+bounces-9599-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jc9KCj6kS2p7XgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9599-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:49:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB614710C54
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:49:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=PLUPTnGj;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9599-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9599-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 260AF302B59B
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136DA434E31;
	Mon,  6 Jul 2026 12:44:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022091.outbound.protection.outlook.com [52.101.101.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27A396B9A;
	Mon,  6 Jul 2026 12:44:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341885; cv=fail; b=mvBcI26lgyKP9q4c4La/b0pMcoPhFFcZKWuQeTmL+KIcAbX/m2pH1VTcI8m6uH8BDlQkE/nK3fQME2t1KDkDwYr6UbvI6H/W07Ql7cdwn+empVmG7UNTJkz0nLrX+v4SDC117JUAQ9ZL4++7IvoZIQfa6i0ifY5c5kkJfxb0H5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341885; c=relaxed/simple;
	bh=16GCSXuqVKmNPDFmCNxg/g4KmVvz/vbabZEZGZDKj3o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FTevbb5qhVrXcH+orQDKWm8WQzDjin8umQ9lZw33OMH1Z/q5coKswMUyxJfRCrMB7CQdnWGKg/qvAzZw2Ky0uz4fAFqdspViI3ocqFlOM0zz//O1SavVIc+EETbAXbHyq96t+/VSlioRy2hLzxd8CCJTiWAVvh19QO1IrdYIwVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PLUPTnGj; arc=fail smtp.client-ip=52.101.101.91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQHpkyQWjOeMq2LGtzykR1I1QZix3iMdZ3dyzxYH/6RcNlkyomS+Q+7/A41KbVLsR/XeIoZGzS8bytCtoOGaq0WdP1PSWozhlPR4sTQ7r8tHffBa+wzVsN3WcfBKd1fHjDzrKGPKPwAngLpSlY4GJvKNsc2DOgeOPlkXJrQW0F81rs5Y5qNhf0AiwvDWerB4TQH25K7cur7CYb+tf1yn5az8oR6J7OvWvri94okmN3gsAn9z+y50MXhMN7Ayn1nGHRn/Q5Sj4S7TKkvPqOJpC6uVzOPBrIlSj7btkcgjB3IhW9MJiiMd65/bv7BfuF8Hn1UUJJ9TkPFQitroxHpDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0o71iTJ7xkqAWRZhOi3sSHfh6UxcK6oHcJ/hcNXhGY=;
 b=nN+Xo922vfJ+PgbFt19P+Cf0rQkyQfpykUQGZczK8yJkQg+H3yk5+LQdpgIBa7pdlTuLj5PbyAtxLkZGtaVxQEG6RzJ7frCW+1O3rBYPWSochjBd5jZ327/o/5adtahHtPmeQgX9VaCyXgyVvh3EXgxbEPEHKVzsWPGLN4MUC8vQx+YQFLtFK7WU+6mz50UfE8LPG1+SzH4+p6JcNq1ktvhDUlbB0IygrGPqhuMj/PSBAonSG6RSZCNgNQGlxbnpkxP/Jv3Ith4PI2pIYYeg1in3WMnqtygOcwFCKSupUPt2OTmlYzzpz8T3hkUVfj6kXf9SPHkVqKI9zUyBxCbelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0o71iTJ7xkqAWRZhOi3sSHfh6UxcK6oHcJ/hcNXhGY=;
 b=PLUPTnGj4fdJJaXHj03JezFg9XpXrXhS9enX6anGfRRxEocfo62EvMXijHkHu/3IZ9klIBMknqakoMTgiZj1hwsD+OMMNRTpxrjZracznedzhRfT/+kcPHsyC+NzZYUwKvbOAe+ETH1iKuWdgmfrjF5eiwEGIMOT6lhOK4Bd/2Q=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:29 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:29 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:23 +0100
Subject: [PATCH v6 10/20] pwm: th1520: remove unnecessary `deref`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-10-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=1792;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=16GCSXuqVKmNPDFmCNxg/g4KmVvz/vbabZEZGZDKj3o=;
 b=Ccinf69zroadXkKFonx2iz/GJG0NW8MSczutqKLYGJ4niV7leuBZMCt5aep6SaKn8U8rgA7sO
 RjtiUAU6JboDUxIcvuAYwHXXecynYi5+MPu1TqneqNfduKIGi7+8Hia
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
X-MS-Office365-Filtering-Correlation-Id: 303e65b9-2205-45b8-226d-08dedb5c51e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	VJVl/ih6iu66pUB/jLMtkw27W9Vz9UI3ygVy783G5uW83P6UhTQVZf8F1IREtoFz4+x9VXqZd0OYb8I+AkdZuaDweovbNdh95N+MB3X3JOC6oG+NU+Ti3AQLpC27x7cN/sW/mqDjvauuwWtaHXll2eK//6G6eIcquvZ7kwFAtbV/t9zH2PlYJLMQbupK6f8XGtmsXmIWNaoHDAkyT9950tQbRUIWV225vlgnuSVAMbTom7TgQVpkSUJZVWYsaIs8b+g6BkBOKJRrJv5sIPrqxJXznl/pebcMHq9P+ipwPNh/K9mz9rOU+7vj6Wq/bETzXEaL44LGZCdotPT5/AHkcOaB9hsz3yJw0UF92CspWjA7B5aRRu6UXaeii8VqyZHl5HNBKtBoGl6OvYVHTm6z+6b2V8UpPWoHSLRynD6e9hPbugL934M7x1SQKYerV/ka5CzUZb63GfAG3RL2SNBFSRyo4Sl5fh+HvLu1dxmJODnuZE5qZSJ/prGjIJjodHv3Q5KpBnq3mLHN6tuQHsxUnp8Mcm8cDeSaDw3w94IzsIFgt1E6KBNKfdrpTC3HicgZfIRnVxDDd63POkjnMev2qg5OM/Ii5g0L0GC5G6PkTVIJoWDfqE7RCv/0hkVJD4+er0ZWhYBfvhTIhbtOFDWJvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tmg4dGdBencvVE1PbjBJRGo1MkdUQVV2WTdpUmNZczVFcmZreUlicWNiV0sw?=
 =?utf-8?B?WkY3UlhjVUpaV0NoMkhqV0htS2luYzEyNWlQMVpBL2ptYXpSMm1ZMGJFNVhF?=
 =?utf-8?B?SExjcnNyQlRqemd0aTJxTjBlQ055WmZ3YUJFdmNxRTc1aEU4OUROcE1hMTE5?=
 =?utf-8?B?eWxIcnFwVDdTczJmWWxvNndsd2tMSWdtVTM1dGFUOWptTzlnU2tZSG5wQU15?=
 =?utf-8?B?bXpQUlF1V1ZpK01acGc3QVdkZTFsem9EWE8xSHpBZEExUUp2dXJDUFpvUkRJ?=
 =?utf-8?B?UERVMG5mWDdVZFVwcDh3b3RtNDBGR3NWUkYra1VpMUxrWGpZd2Y2dDRiNFYw?=
 =?utf-8?B?NkI2K1l6VGl1SFQvem4va2JMemhUSDE0VVJSdmlOSU0xcnBqZWVXczJzUWdI?=
 =?utf-8?B?KytqUlcwbk9ZaHROdEtqazR3TlYxMllJYU5rV0Joa05oMTJrMU1uYmhhN2Zl?=
 =?utf-8?B?bW9RVGFqT281QzBOeFNUUkN4VitDcllOdGxMNy9QY2hyZExGWElTSU9XVGx4?=
 =?utf-8?B?Qk5TY1NLak54U0NrSlBYVWdhV0hSSkZ2RFNRR2JyVytEa2NjdWhwUS9sSHgz?=
 =?utf-8?B?OXVPYlkvK084ZDZuNDBhU0tETDNBTVBDRTYyZlJLNTJpK2sxVFRBOU5DcDVm?=
 =?utf-8?B?SHAzUE1hNS9VcDU5Z3I5dlg2UGo2TTBMWVo1VFVtUmFucTNMeDlkWDRYUG4r?=
 =?utf-8?B?eXhWZlA2RWNJMW5iWDh1bzI4M2dtWlE4b1Y2V0xIdkJOTTV4eEpGNE1GMmRL?=
 =?utf-8?B?Tm1xTUVDWDlNSldRWSszQkowOWh2K0xuT3pYREt4V0cwSkd6bFBYU0R4SE9u?=
 =?utf-8?B?aisyNS9VeU5UWU16dGhRRlpNOXJoVUtYMmJrZHVWNXFlR21KcW02WlBhS0tD?=
 =?utf-8?B?OXV4YjJJVXdSWTZTTVpuYWJyQkIyWk9YUVU5SWlwMDc0cXFPZEs2Zml1YUw3?=
 =?utf-8?B?V2dPRFZYT1RIejBPZy93Mjh4Y2kxKzN6Zm0xY1pXK1JXVmVVMTdrUmk1VmRu?=
 =?utf-8?B?Vm1CTVNLRzQ0dzZHODIrUG1sRHpEY3oxT0ZpZXlPRnF1Nm9mVzVaWkExOGxD?=
 =?utf-8?B?ZFlMOHZLdmhzN2puZTJLUlFmbHpMaUc1RDRsVkZSRGF0UGRneHlXeGN3SU9O?=
 =?utf-8?B?OS9lY1huSWlGVGhNWU9sWWl1VkdpV0hQSmJDNlZ1VTYwL1ZRSHRyYXhSZytX?=
 =?utf-8?B?YnkvNTZlV0d2NlVsVGJGNXl3dG8wb2ZST3VJLzVoQ0NUY1B3VmpmeUhRNU8z?=
 =?utf-8?B?SkF4RGpUVkZxSDA4MUtwNjdtOU5pOVlLRVpzdFBGZlJoa1U2cVNNMDZ4SmVa?=
 =?utf-8?B?NHA1eSs1ZDFvWVNWQVRhWGoxMzZiWXZSWHpzVWRKWTlwbkpwTDZVKytEUXdT?=
 =?utf-8?B?Mm5DVEVtUHhqN3UyRThzbDQzV1JxcE4wbDF2M1AwNVlsLzRTbjk5cFFmKzBn?=
 =?utf-8?B?cWtZZ0VSeUJ4YTlPdXVGM1N4WHB2RlNZMkttb2Q1WGl1ZmRka3NGczJPeCti?=
 =?utf-8?B?OG5NaEIvQkRNVFpubGtHVWRBVlJ4QXgyWFBtZGZraWQ3RVNpa3R2eUVPcjhL?=
 =?utf-8?B?aVFLekFuQ29DeGx2RzhDT3c1c2tDd3BQMlc3QVVQbDNjWi9BQTJHV3ZGMFh3?=
 =?utf-8?B?Sk5KMWxaNWgyRmdWdDFuWTBWUDU0MkNuZGNNbkVOcFQwMnFRMjlRNHJVZDNq?=
 =?utf-8?B?Ym1UbDlyWms2c0orNlczV2NIUEdSazBrK0FnSVNQNmEraUlRdE81UkpPSXR5?=
 =?utf-8?B?RXNVKzk2QkViUmlzUkpSQVFJcUVZcmRCQVFoZWQ3czhLMEJza1JGQ2lQc0F2?=
 =?utf-8?B?aUxEcEdWTXN5czhNTi9ZZFpyN0FNeERYc0JzSmhBRWltaFZtSkV0b0JDRVRY?=
 =?utf-8?B?TUpFMjgyK05PSWpWQ3UwVEYwSWlZd3JaZk4zS0VkSUVsUUxjRGdFVUo4S1Fa?=
 =?utf-8?B?MFduSXdqM3JDdVJrbmF1Ly96a0dKUW9SeHRoaUNhVWZJTm4xTHZJbzhROVNs?=
 =?utf-8?B?a1dxeGFVZ0t5QlBRdy9QZUNrUzZmdHZBa2xqeVpMcURqM3pCUm5Gb2xlVFdY?=
 =?utf-8?B?N0EramZvbGdtOW5OY0dDT1Y4TkJ1cXMvNW1zK0ordjZwRzFVQzVBY0xHa1hh?=
 =?utf-8?B?YmNnZEVNOVJsbDJGUWZVMEdwazZNMk9kMW04SkFSdVEyS1JFeURuL1Vka0Zq?=
 =?utf-8?B?d2VyWGdtUHRneXpsQ2E2Z1RHM0txR2txb2FqSEp6UUF0akFjaU9JTFFhZFov?=
 =?utf-8?B?SlJ3Qy9CRjhLZE03VmxxTnpqY0o2dzFYTC91QytrTE5ZOHJvdEhsWnpwWFEy?=
 =?utf-8?B?SDZMTUxUNjNJWTY2NjlnVE1abW1WTHJhai9hdlFzSnk2aEFPdG1hdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 303e65b9-2205-45b8-226d-08dedb5c51e8
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:29.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/26RfOzDh3UHpbKvUog8xfwsOJdRcKKTFAv75voJ2tHwJ+AXbIWY5xv59eB+4Yt+B85f4niB2GXfISryc1Dgg==
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
	TAGGED_FROM(0.00)[bounces-9599-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB614710C54

`Deref` is automatic and should normally not be used directly.
Also, `IoMem` is going to be implementing `Io` directly, so it will no
longer to be implementing `Deref`.

Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/.E2.9C.94.20Projection.20in.20dma.20bus.20address.20space/near/606672061
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/pwm/pwm_th1520.rs | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 3e3fa51ccef9..022338d17218 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -20,7 +20,6 @@
 //!   this method is not used in this driver.
 //!
 
-use core::ops::Deref;
 use kernel::{
     clk::Clk,
     device::{Bound, Core, Device},
@@ -213,8 +212,7 @@ fn read_waveform(
     ) -> Result<Self::WfHw> {
         let data = chip.drvdata();
         let hwpwm = pwm.hwpwm();
-        let iomem_accessor = data.iomem.access(parent_dev)?;
-        let iomap = iomem_accessor.deref();
+        let iomap = data.iomem.access(parent_dev)?;
 
         let ctrl = iomap.try_read32(th1520_pwm_ctrl(hwpwm))?;
         let period_cycles = iomap.try_read32(th1520_pwm_per(hwpwm))?;
@@ -248,8 +246,7 @@ fn write_waveform(
     ) -> Result {
         let data = chip.drvdata();
         let hwpwm = pwm.hwpwm();
-        let iomem_accessor = data.iomem.access(parent_dev)?;
-        let iomap = iomem_accessor.deref();
+        let iomap = data.iomem.access(parent_dev)?;
         let duty_cycles = iomap.try_read32(th1520_pwm_fp(hwpwm))?;
         let was_enabled = duty_cycles != 0;
 

-- 
2.54.0


