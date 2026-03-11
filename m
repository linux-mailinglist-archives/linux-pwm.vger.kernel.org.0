Return-Path: <linux-pwm+bounces-8232-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FvXAYBhsWl/uQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8232-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 13:35:12 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F24263A87
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 13:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49CFF30CBD00
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC562877C3;
	Wed, 11 Mar 2026 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e7EceduZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0DA28000B;
	Wed, 11 Mar 2026 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232421; cv=fail; b=BIGTn/AuJj08Q7xlXsIqxOdlVmVKfl7UierTrLQ3pGbzi1qiC18KGgw33PEAMY5QLFJmOFRQcdTNiNq+zjvhXVbyQd6pT3xhoEWC8VADGAuxz1Dv1RdWCjfO3KcuDqLXUkuM99mRTTVZlF0fSWYBgWhwjnkCroyYGV7aHZF9sYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232421; c=relaxed/simple;
	bh=2camquN2CtomRoDxmzFGSCkYhO1tnvQUVsoPWhwsAZo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NapbuES6sq5y3fg4Ln1RdAZVH7lA7Aj/LtNebL7MzcNxtUD9W8gTNqzL6C/45TxlqYlkuowvRdKCj+k4IGKNEPgg8eOxw6jOtGuvH4gvgaE1lq4eW1ti6h2nuqo54noz8UxCR276g5duxKUf+QpjI4vfek8AXXv2rZduBRdfNqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=e7EceduZ; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XK3DPeHqWwsYbC0Dl7i43SsVaAwqJylKkD0hEVFPQV864YkeXK4raQ+uIdc9jwtegby8ST35EgG0CNKWsidkideLhzQitQmEfYQelHMPBf7FwCWCy9hb1VeGKXgFdj6/IpUuiHuoh8IanPii4dvZy2SPNgLSbXidCI0YF3tYCYbkrWA/xfK7plxKvCyAtsD+MQPNpgb+A5qoA9TZwgHR3ZvkeBqOgHUZLtobjIfeM31v4WPAOrtpr1U9FdcIfio0iFnG37Kv7ESXIiVMv+wiStTVAB0Q96oori1R52vO0WuPUkpWn6H/AWiGGnegdhKkEQeex6xaKyb6kmp10cpnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E09FmmKj8xnRMQXs0bbuEBu3BYrHWvN/8FuPIekKz+k=;
 b=iVOQbefYktqks4E6u9kaylbBSV0HmDe0R3Oi4ULafHdm4vl9gi5pGWR+nQUC9r7Jjmt62anS8zyQ/w1G0rk1r1x0MXEglwZPQO7vKLmmKjArC+5Oc7dYM69Mjh6Tvi2TcLxqVfgBEOHWEudgPy2iGGIcnKOzqkIjq+6KTZjBAzLICAKSN7j3k+GW2RgGqQR9tl3n8UPxmXCH5ytHClGJ6xYhoK83Zzod4MqUUD75u+L31AQVlld+YnaggnJokNJAuatTMPr+Lvsw+jBkb/fZuTJSCGFIIFNBsr+E7+JDWJlEFccpBHOJkOp7EEN55f62IWVrUGvaeMhEQdq+D9NX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E09FmmKj8xnRMQXs0bbuEBu3BYrHWvN/8FuPIekKz+k=;
 b=e7EceduZANUItOGoq9x90J8dNpKSj0tXVMXdPnsjnI4lWR4wLVlZV8XkiDhhOkjRxB+N0smWqGmIfgL00cv9jZ74VPv04GPwdCRZKf74uQYI6e694JPTtUtY7usSip3YVxYY30YdUuQHOuY1vnABPV4C/MgCpDBTYXCDZvcpGYvtbWErc8nm3ADiNbWsfaEdi6Z/G2yjgabVkpONzht2V+3/pZERXQXw7XZ1GFUyasZgwmiqGY1meZHpOxLUst23OoodScER4tJSnQZWNkQqVFDMw2QnkBGjbhC5LtopayPNAzDkgp0QkiFFaXE1ApsB44r37eLWYsuMDOWn+1l9Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8249.eurprd04.prod.outlook.com (2603:10a6:10:25c::14)
 by AM8PR04MB8051.eurprd04.prod.outlook.com (2603:10a6:20b:241::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 12:33:36 +0000
Received: from DB9PR04MB8249.eurprd04.prod.outlook.com
 ([fe80::7703:f0e8:aa60:ac2e]) by DB9PR04MB8249.eurprd04.prod.outlook.com
 ([fe80::7703:f0e8:aa60:ac2e%5]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 12:33:37 +0000
From: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pwm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Viorel Suman <viorel.suman@oss.nxp.com>
Subject: [PATCH v3] pwm: imx-tpm: count the number of enabled channels in probe
Date: Wed, 11 Mar 2026 14:33:09 +0200
Message-Id: <20260311123309.348904-1-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::20) To DB9PR04MB8249.eurprd04.prod.outlook.com
 (2603:10a6:10:25c::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8249:EE_|AM8PR04MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: d919d13a-c38a-489c-6722-08de7f6a6a8c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CP0cHF1fLi3zBnMWgHUPybuB9tCLShtiKgO868cHLkjywjs5Gcx+NX31Mo9zawvOgw3Z+Xwk4uLhsXlwyuqTJFN9HUNHKWULg06MIzIWP7TU9+rVwZZ0Nc7x0YH9VOKxMLmUXIxSRzSOTq1oyGpKdAYSN3bJiD8vqvGs1aLINahxILhQOzmk1j0KZ4cUsEn/eXDYQkdsGnUKE9rlQ7BomcOtR2d9DDWNDbsyvn609OqlcBXhiNKEhUB7yy1CHoYEmDzIu9OAMSPL1YEaZnB86fQk0qUfN42cxr2R+EFCo0Cpa0i49X1zNNEmIgsYB+AXmV8RkQK/gCl0vJvX21DANg0rLoYaoemuXLtg9/81cehqNu3RXHSPtfsQFtmZzdtlQIeh6u18NB8a096lOxU63uzkTfgng0NcXCCCZFe4ihVZ+cJ/y2KuGUdJ1NfMYBeIUZVVLiGIs46kU1+7L3QlPxc88WDGHBuJ1J/JgjXhJgqWCvAxGZVK6vAD5J0jEC7sC7FVOQcXjjaiOzEl9gLO8l6d0T8VuSEh3GtYMvDV5XZPuyplXtEX0EpG4rhzJ1DGt9ZSMm9dizbS07/t8dxLfRduCagDWprcOkKfBDtVq4Mgf6A2jcpnoAbukO2rkXNbgLy7XDzzPcVxYOVZSxULlh8FTb4RP1ofQ2hHZY7IDjRGvNInWDEaRTzj9IPdNIEiEu9QXU07WBO/DpMUvzUVyH/p0gM9Je1DXjnUlMY1bCuW9IM4juzoE1fEBnKcSudqSRjGscDLimBKEQe15HKL3ay0GYsEzV5nR+x8xFyQnh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8249.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?UlG7ALhmb0o7W1jcrRJEK/iyLxTD13d5fISzLxhQV16ZuG+Olsl7zd1yYF?=
 =?iso-8859-1?Q?X53onyyI2+yLAwGLCFuyZbjKMIOhk52jsjZVOd9y24JmE+kmKeU0jco6By?=
 =?iso-8859-1?Q?Hw7j0JfUi5kveBWhz8bKA5ZiPwncfJp5y7UXEH0FTq8hfbL1EvVpPaIjtV?=
 =?iso-8859-1?Q?LTPUPcPwMsW9lbz1Qk/xyL9bKBHDqufzRvMfTog9UpfnLUkdCQpenYZxzH?=
 =?iso-8859-1?Q?F1fj1jXP5bUkaXs8UXCDcyLZJie5QQ+cH0/utrwO4AAmsmODVK6Qp9Z+VU?=
 =?iso-8859-1?Q?ADltBs2M8SoYuqa1jwHOJsKJBgZOsFLa2pxfo/n51MNqGnRfwaqLTxrlcr?=
 =?iso-8859-1?Q?38Y0/Z+kmOQVbPmwXwdc2khe5oEVCx81jOF1pS5BV0hKT1isLOoxCPSCbh?=
 =?iso-8859-1?Q?tz3Yy8msWtTJmygsI8h7ez5UWDP0lut8fRofzWN0kZvzTReY6L/FKsqVa+?=
 =?iso-8859-1?Q?bW30we3YuLexiUk0lGOEt077AFgaTw2FNCKPukfnC+Y7AtkgX/nrQtqOH1?=
 =?iso-8859-1?Q?x824oPUXiLVjZFlwqxnks2v20Syw0gIkWeQ0x2rAnqOO+IkI9yC+TQxMBG?=
 =?iso-8859-1?Q?4F9FfFPL8LsSK1KfBmbpPvyjEnzPKg1+uGhNpcl4vsh0BP1CMwDBuEsxRQ?=
 =?iso-8859-1?Q?OUBUw1LfLLzKkjwVHTnvtKBbRWjyU+pOPj2/Z9pyIb95iYZZ//8zqg/Q9+?=
 =?iso-8859-1?Q?S4KmPsiS2p5RjaxiQtZCLrfQNriQGn2E17oooNbjokLpoZwsHNFsxWQmh/?=
 =?iso-8859-1?Q?Avg595XK/THUgslClAaGaowRRpYMx/H+hSQaNAaUvnY1+qX5mGjRX7eYvh?=
 =?iso-8859-1?Q?rPd46FbDrhs+PaX2O37JbA4iivvVaEoa/illSdm2IpVzcF1U8I7Lvt/gEe?=
 =?iso-8859-1?Q?RcduOC35vqwprpISqEWCjkrmTBxJ5IvTNOwdwEEWnJt62I9DJkooaM7OEg?=
 =?iso-8859-1?Q?ZNBpEVltikpyJi4LD2dEAgfZ0bpASPQj5dOIpvCtjnfjUnCv08rz/oDNXb?=
 =?iso-8859-1?Q?7KPJ8wDffNTJgFTXUQ0RWqZZ0pIlJlmR57hP9d2Owanhi35FuZQ4jH64+B?=
 =?iso-8859-1?Q?j2ovjmQfv6uO8XodkVpjAy5NcO3nKBlWU0QljC6V9yec1hwfxb4KoxsfBj?=
 =?iso-8859-1?Q?LZP/uFuq5wG5YQMvILCc4gaUdg5JYtW2yrwc33pO/2vsNoZldWplpMH3/i?=
 =?iso-8859-1?Q?dSBo4N6c5LKzLoeY05SUQrkHtpGUEjNVIaaFd/ZI7rS7rvheF+dIAx9SvW?=
 =?iso-8859-1?Q?XAsDT/CGyl0GThCr8OvHHG6RwSR22nR6nB9SAJ71A3yKtQGExlpOyYkt+E?=
 =?iso-8859-1?Q?U4ZIP/8cjeLNi+KYVOEa4P0hZwjIY78LTl8igpyj2pXg/DkyZk5D/4z/JX?=
 =?iso-8859-1?Q?LyV+TQ0Rscfbzoq7pqlE5s0EyY8uMXALNvrZnMrGkqpZb5mPybglAua5VV?=
 =?iso-8859-1?Q?47+KWqASrtUDzzaM6lqsKNFxt8pHL1AHd+zO2xMrP49FY2SQvw/P7LTWXO?=
 =?iso-8859-1?Q?A4WqxmXJD2YE2rsmNveq45mzmHNdcnoRXS7Uq4LqeztWsM8G3wuXv56v45?=
 =?iso-8859-1?Q?YejeZwHxk4zpBpy6jOgnf99hh47uKiffKXgYOYhI64/pkjME8ONjWhehwQ?=
 =?iso-8859-1?Q?5yVppQWeea67j6/bYlK9vQRomuFV8XZFYdoUASYk/E50QcOFTwSUQhfEws?=
 =?iso-8859-1?Q?IDP7XFxrqAUyvW08/kqYEHkF8EfbBNrcYgqaBQM7HQbferWgIUjU/LbPv7?=
 =?iso-8859-1?Q?Ip74qMXu78X+M/ESVQtB/NaILvGS9NXekCeP7TMVfuJEVf2MMD38xD9oY0?=
 =?iso-8859-1?Q?W85J/EAXyw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d919d13a-c38a-489c-6722-08de7f6a6a8c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8249.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:33:36.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Enea4Av84Ua42bJOTdVbf1Z4FZbHRCVI1x5nmmXRXBPyhASWd5iuHsHpgOVWn+A5pm12LBI9ERwyQDpvE07P8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8051
X-Rspamd-Queue-Id: 57F24263A87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8232-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viorel.suman@oss.nxp.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,oss.nxp.com:mid]
X-Rspamd-Action: no action

On a soft reset TPM PWM IP may preserve its internal state from
previous runtime, therefore on a subsequent OS boot and driver
probe "enable_count" value and TPM PWM IP internal channels
"enabled" states may get unaligned. In consequence on a suspend/resume
cycle the call "if (--tpm->enable_count == 0)" may lead to
"enable_count" overflow the system being blocked from entering
suspend due to:

   if (tpm->enable_count > 0)
       return -EBUSY;

Fix the problem by counting the enabled channels in probe function.

Signed-off-by: Viorel Suman (OSS) <viorel.suman@oss.nxp.com>
---
 drivers/pwm/pwm-imx-tpm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 5b399de16d60..80fdb3303400 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -352,7 +352,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 	struct clk *clk;
 	void __iomem *base;
 	int ret;
-	unsigned int npwm;
+	unsigned int i, npwm;
 	u32 val;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
@@ -382,6 +382,13 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 
 	mutex_init(&tpm->lock);
 
+	/* count the enabled channels */
+	for (i = 0; i < npwm; ++i) {
+		val = readl(base + PWM_IMX_TPM_CnSC(i));
+		if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val))
+			++tpm->enable_count;
+	}
+
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
-- 
2.34.1


