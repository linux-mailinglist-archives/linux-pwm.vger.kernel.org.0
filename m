Return-Path: <linux-pwm+bounces-9593-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HyasDDq5S2rsZAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9593-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 16:18:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9104F711DBA
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 16:18:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=mbYX1Aw4;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9593-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9593-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040FF330E10C
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5812430CE4;
	Mon,  6 Jul 2026 12:44:37 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021091.outbound.protection.outlook.com [52.101.100.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683342F714;
	Mon,  6 Jul 2026 12:44:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341877; cv=fail; b=KdtvU6Dx2YSTCXKdD3gnMTnO8cvJUa3PmS2anMFg5pyRLSjs8UDrDWrCMO561eMVOay0D6jXa/K9P3MXMw62r184UONzKzOQEox+ajbcWyiqWoA+B+Y+mtW3UbPxHq5wN2R7pppuxSrT9AnlwkgHld/nWvFlDmH2KAPqlH6bl08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341877; c=relaxed/simple;
	bh=fihaNEvBsUOHv/rajYVxMKB3dacL3pnz1EOCGPpcawA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=A++23daYNqnGdJZDn6UikKcq4xYSJ3mp0vyCP723Tu+V23bfWiOkFERn8hJod/Be83YN0pyZcd0hTupfa34fZsto7KuvXv210Gl5y1oyO7ImXgoKEorL1m0OsLxDk0TxByEWjfvQqRma3j60jewIarItFc2F6oPOMi6tfoLe9qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=mbYX1Aw4; arc=fail smtp.client-ip=52.101.100.91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onUD18/5/vykTr7gXpO8G2FMyCNQlJI11DTN0a+4fKepRSzroXWZO9kNENfR8Jf9JKyxK5HdXYtt2KVzPRm2seTRxgEnazroafUd1/PYYzOGIz23TVJ32NN2vISIw2t2kMIAW231HKXF2fkW/lGY4Og6GDy9WGcMZoBOLpAY1Bl79BIz0mng5zJ9eqsgbHGlmtLOM+1yJZLiZuGRQ1dkHRsK7tkreQynYz+/4NFPonoWP0eFtAvnCybrKGXXsGLLqDJbN9wm3Enft95b7c8Mn/0Kf7+BvHFCDtk7p+9WsmMXD/WCFp4bKBz0Nx/axiIsZVRFkckoaJP91+iNT3MUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8bLK5UA8+n0FfxqSaZGj8XCfzPJEMK5kNCq/p82M5g=;
 b=cMkXNB51A8bcVYzP0PanTEjtOVv94b5/OdNbv6l+6qC+hZgibBZ1sdA6GAbBVyUh5nurD9Kwjm9Xlz7DoNzJoFmOslLLzUbqeyE+j1/GR7H4rxM61Och9ycBLjIaN83Nr6k2McI5FWONZHZiiZH4+Zj5QarXyEUgfki3ZJwHsExeRn8/KjICY/4BQcn/wuxFg3dF4zNoodQGx+s2f1pkeIzPv/4ANU1/PdQLnwzcPFaJQts2jmc6Qt1FUp0HYOHWHx2vkZTulhgCa7mdf77bqqDSXLRh2/6pf/PPsex+DCsidctSQ9/Yw6Q1GEjEfs9PV6pOgPQDiW54ENJ8Hh/+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8bLK5UA8+n0FfxqSaZGj8XCfzPJEMK5kNCq/p82M5g=;
 b=mbYX1Aw4+iMCpTiEdzlzUI0Ng1RWnE103KqSCIIuYkWtwEWkOBvdS/slqB12ZE0pNXxcOe/jSNBpk4Fyqih/+CaCqvcBqWiDK6uQlWRb6iiMChM2MJKTIQIjIDNRw46lxLaroCES/6LcnaKL9naE/Mjiq3JhQYzwr18+uZdjI4Q=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6188.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:278::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:28 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:28 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:21 +0100
Subject: [PATCH v6 08/20] rust: pci: io: make `ConfigSpace` a view
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-8-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=5908;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=fihaNEvBsUOHv/rajYVxMKB3dacL3pnz1EOCGPpcawA=;
 b=jkNyXt1JUoQ7fcUlV4Upj7CMArOv7eXo8gCyVVdbHV+r+ySAgr0bKuHw3WhXD67Z9SnSbfX4M
 vxLLP6xXno1BYuRrFJUGwrK9jNNZgmzls1AXQRGhz1UEoI6c8g6n1z9
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: b51ab622-af40-458b-5f2b-08dedb5c5159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|22082099003|18002099003|3023799007|6133799003|5023799004|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	U8oYx7jAmXnar3cA1IbFc9ZSDPdCwEtppgBKd8FhZYCrrV2fqkyK80pFFaMkewE4Z2crTd0p59icC87iKoPQfrtUhvZcvSdeCIjGZb4jVjgJ6+zBEgHJila11c6/6q42BA19mrahhhCGnxTgq8BeQ18kC5TLAtlaKfg8XP2hHFSPDybHCmR5FD+89H8BW38ErWZEioGuegKMu6I51cXjcLuFwB7oDBCX92Kg/O6W3kpvgwseqXcNjvF+XCQuZ7i3C8zuBSmk/JUVKqU+Pckk90rRKIn3gS4b2tsggwr5fq5k76khbV6HeQ2UHcS41GPzH+WDA/XRsOrwVb9e2RkY+ff4yNpC9WolBurSIpxM3IRknzqdHBjVp0L5K1uGoywAcMG8bPOTrYhEmOmTu52vDIXcqFd+NW7Ym27UMoHnztN4NrLKHp3350u9W6YeUaljl0zPzNwpUl+EfyboONLB7Ev0HN/2AMTyIKPLOwz+33VM486XimfsQMoDKtab/oUfN56yD6wUQQbtLAaOV9ak3qL2uRbaArE4p9Dqx4UJsnlBl20oNjZR+SbFuw/nRFNZN1QVLlmB0Tsc5UowEQz8HddpG5TBtHWLwOcVoQeLtbCTGt3DvAACyWHUT50lvwrDBX7semqO62azB2pHCA2oZVA6v0inQ+29Mmw5qZpWAoPWt6gVBLMJw6pJKKXNJs6E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(22082099003)(18002099003)(3023799007)(6133799003)(5023799004)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlRaaG5pa3Jic01RWWxzalEvakYrZGQ3Umlob0ZmVHl2dHRVM1NlaVo0NjFH?=
 =?utf-8?B?SkF0dU50YzljaHdBUlFqSGVHdlhuSG1jYzAzdSszT0hJVTl5Tm5yTFNDSnlm?=
 =?utf-8?B?TWlUQzhoamhkRk1WRVB4ZUJ4NVhid3YvRlBzRlA5RHEyekZOMWQvaVVjV1Zm?=
 =?utf-8?B?VUxneFB3NlFzNWRzSVBERmRyVGx3czVUam9ES3ZNWFJNcGxjamlGVDdkM3l5?=
 =?utf-8?B?bVJJNXAvM2VpSDZGQWJtdzZXSWVYajRGNnhvNUphOEtmUXUzVTcrMVhsUHNT?=
 =?utf-8?B?b0dDNGlGNExUOWczc3FveklNMUgxenpIUlNiWElteTRGMU51dEJPN2k3cE02?=
 =?utf-8?B?c0NiWE1aaGxCYWhOMGtKVjRNeHVvcmhqQ3ZFL0huZ2UvZTNtd0NscUREejFG?=
 =?utf-8?B?M1NoVjVUSFR4Zm5JYkc4Wkx0d2U1c2czSFpicnIzck5hVXRwa0ZuMDBXQ2NO?=
 =?utf-8?B?Q01Vdlg0V0NUQko2YzE3VEF2V2xuL3dMeHcyekpIYkQySXo2SEw4UE5NNVYz?=
 =?utf-8?B?OUFsbHFuR3A5bXYraUJUaTM5Z1l5bm5hVHhDazZCamRuS1dWdHorOWxTSEc5?=
 =?utf-8?B?L0ZkYUtmbW5OeVRDbGxodlM0SS8zdk5xeHFGUjlRUzVVb2xvNFlOd2ZsSmdk?=
 =?utf-8?B?SVJpczQvOFBhall3Mm92WmxqMllmNjdQUGFXb2lGVTR4WDlrd1VKQmNrQXJp?=
 =?utf-8?B?UEF3SzVNSnh6cE9zOHYrNVFIVHR3TVlFOTZ4MWdqWnBMWGI0YnUwTXovNld0?=
 =?utf-8?B?UzhvU2ZURzA3TlFLUklsdEFIamNEekUrWFREajVUbk5jUHJvcUY3eTc2c2Ry?=
 =?utf-8?B?SXlSb2NiME1IZW1uQ3N2NDMyTjZsQ2ovUVZOcThBSG5JNHUzcitYYzFVd3lK?=
 =?utf-8?B?VjltQ1BqUFFVcllsSDlUNVFrZWtiWmlSaFNramZsNk0zRk9TMEJGOXp6UE1h?=
 =?utf-8?B?R3pRQlB1VzJ4ak9UZ0JIZEpxblJYV29sRWtUYkFEVGQvazJjQTA1Y0t0RGxT?=
 =?utf-8?B?RzFvWHRleGVDT2FSY21mNzZETTk0d0VjK1lDdTlpMEZ1aldoNlJ2d0FVVDRJ?=
 =?utf-8?B?aGJyNFZ2N2N5QVpWR1FZZlpabEpuRDZ6c3VET3RsOXU2cVFua0NPNTV3WEpt?=
 =?utf-8?B?MVZQMHNjcUtzY0JZaDIvMHhpTHR2Rm1IUnNKVFhMeDlaQWYxVmE0K3VwTGNW?=
 =?utf-8?B?SEVlZ1VrM29YR2w1K29CckJkK2YzZDJMekJ1ZlEzQjJ2OVpVcUlJV0NFaGhL?=
 =?utf-8?B?V2ZvZXRsN3ovRGoxRmd0eHc3VTZWTTVic0ZTbk8xZXpDbjkyWnVsNEZaWC9U?=
 =?utf-8?B?VGg3MVBta1ZmQUNRcGNWZENvSXhWWjdyMk5aQmU2UVdxUm9nVXpTUnVtUG1r?=
 =?utf-8?B?N1UzV2RuRFc3ZG5Oa0VhNGQzR1Z0d1BxQXMxa2ZsdThwREVRNElVYmdJQ2xl?=
 =?utf-8?B?SE83aGluRzFZMWtBdnhlSkxHd2wxZmFRQ1owMUE5bEs2NGhOVWUxakFsQ1NX?=
 =?utf-8?B?cWU1WkFoK0lZTFlndVZyT2lpaTROWFJkM25UQll0UXhpdkd3ckZ0bm0waUJk?=
 =?utf-8?B?SzVLaXVzNzNOR1RuZ1YxYXZnemVKd3ovMnhuUzdjaXljMXJqVzJRcGpnU2po?=
 =?utf-8?B?VVk2ckxoUUozMXVOeHo2RWo0cEoyNEo3V2JibEk4aFRITnFXZlRIUGs4dGlk?=
 =?utf-8?B?d2M3RmN4ZjBKSXovYUkxSEJETHFHb0tGZzVFaWlUT0dFOFNXOThNSHR2SEVS?=
 =?utf-8?B?MUIwbUFZNGtyUEVycmN6WnNVY2l1am1oMG84UzlzYmZGZXZ2T1pWTTVyQ2I3?=
 =?utf-8?B?Z1YrNXdtOUthZEU0S3d4RkV3UUxKaVlRbzJocTRNdDZrSHlIUHNLVTZHVDZ1?=
 =?utf-8?B?VE43N2owRDJ4YWJ6NlYwd2hqNVVTb1RLaDFjcFlDWFdkcXYzb0JzMVRsdDFm?=
 =?utf-8?B?b2hGZmpIM1ViRFVsalZ5T3RVVXBodEs2TEJvTDBrMWhmVGRCVnRYYlArMEwz?=
 =?utf-8?B?YmVSZU9EbFVpOFNleUl1WDIzYWFEQmxTNFFMbGEvWWRBdGFOSWRSYTBEQ1dw?=
 =?utf-8?B?TURnK0UwS2dicEdhL3lmT1k1ZDZPNDg4NkllN1pEZkZ0VGtHRmdVZDRWazNj?=
 =?utf-8?B?aDlNWFU4NERWbVhkbTQ5VFVobFZEZjU0V3ZQMVJjcW1LS0VTckFpd3pwR1hE?=
 =?utf-8?B?VFdURXBHSlFxaXFDYXkydWVLTTQ2WlcveUVJdUl5eWhOVWE3VWxNaW81dDR6?=
 =?utf-8?B?SmxrK0xtK1Vtb2FZYjE3a3YrQWpzcjlQclpPWXYxd1FDUTJFNUpGY2NnL1M2?=
 =?utf-8?B?ZGZxUE9rMktzVTl0VkV5NEpzTWpKaG5QNU5lVFRjcjBvaGlDcDBnQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b51ab622-af40-458b-5f2b-08dedb5c5159
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:28.2167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVPZJNWoEpf+EFsKHx4wqCcFk/Nkjnl2nWmf9XMcgGBt/c4HF2dPoZUSED1LwHoJbMPgwuf0b6DGAphQypyA8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9593-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9104F711DBA

In order to support I/O projection, we are splitting I/O types into two
categories: owned objects and views. Owned objects have a specific type
that is related to setting up and tearing down, while views can have their
type changed with I/O projection.

Things like `IoMem` or `Bar` are owned objects, which requires setting up
mapping and cleaning up on drop. On the other side, `ConfigSpace` is really
just a view, as the resource is associated with the `pci::Device`.

Remove the `ConfigSpaceKind` bound on `ConfigSpace` and make it a generic
view. This means that `ConfigSpace` object now represents a subregion and
therefore encodes offset (as address of pointers) and size (as metadata of
pointers) itself. The full region case is still supported with offset 0 and
size of `cfg_size`.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/pci/io.rs | 64 +++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index e0acb62f58a2..89f4bb483a7f 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -18,7 +18,6 @@
     ptr::KnownSize, //
 };
 use core::{
-    marker::PhantomData,
     ops::Deref, //
 };
 
