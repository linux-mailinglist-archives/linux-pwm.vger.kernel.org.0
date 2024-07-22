Return-Path: <linux-pwm+bounces-2899-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECD5939215
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 17:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20121C20D6F
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9464B16DEDC;
	Mon, 22 Jul 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q9AQGUGv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88421E891;
	Mon, 22 Jul 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663477; cv=fail; b=mBYfnCvrzzW3pasNO7EXA9qGDPJYpwKi4C4z9hgL5qjTm+FcpOcuAZZ63hGjIfEh2OOq7QFOszcERSRWJyWx/jCLSy0AtiwQDIm2rNKzZONYr5oocgcpnrLrHYfihInnvhx0KjMJ8WX5ZR9/QLDzlQefqWmf4DX6h+h2uZFHrWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663477; c=relaxed/simple;
	bh=AD4Rym+zMmn9FSYowPbLrdSl+TO7jvDjPm3GWl8XSeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h8SOtKz44h/av1reV09+FUBDhxdrp6PnAm51X9E2Xu3zJ/K0prqJsU1nfot09wGkUVzQrCULIPJk/mHmv++fpxzxlOF7nTb+ux0Uk4tPj60OwxaPS141qi10g5Onc1pbwcuJGV7Pmco3kZ+QDtOXjtkn8qKTlyMORHHvX8Vlagg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=q9AQGUGv; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIkEUbA02kCh6ugqbbhmHNqW8WYDSHRJTUDODeTtvX5yxzw7VBv/5F+xvYg2iJ0Fz6gHgf8qN8nn6UuacFcrjpej/eOSksBdIWQn7KZ6ZSDBiXC+6SRlJmLqoAb6uv9UAE9nDM9V1KJNU8t/pi4KCjIAiHw/eAEW6u36aSySBB9YKmmNwwQKk9C5Wz13sr405Elrk4nhkAucbbVMn7/0o9VdVjOeMKwY9YyelBYu6SQEbZwPBVORj8Act9s8EK3upLhvKBqvCJKyBiwPPL0paBjWiwDU8PTjWqvHt56HBedSzm4WWiepSe0Qs/+Bi3URiT8EouYCOIWA/sLr202Vfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJFDZQ1MlHBEMsEXO4SVRNep0A7Gy/yIGyp8Ixxw8HM=;
 b=IiIILdK8zixO38EfgJEYE3JHvseDS3pIT/c4ilp+mAPrG6XXXvhSGc6K036SANl8RWdKid8j4C1qYdMAy6aR3x9EG0b8ZtZ7u1w+ygY1Ax8FXzgAUElIdVSQJFom79M0mO+4V9jz9d7c8Y3o+9mmNB77GYVI8BRH4QVHB3FJssbAtlQ9qIwgFy/sq1FYtndSq1TgRCYyeisTNLt/N+Y2fIZREM7OzZoCCv1nOf9P+YZ+a054EWQ32kE53D14iOHIzhLIAWgv+WfoMNqLAy92Q3K1OI2/M3NmXca9RJC+cutukOOfSvw9bn3hstfsYLTpFFiLZsGI/36lim6kXqnXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJFDZQ1MlHBEMsEXO4SVRNep0A7Gy/yIGyp8Ixxw8HM=;
 b=q9AQGUGvk6jfBVjKzZwtoWimFJD38DqhBox789fTZCB97QMtHKKPxx/IMJf6aDc0Hh/6F597FnlVoE8L2xzLLIRJf1IgPdGTphmxZFQb41dwfdCgxQxbS1HaOOW8WvJIcZ2lgCebeAyFvdaapUIVpwqeYCZBfMltLnfl4ihJOck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7154.eurprd04.prod.outlook.com (2603:10a6:208:19f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 15:51:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 15:51:08 +0000
Date: Mon, 22 Jul 2024 11:50:59 -0400
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
Subject: Re: [PATCH v7 3/4] gpio: adp5585: Add Analog Devices ADP5585 support
Message-ID: <Zp5/4zU3M34f5OIZ@lizhi-Precision-Tower-5810>
References: <20240722121100.2855-1-laurent.pinchart@ideasonboard.com>
 <20240722121100.2855-4-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722121100.2855-4-laurent.pinchart@ideasonboard.com>
X-ClientProxiedBy: SJ0PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:332::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b597d29-3d05-40df-f5e8-08dcaa661a28
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?07oOXpJqG0lEki7GsaKpQNbYzzyGjAJ7hw67ISPeWxw8VCeweH9AaPuy2wm8?=
 =?us-ascii?Q?dpn4ymHtWCS+/WqSiuBDmqAiSsJgXmKbZQlOEFtwazJepuLaKkq/Bie4IG7y?=
 =?us-ascii?Q?iPy9SDJBALOJwA0X1MicOShBTiPrficE727KpMk86iPbzeprvW8jtAEf64ax?=
 =?us-ascii?Q?sf9tjUe90tBF3UjCSXnLp67c2/Qfe7umXoZ5Puj/HCfpWeGlDm8Q2ME3RRsn?=
 =?us-ascii?Q?dzevpe+TsNI6qZ7Yupi0q2gCYqtA2GOD2Etzs0NwT+VmB+fKvD/wTPuNBsYB?=
 =?us-ascii?Q?nmFqQ2v47H4t/FZSm9J2OJNa5hSSzpR0i3BJ59/74CsU4Z2wY6Cc1lDouzyy?=
 =?us-ascii?Q?L9/SDFxHMxo/lROmiPiNCO4hbURvL2aZjIYdpEV6efMPvleHoTvgfmqIiv5q?=
 =?us-ascii?Q?LE7wqITuyHqezVSI1ZTd+JB12gWfjMeHGWtC4Qa5hmGvjMJoHbA5CBsl5EVI?=
 =?us-ascii?Q?AqOFyjPszEvtx8wIuFiyZCQbMdd+QLdsdo9aJsHr8blJ8PoX5FgAApS0kRyv?=
 =?us-ascii?Q?tsulX/xGMhPPBDm5P2eCfHacTNI+D+vViJKtiJcUmO/EWgX/oUsZYHus7IsN?=
 =?us-ascii?Q?/WNwD0dR81XfHCX8xTN8A2mmi2K5hRd4KThIE6/TcwzzoCIU4mYM/TmlYx1m?=
 =?us-ascii?Q?N7Qc2p/DXdqWLdAhb1jgqmswVS0LER+WGSLxC7RVOAJsSv7HtOYAhIatuBU3?=
 =?us-ascii?Q?r6Ec4a9mS+vRaCs2h8Sw8R1S6V1iirNYBY8RUkWgJR9dFn+wupCM3q0Y1KLE?=
 =?us-ascii?Q?3MAUKd/cRC4j4KgIyaKT1KEWPJhE7GWO9SKVhwbTgj6MdXTcPTCLAKaie/m/?=
 =?us-ascii?Q?JCIqW84MXa+zRu0we6W7i4UkGw11dysdLqNwnqH+FMxP+LKd2zQOWFhxL2pb?=
 =?us-ascii?Q?PNxFC2hFwrr/5PK910u8YLAsHp2POfi5oxg6qKVVt7KKzvj4CwKlxeqp7smv?=
 =?us-ascii?Q?N97tjgAYD45LRVTJ9JtKLLSjJG1cK5bjn+gJt+luaqLhX7NLHFozIgm1SGsD?=
 =?us-ascii?Q?NhXHoTDuGv0hgs8Rja0ujNhcZ10uEWa367/Xu0STh8+9LGXw4YhRho46/pJx?=
 =?us-ascii?Q?W4uI7nIg2gVrYiTStB1+hQhhNNjHBADFcitZc3sqtlgcKoEKn0S09GMZcR/o?=
 =?us-ascii?Q?TlQsGhjunLFztVBqcz2LopjvKyTMROUh7P+cktN1Fff3AgM0EpLPVHriau8H?=
 =?us-ascii?Q?69zBDoScEW+vmRe8SGYNKWDiiVztUHGuOe6+CNaMq6jIMxCnT3Twyw+5fS3l?=
 =?us-ascii?Q?oW40zBobaZipohg5JUTmvjG7iUOcW8vDCe9418S4sKmPmgygehQKGAIS9XM9?=
 =?us-ascii?Q?M9vHsdtwGkPdtU6Lloy5oEEKZNadb2kwBirG4o5FA3ckauk0Wcgz3n5tCYlj?=
 =?us-ascii?Q?ZlYwkZA+G2gEQkomgnYU8Eyz001wVAZHV7zwKveAxntT8Hrcdg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?SIE6mzWk9SKYRtYslALCswoRc12sOSCXMpZifsEFpKIAXthqiu/vENqc5EDc?=
 =?us-ascii?Q?KpnhNETx4VXY6fG0JsGzifC6CRBwcwVbt118rGtX7Yn9LawZ6rbH1bw65NI1?=
 =?us-ascii?Q?yrbAJ6IpL7Y6Zush6bqHzgk63JGpUWeWluZ2/Z/esg3W/oR27YtmUkYsZHQd?=
 =?us-ascii?Q?DJD7DnlN7vquBRTLqwRDZdgi8IouNXvWugND3xuFwU6fJ4XCojsd7AAcoBAc?=
 =?us-ascii?Q?L3SHzETkW+JOqTNKIjqZfa9C3PunlW1seeF5PKR4HcEKg8yRY5NaMsYHuVQ3?=
 =?us-ascii?Q?HGSkJVzk0WWylE5nuXn+1FTpGIzNVOMRuDw32vambbpZaLm8LQohpC2mf0nc?=
 =?us-ascii?Q?rGDky7O7sNHRd+04qphTVTg25tUmgPJxaL3BkDW8JwIjpseqmh605SpaCB99?=
 =?us-ascii?Q?Qx8GoqWcOFTgZuM242tr6B3mOFUY15w31kRMLiRVliOSm/Aov3O+BqFjvCWP?=
 =?us-ascii?Q?vHNHhqhiC0OHgUljQnhlwZxu3S8FGSm2e6qfj35obdxGVPGpT4Zw44NA850X?=
 =?us-ascii?Q?4LPt69sVBmlNf1opcvZ4TepFs9/2g4FZbppXzhyf+wgMqP6hNxMlxT+e61WS?=
 =?us-ascii?Q?rmP28FzzP2KWXcZDBJy0j2Drj1Ol1D+DSIfnoRet02KfsBeGYaR1MK367hfh?=
 =?us-ascii?Q?tu0EUxR3176qqlMwadfbW9ONkehyVZ1R0ggU7QqtdVyTjy0C4UPOcVaphNWk?=
 =?us-ascii?Q?dsZxcin1IGHbrxcFRYAfKVvcb3YOSPxdjeu6PsgR4KUjG/QMKdF20aj+r0iG?=
 =?us-ascii?Q?BZBVF6h/kA1ZRKF1G99awINu/J/CSgAfXpJBjC58du6/9/UaBoHv+3AC3IV1?=
 =?us-ascii?Q?1EHHLsfTPXTxHCNA7nxBPfaWFtfBrIrIDW2lP7C3jEtxG2ye0U77put4sa8r?=
 =?us-ascii?Q?NKN+qE0DkmyQzrkY7R7RmygGXLSFZQqfcaKJePo5fgc4G1sY1S+hedWeF0Nv?=
 =?us-ascii?Q?+8yIMr1lrkrtO9RdbRHTKzPXJ7QtbKdZM6e1kgoeAy1k2AlRtagpCaG/v2Dl?=
 =?us-ascii?Q?AYQRg2nnEK0WvoSH2BgMcRX0YJmpF5v8fRVVazClcFgudoFctuZEimab9IFQ?=
 =?us-ascii?Q?i8jD2ScEbQUX570s2NalHPdBCxioA7gf+k7F0tcy1W19xFwK9pHITDJsQj3R?=
 =?us-ascii?Q?GOJ5oSqCg9lmD+Xzm8BJx2ifXZgbzX8vU6K5TV/OD6aqDiIsdlrF0JJzs1zM?=
 =?us-ascii?Q?pbKlk7/vWEUivFXkhTTwQ5ezR61vC0ycJwEbX4/fKzfvZcC0qFnfytN3f8gF?=
 =?us-ascii?Q?DyDHNaVXxSEVcOGgNmpNosMNCdtW/1kaiz6oiHnPg1jnRKe0/wybufe2UoA2?=
 =?us-ascii?Q?hrqnbjvphrUx1ps0fFC6j9t7JJKwwSixtHYP1l93t5+ERhwUvFEIh7TgY3xO?=
 =?us-ascii?Q?//TVjR44zT7ipXeSs6fvgUsYNURf0WwDSvlK3gQNp9OSH0acyR2+mISZ1UZE?=
 =?us-ascii?Q?/u5CdjNvBvVSQpTWeZcj1GgljpXo5OTzq2dEJ6LLZw5bm0MOVDZ+VuO+G0kd?=
 =?us-ascii?Q?p1Vol9xHOH0IFaPJeiFCapZSIMew5JM03XuOCB49+b5g5NTns4feuhacsXdb?=
 =?us-ascii?Q?6tbSFG0qdKb8HQGjQ90=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b597d29-3d05-40df-f5e8-08dcaa661a28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:51:08.4716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8XrJ3qzySFDjuhH5ywK97iijE32eqY4uX2MQtZvEfGuHl8idqRfpkuxkCAtfSPN+MAu3OuFgKFTW48BjvBUYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7154

On Mon, Jul 22, 2024 at 03:10:59PM +0300, Laurent Pinchart wrote:
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
> Co-developed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes since v5:
> 
> - Use regmap_set_bits() and regmap_clear_bits()
> - Fix value argument to regmap_update_bits()
> - Drop comma after sentinel
> 
> Changes since v2:
> 
> - Add missing headers
> - Drop platform_set_drvdata()
> - Fix bit shift in bias configuration
> 
> Changes since v1:
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
>  drivers/gpio/gpio-adp5585.c | 229 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 238 insertions(+)
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
> index 000000000000..000d31f09671
> --- /dev/null
> +++ b/drivers/gpio/gpio-adp5585.c
> @@ -0,0 +1,229 @@
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
> +	return regmap_clear_bits(adp5585_gpio->regmap,
> +				 ADP5585_GPIO_DIRECTION_A + bank, bit);
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
> +	return regmap_set_bits(adp5585_gpio->regmap,
> +			       ADP5585_GPIO_DIRECTION_A + bank, bit);
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
> +				  drive == PIN_CONFIG_DRIVE_OPEN_DRAIN ? bit : 0);
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
> +				  debounce ? 0 : bit);
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
> +	{ /* Sentinel */ }
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

