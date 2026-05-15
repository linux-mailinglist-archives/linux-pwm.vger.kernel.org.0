Return-Path: <linux-pwm+bounces-8880-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIE2N2nLBmrynwIAu9opvQ
	(envelope-from <linux-pwm+bounces-8880-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 09:29:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B471354A95D
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 09:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09514300138F
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 07:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2433E51C1;
	Fri, 15 May 2026 07:19:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2125.outbound.protection.partner.outlook.cn [139.219.17.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30573DF015;
	Fri, 15 May 2026 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829573; cv=fail; b=r8YvqrONVTzr4VabBeemjzEOjX1zfWyMrbNbURurKCGcYxhMT/EGJi3g+dlazw/xZFCNNWEYtbFTDppGbPY+u5xIGico1AFBlqZtUhqWyaDGoZMHpaG2LR+J8ae2OEdsQ3GLmde6cTB/bdQNXXGimYUREDerhyjWLh7MUaxEVNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829573; c=relaxed/simple;
	bh=mB2qnBuk3VA7hkaylR5bZFVaCjNlkHgh4SOUYexsCIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N5ItaVusFhOn9ZidoJExd8gsk/INcw1SlRfrqHBHQkm8ur+D6MzWKdI3t5qPuIg1zHMKnxVM+caO2A/7Anz+dyPe2RVQmJ+KGrX2ijqq/Z7xfZuMh3XGvFE0fhiD13DwjjIZPaRbLn/MYoPeIudK0mqNFqJCPdw0AtZHDmlGeRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdjHJF553PcTy7kTKoIsHvUZiU/qDtMEBBsOBpTVUuqAPfShEQoTBxa5KyD3DE6W53Bz9X1FSDT5NJ9U3tUQvwTzi+hQTCK+BfNmvMTnxlZy7I3zikrSaWtbbR2N93jGIX96KfL5i2YNl7gidrmyeUCqi6XRc/GKRphKdlc2YlEhb4Q3L8R19BOuIxxoq5OKghXxapyHMWrL7zaqK+6LBXejGm+5tIS7Usw4ZXeds9gUlQQ7vGsYUSA6m9gQ7PTdp0bl3xugrNWP5LzREbeW3OmPY5Cu/npsaj1dv1Z1cFIEYbnZyPA5PayHLNhWu/LW0HUKcWJugBGx7rRmkmumpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQsOsFCyy2ameyCBGoWUv1iv8VoGWNLHXYWUj5o+09w=;
 b=em53A5yV4rJjQWemH+On2KsUcMc+Me4xDf/LckSkNf3+fMh3cmPI1RFPX8rFyNf3sagPIDP0ZUEeERHFaTOGMWuSJipDps5s40JR31JL2nWmKZAfrEcEv6BK0RDL2EU0T8+7JIHNtDG6YroO05K6zNkQqJxVvcTjpDPPW5xi++J76ecsa5LTamccNZiNFKqKVryB1wd2eY4R0m9PEWAiTzUlWZMqzZuxNUKa3KaYxll3EMcqx6+sRPfm4vkkrB6/uqnU37pca4NxCG83tXsDX3T63Com7X1FxZQQbvnaurkYHueGYbQFvtuMiID8SPU0G7YsR3Eo5qXbyuuaowKV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1276.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 05:47:32 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%4])
 with mapi id 15.20.9913.009; Fri, 15 May 2026 05:47:32 +0000
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
Subject: [PATCH v18 1/3] dt-bindings: pwm: opencores: Drop starfive compatibles and update maintainers
Date: Fri, 15 May 2026 13:47:20 +0800
Message-ID: <20260515054723.25024-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260515054723.25024-1-hal.feng@starfivetech.com>
References: <20260515054723.25024-1-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: a06aca4b-2e62-4d6a-f177-08deb2457519
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|56012099003|18002099003|22082099003|38350700014|3023799003;
X-Microsoft-Antispam-Message-Info:
	i72FRP+ko0OU0mWpM1kmjfcNPewgUUzAn77Wqf4eJz+LovjfvPEGTghsx3qwkAb32FFtGFGPvSHETtCxu0AH7a7sdcnnRqmNwZGuJpzcGckHxVci8D35YPnCnExK446/T182xymWJyxqo4OqOnOvzvSxzFtIjCcQB2HHyDB+H9OoYcVgGdsHiBsjZskkntQRECKfuWR+tBE2jqGtI71CeqHQqhxFEzTK/PxiVkkr7iTuWDEinUoX8RzPG4f+3Ik6m55TcunqU5srOttPqCQyqV6LSz2xN0YhwnEZ+9OUobYTKmwE/Jg/7ISX7YQK6GTHQJcVsqQEViHepcYORYxuF4Yj58koPXZBgNBF/jjbGrOMUA1TNAjUm0aRFheSky9oRQPWKUSWGyl5YEqtqybHFYbUQq1fUtR+9MDRRIbLZPBvR+eyHOCYPIyM2WOCck95f+vXZYe/hJ1D7ObNIHjEDUBk9LhspLi8Th+DwSnI5koQdOMPjYzT+HAnNsahE/FX2RkD3bP5kiic/tJgkEdEscnDqg9XaWYqSXo4b6NwKL6HnyVyjwV1lXOhqAaKPl7I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(56012099003)(18002099003)(22082099003)(38350700014)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n0cBSbonTq3EE5FyXpaUOAdDA5nmTPv11TtJRnXT6WR+EVyuHjWwgx7iM+Pb?=
 =?us-ascii?Q?iyRtiTfT70eYtAH26ASyywn75LXajPFYDRsrNRIdWgC3hNjOXqiDYDQkerfr?=
 =?us-ascii?Q?aLODkDYP6mZhserIpHxU1oQm7fOPnDVVmxbdoqanTtnUf8CXMwRy6UWipkoT?=
 =?us-ascii?Q?GnLO8CJDLDlu1JFMaNpfBckSOqVy2QIa2BBxOC3lnZYxkEQsExhmoR7OzWiT?=
 =?us-ascii?Q?zt1Z+FmV83dBRb+Wwma9M3hgJGLmHt3aSJ+mGM8dniMZApICMj3uW3uZ66Ok?=
 =?us-ascii?Q?vER+u+fFHwSbMQmZukYBc4X2jD+Uv8iIElDlO7Ht2ZHaGlvSrQ5v0mMoDnF9?=
 =?us-ascii?Q?BTLPvbYtNFjRR0b2LAiyXud5pNGa/RYrdA9KH2TzndW0ArpiS6kPmB4LE9o+?=
 =?us-ascii?Q?9b/nsDC7IPL/u8+HtThAztk6UebtHGw1KVEYDIvrv63n+3COHAmR8aE0qSdP?=
 =?us-ascii?Q?CIHWQDjlrTTp8IUGkPzLXirNaOsQjjnF2tHpsuQIJqMZKNlR2ZQByU6HgAji?=
 =?us-ascii?Q?dWyChPqnLxqGjT0s5wxre5zFksl2i3whwDZQUjCSqEc+ramGYFk1rmMjIs3a?=
 =?us-ascii?Q?5Bqoi0D62AaNDUlegZVuXXIX1HhBE64DLE0JVT+SzymKq7GiF6YxzI4LPjJf?=
 =?us-ascii?Q?MYuaC0CDexeU5/3tC5Dabr2lGjpbV9cXT1COmRb9ggWVuLGdpAzhFJN6qzOQ?=
 =?us-ascii?Q?Z6nT3rVbqQZN+eStylBA8gLbFopTZTEtOd8+IF0/rbscR8y10TIkfHgrihDd?=
 =?us-ascii?Q?PqBvy12PDA5BJpRXkXtRMhQV0P2oqzBuuHVPFpD7wbnuGCRYGZdLsY7ZsmgW?=
 =?us-ascii?Q?3o6ijistqbjAwf/U0Bg8NmiZS4hpht80AYZhz5TzWMHUvPJO7JMw+pD1pkNO?=
 =?us-ascii?Q?VUfE/5+rlpMjKJtIgab9H8oFzJPDe3kIJCywTLqOi+DNIUtmNwkoQxFXpYyh?=
 =?us-ascii?Q?FMkOlfVvuslRIUaEKbAE7jjveINBVQg8S0AOpC6PElKOs00Jfe3ni3SKycUH?=
 =?us-ascii?Q?hetD2T+S/jsba5n6nIxdxei/OVJo58ddGhgcTg5pxx8HOiVhd5iyzTfSZXsf?=
 =?us-ascii?Q?hKdV4SaR9OiCHFUnfINDI2xJMaGhOzkp0N3ae+TX0uLoaO1oFSQbwhORjReP?=
 =?us-ascii?Q?U/a8fduuq/AV87AazapzaVFKn3TBMXB6By+tOssUZKOteN0xMrfYqCXjH6cL?=
 =?us-ascii?Q?05cyMLNFfxxia+TuetgWpwCfFkcdEmb8yrQiwfzs4HpzJYNjOQZw/fC2JV9x?=
 =?us-ascii?Q?MctY8VqAlEZx69jjTAtOcuRXH3RcaISLC4kRp9b1/mc1+LnPax1id1E3EMe4?=
 =?us-ascii?Q?knVkupBmEb0OGxLL9Zq/tetwJ3MOcHJI4Vb7xHm4paSM1nfSbNghgonknjkM?=
 =?us-ascii?Q?6B4zrH/6jIi1u/C4yCPI4x8YFkHwLcEHPzmcBecGw3HjLkyhAoW1qCKg9iH3?=
 =?us-ascii?Q?726LJZkLvALsWW3hZ/ChawRJa1rWt7emDjC7V2qpO4a6fZYxhL3uvSx7WXuB?=
 =?us-ascii?Q?KIf1h2pYB2MeE+FnezI1SWbp5AU/ZZA3gQIQIGdAwXsr14iTkVCY5VSSF+Es?=
 =?us-ascii?Q?WhIW+cZhwPuTdvf7H89ewoRTB8JSfOXPUjlBp/MdpxDjLvZLul/Xw4ks792j?=
 =?us-ascii?Q?4kLYIWGec7IKnGAFFgSE0LhXP0n6JI+54+gVx/IK3HoBGytz4shkE7bQDFpS?=
 =?us-ascii?Q?nv8yhVF9dYlXtQp8Qa+LOosQQkRgE6hWlovfimcfHvqHg1LJjIKOeWUUoFvG?=
 =?us-ascii?Q?ee+atyaLwhA0+bO4AxwUlvJJpp32M3o=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06aca4b-2e62-4d6a-f177-08deb2457519
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 05:47:32.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PjZL1uUOLCV6BN+/WbCpKkSN+7EGRl6jie6fHP4HGTVuu85TjVtKY6JNr2vlkiwFBRjSkrUXIymp9/bYCYfy3ifpSIuXqRPPWmmR1oS9EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1276
X-Rspamd-Queue-Id: B471354A95D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8880-lists,linux-pwm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.190.149.16:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devicetree.org:url,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Action: no action

