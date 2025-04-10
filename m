Return-Path: <linux-pwm+bounces-5433-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9669A8357B
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 03:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947AB3BD7E8
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 01:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010F58633A;
	Thu, 10 Apr 2025 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="EnC4LaR1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010042.outbound.protection.outlook.com [52.101.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CAE1519B9;
	Thu, 10 Apr 2025 01:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247466; cv=fail; b=WFaQJWu9bsu+ScWx4YNyhv0wX3lT9Hg8amF6mSHAlUiS/U8RTq1lYkJIlRi/ZpKwlGIo6/GbgGbt6O/idb4R/zX8vtCCwlyKvmNFKmba1wF1x4DLRIzQfFGPS6pGzGaxdkhCOTybDmeNs9xkZ8PaViip5s3VFoCP0Re+eiI2YmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247466; c=relaxed/simple;
	bh=6XoDT+QQ8LQfBXy3qQnkZJBmAJE0eYPrIUz++Ntjbe4=;
	h=Message-ID:From:To:Subject:Content-Type:Date:MIME-Version; b=StZwQtWtb7XvZpYSOfmrMhBpL8zX3VyDI3cTrMFm7Rwy2vphW5VWE70X7JCFaN7S24/aAX3YYHaP2wPpyPnjPke6avEbVTllBKbqWEQRT4q2bVBV7HB88wdXXcpHM3+6gCx985kk1L4sb/mK1ohKgrHyrLwlp7NAgOKaUbmL8zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=EnC4LaR1; arc=fail smtp.client-ip=52.101.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMgGIJoUFR7dfBKBH+LgUbs0vX5ab5/R8oMhSnEUFiJmCA6TprMUSd/Y09ZU3t1kdvRIX1H5XzXlBy0EuUloN0R9p7k4gsI7wlpDEoGNVBx3gLccpyxmohLGsd7nJ7HzXGyvx6rMAW1AC0OOPKC4QEuNXEjzCCnHyFDk8e+PG5TkwAIxOUvO4xulMLojbLkxFxtv7YlvsqQGkK46xHMSCwjm0GpT93kXkdnZMceUbE0xw1Vr/kwCACbEJ+AiNKTt5tqa2DcI6nd6ozoRp58mvoCz4N2TyyX0/XTJuIOky3PE9H5kByhW8Yi2x+E9376h5NdOebdW5c/O7BuqDTdAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKVS1GhfnF1I1t0R1uy+weWIyysB0ywzH+XyIaLtm2Y=;
 b=EF7OQIPaVw4cGvHEISFD9/MJn81uAoSJN6GGwtWl0dSbT6vY5jEmSyNY0BREcSvQFhnCy7H8SSCXGtU2BPQRJ/Cx2UdsEyZwlsQt3mZ+tbpw4+9lvvv8ORNLVIBRkumvNo8FiMXFHXsO/yYGvXZVE9wNqkdXZ7cBFxH1zardKfGWXhcIN3JFpnlfTUqbICdQts6b5r5MXARaTARSRi4T2aiFTWZoe+yCanJxeDFLHVW8/H0hyqWslsWg3BjCTaWW/h0F11ErIgn+fGlko0Owvi/4Azl5UoHE6/bAG3QufDtTjbQvyzjxDY2KlDsKWflv+uBUpHXcG5HfKEMxO7WK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKVS1GhfnF1I1t0R1uy+weWIyysB0ywzH+XyIaLtm2Y=;
 b=EnC4LaR1C3yRqF0k9oNtKmhjexT9H0eN9IYjS6lZNZJzhrJ7RUDd3rMoRhieOUP7qQMY7iI44CZqc2xXFE/BJ8ah06EQJxel/njBB/pcB2k6d9+bIyDTFnYtVKuhofKutFgNM6NjrJlk5tibGEaaxOfHVHw+hkZkBIt5e/wbq94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS0PR01MB6018.jpnprd01.prod.outlook.com
 (2603:1096:604:cf::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 01:10:48 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 01:10:48 +0000
Message-ID: <87semglt2g.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: =?ISO-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <ukleinek@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>, Rob Herring <robh@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] dt-bindings: timer: renesas,tpu: remove binding documentation
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 10 Apr 2025 01:10:48 +0000
X-ClientProxiedBy: TYCP286CA0282.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::9) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS0PR01MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 84fbf44c-c2b0-4fe3-baab-08dd77cc873e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bvXtWl4YCYGDE2HbN+ghZePszokW8q5fHNmp3qP3m+6kmKXuk/3LJC8jS7oi?=
 =?us-ascii?Q?ov2PxTOsra/9zUZlfDWg3mJqbbVS4BiUv4qZNr7qPG61jNrjBOsxw7NAjqJf?=
 =?us-ascii?Q?PXkgsy7gU/Jq3Skr91OSGzdNPWeuV01lXJqp+G/qBhdvhKyLGhKtJLNfYUQZ?=
 =?us-ascii?Q?JbeAyg9i7jBm7aRM1JUfNk4QwUgKfZN16agNJMClYnyfouNIFjR0pnGUF5pl?=
 =?us-ascii?Q?X4JWzaVQPMAVZ7jaXWmPsIMIvQHipuVj5slHzmIzlbMaxDr2SF34S4zmu/cY?=
 =?us-ascii?Q?Z3ZnrPyG8mnkCgGxE1D+EogRw0cAKhSEb2Cn6CsG8EMnf87tQ9ILDStapcZi?=
 =?us-ascii?Q?O6tcP29jyr07LsNyPoqN5pcOT33nY6E7G97eIO2y2gaxoTQVkfvUhgM8rgPG?=
 =?us-ascii?Q?0XqJ+4aKrWVj4kyEVHbr3s2cMJBj8IvtRBJvyWxfurBlMYY2GpI2QffMYzi0?=
 =?us-ascii?Q?Si3Occ1goU6wyYXgYKIMtkMD833lG7+cSB2FFnkiVr0DwEPuAUXecFaN5OTT?=
 =?us-ascii?Q?enpKOrf6NsnsJNnwofE6jDVYPlGg550fVrQCcQrJk7JvcZi+loJTWvS7eBR8?=
 =?us-ascii?Q?mfHzH4PTQGYOp0kRF/Ir1QUUk/7S4Qzyy3BsqZgAcMStybQxAkdPtWfpUNab?=
 =?us-ascii?Q?lDtpcWf1jqGrAO9wL9Byk+iSH0hq8KchmFVxhOK2qjQjS6iYnL/OpJ7+zPhh?=
 =?us-ascii?Q?bY/lTlemjasPVZ2zyMzCyC1TOh3Z5MLYKciRN2qXyV80FO3MtMyvdMy9ukOk?=
 =?us-ascii?Q?WEO463vmYlsXHXW2SKEDAaeoUdc9AXofvO0xYTi/9LmaU5YW77i5eMwQ1Fov?=
 =?us-ascii?Q?8b7xKqZhJA46+eHU79z20flSwX4y5QoBaZaQzy1e2T5s1kdOtlQpOyd1CErU?=
 =?us-ascii?Q?mutimPzcn4jMxjgwZzMKaXEj+4SEb6hsH3Lnyb1G6IpR5mOaa6FWA3t2E91k?=
 =?us-ascii?Q?2nWw7BP6RvMAl3u5/8qtRQYrMPNbXL6eNDbjymEUn50tWJnvOFvPGgXQ9kNS?=
 =?us-ascii?Q?kebVKGVjdh0BPrLTw+f+XCeMNLKI1CWoRo70phkcx+8wUM4hNcAvPDsG/sf0?=
 =?us-ascii?Q?vAAKShUaqMiGldE3rHILzHcqeULtAz98U+IjA+TedC/FMIRrv4hc8lS5esDG?=
 =?us-ascii?Q?szLsEUqme1vpzWjXvEInnZG4BY3ghQj8/pIM0bN67XFomHYZs2jpF9fUbe10?=
 =?us-ascii?Q?EEn/iQdBdj/WRvdcT8mxNNGbZzZIr923n+VncYtLWKszDl7cl1o+t84LbRpw?=
 =?us-ascii?Q?FdcXMjL8RAnGHgW3JBkLIA4AYyBrvAF0+KXdQEYmVNfwk/L0+aLJ1J/F6YXy?=
 =?us-ascii?Q?N0snD9nftuF0xfvlWIwaTbSngNwuZMoVgnS2IVZSvLPcJ4UbV1b7zx097G3e?=
 =?us-ascii?Q?a5JkIDvjZc3nUDK2GYN0Rd8y1QFCshePv5Baiebux/CdAI547VS8TjCGvxMO?=
 =?us-ascii?Q?SPvxqFlKymjPrj+VlMKFjHZx2Nk7FzoT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D04hqy49PwiYEv/Mbii+UrwMDuH3Vd7lcpbNEtW7Si+RoRUjWBgsZl9IEqGD?=
 =?us-ascii?Q?XBLfEREfCsnWh9eZeva+Wbh83O4wiEh0lRuXXKLqQxmLtb/CcTL1Cy3oPV/K?=
 =?us-ascii?Q?VXlIsixI9jCqjAejGIB8b2NxefDmPEOV4SYk+CkDHTnWq07IUeyqgtso2WAe?=
 =?us-ascii?Q?zL5UgIwrbDfvBjfJAwWLbXyZ2scfNii70fGWS5LKdO4voxLy5K8zE1zFQA/P?=
 =?us-ascii?Q?VqcaYnTWZsk0Uw8vumHfUe5NOj3nczRsxOwqffvXBCGzzaQD0ErsCxpDKk7L?=
 =?us-ascii?Q?HA09ChHs7iVUatx5w7S1VLhGe3qFmlINqxHLx5TZhgW6c7oNooyY62A9hkCk?=
 =?us-ascii?Q?mus0wvHvOu7Gfth4GVdxkOP5ZS0OlYvl1LjAyLam8IzVmvsbpYuuWAH3GHKL?=
 =?us-ascii?Q?0qQMXwoiyC7JHwrOawxPDlsmMVLFCyJYK9mLjJLOeg3tKgTk1sYEPfcq3M3W?=
 =?us-ascii?Q?ONBwp4BncCBQr7O/pX68+ZqQhIKLgy8TL2KzUMOGTC7GGE7ZTDEcqlUfL2jm?=
 =?us-ascii?Q?U0pOhlW0sAPoaV5V31ofWRPt8mV9GRbLEcOtKXgC4vNh5VJtY1ww0CcQg2eV?=
 =?us-ascii?Q?CPXXiD7Rk9QTHnTiyPPUWNiMXHB5sxAVEFIQGPwg9K6lmt6qRsZM1xe/8Gw+?=
 =?us-ascii?Q?Hgho+FsIdxvLPcy7X2jP9TBKz5EQHOhOGxFDGjWTGCR/5iPB4Ne+WHW4VJmp?=
 =?us-ascii?Q?fHxx9fsvdwCsWnd4jE7OIZlX1bCJ7ngftHFOJvfJ8GXgqZGxc0zE67uSKCE9?=
 =?us-ascii?Q?hr5r1+YiCeq1yWrB/xxS5i6YAQzCRHnR/6D4uhkrYpfj7DaBqWimJaDt3QcN?=
 =?us-ascii?Q?dAxKLRKqdX/dlu05BMILoOX+UOI/GYnt8YpjDkqEwx6rQiTCMD4h/tZKTT7M?=
 =?us-ascii?Q?C7E98r4wfaZgp3oRlsITg2KiUhf5oBF7vz0UMCts1ILAQANpYb1mEcofFdQm?=
 =?us-ascii?Q?7usK510XBPqZOV961dzWU0hmh3205gfcA+GAPmeodc9CQ6HLqYXLky5ENq/A?=
 =?us-ascii?Q?z8iDF+KMZWpVagW8T70zC20qjDD4Wxz4zuB5Xa3qA1pDRmxVbgY+lw5Br0vM?=
 =?us-ascii?Q?VS9Vk1/LKdcFiMn3iak3avO0toe+9N+gDXjXOfQPHrAlfypCV4f+PWimFmyt?=
 =?us-ascii?Q?rWGlxZ1dO2tV4LblO9yDirBxMg75Etqem9uTFuMftMbcG2XKeNUSiSFMBEzq?=
 =?us-ascii?Q?KdKB6pdOBWQNDieysb6155I2skW+BsV1IzBoSZlZkR1usOBWkwlJn2XbicUV?=
 =?us-ascii?Q?XUbw+epB+vpKxl1fQ+/k3kAK/OQmuPoJGWo9C5+g0c4C1vwcx5RcwB+lzcge?=
 =?us-ascii?Q?wvuXXmgN9mhUxd+UqG6yfPDzJ+HLKMvJVC9qnqGU3SLXN2seQ+Da/51P8c2/?=
 =?us-ascii?Q?kqHVGNWX66DXlT+LMqBmPv3iGRHV3vhyEg497xF8b/MLIlwGXCR3WDf0R5VM?=
 =?us-ascii?Q?q2XAWu+19sNtfHr/XUwBhxH4+fu3/8Atfu1vl6u/dmZdhAM19bI93QfF/RNh?=
 =?us-ascii?Q?kaopW4IzIckKfBftP2LonI7S6uSeS47yi0zeOvY19S3mb1QMsXM9biymmq2T?=
 =?us-ascii?Q?PdUTk9qdl7q210C8VclM8kQbDQdWbXWiG7nSfeF6GfknkMYBpFwfjh9pwXvh?=
 =?us-ascii?Q?5p37Yld7F9Yx8vbv3KoVe6Q=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fbf44c-c2b0-4fe3-baab-08dd77cc873e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 01:10:48.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bt45Z6p30Yn1vU+2RmJSgaxe5fL03J515NY3FGaWJ5RXMUhuP8kcZcy8VZzgF9JPn/QBdddTLkXZ0iIVnA6LhgSdm26a/GtHjXV6z53nYwkGjqE8hES5h1Q/5jqYUJ/y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6018

