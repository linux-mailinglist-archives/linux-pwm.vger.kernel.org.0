Return-Path: <linux-pwm+bounces-9293-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HbznHKAnMGqSPAUAu9opvQ
	(envelope-from <linux-pwm+bounces-9293-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 18:26:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 713FE68856A
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 18:26:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9293-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9293-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E995305C9F9
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04A340B370;
	Mon, 15 Jun 2026 16:12:38 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2101.outbound.protection.partner.outlook.cn [139.219.17.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845CF40910F;
	Mon, 15 Jun 2026 16:12:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539958; cv=fail; b=KdbwbwVAViW5T7D41pAphIwMxrMcY4UZISekcvHz1fuPEdnnDXUxbYVwx7FDxQ2VueY3+QDd3z+iwXOdvfQdcp8UtJwigi4/xFR8BqZqbFZG6f9QIpU/cIQ2scPmDqrFDeYfd25JoJXxRRSBgq2ZENx/Pnh3ANNOt5l72+vNOwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539958; c=relaxed/simple;
	bh=0fO3KfRUVuLOSEOhBPTm/acSlbr2Rj+XF5JEoMnfAUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NMVVIIKKhiQpnQYPcYasLvuM/TYIHZNOBr/dFhM9n1G0e1sK0Np6xeCcV63WcdRzeSRjfj4sogSHa6J3Y3rJ5qxZ47okbvwA+If9m7CywDU8BJx2NHXpFPYMVb/qKk7BOBv40zZPruLflI6fVFkk340+eIG1yu5hesIukKS3eaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnrNx8PdQ8Ns4UHpTx7tjc7IPfkLr65ENiSRpLQe7WJk5n/qCNprgzfvbcoAzwjFJV3JjoULHqcI07serL6v10vUeQDbRBjW8rT+esyvNdfa/fZmg1eCS031bJCI1ex3yOmDwhxV0aZpKA+LqJHxQdLrxN2gE1l4XRvwln6P4wyz3agw/uxy1OtBx+LUn/3O2SdsuHrtFMv8zQ+gkzrwP2k0wC5uNnRgyErvNSx9Y7TKbng/gyq9Dc3KQz1V94b2MqoOhJ09dehEp30TCWhrLLY3mjgLf+Q0fdbe9cbA2O08gJNTdC/BLYsLTrzoHwTJC53L2sTyFxtDgIpcnKtnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnLGp4EDeyZWcAIEmKd6NEfR/2g0u4pFyM/Hghphics=;
 b=E8xKeQzs49bJEdfdaOMkwholvB+pF9HHkBDbxIa4ei2xXnJZAPXYguv0WVI4mexYILd3IB/J9l1tVLgdpWy3ntzZiAms2bsgx6GW9zezQacSrQwpdyuajyKaXkbKmGmhofoKpIi4aY/J+uHqY0QSAmB0hxWV9mAFUKu0IQyOo6szyhZC5pEpLOlpldBxEaCsOth7k1dcdNJfoiAayLddCzmEAgKoNRSywIIO1AFwCCXU5Hr3Hd+IXvCZQgJbgOI/N792GNX2pfFyfA7v3GLzedRAF6F2cSowRpENMhTORmwvV5TXze1mVkwOrSN0GdHsU7iiWlK3YDW9RZtu+YyfNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1321.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:58:07 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0113.015; Mon, 15 Jun 2026 15:58:07 +0000
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
Subject: [PATCH v19 1/3] dt-bindings: pwm: opencores: Update compatibles, examples and maintainers
Date: Mon, 15 Jun 2026 23:57:57 +0800
Message-ID: <20260615155759.129210-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260615155759.129210-1-hal.feng@starfivetech.com>
References: <20260615155759.129210-1-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: c10f85b4-d397-4958-e39b-08decaf6e45e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|23010399003|38350700014|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	y6xOEbkWwFbjzl4Q9gjdG1s4hySzjzClQyr8dauliZEOekylBE5cFCX7thB1FnQ/uqjpMG7vgxg3ALt3RCbF3XOnGsrCvn8v9ZY5yNTpAlwglExmnxa4w7ConlMdg68Kaml0HwyycTR1FhwXBHShbkO4u3NX+gKxr5nUt6aKPPPw8X6lvBLKCsxAI0AALnfropwW1gn4+kLu4WuZWRnZ1R2hzU+OrHsT6sMS8dMNlh4mlTpZbldmTPC0hu9kGeewCROtFF0zsksGQkpNAt1p9ZoDCU/aXmqBi4XUWkPih5fiSy0eLZPkXfqzpP2biInsFr0NBxAtN1PpuqGQVt4mR8Tv6sxzOmJXrBn7wctHbLNn04wSTp+kLKWK6NQr5rDBiD8k6oRAqsUFzlhH5vTBN8F1Kjne8J5GaJetHyCOoey7apr9xNSlTVZP8qYCJeIGs4C640Qh0a3naD8ZRj5c0fpjWrXyO9WcuU8gHkszyTZyG77hdkJv6H/h5sOdxFkmWqykwbaLjZ1NaZ1Q4qkJYvPLJLvAIDy+SUZ/R1rsuu+MBtdzj/o8IJgoj3p7pI4W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(23010399003)(38350700014)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aRAYprCFV9pkfWPS6NuT+14Pc8AIVckg759bOtZHPgQfCPOqzBuuBT4wUwUq?=
 =?us-ascii?Q?MgeJlXhuueP9Q4x87w3rXAryOo2fkPhT6FPDmjq0iyqo+9PK0g6zAowpe5nA?=
 =?us-ascii?Q?M/GHFgfZziSuAliLpgk1FsQu0DSH0MCdxT8/TeUHnOZOQhDCq0udZObm5D6n?=
 =?us-ascii?Q?aTUUnHk9owVf0PWtGqq5UhgASuA6GLxXPbD4w69cCmPar56GYFMSSVJ1JLDz?=
 =?us-ascii?Q?vTm8Dz/KscjiAqsixIgNvsSZTPhoZzvxGHlMWpYS/qKC6+7eWUy89HG+6psl?=
 =?us-ascii?Q?8Ei4fdNqQfgi63mO4jtV4zdOj2lMZiSUQS6fHEGbIQyUjj1nxiCFRi36oMcy?=
 =?us-ascii?Q?GWJcIb0mm/aC8ZcKKv1AvqKVVZ1o6fOTvMajvkWMgI8WADhhRIwCr+DwN7d8?=
 =?us-ascii?Q?T72Wx674Jvu9eP6LW2268HuBzsNcuW5BL83ROydaZQ3yRcNfaGoBn81rAfpv?=
 =?us-ascii?Q?jE6by9Kd/a75llHe7gWG9eS8OrRa+nQQwfRZYPM/U6knY0HvRHTrwZfUA7zO?=
 =?us-ascii?Q?a9Bv+7qMeQN6FV13Y1dnL7+iI1Psdu/3q4UkqLYqLAfcW6dWNKwm9Cn4SlAu?=
 =?us-ascii?Q?CkRPSWt1m1oXUIw0kcvFM97pph/txCNqDUg7mtrGHZMduaeY5o+H8hoCR31+?=
 =?us-ascii?Q?saBlTop8V0rnE/C6NM3EePXTsiOJ1ePGIHopxoZFiG3i0FQnWgcl6Nh+vm1D?=
 =?us-ascii?Q?MrVOICVzE3NJEtfzFWLUzKMrqm2qLm7NdlE+zO9LFH7hXYQQk+BEqFXOz4OW?=
 =?us-ascii?Q?4G4hp3M5N0KqPpd3FFiqyUqm8oXPxoB5pM3UOlxO7XvuwKsFYxN0PnU9dqIR?=
 =?us-ascii?Q?tlJh3irQA6BuGtUkHSnoWgmxXMt4I9G1AJzPHDRmrE2IiFiUJbzVwjGDjFDA?=
 =?us-ascii?Q?lgzdmwqsQZXcBbC5vooQpau0RWPz5HKIGJhicmbHRARzAhYIhGNfhRbYJxOY?=
 =?us-ascii?Q?Ux6AiOjZdZktgQ6vswv8jYfr4t7Po2pdPph9pUeVq8kOZha3EfClvWigh1kE?=
 =?us-ascii?Q?VqoRYSLJBx/+lWRjRXw6F9vz2+rwKdaHN6VtWhNYpMu5Ijk8e/FIEsNnGV0D?=
 =?us-ascii?Q?INrOJttkSUEjI7R4l8bNXM0kOpLwXhjBmiAB0bwo+cQnxDo11rXufOKDzjW/?=
 =?us-ascii?Q?Q8BividtBSGkDwLEs6xpxmKLfJlhV2RAaYiw3v4G9NSaed4+Ufv36+rZwojF?=
 =?us-ascii?Q?GfamgPWzw1CEnb7AxIyedI7LsboU+0dk0rDS+P314vDZPgRWLx4JaIYZ90N5?=
 =?us-ascii?Q?s//J7jAa9VMTpvCnMozrrHbSGGujxZs7l0GT8R4QX7xT8XuZfQ3Gqco1Lj1e?=
 =?us-ascii?Q?Wh4YFfz4swbRod92TeS0Pagq/MP6rjjtH79mpDBJDg53XAeXGfPFQNugtuVu?=
 =?us-ascii?Q?7t7XpWICav1PO3J3w0VL3bbR7s2dtrE1lBQHb5vLQ6ngxhIa4fU+jOohmnkE?=
 =?us-ascii?Q?wGe8jBSzj+4AfJ4W56lH2ZWUMiwj09Wulis527DK5SdlM8hXkB/9isTk7C4g?=
 =?us-ascii?Q?t3CPWcpCHs2VOafP/u95w1PgSNYlOvPFOWNeB/Pbb5rAquw9OKTriD0OGhU4?=
 =?us-ascii?Q?5UUIbm5X1/Drc6ZnnovtsbHtJhbEd7pUQOGFRtY3gTbRi37iu7lRegewfmHp?=
 =?us-ascii?Q?IjEYMNCmTpIGut/fjSOGfzp88LiB3Z9u/8Vh8xWgdFpJE0WrW+KgPT+6NPaT?=
 =?us-ascii?Q?Vu38vAM7Prjk8AILAlKGAwuavOgq4hLmkDNgMemIYrzOlgNqubzFBosfXSJk?=
 =?us-ascii?Q?bVDqDnQ4txwxILXxMSAtAhFkgroHqkw=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10f85b4-d397-4958-e39b-08decaf6e45e
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:58:07.6553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3SahtCM2FfddoVD6JkuC979qTWxXH9hr62dWhJiGbKmCtilGKmK0amaGLN3FDty676K42O1EObDP6F16K/oqXw3UZLi0B0IAjibjDFSKCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1321
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-9293-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,starfivetech.com:email,starfivetech.com:mid,starfivetech.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 713FE68856A

Remove the jh8100 compatible since the JH8100 SoC has been canceled and
will not be released. Add the jhb100 compatible to replace it.
Use a oneOf construct to support the single-string opencores,pwm-v1
compatible.

Change the register size in examples to 0x10, since an OpenCores PTC IP
has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.

I will maintain this pwm module in place of William.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../devicetree/bindings/pwm/opencores,pwm.yaml   | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
index 52a59d245cdb..5f05606a2d3d 100644
--- a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: OpenCores PWM controller
 
 maintainers:
-  - William Qiu <william.qiu@starfivetech.com>
+  - Hal Feng <hal.feng@starfivetech.com>
 
 description:
   The OpenCores PTC ip core contains a PWM controller. When operating in PWM
@@ -19,12 +19,14 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - starfive,jh7100-pwm
-          - starfive,jh7110-pwm
-          - starfive,jh8100-pwm
+    oneOf:
       - const: opencores,pwm-v1
+      - items:
+        - enum:
+            - starfive,jh7100-pwm
+            - starfive,jh7110-pwm
+            - starfive,jhb100-pwm
+        - const: opencores,pwm-v1
 
   reg:
     maxItems: 1
@@ -49,7 +51,7 @@ examples:
   - |
     pwm@12490000 {
         compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
-        reg = <0x12490000 0x10000>;
+        reg = <0x12490000 0x10>;
         clocks = <&clkgen 181>;
         resets = <&rstgen 109>;
         #pwm-cells = <3>;
-- 
2.43.2


