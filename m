Return-Path: <linux-pwm+bounces-9469-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d+EMC3FrQmoL6wkAu9opvQ
	(envelope-from <linux-pwm+bounces-9469-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:56:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D696DA9B8
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:56:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=vzBgK7Z3;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9469-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9469-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01301309F9E6
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAAA409100;
	Mon, 29 Jun 2026 12:39:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020101.outbound.protection.outlook.com [52.101.196.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D574071CD;
	Mon, 29 Jun 2026 12:39:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736795; cv=fail; b=HOVmcRiXl2OW7eof0urT3/aQtfcp/hJHZa18UP0wJbyldZXwhuKYch5a8dAGmHw6/1SMiK88Dce9IRHopbGLzwwfOmw5RluWjexc215KngSNQ/zxw3KE8lbZnByj5HvPRPkJEFOCt3/toQ2IQJatbhB1wbPFtEr29KYZdy0OSJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736795; c=relaxed/simple;
	bh=sHG3lY8Q6JvwbSwk4FmX8jEDsL3Z1APSIPWU1i5Sd74=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=noIrIqIJVS4syej6ny7UmRvvYm4dctMae18m7BqEoHCweR6OtbuI1GhbF5D3nuV0NXOoOq95b6+vvrs3GfnT7/l0yt04fJhipgm9SiC+b9ZXWPRVeIMK3BLh5IesXg9m8egVq5QJN4iaD/wqwEm/EVnSxD77exzskkzwQrhPk/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vzBgK7Z3; arc=fail smtp.client-ip=52.101.196.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olDXg+b4CjhmuWT7+7bbO/sK+FZgVcKAyS9pNQqWPBpkzQPeU/z7MH0SMLrqTF/MUU6ryNd1q+QYOKuk7zVycAK7XragsiNzH+BerwX/S7cL6QlykJ15341WqF7JfOgZUQcBa4cxMlLpoFDVkzM88gIaD0I3CKuXf63y0KfHLvzxwYDs+lRMp0pNAwlECAHU976754/6DKWQ+vBcbCPzJuTOYFGOxaMm3L2eI2wHJK647U40l93l+wTqIMJo40M/V+wn+HzBfYHxH5D9a/f4528pU+JuEs0trcpl+2bAmLizutiPql4J1FAbp316/HP7Rr+gqaJF5sapt8DZrSTwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bS/s+IK7K9sYBskJe3XcOxKDPPnYRnuHvWiCtpWp2Us=;
 b=AbMxPOomLtEmur97E7TPr5fbTfLNtHNJ25Y5qybboGZCmxga0se2IVrepq3yBByaJFDY7/+O/8bG6OgHaLLxovb/lngDdhb8jCCL20sBtUTGY6XsS4pl20vjZa2oAbJfcVJPApXflgZ2lpFtW5zhyuAMk0wYb9Eiksj/sj+wsQzeXysvahESnwKq9aIKj0jGOwD0U8uHkqF9Q6TXp5tLVJaAaCNxHmXYwla55nCDQMohDVdUiR9pCTKhN3EC/YGGTmg9ICzX+z4uc8djNM4R9WFp/yWOSKr3UmTy6GvcUJSOaOy85oOnXeoxSfIxGaCMH0o3xkO2JUN5t6XHiiH5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS/s+IK7K9sYBskJe3XcOxKDPPnYRnuHvWiCtpWp2Us=;
 b=vzBgK7Z3GaIrdiSkb6TwLBOMIsQQ9hsbUgIbxAQmqTaGA2lscQECxGScaE/2vRMFDbGQwyXmhQRE6U4Cx+lfD7RFg6uaLE5r8dQixWB3JZ2pavTcoea/0RUlmMPrYZx+YXL96F3CbKSXVnNfAvFoXmU/iVZQ636y9dnqYTitw+c=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2670.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Mon, 29 Jun
 2026 12:39:45 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:39:45 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 29 Jun 2026 13:39:42 +0100
Subject: [PATCH v2 08/11] rust: driver: store pointers in `DeviceId`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-id_info-v2-8-56fccbe9c5ef@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782736778; l=17170;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=sHG3lY8Q6JvwbSwk4FmX8jEDsL3Z1APSIPWU1i5Sd74=;
 b=HuM/f1+UDGluqyTIBdcclgg8XwKHXEvHBB4Mw/FO2tx6lZH0EPVtd4dVNR9L2fXf9F0ROPQNq
 aQiJ8P3LDK+Dv3cbQhtEfkjdG4DBAkUyga2Eky+y3Gn/dFC8IDKQfQJ
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB2670:EE_
X-MS-Office365-Filtering-Correlation-Id: b037d739-4713-4976-7ae7-08ded5db800d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10070799003|22082099003|18002099003|921020|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SQBn/zF8sVKl8pr8CRwELLAX+DDwlent1lPHIKkLjjouh6OgqtNTRd0vBhZ/Ek3QpPh2DXnXxNT3ialM7b50EqejCbl9wAVPkH4Ts0t7J+5pJt0G8YNx0TwNHX2oh4QvtZmQsP0N5tmR7106nEcmmjCUSl1jxDKBy4SHQCIrwNuEQhivz2295rvbF5ndFY6tc10wp89/CDx0HsmH+5sJ9Z6TxlppP/Bh9gDSxhzSH2jX0CkqtdahfEw0GYUCO1WbQtCA4b42nLWRFsYGf8hCWRRZH81VhfIfZdwTj5h9IhPloMf8iXHaz/w1SQQ7oQ/AC4gXelh8kIVXjcDZ/dQSzjVUREwOO5digukfhsVMv+txHFdgejePNwWapx6szf1HTcattS5hq4KaXfosy/Q71VvmCHsNymkBjd7WizqiFsO6mD/m9VyzC/7kVuZg0igEjCVhUbjjzUuJpv6JerMQqSMfs/xFmvi5XsXn9A6PsuOLObZKluM9IZ3xeRHfqHzXT3cbKbILaAD+NoOnIV1WTorbxHw/n5qtn4DlCDQqXHUKmp285eAsZNQltdeZnz/0aSYYMomvpwtPnNJpd7ArUMOr2gM1KR2N/2d0iPk6j7WMiJIQQqr8lZjZsP+YeMIdv5yFeQFqiFR+SrmmcoYdSA6T5qnsJdlMSibNyVN+WhlIVdiDc1Ag+33gjMzR/CaUmh0VqSynXeIkyUmoulShGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10070799003)(22082099003)(18002099003)(921020)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2poNEVFeWlDRUMxR25OTnV4WWlHd1NndXY5LzV4QjlpRSs3Qms4d1pFenRt?=
 =?utf-8?B?c1RWeWFFN09yMVZhQVBFcFVLS0p6L3FxakZra3MyS3UzeE13SlpsVnVLNWdk?=
 =?utf-8?B?NTk2R1FWNFpjU0NndW9uWElKY0tyR0hhakJCcVdBalE0Q010clhGRmRUV3J4?=
 =?utf-8?B?cEYxQ1Nsd003RG1oNXB3dTdCbXhia1RCaVVrdzVNbSs2T3R6dHgwSmU1MDMz?=
 =?utf-8?B?c1JoTzRTWDd4WUFGWStZdEdndmFnSFcxYUtGVjhyeXFBWTRLNnhHZTNCVU51?=
 =?utf-8?B?V01IK2pBZ0UwOHMwTkFsQmJHK1I1WFZFSllZOEs3d1E0cndJb2ZoMU85OTdv?=
 =?utf-8?B?WktYUFZwNnJpWlRYQlNoQVJTVGNzMHg3eno5MURMQkJPR0tTa0hIY1FCUkd1?=
 =?utf-8?B?ZTA0TEJFQVdxbUFWemI0eEdjOGJZditranQrTW1BTno1U20xRlNXNnZ1aFBB?=
 =?utf-8?B?N2k2SmpwQXd6RjgxY3NsWFNDMk85MzNIR2VCZjRTNk5ON0pVUXdlVzhTQ3B1?=
 =?utf-8?B?TFRDT2NzeUtXTENtWXJpQ01NR2lmb2s3VjdvbS82TFprbFVPTE9ia2JaTmM4?=
 =?utf-8?B?MEpjbDluUWlYVThiYXVwTUNEYmRuZ2RseVhFRWpKc1RleU5GR0tldnZWd3FK?=
 =?utf-8?B?RGdHSW9hVWNjNWR4NXkzdUdVR1RNNG1BRWdtVHZuWWpnYVBmVDVhaStMS2U0?=
 =?utf-8?B?Q1UvY3VXY0oxYStVakRQYkRDdWdZMlh2MDJBeExJMmFpUVB4eHFNUTMvQWNM?=
 =?utf-8?B?VTlwa3orUmg4RWcxeW5DMEgvUTU5OVc5ZGNPNDkwc2VYZ21sckpYdDBLN0FB?=
 =?utf-8?B?Q2V4SWtWcVYwWjhHV3c5L241V2FTTk10bkxMMllSeFJxdlk2NTNXdngzY1Yv?=
 =?utf-8?B?cUltdGlhbHlQT3dRWlZ6QU8waGVNajhtcUVhdVNIMmFOeVRUWk1kSkxuV0lN?=
 =?utf-8?B?QSszVUEwMTJHb2xDZ29ERkFFRDVGbEI0MjRSVXcwTzNJRWxqSFdmT0FoRjZh?=
 =?utf-8?B?dzQ2T3NZM0xVbkRNNzRiVmwxZXlLNlZpSzMwZDE4VTFGTFhQRU84S0toV0FV?=
 =?utf-8?B?Y0VkWnQxTjZJa2U2Sll0NmpOSjhIdktMeFBYRjFEQlZWRzRRYUdvU3ZSRHNu?=
 =?utf-8?B?S2JLZnpjNjdtcVhIUWdIdUx1M3M1YUpOV3BJVlhhSkE3TkNGZStNL2twZzRG?=
 =?utf-8?B?SVJVdjBvY0ZsWDVES21la1RWV2VEbjZVQnk1YUd2OWxrRU96SHdLOVNNQXBP?=
 =?utf-8?B?SkhNb1dQdCt5b1h6WDV6OFFVK0NTTzVLQnVCVUpWbUEvSDhOcG1ubUxzK2kx?=
 =?utf-8?B?QW9mVFdBWlkwNXg4ZEtXRm42TzdmWEx5WkM2aDNoQVFHcW56MFZiKy9wR3RO?=
 =?utf-8?B?SnRmUVRMYmNzRzJjSVVmUUdaeHBiYVd5a3VvcW9KVDZHRHBpNFowbWxLRXNE?=
 =?utf-8?B?REFhQUtJRTU1cHErbWNXeTZOMnhNV2RNUzhzdlhhOEJyeTRIekVyU3EyNkta?=
 =?utf-8?B?cUl1ZGZjaGhUZC9KY0pHVW9pZEVmKytueWZJR3hsb2kyN3pMWTVtUy80dU1p?=
 =?utf-8?B?d0JpTlFZeDRoOXVBdytCTXp6M0ZCTG5MMW54SFREZUN5cW8vbHl5Tk1FeG9E?=
 =?utf-8?B?ZWphUXk3aWVzbXM1bGExSjhBOFRaL2gvdy83cXF3Ym5IallYSzJvMmFRU2JX?=
 =?utf-8?B?cStxaHFuSGFTY0N4OG8rSGViR1J6bzZZaU1RN2VVRmRrU1BZSzhjaUZLa1Fv?=
 =?utf-8?B?ZVZicmRHc21UanpmWC9uYjNtSXNuaG5pa2tJa2k0aFVIMTlONUtvemxlMGEw?=
 =?utf-8?B?Z3d0clRVcW9UN2xYSGFsbDd6UndYNE1ZTVltUFVGWSs5VlJtV0tyVUthVW9t?=
 =?utf-8?B?QVpLZnJpRmFLZWI3VC8rRDJ0ZmpCdGRvQnlvcFdYazJ2VzMvOXdyUFBLVlc4?=
 =?utf-8?B?OGdSd2VwUGk4b1VMdmZsdVd2cER6dCtHdERObktVMG5jQk9mQ0s4SURkUGtR?=
 =?utf-8?B?ckJSOXRWL0M1U3RtSExIWWNWbWliYWtHYUhpUDNKcXc0N2JubnQ5cVozTEw0?=
 =?utf-8?B?ZXp1Y2x4djF6SjJEbTJicGlyZjM0aHZtSFE3OTJEdUhyRUcvTjY1L2pTMXNy?=
 =?utf-8?B?Vit2emZOd2g2OTVOMk5LcGpkVFZFY1hPZWRZUitLUEZ5ZnZtbkM4U0N1MFQ0?=
 =?utf-8?B?dGcwQlNWMU9pWWM4Wm9mODBhaG05aGFic29hU2ovalc4eWFEd25sME1VV3k1?=
 =?utf-8?B?bndmZVF6dnk0Y2V5S1NiWSs1M0VtYldqdlp0RGZEaFZHSzh1eWlzN2JLY0My?=
 =?utf-8?B?ZmV0eHZRZjh4ODNtUkI4cW9oTzIzTG9ZU0RyMG1XRGI4MWhwQTU3dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b037d739-4713-4976-7ae7-08ded5db800d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:39:45.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIThNwA015iWjFmzNIIRCH2V0uJxiDC0toQ3N7thNS+vaaaBcXFeU3lobBBieJ4B75iwj6okvlNIGtmYcstIAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2670
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9469-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,0.data:url,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86D696DA9B8

The common practice in C drivers is to store pointers into `driver_data`
field of device IDs. The Rust code is however currently storing indices
into the fields and then carry a side table that maps the index to
pointers.

It is much simpler to just have `DeviceId` carry the pointer like C code
does. However, just doing so naively would cause a "pointers cannot be cast
to integers during const eval" error, as kernel_ulong_t does not have
provenance while pointers do, and Rust forbids `expose_provenance` during
consteval.

Work around this limitation by wrapping raw IDs in `MaybeUninit`.
`MaybeUninit` is allowed to host arbitrary bytes with or without
provenance, so we can just then use `unsafe` to store a pointer with
provenance there. This has the same effect as changing the C-side
definition to use `void*` instead of `kernel_ulong_t`, but without actually
changing the C side.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/acpi.rs      |  4 ---
 rust/kernel/auxiliary.rs |  8 ++---
 rust/kernel/device_id.rs | 88 +++++++++++++++++++++++++++++-------------------
 rust/kernel/driver.rs    | 14 ++++----
 rust/kernel/i2c.rs       |  7 ++--
 rust/kernel/of.rs        |  4 ---
 rust/kernel/pci.rs       | 12 +++----
 rust/kernel/usb.rs       | 11 +++---
 8 files changed, 77 insertions(+), 71 deletions(-)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 315f2f2af446..ea2ce61ee393 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -25,10 +25,6 @@ unsafe impl RawDeviceId for DeviceId {
 // SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
 unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::acpi_device_id, driver_data);
-
-    fn index(&self) -> usize {
-        self.0.driver_data
-    }
 }
 
 impl DeviceId {
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 59787c9bff26..aa13d8866a19 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -93,7 +93,9 @@ extern "C" fn probe_callback(
         // SAFETY: `DeviceId` is a `#[repr(transparent)`] wrapper of `struct auxiliary_device_id`
         // and does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*id.cast::<DeviceId>() };
-        let info = T::ID_TABLE.info(id.index());
+
+        // SAFETY: `id` comes from `T::ID_TABLE` which is of type `IdArray<_, T::IdInfo>`.
+        let info = unsafe { id.info_unchecked::<T::IdInfo>() };
 
         from_result(|| {
             let data = T::probe(adev, info);
@@ -169,10 +171,6 @@ unsafe impl RawDeviceId for DeviceId {
 unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize =
         core::mem::offset_of!(bindings::auxiliary_device_id, driver_data);
-
-    fn index(&self) -> usize {
-        self.0.driver_data
-    }
 }
 
 /// IdTable type for auxiliary drivers.
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 022f0101871f..50d82bfca9b8 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -5,7 +5,10 @@
 //! Each bus / subsystem that matches device and driver through a bus / subsystem specific ID is
 //! expected to implement [`RawDeviceId`].
 
-use core::mem::MaybeUninit;
+use core::{
+    marker::PhantomData,
+    mem::MaybeUninit, //
+};
 
 /// Marker trait to indicate a Rust device ID type represents a corresponding C device ID type.
 ///
@@ -47,15 +50,48 @@ pub unsafe trait RawDeviceIdIndex: RawDeviceId {
     /// The offset (in bytes) to the context/data field in the raw device ID.
     const DRIVER_DATA_OFFSET: usize;
 
-    /// The index stored at `DRIVER_DATA_OFFSET` of the implementor of the [`RawDeviceIdIndex`]
-    /// trait.
-    fn index(&self) -> usize;
+    /// Obtain the data pointer stored inside the device ID.
+    ///
+    /// # Safety
+    ///
+    /// `&Self` must be stored inside a `IdArray<Self, U>`.
+    unsafe fn info_unchecked<U>(&self) -> &'static U {
+        // SAFETY: By safety requirement of the trait, this is `self.driver_data as *const U` and by
+        // the safety requirement of the function, this is stored in `IdArray<Self, U>` so is
+        // convertible to `&'static U`.
+        unsafe {
+            core::ptr::from_ref(self)
+                .byte_add(Self::DRIVER_DATA_OFFSET)
+                .cast::<&U>()
+                .read()
+        }
+    }
+
+    /// Obtain the data pointer stored inside the device ID.
+    ///
+    /// # Safety
+    ///
+    /// `&Self` must be stored inside a `IdArray<Self, U>`, or has NULL (or 0) as driver data.
+    unsafe fn info_unchecked_opt<U>(&self) -> Option<&'static U> {
+        // SAFETY: By safety requirement of the trait, this is `self.driver_data as *const U` and by
+        // the safety requirement of the function, if this is stored in `IdArray<Self, U>`, this is
+        // convertible to `Option<&'static U>`. Otherwise it is NULL which is `None` as
+        // `Option<&U>`.
+        unsafe {
+            core::ptr::from_ref(self)
+                .byte_add(Self::DRIVER_DATA_OFFSET)
+                .cast::<Option<&U>>()
+                .read()
+        }
+    }
 }
 
 /// A zero-terminated device id array.
 #[repr(C)]
 pub struct RawIdArray<T: RawDeviceId, const N: usize> {
-    ids: [T::RawType; N],
+    // This is `MaybeUninit<T::RawType>` so any bytes inside it can carry provenance in CTFE.
+    // If this were `T::RawType`, integer fields would not be able to contain pointers.
+    ids: [MaybeUninit<T::RawType>; N],
     sentinel: MaybeUninit<T::RawType>,
 }
 
@@ -68,18 +104,17 @@ pub const fn size(&self) -> usize {
 
 /// A zero-terminated device id array, followed by context data.
 #[repr(C)]
-pub struct IdArray<T: RawDeviceId, U, const N: usize> {
+pub struct IdArray<T: RawDeviceId, U: 'static, const N: usize> {
     raw_ids: RawIdArray<T, N>,
-    id_infos: [U; N],
+    phantom: PhantomData<&'static U>,
 }
 
-impl<T: RawDeviceId + RawDeviceIdIndex, U, const N: usize> IdArray<T, U, N> {
+impl<T: RawDeviceId + RawDeviceIdIndex, U: 'static, const N: usize> IdArray<T, U, N> {
     /// Creates a new instance of the array.
     ///
     /// The contents are derived from the given identifiers and context information.
-    pub const fn new(ids: [(T, U); N]) -> Self {
+    pub const fn new(ids: [(T, &'static U); N]) -> Self {
         let mut raw_ids = [const { MaybeUninit::<T::RawType>::uninit() }; N];
-        let mut infos = [const { MaybeUninit::uninit() }; N];
 
         let mut i = 0usize;
         while i < N {
@@ -87,18 +122,15 @@ impl<T: RawDeviceId + RawDeviceIdIndex, U, const N: usize> IdArray<T, U, N> {
             // layout-wise compatible with `RawType`.
             raw_ids[i] = unsafe { core::mem::transmute_copy(&ids[i].0) };
             // SAFETY: by the safety requirement of `RawDeviceIdIndex`, this would be effectively
-            // `raw_ids[i].driver_data = i;`.
+            // `raw_ids[i].driver_data = ids[i].1;`.
             unsafe {
                 raw_ids[i]
                     .as_mut_ptr()
                     .byte_add(T::DRIVER_DATA_OFFSET)
-                    .cast::<usize>()
-                    .write(i);
+                    .cast::<&U>()
+                    .write(ids[i].1);
             }
 
-            // SAFETY: this is effectively a move: `infos[i] = ids[i].1`. We make a copy here but
-            // later forget `ids`.
-            infos[i] = MaybeUninit::new(unsafe { core::ptr::read(&ids[i].1) });
             i += 1;
         }
 
@@ -106,20 +138,15 @@ impl<T: RawDeviceId + RawDeviceIdIndex, U, const N: usize> IdArray<T, U, N> {
 
         Self {
             raw_ids: RawIdArray {
-                // SAFETY: this is effectively `array_assume_init`, which is unstable, so we use
-                // `transmute_copy` instead. We have initialized all elements of `raw_ids` so this
-                // `array_assume_init` is safe.
-                ids: unsafe { core::mem::transmute_copy(&raw_ids) },
+                ids: raw_ids,
                 sentinel: MaybeUninit::zeroed(),
             },
-            // SAFETY: We have initialized all elements of `infos` so this `array_assume_init` is
-            // safe.
-            id_infos: unsafe { core::mem::transmute_copy(&infos) },
+            phantom: PhantomData,
         }
     }
 }
 
-impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
+impl<T: RawDeviceId, U: 'static, const N: usize> IdArray<T, U, N> {
     /// Reference to the contained [`RawIdArray`].
     pub const fn raw_ids(&self) -> &RawIdArray<T, N> {
         &self.raw_ids
@@ -133,7 +160,7 @@ impl<T: RawDeviceId, const N: usize> IdArray<T, (), N> {
     /// If the device implements [`RawDeviceIdIndex`], consider using [`IdArray::new`] instead.
     pub const fn new_without_index(ids: [T; N]) -> Self {
         // SAFETY: `T` is layout-wise compatible with `T::RawType`, so is the array of them.
-        let raw_ids: [T::RawType; N] = unsafe { core::mem::transmute_copy(&ids) };
+        let raw_ids: [MaybeUninit<T::RawType>; N] = unsafe { core::mem::transmute_copy(&ids) };
         core::mem::forget(ids);
 
         Self {
@@ -141,7 +168,7 @@ impl<T: RawDeviceId, const N: usize> IdArray<T, (), N> {
                 ids: raw_ids,
                 sentinel: MaybeUninit::zeroed(),
             },
-            id_infos: [(); N],
+            phantom: PhantomData,
         }
     }
 }
@@ -155,9 +182,6 @@ impl<T: RawDeviceId, const N: usize> IdArray<T, (), N> {
 pub trait IdTable<T: RawDeviceId, U> {
     /// Obtain the pointer to the ID table.
     fn as_ptr(&self) -> *const T::RawType;
-
-    /// Obtain the pointer to the driver-specific information from an index.
-    fn info(&self, index: usize) -> &U;
 }
 
 impl<T: RawDeviceId, U, const N: usize> IdTable<T, U> for IdArray<T, U, N> {
@@ -166,10 +190,6 @@ fn as_ptr(&self) -> *const T::RawType {
         // to access the sentinel.
         core::ptr::from_ref(self).cast()
     }
-
-    fn info(&self, index: usize) -> &U {
-        &self.id_infos[index]
-    }
 }
 
 /// Create device table alias for modpost.
@@ -184,7 +204,7 @@ macro_rules! module_device_table {
             $device_id_ty,
             $id_info_type,
             { <[$device_id_ty]>::len(&[$($id,)*]) },
-        > = $crate::device_id::IdArray::new([$(($id, $info),)*]);
+        > = $crate::device_id::IdArray::new([$(($id, &$info),)*]);
 
         $crate::module_device_table!($table_type, $table_name);
     };
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index bf5ba0d27553..824899d76fed 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -107,6 +107,7 @@
 use crate::{
     acpi,
     device,
+    device_id::RawDeviceIdIndex,
     of,
     prelude::*,
     types::Opaque,
@@ -350,7 +351,8 @@ fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
                 // and does not add additional invariants, so it's safe to transmute.
                 let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
 
-                Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceIdIndex>::index(id)))
+                // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
+                Some(unsafe { id.info_unchecked::<Self::IdInfo>() })
             }
         }
     }
@@ -381,9 +383,8 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
                 // and does not add additional invariants, so it's safe to transmute.
                 let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
 
-                return Some(table.info(
-                    <of::DeviceId as crate::device_id::RawDeviceIdIndex>::index(id),
-                ));
+                // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
+                return Some(unsafe { id.info_unchecked::<Self::IdInfo>() });
             }
         }
 
@@ -412,9 +413,8 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
                 //   and does not add additional invariants, so it's safe to transmute.
                 let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
 
-                return Some(table.info(
-                    <of::DeviceId as crate::device_id::RawDeviceIdIndex>::index(id),
-                ));
+                // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
+                return Some(unsafe { id.info_unchecked::<Self::IdInfo>() });
             }
         }
 
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 6f2dcd467e72..31f2cfe6be31 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -65,10 +65,6 @@ unsafe impl RawDeviceId for DeviceId {
 // SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
 unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::i2c_device_id, driver_data);
-
-    fn index(&self) -> usize {
-        self.0.driver_data
-    }
 }
 
 /// IdTable type for I2C
@@ -212,7 +208,8 @@ fn i2c_id_info(dev: &I2cClient) -> Option<&'static <Self as driver::Adapter>::Id
         // does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*raw_id.cast::<DeviceId>() };
 
-        Some(table.info(<DeviceId as RawDeviceIdIndex>::index(id)))
+        // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
+        Some(unsafe { id.info_unchecked::<T::IdInfo>() })
     }
 }
 
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 35aa6d36d309..d0318f62afd7 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -25,10 +25,6 @@ unsafe impl RawDeviceId for DeviceId {
 // SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `data` field.
 unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
-
-    fn index(&self) -> usize {
-        self.0.data as usize
-    }
 }
 
 impl DeviceId {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index a3dd48f76353..925cf280dae2 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -110,10 +110,14 @@ extern "C" fn probe_callback(
         // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct pci_device_id` and
         // does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*id.cast::<DeviceId>() };
-        let info = T::ID_TABLE.info(id.index());
+
+        // SAFETY: `id` comes from `T::ID_TABLE` which is of type `IdArray<_, T::IdInfo>` or
+        // `pci_device_id_any` which has 0 as driver_data. It can also come from dynamic IDs, which
+        // will ensure that `driver_data` exists in `T::ID_TABLE`.
+        let info = unsafe { id.info_unchecked_opt::<T::IdInfo>() };
 
         from_result(|| {
-            let data = T::probe(pdev, Some(info));
+            let data = T::probe(pdev, info);
 
             pdev.as_ref().set_drvdata(data)?;
             Ok(0)
@@ -233,10 +237,6 @@ unsafe impl RawDeviceId for DeviceId {
 // SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
 unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::pci_device_id, driver_data);
-
-    fn index(&self) -> usize {
-        self.0.driver_data
-    }
 }
 
 /// `IdTable` type for PCI.
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index d8cffbe594ff..aec7dce04955 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -89,8 +89,11 @@ extern "C" fn probe_callback(
             // does not add additional invariants, so it's safe to transmute.
             let id = unsafe { &*id.cast::<DeviceId>() };
 
-            let info = T::ID_TABLE.info(id.index());
-            let data = T::probe(intf, id, Some(info));
+            // SAFETY: `id` comes from `T::ID_TABLE` which is of type `IdArray<_, T::IdInfo>`. It
+            // can also come from dynamic IDs, which will ensure that `driver_data` exists in
+            // `T::ID_TABLE` or is 0.
+            let info = unsafe { id.info_unchecked_opt::<T::IdInfo>() };
+            let data = T::probe(intf, id, info);
 
             let dev: &device::Device<device::CoreInternal<'_>> = intf.as_ref();
             dev.set_drvdata(data)?;
@@ -242,10 +245,6 @@ unsafe impl RawDeviceId for DeviceId {
 // SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_info` field.
 unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::usb_device_id, driver_info);
-
-    fn index(&self) -> usize {
-        self.0.driver_info
-    }
 }
 
 /// [`IdTable`](kernel::device_id::IdTable) type for USB.

-- 
2.54.0


