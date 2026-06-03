Return-Path: <linux-pwm+bounces-9234-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8rl8O0saIGp5vwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9234-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 14:13:00 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C27E6375EC
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 14:12:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=ZuHcGsqV;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9234-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9234-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F1C631037DA
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2026 12:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55509477E28;
	Wed,  3 Jun 2026 12:04:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021120.outbound.protection.outlook.com [52.101.100.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3076A477998;
	Wed,  3 Jun 2026 12:04:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488250; cv=fail; b=vDfleFOX9qMMswToraMWHjvosPyY1pcijT0cUSCLRfx7oK34sxUOzKqjvsHPd9CHLVICMN008enA2aB2DWRKyFXGzskOKXC4U93oXDYmXHZFCkkIkmBWX3e6gxwiUciFV3LIqoDh9cGz+SnHW4yRacO7tnRfkpSfV393VVLZDzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488250; c=relaxed/simple;
	bh=kdFdqV7npzFWu8XMUYzxY+6ljOGh1qOQRSAi8ikH6w0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=U3uF7IobQLyMF7lgd1FYWzXwqiKZrGam4B9/AXb2RQ/zBrOaKFBO1ln78HRzWcs7LFruxZwCy4aL2LZwaRNeCLy+TbRJDc8ua47W2FR1h0sdLO/IWH96ur3fmNjWGCNnKfbZfEpHxU1Bbb4+ng/XJsURvrqQ+uazsIQzdN8biqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZuHcGsqV; arc=fail smtp.client-ip=52.101.100.120
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3ONyqCS8v4THNb6N7XVci4XLtqRA1B0mKJM9tV4SxcIG64660pQe7vlicjPRMVlE1Hz+BDiA6sOmpcL/mayswHaiM1GpYDnr+pLvRHifQ7ZWUdr8r8sXI9phUI9jisIaMgBYokQMGblmLijVW3fNR1G5uRQli/rEe1hc0mKvcHfJ9UfiIp7XRj067DS+7H8KaQ/x6pdBadHnTRjP49i1nTq9NnkVSo4S+Q4zGeb+bBwxKFnFHFCqdBfJQpeFQBz6AVFViY2WQ/X4c6X+PI291e5wbPB+6xfQyfToK//VAfyeUKOAzWsvM/WF8TwJYw50OjXsTdlK5mIJK+WTTUmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Sv0XSsxxYkjvpjPM50u7h1RMJU0UqasupDVCsyHKVU=;
 b=K7qb/gtgMEAfKpue7BaUWHnB2pVOuWLhWHQM1AcWqXXcKMV9ZvD6VugMe864I8qcH94edRnmw5i8ScKNQ9E9y0kguc9auuknVCE6Lv+o3cBpGTPZiGZaJu1IUPiuTZ57hCPM13tApl211v3Bt0Hft+24rXocBHMggwfc4KwXL6tMGLvxQrqOyNRP0MOEHF1MW4U9s5Wvw1kAFkExSXqynS1ogxFijspRkQmhiioIF2jJ4X8EyPVHqfzlryq137MgHf3tXNaqOzG4p28aK6S5xHGyS22qUBp/InbkCrwYwFUzEmssIxPp4ciHHqcwOF3r/GzjVuTJTi1kXdC0AWnplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Sv0XSsxxYkjvpjPM50u7h1RMJU0UqasupDVCsyHKVU=;
 b=ZuHcGsqVeJ1kuHjlTkHJNgGoEYh7LpW76JvUQN0TbYEEMunbxwV6WCTJ5kLZcju0ldJFFR1no5eNmqA7KFLKJ8WEtNUE/AOMAlhdhxxnBxZPM02bAJx7VSsFb61vhbyj8Q1zM4rmzCpCOu06K/L4z1+fn0onz+zCp51C9Wa3aAk=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5205.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:254::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 12:04:00 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 12:04:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 13:04:00 +0100
Message-Id: <DIZEELOBB4LR.10A39CE4HO616@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] rust: types: introduce ForLt base trait for
 CovariantForLt
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
References: <20260603011020.2073650-1-dakr@kernel.org>
 <20260603011020.2073650-3-dakr@kernel.org>
