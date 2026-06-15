Return-Path: <linux-pwm+bounces-9296-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8TQjHSguMGo7PgUAu9opvQ
	(envelope-from <linux-pwm+bounces-9296-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 18:54:00 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0316768890A
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 18:54:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9296-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9296-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 382D2310D543
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B3540C5DF;
	Mon, 15 Jun 2026 16:31:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF913FE66F;
	Mon, 15 Jun 2026 16:31:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541111; cv=fail; b=IQBH/DxNQqrKNndlv/Er+UZXGbHdXfLvU1qzj5NP9u1ncMzfgZokEBAC9a61wbu4VY7yroeu0dEPdDPIqzkdeYvf3xqwOUMGC1ELCMLd+r+j+VwQFZOAPixHBCGht/HoE0c5grkr6nxtayQrHsFNe3W2KItrXfEOE8OB3cL206g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541111; c=relaxed/simple;
	bh=dqklhzJXGXFrgXGgJa8W9zljwqTagJXi5gpMyluogoM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q7kCXWLGQh1T1Jk+d0LcwZh9zsMtfV/IpwoP3bVTrdYo64hVQzlTnSRo0egYnPRAMfKoXQXp9O41rT5QdMTvbRDfuWzob+kONr6+b0Vsoo3V42xXIOHUyBtd+bKD8KIQ2i71+pr/0GyYD2gxsGBr4YLOAiG4huCuxZcGOAOyKsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+AoGWH1O2ry7jHnZFKQ7n3N29tuIllUuTW78OMoJuWy8sbXN735hnO+f2KvzKzIhueCf0Kb1ZT1Kvs+VcRrx1rSx/+6N5R0DqPUAUDEZsEzWoG0Rg10RceDYfXw8X9Fbtse2tLvGtdsKdda/IH23VJd6r4Dmc3Z0xW1xzd0poKABMTcsBkTDr0L5peuFVNToZcmmFDGO1GyRwyvPDphUFk/8SuIRmXoHbHwMnJHvmkP8TFbRyt3NLZ5iJ1zB7tHPyThHDR9/pYJsAlBLabPfVCShqt3u0ywak9ciw6MaDR3l8+UYM3zYD/k1f0hCIvPrxLoRcZ8mKvNjjqLQJtuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwPyaAmZNKxEweQBz5hloUliHo67YernfyFmIqA9r2g=;
 b=IO1XUZ3ErJLAM+i8N3WLV/pQ6XQoMErSCtyVEBpPd0kaxSGSxQ2PIGOSG3jupsDDctyqO76IHQ3qkn+KIPZLfEOsp2K5lVfqxVIHOXDplx6eeG4apK/QYko5xxPM/cZ+kmK11vtmY6vprMszN/VTG9AC0gKQCXUnE5WwzKAQMcFcylbBxhOiYJFwY6j9Pc5Zge35FPF7KbBTZ1XuigpIQljQNvb1BeRlEvgB1h8YTyGgrjjCBSHUPgYNM5I5VoppcP8GYY0x2fcrPXHVJmkFyHdC9FiwZxJDrRN3XN6e2gcspm4JKxVxwhZ+5OBT0pvkOK3BgMkBi7IofZLobrN+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1321.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:58:06 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0113.015; Mon, 15 Jun 2026 15:58:06 +0000
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
Subject: [PATCH v19 0/3] Add OpenCores PTC PWM support
Date: Mon, 15 Jun 2026 23:57:56 +0800
Message-ID: <20260615155759.129210-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0065.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::32) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1321:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b8424f-4c39-4bbd-ad24-08decaf6e3b8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|23010399003|38350700014|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	J9S3YCcVbH2+k9WsZLykQrmSgJGuqZgZJjQu1GEUuoZdrqtLx4htLyNBlefsHpI56Uw3qE2KnYAn2lk/BFfcZNllrVWistHQdJRCAYnJw0gDaAQro8IJAO4qWLMpwi8myfPgDsqenjwgaxp0eZNqhwN07DUUvuA88vT8x7KbPPZPYojidy1dxh7Vi0PejLYgZ6EpVJDUhrT8STEql6Y7UwCExOr0CYTtALO/2dJbqNw9gLYVhVM1R8xTqAdm662YHTS3TM28KX58hvvTi6VCrGJbxqTDZTPju+YePro4YwreF7DrmHPm60TyFoxMz5Px8ym7aab8dZ/EP++yUfFGdLIiG9BUEP7KA6Bbn5Eg0KVI9vqJ41xl234gEHXcAZnEIFk8JDlBc4UtShGcSShNwFvPRq/loUO4G2YsEKwC+OFibg9/pNGngQVlz5zSS0S9ety/rS9YNBW3wWdjOP/Bc9d2RfD9807raR1Egm1ncUuDhq8m2hPkBW5L49UcNRo1I89/Ch10p4ouISHY6IshGdKzJLs1bfRMLvDkxBv1iXkdJxDYPMyRICGFl9lW61Hw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(23010399003)(38350700014)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GS58SaXA89PbKpKmFiaY2UAbBEKB4a/QEtVXTBfYPgiG62TneW8AjWhvA8oB?=
 =?us-ascii?Q?5W9C+JfUUkUh20ac2EWXhdmnE2QMT42yNHOv3hrS65OBsuxV2tv1pZTkD/Az?=
 =?us-ascii?Q?G5Q3+/LNuwbzUcs2UxXxrf9/l/7dzYQrUwk/hYI7Cots/OcK9uBwqwA6YBvJ?=
 =?us-ascii?Q?Kglq88uAYwytkZaL0xfzTAULCbwGSLVS0jHmzD4kdF7jdluarUOJdCWyFWqI?=
 =?us-ascii?Q?FsSqpGW8GZxka2vUEVyNB+ZmkNL+ilr1YLzLSWA01cTTzj45Mmc8xGsRG93B?=
 =?us-ascii?Q?W8ByxMyc5CdPBuvB19NgSe1VrOuFOB1zZKNCVJC/3cAbBdRS13earvSj5yQJ?=
 =?us-ascii?Q?sHrwri9A8ll5lnhKZG4zrR3sxsgUAboaDMYinz4YR1hQ6eS8M4tFjpglQNUE?=
 =?us-ascii?Q?piBkO18KcfQpskFVieAt3AEJqjG0lONiA4RkslZN2u+eqyldErsu8EmHAW2o?=
 =?us-ascii?Q?3Asb54Bq03G22FxhnfKQYW4Sufeg422dDfV2hE3+ftVmrCYMdpHLOR9Ublgg?=
 =?us-ascii?Q?yZ7ZS4xflDVQ+Aol4hCl585Z83jTUR2M5K05G7EmBeIrnk/vOEUplplO7di2?=
 =?us-ascii?Q?7hPSYDSpJa3p+T8PRnXi9cxHo3dsJ8O0Whr0Rlqgtg5hmOVWCvWES3hRfvz+?=
 =?us-ascii?Q?PzraxZx10EGPKaBCs7sbFmQAJxDwXaVvTheEE0qCZh7shl4RkGKnVYhxjmX9?=
 =?us-ascii?Q?+ezg49XkZ5yKcvgagcYKMYow2kqrPtcYcGZw8U+ngCCQV3dTubA40O5GxgnU?=
 =?us-ascii?Q?1jgf4zARU2iyX7LyxN1DpfD7QBuT1R9sJZLeIiRgdM2tPupQi+G+DaCxPs9x?=
 =?us-ascii?Q?FApiw/3bcO2/rx+xOF0Ok8JQ+MwR4aink7jf4zELx/E6dMnfOuz6dHAGbNn2?=
 =?us-ascii?Q?CINZDo7nw5TAVlujovzF8pgV2husNWJmXTHcrVQEkgkyIiGpyZy5IAbkX4qv?=
 =?us-ascii?Q?PfKk24MpCf0ns10Pa1L+LvwO9uy4zAKgWItR5OoWESJFST3BaMAd2rkUT0Dn?=
 =?us-ascii?Q?01ea0MtuCGIvy+qPibG2mEIpRIbwlgMjwmeGGKUzIteXthmV/FZ4a6FvWt9N?=
 =?us-ascii?Q?RuI8PewVwN+rXwl/oBRRktS3mSft6NBNXjo83esr1PYw0quzLyK0vTSBU6rP?=
 =?us-ascii?Q?p1ZSaXY/eUbQbGhXH/5SSDGAbLuXbsJ96NJi3CJjPDT+JxhEDk0oT0VqMRTG?=
 =?us-ascii?Q?s3Je6zAPXrEleBOKS6w2XCAyHnqlXYzQFcaE09VTHpJrPIZwzZzd7IqQicd0?=
 =?us-ascii?Q?BtaSnoj9i6ySwmS6KCzvewrZNu11uXMYeCOOtu3iPCBf0uW5rz1D/L1kOXbl?=
 =?us-ascii?Q?EpVUJbcEV1IMq+PA/UBzlgFhDyrCWqbaMgCwau4nXQjTL4pTWYDtjZbhn7HT?=
 =?us-ascii?Q?ppjiDxF9xF1FILD+WlQnOYJaGSDZQJm4xpBrE+GFlM/jxYJtwxrC/MiCGm6y?=
 =?us-ascii?Q?U8JFLMjeAeN0IJaa6E8869WVgpgTxyaDMxOllxq0BTXpNfZoukb5B+hrusg6?=
 =?us-ascii?Q?wNewrSqYRsuCtB19Ubrp3PHzLht3gNi+VFGI1KkNBi8+S5iFzOifqwU6DtKK?=
 =?us-ascii?Q?G2GKa0l63kCWEcPXvW7/8/RhGnuhxMrmgztbRnDICU7POV+CunE/43tjZCU2?=
 =?us-ascii?Q?J4+Cpm65ABwPw+emMwXx+UkAAebQlIMN8Kjmm4dh6tWI5I01EFpKoyN1/nyD?=
 =?us-ascii?Q?c+EaglWwy9dv5UPB4R779OfhXuwqO2iaYc/JrRUylDVrdzZYwHhOe5L9ZsXE?=
 =?us-ascii?Q?inIT1aGeduDYIO+pCDyM5Hq+VaAk5P0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b8424f-4c39-4bbd-ad24-08decaf6e3b8
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:58:06.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOFS7nYfVzy0IQ79UdKGiiY/ATUmwm/yAh2h8MlPmiwNOJ2O5lN+3k/lii3rAngQA9RxmrijjDK8cGuKEaVt3TMVFelkaow+KcKqxyt0AWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1321
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
	TAGGED_FROM(0.00)[bounces-9296-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,starfivetech.com:mid,starfivetech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0316768890A

Add OpenCores PTC PWM driver which is used in StarFive
JH7100/JH7110/JHB100 SoC.

I will maintain this pwm module in place of William.

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
v18: https://lore.kernel.org/all/20260515054723.25024-1-hal.feng@starfivetech.com/
v17: https://lore.kernel.org/all/20250106103540.10079-1-william.qiu@starfivetech.com/

Hal Feng (3):
  dt-bindings: pwm: opencores: Update compatibles, examples and
    maintainers
  riscv: dts: starfive: Correct pwm nodes
  pwm: Add OpenCores PTC PWM driver

 .../bindings/pwm/opencores,pwm.yaml           |  16 +-
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
 drivers/pwm/pwm-ocores.c                      | 312 ++++++++++++++++++
 14 files changed, 538 insertions(+), 28 deletions(-)
 create mode 100644 drivers/pwm/pwm-ocores.c


base-commit: 95e56f0f293ef797123eb032f78f5b5d56a035a6
-- 
2.43.2


