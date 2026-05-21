Return-Path: <linux-pwm+bounces-9046-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kESPMuFVD2oFJQYAu9opvQ
	(envelope-from <linux-pwm+bounces-9046-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 20:58:41 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD045AB4BF
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38D6130329A0
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95213002B6;
	Thu, 21 May 2026 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TR5O7iXO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745593DCDA9;
	Thu, 21 May 2026 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779389840; cv=fail; b=NRG3aNv+/cfdaZeYokrw2nCTfGDNI9e1hxtoscafQ/bckoTHj6f2BCJNqMpn7AgohR6wNPSClcn+QLzmk++q6ZP7Du60Lb9D67WMYvfTYQhaV+ryIruxLKfOU/NEjXbbVDZF/CMjIjypMmy+H5LMOJ21Z04ty5gVZdvdi9tkgzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779389840; c=relaxed/simple;
	bh=I6jv3ykflDW5yHqVBaabgkEBfSLB2Oxyp5n5rKX+6Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eHvxCzCzTucUs60LOCsj1Aw9WuVLtS7Hz0IidXiYEhEyzPlgQs0ohorUvbxIkomGlCRrbExid6ZjilEMj1eBZ/MNjXMfQZUemWBohHXREB5sgkglSvlpRJNsTlGX7zVcBwynPJc+fA09RUwPLEMp/GeBEkdztYEcBwj7aTnMPqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TR5O7iXO; arc=fail smtp.client-ip=52.101.84.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYikIAkGcIWcuoKlPetK0aqZyiDtzb7jQG5o/KJkDDcywF20sPwghwBKmGOQozQlrlTyK67G0HcGVRf9Bfi1tJ7vEtPFyVP+I4Ibd9n07LVAP73IU170W5s/HvgaMKfbZJ5TmzYmg3SVz+APhq/yzqG5TPZk8oyHvgMkxMjrjK0g+q7V5ixp1YV81X4jOcz6WyRnlEoH/dAX0G8k10HE1vzostnXzXmO+LS+eej8yeyJa1U9CrlyuolW8mFgbTAlGrkqB2LvyypWw74AQXbbtSXYxeSXurvSRsze/n2e80wfK0WuBYXFz6diybsgmCeNu+p4Jn2CmBjHZzEhOBmsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQPUvw1EVv3wMo+5XCqi3dBxzVExXxLWd6AksmEn/LY=;
 b=g1GjVfTz2O5J1J/53/Nr3qGTpvRhL5LVdu6MmYwMAGGHPMPEU9uWKfCm/dvVMCf1XAEJV77vc5XEGiAg99Ppo66dpnyjjsiPrgPVhAjlqReWlQG81KVN+WeTwM/9yT2dmbSzdHUVps1qb6tF7EXU6ZrlR6dTZhh686NXllWmC7flcx7R3XsfDEy2qA3lNdLHrzAzh53sGE+3hvZA0C/nw+GwD3zouvAJSXVrDAHbsBgTYYk3Pgon0B47rgz/AQvHLV8tlqW7wLwuVD8WSB/jvsbFuEHY16//kjf7Dq9a16glWNdUlulvBTCfPXyCmSSUGf+yzPrT6kMhuK6pDunwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQPUvw1EVv3wMo+5XCqi3dBxzVExXxLWd6AksmEn/LY=;
 b=TR5O7iXO41Iig5fpd4aAwAnn7Ftjl74Mgz3TxQI5P2N68E9X/2icZIAXWX7sh2KoedOe4DkyIAZw8DKWrDpqzTmdotSPvI9l5ttthbYXY2Y73Pg+KoBy1jxcXSYurwPojjqJamiVGZ0rOk87yU+K+ntUyxV8KlQBXb8AY05tqQ1b21bKdoAw/cbSZNf2AFRN5QENExYibcxKPXSvKIstXzH1ru44qsQP9thb1LXJZJyx2CtCd4UpW/sOIIAnH9BSS4EOYYoJ5if6wEfEU1Sd3YpRZ4x3Sd2INyo05h2PDrGQWzq/ndv8U7k1EaKnlDL5zcIfDDmCyWUkNLdzXFrb5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by DU6PR04MB11159.eurprd04.prod.outlook.com (2603:10a6:10:5c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 18:57:15 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 18:57:15 +0000
Date: Thu, 21 May 2026 14:56:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Ronaldo Nunez <rnunez@baylibre.com>
Cc: linux-pwm@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: imx27: Fix variable truncation in .apply()
Message-ID: <ag9VcFoodZjxUsBg@lizhi-Precision-Tower-5810>
References: <20260521000054.4790-1-rnunez@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521000054.4790-1-rnunez@baylibre.com>
X-ClientProxiedBy: PH7P221CA0042.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::10) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|DU6PR04MB11159:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9681d3-bc80-436d-6430-08deb76abcc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014|6133799003|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YeDz4+YaGBvLHdNkJEiBJwbo+pRY+1G+YYQNadIG966tRgFseKkc+H0oOyP8liZTxqIZ9mchDgC3ttNJQcpDDRhO4wwBkwA++repejM+CAfzON5ZQOhaVnBJknGfzuuzOqjHtyoDiN4HQXG0qrdukklAPKx0r3hR+9RImACyjjHuSmcujOqRYj5pnfAn0sXL7ch9Tw+ijFfwf5/Hbr08Crlf+ES3tEJwQzJDrsoODaEhwONIfJbu1JogH+3TWDR0J5jNrH3KIuxy2eOyosG5iicES1V3WUlHvbfbU03m8Ivc6JFg7oXNlXWg4cKapNPTxDT25U6xYWrkqWmbumFaNnuny6uAMfUtkOC+iXf1icMP5HFDTkewXcy4RQ/MUlCw+emmZaT6gG/0YvMI9+0ZYrZ4L9L5MMcaWmEfOtpbUM5ouGoFI6k6tLWFia8Efs2u3pjW4J/uW8Ji6DE0x0+LY/qzgkBy0TFdhZKOPJfcNfkGfUoLOVuEndxjySUjidTqFa8lkHw+fEIcCZ1MR6kzlUaxVAuwj62mnolgtbdXafvTKOQasz/xLuOIdi/oZREMfgJKDVHYJLHq+vqEYqYm2vQW96UaQ/fq6Zvp0JH9nAnhZohegX5FELeQtLIOEYHqJI/uDffFwmZ3JDpTlE9PcN+JYBjZ5zrv98UDI/zZx99BO+py5A097iZQXFs+l9a73oLFdnFHP5Bivdm64H3+fnxm+hkESQQ5DAHHu5+rnlR/ASBQuQBIYR9CVvvymbve
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(6133799003)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+8F1D83dJSfbtYS5YfZpCxeWmjfx52zXwxhyq2yUgDU2UqKiABouWlRIRzdy?=
 =?us-ascii?Q?uEM53lWxHmh7CNaB5fZ/idZGHxIgV+DhrE43C/kRZrGL00Nd6SiOBILdxMhd?=
 =?us-ascii?Q?o9xeU18jlgvyCuNs7B/LpGJCYXi+GzRHfqNZxJnRxp33D5yF/4ir1IAxVj9o?=
 =?us-ascii?Q?GPmvFw7BVnkM3zstueZ7Am+vzuN2KdgoJnL+VuVVtolWdL5yPwFH1BbQ98hR?=
 =?us-ascii?Q?bGgILVNJKudbufFPuVeFxD0urZke8HWzNKVGWTPoTwqx3afLaQdofcXUX+hl?=
 =?us-ascii?Q?wJmkWSxsFww06my59XI6n+mmiGCZZ5jaqkMn22V9Ye/CetWZ/THH8DK4sDka?=
 =?us-ascii?Q?88/k1Lq3YRNcyvGwWy+oB77mTKDTpy75wJtryke5qhqfpcSwTTu5hMmm5Q3J?=
 =?us-ascii?Q?6o53hbiD2LaxlrXZkLokGsjmyA1ee7gm8lJ/KJrE3nYdnvB1d7GmZnHd1lUJ?=
 =?us-ascii?Q?LCy8fmu2wjrrzpszWJB4p59kogtV/8AMyxYzvQwlbTdcPbK0pJoKB0rm73Qq?=
 =?us-ascii?Q?tYmzmaD/4mbqOvn4cWR8I3qxcDYGUEyTud4plDFJV2vx77ecY3ueh+0bZHrd?=
 =?us-ascii?Q?XI/pMo2RmRkpPLndHSJgqYCe3tK5xBiS6PZcaC3ZCiVM1AStIb4eNxKomnqB?=
 =?us-ascii?Q?BCVaKVX5oPJtgxUrj/zBYhh7kKiOkhVQiraFCgki1VOz/54Aa+bdTAW7ycV1?=
 =?us-ascii?Q?l1sJ0fzqaLfhMeX4r1C4nePk7ZNF7xGpMAKb+ikhwUH/zRehOJAyggkIW380?=
 =?us-ascii?Q?jWVRQPRwo4ZORsfvyeyz52WeGDkJ9EZ8n73VrHR/66glBviaWkY96hV9gJx0?=
 =?us-ascii?Q?iPRNKZ2lXsVwdW7Dso2Cheqik5jVmdlr6EoQZGy2nm60gEEvEA/4LxhsTV/m?=
 =?us-ascii?Q?D/638gBNcg0wavr6z9RmfWPceRkVOfck8p8zCjqJPJLHIpjhNy3tCBf9xIYW?=
 =?us-ascii?Q?ZOSN+gXG/hyexnn/hMVchuuDdeN+IgY+l5hIx4MH1FXSyJeJijtgtUuPKQno?=
 =?us-ascii?Q?8J2bLTU1BSxSpecnPCgLDOu0TdpJoUjm0TIB4vy6mDTjBPckglasXO3PaLWH?=
 =?us-ascii?Q?sPHivYfDqbq7+6UzECm2UHL/gbCLKNtdREhU0QdeluYdPTtIGy3svTBb2gZd?=
 =?us-ascii?Q?FeYHXBql/TrhD6scSy2YTr3ysOhghmaf+Vh0aWyvjI/0jgrhWjf+ekJhhFgL?=
 =?us-ascii?Q?9O4Rwe/8MYMAJl3OiRe93YFveGMZhm5ejTy82CwbGw4gKLTLQ3rIZhBbAkpz?=
 =?us-ascii?Q?VuYN7dEpRyOIzO2EuNDcr7PfftvpH+W3niYIR+qQdGNj5Y8dloYy5wRxrumr?=
 =?us-ascii?Q?wo7KubA0glVyC7tuZqXQOdScZW69ovkKcqFCJ6bUqQlJuMpQl0I/eSqylgLZ?=
 =?us-ascii?Q?6pyf3pF66sPMYP7Vixi9bymcHp3lMbMXSKxlZOTx4Lgj5E6tM0/fC7dw/g0n?=
 =?us-ascii?Q?Q1t7rW7igw9Z3C68Pe0ugP8ZiEPGrPfl1kP79/rWbqufKfcfRQPNalWBAc75?=
 =?us-ascii?Q?gZJ1xM6T42nmR8baGRu4qv0dmKYx2TFdlkchnOY4uEh3A3LZowMN4yZaO0k3?=
 =?us-ascii?Q?FSwHNq0O8V8IgI11kGEyhLkfa/hyr0iWaHzdebnD4XQFm8GwU6BCd22Abf/w?=
 =?us-ascii?Q?9QNOEAgNuOjYiYH4C3J/AVo/huxLDul+q1xE6IcEZEPbkUn6tSMEoq5yTUKm?=
 =?us-ascii?Q?N7tHW8DlUwcRMnl9xKIrXaBZs3eZ5N8IBmzbEmeWpXb3aU8t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9681d3-bc80-436d-6430-08deb76abcc6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 18:57:15.0967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydTcogGY7JNR6ZWYTb0zwZNy5LPSKV9uxGMf5UbVq6cHEh56dwzFIsBp0eG8HXqYoTyL+1P1r3B92QEWQvmQiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11159
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,pengutronix.de,gmail.com,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9046-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2DD045AB4BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 09:00:54PM -0300, Ronaldo Nunez wrote:
> This patch fixes a variable truncation when calculating period in

Remove "This Patch" just

Fix a variable 'tmp' truncation when calculating period in

> microseconds as part of the solution for the ERR051198 in .apply()
> callback.
>
> The problem was identified when reducing the duty cycle through sysfs,
> with enable set to 1. The condition to fix errata ERR051198 for period
> smaller than 2us is always being met, due to a truncation on tmp,
> variable from .apply() callback, caused by the multiplication of
> NSEC_PER_SEC, PWMPR (period register) and the prescaler which can easily
> overflow u32.

It'd better provide actual example value for PWMPR and prescaler when
overflow happen.

> Declaring tmp as u64 makes it large enough to accommodate
> larger multiplication results.
>
> Testing:
> - Hardware: Udoo Neo Extended with iMX6SoloX SoC
> - Tools: Verified with a logic analyzer

needn't this part.

Frank
>
> Signed-off-by: Ronaldo Nunez <rnunez@baylibre.com>
> ---
>  drivers/pwm/pwm-imx27.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 3d34cdc4a3a5..c8b801fcb525 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -200,7 +200,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
>  static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			   const struct pwm_state *state)
>  {
> -	unsigned long period_cycles, duty_cycles, prescale, period_us, tmp;
> +	unsigned long period_cycles, duty_cycles, prescale, period_us;
>  	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
>  	unsigned long long c;
>  	unsigned long long clkrate;
> @@ -208,6 +208,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	int val;
>  	int ret;
>  	u32 cr;
> +	u64 tmp;
>
>  	clkrate = clk_get_rate(imx->clks[PWM_IMX27_PER].clk);
>  	c = clkrate * state->period;
> @@ -249,6 +250,11 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	val = readl(imx->mmio_base + MX3_PWMPR);
>  	val = val >= MX3_PWMPR_MAX ? MX3_PWMPR_MAX : val;
>  	cr = readl(imx->mmio_base + MX3_PWMCR);
> +
> +	/*
> +	 * tmp stores period in nanoseconds. Result fits in u64 since
> +	 * val <= 0xfffe and prescaler in [1, 0x1000].
> +	 */
>  	tmp = NSEC_PER_SEC * (u64)(val + 2) * MX3_PWMCR_PRESCALER_GET(cr);
>  	tmp = DIV_ROUND_UP_ULL(tmp, clkrate);
>  	period_us = DIV_ROUND_UP_ULL(tmp, 1000);
> --
> 2.53.0
>

