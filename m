Return-Path: <linux-pwm+bounces-2839-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5871593357B
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 04:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE091C22755
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 02:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BF04C8D;
	Wed, 17 Jul 2024 02:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kXQnx+ny"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE436FB6;
	Wed, 17 Jul 2024 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721183983; cv=fail; b=uhBBMV3YuJ7qn0P5X9EdsT77my+g/OUPdXM5yGWRYicG90sdy8ZFF9IGdCb9EQrr0jAAYvfdrZqngS+D7yGeg9/6Z4vZZHJ8Tn7GhkEt3DWjxl+h7aKgj84n9hpJbPn/XQH3pWhqJ1HgX1BsU75RfdMnjEH/GDk0QCGCJgMVw34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721183983; c=relaxed/simple;
	bh=Lqzw7RyQJZ3F0g0nc8ipVyeLLlukgSoLkO/P5eWiLXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VdVvQ/sLlELYc2oCsLdeK+V9N4QBhOO4Mr2uDtGWKfJ1zqXpeTz4nVh1jd+0+K2U3t/Iz8pKOfVdDIKiOGe1zsEaqa+y6D0XkfmXzcNt6Ieyt7PYcS2KXCcNJkbTiz+m+R8t/2s2HeAEbrIbPO/B/rd1P/xA/lrmVOxulxyUSQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kXQnx+ny; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kefqxMwF6ZYNH0KxfulGrvmyi746Sjwl/XAVrWGqvSu/hIahAs/ijqoBJJ8TEY1Maahr/UWI/IlNZD9/qvyqk9tAQFrUcQC4B6vNvU/M0u94O9VTFkVJYx5rC2LgQGkzNoM2+IGFbcNBfHz7dk3Pghy2d6SRcUkwZb9FhHFextpkbkWNuLjr8cVoy2M44nS1oO6X1VhsMV+tIlNQ6vtzk+Mi48nQas/1fPxbdr8h6sLe2s1LiO5PygBqggWyJnESnMDADxr03WDmMm7pJf3UGvna1MiFBiKreYcrD6rINNrOaj9ugLnwdloJaUrLtGbVpvFN2HDPUOdpTRxifYI6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6UUVW2Op0DZ8tGIMmNNUsnv9nwtBut+7F7DSfsEg18=;
 b=RK5rPdhhfuvBFl5P2ckIGxkK3vAe7kzkUUY0dJF2sxnvWZ86EYFNl81BmwXokIJyI26xa3hsxeLUWI4xn6L1xJnknZ1euRr5gQCiD+uDBiVv8ar7ly9qTXO3zGWCkUbIXwoAqR9KzwkNb6xcW6Wvc7HwNdVy28E0GTuFtp3tDQeeZ46TLdfEUwrPZSZ3itroy8ydCwcuSkfksuKEWDxDbLFjZ4KiS0kKQlCCNoWR61Mp233byh1Z+EFVYga5tsi/iTygyc3TKngg9DrJMkmyUrJIkEOnflX88mWpEQv3NUyM4DyqsxmRkjbaJvFYShf2JWF8LpAsBQhmkZjfFD189A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6UUVW2Op0DZ8tGIMmNNUsnv9nwtBut+7F7DSfsEg18=;
 b=kXQnx+ny4wBVZOVKsdPa0AqTVpzmyKe08N2ELGAsK3mTZ1WZ3MI57HSwAA4Qyveoh0c7v6xB860kDda1jW0twz+2HhldIHKuClV1K+CZNLiab/mZJYPO0X2FV9zQdzosBzdYloy2p6tVzRznJ3e2OljChzhSfVO/wG6ohnmziIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7282.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 02:39:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 02:39:37 +0000
Date: Tue, 16 Jul 2024 22:39:27 -0400
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
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v4 2/4] mfd: adp5585: Add Analog Devices ADP5585 core
 support
