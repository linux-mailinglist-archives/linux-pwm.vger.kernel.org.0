Return-Path: <linux-pwm+bounces-9419-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KBW8NAeSPmrWIAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9419-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:51:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F31D6CE255
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:51:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b="fXZvzix/";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9419-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9419-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EA403000898
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE193FFAA4;
	Fri, 26 Jun 2026 14:45:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022142.outbound.protection.outlook.com [52.101.101.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661383FD941;
	Fri, 26 Jun 2026 14:45:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485155; cv=fail; b=Gg9xSReSRrzru6meQnLZnqgjyt2Xs2zf+58gOJHo7aRPT7NHoeyQdCwO0okFe1axQVP3MED1zO2v9akhT/GzzRHLK7Sv1Il4Ylc7xGwFjESNIeqtcIw0hC2lue2MdzzMmo68pKHiiZUkpAXPOW+Zf9C5GlXGfO8GZa5N7MY96T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485155; c=relaxed/simple;
	bh=X3jtfWZLQGJZh2g9tCEqgAxb4lmWw01CX+lOBYGY4qM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pdZ0mCKlXvBkyMkrq0yef4NmkcR7kSQTuwDrVP3fzsR43ME3KAdPxzLhA+oNorYkd26R2j+khhbxz41Ac97b+TBgv0EbQMpLZqKlSN4/Ygh+aMe1rQ0lF/pxfVnh0fo5NT5bSk6RiCXJDN+1rZby0YZD489rkcou3en87ducJ9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fXZvzix/; arc=fail smtp.client-ip=52.101.101.142
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3iOwG8cpRaQiMV5iUXg3VO6rFllgUV+quh/FQhCEGVhsJcxzUuvWcaBzFIzF2/NUJW8S8SzpP1jVO9dvPTQU7+O60m/QLAZc0Le5Eo5vq7xu8+w4bbvt/cW0ylVbHjIKqPwS/ZReibZP/GpJuENlONg0WYu6p/y1wzjmIMH4h4FMqj1mnz+D0BsdR88lv9cFI+xONPbJ0RAhJp5jmFR5+NsPjHgwnP31tLAVlHSWvOIxEmUZdlJhPR8TF+EPpZD/cTebLX/q5vSoScjjyDDH2ue2zVcUQBzVnKYSNUGj2MAuHHxj9Ne520FCwzXn7JMWL3IiJAv31hmCORMz5l9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvP3V1N2DDGsrmatTSvhoZJuRmdEBJem5u3DqqZsDrA=;
 b=TI0aWEjWVl578lKW01MLghCkMwqy0gQPLhbcSLtmg14rGPupcfkl4EOjrwbubktTn/Hrrmt7+jSh/cEqhTcjDQljRc7U/4TPlbXjGp4nZ8o7MPPSc0Ewgzc6/q1J1PS3/aWbZtWfsjEslqiFtXfJ9wsl788oEInKMHRfWZcjGH0aV9SPlPoBbckyWAEX8EN3MGUNcPVe+fq9rBuziV3V0ECYuf9MPlmY3SbMLIHBShicff5bdmm6EWA+GNWpO2WrIslnsoYAYlzB6QTVCVKxD6CpaHJE7uM7sMBoJw0GS7j7oPSJ85Pho/F7ditnZBKO6p48gPGbh+wUorCUYi9qRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvP3V1N2DDGsrmatTSvhoZJuRmdEBJem5u3DqqZsDrA=;
 b=fXZvzix/Okv2IiJzlf5/ZGcgX+qtNkEDiia3b/+ib43mne2NXF6JzifaoBZlqh7uVWr/l3S6bGBBZTeYiEQy97I72kODd+DSgJdXVhD9YUfWS7l3s4p8e1CM1Yk5ouKU0FlWuGD/uXbrkGOmufMzxO56XbZaId0wlAP67s/SYHw=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2694.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:25 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:25 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:21 +0100
Subject: [PATCH v5 17/20] gpu: nova-core: use I/O projection for cleaner
 encapsulation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-17-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=13099;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=X3jtfWZLQGJZh2g9tCEqgAxb4lmWw01CX+lOBYGY4qM=;
 b=nEda+0TNrXVHYD4+jP9t2x1QdiB6dUKSJm0jCMPF+3KFg9gBHGZ/rfqOj45erTR1rtNEhFequ
 wyapF50FytyCUt6URynTKLkyJwuXsKGnHnXVUALJhp/7exfaQzNWvo5
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
X-MS-Office365-Filtering-Correlation-Id: a2dad0e0-8eb5-495a-dcff-08ded3918f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|921020|3023799007|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	2qlNOjhLuY0Y4U7foSe+0YZRwHPBsoNh1LRs7jT2JAQdJhFJR5cWuBKGy+aXSx9KqlQbG1yoNDhibZGOhdOaAdX1b1Ml7YGF54eGSWg8MX237I97ZiwgZaaUw25sI0Km2sg/ckYLAJtT8G+XfMpkg89cAE7gJoW5r+YMKPl5yJgmjq+hOpRDLcF7KBa6Ynyc8DbEDle7aTbzNaUN5YZJsoIn/b5h3BP+rJHwdE8R7QPlTBJ/DnSutDOXVj/ws9sexZeqwhNeW9yto0RooN7nHl3ASQxmRXfWmFvHFskhP0ssgfpDO92WZigLLpzspjb+xlvVqUGESBInzmdGzX+w92Wl/Kcr1G4nYOzyIL81kEVGKPz+hIxbtMBagIvnasQVwEwzzql/faKTKdrp6kUmmpmQ+1Fbcoo91vZTOlmSWpa3LSPDF3bkHzo4cyRcNM28rU1Ee7pvyBFyHLDc3RAd4L0h7nm+dJfUuMCnXEBYn7ivBwqLxxDQUh0CbxNCDoTad9PTpJzDV70NbfqPK1qir4NFgaMC/ob6K02L+2xyyOy7q2bgev9CCthdHM2GiECTMc/74Jbgvr5/8CkwFBDzpkObw9oEUAxB+DJyGH1W8g/TixID6k6DNDMq/1qNXTJSyM/YA75JZOlGxZ472UznGnCCflKsvFI5sDae/AHRkdhURfO0q3AIyxGtoVoFye166kXdlUSXqIhImAufFY7ObA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(921020)(3023799007)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTFiZWQ4RjVjOVJka0pkOThzQTBBVGFIeUpXdnBQa1B3TzZrblF1V1J1MlRP?=
 =?utf-8?B?RGtSU290aDlLSlBBbXJBSE96eWE0OUxaMk9DM1JHU2w2UjIxemQxNWU2eXJY?=
 =?utf-8?B?d0hXODRtcjM1QTgvLzRDNEo2QlFkOE1PUjRkbFNRaHZkMFdHSmxnK0xySkto?=
 =?utf-8?B?dHMrRHNTNklTSE9Vd1hiVzR2MlJ6eTJRTVZnQVA3NDNtclNMRDdyVjRLMVlG?=
 =?utf-8?B?Ri91eVdNWjdWYkN1dyt4RHdUY1Q2VzdlN3Mra2R1SWRxc1Q3a1dsV0NDZDlS?=
 =?utf-8?B?TkFZNFJ1bVFTV1JlZnpzOUI3eDZrSDEwUGxpVjg5eGlRd2R2bjBwakRmcVZC?=
 =?utf-8?B?K2wzcVBOWjJ1N3BiekRBS3l1YmZXN0cyVEZMUE85dHorN1R3Wk9OeDFua0Vz?=
 =?utf-8?B?VkxNWCs2Z29HdndNUmZ3cEJmcEp0d0RxSTZZd1FjU3hQbVA3UFBKK1cvYzAx?=
 =?utf-8?B?ZENDTFB5ZnlEcEpMYXVkV2pnelo4OHJEY3IrbndVVldDRG45Sk43WlZrZVRj?=
 =?utf-8?B?SGtFSmFLOEl1TWdnM3RwZjhGSlVTSlo4OFNnWkd5Y1A0RHBzYmltWW9YQVE1?=
 =?utf-8?B?b0RTS09jOXJOTDdnQUt3NENhaEx0dTRJaC9WTjhTeWhHcWdQdjNPdWx6eUwx?=
 =?utf-8?B?Q012L1dFbDF6TGtkNkZoSFN1Mm1Uci94Y3grRkwwUm0wemZMTXZrbkFFa3Ur?=
 =?utf-8?B?aWpBOVg5aHg4dVU5S0d6UjVINk5RdldZclhrZTl3Ny90enJYaFJEQllqblRu?=
 =?utf-8?B?dGUvb3EyR1BUK1RWeHk4V1Zha2NCWVp3dkRMdjR0Z2VjS0JsSHR1OTY2TmFz?=
 =?utf-8?B?OUE1c09OYlBQN3J2SmlnaWdnRGRyWnhGcHl6YTY4Rjg3NnJWY0xJSm1FWlVZ?=
 =?utf-8?B?clpWRG8rWnRYdUdzajJTdFJvS3ZvaWNTSUtJdjJZR0h5Y2VFTmw2MUluc1hM?=
 =?utf-8?B?cHZINi84UmJ3dDVyYmczcXdRQlZ1Z3RjaDBhQXZXZHFINzQvZkJFcWUvVUk5?=
 =?utf-8?B?K2Vwb0ZNQk9mbDBtelAzcysrUHgzV2RnaUN0c2JtVG9hQ3UwSFA5VXM4c2tj?=
 =?utf-8?B?K0g2ZXUwUnZWSXIxeVQ5cGkzd0w1c2ovTE1IaWY3dGNvc24yU2JWbU4vaXEw?=
 =?utf-8?B?Uk1yYmo5anFWa3ByZkNvQjJlUWRDdERxMFNCV0wyVjdRaUFuM3VQYjdlSFEv?=
 =?utf-8?B?cHBkWDVpcStWZXBYMUlPK00rWmxwelVqOHExeXBrQ3piRzZNUkxFNjhGOCtp?=
 =?utf-8?B?SnlvUlBuclNUSjZIYVJtVm1JdTRwUzdKdXpocjR4M3N0SUNFaDdFK0h1bmY4?=
 =?utf-8?B?Mm8yc1dZcnV1VVBrYWpwK3RxeHNOMHRBVUp5ZjNrNEpZcFRCSnBXRjh3UWd1?=
 =?utf-8?B?RUxDTDl5Z2JVWmF1b0h4SEMrdE96R0NabTNtSWJYSzM5S3pzZU5CbWZYcGUz?=
 =?utf-8?B?NEZUbWJDUFFMZlkzZGxxK0haNFVkZWJ6L3JRdlBrUC9GLzJ3Zjl6VnlsSkxP?=
 =?utf-8?B?Mkswc3JvcHliZXlGTVRFeVJqU3dxNGFrc1Vsb3BQL0NFZ0ZGRXJyZExvM1Z0?=
 =?utf-8?B?bEt4MCtNMXRqVmtMVm5RTUxiaC9IbVRtZDNBTWFyZHQ0bWpVWW5EcjNmV2Fq?=
 =?utf-8?B?R2x0TkJUUU9EWkRYblNWbEdxWGt0Q2VmcnkvdzFVV0hKdmJhanNsRjlKV29i?=
 =?utf-8?B?SDdZZXRiYVJmT244UXhmc2xLL0kyN0c5dVRoc2RqZU9vbFpDbUl2SGpCeVRQ?=
 =?utf-8?B?ZFpZQ3o1M05XdmxEaWFScTZlb0N6Nm82TmxSenJGZXFjME1CTlBJb2tXelk5?=
 =?utf-8?B?c3g3ZjZWRUlGazZkalliL2xEc0xRQVQ4cjJwTmR2cXYvRW4zMi8zZnRWQXpW?=
 =?utf-8?B?T291ZFZEMm5BWHZhaWJ2UkFrcmRQTHUwRnNtV3J5bm9IYUl6dDluall6VVJv?=
 =?utf-8?B?Y3J6ZU96aFYzY01xM3V2V0dGU3ZTRjUwTTRuMzJCWXRENU5haGdLNEI4TG9n?=
 =?utf-8?B?Um1rbEZQRkU5czZvSTVzZWFCRlZzUlZmZzNIaENvVGFZNmVSUjZ2Tkx0bktY?=
 =?utf-8?B?d0EzMXJqKzdyR3VqVUpydXJJUUJ4UHBEU0ZtaHA1UXFrL1JWL1JOMnFkdXVU?=
 =?utf-8?B?UDB6RXJVb28rTjBUS3lURVIrZ3JOcU9HUncvOU5xanlaR0t6R01aTExDb0hK?=
 =?utf-8?B?MlJtTDFZaUdiV0prOG9vT0xaVGd0VFRYTUdKcVNpMjA3RkYvSDlSdENCTlRn?=
 =?utf-8?B?UW1BbTE0WFVDbnJwM1JRYS9SaDVjNkx4NGt0Nmxicm5SVzRzVTJVaW9MRUZY?=
 =?utf-8?B?eGMyU0l3WDJhLy9WeVcrOW02MHFiVUFqbkRwSFpvdGJKNUcxL0VKdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dad0e0-8eb5-495a-dcff-08ded3918f05
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:25.7154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaTPfndXqM9SBXxVfJijJKAVx+2CuHobTPK28g+mLVfOE6nkPBff13LUUsI7xD5m1zvDhCXT64lPrOScm5VlgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2694
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
	TAGGED_FROM(0.00)[bounces-9419-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F31D6CE255

Use `io_project!` for PTE array and message queues to restore the proper
encapsulation.

The remaining `dma_read!` and `dma_write!` is now only acting on
primitives; thus replace by `io_read!` and `io_write!`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp.rs      | 53 ++++++++++++-------------
 drivers/gpu/nova-core/gsp/cmdq.rs | 66 +++++++++++++++++--------------
 drivers/gpu/nova-core/gsp/fw.rs   | 82 +++++++++++++--------------------------
 3 files changed, 90 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 69175ca3315c..cfa7553cd820 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -9,14 +9,16 @@
     dma::{
         Coherent,
         CoherentBox,
+        CoherentView,
         DmaAddress, //
     },
+    io::{
+        io_project,
+        io_write,
+        Io, //
+    },
     pci,
-    prelude::*,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    }, //
+    prelude::*, //
 };
 
 pub(crate) mod cmdq;