In-Reply-To: <20260603011020.2073650-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f40b577-ef4f-4560-7ea9-08dec16832d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|6133799003|56012099006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C9bo/d2T4ZisS9Eke/udgiYPCoo7OeR5m7WU5/IBM8KcZdx92E9x81DewOBeNugh5KJiY8oLapGmGlryounWtQ3eAfapns5qHLBIvaVkte5NwJ80rbMX4NHsA4aiQndT9cRQzlvTpahw1Isve9+3+lSQlh/cVVj8/Ooqa8Y0iKm9UZooULeTYaIVRHLBgbj2hy27sb9yveBgpUu9Yn6jZKiDsrJok8h8bhaFKf+ue8W3W8FH1KoNWuX6HKkcxrCYpgMzjnuWMjKvZ7tOtvoLY3VAxunMLMQqczT/tYgm206aoyx3acHEiYT1rmKqpaf88wxoDaGEW232OyUsop4//YW1PtkIu4uMkW+v2CQO+kMB0UBkkSwqf9Mykei8K7mYwChIbQpc/V+3t/4yK5T2G2aCGqqPYQ6/h+2JxWoZedYNuS/lfVCZvPrpRxwIWbqkqajdDXcVr8wSwE/888OVZ3xyFaYiFVYvlCe2Tno6kSAsdN0XI++EcCXWG0B9RajSPhEkPXhRnFsbZJPr/8KNlOHQB4PJX/k6Qg9p24zogaAPRMq4XYozNfFKBWB51yyprgCq+GVwJGlDx/gEVA3mw+PkEAxDkVVaDexsaxZrI/EGmC8k5zlEBO/86M8ls6sXafHwlMM6q0tzOTOFTI20lZYvcCnn0BpsX/dy9srZk58wlgKbMORiINzdTzdn+bbD29KfYNUrHNuPQLcbDtu2zxoIdW+ixbZ1esQu5B2AaVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(6133799003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTZIT3JMbWRCWjR1bUZHUWdMMUc4SVU4VzlwN3RxdXViM1dHb1YvajhwQ1RY?=
 =?utf-8?B?dnZ6MzlXK01UanNmajIvaWVMTUdBTTIzbEtnNGhLeUhXRktXTW5ITC80dTlM?=
 =?utf-8?B?Yzgya2QrQmw3cDlFRmdYdDAyM1E3eUZIaTF1OHZsVlRoclFpc1IrRW1wbVYy?=
 =?utf-8?B?V1NkTGdzS1lvc203dk8yLytLSkN3ZFg5ZU95MFJRSzBZQ1JZOVF3dmg5QlVh?=
 =?utf-8?B?eWtvQVo4WmtNMHRIbWF1T3N6SjBaTExiTVpXSExxN3lTMlNBQlQxdG5SZXBG?=
 =?utf-8?B?aVVMbXpLMThNVTRYMDljcGE5bmorYyt5QnQxS1llNkJiaU5peGJJWWdiRzZF?=
 =?utf-8?B?R1pmSWg1cGp1bFpjd0ZHVVRTSDA0c1A3ZG4xdnp3YkV4TkQwNnd6TEN2V24v?=
 =?utf-8?B?bFVEaTFkTXFWTDBEcXp5Qis4R2RDWXVrVkpna2FnYUErbFdzaTRCWjdQL3dt?=
 =?utf-8?B?RUtRRE8rY3U1ZG9Hek1mWnBndjBxU3BneU85dkhYNFJGcmppZWNFWEU5MHVZ?=
 =?utf-8?B?Znk3WHpzOWg4aC84ZmhUSVZ2ZCtDMUQyazFubUNjQkRBS3V6clJnZ1hzQk4v?=
 =?utf-8?B?QS8yWU0wcCtzeGVua0FJdUFQMDA0YkZQRjY0UXN3czk0dkZXbXdjSFljYlN6?=
 =?utf-8?B?a1dKdVMrakFudnkyaks0bjFXV3AvMGRRY3ZEU1g2aTc5VjRsckdNdDA5Q1JG?=
 =?utf-8?B?aU9JQmFhVG1HYVYwdVVQVjlqZktEV0Z1NTJ1b1JMK3VpSWZxbHNYY0tRSkJG?=
 =?utf-8?B?eVp4bTRyYUErTmpENk1mZHMwaGtKNStwU0hydEhrVFdUYjRhUEJ2OGdLLzBX?=
 =?utf-8?B?eWQ2Ull6RXJqNE5CMWIyRFdkbTZ0UWR0dmwyQko2ekxLSG1mWWs2QUVDUEl0?=
 =?utf-8?B?SzdBSGNVNW9JUWYwRnY4TlZUTzd3SURVU25FU3hQTVFRWnZYTGpScmpLQUZ0?=
 =?utf-8?B?Smh1WWRGQ3VPazI5NURYVnZIWTV6RkcyVXZsbnp3Q0tnd3FvM21ZQ3YzNVVl?=
 =?utf-8?B?SExpRzU0T0dzeEd3MGM3UVlacVFYTHJONjVTOEZsU0xxT0lVdnpIN080c2pv?=
 =?utf-8?B?QjZ1bURVYVNFbDY1WTZYTE9pZnBIaWNtdjJEM0kzZnNvckNMMVRYdExKQkVD?=
 =?utf-8?B?dmdqMWphTUt3N1FET3NBMGRzRzN6WC9vaytuYzhGNXBaUlNXbnJXWEpzMk1K?=
 =?utf-8?B?VUl2cTBmbFFzWnIySjdhNDRTcTZ1dTF5a24ycGJhUTd3QUlMNWdrUlJWREJP?=
 =?utf-8?B?ZnREZVIvMTNGY085WWFiaFNQd0EvaHBKdmdOaWNnWHZNdnJCamVwaXlMQzU0?=
 =?utf-8?B?bmxnMmhCeC9YSXhMTUYremI2SlVZOGdReVBIL0FhVTVYeEt0eWdOcEw1SFFY?=
 =?utf-8?B?QVJDVitKTSs1RmFvdVd0bEYxVzBTZ2ZpQVpYRkFxY2ZFelV3R2p2amFrWTJl?=
 =?utf-8?B?WDNwRlpjZ3NVL25BMWlmMFIrRnBrL3l5K1J2REJDWkRJR2ZhTXBnQ1ZtbU42?=
 =?utf-8?B?Y2dvaGM0V1ZwQkE1ZEpKRW1MV20xa25qcUNWSTlFd3pqbStxU0RUaTYyaEE3?=
 =?utf-8?B?U0treUJrQVZNdC9tbnZMWFBML3JGSi83a1Qwa2pjTGRxZFhvWkFsYXVKSTRK?=
 =?utf-8?B?Q0htVVhwM21mUXVGTDN3ekpNNDdNdkcvR1F3d2pHTUJZTFdOTEtSYXBPWURR?=
 =?utf-8?B?VHNKcTE0YlVoTzBYT3dVbFlpazVEcHFla2d0OXpBVlUwcGlHY1NoTGE2ZTBw?=
 =?utf-8?B?NTNaaG5TVEQzVHBqK3BFVDZidmhJQXEwU0w3NFNkY1NLK1l2SEJKRGdvMVlD?=
 =?utf-8?B?RVVxMjkzWGlrQVZCYkMvV3A1LzBMZ2hOeEtPMGFSdTdUYjhPNmJGdkp2VDR3?=
 =?utf-8?B?S3c5Y2djWFVSeDN2N0VFMWIvd2Z4NHZPL3htNWdiN3owN0xMTkx0VG0rdHd1?=
 =?utf-8?B?bGRBYnU4aHhBMjhEZnFQdERlR1FvTXdwRnh2Q21NaGNPdDZTVG1CQWNFLzRu?=
 =?utf-8?B?cXJ4QjBTWnJ4Y2lYTG56MTJObzBUb0REWVcvVzBDbkg5d2FiRk42cHlOdDBH?=
 =?utf-8?B?KzJOdys4Z2xtUUtVc3RVU3M5VlVPYjZJYU9kL2ZuNmFiMlE2RTMyblc1aGVI?=
 =?utf-8?B?djNqcWRWQ0Z6RTh4L1NwdktPOXY4L0FXZ2JZYXIwZXpFT2hYd2FmYy9HS01C?=
 =?utf-8?B?Z1IyeVBEU2VOOS9xS1hnOUc3Wm1aRWpPMGhkMWc4dk5yMHhlTFVtYUNoNWYw?=
 =?utf-8?B?YlhrbzBNeXJwc2F4REM1VnZ4RlduSHhZM05nRjd0L0RDTWRneUEyemZUMGE0?=
 =?utf-8?B?RG9MVjYvSElaMkp3MHVPdEpzR0xDNlF2TFg0VE9WSzBETjJ2SUNtdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f40b577-ef4f-4560-7ea9-08dec16832d1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 12:04:00.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzYOxFRincYFG9jELKPMF8RO2m5709y9rsSShBzLORuxRXllpsRCXWFkTez2ZHNogAKfy2Eo2y0Vml8XhCrt+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5205
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9234-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:from_mime,garyguo.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C27E6375EC