Message-ID: <Zpcu3+6Ar/zR78Ma@lizhi-Precision-Tower-5810>
References: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
 <20240608141633.2562-3-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608141633.2562-3-laurent.pinchart@ideasonboard.com>
X-ClientProxiedBy: SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 27680704-990d-4ed4-cd40-08dca609b308
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Oe+J09XSrjahLXk2QfDlKa+2ZIPYIXABIG0fuuxkZ9CDSC4TjlY4MQhAStB6?=
 =?us-ascii?Q?G1EoTsVWw0v993i2Or/yAm8RR8xSSuemGx6Dgwm/xxb65RoozUqW1hZWZFND?=
 =?us-ascii?Q?ihEWGc2O9N77tGwUVPEeATxR8PxCxCSnTta4D2cznmQjjm937xHbjff1Fxjm?=
 =?us-ascii?Q?lci90NQJAd6NVpi7+kjKjx3scWdWgCauF/r+Ij6ROOArBUDRRlujiqllLKZY?=
 =?us-ascii?Q?vlEi0yxqAPh3Yk/VHjc1YwkMqX1EcDzXmxScCkF1U75vms9xnEW0xFsQXmGD?=
 =?us-ascii?Q?nv0enMxBrqHVU10NwHzMuG5UNHaDLP+ltOJdWKywLcMwXfXwson8uRpCSGrN?=
 =?us-ascii?Q?nHBxNJO8ne2sNA0H3EH8fv40G6/Cwk8JbbgEFkrnAsJwzJSFsJy25IO9v4pq?=
 =?us-ascii?Q?8Z1EMVJDN45lYviEjUjfDf687poBMMnh6FGqygNnQmYe0NOUy1tuYPiBd1VM?=
 =?us-ascii?Q?A6+U7rCQohj7RapcOcIeXOJbprEG0JinX4Wv7S3Dz8D1O4PZe8nL39z2CyLN?=
 =?us-ascii?Q?J4dlzhCesFRg0I4j6OAndD4SZ5f8KRNPyA1t4CVLvLkC4GWwba3vUgpxCjaA?=
 =?us-ascii?Q?Aog9fTDjGkJVn71pXP6bb0fTqtE6/SMxaGjKuHuFNdrVLaL8pBLDJmj/fksH?=
 =?us-ascii?Q?IHiClTTtBhq4KRaETXYhSLeZlCSqBPNsk4tHJTA+olwhwGaZtKdleiMeurG5?=
 =?us-ascii?Q?CP1PsJJKVowEB51bC2/d5E3zV1m3fpEINWvm4PY2PPekr58pmnEl/Kt8G/Gn?=
 =?us-ascii?Q?LQsk/bWGonc69lcv7PvGJzWs2KRnxpmT5aRz/fzjwqbbcZmvlSPN3iDtfjU4?=
 =?us-ascii?Q?y2EgpRw3ySzHE2xDBd8yuhRuFkQXPnTWBdRHbp4AzHMsCcxRz14U2gym6OCA?=
 =?us-ascii?Q?EmkRYYnd2dQeex+9bo44dUxIqojCoeJogljH/+jB5RU9qqPxA3UmCrfY2znf?=
 =?us-ascii?Q?JqSmcRUcjxKPKnuTWmhPqyNZcasVHqG/ddmeiguctP9Mj45P4zFhgBu+gfYY?=
 =?us-ascii?Q?dudifQ4J0z0ePDCg2r1HcSFlr/n/JPbqfWcG7ab/Gyyqau3zFAUJ011irJDj?=
 =?us-ascii?Q?R0R0lEBvif/5zv9MoN3qP2t6/muo/H3FQV/U0q+GOh+Snkz4xClaNTROXy83?=
 =?us-ascii?Q?5a3Y5h0lQ6tdFvSgU/Vpuc5dDo96X5rrQ8WEt6Z4rMkN7DTNUPYAzYpJbxiW?=
 =?us-ascii?Q?LcWCFvxNe1AX92feRqA+cRd16db5k5DudwRD6vFpfEfgcpaaNwbsP+YQ8hmv?=
 =?us-ascii?Q?EubktqW8mcps54NQXwN34jBwKNPs7s/lvNhXkAs6on1M/CAg9Dl9aVTOexmi?=
 =?us-ascii?Q?b4nFk2z9K3SJwVANuASvo/Y3TBMnKWMPiu5bwAKq7kEGqFUllwees1icr0VR?=
 =?us-ascii?Q?RzNwy/31Bn2QW+7LH7X1jryoHPh2lmbSazZDf09n99dzZF3Siw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?PWb5Qy5TsbtQXqkzgt1sgGFU7fOkqSrHoR/IGkYsltCkPL/FnUiB6Zuz9LTb?=
 =?us-ascii?Q?k2qNdS1JEeRdFXw2G4h0pZ23w7XXUPQrxL6DvemfFpAMA+9oymFU0FCkHkVV?=
 =?us-ascii?Q?nb4pF//gi3UZMcJmCnSfWEhd9F2U4w5LHj3VJnlEG0d2YlG3nqgBesFT7CPl?=
 =?us-ascii?Q?lH6FUg8mh+/fDIjoLgTv6KExd5o3GGHI11RY5bIAWao3gAiYYZDLEijFXFPL?=
 =?us-ascii?Q?gvicBlXksPo/lfTAxRx7Q4OTjPCu+P/r1hZEBHjQDMBud5rzopwhHIogX2uI?=
 =?us-ascii?Q?v1VvK7AhU+oWlRcbsSFDxtlQaY5jj+cpC6PHSFCj3Xk6O3FqLb2KXCO18AAQ?=
 =?us-ascii?Q?NN1nAq+yd0+cxxFMX07d8UwsJkM28GzT1b7F0siobK84GHHDdZwOGXhQMvEj?=
 =?us-ascii?Q?QsecbdAWjWjXho6jWjtd7+JxMf9vVm3GL7czKPPxM5hf+ypHmVECXblGAFt2?=
 =?us-ascii?Q?U+0R8Ml+xOsGD5mN+TpppXlya3LMpm49YcUR0j17PKwfQz8lmTvLJluu0X3G?=
 =?us-ascii?Q?IRfdGnBSy5hN8NmU3UhmzElhZF1FJyMQdW6FPpZ+PWpGnZAejcslBxev/jZ/?=
 =?us-ascii?Q?RHDbETrKEKULaMlWh2W/aPL7OacpMu3fBP54swMSDmPSYreKkniVPgXaWWx0?=
 =?us-ascii?Q?FhFB6VEHLmZEC9aBb4hxF63eNOZn15aoDE5lK739TDYiG6YrADt8RMocvrX+?=
 =?us-ascii?Q?DIwMrEJ1uoiBCKb/WJy9Z7+WnmIXPllF/EtFT0UNw7UsrSwUHe3ohVqn0jy+?=
 =?us-ascii?Q?oxSbN8W3i3ka1p3EGNnHSsFqa5fCyCFFjOb5fLOTInUQH+W/3pA/KLGz+N9B?=
 =?us-ascii?Q?ZYfpkAUdsfl5Tl/90M4lZHpXt//eDLtJ9kLuvqxQ+4XCsOqN0pGVmb+ZsTbg?=
 =?us-ascii?Q?4GSlsG6Qk4WMQ5Uv2a2L52bbKxk7n5qCF3LuYpCXpeWRzOw8Of2CbdfZFo5u?=
 =?us-ascii?Q?isyqyM0NWnZjE7wWFZ5XWVVCcDiiUPou2+3ZccnJQjGN9yrggr8/Mas064ER?=
 =?us-ascii?Q?2U+rJ1ABAKVW9VjF4Qz7EMTIQs7/7roroN1t6anQCE9nLoKFKNNDNAGxnVcI?=
 =?us-ascii?Q?JrIlp5MM13Z2uBfLbQQUWIQNehuWL7Jr5JA4tdYGr935LemE91i9VF/0RsDX?=
 =?us-ascii?Q?CE+CB6Oz6f7GBbcaUozfPZv4qjFcwwU4lLXcW5FgAba9z3kdbPT4KXSV2yFF?=
 =?us-ascii?Q?Q/5AV1+X5mi/j4jiZYI3LBpf4SxUOGB4mkuwZboL2wjo42hgnjflBfompbmk?=
 =?us-ascii?Q?8LSXadVvLJVWocJOuPV7SqFFBZni0fnHxDYnXNR66EHqr58t718Q5gqLTWGi?=
 =?us-ascii?Q?bamDpNibjLHdF//wyTRt8M+jRRNSuXOEw6dv1laKKYsms/nHK0ioxQD1n6zl?=
 =?us-ascii?Q?KJSSXIb8I/miOSigl1BGZ4N+sGE7itUNi+rM2isTykn92QJM3Pgrb23aNVaE?=
 =?us-ascii?Q?F+XiE4/0mDOIzJsHASy4c1bcgDNhsbQaH0qFLdTpwE2aot0fIdKvb85CgBj0?=
 =?us-ascii?Q?CaZchPbnl7jPKNj3GFfSpU+CtsX3yYVnUun30gGbciSudQaeJf28mzhqwNQQ?=
 =?us-ascii?Q?7mvgBEzbL0BbKpN5fud6qcbCyrJ1hbIhWTVSXWQ4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27680704-990d-4ed4-cd40-08dca609b308
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 02:39:37.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZ2u7SrILXjS38OiI5JY5nC276ktL9hJ4RkuEqp4T43DZ7uhVCnC1Q6GVH1YEqNnLjTT/2fuIh7tjq5jQ1xFyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7282

