Return-Path: <linux-pwm+bounces-3053-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370E995EC11
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Aug 2024 10:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4A01C21376
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Aug 2024 08:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090613D61D;
	Mon, 26 Aug 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UjtAv2iT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F69313C9A2;
	Mon, 26 Aug 2024 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661210; cv=fail; b=TLZ7YFNBXO3ngYgG5Ls9CDYH/l16k4983fUkZDQE1Xk77+pN4yODO+OJDp056LKpxuinwxUNFk3j/KAhGD6tPoA2WcMMz9DDi7Up4GDIvbj7aOqzmsnHrm2igQd9dnoAg11dE6n8645ayzX3cNKcQ8+839kCKBnbiqah1qT1ZCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661210; c=relaxed/simple;
	bh=HPlWVsJzXFZXal9Qxvnl+seP+Of+CWjyuE/94RHu798=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kNdbNi5csDMY1NOwTOsC95KqdjCkLhyp0VAhxe62ASh6ld0Znns/hbg9Vv8lnjtmQhmKMXNCjalTAXngDCcDD0YjE2FB6sAPdx+89zGD1Rpb2M3M5MhvLgAvhw2RvMyjTayBpaJGWxDJJ/7Ny5R5Q2L2AkCeXSgmOs4cZb3qE7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UjtAv2iT; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQKTGqBLBtvFFVTgTkE3awHx47Ng6CxtWpLAtE66Ttl9vOpCTQX9N4OCUDelV4OLr3kXmHOnY4KHsfjEa5WY+tzeU41U3zTSy5l2zgfOQlX2SGzUx38/WNnKChds3EiMOnXvsZnMs3ko949pUXb3495Loeysvi0NJmuWpK1m7becIiMNH7XFDiBqdfJXKOmEwq4I8xidgx55+dBfujUfnfez9dkwbXnjISFBJUteLz5GswC+jxjMKNZfTmeqluAITu/fKlswMKdQJUaUKcQ32S/aXgxIWPgSMtcrjG6tJAHyf0xHL1EEm8amonlUO56GPrdhOG9G8NcOtMWQ612yWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS0ZLvGm1DuC3MG9+fg3xjws1HrMG8Cr+MaVXDfozPo=;
 b=gqKsPDbFzVZqOeFyeb4jojUY/6PKBJWGvrS46U1ZyaPWvCkU6s4kKo0rtp6JNQ/YtnerfVbM6dC8y22fUPZw/bya2L/rveHWETNfQ/8UzZIpNLdzLtnotWHi36PDmGuVYfXOGjgdCNQbJ70dDyUTli+ThPX/tNeuVKsCePEtgHyXaM+Na0utHsKKhN0DuTAqiTmuhcJ6ejfZjL6x48BK/MXs0J1+kXuiQgXVRT3USRrKM4CW2XjPkDXGmDnE+gwhUEkDrTBo2dzd9zKfk+IppUBvqQqbLX9X+fTJ3wPYnfWPkNi9yEFYvMko9OzRxUA68sbZKmcjb2lh2w83nU1Kww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS0ZLvGm1DuC3MG9+fg3xjws1HrMG8Cr+MaVXDfozPo=;
 b=UjtAv2iT3xJ5SfxN+x05/tLgC5dUvfg9hPK0B/ddUollK5VwZktMpWyzUMod5pO9LaVdHxmsRgUz1ed00MxyGiJQ8dpITPlA25KYLLS4LLRlBRzeamrzYOwCMTrSFmxqZ94xwJ4lbL0sSPSJSLB91YaIeWQy6RIiuk9qBf1K9wHcTBdbNRTdcngJpMf5NbKISv7L/94wxi063qVLDUMi4gY7vCT0KMFloPDSULhrkry+q5ekU8tJ5hvuoJxaS8hDcAxTPRfs8IYvbo8Wsa2CsRHrca4LB9AcHQwVdaZk6sMOTyo0RUEWJtZxjZaIrboRh1rkgyb8TifISU4MLDeS1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI2PR04MB10931.eurprd04.prod.outlook.com (2603:10a6:800:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 08:33:25 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:33:25 +0000
From: Liu Ying <victor.liu@nxp.com>
To: linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com,
	ukleinek@kernel.org,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	lee@kernel.org
Subject: [PATCH] pwm: adp5585: Set OSC_EN bit to 1 when PWM state is enabled
Date: Mon, 26 Aug 2024 16:33:37 +0800
Message-Id: <20240826083337.1835405-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VI2PR04MB10931:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5984fb-e086-4f9b-3ca5-08dcc5a9c07a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Mg7VtQl6S3FGOXU6v72Nu/x21BLS0s3ZG5ZH4m9YPU/d4KIW/CQH7sNsmh8D?=
 =?us-ascii?Q?dM7Ykhpo0SBt+UWRqRqUSlCmWeuH7WWO7jqSbaaz/0Ph4qXrZd8usKVjjYOI?=
 =?us-ascii?Q?ts1tQQbGiUt64AabLfUlmEnm/UTR73EM3Rd1SzBVSSWVptxlfgomzavalYrG?=
 =?us-ascii?Q?uouRXOraJjIie4eX7eBffdrfCSo/uBGHlWNyDkL9O9FF4x5UJxGm09pTQGg/?=
 =?us-ascii?Q?UJIkvKqFoDGaCJyNjKQwL55fzbz6/MXKbLOygOBwC9JmV9WkpnwlTk+yyu0v?=
 =?us-ascii?Q?HI5IrWDwCh80wlZn0FXLaQEfC64tRv4nj33IKHU96v8+kXITlCYkjUifN3c1?=
 =?us-ascii?Q?mjb3b/U8rJQn978Iq3vG/QMlxtUonCjw0evwdGQsB5tF4M4Xd7eWErik+m8f?=
 =?us-ascii?Q?q7QFQXIAPsazDu72+QleppFOKlr2pITvdnlm6gOXztlPeOz9MOytatwDmWls?=
 =?us-ascii?Q?28DIrCiebaLt3rAs0uoeqmOOYQM2J7UDzd3vlAJBOVxVbzYLdElKr268psN9?=
 =?us-ascii?Q?wAOqdtYiTwgGj+XW4t9NGdAe06Y6Zo1OlcR/dcnMfLiPdei5TnIvRf4kXKAe?=
 =?us-ascii?Q?SC9mRFmp0crNdZi9sqeZgOuKC8nQ4tyXIju+ikgNl+lkXaWCwAzcfETugNJC?=
 =?us-ascii?Q?v0j31HCKq41edsc3pQuBNjJETuGD10BTqVg3Dq2R/EKA47ds6XcEiDay+f9j?=
 =?us-ascii?Q?Wgfn/l8mlo6ooZKGzbqe6z7TB1W0fa5Y33EFBRyeDBZqvGLv3x9x73mGxfxs?=
 =?us-ascii?Q?s7vSGdASMLoSBgJye1mB5fOs16HAVI37/jU8vef6ecgWwPopQXBaY6m4N/YG?=
 =?us-ascii?Q?pkeb+nc+IyakfpEKVfG+YxvbSWFtW73rMgGIznFQPxhNpuGVRwE78XHA5RDN?=
 =?us-ascii?Q?60oC3R7PAhzVky5H2lzWuAdglF+2F93X59xGeZinO8gCMxGy3TuR1U1qi3pu?=
 =?us-ascii?Q?VezrsUIyRzFtK6dPks8D+0PFAjRQPLDcwmEn3hOxMhVh/Px5PzFQdlQ7TMWG?=
 =?us-ascii?Q?LBLt49yPVU40qfcNI5egLPTFXDFOKwQeVwl5PpmFK9i+AMTnXSgt5w4SgnIj?=
 =?us-ascii?Q?/Z+f9LSyfsWHru5lWOrRRdV6yJdLyXxerBlzdjDf+jfcsjbdhh2q6j66Xrl8?=
 =?us-ascii?Q?KZraiAaFMpaeDOHcEXO/fEzT7M3lQ3+ivNH7Qht6h1A+/Wr7yaOv1PruffRe?=
 =?us-ascii?Q?5+K9x5oXcaNoymDZumdqzWnIlMzuAqbXmeNtT30B5XeA0RerO/JXxGRpSO4M?=
 =?us-ascii?Q?ImOZ9JA3Zi6R3E+fw3hS8zNymnUWz1q9K3e3KEuM4fYikS9/nWsJAQRrxNKx?=
 =?us-ascii?Q?juyOJcwCa0R3rFdFiyXFSwZhVCh2+oCEj2fSBv62/ybqYqoFcpfjFj85W/iX?=
 =?us-ascii?Q?kBZc0SC6Ol6+sT+0OQMdztg0MkhRgLHL03Yr1d7p0DyG5sD5Fw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?lU7hJLSX8Kj1Y6fCrZAiUa4oMRILY+aCO6otpJLuvG07Bs6JEncReQSYr1mN?=
 =?us-ascii?Q?0qqY2lKMnXnMCSC6VeN7N79hHvkuO5zfEcTATrM8nq3x3cDd6V5XKsGf/Zq7?=
 =?us-ascii?Q?Gi1f+sbr4E2ZabzaKhIJEJzdUS3friLNxYZM16BZHHNGFTnFewh2+0oG5Rfb?=
 =?us-ascii?Q?swKFjMgqLzt+urFMPHpb2ddiztLbjrMvRBLGlYuRSZiZy4g+85AIF/poC8XV?=
 =?us-ascii?Q?Tuozz9RN8Nj2GDRW+m0/O8GjHZTrnyjCd3NXE/lhKefH4tixgGnX0wtL0Sso?=
 =?us-ascii?Q?WjmCjSLh7S61PiOoQlU8177fImzOAj3Mj4jfda2XJcNRNOqYFzyEzxVAs8pG?=
 =?us-ascii?Q?1gLdrB2PyfYq57F+UbbK7r0vNxzoLcaptvw3twf3dgWWfUvz5Tnhjf8qteyQ?=
 =?us-ascii?Q?rgM5Vz3OlLLPsEDOTYAXVfP11lf5emK6tVF7MDZ8jOUx6JMKQ1Z3leXftEx4?=
 =?us-ascii?Q?iZFCbyBMnaUgD0hohF8wYjyqNe1stuYNkpVY7AFLjb1rC7Ou0nV+vUAegAJL?=
 =?us-ascii?Q?nhsQHJ/gAFQ/l9K+rJQXrx9Bg5Q/b637KRQg1YAiEZo6jS0G9SduacNh2RJD?=
 =?us-ascii?Q?DaIeU7EeXqdTU7XU4UuLFEUKmgEHAEO4Bajf+8oCJfvI8UJz0y4sddqEexqt?=
 =?us-ascii?Q?vQu81dl9L8ck8YOponPJsABoRQoj5eB/kAfO8ia3njHtoBJHo97KPnabhEM8?=
 =?us-ascii?Q?TjwskFI4W4bzlnFqJ4KYBg+4/ZlnbE/QIOLAFfAs1GzOy1q6s2XYxJKLZOp1?=
 =?us-ascii?Q?6qxEZlyrt+JaxjG4LXNfxwCc3YD3O3EzBlY9wSapafdv2jjyy1YyikV6jlFp?=
 =?us-ascii?Q?gda6TXMZkYRrSq4xk2EzDxj4h2D1bvw6nrEMwsCvstkehFgZ3rBBNo/6XZcJ?=
 =?us-ascii?Q?QzxYRaLYkocnsGBXBbZ2/C8G1Aju5LExZzP4oubNHYG+UzrsAnkjseF0ZgtH?=
 =?us-ascii?Q?2gt7LqzZm+ZPsQV5JBTpcAN3U3WbAfcZ83RgFbQ6AP0btKeBrQZaqrbWhj5A?=
 =?us-ascii?Q?3CmJm8XRE+S5hIp31SnDvb5ugJT5+cwpl3Svyqqc0cdlQXJOT5ieaCLSdP1z?=
 =?us-ascii?Q?t6jDZ46nqLHxPuvCfOE/55jBKbB0mR9SxMkKygOwz3xK8EFf1kGAhvNTmlTe?=
 =?us-ascii?Q?1IUCOZ5V2pP2iSSd7mMrT5Gc/le/6gnSPWcEUEt8uW0hPi5sXN9/N7Wgv1LZ?=
 =?us-ascii?Q?PlzKdBRpaik48RxrLZqxxpwmC00ykK09N3GledQMIuoa7AozM6MNAGv4zkUS?=
 =?us-ascii?Q?A+zgi69ibQVcF23nVgQ+k27+hIHJQXAYjYsCw2Z127ggXWMgUsUGfjlC26Je?=
 =?us-ascii?Q?/Gb4mDhWbS1Ue2bSujA74UyeOST/QwTzcyQ4E8kMSe2AJtlyTbEdDi8fnlU9?=
 =?us-ascii?Q?C9f4/KKYb1GMFyvsK47uBVsBk0YuObo3SCa7G2OCZf812oIPjZQYnLBwHACi?=
 =?us-ascii?Q?VL38+OqYPWLISu3dH1cG24pO/yvL7QmMr/5xcWIgl20LopjWSfU31U9Si9Yr?=
 =?us-ascii?Q?JdgRileJTOak0CVl3Ct05De24cxOVET6E7U5eyZUV0mg7TaXZ34qVaIi/wDM?=
 =?us-ascii?Q?1vjHMgV03wycknFhIjkQi/JyUsrd4QCD0wv7FPh0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5984fb-e086-4f9b-3ca5-08dcc5a9c07a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:33:25.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRTkyIO9J961Dxz7rOwlwDVKYbwSbfFcZi16NQX2CjogU0v2Hb+sB9dRONqJauNEAfJLJSOmmQF8HswREjlLFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10931

It turns out that OSC_EN bit in GERNERAL_CFG register has to be set to 1
when PWM state is enabled, otherwise PWM signal won't be generated.

Fixes: e9b503879fd2 ("pwm: adp5585: Add Analog Devices ADP5585 support")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 drivers/pwm/pwm-adp5585.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
index ed7e8c6bcf32..40472ac5db64 100644
--- a/drivers/pwm/pwm-adp5585.c
+++ b/drivers/pwm/pwm-adp5585.c
@@ -100,6 +100,10 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
 	if (ret)
 		return ret;
 
+	ret = regmap_set_bits(regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
+	if (ret)
+		return ret;
+
 	return regmap_set_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
 }
 
-- 
2.34.1


