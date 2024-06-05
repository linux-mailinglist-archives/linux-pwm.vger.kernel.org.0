Return-Path: <linux-pwm+bounces-2362-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C37E78FD999
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Jun 2024 00:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30EE1C2136A
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 22:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB815F336;
	Wed,  5 Jun 2024 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lbPD2+o5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D773C28;
	Wed,  5 Jun 2024 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717625341; cv=fail; b=iD4Lwr0qi6PDSp9INNAeUKmwd4vw88gl+WjCgYkV1AqjreVL0SBb/BaGi1/3iX/ZMOH5hwv9+KACebhmiZ10kI7DprEkCACy7opivzRKMD+eFTcPG1qkXVF+jK8FEUoRUdBNlOS/jcwAygUAhW6fTcfK7hV+Gj1lDadZAXy5nyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717625341; c=relaxed/simple;
	bh=sVqT303cHbrY8hhnp/dRF6G/RR/ninmVMFzoWLmexPA=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Qc3MrJ9ed3iFOYwsCg+s5fqAfSb5kfs44Ihzzh4rnDJP1FSCN2p7Hljs9W4t0Rg51PrqiDqeS5gjCsZV+i6HAIc8eVhJpp1IHa3zUh1yWCE5BHKsOFzh+wKQfM801AdV2H0wZq0rBI7mfJsCaTm4ZX3YcozXAoGcCAYB7g7eFLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lbPD2+o5; arc=fail smtp.client-ip=40.107.7.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYNv/JPd2gyvM490oURU+Ux3IswYEvKdKcXtil/LWozOyvDlIAmzdjqafyePnzYwY0Y1G4HcAVcu9NQF5bO6nNbQ26IokTBu0AxQ+iE8qFm2ClJ1LpEX36NzuKwNvBiL0CxYUGbQzg5qK53fTqSWub6LmHfbXmab+JYV+Aq+VY/CRcf0DpFkcC5mtW1qlXl2/mpBcbUshM8aHtiMemCWml/CZ+RwjqQUuR8KoCbbiKR7dX1+41VEd0tZW9EZ+bkezinWDnS/K0kcnyD4+pSOOfcBGo1bzHC/G+Nc8DR77ZvKRCQmICRAVzKD+G7qGZcs/ALKoNRoCrnEnZ1Uytxm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDBE7bXM4txmGinastI/UVRuEQgMmBd7WGfUGsa/GNs=;
 b=EddKsnLLdgo9jqj7WMyYyAEMx0Ueauvi++FXLZi7SHVi4cKfdJHLBJbEbCD2OAZC71D594MVBIG9fdcUz3r6LcRrRjpSqbklmS+Fol4crN5OqVcRa12XrDimte0E+EkXJMR4hq7xthivFwvBmuHJiKZFGmTKm4/gdc7RTO5jhibHaWJ6O+bDeZ8VCf+SidADKzpcW5cHwkqk7pj7UE6/+sx5M4XDEqSxWkA06+8tzzqDhZdsDMU4ahVa3Jr0JHseJcs6O1YpDaanranaU/2+KO+OVlSyQGna9gHqDrS4U0jf7eNy9RSwRUB9dGbti7L2hgg0YPfJ67lpcqABilbwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDBE7bXM4txmGinastI/UVRuEQgMmBd7WGfUGsa/GNs=;
 b=lbPD2+o5VbYnIuVW313s0bC1g08Sox+EibtErUko+JGGrRLulqzAtAVB/VlfvdA5+1UyS4RTwfyodfwuXnGG/ua7GHR3tpzP3f+u8aZ5DKypVmmApknl7pVMzBXY6jgNeHpxtpmRz174lI4vKj6MZWRs+RATRs/USsRkfuDJ/cU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10718.eurprd04.prod.outlook.com (2603:10a6:10:58f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 22:08:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 22:08:56 +0000
From: Frank Li <Frank.Li@nxp.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] dt-bindings: pwm: imx: remove interrupt proptery from required
Date: Wed,  5 Jun 2024 18:08:39 -0400
Message-Id: <20240605220839.1398872-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:a03:333::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10718:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd8e8f5-7a1c-405c-b05f-08dc85ac17ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|52116005|1800799015|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oz/bKgQBMqti2qN+RhqQVuDVUs4lNS/KXJV29PxZHfplK4vMtQrQIfVS6OQM?=
 =?us-ascii?Q?t6WeZ8zNhBKfxzYEtVM/bHIJ2J9r/oOv3A3A1sSaAXUk8QoXdrgu8RTlJKLD?=
 =?us-ascii?Q?G43IFpr5itWNE1Bdjy5HX1G2eGysvBdkWY1KlWZZGpnMq8yE2IK3EVmlPkeE?=
 =?us-ascii?Q?8f9EoA/VDs0C349FgLJHzdpAz5J0SFt/F4h741l+cgHeT9aIujZq7yeUgQLB?=
 =?us-ascii?Q?6yR+3tm/QItssrf83bbhXt7ZFOK/z7M+CArJsz0lMbpk28BQpbYKv7DN11g4?=
 =?us-ascii?Q?x8m6JevF1HzcpOokR5TtNxGu3Rr3p22wTXlsjg31D/R+prez+mKbi3TmgeDQ?=
 =?us-ascii?Q?FPXwfMyk5+gdvAxUNNj9ZTUwR7Z3tzRFVW3o6r5NJKQ3N2xLxdLgLj0/uN36?=
 =?us-ascii?Q?dq9pePmwc3LtjdU4+Yt6Tmd+M1yauHqbbG1B/+RYQZaZs2sdXzOZdm6GhFVi?=
 =?us-ascii?Q?fzaEC6OHlYHsqGG2FnU8xq7al6e+/NjBwFDXKEZYfUlo03wK4hxhwPPp6D7S?=
 =?us-ascii?Q?+u8ND4aY0Biti7vC7/l9bJZ7rCvbjcLbjygOoMAQQLtNaGhrq2qbv/3R8LBR?=
 =?us-ascii?Q?oqGo1qP61w3KjYkcViQ8kPn9KbO8tFKvCaBxhuQD9ifpB7C8PsuK0qq2VruZ?=
 =?us-ascii?Q?Wu/yfp6cX+VetY5q0+0RUgEtG7lUzi0YUfMP7Y4+ieSSvYNq8+LMrtoO5gV6?=
 =?us-ascii?Q?Y0d6Rj0zsqihfHZ8aouWut6eUGtGLovYlEV3ccaFIsGehfbKSOOQyOVrccxG?=
 =?us-ascii?Q?2yO2lSHpu2ZWzHJZV+6F9kAYvbWlSD8Z9OVd5bvKb8n2P9eDo9q6EnBPBDUN?=
 =?us-ascii?Q?tv3zd0Nsq6J0aOX/LX7JNFjZxs0DceE0SSTH19e41DgIEjMdV2o/Y+obQwfT?=
 =?us-ascii?Q?Pke9cNR0dV2UcWn0xdsVcMyNjKh8MIt5+bjwkiPFTXKZVOzUO91TzRVR8fj0?=
 =?us-ascii?Q?tCECTQoBXQxE6mcBXlL6bnr1/gHsn63bx+7NoLVK1iHg+iWWbDbMhNIWXmaC?=
 =?us-ascii?Q?b4j6dQF3SL6MSGElYrY8mk2bc6P8Wa0sNeVoz9qRClWJkHzN2+xq7ud6k9N+?=
 =?us-ascii?Q?4iJKtukLSrusCz42HnhBNjl5dcyqjhpJM8IxAvTCORZtiEbg313mHmWsu6qn?=
 =?us-ascii?Q?C+1u+beLXAeVaZL2UIq7mJ1cvtTLCY798y8lpuGHgCwWH9cQWp4QR7YxhVbi?=
 =?us-ascii?Q?506JefI1uCyjSafPzXIWDzWTGrkJ9qBbGbfdxsP/YRZiCEYqTUXgDEin0uIw?=
 =?us-ascii?Q?seKhlA0LpbML30W+GbUVynAF0cLDD7Y/pdnS5Kekj84dZr1SQ6dRTUPAbV+l?=
 =?us-ascii?Q?oaKtnGktLn1tDk76mP7djAeOVVEYogOuOEbsgc/fyGdQZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gw9/SsesfFQswsjY/ax7YPUod0ftxVeE/R3/Rvfs6ktOc34nVEW9kZ2DccoU?=
 =?us-ascii?Q?7FEs4xtO+b60MAX48GGMY4E2zMEamzX2QcJnoZ6jiV5SleLVR7eKWYi0NS9p?=
 =?us-ascii?Q?F+sGmsrG7wIzEE5gBOaDncmePMELx0IdXds3FMH/004kaHd7JG+QbBbJ3JiZ?=
 =?us-ascii?Q?B+SItVRuJm/ODT02gLamBOX2jkOku4+LPM/RB843ij+0ibFo+QM/JfghaBkv?=
 =?us-ascii?Q?qf42PZ/L41MRdWbrR2lcoS4k70N4qwjSvm9nqN8Nr3gGb6qGxx8p9P34Yq4N?=
 =?us-ascii?Q?Zc747F5HBN/1QHU3WtLIgGwAjU1vHSC5CvS9jW6O6UM21oxOkGQMbak8UpaS?=
 =?us-ascii?Q?K4QgpoBXb4xFe2TZz7EfRnKsLygR4GAvrkYf3WYYwSpUI7dpPbgDMb96o77+?=
 =?us-ascii?Q?Qjw6YbqS0cmYyEVnW1Y0aALO6hOMjeDooRc17qS0pipdMe4GWoA2VU6zwMTx?=
 =?us-ascii?Q?JhyxQrU4LxMi6pX8XrxgA/KDx1L8JBkcrKl87iRzDQI45O0FA7OsnR1MspB9?=
 =?us-ascii?Q?+Gy/UxYgc2setxG0ZP1S0AogMDaWoOWk6Py8ThvYlgQvMNPyUbvpjW+LXbqi?=
 =?us-ascii?Q?O71Ay8o2lrz7pvNKpJwN51T4Leg4asotFW1X9swr7WrjNwojr9nTigFujUiX?=
 =?us-ascii?Q?9uGiXHvFqy1WcY1E/9F3y75SsrRXRyMWKTJFXlL7QvJzq3CW110f7J7oG93C?=
 =?us-ascii?Q?nzii+hK2yEu20Kl/s2sFWX9gxA2NXCPW1kk+Y1YB2PvHLQN2DbcOM7Lkkgmz?=
 =?us-ascii?Q?Qr2wmqGVIrkwRfcevJDyGhiVRv1tKaBQqmEG994XCGTMIWRrUMPGJ+QTB48g?=
 =?us-ascii?Q?0Quao4Fle9FlgUcFWrYCpggkSA8xpKYRYS6wqSqXYNP/zwwLrRCccv6IRmdJ?=
 =?us-ascii?Q?h5ymUN61r2/KtHnPXL8UMrrjmTUvkJUc9Zcjy7jpDeY5rwmpcp7PojcWbPfI?=
 =?us-ascii?Q?G7TwTwihb6LBK+vnm+tG9y1LVP4hG4pH6MoUObFEkGYUSCfsDeUbsJVlOyPg?=
 =?us-ascii?Q?ZkGvJeeYWqrdML6m11Z8AA/RHIpG83TTGnvJsBMzKknMB7nR/1Bv8iZxxzpr?=
 =?us-ascii?Q?mL/PSjjt55fcHaOVWd9UWPaVx1EXVnz8ardanjStLPwIC83x/Mw8Xocf0HUg?=
 =?us-ascii?Q?4CRJCEhe1LvLJO0uxH+PKPnwkPEOkVSDMup2VvGUzaBfFkZ50vcic1YcCR6Q?=
 =?us-ascii?Q?P8HrUWoFzZBEJSXcYFwj860Lvm0h0dUjIU9bIwwaASvSf9KwaVvpds4dqs6O?=
 =?us-ascii?Q?Hv36bs2CgfNdiH4FUd9MeHv95gdczsTfXsQnQRN1P7eJ/q8IoKBWX4pAbrW3?=
 =?us-ascii?Q?7Pz5qZO0uE53lEVetq5B2GiUF0g/DPA22ecU65Rtik5wP+jN4d3m9scKoBdQ?=
 =?us-ascii?Q?yRpjq7IOGXUgO1PzSl8GjMUg7liS4dzwwkKCxyFItIUZwJ7pSXzUKsZvgdmr?=
 =?us-ascii?Q?49gsR6EqIIhz0/Z3GZQ6XpMflR7ZAQ90+XJQRXv/YCblMW1HCl7x+PmsI7DP?=
 =?us-ascii?Q?xjzB/iKRYbsKKVPwiBfDehCCzj2SmgcTppmMVMtDh3ZLbhuP7nwtriUH1aNu?=
 =?us-ascii?Q?92SuZv1TNa+XqqfHYeQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd8e8f5-7a1c-405c-b05f-08dc85ac17ba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 22:08:56.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlfLDEya3jmbfplOwN0n3cQHh6EHm4jdJpcOJQBNMZnUNtQHchM310htGAhxG4XPCiP9ae9Nqdt27gVZ56Rmxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10718

The driver "drivers/pwm/pwm-imx27.c" never use interrupt. Generally pwm
hardware generate a waveform according to register timing setting. Needn't
interrupt handle at all. So remove it from "required" list.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
index a84a240a61dc1..04148198e34d0 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -68,7 +68,6 @@ required:
   - reg
   - clocks
   - clock-names
-  - interrupts
 
 additionalProperties: false
 
-- 
2.34.1


