Return-Path: <linux-pwm+bounces-7103-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D37CBB2C96C
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 18:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585905257B9
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 16:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B32241665;
	Tue, 19 Aug 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="SaIefyTg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011002.outbound.protection.outlook.com [52.101.125.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDDA38F80;
	Tue, 19 Aug 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620495; cv=fail; b=FxaktvT5WlmdevJRpljjcLbl4WWmFx2t8dv1o3T+/y+TNdHupiUrTL22cnrqwB+Y6Vr2nFyQ2I7DI1grIJxgWE8U5QnOK2Pe+rsG3laApJkf8O0dJL3dfFEQy1p6lTZvdtmbhLjAYWWHP5J0+SX0DueE61wwwD/WmA9XyISU/DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620495; c=relaxed/simple;
	bh=me6//vD48gQ1GtRbOAUIh40aYI1HcmjaGGZ/MHtuOG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JmvDMivLj4n4HEajhZVO9o0KSdsWLlT/PoltMQsDWKRDNH8TIm8yfFWSj/OG5KR7iwrRHEu3kY7yQv4QbwsWM/BwT7VncDPZZrBcDTg0xKiiraLOki1iCPSkB+zj2u/cAeaQw+2hrAr+lJprkpGZyhGYrwGkcaxwSGRDC6k2aj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=SaIefyTg; arc=fail smtp.client-ip=52.101.125.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x35sUQt7r7m6ToHkKjjo16xvNvlNHqLcIE4rtfkf5mhVnyYO/l0CbXinWRq1mSapCl3YbMS0lHzU8DEqAsB5W1768rl+kYBffiaq94Sccj0wSY7dFTS3LkVtuFiLHPhVtGc1NHGQAD+zkp6wDZmbVg5uhuHrRa3RqIzLsP484Atlg+MwcQIUKElnWjsFVrx+Wgmnmhwh1AxrYoNx4h6bj5vST+7K8iLyW2nHCw5lkWu6kBPOVyhMOShtx859gqCzNr0p2MH0XoiQvSiHPkN3IG8P9Ja/mOPj/ATz5FAoZJ4jvBvW50SjZwvsT7T30llTUmQ0SrTsND/hHdJiGQImVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yN5hKGQUXgDm2NCjW802nUqASaNBNxqvnFXd873s/8=;
 b=jDOig9dL0ZKsnbu+Al/q5fNtNdYpDE3SDsBj8/c3T6K0CPhc2eQwCBYJP1JpBRoF+v2+JFVU0xnJfPklt7OZgR7jUI+/U2Q2RHiNKWMAJQtCCirJiSuu5ic+2ksBbqokZpnttpKWpKlcDk/8ifXarvQa23Lk/EqOv+8d5LK6cKFjR1pc60hJaH8BBQTTguAXs4tP1k5n94w6w76hPwPscxool2Rlz7C/SzwWU6XmfJFGM84mUIAtTkUVgPTtfOK4pOGOgwL/lxeNHB+KGPBLar28nZ108yJjszeGhfRyWsW1UoGAZlWbzhw5BpeQNjFYHJchD+LsCrvCQOe4LxTVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yN5hKGQUXgDm2NCjW802nUqASaNBNxqvnFXd873s/8=;
 b=SaIefyTg35HLEyuwG/hSGGvpr4WOpEuHieRnHtH99dvxYuieWCYf/smy+dGFqX5CMc3FkYO+8VCuiH71Z2yQPCeeC4nyxuU8D1qTP01/NjJ02iyowHyGV+CwKjCCwslS6FtXAw1JwKpNIgiCsj9xK526gKF5RJwZDR05DwIw4DU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 16:21:31 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 16:21:31 +0000
Date: Tue, 19 Aug 2025 18:21:22 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 3/7] pwm: rzg2l-gpt: Add prescale_pow_of_two_mult_factor
 variable to struct rzg2l_gpt_info
