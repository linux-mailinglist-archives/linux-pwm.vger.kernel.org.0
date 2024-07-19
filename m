Return-Path: <linux-pwm+bounces-2865-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE8F937D7E
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 23:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF1D281F0A
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 21:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F3914831D;
	Fri, 19 Jul 2024 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jVG09LWO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94BE1448F6;
	Fri, 19 Jul 2024 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721425140; cv=fail; b=c1tMrOVtmmdFjWhDD2dHn8BNCEYQSFUmZpcI4rMM7jEYOm/GYsS6lQzSt3eHZZDZU2c326NhvyOMk30wvMry3bgWQbqFCN4joPj3HP0qZjGqSy6DXrwlil6TolekQg86E0Kugym6k6NNiveM8QwOKybd+S0ZoGJGSWaKvgH9BG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721425140; c=relaxed/simple;
	bh=QQLjSTHb5qzX/n2o2G2mbmOQJSv7ogcFkO7ub7uTHBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X9qJk1HuEK2vG8KDVJEcG2ngVuwAaTURfjiTtG2zybwmLYDA5o8xPwyczFdIsJsgFqmovfPFTLqqEiVdohHRp+gEllXFk4ww8bSkcsCZNrwI/snuh/+xrc4SExpSA0XVwFX0HzwcG3JBrWqmhpOmBoclZ4lrqHhx0eFWzgudGDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jVG09LWO; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEuqano6MJ/0Jn4e9eQ/B9L02IA4u0CTd61i43gnxCFnsqHj5NdV2bOhIxV8uN7TmMiVWG0BqfvuNB/qF7Gswgk0Kv90fYFopDZToVpo//WkqH52TXpFs4QpCM6XlI/W55+6AT1U/6Y+AVLxhQ6I0a40Z3K/46Ye6eMOVisvtGETLsqYI2lWD74HipeIQMEwOr7Xy7ADybjSaz1BDhKiBQOvv5sHL4OuAJRmA8hL9WwuR52e9bwNMndrxZ/UzroMh5YEnzQ/JAWumDtfmk3mxWpqDmO00v+bL1dCltE2Q1UT4CLk3YZKIlkZ6Vn+bXmzlcQVM3KvK7K5BLBkhI+/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n62g4JrZDiox3c1Wlc5bm4z9NvN+/rpY/FwVPi93dSE=;
 b=Ib5eHwgBB33vGXvjb5NFekvhvo/djNaSQRpqztW2ATYvG7gwwOX5bZSTMLZB7RURsJULDBbNw7STkfH2TmV/M4dy41+UE9aBh2I9U2+aHxuUZ0EiT4givYOB5mKMvX/HELh4SOlrC0/O5JE29Skm5PGBE/dzHjcvF7YtY43LWxwIry9AEwQlJCqRXLRN0fQAfOiokVxKKEueOLPvDiFNOKzvCDdmdlZ7aBfJO5CgQIjb13upqoKI2+scJXYeORKTi23IaL5WBtW9W41UE/35kAy3Axz/srPKII25KJKq2dO7xDjM5MEKFtfd3/gX9OEu4OJ9WVGcWVsWVi945TZCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n62g4JrZDiox3c1Wlc5bm4z9NvN+/rpY/FwVPi93dSE=;
 b=jVG09LWOTPlDFdPGE9XVr76uM46z7KtyEdCxRgV+fp8xnSBoM7SEe7iFvTBsdlGzxRIJEt/smtQRnnpbhCe/mIjMUN1IgzRxykGvTK/ayUYSTwm41LI19R2rl5W9t/GXmxfQRAwqUDd5kPxvGtXK8xkiqKDSxxtJIqdLwhuPMPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10783.eurprd04.prod.outlook.com (2603:10a6:800:267::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 21:38:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 21:38:53 +0000
Date: Fri, 19 Jul 2024 17:38:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v5 3/4] gpio: adp5585: Add Analog Devices ADP5585 support
Message-ID: <Zprc5Vl9UFIrUvDe@lizhi-Precision-Tower-5810>
References: <20240719203946.22909-1-laurent.pinchart@ideasonboard.com>
 <20240719203946.22909-4-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719203946.22909-4-laurent.pinchart@ideasonboard.com>
