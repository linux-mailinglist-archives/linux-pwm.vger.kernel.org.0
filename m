Return-Path: <linux-pwm+bounces-7102-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C196B2C95D
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 18:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF1D7A38E9
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D276244661;
	Tue, 19 Aug 2025 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="NzNIZBmE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011016.outbound.protection.outlook.com [52.101.125.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982E122F76F;
	Tue, 19 Aug 2025 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620435; cv=fail; b=K0mvFVRZbVn6HZoKTxPCk11xBC3NzQTwES5D3RH3GBgBQBypEA91lwcisGWBzNL8MTjjlWXTBOoSs942E0eorgZE7r5wdY0gdnuKRhxrxBVwVt2lTfjL44eOGA8uGvK5HiGWcjOPTo+OeIZC7D4Pa1Poq9Y7/hVz5Ppjzj6CbNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620435; c=relaxed/simple;
	bh=vBXenFvvpLE7TS4W6Q5yLUTa7d7wWPWHinBg2kPnp1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eOvmLe65miyE8oHCHQeTphKFfDEm7/6XtG42MWZsm0/nsm/xPsdxpT6lnyzGZ8mE+NdisCjhu2DceRoyB7dTg5rF3RiXb36RLfmvHUZdwUg50JQA67NC/JLz4dBdSM4CRyHGFA+f+7geGhqhDLqBClPdYeSWJBSPV0BUxHvCeg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=NzNIZBmE; arc=fail smtp.client-ip=52.101.125.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9JbhKpDnlYWhhj/mIFywS0ozanaYH/+SKVq5Wke/VxyCdnQZzSX+3LLddZkbrqJpe7kczX0GVKrr+3dKnCM4cEfotnILFcC4dkpZIISEJjVyZpFr0dJ2oa8m/+05R87FXL8/Ita+RU8qzCHzBZEIqmTJcIk5rSpGUPqiB4aM6IHLD8hMEL0BhPGSCeDCr8Hka3eCzLzICYnQCOzB5RGelxKmt/2llHHfaAyftfOrt1uKW5COxkG9oo7D/vNcmbZrkVmsi6a3u5vokR5KQHIT95G5o6KTLLnhmb59eHbex2a/1D/q9EWgKRSogx46orkwtQyoJfLE8CxfVKrS9MZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYN0JIEzgViQfKCnnubXEiEJZEVT58fABoZFGtwquHc=;
 b=VnHQdZ2djuD1eJtWv6FEO+lqSKafiQuaGjNoNJGexFWkNTeieHtYZVKW2IUbowHObZe0BppKgBsT6uinP4oPIM2hEtKwPTYwGb2vDnus/X/fUjOIY4ptj15OBfGacdzMVDbLSXJs86N70g5iKvCPAXkyb+GPbH6Kx+8G1fUI4M+JM+Tz6PKaoCLvq3xU+RMrqsLcayHbsLOo+5eNLNxhHj0eVEXr3KwHeiZBO6HS5y9DGLE5wK0X444TK8NVMtSGQ3xqAxuZunW3YxV6HrD6N0/DwxMl7aA5yj5OFjkCCbrK6zF6LpmUT8LQ10UfHf4z2Ma0HM+fgOg9OykdbcR7Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYN0JIEzgViQfKCnnubXEiEJZEVT58fABoZFGtwquHc=;
 b=NzNIZBmEdEi+sf2HpyFUtgcX/xZFZ23feEtORTq+xBXASqZ1w8lydDJz0qca8gTc3LVw/+Uh2q0kWXmEH944BulXK4MNz927EsPVFIhxbzGsEKAkjIy4UWITcWfA3KS/fSA6RgA5SmMVSre0LOFHOCeZmYmSFc/yNjrnHjFpMDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 16:20:30 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 16:20:30 +0000
Date: Tue, 19 Aug 2025 18:20:21 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 2/7] pwm: rzg2l-gpt: Add info variable to struct
 rzg2l_gpt_chip
