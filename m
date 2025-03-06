Return-Path: <linux-pwm+bounces-5112-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F05CAA5526A
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Mar 2025 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5525016BE7D
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Mar 2025 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF8D25A637;
	Thu,  6 Mar 2025 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fd1tddVz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E025A2D1;
	Thu,  6 Mar 2025 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280943; cv=fail; b=oaujAoez+gpYokqTYGx7t4N3uCYwvCEwlcBrHjAz1Fe6XmZMDJtL9yW0iFKToh+eVX/st3lv8+tqiVqX4/YSdwboZQWOiqQxVY8AUzNi8+mNRWVTpvKFy3T42/vg0TDWnn7K6v85pEdGP0v/o+3H0MN1pu1ldBYOxO/N4Zb58V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280943; c=relaxed/simple;
	bh=3dcaabYW3YZFr4PLR4tsAt2eT5XbVYC7j9UgDNSu/rE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lJeZpVNP9hgdaoR1W4gj+UfnNVhPe5kyW9F4UZjzVTBUU24HeOg807DaNCZFpYOP85gbZkyOQOdzuQLKAGDU1rzWt7HRk451lfuIUYGu5hdbqdzJEQzTFiIFidcYd8KJZT/njhmfEFKcwVchIfZUddZLkdXJ9ry04X+a+Fle6QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fd1tddVz; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ya/1EuoLs1QfxP1RTcEghwMzj0oXQV0Ru2RvCiaCVyVWD0cNvCh3iKawRp0rslQXEyO92mJD3JsExEZBBO0YJgF+X4I2skcP8Ve96MZVhiIp0GPJmKkpcHe/2hSX9Fq0RYHcR4jMZuOkiFVRuSGtwnZKW27oqd5V2P3yiIuyUV7c8zI32vf2DTI8yr4mjY/GenSHV1ZWLC+xy3+WXqJymL/FPzPjfJ+cIztYYFVFJDx1/WZIAauoXjgxA7JQoAJsYrksKdxBUBp6KmoD1p8CQCQszkskZyIp6bMjLegV6de671R3p3Cgp132ZCGuwkxhFSentpqEdiplda7rdOHbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8r463Ph4XMAxEo7yNWLnGIKZmih9dHIfDuT1XPFT6A=;
 b=JF6/G8rB/JHjy5tS4lnGS/WbbsK4+bi//c7wPNUbgV7xPFd2UYOK7qadnHH//xdqS3ER5XowSxLBRcIAvm1YSTwkYA1A76QCr38JgVucUfEwsoodjgT7DQ2MstL6389f4SZMsQKXORX6t1b2IFVCfRFc5AXhOwBHXpjmw+BO7H5BtPHRS3DaU/KL6rm/xji0qb3o5Cdxm1p/PhH4olBcdXliQYMvaykQ8DlvFj//DSKKqfcnj3ZWxze9eD1JHdycJ539fFp+yOcyi8GoXHxjty8FpTBnJR5jOFId/zI95aUUZAWnTLA+Mx3oC85bKLnZug6jESnps3P4DQaIRPCiTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8r463Ph4XMAxEo7yNWLnGIKZmih9dHIfDuT1XPFT6A=;
 b=fd1tddVzEd80yFHo2sOKiRsR4Qg2PJY5sE2CwOUDJjj6nopFp7fXdHTXQoUdxxqdOzs7bpc4sl2AYRnn7ITklpz7FCNB8/CSuh65UaZMSCHHdzIFY91GAHnLNv01CBQx6+L0sP0JJcgEue+FL+uKMiP9FWCluratKF9dGyGO4IzLhN6wnafdnIzVF6YsrVhY7ao5rUqnF6SK6P0mviqo570ljjrbnxpZ0mTX0vjzvPE8LOOcHq5H1hYCAHEWKoSU6DoRXLZnz2k9aFqKn0U0fWIee5bbm2aE6tLBZAlmX68mOMb2g3kjNq+6wAoyQW9CqAe6iBmLWvObD9uAc9vPXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9179.eurprd04.prod.outlook.com (2603:10a6:10:2f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 17:08:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:08:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH] dt-bindings: pwm: imx: Add i.MX93, i.MX94 and i.MX95 support