commit 1c4b5ecb7ea1 ("remove the h8300 architecture") removes Renesas TPU
timer driver. Let's remove its binding documentation.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1 -> v2
	- add Geert's Reviewed-by
	- tidyup git-log ("DoC" -> "binding documentation")

 .../bindings/pwm/renesas,tpu-pwm.yaml         |  9 ---
 .../bindings/timer/renesas,tpu.yaml           | 56 -------------------
 2 files changed, 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.yaml

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index a4dfa09344dd..f85ee5d20ccb 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -9,15 +9,6 @@ title: Renesas R-Car Timer Pulse Unit PWM Controller
 maintainers:
   - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
 
-select:
-  properties:
-    compatible:
-      contains:
-        const: renesas,tpu
-  required:
-    - compatible
-    - '#pwm-cells'
-
 properties:
   compatible:
     items:
diff --git a/Documentation/devicetree/bindings/timer/renesas,tpu.yaml b/Documentation/devicetree/bindings/timer/renesas,tpu.yaml
deleted file mode 100644
index 7a473b302775..000000000000
--- a/Documentation/devicetree/bindings/timer/renesas,tpu.yaml
+++ /dev/null
@@ -1,56 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/timer/renesas,tpu.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Renesas H8/300 Timer Pulse Unit
-
-maintainers:
-  - Yoshinori Sato <ysato@users.sourceforge.jp>
-
-description:
-  The TPU is a 16bit timer/counter with configurable clock inputs and
-  programmable compare match.
-  This implementation supports only cascade mode.
-
-select:
-  properties:
-    compatible:
-      contains:
-        const: renesas,tpu
-    '#pwm-cells': false
-  required:
-    - compatible
-
-properties:
-  compatible:
-    const: renesas,tpu
-
-  reg:
-    items:
-      - description: First channel
-      - description: Second channel
-
-  clocks:
-    maxItems: 1
-
-  clock-names:
-    const: fck
-
-required:
-  - compatible
-  - reg
-  - clocks
-  - clock-names
-
-additionalProperties: false
-
-examples:
-  - |
-    tpu: tpu@ffffe0 {
-        compatible = "renesas,tpu";
-        reg = <0xffffe0 16>, <0xfffff0 12>;
-        clocks = <&pclk>;
-        clock-names = "fck";
-    };
-- 
2.43.0


