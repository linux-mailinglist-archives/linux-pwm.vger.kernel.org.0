Return-Path: <linux-pwm+bounces-9706-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z/NyKaa3VWrCrwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9706-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 06:14:30 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04236750C5A
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 06:14:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9706-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9706-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E23F3026156
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 04:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C4533BBD0;
	Tue, 14 Jul 2026 04:05:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2138.outbound.protection.partner.outlook.cn [139.219.146.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC102EA468;
	Tue, 14 Jul 2026 04:05:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001951; cv=fail; b=Ev2R+pPZwYHdfwprVtdyPbDplYFkGw9r/lO+ZCwr4aHfxrc+nFYCM2ZU+9ePksoyv9YZLlVlzmV3Avq/StEJWkh89AH8kEcpL+5JCEau+GukwVPFUjPos/P1HmCjRq8BSBX3qzTSt9TMPYtJVN8oDohlgBYAtS1UUPtWehwptRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001951; c=relaxed/simple;
	bh=ve/275BnCVjtnIFvpMNpnZcGVsXJlYCN9AWudlpK0gE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GeDqtFv8KSh/e09Mey9a4p3cl4JmbZOE0qv3VsYTYIpbrO1mwKI1XIW/dSbXvbAQ41JYXwCYbi4jfv7bPrr9AGIo6XgJMWWJo1fLEZ+3MJxhZ/jBbvXjU47aA4kArJ6KjR4BQ7Z0KQ/4wBl3djT7IWZ/ZEtb+AuTjBDuDckBEiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.138
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoSNVV23KMOWin9wq48UjJ8NK+60NOoiT4GFwgml+uJTvC8PpySaGlE6J7kh/LHK0ngyeoYfjr1c8EpbRTlW2fz5Sef54dor1Hk5J04FaOirLGMWGlsWg5w8juz341RaUNzcyxBp/mR6HpQDjf9gdQxmfHMbYKKSKi/yMYbUBZnydpCta7ndMLB4ugyJcL2ywyAWzTLg+DLseT80YdEbXFM1EmxTZY4DJgUBY075bLp/06nfjDo7F1g85dMvS48ZFKi2YItwxytASGZvJtpqFnoARyMos07hxg0m5Mhy4KrKjOnhRuv2916oGH52bPU9hva/4iPqDKbcmbEJxUak7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFwR12LXg/bOkuzkiNUiTiFGAf5q6hv8zE7e7CX+rVo=;
 b=jOlbc+t/stInbrItjyvf12t9LznkioGDOLfAb/uDjYcNAleyU0yfF3fSn32nYBBxUskqKrTN9p1zSYKaxd2n6DEn/C/6uf1bjBBso9Tt0Km4bE4lZw0E6nap5Y2aKgzIF5Y4CEetiJuooD6VtCunEYSJ9D5aJZYdZUnIppRQ6yk3ydBAOdvaN7k5SEAN3awe/S1LMMWD9TMfv18wKmg9TehcXXmzPg3EeVOjkHvFiuO0iY9Dv58Y9bfGxkLXaFfwz+nHLfyDJb2ZFxCYc0R1MWPEGGNjxSglHHC81pACO3niMMjuIytfwkgpE/wcaCIQM0Dtpw+wjcYuQ1av74MlrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1324.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Tue, 14 Jul
 2026 03:30:58 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0139.024; Tue, 14 Jul 2026 03:30:58 +0000
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
Subject: [PATCH v22 0/3] Add OpenCores PTC PWM support
Date: Tue, 14 Jul 2026 11:30:47 +0800
Message-ID: <20260714033050.44952-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::35) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1324:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b86ded-3667-44e5-199e-08dee1585206
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|56012099006|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info:
	bNhSucXwNChpNqnTJwALtB1yX03M8j6ga2aMwPEk+VS66gVR3AdikY8HwtGwKtHtls7fRl/Mc14ndfcXfsEMkB/SsNtR3hCA757KSRRq+MMUjCTcUMesxbO+oefgr0ahtEmb/7fXOvCQCDml1EPxY8zHwR7vRgGcKL+EkfjLlBYJG2YX7oKKdj2kMbqwrO7Vl1T7Jbs13QQ57CISP0JRT1NxBS4VwDOH4KGNzbDd/7Oqcep7+W0qy8iL8w2/aqDocvrt5vz8bdiIbQ5zYg8KThIp5TThzJhWuw+tbmT0HYzDL46+97EKsn7KffUIGsW1nh17V/dfbQgmlvIRRxKdF7rw01pNrei6SiyLVReE88aCC0a77Mxcby4JUo1yhxO3gqdW+GWnxCAX3suB6tECvXSY41OSUIBm6rjMhtAm5p0x94M7qadhEIAL5rLaavPgV04mYr/XbA+sxgy3W5t4ao1olxlNuSucgZc3DDUOKVjrL8HUFSn9iBU64FoPJplQEKSja1mnPuZ+5cznw/7GAc0WCJwp9jw5ZJOQBKYccT9nIGAlRxv/YzGL9er9DmXw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(56012099006)(38350700014)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FIVMPWKMVLuxaRftwCRHlUz2GmkWHGg+mF9m/SxqCrD+QyFT92Q6WbJD7z0d?=
 =?us-ascii?Q?/sKhgIHzRUsaZ/SlmP5J0gscxG4DHkGUzeBCK4dQSmwgRGHOiwzoXLhO/wHW?=
 =?us-ascii?Q?JXnUgE6Rn1moCWcWkZAj2He7vD7DIkk28xapakDXm1EPotdMWs2hgeGOEOL7?=
 =?us-ascii?Q?ZnqmDsXpmv/IfAi8fDKF6nF9TKY+6f7bTI71U/FezB+4LV8iK8swGVC2bE6O?=
 =?us-ascii?Q?HgbBeXONT2vJ0Bmw3sg9HBp7sXp0E/e16gwCfgFcJZgu9qEkuPDEnX5fsQB4?=
 =?us-ascii?Q?Ih1kgqpG7/vezYaq4BGywGEP+lb3QiV4uWwn4e+S9U51zPhP4egdK8bX9rzy?=
 =?us-ascii?Q?yqA2pqQpl1P+2oclcKu0KPNAWE+Vz26zMcnFQpWUcTCPvhPonLoQImoXI37r?=
 =?us-ascii?Q?FZsbQ4h+KubL4XRSzZ0rUjTc0paVGI1i/zqL08KKVhqRjoKKN0twLC/JGhdd?=
 =?us-ascii?Q?npI66z15oMxNN2MQY2WlvN6kLXKxGyN+RYXOUCGL4NK7tq8Th34JFaAfRtZ8?=
 =?us-ascii?Q?DqLmWqc5oA4jjsh6wH64lnZpLJOpIxTdlNnIC3bk4urUAwvlGW6pDua4aliq?=
 =?us-ascii?Q?tS+cqlp4bvsYkzSTxRt6/Gpzfp7xITCWYs0nr9u10rnLSEhuEuxBLuYWwL+X?=
 =?us-ascii?Q?TM1YB7vSAieTgfNQT6uS181vGFLP1ryTacrXMAtUVeYp7kaKfgMBKz3y5usO?=
 =?us-ascii?Q?GcsCb6vA+NXSpBzOWfFu2nLB8g4ZbNZnwQHM0u17yDEAXrdmXBHWXGTIDfx7?=
 =?us-ascii?Q?j5KOmwa+BxxeP+cfc6nvTnKZ1Pcca77bdG5H4U/YxDdjUzhwBma1+Yo2UrI0?=
 =?us-ascii?Q?ZpQaYQ2v5O4t65Cs4hyjU232yHow9zqJDNlcrYSKBsyLheHCgUmPALVm6g4N?=
 =?us-ascii?Q?7/KPHco7lIBXXG9ABnLnCWnlOeVCm5vaaO1hRJ0L0WrJwMp5OKSPfoYSsgnq?=
 =?us-ascii?Q?MO+E1F7k3Ut8gzS0erBZNqcDoyErrBchkJNwc7AaHHytMUT2gjV5GrxcOThm?=
 =?us-ascii?Q?mr9+rxOnDhzoUYaMb3+lrq72h+Lz0bdxSsjaWeuSZDZ2PEOG+CWQoEtrMnpC?=
 =?us-ascii?Q?Jl7Z83EjLAYQwUCZSKvJh+1iIMXzXBEw+0oFlJyP3Ejtc5qKJrmZApSJeR6S?=
 =?us-ascii?Q?DdNcHSjok2NQ9HYNsGc1nsR6jKcYHmppW1k3r44Bb9/uAfeTwXFrCW+v/MBh?=
 =?us-ascii?Q?0oopn+JoM2dbuKWfSUjZvJD37tLMmTntceWSLv2MtLCnNxBUtfA4132uy9sE?=
 =?us-ascii?Q?V2yCnutfLaKt0qwfDBmNK7VyyTceGqpYqBGkqCg+xhJu1qdFRgx1/sQbmpHw?=
 =?us-ascii?Q?UyaBLeWHqkNZi7cAYTmRcNmhUWLc9pI5cqBwPts9C7S4o6I/lPG83RSZboKQ?=
 =?us-ascii?Q?9e9FPr9HgEANQeA/7ql4WAen0LeuHMhbIlHcwvh6g7pP+YjuYjSc+Ca/zCij?=
 =?us-ascii?Q?80CLuygV6iL56KBIa7XkODiaC0ROQ42WMHGXJZMxpiUrLO8oo5lLUwQJGvSy?=
 =?us-ascii?Q?bE1fDQSjH3hbvFYUWhRjflc/OXuobdh4tkB/XkVzojXikyyycakAOk+21g6q?=
 =?us-ascii?Q?VsK4nSLfDoT0K5zYo7QrOvR//n6ojhb3Btx491JmhYLpk5QZ3a8etbtuRkXO?=
 =?us-ascii?Q?Qt71UPSwRCxH9oILLzoXK/FTI447Mh1ZZac2+XPWSu4t6oKp5fHHDjYYBIxe?=
 =?us-ascii?Q?adh4IWYMkbGnPmGoSV4es4/Vu6mT5+YtXJqTeCy3ar50s7PRCSUOhqJRAuCs?=
 =?us-ascii?Q?G2wFTfVLyrgM6siNqvnQmTbeUQnQrqg=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b86ded-3667-44e5-199e-08dee1585206
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 03:30:58.3928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VTufCWI54dHeC3++iaVTut32La+x7Wo2XMIS8P2kq/FUQenaTgZdDriIM47dEG+2r17tk16Nlr9SUimLPK4c5zJ6vMuzWTX+Cvy2yXYZis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1324
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-9706-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:from_mime,starfivetech.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04236750C5A

Add OpenCores PTC PWM driver which is used in StarFive
JH7100/JH7110/JHB100 SoC.

I will maintain this pwm module in place of William.

Changes since v21:
- Allow non-zero duty cycles shorter than one clock tick to round down to
  zero.
- Drop the .free() callback to preserve the PWM hardware state after
  pwm_put().
- Update the comment.

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
v21: https://lore.kernel.org/all/20260701074442.7714-1-hal.feng@starfivetech.com/
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
 drivers/pwm/pwm-ocores.c                      | 298 ++++++++++++++++++
 14 files changed, 518 insertions(+), 24 deletions(-)
 create mode 100644 drivers/pwm/pwm-ocores.c


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.43.2


