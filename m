Return-Path: <linux-pwm+bounces-9466-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FQCPElJpQmpN6gkAu9opvQ
	(envelope-from <linux-pwm+bounces-9466-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:47:14 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD4F6DA7AD
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:47:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=BuaqFGVZ;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9466-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9466-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3B0B304569C
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACD84071C3;
	Mon, 29 Jun 2026 12:39:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020101.outbound.protection.outlook.com [52.101.196.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF9403EBA;
	Mon, 29 Jun 2026 12:39:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736791; cv=fail; b=Yi1qZirOahmAq6UJe0IRinbMpQ2p7RZq7xYj8CN1V4q4ycK8yG7/mdqYGV3H4umhU67el4LkoAr4YRs4moRMdENGEw7TRtK0K4IwXgqDvWz+IHA8wXzpgHFJLJCjrw6GqdFAL6ow9/FIrew+wphjJRklGt7iSwuH5efpS6KJGLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736791; c=relaxed/simple;
	bh=NuqK99U4Ll4Ec+fw2qhKP0nlS1mTxxnyGsa731njDJw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Rx1tBl+vQQMTSKpGOfP7GDavABW1FNw0eGRDwQ1+iCPEMjF0upSdM4yPKg8N20m4EAA2zcTATXAeoFaWAsq+yJ1xpOav06f3Q/z1TODoBuHhoQ38cFMjVMcavj5EzY91Ljdjae9RIroIZwQ1akZxhgnb6Rbp5rHzaaUVjYZzmfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BuaqFGVZ; arc=fail smtp.client-ip=52.101.196.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sP1LSlZTW7hlNw8CAHBEccYqz1qA1xX2sl7wXfMHp30xLFvf6LBOSEJsfOoQcwJrs0Jt9NDwrcJ5r03J9fCJ09YnuFPoLlK2t+Ac7PLFLn8RCo+DSIvGViR6hbCEdSkjrSzmTGOlgIWBlhp2a4+t8fp48j6N8nBMsfdkjE4k1gKYuUNvdRpzaVORRpp7Ko2AHnuawT1qsg9bCHfjzALkejBLhEaTQlvTRBF0MD+zLuURzbT69MVrukVOnas6F9TdFxH7d9BeTHaRsJeo0hAciP10AEcV7uKVWgWKi+KcZii3gflpFY2HSrwveQCoHaQ/8D5kiRmFzZELVQ0YI4knFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arINl/qXd+KTLpf+U2m4EsXms5dsAZelHzhJ3/IuSj4=;
 b=qN17lRsp5jnmnaBWF8HPiukeJbdbkFBJ9UwpAd52DkD4ROQAzjOyRGGzA0lOJ/xoMDtvmalAKObnzeog6PgBYeNw1Qxe+jJT+zpKKt1mvPC6Y9kKQZBKVj0RBP+B9mua0iJLKkMZWDVGT94PBmJ6gTRFEB0Px66+9Do/TTsQwtYwXZMUqyVf/D7WEbOrYID9yZVSVCjGoOWKOSKqUEtDY2TMrSp5HrpXYs5Gg3ZBWf6bB+GiUorJsmztqqTPx5heeEI+y5iIcdOXCcI+gQ8eK3utf7o17bZIbXwqlSZBB43GMdAvG8z72IedJ1T9SZFRwdqVDnhA1l5717lrt7hAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arINl/qXd+KTLpf+U2m4EsXms5dsAZelHzhJ3/IuSj4=;
 b=BuaqFGVZIUqKHETAEDdwKB+hVWQHCjOts+A50wgfjjJKSQmqmvuR5gcpdIA7Pf9JgqL1ux98tXjXbLHyKz/kxaHwhoHD56XUgZ7yg8K0viboGE4dgtGNp8eEUOC/LGqfUJa+r8YxyDmlg+2ZzeXdjbQBWePZ4N0+nxz4PD69QJI=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2670.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Mon, 29 Jun
 2026 12:39:45 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:39:44 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 29 Jun 2026 13:39:41 +0100
Subject: [PATCH v2 07/11] rust: driver: remove `$module_table_name` from
 `module_device_table`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-id_info-v2-7-56fccbe9c5ef@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782736778; l=13923;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=NuqK99U4Ll4Ec+fw2qhKP0nlS1mTxxnyGsa731njDJw=;
 b=Wnf67hgqyWYwliEce0Jh10oDR72SKxFVTjxh3AmWA04ohCFv1oVv8yrJXHHhgdP+pIW5sFiP5
 hAtWcMAjvVOAiopX39p8o8CywmPqGk/xDDa0EuGIxxRXnEVuQbTEy9g
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
X-MS-Office365-Filtering-Correlation-Id: d7d3db4d-f067-4ef1-1486-08ded5db7f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10070799003|22082099003|18002099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	Vwhr3lJtQEgmeM/olN4GRYoRVZZ4WEl6oujDtZ+yB+X+y7DdWp4MgNGykfBlQHSdr7qpSuBAjyu8WehkXfWVuMgt9fVVGi1kzhhJ054FbyK6PTNXcRD0Miby56AGwy/zLdAP7+z44yjKg9Ns96TPxGQucATzICdyPTsM+lLGArr/gymcu/zOjuvN0tIFNfu7LxOb8+McAxKUC8HBpivyEHWwJlWRZwMYNHuVMWyZpzl4Qd6kLQmkREPL25qd2e3QeSmFuliWCAcCRBW+3vyFRuTMJzxQxFKKq+uxCbSBdJmm31WvZ1Ys2jIwrrcnDAWc+mRxcOn6PmVM50JPC434YUyvlnWyCR+vOTaKI3w5YXJwU6Ca01ML406UBlP04eocw2Q46x1AHq9AfHc8BR2xjyFrvbhNJhk431JM3/yzPTadz58AICNZRCcBki2sTNFUb3XggbMEs5AN3ipybH25mYa4lG3Xm50wSclkP8kdRbnnwW8235nnZFftb/s4qccYh+zSJceMY8UhfvrpNCMdTvL8AHI0O4S2ml+fYJkeYX20u5ejYs1RrT3SUebSQWcR7T/R2hmD6K1Ev1h2dA5tUxiOH7GgZMP+qdOTvQW1B0JNmz8M3B0I3ljUnugujBWnpN/A1jaT1/vTY7ud0Dlb97EjiuLGRVrPVcdHT78g7IV3I/qRoKE1bHXkCq1A5jxIOqsY+SJOhnXRdrtxMJGnMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10070799003)(22082099003)(18002099003)(921020)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzRVeFlib0VVUW9Hc0tZcHRQenBPdUt5dHgydys1ZkZ5c2xzQVFRbC9WZTVh?=
 =?utf-8?B?eGlvcUluSUhNVUkrUXlhS3ViV0wxclJHTEthd0NQMXkvUEpPN0I3d1hSaWNj?=
 =?utf-8?B?d1czQ1NTd0lIek83MlJKbEx6T0ErLzFOOTVQSUdlRWtKTkRoT0tmZHVDUmF1?=
 =?utf-8?B?UEtYRUlsUXZlakh4Tm1sVmZOUDlYWUFaMUFWYVo3djI3Ums2cVRXa2RJTUpu?=
 =?utf-8?B?S3hqMkllK1RDeFkrcStyUnM2YUhyeUFrRVFqWTgyb2ZsaHlCTmIzaEFEK1By?=
 =?utf-8?B?VmdrUXlhYTVoYXJNU2pOV1ZtUGRLcFJmVy9lRVpWTW1uRDFiSmNhUWp4OWds?=
 =?utf-8?B?VTlPbjBUY0pza0hYSTdadmVaWElGSUEwUXplOFJJRmRYcS91Qm0zODhxT2tz?=
 =?utf-8?B?b2oyWFpiV3JId2hFME9iZ3lOQTcwUWF5Sjd1OXFjRTJBWjYvTkVHblJ2dVVU?=
 =?utf-8?B?cUZnMllyTFcxYlRXV0R5YmdSTm1zMG1zSHpjaEQ2S3dHMEEwdmNPU1o0Znho?=
 =?utf-8?B?dzFIU2VnQmJjYWplRWlDSzdOeEdxVXE2WTR3OW9NcS9kVVg0MnVMODFlc042?=
 =?utf-8?B?REFiV1dEUkJ4N0E4NFdPbU5kK05lcmJWa1VlY29DaFkzTUtKMGxwNjlOT1RM?=
 =?utf-8?B?T1hsM0RXSi9ySEI1Rjc2aFVTR0ljN3JkWk01L0VGdUcwbGVNT3N0VERWWVRP?=
 =?utf-8?B?am15eWN2YnNOVWNSZ2g3L2NEN0syZlN4SnBNNDZlMTFLN3pOOEd6eUh5aWZk?=
 =?utf-8?B?U0pya1dPbFV0OS8vRHFVSmQ5TUhvdVlNeVRibGFkdUNBQmdpdjY0RlQweGlx?=
 =?utf-8?B?dTMwdEwxaXNMSkV6WWJRNUMzYTVXRDVwSzBUeG1jQnovWDRrVGdrYXZHVEJo?=
 =?utf-8?B?cTFFUlM3V2NtR1JJOEhmTm5JS3hLK1p5OExOYTZXWGl3WnpINFVOK0xnWldt?=
 =?utf-8?B?cnZ0VWQxYnZ2RXh4MklIWC8vcHBEaG13WmdEek02ZC9vbE9vcE5qS2wvbUZO?=
 =?utf-8?B?Y09EdDFGK2EwaGxnRm1FMmtNT3EzQWxhTk1GaXl0ZE5kT29iRWFpWUZBN1da?=
 =?utf-8?B?SUZIaWpJYnMzdUxzNHhmKy9vYXY4am5mN09XZVBJbE9IV3EwSzc0T1J6aFJM?=
 =?utf-8?B?akdnaGZjNjlycUI0MXRzSEh5QktGMStZc1lNMTlZMFVYeUltWncyQTkzZTE2?=
 =?utf-8?B?QUU4Y3VidC9sVVBkYlZYZXBGSDJscXNQR2NOVU1DcDhJZlFMdDd4WGc0ZzBC?=
 =?utf-8?B?MEpDSG5zYk1KbGlMenczdHdLU0dJYUZDZitIWXFyQTRDMmhWRXlpQy95cnhK?=
 =?utf-8?B?Z2tMOWhUT2tBdGJIck5LRW1pcjdVcTNxVVovZWJHTExpd1U4QmRiakY4N2M0?=
 =?utf-8?B?QkdCZjAzNmtzODBqWWxlcHhxU0FScWJWcUJ6OHgwM2h4OTMva1RZeS9OL3FV?=
 =?utf-8?B?Mms4elNIZUdxdjA2SXErc3M0NE1ZU0Y0WW9LNkFOS1k2ME50Z1c3eHFxVTZ3?=
 =?utf-8?B?SDFveHQ4MHFBYWdmRlFENTY2czJlNjhEYnE2U0dpNlRxNkYyRzVVR3FKaW5J?=
 =?utf-8?B?djBQSlJLSnNkN1BUZjlJTGMwZlUwQXF3T092VWdMZEpsZ2JKWXlzbnRoWi9T?=
 =?utf-8?B?Z0xINnFrZkpYZEFoakxEbUpqRGkweEhEazNBZnlwVCtSeHNsQnpZb2MyNzRK?=
 =?utf-8?B?V0hDZXVsei9xQmJhTXpLQWQrLzZQakptU3Vlcm9kdWFiQlNpTWQxZjdLUVBp?=
 =?utf-8?B?NTY2TGdQdTJLNEc3a21DRWZ6OWtMYkFIajhJSFNBaCtRSzA5UGJEdi85cnZE?=
 =?utf-8?B?YWlVd0NZYUtmQ1VEMU5qM0FvbnZXaEE4N3E0UzlYTFVSbFBIZmJ1UWFsbnp5?=
 =?utf-8?B?YjRKakFlUm45bFdzTVlEOHdVTndmTlV2QlZuN0dhODNaUjVhT0htZ21OTVlV?=
 =?utf-8?B?NzB4MWgxT1V5UDZ5MlA5Qmd4dm1BQ21rRzduUnZxQ052ZndQZXA3eUpiZmZN?=
 =?utf-8?B?N1lsWWJTWW5FS1ZSNU0yMm5yaVYrTXJrZmxFU1FZVVJvWlBieGFsVDhHNS96?=
 =?utf-8?B?ZmU1TmpaSFBwY3dVQk1JT1Z5T1h1WkxhTGRUTFJmd0FKc1Fsc1FvS05lVW9S?=
 =?utf-8?B?cy83em44ZzBCMXFoZEhCRFdMMk9JUFBCeUZLSUlRaDRSUStDYTg4ZU1yN2Ex?=
 =?utf-8?B?dDFlaE9iVDEzMGpiZ2V3bDYzZ2YwbzRCU1FpYVJCcTJpVWthNGF4WG84QXVy?=
 =?utf-8?B?cEtXL2VHT0FaQ0E1ZjZrb2tPQUY5V0dzanR1eVdlQS9uaTYyM3ZPOTZrc3Qr?=
 =?utf-8?B?R29aOXJpWjlQNXhQZ1VtZVVhWGhOY0hhYUQ2SmdZV2ovWDRhYVVSUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d3db4d-f067-4ef1-1486-08ded5db7f93
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:39:44.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Bv83qEP8ODf8VAyO6R4ii5263r+CA6dYq/VKPGHVpt9tgSXDFcPvVD8BuuDmagtgOBrrKa0fNAu5doC7wFBDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2670
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_HAS_CURRENCY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9466-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,gmail.com,ffwll.ch,arm.com,intel.com,linux.dev,linaro.org,samsung.com,redhat.com];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[47];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fujita.tomonori@gmail.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:david.m.ertman@intel.com,m:iweiny@kernel.org,m:leon@kernel.org,m:lenb@kernel.org,m:igor.korotin@linux.dev,m:robh@kernel.org,m:saravanak@kernel.org,m:viresh.kumar@linaro.org,m:m.wilczynski@samsung.com,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pci@vger.kernel.org,m:lin
 ux-acpi@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:linux-usb@vger.kernel.org,m:gary@garyguo.net,m:fujitatomonori@gmail.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFD4F6DA7AD