Each of the StarFive JH7100/JH7110/JH8100 SoCs has 8 OpenCores PTC IP
cores. One OpenCores PTC IP core can output one PWM channel. The only
difference among them is the register base address. There is no need
to add starfive compatibles to distinguish them.

I will maintain the pwm module in place of William.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../devicetree/bindings/pwm/opencores,pwm.yaml         | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
index 52a59d245cdb..834fb17ec595 100644
--- a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: OpenCores PWM controller
 
 maintainers:
-  - William Qiu <william.qiu@starfivetech.com>
+  - Hal Feng <hal.feng@starfivetech.com>
 
 description:
   The OpenCores PTC ip core contains a PWM controller. When operating in PWM
@@ -20,10 +20,6 @@ allOf:
 properties:
   compatible:
     items:
-      - enum:
-          - starfive,jh7100-pwm
-          - starfive,jh7110-pwm
-          - starfive,jh8100-pwm
       - const: opencores,pwm-v1
 
   reg:
@@ -48,8 +44,8 @@ additionalProperties: false
 examples:
   - |
     pwm@12490000 {
-        compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
-        reg = <0x12490000 0x10000>;
+        compatible = "opencores,pwm-v1";
+        reg = <0x12490000 0x10>;
         clocks = <&clkgen 181>;
         resets = <&rstgen 109>;
         #pwm-cells = <3>;
-- 
2.43.2