X-ClientProxiedBy: BY3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:254::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10783:EE_
X-MS-Office365-Filtering-Correlation-Id: 88009253-1224-49fb-cac4-08dca83b2f83
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ar85mjvWrfyAEh0oQKDnSB6E4RP+psiz88JpmIUyLergkIR9Hn2HQtEsFkNJ?=
 =?us-ascii?Q?TyZdzXdgpoM/6slHnY2yNae56EEVmN2XJitKOaynXFgh18/D5G2LyAbMQVh/?=
 =?us-ascii?Q?HF+L/rbsl5Wz0nN5zvQ0Ec8LVOZvbkUssgFQPcU2iBMk89u0YxC7tNUqTtBP?=
 =?us-ascii?Q?Qjdjpk6MvETMmbrD39HPu7tXovyuoqecsLQG3la6amHbhWYI0jjFgqTbxfZA?=
 =?us-ascii?Q?QN5uIqWUGtV83MHOqlze3fRPtvkYtsPArt9f35maYlMyYHaaHHm6z3xW1X0B?=
 =?us-ascii?Q?iS2uRUIzvKlbhamnEsqP6Ur4K8v1POXc39mgHbqqaPH+SdN8HbzZQ64T9VIz?=
 =?us-ascii?Q?+fsLJKwjrFiKdO14JU1bl683yPnGlYRyXhlcazsdFrpz5OPSvkoM75k0Ew9j?=
 =?us-ascii?Q?NfsTprWo56asafpPQdyoft8Ipo+k0uAUvcC1ksT1u9WB8SQBLPFiNxnMgEDy?=
 =?us-ascii?Q?7NQDKN+6E6CIRqs0EexsQLOkrU4UmuUI45ukL1i+UyITTy7Nh1Ny68iyKsMr?=
 =?us-ascii?Q?fmDtUsH1x+k40lX0OhS0BfsyGV06pyKG+fzNDKeAxKpY9gQlvH0FBNnLtcvI?=
 =?us-ascii?Q?mtHFKeRvh5+x0pbwnYsa1RKtVUmqPf08Hpty8UEGck1Ny+yLVqebynS9OC77?=
 =?us-ascii?Q?3wdzlL/0H7dYnR6i4crq6l8nyVNiH66PXaYUWaM/Inm8W5fIm60QVadxSIrd?=
 =?us-ascii?Q?2awjID9B22mTMKAKjtmy7BgilVcI+DKG5eAOG6eFgThR++ljFJTET8c+Uebx?=
 =?us-ascii?Q?YAflxsdcyZ1ocps2FzlVQUFj48w2eLbmWX/4/Yx5Np2UXYx5+4OtMtvkegHt?=
 =?us-ascii?Q?F5cks+SqNXSVGSmc9nEM8WFrPZ+fE4e9UZjJavoik9SJPLP/2viMR8yORpSA?=
 =?us-ascii?Q?tnTc1Zm8Q7HC8+huiwAnYPu1THUev5Z5XD/TTNieYjOw86+EX4rSN/0Z9LUw?=
 =?us-ascii?Q?Tr06eEhXjhQpMOOdQ5+bgK8jXp05JVrqBxm+UfMGBikuon+yZNkWm4JShlFZ?=
 =?us-ascii?Q?epue3L7ULgVkXgEXG9nMZnpubobnyR+MUEX1pfe8Re8+ElOjjFaBKyRjksLh?=
 =?us-ascii?Q?txCJpQuj8lXy+zcvUgfq/b1vDew2h54ecb5lIBmRXkf6DGJTOWHYUqVa2Wwb?=
 =?us-ascii?Q?kFH8SgEBJTKOOjYTCZu9c2TrJXPSEZEl6kd0qSz1UwBjCJi48bQDLep9UJVR?=
 =?us-ascii?Q?q/gQaV5JQB47FSucVffxUWL5WPbULTFAsDQPO2tTLHxOKaQjD2iccr12EsdV?=
 =?us-ascii?Q?d5Cn1F4FRTpit0sRhLAELbIvg8rjP5GP6M7ww6FowMyR6eDo4MjIh88ycGby?=
 =?us-ascii?Q?4lGnQPS0dfDtcldeP4lRcl/usiaF7FQyTqDIWGHN7yeSx6wMG5AKP/zWa+1H?=
 =?us-ascii?Q?5JyUMmYaDsPaiC5zETj7u3IJ1GFiNigeVzgAgNgrPA5DX4UdRQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?lJdrVDQxbA+vgpPZrKAU3LGaB+Wv2z4Q5wHxdcTcR6DpZ/b/ESkbv2kA9Pjx?=
 =?us-ascii?Q?HEJw+cyFsrDspJhFRaxhDKH67Rl4yWBp6tkAUUvyFr4B8OZECWwcTvya7sOR?=
 =?us-ascii?Q?XGkJr5Xjz4yWoltq0wM+a/MXkYbOcZYm3oHUzXz6XyG+q9/dHyt1UhsflKVV?=
 =?us-ascii?Q?0MuQUoQC3bmWb1VuNIMjkmGUeBOib3XKHAHbtgf7ZqXlgD/jerKjSeTzAQ7z?=
 =?us-ascii?Q?bYloayMGXP6lz/sry4c4rzhrBZFh+d2hIzkDGNRPmRtRy31536wjppFgepa/?=
 =?us-ascii?Q?GKMyHrKjBbPUkWhp7fXeSY/K6ldhNXlplabhtYv7X+9OfBGMjoGkZ33LOa5G?=
 =?us-ascii?Q?CU9eLQbe3jOSabKuALJO5a8IjUnjrz8rLUIlWBUYwLtGqtMxCajby428xhlv?=
 =?us-ascii?Q?WUHP4yrWVkT6i4j1ta+Vr3s2s9T4bgt76vFGl2EpMQvDKvUtA7l4NscvN4TD?=
 =?us-ascii?Q?0Y0ao4I2QH8JoiXxag0NW22+Nf88VBz6tra+RnQcQBD/1YTNUEYx9sJVI/WV?=
 =?us-ascii?Q?iZLmNfXOSXqhTtMJ9LaVHo4Ak/IW/4+HHPxC//3GzjzbspYclP0/NM5tbdwJ?=
 =?us-ascii?Q?wKKuX0EISpRpXb7mr9nGLhBpEHyY14M2hB4IcPPV6WXObtqy5v16aKMfPE+a?=
 =?us-ascii?Q?eZeFLI/r+pMQp6XAQLzyvHAI1CMexu9voBrvRyP/MSm5Vn3evxTgVfjPnjr7?=
 =?us-ascii?Q?Q14xy6fRuRtJFECScCQP6ZN87k65XyW5xQF6X4QxvvGU9ILrjLU+v0LL2mYQ?=
 =?us-ascii?Q?KfGoJ0HbL1Vqp8lP7If9tt+zP3JVHmInglUxW5Ftfx+ODlm4OoTeJmHWKd64?=
 =?us-ascii?Q?uDttnriSM9jIna5KWyOzYwnv4ixHaIVE06GVNRyPsAB2Bhb7+Zvue2mOO/1e?=
 =?us-ascii?Q?dbcfdvLoCTAebEp0BfKINR/oEL7LytG7yMOBv48KWN1BDBhOTnFbtqT7EXZW?=
 =?us-ascii?Q?VFJSkx36fbol6jlSreYL02NYwgMHPhMTJJJmLy3U5Q/xjnmnS99UKwncNAQV?=
 =?us-ascii?Q?TGt4Eqc/Tea+lastFr0TjQKb/su7owyXODdeH4TWhwa7JgawBV/0JMldv1u0?=
 =?us-ascii?Q?bSW3OF1fPeZwzUsG6hS0I1/eVHn4J8Vkqf7/OpDag+GQF6q/710MiV42ezym?=
 =?us-ascii?Q?/kZfndf63ymKAtx9B9kYnAv41urpJMcu7O4roz4XGrYHF/bPxtptqqK/4GlO?=
 =?us-ascii?Q?ZfS0zG1vnjl5MLvnPMJ8547nG43NnKMGr0A5Qn4qrjtAnBRbNPirSYHzAkMM?=
 =?us-ascii?Q?e2PCmrXiC1owy36nq24CPRe74MA+WcVDm5CvwhrwY+kersSnQxARoZCiqMav?=
 =?us-ascii?Q?pLdjPRtJNkAgn0ERvh8JVDKtq9Dv6eovHXKLNxq54baBsfBmZpbbiNA2OSC6?=
 =?us-ascii?Q?xRXHuiuxWGw+Bx9IpPgYluZ7pkjdnAOBE3iKh3hF3zpwRS+Gwc0/iAYUjbf6?=
 =?us-ascii?Q?QSQwzMM+U/YSD20h7v/dzR4lgBKD7rHjO+IIffuv0sVYL2P88gF5G00PxsRQ?=
 =?us-ascii?Q?vy1CJ/kBaSBH23Dvw10QETYWeO5zRbQcCOYRS0/Yiv//PEXwAKt7uXqnjQ5A?=
 =?us-ascii?Q?f93sZnppHlx8mL/zSKM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88009253-1224-49fb-cac4-08dca83b2f83
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 21:38:53.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hv1yv0lJq0p3f5yuJd+Sb9iBjun/DHwq9adM2VjyJHuBFg1xoVrhCsgVpx6xgboxFkAgvaLFdUX3TDno70mN/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10783

