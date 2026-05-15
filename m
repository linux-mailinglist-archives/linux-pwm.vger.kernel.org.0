Return-Path: <linux-pwm+bounces-8881-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO9LAknNBmrynwIAu9opvQ
	(envelope-from <linux-pwm+bounces-8881-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 09:37:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A3354AAE7
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 09:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C18B83022976
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 07:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600EB3E5A34;
	Fri, 15 May 2026 07:20:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2113.outbound.protection.partner.outlook.cn [139.219.17.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD273E0257;
	Fri, 15 May 2026 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829615; cv=fail; b=SgHdVsWppihogSyhexpnwFVQ5jHWG5K+xhNreS6JmlONT/4rgDlyD5D/f7gMMC8ARttJb6b77J1fIydjpUbvZk2iSO/tHG1kI+p7uqCq88WVoeLw8T/DwiabQg15Z8PHOSbLlYZ7xBRYbjM3AIywTRC9N3KHxVKKxWO8Hj+oMs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829615; c=relaxed/simple;
	bh=A2DHMhlTgMTX6a0EaB15QFX3mLNoY6KNmlmTDtUEEh0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FT/2YmVhv/SSKDV835olo2ScrgzKeBndPax09siO+oRSZ4aDMbiueMK/RLeLsWr8Huv+CneUdLP6zhsr62pO1tHF5BmSwQLbI7X1LpPzmceizhnN+tQb4DM+XJ9XU3KEyZT99gfBXHcWZUY+4uSm9Wv44xvs42CoHrqo727mFb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdi9k+IGQaSS9yeZF3+fYHEpFlYnSM/Uc59Hn7cTXqZ2Oy4O1dM5sQIZCPSuJ8qRQImH+4vvUBjfNQUOWNZc1vw8vo8utMWoOcWprsZGCha43PPGjeDr8xPEf/p+RCa9neTVYaw+2EoRkZClIQE9YRhKeQ0gbn4SVi+NcRrmGqfiQaZxO6bevIj5LuLJAOzA8vnGnqfZD7yHuW4veMgpzoI5owJ0yTrelekQkMa7OnXcnNnmUjoJl8G4UcA+55vNvr5oQ6bGKXWxAnP6dpZSVnLsViUjxrxLujt1b4OZR+uOjKwh8T+2XQVjVtVataKJU4a9AclTU0VEogHV2yJ56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV5ddLc+dFKKxL/DB/3WtNoq7rKoxesfNfJY250Gljg=;
 b=GFxo5mIigZ9L+WzpaKvrh6I0sEJA/QjQYGs3u3YPuyRDiVLdzXf7aMcRt4LSzeBcZE/fSJFtlVf1FAR0McV8WWGQWTH1WJ3+FzUSIMZAieV90IU9Hn3obJvJjYcSybhZEfszr1paBgGUlrs8Q6DZ9e1LWRoNjrMXD+a0kkaw0mWf9uPe93SUFNgGLvD0IgnMQoR2mn2vdtfk4THbLV5YT7V469HlPWwSdKz95F6EHWkLxs+lTZFWMvhrNrFj8k3UxkttefuzhTABsA8BhOv1lWYtL3bl23xD4PsA2Mqrc5lMSt7dqnWpAE3/9ZhSSpuZ08AOC3S+thoQwxUSFJRGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1276.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 05:47:31 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%4])
 with mapi id 15.20.9913.009; Fri, 15 May 2026 05:47:31 +0000
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
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v18 0/3] Add OpenCores PTC PWM support
Date: Fri, 15 May 2026 13:47:19 +0800
Message-ID: <20260515054723.25024-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::22) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1276:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ffeb50e-c259-4f47-3e79-08deb2457449
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Y29TvktpNcIkB5rTff3TzJW1QPbqE6NdzGvnU48KJTBh2RFtBeO7mEN/+ziN+ZqeC+A0k0Ow5gPOuRYut8ss2pxhMtlsKqWL942bHGcqnGB8NzMsnaw6cLh6j5N2bY7bPoKmfpoY3P9+e0WkpJsttxB8kDNiKUTlNdQXdivylsTuUIipi9EC3I2ygp8ftwvAJCmUyaDkJ6vipVvDWInTbV1Xr4YEG8l+A5I2Y2VHJfw7ft4zv/TI9o6MX1rxhw6O6DM1OSKbpYh7kgOYOmRff3kYGalXFQ+5PCfzUTvR2LzZbDzNlFCz/eE0n/sjqGqhdryBIuA9EGUXPt5ZXRjPV6EejyrQQGkdGCzj0INt40OFeM9XDUXWLiKYIrEVmc3M6Qxw5azhqe7JS9MeNlhgL8IWSZuPtvB/antPNhIt3Dn8FXT1Lqc/+3fAwHWX5JNrPz0XrnhufsFfy2T7c3vkxqPOiDhFCec3CnzkLxZ156RaACL4vUzfAlxORasnvVXo6ut5RHjzLjzITX0wQREMcU7f6eZJ8ccLE+O1x+p/B8p6cVtv1A5WhNruM2bdlnIY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dplLlA2pYd73CeP7ahlc8nh/fcfbNs8+/HP4k9zfGVgm66eXk3jG2xNA7dF/?=
 =?us-ascii?Q?W8rMLVK3iYLsynd546locDgC4RBqjKVZAI1BiWohMt7jm7+dyFv9xQ14lD4Y?=
 =?us-ascii?Q?RaiRIPkyEYWDQW+jy2UvC0UOoUBWSHx+uS1+TI38myGzt0YAQIQYhwzXnYSq?=
 =?us-ascii?Q?Jn0sJxQzbYMAHhY3PK5mjmFGYVxhTKk6NIz3XgUjjqh0ajcAHY1myTDfBQTW?=
 =?us-ascii?Q?GX5VsKDBfgXctrI6VE5Dtm3eV+FrKmL0tjjqJJOkiU05n8yFTpq8kEEpmW4v?=
 =?us-ascii?Q?KZcZgWeeoUmpgy++qmytCCh49GUcIJxULawOxwtKhN5QDBbEsgBRHsUmpFhk?=
 =?us-ascii?Q?LoAgGKIxve0EMptgqYLOxM13wAvqAik414F2Ev0I7V9o9u3ZLt9A//lOr65P?=
 =?us-ascii?Q?TXfLNbO/PP2VM17CygXsJkyjbjhYh3MYpfVaE/2NaFHSuaANrTnCRwHMUnwY?=
 =?us-ascii?Q?bhe26CUhEVX8EwS3Qr2ZGiRbUxbObV2oNw24oPOo2lnQlWmMwPV8Vs85jTma?=
 =?us-ascii?Q?a/4ZLdXv1eNDgwVyTdDMexKtnxiF+zj9SCq966HhpoXV8lv1RCPO/CEy39Vt?=
 =?us-ascii?Q?zArgJi3jZjByZEXhAI8u/YMNvhGeiK6YZWIfKlEpuUtp7YOQ1R0PaxVcR1gK?=
 =?us-ascii?Q?meSpQmsmbdMt9R3nHkCsDe07oRJpEHDiatnrtara/y3fJizTEOnoSzJSQVqs?=
 =?us-ascii?Q?OLpFu3ifoxXAT/qN3qlwoAu27PkojeABYQvi60rvsFZBW4WtMdp/jYrbQ7xf?=
 =?us-ascii?Q?3eXpNIltUTx3oad34ytOlGhNv9CiVKs7vnuImyIc12kyWOOtMVmBuKUmI55Z?=
 =?us-ascii?Q?Vh+5fQdrbNAFRfJVvPJNLsgDforjHa3FYZ6IojoLkD8ULhrzrIJtfRN7263U?=
 =?us-ascii?Q?78kaOQ0P46LY6Y9g7+/MO8BKCRCFr1KJjNahL/ublHv5RQayj96ujQ2Nnnur?=
 =?us-ascii?Q?PRGr9mNP5bZLuf/FfTOzst3Z9Ww1WivFccLDCVE33OVT4hDDvT8BBnmt/txa?=
 =?us-ascii?Q?326ftBygjlNvpcwwd+q58MpJNI12IEw6ThC7T20oUTIApucxc5wCb2MFj5TD?=
 =?us-ascii?Q?o1DQJ/E6/z4Q6Hy6iOxbKzTgPgDoQ1+7wId+pjp/axVkLwBRaqaXofzBc2Zz?=
 =?us-ascii?Q?8Jvh8PIpJOnPK0gD4KNr6aykiTzY6sabchwvVhy99Ql8RhsuisZRoMnvd18l?=
 =?us-ascii?Q?okskwjiCbgRRecW7P117QRzjjeKYk2FneU2Xli6S9cNAzDQXQJfGzCXrW2cC?=
 =?us-ascii?Q?/W7JBKopr4x+gAQ/wAyU/5lA9NAtjd6Qnaf+HV4gT2rak/c5C+9erGgJQ3cH?=
 =?us-ascii?Q?r8IScTZmL35f4IKh7vzMofCUzqZJnc+UjNr71+le/SdBzUJQzOwY7o7LOniL?=
 =?us-ascii?Q?DtkeF3hADD6NMegb+XrcmCum22IjLYxhEMWOzdn7/XCrZmXOLRurkzk8gtL1?=
 =?us-ascii?Q?EBWAFHuaD5kZ7eob0jIgp1iyD+A1MVizd4pGEM0vqpgODRmPtMh3Dlk+ALJ/?=
 =?us-ascii?Q?QtxzU2gORJpZikM4rKoR3Jm0uD9MwbTqMLkTeBKmSKcXMJBmv1WqI4+UkPLj?=
 =?us-ascii?Q?lk6yRpmiF3hS3+ALaUaDssx/KQG3ZY6jL73YnFsTXz+CIIrb1XNolR/PENue?=
 =?us-ascii?Q?3TebtVOqZvEDn5w7ILworrJ6qDbucvhYkbvlDwYXY8onmXKJwrEWNlQT8eYn?=
 =?us-ascii?Q?wQtmz6YMqhBb8rkUIEEIcCJaUBIf7QTEOCB2XWI9CoS82WvK+RLO4au8Qd0O?=
 =?us-ascii?Q?9hA0bIATNvuP2iFmDKVYc/X5D5cGQEs=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffeb50e-c259-4f47-3e79-08deb2457449
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 05:47:30.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dL4clGighWSCaTWd/qymIWLB94zX4zCbvBVZcAkMm/rvQmfxgAJXHPYQwndbZSAFMTvl4pz2lQYH+FQgL5AXbX/Of5ECMqlSCG9n+iw0A3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1276
X-Rspamd-Queue-Id: 79A3354AAE7
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8881-lists,linux-pwm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.950];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:mid]
X-Rspamd-Action: no action

