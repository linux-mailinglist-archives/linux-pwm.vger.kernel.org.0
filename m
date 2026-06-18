Return-Path: <linux-pwm+bounces-9322-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kk7FBIsmNGrgPwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9322-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:10:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6678A6A1D41
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:10:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=ggSDtMIU;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9322-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9322-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEE0B310FC98
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9F0346E7D;
	Thu, 18 Jun 2026 17:04:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021095.outbound.protection.outlook.com [52.101.100.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC02FDC3C;
	Thu, 18 Jun 2026 17:04:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802293; cv=fail; b=IAHo3F/6qm5299lXO6fwFnTBD6eF9f7GCTQKrOIiz7vPXXZbV3wVkPKm5CePTuj6F+bD+WqFT7C2XiBB4agXChecO0QxlqGtG7yIL7OYUEN7jgFKvVuqboAHwDLjckXexW9WXbuQ3jub92/2d5gwo0S6lF0aiihSGaLP7lgL7U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802293; c=relaxed/simple;
	bh=HhdpyPupZL4/FjKYfaoCdFtZHkH8NnJ1vLSVhYlNxgw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nQmeEY4rgkgZr/6LJLKQvAZuLE+UXXoZaBm43RneMrsORlDwHE8Xya+XLqQQlb/8zPsuaJJA20PaclYgviKvHTAMo/7pxGwQYlX81KhIAjd2k+evPLAM2/4q3mXXgjDoARpCLMoWWDRhFjzJLPq03FbuOzIGLPnjGNucZc6xj+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ggSDtMIU; arc=fail smtp.client-ip=52.101.100.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A64yP6qqouJFFsbsu/rqj+kjz4c8Cx+60+Wce7zYm0l1LwoTLFryhl4PWDrpJ20Hh0Trc52O22eFhHejR0q1xr5uTwnnCRBX2SbjWG7vZXjMFegG3BmjwlY2aAtjjaRoh5N6P0J3wQ0C6NaSXvlCebMaQRhTGO69OcWD2lk1IBbwe4RSv/Ktn9+JqliKb9LoepG94w3Z+6qscPJOoF80os8RiLmq8zgTsVPADOaSg4JLvUftujGY+4NDxyNEv2HENLa57seiKflBvNAIfd2qmO1Dlbnm2JIU62wYl8u1bO5xYWDl732hfvNACMRxBl8Xd/EaCJKyuK4qeeSIakHsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrhhCsAMRIAcU27Y2Tt9C0sSU03E1gIx/ccCWojECQ8=;
 b=fmmR/j1O//Bd79D124UWX4YquV0pspZmgWTXUbTMAEBmX0D9C/khHbtDx7G+ag0Fq2D+2LwU4HdQ+r5k27+WTpaNGZ1g3UIYFNxZjvgMSGAL1THyPaKC7zyIW/EDwWfNHZu1ycWiWylPNaMXLa9OEQxyOj0DVmEjkcp2x7EF19E71i69FqBNMW4k1xo1WTBn4zwiZOljpa/aPGxOlC/hx3Od9+D1HTZKKQMaWb6J3mpklLAMQHP7z+eL4bfNU5ln9wgvfDGnhwI24xumLCkuFSUIOhg7l43qer3/WOTyfrE2aiow9Oc+KuAkLgChBWpiu8r30vpRfS8GJPnlWnZ1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrhhCsAMRIAcU27Y2Tt9C0sSU03E1gIx/ccCWojECQ8=;
 b=ggSDtMIUNa2XUR1ENvZAqS+OzZi6VE910txAMypC/LIMQ/n0CrG9MtE8JxdAPh/sH3nAOYy08neZOZM67zJMUsyP+uLbrCkqMnJWOAWE8mbWcuICYPJeUfGYKGM7SPLnCl97WDOAxb1PeZyrB+KrZ8erMs1WgCxPItw2RYfNOW8=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6966.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 17:04:44 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:04:44 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 18 Jun 2026 18:03:38 +0100
Subject: [PATCH 01/10] rust: driver: remove `IdTable::id`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-id_info-v1-1-96af1e559ef9@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781802282; l=1028;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=HhdpyPupZL4/FjKYfaoCdFtZHkH8NnJ1vLSVhYlNxgw=;
 b=fLS+x7haTJLHkJ3TEljsIXJRahZ+oaX39H9X109OOzIyi/+vx0HoaHqPaRNGtDz4FgvrnTnWn
 q18QVCGIzYbBKRfOzWjAstg0QQvguDgqavxYgBPTXxBegc8eIQH8GUr
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
X-MS-Office365-Filtering-Correlation-Id: bab8f7d2-27a4-4672-6e88-08decd5bb1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|366016|7416014|921020|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WMvAiWDb9lJbixxF4uFgX2FmTa8vY4QtaPcnMQOxXiVYyEXo1m/+sMyVIGO9GxIMNK3eHYrMA+vAfyIzP5HUT2uwpfTidxDDQwpAYTm81CKPPMZCJBm9AcZs6NEB3aIW7SGfTzE5+U4ky4QREP++/rIZSuYMmUgd6qNRe7jp1nlxmaIx6vAYQueg//Yuduz4iuq+1bN4+r1qNFbFFLJs7amBrTKnou/PpnN9esiaXdYl8QCPeFaR2laH//s1ttL1j/QWvmZXcQ9ujYw/UpAhwdlSd+b/fR8YLJM8m0e9PZYEVxx0Yv9K2NreIMC6NSe94/TEt/l/NsEmt1ANSngHeXVSBY8jxQw/kIT17TujgYLrRkla/HrTlzOz+o1IiwooVL9p1GbI73pDs54gZC1kgfG2wrBHNyUCaekDXJArn8I41WCruF3htTGDPteFcjriahMGz3iOKB9Ok5K7254iba8dxBBNJ0plLt418KQCk6XILFYewXCkbLscEApbRFG9+iwEMrIbCyN0ZH3doClkvAKaxBNtfJiBeK4P41+hvlhVJPkAFd4hygSPD8Y7HUkrh7htqlEe6BLFBEITGYDzzNSg6pOiV6X4OQYe6vPhaU6oPm14qdb+dp9GVQbSLWeLqPBmO/mKPosZsgYdGML8DTZaCr/PIJAqpKZ3mQUE3LgJQPAYzkSTOiAHCjzBZPt/cqLQQ+2jZycO+VwRIgbJrFqjVsYr+aSTzwQ6A46G6hM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(7416014)(921020)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGE3S2ZXQVg5WnVlVkNTMWs2N090R3M0d21VcmozUjhrVG13N3UySWdUb1JF?=
 =?utf-8?B?K3VNWStiN1d0RjlLVEgwUHV2T3I1amFkZER3UjZKbEl3azhQU213UmRNYzM5?=
 =?utf-8?B?enV0R1lKZ1lQNW5vWjdCZHlCOGRUTm9zbEF4SVdraS9YY1NPMFROVlZaNWpI?=
 =?utf-8?B?RnpzSk9FbzEvb0tVNlcxTUJvT3NTd04xdlpwbVJkdjRqQ1ZJUEdvK3FocU5W?=
 =?utf-8?B?UWpjcWMvczB2R0lINUpQbGRCamFGSU1tT2RjYWRlKzkzSUFHYkhIUFdkQ1Ny?=
 =?utf-8?B?Qlp1d2syaTZnMDNMaUNwSEg3M2FJWVJBSnEvNXNvOGlTV3ZqeVZGSEpHYlB3?=
 =?utf-8?B?QzVOMHpQN2NDclhEaDBiTGlBQTdObVl5NjVROUl0YS8xbm5LMGdLRWJaNzFw?=
 =?utf-8?B?Z0d5Q3VWSHZiOE5tekRBTTBwajQzSHVISHN3UDY4b3VmcUZPYkg2WnBXSkZD?=
 =?utf-8?B?UzlFK2dyaGRqcm9ZcERid1ZaUnZRenU3ZktLNitLOGsxZ09vZU5KVEJGNnhD?=
 =?utf-8?B?YjZLUmxnRTFyMUhUemppMTNIb3kyZWI1QjdxOFl6dGJGajVzWXlUYXphS1BT?=
 =?utf-8?B?dU5SQzhiR05Rdk5OMDhQa1pKMERzYVp6RHRCUHdhL2s4ZE9uZ2NQenoxczFn?=
 =?utf-8?B?aFBZbnlEc2RjeElGdVZkSUt4MVgrdzhNUWhXbjVGdXNxd0FFZFplWURpaWh6?=
 =?utf-8?B?Si9pQm41N1ZDOW5jeWVRMFo4RGswbmpTMHBIbGZTZVgrczlROU5wM0pKTGZW?=
 =?utf-8?B?UFJGcEszeDJodEFnTEIrSVlHU2xaSHJOK01yNHM4NWVzOXV3d0VoeXRUUnlT?=
 =?utf-8?B?Ry92T1JKd2R1V0JzR0c3Y1J2ZjVVRG5pZWsrS0xRa3o3MDJhTWIvTTA0bkNa?=
 =?utf-8?B?RFVUSEJnbndQWHgrMWRhei9NSzZPSS9QUDA4aTl1YmpCSlcrRHFQeFhCRThJ?=
 =?utf-8?B?WitzaVhBUktPNkpxYXBDKzhFdXZua0FFaUV0WG9JbmU5ai9CM0VFOTRydldB?=
 =?utf-8?B?SURLTEN4ZGtid2JnNG1jbDYwenFveEpQZWhiN204c3c1cjZBa1RrSGtsdDZY?=
 =?utf-8?B?NWpkN3Nsd0RycjJrbllCUUR5dlNjRW9tMEpSUmpQd2NNRXdGRFF6NzZiSHAw?=
 =?utf-8?B?bytvSlhwY0s3Q3ZKMktRQTFxTFd1dTQxSlM5T3prZ2NkR0ZaU3FJV0lNM0x1?=
 =?utf-8?B?d0ozRkt5YnlVNzFTSkRLRlJJU2Z0VWxKeUg0eVpOMHJjbTF5bS9uZFJ2MFdh?=
 =?utf-8?B?cmRhY3dwNnd4VFZjZXFMdEdMbkFYLzlmR0hxQ3lsd1NTRUpDNm5rTmtkbTBs?=
 =?utf-8?B?MktwUzV3TUMvZkQxcHhsUStuWlJEZ3lwQW05bGVCRHUxc0h3UmlIU3Ewd0M3?=
 =?utf-8?B?M3J0RzJydEtoNEZaSlRIMnpHOE1EbzdMNjRxVkt0SzNDVlhGcHhwYmpZVEVW?=
 =?utf-8?B?NDZEU21haXRvd2YyS09tcGFLczhqQUdtUjZYaEt4STB2K1I2bVlKamk0c3Vx?=
 =?utf-8?B?UHpza2VFeVhOZExyMmNab1RQeFc4aVdQaEN5cDNFRXBpUmgwWWswQ3hXaHBW?=
 =?utf-8?B?cU5UZkZjdXhKQjFNUmIycjViNXhaVGdiWE91eUd5a3VtSjREYWVyQmsrNXd2?=
 =?utf-8?B?VytnajhsTGJEbnc1S3FmanBnbXJnZmo1dVE2K0JwTkVmZ0UyVUViVGpHVXlu?=
 =?utf-8?B?MlgwYm5Md0VqTXZpbWt3dnpCVFRiUXpUbndTQkNyUTF1RnRaREZIYnNKSXY3?=
 =?utf-8?B?STJpUExFdzhRNElkZW5yQTZNRmNPei9veVIrYXh2cGVkVXZMMjRIMWoyeDNN?=
 =?utf-8?B?OUJUTG1rbkM3SU5kUTVqMzdmb3BSRXYybkNKa3NvTCt3cDl0OElJVWNnN3JP?=
 =?utf-8?B?K2Q4TkQ3SjAzcGdWS3E2dFE1Y09WbVNwdFdrbnRJdlJUdnRPWVl6OGJ0S2gr?=
 =?utf-8?B?c21USXErQTVsNlVZUHNWVWpQRGl6bHFGdU5DaU44K1czOUp6TW5WVlRqNzhx?=
 =?utf-8?B?Q2JiUDQvQytiY0tUbHRnWDk3T1l0K0hhU0FrU25DdTFVTGZSQVNZd1c2WC8r?=
 =?utf-8?B?UlJXZEthNjBYZ0QzL2UwRlNTY3ZEbVFXYk44cmFZMEFlRTZhWVN3UnFjWmZH?=
 =?utf-8?B?Wk5yanllcDJiOVQ3QTNSSnJWaEVjL05XZHA4SlRYT3hSSXFCcXJVMjV2M1Vp?=
 =?utf-8?B?dU5JVVQyZGhSZmNPR1hVY1pxNGxIczV3NitLWll4V0lUOVZScHZhR2NoOHVi?=
 =?utf-8?B?N0ErUVEySGt4bjNiNlJzeFYydmlBTG4xRTlaNEdoS1puNU0reUw0MmR5dE5O?=
 =?utf-8?B?Vnc4K0taRWIyYmFkbmZVRlVtUmxPNENDMWY5YjE1UXZyYmxlK05hZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bab8f7d2-27a4-4672-6e88-08decd5bb1c2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:04:44.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYNpUYWvorH4R5O7v1e/MGSZVXiLNqXUH+QLht6xJT4CMDj4R7NjR2Kxnm41IC+PA4mpNs3S+xVwnFYh1ZmIUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6966
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
	TAGGED_FROM(0.00)[bounces-9322-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,gmail.com,ffwll.ch,arm.com,intel.com,linux.dev,linaro.org,samsung.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fujita.tomonori@gmail.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:david.m.ertman@intel.com,m:iweiny@kernel.org,m:leon@kernel.org,m:lenb@kernel.org,m:igor.korotin@linux.dev,m:robh@kernel.org,m:saravanak@kernel.org,m:viresh.kumar@linaro.org,m:m.wilczynski@samsung.com,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pci@vger.kernel.org,m:lin
 ux-acpi@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:fujitatomonori@gmail.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6678A6A1D41

This is unused.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/device_id.rs | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 8e9721446014..fbf6d8e6afb9 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -166,9 +166,6 @@ pub trait IdTable<T: RawDeviceId, U> {
     /// Obtain the pointer to the ID table.
     fn as_ptr(&self) -> *const T::RawType;
 
-    /// Obtain the pointer to the bus specific device ID from an index.
-    fn id(&self, index: usize) -> &T::RawType;
-
     /// Obtain the pointer to the driver-specific information from an index.
     fn info(&self, index: usize) -> &U;
 }
@@ -180,10 +177,6 @@ fn as_ptr(&self) -> *const T::RawType {
         core::ptr::from_ref(self).cast()
     }
 
-    fn id(&self, index: usize) -> &T::RawType {
-        &self.raw_ids.ids[index]
-    }
-
     fn info(&self, index: usize) -> &U {
         &self.id_infos[index]
     }

-- 
2.54.0


