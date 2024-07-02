Return-Path: <linux-pwm+bounces-2662-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FA39243E5
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96601C24164
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502141BE232;
	Tue,  2 Jul 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EQ6cIgbD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2061.outbound.protection.outlook.com [40.107.103.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4861E1BE229
	for <linux-pwm@vger.kernel.org>; Tue,  2 Jul 2024 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938758; cv=fail; b=Du8izduPqBrow5CgD+y3cNTY4lLVLuryWwWzCRsSpxEDhttC759rRurEuY44ym6NmMmiikRI1TULKIPGzMrLnKtniAk3jfwEBJmqvf4uh/K8g2MjbF0R3cfWWOaUTfGciPUgcoIC0wui7df+5D1pitNr4C+XKO+IEH7tQCMCCDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938758; c=relaxed/simple;
	bh=YrP1ohIeHeokM9ZIlzcIS8qmoa2aIrscZzI0Nmy6aRU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ti/zcn/+uvGfq9ZznPUj7fbgEr1dzuJCdTunP8OFVkD5JQkK6/QFhcJxLe8ZZ1INeB39X6ZGrAjtijwvXENwNLkDBuRYQg5/+75q5sdfL9xxOVQAJyEZrDJwQv4oKub/iZ7mpkt0YDBoa2GDC3ZRK/PYOSp5lYUXxNPIc6RCebQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EQ6cIgbD; arc=fail smtp.client-ip=40.107.103.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdv+lF+ngixLXDgA7+9NO7idJAge+WjEG1wVQXriT5T+Gu18k7+aAtffQa9E0BRsLz9hbVGGmMFCnSVKWeuEvzazwqGhnPu3iQ3bITQKoUMMyX9q0BshAMxWA61CYbBk0RLkIspjeY2I8FtLLXxJgjBBYyOmhv3zVRJAKUUkRu1MKSuXIgh1mk4Wvzf9Y5hEoeC4Ww7L+UOhb1+zVfp8jEb9v4c5+R72DSnSrpKdJwqPnvgk4PFTB34gNQqCBRmlOOOX7vNLXXr98AgYIt0uPEUvr4I7AzckfOxuBKCCUw9VVoTACajnrf+uPTLF2aZbArNHC6Gin5dxV5YGDsilHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JtiVlLkVC0hq32HXAouFb/XPrihMAJWSfHCeGySDmY=;
 b=H66WbUPx8wZqhj2tCs8XWQgPH/yzCU7Cy1Sd47f2LWniB7738vavBiZLYptnpq90Yrnf1MBU/ZyvlgftgAF3e7I9PTnwPaiE5i8edYgrpNl90Y10EfpWhJm2BdCD/HlKuETe4Y7tlKHCQhTQsvoSPS+eFTEFneZmfTSyEP8V9mPJx3fKP/qJEN8WJA9LTab9D++pgWYIQocPKCIyZOMrrlAc0BSTnhwPfBaZfniyTALbzEQZaHxIDUrikcaWgXt2XnBFZrih+HjMipJIVNKj70WIq613nO3p7Z0MnRsQkvOBGRWVQU4e3DikVr2cV80+0IWPgRIIdzLX6md2XhMIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JtiVlLkVC0hq32HXAouFb/XPrihMAJWSfHCeGySDmY=;
 b=EQ6cIgbDcK19XGhpmHa3qkresc3quvq/nj4ECtZMMHV49MikIwi6zn36uJzkAUOvhE/m7ebEFgMbSQDh2y1YArT0UI2aiXcOibU7Onv8zALKKaKqFodeZSO2HW5KwQF/Pkl1kT9syxOzxpFB5BtBcYSlfHVPOLstC52XtfuqH40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB8643.eurprd04.prod.outlook.com (2603:10a6:20b:42a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 16:45:53 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%2]) with mapi id 15.20.7698.025; Tue, 2 Jul 2024
 16:45:53 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pwm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v2] pwm: imx-tpm: Enable pinctrl setting for sleep state
