Return-Path: <linux-pwm+bounces-9506-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ug5iLPPqRGp73AoAu9opvQ
	(envelope-from <linux-pwm+bounces-9506-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 12:24:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2668F6EC1E0
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 12:24:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9506-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9506-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C2E7301105F
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A248040960A;
	Wed,  1 Jul 2026 10:18:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2130.outbound.protection.partner.outlook.cn [139.219.17.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF93F39F1;
	Wed,  1 Jul 2026 10:18:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901099; cv=fail; b=UlNibfM0Kbhgpb42h0kxZqf3Zg+oIBOeoJgioonyA1jMI/A/GbY596H9PTFbUpXzYp2j2LixXzrZOY/CU4kMqA1jQ8voVfwwKXaCh3wQQ/SEYeBJCSu4J321544sJslEoXAJCli1BIJTdA4wcDl7TyqbabbC668y7Q5J9E6fVx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901099; c=relaxed/simple;
	bh=mW3Obbi7ZNnF8KGepPlAyepjebbbRirAs1zV0C8olkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MtEwLdcvt7tGsIpGeTP9ekR11jnDxdXf1c6HOykwPF6mbvNTKCGPjxE4t5Wdmfb+ToLMyNswTxoR/9xkaKuRByi7MtY2OC7X7go0ULol8TRfljcj+1UFU7YwM1PVKUdzaMmPJ8EEKM4k0ukilRhg2s4rSJtp1fvHAJmW3Tb0Yj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.130
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8KmHrXdxJDhZn8VJfRcLx1fkz7q+Y8p1LlCi5HDjvnIwM0ifSbKe/P/0n/SYI2De8iMnIf6kUzyRMFNDv++s3PrBQrQq3p8wD8J521c8kFTxD5p9c8nr70MC+2EK9ArZHuebVEw9JhJ51DrG5fmtTDPIJ83BgF2epW5u6LapECzPWAh5sF/IIqtj9xYGkeEqb9LifDFnovIQkrK05AYzjkjmd3cqfFmGniWiSFJ1J+s+X9ddHBFqnzCEcIdBAEZ4vh8svdL8PQ5AUPxNGXl2A3Ojg0ThWiurGtoIkhXKfI4U+VuTrh7Y5gpa/oZVZqDIgh4Le7hZ3ym3Gh0196wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YD3IboAnPkUzVxwkee6yCSeA50vzochcqZ48GkMsiXM=;
 b=UdE286QVwDPVfMqBNSYx6KTow1qYeu0pcCI00WqEkQ6FApQsx4KHVxvVKiBa6huVwo2RPAIbUsanctNaI4CaE0a+QFTCgNq3a7kZ4cCisvN1j1wHMbVZ/xxjFNGhGZ2o6vmcQ+hoJKONQwispQT3SXF8ptWKpgBHrVcvzCIB7NDFoZtGAENIEmmK5YOyDWo6xFvqxP2XEMrlF0oadzo0xrbCTYO/RXLiZTnFMVAuMFtsgUvjQXGbW6/QdipOIGHnQrr/2s8wH41B9xdPoj5/dRIBVySHPwV8BmZC1H+4rjRDA39exsIznJavIZ/NPNWIxciYJsFE0dEuSWV32TNZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.25; Wed, 1 Jul
 2026 07:44:51 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0139.024; Wed, 1 Jul 2026 07:44:51 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v21 2/3] riscv: dts: starfive: Correct pwm nodes
Date: Wed,  1 Jul 2026 15:44:41 +0800
Message-ID: <20260701074442.7714-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260701074442.7714-1-hal.feng@starfivetech.com>
References: <20260701074442.7714-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0026.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::35) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_
X-MS-Office365-Filtering-Correlation-Id: e65d4a2b-e9de-4893-87bf-08ded744a269
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|23010399003|7416014|376014|1800799024|38350700014|22082099003|3023799007|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	DySRaVqSibSSp5qgdmXcYgTZcVfutVMl9D++ZYA769jQg4VeSXilQgpVwT2bbCsHGwif+4emmX8ltwOOvQECC3DphyLLQa379VKITiKc0tktJQumRlGLIJifE8eeYjDiiYbCWFDKlUfDQD9gR01v9inWOSrGGcCgYaDaQTrV3g39caKcT3G3nlqDrBomfRk5TEULNhXh2bboLjqGCN4K6fFnlmLRVJz9OTm3Isc4qPtdaWQpYYmb7qT66sv1kZTZCnBgbxJlGPSScgv7n5f9F4zolfJLxUjql6pCCqQpZX3mqU9UmVrFv+OFqqypKmHl+rHwohHIj065HrdAEgJwaGXk1/YrwgeNLY/PpTSpThGrQ4PlbfRftsJ4NonamWhLjgV8TMPeeiVyhnhP3O9Db/RHoHZkFxexRZbMR4Eo5NAgM+qRmd+UbmYUo4HlXR9EKEUG0RRt5nSj2dmKbvnxmVmosBA/1rNPxVgAzHoLUJNUxhF7MIgxbZ9g2Nm+09oydhasaYPhdhJAEUWqzsq1tBkiXtEoaLtz/OPXRaVDQGZgp4Ms0nqfmmpLCLBmBFqP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(23010399003)(7416014)(376014)(1800799024)(38350700014)(22082099003)(3023799007)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6BxyvOClpzBhRw50JQ0ObiuybdkPqQ6WNEjncetJokWRI6BXX5bF8J3JR4CQ?=
 =?us-ascii?Q?Xmkm7XsLPvZmKOKi4rNuikaMGzURt7IwG/8OHKOP9zVqogLeci9VW/NiF9zb?=
 =?us-ascii?Q?37xDt1LXNqddpcEu5ueCXkOjNDKWlN8iWqTGwqnLdezM6+kQEd1beMXNMsjs?=
 =?us-ascii?Q?GnPSMfeXVG+ZMdm2RPAgdFJlBuBY8U03ZSKWpL3VMk2fGCVqt4EtYKlyC9ON?=
 =?us-ascii?Q?VkAUbUXJo6y1dxRPtDQewKJ4/BkKJwmpy/yHzR0Pdyvm1Sy/SyaV8EcOM0sr?=
 =?us-ascii?Q?ZyE9w4iW6gik+fFq7ftPSi1F2FASlKutyucLgn89AsiGYB+I9l1WNxzCtb4c?=
 =?us-ascii?Q?Zuf47skDI/g2GTkOe3C/2YLduFIq/79tID+7YrGrvq91Jbob+YEsjZstJz0h?=
 =?us-ascii?Q?1PjMAfLPLc3K9hvmaw5F57ezlT9Zs45CBiVzT42DYpQZHqU1+IymhBmBd9hw?=
 =?us-ascii?Q?qp3Xd76fJco9d7fxoQMreIGxHVQ+ce19o9li+bm4sMNhm5Hkasyy4QRaziHb?=
 =?us-ascii?Q?8W2ef4bcnswzLA1AbD1hvnd/kkmUsdof5itowKFdPeEmTLLPwm2n0etHmUpK?=
 =?us-ascii?Q?g3dhOWFlx0wxoj2KwsfNMcIRyJjVzpckBJSOkpKk1u1aA9+0DuOd3VMqencL?=
 =?us-ascii?Q?w1ULOh2gSNLTfGIT62AwBfZ/vqnViB3Lcl4nWCvIn3132bg5Hl5r/NYGGMAu?=
 =?us-ascii?Q?LviVSde4IXgdmlgTuU5NZdQyIsGLWjZjleNSjR9oRQEIPxkj9LzFfO0vK95H?=
 =?us-ascii?Q?ZRz4sZ31SgFvEwY+c+iKEXumK1nzmDd8BLZuPXN/HQug6R9C9cggs3tLzOJ+?=
 =?us-ascii?Q?taLnq/dhUSsmBiIhY0DHnIe3xkg0rEq9NaE8EXfOVA17Xeu8MYYlFD5zt7iG?=
 =?us-ascii?Q?l4Zi+r/IgrXYmLtZ1JvwIwUn29mlOEakCRBw4m/hPHadYCRFI/AJIY3tqnb1?=
 =?us-ascii?Q?qSR8Cqg3/TRWOHlSO5lr6Jcxb/KwyQAJKg+Zx5/gXNGjtewgusqWmvcsnOHs?=
 =?us-ascii?Q?BxcR5w437CAqVQdmhjIW6AS6XXOYgtv+sYJuWgywekJEgHG2qkYnQuFIiKUe?=
 =?us-ascii?Q?d0BLHSMa7mF2ptUFkk6hRyHgjm0GCfCx784NDIq/Twh9mpZ6RpTYV1ymsSg0?=
 =?us-ascii?Q?EFlDzPT69XsPkLZ+2bvZIPIPv7B/0cm8bLPCCvWFJ/ku1eTV2clKhCB+Xr6u?=
 =?us-ascii?Q?nmY8O5foW5jKMmgrbS6qM1/vguCZLOH6O0ggoWokIXJL1rpCq8dBbQQynXOv?=
 =?us-ascii?Q?Ly+8xoshnQJA3Fp/1z1nFG2bRCin5plng181hSx9foGy4Rd5SddmKlRuyXe7?=
 =?us-ascii?Q?RtEetRl/uC2IpgzzUozZSRlLXKb27BtGlcAKxaxjfhIkVY1bKnSgf7YB436+?=
 =?us-ascii?Q?XS0wdigJX+0bmVU5vRqDWW8X7KL1HncXG3H1w4og55EKWj+TCI27WSASKR0P?=
 =?us-ascii?Q?vn7m4ZyyI71KaqAfFxHKHEmJTTB3JrE5lyGVVY5MjMG+vjbCVvINMthV/RuF?=
 =?us-ascii?Q?7tcBesb3bIPBKryiDiVqg+eHssBQr5uMae00mUV8MqgjaswMOfD3cnuHNhrj?=
 =?us-ascii?Q?2Xt+DtgIq5EOnGiqP6Xo+QXLNk85WlGcFjGC/AmZsNvXMQUNc3c+pkHeBaz9?=
 =?us-ascii?Q?VwX6h65k3xoAIkRmTwZnt+dSvp+okLkh4nIhqcIAXAPgAsF3XcZovxSJRaxb?=
 =?us-ascii?Q?KrqF0o3723zOv36qPUwlOAwVoZOlZqB/ujo7uwN9O2LUwVGjImMj11WlmzFX?=
 =?us-ascii?Q?95EpE0wc7leD7fEQojfrvc9nqElbLFk=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65d4a2b-e9de-4893-87bf-08ded744a269
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:44:51.6767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytXJziuq8qsB1kb9pY6D71o52rKNjErjup6SrfSJCKRIxxylQKYbrJe/mc/ercPWlVqRDe6h+sNtI2Z7A7+FlnSrIQujoZq07MXvUGKryA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1307
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:p.zabel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor@kernel.org,m:emil.renner.berthing@canonical.com,m:palmer@dabbelt.com,m:pjw@kernel.org,m:aou@eecs.berkeley.edu,m:hal.feng@starfivetech.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9506-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,starfivetech.com:email,starfivetech.com:mid,starfivetech.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2668F6EC1E0

