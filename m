Return-Path: <linux-pwm+bounces-9707-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mij7GLzDVWp0sgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9707-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 07:06:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D9775104A
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 07:06:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9707-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9707-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D743302F0FD
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 05:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C4E2EB859;
	Tue, 14 Jul 2026 05:06:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2134.outbound.protection.partner.outlook.cn [139.219.146.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F72D8DCA;
	Tue, 14 Jul 2026 05:05:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005561; cv=fail; b=uTT1ghiw4Gs8xAKosAU8sJy5R3xhH/25WfGR6mw01L5aX+hA6DpFP+/NUiC7shtJy+/uNT8dwPNzyQh7nhYP2gwHUN0m9RdMjgKkht+0JzsPC4fM/soKLG0VUNzI/enUvJypWY4UZwWSBlXYwamiB6PMubBAOts+FL63hHaPRR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005561; c=relaxed/simple;
	bh=11LLsd8v/iKCSo4bV2NQM8dnGyS+MLkzJp81qnhMwdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CQjqyoNiXaxlsj6b5IsAKLxQdz7Ddaiy6rMFixOY8blnbDg5o4lOuZdO0shNFQzrX0uywUw5rDAiWlnPrmVbSN6RAkQmFVMXps1fRjRgcxAZJdyIJ78yeoXBOhppS17Eb1tuzFNKH6Nk71mPA859uEKXUwzbSuX7i8+tDOJyZ5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.134
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLPmgrDGplrZd45yd/Mcopx7+PeZWTGSDZsmK8q7dm+6g0seKFEXFL9QhDBpflUrTX/vUnu2wbwsXOus168kmTJfxioKBU1a6++6/JOUcd3kGXCv3R4Jqw6Dv8i8k0XoOacRSdTS9oHRMx/B0+6nhKg+m3MYuEzYeyJt3mwn4uvRBfR7Uaizy8m7by4qEKqhkbwULQSdLqYPUhJRgT71UTqvzMp9S6Xz5xv2jyZWfL+eO8a9c/dhS5OlmhZbsmWahMTvEuldP/Gjxx2ILQWPGdfHGLQikDcZFcz7YkINnoyfJMq6dev0CKd2zoL7W9uv8+n1O8yl7cvDWwBkV0FFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YBV86v3nflUO674Q+hvLcTmmy+Ukq1Nv/1bEE7q5W8=;
 b=F/7GCyrjqRqacCzBcKGU80I5NIa3QxPlGkNWTRWwqDdGx7hytOHDvhGkcJhew5ervT/hUmEXkCddCc7wSapFl5/CDa1NmqEF/tDc/aQZP+0mz8h8ItTtKxtAq2uVmYKZ+7UMcvShl+KPvThQJ4337P/WqGQXBWiwU3W/URDnvgLcNXE9r4Dcecq/QX9RS8STOXEX9JJc3rbMkVOEf1L5w6rG4VLpz3f29J2e3sTmAflkHmi6U/cv7jZR1h9KUt7W3pHyIzMexkcAMyPcXmDN8L7TFJsmP8+NpeaGO4d+wloGVJbuD1ov9Yk6WWCMkTYCT7pfXMNZYDRjpvkiEZj5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1324.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Tue, 14 Jul
 2026 03:30:59 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0139.024; Tue, 14 Jul 2026 03:30:59 +0000
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
Subject: [PATCH v22 1/3] dt-bindings: pwm: opencores: Update compatibles, examples and maintainers
Date: Tue, 14 Jul 2026 11:30:48 +0800
Message-ID: <20260714033050.44952-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260714033050.44952-1-hal.feng@starfivetech.com>
References: <20260714033050.44952-1-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0abcb16a-01ff-4a7f-e9b4-08dee15852bd
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|56012099006|38350700014|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	WYKJyw/80O4GuZvZKFWuQSjoOwTcJG4pXILX6FD5C2t7L9JfEoE146eLmF3vUlhLGLfP0UVf1m5oDor3iEc2O02SzzVDsSk9n4P/Uk+f4Ux8nlpBa1LFDTin6g/+CbAJMWFn8RK9Gr4GyjiFyr7eTNXUUZ66yYlVnF7Ag3T1w7Hbe+5ZhCc80ReO1tjWnx6IwGDBi8EgMb3ylt2QPh66bmC3F0k+j1EDM9c1ghZfKfGTfsnyAfCVo/Q+L1Y83Xf8FZi6NRPREeQ24TTbDE7neXghcQn15AlOgfcdH4Jsit7FQJkIg8+K+i07u10alUl649/4p3DUA9lNJFFO76PtxQgjODgnImDOTDDbRFCWlR5sO0PRdfHZwYMtUFP/XEkzWn1FHaqrpq1GHiP58We4SBqrfG2Mnblk1NeNtD4ocvNPWieSrMQxLyJPBDObOEOaWTupkkhBCtQouxI2pnB6EF0J4aJXsM99+F9bhRy98SWQPqOuvj/dcVWCD1vj7eaIJUTCgRpHVSLzyjoWpIbxhaWwoQHGKzWCVJjQeZ8gk3HrK6X6rfA9ctOLKDmDGgEw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(56012099006)(38350700014)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mxlG+hbSVbypQzHdsCkTRjw3YjpGf5RKZtijerFz2Ts63pI1VGTTFaloUPqq?=
 =?us-ascii?Q?ApbV+GSCPIf0nwpNWauYHLVBhHI6BiRp3I3BmfRNOElSEN+VYvrA0bAX4zqs?=
 =?us-ascii?Q?1XePzQAtHIia5nDYJoR1u3nSv7pJSa/eB8Ajlyla51q0svWkqILbIgFb/aRL?=
 =?us-ascii?Q?a0WVQjDiKhA0/lORqoWsMVTAVa8FSMiCZm5xoyYheu0Rb8OtP8YJuRLp7V4D?=
 =?us-ascii?Q?0co9mecenOmgjTtg7nTGDj6Et9rGOL3dIed/hk/cQGRsRQLV2M4YCMQMu7w5?=
 =?us-ascii?Q?mBciFEbK48z9rEbnkfK0Aqz1JWaCeuFnMdyIU707mwi/frS+WLboI303F0cv?=
 =?us-ascii?Q?UeMLtVQZRD2T4j51fqDz5Q9HZThrHQBGY5gq0npij6ZbPvkjAc98EasN8RsA?=
 =?us-ascii?Q?bNWGS/GEazKOVEfvFt1s9FFhZxnKPK5/7/wv8kkv1yFrG9XmnUEKtq1gb1RY?=
 =?us-ascii?Q?IbMWUQnR1NRXPTaLb9W+pqrJvklisH0OfYu5iJgVGaozfkjfvP3RoCQtc4V7?=
 =?us-ascii?Q?PRt6ro81zdnudSyltc313habxzh5rNzV8TrKw5jAh5NHe0ZHLbE5KYev0bzC?=
 =?us-ascii?Q?01kQBIjjswXrdLq18sKooW0RsSbxoHTh5AmpmIoiPz8I3SMGEftVRGcaE9H5?=
 =?us-ascii?Q?dc2Qhyn4K72DRaiBEc48thAsTet7KaQp981EtJ2zqgqVPwLKyfTBS0Dgjsuh?=
 =?us-ascii?Q?mnsKGz4x36uFHCrgdUvB3WBkP1P/aZOmOb+mx6+PusiyJ3UVQB/9UrhtUuu7?=
 =?us-ascii?Q?ivzxLg3W6pVQY1W2V5LKSl3mknVzlVtfHdNpMpy7+tdUDeKPyEE8eXU7WvF0?=
 =?us-ascii?Q?Pa1rFFjHMt7/jS8vM9HoIlMLPvMpk41TUBqOnh0rSGhafDoMMQhGq+cE/KP1?=
 =?us-ascii?Q?go0FlM92z8mjbbRB/761ksJnuF+hqVG/eXWRKkbW2bMvTbVEARK0N111CvXM?=
 =?us-ascii?Q?7b0CNuatHrB171GjLpsAI/yIA2+jt5drWUF1G8HXSeTzFXc+nzgkY0tHCbgE?=
 =?us-ascii?Q?7eOxX+uhfwnCbcm9kDw0F/w8WXLOtye1RpP/3SIhs0pMMKbKSWC7Gw8MTcx0?=
 =?us-ascii?Q?GZO3bPweOh8J/dH7nCqgWNDGuNIWBC9FgL4A+zCVSkQEQtB4KQWyklnGbz1v?=
 =?us-ascii?Q?GHqVcbQtw14wfjH7wWf0Xynkp9mBfY57279wtZcdFAG+0fXyhTYsqFO4KrOl?=
 =?us-ascii?Q?mAblqpk9B2RjjpmdBkfudAjf2I9gth4l6b64h8Yiiaf39TKe/4OB5YJYeFfU?=
 =?us-ascii?Q?KQ79AIevKrTBcaCs5m6SdetuBtCZksjlStMS5/G9cUvvqj4PaSByXuxQEcgs?=
 =?us-ascii?Q?x64+NWu2uVXRhUYNl1ISauQ+0MKvuI73JQXD4G0CwvcpilzS+VmWwNt/8/eL?=
 =?us-ascii?Q?YgZE2cdkyMH299ank9tcqu9veJMetM3AlF003ejlgbPgY9kCcmf1M3t4Tud7?=
 =?us-ascii?Q?Nre/yYgy+3l0xdoifqwZyuXAsjNdogHGkdPV8ksRkgte25L/keIZ9GTMyzqY?=
 =?us-ascii?Q?Ft2gr3toQzTNKF8itavow1iAL1Xb6jrdMRbDDhptM2MiWXoMsij7hBvJ+wOB?=
 =?us-ascii?Q?VXNdtNqpF8l9ZyebwVX58hTJH321MJUDn1sJDx0f0hRE58DKilj63QEuR61I?=
 =?us-ascii?Q?IGTJWfsKnsh5E+SnHvDrESWMrmojC7Wxpa2Af+wHhg7+BkJ+GjdVGjollGJ1?=
 =?us-ascii?Q?JK+sGvX/36/yr59INMAWakvo2b2aGRxUfbyLpkp7dRFhgazc1Q743VmPkmf5?=
 =?us-ascii?Q?JotVGIFZE7KExjxNv5uUhVjW8vxxCXc=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abcb16a-01ff-4a7f-e9b4-08dee15852bd
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 03:30:59.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBoOOjzl+NkMz33Ya1kBkmNK66HImR9D2Ni5Ur4HXfw6ap/E8BIOs1XyODncnPi6JpQ01uE5fXIgZhAjDPO9AMzxkX7aRuLBu80Pt/nqZ00=
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
	GREYLIST(0.00)[pass,meta];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:p.zabel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor@kernel.org,m:emil.renner.berthing@canonical.com,m:palmer@dabbelt.com,m:pjw@kernel.org,m:aou@eecs.berkeley.edu,m:hal.feng@starfivetech.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9707-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:from_mime,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94D9775104A

Remove the jh8100 compatible since the JH8100 SoC has been canceled and
will not be released. Add the jhb100 compatible to replace it.

Change the register size in examples to 0x10, since an OpenCores PTC IP
has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.

I will maintain this pwm module in place of William.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Fixes: 2529085831b0 ("dt-bindings: pwm: Add bindings for OpenCores PWM Controller")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 Documentation/devicetree/bindings/pwm/opencores,pwm.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
index 52a59d245cdb..42c5d2b6326d 100644
--- a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: OpenCores PWM controller
 
 maintainers:
-  - William Qiu <william.qiu@starfivetech.com>
+  - Hal Feng <hal.feng@starfivetech.com>
 
 description:
   The OpenCores PTC ip core contains a PWM controller. When operating in PWM
@@ -23,7 +23,7 @@ properties:
       - enum:
           - starfive,jh7100-pwm
           - starfive,jh7110-pwm
-          - starfive,jh8100-pwm
+          - starfive,jhb100-pwm
       - const: opencores,pwm-v1
 
   reg:
@@ -49,7 +49,7 @@ examples:
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


