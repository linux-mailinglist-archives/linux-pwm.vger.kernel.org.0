Return-Path: <linux-pwm+bounces-9507-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DBrVEEzsRGo03QoAu9opvQ
	(envelope-from <linux-pwm+bounces-9507-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 12:30:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2E96EC298
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 12:30:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9507-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9507-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEF2E303129F
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B7C40C5D4;
	Wed,  1 Jul 2026 10:20:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BBB40801E;
	Wed,  1 Jul 2026 10:20:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901232; cv=fail; b=oxr/1Vc4IU/SNLL50+PpejLz+WGjwJAW2/psOiQTqJbH4a/g80DfO/OPoYZIbaEN4pYqqM83fibBrGLrsldGUxYCaJoIK2BR4SP/dLcNysNQ55g0DYyXtJhf1njECflLmO1iHrZf283oeqozq7AUbmY+z6Y9L3W9oYDx4lqm+/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901232; c=relaxed/simple;
	bh=11LLsd8v/iKCSo4bV2NQM8dnGyS+MLkzJp81qnhMwdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Km7+WV9k8gF5+NGkfJ3Ed5H1r8PvYpi8jkZSuUVIdagE1SzZj95gsMx0JKdqjW8cZ9NP3BmpuECKFNpznEH29EDMCt1mpEelx0wGPWzMqXTSVdl8Ngtl5nTKYFHDgbRIGAuu7P/zYFrw8dQhoY93K3H4zs5mhgAXXcnah1PdieA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSut3H1JeZhJUUsGyYWUUPYfqhM0mJJp2rKC4NDpp9hA3V/1elytWm7SMCrnfCcmK1GFbPK8j4317grsAkq5Bp1Aq0Z7dMUqmLOiwj0bzZ+4IAm3WXBsOt8uqCi1bqAPGh9rgqsZhpUYuQ9pNog/N8CsWVrniUrzZupQC9zA+HAB/1dhN8JsjW5KU/gcOmTE/OcHsy9sOOMLJ5OGHBY29OIjxxTM+E3CCXVSUuRCbQiLFTE0B79zhH97B/IzP62TAM4sx2WXOAzzSQk8ASzJOqDlhlRr/qzg4GD80w7DNOc5i5mfILtm6fh+DCe24eYRpr6EM9yWabIRFKSh1MS8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YBV86v3nflUO674Q+hvLcTmmy+Ukq1Nv/1bEE7q5W8=;
 b=iTtlf2xXkTPccfDqoFBFlCRXgYgJyP3ygnAB7NGXpQcjCfQI8jUu+l4m9AAVJOOz13arq/8Rk3A0j8C+8of3UMn3gPafjQhuPrZTskH/Kf8IhApbTC7GNtdYC+GzF4ddNHMCB30VrgUC6o243tQkXt9BhM5G016B7CkKklZgAe3k4BNRBbqmAea5KltYf5MSKslh1oRc+c0Fo0lh7Ol3m138XlhHwvKWrol7MzkIXQoCbKG+JQjI2GV/bMR2GiXPkUKuB7uopj7PVbXrBtVWCBNyRSgp8KDvPhVc3g21wo5rQQchIjzTJU7aFVHVP2DfExS0bSWz6ZLqTXwDoQfuMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.25; Wed, 1 Jul
 2026 07:44:50 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0139.024; Wed, 1 Jul 2026 07:44:50 +0000
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
Subject: [PATCH v21 1/3] dt-bindings: pwm: opencores: Update compatibles, examples and maintainers
Date: Wed,  1 Jul 2026 15:44:40 +0800
Message-ID: <20260701074442.7714-2-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 592f924f-8be6-4bf6-e0ee-08ded744a1be
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|23010399003|7416014|376014|1800799024|38350700014|22082099003|3023799007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	FGvCEY6V/I99GKpXo4xStdzXYG8/nK2Vv740UQGSz/gTd+T8Klnavr3WqSKSVYSfJ5sNRR+S9kbnYZgQdc7msb/Dz/1vQuFKsi8AViHDyH96SKVMTNMsT7UoIrE1hKmJ9JkbCGWWD7e21gWnojzE3wWRn98b9ihJSB6gxMpKzIetswXXNuosI2sschMAxAqr5TGNrcE3JcMSVNR38LLWxZL7rk/2KCYlYOqfOD4EM9E7RA3TU7BIEscmqPGWh3x82K9O8OTiw64LGAHYhuMBBOeahKeqJ0yaafCFJapMTrqLjxWE1FGpgwY/gQ1B1m8uWai+QX/rvUlVDll7LWelD6N/ZIjWTc5UJzkZLG0hhneL1RzNQzMRNqgV1Ya/THCV/onEK/RBrOAjXa/YFapjBdAyZQ/j3XYLAz42ysKemxpBIGmolVv7VC56DawGJB0jSqZkXavqZO4/F8SzapHsvtk0MCPxedTnXrpRMpf6EgEOhR4GN44rQbjgJ4WSyYGVK2rehryiFSnITpaqcyRLN6tcEewZVR0zxBCOeMZeJj8c6/1LlbF9jj59sX8FkD7n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(23010399003)(7416014)(376014)(1800799024)(38350700014)(22082099003)(3023799007)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SjLDGiShlVwjK58byUWj9Qsc4xI+/Y2guQCwx7ausRZQnjdi9i31rcK446nC?=
 =?us-ascii?Q?pM0SoATo+Rp3Lj2ZOfG91CGo7PTi4MUcQs7wk63+tx8FdlOcfuIfardwn7Ss?=
 =?us-ascii?Q?GTu43HY2Y1/jIwskkHhpPxra+aIoFoles3WHjMj5R8lP+3N2iKtHmhv3JB8+?=
 =?us-ascii?Q?DTTmr61Ly4hVtXX97cwobcqcnq3wKk9DECyUcsn89kJvwOZJ+w62r2PrBRt5?=
 =?us-ascii?Q?AwAp1XeXTorcUDx2l7db/qHSvEeh/1M6WUoX1cLe4hvYghqt7ZbBNGzPZAPs?=
 =?us-ascii?Q?q31OfItAB/MiPW747EC6RYWKPVUucWwt9GhBod26pWPjsAa1NJy3YwJ1D9yL?=
 =?us-ascii?Q?Was9CSZfIAr3MsntnX9IHYsv0MdWl2nsMrAKsc9RdzEqAlMsMekXkADS5n3U?=
 =?us-ascii?Q?7L9bVkemt405AjZf65sfgfCuxfsajxSzkILSigdVA3iZnoh1ak1xlx6L47oz?=
 =?us-ascii?Q?D5bFApH3cZ3tjcrxzcFH+SH9ePiuZ3E6Dku8wDX01b7gOuols4pBZnn06ozP?=
 =?us-ascii?Q?8M3ik4GfZ5fcJLuo5C+8FmkubVYOTTyd6+4pTmqKBuMrDc/CRvpGvJuGuBcE?=
 =?us-ascii?Q?0f86KssB5H8VVVtAdXH/hhQtKKvVjRsmv92P8gmMrl/7PfB9ipgHsc2tVVhz?=
 =?us-ascii?Q?U9RZXVPs/e3DkpJTzvPeL2BIo0AZFf/zEeOIxGBo7BZV3g/95h4UpMXuldhu?=
 =?us-ascii?Q?clBcJQcOIZGS4mUkrtVfvZSsszjjLufO7yJpQLFWVfopmqV3pE2HeFykE+aG?=
 =?us-ascii?Q?PFDbbdpOB+mah0wXwygJIqJS2+2vbHSlnn6HC9JkunIunMU20ZJ8xIxyt/5k?=
 =?us-ascii?Q?vHeEVJz7S4BqzDrZrx8cW/EcT0Xjnct12vFYZZSlvMEHXpSZ0KidVaOLKAXq?=
 =?us-ascii?Q?wWnlim5Dd9BzkDWkFvjqkTctdlEnuPcaQl4BYl2A6JUkTt7VkE2+38tfnuO6?=
 =?us-ascii?Q?GF5EUEgJSiPht05385ArZRyLO2rLfpJSfStKEa9s6xDAKNG8/zId1iJ1lQ0g?=
 =?us-ascii?Q?ygD3bowhhHQHh0gNkvoRa9afAJXAmGG+FNyvrRshqLL3FyYqkc3ia468zIDp?=
 =?us-ascii?Q?legy4p3RcmwyQ6SAIKFiQ3o9MTv7e3n6g+Qr1sFS8Z9vXsO8XyH5avBsI+4z?=
 =?us-ascii?Q?vhAMgdUzJ8BZRn72/7rrEnd9OU+2qtp5TcOa9xP6/IhUyAOaXlZtVDqKm6fj?=
 =?us-ascii?Q?5pRsgJDU6yB6H5nk1a331w66gTlMiEPSjxxUs/xwv7iBUL32vV03pbDrHVST?=
 =?us-ascii?Q?Y0QvDFJjjMVFCCHe0MXcIZoq6IxMhIZSBfqo1Uxyxmn4y2juPQNvAbferddk?=
 =?us-ascii?Q?/6sn2zWTRRFpL6QbcRipIloi7T8Y6Of08C3tJuo4s4Y3ckVfClah9pbSvSZp?=
 =?us-ascii?Q?WGZwzuSQUoFeJd1E1RrnroMLRvY+vjhkUicsSO8Q+R/xBxQWC8NdwEnP0fAf?=
 =?us-ascii?Q?uNoAuUhz25wdT5i7VbC69ra29LpNKOxwd4acz23ThInVaYYVt6kLu5dobYB1?=
 =?us-ascii?Q?Ufz/Zdm/yS2lZ34mp+ttJkC+x7M56ZpYp+C+j50TBxKgUwZoigHjORJlqZWn?=
 =?us-ascii?Q?m8i2rfpRUOZ588givfXn1ggUIcnYLYZdaz2dZwYJKs70yzbrVoSJW4YHwn4f?=
 =?us-ascii?Q?EwK+zmUih6dqXPo9YryDUfcwmLCcg4d5z5pIwKbzu5e04/qtqzseE2I44Po+?=
 =?us-ascii?Q?hFyB9yjtDGIg+KUslNYie3IOgZrHofgqLwxXflnNGRqR1tA76Ij8KL6jGhqh?=
 =?us-ascii?Q?WG6BpElm10WBja8OODs5tEKGgX2N4VA=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592f924f-8be6-4bf6-e0ee-08ded744a1be
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:44:50.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A62TTCKo3UuTwulE+1ynFaL/2Ye9Mw0KgFZB9JAB42gw8K1kTscdcDf0TibaGAQJfP4z4tU+EOMJuAhwtd3pp54jcRlgcK70WRmuKq4Pgzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1307
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-9507-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,vger.kernel.org:from_smtp,starfivetech.com:email,starfivetech.com:mid,starfivetech.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA2E96EC298

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