Date: Tue,  2 Jul 2024 11:45:14 -0500
Message-Id: <20240702164514.11007-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:a03:60::34) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AS8PR04MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c83697b-94f1-4103-5808-08dc9ab66fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zS6ECyFyBzXD+Os7WQv1fwc9wEh4Sw9q4Qatj7ZI8Y9g+xRD/WUQ5hg0baKI?=
 =?us-ascii?Q?ikn70RMSybHA2j1fdfa90u/E+wogIj11ABFiptur2vNglNLd5rpPIsMcQyMI?=
 =?us-ascii?Q?HipFoiITbmwh7VHq0yGjumrPNyiz8YZXlnaMCp5t4VcfgefvTX0cuEZNErZh?=
 =?us-ascii?Q?uj7+oDBqm0ZpaRBdRa4mvL4tQRaaIT/uFbk5EyijpHIoTTFpwrpzRmdZo47j?=
 =?us-ascii?Q?yaNLM0ZgpzeU2m9yzwmbLY1IH41zZEd/lGa0jMs9uxC1n8xr+kz3fsjaB/Uq?=
 =?us-ascii?Q?E53DLGY5pmViSMMLnzKPFylfn8Qf1c/FjdLVyajjMAQTmP0jwadXd6xW0/CN?=
 =?us-ascii?Q?kQq1oLt785pg2SDss38puz41uYE9C7uLc1h6Ovio8/SZ7YyylzAQa7FexDG6?=
 =?us-ascii?Q?A4GN0FKLfAYhyObJWMMXuh6W6kk+1Kchs30kHyZGJ8ApKaikeCzqm7tvcGpq?=
 =?us-ascii?Q?c6D3JWHdznItBlEs3A3S5xYnSy2rgqdY0UHQl5tUGFAzbbmGjxS36bg/51+6?=
 =?us-ascii?Q?bM1S5KUhGHqeFLPLJjeHx6nwUkHrgecUGv6BQI1bVLbFQM+nQXxFki0hKsyK?=
 =?us-ascii?Q?Arqjia2MUpMalWYCXuyWRnmmQdH5oB8RCfHT64kabOThNO2PhN3zchlhyYvt?=
 =?us-ascii?Q?UB8CA4yRHXVj4aSTp0p7Ffr0I+hvnpzQ2kekhXop2Rlw1C4m1MdYjD5fBM2p?=
 =?us-ascii?Q?WsGFwRkqou+G1tMokfH36nAOJgaem9A54MJ2HuRbocj6Lx1Zflti1w6yRbpA?=
 =?us-ascii?Q?O8t4lIzX/0IGdcsvamkJmlUYMKz9MACSG3PHPjh/u7e47y6BTaKC3tRxhSfR?=
 =?us-ascii?Q?3bw4wbU9MoCw+fSP2yReC/psk9O8OEUnIn6rkeFr8zQYsYD7WxU3z7kFTbsd?=
 =?us-ascii?Q?jbEurHTdPkOieIY6YvrMRbrpvjS+mDRbrYBk6R6pLwihl8bY2WDhLE6v/WNg?=
 =?us-ascii?Q?u7UG3U0+v5rfdwQs3XRanvlHZK7UEiidxMDHTGAnVpFhp3kzknI1LpY4fZ95?=
 =?us-ascii?Q?AEOQmmzWwYDRb5nG2czaXFGzEXgbVEbyQxVBq3gbGwmMHiwoq9IR3GMgq/vy?=
 =?us-ascii?Q?KeGmCMQuQaKXdOQbiqRqutDeejl44IIJHcNM20eAv9tXhAUqrCsrg9GoQplo?=
 =?us-ascii?Q?kaDMECarAgqJvMcxLaf8l4/e/yUqV9PH8qZpEOrn/mDMZ8NLExMOXRSB/hEx?=
 =?us-ascii?Q?dOLmtooaR0TLEaujYq01USo47shS7Shp/Ak19eNptTAbCYCyXEFhq5R8rZGg?=
 =?us-ascii?Q?InLH9YVNhEJAV92nUWpCXHsjNYk4neJe8098eAl+HJ6mr2YIejsG4Twa1Uuv?=
 =?us-ascii?Q?VP0xwucywNwmhn4V4Uc6QrXc/4Rlyt+dbyv8EQrcCRRse/Uw+9LBqlNs5mx6?=
 =?us-ascii?Q?HJHJQ72NFuHXYRW2YRRf22EK6ND4JUuY6bLtt5sFNCw6uKEMrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SDohPSguG+bhnZb1ztmENVAjmPj7EUpaqi4HU1TXN2rlqGgehOo1XhriBNoU?=
 =?us-ascii?Q?0s8LC2ufgVcvi3RmEMtvslVskzOaosDFe3Z12jQeOvHBBosHtFPWITdGkoaV?=
 =?us-ascii?Q?X5MA/pYmSNKU/lPsYio9Gck6fb0FJ5Sg7a6gGlj3C1mWyiPqUfLTDnbt3DhM?=
 =?us-ascii?Q?qx1IiMzb33GZCstf4JjFpmNplEQ0GFtB/0SUlqWYfHLRM/XY1oIdKtjVVdiX?=
 =?us-ascii?Q?zo19AWjvFmmIwZcxIX7BpOWMaKD17SrRkvxe8gKOp06lXx2j107ciT9OBMzl?=
 =?us-ascii?Q?i9JyLzfmOmOoDJwpXxdEegyJuwg/Kl4d8+HYQ4DNVpfARpDKtziOrybMOgg9?=
 =?us-ascii?Q?v0ABOEfxTT7qvKL2jqQTB5OgMSPiVetC7rvw87MoTGOCHjiBKSfYziYNoxvi?=
 =?us-ascii?Q?AtMnRZuh3lVhMRVf7eoT8VgOrH3X7ubPhqLn5N4axjGefcZLUe2ux8N9o5aY?=
 =?us-ascii?Q?XQx5fWV2l2ICNQBmHT6AnpQQ/MlQWc3Q58NeyvK2bTcnhrID5DppoHgQy2Z6?=
 =?us-ascii?Q?hyavlq1VaFYL+K+m1E8Ja9ewWhaL3KfmA/HoWjz1CTbuSXNb3hUvwLJUIXvM?=
 =?us-ascii?Q?vPtaJYVn/WvcyFrZtDpC5NfwXqtmJrZTJoLZJVVw/EV5Umf60HRW/bkqxJiA?=
 =?us-ascii?Q?QRUT0Kw8d/kQp21dYfLLjbceTgk4N1Lu1IEOmPEDXzN0cfqPxLRW8H5HEYpy?=
 =?us-ascii?Q?W0GIwiDVL3h7DOoVXZ5dC1XVs/2OdSdzCCXRwnTCRhLuHGcJX3MxlzfxlH3m?=
 =?us-ascii?Q?jJoKHcPL0KlzBsccsMlgoOXS8JYD8cG+uaIqJofBb0+290VrdMtZe+KltOug?=
 =?us-ascii?Q?Vwejq/3peck8ldHSiboYHJERJ+wg1Gj3p4KASyT9zJu7lmEwo5SehF3jXT4N?=
 =?us-ascii?Q?+54gz2NgCotAOheL5R7AcVMnJsHwAMfrPaOWm/SGkCdT/Axxk1AIO6e8JyoG?=
 =?us-ascii?Q?nEeRGJ9PXYFNoD+Wfuf2ypkrTyCB7y4HqODWb/6JlX4NNc7YO7zlehP1fm4v?=
 =?us-ascii?Q?XEgoZJA+6ODAozKaBJwlH73MMESN95jUjX7fojD3bT8uqm81t8lB/980s7am?=
 =?us-ascii?Q?DwQMxNhIIaMVmK+r5TyW9nKoLjzEI+t2zGSroqzxQj7qg5GpdmDNeG2RpEEn?=
 =?us-ascii?Q?1CmploXZlzBOMBspqlUwkTXQ3iUbZMjgs7nu365qlcW2efURVaev+hYPHC/K?=
 =?us-ascii?Q?xok4t+avQwUFRR5Yn1TYMjuCPwpoGXoHvNRt6j6VyD+i7qganF5Y525Syu07?=
 =?us-ascii?Q?WDNq1X8P5A93UQOpT6Y9aofxIoxH/9shluf0ov18BmxUNUBSELzgkbPcQkPp?=
 =?us-ascii?Q?Ggg/qcrQdWH7kBQ8JNy6tkeNfHIIure9ABdfm1d5zamGn2P+02RR1fiopT/S?=
 =?us-ascii?Q?cQTuuWCW088SJBdP2sJ2RW7Y0TIDiYucZpCLJEtqXWe6jIQSszbjHcKhJhmZ?=
 =?us-ascii?Q?b2XB/6NY+3rvEcP0y6tC9yqVmCEY4ccZgrfc9f3D7VbDY/fFxDqUDApfwLDB?=
 =?us-ascii?Q?q1v5tauFmcoixy+Y5w4xpsmM58HBhyhDoJFDqfyGnEwef4oHzbOkkIkUZvjt?=
 =?us-ascii?Q?4AC2gBDY3RBN+O5pLYi4zRgsw3unPV8tu0nlQ5l4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c83697b-94f1-4103-5808-08dc9ab66fba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 16:45:53.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jj4JHHY4WxwmNzNO6zZqBugNbGQSvF0AgdN78oyQkgvfYkm+ipv/Vcta8bpyXmsv2aTHrAHa+y0hBjCHNVUdZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8643

