Return-Path: <linux-pwm+bounces-7104-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D3B2C96F
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 18:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06E77B2B8A
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C44D2566FC;
	Tue, 19 Aug 2025 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iiXpXx2m"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011040.outbound.protection.outlook.com [52.101.125.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B03A244661;
	Tue, 19 Aug 2025 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620551; cv=fail; b=Y/Wmqhlose0ffu+8U6a/eG64E7sS/vsQ+5GgIjXbwaq4BWtTuPuZ5HkwnzM4XPhEYsNVlUtQ3GyYtS4dtSo5/yJsn7Kv5VlesLvxUbV31dHFukFH2Dp198RG9Il8yFoak379HG8gy8dEJzk4yswMvna4rERICdfVaqv1jjI0fXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620551; c=relaxed/simple;
	bh=eAESYgqLFPDnoGVPeQlwDBOLyWaJAPtkuwfJp4/kzxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S6KvJfzL1bAE/sFWDvN54tpcksMUnuT4oTs6o43LNL6vS+l+Mq/brUgF3SuExIRVS0N5J7XJT0ghpLEsaHhc9/3x0JKvre+NrGOCV4Z3qESCX6N/pjuvmxAxwekmFCLbiFMwa76oYYNUWrZwvXYo6ojz8S4cEDP5NJo4+MuZvK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=iiXpXx2m; arc=fail smtp.client-ip=52.101.125.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUre8JbRS+JLw/ztKEOsChk2QK0IejphbvQZv/bLwxTK6ycSSl2HyQqwSez+W2MMA8K0EV4K2iyKqHCvggV8QKifdmAka45pbI25rYBe5ajxq/Yq0prJCbSC0FFFjgh2nPzQWBa5HmISKkqc5i6Q8bjixLSqs0PdeAWoXeAF0nlLJGsOFkBNA+AIgw845ofMMggwob4PuIXa4Asnm8FL9p1/+0DhWW59LMUQiT7q243TKF4jZNaVixXC8OEomlDTgdkkQTFJ0Fgu+YHBFC44ktBa03Oh3TMvhR5AwvEYLxBAMorw4Pr8Jag+9k3W7UYymnEU6HQ3+uJ0QCNJ1krXhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQoAO5LLe5clxmsYipgznSDP3S9yGT3EvLIakZo7zbs=;
 b=dX7bUme1RSMNb8YlvgvlFmjLf4ySoQJowbLTbeJds1NNe6rhGwr5pbz/DoxV59SxrxrcfgpAjq4XnGy1rGTgb9+TlJex23jey7EXCPo0lKhTWfnnl9gI2BaIAb2N/tvcgLD0lN1GOvA6L4nzwkgDzP8ZYBYlWqljEwSBTl4iOe3miQ55yRZ2brN8F/yS0Pq1fMezGFjks+cel6EvRWIezNZrEqX2itgS4+kmhOQEUwR/N/12mcsPFk5V9KXdZTquIs/XIrmPZTY4oMroKRjKM3DHTOLqA1/tGcqlP7ivIW2/fqwEM+7Eg4TN0rHu0kefT6zabtJrzA48Jeu5436U0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQoAO5LLe5clxmsYipgznSDP3S9yGT3EvLIakZo7zbs=;
 b=iiXpXx2mB99CCF66sk6sUKQcxnsbv2Mgem4YmFPcK8T+EElIaYu5YmRdBjM5+hWB9jLxqskd0M8KkFZ504NbWivPzNuGcIU0dr6YHciae+Pa8n1vy/4cPwhfvA5YWB0XeSl91lo0kWUVSW1TIJuUz4NKMUoR9P/lW4howzaHCak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 16:22:27 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 16:22:27 +0000
Date: Tue, 19 Aug 2025 18:22:18 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 4/7] pwm: rzg2l-gpt: Add calculate_prescale() callback to
 struct rzg2l_gpt_info