@@ -48,21 +50,21 @@
 
 /// Array of page table entries, as understood by the GSP bootloader.
 #[repr(C)]
+#[derive(FromBytes, IntoBytes)]
 struct PteArray<const NUM_ENTRIES: usize>([u64; NUM_ENTRIES]);
 
-/// SAFETY: arrays of `u64` implement `FromBytes` and we are but a wrapper around one.
-unsafe impl<const NUM_ENTRIES: usize> FromBytes for PteArray<NUM_ENTRIES> {}
-
-/// SAFETY: arrays of `u64` implement `AsBytes` and we are but a wrapper around one.
-unsafe impl<const NUM_ENTRIES: usize> AsBytes for PteArray<NUM_ENTRIES> {}
-
 impl<const NUM_PAGES: usize> PteArray<NUM_PAGES> {
-    /// Returns the page table entry for `index`, for a mapping starting at `start`.
-    // TODO: Replace with `IoView` projection once available.
-    fn entry(start: DmaAddress, index: usize) -> Result<u64> {
-        start
-            .checked_add(num::usize_as_u64(index) << GSP_PAGE_SHIFT)
-            .ok_or(EOVERFLOW)
+    /// Initialize a new page table array mapping `NUM_PAGES` GSP pages starting at address `start`.
+    fn init(view: CoherentView<'_, Self>, start: DmaAddress) -> Result<()> {
+        for i in 0..NUM_PAGES {
+            io_write!(view, .0[build: i],
+                start
+                    .checked_add(num::usize_as_u64(i) << GSP_PAGE_SHIFT)
+                    .ok_or(EOVERFLOW)?
+            );
+        }
+
+        Ok(())
     }
 }
 
@@ -89,17 +91,12 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
 
         let start_addr = obj.0.dma_handle();
 
-        // SAFETY: `obj` has just been created and we are its sole user.
-        let pte_region = unsafe {
-            &mut obj.0.as_mut()[size_of::<u64>()..][..RM_LOG_BUFFER_NUM_PAGES * size_of::<u64>()]
-        };
-
-        // Write values one by one to avoid an on-stack instance of `PteArray`.
-        for (i, chunk) in pte_region.chunks_exact_mut(size_of::<u64>()).enumerate() {
-            let pte_value = PteArray::<0>::entry(start_addr, i)?;
-
-            chunk.copy_from_slice(&pte_value.to_ne_bytes());
-        }
+        let pte_view = io_project!(
+            obj.0,
+            [build: size_of::<u64>()..][build: ..RM_LOG_BUFFER_NUM_PAGES * size_of::<u64>()]
+        )
+        .try_cast::<PteArray<RM_LOG_BUFFER_NUM_PAGES>>()?;
+        PteArray::init(pte_view, start_addr)?;
 
         Ok(obj)
     }
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 070de0731e95..c34b48961496 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -2,16 +2,23 @@
 
 mod continuation;
 