Date: Thu,  6 Mar 2025 12:08:45 -0500
Message-Id: <20250306170845.240555-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c4d63a-b4ee-4c37-4a4b-08dd5cd19601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xm7p7K3HXTQq3Z1wOWNqpyXLt4ZAB3RukInJA1QlZ83xHBcwVQ7xpmPsyDsC?=
 =?us-ascii?Q?JwSlXaX/IcJX8UogOIK1J94OthUMsU1dKHIDz9oF/OBTqK2JwppjMIK6ApLo?=
 =?us-ascii?Q?UCFSu8K0o8mpqfpSN2s4NIw1I/OT76/o+T8cvfERZzej4zrytyrgaz2albEh?=
 =?us-ascii?Q?OtX7dUrHTmNfA67ySN0Ic4SoJflKZRlQLXB8onC4L5rbFOgvihPwHUMX9gkm?=
 =?us-ascii?Q?eUyHvFirZ4XQYZRcHsqExr36T1zafr48Sew/s2E8YTv3kZDllSYXYaZHO6ac?=
 =?us-ascii?Q?i6ghpIeeQSnukVdiq3pg9vP85wb18Nmo+ByqSOcW/LxqGHshjPyTOQJwiLeW?=
 =?us-ascii?Q?65b17a55p7Q1S2ON5KIKqKpdNJ2DPfK+jP79aJrq3Vj4EXc0BevNSjzunz5z?=
 =?us-ascii?Q?N5mqTtHx9O/U5t3beLch+w9TPYAlNCAyGwyp32AbgB34FRRIGUD2FdyHo1gb?=
 =?us-ascii?Q?7SSSXZv8w3abTzXdqBJTVpE0aSPu6EzjuPvG/P6dhMBAEYZDDkJo5RU43bfR?=
 =?us-ascii?Q?ZwbbaebBx9s78M6Islj+l5Eea1stx43XMe9aSlRwHreZas+nrVrMEXhgj6YZ?=
 =?us-ascii?Q?lh+ajCN+L1/ClBEr3R/rVSQJyTYzxt2gU9kLPyJtvWHJwEzecKb3NM9ZGop2?=
 =?us-ascii?Q?Z4C1zy/G+D33YKv+bStdUzo3LlW8T6j/VP3vzDNbluU2huNBSSN58JFanHeO?=
 =?us-ascii?Q?g5GGi/MQefvpT9wt4Xmszgb2kuT7wootW1viZyk1JsRH/wHOTNPle59AXmg7?=
 =?us-ascii?Q?+fX/qXW16Njx1llFXoY5pOtKfyeFIVGXckDK9XN3a0I2ZKR79dy/JvuUIY8m?=
 =?us-ascii?Q?awSVizDsMwKtylN4sF4UGl7Ci+cbNfTKz8vbrwDwDGcWBHJDAJBCbxHYPJje?=
 =?us-ascii?Q?RrpQVazyglq9FYM6MRO/zx3CEZJj9im69Mnd5BDkz/0xJtBeOxKjVOuvZfsR?=
 =?us-ascii?Q?41PD9JmB7hzJmSt/ZYeaGaI1pbq61E6XtuQjqAaBxymkRxd6yQnLzAQ6AuiT?=
 =?us-ascii?Q?tlxlmYMSZs5QFhP6+M1OfjPoBXLWU7m78cwL6SOaw78ChjzieU3EKIod4IV3?=
 =?us-ascii?Q?lqEZ9JrLDGgC/t5vwJbeEMzxRYqubSu0c7R0TeXAVO57qIIzC5gJMQ13jdvh?=
 =?us-ascii?Q?0sM/zU6NXTuqRdzIEW9wGyFavqY78Z4TuWxqZnuIJrBPD+fvmQry7FH2qi8I?=
 =?us-ascii?Q?9GmvL4V0NFpgRFPv9t4CplIieqNeha9GAal1MrA+uBOY2S4VVa5Z/063Q7BF?=
 =?us-ascii?Q?Y7kZIe7YrXublngjoLBTq5uc5vJTK814otqiCkcUod4hYYEjb0J/AgW0VSOT?=
 =?us-ascii?Q?SeqOZS5S4NmxPe8LUUmqKQJdNlJ0U1jZ9NrUGhURCCm43apxnbOC0KuzzNlG?=
 =?us-ascii?Q?y8LLyuZKKVuSCwgd/5XMpQGSGFCDzWdtSoWzmmIlJHTs8jy3WpnCyhh//GLZ?=
 =?us-ascii?Q?+3Bq03CirT4hEtSXIpCL97XB1uLWaAMI+C83mjAf+i29UhgL8P40qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wkvd5iqeUaXJ9jGjSCwVeUd3Uu+P1/tI+YD5H5PIDWnO9/oNDmM3sfOfkBze?=
 =?us-ascii?Q?9eGDjjFUhJ46xnw2xhVPhCqa62kiAie4PxV11ifyTbsUZ5P/hPYNf87SzZS6?=
 =?us-ascii?Q?7nJ51peKTP4ASHIGVXyOMbG33XdwpNfHOq97itTdSaTMQ5B00IzMiDefFE3v?=
 =?us-ascii?Q?lXJeEqK2LrAxkm/t5D4/ssilz42YZJ7kjnrwOeHTWngpBvS+Y/w8SrLmMwwW?=
 =?us-ascii?Q?XZVpzvSJAaswTYlDhVF8U8j1RHtSvs2y+9AYWQPnGYUjeSdfuApD/0E221Hx?=
 =?us-ascii?Q?n3g0XvGxgzemeLWLWfpuOsfVIbG7Lnnf4NTvtNymLMPU/iOHaSynbanVFj90?=
 =?us-ascii?Q?r1qp41mGowiBe2bXyK2/fQ77f775L5jozsMcBQUDs3cL8YgHCw+tAvNQaNKw?=
 =?us-ascii?Q?JQLy5I/7gQ9BjDnQFHXFaYNfA9vfJhn75OKAmDAk9yz0pnJQDIZhYhwhk28B?=
 =?us-ascii?Q?VJQ0wQYedKBmFED9tRNIn4Y3yEDoJ4q3SuAlKM0al1TJKVnWMTwtiCh7gMbu?=
 =?us-ascii?Q?9dWq6VtucvCjZRT6yeYuXFQGaJqUvYyspU4tyKCJm3+JUEx2hLUxOw93wzST?=
 =?us-ascii?Q?/Jv3fFhm659sTMSnxyoz/Ifjel30YfeMeH8ZFBhg/C5QlLxA+KP5DmxjPtmk?=
 =?us-ascii?Q?tA4+fL5YrPy2hUPIO74+x1SDIkTxfIs0UQnU2G6PXX+Xg1D7qgoem1NuJyT5?=
 =?us-ascii?Q?UeBNQpCGY+mrTY2bPy+1H+Fy1NfCNWXz/Un0MF4+iIurPht8vS+p3i3nBMDY?=
 =?us-ascii?Q?VWUNu5MjSi6GzeycfkPXpykZI+NO+HtIGQ9YODFjpheqKTKk1Vmo9sj4o3Qg?=
 =?us-ascii?Q?n7l0IkUQAX6k8Ig0aipxN4VEP0/e7ZzAZz8vDLxZJKVPlaC1b70dzEt0Y2NR?=
 =?us-ascii?Q?qZLDvATSXhZUKjXh1bKavMihu5Qkz4sw8NNDbVIjEiVyNjL1skQPFJLN8ZAN?=
 =?us-ascii?Q?c0ZgE/h0dns5H2PEhA751n367K7noVhaa7A3MxvwBW6LnGaIZyG1FhdBqDjh?=
 =?us-ascii?Q?Z6mugv8Sx594OX6cd29r7ONs7HwGrvmsbgAcjF4mMpXTKl4xxish0kqW5xqN?=
 =?us-ascii?Q?+PUfExD/Z6/lkZFD6FubOSNWXoUbXBjkpNKlVK3Uk+RnAde0wYha9ZbnJ49c?=
 =?us-ascii?Q?6yOyUJ8ouUKmtwFVAXlWu/+pX29kXv5KrhtWfT3Ay0TcrDgrKkk4j+vuTOzV?=
 =?us-ascii?Q?mCXlPw+TdENZJfUBtwAl9We8awFc6WbZyWanh3ANgsNQ8Kh9cYI/QCgegJnt?=
 =?us-ascii?Q?CzXzsrkPX9MKDW8lnC5Xm2gOtoCB87oz7IrsPjvvw6rhq8c6FueFTdNWOpoz?=
 =?us-ascii?Q?07TZTaW2TlX/UJZs9bFpGSVMsTJYMnRhgPNZ52wN9Y+JiT/+XHY1VsxZcFtV?=
 =?us-ascii?Q?fk7C0KYx0HLAnFafiqnGwRC41GpFNkg4QfLGsDWX01Q3PqI+zEKjPxYMzxr9?=
 =?us-ascii?Q?YkxQzyTgpwGPEsRaqarU+s3m83OJXbLsO9aIo0z3EIz0xfUfurnqQX9HHP5I?=
 =?us-ascii?Q?kPg9F33Zl2TKNRQDzBkRuUrytniug7OFCmotK5RzK43KKqubGp6Pjs02OlkZ?=
 =?us-ascii?Q?5g7Bmv/oKAFvN4Fmsosv8UxmWoVkOJGC4FJVWcrq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c4d63a-b4ee-4c37-4a4b-08dd5cd19601
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:08:59.4003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvnOm7DZvRJu9wi+xh0sg1sObLBlZAssk8quvz8kZdaDFANikYhAemweoGFeXu+uwiqdhPI0K13jhB8OtBbHrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9179

Add compatible string "fsl,imx93-pwm", "fsl,imx94-pwm" and "fsl,imx95-pwm",
which is backward compatible with i.MX7ULP. Set it to fall back to
"fsl,imx7ulp-pwm".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pwm/imx-tpm-pwm.yaml          | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
index ac0a35bf8648c..d5a9340ff9209 100644
--- a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
@@ -23,8 +23,15 @@ properties:
     const: 3
 
   compatible:
-    enum:
-      - fsl,imx7ulp-pwm
+    oneOf:
+      - enum:
+          - fsl,imx7ulp-pwm
+      - items:
+          - enum:
+              - fsl,imx93-pwm
+              - fsl,imx94-pwm
+              - fsl,imx95-pwm
+          - const: fsl,imx7ulp-pwm
 
   reg:
     maxItems: 1
-- 
2.34.1


