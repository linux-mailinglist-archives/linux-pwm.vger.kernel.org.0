Return-Path: <linux-pwm+bounces-9605-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eGPMDuykS2qsXgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9605-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:51:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD404710CAF
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:51:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=nnnSn6RC;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9605-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9605-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A92763042BB9
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6374E438497;
	Mon,  6 Jul 2026 12:44:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022091.outbound.protection.outlook.com [52.101.101.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E03437849;
	Mon,  6 Jul 2026 12:44:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341892; cv=fail; b=Id8iBcIVBdC3AYR/u02Cg4Oq2xvVquibr1bKrDrNJVmGv6iwt8cd4iiU8UAzftalUbkBDwCyeNbZlV67OB0Ye4BKDyhFKXPsCVr/nf0Ovy9kfmVVFquBpj+3J+Bi6KHhAEH/A/GLs5fQ6+h5Vmu1gQiwNFJbYCloTWJ9Av8fKtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341892; c=relaxed/simple;
	bh=h24dJ7dnCHnOBDOejt/EnOyVIzMHXnpWeyKxoA+ZkE8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=vAfLwIkj5EIV95dC9CSVllDuVAWqVLyt/VsyGGpXpzsiIR6N9uh+leIhKJSiF0J1WagGmzZSsJaJAmN2iLd14qrhMloCgNns7G8oAGOIgzrCbS2pNDNkiRXz0JXxng+oMfI5RsgYCj8LQ4cqIeL98FngFD1h1bd9wSYowfa6L0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=nnnSn6RC; arc=fail smtp.client-ip=52.101.101.91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVwpHZNbTZ8QRAa6l3sqetTeCZJaZfu9vMtEqsKe7gge0r4wCd93D0feoTuomSvgPAxb/ErbGXEqtNTckeoT+3pRQ3uZHyiFewwhULGqNx4g10cpZx4lQalxRxu5Ag6wjDQV3FAqpVWQQyTK9YzMl5jFozqPDV6c7Mx6/WZL9h/ZgoLcvkr6cRVqgX0KCft5Bhcocb1uwShpc/6Ww1vsDObki6n6imDLm3CibUTWJMs0pYbwU9EMD/oI11uI1OkIKF/pAgxa12yZ2N1fz46/v6C6/beT27+tHQ6L8ONcXDcRh+Ih7mlMBFQ0tLxPYVxi+gJNTxz+PhHYwSEhrqTnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jw6no+2LaONvJu9C9FjvQfkqxaEb7WhIbimiq0PE3wQ=;
 b=gaXDeEhGvcDO6LUQia/rG5BR+k4zAC1UtzEAtOVmHaS/wEfMFT0rA4Lt0KpOweHpuR4g3lck2nqSj2/tIgIovUHOi0u5rt1NPXORO84vy340DFjAhnH9xkF4X0kIi6m3vQ12JYYHp/ugXfnRTocSenSJODEAfAseWiRAsxmU5rKbyKkq7iJuXVOYTUB/0XFgFugUK8s1QvizuLam4VJNQ6Rnwb5hiZr/Y5XysWK7AGy1mFFVuKhq8jyi+Lmjh7ip/vEta2hUXm/rYFBehPeC+O12FJXqpZ/OkBg41i0tQ2HZYYzuudgUhzc4YH6NbO85wEY7GtZdk2z5FjF98R6RQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw6no+2LaONvJu9C9FjvQfkqxaEb7WhIbimiq0PE3wQ=;
 b=nnnSn6RCZAV6zuIUd5yYt1hTxHVhu/t5NVTsIcHXjE/w+KELaMcg0h/cxxjZoPARQ0m1a6r6ynVVcXBFUyVnknKQZxJv2UNZBZXK03zpvUu1tI2ZUokxfsvVA8dz+cz/QVUaGE/V5Ng8ZZdFHDN+8iGTbdtl8cHegIQyleSR4ps=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:31 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:31 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:28 +0100
Subject: [PATCH v6 15/20] rust: io: implement a view type for `Coherent`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-15-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=5793;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=h24dJ7dnCHnOBDOejt/EnOyVIzMHXnpWeyKxoA+ZkE8=;
 b=RoktTCf46/ZoXQxvaVsS1/AHKj6f8rAk4HuDB0+aTukmdbT8yl9fDfu1bgni5nyy71nGzKwQZ
 DiZiWhMbVHTDP3NAwZZB1yZ0jGFxK5IfaBx427SowKR4Xipi/aWZRet
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
X-MS-Office365-Filtering-Correlation-Id: bc7860ca-29c6-49e1-56d4-08dedb5c533e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|5023799004|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	ROwFJ+tSPHFV+uDgAS9jehpfvA+TH73GYDJBzzKBQo/vkBJqvH6gnb0MJSYog75i3R951kp1gltVi66ICDaxqtMjWQYMvacqvROoyrRcgNj2TSMzDdcUztywZ/0qExlYCgHS7BnERJC/nALjSl+5dWTZ2sOcC8AIiMtAEDD/Wyj0GRzTbgCLFDTMcBLyaDOknRPs9u6gUHzqjbYNCwPzIb9pnM75SxmYWMzwwziocNcK9NPbnVkdyYywzNFAgTozIQJFFPG2zg26rrOah6x+EhKXfCfYmAcuxur8H781aQvF9THRZT90lg0LO+N1aYVBgZoV+QWlJu50CzvuZbu5EHuTOg3dEgd3IJXgY4Ak1YTqeiElJZhe5Jafq49x2bKq59HbW0e/8AJcRdw0gbGkKUcZ0iVSzGFr2xOZQ8jNRm2aynZ4V5WUkifiPmXljKPCWbKF47Yn66lNMrkia77cad+FCI8nrGbpMoap0Lm50Q2wxRi+baZ3xDqiuzjW0IlQvXErI9eqVqzA9wpe4RZDPi/4yO6jGf5Mx6+x5fedJ53AI2UKqnMzWEC25GNs9Oapr48RaUAVOOOvHnlMTiDc9lKMpOvVM8Ed9OVaCn0vaQVkH0PH8p+gySF8STu1otmvCHFAW7wh8KoBsul57RzTSKdePQAN0rhkoI+aMXhHpvc567eOQVYDigaUyzkV+CfoPTs3afyigyeNYLiDcH5O2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(5023799004)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTVQSURWTzRsOElvOG9zbm5TdEJjaU1pdk1TQnRCTGRGdm5qZERoQ2hwdWFR?=
 =?utf-8?B?ZVFYM0hVa29Ibi9BQkJnZnJCZCt0THFnYVRtT2x6QXd5N3U1NFVsNmNYREpO?=
 =?utf-8?B?NFppQldnQkR6bXpNNDQzSkxIN0liSG1uV2owZTY0c3BNa1k0YWlUNUxRcHRo?=
 =?utf-8?B?YllnODNmNGVyTDVTVy94Tzl5d01kQldwTDhQZ3ZnUFUyMEtXUTRmKzVPVXpu?=
 =?utf-8?B?YUtoVTliU2RVNXNUSW4zcHNSUjFCSnBLOEhzSUs2K3dGQTlYN29hUHJCLzF2?=
 =?utf-8?B?a0p2U01GZnFkam0xUjdMWEx4NWpKTHFGWHplVzliQlBDaEJDNVV4a2hUZWVQ?=
 =?utf-8?B?WkNFY1hKTW9pVHhOUzBYTVpYbGg2ZDdrVEpHZ3lRNUJlMG9iK2ZwUnF4ZHF0?=
 =?utf-8?B?SVZWVEFjNTI0N3A4MjA3SkRrTEN6MUhCbHhvOFFrV08xV1VEU0Q3K2JSZzJO?=
 =?utf-8?B?MEo1cFVSQ3k3Qm5CeTlydUFFNHhDYjA0RWQ3cFYrRlZUM1ErZ0p6VHJmV1U3?=
 =?utf-8?B?eE9FNjR5UzVVZWF3elljN2ZMSHlMdkxmcmw5UldXZXFvQklQcDF1VnNJemQv?=
 =?utf-8?B?OXVCV21qdStCZGdNdEU4MFJpUWs5U0dLTFhuZ3ArKzl4NnluNWFIeVRWSHNI?=
 =?utf-8?B?YUdvRTRuVlRBcDh0R3JyelltK2xXZWEwcCt6MG9KTTBkT1pzeVc2cG1sOWVP?=
 =?utf-8?B?UFFQc2hxTHNZMmNxUGpuL29tS3NTcTFuVXdhekFBa1RyRUFtM0lta3NHUEow?=
 =?utf-8?B?NEVRRXhpOHpxZ2ppejFZbDBNT3o3Rnd5SWhlaW11M0VZclg3VVVVdXQveWg3?=
 =?utf-8?B?dkovUFZCeGM1UWREdjJWTU0yR3NMS3pOSGlHcmlzVDdwd0FxSDBvMTRyQlJz?=
 =?utf-8?B?NnNtZDR1OEN1VW9qbkFiK3ZzQnJ1QlFlN3d2cHVhSTR3NnpRSVlFY2s3eXFa?=
 =?utf-8?B?RGoxS0F3R29jazVZeVpNclFveUxteE5HZFRTdXlkaS9aSkRoZHNKRWNrYXox?=
 =?utf-8?B?QnBJZS9pOFJYcW1qbXdCeVJhVkdJUUt2RmR6cVg2NkxKdDhtbWlVT09IS0Jy?=
 =?utf-8?B?cUFERURvWVVJc1NVY0VvZ1dvbUROVkJnQ2NvazFjNFI3aHVVOFRvNkF3MWti?=
 =?utf-8?B?U3dzTXlXOFIwYm9lamEyZWFJV2x5TUk5Q0hwS2RrYWtjR01BcUNPZ1VQWHVq?=
 =?utf-8?B?WUNBU3VobGNKQnR2UWsvM0phcFlodndGVW45bUVtOTVFV3pUTURleEhnSzdC?=
 =?utf-8?B?eHl1MnBqdGFxcEhBbHQvTkJFUlM2all6aDZEeGEzYm92eGhpUCs5MXFCbC9a?=
 =?utf-8?B?REtQa0llNjRYRFVPbkRXcGNjU0haZ2RlOVV1TEtnTk5BVHhzNTRQR0owOXlq?=
 =?utf-8?B?NS9maGhNK3c4RmpHbjkyODlvRDlVTjRScUgvMmpEWk9jcGE3UXArdnAyUG9O?=
 =?utf-8?B?OWx1NU5TenlNaXMvZTlvRm11YUhlejIwTG9yUU9QZVlPVTlrVnhtNUVENXYv?=
 =?utf-8?B?U095dmJFUFFIVGd6dlhOMS9qR0N3VlpUczR6dDAzdnZWdmlWVVc0dnM1ZDFM?=
 =?utf-8?B?eEx3djRpd2xpT2pUa0dISHh2aHJnNENPbkZrUm1EUWhuM0pSb1ZwcGNteHNw?=
 =?utf-8?B?UktNc040K0I5M0RmNDFva1ArSVVHdXlrTWFRMzFyaytPbUlXaFFnN28zMCtH?=
 =?utf-8?B?NkxjekNka1d2THI1MGRuekcxQkE5TDdtb1JLdEpYNnJkaE16N2dCc3NoNVhS?=
 =?utf-8?B?R29BbUJNNVRVKy9QL2UwMHpNUjlkZDR5RWdVVXVoeDA3UnI1STFRTCtJL0tI?=
 =?utf-8?B?N3ZLYzE1Ujc0UmFYUHhFQ28xRGR4cmFDbXI2am9hemJYZHpQdVFsKzlEa2dz?=
 =?utf-8?B?QXJVRkRpUThpb21VRzdlV2xlSExLQ1RSYnU0V2ZSUURJNjdPVE5rNXlYa3gy?=
 =?utf-8?B?ZUsyNEdVemhqcmE2cmNGZnhuSnFydG1lYUFHSnlNazduSDN3RkM2OG1QYnFC?=
 =?utf-8?B?ZnRkdXV2RysyWDd4eEd0V1RSOHdnSEY1QkVXMFhqcTNwS1NQVmNxcmQwT3pG?=
 =?utf-8?B?ZnRRQnB1Smxjd25MSGVFTVk5Mk5pbVE2VG9LUWIvdlpXMWYrL1RqZ3VvRG9J?=
 =?utf-8?B?OTNZRzkvWm5uNmNjbkFmZVNwR0NyOEo5dmlSTHc1L2c3STQxSkRlOGhRS2tw?=
 =?utf-8?B?SXlrMVJndlY1L0dqS1h6Z2w1U245ellJVk1VZ2NxcHl0MGt3NHR2dmNJdkJU?=
 =?utf-8?B?V01zbUloNzJuNk9GTHBOK3NlMlE1clBGNlNhbVVvNGVkNzM4RHZPNUZObGNu?=
 =?utf-8?B?am9xa3pWZ2pVOFpxckhya3VNczcrbXowajdncHBLQ01xQXFnMkE3dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7860ca-29c6-49e1-56d4-08dedb5c533e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:31.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hif3FR7Fuv3/wVw1Cz7GBjTSP6WHnyPC1um63O68XdI3+vbgt7uFomPMntzy3RHUF3AxKtLuzONUf0SI6Z9Utw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9605-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD404710CAF

Implement a `CoherentView` type which is a view of `Coherent`. To be able
to give out DMA handles, the view type contains both CPU and DMA pointers,
and the projection method projects both at once.

Delegate most of the `Io` implementation to `SysMemBackend`. Provide a
method to erase the DMA handle and give out a `SysMem` view, if the user
does not need the `dma_handle`.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 200def84fb69..1535bc6eec64 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -14,14 +14,21 @@
     },
     error::to_result,
     fs::file,