On Fri, Jul 19, 2024 at 11:39:45PM +0300, Laurent Pinchart wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the GPIO function using the platform device
> registered by the core MFD driver.
> 
> The driver is derived from an initial implementation from NXP, available
> in commit 451f61b46b76 ("MLK-25917-2 gpio: adp5585-gpio: add
> adp5585-gpio support") in their BSP kernel tree. It has been extensively
> rewritten.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Changes compared to v2:
> 
> - Add missing headers
> - Drop platform_set_drvdata()
> - Fix bit shift in bias configuration
> 
> Changes compared to v1:
> 
> - Drop OF match table
> - Fix .get() for GPOs
> - Add platform ID table
> - Set struct device of_node manually
> - Merge child DT node into parent node
> - Implement .get_direction()
> - Drop mutex
> 
> Changes compared to the NXP original version
> 
> - Add MAINTAINERS entry
> - Add prefix to compatible string
> - Switch to regmap
> - White space fixes
> - Use sizeof(*variable)
> - Initialize variables at declaration time
> - Use mutex scope guards
> - Cleanup header includes
> - Support R5 GPIO pin
> - Reorder functions
> - Add bias support
> - Return real pin value from .get()
> - Add debounce support
> - Add drive mode support
> - Destroy mutex on remove
> - Update copyright
> - Update license to GPL-2.0-only
> ---
>  MAINTAINERS                 |   1 +
>  drivers/gpio/Kconfig        |   7 ++
>  drivers/gpio/Makefile       |   1 +
>  drivers/gpio/gpio-adp5585.c | 231 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 240 insertions(+)
>  create mode 100644 drivers/gpio/gpio-adp5585.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ebb1a1833bbc..b748af2acf9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -532,6 +532,7 @@ L:	linux-gpio@vger.kernel.org
>  L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
> +F:	drivers/gpio/gpio-adp5585.c
>  F:	drivers/mfd/adp5585.c
>  F:	include/linux/mfd/adp5585.h
>  
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 1c28a48915bb..fc66e8264eef 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1233,6 +1233,13 @@ config GPIO_ADP5520
>  	  This option enables support for on-chip GPIO found
>  	  on Analog Devices ADP5520 PMICs.
>  
> +config GPIO_ADP5585
> +	tristate "GPIO Support for ADP5585"
> +	depends on MFD_ADP5585
> +	help
> +	  This option enables support for the GPIO function found in the Analog
> +	  Devices ADP5585.
> +
>  config GPIO_ALTERA_A10SR
>  	tristate "Altera Arria10 System Resource GPIO"
>  	depends on MFD_ALTERA_A10SR
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index e2a53013780e..04bfa2bc7e11 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_GPIO_74X164)		+= gpio-74x164.o
>  obj-$(CONFIG_GPIO_74XX_MMIO)		+= gpio-74xx-mmio.o
>  obj-$(CONFIG_GPIO_ADNP)			+= gpio-adnp.o
>  obj-$(CONFIG_GPIO_ADP5520)		+= gpio-adp5520.o
> +obj-$(CONFIG_GPIO_ADP5585)		+= gpio-adp5585.o
>  obj-$(CONFIG_GPIO_AGGREGATOR)		+= gpio-aggregator.o
>  obj-$(CONFIG_GPIO_ALTERA_A10SR)		+= gpio-altera-a10sr.o
>  obj-$(CONFIG_GPIO_ALTERA)  		+= gpio-altera.o
> diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
> new file mode 100644
> index 000000000000..49f8d91623ba
> --- /dev/null
> +++ b/drivers/gpio/gpio-adp5585.c
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices ADP5585 GPIO driver
> + *
> + * Copyright 2022 NXP
> + * Copyright 2024 Ideas on Board Oy
> + */
> +
> +#include <linux/device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/mfd/adp5585.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#define ADP5585_GPIO_MAX	11
> +
> +struct adp5585_gpio_dev {
> +	struct gpio_chip gpio_chip;
> +	struct regmap *regmap;
> +};
> +
> +static int adp5585_gpio_get_direction(struct gpio_chip *chip, unsigned int off)
> +{
> +	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
> +	unsigned int bank = ADP5585_BANK(off);
> +	unsigned int bit = ADP5585_BIT(off);
> +	unsigned int val;
> +
> +	regmap_read(adp5585_gpio->regmap, ADP5585_GPIO_DIRECTION_A + bank, &val);
> +
> +	return val & bit ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
> +}
> +
> +static int adp5585_gpio_direction_input(struct gpio_chip *chip, unsigned int off)
> +{
> +	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
> +	unsigned int bank = ADP5585_BANK(off);
> +	unsigned int bit = ADP5585_BIT(off);
> +
> +	return regmap_update_bits(adp5585_gpio->regmap,
> +				  ADP5585_GPIO_DIRECTION_A + bank,
> +				  bit, 0);

regmap_clear_bits()?

> +}
> +
> +static int adp5585_gpio_direction_output(struct gpio_chip *chip, unsigned int off, int val)
> +{
> +	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
> +	unsigned int bank = ADP5585_BANK(off);
> +	unsigned int bit = ADP5585_BIT(off);
> +	int ret;
> +
> +	ret = regmap_update_bits(adp5585_gpio->regmap,
> +				 ADP5585_GPO_DATA_OUT_A + bank, bit,
> +				 val ? bit : 0);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(adp5585_gpio->regmap,
> +				  ADP5585_GPIO_DIRECTION_A + bank,
> +				  bit, bit);

regmap_set_bits()?

> +}
> +
> +static int adp5585_gpio_get_value(struct gpio_chip *chip, unsigned int off)
> +{
> +	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
> +	unsigned int bank = ADP5585_BANK(off);
> +	unsigned int bit = ADP5585_BIT(off);
> +	unsigned int reg;
> +	unsigned int val;
> +
> +	/*
> +	 * The input status register doesn't reflect the pin state when the
> +	 * GPIO is configured as an output. Check the direction, and read the
> +	 * input status from GPI_STATUS or output value from GPO_DATA_OUT
> +	 * accordingly.
> +	 *
> +	 * We don't need any locking, as concurrent access to the same GPIO
> +	 * isn't allowed by the GPIO API, so there's no risk of the
> +	 * .direction_input(), .direction_output() or .set() operations racing
> +	 * with this.
> +	 */
> +	regmap_read(adp5585_gpio->regmap, ADP5585_GPIO_DIRECTION_A + bank, &val);
> +	reg = val & bit ? ADP5585_GPO_DATA_OUT_A : ADP5585_GPI_STATUS_A;
> +	regmap_read(adp5585_gpio->regmap, reg + bank, &val);
> +
> +	return !!(val & bit);
> +}
> +
> +static void adp5585_gpio_set_value(struct gpio_chip *chip, unsigned int off, int val)
> +{
> +	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
> +	unsigned int bank = ADP5585_BANK(off);
> +	unsigned int bit = ADP5585_BIT(off);
> +
> +	regmap_update_bits(adp5585_gpio->regmap, ADP5585_GPO_DATA_OUT_A + bank,
> +			   bit, val ? bit : 0);
> +}
> +
> +static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
> +				 unsigned int off, unsigned int bias)
> +{
> +	unsigned int bit, reg, mask, val;
> +
> +	/*
> +	 * The bias configuration fields are 2 bits wide and laid down in
> +	 * consecutive registers ADP5585_RPULL_CONFIG_*, with a hole of 4 bits
> +	 * after R5.
> +	 */
> +	bit = off * 2 + (off > 5 ? 4 : 0);
> +	reg = ADP5585_RPULL_CONFIG_A + bit / 8;
> +	mask = ADP5585_Rx_PULL_CFG_MASK << (bit % 8);
> +	val = bias << (bit % 8);
> +
> +	return regmap_update_bits(adp5585_gpio->regmap, reg, mask, val);
> +}
> +
> +static int adp5585_gpio_set_drive(struct adp5585_gpio_dev *adp5585_gpio,
> +				  unsigned int off, enum pin_config_param drive)
> +{
> +	unsigned int bank = ADP5585_BANK(off);
> +	unsigned int bit = ADP5585_BIT(off);
> +
> +	return regmap_update_bits(adp5585_gpio->regmap,
> +				  ADP5585_GPO_OUT_MODE_A + bank, bit,
> +				  drive == PIN_CONFIG_DRIVE_OPEN_DRAIN ? 1 : 0);

look like should be

drive == PIN_CONFIG_DRIVE_OPEN_DRAIN ? bit : 0

same as the other place.

> +}
> +
> +static int adp5585_gpio_set_debounce(struct adp5585_gpio_dev *adp5585_gpio,
> +				     unsigned int off, unsigned int debounce)
> +{
> +	unsigned int bank = ADP5585_BANK(off);
> +	unsigned int bit = ADP5585_BIT(off);
> +
> +	return regmap_update_bits(adp5585_gpio->regmap,
> +				  ADP5585_DEBOUNCE_DIS_A + bank, bit,
> +				  debounce ? 0 : 1);
> +}
> +
> +static int adp5585_gpio_set_config(struct gpio_chip *chip, unsigned int off,
> +				   unsigned long config)
> +{
> +	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
> +	enum pin_config_param param = pinconf_to_config_param(config);
> +	u32 arg = pinconf_to_config_argument(config);
> +
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_DISABLE:
> +		return adp5585_gpio_set_bias(adp5585_gpio, off,
> +					     ADP5585_Rx_PULL_CFG_DISABLE);
> +
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		return adp5585_gpio_set_bias(adp5585_gpio, off, arg ?
> +					     ADP5585_Rx_PULL_CFG_PD_300K :
> +					     ADP5585_Rx_PULL_CFG_DISABLE);
> +
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		return adp5585_gpio_set_bias(adp5585_gpio, off, arg ?
> +					     ADP5585_Rx_PULL_CFG_PU_300K :
> +					     ADP5585_Rx_PULL_CFG_DISABLE);
> +
> +	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +	case PIN_CONFIG_DRIVE_PUSH_PULL:
> +		return adp5585_gpio_set_drive(adp5585_gpio, off, param);
> +
> +	case PIN_CONFIG_INPUT_DEBOUNCE:
> +		return adp5585_gpio_set_debounce(adp5585_gpio, off, arg);
> +
> +	default:
> +		return -ENOTSUPP;
> +	};
> +}
> +
> +static int adp5585_gpio_probe(struct platform_device *pdev)
> +{
> +	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
> +	struct adp5585_gpio_dev *adp5585_gpio;
> +	struct device *dev = &pdev->dev;
> +	struct gpio_chip *gc;
> +	int ret;
> +
> +	adp5585_gpio = devm_kzalloc(dev, sizeof(*adp5585_gpio), GFP_KERNEL);
> +	if (!adp5585_gpio)
> +		return -ENOMEM;
> +
> +	adp5585_gpio->regmap = adp5585->regmap;
> +
> +	device_set_of_node_from_dev(dev, dev->parent);
> +
> +	gc = &adp5585_gpio->gpio_chip;
> +	gc->parent = dev;
> +	gc->get_direction = adp5585_gpio_get_direction;
> +	gc->direction_input = adp5585_gpio_direction_input;
> +	gc->direction_output = adp5585_gpio_direction_output;
> +	gc->get = adp5585_gpio_get_value;
> +	gc->set = adp5585_gpio_set_value;
> +	gc->set_config = adp5585_gpio_set_config;
> +	gc->can_sleep = true;
> +
> +	gc->base = -1;
> +	gc->ngpio = ADP5585_GPIO_MAX;
> +	gc->label = pdev->name;
> +	gc->owner = THIS_MODULE;
> +
> +	ret = devm_gpiochip_add_data(dev, &adp5585_gpio->gpio_chip,
> +				     adp5585_gpio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add GPIO chip\n");
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id adp5585_gpio_id_table[] = {
> +	{ "adp5585-gpio" },
> +	{ /* Sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(platform, adp5585_gpio_id_table);
> +
> +static struct platform_driver adp5585_gpio_driver = {
> +	.driver	= {
> +		.name = "adp5585-gpio",
> +	},
> +	.probe = adp5585_gpio_probe,
> +	.id_table = adp5585_gpio_id_table,
> +};
> +module_platform_driver(adp5585_gpio_driver);
> +
> +MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
> +MODULE_DESCRIPTION("GPIO ADP5585 Driver");
> +MODULE_LICENSE("GPL");
> -- 
> Regards,
> 
> Laurent Pinchart
> 

