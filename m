Return-Path: <linux-pwm+bounces-2900-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25208939218
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 17:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B9E280D81
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF116E884;
	Mon, 22 Jul 2024 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Olo50YWE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325D61E891;
	Mon, 22 Jul 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663530; cv=fail; b=ZFqszTUmLY+nD5NxKXaYgVOCRnYbrneT8yM5ACLdlwpZYpe8Qnrv8UxLZgmNIwvbjJ0mv82uAhjkp7UqDHIIGrFh+SSr9uiwVwAskOiU2zJPpFHqfB5DJlDH63ss7txRZwXjnDITVqfhnNyFlYXr+thPuNhWbwJY9YOSAl86DqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663530; c=relaxed/simple;
	bh=WszEJhV63f3AD2sbWDAsluKWz/+sZMg9VYXwNEDhhBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d4V7hutqYRgUN5EuJ4d4SvykN+u5t1IVUuxiqFy1NcqACsXHmX1uk6yAWV0ByeoZmEFqZiH+mfLDJDg3gIK9pd5iUi1YM2NHwQTvuZTyYjpJIpFD3DT4Y2fPWkDt3r/86Bi1XAxsrm0jWLGE/fux6/0DIdSt0yQldD7YL78MPpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Olo50YWE; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQnnz0TWIzZgoD4fiQUmJCacQm7QetzhrC/GhP9MtZafCcJV4oDv841TLwjhvy/WhJv/NZvalCgWZw8/lCr0kBcSrcct2WaUhp7Ibml1aeI9UHqZNusJcLLAcQNvg+J69Xya0OtanFJIeEKPNgsrqL/N055Mq0WJg4qLc88YB9yFfVTnS8/DF3B6H5ZZFXBdBN4rCBis/95eTBFZNlgHHn6qup8f+dYPgJRKEw5YlMCknI1iXiT7ZP7q7zwEshDTZl7aaDJPdU9qGdU6grxQj79rtcUdjesxikQXxr1yFDHXIs+SIaP8EcGKw/r14MPG2DIHlSWZBPIeupBGQcKqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUGddVlRfysX3hPx2wDGtEqDaYvOWTKkSdS0Um+Wn/I=;
 b=loQUThTNfMyBqIx7PqX8wrhsXaHbEN4J4TwR3o2kbAMcoERCAp13udbD4q2fgQWj/a79A4zFC4BHsb7qwEeJupmapDXpXXb0xFCOm47Xs6D7M9qjDpnot2yEn20/6QygqArmovX33p7qu/4EN4xuFfPSC+OTqD0y+MRuJxIL3YfWI1k2MvoNlZQI9CL+0oJZexJ94B/ZIlmU/mdnocmA3ZnnIM5EeCXr1tDDFKword+6hQMYVg5rhdx5vpYOXfTZ31oJs/6bgBDyMum4NZO/1gQE9hpJwnXyfX+jUYMOr0sSkYk7wh2Sbowk8dxRIMv5f9g9goq9ciK/5M9RtKFyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUGddVlRfysX3hPx2wDGtEqDaYvOWTKkSdS0Um+Wn/I=;
 b=Olo50YWE3tdMxEMGfW8mSs+/FM9UPEtBKfzUuK9+nLSf0H5EryFNmtoc4TW7IQbprSwcyrltcSJvjyFP8xEqcmKaY7Hao3/OlVO0oSLP6STg1+6uTRDbQQCspquIo6Bzaskz1MfIoXR2NKQFWwOAdpAH/euDjNxc/AkwtVIS6mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10480.eurprd04.prod.outlook.com (2603:10a6:150:1c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 15:52:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 15:52:04 +0000
Date: Mon, 22 Jul 2024 11:51:56 -0400
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
Subject: Re: [PATCH v7 2/4] mfd: adp5585: Add Analog Devices ADP5585 core
 support
Message-ID: <Zp6AHM6JE/R02e8J@lizhi-Precision-Tower-5810>
References: <20240722121100.2855-1-laurent.pinchart@ideasonboard.com>
 <20240722121100.2855-3-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722121100.2855-3-laurent.pinchart@ideasonboard.com>
X-ClientProxiedBy: BYAPR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:a03:54::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10480:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c24044-337f-4d6f-c6a4-08dcaa663bb6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?pE4WfQoWOvGCUZHqWb4S+1+aY02XhRwQ3hgSviQ3EHBlfoxUfLI9H49JJ9ak?=
 =?us-ascii?Q?4t1JqDazo0bUgU3tQAbo2Ewqk+qRxvdQ4/Z8RnBZL0/zCyPrZOiQ4KF4/9si?=
 =?us-ascii?Q?p6F8troDUgparg4G6DP7RR9B28fTcUKaS/GA+68YOEGMi2j9BJMdPavcU/8+?=
 =?us-ascii?Q?xUt/AYTrF65iFkzSjb32W/Fn4doBAvIncAyTSM/36wdschRGuucaboZd2Gsc?=
 =?us-ascii?Q?QvOfjVAZ6iuogsOMZYPxA3fAhPTdUSEHmrJ5R/+j81zAHCU8NYVcQSgQIp8A?=
 =?us-ascii?Q?7xNDbTmlqq/woWvKIkJP2V07iUat2Yy/fUUy3W9hkccWrYrZbXAZ8U51ZuXf?=
 =?us-ascii?Q?ywoa7esDguqanFGEzXo+zbctpWWU08vosdqEqLOVSyzOlGXS/PaHiamiLrzB?=
 =?us-ascii?Q?a7HLbzgWroPu8CZAt9dkF9mHA0mw0LUlgGbN9dh2QQlVv6SOo73g5S4Q3yy1?=
 =?us-ascii?Q?CX/02ayusORKalGmXLqh/cfFS3Z0BZMkERFGMngHA4hrZV6CuYZQ43Cu0tSK?=
 =?us-ascii?Q?YKimWDF6mQge+Y4uwMmik8Yv+3nDnZF2bhzhPlAhNxRBWBoauQkx+2TmpigA?=
 =?us-ascii?Q?W1qvJLEPoPbzxXSnKNHCpmJMxTGp/kKtRQSvHFqc3XoHvvEJ3V+9mCwyyvu2?=
 =?us-ascii?Q?vrL3nt9nh8o1OAyD7I6n3stKYBK9HKqear5vSettz2H3M9FGWPWGKgwrW6FP?=
 =?us-ascii?Q?h9kfbdOXWa+xB01Ge74Q9VoipuEX8LYepUpb6ppHkT+SdZNrQw+BTaQlsYe2?=
 =?us-ascii?Q?o8G+9VJGheUu+UyIN0SoOLUNYQkX9W8VExOQMz8mrItn+fISZa9Gx2bTMyG0?=
 =?us-ascii?Q?0mATgpxjDjaFguXtCxIqSWIGkBo5pinYXd/dEIoovYuRyWnsI/Zy5JBPKqgA?=
 =?us-ascii?Q?R0IbSDU3PWpfo3R5kMueyahH60xmzx52rUQo//t+ZSKW4iaMk87lJByVWVT6?=
 =?us-ascii?Q?Bt/wmIp7Omu6c8tT1FcHFwq/pUPSWrzhBBofDixSIMuUbU37Dv7iNPBgqWxd?=
 =?us-ascii?Q?uYh7nVLlf/OIYYXYqwqDsSwQ911gg5bC9Awq8iL0z3uvI5EVC3fFoU57+wQs?=
 =?us-ascii?Q?08HwjGPrBeLydHNn6hnmYqlYDXpEOsDsnEJxtLj+1r9jw0UBLDCXCuIw1vmU?=
 =?us-ascii?Q?l2HHNuGGbEga21r86BIfhq4fyEb6oKH8DkfOlTlVKCqSUbtANr8ViVpEKP6x?=
 =?us-ascii?Q?wusXlgFiSUzoHylHE94NWYmt2x4gdVSOSJwWxK49HmuzftpX4typCwPIiYBN?=
 =?us-ascii?Q?HmFIutRihtQOE3dXP/1t1Gdhvv3HrHCetvun4AE73qNyf65bitE0vq1KsFO7?=
 =?us-ascii?Q?7XTYjK/FI7ZI4753x8SMQLnooIRaMjLXw420V1xqv0hNEazC7AhMVVUbsR4A?=
 =?us-ascii?Q?JsQgN8GSQQaxP1rsthjKtraBnkjC+R4vmpDSlzlixuVRcggCDw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?RZ/BVjuOfGfY6YyBJ1KwC+rENI0fpJ8ZYWd0BrknvlKbAdvCtNwpbkWfAI6g?=
 =?us-ascii?Q?3Jp+0P/0N/v9TshA1+rZxTpGEpgBV6yrq+LX4VNMi58dxHiogDd+4gxtwqZS?=
 =?us-ascii?Q?+WAfiYtC6tt4qkdw9Khy1clnDQxBdqOfYRdIg04W5lYRVvFbw4EdowHaRNK9?=
 =?us-ascii?Q?nSUQQUka20O4QgtPlEUGPvymrkI/FneuLURpRK1SPyQ1KHcPujA4WE7CwB47?=
 =?us-ascii?Q?Ch+TB/VYRVmPdqY/P4GeXGTjNHkVoSjLbWVpeOpMM+FNPwNlHV09P+kH3m+Z?=
 =?us-ascii?Q?vUHZdK4eKZq2IugRnji/ozfbTBvegPBASqeWYC3MDAmp2wE4qJfsKaXb0B3h?=
 =?us-ascii?Q?bDMGk7TPRKpWN4I+hs0clhsltU6baK3qbxcHzhTsNfNuWH/GtAXGfX8hV/iT?=
 =?us-ascii?Q?xx2TXCWDfj6vYLWyjf4OQSgs9v5i89sKPofnmwGj8Esac92LF4uXUsSAUGtb?=
 =?us-ascii?Q?593eJMViO/SRQfZwXz4uM+APq57V3YPg2w9mCXBgmgPW2qod5w+c5ldZj/ek?=
 =?us-ascii?Q?H/VoHMIBEOCdYColEP9hqcOmQbSXf37FdKGpL8KemK0fGH07D4pTthTMOvV2?=
 =?us-ascii?Q?4hjHaO0ExWxRdx96hkwezf/qkkuaAMh4JlwoCBTBA7naXvu9OFHo7U30ynRM?=
 =?us-ascii?Q?ahWksJZiWLOwLejhRCHR0ooxz9YgWnFtrAEc2ngtwEXjCBtEV46byIAwTNy1?=
 =?us-ascii?Q?f6fQVVLS5V+MMKPkklJksGeqj5Qrd56w05vVvTgMUxku88fNGcFSYtoxlm9s?=
 =?us-ascii?Q?8sOTthr/YAQXEPWoj+dg/QbTzUrudmPWKe1tyGhDw9ecwZwql73DjV1Wnkiy?=
 =?us-ascii?Q?syC9JVcIrkX+Udo54FaZBxW1u4mkpficDFtyHlDZQyMrOtoytgypTi8hn6DD?=
 =?us-ascii?Q?Su+1P4dGBl4+xhF5GaRgGQNRD6JtoEKtHs6z3/HyaOUiU0IeE1qaVGANWoiF?=
 =?us-ascii?Q?A93kVIqo93S4KkzRbGX+Fr5oPrzKF1NWZu6sZGNbpBW7o4bmAF3+1SR4h9Pk?=
 =?us-ascii?Q?1pyRpbVhM4oHu2Vn+bhsaVgMtIk1jwbO6i8tc/+2Z5IHp47AQjXpljgePB/c?=
 =?us-ascii?Q?DQA8wQe3m0GqixRlzZK/OcjGtHZcNYYMmFLFHd+ITTw9LuKL4pO3ZwVJO4Vk?=
 =?us-ascii?Q?n3ZRUUBp26TfKpXhe/cjNskor0yEQmYzdrMgIZ80szx9cOqCGiXV6eQae0nA?=
 =?us-ascii?Q?ABtfkuWPPXl6PLA8s824Vo1jUXdKfu//dLgnrq29RBPe29yNxkmqWoDe0eKT?=
 =?us-ascii?Q?Qq3gAw9eJl1RrYlopwBfxS+J8EhSZ5j8BlKNjbAMQl/dYIgs1mD+hU1hKje9?=
 =?us-ascii?Q?Zt2ziQRkdrWnELk7KzNUytQAWHUv0K1KTWdXOkMdiPqVEggFSd6PJllgNSTA?=
 =?us-ascii?Q?ph91y/0tFLAuOuq5ZMAef9cztprfeBzwf62cO7zmM5rVdFbTBJ1EQTovm9D9?=
 =?us-ascii?Q?OUxHtqVgOywdpaXLGcl0VSclu3AY+guVmgV86ceWrAH1ajz7Pko4EAxSXU2k?=
 =?us-ascii?Q?hOi055UpOHCSvub6jEJOl89jkDB5w1xuIm1zm/tPIjrgi/piP5LA2WUk4lvx?=
 =?us-ascii?Q?BBOmWWRByUuOjDC+hV4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c24044-337f-4d6f-c6a4-08dcaa663bb6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:52:04.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuBpuen+rdKEJVyu56YxkkCJAnBOrk5e4ExmvRAyZ0lkqx62dBMSNLjO9WzIdj5ycG8s+vFUbMQiitT+kEH+2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10480

On Mon, Jul 22, 2024 at 03:10:58PM +0300, Laurent Pinchart wrote:
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes since v6:
> 
> - Drop 'MFD' reference in Kconfig description and in kernel message
> - Use sizeof(*variable)
> - Add comment to describe chip variants
> - Drop LINUX prefix from header guard
> - Drop debug message
> - Drop comments
> 
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
>  drivers/mfd/adp5585.c       | 205 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/adp5585.h | 126 ++++++++++++++++++++++
>  5 files changed, 346 insertions(+)
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
> index 266b4f54af60..13404448945b 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -20,6 +20,18 @@ config MFD_CS5535
>  	  This is the core driver for CS5535/CS5536 MFD functions.  This is
>  	  necessary for using the board's GPIO and MFGPT functionality.
>  
> +config MFD_ADP5585
> +	tristate "Analog Devices ADP5585 keypad decoder and I/O expander driver"
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
> index 000000000000..160e0b38106a
> --- /dev/null
> +++ b/drivers/mfd/adp5585.c
> @@ -0,0 +1,205 @@
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
> +/*
> + * Chip variants differ in the default configuration of pull-up and pull-down
> + * resistors, and therefore have different default register values:
> + *
> + * - The -00, -01 and -03 variants (collectively referred to as
> + *   ADP5585_REGMAP_00) have pull-up on all GPIO pins by default.
> + * - The -02 variant has no default pull-up or pull-down resistors.
> + * - The -04 variant has default pull-down resistors on all GPIO pins.
> + */
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
> +	adp5585 = devm_kzalloc(&i2c->dev, sizeof(*adp5585), GFP_KERNEL);
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
> +	ret = regmap_read(adp5585->regmap, ADP5585_ID, &id);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret,
> +				     "Failed to read device ID\n");
> +
> +	if ((id & ADP5585_MAN_ID_MASK) != ADP5585_MAN_ID_VALUE)
> +		return dev_err_probe(&i2c->dev, -ENODEV,
> +				     "Invalid device ID 0x%02x\n", id);
> +
> +	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> +				   adp5585_devs, ARRAY_SIZE(adp5585_devs),
> +				   NULL, 0, NULL);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret,
> +				     "Failed to add child devices\n");
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
> index 000000000000..016033cd68e4
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
> +#ifndef __MFD_ADP5585_H_
> +#define __MFD_ADP5585_H_
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