Add OpenCores PTC PWM driver which is used in StarFive
JH7100/JH7110/JHB100 SoC.

I will maintain this pwm module in place of William.

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
v17: https://lore.kernel.org/all/20250106103540.10079-1-william.qiu@starfivetech.com/

Hal Feng (3):
  dt-bindings: pwm: opencores: Drop starfive compatibles and update
    maintainers
  riscv: dts: starfive: Correct pwm nodes
  pwm: Add OpenCores PTC PWM driver

 .../bindings/pwm/opencores,pwm.yaml           |  10 +-
 MAINTAINERS                                   |   6 +
 .../boot/dts/starfive/jh7100-common.dtsi      |  28 +-
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |  69 ++++-
 .../boot/dts/starfive/jh7110-common.dtsi      |  27 +-
 .../boot/dts/starfive/jh7110-milkv-mars.dts   |   6 +-
 .../dts/starfive/jh7110-milkv-marscm.dtsi     |   6 +-
 .../dts/starfive/jh7110-pine64-star64.dts     |   6 +-
 .../jh7110-starfive-visionfive-2-lite.dtsi    |   6 +-
 .../jh7110-starfive-visionfive-2.dtsi         |   6 +-
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  69 ++++-
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ocores.c                      | 249 ++++++++++++++++++
 14 files changed, 471 insertions(+), 30 deletions(-)
 create mode 100644 drivers/pwm/pwm-ocores.c


base-commit: 66182ca873a4e87b3496eca79d57f86b76d7f52d
-- 
2.43.2