Each of the StarFive JH7100/JH7110 SoCs has 8 OpenCores PTC IP
cores. One OpenCores PTC IP core can output one PWM channel.
Change the register size to 0x10, since an OpenCores PTC IP
has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.

Fixes: 8d01f741a046 ("riscv: dts: starfive: jh7110: Add PWM node and pins configuration")
Fixes: 5e598b99fedf ("riscv: dts: starfive: jh7100: Add PWM node and pins configuration")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../boot/dts/starfive/jh7100-common.dtsi      | 28 ++++++--
 arch/riscv/boot/dts/starfive/jh7100.dtsi      | 67 ++++++++++++++++++-
 .../boot/dts/starfive/jh7110-common.dtsi      | 27 ++++++--
 .../boot/dts/starfive/jh7110-milkv-mars.dts   |  6 +-
 .../dts/starfive/jh7110-milkv-marscm.dtsi     |  6 +-
 .../dts/starfive/jh7110-pine64-star64.dts     |  6 +-
 .../jh7110-starfive-visionfive-2-lite.dtsi    |  6 +-
 .../jh7110-starfive-visionfive-2.dtsi         |  6 +-
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 67 ++++++++++++++++++-
 9 files changed, 198 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
index ae1a6aeb0aea..85106545090e 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
@@ -199,13 +199,23 @@ GPO_I2C2_PAD_SDA_OEN,
 		};
 	};
 