On Wed Jun 3, 2026 at 2:10 AM BST, Danilo Krummrich wrote:
> Add a new ForLt trait as a base for CovariantForLt:
>
>   - ForLt (non-unsafe): represents a type generic over a lifetime, with
>     no covariance guarantee.  Provides unsafe fn cast_ref_unchecked()
>     for callers that can justify lifetime shortening via a round-trip
>     safety argument.
>
>   - CovariantForLt (unsafe): becomes a subtrait of ForLt that
>     additionally proves the type is covariant over its lifetime
>     parameter, providing a safe cast_ref() method.
>
> This split allows non-covariant types (e.g. types behind a Mutex) to
> implement ForLt and participate in DevresLt / registration data patterns
> where the round-trip argument suffices, without requiring a covariance
> proof that would fail to compile.
>
> The internal macro backend is split accordingly: ForLt! emits ForLtImpl
> (no covariance proof), CovariantForLt! emits CovariantForLtImpl (with
> compile-time covariance proof).
>
> No existing callers change; they all use CovariantForLt.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/types.rs        |   1 +
>  rust/kernel/types/for_lt.rs | 101 ++++++++++++++++++++++++++++++------
>  rust/macros/for_lt.rs       |  50 ++++++++++++++----
>  rust/macros/lib.rs          |  19 ++++++-
>  4 files changed, 145 insertions(+), 26 deletions(-)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index cbe6907042d3..c1ed05d1046c 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -14,6 +14,7 @@
>  #[doc(hidden)]
>  pub mod for_lt;
>  pub use for_lt::CovariantForLt;
> +pub use for_lt::ForLt;
> =20
>  /// Used to transfer ownership to and from foreign (non-Rust) languages.
>  ///
> diff --git a/rust/kernel/types/for_lt.rs b/rust/kernel/types/for_lt.rs
> index ef510ab6c092..e1774b03dd1f 100644
> --- a/rust/kernel/types/for_lt.rs
> +++ b/rust/kernel/types/for_lt.rs
> @@ -1,17 +1,74 @@
>  // SPDX-License-Identifier: Apache-2.0 OR MIT
> =20
> -//! Provide implementation and test of the `CovariantForLt` trait and ma=
cro.
> +//! Provide implementation and test of the `ForLt` and `CovariantForLt` =
traits and macros.
>  //!
> -//! This module is hidden and user should just use `CovariantForLt!` dir=
ectly.
> +//! This module is hidden and users should just use `ForLt!` / `Covarian=
tForLt!` directly.
> =20
>  use core::marker::PhantomData;
> =20
>  /// Representation of types generic over a lifetime.
>  ///
> -/// The type must be covariant over the generic lifetime, i.e. the lifet=
ime parameter
> -/// can be soundly shortened.
> +/// # Macro
> +///
> +/// It is not recommended to implement this trait directly. `ForLt!` mac=
ro is provided to obtain a
> +/// type that implements this trait.
> +///
> +/// The full syntax is
> +///
> +/// ```
> +/// # use kernel::types::ForLt;
> +/// # fn expect_lt<F: ForLt>() {}
> +/// # struct TypeThatUse<'a>(&'a ());
> +/// # expect_lt::<
> +/// ForLt!(for<'a> TypeThatUse<'a>)
> +/// # >();
> +/// ```
> +///
> +/// which gives a type so that `<ForLt!(for<'a> TypeThatUse<'a>) as ForL=
t>::Of<'b>`
> +/// is `TypeThatUse<'b>`.
> +///
> +/// You may also use a short-hand syntax which works similar to lifetime=
 elision.