Message-ID: <aKSkRXdYc8ARrylC@tom-desktop>
References: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
 <20250814184115.192930-3-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814184115.192930-3-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 3637ec55-2cd1-40cd-1b67-08dddf3c50e4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bipWaYBLuIaUo7E61sO0FRxNhoQPkGjuWTFjqtukPIxzNc2l8AeKBGIf7aKA?=
 =?us-ascii?Q?8KXi3xrw5MIU7CL/2eg6FTYPrGlP4B9t9OuID2TcJrDmh8ahPx8XW9OS0b5X?=
 =?us-ascii?Q?+iDnjL7yAcg/6k5b0bpaB1SUpYJ/WPQt+xy52o72dhJXS3REGosYtIebVdNR?=
 =?us-ascii?Q?oMecv49ADFBeLM2tSyRrI8p0lRchvfzbDFoX8M6/732UuD0c7dkBdeabjEem?=
 =?us-ascii?Q?Zt7TePh99GIXjXgBXLsu0nrTizIZCG1N/85Jt5rRVWVoUi9UrmwdSk9M9JFQ?=
 =?us-ascii?Q?E5WoKv4c1BBAuxKzEzUOfOPKj+fNO2DO70bHjJFRM1tK+dzDYBF3dzqew+23?=
 =?us-ascii?Q?6C94igkOtNtDPhhv+ATz/iEWmr1tTiqNIAA7D2kHNNS7wqAfab01pjQExA+T?=
 =?us-ascii?Q?YxP/j1viExeDwqf4+pCebmcIKxPaXo+CQTPFIjDRLpFFq9Tr2cxJA5lQDEIu?=
 =?us-ascii?Q?2gM+uiZF7MfUFvldGP/K1gNgpAt1XZ/dO8kt3paWDkn8HXT53Ug3HudWY+OV?=
 =?us-ascii?Q?dlAcEUu/0fDAy7ZnWx61eSuOtbOwEiZYNXDPv6e0wEF6m5+sDjA4F+od3f9r?=
 =?us-ascii?Q?Xa1UIFk6BXMD8h8PTpbNdT0IX6ERpBINWxQrqCN3zA9gw6MRKhz+G9ojSHKz?=
 =?us-ascii?Q?h0wMk25mVvyo5Z/I/jsieOqO0CPXUUosbW9d9kpNu6GaT1XwJ3vg8oaN1qMm?=
 =?us-ascii?Q?7lZfIVWm6fJ0BSYkUgMe73oaX6f9Y3Z85o13KqFZYA49nY7RQO+x3O/xCKPP?=
 =?us-ascii?Q?QUWt+TW/W6vD/1n7ZOPThMni01SZa532gpbKrES1y4sL4sRXVbCeOyJLiHcy?=
 =?us-ascii?Q?Cynk9XiFp3V6LPKchZKFPnAwvdwuBYCSPbGD378Q6ZZNlCIKX0JveWdXERGM?=
 =?us-ascii?Q?cicXhAYURCDLMWG4r2Sm6UlMF4h/4Qoj7012FROpW/idwJzjS0sbt/HmeUKZ?=
 =?us-ascii?Q?CIK7y4RAO1MHH3JD2gVG45S4HjwnbphGBPJzMAOvWtXF5yAJ+b5fgsSNb0fN?=
 =?us-ascii?Q?6b4TfHrUi2i8o/PLRa5GURFjkpbucfR8YEwfA8JnhACjBnjtcBqQTla4C/pd?=
 =?us-ascii?Q?83qhtwJBlnxd4p5APdWElUgxXfEaRDVbWtTCu9YbUZP7v6NUUwLXVkiPDOCR?=
 =?us-ascii?Q?QUViAYLzm/3YL2vwofFFmhleIRu9U3ZNDyu7WrjUJUEC8XQgCN+IUSXaGVqN?=
 =?us-ascii?Q?AruOaRGNbreHzYKdbHTgfwBEUCGsu+RtnBN55iUaf0+8SyTfpQ8P61lyplSg?=
 =?us-ascii?Q?3uL4gnyoDYboOMykTUuJjEFspc8aXg6NiFcOke9G/Or5ISsMwkSmLZQNpoV4?=
 =?us-ascii?Q?gxYryE+0l1hOFm+1WqSVHyjD2oAizvoi/t4d1DaNdkQQz7oqgEe+TgmFiZkc?=
 =?us-ascii?Q?DosN2BSXZz+go46nQNFmavflDYDUhQbpxciH+2VriZKYpjOXWgjrYqQ4ipVW?=
 =?us-ascii?Q?foqHZTtz7+yS0v5ylrvh3Qqwolv8RLX8sugsKGS4fZr0lD6EFaixLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z7ps+Y3TAFcZVC0gwNMi3hWA5DyttvXlqve+PCIcUlBa/fwLjd7bVqM2K+8X?=
 =?us-ascii?Q?kC1JzTsYVO8GtSmzwEuGpsczJQTD1fHeSWk1oah51UClm59eZBucidFEiuu5?=
 =?us-ascii?Q?ZvFlALiIBPpjimF0HKdhDByoeWYs3I8xnoe9n5OLL1fy5aYv62GQHmxzZ6vs?=
 =?us-ascii?Q?yw/ZVQywP7XXxhYnAxVopwrRy/KhnbmWYbWgQMaN6pFimMEMrYSuBr6VKJEU?=
 =?us-ascii?Q?wnUEKbFiXcLJffe0KmPuexrL6gewox+/eFzF0Q0oSbP/5aCFjOUnutYQ+5pd?=
 =?us-ascii?Q?DhBVEF+NB3AGliiCoojYJsgZ8dezFbo9lpVwqk07DDOAmN9Ck+/7krGf6gDQ?=
 =?us-ascii?Q?XBJUSwzJyGYHEKFxFFZjeBunxjlDsfDCxx/xOQ5EyJPQEcs4i9OeMXmrKSu6?=
 =?us-ascii?Q?kKTeFDWp5GWtnNMpndWtUhVdDCUM8IqpVh1A4JOl5EYr9ktCq+XbAzRa2E7t?=
 =?us-ascii?Q?6e3kjprMAppRvVDOmkMwS9AWbxB/XazD/1qEujwOcR3FVTCm31cXjYUDlKGd?=
 =?us-ascii?Q?HaPG/26/vLuu9Zucmg+bCYDLT6b43eauqPi844GE1rY4FhRTj2ANh51mAjXW?=
 =?us-ascii?Q?sAGcSJ3lyjE8AV40defCR6GwJoya4P4X9wzUJJeheIKjyYPLl+ZIj3Da4Y90?=
 =?us-ascii?Q?Zl01mcSutZcgUH9DMwWb66WJW9JhTG56uyFcpqbpFq84liauGvPSnzjCqNTG?=
 =?us-ascii?Q?3awAv4/30PvGIm0/OF84tOyAaRtd4ecEIw//1KNkUSOyx2POx2BSWMvk3NOz?=
 =?us-ascii?Q?7jspjAL33uxpqui/lfUeysy3yGOe2drKF+APKdMLU4PkYApGYWHpRg8h/D4K?=
 =?us-ascii?Q?MsmgakUwC85mGQhoQyPtuj/3JmoJ4XHitc35SDyRP5ONmBAoKmHmrRNiOh0v?=
 =?us-ascii?Q?Farpo6bdvn6FIGxC5mbMhGptsRshf6twLMhonxrZxVLDUQRXnaWLE/ZGayJs?=
 =?us-ascii?Q?xKi7EDdLEJDa6+krDHa+ajLvJNtQH7EwItzCYDkk++GqsO6t9xHEtlZaKPAt?=
 =?us-ascii?Q?BSrynQyQTrjRYc32hORtFD20xNjz4DdyRn0abspxStcv4+7I2g1DhwLDB7l4?=
 =?us-ascii?Q?db//7kaXIe0xnngyzxfPQeIgdMw9vMOBupSQylRdV27GhNpAtv9PNG9Wbj4X?=
 =?us-ascii?Q?+ePdrSHrm3cvdP+UoK/e2MPUYpYhUOD1pkAkOZkC6Lv9wTX72B6ZDIMjahG8?=
 =?us-ascii?Q?8OQzIwU/aCS2hFtNPEc4OQbyhVZ4jsWR4v38VRtAVJjE4Zbx3cMwRzsm+/Qy?=
 =?us-ascii?Q?dZk3Ug/fdMbmo3hxF8S7PKrxXc4pIK0Tq1BcUrueq3S/DibADj80FpmPYq4o?=
 =?us-ascii?Q?TckmFRl7S3JDfHEdNZRcbJ90ZmQto96alrieUDZZuEw25i8PIL8xzfuk+6u3?=
 =?us-ascii?Q?b+lhp6Iq3RcZdQuvUWTcm4XWiksNVkhzfKbFPu2TORCZgLCCY7YZtlGAjFDe?=
 =?us-ascii?Q?H5tXpyyQTbl4iq1FcxB8fXWqSa2C/lrSJ1GQd6IIxkFsI71uYrtrcI/RHYDj?=
 =?us-ascii?Q?r1/cabw6wkI4swHxf1uWelQQGo/d81+N7oxofzDLoYKqIYJDWS43ibrwh+ij?=
 =?us-ascii?Q?piiqX/mMwRg8P9bWZIgN3hAHxdy9+deZ+YPaod/ZolvxBDYS83ZMQ/p2spEP?=
 =?us-ascii?Q?RWUMZITFz/QnvnNtrylC1P8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3637ec55-2cd1-40cd-1b67-08dddf3c50e4
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:20:30.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQKqQmKZsnLLNkeN69NnayB3MegSfg0SPxqh4QdNb/FcANiH376JbuSGULZ1gKjSUYIhZCjL4W4AB6ckhEVWqfbC/q1IEmRNO7MSln7ojZwaDdfbP+NdytZvor8DYA7u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7049

