Return-Path: <linux-pwm+bounces-3055-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B3C960166
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Aug 2024 08:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEFE3B21953
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Aug 2024 06:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F6C132132;
	Tue, 27 Aug 2024 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VTzGHVdz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D497D51C;
	Tue, 27 Aug 2024 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739410; cv=fail; b=C1lJ0oQwHi+LsUE4U/uagJQLeDCfSlewIyKIhFKY6dZYI4ETKfxipK4QIyCAgrGfJJBtYn05TsPpe0EW6Zh9cRKkytdm89VG6KnoIZgGxbEo5eCPV4AyYPZOhbgxVKGVuvhb3gHDXNg8pbGmsiyNPYmQDFoJJ1zZmCB90N51mdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739410; c=relaxed/simple;
	bh=Z+9bJmhkvgNvLCIWcEKR/xQp3WduxrqWD875AfIu9rU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dOweUj0XVR++IOl6CQN3aLTbBJ1UiqClYtCVnNdjWTntUI6yXRnLQXU38l5dxnLtgtjNYtonOkJye7jHlQFz8U/WQhtPCZKskR0NcjBbVxe9FIYoK6U4B5dUPS+OFxoxkrqDU7n+331bpbVaBl3KTrMKW1zRTDlzZ+vlxQc4cBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VTzGHVdz; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7LCl3oTwpAizDw7IzUUCe1hsvEoRA/q2VLlDLBKWbTFMTFwynOqSqX3uZB6np88htQQZ/F0KHnS0PhDYsZZwLYzS7jKIpMODeObOD6rccLilRFj2mVa1Sar9S/HhaXRYK8FkF81rctNE2xb/2bmg/UY6s7sOdlDwIJwXQ7IitHZQJtTegEueuWhR7bQPdrvkp1wlQP0R7QY9DcNNCZVLQaoXu+5P5zsbtx2pblEDyX2li4mw3+/+KVtvxoVKczU/VrY73t0Tc6APApMtEUxlzB+Ru9f48Q1+EqB670QJb1TEcr58ZINNAEYq0d1nftZLWhKag6I7xtMjLAZejW7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL/MyrUDpI8Q7SMwSZwvUHk4iHWMm8pBpWw8hT/1a/4=;
 b=IoFp4dz/OXTVVusWR6CPEtbV9r3wdV9mcYBPyc+tE0yhjf1LnvjRhf4qjf4vBjJQcBEj4mJKgEV/iJqs7c5hbI2K3jC7mz0mt85X1mGAHTL5KEbmpsHn6qurXBvd/GmKDDtPS+CteVz3iHOC4s/J4Jzfl1tDwq/3pufjZynXHx+o055WZWI0dZnkPUf177QoCBLi7K7bMuHAUiZCa9qva+0uDfewAp8KNJFHDsSDjYZKMVjQ42NO07t6rfKwn7Yw+hXKQ7OFlO64SIttrzJWQoDo8X+q1rtFHiOFjFXvorAdqX2yv34/on2zd8LqHkUd4E3ktOjD1iVB6SB6/Tj6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL/MyrUDpI8Q7SMwSZwvUHk4iHWMm8pBpWw8hT/1a/4=;
 b=VTzGHVdzx0af8CL5NyHwkCJdRkuPHMhMdNYTAd786thP2QEt4t+YPNyYmtLNK77LlVhC+ea3TmnwtrsYv99o1FrW/uQNFBDMe6HDpYWG0FZyu5InYMBIcU9pypjHGvSK64k7dpVBrmvCvEe+qYhLlS3lncWvjFcH5P01zFhabE0G3Ox0dfJpZv1VqleYWW6erIb2xoeDKgtclJea+ttSetYji8uVPktgdnh1aNRD82HlglFmIyfCoWiiFpdF2oJBcfIDG0BfoRyinG7eqJ1r63qdNYQ4Pgn0MJ6hkF4Q0DLVRSB3sAPyyBomExjdjLTzL9ebuDGg4LmGfdCyOlWMPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:16:45 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:16:45 +0000
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
Subject: [PATCH] dt-bindings: mfd: adp5585: Add parsing of hogs
Date: Tue, 27 Aug 2024 14:17:10 +0800
Message-Id: <20240827061710.2091661-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AS8PR04MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: f76dfdc0-dbd7-43f8-6342-08dcc65fd353
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?DqWqZmEqMr5GEdKPtrIl53rR6VQM1q4T0b5g7XWvKC6WCaOmzA5A2DWHkcf8?=
 =?us-ascii?Q?x2VTnFodP/R335D5RM1rChetXt5rToagc6USK7znFSLZ13x6tVIYEIun8vmM?=
 =?us-ascii?Q?XC5uB9SJYZdU0tfj4cYyaK7Tm2Ll6+uH6GdG18oFqk5AFxnh1pAcQxvA5L1f?=
 =?us-ascii?Q?BqQdSxDTq4Cf30lqFpFhR2jD2NhGKHqtWrllRrf0j5/lu2npv9gEplrcGLLr?=
 =?us-ascii?Q?9ATCg+UHGFIeU/twATjBWZ3SCHGbWFkAnFacrawK1M6T+/fICdcZ3zuSwu3+?=
 =?us-ascii?Q?Kq1f5g/rl6jPwxWJQ+0TnfMWD7MvAuqLbTNzMuxB2BEt1iuORd9/awwuzLxv?=
 =?us-ascii?Q?TwyuZwMeKDx1hZ73of7NVTnXStyn3L7fDBnddHUkMgtsr7kJiuD82dtNbRxX?=
 =?us-ascii?Q?BNpgiZUW326lqowiA4Ll9D3GmlYJHD6tayN1jfplaOcHQcxxEeaauwCf0K+L?=
 =?us-ascii?Q?khB1szJhOf7eHlKMLflowrkF4B6O+9+1uTOTe5IAgJpR6tOrJQmM4Fwx3MGR?=
 =?us-ascii?Q?9Y4HSAllfsKoZSOT3v1LJC0j/02oZxt0N5PCIs0JuiZuytHnJfvvcfPyNhxy?=
 =?us-ascii?Q?PEtI+5vbUc01XqVvficGcvVfDcPGzkYfQvB0OEqjKQdRHPBjNm6RLMEC3aR0?=
 =?us-ascii?Q?gazOZ0IPwZ5UMUL+y4AHZhLkYXWDGPNYbFASAA6YUNSW875sqac6ka3e43K6?=
 =?us-ascii?Q?2zOL9uo9nIHA5xkJXzmqXVOGZm205SBzG1xLT0Q/ZaxiV/BRDCXYtvkLXbma?=
 =?us-ascii?Q?kTQnDy5+2loeXYTOcvHnQCDY4Nwy1V7TGSSffe41rhd6EvL4nafskxEeOVuW?=
 =?us-ascii?Q?SBo0DozEyAoYFqfM3I6c+x1wG05OZK+zgsL1OPSfWTZCMq2CqR2ux/yopkY2?=
 =?us-ascii?Q?3nlgXA0pqPYkQyW67K8IDCuRAdZ0764d/w+leLt2NxdsMj5XfZzyM6uVTKia?=
 =?us-ascii?Q?UV9m7sXKoNJaLwVZz6a/sh2AKdQnXZvVP+QLay78KZedeqZJILJF4dnstOZM?=
 =?us-ascii?Q?Ncj1RlqLjSoElDRH29tZvNAc+eDDt7WSesIfYeYA2cToUQPA4oNKvPeOjwdU?=
 =?us-ascii?Q?N215yJSK5aPn7+DfBzLjsvkOKMRx9PPzAMNGB7gBIt1SegnAn73RkdoCOT0v?=
 =?us-ascii?Q?W5LHR6k9yq2ralZf1n13FmcjWecVW9WqLLEDOXQcYo5DmdI/WC3bFWPEfow/?=
 =?us-ascii?Q?5fLm3XdVsYBPYg3wxPlINYvxUq26ZS//nU4eIpzgWa9H2orvM4JpLWjao0RV?=
 =?us-ascii?Q?MjbEsFoAgr+bTFhZjM+i+wPEd2HEpGMcwe98lKeVomfVRF5DqSF7sUIdYFd4?=
 =?us-ascii?Q?IP9MmMZdRi2G4TZssFf1/yO/6hepNDrjmWs52YWkCUM05TFP1D+R+G8kuKHe?=
 =?us-ascii?Q?91BQGfN4Cv5IYIndbUfg0EGhQWBmGB+fbluBI4lHhvR+yOt/xw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?hGmUKmbkrZ1D9bfvNa4feNPUb4VqTct/qLKh85M1CSdP7s9nR4iobsw8AXw7?=
 =?us-ascii?Q?NmLOqFQD+u6NFIDDVpLnwzt8EbYAhTjOvx6+nPqRJ0il5gYElitNPNUfAOlj?=
 =?us-ascii?Q?XFY6XDqVYNXMnRRVoadeLJGzrzDuLQRc3F7Sdw/0htV3sK6ntn1yjiBkQX1C?=
 =?us-ascii?Q?SWnWJUyQQ2uVzr1BJvG9ptNC83gzTzrnEdmCPtzzfCU1JFEVTI17aSMp4spR?=
 =?us-ascii?Q?nQ8sx6RmGhhd14IU9Gk+j+QKcICva4aulc+qZg5n5IvJ8tKM9FzpU0iUQChF?=
 =?us-ascii?Q?xCKRcZI+nIC7k53Lz0JQnL+U39nCXuz4nQPI9f8jxSYx+rA3AyBhp38Swnt2?=
 =?us-ascii?Q?96rOaKRmHTemusgPEwBcn5C2oCMxw+VsCrJ9BmZChl7KMqm2REpN4ZBLYCnF?=
 =?us-ascii?Q?Me5xc/2Y6FbahQdkVBLDzHujtSvZFg1F4NfqiilOqqP5q+ck8PBY1UuGBTTS?=
 =?us-ascii?Q?BmpCAIZqxQZYa8L/BVk9darkrd9eXdpOw2UoNRYKHSkZ0+pDVTers0TmDpbG?=
 =?us-ascii?Q?6Vvk8081Ej4CWatSb5QViXNY78bwVvOF7TMvmcK2xUAik/77E2bWKIKnJd8R?=
 =?us-ascii?Q?visR2Z/HaRb+446EJt8XIS09wU/UrC9P6Iq1unpv3BnF8sYk1xuyJ1peXY2U?=
 =?us-ascii?Q?S13V7P7ktmqqqLj/C3eYIR4LSYmuXN7qYodRtuBkgHEHudL9RZvDVuApZZ7f?=
 =?us-ascii?Q?FxOtmixQ+gpAtNFinhbCrFcvQrrXsFgkLJWm7VQ+esP9LK3gRZi0ERLx3JCZ?=
 =?us-ascii?Q?nx/OpfqrLSn5fvsnhaPn7kyVldFOZ3Oj/IXaQkd7OWszWmwk33powSY/oRTL?=
 =?us-ascii?Q?0s29u4E3DqJCLroK5ibcnK/8jSFFDi4CIumXbyu3tQiEavvz2kiRmvOQK1f1?=
 =?us-ascii?Q?MCo4KPju9NuSfnHsalM0v+7Z+HhgO0QCtV9ie9YpIvbDAdFs8KG8SxzMbQZd?=
 =?us-ascii?Q?onmAB2IiGJiUBb9HtQRH2BkPVt6brAdTNV7Ja0gNEKoQ3p41AYDNwS1S3bqr?=
 =?us-ascii?Q?tMmXhxABSBeYczH4i6PblXkxekG6mX3D/HRQGgAPFv24b5bLEC08erkCB51D?=
 =?us-ascii?Q?I/Iny6Cl0U0Fsw/dQyhRFMChYI2TEA5uk3fzpq6XQUHI4CLJNjEt0XoM/5vY?=
 =?us-ascii?Q?+YPVb2R6yMz4+arV30bFUOU75YMvEpZTTvhDVJOxGuofRg9udnCb4TeoMOp/?=
 =?us-ascii?Q?0Yj53/Cu0GwCe0vw8s2rJerHDDUPp7RW5ppV9XjO+Cd7DCdP5amXca8oJJp8?=
 =?us-ascii?Q?bl5w1QdeItw0+nvJENK3+xlyh1sW3vGNdWJhFdGqAOx4gOyeAofiPvrYVyWx?=
 =?us-ascii?Q?7HuzHyE+0DvvgpTJoXwKxhGi9co4bRjT2xYPl4mZDjJ2tdog0+fgk6XpJn/E?=
 =?us-ascii?Q?12zV+0DwM8V0bMDe4fgpcJp8Qu01Tp3L5OAI34sBb0wPPy1qyddTT+74a2de?=
 =?us-ascii?Q?CULi3x7RAE0a5McbwlH6mdsC+PVSYVIic6Y3Hex5rKL3gIa6ou4o4XTMgHft?=
 =?us-ascii?Q?bWZphNabQPAEGARL7JDYZzn4qSgXeAGGuPLMzTXkqKM2QxRXsyBG5H7st7l9?=
 =?us-ascii?Q?cViLlL0Z7zR3NWdW8NLxONRGX8ioKj7Nps/JJnWy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76dfdc0-dbd7-43f8-6342-08dcc65fd353
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:16:45.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dk/n03JpRCqV2oTgoggMJT9tqY86XpLOjoVqj+7/Nv3PUlkETCb3XI36jcNevf993yZFfjpfihtqPhklFH0YDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9176

From: Haibo Chen <haibo.chen@nxp.com>

Allow parsing GPIO controller children nodes with GPIO hogs.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
index f9c069f8534b..815a39c18556 100644
--- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
+++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
@@ -42,6 +42,13 @@ properties:
   "#pwm-cells":
     const: 3
 
+patternProperties:
+  "^(.+-hog(-[0-9]+)?)$":
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