> +/// The macro also accepts types that do not involve a lifetime at all.
> +///
> +/// ```
> +/// # use kernel::types::ForLt;
> +/// # fn expect_lt<F: ForLt>() {}
> +/// # struct TypeThatUse<'a>(&'a ());
> +/// # expect_lt::<
> +/// ForLt!(TypeThatUse<'_>) // Equivalent to `ForLt!(for<'a> TypeThatUse=
<'a>)`.
> +/// # >();
> +/// # expect_lt::<
> +/// ForLt!(&u32) // Equivalent to `ForLt!(for<'a> &'a u32)`.
> +/// # >();
> +/// # expect_lt::<
> +/// ForLt!(u32) // Equivalent to `ForLt!(for<'a> u32)`.
> +/// # >();
> +/// ```
> +pub trait ForLt {
> +    /// The type parameterized by the lifetime.
> +    type Of<'a>: 'a;
> +
> +    /// Cast a reference to a shorter lifetime.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that the lifetime shortening is sound for=
 their use case,
> +    /// e.g. because the `'long` reference originated from a `'short`-to=
-`'static` transmute
> +    /// and this is the reverse leg of that round-trip.
> +    #[inline(always)]
> +    unsafe fn cast_ref_unchecked<'r, 'short: 'r, 'long: 'short>(
> +        long: &'r Self::Of<'long>,
> +    ) -> &'r Self::Of<'short> {
> +        // SAFETY: Caller guarantees the lifetime shortening is sound.
> +        unsafe { core::mem::transmute(long) }
> +    }

