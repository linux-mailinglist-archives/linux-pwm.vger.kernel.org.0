Return-Path: <linux-pwm+bounces-9505-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yAF7EfDMRGpx1AoAu9opvQ
	(envelope-from <linux-pwm+bounces-9505-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 10:16:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF856EB02A
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 10:16:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9505-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9505-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A48F3031E95
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 08:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FD43C942B;
	Wed,  1 Jul 2026 08:00:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2107.outbound.protection.partner.outlook.cn [139.219.17.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFAD35201E;
	Wed,  1 Jul 2026 08:00:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892843; cv=fail; b=O7LEv1+lHE5iTzcJ/6qtfa/9omL1dYHlXF/LWZhWs1FOUhdwQ2GpIrd5kgBQ+xlzBvKBObNtSwXr4i8YFYi+90LQVB+DO28zgUKJEnDnXM9lAcfuRg7OoEZrj940mwv3rYTPdxAPNuMFXFdjb2M7z7aQB7DOyb2uO5ocHR4LkMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892843; c=relaxed/simple;
	bh=DUMMWRHUHKoPiOMqzBvOGQ7WN1t90KmvfDrs8x7fccs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bv5m60R5xqhOHBo9JeQh1v1tIK4jNtbXqc2PJN53wAX4cYbqVk/zoQY3ns3n+VM0bWkBzQDFdGLEqwpCmjqC0/uP0Xcq3jiQZXAsQmdW5FRk2lIQNgoDuxhgf7ZAhTbAtHxiuZyx5cKRcCuU18AaXVyQ+BBykzndEz6uOQTh1dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.107
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEqqlUD9Nyjebt29eQfwJaDe9QUBTmsAx3tEmqwiA8cAngoVVwysQcXapwflxyZIfr1grXdOZNId57urjPti67M3iXjzh+Ew4tfJuz3T4TTM7mfs9MEkZ/9nVnPnFiK/Kcrkq5UlF5ScXy2gpJpM+VD7htVoITJD07Cm9X7mY+yLcRl/jnceq2sXlT8xCwvz2/ktKO0WHABd3XZCUdLu0qdQ8p09+aJV4D01FivLGAjuQ9g0SLUvJJrfzNc8oWyCYpRCahu9mbk5UPC36hkgJ7OsvhS17L7TfyJfBpGgX2+2DefA3csuzJHU0Z5RV+nfHLSOt8UCla2wJzz47eXFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyuqZf2/SD1UwxL7gwvQ3fUQqv1MpDXSpbv8Q18P+Ws=;
 b=aY8iXF2GRompb2gYuvsB7yQXNWmCdqw5NC+eKpCTIel/gH5DCxttvja8HABc6ZPMkGdxyai+MXDjK6Bh5nFix3ZQAyZRbQxAWPAhtqwDh/L0ADvFAK4wlkTurjNe9kK8osyc5dS2DbbBM72BakdaL/5l04jxGH9UGEFrr3YhyxTRuJlX2qA7GuRtlQ5Ah3rLOpkXHsIZUnZzjEFkV0x8GINkh1XUdd38BxDOKwRNwYrtZSqd1U5CLVefm/gF9r3eSxBysfmj7pUMnFCD0GH7fXxYOxezC0Cxr03bU+sEyuXEhfJTNIyHjgBJvyMiCUOoCp4D9IZDO/Pc5av8tUZoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.25; Wed, 1 Jul
 2026 07:44:49 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0139.024; Wed, 1 Jul 2026 07:44:49 +0000
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
Subject: [PATCH v21 0/3] Add OpenCores PTC PWM support
Date: Wed,  1 Jul 2026 15:44:39 +0800
Message-ID: <20260701074442.7714-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-Office365-Filtering-Correlation-Id: e0be8a65-b111-436d-265d-08ded744a117
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|23010399003|7416014|376014|1800799024|38350700014|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	N6uXyqZgqL6ciBSOF52N8z46vLzHuaYXiDiiS2MuFfwjCCYv+9zagZX3UN/XM0welGwEDw9bltNjL0BM8QNWRjTsthKGo/YWLQhatn6gMrlt4dzhibeCPaZxPDxRIyMZc2YvD6EE9/aW/hj27LKYL+k1HmcMxO/6126EPTcdo/WNALJ+HihdRC/HtRvm6nfBjy1vf2bL2iCb5QzHqu6k1Vsm3vk1TvkZHbBChRnYjESWadQgKyvPkiSXgcshmQTKHArXkxXtqs5tg+99jBDb5WDvHk3MzTWZIqaBuLgta2AOeehx7dG3ees9Kv24HPT9BNbHVk0kLfFw/bbAwBbjNUZxFo3r/erkJKGuZmfG8P7o4w3AJ8mW0O8KyMSMoE7S8nSBLc6zAxPWqJz/qlbhaR8xhdYmUSQndL8/scwHi1XR6x4jfzu6MK4l623U2Au+WDTsnDksOAcYHFFKw5ZSzaHlZ57ZUTJKTH53IV5r+WJvrNClr1NIrocx5Jz2D0yJZRIqNxCmXLRNKrZtJIJIcKIGmzzkRq6vD0+w2s4V7aChskOutGsaRb7tLajuJuMU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(23010399003)(7416014)(376014)(1800799024)(38350700014)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/8KDzqoKCBkpSZ6Xj8Wr427j469d94yZuZ6N5adZcnRpaEwx/9V94gxVX5S+?=
 =?us-ascii?Q?xBrJjSTQtGIkGt17aBk38rVAYREM8GNLaUmLcZDdWL2GYVX2HGfm61kAKWQM?=
 =?us-ascii?Q?Xt8P1UF8opDj5zCuyO5w/M7HxSQPnsArqZ/ns9ju2GG+UrAtG5tSXLhbBfAK?=
 =?us-ascii?Q?i7jfRIgchR3v/fYdGJYsC7rU4AiuneiA+Lbb3EMoe1htu7cp8MP07TNaYRWK?=
 =?us-ascii?Q?cWhLuUyu3qhp3MtL3rUOeKKfKXf7WgHQAiMeMzwhTHJHc36M2EAD3igFjwoh?=
 =?us-ascii?Q?rKY1x1/FdjrGOIVTS5nsNitSJ6Ec5O4x9xX+2QxUkIo/FFuMIzEGVr4nRTIF?=
 =?us-ascii?Q?RNqhUipeDveLlskYeh04t9GoiTMkghI8MU338LrLGfv73ongaLJ6zldCiwbm?=
 =?us-ascii?Q?omt35MMWMzO8vKafQ4iUpB1W9O1N7sr8Dmqd8poFnVIef+epxsBn6YpFk7YS?=
 =?us-ascii?Q?qrEFlNbzCBV1xWJqnXvBJuYVGs3ZGJgF9S1wrpEr1otFa8xY8Cpt4dRkpP1h?=
 =?us-ascii?Q?xiQUFBxKwWXMdx6gu4rAAPT4my0kVBUP39FDU2xDyWc8FCp+34g1x8lOdyBn?=
 =?us-ascii?Q?9ZSbBEwREujBtHShzgy+V/MK3nffRuVr24eTCOSO0+3X+kUWg4eDimTpv6hQ?=
 =?us-ascii?Q?p2VWQ1MqCbwHyBAMMJ0bq2wgt/fXRihc6ER5GQI01Fd55Eu+mrhICX3r2vb0?=
 =?us-ascii?Q?OYch9CP/2t6rtOuOr+o0/ikqqFOWNQ0nx+S7uvJS8TruJ+jyyRwO8b8PaWtZ?=
 =?us-ascii?Q?AluqKw8aR1dUy46b044Mj9w0ADkY4+UTHVWdCMMyj8n+EIS3xc3qhblR1uY8?=
 =?us-ascii?Q?O0B1cQ6EZ19QB/a7WcdnsDFjwDSiFW5VLPc3uLNL5jNQaqEEmo+GhM7jqaVG?=
 =?us-ascii?Q?DXN3veys6Lin++Lb0LczR2FCs2/l++CZ4jJAjnx/SlDyRKv7yi14Eq7tvAAH?=
 =?us-ascii?Q?2FOCWroxFWaazYBli3jnG2SnLXX7t/vtiDVQhYyT/Imu5lws86mEGGrEkUMv?=
 =?us-ascii?Q?JlWcYKbg1nmeLVDDBYqkblqc7LSUDq8ClLnk2M48vz+2/y2tH/U2ZqJKOcHp?=
 =?us-ascii?Q?L7ENT0oQ+vf0C5DwE0GUp3YsEYZiEPDgguX1+7Nhtl3DJCZacxT7cj7RPduN?=
 =?us-ascii?Q?MeZEEuaWhKrXjVwcj6Rvsbg5O3CB59p3IpYL/HzP6jL2qSzPdxeWj6pZ/Hix?=
 =?us-ascii?Q?gNdCYNTJX69nVN1osqXMogRLO28R4AHc+op+AQdxgK/nAdAUvhTdVdrvnpGF?=
 =?us-ascii?Q?tFIV4d2VOHO3nf975JmDaz5lVJDrtQUMt9d8j7f10NluhobVLtG6y1wbDpay?=
 =?us-ascii?Q?aZzNAfCSpM1qzJRGjFGSPh1zwHOSjn0v3mInvtL1g6F5ix2tN5cEuU+WkTbV?=
 =?us-ascii?Q?VcWoEGjXW45PT0wu56u2XKcWPpyVqqSqiOUPg55sci23RMyYOUAYqHsYZYk9?=
 =?us-ascii?Q?THZMqmC8ZFk1TOPxQC0FB6MYNqm3+S4po7Vh9TonnsUbtDODz7KJ+LOvxIhu?=
 =?us-ascii?Q?NLUUyu6N8mjUClhEJdilPD9Cfk1ovw4wXMszgonIcshCGhh7gj0RPNK54uOX?=
 =?us-ascii?Q?6Z1AeisTL5wsKL8+rm33sYNSS8qv4avxM54hzB2mhXfaD5g7V+auOCikjBrB?=
 =?us-ascii?Q?DO92YE45sdHWY8VVGeRAUQK0u4ctkfZZmB8c6GJgfjDFHPghyU9vAKfZBO92?=
 =?us-ascii?Q?X2edwYn299HQVtDWLGWadnEhQsLGv7i5c2WNCsXQqZmBHA3jiFnT6SfrR0SX?=
 =?us-ascii?Q?+lE+ZeFrMCORiaiIK4J+gILcVCESX6c=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0be8a65-b111-436d-265d-08ded744a117
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:44:49.4790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6H3pcwVneEV2+CcKGrI6uhwmZ1XTPZESOCYqio6tJLT7dDWGPHHWBbwoVSyAUz9Ctjcg6Gv+Xltf2xItc17zcbBDchB9ae5bjRFXXW+D5eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1307
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-9505-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,starfivetech.com:mid,starfivetech.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEF856EB02A

Add OpenCores PTC PWM driver which is used in StarFive
JH7100/JH7110/JHB100 SoC.

I will maintain this pwm module in place of William.

Changes since v20:
- Fix 0% duty cycle support.

Changes since v19:
- Drop the oneOf construct in dt-bindings.
- Address Sashiko AI review comments for the OpenCores PWM driver.
  In ocores_pwm_apply(), handling disable requests first, then calculating
  and validating period/duty for enable requests before taking a runtime
  PM reference or touching the hardware registers.

Changes since v18:
- Address Sashiko AI review comments for the OpenCores PWM driver.
- Fix runtime PM usage count handling on probe, error paths, PWM release
  and driver teardown.
- Reject period or duty cycle values below the hardware minimum.
- Restore PWM registers across system sleep resume.
- Return the real error from devm_pwmchip_alloc().
- Preserve bootloader-configured PWM state during probe and keep runtime
  PM active if the PWM is already enabled.
- Use synchronous runtime PM put before possible teardown.

Changes since v17:
- Simplify the code. Make it more readable.
- Restructure the driver to register the pwm chip for one pwm channel,
  because each OpenCores PTC IP core only supports one PWM channel.
  Drop starfive compatibles.
  Add patches to fix the dt-bindings and device tree.
- Support runtime pm and system sleep pm.
- Disable the pwm module and reset the pwm counter before updating the
  period and duty cycle.
- Improve the descriptions.
- Update the dt-bindings maintainer to Hal Feng.

History:
v20: https://lore.kernel.org/all/20260629063601.63917-1-hal.feng@starfivetech.com/
v19: https://lore.kernel.org/all/20260615155759.129210-1-hal.feng@starfivetech.com/
v18: https://lore.kernel.org/all/20260515054723.25024-1-hal.feng@starfivetech.com/
v17: https://lore.kernel.org/all/20250106103540.10079-1-william.qiu@starfivetech.com/

Hal Feng (3):
  dt-bindings: pwm: opencores: Update compatibles, examples and
    maintainers
  riscv: dts: starfive: Correct pwm nodes
  pwm: Add OpenCores PTC PWM driver

 .../bindings/pwm/opencores,pwm.yaml           |   6 +-
 MAINTAINERS                                   |   6 +
 .../boot/dts/starfive/jh7100-common.dtsi      |  28 +-
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |  67 +++-
 .../boot/dts/starfive/jh7110-common.dtsi      |  27 +-
 .../boot/dts/starfive/jh7110-milkv-mars.dts   |   6 +-
 .../dts/starfive/jh7110-milkv-marscm.dtsi     |   6 +-
 .../dts/starfive/jh7110-pine64-star64.dts     |   6 +-
 .../jh7110-starfive-visionfive-2-lite.dtsi    |   6 +-
 .../jh7110-starfive-visionfive-2.dtsi         |   6 +-
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  67 +++-
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ocores.c                      | 309 ++++++++++++++++++
 14 files changed, 529 insertions(+), 24 deletions(-)
 create mode 100644 drivers/pwm/pwm-ocores.c


base-commit: 665159e246749578d4e4bfe106ee3b74edcdab18
-- 
2.43.2