-	pwm_pins: pwm-0 {
-		pwm-pins {
+	pwm0_pins: pwm0-0 {
+		pwm0-pins {
 			pinmux = <GPIOMUX(7,
 				  GPO_PWM_PAD_OUT_BIT0,
 				  GPO_PWM_PAD_OE_N_BIT0,
-				  GPI_NONE)>,
-				 <GPIOMUX(5,
+				  GPI_NONE)>;
+			bias-disable;
+			drive-strength = <35>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm1_pins: pwm1-0 {
+		pwm1-pins {
+			pinmux =  <GPIOMUX(5,
 				  GPO_PWM_PAD_OUT_BIT1,
 				  GPO_PWM_PAD_OE_N_BIT1,
 				  GPI_NONE)>;
@@ -359,9 +369,15 @@ &osc_aud {
 	clock-frequency = <27000000>;
 };
 
-&pwm {
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins>;
+	status = "okay";
+};
+
+&pwm1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm_pins>;
+	pinctrl-0 = <&pwm1_pins>;
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index 7de0732b8eab..90438df1f74d 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -360,9 +360,72 @@ watchdog@12480000 {
 				 <&rstgen JH7100_RSTN_WDT>;
 		};
 
-		pwm: pwm@12490000 {
+		pwm0: pwm@12490000 {
 			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
-			reg = <0x0 0x12490000 0x0 0x10000>;
+			reg = <0x0 0x12490000 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@12490010 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12490010 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@12490020 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12490020 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@12490030 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12490030 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@12498000 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12498000 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@12498010 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12498010 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@12498020 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12498020 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@12498030 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12498030 0x0 0x10>;
 			clocks = <&clkgen JH7100_CLK_PWM_APB>;
 			resets = <&rstgen JH7100_RSTN_PWM_APB>;
 			#pwm-cells = <3>;
diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index a7a1c09a2c90..64de468f2c31 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -326,9 +326,14 @@ uboot@100000 {
 	};
 };
 
-&pwm {
+&pwm0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm_pins>;
+	pinctrl-0 = <&pwm0_pins>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm1_pins>;
 };
 
 &spi0 {
@@ -528,12 +533,22 @@ GPOEN_ENABLE,
 		};
 	};
 
-	pwm_pins: pwm-0 {
-		pwm-pins {
+	pwm0_pins: pwm0-0 {
+		pwm0-pins {
 			pinmux = <GPIOMUX(46, GPOUT_SYS_PWM_CHANNEL0,
 					      GPOEN_SYS_PWM0_CHANNEL0,
-					      GPI_NONE)>,
-				 <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm1_pins: pwm1-0 {
+		pwm1-pins {
+			pinmux = <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
 					      GPOEN_SYS_PWM0_CHANNEL1,
 					      GPI_NONE)>;
 			bias-disable;
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
index 21873612d993..54013c70f4b4 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -68,7 +68,11 @@ &phy0 {
 	motorcomm,tx-clk-adj-enabled;
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
index 025471061d43..31afac27b86d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
@@ -87,7 +87,11 @@ &phy0 {
 	motorcomm,tx-clk-adj-enabled;
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
index aec7ae3d1f5b..a9e82f25efde 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
@@ -95,7 +95,11 @@ &phy1 {
 	motorcomm,tx-clk-100-inverted;
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
index f8797a666dbf..85b56a72dff7 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
@@ -74,7 +74,11 @@ &phy0 {
 	tx-internal-delay-ps = <1500>;
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index edc8f4588133..35208f95cd3d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -73,7 +73,11 @@ &pcie1 {
 	status = "okay";
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 9c3e4598747e..82ea63f715b0 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -846,9 +846,72 @@ i2stx1: i2s@120c0000 {
 			status = "disabled";
 		};
 
-		pwm: pwm@120d0000 {
+		pwm0: pwm@120d0000 {
 			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
-			reg = <0x0 0x120d0000 0x0 0x10000>;
+			reg = <0x0 0x120d0000 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@120d0010 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d0010 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@120d0020 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d0020 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@120d0030 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d0030 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@120d8000 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d8000 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@120d8010 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d8010 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@120d8020 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d8020 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@120d8030 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d8030 0x0 0x10>;
 			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
 			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
 			#pwm-cells = <3>;
-- 
2.43.2