Message-ID: <aKSkgjx9A2osv4M5@tom-desktop>
References: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
 <20250814184115.192930-4-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814184115.192930-4-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR0P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 451ed5ed-a0d5-4148-5d47-08dddf3c7516
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l6AgQKbwqclvKVW9v2adii/jtboaO4W+TloJESAfnFyuGkh3yNU5PLDGWXbS?=
 =?us-ascii?Q?sgDDIu9eEOHFG5eJtlqrWfv3bXyC9rwKDRnRNJKElfFLN66eBb2xDmEmTzQJ?=
 =?us-ascii?Q?RaQ+NxpLzh0xPkw0X+eGSCFgHLL4c/NnwMJI0iXq+E6Mory4tTmrmw3DnAwC?=
 =?us-ascii?Q?yf+weIv937SqpqjrYsq2Zf1K5fpbiJX2ua5fJYy/X6DZHU3V1s/rkJNje1ps?=
 =?us-ascii?Q?nkVzL4c4UsNR+gJKWQXaDgHyrNMizejBCJ3DL6KOptXbJpyskuHIT/6hpK6X?=
 =?us-ascii?Q?XNOnDkal1501W62caRo3TJZXDWpLeSuP+uaTtayHArYEpN3dZND56fEhSjRp?=
 =?us-ascii?Q?veGhKGSVRmODiQrht3Uq2M/1AElXvl7m5SfEht5leOFIat6WU/PHcH7mBB2j?=
 =?us-ascii?Q?bClUtxq5DOnEr9ljf1DHHd9w2K4m2voE7K/5JeoPN7U20J+C2eUMXqJIovK2?=
 =?us-ascii?Q?IWymGf+3830ZXiExO1taTq11BwzCbkfmXlkvgnSypoZ1b6eNXGbhRcUgYLWf?=
 =?us-ascii?Q?fzgrINr5p5hT0bJefto4Ddb/36uu05alxiqfgoelCLuW9Y+7BnZGaZmJLJyZ?=
 =?us-ascii?Q?Bv48rTgvZmPrWVTQ3gk3cTxnsfoGV3fMV414NnwnUniIF7cysTJunpDY+f98?=
 =?us-ascii?Q?hxZcg+NNC/5cUY4+zf8Yut/HDR9dlph8n+6dEbcNzShoI+0AX9uYNlP2sC3k?=
 =?us-ascii?Q?5cretKNVCpMyg//DHcP5BfSdwxkdoBqgwOUehjoQ8xynL+FNyo7La+r79MeJ?=
 =?us-ascii?Q?CPphj7zCfRawfC1CrIgqO1aLHc1ZdmIDAVteLL9UyDu6Zm3X0lsNvurmOSI6?=
 =?us-ascii?Q?sK6V7nPym5cPUtj87aO7/byIbg/hrFI6lZ2Enm+O6fhpXvKrmyEFpbv7E3oU?=
 =?us-ascii?Q?HSOv/U5skgK9jkW2PeiMJ2b/2uYNh8I6zj5kH/lpt4aVk2xO3lV+wqE+G7P/?=
 =?us-ascii?Q?dQ91ggCfBVhIojL+spklfCrhIlt81N39LGA3Wo1D4sAgtXGkvZomRSZjhKXQ?=
 =?us-ascii?Q?mp0KyboYFNeYtMD36nRaev0SG8XrLCKYD+THPrMbJrgmPXdqIj+gkea4OU6w?=
 =?us-ascii?Q?54rt2wChPVwm6TqeCpHJc3h6mEhUHzEHhCaqPG+SAI27/VcLx223YZgW1y8p?=
 =?us-ascii?Q?ummqyHtXEr5ikFtuSwNJvBAmUidH/jYhHCFK9CrYVrm1ZoyGv8to4J2Yo1lT?=
 =?us-ascii?Q?Zo1QLADhVE1pQYFLKCge+JTL83BMV5qHFMXFbvsQjtaSM5KqpO1ki+d3J946?=
 =?us-ascii?Q?2GNeaYqeY/R4xVELzIkYqCMnDAf24eKjsw7GQc0vaEKOmlzqzE8xY3iHFt0S?=
 =?us-ascii?Q?Z/ofuHdfh4Er6/wAouprxKOLas+qbRYkyhviIVrRdzjAlP2FXG7iCk2drCtk?=
 =?us-ascii?Q?m24Iro3qPjdn9U9wM/LGvAAYN5X9RgYER66WUhNdasXxbTFtEim3Pp9vDBaR?=
 =?us-ascii?Q?v7dEHJYTYdc5BfSuN5RIL8BwpBJBalFPnrJyTMSaPVCaoMdgGOTeig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1VW7A9gFOZrMc92IMg8hXryN5uT1plR9qXBXem3UWoYXySIz1Wof+2xrnjtv?=
 =?us-ascii?Q?4aEBGGYU3tpt2omleZaomdtR5C0/ugeZC3dzaWlZL/kil5lLctN+HyHvD1zW?=
 =?us-ascii?Q?JNfpcwCJ179YL4OOC7O8IMHEqzh6XCtuxptW47gGWlZQAvhOTZHNdWOMDT0A?=
 =?us-ascii?Q?YfPnBCnT2HSoQiS31TfKc7HrecfXQaWS4lQcZDUoISitRov9cgz1HOB+XYig?=
 =?us-ascii?Q?YgUMLbpi8UxWPs9sByveznw3LW0ifeO3TmqxCT5GkgblztNCqHVO/zhzZC3R?=
 =?us-ascii?Q?p5vfyt/R3ozqLo0XaSOE4Y5rGYNmU9cN45vkxj3zkvFIRg6s4oT0NnWrGz2m?=
 =?us-ascii?Q?VicjkA8W6PK73qqHvag63Y3IkBiAD0NZT0yXp9AyrnQ2dznPouT33iIjpRWC?=
 =?us-ascii?Q?9uPZpOcdybVny9Cc+7iQ+Xed/D7kZXludbIC6DFJGR5T1fQaUVsw0QBnkfjy?=
 =?us-ascii?Q?L/t6i3tRvIHpzZxuruwIeTsrdcpv0XbJQktZJke5W/7EbmpcktQSowBw78Ss?=
 =?us-ascii?Q?K1SAk25qqG/lksFRM5Tfi/yX19if57jsyr40BB0pORBoxsM+RTcSn3yGheYr?=
 =?us-ascii?Q?dWHiqvLUChpnRDc5JPaiAPb/R3Qq63ANAQPJqsmoemI2yqqr1ZHEZwNdq9E9?=
 =?us-ascii?Q?xLLHCjMMNE9WLjcVS4TIz+CrdoB/BRUQ7ewbYgIt9FxAPZueuKvblT/XdFTj?=
 =?us-ascii?Q?rzOq2aJ8Tw2kyxWDoCNycq0n51M+x6lfG5MdC+TIHU5jjAB9/YgMbFUnNdHv?=
 =?us-ascii?Q?GYAhsdvomK0POlmFSlSEfFW2BpSz1ann3EC/gB/gb27aTCF4jmhknghM+bn/?=
 =?us-ascii?Q?tQbrJJE3qr6r27OEs63n3OllKdkl5OsE09KZ5UidkPx/coZkXDuhnJDaTsdO?=
 =?us-ascii?Q?82liZ7NaRVzsq+s0w55yLIRhgh8vFbRzh0jbPLJsdfK8K6L8F+dM/XyW2z48?=
 =?us-ascii?Q?fhcDanNgErc20PnqiM/qRDsk0Ybl44Ud6KBdZzHcUUyY8xT4exzJJC5WHEoe?=
 =?us-ascii?Q?5/euaLW3b3RzRXKGlq8LwlmCur1xL3KF4CgsFxeAO9ORw2zyOm1aSMy9TvM3?=
 =?us-ascii?Q?sSO1d2G4tUdSqW/I3NiGkmj/FI0bKgvxgoLQCD2u9tDr2JHH3ealLn7P+hY+?=
 =?us-ascii?Q?jtn1h6yDcrR1cSFyAUh4BuxrJiUjSMXIHhaab/FmdtdVxnO9devf+0F1RMqR?=
 =?us-ascii?Q?ieYn5kE1zQoJ2R8lehI1D0hCUPzYLZAKumLeUVlhda4y60S0DhbMotpBpLsa?=
 =?us-ascii?Q?eVL/BAsDZH1PdGFpgDOadl904XkMOVqEXqcIi42nWzDh96QC0p7wrBScFM+C?=
 =?us-ascii?Q?+P70+62aVuxutjOj2/17ssO7iY7umNboBe/obeGwq4ECJdg+EiVWNtoGm+Ip?=
 =?us-ascii?Q?ZtT+mfaF6xKF4ZLRzoHkxXjABRkgo1O442OM/NNU/VxS4Db1r6iP3eNTpoIu?=
 =?us-ascii?Q?yVvxe0Vn2gwEBEPfJsgFW5sfI+p8mKLyprwy1MEAxn5XAGoHPjxjICyrvAUj?=
 =?us-ascii?Q?KMukaCM0iF93mfpUWF6SouA24z87YDU+IKsm6rctE1Nm+t+zZsyr/rgSvJte?=
 =?us-ascii?Q?rHzQitI6l8i9NHw/yCGTikBdh84BHal71Kyqxqviz/xuwrHeF8zpPZOS0YPM?=
 =?us-ascii?Q?6Ic5eShTvbbCfz2g6tIlRnw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451ed5ed-a0d5-4148-5d47-08dddf3c7516
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:21:31.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wu6WC2XhtqkG8nUeTxHUZqEGoJ2yQX3O/z64kGqlMmR4IKAQGFl1Dol8tw+z/6S2TiaQaMyNl+80SmPcEECXUYPtGKhYJFUESQ1yrstkI9rJZFwEJwsL4h/EDbFhvdYU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7049