I think this method should just be gone.

> +}
> +pub use macros::ForLt;
> +
> +/// [`trait@ForLt`] subtrait for types that are covariant over their lif=
etime parameter.
>  ///
> -/// The lifetime involved must be covariant.
> +/// Provides a safe [`cast_ref`](CovariantForLt::cast_ref) method for ty=
pes that are proven to be
> +/// covariant. The `CovariantForLt!` macro syntax is the same as `ForLt!=
`.
>  ///
>  /// # Macro
>  ///
> @@ -84,10 +141,7 @@
>  /// # Safety
>  ///
>  /// `Self::Of<'a>` must be covariant over the lifetime `'a`.
> -pub unsafe trait CovariantForLt {
> -    /// The type parameterized by the lifetime.
> -    type Of<'a>: 'a;
> -
> +pub unsafe trait CovariantForLt: ForLt {
>      /// Cast a reference to a shorter lifetime.
>      #[inline(always)]
>      fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r Self::Of<'long>=
) -> &'r Self::Of<'short> {
> @@ -97,27 +151,44 @@ fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r=
 Self::Of<'long>) -> &'r Sel
>  }
>  pub use macros::CovariantForLt;
> =20
> -/// Helper type for the `CovariantForLt!` macro.
> +/// Helper type for the `ForLt!` macro.
>  ///
> -/// Must only be used by the `CovariantForLt!` macro.
> +/// Must only be used by the `ForLt!` macro.
>  ///
>  /// `T` is the magic `dyn for<'a> WithLt<'a, TypeThatUse<'a>>` generated=
 by macro.