Apply the pinctrl setting of sleep state when system enters
suspend state.
Restore to the default pinctrl setting when system resumes.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
Changes in V2:
- restore the clk states in error path in .suspend function
- restore the pinctrl states in error path in .resume function

 drivers/pwm/pwm-imx-tpm.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index c50ddbac43c8..96ea343856f0 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
@@ -380,6 +381,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 static int pwm_imx_tpm_suspend(struct device *dev)
 {
 	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
+	int ret;

 	if (tpm->enable_count > 0)
 		return -EBUSY;
@@ -393,7 +395,11 @@ static int pwm_imx_tpm_suspend(struct device *dev)

 	clk_disable_unprepare(tpm->clk);

-	return 0;
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret)
+		clk_prepare_enable(tpm->clk);
+
+	return ret;
 }

 static int pwm_imx_tpm_resume(struct device *dev)
@@ -401,9 +407,15 @@ static int pwm_imx_tpm_resume(struct device *dev)
 	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
 	int ret = 0;

-	ret = clk_prepare_enable(tpm->clk);
+	ret = pinctrl_pm_select_default_state(dev);
 	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(tpm->clk);
+	if (ret) {
 		dev_err(dev, "failed to prepare or enable clock: %d\n", ret);
+		pinctrl_pm_select_sleep_state(dev);
+	}

 	return ret;
 }
--
2.34.1


