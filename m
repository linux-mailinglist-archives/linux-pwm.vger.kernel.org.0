Return-Path: <linux-pwm+bounces-9471-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rPtiAuZpQmqb6gkAu9opvQ
	(envelope-from <linux-pwm+bounces-9471-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:49:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B66466DA879
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:49:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=ykDAACgM;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9471-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9471-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BDA7315FF7C
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9086940B39F;
	Mon, 29 Jun 2026 12:39:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020101.outbound.protection.outlook.com [52.101.196.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0438409DF0;
	Mon, 29 Jun 2026 12:39:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736799; cv=fail; b=mgX1ocgxfAHlxs99kCAZBMIzrNaS8UBIJlDSOsZ/e79CSNCR2qJsCmz2gid20ROK3iU79fHmSq3duWTqLHcz1XKxYr4/gnwamDsFTPGJatdPYtp21Z3ixW0fl9+6hr4heaXk6szK7fO+IciWqQWwzYyggPiz/8RaQKjZH4vF3GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736799; c=relaxed/simple;
	bh=LjeMQ5Etr8IH9xy5/xESBemol5R4J/N4asY9n3QTZpY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Djmu28HXTdrQLkUgc+Q9gPSOSZRygWLsGu6d5NJDF/7jAtW1/WJkcNdJxnpxwfBbYP5c9Itqe+ht0UKL62QNg3sRQW9FmrpQk/VDZ1PJi+bQ2rli+0Q4ItFBC5ZgO/2BAonA3KkpK1UgzE8KhT7/2ORbGvEagP77gqzUcKZJV3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ykDAACgM; arc=fail smtp.client-ip=52.101.196.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgnriFV+VfWGbdBNap6C/YL7ngh7ofCNX1ItIa5XLcn6311jYNXfalNPekSm+7t9ggZGcR3LM3lhyEXo2FsNu6B06O2KDbR4cttvcbtwBBDaZntmvu448/4ZE1q9qW4b5b6+rGNp7zwEbB2PJdOaAPZTpohMIVZU8c3gPKQuiHbF0iNajIgD3C1q+X7sTLP5mDzDhtNgaxnsBz/bXE4ViRDAXHZme/QZVJRjZpYu6Cahnmn1cjKpzL/SbVU1mQbSezw33q9KvfuTCUv8c+CE59gJ4wO6FRrs590rS9hzkrej2kNFJCQGIF3qX+3VhmvymsiCCVo4HmYcwh3HdfS7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+MC8Elc9pYJmd3bHEzDkHn9/FCLc5NotGB4M6+JW/8=;
 b=wi5BWjRJs3GB1kaHET7YD67k3xTFmjv9RKnINg+/MFuEAEgyLJ2M2itodATCIIxKpOn9zreuOmwBeFij1swNhDBBCofo+Zwkb1fiblKJTQM5VOqZe/1+Po2t2vL4UuDFcWxjtKdxIcWNp8myZW6gyBLGx5zXmAHOWTQKw7AcgFeuayjbsVSAhJlwIM3rWh6N3209TsSorAryI0G5jc2O5aqWK2CJ1BX3P+tGJ/4qw61T1kXshLzW2YDkCD7O2r30ysA1bup2eUui+uKyH4NKZ20pZ2pLCZkIYdWQ9smtHssWclnMnZmrBg6NftOtVVIeguJ5cHzaJt3YDgApgSop/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+MC8Elc9pYJmd3bHEzDkHn9/FCLc5NotGB4M6+JW/8=;
 b=ykDAACgMLP6s6gz5ucFntN22eqRwZSoJUDQ2eA8RQfx75KQh3VWbiuQjdP1sY1Pt1KhAx/TXtDuuzfQFwA+MLtbpn0hE545smJX/y5QljlEhMNukzwO3JR/IlNdv+hmirl97v2i9XVpQZPAH2z1l2jGoEme4m+JQnJqDHwGu/R8=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2670.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Mon, 29 Jun
 2026 12:39:47 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:39:47 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 29 Jun 2026 13:39:44 +0100
Subject: [PATCH v2 10/11] rust: driver: remove duplicate ID table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-id_info-v2-10-56fccbe9c5ef@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782736778; l=5932;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=LjeMQ5Etr8IH9xy5/xESBemol5R4J/N4asY9n3QTZpY=;
 b=5ohJLi7apqyB28ioDIkLlI9t8A1lOHY6Vqr/2TGqbFRGzw7CXGWex5BXdvf7bHW555KsN/+pV
 B4zqfeUSNa/BdOuGH6yA3sSBs+nC6OI+3QCf5arQpU2KJ4FyR4PYSmm
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
X-MS-Office365-Filtering-Correlation-Id: df93827c-2f55-43da-7c0c-08ded5db8108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10070799003|22082099003|18002099003|921020|6133799003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	SEm6SiK6PNF/B5zgPqFjXE0vJ7v/8iE1GY4y4HzwoQS1/kaYs9PvcqHtN6DuzNwKVjmqhT/vQiHua3tYr+Zhdyi3LHrr2w1SDR4n56gQO8FQ4RooT9PIQ1vBXkPt5phVv24gMXbafcVolnV31++uckWuHDBww1oN7+u/F39b7LGBMzAtKkrd+iBb2Sfc3aEXPsPsIM3s2KnmF9faTGqDSA+N7FlZeEBoOUMkaVnP6vxGvweUqqvY46bBdZU8v9u3xdEXM3cAwq895AIUvZMnAVK08yMkcLoBCkVwB4s/m6OWhhATY+yxb8VrGxWg9/d+8SlWyFnhwMUHYpaFAF1bg3Q6/mGe1F6yLu4cEUUxezrgzLXyTUz2wkDM+BDwIwwpVZVzEWk0LEe3qaCQYrvxq8yINMTuQghnEPQO4uPhYrjbMtkmAOTuKYy+hZxL3Xerxs/5Uciu8GGQP8pvfqEdeJXuZWHisWiGUDzq+1Au1xmyNKsZf7tnixJcfut1X1ipldBMazN0CC6XzqFezRx1Z3Lx4/A8pwPw1Fz7CWFlbTxPGofm/SFoEqk6a0bHQPzVMPV172uzyJ0ej10cZys1WbAe8dP5zJvubG+Y2K1yQBJqujKIrsNvuc4W6Kq9ndpZm9xbXWL74GBx/TFkHcnz1uO9EYYnQi960v+e2Ft69cku7m4zA+F0GgwMEPtON62YQzA08aO6gukC5S3Orrx5UQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10070799003)(22082099003)(18002099003)(921020)(6133799003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFcwVTdmRTJFbjkrUnp1dCtra0xwNHZPcENzY0ExT0Naek0wRHpFWTkzbll5?=
 =?utf-8?B?aVVlRy9KZ0dINVNzN0IwM0VxTXlxbks0UVJ2UkZNbkpFK1ZqL1IzL2VsckFv?=
 =?utf-8?B?REhzUHc4eGdNcW9kbjFKTjZSOHFPV1FEdVdjSDhGSTRIUG5UMkdIM2phcnJ4?=
 =?utf-8?B?aWpWd1IxVFhsUWFMTnlqN2JRR0NGSFI2RVROVEo2TEg1czFPTHQwRFM3V1FZ?=
 =?utf-8?B?dHJ6Mmp0U1NOeGlidW4zcXVnZndYaVF1OEFNUTRTMmVMQytaYU55QSt0K2I3?=
 =?utf-8?B?UE1TV3Vyc1ZWOU52K2JzMFNybmlXdTN0c2JxUVcwcXRXcWIwdXNxZmNDL20y?=
 =?utf-8?B?NWtrbmx2QXFFK3BUWUVsU2FvZVIvOWpQa0hpcFM1V2FkdjRKd2RLVEtjSGNP?=
 =?utf-8?B?R280U3FGWDZ6bXF5dWhnNDFEcE5Nb1Z3VVBmL1gzVHc1NXJYTWpwbXFOK0J2?=
 =?utf-8?B?aFVaL3ZhcDQrbWpQdXZid3VyL2ZjM29hWTI3WnU3T2pmT0hQZG9oZ1FINWNo?=
 =?utf-8?B?Z1RhN0Y1ZkMwQklJS0podGkwWUwwMkgzSnFCY1RiZEVib2FiNEV6TW5Kdm0w?=
 =?utf-8?B?NVIvOXpYWGVmYnFkMjVITzJxS2ZpQjB4eW41RjczRjlUNTUyWDdFN2dWTXNM?=
 =?utf-8?B?RDlXOTRHZ0MrZmtITmhUNEw4ZnA1VFA2WDhQa3U5Yjh0dEJkNGlkRXhQcEhW?=
 =?utf-8?B?UkEvNXFWcVM0ci80YWdvRDhHdWMzaUZnNmpucWJYOUNnck9lWGxvdms0RTJq?=
 =?utf-8?B?ZlFGT2xYWFFRTkg1V1FSQXZtSU5nTDJ1RDRUZkFvWGdjUTJScHZhQ1pFQ2RI?=
 =?utf-8?B?UGRIWVZqM090UmNNUk12T1VlQ1hEODhWbkkydTg0bHdmUDdTTE5TZk1RVlNP?=
 =?utf-8?B?Tm40WHFJZnk3U1YrTmZ5NFpkSitTS2N4ZlNpbjJTWkliMnF3VEFsbDZ4c1cr?=
 =?utf-8?B?czVVZTBmNHU0Vk42VFI2c0xFVnhIODFaZUU3L2J6TEZ5QXB3TnNwb2w3ZXlp?=
 =?utf-8?B?V0Q4M3BSTVk4ZDloRG05Z1FodXNDdCtMcHcrVnVVLzdSSzJNSmdqYUU0Tm4w?=
 =?utf-8?B?YWZRcmxFUWJ6RGRSZEZiR0FSN1dxd3dleEhYcE5HbmEyUWJJbWFtYU5id1hV?=
 =?utf-8?B?QnJaQUcxUkpPTzZKSzY2ZkpvRVNjZHEzTEV0clZMbFBmRTlDT0MxblkzaEhR?=
 =?utf-8?B?ZGRNeE5LejZQbm95YW5BakozSEp4UDhzMTJneW14MUlaTHRWNWZ0bkU4MDd4?=
 =?utf-8?B?MTAyMmMxcEsrNlNxcnM2ejR6c0xscWNGNjZod1RlampDY2ljMExzUm94ckI4?=
 =?utf-8?B?elc5bXo4YVUwS0ZnWWd3Zy9wUXlSNTl0MHpBN0RkbXJWOE02U3hDcXk0blBZ?=
 =?utf-8?B?NGJpM29RajJzL0pQa0NVWnY5bXhMU3Z6bTRoMjZjUVJrQ0ZtMzVYVjNXOWVy?=
 =?utf-8?B?Z3cxQ2Z5R0x2N3Z1bTB6M3JLNDcvak00VWdJRUZiNGFHVkNxd1hRZDhaQkFF?=
 =?utf-8?B?NTlhQ0djaDJ6L056L1paNDNDT1VBQzB2dkZCM1ZPem1oR1VndVpkS3ZqNmJ5?=
 =?utf-8?B?V0poaUh3WDRSSWxudEwyRWkxSjBDbHdheFBIUEJXSnlicUtBSndhQ0prRnlr?=
 =?utf-8?B?SXdnVm5VK0pNTkJ0akZrTUlGNmJXanhGTDhNWVpHKzhlRWh6ckwybXkyS3hN?=
 =?utf-8?B?WEZHM25hN2pCaEI2di81eTBTTGNDZkNlQ0hMVE9TUkpJZk0rNU8rSHBxR1JB?=
 =?utf-8?B?VE4rYUVmZDlwVjBJbnBZeG9CUFNYK1o5R1VtM2hEdkxmSFdtelJLb0hCcDNq?=
 =?utf-8?B?QVhIRnR1WXRid3hGcnpEL2ZTYW1BUE55ZlZFSmxYMWRNUVA0ZHpCUWVyRXRu?=
 =?utf-8?B?VTRTWXkybXR0WWowczRPUG9EVnpBMDB2Ymx0WGZyUDZrVE5EdHVGdWl2aWhU?=
 =?utf-8?B?NkpUdTVNSjVPNmI0QysrN0Z6K1NKa0QxaE9lbVdMYXVVOFdGaXorSWMwYU1a?=
 =?utf-8?B?bjBaSTAyVHBCb1NRYXZjclA3Y0J2VHdYZWVJc2xHMmkzQThiK2dRY1dUaEU5?=
 =?utf-8?B?dkQvbGpwN2lHLy9xS09kL01qYTdGc3R6M0RUN01xQjVRTkdOSloyd0FoSk9T?=
 =?utf-8?B?VWo4Q21DNnU3QWU3L3lncTk2b0RId1VUZ3pac1ppVUVaakJDcERVbEJrVjVz?=
 =?utf-8?B?THN2MnNaK1JwcHlhakVqZ0JoS2ExcFplNTNVYVQ0L2t4TTVDZm1SSzNTQ0xB?=
 =?utf-8?B?N3JEV3BoSVNHMUcxWktkVmZaMmorV2tXMVE2YWdVV0dvNjYrbDlEZjNGTzdt?=
 =?utf-8?B?MGRWVkhRaytYeStkYXEyekxjM00yVVhJRk5RMUVBNWJKc01xYjVCQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: df93827c-2f55-43da-7c0c-08ded5db8108
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:39:47.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5k2iPLhAKKoTnMZG5XLJq4hSOHyDfqMvNhpDwZyTfbitfv2sZSk9cvCdyDzKdgk+9KxPYoJoTKbD6Zrixw4qQ==
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
	TAGGED_FROM(0.00)[bounces-9471-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B66466DA879

Previously, `IdArray` contains both device ID table and info table so we
keep a separate copy for MODULE_DEVICE_TABLE for hotplug (which needs to be
just the device ID table). With the info being changed to be carried via
pointers, `IdArray` is now layout compatible with raw ID table and hence
there is no longer a need to keep the distinction.

Deduplicate the code, and remove the redundant copy for hotplug purpose by
just giving the `IdArray` instance a proper symbol name.

While at it, also update the macro to use `::core::line!()` instead of just
`line!()`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/device_id.rs | 76 +++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 49 deletions(-)

diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 50d82bfca9b8..c81fca5b4986 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -86,28 +86,23 @@ unsafe fn info_unchecked_opt<U>(&self) -> Option<&'static U> {
     }
 }
 
-/// A zero-terminated device id array.
+/// A zero-terminated device id array, followed by context data.
 #[repr(C)]
-pub struct RawIdArray<T: RawDeviceId, const N: usize> {
+pub struct IdArray<T: RawDeviceId, U: 'static, const N: usize> {
     // This is `MaybeUninit<T::RawType>` so any bytes inside it can carry provenance in CTFE.
     // If this were `T::RawType`, integer fields would not be able to contain pointers.
     ids: [MaybeUninit<T::RawType>; N],
     sentinel: MaybeUninit<T::RawType>,
+    phantom: PhantomData<&'static U>,
 }
 
-impl<T: RawDeviceId, const N: usize> RawIdArray<T, N> {
-    #[doc(hidden)]
-    pub const fn size(&self) -> usize {
-        core::mem::size_of::<Self>()
-    }
-}
+// SAFETY: device ID is plain data plus a `&'static U` and can thus be sent between threads safely
+// if `&U` can.
+unsafe impl<T: RawDeviceId, U: Sync + 'static, const N: usize> Send for IdArray<T, U, N> {}
 
-/// A zero-terminated device id array, followed by context data.
-#[repr(C)]
-pub struct IdArray<T: RawDeviceId, U: 'static, const N: usize> {
-    raw_ids: RawIdArray<T, N>,
-    phantom: PhantomData<&'static U>,
-}
+// SAFETY: device ID is plain data plus a `&'static U` and can thus be shared between threads safely
+// if `&U` can.
+unsafe impl<T: RawDeviceId, U: Sync + 'static, const N: usize> Sync for IdArray<T, U, N> {}
 
 impl<T: RawDeviceId + RawDeviceIdIndex, U: 'static, const N: usize> IdArray<T, U, N> {
     /// Creates a new instance of the array.