>  ///
>  /// `WF` is a type that the macro can use to assert some specific type i=
s well-formed.
> +#[doc(hidden)]
> +pub struct ForLtImpl<T: ?Sized, WF>(PhantomData<(WF, T)>);

The `N` is still needed for `ForLtImpl` in case there needs to be a
wellformedness check. Currently the macro emits a `struct` to serve
wellformedness-check purpose and a `fn` to check for covariance, and the fi=
rst
part still needs to be kept (at least until Rust starts checking WF-ness fo=
r
`dyn`).

If you follow my suggestion in patch 1, you should be able to share macro i=
mpl
for `CovariantForLt` and `ForLt`, and just have a boolean to decide whether=
 to
to emit the function that check for variance.

Best,
Gary

> +
> +/// Helper type for the `CovariantForLt!` macro.
> +///
> +/// Must only be used by the `CovariantForLt!` macro.
> +///
> +/// `T` and `WF` are the same as in [`ForLtImpl`].
>  ///
>  /// `N` is to provide the macro a place to emit arbitrary items, in case=
 it needs to prove
>  /// additional properties.
>  #[doc(hidden)]
>  pub struct CovariantForLtImpl<T: ?Sized, WF, const N: usize>(PhantomData=
<(WF, T)>);
> =20
> -// This is a helper trait for implementation `CovariantForLt` to be able=
 to use HRTB.