+    io::{
+        IoBackend,
+        IoBase,
+        IoCapable,
+        SysMem,
+        SysMemBackend, //
+    },
     prelude::*,
     ptr::KnownSize,
     sync::aref::ARef,
     transmute::{
         AsBytes,
         FromBytes, //
-    }, //
-    uaccess::UserSliceWriter,
+    },
+    uaccess::UserSliceWriter, //
 };
 use core::{
     ops::{
@@ -1133,6 +1140,133 @@ unsafe impl Send for CoherentHandle {}
 // plain `Copy` values.
 unsafe impl Sync for CoherentHandle {}
 
+/// View type for `Coherent`.
+///
+/// This is same as [`SysMem`] but with additional information that allows handing out a DMA handle.
+pub struct CoherentView<'a, T: ?Sized> {
+    cpu_addr: SysMem<'a, T>,
+    dma_handle: DmaAddress,
+}
+
+impl<T: ?Sized> Copy for CoherentView<'_, T> {}
+impl<T: ?Sized> Clone for CoherentView<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<'a, T: ?Sized> CoherentView<'a, T> {
+    /// Erase the DMA handle information and obtain a [`SysMem`] view of the same memory region.
+    #[inline]
+    pub fn as_sys_mem(self) -> SysMem<'a, T> {
+        self.cpu_addr
+    }
+
+    /// Returns a DMA handle which may be given to the device as the DMA address base of the region.
+    #[inline]
+    pub fn dma_handle(self) -> DmaAddress {
+        self.dma_handle
+    }
+
+    /// Returns a reference to the data in the region.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that the device does not read/write to/from memory while the returned
+    ///   reference is live.
+    /// * Callers must ensure that this call does not race with a write (including call to `as_mut`)
+    ///   to the same region while the returned reference is live.
+    #[inline]
+    pub unsafe fn as_ref(self) -> &'a T {
+        // SAFETY: pointer is aligned and valid per type invariant. Aliasing rule is satisfied per
+        // safety requirement.
+        unsafe { &*self.cpu_addr.as_ptr() }
+    }
+
+    /// Returns a mutable reference to the data in the region.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that the device does not read/write to/from memory while the returned
+    ///   reference is live.
+    /// * Callers must ensure that this call does not race with a read (including call to `as_ref`)
+    ///   or write (including call to `as_mut`) to the same region while the returned reference is
+    ///   live.
+    #[inline]
+    pub unsafe fn as_mut(self) -> &'a mut T {
+        // SAFETY: pointer is aligned and valid per type invariant. Aliasing rule is satisfied per
+        // safety requirement.
+        unsafe { &mut *self.cpu_addr.as_ptr() }
+    }
+}
+
+/// `IoBackend` implementation for `Coherent`.
+pub struct CoherentIoBackend;
+
+impl IoBackend for CoherentIoBackend {
+    type View<'a, T: ?Sized + KnownSize> = CoherentView<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        SysMemBackend::as_ptr(view.cpu_addr)
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        let offset = ptr.addr() - view.cpu_addr.as_ptr().addr();
+        // CAST: The offset DMA address can never overflow.
+        let dma_handle = view.dma_handle + offset as DmaAddress;
+        CoherentView {
+            dma_handle,
+            // SAFETY: Per safety requirement.
+            cpu_addr: unsafe { SysMemBackend::project_view(view.cpu_addr, ptr) },
+        }
+    }
+}
+
+impl<T> IoCapable<T> for CoherentIoBackend
+where
+    SysMemBackend: IoCapable<T>,
+{
+    #[inline]
+    fn io_read<'a>(view: Self::View<'a, T>) -> T {
+        SysMemBackend::io_read(view.cpu_addr)
+    }
+
+    #[inline]
+    fn io_write<'a>(view: Self::View<'a, T>, value: T) {
+        SysMemBackend::io_write(view.cpu_addr, value)
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for CoherentView<'a, T> {
+    type Backend = CoherentIoBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> CoherentView<'a, Self::Target> {
+        self
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for &'a Coherent<T> {
+    type Backend = CoherentIoBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> CoherentView<'a, Self::Target> {
+        CoherentView {
+            // SAFETY: `cpu_addr` is valid and aligned kernel accessible memory.
+            cpu_addr: unsafe { SysMem::new(self.cpu_addr.as_ptr()) },
+            dma_handle: self.dma_handle,
+        }
+    }
+}
+
 /// Reads a field of an item from an allocated region of structs.
 ///
 /// The syntax is of the form `kernel::dma_read!(dma, proj)` where `dma` is an expression evaluating

-- 
2.54.0