Wrap the generated code in a `const _: ()` block to avoid symbol conflict.
This removes the need of creating a new identifier.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/cpufreq/rcpufreq_dt.rs        |  1 -
 drivers/gpu/drm/nova/driver.rs        |  1 -
 drivers/gpu/drm/tyr/driver.rs         |  1 -
 drivers/gpu/nova-core/driver.rs       |  1 -
 drivers/pwm/pwm_th1520.rs             |  1 -
 rust/kernel/device_id.rs              | 30 ++++++++++++++++--------------
 rust/kernel/i2c.rs                    |  3 ---
 rust/kernel/net/phy.rs                |  2 +-
 rust/kernel/pci.rs                    |  1 -
 rust/kernel/platform.rs               |  2 --
 rust/kernel/usb.rs                    |  1 -
 samples/rust/rust_debugfs.rs          |  1 -
 samples/rust/rust_dma.rs              |  1 -
 samples/rust/rust_driver_auxiliary.rs |  2 --
 samples/rust/rust_driver_i2c.rs       |  3 ---
 samples/rust/rust_driver_pci.rs       |  1 -
 samples/rust/rust_driver_platform.rs  |  2 --
 samples/rust/rust_driver_usb.rs       |  1 -
 samples/rust/rust_i2c_client.rs       |  2 --
 samples/rust/rust_soc.rs              |  2 --
 20 files changed, 17 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 10106fa13095..145daa12072f 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -194,7 +194,6 @@ fn register_em(policy: &mut cpufreq::Policy) {
 
 kernel::of_device_table!(
     OF_TABLE,
-    MODULE_OF_TABLE,
     <CPUFreqDTDriver as platform::Driver>::IdInfo,
     [(of::DeviceId::new(c"operating-points-v2"), ())]
 );
diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 48933d86ddda..43f15cdfeb09 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -43,7 +43,6 @@ pub(crate) struct NovaData {
 
 kernel::auxiliary_device_table!(
     AUX_TABLE,
-    MODULE_AUX_TABLE,
     <NovaDriver as auxiliary::Driver>::IdInfo,
     [(
         auxiliary::DeviceId::new(NOVA_CORE_MODULE_NAME, AUXILIARY_NAME),
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index d063bc664cc1..218e9af899c7 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -87,7 +87,6 @@ fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
 
 kernel::of_device_table!(
     OF_TABLE,
-    MODULE_OF_TABLE,
     <TyrPlatformDriver as platform::Driver>::IdInfo,
     [
         (of::DeviceId::new(c"rockchip,rk3588-mali"), ()),
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5a5f0b63e0f3..0c53b7239ac9 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -40,7 +40,6 @@ pub(crate) struct NovaCore<'bound> {
 
 kernel::pci_device_table!(
     PCI_TABLE,
-    MODULE_PCI_TABLE,
     <NovaCoreDriver as pci::Driver>::IdInfo,
     [
         // Modern NVIDIA GPUs will show up as either VGA or 3D controllers.
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 3e3fa51ccef9..1df752330e8f 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -303,7 +303,6 @@ fn drop(self: Pin<&mut Self>) {
 
 kernel::of_device_table!(
     OF_TABLE,
-    MODULE_OF_TABLE,
     <Th1520PwmPlatformDriver as platform::Driver>::IdInfo,
     [(of::DeviceId::new(c"thead,th1520-pwm"), ())]
 );
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 0239f89d5f69..022f0101871f 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -177,7 +177,7 @@ fn info(&self, index: usize) -> &U {
 macro_rules! module_device_table {
     (
         $table_type: literal, $device_id_ty: ty,
-        $table_name: ident, $module_table_name: ident, $id_info_type: ty,
+        $table_name: ident, $id_info_type: ty,
         [$(($id: expr, $info:expr $(,)?)),* $(,)?]
     ) => {
         const $table_name: $crate::device_id::IdArray<
@@ -186,13 +186,13 @@ macro_rules! module_device_table {
             { <[$device_id_ty]>::len(&[$($id,)*]) },
         > = $crate::device_id::IdArray::new([$(($id, $info),)*]);
 
-        $crate::module_device_table!($table_type, $module_table_name, $table_name);
+        $crate::module_device_table!($table_type, $table_name);
     };
 
     // Case for no ID info.
     (
         $table_type: literal, $device_id_ty: ty,
-        $table_name: ident, $module_table_name: ident, @none,
+        $table_name: ident, @none,
         [$($id: expr),* $(,)?]
     ) => {
         const $table_name: $crate::device_id::IdArray<
@@ -201,18 +201,20 @@ macro_rules! module_device_table {
             { <[$device_id_ty]>::len(&[$($id,)*]) },
         > = $crate::device_id::IdArray::new_without_index([$($id),*]);
 
-        $crate::module_device_table!($table_type, $module_table_name, $table_name);
+        $crate::module_device_table!($table_type, $table_name);
     };
 
-    ($table_type: literal, $module_table_name: ident, $table_name:ident) => {
-        #[rustfmt::skip]
-        #[export_name =
-            concat!("__mod_device_table__", line!(),
-                    "__kmod_", module_path!(),
-                    "__", $table_type,
-                    "__", stringify!($table_name))
-        ]
-        static $module_table_name: [::core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
-            unsafe { ::core::mem::transmute_copy($table_name.raw_ids()) };
+    ($table_type: literal, $table_name:ident) => {
+        const _: () = {
+            #[rustfmt::skip]
+            #[export_name =
+                concat!("__mod_device_table__", line!(),
+                        "__kmod_", module_path!(),
+                        "__", $table_type,
+                        "__", stringify!($table_name))
+            ]
+            static MOD_DEVICE_TABLE: [::core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
+                unsafe { ::core::mem::transmute_copy($table_name.raw_ids()) };
+        };
     };
 }
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index a1f968fd873d..6f2dcd467e72 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -261,7 +261,6 @@ macro_rules! module_i2c_driver {
 ///
 /// kernel::acpi_device_table!(
 ///     ACPI_TABLE,
-///     MODULE_ACPI_TABLE,
 ///     <MyDriver as i2c::Driver>::IdInfo,
 ///     [
 ///         (acpi::DeviceId::new(c"LNUXBEEF"), ())
@@ -270,7 +269,6 @@ macro_rules! module_i2c_driver {
 ///
 /// kernel::i2c_device_table!(
 ///     I2C_TABLE,
-///     MODULE_I2C_TABLE,
 ///     <MyDriver as i2c::Driver>::IdInfo,
 ///     [
 ///          (i2c::DeviceId::new(c"rust_driver_i2c"), ())
@@ -279,7 +277,6 @@ macro_rules! module_i2c_driver {
 ///
 /// kernel::of_device_table!(
 ///     OF_TABLE,
-///     MODULE_OF_TABLE,
 ///     <MyDriver as i2c::Driver>::IdInfo,
 ///     [
 ///         (of::DeviceId::new(c"test,device"), ())
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 166572861e61..1e86b901c391 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -811,7 +811,7 @@ macro_rules! module_phy_driver {
     (@device_table [$($dev:expr),+]) => {
         $crate::module_device_table!(
             "mdio", $crate::net::phy::DeviceId,
-            phydev, TABLE, @none, [$($dev),+]
+            TABLE, @none, [$($dev),+]
         );
     };
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 34e07a53244d..a3dd48f76353 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -261,7 +261,6 @@ macro_rules! pci_device_table {
 ///
 /// kernel::pci_device_table!(
 ///     PCI_TABLE,
-///     MODULE_PCI_TABLE,
 ///     <MyDriver as pci::Driver>::IdInfo,
 ///     [
 ///         (
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 9b362e0495d3..210a815925ce 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -176,7 +176,6 @@ macro_rules! module_platform_driver {
 ///
 /// kernel::of_device_table!(
 ///     OF_TABLE,
-///     MODULE_OF_TABLE,
 ///     <MyDriver as platform::Driver>::IdInfo,
 ///     [
 ///         (of::DeviceId::new(c"test,device"), ())
@@ -185,7 +184,6 @@ macro_rules! module_platform_driver {
 ///
 /// kernel::acpi_device_table!(
 ///     ACPI_TABLE,
-///     MODULE_ACPI_TABLE,
 ///     <MyDriver as platform::Driver>::IdInfo,
 ///     [
 ///         (acpi::DeviceId::new(c"LNUXBEEF"), ())
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 3797f4a79b79..d8cffbe594ff 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -271,7 +271,6 @@ macro_rules! usb_device_table {
 ///
 /// kernel::usb_device_table!(
 ///     USB_TABLE,
-///     MODULE_USB_TABLE,
 ///     <MyDriver as usb::Driver>::IdInfo,
 ///     [
 ///         (usb::DeviceId::from_id(0x1234, 0x5678), ()),
diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index 1f59e08aaa4b..181fd98ae5b6 100644
--- a/samples/rust/rust_debugfs.rs
+++ b/samples/rust/rust_debugfs.rs
@@ -110,7 +110,6 @@ fn from_str(s: &str) -> Result<Self> {
 
 kernel::acpi_device_table!(
     ACPI_TABLE,
-    MODULE_ACPI_TABLE,
     <RustDebugFs as platform::Driver>::IdInfo,
     [(acpi::DeviceId::new(c"LNUXBEEF"), ())]
 );
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 9beb37275e0d..80c309ce07e9 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -51,7 +51,6 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
 
 kernel::pci_device_table!(
     PCI_TABLE,
-    MODULE_PCI_TABLE,
     <DmaSampleDriver as pci::Driver>::IdInfo,
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 73c63afc046a..704567a072ba 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -24,7 +24,6 @@
 
 kernel::auxiliary_device_table!(
     AUX_TABLE,
-    MODULE_AUX_TABLE,
     <AuxiliaryDriver as auxiliary::Driver>::IdInfo,
     [(auxiliary::DeviceId::new(MODULE_NAME, AUXILIARY_NAME), ())]
 );
@@ -66,7 +65,6 @@ struct ParentData<'bound> {
 
 kernel::pci_device_table!(
     PCI_TABLE,
-    MODULE_PCI_TABLE,
     <ParentDriver as pci::Driver>::IdInfo,
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
diff --git a/samples/rust/rust_driver_i2c.rs b/samples/rust/rust_driver_i2c.rs
index ead8263a7d48..a0df0c6097c4 100644
--- a/samples/rust/rust_driver_i2c.rs
+++ b/samples/rust/rust_driver_i2c.rs
@@ -14,21 +14,18 @@
 
 kernel::acpi_device_table! {
     ACPI_TABLE,
-    MODULE_ACPI_TABLE,
     <SampleDriver as i2c::Driver>::IdInfo,
     [(acpi::DeviceId::new(c"LNUXBEEF"), 0)]
 }
 
 kernel::i2c_device_table! {
     I2C_TABLE,
-    MODULE_I2C_TABLE,
     <SampleDriver as i2c::Driver>::IdInfo,
     [(i2c::DeviceId::new(c"rust_driver_i2c"), 0)]
 }
 
 kernel::of_device_table! {
     OF_TABLE,
-    MODULE_OF_TABLE,
     <SampleDriver as i2c::Driver>::IdInfo,
     [(of::DeviceId::new(c"test,rust_driver_i2c"), 0)]
 }
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 5547dd704a1b..2282191e6292 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -74,7 +74,6 @@ struct SampleDriverData<'bound> {
 
 kernel::pci_device_table!(
     PCI_TABLE,
-    MODULE_PCI_TABLE,
     <SampleDriver as pci::Driver>::IdInfo,
     [(
         pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5),
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index ec0d6cac4f57..710145b3605a 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -87,14 +87,12 @@ struct SampleDriver {
 
 kernel::of_device_table!(
     OF_TABLE,
-    MODULE_OF_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
     [(of::DeviceId::new(c"test,rust-device"), Info(42))]
 );
 
 kernel::acpi_device_table!(
     ACPI_TABLE,
-    MODULE_ACPI_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
     [(acpi::DeviceId::new(c"LNUXBEEF"), Info(0))]
 );
diff --git a/samples/rust/rust_driver_usb.rs b/samples/rust/rust_driver_usb.rs
index 176ef625ed75..7ef04e177c80 100644
--- a/samples/rust/rust_driver_usb.rs
+++ b/samples/rust/rust_driver_usb.rs
@@ -19,7 +19,6 @@ struct SampleDriver {
 
 kernel::usb_device_table!(
     USB_TABLE,
-    MODULE_USB_TABLE,
     <SampleDriver as usb::Driver>::IdInfo,
     [(usb::DeviceId::from_id(0x1234, 0x5678), ()),]
 );
diff --git a/samples/rust/rust_i2c_client.rs b/samples/rust/rust_i2c_client.rs
index 2d876f4e3ee0..c8a23875ef5b 100644
--- a/samples/rust/rust_i2c_client.rs
+++ b/samples/rust/rust_i2c_client.rs
@@ -87,14 +87,12 @@ struct SampleDriver {
 
 kernel::of_device_table!(
     OF_TABLE,
-    MODULE_OF_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
     [(of::DeviceId::new(c"test,rust-device"), ())]
 );
 
 kernel::acpi_device_table!(
     ACPI_TABLE,
-    MODULE_ACPI_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
     [(acpi::DeviceId::new(c"LNUXBEEF"), ())]
 );
diff --git a/samples/rust/rust_soc.rs b/samples/rust/rust_soc.rs
index 808d58200eb6..f5e5f2f9adf7 100644
--- a/samples/rust/rust_soc.rs
+++ b/samples/rust/rust_soc.rs
@@ -23,14 +23,12 @@ struct SampleSocDriver {
 
 kernel::of_device_table!(
     OF_TABLE,
-    MODULE_OF_TABLE,
     <SampleSocDriver as platform::Driver>::IdInfo,
     [(of::DeviceId::new(c"test,rust-device"), ())]
 );
 
 kernel::acpi_device_table!(
     ACPI_TABLE,
-    MODULE_ACPI_TABLE,
     <SampleSocDriver as platform::Driver>::IdInfo,
     [(acpi::DeviceId::new(c"LNUXBEEF"), ())]
 );

-- 
2.54.0


