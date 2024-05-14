Return-Path: <linux-pwm+bounces-2170-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2110E8C5C06
	for <lists+linux-pwm@lfdr.de>; Tue, 14 May 2024 22:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863DC1F23890
	for <lists+linux-pwm@lfdr.de>; Tue, 14 May 2024 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A5E180A92;
	Tue, 14 May 2024 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qL2L1dBf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF1D181333
	for <linux-pwm@vger.kernel.org>; Tue, 14 May 2024 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715717148; cv=fail; b=AqA/qGv36b+w9GrSx+skV8QiHq6z08gQkDiFVhAtT+SGs8fjHqxJhta/SSAMnugc3q7hEYw/ImVTDk1f73xeRI36AcvzvdifoDID+5510+5S6rEi3OgQcKOJhf1cVTJxl6povcgx6Kj0ILnVssIZBhsG7z2HKhygPCw8oaeGggY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715717148; c=relaxed/simple;
	bh=Q3vwZUsVSpubghSWOJrRM01pyrkhaL/zpTuRScITy30=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Dgc/kCPVzdJZI3qWB3fz/MXzrvDXKbF5LhEYc8xDudofg0YER4aWXvqq1XuhAwik6742jybWoEr9dZNfo1WorY/I458DYccFfFNX/S4dRSRLcf0a+ZHnMLzliz+QmW/xWzthSb0ejYSyUDPRizft4bKJj13EbiD5nB1M6jz6AL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qL2L1dBf; arc=fail smtp.client-ip=40.107.104.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR37j9yO+H/a4CIwBoYjeTAF3TSmns3OxArDtvwkyqY5AAEDUCV9gNiyMinB71ItVWEKSWfclWTuGYRZRlu7IfVuwnl1HJLNyNonj0qzGt5S8MfsHyqDmJyJxNoZLIvsJgqHtZTBS+RAJnbTUQ0QksOeWhdZoFzoYSKPvm3/gcn4Av9uAjI5Q83VsTNj8Cw3qn/mpO/2QeO1QsLPa7NMSokfDqC93beeR09yBEX6jE+2rrgrGf3Z2sA7HKxj9ki7wEgt/426l7SE63qG7/RfkfYU34dNOCVpYfmI74Z75pDkoonNqIWqnpGCs+8tkpQ2lHKj4Y/V96H7l2Xu1S6EMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWao8nhTwDMVhh8chAf/CwxBNxQaZzVpnpgp/+yTgTo=;
 b=FCVdZL9T5ZWBDsCmTN3cZABQryDadW+v7rcvkD9lxKe6C0Kbqz8EfLbKSENK6l/9+gxYu8ftyqsq9M+ojgjdZ4rQA9DB7+ea5qfmgghuYTVlap/InYacxywJ/NcH5YJRsYbbN5Xz+scFUj5AITl86rL24lA0+f0x8aisb7NtC2KTiEdHAN0uZ7jjK8AU+/3nQ9ANrSfLmVlRiRG5d/gvj5Ospxq0h9yrJJHUQh3v6ohs7rdh5pYCl8CIOqMPpX8QgqiTZrhEb8xzs4Wo6I0gtgOAGNGV1Nl4cUwjG8I0rTZR/amnxU3SP1wl9gSlKdTW4REuqmwWtDqAGZnMnlQ/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWao8nhTwDMVhh8chAf/CwxBNxQaZzVpnpgp/+yTgTo=;
 b=qL2L1dBfiwDRXkOLz6VK79cCoBCOwJ30Mbe5N7BMY0LyFkPb21HXHz0HCahLC/JVCQndUetMXbS1wCr9lxr330GWuoUZzPiMOEkAc/DEGJL0efSfD0oK3UdIs2qP+39qgDV2TvS7TJYFBJZvBX8ORMoVcvMFIIiOc/VHyV14eFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM7PR04MB6807.eurprd04.prod.outlook.com (2603:10a6:20b:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 20:05:43 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%2]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 20:05:43 +0000
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
Subject: [PATCH] pwm: imx-tpm: Enable pinctrl setting for sleep state
Date: Tue, 14 May 2024 15:05:34 -0500
Message-Id: <20240514200534.73847-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0082.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::23) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM7PR04MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f30f6ac-972c-45ab-094c-08dc74513c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zDth5/BWnXK0UjbSN42Hg4ZtMGjxBz/R18DS2INtycXj7mkqUp/R/Xpph17+?=
 =?us-ascii?Q?K8nP2muCt1rXUGj5AYjVlMk3h+XXLght3/1r4nvvJY2KYr1tbf95XAenYCrQ?=
 =?us-ascii?Q?bmpYok7dGGAflBwa+hpElTN5j2slLZLL24tEonMPP+5dH7WHofY3wIfPahKr?=
 =?us-ascii?Q?f1LqDwy5RNtpR9hpl42UzdF2nRa3grJmNdUdQtMYNIWIAAnxmzsvtp0ii9Xz?=
 =?us-ascii?Q?kFq8MUhgfPG3KjuB9ElQ6WuJ/JLj1ij7lHtF6Go6NwHshqnP7jePwBB2YPRe?=
 =?us-ascii?Q?2TcVhX0yYYvfkn5uFTvCv/3pBj014LzXB6QXG/RJAWBNBvh148lar4eaWIIx?=
 =?us-ascii?Q?Mz/p3xNHNCXjsXbhh8OB94Z0Yv6c/kQBWbUj7+B6rZ++ugifiWlyYFsyDC+G?=
 =?us-ascii?Q?0XbURhkG1DgdBjydZwwf1NT8rOZcLARmvaU21wqBDmdlT9X8ZtFPCsMyEAXo?=
 =?us-ascii?Q?LGQYZbonZm0dXwKvO6ryMnoRgv+V0mqqwAJ3vZDJ5OvuQkexGgwEW5CKI3aX?=
 =?us-ascii?Q?pZnEbM+xFj/NeopI/s8U0zaAgEOoZLz0MppVmoIHAtK4vn6P7ZnM5MReY6G3?=
 =?us-ascii?Q?rFKI0WI4BSwQZZc364Rp4PjtzRAkrQGonOgz14i9LOpXoePZz2fhsQXBlF7f?=
 =?us-ascii?Q?b2VJVtmJ6I/vHFU7wCfPSXvwofOCIP5AiKH8+j6Yw5c4OwaMF080VPyZOn6M?=
 =?us-ascii?Q?cgeFT1yeQzXxGUktS1X7yWtCHRHITvCbj7fthc+2VevhkDgiXE5U7Ggl1l2h?=
 =?us-ascii?Q?3aaibOqqBYpyxxAODQEK9tR3zWe4h3pjjDpqPZ47E2k1l7+sn5TX5wkeNmjE?=
 =?us-ascii?Q?V721J55ghkIN8sAbLIr1tkC75KTr5HKR0irmBr2wkCZDoG06tsEyWymBpwUr?=
 =?us-ascii?Q?SoTenYCKnBUMN1cHt+dT5uJtrYUa7XHmBvuk6FN2MGLksyuaNAB///CCM3aL?=
 =?us-ascii?Q?tjJudAy0KvfIyrgujBv0oUgB0ov0PL/yw6DECkBQ/5TXI0XDGE7MB+uoBMCm?=
 =?us-ascii?Q?jiHyfVqzpQGiQRxi8YOGz+jIu/qWQigUu3QGUENeRjilLZhZTQmX4ex+Bx5e?=
 =?us-ascii?Q?IcmYhOX5aYfutYxXGrBaPMJZYb9gOfF23vwzHYrXxgz2AvUF9LPVf1KtqruK?=
 =?us-ascii?Q?wkLiDkTHRL2T6Y8xu1HXMd0OUSWRxEAy8xu6NOaAuG7pyJ2pKxNe1KxaOToY?=
 =?us-ascii?Q?tLn9NAQs5W/5YweeDABIG4sYoYjS4vRoC4haCGHL6vWDxJ7c8rXWOmspAVXB?=
 =?us-ascii?Q?x2FKC+NVUc1knmAxL2UNtc38/LDKXBv+8DsoYGVFC5dXVSC/kXW/xjVidxPW?=
 =?us-ascii?Q?ATXtf4zEA4d9cbh8DCkqEvTJ5Qet1atRTXjrN3fOXCkxwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mXvauGlMbZNXGMSevn3qpjluXdH67GcMe9kuA+SqjHR2QakWBTRkPRaRUwlj?=
 =?us-ascii?Q?EbHwdDz/DBT1lUw7bN8RUZ8B5FbJm9fIjBYRHFdvYu4aOg3Auyk72+L2Hcpu?=
 =?us-ascii?Q?xM33Spqoi0ngWVxX+BEDWxKHiYIeN9qketa100B1gSZb5SIA06U+CWobX+Z+?=
 =?us-ascii?Q?FBRujxJ/DYufvfjFiNE3RfTNxFXq8buEhimgwpMg1Pm8uxFlk3MNskWOt/bh?=
 =?us-ascii?Q?wmTeZIKWCrBBDDLvVfe4J1Zv+DgU5CykRfPfJDWYNVeZP/Z0LgYAQ//tz1qt?=
 =?us-ascii?Q?wDyM84FSBp8XLKXPlbvXYN+iR8C58zYnBlzASmVHdFvqezixWJzjcyWMPL4B?=
 =?us-ascii?Q?5TezCjYyMNsno2xCRNQQc4vJE0PR5fpfskPpt+sYyTNJsV3Kv8kNIMJgg1Uo?=
 =?us-ascii?Q?NpSwNZTgtBtqqkUAYupzAlxyms1zokWVO8Vvx8ya71Hx9kOLMhciSJBNu8Qu?=
 =?us-ascii?Q?9jIibZOKJj1f92qS5RkjHvFuIEXsK3daX8FunrX82LuxYUlkNn/Fq3iu/yue?=
 =?us-ascii?Q?21FR2HSQYy6SEj9Mr6XVa1ux5imp1QmzNf3CcyiZr3wEWEpzINLmUKDm/kXw?=
 =?us-ascii?Q?iglIDDMM12W+6+i0FmLk0obF0J8ldd+iejiASFvhEqRxKuB3YY0KtbJPp7TF?=
 =?us-ascii?Q?Eq6bMQXc1jS16w7ohcWr2Rjvon6HjN3ZRKu+76hg2GqDLnbQVWiQf0IgviNY?=
 =?us-ascii?Q?cF3HAu+dTm/82GOCjLe3xf7/Bz06Jh/dVJvaFhaOYM0TQUg+UEH4fRXgpDOK?=
 =?us-ascii?Q?MafTbsGAMPUNz1FBWtdMhDZB9/0bCKlVVEk4u5DurUzrFi4FqZb7yL3+rxFn?=
 =?us-ascii?Q?UqloY20/iBOX3WAyr29pPluw64qUEmPfEMRkfdrbqGqJ/jJTUQ/SpNu00bgk?=
 =?us-ascii?Q?ManTXd4XhWUVfi48Hklk3ayiDYkILUCF2kjWbEs04dCj0+qIeq1wUd4OYtcx?=
 =?us-ascii?Q?9Owd850Zg9rThs+Gg5VWo1REyCs66szBtfuaFsbCVB3oaHxefKg3iVp5aHc2?=
 =?us-ascii?Q?DTIaNqdtfL2uCQ5snTg/Ih8S8+5hfvdNLRgGOyp0vtqHYcdYevEfWC9txjDU?=
 =?us-ascii?Q?3d2jSNNu7Pr8m+PCS7mA2/YjaKkNCpRTiqB/PkHXqTd8Bsokn9dcppvzfeTy?=
 =?us-ascii?Q?UjfP53PFhBZo6M2PnIErUmXmmWiBrUhUvgPE032/RJJRuAAASnQ3RPL4R2J8?=
 =?us-ascii?Q?H8+10GXhR6s1P2ArsMuqnxOJwp/FFYGSMBw4mMLFZH8iNBb54cDwq3WpPY3L?=
 =?us-ascii?Q?V0IyB3ao5bQU32eJXcMUlqKFFSZYPJMgkKeHRvhSX33Bd8wPpHPeEbqCfqhD?=
 =?us-ascii?Q?RzWTwe7CJ+lrY8Yh3ZEh6h93wLgFSX+CsTrkXChgqsmFXobGz0WjBs1YX0pX?=
 =?us-ascii?Q?Z/IuIq3Y68z2Lo9CNGo50FyeNF7xuBXd0gGjd6/DqorLmEIknkQJdZwsGdg8?=
 =?us-ascii?Q?SS8CMvmvOCxPYyztNdufMFxOBuJ87eeGmEnggm4CTFPAAywDxvLnSHK+3bSk?=
 =?us-ascii?Q?vhMdJ/gHQ+myPAoCqv00NXZOVnb6lnJTq5SPkr5MeyjXl5EooxpIuKwGB0Yq?=
 =?us-ascii?Q?x+LqceZrwVvA/dIfMg8ruUqtidCQsMvSrPsgbXHL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f30f6ac-972c-45ab-094c-08dc74513c4d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 20:05:43.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oq2h85W7ZzKmUON/dli/p7JUb6jd/7lzqhSArfGCyxB+zIBaxmuyI/KK9l/rbhO+GhbBMNjV+scfUW0zgKizrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6807

Apply the pinctrl setting of sleep state when system enters
suspend state.
Restore to the default pinctrl setting when system resumes.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/pwm/pwm-imx-tpm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index c50ddbac43c8..19245790c67c 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -393,7 +393,7 @@ static int pwm_imx_tpm_suspend(struct device *dev)
 
 	clk_disable_unprepare(tpm->clk);
 
-	return 0;
+	return pinctrl_pm_select_sleep_state(dev);
 }
 
 static int pwm_imx_tpm_resume(struct device *dev)
@@ -401,6 +401,10 @@ static int pwm_imx_tpm_resume(struct device *dev)
 	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
 	int ret = 0;
 
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(tpm->clk);
 	if (ret)
 		dev_err(dev, "failed to prepare or enable clock: %d\n", ret);
-- 
2.34.1