On Sat, Jun 08, 2024 at 05:16:31PM +0300, Laurent Pinchart wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the chip by modelling it as an MFD device, with two
> child devices for the GPIO and PWM functions.
> 
> The driver is derived from an initial implementation from NXP, available
> in commit 8059835bee19 ("MLK-25917-1 mfd: adp5585: add ADI adp5585 core
> support") in their BSP kernel tree. It has been extensively rewritten.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Laurent:
	Just saw you already sent out adp5585 patches. Do you plan to
continue work on this? If you are busy, I can help follow up this.

Frank

> ---
> Changes since v2:
> 
> - Add missing and remove extraneous headers
> - Use i2c_get_match_data()
> - Drop unneeded parentheses
> - Use GENMASK()
> - Drop of_match_ptr()
> - Allow compilation on !OF with COMPILE_TEST
> - Replace ADP5585_MAN_ID() macro with ADP5585_MAN_ID_MASK
> - Drop unneeded macro
> 
> Changes since v1:
> 
> - Add comment to explain BANK and BIT macros
> - Drop compatible strings from cells
> - White space fixes
> - Fix comparison to NULL
> 
> Changes compared to the NXP original version:
> 
> - Add MAINTAINERS entry
> - Fix compatible strings for child devices
> - Fix header guards
> - Use lowercase hex constants
> - White space fixes
> - Use module_i2c_driver()
> - Switch to regmap
> - Drop I2C device ID table
> - Drop ADP5585_REG_MASK
> - Support R5 GPIO pin
> - Drop dev field from adp5585_dev structure
> - Check device ID at probe time
> - Fix register field names
> - Update copyright
> - Update license to GPL-2.0-only
> - Implement suspend/resume
> ---
>  MAINTAINERS                 |   2 +
>  drivers/mfd/Kconfig         |  12 +++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/adp5585.c       | 199 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/adp5585.h | 126 +++++++++++++++++++++++
>  5 files changed, 340 insertions(+)
>  create mode 100644 drivers/mfd/adp5585.c
>  create mode 100644 include/linux/mfd/adp5585.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8ebdde3106d3..1250992f7788 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -532,6 +532,8 @@ L:	linux-gpio@vger.kernel.org
>  L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
> +F:	drivers/mfd/adp5585.c
> +F:	include/linux/mfd/adp5585.h
>  
>  ADP5588 QWERTY KEYPAD AND IO EXPANDER DRIVER (ADP5588/ADP5587)
>  M:	Michael Hennerich <michael.hennerich@analog.com>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 266b4f54af60..05e8e1f0b602 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -20,6 +20,18 @@ config MFD_CS5535
>  	  This is the core driver for CS5535/CS5536 MFD functions.  This is
>  	  necessary for using the board's GPIO and MFGPT functionality.
>  
> +config MFD_ADP5585
> +	tristate "Analog Devices ADP5585 MFD driver"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	depends on I2C
> +	depends on OF || COMPILE_TEST
> +	help
> +	  Say yes here to add support for the Analog Devices ADP5585 GPIO
> +	  expander, PWM and keypad controller. This includes the I2C driver and
> +	  the core APIs _only_, you have to select individual components like
> +	  the GPIO and PWM functions under the corresponding menus.
> +
>  config MFD_ALTERA_A10SR
>  	bool "Altera Arria10 DevKit System Resource chip"
>  	depends on ARCH_INTEL_SOCFPGA && SPI_MASTER=y && OF
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index c66f07edcd0e..37f36a019a68 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -188,6 +188,7 @@ obj-$(CONFIG_MFD_DB8500_PRCMU)	+= db8500-prcmu.o
>  obj-$(CONFIG_AB8500_CORE)	+= ab8500-core.o ab8500-sysctrl.o
>  obj-$(CONFIG_MFD_TIMBERDALE)    += timberdale.o
>  obj-$(CONFIG_PMIC_ADP5520)	+= adp5520.o
> +obj-$(CONFIG_MFD_ADP5585)	+= adp5585.o
>  obj-$(CONFIG_MFD_KEMPLD)	+= kempld-core.o
>  obj-$(CONFIG_MFD_INTEL_QUARK_I2C_GPIO)	+= intel_quark_i2c_gpio.o
>  obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> new file mode 100644
> index 000000000000..5268229eed18
> --- /dev/null
> +++ b/drivers/mfd/adp5585.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices ADP5585 I/O expander, PWM controller and keypad controller
> + *
> + * Copyright 2022 NXP
> + * Copyright 2024 Ideas on Board Oy
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/adp5585.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +static const struct mfd_cell adp5585_devs[] = {
> +	{ .name = "adp5585-gpio", },
> +	{ .name = "adp5585-pwm", },
> +};
> +
> +static const struct regmap_range adp5585_volatile_ranges[] = {
> +	regmap_reg_range(ADP5585_ID, ADP5585_GPI_STATUS_B),
> +};
> +
> +static const struct regmap_access_table adp5585_volatile_regs = {
> +	.yes_ranges = adp5585_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(adp5585_volatile_ranges),
> +};
> +
> +static const u8 adp5585_regmap_defaults_00[ADP5585_MAX_REG + 1] = {
> +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> +};
> +
> +static const u8 adp5585_regmap_defaults_02[ADP5585_MAX_REG + 1] = {
> +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc3,
> +	/* 0x18 */ 0x03, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> +};
> +
> +static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
> +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55,
> +	/* 0x18 */ 0x05, 0x55, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> +};
> +
> +enum adp5585_regmap_type {
> +	ADP5585_REGMAP_00,
> +	ADP5585_REGMAP_02,
> +	ADP5585_REGMAP_04,
> +};
> +
> +static const struct regmap_config adp5585_regmap_configs[] = {
> +	[ADP5585_REGMAP_00] = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = ADP5585_MAX_REG,
> +		.volatile_table = &adp5585_volatile_regs,
> +		.cache_type = REGCACHE_MAPLE,
> +		.reg_defaults_raw = adp5585_regmap_defaults_00,
> +		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_00),
> +	},
> +	[ADP5585_REGMAP_02] = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = ADP5585_MAX_REG,
> +		.volatile_table = &adp5585_volatile_regs,
> +		.cache_type = REGCACHE_MAPLE,
> +		.reg_defaults_raw = adp5585_regmap_defaults_02,
> +		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_02),
> +	},
> +	[ADP5585_REGMAP_04] = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = ADP5585_MAX_REG,
> +		.volatile_table = &adp5585_volatile_regs,
> +		.cache_type = REGCACHE_MAPLE,
> +		.reg_defaults_raw = adp5585_regmap_defaults_04,
> +		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_04),
> +	},
> +};
> +
> +static int adp5585_i2c_probe(struct i2c_client *i2c)
> +{
> +	const struct regmap_config *regmap_config;
> +	struct adp5585_dev *adp5585;
> +	unsigned int id;
> +	int ret;
> +
> +	adp5585 = devm_kzalloc(&i2c->dev, sizeof(struct adp5585_dev),
> +			       GFP_KERNEL);
> +	if (!adp5585)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, adp5585);
> +
> +	regmap_config = i2c_get_match_data(i2c);
> +	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
> +	if (IS_ERR(adp5585->regmap))
> +		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> +				     "Failed to initialize register map\n");
> +
> +	/* Verify the device ID. */
> +	ret = regmap_read(adp5585->regmap, ADP5585_ID, &id);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret,
> +				     "Failed to read device ID\n");
> +
> +	if ((id & ADP5585_MAN_ID_MASK) != ADP5585_MAN_ID_VALUE)
> +		return dev_err_probe(&i2c->dev, -ENODEV,
> +				     "Invalid device ID 0x%02x\n", id);
> +
> +	dev_dbg(&i2c->dev, "device ID 0x%02x\n", id);
> +
> +	/* Add MFD devices. */
> +	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> +				   adp5585_devs, ARRAY_SIZE(adp5585_devs),
> +				   NULL, 0, NULL);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret,
> +				     "Failed to add MFD devices\n");
> +
> +	return 0;
> +}
> +
> +static int adp5585_suspend(struct device *dev)
> +{
> +	struct adp5585_dev *adp5585 = dev_get_drvdata(dev);
> +
> +	regcache_cache_only(adp5585->regmap, true);
> +
> +	return 0;
> +}
> +
> +static int adp5585_resume(struct device *dev)
> +{
> +	struct adp5585_dev *adp5585 = dev_get_drvdata(dev);
> +
> +	regcache_cache_only(adp5585->regmap, false);
> +	regcache_mark_dirty(adp5585->regmap);
> +
> +	return regcache_sync(adp5585->regmap);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend, adp5585_resume);
> +
> +static const struct of_device_id adp5585_of_match[] = {
> +	{
> +		.compatible = "adi,adp5585-00",
> +		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
> +	}, {
> +		.compatible = "adi,adp5585-01",
> +		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
> +	}, {
> +		.compatible = "adi,adp5585-02",
> +		.data = &adp5585_regmap_configs[ADP5585_REGMAP_02],
> +	}, {
> +		.compatible = "adi,adp5585-03",
> +		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
> +	}, {
> +		.compatible = "adi,adp5585-04",
> +		.data = &adp5585_regmap_configs[ADP5585_REGMAP_04],
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, adp5585_of_match);
> +
> +static struct i2c_driver adp5585_i2c_driver = {
> +	.driver = {
> +		.name = "adp5585",
> +		.of_match_table = adp5585_of_match,
> +		.pm = pm_sleep_ptr(&adp5585_pm),
> +	},
> +	.probe = adp5585_i2c_probe,
> +};
> +module_i2c_driver(adp5585_i2c_driver);
> +
> +MODULE_DESCRIPTION("ADP5585 core driver");
> +MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> new file mode 100644
> index 000000000000..92d90218762e
> --- /dev/null
> +++ b/include/linux/mfd/adp5585.h
> @@ -0,0 +1,126 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Analog Devices ADP5585 I/O expander, PWM controller and keypad controller
> + *
> + * Copyright 2022 NXP
> + * Copyright 2024 Ideas on Board Oy
> + */
> +
> +#ifndef __LINUX_MFD_ADP5585_H_
> +#define __LINUX_MFD_ADP5585_H_
> +
> +#include <linux/bits.h>
> +
> +#define ADP5585_ID			0x00
> +#define		ADP5585_MAN_ID_VALUE		0x20
> +#define		ADP5585_MAN_ID_MASK		GENMASK(7, 4)
> +#define ADP5585_INT_STATUS		0x01
> +#define ADP5585_STATUS			0x02
> +#define ADP5585_FIFO_1			0x03
> +#define ADP5585_FIFO_2			0x04
> +#define ADP5585_FIFO_3			0x05
> +#define ADP5585_FIFO_4			0x06
> +#define ADP5585_FIFO_5			0x07
> +#define ADP5585_FIFO_6			0x08
> +#define ADP5585_FIFO_7			0x09
> +#define ADP5585_FIFO_8			0x0a
> +#define ADP5585_FIFO_9			0x0b
> +#define ADP5585_FIFO_10			0x0c
> +#define ADP5585_FIFO_11			0x0d
> +#define ADP5585_FIFO_12			0x0e
> +#define ADP5585_FIFO_13			0x0f
> +#define ADP5585_FIFO_14			0x10
> +#define ADP5585_FIFO_15			0x11
> +#define ADP5585_FIFO_16			0x12
> +#define ADP5585_GPI_INT_STAT_A		0x13
> +#define ADP5585_GPI_INT_STAT_B		0x14
> +#define ADP5585_GPI_STATUS_A		0x15
> +#define ADP5585_GPI_STATUS_B		0x16
> +#define ADP5585_RPULL_CONFIG_A		0x17
> +#define ADP5585_RPULL_CONFIG_B		0x18
> +#define ADP5585_RPULL_CONFIG_C		0x19
> +#define ADP5585_RPULL_CONFIG_D		0x1a
> +#define		ADP5585_Rx_PULL_CFG_PU_300K	0
> +#define		ADP5585_Rx_PULL_CFG_PD_300K	1
> +#define		ADP5585_Rx_PULL_CFG_PU_100K	2
> +#define		ADP5585_Rx_PULL_CFG_DISABLE	3
> +#define		ADP5585_Rx_PULL_CFG_MASK	3
> +#define ADP5585_GPI_INT_LEVEL_A		0x1b
> +#define ADP5585_GPI_INT_LEVEL_B		0x1c
> +#define ADP5585_GPI_EVENT_EN_A		0x1d
> +#define ADP5585_GPI_EVENT_EN_B		0x1e
> +#define ADP5585_GPI_INTERRUPT_EN_A	0x1f
> +#define ADP5585_GPI_INTERRUPT_EN_B	0x20
> +#define ADP5585_DEBOUNCE_DIS_A		0x21
> +#define ADP5585_DEBOUNCE_DIS_B		0x22
> +#define ADP5585_GPO_DATA_OUT_A		0x23
> +#define ADP5585_GPO_DATA_OUT_B		0x24
> +#define ADP5585_GPO_OUT_MODE_A		0x25
> +#define ADP5585_GPO_OUT_MODE_B		0x26
> +#define ADP5585_GPIO_DIRECTION_A	0x27
> +#define ADP5585_GPIO_DIRECTION_B	0x28
> +#define ADP5585_RESET1_EVENT_A		0x29
> +#define ADP5585_RESET1_EVENT_B		0x2a
> +#define ADP5585_RESET1_EVENT_C		0x2b
> +#define ADP5585_RESET2_EVENT_A		0x2c
> +#define ADP5585_RESET2_EVENT_B		0x2d
> +#define ADP5585_RESET_CFG		0x2e
> +#define ADP5585_PWM_OFFT_LOW		0x2f
> +#define ADP5585_PWM_OFFT_HIGH		0x30
> +#define ADP5585_PWM_ONT_LOW		0x31
> +#define ADP5585_PWM_ONT_HIGH		0x32
> +#define ADP5585_PWM_CFG			0x33
> +#define		ADP5585_PWM_IN_AND		BIT(2)
> +#define		ADP5585_PWM_MODE		BIT(1)
> +#define		ADP5585_PWM_EN			BIT(0)
> +#define ADP5585_LOGIC_CFG		0x34
> +#define ADP5585_LOGIC_FF_CFG		0x35
> +#define ADP5585_LOGIC_INT_EVENT_EN	0x36
> +#define ADP5585_POLL_PTIME_CFG		0x37
> +#define ADP5585_PIN_CONFIG_A		0x38
> +#define ADP5585_PIN_CONFIG_B		0x39
> +#define ADP5585_PIN_CONFIG_C		0x3a
> +#define		ADP5585_PULL_SELECT		BIT(7)
> +#define		ADP5585_C4_EXTEND_CFG_GPIO11	(0U << 6)
> +#define		ADP5585_C4_EXTEND_CFG_RESET2	(1U << 6)
> +#define		ADP5585_C4_EXTEND_CFG_MASK	GENMASK(6, 6)
> +#define		ADP5585_R4_EXTEND_CFG_GPIO5	(0U << 5)
> +#define		ADP5585_R4_EXTEND_CFG_RESET1	(1U << 5)
> +#define		ADP5585_R4_EXTEND_CFG_MASK	GENMASK(5, 5)
> +#define		ADP5585_R3_EXTEND_CFG_GPIO4	(0U << 2)
> +#define		ADP5585_R3_EXTEND_CFG_LC	(1U << 2)
> +#define		ADP5585_R3_EXTEND_CFG_PWM_OUT	(2U << 2)
> +#define		ADP5585_R3_EXTEND_CFG_MASK	GENMASK(3, 2)
> +#define		ADP5585_R0_EXTEND_CFG_GPIO1	(0U << 0)
> +#define		ADP5585_R0_EXTEND_CFG_LY	(1U << 0)
> +#define		ADP5585_R0_EXTEND_CFG_MASK	GENMASK(0, 0)
> +#define ADP5585_GENERAL_CFG		0x3b
> +#define		ADP5585_OSC_EN			BIT(7)
> +#define		ADP5585_OSC_FREQ_50KHZ		(0U << 5)
> +#define		ADP5585_OSC_FREQ_100KHZ		(1U << 5)
> +#define		ADP5585_OSC_FREQ_200KHZ		(2U << 5)
> +#define		ADP5585_OSC_FREQ_500KHZ		(3U << 5)
> +#define		ADP5585_OSC_FREQ_MASK		(3U << 5)
> +#define		ADP5585_INT_CFG			BIT(1)
> +#define		ADP5585_RST_CFG			BIT(0)
> +#define ADP5585_INT_EN			0x3c
> +
> +#define ADP5585_MAX_REG			ADP5585_INT_EN
> +
> +/*
> + * Bank 0 covers pins "GPIO 1/R0" to "GPIO 6/R5", numbered 0 to 5 by the
> + * driver, and bank 1 covers pins "GPIO 7/C0" to "GPIO 11/C4", numbered 6 to
> + * 10. Some variants of the ADP5585 don't support "GPIO 6/R5". As the driver
> + * uses identical GPIO numbering for all variants to avoid confusion, GPIO 5 is
> + * marked as reserved in the device tree for variants that don't support it.
> + */
> +#define ADP5585_BANK(n)			((n) >= 6 ? 1 : 0)
> +#define ADP5585_BIT(n)			((n) >= 6 ? BIT((n) - 6) : BIT(n))
> +
> +struct regmap;
> +
> +struct adp5585_dev {
> +	struct regmap *regmap;
> +};
> +
> +#endif
> -- 
> Regards,
> 
> Laurent Pinchart
> 