@@ -137,22 +132,13 @@ impl<T: RawDeviceId + RawDeviceIdIndex, U: 'static, const N: usize> IdArray<T, U
         core::mem::forget(ids);
 
         Self {
-            raw_ids: RawIdArray {
-                ids: raw_ids,
-                sentinel: MaybeUninit::zeroed(),
-            },
+            ids: raw_ids,
+            sentinel: MaybeUninit::zeroed(),
             phantom: PhantomData,
         }
     }
 }
 
-impl<T: RawDeviceId, U: 'static, const N: usize> IdArray<T, U, N> {
-    /// Reference to the contained [`RawIdArray`].
-    pub const fn raw_ids(&self) -> &RawIdArray<T, N> {
-        &self.raw_ids
-    }
-}
-
 impl<T: RawDeviceId, const N: usize> IdArray<T, (), N> {
     /// Creates a new instance of the array without writing index values.
     ///
@@ -164,10 +150,8 @@ impl<T: RawDeviceId, const N: usize> IdArray<T, (), N> {
         core::mem::forget(ids);
 
         Self {
-            raw_ids: RawIdArray {
-                ids: raw_ids,
-                sentinel: MaybeUninit::zeroed(),
-            },
+            ids: raw_ids,
+            sentinel: MaybeUninit::zeroed(),
             phantom: PhantomData,
         }
     }
@@ -200,13 +184,17 @@ macro_rules! module_device_table {
         $table_name: ident, $id_info_type: ty,
         [$(($id: expr, $info:expr $(,)?)),* $(,)?]
     ) => {
-        const $table_name: $crate::device_id::IdArray<
+        #[export_name =
+            concat!("__mod_device_table__", ::core::line!(),
+                    "__kmod_", module_path!(),
+                    "__", $table_type,
+                    "__", stringify!($table_name))
+        ]
+        static $table_name: $crate::device_id::IdArray<
             $device_id_ty,
             $id_info_type,
             { <[$device_id_ty]>::len(&[$($id,)*]) },
         > = $crate::device_id::IdArray::new([$(($id, &$info),)*]);
-
-        $crate::module_device_table!($table_type, $table_name);
     };
 
     // Case for no ID info.
@@ -215,26 +203,16 @@ macro_rules! module_device_table {
         $table_name: ident, @none,
         [$($id: expr),* $(,)?]
     ) => {
-        const $table_name: $crate::device_id::IdArray<
+        #[export_name =
+            concat!("__mod_device_table__", ::core::line!(),
+                    "__kmod_", module_path!(),
+                    "__", $table_type,
+                    "__", stringify!($table_name))
+        ]
+        static $table_name: $crate::device_id::IdArray<
             $device_id_ty,
             (),
             { <[$device_id_ty]>::len(&[$($id,)*]) },
         > = $crate::device_id::IdArray::new_without_index([$($id),*]);
-
-        $crate::module_device_table!($table_type, $table_name);
-    };
-
-    ($table_type: literal, $table_name:ident) => {
-        const _: () = {
-            #[rustfmt::skip]
-            #[export_name =
-                concat!("__mod_device_table__", line!(),
-                        "__kmod_", module_path!(),
-                        "__", $table_type,
-                        "__", stringify!($table_name))
-            ]
-            static MOD_DEVICE_TABLE: [::core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
-                unsafe { ::core::mem::transmute_copy($table_name.raw_ids()) };
-        };
     };
 }

-- 
2.54.0