Hi Biju,
Thank you for the patch.

On Thu, Aug 14, 2025 at 07:41:06PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> RZ/G3E GPT IP is similar to the one found on RZ/G2L GPT, but there are
> some differences. The field width of prescalar on RZ/G3E is 4 whereas on
> RZ/G2L it is 3. Add rzg2l_gpt_info variable to handle this differences.
> The FIELD_PREP and FIELD_GET macro is giving compilation issue as the
> parameters are not build time constants. So added Non-constant mask
> variant of FIELD_GET() and FIELD_PREP().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Thanks & Regards,
Tommaso

> ---
>  drivers/pwm/pwm-rzg2l-gpt.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> index f0a8531457ca..bf989defa527 100644
> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -33,6 +33,19 @@
>  #include <linux/time.h>
>  #include <linux/units.h>
>  
> +/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> +#define field_get(_mask, _reg)	\
> +({\
> +	typeof(_mask) (mask) = (_mask); \
> +	(((_reg) & (mask)) >> (ffs(mask) - 1)); \
> +})
> +
> +#define field_prep(_mask, _val)	\
> +({\
> +	typeof(_mask) (mask) = (_mask); \
> +	(((_val) << (ffs(mask) - 1)) & (mask)); \
> +})
> +
>  #define RZG2L_GET_CH(hwpwm)	((hwpwm) / 2)
>  #define RZG2L_GET_CH_OFFS(ch)	(0x100 * (ch))
>  
> @@ -46,7 +59,6 @@
>  
>  #define RZG2L_GTCR_CST		BIT(0)
>  #define RZG2L_GTCR_MD		GENMASK(18, 16)
> -#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
>  
>  #define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
>  
> @@ -77,9 +89,14 @@
>  #define RZG2L_MAX_SCALE_FACTOR	1024
>  #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
>  
> +struct rzg2l_gpt_info {
> +	u32 gtcr_tpcs_mask;
> +};
> +
>  struct rzg2l_gpt_chip {
>  	void __iomem *mmio;
>  	struct mutex lock; /* lock to protect shared channel resources */
> +	const struct rzg2l_gpt_info *info;
>  	unsigned long rate_khz;
>  	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
>  	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
> @@ -317,7 +334,7 @@ static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
>  
>  	if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm)) {
>  		gtcr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
> -		wfhw->prescale = FIELD_GET(RZG2L_GTCR_TPCS, gtcr);
> +		wfhw->prescale = field_get(rzg2l_gpt->info->gtcr_tpcs_mask, gtcr);
>  		wfhw->gtpr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
>  		wfhw->gtccr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
>  		if (wfhw->gtccr > wfhw->gtpr)
> @@ -354,8 +371,8 @@ static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
>  		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC(ch), RZG2L_GTUDDTYC_UP_COUNTING);
>  
>  		/* Select count clock */
> -		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
> -				 FIELD_PREP(RZG2L_GTCR_TPCS, wfhw->prescale));
> +		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), rzg2l_gpt->info->gtcr_tpcs_mask,
> +				 field_prep(rzg2l_gpt->info->gtcr_tpcs_mask, wfhw->prescale));
>  
>  		/* Set period */
>  		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), wfhw->gtpr);
> @@ -414,6 +431,8 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
>  	if (IS_ERR(rzg2l_gpt->mmio))
>  		return PTR_ERR(rzg2l_gpt->mmio);
>  
> +	rzg2l_gpt->info = of_device_get_match_data(dev);
> +
>  	rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
>  	if (IS_ERR(rstc))
>  		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
> @@ -456,8 +475,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct rzg2l_gpt_info rzg2l_data = {
> +	.gtcr_tpcs_mask = GENMASK(26, 24),
> +};
> +
>  static const struct of_device_id rzg2l_gpt_of_table[] = {
> -	{ .compatible = "renesas,rzg2l-gpt", },
> +	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
>  	{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
> -- 
> 2.43.0
> 