> +// This is a helper trait for implementation `ForLt` to be able to use H=
RTB.
>  #[doc(hidden)]
>  pub trait WithLt<'a> {
>      type Of: 'a;
>  }
> =20
> -// SAFETY: In `CovariantForLt!` macro, a covariance proof is generated w=
hen naming
> -// `CovariantForLtImpl` and it will fail to evaluate if the type is not =
covariant.
> -unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF> CovariantForLt for Covar=
iantForLtImpl<T, WF, 0> {
> +impl<T: ?Sized + for<'a> WithLt<'a>, WF> ForLt for ForLtImpl<T, WF> {
> +    type Of<'a> =3D <T as WithLt<'a>>::Of;
> +}
> +
> +impl<T: ?Sized + for<'a> WithLt<'a>, WF, const N: usize> ForLt for Covar=
iantForLtImpl<T, WF, N> {
>      type Of<'a> =3D <T as WithLt<'a>>::Of;
>  }
> +
> +// SAFETY: In `CovariantForLt!` macro, a covariance proof is generated i=
n the `N` const generic
> +// and it will fail to evaluate if the type is not covariant.
> +unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF, const N: usize> Covarian=
tForLt
> +    for CovariantForLtImpl<T, WF, N>
> +{
> +}
> diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
> index 3cb094d00548..ad9809563fab 100644
> --- a/rust/macros/for_lt.rs
> +++ b/rust/macros/for_lt.rs
> @@ -176,8 +176,10 @@ fn prove(&mut self, ty: &'a Type) {
>      }
>  }
> =20
> -pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
> -    let (ty, lifetime) =3D match input {
> +/// Resolve the higher-ranked type into a concrete `(ty, lifetime)` pair=
, expanding elided
> +/// lifetimes as needed. Shared by both `for_lt` and `covariant_for_lt`.
> +fn resolve_hrt(input: HigherRankedType) -> (Type, Lifetime) {
> +    match input {
>          HigherRankedType::Explicit { lifetime, ty, .. } =3D> (ty, lifeti=
me),
>          HigherRankedType::Implicit { ty } =3D> {
>              // If there's no explicit `for<'a>` binder, inject a synthet=
ic `'__elided` lifetime
> @@ -188,7 +190,41 @@ pub(crate) fn covariant_for_lt(input: HigherRankedTy=
pe) -> TokenStream {
>              };
>              (ty.expand_elided_lifetime(&lifetime), lifetime)
>          }
> -    };
> +    }
> +}
> +
> +/// Produce the `'static`-substituted type for the WF check. Shared by b=
oth macros.
> +fn ty_static(ty: &Type, lifetime: &Lifetime) -> Type {
> +    ty.replace_lifetime(
> +        lifetime,
> +        &Lifetime {
> +            apostrophe: Span::mixed_site(),
> +            ident: format_ident!("static"),
> +        },
> +    )
> +}
> +
> +pub(crate) fn for_lt(input: HigherRankedType) -> TokenStream {
> +    let (ty, lifetime) =3D resolve_hrt(input);
> +
> +    // Make sure that the type is wellformed when substituting lifetime =
with `'static`.
> +    //
> +    // Currently the Rust compiler doesn't check this, see the `ProveWf`=
 documentation in
> +    // `covariant_for_lt` below.
> +    //
> +    // We prefer to use this way of proving WF-ness as it can work when =
generics are involved.
> +    let ty_static =3D ty_static(&ty, &lifetime);
> +
> +    quote!(
> +        ::kernel::types::for_lt::ForLtImpl::<
> +            dyn for<#lifetime> ::kernel::types::for_lt::WithLt<#lifetime=
, Of =3D #ty>,
> +            #ty_static,
> +        >
> +    )
> +}
> +
> +pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
> +    let (ty, lifetime) =3D resolve_hrt(input);
> =20
>      let mut prover =3D Prover(&lifetime, Vec::new());
>      prover.prove(&ty);
> @@ -226,13 +262,7 @@ fn #cov_proof_name<'__short, '__long: '__short>(
>      // Currently the Rust compiler doesn't check this, see the above `Pr=
oveWf` documentation.
>      //
>      // We prefer to use this way of proving WF-ness as it can work when =
generics are involved.
> -    let ty_static =3D ty.replace_lifetime(
> -        &lifetime,
> -        &Lifetime {
> -            apostrophe: Span::mixed_site(),
> -            ident: format_ident!("static"),
> -        },
> -    );
> +    let ty_static =3D ty_static(&ty, &lifetime);
> =20
>      quote!(
>          ::kernel::types::for_lt::CovariantForLtImpl::<
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 2167cb270928..e970769609f3 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -491,11 +491,28 @@ pub fn kunit_tests(attr: TokenStream, input: TokenS=
tream) -> TokenStream {
>          .into()
>  }
> =20
> -/// Obtain a type that implements [`CovariantForLt`] for the given highe=
r-ranked type.
> +/// Obtain a type that implements [`ForLt`] for the given higher-ranked =
type.
> +///
> +/// Please refer to the documentation of the [`ForLt`] trait.
> +///
> +/// [`ForLt`]: trait.ForLt.html
> +#[proc_macro]
> +#[allow(non_snake_case)]
> +pub fn ForLt(input: TokenStream) -> TokenStream {
> +    for_lt::for_lt(parse_macro_input!(input)).into()
> +}
> +
> +/// Obtain a type that implements [`CovariantForLt`] (and [`ForLt`]) for=
 the given higher-ranked
> +/// type.
> +///
> +/// Unlike [`ForLt!`], this macro additionally proves that the type is c=
ovariant over the lifetime,
> +/// providing a safe [`CovariantForLt::cast_ref`] method.
>  ///
>  /// Please refer to the documentation of the [`CovariantForLt`] trait.
>  ///
>  /// [`CovariantForLt`]: trait.CovariantForLt.html
> +/// [`CovariantForLt::cast_ref`]: trait.CovariantForLt.html#method.cast_=
ref
> +/// [`ForLt`]: trait.ForLt.html
>  #[proc_macro]
>  #[allow(non_snake_case)]
>  pub fn CovariantForLt(input: TokenStream) -> TokenStream {



