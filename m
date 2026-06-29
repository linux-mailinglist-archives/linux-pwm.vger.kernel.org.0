Return-Path: <linux-pwm+bounces-9462-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a4IYMtttQmrW6wkAu9opvQ
	(envelope-from <linux-pwm+bounces-9462-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:06:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EE56DABF7
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:06:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=DNDeV1aM;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9462-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9462-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AC74318EDBB
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578984028F2;
	Mon, 29 Jun 2026 12:39:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020122.outbound.protection.outlook.com [52.101.196.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095D367B92;
	Mon, 29 Jun 2026 12:39:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736787; cv=fail; b=AEraK5GbIzPyyHg2WUWG3VsrPD+Qq82SgLx+44wsKJq0XMTjZZv1RRWQ+V/QQ7dMyhbKC17PpfCe8SXh1a/k7uL69TWhFJfV2Dpyaz8DB5xMmq64GMdbCqdsolO91uX4TftEUZ3Rc39h4zBqRYbzH2wPQElaC/Baio0m3sl9HfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736787; c=relaxed/simple;
	bh=2dT/k0xdyDAv/VId4TJjbcCnwySmY8Qww6TVUXxc1A8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fH/FT46qsI/ZD1hjib1rcomksnUL/3NizjkctoWzfs3aejeHT3e3vlEi/9IwnnxfybjoUA1JhVkwb7Y+NmH0e3Ooc2bNRNmfQpNZqkv24fau6DMWtPmYgavU+TVJc76EEFEs5xRr9Zu92gyBhGsIph5vXg5VQPZUNDeoH+n6H5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=DNDeV1aM; arc=fail smtp.client-ip=52.101.196.122
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4Iq6wZKhRmPiEX4gJfgl524KARbPQM9cz12C2Aa24fZaUoGgGLZUAdqgzRy8GNwXzx4wP930W0n4iD8m2PZH0NOQkFnUrrR7N+Kfyy3OdL8A+rGFvCzLmqn8jQoba9SUWo20MgLaNZ0DjeQd6mC2+Z0bJ22QdBkuHLf2QMm1K/tDAZe2rhzqFwnQuIc0EzP6idmkq5YlWYdd4m3NIvxKOTQ6R7bcYZwJ6egGPhIW5DOcZSYZH/UhZ1WiRpb/GcUAMXuBY027zdoTkXVYUKGBRoeJzxoxMbgZWEhHUZdc8/b/7VULyLYm+1Lqz/tqpUzQXuJQ/7Dtrr2B8jBZritJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYhqXbWIhT3rqYCl5LJZ7ER8BbRtoBickjLIbda0PYs=;
 b=B/WslompsM5lnTYU++cDBwC8DDpUNWyUdH4qHb2+BpEpKt4ixVnT79rb3VWKfufqMUBCe3s/4b7W1QxH8Mw6uATu+u+5HqLH3HW8cFESSTbzRN+yyNcx4aZj4brYqCL/FavlQa7DqmA8CmO2TAwo+9xkBJ1tN181/N26GB7Li309xYWhARrm7m5cv6PMjV3QZbP38REZunJWoSJj6+UcAI6aihaw5yDkvXSp2661cKw3AXIR4NJ9C05Bq73Xyfor2PYkYldYNCtid7Gx87mE3Wp47unnOUs9Vj/+khGfFl43aRxwEm0bHDMmb9H9j4+wsUFv2dQ3NauhT3ZkHLtg8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYhqXbWIhT3rqYCl5LJZ7ER8BbRtoBickjLIbda0PYs=;
 b=DNDeV1aM+dqiCm/aK3KACu1R3t0pXVzTb2klFGVvHf5SC1m1QjLzXH4YjLkmwLGqD0Wexb6CUPEECtdw/aNLQamoAG9Rlv+eXAJkQeAigIiQv8aNuVdGJYYilOkF2Dbgm+egH7P+U1rjehJrSkedJOZn+FOAJ5RS0KeiTVaF7KM=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7414.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:39:41 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:39:41 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 29 Jun 2026 13:39:37 +0100
Subject: [PATCH v2 03/11] rust: pci: use `Option<&IdInfo>` for device ID
 info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-id_info-v2-3-56fccbe9c5ef@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782736778; l=4445;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=2dT/k0xdyDAv/VId4TJjbcCnwySmY8Qww6TVUXxc1A8=;
 b=3vblXVaQHQDIWS8Y6okOSztEaQudKzclVeuGq0eRTJ7RpQTQ8aQPFA6+3fjbfPltnIT83ZJiQ
 rlzX/Ygy64LBf7evIqSPPBb9UhRK3Walu8Thdp2+x/K2BOMDVqkTkKN
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
X-MS-Office365-Filtering-Correlation-Id: d5e5046b-1706-4af8-d292-08ded5db7dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|10070799003|6133799003|921020|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1zS6QrYRMSHOOhL9214ZXpTvEQa/itGTbCiizim8Jw0yYZ4VqzuEULVR39D6KOWBHP/vVIb1xXpNVUoaE9Mb8L4aNoNI/ps/cUusmyGQW4q3pu1r+dzCHilVbu37gsQqXg8YFcQ52qYifRm6CovFSUsU5gCPoO7vwUTWl31RGRWngL5ofVjRrRNrXf2ocIsLxkshQS9UQjgbcxNF0bCeptqyDXKDkvnXYcM5EyyaaOM9OQD57WUiW/Op9hQhhmRUeNeb2Vt7ctu+ycXGC9SDEwWnlZlwmvHq+iU8V0tZcg2kAyTejpKM6ex9zIJ09bwEdy0oXUECvPWm0e/pcPFfCNlwG9SKaVZNzBBsnKMM5Vkl00zTBTC88xd3sEGgRYm2E38hF6Duldnw51Y9N0u5hlu2/nFMAFjGdjuSd2d96lW9g76VP5sasA5774BRrJezOjgBOkNfKONPqpgV7eRN14nJDfNoXMCTvXXWo6vTV42lktSMhBWDK23VZKWo03i8pF4o4STdGyRx51kxF3s9FlZ2GkqBK6ChEu8Z2DJ4vxTLUMVv3ijjY1wCIVpvu6OuYsbTJLe8wT2V0I5zpEgzhONqfa/DmNj7p4Y9HkkwYm6ASVc0rgQIkt/IKJduMjfQEzT5nFSAyarKkchNqApBmU08mEY4eXcigx73WEdh9SzXWqCUj4h2jhrO6aTPJrm+vmtb1zYnG7kTLjerlJy/0g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(10070799003)(6133799003)(921020)(3023799007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWc2TysreHlRTmtwK1FCY0NIdFBOeWVjVENMTy91d2lhMnpFWm9vRmdXVVFz?=
 =?utf-8?B?aGI0Mk44YWpEdk5jNjNUNm9hWVdWYmllQ3ZnM3MydDVlK3RyQTY1Qk5hYUsz?=
 =?utf-8?B?eWJyY24rSUhIbTZnSXlPdlpBWXQ4aVErbHIzWlBZVFh3Z2FvU0NtRVBiNUFY?=
 =?utf-8?B?TDdTbVNOeXVXN1hjaTE0UjJ2RVR1TFpDb3d3dDJpQ0h2LytMV0ZxczlaUnBX?=
 =?utf-8?B?eERJZkdqOC9FVEN3eDBWVEFZdlloRmNvaE5JS3lOUUN3UzJWUi9aTXpmSFVD?=
 =?utf-8?B?d0xNOTRWSzQvRlV5UkRQUTl2emYwOHZVWnhUQ3lLNnVNaEtDNmQ3WUQybGJP?=
 =?utf-8?B?MjJPeGx1WGMrOTFyV3JpVlQ5TnVUN3M4WjF0eHNMZkxnRlhKa0pzRWQ3RmNm?=
 =?utf-8?B?TEpnTHIyUW5aVGFuVzdJYk1ka2RaanEyMzdWK0g3M3M3Y3N3dkRxeGR0YWNF?=
 =?utf-8?B?akczUnRicjVPWGRldnE3clM4Ni8zd3g2TG9QQThIcGp1MDg2ZjQ2YXJ4SXEr?=
 =?utf-8?B?dWkzTnFEZENNcnQzdTRzTUpOM21QazNTTlp0cXFyc2hoRUxTaXhYRXY2dXV5?=
 =?utf-8?B?NUJqR2lRalZjNDhzVmF4d0tacWR3NlJFL2hXUDlxMHd2blcvZ096UzA5d3lw?=
 =?utf-8?B?SXNJSE9CbHgwUEt0Ymg5bnhQL2JEK1dWdmxwOUNrMStwOTFLeVNzNUJEUi94?=
 =?utf-8?B?T1JnL2dJc3djTGZkeE5SbUUvYkZyNDRaSDIzZGd2VVhCMGdBWEFObUhWQVdW?=
 =?utf-8?B?dVRCZmdZOUswQ1RDY2pwWi81ZjN0Qy9mWGVlWmRYcEpVYlJ1NmEvQUwrRjR5?=
 =?utf-8?B?L3Npeis2MitKYndmZ25LYkhLYW5BNHY3bzlwUUYwcTZ0bWtYbm1IeVI3YVdJ?=
 =?utf-8?B?SFBBN1VFRGVPU1JRUDV2dWo3Z2NMZW54anhsbFV4TndqbUZENVA4Uk9wSVhn?=
 =?utf-8?B?eUQycE8veExMYUkvQWVwRW1OWWprL251NkJvbStnVG9NdVIrVWl1eXA4TVdL?=
 =?utf-8?B?MzY4enRhZno2RENlOHFJam1UU2V1QmFCZm5xbytwRHJES25oYU9rMVF3MlI5?=
 =?utf-8?B?cHhTaURWUlhzdVJUd2w1NDdRMTREWnJrbmhmc3ZJRVp5Q2JPa3VTMWs2QzZp?=
 =?utf-8?B?Qml3ZEFBU29hNWlwZmw5UG02QWhyMCt0N0dnMUdFTVZRZGlxR3dRKzBWbHRi?=
 =?utf-8?B?Mk03Uk1zakoybW0yZFRta2U4Skl2aTJ6THRqekFrM0VQNVY1NFBveitGN3dR?=
 =?utf-8?B?QnlYZzJGWWF6MzZ4QXBHRnhVYlJjMW12MDZIaS9rbGE3SUE5V2dnNkFJNGxJ?=
 =?utf-8?B?NGlFSEg2R1pwME1QcU14TDMyYytNbVpMV2lKUW1HdFZaaVVlUlplTXFmd0Vp?=
 =?utf-8?B?ZkRkb3B6SkZ5R29UZjhtSTFiME9NVmMzMlB5MTVydXpscitIbENmRng5YjEx?=
 =?utf-8?B?WjNQR3NnNXFyVE9CWFY0RkttRytuK1FCM2NkOVpxNlp2N0RxVlBvNitIV2tD?=
 =?utf-8?B?UUorTmRpY1VWWlMzZmgxK2I2cUwyMXJGM2tsTGlCY0psUndES0p2MXVCOW1y?=
 =?utf-8?B?b0p1Nk5rcWM3WmZVNWVXYkhDUVY1U081MUo2YkVybll2eUtsanByeDJIWlEw?=
 =?utf-8?B?RDZKZWl1emxWdXFNVlR2aVdpbStVNTd0SkNoTDJrTWJwYjlxR3M3V0dscUlN?=
 =?utf-8?B?NEdJUFplWTJsQU9rMDJ5Ujc1aWlLbHBucjBramFNbEs1MVVyNDRFVG1rQklJ?=
 =?utf-8?B?NzF2ODVpbGtUaU1rTUQ5U1NBOXZOTDhwM2lQT0dZMW1wQ2F5VGxqQ0RqSTJQ?=
 =?utf-8?B?REE1ajZpWjZuVlRudUV4NGhpeXJWbmk0SklZTWRlV3VWd3Z2TFFybjR1QzlX?=
 =?utf-8?B?aWY2YnN0NVJTRGdGcmFjSVJqUXZudGtHbFpCZXRaWVo2dUpobWRIdzJKRE5L?=
 =?utf-8?B?aGk4WmkzTC9GRnVCVU1TVXYvL3l4SnFXV1Q1OCtsVmlmSTRJNkl4MnR0YmtP?=
 =?utf-8?B?eDMzVGR6WTEzWXRyR1B5MDZ1bmJmYmo2MFEyWmdjbHJ6Z0VOMmR3aVJkS2M2?=
 =?utf-8?B?OXU1U245V3NmRlBTUU82Rzlvb2NOT1RqMUl4azRWQnJ6TklVOHQ2Z3drSXpC?=
 =?utf-8?B?czJ6NEV6YzcwczFxQ3k2d2dsODZuYm43eThHZzZnU25tSzR6UnZOU1BKT0Vx?=
 =?utf-8?B?QUZMcytuSUVtMktVVzdLMFFuRnlaRWk2citRTlNVWHdLd0x4c1ZtVXZtR2pW?=
 =?utf-8?B?NFVvd0wrZW1RS2dMdzZRZnhlQWhMRWtudTJxWUUrOUM2NExoODVuTEtGWE95?=
 =?utf-8?B?U1l6VSszbks2YklRRnZPQUp1cmM0S0FjaktaaWpoOXNlMGxoVEt5Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e5046b-1706-4af8-d292-08ded5db7dae
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:39:41.6936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoJV/h21u6XhIHuSYGm75m7SWzTbCFJqLUiy5PQoe8GSf2IaXZQ+GJDBnqXlrb4vRa1lDjdOFktSR4QR0TkaiQ==
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
	TAGGED_FROM(0.00)[bounces-9462-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61EE56DABF7

It is possible that `pci_device_id_any` will be passed to the driver, e.g.
`driver_override` is used on the device. Therefore, the driver must be able
to handle the case where `driver_data` is 0. Thus, update the `probe`
functions to get `Option`.

The current code cannot tell if the info does not exist or is the first
entry; however this will be achievable once the code is updated to use a
`&'static IdInfo` pointer instead of indices.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/driver.rs       | 2 +-
 rust/kernel/pci.rs                    | 6 +++---
 samples/rust/rust_dma.rs              | 2 +-
 samples/rust/rust_driver_auxiliary.rs | 2 +-
 samples/rust/rust_driver_pci.rs       | 3 ++-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5738d4ac521b..5a5f0b63e0f3 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -70,7 +70,7 @@ impl pci::Driver for NovaCoreDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
-        _info: &'bound Self::IdInfo,
+        _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..0e055e4df99e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -113,7 +113,7 @@ extern "C" fn probe_callback(
         let info = T::ID_TABLE.info(id.index());
 
         from_result(|| {
-            let data = T::probe(pdev, info);
+            let data = T::probe(pdev, Some(info));
 
             pdev.as_ref().set_drvdata(data)?;
             Ok(0)
@@ -284,7 +284,7 @@ macro_rules! pci_device_table {
 ///
 ///     fn probe<'bound>(
 ///         _pdev: &'bound pci::Device<Core<'_>>,
-///         _id_info: &'bound Self::IdInfo,
+///         _id_info: Option<&'bound Self::IdInfo>,
 ///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
@@ -313,7 +313,7 @@ pub trait Driver {
     /// attempt to initialize the device here.
     fn probe<'bound>(
         dev: &'bound Device<device::Core<'_>>,
-        id_info: &'bound Self::IdInfo,
+        id_info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// PCI driver unbind.
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 5046b4628d0e..9beb37275e0d 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -63,7 +63,7 @@ impl pci::Driver for DmaSampleDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
-        _info: &'bound Self::IdInfo,
+        _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_info!(pdev, "Probe DMA test driver.\n");
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 2c1351040e45..73c63afc046a 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -79,7 +79,7 @@ impl pci::Driver for ParentDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
-        _info: &'bound Self::IdInfo,
+        _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         Ok(ParentData {
             // SAFETY: `ParentData` is the driver's private data, which is dropped when the
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 1aa8197d8698..5547dd704a1b 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -144,7 +144,7 @@ impl pci::Driver for SampleDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
-        info: &'bound Self::IdInfo,
+        info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         let vendor = pdev.vendor_id();
         dev_dbg!(
@@ -153,6 +153,7 @@ fn probe<'bound>(
             vendor,
             pdev.device_id()
         );
+        let info = info.ok_or(ENODEV)?;
 
         pdev.enable_device_mem()?;
         pdev.set_master();

-- 
2.54.0


