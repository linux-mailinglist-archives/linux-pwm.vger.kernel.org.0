Return-Path: <linux-pwm+bounces-9326-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fEXAOTImNGqsPwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9326-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:09:06 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E31F6A1CEC
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:09:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=pEbBVIXr;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9326-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9326-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA0C43079298
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928E7384CD8;
	Thu, 18 Jun 2026 17:04:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021095.outbound.protection.outlook.com [52.101.100.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F0348C6E;
	Thu, 18 Jun 2026 17:04:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802299; cv=fail; b=I0jhtkdfBLjzX7QV1AY4cxUCLeT4mivFHSi6WkyrPICLSAQClqd1i+aoLVxCRLoXoxRb0DBiE8AODsRC1cnCxF2fzr9GSLhse1GP6dU6u7512K+5vGMiIPmtBv3mjgtUfKH7eNp20RGm6vrRqF3iOpb7kO7z663W7jEu4lS+Yks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802299; c=relaxed/simple;
	bh=zrzKTyWZvFl8aHR0nGBQfvLWhUntGP6fVsEvGW3syKw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hLd8ZAjIu5G2jDHHOGqqE/ryFObfuNOYcWBTE/qmQyNFNmzLHxMtvHf3cYehsarAfHlKYIy+xbhxoSBQoLOAvCAZwHseK1BlFhbL9bXpcf3fpB24SHxj/JOns7sw+tmbHOdGNwLH6aKiMjYdRQn/0K3CY/GuToDavRp6KByJp8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=pEbBVIXr; arc=fail smtp.client-ip=52.101.100.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkI3//myayZZcaXrcHL+Lq73xjO3ydab431iYPtt7XAwsYYrquMViZCBIu1SGwnKFIZR1/4bG2V54RGNV5xIU/wg+AjvdqnCQR5iiruohqfVAO3GfGZYFByzsNjNthPYiouMun/1GgQhYoB82K6KbLnU6axAPFvQ7TfpGBL07K200uGSmXN1IbkOq0u/nwaaqvhCCN9iG9dweo0O6/eZIs22MANDALqYUiEdmjE/Ma9B7nOcTNbmNuUVvP5hK6jzRjxsrJiAgazKYp/tBgfav3jnXrZnyZrxM5NAoqNiIvhd45ecSkY7Mmoiyi7C06NJWLhGD3W+hXtw+i9kJiCqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZlStPudhbfDz5sWB4KYpDnrxowPhKGyluFvi7KcHZI=;
 b=ENwB3ZN2uCAmuuCtVXs3BDYqUEVKQsK9H5gu3hfZo0dMtE+M1TZhifb1n0hsFFvKfo2uN5zuZfVD87GfU3aXHZ/OgDxFqYEL1oO4uW2Z/uqABctoBT20Ztsf3j7184jNUMHzj00XmkldgAjd4maL1vij5EJJy7EjTeo+BrAvr5mIaaBSR5Cyd2aDfd7PpHxEtBrLapmlTiogo0/8+nLj39vh2BvO9x/UWATpsgFPFi13lOsxES+CSZYdnOmZZ6exjjFbHlyS0JllHKKh1mhoijH9fGAz14q857SiwtNeN/J1su2RN56T5+AYfgqarDm84BFWBWSKeUN8uCFh5rHg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZlStPudhbfDz5sWB4KYpDnrxowPhKGyluFvi7KcHZI=;
 b=pEbBVIXrR8XceR7cQ3z8fDLAfSnt3g4JQG36fM0fqtZ23D3t6Ze3CO1zt3n+9iTGFbs+jujnkf/cmijBBFrxwg69wFqbotfOuQ19oopguAqD3S2BBPh+8oQqK4dVud9JpI3BcWkWkYQSFOnFVUBqwEN/U2R9qcBcUnN+qGHb+tQ=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6966.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 17:04:47 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:04:47 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 18 Jun 2026 18:03:43 +0100
Subject: [PATCH 06/10] rust: driver: remove `$module_table_name` from
 `module_device_table`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-id_info-v1-6-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
In-Reply-To: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
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
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781802282; l=13912;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=zrzKTyWZvFl8aHR0nGBQfvLWhUntGP6fVsEvGW3syKw=;
 b=CbmMHGyXvD5RrOoMTL4dZ8FaPr8G7SDNfJHKi6VizMHt5Bt8mWoyiUdxmOyqASohcpne84X1F
 27D9Dz24nd0BwBj3MPSnTuFUq1pSXsV9hR1cNNoy52jUbBxdAyBXjdL
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0548.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ea0177-340f-4e5b-90e9-08decd5bb398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|366016|7416014|921020|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	isPeEBW/lI1vC/NzhW0Frlbf2mZZEipPbJaHN9d3Db+MKhtwzMLwPQHMFIEzRP8XZEu3V6tFXs5fZHDPrjALHBc/ukovfqtU7bFyJ9d3Gv7hAK2pe31jsCjidgF6GebRMvkZ5fr32s5CLNxMEmevYybeNY15K5T68aUnZmIhcFyaXfo2SwTA7XwuSZVuVwTGaiMK0ABqM7FkV6cLOeFgxhoR1pYtswo8rC11iX49algXj7waoPM9pKSXmed2bw8quf3KbXij8PIvL/FP2FDLvdKvfmP7BZKy1X7BqjrV5ys4MHJTzJi0KCzABEuktuODKt1rRBBSlsctdmX/fJGNWFA7H3XKspzYg0o+GBK0nayXjz+24co659N4VM3vPN3TmTPAiIaXM0WvZThUTZgPzAwG/WF4vRWJmGnnkTH9ZrJgbuT/HJ8D+aqkZA4NJlYvNbsuEGCQZJtsRBuWedXDkIQ/U/vPQbnhyE4ubNYSK5ltvKVmbW06gAdSuG39RO8sChOWfEeYsJwuszt75M78DDu+MRhpl5X763wYCh0DZO+lMltAV0L6jld5+w8XLoWkGLuY+4mSi9x4KymhzRAROYicfiDgOOIPAIiSWQ60oPcOTsH7PtkbnM3Kq2YsYTPqsKwI61I5rts/3nB/7xTXVqLgrAODkjIGBhVJhZB+Er8AxMx1Mj9hRt4U94qifsdkcRfECS2ygKZfwkJQZ1mNm0c/9zvwvLilwtgUL1wvc6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(7416014)(921020)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHA1KzFxVlhnbGpTcDR4OUhRQWRBdFdYZ1U1QmNxdzdMTU1pdHAxYnhrcWta?=
 =?utf-8?B?b2ZFTklYSFlvWkFDUm5vMjRJdzZYYm0rSlpXNUhFTHBSZGNta2ZQV1FMNlFt?=
 =?utf-8?B?SXBNRkI5TUs3MmFQWDJrWTFXOFZ4UE9KS0Fua3RZOTI3K0tMdHptckNqYW9K?=
 =?utf-8?B?dnFDMVZXUlNVeXBiTCtBTjYyU0QxVTZYQS9RUDZ6TS9pMEplMG81VjR5R3Q2?=
 =?utf-8?B?emZSNU1WcEJRbmVRVkhlZEk3YjNZWHd5d1Q3eUxja2c1UGg1SmxYZ25uU1Fo?=
 =?utf-8?B?KzNHazJaaWxlTGZZWEhjOVZxTlJYQVZuY2MzaTNVSXhPQTdjR1crR3VGMXJr?=
 =?utf-8?B?endpeFdKYmpKRG1BYUN4RVllcTB6RUZnckVyRzlDZ1FjWHdzQ29DUUlOSVVl?=
 =?utf-8?B?MTFiOTNkWkcxanBGZkdRSGVVVDgwWmNRNVZ2YnRuUGpQVkR2TnBzR1ZFaVZy?=
 =?utf-8?B?d0lOeUIyNUpIT0hxWldyRkRTWnNPQXcrc0FmMHVwYmp2YlZFQWVKaEdOMGlB?=
 =?utf-8?B?OWJ5S3hyK25jUFVUMUlXMUp1aEF1djJBU0dqdzFXZVFCVWorOW04VmFzb2Mv?=
 =?utf-8?B?YVMzZmxMMFZPaDNLQ21zb3ZucmcwaTRpZGNxdkNKaDM5TVRlODg2VXJEUWF2?=
 =?utf-8?B?ODYzTmhBc1NJNXIyN3FXQm0zTFZ4dlR2Mk1rREQ1OGxRN2NQejVYWHFZeGlG?=
 =?utf-8?B?d3A5NisxSjZDekxGTjZLNTY4MzA5Yk1vSzcwM283cUE4dFQwKzl0Wllld3NZ?=
 =?utf-8?B?R3AwdTV5RDJNVTdRWmpMKzRZaW9PRFBPRDBXeWp5ZWx2ZXh1cm9saWZRUHJF?=
 =?utf-8?B?L2dVZGoxYU9sM2dHUlVVQWUyS1ZGKzNpbXFENndVbzM5dElET0dzUGU2d3U0?=
 =?utf-8?B?ZGVhd0p6and2MzBjZ29YRVY2WHA1aVc4Z2xucGNaK2pjYkMrY21ZSnlZcTdn?=
 =?utf-8?B?djRMMG8wcDh1YXB2eVRYVjIxZDMxMDdvNjFPa2FEUm5CTktaMkh1L3pyYU9m?=
 =?utf-8?B?Z2ZjbDNpT085S0ZYY0IwTnc0WU05TXh0WlpaOUpvUWtkZGlDNHRMYkJueXUw?=
 =?utf-8?B?MGpSVUhwWTgrUTA2TC9oQXB3WUp1NTE3T1cvVXc2Q3FCUkVMUXQ5bjNVc3ds?=
 =?utf-8?B?Tm0xN1ZPdmcyTVY1SVdYSzVadWw3TmJMMVMzdSsyUUo4dkt0cTB0ZEpFR3NL?=
 =?utf-8?B?NkdyMjBQMHdmR3pRb0FFOVVPNjVvaEkvalZNVzRialh2TnE1ZTEwVmZYZFpa?=
 =?utf-8?B?L3VaSE5pT3lRd1hZQTB5VFVVMWkxQkkzZFF3QTRoL1lPd2R3d1JkQU1tRURV?=
 =?utf-8?B?TGVabkVCdVljWnpSR0g3SDJWTVRqVWxmbVZ0NnVSZk9HdDlFWEUrc1VtQXBu?=
 =?utf-8?B?Kzk2V21mTGhxZW01YmN3LzRBbWhOM1EvRjJDT3pmb2lBQmNsR0dPbW9VR1Rr?=
 =?utf-8?B?aFFpR3owTVBpUHdPMnB1NFd5b2t5NnNnbHp6STlKZWJaem5IVU5sMElacGlF?=
 =?utf-8?B?OHNpb1dxWEQvVHI2dHFxR2JGbHJUTjNFR25mdUZhS0ZSaVFNTDRQMWhKblNq?=
 =?utf-8?B?TzZLd0UvVVg1dnRFMmpJWEZ2V1NrckFyVWxQZER1ZHhETGo0N1pNN3hhZUZC?=
 =?utf-8?B?ZDhzMVZ3MHEzM0RmdGQydTNNZUs5NzFEMi9TaDJOcTZGM212RWpBR0t5S1dr?=
 =?utf-8?B?Wkp0SXN6VWc1bmxsL3dublBncS9aSzYyVm9rUGhWbTV1L3dkdUNhOGQ2STRj?=
 =?utf-8?B?VHYySy9sZDQrWTlJdUR5b3FCZXJzYlU0MUplV0MzY1hodno0SXdTZ2tTNzVm?=
 =?utf-8?B?T3dZQ2wzcy9DOVg2UEpQMzFlV1VDQ3NETlpuNUVld0tMM3dyUkJJbW9qa0hX?=
 =?utf-8?B?QUVCSUpOa3Z3NXNtdm1FN2JUQkdwcEE2R3R0Sk1GaS9Bc3pYYXdmR3pRM1BJ?=
 =?utf-8?B?SzZiK0cyN1BVWU1UREtYZ2RhR2xDMDBna2YwN0g4VFlGcXhRTDJ2ZldLR3p2?=
 =?utf-8?B?Qk84SlBkYUpFMjRhSTNuYm1EdWV2M1NJRlJPSVpyN2tYcTV6UlFOWHNHcWJG?=
 =?utf-8?B?VHRDcUcrTkR3WUN5eDN5ZG02QW9EL3F2WHFsUG9EMXdKcmNIVVZkcE82dFdN?=
 =?utf-8?B?VXc3NG1GSFFBV2JxcSt3OTk2SFpsVFY2K1NCUTZab2cyRFhIK21zbW15SVdL?=
 =?utf-8?B?Yklpb2JTdzRoKzBWZ05vNCtyRVpWODVFMG10ZU5ZV2MxNDBYTmhaek9lckhh?=
 =?utf-8?B?TUpza2kxL1oyQ1pNa1NyTWxSOEUrVGhyclN5M3dwNllmYzFkVWJ4eTh3aGQ4?=
 =?utf-8?B?YTQvTHBBWVdBMHduSWQzdndqRkZUY2lLNW9GR1BQY3FXalpQYnU2UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ea0177-340f-4e5b-90e9-08decd5bb398
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:04:47.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jK2jmplE5eMvR6lo9IHKMauRRNcx3G8z6gPlE+8VavQOJj4a3Y8GDrMExysFRC6JMxXhsPdsHX/xN8VRjaoGuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6966
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_HAS_CURRENCY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9326-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,gmail.com,ffwll.ch,arm.com,intel.com,linux.dev,linaro.org,samsung.com,redhat.com];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[47];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fujita.tomonori@gmail.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:david.m.ertman@intel.com,m:iweiny@kernel.org,m:leon@kernel.org,m:lenb@kernel.org,m:igor.korotin@linux.dev,m:robh@kernel.org,m:saravanak@kernel.org,m:viresh.kumar@linaro.org,m:m.wilczynski@samsung.com,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pci@vger.kernel.org,m:lin
 ux-acpi@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:fujitatomonori@gmail.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E31F6A1CEC

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
index 0239f89d5f69..84852a2d9ad7 100644
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
+            static TABLE: [::core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
+                unsafe { ::core::mem::transmute_copy($table_name.raw_ids()) };
+        };
     };
 }
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index a7d9b88ae616..55c89ba3a82a 100644
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
index 154919ee1e19..500b5e0ba4ea 100644
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
index 02bd5085f9bc..284042c5969b 100644
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