-use core::mem;
+use core::{
+    mem,
+    sync::atomic::{
+        fence,
+        Ordering, //
+    },
+};
 
 use kernel::{
     device,
     dma::{
         Coherent,
+        CoherentBox,
         DmaAddress, //
     },
-    dma_write,
     io::{
+        io_project,
         poll::read_poll_timeout,
         Io, //
     },
@@ -171,20 +178,18 @@ struct MsgqData {
 #[repr(C)]
 // There is no struct defined for this in the open-gpu-kernel-source headers.
 // Instead it is defined by code in `GspMsgQueuesInit()`.
-// TODO: Revert to private once `IoView` projections replace the `gsp_mem` module.
-pub(super) struct Msgq {
+struct Msgq {
     /// Header for sending messages, including the write pointer.
-    pub(super) tx: MsgqTxHeader,
+    tx: MsgqTxHeader,
     /// Header for receiving messages, including the read pointer.
-    pub(super) rx: MsgqRxHeader,
+    rx: MsgqRxHeader,
     /// The message queue proper.
     msgq: MsgqData,
 }
 
 /// Structure shared between the driver and the GSP and containing the command and message queues.
 #[repr(C)]
-// TODO: Revert to private once `IoView` projections replace the `gsp_mem` module.
-pub(super) struct GspMem {
+struct GspMem {
     /// Self-mapping page table entries.
     ptes: PteArray<{ Self::PTE_ARRAY_SIZE }>,
     /// CPU queue: the driver writes commands here, and the GSP reads them. It also contains the
@@ -192,13 +197,13 @@ pub(super) struct GspMem {
     /// index into the GSP queue.
     ///
     /// This member is read-only for the GSP.
-    pub(super) cpuq: Msgq,
+    cpuq: Msgq,
     /// GSP queue: the GSP writes messages here, and the driver reads them. It also contains the
     /// write and read pointers that the GSP updates. This means that the read pointer here is an
     /// index into the CPU queue.
     ///
     /// This member is read-only for the driver.
-    pub(super) gspq: Msgq,
+    gspq: Msgq,
 }
 
 impl GspMem {
@@ -232,20 +237,12 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         const MSGQ_SIZE: u32 = num::usize_into_u32::<{ size_of::<Msgq>() }>();
         const RX_HDR_OFF: u32 = num::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
 
-        let gsp_mem = Coherent::<GspMem>::zeroed(dev, GFP_KERNEL)?;
-
-        let start = gsp_mem.dma_handle();
-        // Write values one by one to avoid an on-stack instance of `PteArray`.
-        for i in 0..GspMem::PTE_ARRAY_SIZE {
-            dma_write!(gsp_mem, .ptes.0[build: i], PteArray::<0>::entry(start, i)?);
-        }
+        let mut gsp_mem = CoherentBox::<GspMem>::zeroed(dev, GFP_KERNEL)?;
+        gsp_mem.cpuq.tx = MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES);
+        gsp_mem.cpuq.rx = MsgqRxHeader::new();
 
-        dma_write!(
-            gsp_mem,
-            .cpuq.tx,
-            MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES)
-        );
-        dma_write!(gsp_mem, .cpuq.rx, MsgqRxHeader::new());
+        let gsp_mem: Coherent<_> = gsp_mem.into();
+        PteArray::init(io_project!(gsp_mem, .ptes), gsp_mem.dma_handle())?;
 
         Ok(Self(gsp_mem))
     }
@@ -406,7 +403,7 @@ fn allocate_command(&mut self, size: usize, timeout: Delta) -> Result<GspCommand
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn gsp_write_ptr(&self) -> u32 {
-        super::fw::gsp_mem::gsp_write_ptr(&self.0)
+        MsgqTxHeader::write_ptr(io_project!(self.0, .gspq.tx)) % MSGQ_NUM_PAGES
     }
 
     // Returns the index of the memory page the GSP will read the next command from.
@@ -415,7 +412,7 @@ fn gsp_write_ptr(&self) -> u32 {
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn gsp_read_ptr(&self) -> u32 {
-        super::fw::gsp_mem::gsp_read_ptr(&self.0)
+        MsgqRxHeader::read_ptr(io_project!(self.0, .gspq.rx)) % MSGQ_NUM_PAGES
     }
 
     // Returns the index of the memory page the CPU can read the next message from.
@@ -424,12 +421,18 @@ fn gsp_read_ptr(&self) -> u32 {
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn cpu_read_ptr(&self) -> u32 {
-        super::fw::gsp_mem::cpu_read_ptr(&self.0)
+        MsgqRxHeader::read_ptr(io_project!(self.0, .cpuq.rx)) % MSGQ_NUM_PAGES
     }
 
     // Informs the GSP that it can send `elem_count` new pages into the message queue.
     fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
-        super::fw::gsp_mem::advance_cpu_read_ptr(&self.0, elem_count)
+        let rx = io_project!(self.0, .cpuq.rx);
+        let rptr = MsgqRxHeader::read_ptr(rx).wrapping_add(elem_count) % MSGQ_NUM_PAGES;
+
+        // Ensure read pointer is properly ordered.
+        fence(Ordering::SeqCst);
+
+        MsgqRxHeader::set_read_ptr(rx, rptr)
     }
 
     // Returns the index of the memory page the CPU can write the next command to.
@@ -438,12 +441,17 @@ fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn cpu_write_ptr(&self) -> u32 {
-        super::fw::gsp_mem::cpu_write_ptr(&self.0)
+        MsgqTxHeader::write_ptr(io_project!(self.0, .cpuq.tx)) % MSGQ_NUM_PAGES
     }
 
     // Informs the GSP that it can process `elem_count` new pages from the command queue.
     fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
-        super::fw::gsp_mem::advance_cpu_write_ptr(&self.0, elem_count)
+        let tx = io_project!(self.0, .cpuq.tx);
+        let wptr = MsgqTxHeader::write_ptr(tx).wrapping_add(elem_count) % MSGQ_NUM_PAGES;
+        MsgqTxHeader::set_write_ptr(tx, wptr);
+
+        // Ensure all command data is visible before triggering the GSP read.
+        fence(Ordering::SeqCst);
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 4db0cfa4dc4d..b0e7de328eaf 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -10,7 +10,14 @@
 use core::ops::Range;
 
 use kernel::{
-    dma::Coherent,
+    dma::{
+        Coherent,
+        CoherentView, //
+    },
+    io::{
+        io_read,
+        io_write, //
+    },
     prelude::*,
     ptr::{
         Alignable,
@@ -44,59 +51,6 @@
     },
 };
 
-// TODO: Replace with `IoView` projections once available.
-pub(super) mod gsp_mem {
-    use core::sync::atomic::{
-        fence,
-        Ordering, //
-    };
-
-    use kernel::{
-        dma::Coherent,
-        dma_read,
-        dma_write, //
-    };
-
-    use crate::gsp::cmdq::{
-        GspMem,
-        MSGQ_NUM_PAGES, //
-    };
-
-    pub(in crate::gsp) fn gsp_write_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .gspq.tx.0.writePtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn gsp_read_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .gspq.rx.0.readPtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn cpu_read_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .cpuq.rx.0.readPtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &Coherent<GspMem>, count: u32) {
-        let rptr = cpu_read_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
-
-        // Ensure read pointer is properly ordered.
-        fence(Ordering::SeqCst);
-
-        dma_write!(qs, .cpuq.rx.0.readPtr, rptr);
-    }
-
-    pub(in crate::gsp) fn cpu_write_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .cpuq.tx.0.writePtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
-        let wptr = cpu_write_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
-
-        dma_write!(qs, .cpuq.tx.0.writePtr, wptr);
-
-        // Ensure all command data is visible before triggering the GSP read.
-        fence(Ordering::SeqCst);
-    }
-}
-
 /// Maximum size of a single GSP message queue element in bytes.
 pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =
     num::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
@@ -720,6 +674,16 @@ pub(crate) fn new(msgq_size: u32, rx_hdr_offset: u32, msg_count: u32) -> Self {
             entryOff: num::usize_into_u32::<GSP_PAGE_SIZE>(),
         })
     }
+
+    /// Returns the value of the write pointer for this queue.
+    pub(crate) fn write_ptr(this: CoherentView<'_, Self>) -> u32 {
+        io_read!(this, .0.writePtr)
+    }
+
+    /// Sets the value of the write pointer for this queue.
+    pub(crate) fn set_write_ptr(this: CoherentView<'_, Self>, val: u32) {
+        io_write!(this, .0.writePtr, val)
+    }
 }
 
 // SAFETY: Padding is explicit and does not contain uninitialized data.
@@ -735,6 +699,16 @@ impl MsgqRxHeader {
     pub(crate) fn new() -> Self {
         Self(Default::default())
     }
+
+    /// Returns the value of the read pointer for this queue.
+    pub(crate) fn read_ptr(this: CoherentView<'_, Self>) -> u32 {
+        io_read!(this, .0.readPtr)
+    }
+
+    /// Sets the value of the read pointer for this queue.
+    pub(crate) fn set_read_ptr(this: CoherentView<'_, Self>, val: u32) {
+        io_write!(this, .0.readPtr, val)
+    }
 }
 
 // SAFETY: Padding is explicit and does not contain uninitialized data.

-- 
2.54.0


