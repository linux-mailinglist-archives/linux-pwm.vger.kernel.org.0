Return-Path: <linux-pwm+bounces-2864-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8EB937D7A
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 23:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2E91F21F1D
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 21:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F4E147C6E;
	Fri, 19 Jul 2024 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AXLu5z8F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E91B86FD;
	Fri, 19 Jul 2024 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721424728; cv=fail; b=SZ9eN0QMYu62gyIjP3AUG0FLq82bvZHOXGSW/iLH2XOj/AaB5cM107h3+DXtCdN5hqj4bGod/3p1sVuhANNJBjhY6hcIJ+EntS9cFrdf5nWPYHyQcvOaqJwp22PKmq+9vQkfiHDbLKKfWuHtx8NX+Gw95eXjL/KstlYZfH3PJ+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721424728; c=relaxed/simple;
	bh=xv9UbFloAHWTwsB9CumNUFZmos2rbVdzaofjicihc7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FjAWjm3OnF/eA4hvMfHGCdV3Zt8Ks5tCSsTOIW/rvwnlD3D9PJ5ZTkChyo3oPZm9BFimD6VWwAde4usyc8Uv4fQXYMYqOvvK8spfGJpkZYCrXoH5lY+mH5/fuXSYAI241+4p4K/Scv3PkGwDTvtg2CpqzdiDkVXojFkDxv4vgS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AXLu5z8F; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRBIk8iD4n2VNUBMkuOfVR9Wb1RW3w5ViJXFV1VYhOOY6uRIFiwN2iuacwO0j2PGEmBRz/UvHCOT+cNYx93roy+1IMyJVB9BHb/6Z4qGhc6iO9Xt8H262MsI1MxDi+Fkd2w8gKfibV/75TKS9kidslIfysRctThIrp+Lg3zj4reAoqNPVP7vCneZrOUdyWw6KXgVilI+o0Vdc/ZVEsWmHjmGAfhLPMA+Rd+/r8uFnx8TzxZEapfsIsLJW3VtmSwS0S/clqyzz+t//PdVlHrOL9H5KNgpYllEJQfe0HrPwb6HaZixU005IDRdaTStbEzbojXu7CKGWJQVPPb8VrOJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mydWkTTUmIsBpT57h5sEEu+gv9vmAh5tK3Ou2b/Zr7c=;
 b=HKVX1jwkqHHQC8NoAkzSYWGipgcyVtE6VImcmrAhM0SHfzTS5ytzMYSsPMVEwXx9AiVtktiBXdz4w55VvhTwD7Ih1hkYb4ld0VoucC9EHlNcf8MKd/V3GPoU0+/Ho+98GKw8T/fXqFNSz1dKRVJ18JqLFJaFLhBIvt2+O0n4BO+r6Da/PuRQA+y3RgXvD7TDF4G7h9nUePmbGid3++wXa6uqrXSIRNZbS0gDBeg4D4Qya0vgy9QB3/zJKKuDPUpRL/yiLABNqIWm/i45pWaK0uhZWE8Tn7iRObdpJpm0XXyeBojfwAWadUFmSs4iwXVsrY6XAkOErGx93qMQgGYA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mydWkTTUmIsBpT57h5sEEu+gv9vmAh5tK3Ou2b/Zr7c=;
 b=AXLu5z8F+WnYwSsqlSiJMP04RQZMFLP0g2bp/VpTXIwHDcjnjwsBZsUCtGSwPn0ctBmWCp4J13Ugx+XE7eZ9vMjCM3xWuxNLovadsTIIzCIRJUTCRqBoQiRZY9EVd0KbDv1xaAutzPumMOXIfA1T71Lp8ka2tZAlbnI3up1neRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10703.eurprd04.prod.outlook.com (2603:10a6:150:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 21:32:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 21:32:01 +0000
Date: Fri, 19 Jul 2024 17:31:53 -0400
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
Subject: Re: [PATCH v5 2/4] mfd: adp5585: Add Analog Devices ADP5585 core
 support
Message-ID: <ZprbST2aJUXN5Lx1@lizhi-Precision-Tower-5810>
References: <20240719203946.22909-1-laurent.pinchart@ideasonboard.com>
 <20240719203946.22909-3-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719203946.22909-3-laurent.pinchart@ideasonboard.com>
X-ClientProxiedBy: BY5PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10703:EE_
X-MS-Office365-Filtering-Correlation-Id: ca11c527-d193-46bb-fd41-08dca83a3a12
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Fxqh3tLRetxSB7ZrIzsiqz0FmlqzLsl3Kd7moXwU881QK0+V/5QlA41HgCut?=
 =?us-ascii?Q?lsBFSEFv1rcqtOlSlrlPWEDN5ACMGhmJpJPgDcOEN/Bs1Ju0Te0YVv/ZlHGT?=
 =?us-ascii?Q?HU3Ft3UgcRYOBIwC5whaqHa1MtSWCOn6hQqKPQFJuFNJphqBFIZ9+Vfd7gjK?=
 =?us-ascii?Q?7MlnHhTiazxjM6VCoi6MJLH02fXhiK44GiGNJdhWNF6/8jQvqiW4z2Rw1Qir?=
 =?us-ascii?Q?okxjFGOqqMz/C4HBVJkyn5CB5QbC3rg+QdTfHJQyJRY9b7Wx8k03dEvwi2z9?=
 =?us-ascii?Q?+DXQf0epguUG+e1Ty75gXQXNLnZXLq3bn1s6iK5d2eDiFj7Ra0xZDRbfj74P?=
 =?us-ascii?Q?i+6euLJUIhssSWgWSxyMhWtf2ZjcRLIotiPNJURf2j72pfmvEgo+QL/g6As4?=
 =?us-ascii?Q?VBnk3t80e/REvOzICJGl8F3mqxUe6aGRg1HX4UvUph8MyHFetOsQV+sKlrym?=
 =?us-ascii?Q?oTtMb8bLZy4Tow5AYK158mp6W9wR9VhFIRwgi9Yc1Py0hT21rF2Ipd59ipEy?=
 =?us-ascii?Q?+7ctyOOTYy+qWbuWvKWcwkE+iQTfbjfW0475LImA+y4ooR2syMlXEKbt9Qz5?=
 =?us-ascii?Q?6SlbCjexIuaEeQ9HkVCIOXM3uXLtQqLIJR9goX3ojd6Wz382WNgpiCzRDoUc?=
 =?us-ascii?Q?DkJ2eNexT+3hp5iR527gsIrmKLr3P/J+pB6U+UM5Gw3njaPMCDguG7u1FYnu?=
 =?us-ascii?Q?5GN1ZKCsg4AFi8bNm66qn5lHploZbh3FstCxqmr4NiacOZ5MRiXEjZGmXb6Y?=
 =?us-ascii?Q?hEb5B8nEPcevt79itgyRHirKAB4RBtobdV9y7LqBXiFWyuaVLs9jemNU18DV?=
 =?us-ascii?Q?nwCz/y9gWXfF8UCm6XHiTxGd32WES7nJqjox3PjABtBn74ZyFC/n/POoVWCR?=
 =?us-ascii?Q?LWyy72SORUem79YJ2kV8A9g0J7ELdbaG0rOb12JvVwwVUUAewR695GyjWdWk?=
 =?us-ascii?Q?KWhtBdPYhRTSSx+VMdDeFkEVDpTMcq1X2D89gizUQOy7ooOgAGeeumOXQk5h?=
 =?us-ascii?Q?wxCzIBxc8O4xPiHNLvduVAZZ50nos6TzdHPNtS6s/g8uSU/EsyNLxp+Cmgwi?=
 =?us-ascii?Q?/VLakVm2L3K31D+o/15mkaj8tX1quivNjhtK7i32EbV/aonJgigMIPVKgsQb?=
 =?us-ascii?Q?NY1oHZ+qdUbMA076bea02vzqEMFaPWJJ9GusR8YgIZSg2g5iQwucgxOiIdcq?=
 =?us-ascii?Q?ES7CX/tgsf1P1lOYPGBz6M5kUamxgdL2u+1YqNdPd5+aB75EyS75q32M8aJ0?=
 =?us-ascii?Q?CLgwl/SQQ8Nl/jfje8dVfINNjLvAQJinRmK+phEkpfFcOSXLmnB2GdSMDlJ+?=
 =?us-ascii?Q?FlgpIqTtgFmRh2uj14plkXTle0W+UCP4lZK+LPJruuMh2qhP6x62iNjT8Nve?=
 =?us-ascii?Q?8Sfa4z6ZTvnS3yCUolvKXRVzLe0AsAabCxjzPgafX2TIFL2H9w=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?NFUTS9cWYESCZSb+oudl1QKlf8lei2kdteOk6d+2ZtBkMpHVOU+S1IeK191x?=
 =?us-ascii?Q?Z6D+/AuBlhwgiSz1lNF1k4NmJh8wKGYOCDJkIyJARvku2WZxc1LoEFTo9ERL?=
 =?us-ascii?Q?Y9WvtvhAsqgnWn4TWZEEZyRBUygnFPzqFVz+VXfUxrzy9DQFBAyavtmj/lP/?=
 =?us-ascii?Q?DcjKH1/i5MG+bBSE/JgBlJ++mg3b6d93eBSZiknHHvnkBSMRPGmvr7G194r+?=
 =?us-ascii?Q?b1R58EeDDJaS4EqatX9E0sDbgtd1ybubOwGZf8TUCLPG9M32FqtH4tgvO9nE?=
 =?us-ascii?Q?+HuEaVsEAOlbVsndQbl4T4ybkln6NYMolUa6z7sAFC98W290viz9Rv1mhmP+?=
 =?us-ascii?Q?al5RoBKoTrqVQJyXRjYdSvESN22Umv1X0wzIuOzimPj+wHTxE+uk4IGSl06J?=
 =?us-ascii?Q?KXxgWC3Otl34GF0UmGD7An3kMvi9+QDNqOv+VHjsGhjxJ5PElMYgwvBMTOkR?=
 =?us-ascii?Q?Wi9FxmHtvLXfOuXtFQIRIbNgNbz3kh9PSlRFpkP6Vqr0IywRlz5M6Um3maAb?=
 =?us-ascii?Q?aJEyO/BuZpPPQfoKE30SzcZc7rpocLp877sJgHSGvHOzY5cdc7oGvDBNwY8J?=
 =?us-ascii?Q?NJCpOM8C7IAfoCTksh35ezqANFcIFoLYBhx5zAdtMIvhOHMiKwkTHK2m8BZy?=
 =?us-ascii?Q?VngTyDFvPfyGZHCkfp48zUrLO4N/E2JqKbeY1G/3WKqoYjE+63Jqp9DxANYV?=
 =?us-ascii?Q?7f9nVY1PNT3trEkpdChD3+LXYrbNyHQ298XgZ1sMSzO1ujWuYZMzXRJrB4Nf?=
 =?us-ascii?Q?cIJ0UtKEzDiu6s4L4OL9qk9TE49ZQdr87yobAFnq9BaTJJ8uSrfsxxtc8P1v?=
 =?us-ascii?Q?sY/MtqinFyVgQ9Ntb/u0IEInwOVc4flOQdMCbHBCq7IfsAhjmjIXyf0wJ3A5?=
 =?us-ascii?Q?NfyshYUCOgbCW0MHyAeV8185gtNcEzziPRUu3WU6DU4UevMqY7v95Q3INULo?=
 =?us-ascii?Q?LNva/W5X27hZeMtnNXIzOy5K9brs0Cp1dyyoQm0548GvbJAQRESItffttucx?=
 =?us-ascii?Q?mr+9egFnQoI1ZLfet3Zhn5sM9MTN/Vm6xo5cYq9A1K1b7PCZQphHs2qiypCU?=
 =?us-ascii?Q?PYSgizyCfSxGKfo9oRVcKQv18xvatJP51RkTq4I1FmlAsVxqRi3EpGMLqwa3?=
 =?us-ascii?Q?/fOY5Nj5n18BtAF8ywzcTukwwAhTwc9Fe9xcat76jVQwlDhPBArzM6QN/cpW?=
 =?us-ascii?Q?uWNKWhWH33DZ7wT6WIcU1gZNk2jVc+xH1nlTFScykwQrcy00FlRgYGgNa4nv?=
 =?us-ascii?Q?3+L28740mn5iPdM45iJvZwYgR2JRE6mwKrmf/gTuBBlaSvRImnwi96vizwvQ?=
 =?us-ascii?Q?sOnAHDsM7mGPcKRHsLCL4CnLp4Wz0bw6cs3koO6VkWD0b/nlDlsRCoHtNKPW?=
 =?us-ascii?Q?tg4srDC54vEh2bebDOSiaTg9+fWxLu5QTDQHTlJGDethdzIkSwTMQBnNyAVJ?=
 =?us-ascii?Q?gSaqh+fRlu+iCT6puDM1CiJtogCj3WNhavFqQjMJXt+13cXvVlxwk6emtmiG?=
 =?us-ascii?Q?iKbJ3d64Rq07CUu/HpPf1qQTLdGpMrIB7EkMc3M5vSSOUaZ3fNVi+/LABSSX?=
 =?us-ascii?Q?WE7pXBv4wCD/Y+bq6qX2rTpcVlwBZj9jrdbcN+XD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca11c527-d193-46bb-fd41-08dca83a3a12
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 21:32:01.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qcuv1VWUIMS5fjHdqZC54orV1WsakUjTUvUv6JuHjrGT3tTuN5Qu0CjFVpK6vyRqLk6Rvg9STa2cbG0h+gXg6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10703

On Fri, Jul 19, 2024 at 11:39:44PM +0300, Laurent Pinchart wrote:
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
> ---
> Changes since v4:
> 
> - One more GENMASK() usage
> - Include err.h
> 
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
>  drivers/mfd/adp5585.c       | 200 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/adp5585.h | 126 +++++++++++++++++++++++
>  5 files changed, 341 insertions(+)
>  create mode 100644 drivers/mfd/adp5585.c
>  create mode 100644 include/linux/mfd/adp5585.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4fe8bd8752a5..ebb1a1833bbc 100644
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
> index 000000000000..5dc3e47a0533
> --- /dev/null
> +++ b/drivers/mfd/adp5585.c
> @@ -0,0 +1,200 @@
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
> +#include <linux/err.h>
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
> index 000000000000..25025b381c63
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

Is it better

#define ADP5585_OSC_FREQ_500KHZ  FIELD_PREP(ADP5585_OSC_FREQ_MASK, 3)


> +#define		ADP5585_OSC_FREQ_MASK		GENMASK(6, 5)
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