Message-ID: <aKSkutjQ58bTHYT4@tom-desktop>
References: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
 <20250814184115.192930-5-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814184115.192930-5-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0348.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::7) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5279c2-4e8c-4d22-5e45-08dddf3c967d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bGVJtfQE0GU5VXpgl4ccr58APMgnN0raIaPddPUfTJIos6iKBSC0Eg1+kfs3?=
 =?us-ascii?Q?2MDsgDXQ2HayRh3LhvaqsHsqIw2ONrWDoXj9mvMCir4hKfgRz4TfSuGo7yDm?=
 =?us-ascii?Q?rkdBsJVUll1JZWFARnDLyty3BHXUTtQOugkMGPr6G/lmYT2aqlFQFqqeRKLU?=
 =?us-ascii?Q?zm2wNq2dNTnDkfQl7ty/bZfJw7o14yOHr7mHx5IBchbOh8MHNy9kKdXicWRu?=
 =?us-ascii?Q?LmutIn7LG43e/6DVtkJUBq3VvEJff/66csYvu32nv7zlmhP6V75lt38NvbY9?=
 =?us-ascii?Q?lU9pv2gdv7qErQEdezlnSAbKfs25l59nU7OrsuvBFpyOA4OlHyvD0OdnpaYV?=
 =?us-ascii?Q?evBTQET8YLZdu+nrULKfDOhFpbbyAV3RXYmbV81xKaF+vzgLITNLsaGOxUK5?=
 =?us-ascii?Q?2aGo+RIUh6qUNiKYqVWcNzbWRPQJ3omPbXjYYR7sF5+yCyMVOOn6fqVbWNQu?=
 =?us-ascii?Q?imB+6H5wcKr6+MIw1aF5Rl/6hie4y5ZB+proMpx9d2pmZFQJhvjnslISf0II?=
 =?us-ascii?Q?QGM+6BplildqWOwJL4Jg/X7zi4F0b3viazNVxAFhn3ra3RI8mHghzPhrI4ro?=
 =?us-ascii?Q?33sQ/sS2xAvXwZA7ftZhl49dYopDr389oburXZHwnLr/WRCrm5KnKyGIBJsS?=
 =?us-ascii?Q?EVFGGSVLoTetU4VGti/DV5tilh6lSb6MrTOUbUfBFuWaf1K9SpNOoVyuxcZR?=
 =?us-ascii?Q?yak0FhPic2IFuIX728azk8FsZ18UMYAFKaQe8mO0l2qtFRb1Z1YEvsfABpNo?=
 =?us-ascii?Q?lhQ5uXQxpri2abVgZ5NQhhzJXy1aXjmzIejnh7KZk7Fanr7c6awVXuiCbMmh?=
 =?us-ascii?Q?5/1h1PK+tnJZRheW4RMI6oLbWom76OzTZvk6J/wbS3ehW2l6E2I7/xM/pZUi?=
 =?us-ascii?Q?A7kh3GOquq33quyu0klAFgEym5uY4CweV4GQyL7Z6slrPymWC1QPnyteRrog?=
 =?us-ascii?Q?hmosGBJEC9am3Pq/vh8IWV9EeVjBXZOxaTK8tIh0BW1KszAo9HMcwDgSKvf+?=
 =?us-ascii?Q?aN+RKoHS7YB1A/FL+R/4FvOcPSOLVVAUikdRQE5Z8+JKfY787QxMYeBFlDHM?=
 =?us-ascii?Q?QHHZC5Oly8i/fDx7JtUqY7df6xCdIe21QuuY6Qes1Vx6qXtaj4fM7RyLugVY?=
 =?us-ascii?Q?RNhMrp3mAyzlIEgWg8t8atKbwKm/PO5dH3ZraDFU7I0WChl5i8cRxrXBSLhQ?=
 =?us-ascii?Q?nwpYpj2xwo3Ik1TNu4Vl6syk1wWSHvPe372b3ef2oyK2ebY9ar0NpHeS1Ogk?=
 =?us-ascii?Q?UcsGl7auXQi1/EJkES7eYiuaeWrVak4jRszwXUm8W5U8N8a4KkvM6/d4mucA?=
 =?us-ascii?Q?Tpa979U6GELcQAc+NQ1SbWimLuognWxODTdim49mA2FBds7bSbj6coJw/cLQ?=
 =?us-ascii?Q?ey0IKfEXqSwbqHeMyG4A3LeUSyaC8QsejrQexffZg4JVzBjOuzAOs5OjeqLL?=
 =?us-ascii?Q?M5TlTDJVvjWpUmkbp2PnOoP61E+ZxhsyVUFXt3RrMEEDnXhALLTVrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RJPaVuIyoKLNhsqqr71WVkXB8aUkoY2yn0XXpKdzlvbhDzem7nQ8jxFtcLjz?=
 =?us-ascii?Q?Up1BIczLfx1wG7Fo0YAZM624QqoWWTYjZOEZsWgMx7ErknuegMklG2FxlFrZ?=
 =?us-ascii?Q?QAXUKMjSe7lr70guvOpyU8nEyYz3wACh6CwGj1Mci5dXWCa+tYQDr7zSyrYS?=
 =?us-ascii?Q?9E7GMGKfwuPxQGcZW/s5y58PNhZryoC8tti6UK+lRnS58U0nXvRSWkZ8BnwC?=
 =?us-ascii?Q?WTUM2a6sTNxk/dxkQvWtd0kuxw2gdQmngEeypFvm5uqay3iUmJNLjNG9A2fM?=
 =?us-ascii?Q?ScjyFz/0W0sDVte/UosKpDcM7DxtDIQY0QeIVoA0heyV/DgrMGtITXenCK84?=
 =?us-ascii?Q?34D9LvipBBSUq8osj+Ej07H2s4skLDN/um1jswCBhIi7l2cNcTb517F2/9Qg?=
 =?us-ascii?Q?iGWLUiyF+CUqQNujBju2uSoVnZI/YlQ5hSaVUQKpr4IPH4EgGdt2RZQgqh0g?=
 =?us-ascii?Q?qYCaDJgfJitIZF7eQm/7FaQl3qabk7QLRtx51eo+3+ADFgOig9V7IBFs0R59?=
 =?us-ascii?Q?GFWa2MgY3ZLDmIyvKF1MUFyrapizHcClokRkBmdoEwVlZFSD4cDdYHg+no5L?=
 =?us-ascii?Q?PQQOxkJtL+dtThLbZPGC4NS8zLbOkfOdM49cfZbHu8gu/0MUaf+4fxXaNubP?=
 =?us-ascii?Q?Jrv4dp2NihfThSDUIUT53pnFUMWl8cr9yYz0QsxxwEYBWu9j5wBB8Sn0ZXQa?=
 =?us-ascii?Q?jG184u7iTkFkL7RHvYwtr2IlseU1I992lHl84+pTlvmGIuBoAlYiMFkj7JDc?=
 =?us-ascii?Q?4PB7rS37oHJgKu7S+KywUVdcsm2YYrHA7vS4LWlEXYTK1s350qZe4a5QCk9c?=
 =?us-ascii?Q?uOSvZn76GTtsrSqpwSFGF6w6qe7tpzipRc2mA5NvCBIzcSpQE8sJmv+jjgf+?=
 =?us-ascii?Q?LkAojPAgtcb3FoPAkkb/HIx6i74sntmiePQiZSovuODxa9iUw4tXPmC5HYH7?=
 =?us-ascii?Q?amvM2RGDsUl15NvxW8PY1rT2b5OJDAaVjaupH5BbzFMFgsEtE21SiFQ3XNHc?=
 =?us-ascii?Q?dl68wEFDBQnhgyWS36XXwikdaxsLTcpkO5AN46rRF3YDqqK90PEwOTeCY0Qv?=
 =?us-ascii?Q?kDrO6IOdMu30IA+O/g44W3hj4ECl7DjcIydJ9eNnIgMj8kBx7X4NVwK2L5iZ?=
 =?us-ascii?Q?kLralcPgqtplzIhFsUAw7RkPP2l7CNGQ8K8g39F1GvRA647rm2Kpu2iqzapt?=
 =?us-ascii?Q?c6bNWoA0L6y0JbOvMSTh93BRZtFgYjtLQR66IlOFd9mZJTjNUxGGGHC+vrKN?=
 =?us-ascii?Q?YZLN+s4Q7VaD2USjpaVm6NIBGrFm9bpZBrhRE/DwDLcO7iq7Ybl4SIc0ADs0?=
 =?us-ascii?Q?nIexy7wwkthAT3AIeuY28bHfgTBkMu/p2tyuK59vaSW0xAaFhze6pMUBjkhm?=
 =?us-ascii?Q?8dwVpqtcQ0AMuIQ6lGhmyy88hkb5j1B8TDIwvRSN2F+45egK1pJhRgEoPUYL?=
 =?us-ascii?Q?1iKCeSa4OPTmETEaL9bwLR8S1CMPWNrBfoxf+35t37p9cnhdyHVDGd5DKCbd?=
 =?us-ascii?Q?aAVARA0WFUqv1iUCxrZAbEhjk49m8BovOq7Xnlk1VnAa87mFntc4PRn0g7i9?=
 =?us-ascii?Q?eNEUs9MBj6gpATccZeHqYJRK6+fVHLGdryZRku65CBp2nYOQjGnaBNcbOa3i?=
 =?us-ascii?Q?TnJkbwChmm7sQRZHxBsl2cc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5279c2-4e8c-4d22-5e45-08dddf3c967d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:22:27.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMhYo/WNsuvp2f+fXCI/qWMfjM9c2IR/FVgWhRwv6RWKxLq65C3O3Z28l4/cCOXLJ7UIPD8/6GLFzd+nQMTO05ttcdk737O9eE1yfB9SHPP1H8yaoBLiGSKkyK/Zl2gm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7049