Hi Biju,
Thank you for your patch.


On Thu, Aug 14, 2025 at 07:41:07PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> RZ/G3E GPT IP has prescale factor power of 2 where as that of RZ/G2L is 4.
> Add prescale_pow_of_two_mult_factor variable to struct rzg2l_gpt_info for
> handling this difference.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Thanks & Regards,
Tommaso

> ---
>  drivers/pwm/pwm-rzg2l-gpt.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> index bf989defa527..74bb0cca4ab4 100644
> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -91,6 +91,7 @@
>  
>  struct rzg2l_gpt_info {
>  	u32 gtcr_tpcs_mask;
> +	u8 prescale_pow_of_two_mult_factor;
>  };
>  
>  struct rzg2l_gpt_chip {
> @@ -226,6 +227,7 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
>  static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
>  					      u32 val, u8 prescale)
>  {
> +	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
>  	u64 tmp;
>  
>  	/*
> @@ -235,15 +237,18 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
>  	 *     < 2^32 * 2^10 * 2^20
>  	 *     = 2^62
>  	 */
> -	tmp = (u64)val << (2 * prescale);
> +	tmp = (u64)val << (info->prescale_pow_of_two_mult_factor * prescale);
>  	tmp *= USEC_PER_SEC;
>  
>  	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);
>  }
>  
> -static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 prescale)
> +static u32 rzg2l_gpt_calculate_pv_or_dc(const struct rzg2l_gpt_info *info,
> +					u64 period_or_duty_cycle, u8 prescale)
>  {
> -	return min_t(u64, DIV_ROUND_DOWN_ULL(period_or_duty_cycle, 1 << (2 * prescale)),
> +	return min_t(u64,
> +		     DIV_ROUND_DOWN_ULL(period_or_duty_cycle,
> +					1 << (info->prescale_pow_of_two_mult_factor * prescale)),
>  		     U32_MAX);
>  }
>  
> @@ -254,6 +259,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
>  
>  {
>  	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
> +	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
>  	struct rzg2l_gpt_waveform *wfhw = _wfhw;
>  	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
>  	u64 period_ticks, duty_ticks;
> @@ -287,12 +293,12 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
>  	}
>  
>  	wfhw->prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
> -	pv = rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
> +	pv = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
>  	wfhw->gtpr = pv;
>  	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_khz, USEC_PER_SEC);
>  	if (duty_ticks > period_ticks)
>  		duty_ticks = period_ticks;
> -	dc = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
> +	dc = rzg2l_gpt_calculate_pv_or_dc(info, duty_ticks, wfhw->prescale);
>  	wfhw->gtccr = dc;
>  
>  	/*
> @@ -477,6 +483,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
>  
>  static const struct rzg2l_gpt_info rzg2l_data = {
>  	.gtcr_tpcs_mask = GENMASK(26, 24),
> +	.prescale_pow_of_two_mult_factor = 2,
>  };
>  
>  static const struct of_device_id rzg2l_gpt_of_table[] = {
> -- 
> 2.43.0
> 

