Return-Path: <linux-pwm+bounces-3058-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F88961C75
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Aug 2024 05:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66BDEB2117F
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Aug 2024 03:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172636A33C;
	Wed, 28 Aug 2024 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DsDFvKJU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E188BFC;
	Wed, 28 Aug 2024 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814217; cv=fail; b=UT+jkEml/burJuZAPeoUTmJ7Ymeyhqm9sw++6sWPR1E9HBEblACkplPGuho5gzrzkGqH+pz8TuCRYNlj8Lu201vy+Fd5EKDJVsUIlu7focxozoKi6+ggXCsrDno1ySH2uyamGubz8x/8Yu+WfgmJrUWNrAZQJ30E7Qp+zoAtVOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814217; c=relaxed/simple;
	bh=oGnS98lPhxczB6mDNEqYznk5hD/tpVTboa3OaF6wPM4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kUudnHNDYS7Yk/1Ua1Mao7sEW0MCeyAfF3/TCEPjZ1tuWw07ccVN6jAErluf8Wbl4BWiIXpc8SGDs32dtKhjyXNv4HTTS8AeaAwQ54D8jZDtHs+9+50BY67ob/Ud8pS5mWu36S7arLgV54RXiIGS1uJZpgUYFNhmU19AFeD6ovQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DsDFvKJU; arc=fail smtp.client-ip=52.101.65.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BR5Ybcdnbxf/jHlmS1z/qLFkAwk10v6ofNiPaqWsq9ptfW+jkVA60LxFDIxJLsCRcusl2baBVIXJSCfos7aLnVDi1aGQmpAIYQAJSq+N2Pa6czbF+KMSQ37X1nIgvg7UAP8iDT/GLx3lPKUWrTHg3hxUzywh4fTycCmJTvvO2IDMrn+RzTrma68s2Rf/ZVyYPmLht1A4bcYB4ElJBLHXQ+LfWk76G1jXG9BGB0h3pPOCXCRdti9pvTMHLWBJnxvuQ+V1H0en51b/w0tB54hbfKR2ciOcDpRxUpFkGuiqGBDzDaHpaYqLWFN7XGShzAPDTLMWMeL2tUNSQ4yhgFDquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wv29+WwzOerN4PtyS4OgAEeHrN9UH0oW88kxAAmhyPM=;
 b=JFYuH2mDoQ3arWn9RpK938qRzMp2YnFQyC75akFlwQ3NCZthI3UtlCImYq3Jh5KRNj6oD+Hg3RYzB/vsk6yoPqEnQ40JHmf0j/b1QfkiIGlFJDGKQdllTIdRCEPO3utzYpAQl0cdLpJ7Zpjow7u6Hz+Q7p1L+Z/LdFJ+y9vbVQDBksFjwen4ulB39ZQlnX1i8I/A7k+KnHCFWcvBuSCb348VyEiKaTrJrox/5PIrpO3Gwbxadb+Y6jGEZ9p1QNCnxE0L79m8w5pPYx8awpAue855efS1P0KIGAsN2XKGMYh4qPaxTOqNQMgkWcpR84M3A/Wf1pzADSNCB14cBQsxYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv29+WwzOerN4PtyS4OgAEeHrN9UH0oW88kxAAmhyPM=;
 b=DsDFvKJUCGhD7MA1O4QEwCs2aULqohwH5ID96SfFmdVMYUWSEbTkiLgrkgn78YysGM4VhNC83iG5y2jznwV/6AoqfISgHG3cCHnHYL7lUWEKnQl734BCixgHPMGNr11wqh8IiBSW+ObMyN3KSL8wgZHnhaTd5YxLjfWklzUZr5HcLwLfiAF7UW5tik8AXPWP5/7hmytpwzswa2Ck4b05baja/QeAxTsoADDMJ9Fwnj1iIUtFEQQf7S/xfj9j/fNdsPms5nJPSxbFejTn4jbEQNJiNrH0HHPaq8rINMeONvCovYiw+g24eVK7pGqimL7XAd0gNRYtmJ46laD65Gj9dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM8PR04MB7761.eurprd04.prod.outlook.com (2603:10a6:20b:248::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 03:03:32 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 03:03:32 +0000
From: haibo.chen@nxp.com
To: laurent.pinchart@ideasonboard.com,
	lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2] dt-bindings: mfd: adp5585: Add parsing of hogs