Hi Biju,
Thank you for your patch.

On Thu, Aug 14, 2025 at 07:41:08PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> RZ/G2L GPT the prescale factors are continuous power of 4 whereas on RZ/G3E
> it is power of 2 but discontinuous. Add calculate_prescale() callback to
> struct rzg2l_gpt_info for handling this difference.
> 

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks & Regards,
Tommaso

> ---
>  drivers/pwm/pwm-rzg2l-gpt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> index 74bb0cca4ab4..b247a6c181d5 100644
> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -90,6 +90,7 @@
>  #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
>  
>  struct rzg2l_gpt_info {
> +	u8 (*calculate_prescale)(u64 period);
>  	u32 gtcr_tpcs_mask;
>  	u8 prescale_pow_of_two_mult_factor;
>  };
> @@ -138,8 +139,7 @@ static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u32 clr,
>  			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set);
>  }
>  
> -static u8 rzg2l_gpt_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
> -				       u64 period_ticks)
> +static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
>  {
>  	u32 prescaled_period_ticks;
>  	u8 prescale;
> @@ -292,7 +292,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
>  			period_ticks = rzg2l_gpt->period_ticks[ch];
>  	}
>  
> -	wfhw->prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
> +	wfhw->prescale = info->calculate_prescale(period_ticks);
>  	pv = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
>  	wfhw->gtpr = pv;
>  	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_khz, USEC_PER_SEC);
> @@ -482,6 +482,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
>  }
>  
>  static const struct rzg2l_gpt_info rzg2l_data = {
> +	.calculate_prescale = rzg2l_gpt_calculate_prescale,
>  	.gtcr_tpcs_mask = GENMASK(26, 24),
>  	.prescale_pow_of_two_mult_factor = 2,
>  };
> -- 
> 2.43.0
> 