@@ -53,33 +52,42 @@ pub const fn into_raw(self) -> usize {
 /// Alias for extended (4096-byte) PCIe configuration space.
 pub type Extended = Region<4096>;
 
-/// Trait for PCI configuration space size markers.
-///
-/// This trait is implemented by [`Normal`] and [`Extended`] to provide
-/// compile-time knowledge of the configuration space size.
-pub trait ConfigSpaceKind: KnownSize {}
-
-impl ConfigSpaceKind for Normal {}
-
-impl ConfigSpaceKind for Extended {}
-
-/// The PCI configuration space of a device.
+/// A view of PCI configuration space of a device.
 ///
 /// Provides typed read and write accessors for configuration registers
 /// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
 ///
-/// The generic parameter `S` indicates the maximum size of the configuration space.
-/// Use [`Normal`] for 256-byte legacy configuration space or [`Extended`] for
-/// 4096-byte PCIe extended configuration space (default).
-pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind = Extended> {
+/// The generic parameter `T` is the type of the view. The full configuration space is also a
+/// special type of view; in such cases, `T` can be [`Normal`] for 256-byte legacy configuration
+/// space or [`Extended`] for 4096-byte PCIe extended configuration space (default).
+///
+/// # Invariants
+///
+/// `ptr` is aligned and range `ptr..ptr + KnownSize::size(ptr)` is within
+/// `0..pdev.cfg_size().into_raw()`.
+pub struct ConfigSpace<'a, T: ?Sized = Extended> {
     pub(crate) pdev: &'a Device<device::Bound>,
-    _marker: PhantomData<S>,
+    ptr: *mut T,
 }
 
+impl<T: ?Sized> Copy for ConfigSpace<'_, T> {}
+impl<T: ?Sized> Clone for ConfigSpace<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+// SAFETY: `ConfigSpace<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Send for ConfigSpace<'_, T> {}
+
+// SAFETY: `ConfigSpace<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Sync for ConfigSpace<'_, T> {}
+
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for &ConfigSpace<'a, S> {
+        impl<'a, T: ?Sized> IoCapable<$ty> for ConfigSpace<'a, T> {
             unsafe fn io_read(self, address: usize) -> $ty {
                 let mut val: $ty = 0;
 
@@ -112,19 +120,17 @@ unsafe fn io_write(self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, S: ?Sized + ConfigSpaceKind> Io for &ConfigSpace<'a, S> {
-    type Target = S;
+impl<'a, T: ?Sized + KnownSize> Io for ConfigSpace<'a, T> {
+    type Target = T;
 
-    /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
     fn addr(self) -> usize {
-        0
+        self.ptr.addr()
     }
 
-    /// Returns the maximum size of the configuration space.
     #[inline]
     fn maxsize(self) -> usize {
-        self.pdev.cfg_size().into_raw()
+        KnownSize::size(self.ptr)
     }
 }
 
@@ -281,23 +287,25 @@ pub fn cfg_size(&self) -> ConfigSpaceSize {
         }
     }
 
-    /// Return an initialized normal (256-byte) config space object.
+    /// Return a view of the normal (256-byte) config space.
     pub fn config_space<'a>(&'a self) -> ConfigSpace<'a, Normal> {
+        // INVARIANT: null is aligned and the range is within config space.
         ConfigSpace {
             pdev: self,
-            _marker: PhantomData,
+            ptr: Normal::ptr_from_raw_parts_mut(core::ptr::null_mut(), self.cfg_size().into_raw()),
         }
     }
 
-    /// Return an initialized extended (4096-byte) config space object.
+    /// Return a view of the extended (4096-byte) config space.
     pub fn config_space_extended<'a>(&'a self) -> Result<ConfigSpace<'a, Extended>> {
         if self.cfg_size() != ConfigSpaceSize::Extended {
             return Err(EINVAL);
         }
 
+        // INVARIANT: null is aligned and we just checked the `cfg_size`.
         Ok(ConfigSpace {
             pdev: self,
-            _marker: PhantomData,
+            ptr: Extended::ptr_from_raw_parts_mut(core::ptr::null_mut(), 4096),
         })
     }
 }

-- 
2.54.0


