Return-Path: <linux-pwm+bounces-9086-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sL+MEjPAEGoSdQYAu9opvQ
	(envelope-from <linux-pwm+bounces-9086-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 22:44:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C05BA295
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 22:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9A023013798
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 20:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5A385D89;
	Fri, 22 May 2026 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NTtXqJRs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D676356754;
	Fri, 22 May 2026 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482652; cv=fail; b=T6bBthRZLvqlvVlJxDA+O5OKNyoBIU/A5lpo4q0V2zf5/UpbpmkpMb1G7EaN6+evH+ZxdNvDmOZxpMQsoVsexGSsCjpada9elDqmzARrPdkQ9pWvOPyvaPPEPVJ3La4Obe5BGNWfL7SvvuW0uDlT4ofAudbu32TOWZLzacFl9tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482652; c=relaxed/simple;
	bh=FOOtrssGnb10frTpIskUTJJp7JTFO2mtQRJu5DP7Jlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PxV2UuBMroLLn7uprn1BlA7oiOVEOg8oxz6P62N4zCFWwvr4g+jWs/SkfuD1mTYzygX3vJGo7NBSxmjEOo+nx2ZlqWyECUZ5qLB9AqIqNdxmIcTM1u8MzWvLgrDtX13uhF8sNvQKjupzKT+c87C5teu/NMCeIEGzuHwc9fWqhfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NTtXqJRs; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLuiLRYD4LMOBw1+O6hFCNP32QRVJKgfouGHYRAHGaOhId8/HGPXRRB8AprxGultZ73Tyd8OQ4OsS+9iI14Y5cL2yn5+dGD2R6aQNjNw4oibBx12d116cbkEEvKNU+RiAOXyl6Jd0cruy397ZW0Ry1OtxnDFrO1XJ4+HHYsOD9ulERaD3HbPeCUZv7Fvxhw4PQx8rSjCAD8ASTWfcKV9am81OAIpqMckPHfNpTc5QWTA2ZC6CnsRAmMA3rNeyYOIHNmyTfvHMvYvD/FaJmEjMBy9pbkfvuXkxEGmjWmIBMsPr18hG2NgvJaTRvEBxbzOkzylQm84xSQrRLF7Fa+SZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3NPSo2MXsZ7Kie6ukVjumeTVq5sNEUeERB7rB872h0=;
 b=eiFvUJZDOaqC2WLY4qDn7Bgr5a8Z8I4hN8RfbUnOPkTOJ8wHpJ7lnHe5fvyIywcMYXKwd+p1FKSzVczSnjQ9djS6yZ5SHw37NGyhv9di//aDt9mgHB4PbySvya6nYFip0wXyVxHM9uHdVRQNUbFwlAz5ufNQiBXlxUCAJXqOXYHlQtOUNn/4f4kM/PAYq7xkfZ++GuveDKvN/kN4mCR7GevnVLjZJnYNBuijn4C4DVwiSGX2jZi2qkFa/hJ8xo6sIhWdnpzB3zbp/VuxzK1v5/zJcKRsk0zqP0ALOi5wdDlpjBkrSgol5zvifLiEwSs/EqoUvdDDlnTCl1RmDjfPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3NPSo2MXsZ7Kie6ukVjumeTVq5sNEUeERB7rB872h0=;
 b=NTtXqJRsUwn4mJoW1UOffJqvrXo87TCMnYkDkS2GNhEDAyBP8M7HrNX+SKenJ3crP6sF2kiuFMYulR9hB4E2poUro3YxueLk7QXOeEp2b2H0CALhWcC3wxEyxLxf77GE6y1W3RJtIxJIJonYeOIaSsHdXUIOWrFu3IR6HAozWqA2+nDpukUS4RBsGVc+hqigLYVIZvSin2Vz62PvQvW1Jsuu4Vh2MnybhH4U48NoX5RB3hpIAFv9stKjDcaUVUZztK5ubP/4KR6x56VbRtnKqub8jdwF26PYsBoif6PkIgUPGuKyqrW1cwdkLRMATz/avHGQYrUZF8jm8Soy9SMfcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 20:44:08 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 20:44:08 +0000
Date: Fri, 22 May 2026 16:44:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Ronaldo Nunez <rnunez@baylibre.com>
Cc: linux-pwm@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: imx27: Fix variable truncation in .apply()
Message-ID: <ahDAEaCFAOwfctUJ@lizhi-Precision-Tower-5810>
References: <20260522191348.6227-1-rnunez@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522191348.6227-1-rnunez@baylibre.com>
X-ClientProxiedBy: PH8P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8622:EE_
X-MS-Office365-Filtering-Correlation-Id: 4671cbf1-73a8-4349-6a3a-08deb842decd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|18002099003|56012099003|22082099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	LMo+v2rglb12cDNdd/VmTLR0i4ocpV4frvWoqPRpDSPEfLFflWufvym9XmswZFa6tw3n7stXLNqtbE4Pxb/NYYNUysGyvVBvvUQBSaUzaSvnat/exKQJS48Kx6GmYWP11xApbmrz/OhcMuSN87Ud61124d91q57xxcn18vaNCm9A7vujwJQwA8LnXDefSqnBwJOGPg9fvGaBQDg13uoeaJcHhX/jXnZ0Z5wxJ3nEn11fRGuHOpRyvyRRCCV9TA8+19j4TpJekqjzNgRf1Zd+dHgP7tgMqtpR1iJ8a3iifVF7i/AWIR7I3s+VikRU0KJmP/aDv3KOnQpVmPFUsQ1GYHfetdQnb6E4UO3Kvk3F4rqbCwpsY7n6jGNxXgDWiSuZioG1l840JjvxEDMBhOqzquYno3U8OiN8a08g0ptG9KVBH5PdHFVFQiEGbD7+irPNhIvGvxxOWpOAD5QxZXBgZIl9Q1etHYyqY73VzbW4WhNyXal/ZSobFvo6g4uuxLcb8MhYm08fhEaGbbU0z9PaWtAFligTUJ/rKPpXeUErzog/w+71p5xaxVEmrbzXH+dkUcqiR5LbR1qeQgfqpBRKcIgMU2CZlFB2CXbHbQwnlXeVbjMgUkGAUQNyYdWZZPwEQI2oBso4TI+LEhYrtDHvGKvwD5BGQL1rqYl63OL84TxsxEUs1u8JfDvIp/Z9E1az1gC+O81S5ffvaNx5Fu/dAEXUWkq1L8QcHWwEC1MfvqtBTLRd95Cgz52E4pd2cGfH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QHqheCKrt643VWAzArrfrVhYMgW6PWGcaD2LnbWOq5bV8jKWDuLIzAZ9Hyii?=
 =?us-ascii?Q?AzzepTTPZEVz5j9Ca+wYvzelXOxRpxVqPXi2t+7qX4E+6+z41wBFvbWlzLcC?=
 =?us-ascii?Q?Ivn0pUlxelCxZ8WXs4bszP0t9cvKbH97ZYFIfKmheis3MvjD8uZSiBH9Q/GS?=
 =?us-ascii?Q?qqTyzSt7nhtGWrLLoQo8z6HFRmYlIB2YMnD305wQnMR5+B5QiPE/Bs6SWO1F?=
 =?us-ascii?Q?ZKmyXJLtNu5go+urnwcym1cY8aqhA4aiATPvxjKbjULpUxIayp+9k5gPxBzw?=
 =?us-ascii?Q?Q2X8cbWnB2bYszocbiZnrQkbRSbkoFePPvuoTUpgtN3xhATWRoK0gM7g1Yqa?=
 =?us-ascii?Q?zLngVkCRvXr447skirKLbQ/BpyeL3jpSLkgPyC8YzDs12X5EdnjS/lfiO+sP?=
 =?us-ascii?Q?xlZLN36/i6ORhhqmPFGHEkHCXP0RJ1diB1w6EAe7/x2KDpNJ3hjk7EByuQri?=
 =?us-ascii?Q?1EcbrXZw8g1MEgHoYVf8MYDWAyLtn77F78Ge+F6yvuxgJeiUrove44+bRpBI?=
 =?us-ascii?Q?GgmvWjkgiR4pf6FY7tK0OJ9pO2ipyGIGKmVuOtUHc9IOesHBm2JGlogq+gQe?=
 =?us-ascii?Q?qKC9RzBGlKUNJQ7RzOTazeio4RKz5askmvpflU2GfcNUx520rHfDiuXTZJal?=
 =?us-ascii?Q?uhTdsNYP8pXZ/Q0oR4G6hZziEWxt8emel5KoR2brbJGPscfJ+uQYyqiI5/BM?=
 =?us-ascii?Q?KXlx5kOI4bUqAr+C4b1/TA2PH1VoUkCBWdYnEVVfwcI93XV1srajoh5pVR3T?=
 =?us-ascii?Q?/eH5hNZnkm+qPGL1VKrTT5qDNB/9B55vRczeJ9y6LSXl/SFvF/G/N4vjTb56?=
 =?us-ascii?Q?8ChNRYaxijIxytuqIoPCd0l/Rh/c90urudidgZoQHKyV1He+61+/mUQNFYZy?=
 =?us-ascii?Q?iz8c5yAeTVki4EmKsGt6swDDGP6l9GIPV5VNM9fpmaXnqUny/Wz7Gl2vWw4S?=
 =?us-ascii?Q?UXhg5zm1/ANEzRcR98aQIwzcc6UzwwiBFYfwdm9QW7S0BeWWs1Epofw6+r96?=
 =?us-ascii?Q?mBe6+A1xh4N4X0jmh2HH1AFSVE0LhuOr5ozsyJpsmXEOvNNQGz4+iLJqiswt?=
 =?us-ascii?Q?DwVBTzy9CrZH2cFgGvOoZxJexTN6vgf7BKxTvZhpRylssIfPSPOu49V42Obj?=
 =?us-ascii?Q?IRr+GpZBWwDS0CMV4CIieaNwSh4IDvGCt8OSfgtd79eT6Ld/7BFALoW6+zZk?=
 =?us-ascii?Q?tMdqiyHUckhvefoP2BnkqwFeqhHk6LQsRv7W9xi8nlxO2mWOjsy1sbCeMddd?=
 =?us-ascii?Q?8gdIe5/o2/fUT0m4b9Tkg0nnpwcffrTI1YA6XygQFUjO2Ecit/F/QIPjAZun?=
 =?us-ascii?Q?1wI/65eSZUsRVBTarPN1cJDnMgS2voU/SwakgLEudad0nL/s5eDu7OycWDSy?=
 =?us-ascii?Q?lxQSEaG6bC7G8p7iAGGQE1WFAWBVJvn8NVzkZWxckKIIr+bM4V03Iq7qovd5?=
 =?us-ascii?Q?3oyNTqunwbusmz8EbXLNh6AYZijmjlwPLKMV5GG4M9QkNsG4LB6eu8DNVu8y?=
 =?us-ascii?Q?P3bTQPr7CtRCI/xzzUQvi6dOp5MRY//AazVmJ3RXR4KaWjiJoJ9zqL8PjUa8?=
 =?us-ascii?Q?1b55DAZ9RwxmDp0T3UL7CpXG91IztMXk4TmbSOVPAxUHcDJ4k10/oRCbRJCu?=
 =?us-ascii?Q?koy3jJWXDIgjdRJA1HXJH1lsiQxpDefb3f8+keqmAFNwlkhqU2AjrNUMgviX?=
 =?us-ascii?Q?DzlIgAIV/UQkht+j31WkeEi/B6Ur3eO3xt2kkMkWYeqw0c1N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4671cbf1-73a8-4349-6a3a-08deb842decd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 20:44:07.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgJ9Cff8CTGWN6Fv294STABuQRVN7crdC+WAWG84rxcxwXFAYWF1XvDnhuediIb0JxM+smAUjhKtk8p7yl8/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,pengutronix.de,gmail.com,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9086-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BE0C05BA295
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 04:13:48PM -0300, Ronaldo Nunez wrote:
> Fix a variable truncation when calculating period in microseconds as
> part of the solution for the ERR051198 in .apply() callback.
>
> Example scenario:
>  - Period of 3us (PWMPR = 196 and prescaler = 1)
>  - Expected value in tmp: 198000000000 (NSEC_PER_SEC * (196 + 2) * 1)
>  - Actual value is 431504384 (truncation to u32)
>
> Signed-off-by: Ronaldo Nunez <rnunez@baylibre.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
> - Added example with actual PWMPR/prescaler values per Frank Li's feedback
> - Dropped testing section
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