Date: Wed, 28 Aug 2024 11:04:05 +0800
Message-Id: <20240828030405.2851611-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AM8PR04MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 44368176-7b32-4c9b-6962-08dcc70dffb6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?WQgfAOf/j9lu8DHBA8tdEftGjKiDkbTj3nGEGGZEUw8t7NeV/vqDzmfAvIej?=
 =?us-ascii?Q?apTy6aE/3vGYuP5eCbs3FHJR1ghK1tMPXlIslL+oQxaLi79tMaHCQWp2aHJS?=
 =?us-ascii?Q?IyoDsZNa3giqDtuvMboMFTHh93HQyzHJtFGVbQzdw8mY5O+SBuXR6x75X5Ot?=
 =?us-ascii?Q?Zc8L5786abfOX6qlxDYpEtRAqFOZwtIfn4bkrKOP/JKur62S8wh9RJ3vlHbZ?=
 =?us-ascii?Q?1ZVzw2iwkoNFqNKa07TiWqNmcrPE73hiCFtRiOQihwU4ggjJo89VgpjjjZNr?=
 =?us-ascii?Q?u7JLQ5qBqKNTFtvi1YznTo4W5wFkId1pqxZ7lZce6x+4ncTIvPFbUSU1HS7m?=
 =?us-ascii?Q?brdiq6+nNhktlKrTV0YcnRFZgBdYxZ3GAx71QRrlhhGS0q9LUwKZQcxi/Z2t?=
 =?us-ascii?Q?DQGmidPI0oO4z8/RwbU1+ydKos3OdXwqF98sg4lFxFDJsJgjD3iZecLs4N7x?=
 =?us-ascii?Q?QnMvBRdkvab0HLWjVL2bPJayqcsS8Hrdawsir8DSZJtUEtRczrDDmrpuGoiy?=
 =?us-ascii?Q?LspDkdz2OxvkLTRRwdFcxQrby5aTzpwzDpYSvGoGIX72uFtR9AHgboDH3MAw?=
 =?us-ascii?Q?K8BAAR2E+KRsS2DVYftywq/Vyk1dppmyxHeQmMLxJQO6HfYIrWY3oqLEOTIF?=
 =?us-ascii?Q?iKaNc375WLadZBIOjKMc9g3q8E9DsO0o6b9CiHT4hEeI9NWT1Swqt/Uv4cpI?=
 =?us-ascii?Q?7mMVUvSgq4qhU50tuto1Q0Xfz7JYcRnNJLc/JDCSTIaUGCaf0t9Yuf97DuJ2?=
 =?us-ascii?Q?Z9UFYzghxS5rQSwlsuiTCscQEHF7qTFuYFws57BhM9e4vsNIfXsq8Ze9ZTkq?=
 =?us-ascii?Q?VTtjy7+OJWQEcfyOTwwySrm5v4KzakLQREjMLEPofk9W/TAVpiq2Z/gmAoT4?=
 =?us-ascii?Q?ck846hT3pKLB+NsOmJpbW7Qh15LNw6RWRlwSyqaVLRA7J5yHU7avTH7Cklgf?=
 =?us-ascii?Q?kU95rJUDJdpOPPeJjOGXLI2RE3oR/DdvsV5gDxk24AH7rRxPpkyuB7k3iCDG?=
 =?us-ascii?Q?2UbG4TWDoXFzF+Yimbq6QXTkEqeAuScW+AbYGhbIYnUG6vPLKjD9tSGNlS4V?=
 =?us-ascii?Q?RGbbmkF6setMB9oIAKzyXXoI0hCCIlLcwcIxJ4vHurj6qgiqTM4KAUTLlS1c?=
 =?us-ascii?Q?FAeemqFvnACvL6onx3i95vGykhFFurz9NImDZdqKJEKR/8WghFRu/kfVLNXF?=
 =?us-ascii?Q?vqreNlc2NDcV0WrP8uYfu8YnQsTcEqanOLD8CsVBfRhCZtdewn1k0hVM1OrY?=
 =?us-ascii?Q?+GFPZa9xHKsSB2vMiWD0/n6AFYkE6nQmjnza/4dSNRrbtCodxoM7tofpClDK?=
 =?us-ascii?Q?uwWrlR/r+18shViWAGv+HUKjSofi37NR40fV8oPT9UsliK5wltGW9mEpmrYd?=
 =?us-ascii?Q?JGmc852cG4TROOCk/JRQmxxOyLQ1CrAEy/TPGygFv8ayz2WqcA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?H0kgvCdm7Nzdr5bm6M2o7KTtsWBjkeuQTYVb94jJut+v26nB19GzE82P7yJv?=
 =?us-ascii?Q?40rp/3nTl3LKEmP6IyaPTOxs8wYrIN7ghIkU8mLn/yBdTHCI9crpDYY+KM+V?=
 =?us-ascii?Q?+hF/v6LaovMqWbi1pRH4gTppi5BI9KI6n3/LBe0hn5YQI8dvOoL/TFbymm20?=
 =?us-ascii?Q?GoHZN/IsKLzvOxwBrmBztUv0uOhtHQQ+nKGOS6i5qdBFGoVKyWbUZ9NFJOcH?=
 =?us-ascii?Q?NHZuklOh45RAMMjgGc0nQRy/p9KLsbNQR7a+++UpebXfrVMhmEahoCLG3rxD?=
 =?us-ascii?Q?nuY0KhI5eJQldJEFyxkpIsFtv1jN6JxcQopYLDvQXBE6X4G0teI+K1fp9fHr?=
 =?us-ascii?Q?NcvBKYIS6yyI1e6aEHey1/2NaXAXgkNuY/G4rl8TbTu7Asj1VGjJIYjPR0Ih?=
 =?us-ascii?Q?rqvr0+A8AsNZxlZVwoNcSvbN1IUIG5y5a+3ugHZXQlVb5dI9kO3oV3TQSaZY?=
 =?us-ascii?Q?8Gl5fy3iKei8xobPBtRgCGnIWtEUgjGHyt4HAfviCOpGOoOtpNtar18qr8Q8?=
 =?us-ascii?Q?+/Yl3ofcg7eTBJ7+uajazTdET1Nd+x6szSGw0aONeW3eFN0C94o2dOSerNBS?=
 =?us-ascii?Q?B+s8jpV3iX6B21YILztdt69aHlA/P4a8dPb74mwZYT0tOiPFjp6MIi1KamUC?=
 =?us-ascii?Q?vE3xl2NiDvYEwpudbfuapNGR4t+yI1tSQ/zd8pzS5cH1nsJHQgD3axnh/sdE?=
 =?us-ascii?Q?EcLZKhMy/Tv/HAEUqirek0Vc0y85kPTcw6qqDnfQwCtXJ+x8vq3ExEUQ0cFP?=
 =?us-ascii?Q?d5bkWxd5qrWt5+Fn/nFUFtEgFZLw//fFb4BydJuaAw5Ieh4EW6bN7eaujesB?=
 =?us-ascii?Q?KXFLZk5OLisN0MNcAdrAyjyu4CrkMiI8FlLjG5YxqY7KEqH9Dkx6Bwy1GXK3?=
 =?us-ascii?Q?8qzyqGFpGI1CYF4K9qBU/efNsZEeOW4XUbiVwGM24EHig0kTbqjvS4BNMbUh?=
 =?us-ascii?Q?w+d/r5pkSF8Ts4gXXn8y86xoSV3W7nTvaWXnumzMKJ1N+K3+Gu4QGEb6tid5?=
 =?us-ascii?Q?Po32QpZuL7wZgsiIWTTi/cv+m1Krv9lHP1JpRiay4dARfu1MlkC8eaWrju2R?=
 =?us-ascii?Q?O9sNaJe0Ex/6M9bBrgBaBDBK0NSi3YPgrb2+vsr9aMKzFp9a/HwT4YO5uMWr?=
 =?us-ascii?Q?BBDW2ij7XjkCqGbb9gIgZztZp33ZhE6vRBwztZ83FRxbI1flJNN3m4UGT38s?=
 =?us-ascii?Q?zML0Es2+FGTNzn2OKdaht4qIh34wuKmuUT6dEtMfeej3aACLRZJhXRuL6Hsw?=
 =?us-ascii?Q?eox2oxnTaMkVzMr8/Ey5ckjocMjn9o0BE6VZFfsZI+OnZxi+dDz8h/+a3bJG?=
 =?us-ascii?Q?umxlptIENzXSR+2sZG58Bc36qq9TTai7n4DMDEyXuZkt5jPDBqbbOk14zIkh?=
 =?us-ascii?Q?zaJH60yTMDo8muH7ODSuUPIinPtj3ABwiWhT6Xhv/mIOIk1QZeXIMhTSFZh+?=
 =?us-ascii?Q?O15cEGoKSzdY+/EzQ1mCo8OZE6regWCHnzJjWZ/lsxv94KR2+dyz07rzDo0G?=
 =?us-ascii?Q?E4OAL9aVqQebI0v48gBGrKMMDtW+5Oynu/lMY0uxRZbI+nSssyiyC6sGWZ7W?=
 =?us-ascii?Q?Scz9Fm48O55QXWmrJEixtkh7BoFFb2JrR/no1s4Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44368176-7b32-4c9b-6962-08dcc70dffb6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 03:03:32.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AvcWZlSwkRoGzupTIFv8L1tYli90oM7rRuZztkxllZD3YlLnCNjmFlNsScD7ejxou4CPJTW0VkwxkCHHmb2Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7761

From: Haibo Chen <haibo.chen@nxp.com>

Allow parsing GPIO controller children nodes with GPIO hogs.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
index f9c069f8534b..ee2272f754a3 100644
--- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
+++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
@@ -42,6 +42,13 @@ properties:
   "#pwm-cells":
     const: 3
 
+patternProperties:
+  "-hog(-[0-9]+)?$":
+    type: object
+
+    required:
+      - gpio-hog
+
 required:
   - compatible
   - reg
-- 
2.34.1


