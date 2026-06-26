Return-Path: <linux-pwm+bounces-9413-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 51v/ElyRPmqoIAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9413-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:49:00 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F896CE1E9
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:48:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=PdIDlWxs;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9413-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9413-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23A683009E0A
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B315F3FCB1E;
	Fri, 26 Jun 2026 14:45:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021075.outbound.protection.outlook.com [52.101.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16503F9F50;
	Fri, 26 Jun 2026 14:45:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485146; cv=fail; b=YFgd+/aD1eI5YbVM6iMvzfxwoyqiu9ZGLYNn6iBHczx39qr0W6TCUSFMmGeStHTPym+VKAEID3RLte7aWBRqcr0gkkGVSyD3lOfLoICRQx/UoEZoXoLAAYCwk0QjeejsuISHP0siN7y8xC/v7agtiex6nY4XimAQdoJJAYowbYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485146; c=relaxed/simple;
	bh=zcL64dOq1S6g74TzRD847SfGyQa8u6SPIOVdRrKD3hg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s8BUzGg+6r7QRt2og0B7pNGAYl8PU+MK1A6wU/xa0V16ouleNV6+E8zkmM0imZGHjV9cvXT9JmU422l8LtSagYtHuQRTpSJiMUSE8CmEjD6AdmQYytBE6t7t4lPv82hIeaLKmnjPaM+1VVeT5YFUeCQ0V2VTEVPmQBgCdp/Fy5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PdIDlWxs; arc=fail smtp.client-ip=52.101.100.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXFnBAGEUg7A7HmLamORN8Gh/Wt5c0+Y+BRlklhUC5Y6y4ZWoZmY+NcakT901LjkanwtmGWggdDOdG+5+8EWrOlv7bB/Te3mjR6HJGVNzOchDJJZqWKI9W9x7AnGfOR3boMjcb0w/RFEa31UM9/GuCUTjpTV7xwy2dtnK5BuYxPPGInnxsIYegZnIJ9/W3vrAgEna4FeKtwLElP2qq2KW5VDWsRRAhYn5nh36ApcGhvdlcFTB4venR8O417/lXmdqWQcPPWrR4N0/EEdgVFj1orCNifrBPl8KC68dSzAwYOR2HC6r/8/ue9pGFr/Xdv3BxoYCVI/lZUM/SAnw2nw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrGyTXT4lLNycWakX13m0EN+saSRVjAARnFVmHOrwg0=;
 b=CByjneVuAg7TL6ganzMqFA5Gjm3QcLhARrmdI/lV/KkalnyCvCQwXXyCK/J0sebWceB1jwOgNilTAIAj+rPR8FPQCtMLKmrtGQriR8eZNU424HkAvli7ZafniaaAGIsP/hSzrtGlxn4AYOBedrwq0nCVQ1JP6uLl0Cubrt38iUYdfW7REQ65JBnGWhaZAg+udCKxpJLCpdud43w7ChZgZlJbsGYmnByqYLgCo2Wl18x/cnV0nJvgY3ESyKD01F/eu7pBqe1ImrODWjqcLdgvQjNmcvKKxrHu+xS/CA1yZUa7o6DEn2PafgjRQ3tQoohzFZ9X1sRv6m2dDMAlDPHcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrGyTXT4lLNycWakX13m0EN+saSRVjAARnFVmHOrwg0=;
 b=PdIDlWxs0rxV8tyxPVSaS68Eerjo/mf0Spk6aOg5FwDVcjkTsZUhCBQA1iouKoJcETTpaUZA9mJw3QsOy7pQJDsKgpz9DFGMSaFR1Y18+goMyu4jhgUWMOMV4/V5sH0bHqCUHKj31+wg7fkqcLk86xrvIND+osgwEl52yOPOXwc=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7248.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:19 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:19 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:09 +0100
Subject: [PATCH v5 05/20] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-5-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=7882;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=zcL64dOq1S6g74TzRD847SfGyQa8u6SPIOVdRrKD3hg=;
 b=4Yy9io2rgiDA6/qI2iOgTumGDccIKgqP1CtyQlyz7MpyEzkAMXMZ8dNOYI89mxxrKnTv5wECc
 w0Bf36cyeGaBof714S7kp93E4iixe0rSVD2lCuK0L2Y9Bt768D/kbrj
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
X-MS-Office365-Filtering-Correlation-Id: 62bef6dc-ec86-4bba-c380-08ded3918b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|23010399003|366016|7416014|18002099003|22082099003|921020|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	7LopdfynQDvHR1FpKxyYH1TaJ9BgHnwSPmi6hXDs46wN9wKVdakUU8K/P5QLnB3vuY7eubqYeUTop8vREnwSoifbdR81lnJfOC0QUBY3007y/8gIWcyA7OhPB0EZlMebpQxRTLUy08HEkYquXhNstWyLC+gZ1xRVk5KYorV5x2gSTp5NgSfRFh4hIKP2HT/Ins+vW6g3cpJqik7pLMn9RhBR9NqDLHSTmJj6qjuMCJn/bfURsvP7XZtsCU8iHZJyc6sdoOdJiKXYI3DawfI1KBcKigIVsMEVAdym5b+LovzfcfK0PfUy9I9eosa5YGN2Zv1h/KDPiv1r+D/Jo+D11nvsCzdX+Vog3o26I/Yk36Hjo5MYoAaLHBGryeoMEUOilRndd8koOVX2isA4LluwNHhAXgtHMY6dU1TG0X0kHL7W9perHDjbuXwKN3ZiAKC4K4KL/kgrd2dcsbte4j7dn06N/d5opUXTCA2vFJ+gifImWGP/SOUMqXjw4uVPehRmZDzkrEzKGFVkViiKM81Uj38fuE438Y96WDv+ioHJdYbxPhmbcczNozropiLHgORKo5OqlIZtsMNjdeJ0FMn8aIWi1jT/rFeKXV5P+P9Dkth/F/Ddk2Nf157MDqoqulcoIokNRDf9Lcri/BW7v/9wpIByupJttRnAoPoz2F+6tE1YZlhHjaYwu8JnJdFpmDl92ijGOjDR3duktlUCi771yg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(7416014)(18002099003)(22082099003)(921020)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alhObkNXcnNQK29Wc2Exei9udkxhK2prcUhQdmdzdWVpL0x1N3dqQXRjWDFH?=
 =?utf-8?B?RERJQ0pscTFhOGpCMlIwQWFMWmFoNmE4aWpyZWJZTGdXUDZCSy9ZTXl0WFB3?=
 =?utf-8?B?M2FDYURDSWNzRERPNjN5RUZLZE9oZ3p3TlRQK2hsbG16OFVVVGZYTHhGNFZL?=
 =?utf-8?B?TlRkQWJMRU5LTEp2Wk1CdXRjOHA5a1lVWVQrU243MzQzMWNJa0xRSlZzSG15?=
 =?utf-8?B?Q09kOUxVa2pycDRjOERoR2xTSjRVZmZJNGd2TUxZV1lLcGZMaGVGMFFXOEdM?=
 =?utf-8?B?dm4wMVBkZ0RSMHVqbFhLcS9kVXZ2VWJmQmJkWUpaZ1F0enNXNWJyN0Vhbm8w?=
 =?utf-8?B?Yy80b1pZektDMjBYb2t4enFlcU93TmM5Tm1yOWVvSUhKSk1XVytScDZmdWg5?=
 =?utf-8?B?YzgyWmM1R0F2VlkrZVF3WWxBTzlEY20yR1lzVE83eStWbE1obHVscXhjYVZZ?=
 =?utf-8?B?ZXo1bGxMSk5KTllENEpJSE4wYnN5WXZEamFvbWhMTW9yY3JYVndaMjZWcUF2?=
 =?utf-8?B?YnRkUzZhdVVOaTRsbVhJQzlKalFLNENMTjdXY2xkanZBclNqMlV0N2k4c21l?=
 =?utf-8?B?WGdEUmxlek0yQS92dWpUNmFXMHNjV1J1SUxTR1h3SWtVVmJNTkNPU01BbEo0?=
 =?utf-8?B?eXExYWdZbWFHNmZxQ1UwTjV1c1BvSkVBUXErYWQ3NEpKa0VZUXY4ZTdZZTU1?=
 =?utf-8?B?bjJmWHFmYVFTaDlWZGVEVjFCSzZ5cEVZS3VpQzZ6UkVqYnFuNVlKZWdEVVFQ?=
 =?utf-8?B?SkVlKy93L0djajVvMm9WalViRW1uQWZSSlJ5Tk50dGxXWmFHbmZCUEE2dnp5?=
 =?utf-8?B?WHdQYWtEaktWQnhhZVNyQVF1K2Q1bXhXVkI1Q0xEaTVBWWJkSzQvRklVZndQ?=
 =?utf-8?B?MnNQbGtoT2EzLzBmMGh6U2NCLzExbXlKUzhyeXhON2d4TWNwMHE4SHRSKzdx?=
 =?utf-8?B?azhHb2dkeitRQTRvb2VqLzZpelJhZ0hvNmRqM2piODJaYnBUVnJPMlZXWDB6?=
 =?utf-8?B?dUhKRGt3cE0xSkRWTGxlcXZTVUcrT3pBUHFWcGhRdmVsYVJ6UE5jTitERkU3?=
 =?utf-8?B?U2YyMGhpZWYyVy84WmkwVDhqNk9FMGt5STNEMThkUG9JTzZoeTZ4dHZNTkln?=
 =?utf-8?B?Q1RCMUR1MUZIZWFwZXFwWXp1bUJqYkRXWjZsYkE1MFdid1BVODV5NlUzRTJM?=
 =?utf-8?B?M1JHbEdjUjFGTDdRaFlhM0l1VkFjdnhoVkZTbVg5ZnE5YlFta0NDL3RNVC8z?=
 =?utf-8?B?N1RBNUdJaUhSMkhVeXlQRVVsaWl0MlRrWmlzRG5XdG93c2lGTzFnRElXTmNW?=
 =?utf-8?B?Y3dCczN0VmFBUG1HZnFGK0JLWHUxampSem9qMGFnaUNHOGVpZDY4eThEUWRp?=
 =?utf-8?B?eVY3OUp0RGJhR3VoR1EyYTVGeVU0d0UrMk9JVkszL1NWUFpiMTZYVXlneG56?=
 =?utf-8?B?YWttRjVOT3c4bGN0OHQyT21NZXF3Vjl6NXZ4MldLa09GRVQrM1J5c1JuZkZX?=
 =?utf-8?B?RjQzeTVmVy9NZ1F4UG5wOVRyd01JUjA2RkRqZWFOQ0pVdXNWYk8xQ01US0JF?=
 =?utf-8?B?b1R2YVl1YlhKOEpGaUY3MjhHUFRJS3c1eXVoejFTRHBNSElLUFNnUHYzdDBw?=
 =?utf-8?B?T2VMNTAvbFNza2xyNDhUaVpvb0srZFRCZ2daRHY2SHJYWmk1ZG1hdGxTUm9I?=
 =?utf-8?B?bXMrK2xZWXR3MWhpakkrV0xBS0xCVHZYbkdtMlh3QnF4eUF5ZnJMVjM1cjJs?=
 =?utf-8?B?K3F4VWdQU056NkpRbHpaU2cwb2k2dHZIN21qMEZBeVlML0tRMkl5MzY5QXVP?=
 =?utf-8?B?bmpzUkt0WDJ3NzQ4NG8zbGxVOHJTMGpXbkJFS2Jtajh1cDdPbGZoNmNLTnEv?=
 =?utf-8?B?WEhoWVNVWllJTktSckQ5Q3BBZEFlNmtCUW9XRGlXWS9GWWFiM2cwTFRZalRZ?=
 =?utf-8?B?S0lzUGp5LytkdWJSQVNOZ3graEZubjA0Vm96MFMrMlRBQkV4L0lZTEFVaHg3?=
 =?utf-8?B?WVlFdWN3dStvN01ua0wvdUxUUTI4ZzFwcjNnc0l4Y1NTRzZhNHAwRDFCbE9h?=
 =?utf-8?B?d0FTNDRBK2MxZEtMdHNVemc2VzRWMVdNTUphNVUvUGNHdk5mWjUxZ2hOVUVN?=
 =?utf-8?B?emZ5TFVTTWpiUkdFVmc1Y2JUWlp0TFE5TkhsOGpDaWVhTFMwSVhnZ1VrU25U?=
 =?utf-8?B?QXVHM2c5Z05nWVg1aVNGelVmbFFzNGxyOS9IekNRRG04cUpWWUg3aXpaSUk3?=
 =?utf-8?B?Y2EzWExsbG84MGVWVTd5VlFqZUhMQzkyK25obzNEaExFM01XcCtsNkpqVDJX?=
 =?utf-8?B?U3psR2lzaEJid0F4T0loU2xvSXBFL2VMSE5Eekw4aDIvemNnQkc5Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bef6dc-ec86-4bba-c380-08ded3918b69
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:19.6693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3nvRzo1KIRJ1Ou/79zfqqBVFrYsbp/JPtHI7isE1oUWw3i/KNDrSecNYB2DK7ox/XT/QUGNiLixvw/0tO2JHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7248
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9413-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64F896CE1E9

Conceptually, `MmioRaw` is just `__iomem *`, so it should work for any
types. Update the existing use case where it represents a region of
compile-time known minimum size and run-time known actual size to use the
dynamic-sized type `Region<SIZE>` instead. Rename `maxsize` method to
reflect that it is the actual size (not a bound) of the region.

Implement `Clone` and `Copy` manually, which cannot be derived due to the
generic parameter. The use of raw pointers also cause the `Send` and `Sync`
auto trait implementation to be lost, so add them back by manual
implementation.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |  7 +++---
 rust/kernel/io.rs     | 67 +++++++++++++++++++++++++++++++++++++--------------
 rust/kernel/io/mem.rs |  5 ++--
 rust/kernel/pci/io.rs |  4 +--
 4 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index ed30ccc6e68e..d0c677fd7932 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -70,14 +70,15 @@ struct Inner<T> {
 ///         Io,
 ///         Mmio,
 ///         MmioRaw,
-///         PhysAddr, //
+///         PhysAddr,
+///         Region, //
 ///     },
 ///     prelude::*,
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -92,7 +93,7 @@ struct Inner<T> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 9f060dd29182..12be266d7ed7 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -88,37 +88,67 @@ fn size(p: *const Self) -> usize {
 
 /// Raw representation of an MMIO region.
 ///
+/// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
+///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
 /// the represented MMIO region does exist or is properly mapped.
 ///
 /// Instead, the bus specific MMIO implementation must convert this raw representation into an
 /// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
 /// structure any guarantees are given.
-pub struct MmioRaw<const SIZE: usize = 0> {
-    addr: usize,
-    maxsize: usize,
+pub struct MmioRaw<T: ?Sized> {
+    /// Pointer is in I/O address space.
+    ///
+    /// The provenance does not matter, only the address and metadata do.
+    ptr: *mut T,
 }
 
-impl<const SIZE: usize> MmioRaw<SIZE> {
-    /// Returns a new `MmioRaw` instance on success, an error otherwise.
-    pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
-        if maxsize < SIZE {
-            return Err(EINVAL);
+impl<T: ?Sized> Copy for MmioRaw<T> {}
+impl<T: ?Sized> Clone for MmioRaw<T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+// SAFETY: `MmioRaw` is just an address, so is thread-safe.
+unsafe impl<T: ?Sized> Send for MmioRaw<T> {}
+// SAFETY: `MmioRaw` is just an address, so is thread-safe.
+unsafe impl<T: ?Sized> Sync for MmioRaw<T> {}
+
+impl<T> MmioRaw<T> {
+    /// Create a `MmioRaw` from address.
+    #[inline]
+    pub fn new(addr: usize) -> Self {
+        Self {
+            ptr: core::ptr::without_provenance_mut(addr),
         }
+    }
+}
 
-        Ok(Self { addr, maxsize })
+impl<const SIZE: usize> MmioRaw<Region<SIZE>> {
+    /// Create a `MmioRaw` representing a I/O region with given size.
+    ///
+    /// The size is checked against the minimum size specified via const generics.
+    #[inline]
+    pub fn new_region(addr: usize, size: usize) -> Result<Self> {
+        Ok(Self {
+            ptr: Region::ptr_try_from_raw_parts_mut(core::ptr::without_provenance_mut(addr), size)?,
+        })
     }
+}
 
+impl<T: ?Sized + KnownSize> MmioRaw<T> {
     /// Returns the base address of the MMIO region.
     #[inline]
     pub fn addr(&self) -> usize {
-        self.addr
+        self.ptr.addr()
     }
 
-    /// Returns the maximum size of the MMIO region.
+    /// Returns the size of the MMIO region.
     #[inline]
-    pub fn maxsize(&self) -> usize {
-        self.maxsize
+    pub fn size(&self) -> usize {
+        KnownSize::size(self.ptr)
     }
 }
 
@@ -143,12 +173,13 @@ pub fn maxsize(&self) -> usize {
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr,
+///         Region,
 ///     },
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also `pci::Bar` for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -163,7 +194,7 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -193,7 +224,7 @@ pub fn maxsize(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
+pub struct Mmio<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
 
 /// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
@@ -840,7 +871,7 @@ fn addr(self) -> usize {
     /// Returns the maximum size of this mapping.
     #[inline]
     fn maxsize(self) -> usize {
-        self.0.maxsize()
+        self.0.size()
     }
 }
 
@@ -851,7 +882,7 @@ impl<const SIZE: usize> Mmio<SIZE> {
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
     /// `maxsize`.
-    pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
+    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
         // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index fc2a3e24f8d5..9e15bc8fde78 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -229,7 +229,7 @@ fn deref(&self) -> &Self::Target {
 /// start of the I/O memory mapped region.
 pub struct IoMem<'a, const SIZE: usize = 0> {
     dev: &'a Device<Bound>,
-    io: MmioRaw<SIZE>,
+    io: MmioRaw<super::Region<SIZE>>,
 }
 
 impl<'a, const SIZE: usize> IoMem<'a, SIZE> {
@@ -264,8 +264,7 @@ fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = MmioRaw::new(addr as usize, size)?;
-
+        let io = MmioRaw::new_region(addr as usize, size)?;
         Ok(IoMem { dev, io })
     }
 
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 505305cd9b86..42f840d64a6f 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -139,7 +139,7 @@ fn maxsize(self) -> usize {
 /// memory mapped PCI BAR and its size.
 pub struct Bar<'a, const SIZE: usize = 0> {
     pdev: &'a Device<device::Bound>,
-    io: MmioRaw<SIZE>,
+    io: MmioRaw<crate::io::Region<SIZE>>,
     num: i32,
 }
 
@@ -179,7 +179,7 @@ pub(super) fn new(
             return Err(ENOMEM);
         }
 
-        let io = match MmioRaw::new(ioptr, len as usize) {
+        let io = match MmioRaw::new_region(ioptr, len as usize) {
             Ok(io) => io,
             Err(err) => {
                 // SAFETY:

-- 
2.54.0


