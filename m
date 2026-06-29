Return-Path: <linux-pwm+bounces-9468-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MIm/FG9uQmoa7AkAu9opvQ
	(envelope-from <linux-pwm+bounces-9468-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:09:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E43E96DACF9
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:09:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=vRaY2jF8;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9468-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9468-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77F5730D13AC
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B58940802C;
	Mon, 29 Jun 2026 12:39:54 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020122.outbound.protection.outlook.com [52.101.196.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30A407570;
	Mon, 29 Jun 2026 12:39:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736794; cv=fail; b=aKGlHi8mtYuNWpHOc83E1YSO4AwHB3f+bYILFfIlin9osFGJBx16n3d4xSAI6Y3pqDZevC99e+6gINevV0JRAUZgMBOAnZakmK+ifoukXEwUfA7jZTPdA0ikmA6WH4oR/Vz3dWEQ7oKkoBJwZiAh1hUluLbXaew/yUPSLVDlRGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736794; c=relaxed/simple;
	bh=tYu///c7xmV8/ML+6JvIY9z3X2BMm7OkTOg+3t5aToo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y+JRa1w486eSKSebelnGg3z3jOTi6p6p+S723L/1ujRp99Q4adNnK0dbeukibS1NJDBg427sCNmrppr2fUW6GFLfEJ/1vMg8R+WxAw3W+0r5iuBSIRhpztZlDoMGVI+9J1ttU5dEfqbrtxpxsRhwZYj2CMMW9ycoxYLLHM/OPTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vRaY2jF8; arc=fail smtp.client-ip=52.101.196.122
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHMQviXnWoX7OM999g2N8n0M6ARQ9bF2KJDbVNmnSYpGZZd01dhw9ivSVwOQewfdtbveWxnLdYzBDAzvlYQahKdCfTRdw1cQAi5McfD5EcWd+IkbKQCpDS5v+GZGQHaXs9nCuB8+FCUQVq3THvqUOBl1pO3DIpA97GkUqFTh4IvA1O9wfbw0YGGvi/MeC4xeQmVfxqo4oCKSSgDqb3UPvUVq80NaVfk0FPbo/KrXWIuijNHA6eAChk6HuNEzsuRxbMvwErYt5XplhXVglr42acxzsL8lA8IjkB0WrIBXxTwz0vFlcj0XtgMI1veddI1SL31MDgK327IhdOn0weq5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoMhaVMMWMCPBUFER67rnre1SpToBfD1zZBc0lYdKgU=;
 b=AhC2FPTXuJLrSjEHpSJ4CryWJAdS/EVXpX3NA0QrNW67lLv8YU5QXtWv0flE7Jcz0TjeCMrJeYlvZt/OP1W36j/YpwkJNT+WNz/dzv/hq0firIrbQ1cssmvf59ZZHEUOCcAiBJDxx0NZTg5aTBaCUpAZN5epfEJYV1d/CetRlazB8goVejuvm5HAAFPdIB4tPyVe1f5MOqk0ABryeqiws7uEWLqubsTmj9Rs4pjLdloUR1WwEE9AsUKyvAuGj8TRMFxZUgNkYbPwbwZGtF118xqKPGjIsOLlvxbRKC9iokY8Mop5ZQZba860i8EiGQA10m1wnsHRkKI75uDCoA3zkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoMhaVMMWMCPBUFER67rnre1SpToBfD1zZBc0lYdKgU=;
 b=vRaY2jF8UvLmaqW9Org83sJc48J1d/bqc7Sn1RYINpDUQBU4sAR3a2RSZS8tRYnTN/ESoarziGUim8pCO2ZZGUYM8DiFxr46buN6Iu6JSwX4LrceBq6UJ1JzWNTq+8d14l+uKd1u9NApwDbnFtIj8q6lE0G7rrRXHRQEIApGGbc=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7414.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:39:44 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:39:44 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 29 Jun 2026 13:39:40 +0100
Subject: [PATCH v2 06/11] rust: driver: centralize device ID handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-id_info-v2-6-56fccbe9c5ef@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782736778; l=8135;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=tYu///c7xmV8/ML+6JvIY9z3X2BMm7OkTOg+3t5aToo=;
 b=5chR09/8RqfBEgyEbMC0ZHRQzJlVgYwG7Uv0NPIX16TbZ7biRTK0Z25XExflBXUa3/G4jVQfR
 5cjyCsdwoUMCP4zPKk2Rz0eICRf+EzuUnTCV6nInA8a6TSSpEB7DQzB
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
X-MS-Office365-Filtering-Correlation-Id: 91f28075-e181-4d2e-57a6-08ded5db7f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|10070799003|921020|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	aby5umHtfV2lce4ot3pEkdPlhFEDPufp+Xls2L3XWWMYASK37DQlKuOGsHZo9L+CFTxEWsoQ+m13J7A2a1ZZ7/JI7ad6LYGe39VlsGb+GhB+dxxpIh5znNNL05L+J9TJBXHQ144+jk8ix41QOpnw1VJv6lyuQVG8w3f+SR4MyvP0XEIPeQoSxI834W4EKYPfUJwRKYBfsuIm4U1yzXAlEPLsZhJGLhgq3GkYh7T2pH68UqkPX9qPaJ4oQF2tuyuwK/S87CBD/d3hrMwAzvmSvZzQGAt1/jEY+TY9Z4LOB2LR34Lmt5lC4sOQVbj7UK7T7Qh2JD1/hrS767n0TFygMshroTCvDxsF/PchcosQS3ylfl+3at/kBR1clAJZ6iUMXnN4bPGG4l6W475Wv2REBxzuiY7sC1eptpBH6FR/pPagkT78EmFWxe445q6ItNYsXBuv6/ww5xDUj8gj4AJEg34mJv8M0VxBOuLNMMt1cJ0nE5a8JDRydE9yS4K8+oWIOfDpJqNMRNZW6oYI1QLAkUG5JUPWkmst+anSiuDeEsQaUjZg/WPfoI58NUUJi8UNquiseNzrWix2mu4cqKwdpGib+5aIjgOKzgraLFZcI2QaoiMYT3ih3DF7LOZr1pcmRkfyh1v/Zs95SpNTWFH8+pCgnMxVz6cfIGuXYjqjLFJnAYnl2G3jGfp4a5MQ7zqD9Al2J9n3xWG37AO4vgSlbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(10070799003)(921020)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkRnUTRqVEUrSS9Ha21QUlNtei9ZWDBUQ24vSHROcDhDbkNqbmd6STFISHJ3?=
 =?utf-8?B?RHNrRU5RS2hDTldTMFpNbU1oVW01Z25iMnFDaFZqMGJSQmhNdy8yYTFBMkZ6?=
 =?utf-8?B?M1JESThPVmZ3N1JkTURIdGx5MS9JZUwxclppSjByeVhDUUtmQ1RlaEtBTHk1?=
 =?utf-8?B?eEJkV3NlZXBPcGVVSURjdDdVQnhUaFJ5OVpRdE5oRjJHenROOEFmVFJJdlBB?=
 =?utf-8?B?WnAxK3F0QlZ6TFVsYzVuZVBYa2hrNDQ2V3lLaVNRU1JKSjVwN2ZNRkpKYkxV?=
 =?utf-8?B?UGYyY2VTYUQvSjViRGZrT0NDcEV4bHZIekdaRjBONStnKyswUlVDVW16bXdD?=
 =?utf-8?B?cXVLbmZzd2c4VWFlSHdjRGxTeWpIL0k5VnhyWVVmbXFDU2NKd2orVmhROEVQ?=
 =?utf-8?B?emRFdVpDKzZNaHZvY1EwLy95ZzRESERQUzMyM2xwaU5wVURUalhoekdPelZL?=
 =?utf-8?B?R1R5S2JLVGxDa3A5Kzc2clloUHVsUW9GQmJGa3prMHBtWGdWNndNMHBzSWN4?=
 =?utf-8?B?Z0drTmZ3R3dlV2Q4U0tDc0QxVGhqVC96T2ZBWWdlcXBLb1V1QUdEeUFKMXRt?=
 =?utf-8?B?NjFQeGdaREliMmtLRytCN0NhdE5KZERNeUU2NDZxZ1dnWUp5ZlhnUmoxWnFx?=
 =?utf-8?B?OEJiQjMrRjNLVVIwUzJDYmVsYlN1TEpMaWM2SHA3S2luekRZQS9NZ0ZGTHNn?=
 =?utf-8?B?Nm1EWE9BUzNzY1BYbzY4UVpUbnZtNHVMQTFEdjJwSFRIRUQ0Um9vd1hIYmph?=
 =?utf-8?B?ZFBDTnVkMGhDOXJHMVRMNFpSdmIvQ0NWVkRBdXR6OGVFQU11bFg2dDN2MThm?=
 =?utf-8?B?dFVhUDRKYlFJcCtKaTcrdlNvU3Y3OStVa2hvT0xGTlJBWjdVb1Vrcll5Rm9s?=
 =?utf-8?B?QWRSUjUwdzU0NXlHbmtDbkJPZHZRRmhub2pKendZZWdrMTRveXNBUWphTWts?=
 =?utf-8?B?U0h4WW0rTWROS1NrZ2c2T2ZEeHUzTHdiQ0JGRnA1cnRkN2NUbVczcmlqL1JP?=
 =?utf-8?B?QTVqUGUwQ1JDSjQ4d2JiOW91NFdDbE1RTmRsblBNZ2kwMGY3UlVMUktJTFZS?=
 =?utf-8?B?WFJQOWhWODBocU12LzN6SHQ3aE56Mk45VCtlT2J5dGlUUXdiR3JKN2tDcCtj?=
 =?utf-8?B?eXQvN05Cc0dZV2ZzRUJLZGpCdlY4dTRXb3dqWVduV3NtMHZ4Z1hvYzhRT0hi?=
 =?utf-8?B?WG94R0Z1Z1M1WXFKMStXbXI4VDdRZ1laYU9CTHhZWXRad3c0VFRtcGk0a1c2?=
 =?utf-8?B?ZFhzNGJlMVlCYitGMXBGTDNFaGJGWEozdEc3UUJzOXRUSC94eTJGNEhHRGJy?=
 =?utf-8?B?c2FRR0hXekljdG1HVDFBMlljd0NZOTlTNUNwWWp2NlpjcWFDV2pYQStyYU1O?=
 =?utf-8?B?WGptZXNUdDVaeEN2WWFIQ2ZETm01V2FSOFhacWtyN3NrUmxneFYzZ2dML3la?=
 =?utf-8?B?VlV0OHg1VHNjd2Y2KzNBNXFpYmc1NGhvK0tIdEdlZkN2cVRTN1BaZ3Urc0wr?=
 =?utf-8?B?THNzeXVTQWJPWms5STVEdVNnT2lUSkwwYUpEMkpNREZTSXA0YUgwaVlWYVoy?=
 =?utf-8?B?cmhOc1BjblY4bXVOY1FhYmtMQUZncDlyZS84ZVoyUGJ2OFI3WHg5WTV5UFV3?=
 =?utf-8?B?TXMvZ3lkVFhXZFRIRFRhUEo4U3JFM1ZsMllMN2RYNk14RHIzL2hqYW1kT1JW?=
 =?utf-8?B?Rks4cWRmdEJuQzR4OXZxdGpCOHpIZkkyYUNzdXlEcm50UzdHbHgzMy9Pa0h5?=
 =?utf-8?B?a3g5bnZ6cHpYTVVDeUtGNGxGbG9WMWdzOERueUFXcENVeUg0S2NEU0MxSWtF?=
 =?utf-8?B?Wmd2UWN6aC9OVnJMWkVoN00vRGl6a0VzUXFiTXdVZDUyWkpMTEU3dC90ZjBZ?=
 =?utf-8?B?dEhXdVNtZUgwS1dOQkVxazNEZVZZaHZxQmhvMVk1U2VPdklEVzJ4Zk1KYXFw?=
 =?utf-8?B?YjdHTVhRcGQ0RmxQY1J2SXVaQ0ZLNmEwYkF0T0FoMFFqMUV1azcyMlFIdnFL?=
 =?utf-8?B?Ri9pcUZUTTNaMDdCOW9YT2pjQ3hyWEQ5VkxyQTNsRWpSZ3ZDOXpUZHBqK0FL?=
 =?utf-8?B?Q08xRENuRURwUUNoVjBDd2JqOVhRUHBWbUpOV0FRRTJ6c0dRQ2t2V2xNNDd0?=
 =?utf-8?B?d2xLSkJ3YUVMbGM2QTJSK1dyckNjSWhDa2NSTjVGTGhtWkdTZjVPdTRFUENy?=
 =?utf-8?B?aGhhUkQ4YXJxTzRyWUhsNDJJc1V5N1R1WWVzSVczYnJ2ZHkvdWYvOUxiUzYx?=
 =?utf-8?B?bnNhRXkrZVNlMVdpVFF3Mm0xbzFRWkFxcVFhZVFWWnI4QlNIWHBBeDN6QTZ0?=
 =?utf-8?B?MkUvV1ZLUGF3L0VqL2xIc1F2V29mM0Y2dS83b0hldDU2Nk9JNmZwZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f28075-e181-4d2e-57a6-08ded5db7f09
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:39:44.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsU17SnSOJzPuh2HHWQY7l61hr6N8E4jKJxTUbI3xsU2rmuYVVgqtAuZpt9Q9Mg0wnxHiuY7YgguEQqgFSubrQ==
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
	TAGGED_FROM(0.00)[bounces-9468-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E43E96DACF9

Move the `IdArray` creation from individual buses to be handled by shared
code in `device_id.rs`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/acpi.rs      | 10 ++--------
 rust/kernel/auxiliary.rs | 10 ++--------
 rust/kernel/device_id.rs | 31 ++++++++++++++++++++++++++++++-
 rust/kernel/i2c.rs       | 10 ++--------
 rust/kernel/net/phy.rs   | 10 ++++------
 rust/kernel/of.rs        | 10 ++--------
 rust/kernel/pci.rs       | 10 ++--------
 rust/kernel/usb.rs       | 10 ++--------
 8 files changed, 46 insertions(+), 55 deletions(-)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 9b8efa623130..315f2f2af446 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -53,13 +53,7 @@ pub const fn new(id: &'static CStr) -> Self {
 /// Create an ACPI `IdTable` with an "alias" for modpost.
 #[macro_export]
 macro_rules! acpi_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
-        const $table_name: $crate::device_id::IdArray<
-            $crate::acpi::DeviceId,
-            $id_info_type,
-            { $table_data.len() },
-        > = $crate::device_id::IdArray::new($table_data);
-
-        $crate::module_device_table!("acpi", $module_table_name, $table_name);
+    ($($tt:tt)*) => {
+        $crate::module_device_table!("acpi", $crate::acpi::DeviceId, $($tt)*);
     };
 }
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index c42928d5a239..59787c9bff26 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -181,14 +181,8 @@ fn index(&self) -> usize {
 /// Create a auxiliary `IdTable` with its alias for modpost.
 #[macro_export]
 macro_rules! auxiliary_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
-        const $table_name: $crate::device_id::IdArray<
-            $crate::auxiliary::DeviceId,
-            $id_info_type,
-            { $table_data.len() },
-        > = $crate::device_id::IdArray::new($table_data);
-
-        $crate::module_device_table!("auxiliary", $module_table_name, $table_name);
+    ($($tt:tt)*) => {
+        $crate::module_device_table!("auxiliary", $crate::auxiliary::DeviceId, $($tt)*);
     };
 }
 
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index eeef3f5e7b63..0239f89d5f69 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -175,7 +175,36 @@ fn info(&self, index: usize) -> &U {
 /// Create device table alias for modpost.
 #[macro_export]
 macro_rules! module_device_table {
-    ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
+    (
+        $table_type: literal, $device_id_ty: ty,
+        $table_name: ident, $module_table_name: ident, $id_info_type: ty,
+        [$(($id: expr, $info:expr $(,)?)),* $(,)?]
+    ) => {
+        const $table_name: $crate::device_id::IdArray<
+            $device_id_ty,
+            $id_info_type,
+            { <[$device_id_ty]>::len(&[$($id,)*]) },
+        > = $crate::device_id::IdArray::new([$(($id, $info),)*]);
+
+        $crate::module_device_table!($table_type, $module_table_name, $table_name);
+    };
+
+    // Case for no ID info.
+    (
+        $table_type: literal, $device_id_ty: ty,
+        $table_name: ident, $module_table_name: ident, @none,
+        [$($id: expr),* $(,)?]
+    ) => {
+        const $table_name: $crate::device_id::IdArray<
+            $device_id_ty,
+            (),
+            { <[$device_id_ty]>::len(&[$($id,)*]) },
+        > = $crate::device_id::IdArray::new_without_index([$($id),*]);
+
+        $crate::module_device_table!($table_type, $module_table_name, $table_name);
+    };
+
+    ($table_type: literal, $module_table_name: ident, $table_name:ident) => {
         #[rustfmt::skip]
         #[export_name =
             concat!("__mod_device_table__", line!(),
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 624b971ca8b0..a1f968fd873d 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -77,14 +77,8 @@ fn index(&self) -> usize {
 /// Create a I2C `IdTable` with its alias for modpost.
 #[macro_export]
 macro_rules! i2c_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
-        const $table_name: $crate::device_id::IdArray<
-            $crate::i2c::DeviceId,
-            $id_info_type,
-            { $table_data.len() },
-        > = $crate::device_id::IdArray::new($table_data);
-
-        $crate::module_device_table!("i2c", $module_table_name, $table_name);
+    ($($tt:tt)*) => {
+        $crate::module_device_table!("i2c", $crate::i2c::DeviceId, $($tt)*);
     };
 }
 
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 965ecca7d55f..166572861e61 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -809,12 +809,10 @@ macro_rules! module_phy_driver {
     };
 
     (@device_table [$($dev:expr),+]) => {
-        const N: usize = $crate::module_phy_driver!(@count_devices $($dev),+);
-
-        const TABLE: $crate::device_id::IdArray<$crate::net::phy::DeviceId, (), N> =
-            $crate::device_id::IdArray::new_without_index([ $($dev),+, ]);
-
-        $crate::module_device_table!("mdio", phydev, TABLE);
+        $crate::module_device_table!(
+            "mdio", $crate::net::phy::DeviceId,
+            phydev, TABLE, @none, [$($dev),+]
+        );
     };
 
     (drivers: [$($driver:ident),+ $(,)?], device_table: [$($dev:expr),+ $(,)?], $($f:tt)*) => {
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 58b20c367f99..35aa6d36d309 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -53,13 +53,7 @@ pub const fn new(compatible: &'static CStr) -> Self {
 /// Create an OF `IdTable` with an "alias" for modpost.
 #[macro_export]
 macro_rules! of_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
-        const $table_name: $crate::device_id::IdArray<
-            $crate::of::DeviceId,
-            $id_info_type,
-            { $table_data.len() },
-        > = $crate::device_id::IdArray::new($table_data);
-
-        $crate::module_device_table!("of", $module_table_name, $table_name);
+    ($($tt:tt)*) => {
+        $crate::module_device_table!("of", $crate::of::DeviceId, $($tt)*);
     };
 }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 0e055e4df99e..34e07a53244d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -245,14 +245,8 @@ fn index(&self) -> usize {
 /// Create a PCI `IdTable` with its alias for modpost.
 #[macro_export]
 macro_rules! pci_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
-        const $table_name: $crate::device_id::IdArray<
-            $crate::pci::DeviceId,
-            $id_info_type,
-            { $table_data.len() },
-        > = $crate::device_id::IdArray::new($table_data);
-
-        $crate::module_device_table!("pci", $module_table_name, $table_name);
+    ($($tt:tt)*) => {
+        $crate::module_device_table!("pci", $crate::pci::DeviceId, $($tt)*);
     };
 }
 
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 6750a49e466b..3797f4a79b79 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -254,14 +254,8 @@ fn index(&self) -> usize {
 /// Create a USB `IdTable` with its alias for modpost.
 #[macro_export]
 macro_rules! usb_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
-        const $table_name: $crate::device_id::IdArray<
-            $crate::usb::DeviceId,
-            $id_info_type,
-            { $table_data.len() },
-        > = $crate::device_id::IdArray::new($table_data);
-
-        $crate::module_device_table!("usb", $module_table_name, $table_name);
+    ($($tt:tt)*) => {
+        $crate::module_device_table!("usb", $crate::usb::DeviceId, $($tt)*);
     };
 }
 

-- 
2.54.0


